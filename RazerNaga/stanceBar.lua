--------------------------------------------------------------------------------
-- Stance bar
-- Lets you move around the bar for displaying forms/stances/etc
--------------------------------------------------------------------------------
local RazerNaga = _G[...]

-- don't bother loading the module if the player is currently playing something without a stance
if not ({
    DRUID = true,
    PALADIN = true,
    PRIEST = true,
    ROGUE = true,
    WARRIOR = true,
})[UnitClassBase('player')] then
    return
end

--------------------------------------------------------------------------------
-- Button
--------------------------------------------------------------------------------

local function getStanceButton(id)
    return _G[('StanceButton%d'):format(id)]
end

local function skinStanceButton(self)
    _G[self:GetName() .. 'Icon']:SetTexCoord(0.06, 0.94, 0.06, 0.94)
    self:GetNormalTexture():SetVertexColor(1, 1, 1, 0.5)
end

for id = 1, 10 do
    local button = getStanceButton(id)

    -- set the buttontype
    button.buttonType = 'SHAPESHIFTBUTTON'
    button:SetAttribute("commandName", "SHAPESHIFTBUTTON" .. id)

    -- apply hooks for quick binding
    RazerNaga.BindableButton:AddQuickBindingSupport(button)

    -- apply pre 10.x button skin
    skinStanceButton(button)
end

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local StanceBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

function StanceBar:New()
    return StanceBar.proto.New(self, 'class')
end

function StanceBar:GetDefaults()
    return {
        point = 'CENTER',
        spacing = 2
    }
end

function StanceBar:NumButtons()
    return GetNumShapeshiftForms() or 0
end

function StanceBar:AcquireButton(index)
    return getStanceButton(index)
end

function StanceBar:OnAttachButton(button)
    button:UpdateHotkeys()
    RazerNaga:GetModule('Tooltips'):Register(button)
end

function StanceBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

-- exports
RazerNaga.StanceBar = StanceBar

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local StanceBarModule = RazerNaga:NewModule('StanceBar', 'AceEvent-3.0')

function StanceBarModule:Load()
    self.bar = StanceBar:New()

    self:RegisterEvent('UPDATE_SHAPESHIFT_FORMS', 'UpdateNumForms')
    self:RegisterEvent('PLAYER_REGEN_ENABLED', 'UpdateNumForms')
    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'UpdateNumForms')
    self:RegisterEvent('UPDATE_BINDINGS')
end

function StanceBarModule:Unload()
    self:UnregisterAllEvents()

    if self.bar then
        self.bar:Free()
    end
end

function StanceBarModule:UpdateNumForms()
    if InCombatLockdown() then
        return
    end

    self.bar:UpdateNumButtons()
end

function StanceBarModule:UPDATE_BINDINGS()
    self.bar:ForButtons('UpdateHotkeys')
end