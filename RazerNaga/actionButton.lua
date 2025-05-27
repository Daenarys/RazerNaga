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
    self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
    self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)
    self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
    local floatingBG = _G[self:GetName() .. 'FloatingBG']
    if floatingBG then
        floatingBG:Hide()
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
        end
    ]])

    -- apply hooks for quick binding
    RazerNaga.BindableButton:AddQuickBindingSupport(self)

    -- apply button skin
    skinActionButton(self)
end

--------------------------------------------------------------------------------
-- Configuration
--------------------------------------------------------------------------------

function ActionButtonMixin:SetFlyoutDirection(direction)
    if InCombatLockdown() then return end

    self:SetAttribute("flyoutDirection", direction)
    ActionButton_UpdateFlyout(self)
end

function ActionButtonMixin:SetShowBindingText(show)
    self.HotKey:SetAlpha(show and 1 or 0)
end

function ActionButtonMixin:SetShowMacroText(show)
    self.Name:SetShown(show and true)
end

function ActionButtonMixin:ShowGrid(reason)
    if InCombatLockdown() then return end

    self:SetAttribute("showgrid", bit.bor(self:GetAttribute("showgrid"), reason))

    if self:GetAttribute("showgrid") > 0 and not self:GetAttribute("statehidden") then
        self:Show()
    end
end

function ActionButtonMixin:HideGrid(reason)
    if InCombatLockdown() then return end

    local showgrid = self:GetAttribute("showgrid");
    if showgrid > 0 then
        self:SetAttribute("showgrid", bit.band(showgrid, bit.bnot(reason)));
    end

    if self:GetAttribute("showgrid") == 0 and not HasAction(self.action) then
        self:Hide()
    end
end

if ActionButton_UpdateHotkeys then
    hooksecurefunc("ActionButton_UpdateHotkeys", RazerNaga.BindableButton.UpdateHotkeys)
end

-- exports
RazerNaga.ActionButtonMixin = ActionButtonMixin

--------------------------------------------------------------------------------
-- Action Button 
-- A pool of action buttons
--------------------------------------------------------------------------------
local ActionButton = CreateFrame('Frame', nil, nil, 'SecureHandlerBaseTemplate')

-- constants
local ACTION_BUTTON_NAME_TEMPLATE = "RazerNaga" .. "ActionButton%d"

ActionButton.buttons = {}

--------------------------------------------------------------------------------
-- Event and Callback Handling
--------------------------------------------------------------------------------

function ActionButton:Initialize()
    self:SetScript("OnEvent", function(f, event, ...) f[event](f, ...) end)

    -- load initial state
    self:SetAttribute("ActionButtonUseKeyDown", GetCVarBool("ActionButtonUseKeyDown"))

    self.Initialize = nil
end

--------------------------------------------------------------------------------
-- Action Button Construction
--------------------------------------------------------------------------------

local ActionButton_ClickBefore = [[
    if button == "HOTKEY" then
        if down == control:GetAttribute("ActionButtonUseKeyDown") then
            return "LeftButton"
        end
        return false
    end

    if down then
        return false
    end
]]

local function GetActionButtonName(id)
    -- 0
    if id <= 0 then
        return
    -- 1
    elseif id <= 12 then
        return "ActionButton" .. id
    -- 2
    elseif id <= 24 then
        return ACTION_BUTTON_NAME_TEMPLATE:format(id)
    -- 3
    elseif id <= 36 then
        return "MultiBarRightButton" .. (id - 24)
    -- 4
    elseif id <= 48 then
        return "MultiBarLeftButton" .. (id - 36)
    -- 5
    elseif id <= 60 then
        return "MultiBarBottomRightButton" .. (id - 48)
    -- 6
    elseif id <= 72 then
        return "MultiBarBottomLeftButton" .. (id - 60)
    -- 7+
    elseif id <= 168 then
        return ACTION_BUTTON_NAME_TEMPLATE:format(id)
    end
end

function ActionButton:GetOrCreateActionButton(id, parent)
    local name = GetActionButtonName(id)
    local button = _G[name]
    local new = false

    -- a button we're creating
    if button == nil then
        button = CreateFrame("CheckButton", name, parent, "ActionBarButtonTemplate")
        Mixin(button, RazerNaga.ActionButtonMixin)

        new = true
    -- a standard UI button we're reusing
    elseif self.buttons[button] == nil then
        Mixin(button, RazerNaga.ActionButtonMixin)

        button:SetID(0)

        new = true
    end

    if new then
        button:OnCreate(id)
        self:WrapScript(button, "OnClick", ActionButton_ClickBefore)
        self.buttons[button] = id
    end

    return button
end

-- startup and export
ActionButton:Initialize()

-- exports
RazerNaga.ActionButton = ActionButton