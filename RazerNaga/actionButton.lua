--------------------------------------------------------------------------------
-- ActionButtonMixin
-- Additional methods we define on action buttons
--------------------------------------------------------------------------------
local RazerNaga = _G[...]
local ActionButtonMixin = {}

local function GetActionButtonCommand(id)
    -- 0
    if id <= 0 then
        return
    -- 1
    elseif id <= 12 then
        return "ACTIONBUTTON" .. id
    -- 2
    elseif id <= 24 then
        return
    -- 3
    elseif id <= 36 then
        return "MULTIACTIONBAR3BUTTON" .. (id - 24)
    -- 4
    elseif id <= 48 then
        return "MULTIACTIONBAR4BUTTON" .. (id - 36)
    -- 5
    elseif id <= 60 then
        return "MULTIACTIONBAR2BUTTON" .. (id - 48)
    -- 6
    elseif id <= 72 then
        return "MULTIACTIONBAR1BUTTON" .. (id - 60)
    -- 7-10
    elseif id <= 120 then
        return
    end
end

local function skinActionButton(self)
    self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
    self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
    self.NormalTexture:ClearAllPoints()
    self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
    self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)
    self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
    self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
    self.PushedTexture:ClearAllPoints()
    self.PushedTexture:SetAllPoints()
    self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
    self.HighlightTexture:ClearAllPoints()
    self.HighlightTexture:SetAllPoints()
    self.HighlightTexture:SetBlendMode("ADD")
    self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
    self.CheckedTexture:ClearAllPoints()
    self.CheckedTexture:SetAllPoints()
    self.CheckedTexture:SetBlendMode("ADD")
    self.NewActionTexture:SetSize(44, 44)
    self.NewActionTexture:SetAtlas("bags-newitem")
    self.NewActionTexture:ClearAllPoints()
    self.NewActionTexture:SetPoint("CENTER")
    self.NewActionTexture:SetBlendMode("ADD")
    self.SpellHighlightTexture:SetSize(44, 44)
    self.SpellHighlightTexture:SetAtlas("bags-newitem")
    self.SpellHighlightTexture:ClearAllPoints()
    self.SpellHighlightTexture:SetPoint("CENTER")
    self.SpellHighlightTexture:SetBlendMode("ADD")
    self.Border:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
    self.Border:SetSize(62, 62)
    self.Border:ClearAllPoints()
    self.Border:SetPoint("CENTER")
    self.Border:SetBlendMode("ADD")
    self.cooldown:ClearAllPoints()
    self.cooldown:SetAllPoints()
    self.chargeCooldown:ClearAllPoints()
    self.chargeCooldown:SetAllPoints()
    self.lossOfControlCooldown:ClearAllPoints()
    self.lossOfControlCooldown:SetAllPoints()
    self.Flash:SetTexture([[Interface\Buttons\UI-QuickslotRed]])
    self.Flash:ClearAllPoints()
    self.Flash:SetAllPoints()
    self.Count:ClearAllPoints()
    self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
    self.Count:SetDrawLayer("ARTWORK", 2)
    if self.IconMask then
        self.IconMask:Hide()
    end
    if self.SlotBackground then
        self.SlotBackground:Hide()
    end
end

function ActionButtonMixin:OnCreate(id)
    -- initialize secure state
    self:SetAttributeNoHandler("action", 0)
    self:SetAttributeNoHandler("commandName", GetActionButtonCommand(id) or ("CLICK %s:HOTKEY"):format(self:GetName()))
    self:SetAttributeNoHandler("showgrid", 0)
    self:SetAttributeNoHandler("useparent-checkfocuscast", true)
    self:SetAttributeNoHandler("useparent-checkmouseovercast", true)
    self:SetAttributeNoHandler("useparent-checkselfcast", true)

    -- register for clicks on all buttons, and enable mousewheel bindings
    self:EnableMouseWheel()
    self:RegisterForClicks("AnyUp", "AnyDown")

    -- secure handlers
    self:SetAttributeNoHandler('_childupdate-offset', [[
        local offset = message or 0
        local id = self:GetAttribute('index') + offset

        if self:GetAttribute('action') ~= id then
            self:SetAttribute('action', id)
            self:RunAttribute("UpdateShown")
        end
    ]])

    self:SetAttributeNoHandler("UpdateShown", [[
        local show = (HasAction(self:GetAttribute("action")))
            and not self:GetAttribute("statehidden")

        if show then
            self:SetAlpha(1)
        else
            self:SetAlpha(0)
        end
    ]])

    -- apply hooks for quick binding
    RazerNaga.BindableButton:AddQuickBindingSupport(self)

    -- apply custom flyout
    if RazerNaga.SpellFlyout then
        RazerNaga.SpellFlyout:Register(self)
    end

    -- use pre 10.x button size
    self:SetSize(36, 36)

    -- apply button skin
    skinActionButton(self)

    -- enable cooldown bling
    self.cooldown:SetDrawBling(true)
end

function ActionButtonMixin:UpdateOverrideBindings()
    if InCombatLockdown() then return end

    self.bind:SetOverrideBindings(GetBindingKey(self:GetAttribute("commandName")))
end

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

function ActionButtonMixin:SetFlyoutDirection(direction)
    if InCombatLockdown() then return end

    self:SetAttribute("flyoutDirection", direction)
    self:UpdateFlyout()
end

function ActionButtonMixin:SetShowBindingText(show)
    self.HotKey:SetAlpha(show and 1 or 0)
end

function ActionButtonMixin:SetShowMacroText(show)
    self.Name:SetShown(show and true)
end

-- exports
RazerNaga.ActionButtonMixin = ActionButtonMixin

--------------------------------------------------------------------------------
-- Action Button 
-- A pool of action buttons
--------------------------------------------------------------------------------
local ActionButton = CreateFrame('Frame', nil, nil, 'SecureHandlerAttributeTemplate')

-- constants
local ACTION_BUTTON_NAME_TEMPLATE = "RazerNaga" .. "ActionButton%d"

ActionButton.buttons = {}

ActionButton:Execute([[
    ActionButton = table.new()
]])

--------------------------------------------------------------------------------
-- Action Button Construction
--------------------------------------------------------------------------------

local function GetActionButtonName(id)
    if id <= 0 then
        return
    else
        return ACTION_BUTTON_NAME_TEMPLATE:format(id)
    end
end

local function SafeMixin(button, trait)
    for k, v in pairs(trait) do
        if rawget(button, k) ~= nil then
            error(("%s[%q] has alrady been set"):format(button:GetName(), k), 2)
        end

        button[k] = v
    end
end

function ActionButton:GetOrCreateActionButton(id, parent)
    local name = GetActionButtonName(id)
    if name == nil then
        error(("Invalid Action ID %q"):format(id))
    end

    local button = _G[name]
    local created = false

    -- button not found, create a new one
    if button == nil then
        button = CreateFrame("CheckButton", name, parent, "ActionBarButtonTemplate")

        -- add custom methods
        SafeMixin(button, RazerNaga.ActionButtonMixin)

        -- initialize the button
        button:OnCreate(id)
        created = true
    -- button found, but not yet registered, reuse
    elseif self.buttons[button] == nil then
        -- add custom methods
        SafeMixin(button, RazerNaga.ActionButtonMixin)

        -- reset the id of a button to zero to avoid triggering the paging
        -- logic of the standard UI
        button:SetParent(parent)
        button:SetID(0)

        -- drop the reference to the bar's original parent, which would otherwise
        -- call thing we do not want
        button.Bar = nil

        -- initialize the button
        button:OnCreate(id)
        created = true
    end

    if created then
        -- add secure handlers
        self:AddCastOnKeyPressSupport(button)

        -- register the button with the controller
        self:SetFrameRef("add", button)

        self:Execute([[
            local b = self:GetFrameRef("add")
            ActionButton[b] = b:GetAttribute("action") or 0
        ]])

        self.buttons[button] = 0
    end

    return button
end

-- update the pushed state of our parent button when pressing and releasing
-- the button's hotkey
local function bindButton_PreClick(self, _, down)
    local owner = self:GetParent()

    if down then
        if owner:GetButtonState() == "NORMAL" then
            owner:SetButtonState("PUSHED")
        end
    else
        if owner:GetButtonState() == "PUSHED" then
            owner:SetButtonState("NORMAL")
        end
    end
end

local function bindButton_SetOverrideBindings(self, ...)
    ClearOverrideBindings(self)

    local name = self:GetName()
    for i = 1, select("#", ...) do
        SetOverrideBindingClick(self, false, select(i, ...), name, "HOTKEY")
    end
end

function ActionButton:AddCastOnKeyPressSupport(button)
    local bind = CreateFrame("Button", "$parentHotkey", button, "SecureActionButtonTemplate")

    bind:SetAttributeNoHandler("type", "action")
    bind:SetAttributeNoHandler("typerelease", "actionrelease")
    bind:SetAttributeNoHandler("useparent-action", true)
    bind:SetAttributeNoHandler("useparent-checkfocuscast", true)
    bind:SetAttributeNoHandler("useparent-checkmouseovercast", true)
    bind:SetAttributeNoHandler("useparent-checkselfcast", true)
    bind:SetAttributeNoHandler("useparent-flyoutDirection", true)
    bind:SetAttributeNoHandler("useparent-pressAndHoldAction", true)
    bind:SetAttributeNoHandler("useparent-unit", true)
    SecureHandlerSetFrameRef(bind, "owner", button)

    bind:EnableMouseWheel()
    bind:RegisterForClicks("AnyUp", "AnyDown")

    bind:SetScript("PreClick", bindButton_PreClick)

    bind.SetOverrideBindings = bindButton_SetOverrideBindings

    if RazerNaga.SpellFlyout then
        RazerNaga.SpellFlyout:Register(bind)
    end

    -- translate HOTKEY button "clicks" into LeftButton
    self:WrapScript(bind, "OnClick", [[
        if button == "HOTKEY" then
            return "LeftButton"
        end
    ]])

    button.bind = bind
    button:UpdateOverrideBindings()
end

-- restore old animations
if (ActionBarActionEventsFrame) then
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_TARGET")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_CLEAR")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_FAILED")
end

local function OverlayGlowAnimOutFinished(animGroup)
    local overlay = animGroup:GetParent()
    local frame = overlay:GetParent()
    overlay:Hide()
    frame.ActionButtonOverlay = nil
end

local function OverlayGlow_OnHide(self)
    if self.animOut:IsPlaying() then
        self.animOut:Stop()
        OverlayGlowAnimOutFinished(self.animOut)
    end
end

local function OverlayGlow_OnUpdate(self, elapsed)
    AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, 0.01)
    local cooldown = self:GetParent().cooldown
    local duration = cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration()
    if((not issecretvalue or not issecretvalue(duration)) and duration and duration > 3000) then
        self:SetAlpha(0.5)
    else
        self:SetAlpha(1.0)
    end
end

local function CreateScaleAnim(group, target, order, duration, x, y, delay)
    local scale = group:CreateAnimation("Scale")
    scale:SetTarget(target)
    scale:SetOrder(order)
    scale:SetDuration(duration)
    scale:SetScale(x, y)

    if delay then
        scale:SetStartDelay(delay)
    end
end

local function CreateAlphaAnim(group, target, order, duration, fromAlpha, toAlpha, delay)
    local alpha = group:CreateAnimation("Alpha")
    alpha:SetTarget(target)
    alpha:SetOrder(order)
    alpha:SetDuration(duration)
    alpha:SetFromAlpha(fromAlpha)
    alpha:SetToAlpha(toAlpha)

    if delay then
        alpha:SetStartDelay(delay)
    end
end

local function AnimIn_OnPlay(group)
    local frame = group:GetParent()
    local frameWidth, frameHeight = frame:GetSize()
    frame.spark:SetSize(frameWidth, frameHeight)
    frame.spark:SetAlpha(0.3)
    frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
    frame.innerGlow:SetAlpha(1.0)
    frame.innerGlowOver:SetAlpha(1.0)
    frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
    frame.outerGlow:SetAlpha(1.0)
    frame.outerGlowOver:SetAlpha(1.0)
    frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
    frame.ants:SetAlpha(0)
    frame:Show()
end

local function AnimIn_OnFinished(group)
    local frame = group:GetParent()
    local frameWidth, frameHeight = frame:GetSize()
    frame.spark:SetAlpha(0)
    frame.innerGlow:SetAlpha(0)
    frame.innerGlow:SetSize(frameWidth, frameHeight)
    frame.innerGlowOver:SetAlpha(0.0)
    frame.outerGlow:SetSize(frameWidth, frameHeight)
    frame.outerGlowOver:SetAlpha(0.0)
    frame.outerGlowOver:SetSize(frameWidth, frameHeight)
    frame.ants:SetAlpha(1.0)
end

hooksecurefunc(ActionButtonSpellAlertManager, "ShowAlert", function(self, button)
    if button.SpellActivationAlert then
        button.SpellActivationAlert:SetAlpha(0)
    end

    if button.ActionButtonOverlay then
        return
    end

    local name = button:GetName()
    local overlay = CreateFrame("Frame", name, UIParent)

    -- spark
    overlay.spark = overlay:CreateTexture(name .. "Spark", "BACKGROUND")
    overlay.spark:SetPoint("CENTER")
    overlay.spark:SetAlpha(0)
    overlay.spark:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    overlay.spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)

    -- inner glow
    overlay.innerGlow = overlay:CreateTexture(name .. "InnerGlow", "ARTWORK")
    overlay.innerGlow:SetPoint("CENTER")
    overlay.innerGlow:SetAlpha(0)
    overlay.innerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    overlay.innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

    -- inner glow over
    overlay.innerGlowOver = overlay:CreateTexture(name .. "InnerGlowOver", "ARTWORK")
    overlay.innerGlowOver:SetPoint("TOPLEFT", overlay.innerGlow, "TOPLEFT")
    overlay.innerGlowOver:SetPoint("BOTTOMRIGHT", overlay.innerGlow, "BOTTOMRIGHT")
    overlay.innerGlowOver:SetAlpha(0)
    overlay.innerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    overlay.innerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

    -- outer glow
    overlay.outerGlow = overlay:CreateTexture(name .. "OuterGlow", "ARTWORK")
    overlay.outerGlow:SetPoint("CENTER")
    overlay.outerGlow:SetAlpha(0)
    overlay.outerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    overlay.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

    -- outer glow over
    overlay.outerGlowOver = overlay:CreateTexture(name .. "OuterGlowOver", "ARTWORK")
    overlay.outerGlowOver:SetPoint("TOPLEFT", overlay.outerGlow, "TOPLEFT")
    overlay.outerGlowOver:SetPoint("BOTTOMRIGHT", overlay.outerGlow, "BOTTOMRIGHT")
    overlay.outerGlowOver:SetAlpha(0)
    overlay.outerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    overlay.outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

    -- ants
    overlay.ants = overlay:CreateTexture(name .. "Ants", "OVERLAY")
    overlay.ants:SetPoint("CENTER")
    overlay.ants:SetAlpha(0)
    overlay.ants:SetTexture([[Interface\SpellActivationOverlay\IconAlertAnts]])

    -- setup antimations
    overlay.animIn = overlay:CreateAnimationGroup()
    CreateScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 1.5, 1.5)
    CreateAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 0, 1)
    CreateScaleAnim(overlay.animIn, overlay.innerGlow,      1, 0.3, 2, 2)
    CreateScaleAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 2, 2)
    CreateAlphaAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 1, 0)
    CreateScaleAnim(overlay.animIn, overlay.outerGlow,      1, 0.3, 0.5, 0.5)
    CreateScaleAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 0.5, 0.5)
    CreateAlphaAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 1, 0)
    CreateScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 2/3, 2/3, 0.2)
    CreateAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 1, 0, 0.2)
    CreateAlphaAnim(overlay.animIn, overlay.innerGlow,      1, 0.2, 1, 0, 0.3)
    CreateAlphaAnim(overlay.animIn, overlay.ants,           1, 0.2, 0, 1, 0.3)
    overlay.animIn:SetScript("OnPlay", AnimIn_OnPlay)
    overlay.animIn:SetScript("OnFinished", AnimIn_OnFinished)

    overlay.animOut = overlay:CreateAnimationGroup()
    CreateAlphaAnim(overlay.animOut, overlay.outerGlowOver, 1, 0.2, 0, 1)
    CreateAlphaAnim(overlay.animOut, overlay.ants,          1, 0.2, 1, 0)
    CreateAlphaAnim(overlay.animOut, overlay.outerGlowOver, 2, 0.2, 1, 0)
    CreateAlphaAnim(overlay.animOut, overlay.outerGlow,     2, 0.2, 1, 0)
    overlay.animOut:SetScript("OnFinished", OverlayGlowAnimOutFinished)

    -- scripts
    overlay:SetScript("OnUpdate", OverlayGlow_OnUpdate)
    overlay:SetScript("OnHide", OverlayGlow_OnHide)

    local frameWidth, frameHeight = button:GetSize()
    overlay:SetParent(button)
    overlay:SetFrameLevel(button:GetFrameLevel() + 5)
    overlay:ClearAllPoints()
    overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4)
    overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2)
    overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2)
    overlay.animIn:Play()
    button.ActionButtonOverlay = overlay

    if button.ActionButtonOverlay then
        if button.ActionButtonOverlay.animOut:IsPlaying() then
            button.ActionButtonOverlay.animOut:Stop()
            button.ActionButtonOverlay.animIn:Play()
        end
    end
end)

hooksecurefunc(ActionButtonSpellAlertManager, "HideAlert", function(self, button)
    if button.ActionButtonOverlay then
        if button.ActionButtonOverlay.animIn:IsPlaying() then
            button.ActionButtonOverlay.animIn:Stop()
        end
        if button:IsVisible() then
            button.ActionButtonOverlay.animOut:Play()
        else
            OverlayGlowAnimOutFinished(button.ActionButtonOverlay.animOut)
        end
    end
end)

hooksecurefunc("CooldownFrame_Set", function(self)
    if not self:IsForbidden() then
        self:SetEdgeTexture("Interface\\Cooldown\\edge")
    end
end)

-- exports
RazerNaga.ActionButton = ActionButton