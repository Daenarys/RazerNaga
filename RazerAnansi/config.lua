--[[
	Config
		Configuration methods for the Anansi addon
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi')
local Config = {}; Anansi.Config = Config

local sendMessage = function(msg, ...)
	return RazerNaga.Envoy:Send(msg, ...)
end


--[[ returns how many T-keys there are ]]--

function Config:NumTKeys()
	return 7
end


--[[ set/get a particilar t key binding (used for bindsync) ]]--

function Config:SetTKeyBinding(tKey, binding)
	if not tKey then
		error('SetTKeyBinding: tKey cannot be null', 2)
	end

	if not binding then
		error('SetTKeyBinding: binding cannot be null', 2)
	end

	RazerNaga.db.global.tKeymap[tKey] = binding
	
	sendMessage('TKEY_UPDATE_BINDING', tKey, self:GetTKeyBinding(tKey))
	return self
end

function Config:GetTKeyBinding(tKey)
	if tKey then
		return RazerNaga.db.global.tKeymap[tKey]
	end
	return nil
end


--[[ set/get t-key names ]]--

function Config:SetTKeyName(tKey, name)
	if not tKey then
		error('SetTKeyName: tKey cannot be null', 2)
	end
	
	if name and name ~= '' then
		RazerNaga.db.profile.tKeyNames[tKey] = name
	else
		RazerNaga.db.profile.tKeyNames[tKey] = 'T' .. tKey
	end
	
	sendMessage('TKEY_UPDATE_NAME', tKey, self:GetTKeyName(tKey))
	return self
end

function Config:GetTKeyName(tKey)
	if not tKey then
		error('GetTKeyName: tKey cannot be null', 2)
	end
	
	local result = RazerNaga.db.profile.tKeyNames[tKey]
	return result or ('Unknown (T%d)'):format(tKey)
end


--[[ configure t-panel display ]]--

--config mode
function Config:SetShowTPanelOnHover(state)
	RazerNaga.db.profile.showTPanel = state
	sendMessage('TPANEL_UPDATE_AUTO_SHOW', self:ShowingTPanelOnHover())
	return self
end

function Config:ShowingTPanelOnHover()
	return RazerNaga.db.profile.showTPanel
end


--[[ configure t-bar auto fading ]]--

function Config:SetAutoFadeTBars(enable)
	RazerNaga.db.profile.autoFadeTBars = enable and true or false
	sendMessage('TBAR_UPDATE_AUTO_FADE', self:AutoFadingTBars())
	return self
end

function Config:AutoFadingTBars()
	return RazerNaga.db.profile.autoFadeTBars or false
end


--[[ configure t-key colors ]]--

function Config:SetTKeyColor(tKey, r, g, b, a)
	local color = RazerNaga.db.global.tKeyColors[tKey]

	color.r = r
	color.g = g
	color.b = b
	color.a = a

	sendMessage('TKEY_UPDATE_COLOR', tKey, self:AutoFadingTBars())
	return self
end

function Config:GetTKeyColor(tKey)
	if not tKey then
		return 255, 255, 255, 255
	end

	local color = RazerNaga.db.global.tKeyColors[tKey]
	return color.r, color.g, color.b, color.a
end

--[[ configure t-key notifications ]]--

function Config:SetEnableTKeyNotifications(enable)
	RazerNaga.db.profile.enableTKeyNotifications = enable and true or false
	sendMessage('TKEY_NOTIFICATIONS_UPDATE', tKey, self:TKeyNotificationsEnabled())
end

function Config:TKeyNotificationsEnabled()
	return RazerNaga.db.profile.enableTKeyNotifications or false
end