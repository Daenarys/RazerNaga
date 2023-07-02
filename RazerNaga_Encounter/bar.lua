if not PlayerPowerBarAlt then return end

local AddonName, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local EncounterBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame); Addon.EncounterBar = EncounterBar

function EncounterBar:New()
	local f = EncounterBar.super.New(self, 'encounter')

	f:InitPlayerPowerBarAlt()
	f:ShowInOverrideUI(true)
	f:ShowInPetBattleUI(true)
	f:Layout()

	return f
end

function EncounterBar:GetDefaults()
	return { point = 'CENTER' }
end

-- always reparent + position the bar due to UIParent.lua moving it whenever its shown
function EncounterBar:Layout()
	local bar = self.__PlayerPowerBarAlt
	bar:ClearAllPoints()
	bar:SetParent(self.header)
	bar:SetPoint('CENTER', self.header)

	-- resize out of combat
	if not InCombatLockdown() then
		local width, height = bar:GetSize()
		local pW, pH = self:GetPadding()

		width = math.max(width, 36 * 6)
		height = math.max(height, 36)

		self:SetSize(width + pW, height + pH)
	end
end

-- grab a reference to the bar
-- and hook the scripts we need to hook
function EncounterBar:InitPlayerPowerBarAlt()
	if not self.__PlayerPowerBarAlt then
		local bar = PlayerPowerBarAlt

		if bar:GetScript('OnSizeChanged') then
			bar:HookScript('OnSizeChanged', function() self:Layout() end)
		else
			bar:SetScript('OnSizeChanged', function() self:Layout() end)
		end

		self.__PlayerPowerBarAlt = bar
	end
end

function EncounterBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	self:AddLayoutPanel(menu)
	self:AddAdvancedPanel(menu)
	
	self.menu = menu
	
	return menu
end

function EncounterBar:AddLayoutPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel.opacitySlider = panel:NewOpacitySlider()
	panel.fadeSlider = panel:NewFadeSlider()
	panel.scaleSlider = panel:NewScaleSlider()
	panel.paddingSlider = panel:NewPaddingSlider()
	panel.spacingSlider = panel:NewSpacingSlider()

	return panel
end

function EncounterBar:AddAdvancedPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Advanced)

	panel:NewClickThroughCheckbox()
	
	return panel
end