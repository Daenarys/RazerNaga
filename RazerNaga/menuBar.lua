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

--[[ Menu Bar ]] --

function MenuBar:SkinButton(button)
    if button.skinned then return end

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
        local prefix = "Interface\\Buttons\\UI-MicroButton-"
        self:SetNormalTexture(prefix..name.."-Up")
        self:SetPushedTexture(prefix..name.."-Down")
        self:SetDisabledTexture(prefix..name.."-Disabled")
        self:SetHitRectInsets(0,0,18,0)
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
            self.FlashBorder:SetSize(64, 64)
            self.FlashBorder:SetTexture("Interface\\Buttons\\Micro-Highlight")
            self.FlashBorder:ClearAllPoints()
            self.FlashBorder:SetPoint("TOPLEFT", -2, -18)
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
        self:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight")
    end)

    CharacterMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
    CharacterMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
    CharacterMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight")

    if not MicroButtonPortrait then
        local portrait = CharacterMicroButton:CreateTexture("MicroButtonPortrait", "OVERLAY")
        portrait:SetSize(18, 25)
        portrait:SetPoint("TOP", 0, -28)
        portrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
    end

    CharacterMicroButton:HookScript("OnEvent", function(self, event, ...)
        if ( event == "UNIT_PORTRAIT_UPDATE" ) then
            local unit = ...
            if ( unit == "player" ) then
                SetPortraitTexture(MicroButtonPortrait, "player")
            end
        elseif ( event == "PORTRAITS_UPDATED" ) then
            SetPortraitTexture(MicroButtonPortrait, "player")
        elseif ( event == "PLAYER_ENTERING_WORLD" ) then
            SetPortraitTexture(MicroButtonPortrait, "player")
        end
    end)

    function CharacterMicroButton_SetPushed()
        MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
        MicroButtonPortrait:SetAlpha(0.5)
    end

    function CharacterMicroButton_SetNormal()
        MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
        MicroButtonPortrait:SetAlpha(1.0)
    end

        CharacterMicroButton:HookScript("OnMouseDown", function(self)
        if ( not KeybindFrames_InQuickKeybindMode() ) then
            MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
            MicroButtonPortrait:SetAlpha(0.5)
        end
    end)

    CharacterMicroButton:HookScript("OnMouseUp", function()
        if ( not KeybindFrames_InQuickKeybindMode() ) then
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
        local status = GetFileStreamingStatus()
        if(status == 0) then
            MainMenuBarDownload:Hide()
            self:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
            self:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
            self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
        else
            self:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
            self:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Down")
            self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
        if (status == 1) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Green")
        elseif (status == 2) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Yellow")
        elseif (status == 3) then
            MainMenuBarDownload:SetTexture("Interface\\BUTTONS\\UI-MicroStream-Red")
        end
            MainMenuBarDownload:Show()
        end
    end)

    if not GuildMicroButtonTabard then
        local GuildMicroButtonTabard = CreateFrame("Frame", "GuildMicroButtonTabard", GuildMicroButton)
        GuildMicroButtonTabard:SetSize(28, 58)
        GuildMicroButtonTabard:SetPoint("TOPLEFT")
        GuildMicroButtonTabard:Hide()
    end

    if not GuildMicroButtonTabardBackground then
        GuildMicroButtonTabard.background = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardBackground", "ARTWORK")
        GuildMicroButtonTabardBackground:SetSize(30, 60)
        GuildMicroButtonTabardBackground:SetTexture("Interface\\Buttons\\UI-MicroButton-Guild-Banner")
        GuildMicroButtonTabardBackground:SetPoint("CENTER", 0, 0)
    end

    if not GuildMicroButtonTabardEmblem then
        GuildMicroButtonTabard.emblem = GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardEmblem", "OVERLAY")
        GuildMicroButtonTabardEmblem:SetSize(16, 16)
        GuildMicroButtonTabardEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
        GuildMicroButtonTabardEmblem:SetPoint("CENTER", 0, -9)
    end

    GuildMicroButton:HookScript("OnMouseDown", function(self)
        GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -1)
        GuildMicroButtonTabard:SetAlpha(0.5)
    end)

    GuildMicroButton:HookScript("OnMouseUp", function(self)
        GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0)
        GuildMicroButtonTabard:SetAlpha(1.0)
    end)

    hooksecurefunc(GuildMicroButton, "UpdateTabard", function()
        local tabard = GuildMicroButtonTabard
        if ( not tabard.needsUpdate) then
            return
        end
        -- switch textures if the guild has a custom tabard
        local emblemFilename = select(10, GetGuildLogoInfo())
        if ( emblemFilename ) then
            if ( not tabard:IsShown() ) then
                local button = GuildMicroButton
                button:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
                button:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
                -- no need to change disabled texture, should always be available if you're in a guild
                tabard:Show()
            end
            SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background)
        else
            if ( tabard:IsShown() ) then
                local button = GuildMicroButton
                button:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up")
                button:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down")
                button:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled")
                tabard:Hide()
            end
        end
        tabard.needsUpdate = nil
    end)

    GuildMicroButton:HookScript("OnEvent", function(self, event, ...)
        if ( event == "PLAYER_ENTERING_WORLD" or event == "PLAYER_GUILD_UPDATE" or event == "NEUTRAL_FACTION_SELECT_RESULT" ) then
            GuildMicroButtonTabard.needsUpdate = true
        end
    end)

    hooksecurefunc("UpdateMicroButtons", function()
        if AchievementMicroButton:IsEnabled() then
            AchievementMicroButton.tooltipText = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT")
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
        GuildMicroButton:GetNormalTexture():SetVertexColor(1, 1, 1)
        GuildMicroButton:GetPushedTexture():SetVertexColor(1, 1, 1)
        GuildMicroButton:GetHighlightTexture():SetVertexColor(1, 1, 1)
        if ( CommunitiesFrame and CommunitiesFrame:IsShown() ) or ( GuildFrame and GuildFrame:IsShown() ) then
            GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -1)
            GuildMicroButtonTabard:SetAlpha(0.70)
        else
            GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0)
            GuildMicroButtonTabard:SetAlpha(1)
        end
    end)

    hooksecurefunc("LoadMicroButtonTextures", function(self)
        if not self == _G.GuildMicroButton then return end

        if _G.IsInGuild() then
            _G.GuildMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
            _G.GuildMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
        else
            _G.GuildMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up")
            _G.GuildMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down")
            _G.GuildMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled")
        end
    end)

    local function EnableMicroButtons()
        local factionGroup = UnitFactionGroup("player")

        if GameMenuFrame and GameMenuFrame:IsShown() then
            CharacterMicroButton:Enable()
            SpellbookMicroButton:Enable()
            if not C_SpecializationInfo.CanPlayerUseTalentSpecUI() then
                TalentMicroButton:Disable()
            else
                TalentMicroButton:Enable()
            end
            QuestLogMicroButton:Enable()
            if ( IsCommunitiesUIDisabledByTrialAccount() or factionGroup == "Neutral" or Kiosk.IsEnabled() ) then
                GuildMicroButton:Disable()
            elseif ( C_Club.IsEnabled() and not BNConnected() ) then
                GuildMicroButton:Disable()
            else
                GuildMicroButton:Enable()
            end
            if not LFDMicroButton:IsActive() then
                LFDMicroButton:Disable()
            else
                LFDMicroButton:Enable()
            end
            AchievementMicroButton:Enable()
            if ( not AdventureGuideUtil.IsAvailable() ) then
                EJMicroButton:Disable()
            else
                EJMicroButton:Enable()
            end
            CollectionsMicroButton:Enable()
            MainMenuMicroButton:Enable()
        end
    end

    -- don't disable them when blizz wants too
    hooksecurefunc(button, 'UpdateMicroButton', EnableMicroButtons)

    button.skinned = true
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
        button:SetParent(self.header)
        button:SetSize(28, 58)
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
    MenuBar.super.LoadSettings(self, ...)

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
        
        button:SetParent(self.header)
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
	wipe(self.overrideButtons)

    for _, buttonName in ipairs(MICRO_BUTTONS) do
        tinsert(self.overrideButtons, _G[buttonName])
    end

    local l, r, t, b = self.overrideButtons[1]:GetHitRectInsets()

    for i, button in ipairs(self.overrideButtons) do
    	button:SetParent(PetBattleFrame.BottomFrame.MicroButtonFrame)
    	button:ClearAllPoints()
        if i == 1 then
        	button:SetPoint('BOTTOMLEFT', -9, button:GetHeight())
        elseif i == 7 then
            button:SetPoint('TOPLEFT', self.overrideButtons[1], 'BOTTOMLEFT', 0, (t - b) - 3)
        else
        	button:SetPoint('BOTTOMLEFT', self.overrideButtons[i - 1], 'BOTTOMRIGHT', (l - r) + 8, 0)
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
	local perf = MainMenuMicroButton and MainMenuMicroButton.MainMenuBarPerformanceBar
	if perf then
		perf:SetSize(28, 58)
		perf:ClearAllPoints()
		perf:SetPoint('CENTER', 0, 0)
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