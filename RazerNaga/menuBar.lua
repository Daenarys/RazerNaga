--------------------------------------------------------------------------------
-- Menu Bar
--------------------------------------------------------------------------------

local PetMicroButtonFrame = PetBattleFrame and PetBattleFrame.BottomFrame.MicroButtonFrame

if MicroMenu then
	for _, button in ipairs { MicroMenu:GetChildren() } do
		button:SetParent(RazerNaga.ShadowUIParent)
	end
end

local MICRO_BUTTONS = {
	'CharacterMicroButton',
	'ProfessionMicroButton',
	'PlayerSpellsMicroButton',
	'AchievementMicroButton',
	'QuestLogMicroButton',
	'HousingMicroButton',
	'GuildMicroButton',
	'LFDMicroButton',
	'CollectionsMicroButton',
	'EJMicroButton',
	'StoreMicroButton',
	'MainMenuMicroButton'
}

local MICRO_BUTTON_NAMES = {
	['CharacterMicroButton'] = CHARACTER_BUTTON,
	['ProfessionMicroButton'] = PROFESSIONS_BUTTON,
	['PlayerSpellsMicroButton'] = PLAYERSPELLS_BUTTON,
	['AchievementMicroButton'] = ACHIEVEMENT_BUTTON,
	['QuestLogMicroButton'] = QUESTLOG_BUTTON,
	['HousingMicroButton'] = HOUSING_MICRO_BUTTON,
	['GuildMicroButton'] = GUILD_AND_COMMUNITIES,
	['LFDMicroButton'] = DUNGEONS_BUTTON,
	['CollectionsMicroButton'] = COLLECTIONS,
	['EJMicroButton'] = ENCOUNTER_JOURNAL,
	['StoreMicroButton'] = BLIZZARD_STORE,
	['MainMenuMicroButton'] = MAINMENU_BUTTON
}

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local MenuBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function MenuBar:New()
	local bar = MenuBar.proto.New(self, 'menu')

	bar:LoadButtons()
	bar:Layout()

	return bar
end

function MenuBar:Create(frameId)
	local bar = MenuBar.proto.Create(self, frameId)

	bar.buttons = {}
	bar.activeButtons = {}
	bar.overrideButtons = {}

	bar.updateLayout = function()
		bar:Layout()
		bar.updatingLayout = nil
	end

	local function getOrHook(frame, script, action)
		if frame:GetScript(script) then
			frame:HookScript(script, action)
		else
			frame:SetScript(script, action)
		end
	end

	local function requestLayoutUpdate()
		if not bar.updatingLayout then
			bar.updatingLayout = true
			C_Timer.After(0.1, bar.updateLayout)
		end
	end

	hooksecurefunc('UpdateMicroButtons', requestLayoutUpdate)

	if OverrideActionBar then
		getOrHook(OverrideActionBar, 'OnShow', function()
			self.isOverrideUIShown = RazerNaga:UsingOverrideUI()
			requestLayoutUpdate()
		end)

		getOrHook(OverrideActionBar, 'OnHide', function()
			self.isOverrideUIShown = nil
			requestLayoutUpdate()
		end)
	end

	if PetMicroButtonFrame then
		getOrHook(PetMicroButtonFrame, 'OnShow', function()
			self.isPetBattleUIShown = true
			requestLayoutUpdate()
		end)

		getOrHook(PetMicroButtonFrame, 'OnHide', function()
			self.isPetBattleUIShown = nil
			requestLayoutUpdate()
		end)
	end

	return bar
end

function MenuBar:LoadButtons()
	for i = 1, #MICRO_BUTTONS do
		self:AddButton(i)
	end

	self:UpdateClickThrough()
end

function MenuBar:AddButton(i)
	local buttonName = MICRO_BUTTONS[i]
	local button = _G[buttonName]

	if button then
		button:SetParent(self)
		button:Show()
		button:SetSize(28, 36)

		self.buttons[i] = button
	end
end

function MenuBar:RemoveButton(i)
	local button = self.buttons[i]

	if button then
		button:SetParent(nil)
		button:Hide()

		self.buttons[i] = nil
	end
end

function MenuBar:LoadSettings(...)
	MenuBar.proto.LoadSettings(self, ...)

	self.activeButtons = {}
end

function MenuBar:GetDefaults()
	return {
		point = 'BOTTOMRIGHT', 
		x = -244, 
		y = 0
	}
end

function MenuBar:NumButtons()
	return #self.activeButtons
end

function MenuBar:UpdateActiveButtons()
	for i = 1, #self.activeButtons do
		self.activeButtons[i] = nil
	end

	for i, button in ipairs(self.buttons) do
		if not self:IsMenuButtonDisabled(button) then
			table.insert(self.activeButtons, button)
		end
	end
end

function MenuBar:DisableMenuButton(button, disabled)
	local disabledButtons = self.sets.disabled or {}

	disabledButtons[button:GetName()] = disabled or false
	self.sets.disabled = disabledButtons

	self:Layout()
end

function MenuBar:IsMenuButtonDisabled(button)
	local disabledButtons = self.sets.disabled

	if disabledButtons then
		return disabledButtons[button:GetName()]
	end

	return false
end

function MenuBar:Layout()
	if self.isPetBattleUIShown then
		self:LayoutPetBattle()
	elseif self.isOverrideUIShown then
		self:LayoutOverrideUI()
	else
		self:LayoutNormal()
	end
end

function MenuBar:LayoutNormal()
	self:UpdateActiveButtons()
	
	for i, button in pairs(self.buttons) do
		button:Hide()
	end
	
	local numButtons = #self.activeButtons
	if numButtons == 0 then
		self:SetSize(36, 36)
		return
	end
	
	local cols = min(self:NumColumns(), numButtons)
	local rows = ceil(numButtons / cols)

	local pW, pH = self:GetPadding()
	local spacing = self:GetSpacing()

	local isLeftToRight = self:GetLeftToRight()
	local isTopToBottom = self:GetTopToBottom()

	local firstButton = self.buttons[1]
	local w = firstButton:GetWidth() + spacing - 2
	local h = firstButton:GetHeight() + spacing - 1

	for i, button in pairs(self.activeButtons) do
		local col, row
		
		if isLeftToRight then
			col = (i-1) % cols
		else
			col = (cols-1) - (i-1) % cols
		end

		if isTopToBottom then
			row = ceil(i / cols) - 1
		else
			row = rows - ceil(i / cols)
		end
		
		button:SetParent(self)
		button:ClearAllPoints()
		button:SetPoint('TOPLEFT', w*col + pW, -(h*row + pH) + 1)
		button:SetScale(1)
		button:Show()
	end

	-- Update bar size, if we're not in combat
	-- TODO: manage bar size via secure code
	if not InCombatLockdown() then
		local newWidth = max(w*cols - spacing + pW*2 + 2, 8)
		local newHeight = max(h*ceil(numButtons / cols) - spacing + pH*2, 8)
		self:SetSize(newWidth, newHeight)
	end
end

function MenuBar:LayoutPetBattle()
	self:FixButtonPositions()
end

function MenuBar:LayoutOverrideUI()
	self:FixButtonPositions()
end

function MenuBar:FixButtonPositions()
	wipe(self.overrideButtons)

	for _, buttonName in ipairs(MICRO_BUTTONS) do
		tinsert(self.overrideButtons, _G[buttonName])
	end

	if OverrideActionBar and OverrideActionBar:IsVisible() then
		for i, button in pairs(self.overrideButtons) do
			button:ClearAllPoints()
			button:SetParent(OverrideActionBar)
			button:SetScale(0.82)

			if i == 1 then
				local x, y = OverrideActionBar:GetMicroButtonAnchor()
				button:SetPoint('BOTTOMLEFT', x + button:GetWidth(), y + button:GetHeight())
			elseif i == 7 then
				button:SetPoint('TOPLEFT', self.overrideButtons[1], 'BOTTOMLEFT')
			else
				button:SetPoint('BOTTOMLEFT', self.overrideButtons[i - 1], 'BOTTOMRIGHT')
			end

			button:Show()
		end
	elseif PetMicroButtonFrame and PetMicroButtonFrame:IsVisible() then
		for i, button in ipairs(self.overrideButtons) do
			button:ClearAllPoints()
			button:SetParent(PetMicroButtonFrame)

			if i == 1 then
				button:SetPoint('TOPLEFT', -17, 9)
			elseif i == 7 then
				button:SetPoint('TOPLEFT', self.overrideButtons[1], 'BOTTOMLEFT', 0, 6)
			else
				button:SetPoint('TOPLEFT', self.overrideButtons[i - 1], 'TOPRIGHT', -5, 0)
			end

			button:Show()
		end
	end
end

--------------------------------------------------------------------------------
-- Menu
--------------------------------------------------------------------------------

local function Menu_AddLayoutPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel:NewOpacitySlider()
	panel:NewFadeSlider()
	panel:NewScaleSlider()
	panel:NewPaddingSlider()
	panel:NewSpacingSlider()
	panel:NewColumnsSlider()

	return panel
end

local function Panel_AddDisableMenuButtonCheckbox(panel, button, name)
	local checkbox = panel:NewCheckButton(name or button:GetName())

	checkbox:SetScript('OnClick', function(self)
		local owner = self:GetParent().owner
		owner:DisableMenuButton(button, self:GetChecked())
	end)

	checkbox:SetScript('OnShow', function(self)
		local owner = self:GetParent().owner
		self:SetChecked(owner:IsMenuButtonDisabled(button))
	end)

	return checkbox
end

local function Menu_AddDisableMenuButtonsPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').DisableMenuButtons)

	panel.width = 200

	for i, buttonName in ipairs(MICRO_BUTTONS) do
		Panel_AddDisableMenuButtonCheckbox(panel, _G[buttonName], MICRO_BUTTON_NAMES[buttonName])
	end

	return panel
end

function MenuBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	Menu_AddLayoutPanel(menu)
	Menu_AddDisableMenuButtonsPanel(menu)
	menu:AddAdvancedPanel()

	self.menu = menu

	return menu
end

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local MenuBarModule = RazerNaga:NewModule('MenuBar')

function MenuBarModule:OnInitialize()
	local perf = MainMenuMicroButton and MainMenuMicroButton.MainMenuBarPerformanceBar
	if perf then
		perf:SetSize(28, 58)
	end

	hooksecurefunc(MicroMenu, 'UpdateFramerateFrameAnchor', function()
		if FramerateFrame then
			FramerateFrame:ClearAllPoints()
			FramerateFrame:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 75)
		end
	end)

	hooksecurefunc(MicroMenu, 'UpdateHelpTicketButtonAnchor', function()
		if HelpOpenWebTicketButton then
			HelpOpenWebTicketButton:ClearAllPoints()
			HelpOpenWebTicketButton:SetPoint('CENTER', CharacterMicroButton, 'CENTER', 0, 20)
		end
	end)
end

function MenuBarModule:Load()
	self.frame = MenuBar:New()
end

function MenuBarModule:Unload()
	if self.frame then
		self.frame:Free()
		self.frame = nil
	end
end