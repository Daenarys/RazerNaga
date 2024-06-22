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
	border.TopEdge:SetSize(32, 32)
	border.TopEdge:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal", true)
	border.TopEdge:SetTexCoord(0, 0.5, 0.13671875, 0.26171875)

	border.TopLeftCorner:SetSize(32, 32)
	border.TopLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal")
	border.TopLeftCorner:SetTexCoord(0.015625, 0.515625, 0.53515625, 0.66015625)

	border.TopRightCorner:SetSize(32, 32)
	border.TopRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal")
	border.TopRightCorner:SetTexCoord(0.015625, 0.515625, 0.66796875, 0.79296875)

	border.BottomEdge:SetSize(32, 32)
	border.BottomEdge:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal", true)
	border.BottomEdge:SetTexCoord(0, 0.5, 0.00390625, 0.12890625)

	border.BottomLeftCorner:SetSize(32, 32)
	border.BottomLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal")
	border.BottomLeftCorner:SetTexCoord(0.015625, 0.515625, 0.26953125, 0.39453125)

	border.BottomRightCorner:SetSize(32, 32)
	border.BottomRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetal")
	border.BottomRightCorner:SetTexCoord(0.015625, 0.515625, 0.40234375, 0.52734375)

	border.LeftEdge:SetSize(32, 32)
	border.LeftEdge:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetalVertical", false, true)
	border.LeftEdge:SetTexCoord(0.0078125, 0.2578125, 0, 1)

	border.RightEdge:SetSize(32, 32)
	border.RightEdge:SetTexture("Interface\\FrameGeneral\\UIFrameDiamondMetalVertical", false, true)
	border.RightEdge:SetTexCoord(0.2734375, 0.5234375, 0, 1)

	local header = f:CreateTexture(nil, 'ARTWORK')
	header:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Header')
	header:SetWidth(320); header:SetHeight(64)
	header:SetPoint('TOP', f, 'TOP', 0, 12)

	local title = f:CreateFontString(nil, 'ARTWORK')
	title:SetFontObject('GameFontNormal')
	title:SetPoint('TOP', header, 'TOP', 0, -14)
	title:SetText('RazerNaga')

	local desc = f:CreateFontString(nil, 'ARTWORK')
	desc:SetFontObject('GameFontHighlight')
	desc:SetPoint('TOP', f, 'TOP', 0, -30)
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