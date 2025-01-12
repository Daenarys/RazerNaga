--------------------------------------------------------------------------------
-- Cast Bar
-- A dominos based casting bar
--------------------------------------------------------------------------------

local DCB = RazerNaga:NewModule('CastingBar')
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local CastBar, CastingBar

function DCB:Load()
	self.frame = CastBar:New()
end

function DCB:Unload()
	self.frame:Free()
end

--------------------------------------------------------------------------------
-- Frame Object
--------------------------------------------------------------------------------

CastBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function CastBar:New()
	local f = self.proto.New(self, 'cast')
	f:SetTooltipText(L.CastBarHelp)

	if not f.cast then
		f.cast = CastingBar:New(f)
	end

	f:Layout()

	return f
end

function CastBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = 30
	}
end

function CastBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel:NewOpacitySlider()
	panel:NewFadeSlider()
	panel:NewScaleSlider()
	panel:NewPaddingSlider()

	self.menu = menu
end

function CastBar:Layout()
	self:SetWidth(max(self.cast:GetWidth() + 4 + self:GetPadding()*2, 8))
	self:SetHeight(max(24 + self:GetPadding()*2, 8))
end

--------------------------------------------------------------------------------
-- CastingBar Object
--------------------------------------------------------------------------------

CastingBar = RazerNaga:CreateClass('StatusBar')

function CastingBar:New(parent)
	local f = self:Bind(CreateFrame('StatusBar', 'RazerNagaCastingBar', parent, 'SmallCastingBarFrameTemplate'))
	f:SetSize(208, 11)
	f:SetPoint('CENTER', 0, 5)
	f:OnLoad("player", true, false)
	f.Icon:Hide()

	return f
end