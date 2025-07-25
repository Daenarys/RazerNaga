local AddonName, Addon = ...
local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local EncounterBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame); Addon.EncounterBar = EncounterBar

function EncounterBar:New()
	local f = RazerNaga.Frame.New(self, 'encounter')
	
	f:InitPlayerPowerBarAlt()
	f:ShowInOverrideUI(true)
	f:ShowInPetBattleUI(true)
	f:Layout()

	return f
end

function EncounterBar:OnEvent(self, event, ...)
	local f = self[event]
	if f then
		f(self, event, ...)
	end
end

function EncounterBar:GetDefaults()
	return { point = 'CENTER' }
end

function EncounterBar:NumButtons()
	return 1
end

function EncounterBar:Layout()
	if InCombatLockdown() then return end		

	-- always reparent + position the bar due to UIParent.lua moving it whenever its shown
	local bar = self.__PlayerPowerBarAlt
	bar:SetParent(self)
	bar:ClearAllPoints()
	bar:SetPoint('CENTER')		
	
	local width, height = bar:GetSize()
	local pW, pH = self:GetPadding()

	width = math.max(width, 36 * 6)
	height = math.max(height, 36)

	self:SetSize(width + pW, height + pH)
end

-- grab a reference to the bar
-- and hook the scripts we need to hook
function EncounterBar:InitPlayerPowerBarAlt()
	if not self.__PlayerPowerBarAlt then
		local bar = _G['PlayerPowerBarAlt']
		
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

	return panel
end

function EncounterBar:AddAdvancedPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Advanced)

	panel:NewClickThroughCheckbox()
	
	return panel
end