--[[ 
	actionButton.lua
		A pool of action buttons
--]]

--[[ globals ]]--

local RazerNaga = _G[...]

--[[ Mixin ]]--

local ActionButtonMixin = {}

function ActionButtonMixin:SetActionOffsetInsecure(offset)
    if InCombatLockdown() then
        return
    end

    local oldActionId = self:GetAttribute('action')
    local newActionId = self:GetAttribute('index') + (offset or 0)

    if oldActionId ~= newActionId then
        self:SetAttribute('action', newActionId)
        self:UpdateState()
    end
end

function ActionButtonMixin:SetShowGridInsecure(showgrid, force)
    if InCombatLockdown() then
        return
    end

    showgrid = tonumber(showgrid) or 0

    if (self:GetAttribute("showgrid") ~= showgrid) or force then
        self:SetAttribute("showgrid", showgrid)
        self:UpdateShownInsecure()
    end
end

function ActionButtonMixin:UpdateShownInsecure()
    if InCombatLockdown() then
        return
    end

    local show = (self:GetAttribute("showgrid") > 0 or HasAction(self:GetAttribute("action")))
        and not self:GetAttribute("statehidden")

    self:SetShown(show)
end

--button visibility
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

-- configuration commands
function ActionButtonMixin:SetFlyoutDirection(direction)
    if InCombatLockdown() then
        return
    end

    self:SetAttribute("flyoutDirection", direction)
    self:UpdateFlyout()
end

-- if we have button facade support, then skin the button that way
-- otherwise, apply the RazerNaga style to the button to make it pretty
function ActionButtonMixin:Skin()
    if not RazerNaga:Masque('Action Bar', self) then
        self.SlotBackground:Hide()
        self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
        self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
        self.NormalTexture:ClearAllPoints()
        self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
        self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)
        self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
        self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
        self.PushedTexture:SetSize(36, 36)
        self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
        self.HighlightTexture:SetSize(36, 36)
        self.HighlightTexture:SetBlendMode("ADD")
        self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
        self.CheckedTexture:ClearAllPoints()
        self.CheckedTexture:SetAllPoints()
        self.CheckedTexture:SetBlendMode("ADD")
        self.SpellHighlightTexture:SetPoint("TOPLEFT", -2, 2)
        self.SpellHighlightTexture:SetPoint("BOTTOMRIGHT", 2, -2)
        self.SpellHighlightTexture:SetBlendMode("ADD")
        self.NewActionTexture:ClearAllPoints()
        self.NewActionTexture:SetAllPoints()
        self.cooldown:ClearAllPoints()
        self.cooldown:SetAllPoints()
        self.Flash:SetTexture([[Interface\Buttons\UI-QuickslotRed]])
        self.Flash:ClearAllPoints()
        self.Flash:SetAllPoints()
        self.Border:ClearAllPoints()
        self.Border:SetPoint("CENTER")
        self.Border:SetBlendMode("ADD")
        self.HotKey:SetFont(self.HotKey:GetFont(), 13, "OUTLINE")
        self.HotKey:SetPoint("TOPRIGHT", -1, -2)
        self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
    end
end

--[[ exports ]]--

RazerNaga.ActionButtonMixin = ActionButtonMixin

--[[ Buttons ]]--

local createActionButton
local SecureHandler = RazerNaga:CreateHiddenFrame('Frame', nil, nil, "SecureHandlerBaseTemplate")
    -- dragonflight hack: whenever a Dominos action button's action changes
    -- set the action of the corresponding blizzard action button
    -- this ensures that pressing a blizzard keybinding does the same thing as
    -- clicking a Dominos button would
    --
    -- We want to not remap blizzard keybindings in dragonflight, so that we can
    -- use some behaviors only available to blizzard action buttons, mainly cast on
    -- key down and press and hold casting
local function proxyActionButton(owner, target)
	if not target then return end
    -- disable paging on the target by giving the target an ID of zero
     target:SetID(0)

    -- display the target's binding action
    owner.commandName = target.commandName

   -- mirror the owner's action on target whenever it changes
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
    local buttonName = ('%sActionButton%d'):format('RazerNaga', id)
    local button = CreateFrame('CheckButton', buttonName, nil, 'ActionBarButtonTemplate')

    -- set the size of the buttons to the pre 10.0 default
    button:SetSize(36, 36)

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

    proxyActionButton(button, RazerNaga.BlizzardActionButtons[id])

    return button
end

-- handle notifications from our parent bar about whate the action button
-- ID offset should be
local actionButton_OnUpdateOffset = [[
    local offset = message or 0
    local id = self:GetAttribute('index') + offset
    if self:GetAttribute('action') ~= id then
        self:SetAttribute('action', id)
        self:CallMethod('UpdateState')
    end
]]

-- action button creation is deferred so that we can avoid creating buttons for
-- bars set to show less than the maximum
local ActionButtons = setmetatable({}, {
    -- index creates & initializes buttons as we need them
    __index = function(self, id)
        -- validate the ID of the button we're getting is within an
        -- our expected range
        id = tonumber(id) or 0
        if id < 1 then
            error(('Usage: %s.ActionButtons[>0]'):format('RazerNaga'), 2)
        end

        local button = createActionButton(id)

        -- apply our extra action button methods
        Mixin(button, RazerNaga.ActionButtonMixin)

        -- apply hooks for quick binding
        -- this must be done before we reset the button ID, as we use it
        -- to figure out the binding action for the button
        RazerNaga.BindableButton:AddQuickBindingSupport(button)

        -- set a handler for updating the action from a parent frame
        button:SetAttribute('_childupdate-offset', actionButton_OnUpdateOffset)

        -- reset the showgrid setting to default
        button:SetAttribute('showgrid', 0)

        button:Hide()

        -- enable binding to mousewheel
        button:EnableMouseWheel(true)
		
        -- enable masque support
        button:Skin()

        rawset(self, id, button)
        return button
    end,

    -- newindex is set to block writes to prevent errors
    __newindex = function()
        error(('%s.ActionButtons does not support writes'):format('RazerNaga'), 2)
    end
})

--[[ exports ]]--

RazerNaga.ActionButtons = ActionButtons