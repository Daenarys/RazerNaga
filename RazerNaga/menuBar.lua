--[[
	MenuBar
--]]

local MenuBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)
RazerNaga.MenuBar = MenuBar

local WIDTH_OFFSET = 2
local HEIGHT_OFFSET = 20

local MICRO_BUTTONS = {
	"CharacterMicroButton",
	"SpellbookMicroButton",
	"TalentMicroButton",
	"AchievementMicroButton",
	"QuestLogMicroButton",
	"GuildMicroButton",
	"LFDMicroButton",
	"EJMicroButton",
	"CollectionsMicroButton",
	"StoreMicroButton",
	"MainMenuMicroButton"
}

local MICRO_BUTTON_NAMES = {
	['CharacterMicroButton'] = _G['CHARACTER_BUTTON'],
	['SpellbookMicroButton'] = _G['SPELLBOOK_ABILITIES_BUTTON'],
	['TalentMicroButton'] = _G['TALENTS_BUTTON'],
	['AchievementMicroButton'] = _G['ACHIEVEMENT_BUTTON'],
	['QuestLogMicroButton'] = _G['QUESTLOG_BUTTON'],
	['GuildMicroButton'] = _G['LOOKINGFORGUILD'],
	['LFDMicroButton'] = _G['DUNGEONS_BUTTON'],
	['EJMicroButton'] = _G['ENCOUNTER_JOURNAL'],
	['MainMenuMicroButton'] = _G['MAINMENU_BUTTON'],
	['StoreMicroButton'] = _G['BLIZZARD_STORE'],
	['CollectionsMicroButton'] = _G['COLLECTIONS']
}


--[[ Menu Bar ]]--

function MenuBar:SkinButton()
    local buttons = {
        {button = CharacterMicroButton, name = "Character"},
        {button = SpellbookMicroButton, name = "Spellbook"},
        {button = TalentMicroButton, name = "Talents"},
        {button = AchievementMicroButton, name = "Achievement"},
        {button = QuestLogMicroButton, name = "Quest"},
        {button = GuildMicroButton, name = "Socials"},
        {button = LFDMicroButton, name = "LFG"},
        {button = CollectionsMicroButton, name = "Mounts"},
        {button = EJMicroButton, name = "EJ"},
        {button = StoreMicroButton, name = "BStore"},  
        {button = MainMenuMicroButton, name = "MainMenu"},
    }

    local function replaceAtlases(self, name)
        local prefix = "Interface\\Buttons\\UI-MicroButton-";
        self:SetNormalTexture(prefix..name.."-Up");
        self:SetPushedTexture(prefix..name.."-Down");
        self:SetDisabledTexture(prefix..name.."-Disabled");

        self:HookScript("OnUpdate", function(self)
            if self.FlashBorder then
				self.FlashBorder:SetSize(64, 64)
				self.FlashBorder:SetTexture("Interface\\Buttons\\Micro-Highlight")
				self.FlashBorder:ClearAllPoints()
				self.FlashBorder:SetPoint("TOPLEFT", -2, -18)
            end
            if self.FlashContent then
                UIFrameFlashStop(self.FlashContent);
            end
            self:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");
        end)
    end

    local function replaceAllAtlases()
        for _, data in pairs(buttons) do
            replaceAtlases(data.button, data.name)
        end
    end
    replaceAllAtlases()

    CharacterMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up");
    CharacterMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down");
    CharacterMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");

    local portrait = CharacterMicroButton:CreateTexture("MicroButtonPortrait", "OVERLAY")
    portrait:SetSize(18, 25)
    portrait:SetPoint("TOP", 0, -28)
    portrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)

    CharacterMicroButton:HookScript("OnEvent", function(self, event, ...)
        if (event == "UNIT_PORTRAIT_UPDATE") then
            local unit = ...
            if (unit == "player") then
                SetPortraitTexture(MicroButtonPortrait, "player")
            end
        elseif (event == "PORTRAITS_UPDATED") then
            SetPortraitTexture(MicroButtonPortrait, "player")
        elseif (event == "PLAYER_ENTERING_WORLD") then
            SetPortraitTexture(MicroButtonPortrait, "player")
        end
    end)
    CharacterMicroButton:RegisterEvent("PLAYER_ENTERING_WORLD")
    CharacterMicroButton:RegisterEvent("UNIT_PORTRAIT_UPDATE")
    CharacterMicroButton:RegisterEvent("PORTRAITS_UPDATED")

    local function CharacterMicroButton_SetPushed()
        SetPortraitTexture(MicroButtonPortrait, "player")
        MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333);
        MicroButtonPortrait:SetAlpha(0.5);
        CharacterMicroButton:SetButtonState("PUSHED", true);
    end
    
    local function CharacterMicroButton_SetNormal()
        SetPortraitTexture(MicroButtonPortrait, "player")
        MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9);
        MicroButtonPortrait:SetAlpha(1.0);
        CharacterMicroButton:SetButtonState("NORMAL");
    end

    CharacterMicroButton:HookScript("OnMouseDown", function(self)
        if ( not KeybindFrames_InQuickKeybindMode() ) then
            if ( self.down ) then
                CharacterMicroButton_SetPushed();
            end
        end
    end)

    CharacterMicroButton:HookScript("OnMouseUp", function(self, button)
        if ( KeybindFrames_InQuickKeybindMode() ) then
        else
            if ( self.down ) then
            elseif ( self:GetButtonState() == "NORMAL" ) then
                CharacterMicroButton_SetNormal();
            else
                CharacterMicroButton_SetPushed();
            end
        end
    end)

    MainMenuMicroButton:CreateTexture("MainMenuBarDownload", "OVERLAY")
    MainMenuBarDownload:SetPoint("BOTTOM", "StoreMicroButton", "BOTTOMRIGHT", -2, 0)
    MainMenuBarDownload:SetSize(28, 28)

    MainMenuMicroButton:HookScript("OnUpdate", function(self, elapsed)
        local status = GetFileStreamingStatus();
            if ( status == 0 ) then
            MainMenuBarDownload:Hide();
            self:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
            self:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
            self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
        else
            self:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up");
            self:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Down");
            self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up");
            if ( status == 1 ) then
                MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Green");
            elseif ( status == 2 ) then
                MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Yellow");
            elseif ( status == 3 ) then
                MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Red");
            end
            MainMenuBarDownload:Show();
        end
        self:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");
    end)

    local GuildMicroButtonTabard = CreateFrame("Frame", "GuildMicroButtonTabard", GuildMicroButton)
    GuildMicroButtonTabard:SetSize(28, 58)
    GuildMicroButtonTabard:SetPoint("TOPLEFT")
    GuildMicroButtonTabard:Hide()

    GuildMicroButtonTabard.background = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardBackground", "ARTWORK")
    GuildMicroButtonTabardBackground:SetSize(30, 60)
    GuildMicroButtonTabardBackground:SetTexture("Interface\\Buttons\\UI-MicroButton-Guild-Banner")
    GuildMicroButtonTabardBackground:SetPoint("CENTER", 0, 0)

    GuildMicroButtonTabard.emblem = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardEmblem", "OVERLAY")
    GuildMicroButtonTabardEmblem:SetSize(16, 16)
    GuildMicroButtonTabardEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
    GuildMicroButtonTabardEmblem:SetPoint("CENTER", 0, -9)

    local function GuildMicroButton_UpdateTabard(forceUpdate)
        local tabard = GuildMicroButtonTabard;
        if ( not tabard.needsUpdate and not forceUpdate ) then
            return;
        end
        -- switch textures if the guild has a custom tabard
        local emblemFilename = select(10, GetGuildLogoInfo());
        if ( emblemFilename ) then
            if ( not tabard:IsShown() ) then
                local button = GuildMicroButton;
                button:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up");
                button:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down");
                -- no need to change disabled texture, should always be available if you're in a guild
                tabard:Show();
            end
            SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background);
        else
            if ( tabard:IsShown() ) then
                local button = GuildMicroButton;
                button:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up");
                button:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down");
                button:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled");
                tabard:Hide();
            end
        end
        tabard.needsUpdate = nil;
    end

    local function updateButtons()
        if ( CharacterFrame and CharacterFrame:IsShown() ) then
            CharacterMicroButton_SetPushed();
        else
            CharacterMicroButton_SetNormal();
        end
        GuildMicroButton_UpdateTabard(true)
        if ( CommunitiesFrame and CommunitiesFrame:IsShown() ) or ( GuildFrame and GuildFrame:IsShown() ) then
            GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -2);
            GuildMicroButtonTabard:SetAlpha(0.70);
        else
            GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0);
            GuildMicroButtonTabard:SetAlpha(1);
        end
    end
    hooksecurefunc("UpdateMicroButtons", updateButtons)
end

function MenuBar:New()
	local bar = MenuBar.super.New(self, 'menu')

	bar:LoadButtons()
	bar:Layout()

	return bar
end

function MenuBar:Create(frameId)
	local bar = MenuBar.super.Create(self, frameId)

	bar.buttons = {}
	bar.activeButtons = {}

	local getOrHook = function(frame, script, action)
		if frame:GetScript(script) then
			frame:HookScript(script, action)
		else
			frame:SetScript(script, action)
		end
	end

	local requestLayoutUpdate
	do
		local f = CreateFrame('Frame'); f:Hide()
		local delay = 0.01

		f:SetScript('OnUpdate', function(self, elapsed)
			self:Hide()
			bar:Layout()
		end)

		requestLayoutUpdate = function() f:Show() end
	end

	hooksecurefunc('UpdateMicroButtons', function() requestLayoutUpdate() end)

	local petBattleFrame = _G['PetBattleFrame'].BottomFrame.MicroButtonFrame

	getOrHook(petBattleFrame, 'OnShow', function()
		bar.isPetBattleUIShown = true
		requestLayoutUpdate()
	end)

	getOrHook(petBattleFrame, 'OnHide', function()
		bar.isPetBattleUIShown = nil
		requestLayoutUpdate()
	end)


	local overrideActionBar = _G['OverrideActionBar']

	getOrHook(overrideActionBar, 'OnShow', function()
		bar.isOverrideUIShown = RazerNaga:UsingOverrideUI()
		requestLayoutUpdate()
	end)

	getOrHook(overrideActionBar, 'OnHide', function()
		bar.isOverrideUIShown = nil
		requestLayoutUpdate()
	end)

	return bar
end

function MenuBar:LoadButtons()
	for i, buttonName in ipairs(MICRO_BUTTONS) do
		self:AddButton(i)
	end

	self:UpdateClickThrough()
end

function MenuBar:AddButton(i)
	local buttonName = MICRO_BUTTONS[i]
	local button = _G[buttonName]

	if button then
		button:SetParent(self.header)
		button:SetSize(28, 58)
		button:Show()
		self:SkinButton()

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
	MenuBar.super.LoadSettings(self, ...)

	self.activeButtons = {}
end

function MenuBar:GetDefaults()
	return {
		point = 'BOTTOMRIGHT',
		x = -244,
		y = 0,
	}
end

function MenuBar:NumButtons()
	return #self.activeButtons
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
    local w = firstButton:GetWidth() + spacing - WIDTH_OFFSET
    local h = firstButton:GetHeight() + spacing - HEIGHT_OFFSET

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
        button:SetPoint('TOPLEFT', w*col + pW, -(h*row + pH) + HEIGHT_OFFSET)
        button:Show()
    end

    -- Update bar size, if we're not in combat
    -- TODO: manage bar size via secure code
    if not InCombatLockdown() then
        local newWidth = max(w*cols - spacing + pW*2 + WIDTH_OFFSET, 8)
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
	local isStoreEnabled = C_StorePublic.IsEnabled()
	local overrideButtons = {}

	for i, buttonName in ipairs(MICRO_BUTTONS) do
		local button = _G[buttonName]
		button:Hide()

		local shouldAddButton

		if buttonName == 'HelpMicroButton' then
			shouldAddButton = not isStoreEnabled
		elseif buttonName == 'StoreMicroButton' then
			shouldAddButton = isStoreEnabled
		else
			shouldAddButton = true
		end

		if shouldAddButton then
			table.insert(overrideButtons, button)
		end
	end

	for i, button in ipairs(overrideButtons) do
		if i > 1 then
			button:ClearAllPoints()
			if i == 7 then
				button:SetPoint('TOPLEFT', overrideButtons[1], 'BOTTOMLEFT', 0, HEIGHT_OFFSET + 4)
			else
				button:SetPoint('BOTTOMLEFT', overrideButtons[i - 1], 'BOTTOMRIGHT', -WIDTH_OFFSET, 0)
			end
		end

		button:Show()
	end
end

function MenuBar:UpdateActiveButtons()
	for i = 1, #self.activeButtons do self.activeButtons[i] = nil end

	for i, button in ipairs(self.buttons) do
		if not self:IsMenuButtonDisabled(button) then
			table.insert(self.activeButtons, button)
		end
	end
end

--[[ Menu Code ]]--

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

--[[ module ]]--

local MenuBarController = RazerNaga:NewModule('MenuBar')

function MenuBarController:OnInitialize()
	-- fixed blizzard nil bug
	if not _G['AchievementMicroButton_Update'] then
		_G['AchievementMicroButton_Update'] = function() end
	end

	-- the performance bar actually appears under the game menu button if you
	-- move it somewhere else
	local perf = MainMenuMicroButton and MainMenuMicroButton.MainMenuBarPerformanceBar
	if perf then
		perf:SetSize(28, 58)
		perf:ClearAllPoints()
		perf:SetPoint('BOTTOM')
	end
end

function MenuBarController:Load()
	self.frame = MenuBar:New()
end

function MenuBarController:Unload()
	if self.frame then
		self.frame:Free()
		self.frame = nil
	end
end
