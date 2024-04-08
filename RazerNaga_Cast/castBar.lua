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
	f:SetFrameStrata('HIGH')

	if not f.cast then
		f.cast = CastingBar:New(f)
		f:SetWidth(240) 
		f:SetHeight(24)
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
		self.cast.time:Show()
	else
		self.cast.time:Hide()
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

local BORDER_SCALE = 197/150
local TEXT_PADDING = 18

function CastingBar:New(parent)
	local f = self:Bind(CreateFrame('StatusBar', 'RazerNagaCastingBar', parent, 'RazerNagaCastingBarTemplate'))
	f:SetPoint('CENTER')

	local name = f:GetName()
	local _G = getfenv(0)
	f.time = _G[name .. 'Time']
	f.text = _G[name .. 'Text']
	f.borderTexture = _G[name .. 'Border']
	f.flashTexture = _G[name .. 'Flash']

	f.normalWidth = f:GetWidth()
	f:SetScript('OnUpdate', f.OnUpdate)
	f:SetScript('OnEvent', f.OnEvent)

	return f
end

function CastingBar:OnEvent(event, ...)
	CastingBarFrame_OnEvent(self, event, ...)

	local unit = self.unit
	local spell  = UnitCastingInfo(unit)
	if unit == self.unit then
		if event == 'UNIT_SPELLCAST_FAILED' or event == 'UNIT_SPELLCAST_INTERRUPTED' then
			self.failed = true
		elseif event == 'UNIT_SPELLCAST_START' or event == 'UNIT_SPELLCAST_CHANNEL_START' then
			self.failed = nil
		end
		self:UpdateColor(spell)
	end
end

function CastingBar:OnUpdate(elapsed)
	CastingBarFrame_OnUpdate(self, elapsed)

	if self.casting then
		self.time:SetFormattedText('%.1f', self.maxValue - self.value)
		self:AdjustWidth()
	elseif self.channeling then
		self.time:SetFormattedText('%.1f', self.value)
		self:AdjustWidth()
	end

	if ( self.value >= self.maxValue ) then
		self:SetStatusBarColor(0.0, 1.0, 0.0)
	end
end

function CastingBar:AdjustWidth()
	local textWidth = self.text:GetStringWidth() + TEXT_PADDING
	local timeWidth = (self.time:IsShown() and (self.time:GetStringWidth() + 4) * 2) or 0
	local width = textWidth + timeWidth

	if width < self.normalWidth then
		width = self.normalWidth
	end
	 	
	local diff = math.abs(width - self:GetWidth()) --calculate an absolute difference between needed size and last size
	
	if diff > TEXT_PADDING then --is the difference big enough to redraw the bar?
		self:SetWidth(width)
		self.borderTexture:SetWidth(width * BORDER_SCALE)
		self.flashTexture:SetWidth(width * BORDER_SCALE)

		self:GetParent():Layout()
	end
end

function CastingBar:UpdateColor(spell)
	if self.failed then
		self:SetStatusBarColor(0.86, 0.08, 0.24)
	elseif spell and IsHelpfulSpell(spell) then
		self:SetStatusBarColor(0.31, 0.78, 0.47)
	elseif spell and IsHarmfulSpell(spell) then
		self:SetStatusBarColor(0.63, 0.36, 0.94)
	else
		self:SetStatusBarColor(1, 0.7, 0)
	end
end

--hide the old casting bar
PlayerCastingBarFrame:UnregisterAllEvents()
PlayerCastingBarFrame:Hide()