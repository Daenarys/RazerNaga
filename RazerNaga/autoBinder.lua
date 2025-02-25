--[[
	autoBinder.lua
		Handles automatic keybinding mode for lynn
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local AutoBinder = RazerNaga:NewModule('AutoBinder', 'AceEvent-3.0'); RazerNaga.AutoBinder = AutoBinder
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

--[[ Events ]]--

function AutoBinder:Load()
	self:EnforceBindings()

	self:RegisterEvent('PLAYER_LOGOUT')
	RazerNaga.Envoy:Register(self, 'CONFIG_MODE_UPDATE')
	RazerNaga.Envoy:Register(self, 'UPDATE_AUTO_BINDINGS')
	LibStub('LibKeyBound-1.0').RegisterCallback(self, 'LIBKEYBOUND_ENABLED')
	LibStub('LibKeyBound-1.0').RegisterCallback(self, 'LIBKEYBOUND_DISABLED')
end

function AutoBinder:Unload()
	self:UnregisterEvent('PLAYER_LOGOUT')
	RazerNaga.Envoy:Unregister(self, 'CONFIG_MODE_UPDATE')
	RazerNaga.Envoy:Unregister(self, 'UPDATE_AUTO_BINDINGS')
	LibStub('LibKeyBound-1.0').UnregisterCallback(self, 'LIBKEYBOUND_ENABLED')
	LibStub('LibKeyBound-1.0').UnregisterCallback(self, 'LIBKEYBOUND_DISABLED')
end

--lock events
function AutoBinder:CONFIG_MODE_UPDATE()
	self:EnforceBindings()
end

--auto binding enforcement
function AutoBinder:UPDATE_AUTO_BINDINGS()
	self:EnforceBindings()
end

--keybound events
function AutoBinder:LIBKEYBOUND_ENABLED()
	self:EnforceBindings()
end

function AutoBinder:LIBKEYBOUND_DISABLED()
	self:EnforceBindings()
end

--logout event
function AutoBinder:PLAYER_LOGOUT()
	self:EnforceBindings()
end


--[[ Update Methods ]]--

function AutoBinder:SetEnableAutomaticBindings(enable)
	RazerNaga.db.profile.autoBindKeys = enable or false
	RazerNaga.Envoy:Send('UPDATE_AUTO_BINDINGS', self:IsAutoBindingEnabled())
end

function AutoBinder:IsAutoBindingEnabled()
	return RazerNaga.db.profile.autoBindKeys
end

function AutoBinder:EnforceBindings()
	if self:IsAutoBindingEnabled() then
		local set = RazerNaga.BindingsLoader:GetCurrentBindingsSet()
		if set then
			RazerNaga:Print(format(L.EnforcingBindings, set.layout, set.localizedName))
			RazerNaga.BindingsLoader:LoadBindings(set)
		end
	end
end

--binding confirmation dialog
local function CreateEnableAutomaticBindingsPrompt()
	local f = CreateFrame('Frame', nil, UIParent)
	f:SetFrameStrata('DIALOG')
	f:SetToplevel(true)
	f:EnableMouse(true)
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:SetWidth(320)
	f:SetHeight(72)

	f:SetBackdrop{
		bgFile='Interface\\DialogFrame\\UI-DialogBox-Background' ,
		edgeFile='Interface\\DialogFrame\\UI-DialogBox-Border',
		tile = true,
		insets = {left = 11, right = 12, top = 12, bottom = 11},
		tileSize = 32,
		edgeSize = 32,
	}
	f:SetPoint('TOP', 0, -24)
	f:Hide()

	f:RegisterForDrag('LeftButton')
	f:SetScript('OnShow', function() PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end)
	f:SetScript('OnHide', function() PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT) end)
	f:SetScript('OnDragStart', function() f:StartMoving() end)
	f:SetScript('OnDragStop', function() f:StopMovingOrSizing() end)

	local header = f:CreateTexture(nil, 'ARTWORK')
	header:SetTexture([[Interface\DialogFrame\UI-DialogBox-Header]])
	header:SetWidth(320); header:SetHeight(64)
	header:SetPoint('TOP', f, 'TOP', 0, 12)

	local title = f:CreateFontString('ARTWORK')
	title:SetFontObject('GameFontNormal')
	title:SetPoint('TOP', header, 'TOP', 0, -14)
	title:SetText('RazerNaga')

	local desc = f:CreateFontString('ARTWORK')
	desc:SetFontObject('GameFontHighlight')
--	desc:SetJustifyV('TOP')
--	desc:SetJustifyH('CENTER')
	desc:SetPoint('TOP', f, 'TOP', 0, -24)
	desc:SetWidth(290)
	desc:SetHeight(0)
	desc:SetText(L.EnableAutoBindingsPrompt)

	local button1 = CreateFrame('Button', nil, f, 'StaticPopupButtonTemplate')
	button1:SetText(YES)
	button1:SetPoint("TOPRIGHT", desc, "BOTTOM", -6, -8);
	button1:SetScript('OnClick', function() AutoBinder:SetEnableAutomaticBindings(true); f:Hide() end)

	local button2 = CreateFrame('Button', nil, f, 'StaticPopupButtonTemplate')
	button2:SetText(NO)
	button2:SetPoint("LEFT", button1, "RIGHT", 13, 0);
	button2:SetScript('OnClick', function() AutoBinder:SetEnableAutomaticBindings(false); f:Hide() end)

	f:SetHeight(42 + desc:GetHeight() + 8 + button1:GetHeight() + 16);

	return f
end

function AutoBinder:ShowEnableAutoBindingsDialog()
	self.dialog = self.dialog or CreateEnableAutomaticBindingsPrompt()
	self.dialog:Show()
end
