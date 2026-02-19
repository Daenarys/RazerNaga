--[[
	general.lua
		The general panel of the RazerNaga GeneralOptions menu
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config')
local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local AddonName, AddonDesc = select(2, C_AddOns.GetAddOnInfo('RazerNaga'))

do
	local Options = CreateFrame('Frame', 'RazerNagaOptions'); Options:Hide()
	RazerNaga.Options = Options

	Options.panels = {}

	Options.name = AddonName

	local mainCategory = Settings.RegisterCanvasLayoutCategory(Options, AddonName)
	Settings.RegisterAddOnCategory(mainCategory)
	Options.mainCategory = mainCategory
	
	Options.NewPanel = function(self, title, subtitle, icon)
		local panel = RazerNaga.Panel:New('$parent' .. title, AddonName, title, subtitle, icon)

		local subCategory = Settings.RegisterCanvasLayoutSubcategory(self.mainCategory, panel, title)
		panel.settingsCategory = subCategory

		table.insert(self.panels, panel)

		return panel
	end
end

local GeneralOptions = RazerNaga.Options:NewPanel(L.General, L.GeneralPanelDesc, [[Interface\Addons\RazerNaga\Icons\RazerNaga]])

--[[ Buttons ]]--

--toggle config mode
local lock = GeneralOptions:NewButton(L.EnterConfigMode, 136, 22)
lock:SetScript('OnClick', function(self)
	RazerNaga:ToggleLockedFrames()
	HideUIPanel(SettingsPanel)
end)
lock:SetPoint('TOPLEFT', 12, -80)

--toggle keybinding mode
local bind = GeneralOptions:NewButton(L.EnterBindingMode, 116, 22)
bind:SetScript('OnClick', function(self)
	RazerNaga:ToggleBindingMode()
	HideUIPanel(SettingsPanel)
end)
bind:SetPoint('LEFT', lock, 'RIGHT', 4, 0)


--[[ Check Buttons ]]--

--[[ General Settings ]]--

local stickyBars = GeneralOptions:NewCheckButton(L.StickyBars)
stickyBars:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:Sticky())
end)
stickyBars:SetScript('OnClick', function(self)
	RazerNaga:SetSticky(self:GetChecked())
end)
stickyBars:SetPoint('TOPLEFT', lock, 'BOTTOMLEFT', 0, -24)

local linkedOpacity = GeneralOptions:NewCheckButton(L.LinkedOpacity)
linkedOpacity:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:IsLinkedOpacityEnabled())
end)
linkedOpacity:SetScript('OnClick', function(self)
	RazerNaga:SetLinkedOpacity(self:GetChecked())
end)
linkedOpacity:SetPoint('TOP', stickyBars, 'BOTTOM', 8, -2)

local showMinimapButton = GeneralOptions:NewCheckButton(L.ShowMinimapButton)
showMinimapButton:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowingMinimap())
end)
showMinimapButton:SetScript('OnClick', function(self)
	RazerNaga:SetShowMinimap(self:GetChecked())
end)
showMinimapButton:SetPoint('TOP', linkedOpacity, 'BOTTOM', -8, -10)


--[[ Action Bar Settings ]]--

--show empty buttons
local showEmpty = GeneralOptions:NewCheckButton(L.ShowEmptyButtons)
showEmpty:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowGrid())
end)
showEmpty:SetScript('OnClick', function(self)
	RazerNaga:SetShowGrid(self:GetChecked())
end)
--showEmpty:SetPoint('TOPLEFT', lock, 'BOTTOMLEFT', 0, -24)
showEmpty:SetPoint('TOP', showMinimapButton, 'BOTTOM', 0, -10)

--show keybinding text
local showBindings = GeneralOptions:NewCheckButton(L.ShowBindingText)
showBindings:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowBindingText())
end)
showBindings:SetScript('OnClick', function(self)
	RazerNaga:SetShowBindingText(self:GetChecked())
end)
showBindings:SetPoint('TOP', showEmpty, 'BOTTOM', 0, -10)

--show macro text
local showMacros = GeneralOptions:NewCheckButton(L.ShowMacroText)
showMacros:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowMacroText())
end)
showMacros:SetScript('OnClick', function(self)
	RazerNaga:SetShowMacroText(self:GetChecked())
end)
showMacros:SetPoint('TOP', showBindings, 'BOTTOM', 0, -10)

--show tooltips
local showTooltips = GeneralOptions:NewCheckButton(L.ShowTooltips)
showTooltips:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowTooltips())
end)
showTooltips:SetScript('OnClick', function(self)
	RazerNaga:SetShowTooltips(self:GetChecked())
end)
showTooltips:SetPoint('TOP', showMacros, 'BOTTOM', 0, -10)

--show tooltips in combat
local showTooltipsCombat = GeneralOptions:NewCheckButton(L.ShowTooltipsCombat)
showTooltipsCombat:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:ShowCombatTooltips())
end)
showTooltipsCombat:SetScript('OnClick', function(self)
	RazerNaga:SetShowCombatTooltips(self:GetChecked())
end)
showTooltipsCombat:SetPoint('TOP', showTooltips, 'BOTTOM', 8, -2)

--show override ui
local showOverrideUI = GeneralOptions:NewCheckButton(L.ShowOverrideUI)
showOverrideUI:SetScript('OnShow', function(self)
	self:SetChecked(RazerNaga:UsingOverrideUI())
end)
showOverrideUI:SetScript('OnClick', function(self)
	RazerNaga:SetUseOverrideUI(self:GetChecked())
end)
showOverrideUI:SetPoint('TOP', showTooltipsCombat, 'BOTTOM', -8, -10)


--[[ Dropdowns ]]--

local info = {}
local function AddItem(text, value, func, checked, arg1)
	info.text = text
	info.func = func
	info.value = value
	info.checked = checked
	info.arg1 = arg1
	UIDropDownMenu_AddButton(info)
end

local function AddClickActionSelector(self, name, action)
	local dd = self:NewDropdown(name)

	dd:SetScript('OnShow', function(self)
		UIDropDownMenu_SetWidth(self, 110)
		UIDropDownMenu_Initialize(self, self.Initialize)
		UIDropDownMenu_SetSelectedValue(self, GetModifiedClick(action) or 'NONE')
	end)

	local function Item_OnClick(self)
		SetModifiedClick(action, self.value)
		UIDropDownMenu_SetSelectedValue(dd, self.value)
		SaveBindings(GetCurrentBindingSet())
	end

	function dd:Initialize()
		local selected = GetModifiedClick(action) or 'NONE'

		AddItem(ALT_KEY, 'ALT', Item_OnClick, 'ALT' == selected)
		AddItem(CTRL_KEY, 'CTRL', Item_OnClick, 'CTRL' == selected)
		AddItem(SHIFT_KEY, 'SHIFT', Item_OnClick, 'SHIFT' == selected)
		AddItem(NONE_KEY, 'NONE', Item_OnClick, 'NONE' == selected)
	end
	return dd
end

local function AddRightClickTargetSelector(self)
	local dd = self:NewDropdown(L.RightClickUnit)

	dd:SetScript('OnShow', function(self)
		UIDropDownMenu_SetWidth(self, 110)
		UIDropDownMenu_Initialize(self, self.Initialize)
		UIDropDownMenu_SetSelectedValue(self, RazerNaga:GetRightClickUnit() or 'NONE')
	end)

	local function Item_OnClick(self)
		RazerNaga:SetRightClickUnit(self.value ~= 'NONE' and self.value or nil)
		UIDropDownMenu_SetSelectedValue(dd, self.value)
	end

	function dd:Initialize()
		local selected = RazerNaga:GetRightClickUnit()  or 'NONE'

		AddItem(L.RCUPlayer, 'player', Item_OnClick, 'player' == selected)
		AddItem(L.RCUFocus, 'focus', Item_OnClick, 'focus' == selected)
		AddItem(L.RCUToT, 'targettarget', Item_OnClick, 'targettarget' == selected)
		AddItem(NONE_KEY, 'NONE', Item_OnClick, 'NONE' == selected)
	end
	return dd
end

local function AddPossessBarSelector(self)
	local dd = self:NewDropdown(L.PossessBar)

	dd:SetScript('OnShow', function(self)
		UIDropDownMenu_SetWidth(self, 110)
		UIDropDownMenu_Initialize(self, self.Initialize)
		UIDropDownMenu_SetSelectedValue(self, RazerNaga:GetOverrideBar().id)
	end)

	local function Item_OnClick(self)
		RazerNaga:SetOverrideBar(self.value)
		UIDropDownMenu_SetSelectedValue(dd, self.value)
	end

	function dd:Initialize()
		local selected = RazerNaga:GetOverrideBar().id

		for i = 1, RazerNaga:NumBars() do
			AddItem('Action Bar ' .. i, i, Item_OnClick, i == selected)
		end
	end
	return dd
end

local rightClickUnit = AddRightClickTargetSelector(GeneralOptions)
rightClickUnit:SetPoint('TOPRIGHT', -10, -132)

local possess = AddPossessBarSelector(GeneralOptions)
possess:SetPoint('TOP', rightClickUnit, 'BOTTOM', 0, -16)