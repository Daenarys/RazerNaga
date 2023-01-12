--[[ 
    actionButton.lua
        A pool of action buttons
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
local MAX_BUTTONS = 120

local function proxyActionButton(owner, target)
    if not target then return end

    -- disable paging on the target by giving the target an ID of zero
    target:SetID(0)

    -- display the target's binding action
    owner.commandName = target.commandName

    -- mirror the owner's action on target whenever it changes
    local SecureHandler = RazerNaga:CreateHiddenFrame('Frame', nil, nil, "SecureHandlerBaseTemplate")

    SecureHandlerSetFrameRef(owner, "ProxyTarget", target)
    SecureHandler:WrapScript(owner, "OnAttributeChanged", [[
        if name ~= "action" then return end
        local target = self:GetFrameRef("ProxyTarget")
        if target and target:GetAttribute(name) ~= value then
            target:SetAttribute(name, value)
        end
    ]])

    -- mirror the pushed state of the target button
    hooksecurefunc(target, "SetButtonStateBase", function(_, state)
        owner:SetButtonStateBase(state)
    end)
end

local function createActionButton(id)
    local name = ('%sActionButton%d'):format("RazerNaga", id)
    local button = CreateFrame('CheckButton', name, nil, 'ActionBarButtonTemplate')

    proxyActionButton(button, RazerNaga.BlizzardActionButtons[id])

    return button
end

-- handle notifications what the action button ID offset should be
local actionButton_OnUpdateOffset = [[
    local offset = message or 0
    local id = self:GetAttribute('index') + offset
    if self:GetAttribute('action') ~= id then
        self:SetAttribute('action', id)
        self:RunAttribute("UpdateShown")
        self:CallMethod('UpdateState')
    end
]]

local actionButton_OnUpdateShowGrid = [[
    local new = message or 0
    local old = self:GetAttribute("showgrid") or 0
    if old ~= new then
        self:SetAttribute("showgrid", new)
        self:RunAttribute("UpdateShown")
    end
]]

local actionButton_UpdateShown = [[
    local show = (self:GetAttribute("showgrid") > 0 or HasAction(self:GetAttribute("action")))
                 and not self:GetAttribute("statehidden")
    if show then
        self:Show(true)
    else
        self:Hide(true)
    end
]]

-- action button creation is deferred so that we can avoid creating buttons for
-- bars set to show less than the maximum
local ActionButton = setmetatable({}, {
    -- index creates & initializes buttons as we need them
    __index = function(self, id)
        -- validate the ID of the button we're getting is within an
        -- our expected range
        id = tonumber(id) or 0
        if id < 1 or id > MAX_BUTTONS then
            error(('Usage: %s.ActionButton[1-%d]'):format("RazerNaga", MAX_BUTTONS), 2)
        end

        local button = createActionButton(id)

        -- apply our extra action button methods
        Mixin(button, RazerNaga.ActionButtonMixin)

        -- apply hooks for quick binding
        RazerNaga.BindableButton:AddQuickBindingSupport(button)

        -- set a handler for updating the action from a parent frame
        button:SetAttribute('_childupdate-offset', actionButton_OnUpdateOffset)

        -- set a handler for updating showgrid status
        button:SetAttribute('_childupdate-showgrid', actionButton_OnUpdateShowGrid)

        button:SetAttribute("UpdateShown", actionButton_UpdateShown)

        -- reset the ID to zero to avoid paging issues
        button:SetID(0)

        -- clear current position to avoid forbidden frame issues
        button:ClearAllPoints()

        -- reset the showgrid setting to default
        button:SetAttribute('showgrid', 0)

        -- enable mousewheel clicks
        button:EnableMouseWheel(true)

        -- use the pre 10.0 button size
        button:SetSize(36, 36)

        -- apply the pre 10.0 button skin
        button:Skin()

        -- inject custom flyout handling
        RazerNaga.SpellFlyout:WrapScript(button, "OnClick", [[
            if not down then
                local actionType, actionID = GetActionInfo(self:GetAttribute("action"))
                if actionType == "flyout" then
                    control:SetAttribute("caller", self)
                    control:RunAttribute("Toggle", actionID)
                    return false
                end
            end
        ]])

        rawset(self, id, button)
        return button
    end,

    -- newindex is set to block writes to prevent errors
    __newindex = function()
        error(('%s.ActionButton does not support writes'):format("RazerNaga"), 2)
    end
})

--[[ exports ]]--

RazerNaga.ActionButton = ActionButton