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
    self.NormalTexture:ClearAllPoints()
    self.NormalTexture:SetPoint("TOPLEFT", -3, 3)
    self.NormalTexture:SetPoint("BOTTOMRIGHT", 7, -7)
    self.PushedTexture:ClearAllPoints()
    self.PushedTexture:SetPoint("TOPLEFT", -2, 2)
    self.PushedTexture:SetPoint("BOTTOMRIGHT", 6, -6)
    self.HighlightTexture:ClearAllPoints()
    self.HighlightTexture:SetPoint("TOPLEFT", -3, 3)
    self.HighlightTexture:SetPoint("BOTTOMRIGHT", 3, -2)
    self.CheckedTexture:ClearAllPoints()
    self.CheckedTexture:SetPoint("TOPLEFT", -3, 3)
    self.CheckedTexture:SetPoint("BOTTOMRIGHT", 3, -2)
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
    self.Border:ClearAllPoints()
    self.Border:SetPoint("TOPLEFT", -3, 3)
    self.Border:SetPoint("BOTTOMRIGHT", 2, -2)
    self.cooldown:ClearAllPoints()
    self.cooldown:SetAllPoints()
    self.Count:ClearAllPoints()
    self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
    self.Flash:ClearAllPoints()
    self.Flash:SetAllPoints()
    self.FlyoutBorderShadow:SetSize(48, 48)
    self.HotKey:ClearAllPoints()
    self.HotKey:SetPoint("TOPRIGHT", -1, -3)
    self.SlotBackground:ClearAllPoints()
    self.SlotBackground:SetPoint("TOPLEFT", -2, 2)
    self.SlotBackground:SetPoint("BOTTOMRIGHT", 6, -6)
end

function ActionButtonMixin:OnCreate(id)
    -- initialize secure state
    self:SetAttributeNoHandler("action", 0)
    self:SetAttributeNoHandler("commandName", GetActionButtonCommand(id) or self:GetName())
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
    RazerNaga.SpellFlyout:Register(self)

    -- use pre 10.x button size
    self:SetSize(36, 36)

    -- apply button skin
    skinActionButton(self)
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

    RazerNaga.SpellFlyout:Register(bind)

    -- translate HOTKEY button "clicks" into LeftButton
    self:WrapScript(bind, "OnClick", [[
        if button == "HOTKEY" then
            return "LeftButton"
        end
    ]])

    button.bind = bind
    button:UpdateOverrideBindings()
end

-- disable new animations
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

hooksecurefunc("StartChargeCooldown", function(parent)
    parent.chargeCooldown:SetAllPoints(parent)
end)

-- exports
RazerNaga.ActionButton = ActionButton