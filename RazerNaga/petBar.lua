﻿--[[
    petBar.lua
        A RazerNaga pet bar
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

--[[ Pet Button ]]--

local PetActionButtonMixin = {}

function PetActionButtonMixin:CancelSpellDataLoadedCallback()
    local cancelFunc = self.spellDataLoadedCancelFunc

    if cancelFunc then
        cancelFunc()
        self.spellDataLoadedCancelFunc = nil
    end
end

-- this is mostly a straight port of PetActionBarMixin:Update()
function PetActionButtonMixin:Update()
    local petActionID = self:GetID()
    local petActionIcon = self.icon
    local name, texture, isToken, isActive, autoCastAllowed, autoCastEnabled, spellID = GetPetActionInfo(petActionID)
    
    if not isToken then
        self.tooltipName = name
    else
        self.tooltipName = _G[name]
    end

    self.isToken = isToken

    if spellID and spellID ~= self.spellID then
        self.spellID = spellID

        local spell = Spell:CreateFromSpellID(spellID)

        self.spellDataLoadedCancelFunc = spell:ContinueWithCancelOnSpellLoad(function()
            self.tooltipSubtext = spell:GetSpellSubtext()
        end)
    end

    if isActive then
        if IsPetAttackAction(petActionID) then
            self:StartFlash()
            self:GetCheckedTexture():SetAlpha(0.5)
        else
            self:StopFlash()
            self:GetCheckedTexture():SetAlpha(1)
        end
    else
        self:StopFlash()
    end

    self:SetChecked(isActive and true)

    self.AutoCastable:SetShown(autoCastAllowed and true)

    if autoCastEnabled then
        AutoCastShine_AutoCastStart(self.AutoCastShine)
    else
        AutoCastShine_AutoCastStop(self.AutoCastShine)
    end

    if texture then
        if GetPetActionSlotUsable(petActionID) then
            petActionIcon:SetVertexColor(1, 1, 1)
        else
            petActionIcon:SetVertexColor(0.4, 0.4, 0.4)
        end

        petActionIcon:SetTexture(isToken and _G[texture] or texture)
        petActionIcon:Show()

        self:ShowButton()
        if self.overlay then
            self.overlay:Show()
        end
    else
        petActionIcon:Hide()

        self:HideButton()
        if self.showgrid == 0 and not RazerNaga:ShowGrid() then
            if self.overlay then
                self.overlay:Hide()
            end
        end
    end

    SharedActionButton_RefreshSpellHighlight(self, PET_ACTION_HIGHLIGHT_MARKS[petActionID])
end

function PetActionButtonMixin:ShowButton()
    self:SetAlpha(1.0)
end

function PetActionButtonMixin:HideButton()
    if self.showgrid == 0 and not RazerNaga:ShowGrid() then
        self:SetAlpha(0.0)
    end
end

function PetActionButtonMixin:ShowGrid()
    self.showgrid = self.showgrid + 1
    self:SetAlpha(1.0)
end

function PetActionButtonMixin:HideGrid()
    if self.showgrid > 0 then self.showgrid = self.showgrid - 1 end
    if self.showgrid == 0  and not GetPetActionInfo(self:GetID()) and not RazerNaga:ShowGrid() then
        self:SetAlpha(0.0)
    end
end

function PetActionButtonMixin:UpdateCooldown()
    local cooldown = self.cooldown
    local start, duration, enable = GetPetActionCooldown(self:GetID())

    if enable and enable ~= 0 and start > 0 and duration > 0 then
        cooldown:SetCooldown(start, duration)
    else
        cooldown:Clear()
    end

    if GameTooltip and GameTooltip:IsOwned(self) then
        self:OnEnter()
    end
end

-- if we have button facade support, then skin the button that way
-- otherwise, apply the RazerNaga style to the button to make it pretty
function PetActionButtonMixin:Skin()
    if not RazerNaga:Masque('Pet Bar', self) then
        self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
        self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
        self.NormalTexture:SetSize(54, 54)
        self.NormalTexture:ClearAllPoints()
        self.NormalTexture:SetPoint("CENTER", 0, -1)
        self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
        self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
        self.PushedTexture:SetSize(30, 30)
        self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
        self.HighlightTexture:SetSize(30, 30)
        self.HighlightTexture:SetBlendMode("ADD")
        self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
        self.CheckedTexture:ClearAllPoints()
        self.CheckedTexture:SetPoint("TOPLEFT", self.icon, "TOPLEFT")
        self.CheckedTexture:SetPoint("BOTTOMRIGHT", self.icon, "BOTTOMRIGHT")
        self.CheckedTexture:SetBlendMode("ADD")
        self.HotKey:SetFont(self.HotKey:GetFont(), 13, "OUTLINE")
        self.HotKey:SetPoint("TOPRIGHT", 0, -2)
    end
end

local function createPetActionButton(name, id)
    local button = CreateFrame('CheckButton', name, nil, 'PetActionButtonTemplate')

    button.showgrid = 0

    Mixin(button, PetActionButtonMixin)

    -- get the stock button
    local petActionButton = _G['PetActionButton' .. id]

    -- copy its ID
    button:SetID(petActionButton:GetID())

    -- copy its pushed state
    hooksecurefunc(petActionButton, "SetButtonState", function(_, ...)
        button:SetButtonState(...)
    end)

    -- setup bindings
    button.commandName = ("BONUSACTIONBUTTON%d"):format(id)
    RazerNaga.BindableButton:AddQuickBindingSupport(button)

    -- add support for mousewheel bindings
    button:EnableMouseWheel(true)

    -- unregister spell data loaded callback
    button:HookScript("OnHide", PetActionButtonMixin.CancelSpellDataLoadedCallback)
    
    -- enable masque support
    button:Skin()

    return button
end

local function getOrCreatePetActionButton(id)
    local name = ('%sPetActionButton%d'):format('RazerNaga', id)
    local button = _G[name]

    if not button then
        button = createPetActionButton(name, id)
    end

    return button
end

--[[ Pet Bar ]]--

local PetBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

function PetBar:New()
    local f = self.proto.New(self, 'pet')
    f:SetTooltipText(L.PetBarHelp)

    return f
end

function PetBar:IsOverrideBar()
    return RazerNaga.db.profile.possessBar == self.id
end

function PetBar:UpdateOverrideBar()
end

function PetBar:GetShowStates()
    if UnitClassBase("player") == "WARLOCK" then
        local eyeOfKilrogg = GetSpellInfo(126)
        return ('[channeling:%s]hide;[@pet,exists,nopossessbar]show;hide'):format(eyeOfKilrogg)
    end

    return '[@pet,exists,nopossessbar]show;hide'
end

function PetBar:GetDefaults()
    return {
        point = 'CENTER',
        x = 0,
        y = -32,
        spacing = 6
    }
end

function PetBar:NumButtons()
    return NUM_PET_ACTION_SLOTS
end

function PetBar:AcquireButton(index)
    return getOrCreatePetActionButton(index)
end

function PetBar:OnAttachButton(button)
    button:UpdateHotkeys()

    RazerNaga:GetModule('Tooltips'):Register(button)
end

function PetBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

-- keybound events
function PetBar:KEYBOUND_ENABLED()
    self:ForButtons("ShowButton")
end

function PetBar:KEYBOUND_DISABLED()
    self:ForButtons("HideGrid")
end

--[[ controller good times ]]--

local PetBarModule = RazerNaga:NewModule('PetBar', 'AceEvent-3.0')

function PetBarModule:Load()
    if not self.loaded then
        self:OnFirstLoad()
        self.loaded = true
    end

    self.bar = PetBar:New()
    self:UpdateActions()
    self:RegisterEvent("PET_BAR_UPDATE_COOLDOWN")
    self:RegisterEvent("PET_BAR_SHOWGRID")
    self:RegisterEvent("PET_BAR_HIDEGRID")
end

function PetBarModule:Unload()
    self:UnregisterAllEvents()

    if self.bar then
        self.bar:Free()
        self.bar = nil
    end
end

function PetBarModule:OnFirstLoad()
    -- an extremly lazy method of updating the pet bar when the
    -- normal pet bar would be updated
    hooksecurefunc(PetActionBar, "Update", RazerNaga:Defer(function() self:UpdateActions() end, 0.01))
end

function PetBarModule:PET_BAR_UPDATE_COOLDOWN()
    self:UpdateCooldowns()
end

function PetBarModule:PET_BAR_SHOWGRID()
    if not (self.bar and PetHasActionBar() and UnitIsVisible("pet")) then return end

    self.bar:ForButtons("ShowGrid")
end

function PetBarModule:PET_BAR_HIDEGRID()
    if not (self.bar and PetHasActionBar() and UnitIsVisible("pet")) then return end

    self.bar:ForButtons("HideGrid")
end

function PetBarModule:UpdateActions()
    if not (self.bar and PetHasActionBar() and UnitIsVisible("pet")) then return end

    self.bar:ForButtons("Update")
end

function PetBarModule:UpdateCooldowns()
    if not (self.bar and PetHasActionBar() and UnitIsVisible("pet")) then return end

    self.bar:ForButtons("UpdateCooldown")
end