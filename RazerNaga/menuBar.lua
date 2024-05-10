--------------------------------------------------------------------------------
-- Menu Bar
-- Defines the RazerNaga menuBar object
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local MenuBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

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

function MenuBar:SkinButton(button)
    if button.skinned then return end

    button:SetSize(28, 36)

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
        {button = MainMenuMicroButton, name = "MainMenu"}
    }

    local function replaceAtlases(self, name)
        local prefix = "hud-microbutton-";
        self:SetNormalAtlas(prefix..name.."-Up", true)
        self:SetPushedAtlas(prefix..name.."-Down", true)
        if self:GetDisabledTexture() then
            self:SetDisabledAtlas(prefix..name.."-Disabled", true)
        end
    end

    local function replaceAllAtlases()
        for _, data in pairs(buttons) do
            replaceAtlases(data.button, data.name)
        end
    end
    replaceAllAtlases()

    button:HookScript("OnUpdate", function(self)
        local normalTexture = self:GetNormalTexture()
        if (normalTexture) then
            normalTexture:SetAlpha(1)
        end
        local highlightTexture = self:GetHighlightTexture()
        if (highlightTexture) then
            highlightTexture:SetAlpha(1)
        end
        if self.Background then
            self.Background:Hide()
        end
        if self.PushedBackground then
            self.PushedBackground:Hide()
        end
        if self.Shadow then
            self.Shadow:Hide()
        end
        if self.PushedShadow then
            self.PushedShadow:Hide()
        end
        if self.FlashBorder then
            self.FlashBorder:SetAtlas("hud-microbutton-highlightalert", true)
            self.FlashBorder:ClearAllPoints()
            self.FlashBorder:SetPoint("TOPLEFT", -2, 2)
        end
        if self.FlashContent then
            UIFrameFlashStop(self.FlashContent)
        end
        if self.Emblem then
            self.Emblem:Hide()
        end
        if self.HighlightEmblem then
            self.HighlightEmblem:Hide()
        end
        self:SetHighlightAtlas("hud-microbutton-highlight")
    end)

    if not MicroButtonPortrait then
        local portrait = CharacterMicroButton:CreateTexture("MicroButtonPortrait", "OVERLAY")
        portrait:SetSize(16, 22)
        portrait:SetPoint("TOP", 0, -8)
        portrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
    end

    CharacterMicroButton:HookScript("OnEvent", function(self, event, ...)
        if ( event == "UNIT_PORTRAIT_UPDATE" ) then
            local unit = ...;
            if ( unit == "player" ) then
                SetPortraitTexture(MicroButtonPortrait, "player")
            end
        elseif ( event == "PORTRAITS_UPDATED" ) then
            SetPortraitTexture(MicroButtonPortrait, "player")
        elseif ( event == "PLAYER_ENTERING_WORLD" ) then
            SetPortraitTexture(MicroButtonPortrait, "player")
        end
    end)

    local function CharacterMicroButton_SetPushed()
        MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
        MicroButtonPortrait:SetAlpha(0.5)
    end

    local function CharacterMicroButton_SetNormal()
        MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
        MicroButtonPortrait:SetAlpha(1.0)
    end

    CharacterMicroButton:HookScript("OnMouseDown", function(self)
        if ( not KeybindFrames_InQuickKeybindMode() and self:IsEnabled() ) then
            MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
            MicroButtonPortrait:SetAlpha(0.5)
        end
    end)

    CharacterMicroButton:HookScript("OnMouseUp", function(self)
        if ( not KeybindFrames_InQuickKeybindMode() and self:IsEnabled() ) then
            MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
            MicroButtonPortrait:SetAlpha(1.0)
        end
    end)

    if not MainMenuBarDownload then
        MainMenuBarDownload = MainMenuMicroButton:CreateTexture("MainMenuBarDownload", "OVERLAY")
        MainMenuBarDownload:SetSize(28, 28)
        MainMenuBarDownload:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, -7)
    end
    
    MainMenuMicroButton:HookScript("OnUpdate", function(self, elapsed)
        local status = GetFileStreamingStatus();
        if ( status == 0 ) then
            MainMenuBarDownload:Hide()
            self:SetNormalAtlas("hud-microbutton-MainMenu-Up", true)
            self:SetPushedAtlas("hud-microbutton-MainMenu-Down", true)
            self:SetDisabledAtlas("hud-microbutton-MainMenu-Disabled", true)
        else
            self:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
            self:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Down")
            self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
        if ( status == 1 ) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Green")
        elseif ( status == 2 ) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Yellow")
        elseif ( status == 3 ) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Red")
        end
            MainMenuBarDownload:Show()
        end
    end)

    if not GuildMicroButtonTabard then
        local GuildMicroButtonTabard = CreateFrame("Frame", "GuildMicroButtonTabard", GuildMicroButton)
        GuildMicroButtonTabard:SetSize(28, 36)
        GuildMicroButtonTabard:SetPoint("TOPLEFT")
        GuildMicroButtonTabard:Hide()
    end

    if not GuildMicroButtonTabardBackground then
        GuildMicroButtonTabard.background = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardBackground", "ARTWORK")
        GuildMicroButtonTabardBackground:SetAtlas("hud-microbutton-Guild-Banner", true)
        GuildMicroButtonTabardBackground:SetPoint("CENTER", 0, 0)
    end

    if not GuildMicroButtonTabardEmblem then
        GuildMicroButtonTabard.emblem = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardEmblem", "OVERLAY")
        GuildMicroButtonTabardEmblem:SetSize(14, 14)
        GuildMicroButtonTabardEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
        GuildMicroButtonTabardEmblem:SetPoint("CENTER", 0, 0)
    end

    GuildMicroButton:HookScript("OnMouseDown", function(self)
        if self:IsEnabled() then
            GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -1)
            GuildMicroButtonTabard:SetAlpha(0.5)
        end
    end)

    GuildMicroButton:HookScript("OnMouseUp", function(self)
        if self:IsEnabled() then
            GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0)
            GuildMicroButtonTabard:SetAlpha(1.0)
        end
    end)

    hooksecurefunc(GuildMicroButton, "UpdateNotificationIcon", function(self)
        self.NotificationOverlay:Hide()
    end)

    hooksecurefunc(GuildMicroButton, "UpdateTabard", function()
        local tabard = GuildMicroButtonTabard;
        if ( not tabard.needsUpdate ) then
            return;
        end
        -- switch textures if the guild has a custom tabard
        local emblemFilename = select(10, GetGuildLogoInfo())
        if ( emblemFilename ) then
            if ( not tabard:IsShown() ) then
                local button = GuildMicroButton;
                button:SetNormalAtlas("hud-microbutton-Character-Up", true)
                button:SetPushedAtlas("hud-microbutton-Character-Down", true)
                button:SetDisabledAtlas("hud-microbutton-Character-Up", true)
                tabard:Show()
            end
            SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background)
        else
            if ( tabard:IsShown() ) then
                local button = GuildMicroButton;
                button:SetNormalAtlas("hud-microbutton-Socials-Up", true)
                button:SetPushedAtlas("hud-microbutton-Socials-Down", true)
                button:SetDisabledAtlas("hud-microbutton-Socials-Disabled", true)
                tabard:Hide()
            end
        end
        tabard.needsUpdate = nil;
    end)

    GuildMicroButton:HookScript("OnEvent", function(self, event, ...)
        if ( event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_GUILD_UPDATE" or event == "NEUTRAL_FACTION_SELECT_RESULT" ) then
            GuildMicroButtonTabard.needsUpdate = true;
        end
    end)

    hooksecurefunc("UpdateMicroButtons", function()
        if AchievementMicroButton:IsEnabled() then
            AchievementMicroButton.tooltipText = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT");
        end
        if CharacterMicroButton.Portrait then
            CharacterMicroButton.Portrait:Hide()
        end
        if CharacterMicroButton.PortraitMask then
            CharacterMicroButton.PortraitMask:Hide()
        end
        if ( CharacterFrame and CharacterFrame:IsShown() ) then
            CharacterMicroButton_SetPushed()
        else
            CharacterMicroButton_SetNormal()
        end
        if not CharacterMicroButton:IsEnabled() then
            SetDesaturation(MicroButtonPortrait, true)
        else
            SetDesaturation(MicroButtonPortrait, false)
        end
        GuildMicroButton:GetNormalTexture():SetVertexColor(1, 1, 1)
        GuildMicroButton:GetPushedTexture():SetVertexColor(1, 1, 1)
        GuildMicroButton:GetDisabledTexture():SetVertexColor(1, 1, 1)
        GuildMicroButton:GetHighlightTexture():SetVertexColor(1, 1, 1)
        if ( CommunitiesFrame and CommunitiesFrame:IsShown() ) or ( GuildFrame and GuildFrame:IsShown() ) then
            GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -1)
            GuildMicroButtonTabard:SetAlpha(0.70)
        else
            GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0)
            GuildMicroButtonTabard:SetAlpha(1)
        end
    end)

    hooksecurefunc("LoadMicroButtonTextures", function()
        local button = GuildMicroButton
        local emblemFilename = select(10, GetGuildLogoInfo())
        if ( emblemFilename ) then
            button:SetNormalAtlas("hud-microbutton-Character-Up", true)
            button:SetPushedAtlas("hud-microbutton-Character-Down", true)
            button:SetDisabledAtlas("hud-microbutton-Character-Up", true)
        else
            button:SetNormalAtlas("hud-microbutton-Socials-Up", true)
            button:SetPushedAtlas("hud-microbutton-Socials-Down", true)
            button:SetDisabledAtlas("hud-microbutton-Socials-Disabled", true)
        end
    end)

    hooksecurefunc("HelpOpenWebTicketButton_OnUpdate", function(self)
        self:SetParent(MainMenuMicroButton)
        self:ClearAllPoints()
        self:SetPoint("CENTER", MainMenuMicroButton, "TOPRIGHT", -3, -26)
    end)

    button.skinned = true
end

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

    if PetBattleFrame and PetBattleFrame.BottomFrame and PetBattleFrame.BottomFrame.MicroButtonFrame then
        local petMicroButtons = PetBattleFrame.BottomFrame.MicroButtonFrame

        getOrHook(
            petMicroButtons, 'OnShow', function()
                self.isPetBattleUIShown = true
                requestLayoutUpdate()
            end
        )

        getOrHook(
            petMicroButtons, 'OnHide', function()
                self.isPetBattleUIShown = nil
                requestLayoutUpdate()
            end
        )
    end

    if OverrideActionBar then
        getOrHook(
            OverrideActionBar, 'OnShow', function()
                self.isOverrideUIShown = RazerNaga:UsingOverrideUI()
                requestLayoutUpdate()
            end
        )

        getOrHook(
            OverrideActionBar, 'OnHide', function()
                self.isOverrideUIShown = nil
                requestLayoutUpdate()
            end
        )
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
        self:SkinButton(button)

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
    return {point = 'BOTTOMRIGHT', x = -244, y = 0}
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

    local l, r, t, b = self.overrideButtons[1]:GetHitRectInsets()

    for i, button in ipairs(self.overrideButtons) do
        button:SetParent(PetBattleFrame.BottomFrame.MicroButtonFrame)
        button:ClearAllPoints()
        if i == 1 then
            button:SetPoint('TOPLEFT', -4, 3)
        elseif i == 7 then
            button:SetPoint('TOPLEFT', self.overrideButtons[1], 'BOTTOMLEFT', 0, 6)
        else
            button:SetPoint('TOPLEFT', self.overrideButtons[i - 1], 'TOPRIGHT', -5, 0)
        end

        button:Show()
    end
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

function MenuBar:GetButtonInsets()
    local l, r, t, b = MenuBar.proto.GetButtonInsets(self)

    return l, r + 1, t + 3, b
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

    checkbox:SetScript(
        'OnClick', function(self)
            local owner = self:GetParent().owner

            owner:DisableMenuButton(button, self:GetChecked())
        end
    )

    checkbox:SetScript(
        'OnShow', function(self)
            local owner = self:GetParent().owner

            self:SetChecked(owner:IsMenuButtonDisabled(button))
        end
    )

    return checkbox
end

local function Menu_AddDisableMenuButtonsPanel(menu)
    local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').DisableMenuButtons)

    panel.width = 200

    for i, buttonName in ipairs(MICRO_BUTTONS) do
        Panel_AddDisableMenuButtonCheckbox(
            panel, _G[buttonName], MICRO_BUTTON_NAMES[buttonName]
        )
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
        perf:ClearAllPoints()
        perf:SetPoint('BOTTOM')
    end

    -- temp fix for 10.2.6 bug
    MicroMenu.GetEdgeButton = function() end
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