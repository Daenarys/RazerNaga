--[[
	autoBinder.lua
		Handles automatic keybinding mode for lynn
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local AutoBinder = RazerNaga:NewModule('AutoBinder', 'AceEvent-3.0'); RazerNaga.AutoBinder = AutoBinder
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

--binding confirmation dialog
local function CreateEnableAutomaticBindingsPrompt()
	local f = CreateFrame('Frame', nil, UIParent)
	f:SetFrameStrata('DIALOG')
	f:EnableMouse(true)
	f:SetClampedToScreen(true)
	f:SetWidth(320)
	f:SetHeight(72)
	f:SetPoint('TOP', 0, -24)
	f:Hide()

	f:SetScript('OnShow', function() PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end)
	f:SetScript('OnHide', function() PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT) end)

	local border = CreateFrame('Frame', nil, f, 'DialogBorderTemplate')

	local header = CreateFrame('Frame', nil, f, 'DialogHeaderTemplate')
	header:SetWidth(150) 
	header:SetPoint('TOP', 0, 12)

	local title = header:CreateFontString(nil, 'ARTWORK')
	title:SetFontObject('GameFontNormal')
	title:SetPoint('TOP', header, 'TOP', 0, -14)
	title:SetText('RazerNaga')

	local desc = f:CreateFontString(nil, 'ARTWORK')
	desc:SetFontObject('GameFontHighlight')
	desc:SetPoint('TOP', f, 'TOP', 0, -32)
	desc:SetWidth(290)
	desc:SetHeight(0)
	desc:SetText(L.EnableAutoBindingsPrompt)

	local button1 = CreateFrame('Button', nil, f, 'StaticPopupButtonTemplate')
	button1:SetText(YES)
	button1:SetPoint("TOPRIGHT", desc, "BOTTOM", -6, -10);
	button1:SetScript('OnClick', function() f:Hide() end)

	local button2 = CreateFrame('Button', nil, f, 'StaticPopupButtonTemplate')
	button2:SetText(NO)
	button2:SetPoint("LEFT", button1, "RIGHT", 13, 0);
	button2:SetScript('OnClick', function() f:Hide() end)

	f:SetHeight(42 + desc:GetHeight() + 8 + button1:GetHeight() + 16);

	return f
end

function AutoBinder:ShowEnableAutoBindingsDialog()
	self.dialog = self.dialog or CreateEnableAutomaticBindingsPrompt()
	self.dialog:Show()
end