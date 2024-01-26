--[[ 
	Action Button.lua
		A RazerNaga action button
--]]

local KeyBound = LibStub('LibKeyBound-1.0')
local Bindings = RazerNaga.BindingsController
local Tooltips = RazerNaga:GetModule('Tooltips')

local ActionButton = RazerNaga:CreateClass('CheckButton', RazerNaga.BindableButton)
RazerNaga.ActionButton = ActionButton
ActionButton.unused = {}
ActionButton.active = {}

local function GetOrCreateActionButton(id)
	if id <= 12 then
		local b = _G['ActionButton' .. id]
		b.buttonType = 'ACTIONBUTTON'
		return b
	elseif id <= 24 then
		return _G['MultiBar5Button' .. (id-12)]
	elseif id <= 36 then
		return _G['MultiBarRightButton' .. (id-24)]
	elseif id <= 48 then
		return _G['MultiBarLeftButton' .. (id-36)]
	elseif id <= 60 then
		return _G['MultiBarBottomRightButton' .. (id-48)]
	elseif id <= 72 then
		return _G['MultiBarBottomLeftButton' .. (id-60)]
	elseif id <= 84 then
		return _G['MultiBar6Button' .. (id-72)]
	elseif id <= 96 then
		return _G['MultiBar7Button' .. (id-84)]
	end
	return CreateFrame('CheckButton', 'RazerNagaActionButton' .. (id-96), nil, 'ActionBarButtonTemplate')
end

--constructor
function ActionButton:New(id)
	local b = self:Restore(id) or self:Create(id)

	if b then
		b:SetAttribute('showgrid', 1)
		b:SetAttribute('action--base', id)
		b:SetAttribute('_childupdate-action', [[
			local state = message
			local overridePage = self:GetParent():GetAttribute('state-overridepage')
			local newActionID
			
			if state == 'override' then
				newActionID = (self:GetAttribute('button--index') or 1) + (overridePage - 1) * 12
			else
				newActionID = state and self:GetAttribute('action--' .. state) or self:GetAttribute('action--base')
			end
			
			if newActionID ~= self:GetAttribute('action') then
				self:SetAttribute('action', newActionID)
				self:RunAttribute("UpdateShown")
				self:CallMethod('UpdateState')
			end
		]])
		b:SetAttribute("UpdateShown", [[
		    local show = (HasAction(self:GetAttribute("action")))
		                 and not self:GetAttribute("statehidden")
		    if show then
		        self:SetAlpha(1.0)
		    else
		        self:SetAlpha(0.0)
		    end
		]])

		Bindings:Register(b, b:GetName():match('RazerNagaActionButton%d'))
		Tooltips:Register(b)

		--get rid of range indicator text
		local hotkey = b.HotKey
		if hotkey:GetText() == _G['RANGE_INDICATOR'] then
			hotkey:SetText('')
		end

		b:UpdateMacro()

		self.active[id] = b
	end

	return b	
end

function ActionButton:Create(id)
	local b = GetOrCreateActionButton(id)

	if b then
		self:Bind(b)

		--this is used to preserve the button's old id
		--we cannot simply keep a button's id at > 0 or blizzard code will take control of paging
		--but we need the button's id for the old bindings system
		b:SetAttribute('bindingid', b:GetID())
		b:SetID(0)

		b:ClearAllPoints()
		b:SetAttribute('useparent-actionpage', nil)
		b:SetAttribute('useparent-unit', true)
		b:SetAttribute("statehidden", nil)
		b:EnableMouseWheel(true)
		b:HookScript('OnEnter', self.OnEnter)
		b:SetSize(36, 36)
		b:Skin()

		if b.cooldown then
			b.cooldown:SetDrawBling(true)
		end

		if b.UpdateHotKeys then
			hooksecurefunc(b, 'UpdateHotkeys', ActionButton.UpdateHotkey)
		end

		if b.UpdateButtonArt then
			b.UpdateButtonArt = function() end
		end
	end
	return b
end

function ActionButton:Restore(id)
	local b = self.unused[id]

	if b then
		self.unused[id] = nil

		b:SetAttribute("statehidden", nil)

		self.active[id] = b
		return b
	end
end

--destructor
do
	local HiddenActionButtonFrame = CreateFrame('Frame')
	HiddenActionButtonFrame:Hide()

	function ActionButton:Free()
		local id = self:GetAttribute('action--base')

		self.active[id] = nil

		Tooltips:Unregister(self)
		Bindings:Unregister(self)

		self:SetAttribute("statehidden", true)
		self:SetParent(HiddenActionButtonFrame)
		self:Hide()
		self.action = 0

		self.unused[id] = self
	end
end

--keybound support
function ActionButton:OnEnter()
	KeyBound:Set(self)
end

--macro text
function ActionButton:UpdateMacro()
	if RazerNaga:ShowMacroText() then
		self.Name:Show()
	else
		self.Name:Hide()
	end
end

--utility function, resyncs the button's current action, modified by state
function ActionButton:LoadAction()
	local state = self:GetParent():GetAttribute('state-page')
	local id = state and self:GetAttribute('action--' .. state) or self:GetAttribute('action--base')
	
	self:SetAttribute('action', id)
end

function ActionButton:Skin()
	if not RazerNaga:Masque('Action Bar', self) then
		self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
		self:SetNormalAtlas("UI-HUD-ActionBar-IconFrame")
		self.NormalTexture:ClearAllPoints()
		self.NormalTexture:SetPoint("TOPLEFT", -3, 3)
		self.NormalTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self:SetPushedAtlas("UI-HUD-ActionBar-IconFrame-Down")
		self.PushedTexture:ClearAllPoints()
		self.PushedTexture:SetPoint("TOPLEFT", -3, 3)
		self.PushedTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.HighlightTexture:ClearAllPoints()
		self.HighlightTexture:SetPoint("TOPLEFT", -3, 3)
		self.HighlightTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.CheckedTexture:ClearAllPoints()
		self.CheckedTexture:SetPoint("TOPLEFT", -3, 3)
		self.CheckedTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.NewActionTexture:ClearAllPoints()
		self.NewActionTexture:SetPoint("TOPLEFT", -3, 3)
		self.NewActionTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.SpellHighlightTexture:ClearAllPoints()
		self.SpellHighlightTexture:SetPoint("TOPLEFT", -3, 3)
		self.SpellHighlightTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.QuickKeybindHighlightTexture:ClearAllPoints()
		self.QuickKeybindHighlightTexture:SetPoint("TOPLEFT", -3, 3)
		self.QuickKeybindHighlightTexture:SetPoint("BOTTOMRIGHT", 3, -3)
		self.Border:ClearAllPoints()
		self.Border:SetPoint("TOPLEFT", -3, 3)
		self.Border:SetPoint("BOTTOMRIGHT", 3, -3)
		self.cooldown:ClearAllPoints()
		self.cooldown:SetAllPoints()
		self.Flash:ClearAllPoints()
		self.Flash:SetAllPoints()
		self.Count:ClearAllPoints()
		self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
		if self.SlotArt then
			self.SlotArt:Hide()
		end
		if self.SlotBackground then
			self.SlotBackground:SetPoint("TOPLEFT", -3, 3)
			self.SlotBackground:SetPoint("BOTTOMRIGHT", 3, -3)
		end
    end
end

if (ActionBarActionEventsFrame) then
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_TARGET")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_CLEAR")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_FAILED")
end