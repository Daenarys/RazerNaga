--[[
	Anansi:
		Anansi keyboard extensions to the RazerNaga addons
--]]

--setup module
local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:NewModule('Anansi', 'AceEvent-3.0')
local ModHighlighter = RazerNaga:GetModule('ModHighlighter')

--[[ events ]]--

function Anansi:Load()
	self:RegisterEvent('PLAYER_REGEN_DISABLED')
	self:RegisterEvent('PLAYER_REGEN_ENABLED')
	
	self:RegisterMessages(
		'CONFIG_MODE_UPDATE',
		'UPDATE_AUTO_BINDINGS',
		'FRAME_UPDATE_MODIFIER',
		'FRAME_UPDATE_AUTO_BINDINGS',
		'TKEY_UPDATE_BINDING',
		'TKEY_UPDATE_NAME',
		'TKEY_NOTIFICATIONS_UPDATE',
		'TPANEL_UPDATE_AUTO_SHOW'
	)
	
	self:LoadBindingTKeys()
	self:LoadFrameNames()
	self:UpdateTKeyNotificationDisplay()
	self.TPanelWatcher:UpdateWatchForAll()
end

function Anansi:Unload()
	self:UnregisterAllEvents()
	self:UnregisterAllMessages()
	self.TPanelWatcher:Stop()
	
	if self.alertsBar then
		self.alertsBar:Free()
		self.alertsBar = nil
	end
end

function Anansi:RegisterMessages(...)
	RazerNaga.Envoy:RegisterMany(self, ...)
end

function Anansi:UnregisterMessage(msg)
	RazerNaga.Envoy:Unregister(self, msg)
end

function Anansi:UnregisterAllMessages()
	RazerNaga.Envoy:UnregisterAll(self)
end

function Anansi:CONFIG_MODE_UPDATE(msg, ...)
	self.TPanelWatcher:UpdateEnabled()
end

function Anansi:UPDATE_AUTO_BINDINGS(msg, ...)
	self:LoadFrameNames()
	self.TPanelWatcher:UpdateEnabled()
end

function Anansi:FRAME_UPDATE_MODIFIER(msg, frame)
	self:LoadFrameNames()
	self.TPanelWatcher:UpdateWatch(frame)
end

function Anansi:FRAME_UPDATE_AUTO_BINDINGS(msg, frame)
	self:LoadFrameNames()
	self.TPanelWatcher:UpdateWatch(frame)
end

function Anansi:PLAYER_REGEN_ENABLED(event, ...)
	self.inCombat = nil
	self.TPanelWatcher:UpdateEnabled()
end

function Anansi:PLAYER_REGEN_DISABLED(event, ...)
	self.inCombat = true
	self.TPanelWatcher:UpdateEnabled()
end

function Anansi:MODIFIER_STATE_CHANGED(event, ...)
	self:UpdateModiferSelection()
end

function Anansi:TKEY_UPDATE_BINDING(msg, tKey, binding)
	self:SetTKeyForBinding(binding, tKey)
end

function Anansi:TKEY_UPDATE_NAME(msg, tKey, name)
	for id, frame in RazerNaga.Frame:GetAll() do
		if tKey == self:GetFrameTKey(frame) then
			frame:OverrideDisplayName(name)
		end
	end
end

function Anansi:TKEY_NOTIFICATIONS_UPDATE(msg, enable)
	self:UpdateTKeyNotificationDisplay()
end

function Anansi:TPANEL_UPDATE_AUTO_SHOW(msg, state)
	self.TPanelWatcher:UpdateEnabled()
end

function Anansi:SPELL_ACTIVATION_OVERLAY_GLOW_SHOW(msg, spellId)
	if self.alertsBar:IsShown() then
		self:ShowTKeyNotification(spellId)
	end
end


--[[ T-Panel Display ]]--

function Anansi:ShowTPanel(frame)
	if not self:IsTPanelShown(frame) then
		self.TPanel:Set(frame)
	end
end

function Anansi:HideTPanel(frame)
	if self:IsTPanelShown(frame) then
		self.TPanel:Set(nil)
	end
end

function Anansi:UpdateTPanelShown(frame)
	if self:ShouldShowTPanel(frame) then
		self:ShowTPanel(frame)
	else
		self:HideTPanel(frame)
	end
end

function Anansi:IsTPanelShown(frame)
	return self.TPanel:IsOwned(frame)
end

function Anansi:ShouldShowTPanel(frame)
	if self:CanShowTPanel() and self:GetFrameTKey(frame) then
		return frame:IsFocus(true)
	end
	return false
end

function Anansi:CanShowTPanel()
	local state = self.Config:ShowingTPanelOnHover()

	if state == 'always' then
		return true
	end
	
	if state == 'ooc' then
		return not self.inCombat
	end
	
	if state == 'config' then
		return not RazerNaga:Locked()
	end
	
	return false
end


--[[ given a binding, retrieve its associated t-key ]]--

do
	local tKeys = {}
	
	function Anansi:SetTKeyForBinding(binding, index)	
		tKeys[binding] = index
	end

	function Anansi:GetTKeyFromBinding(binding)
		if binding then
			return tKeys[binding]
		end
	end
	
	function Anansi:LoadBindingTKeys()
		for i = 1, self.Config:NumTKeys() do
			tKeys[self.Config:GetTKeyBinding(i)] = i
		end
	end
end


--[[ given a frame, retrieve its associated binding ]]--

function Anansi:GetFrameTKey(frame)
	if not RazerNaga.BindingsLoader:IsAutoBindingEnabled(frame) then return end
	
	local modifier = RazerNaga.BindingsLoader:GetFrameModifier(frame)
	return self:GetTKeyFromBinding(modifier)
end

function Anansi:GetFrameTColor(frame)
	if RazerNaga.BindingsLoader:IsAutoBindingEnabled(frame) then
		local tKey = self:GetFrameTKey(frame)
		if tKey then
			local r, g, b, a = self.Config:GetTKeyColor(tKey)
			return r / 255, g / 255, b / 255, a / 255
		end
	end
end


--[[ t-key polling ]]--

function Anansi:IsTKeyPressed(index)
	local modifier = ModHighlighter:GetCurrentModifierCombo() 
	return self:GetTKeyFromBinding(modifier) == index
end


--[[ t-key syncronization ]]--

function Anansi:ResyncKeys()
	self.BindSync:StartSyncBindings()
end


--[[ t-frame names ]]--

function Anansi:LoadFrameNames()
	for id, frame in RazerNaga.Frame:GetAll() do
		local tKey = self:GetFrameTKey(frame)
		if tKey then
			frame:OverrideDisplayName(self.Config:GetTKeyName(tKey))
		else
			frame:OverrideDisplayName(nil)
		end
	end
end


--[[ t-key notifications ]]--

function Anansi:UpdateTKeyNotificationDisplay()
	if self.Config:TKeyNotificationsEnabled() then
		self:RegisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW')
		if not self.alertsBar then
			self.alertsBar = self.AlertsBar:New()
		end
	else
		self:UnregisterEvent('SPELL_ACTIVATION_OVERLAY_GLOW_SHOW')
		if self.alertsBar then
			self.alertsBar:Free()
			self.alertsBar = nil
		end
	end
end

function Anansi:ShowTKeyNotification(spellId)
	local tKey, nagaKey = self:GetTKeyAction(spellId)
	if nagaKey then
		self:ShowNotification(spellId, tKey, nagaKey)
	end
end

function Anansi:GetTKeyAction(spellId)
	for id = 1, RazerNaga:NumBars() do
		local frame = RazerNaga.Frame:Get(id)	
		if RazerNaga.BindingsLoader:IsAutoBindingEnabled(frame) then	
			local tKey = self:GetFrameTKey(frame)
			for i, button in ipairs(frame.buttons) do
				local actionId = button.action
				if actionId then
					local actionType, actionSpellId = GetActionInfo(actionId)
					if actionSpellId == spellId then
						return tKey, self:GetNagaKey(i)
					end
				end
			end
		end
	end
end

function Anansi:GetNagaKey(index)
	if index then
		local bindingSet = RazerNaga.BindingsLoader:GetCurrentBindingsSet()
		return bindingSet.nagaKeys[index]
	end
end

--notification sending
function Anansi:ShowNotification(spellId, tKey, nagaKey)
	self.alertsBar:ShowTKeyMessage(spellId, tKey, nagaKey)
end