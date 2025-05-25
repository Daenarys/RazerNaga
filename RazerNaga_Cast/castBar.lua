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

	f:UpdateText()
	f:Layout()

	return f
end

function CastBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = 30,
		showText = true,
	}
end

function CastBar:ToggleText(enable)
	self.sets.showText = enable or false
	self:UpdateText()
end

function CastBar:UpdateText()
	if self.sets.showText then
		self.cast.Time:Show()
	else
		self.cast.Time:Hide()
	end
	self.cast:AdjustWidth()
end

function CastBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	local time = panel:NewCheckButton(RazerNaga_SHOW_TIME)
	time:SetScript('OnClick', function(b) self:ToggleText(b:GetChecked()) end)
	time:SetScript('OnShow', function(b) b:SetChecked(self.sets.showText) end)

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

--omg speed
local BORDER_SCALE = 197/150 -- its magic!
local TEXT_PADDING = 18

function CastingBar:New(parent)
	local f = self:Bind(CreateFrame('StatusBar', 'RazerNagaCastingBar', parent, 'RazerNagaCastingBarTemplate'))
	f:SetPoint('CENTER')

	f.normalWidth = f:GetWidth()
	f:SetScript('OnUpdate', f.OnUpdate)

	return f
end

function CastingBar:OnUpdate(elapsed)
	CastingBarFrame_OnUpdate(self, elapsed)

	if self.casting then
		self.Time:SetFormattedText('%.1f', self.maxValue - self.value)
		self:AdjustWidth()
	elseif self.channeling then
		self.Time:SetFormattedText('%.1f', self.value)
		self:AdjustWidth()
	end
end

function CastingBar:AdjustWidth()
	local textWidth = self.Text:GetStringWidth() + TEXT_PADDING
	local timeWidth = (self.Time:IsShown() and (self.Time:GetStringWidth() + 4) * 2) or 0
	local width = textWidth + timeWidth

	if width < self.normalWidth then
		width = self.normalWidth
	end

	local diff = math.abs(width - self:GetWidth()) -- calculate an absolute difference between needed size and last size

	if diff > TEXT_PADDING then -- is the difference big enough to redraw the bar ?
		self:SetWidth(width)
		self.Border:SetWidth(width * BORDER_SCALE)
		self.Flash:SetWidth(width * BORDER_SCALE)
	end
end