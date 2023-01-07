--[[
	menuBar.lua
		A movable bar for the micro menu buttons
--]]

--[[ globals ]]--

local MenuBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)
RazerNaga.MenuBar = MenuBar

local MICRO_BUTTONS = {
    'CharacterMicroButton',
    'SpellbookMicroButton',
    'TalentMicroButton',
    'AchievementMicroButton',
    'QuestLogMicroButton',
    'GuildMicroButton',
    'LFDMicroButton',
    'CollectionsMicroButton',
    'EJMicroButton',
    'StoreMicroButton',
    'MainMenuMicroButton'
}

local MICRO_BUTTON_NAMES = {
    ['CharacterMicroButton'] = CHARACTER_BUTTON,
    ['SpellbookMicroButton'] = SPELLBOOK_ABILITIES_BUTTON,
    ['TalentMicroButton'] = TALENTS_BUTTON,
    ['AchievementMicroButton'] = ACHIEVEMENT_BUTTON,
    ['QuestLogMicroButton'] = QUESTLOG_BUTTON,
    ['GuildMicroButton'] = LOOKINGFORGUILD,
    ['LFDMicroButton'] = DUNGEONS_BUTTON,
    ['EJMicroButton'] = ENCOUNTER_JOURNAL,
    ['MainMenuMicroButton'] = MAINMENU_BUTTON,
    ['StoreMicroButton'] = BLIZZARD_STORE,
    ['CollectionsMicroButton'] = COLLECTIONS,
    ['HelpMicroButton'] = HELP_BUTTON,
    ['SocialsMicroButton'] = SOCIAL_BUTTON,
    ['WorldMapMicroButton'] = WORLDMAP_BUTTON
}

--[[ Menu Bar ]] --

function MenuBar:New()
    local bar = MenuBar.proto.New(self, 'menu')

    bar:LoadButtons()
    bar:Layout()

    return bar
end

function MenuBar:SkinButton(b)
    local SetPortraitTexture = SetPortraitTexture
    local BNConnected = BNConnected
    local C_Club_IsEnabled = C_Club.IsEnabled
    local C_Club_IsRestricted = C_Club.IsRestricted
    local Kiosk_IsEnabled = Kiosk.IsEnabled
    local UIFrameFlashStop = UIFrameFlashStop
    local UnitFactionGroup = UnitFactionGroup
    local GetFileStreamingStatus = GetFileStreamingStatus
    local GetBackgroundLoadingStatus = GetBackgroundLoadingStatus
    local IsCommunitiesUIDisabledByTrialAccount = IsCommunitiesUIDisabledByTrialAccount

    -- [MicroButtons]
    RazerNaga.mbWidth = 28
    RazerNaga.mbHeight = 38
    RazerNaga.MicroButtonsGroup = {
        [CharacterMicroButton] = 1,
        [SpellbookMicroButton] = 2,
        [TalentMicroButton] = 3,
        [AchievementMicroButton] = 4,
        [QuestLogMicroButton] = 5,
        [GuildMicroButton] = 6,
        [LFDMicroButton] = 7,
        [CollectionsMicroButton] = 8,
        [EJMicroButton] = 9,
        [StoreMicroButton] = 10,
        [MainMenuMicroButton] = 11
    }
    
    -- [MicroButtons] CharacterMicroButton
    CharacterMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    CharacterMicroButton:SetPoint("BOTTOMLEFT", 556, 2)
    CharacterMicroButton:SetFrameStrata("MEDIUM")
    CharacterMicroButton:SetFrameLevel(3)
    CharacterMicroButton:SetNormalAtlas("hud-microbutton-Character-Up", true)
    CharacterMicroButton:SetPushedAtlas("hud-microbutton-Character-Down", true)
    CharacterMicroButton:SetDisabledAtlas("hud-microbutton-Character-Disabled", true)
    CharacterMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    CharacterMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
    CharacterMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
    CharacterMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    CharacterMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Disabled")
    CharacterMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CharacterMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CharacterMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CharacterMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CharacterMicroButton.FlashBorder:SetSize(34, 44)
    CharacterMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] CharacterMicroButton -> Portrait texture
    local CUI_MicroButtonPortrait = CharacterMicroButton:CreateTexture("CUI_MicroButtonPortrait")
    CUI_MicroButtonPortrait:SetPoint("TOP", CharacterMicroButton, "TOP", 0, -7)
    CUI_MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
    CUI_MicroButtonPortrait:SetAlpha(1)
    CUI_MicroButtonPortrait:SetSize(18, 25)
    CUI_MicroButtonPortrait:SetDrawLayer("OVERLAY", 0)
    hooksecurefunc(CharacterMicroButton, "SetPushed", function(self)
        CUI_MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
        CUI_MicroButtonPortrait:SetAlpha(0.5)
    end)
    hooksecurefunc(CharacterMicroButton, "SetNormal", function(self)
        CUI_MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
        CUI_MicroButtonPortrait:SetAlpha(1.0)
    end)
    CharacterMicroButton:HookScript("OnEvent", function(self, event, ...)
        if (event == "UNIT_PORTRAIT_UPDATE") then
            local unit = ...
            if (unit == "player") then
                SetPortraitTexture(CUI_MicroButtonPortrait, "player")
            end
        elseif (event == "PORTRAITS_UPDATED") then
            SetPortraitTexture(CUI_MicroButtonPortrait, "player")
        elseif (event == "PLAYER_ENTERING_WORLD") then
            SetPortraitTexture(CUI_MicroButtonPortrait, "player")
        end
    end)
    CharacterMicroButton:RegisterEvent("PLAYER_ENTERING_WORLD")
    CharacterMicroButton:RegisterEvent("UNIT_PORTRAIT_UPDATE")
    CharacterMicroButton:RegisterEvent("PORTRAITS_UPDATED")
    SetPortraitTexture(CUI_MicroButtonPortrait, "player")
    CUI_MicroButtonPortrait:Show()
    
    -- [MicroButtons] SpellbookMicroButton
    SpellbookMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    SpellbookMicroButton:SetPoint("BOTTOMLEFT", CharacterMicroButton, "BOTTOMRIGHT", -2, 0)
    SpellbookMicroButton:SetFrameStrata("MEDIUM")
    SpellbookMicroButton:SetFrameLevel(3)
    SpellbookMicroButton:SetNormalAtlas("hud-microbutton-Spellbook-Up", true)
    SpellbookMicroButton:SetPushedAtlas("hud-microbutton-Spellbook-Down", true)
    SpellbookMicroButton:SetDisabledAtlas("hud-microbutton-Spellbook-Disabled", true)
    SpellbookMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    SpellbookMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Up")
    SpellbookMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Down")
    SpellbookMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    SpellbookMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Disabled")
    SpellbookMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    SpellbookMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    SpellbookMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    SpellbookMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    SpellbookMicroButton.FlashBorder:SetSize(34, 44)
    SpellbookMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] TalentMicroButton
    TalentMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    TalentMicroButton:SetPoint("BOTTOMLEFT", SpellbookMicroButton, "BOTTOMRIGHT", -2, 0)
    TalentMicroButton:SetFrameStrata("MEDIUM")
    TalentMicroButton:SetFrameLevel(3)
    TalentMicroButton:SetNormalAtlas("hud-microbutton-Talents-Up", true)
    TalentMicroButton:SetPushedAtlas("hud-microbutton-Talents-Down", true)
    TalentMicroButton:SetDisabledAtlas("hud-microbutton-Talents-Disabled", true)
    TalentMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    TalentMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Talents-Up")
    TalentMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Talents-Down")
    TalentMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    TalentMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Talents-Disabled")
    TalentMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    TalentMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    TalentMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    TalentMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    TalentMicroButton.FlashBorder:SetSize(34, 44)
    TalentMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] AchievementMicroButton
    AchievementMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    AchievementMicroButton:SetPoint("BOTTOMLEFT", TalentMicroButton, "BOTTOMRIGHT", -2, 0)
    AchievementMicroButton:SetFrameStrata("MEDIUM")
    AchievementMicroButton:SetFrameLevel(3)
    AchievementMicroButton:SetNormalAtlas("hud-microbutton-Achievement-Up", true)
    AchievementMicroButton:SetPushedAtlas("hud-microbutton-Achievement-Down", true)
    AchievementMicroButton:SetDisabledAtlas("hud-microbutton-Achievement-Disabled", true)
    AchievementMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    AchievementMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Up")
    AchievementMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Down")
    AchievementMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    AchievementMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Disabled")
    AchievementMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    AchievementMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    AchievementMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    AchievementMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    AchievementMicroButton.FlashBorder:SetSize(34, 44)
    AchievementMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] QuestLogMicroButton
    QuestLogMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    QuestLogMicroButton:SetPoint("BOTTOMLEFT", AchievementMicroButton, "BOTTOMRIGHT", -2, 0)
    QuestLogMicroButton:SetFrameStrata("MEDIUM")
    QuestLogMicroButton:SetFrameLevel(3)
    QuestLogMicroButton:SetNormalAtlas("hud-microbutton-Quest-Up", true)
    QuestLogMicroButton:SetPushedAtlas("hud-microbutton-Quest-Down", true)
    QuestLogMicroButton:SetDisabledAtlas("hud-microbutton-Quest-Disabled", true)
    QuestLogMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    QuestLogMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Quest-Up")
    QuestLogMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Quest-Down")
    QuestLogMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Quest-Disabled")
    QuestLogMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    QuestLogMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    QuestLogMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    QuestLogMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    QuestLogMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    QuestLogMicroButton.FlashBorder:SetSize(34, 44)
    QuestLogMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] GuildMicroButton
    GuildMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    GuildMicroButton:SetPoint("BOTTOMLEFT", QuestLogMicroButton, "BOTTOMRIGHT", -2, 0)
    GuildMicroButton:SetFrameStrata("MEDIUM")
    GuildMicroButton:SetFrameLevel(3)
    GuildMicroButton:SetNormalAtlas("hud-microbutton-Socials-Up", true)
    GuildMicroButton:SetPushedAtlas("hud-microbutton-Socials-Down", true)
    GuildMicroButton:SetDisabledAtlas("hud-microbutton-Socials-Disabled", true)
    GuildMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    GuildMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up")
    GuildMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down")
    GuildMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled")
    GuildMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    GuildMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    GuildMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    GuildMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    GuildMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    GuildMicroButton.FlashBorder:SetSize(34, 44)
    GuildMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    GuildMicroButton.NotificationOverlay:SetFrameStrata("MEDIUM")
    GuildMicroButton.NotificationOverlay:SetFrameLevel(500)
    GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetAtlas("hud-microbutton-communities-icon-notification")
    GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetSize(18, 18)
    GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:ClearAllPoints()
    GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetPoint("CENTER", GuildMicroButton.NotificationOverlay, "TOP", 0, -5)
    
    local GuildMicroButtonTabard = CreateFrame("Frame", "GuildMicroButtonTabard", GuildMicroButton)
    GuildMicroButtonTabard:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    GuildMicroButtonTabard:SetPoint("TOPLEFT", GuildMicroButton, "TOPLEFT", 0, 0)
    GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardBackground", "ARTWORK")
    GuildMicroButtonTabard:Hide()
    GuildMicroButtonTabard.background = GuildMicroButtonTabardBackground
    GuildMicroButtonTabardBackground:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    GuildMicroButtonTabardBackground:SetTexture("Interface\\Buttons\\UI-MicroButton-Guild-Banner")
    GuildMicroButtonTabardBackground:SetTexCoord(0/32, 32/32, 22/64, 64/64)
    GuildMicroButtonTabardBackground:SetPoint("CENTER", GuildMicroButtonTabard, "CENTER", 0, 0)
    GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardEmblem", "OVERLAY")
    GuildMicroButtonTabard.emblem = GuildMicroButtonTabardEmblem
    GuildMicroButtonTabardEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
    GuildMicroButtonTabardEmblem:SetDrawLayer("OVERLAY", 1)
    GuildMicroButtonTabardEmblem:SetSize(14, 14)
    GuildMicroButtonTabardEmblem:SetPoint("CENTER", GuildMicroButtonTabard, "CENTER", 0, 0)

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

    GuildMicroButton_UpdateTabard()
    C_Timer.After(4, GuildMicroButton_UpdateTabard)

    hooksecurefunc("UpdateMicroButtons", function()
        GuildMicroButton_UpdateTabard(true)
    end)

    -- [MicroButtons] LFDMicroButton
    LFDMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    LFDMicroButton:SetPoint("BOTTOMLEFT", GuildMicroButton, "BOTTOMRIGHT", -3, 0)
    LFDMicroButton:SetFrameStrata("MEDIUM")
    LFDMicroButton:SetFrameLevel(3)
    LFDMicroButton:SetNormalAtlas("hud-microbutton-LFG-Up", true)
    LFDMicroButton:SetPushedAtlas("hud-microbutton-LFG-Down", true)
    LFDMicroButton:SetDisabledAtlas("hud-microbutton-LFG-Disabled", true)
    LFDMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    LFDMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-LFG-Up")
    LFDMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-LFG-Down")
    LFDMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    LFDMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-LFG-Disabled")
    LFDMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    LFDMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    LFDMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    LFDMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    LFDMicroButton.FlashBorder:SetSize(34, 44)
    LFDMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] CollectionsMicroButton
    CollectionsMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    CollectionsMicroButton:SetPoint("BOTTOMLEFT", LFDMicroButton, "BOTTOMRIGHT", -2, 0)
    CollectionsMicroButton:SetFrameStrata("MEDIUM")
    CollectionsMicroButton:SetFrameLevel(3)
    CollectionsMicroButton:SetNormalAtlas("hud-microbutton-Mounts-Up", true)
    CollectionsMicroButton:SetPushedAtlas("hud-microbutton-Mounts-Down", true)
    CollectionsMicroButton:SetDisabledAtlas("hud-microbutton-Mounts-Disabled", true)
    CollectionsMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    CollectionsMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Up")
    CollectionsMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Down")
    CollectionsMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    CollectionsMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Disabled")
    CollectionsMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CollectionsMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CollectionsMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CollectionsMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    CollectionsMicroButton.FlashBorder:SetSize(34, 44)
    CollectionsMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] EJMicroButton
    EJMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    EJMicroButton:SetPoint("BOTTOMLEFT", CollectionsMicroButton, "BOTTOMRIGHT", -2, 0)
    EJMicroButton:SetFrameStrata("MEDIUM")
    EJMicroButton:SetFrameLevel(3)
    EJMicroButton:SetNormalAtlas("hud-microbutton-EJ-Up", true)
    EJMicroButton:SetPushedAtlas("hud-microbutton-EJ-Down", true)
    EJMicroButton:SetDisabledAtlas("hud-microbutton-EJ-Disabled", true)
    EJMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    EJMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-EJ-Up")
    EJMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-EJ-Down")
    EJMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    EJMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-EJ-Disabled")
    EJMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    EJMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    EJMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    EJMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    EJMicroButton.FlashBorder:SetSize(34, 44)
    EJMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] StoreMicroButton
    StoreMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    StoreMicroButton:SetPoint("BOTTOMLEFT", EJMicroButton, "BOTTOMRIGHT", -2, 0)
    StoreMicroButton:SetFrameStrata("MEDIUM")
    StoreMicroButton:SetFrameLevel(3)
    StoreMicroButton:SetNormalAtlas("hud-microbutton-BStore-Up", true)
    StoreMicroButton:SetPushedAtlas("hud-microbutton-BStore-Down", true)
    StoreMicroButton:SetDisabledAtlas("hud-microbutton-BStore-Disabled", true)
    StoreMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    StoreMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-BStore-Up")
    StoreMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-BStore-Down")
    StoreMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    StoreMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-BStore-Disabled")
    StoreMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    StoreMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    StoreMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    StoreMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    StoreMicroButton.FlashBorder:SetSize(34, 44)
    StoreMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    -- [MicroButtons] MainMenuMicroButton
    MainMenuMicroButton:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
    MainMenuMicroButton:SetPoint("BOTTOMLEFT", StoreMicroButton, "BOTTOMRIGHT", -3, 0)
    MainMenuMicroButton:SetFrameStrata("MEDIUM")
    MainMenuMicroButton:SetFrameLevel(3)
    MainMenuMicroButton:SetNormalAtlas("hud-microbutton-MainMenu-Up", true)
    MainMenuMicroButton:SetPushedAtlas("hud-microbutton-MainMenu-Down", true)
    MainMenuMicroButton:SetDisabledAtlas("hud-microbutton-MainMenu-Disabled", true)
    MainMenuMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
    MainMenuMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
    MainMenuMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
    MainMenuMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
    MainMenuMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
    MainMenuMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    MainMenuMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    MainMenuMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    MainMenuMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
    MainMenuMicroButton.FlashBorder:SetSize(34, 44)
    MainMenuMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
    
    if (MainMenuMicroButton.MainMenuBarPerformanceBar ~= nil) then
        MainMenuMicroButton.MainMenuBarPerformanceBar:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
        MainMenuMicroButton.MainMenuBarPerformanceBar:SetTexCoord(0/32, 32/32, 22/64, 64/64)
        MainMenuMicroButton.MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
    end
    
    hooksecurefunc("MicroButtonPulse", function(self, duration)
        if (RazerNaga.MicroButtonsGroup[self] ~= nil and self.FlashContent ~= nil) then
            UIFrameFlashStop(self.FlashContent)
        end
    end)
    
    -- [MicroButtons] MainMenuMicroButton -> HelpOpenWebTicketButton
    if (HelpOpenWebTicketButton ~= nil) then
        HelpOpenWebTicketButton:SetParent(MainMenuMicroButton)
        HelpOpenWebTicketButton:SetPoint("CENTER", HelpOpenWebTicketButton:GetParent(), "TOPRIGHT", -3, -4)
    end
    
    -- [MicroButtons] MainMenuMicroButton -> MainMenuBarDownload texture
    local CUI_MainMenuBarDownload = MainMenuMicroButton:CreateTexture("CUI_MainMenuBarDownload")
    CUI_MainMenuBarDownload:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 7)
    CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Yellow")
    CUI_MainMenuBarDownload:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
    CUI_MainMenuBarDownload:SetSize(28, 28)
    CUI_MainMenuBarDownload:SetDrawLayer("OVERLAY", 0)
    CUI_MainMenuBarDownload:SetAlpha(1)
    CUI_MainMenuBarDownload:Hide()
    
    MainMenuMicroButton:HookScript("OnUpdate", function(self, elapsed)
        if (self.updateInterval >= 1) then  -- PERFORMANCE_BAR_UPDATE_INTERVAL = 1
            local status = GetFileStreamingStatus()
            if ( status == 0 ) then
                status = (GetBackgroundLoadingStatus()~=0) and 1 or 0
            end
            self:SetSize(RazerNaga.mbWidth, RazerNaga.mbHeight)
            self:SetNormalAtlas("hud-microbutton-MainMenu-Up", true)
            self:SetPushedAtlas("hud-microbutton-MainMenu-Down", true)
            self:SetDisabledAtlas("hud-microbutton-MainMenu-Disabled", true)
            self:SetHighlightAtlas("hud-microbutton-highlight")
            self:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
            self:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
            if ( status == 0 ) then
                self:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
                self:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
                self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
                self:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                self:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                self:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                CUI_MainMenuBarDownload:Hide()
            else
                self:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
                self:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Down")
                self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
                self:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                self:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                self:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
                if ( status == 1 ) then
                    CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Green")
                elseif ( status == 2 ) then
                    CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Yellow")
                elseif ( status == 3 ) then
                    CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Red")
                end
                CUI_MainMenuBarDownload:Show()
            end
        end
    end)
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
                self.isOverrideUIShown = true
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
        self:SkinButton(b)

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

    local l, r, t, b = self.buttons[1]:GetHitRectInsets()
    local cols = min(self:NumColumns(), numButtons)
    local rows = ceil(numButtons / cols)

    local pW, pH = self:GetPadding()
    local spacing = self:GetSpacing()

    local isLeftToRight = self:GetLeftToRight()
    local isTopToBottom = self:GetTopToBottom()

    local firstButton = self.buttons[1]
    local w = firstButton:GetWidth() + spacing - (l + r)
    local h = firstButton:GetHeight() + spacing - (t + b)

    for i, button in pairs(self.activeButtons) do
        local col, row

        if isLeftToRight then
            col = (i - 1) % cols
        else
            col = (cols - 1) - (i - 1) % cols
        end

        if isTopToBottom then
            row = ceil(i / cols) - 1
        else
            row = rows - ceil(i / cols)
        end

        button:SetParent(self)
        button:ClearAllPoints()
        button:SetPoint('TOPLEFT', w * col + pW - l, -(h * row + pH) + r)
        button:Show()
    end

    -- Update bar size, if we're not in combat
    -- TODO: manage bar size via secure code
    if not InCombatLockdown() then
        local newWidth = max(w * cols - spacing + pW * 2 + l, 8)
        local newHeight = max(h * ceil(numButtons / cols) - spacing + pH * 2, 8)
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
        if i > 1 then
            button:ClearAllPoints()

            if i == 7 then
                button:SetPoint('TOPLEFT', self.overrideButtons[1], 'BOTTOMLEFT', 0, (t - b) + 1.5)
            else
                button:SetPoint('BOTTOMLEFT', self.overrideButtons[i - 1], 'BOTTOMRIGHT', (l - r) - 2.5, 0)
            end
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

--[[ Menu Code ]] --

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

--[[ module ]] --

local MenuBarController = RazerNaga:NewModule('MenuBar')

function MenuBarController:OnInitialize()
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
