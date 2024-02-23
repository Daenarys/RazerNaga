--------------------------------------------------------------------------------
-- Pet Bar
-- A movable action bar for pets
--------------------------------------------------------------------------------

local RazerNaga = _G[...]

--------------------------------------------------------------------------------
-- Button
--------------------------------------------------------------------------------

local function getPetButton(id)
    return _G[('PetActionButton%d'):format(id)]
end

for id = 1, NUM_PET_ACTION_SLOTS do
    local button = getPetButton(id)

    -- set the buttontype
    button:SetAttribute("commandName", "BONUSACTIONBUTTON" .. id)

    -- enable drawbling
    button.cooldown:SetDrawBling(button.cooldown:GetEffectiveAlpha() > 0.5)

    -- apply hooks for quick binding
    RazerNaga.BindableButton:AddQuickBindingSupport(button)
end

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local PetBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

function PetBar:New()
    return PetBar.proto.New(self, 'pet')
end

function PetBar:IsOverrideBar()
    return RazerNaga.db.profile.possessBar == self.id
end

function PetBar:UpdateOverrideBar()
    self:UpdateDisplayConditions()
end

function PetBar:GetDisplayConditions()
    return '[@pet,exists,nopossessbar]show;hide'
end

function PetBar:GetDefaults()
    return {
        point = 'CENTER',
        x = 0,
        y = -32,
        spacing = 4
    }
end

function PetBar:NumButtons()
    return NUM_PET_ACTION_SLOTS
end

function PetBar:AcquireButton(index)
    return getPetButton(index)
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
    self:ForButtons("Show")
end

function PetBar:KEYBOUND_DISABLED()
    local petBarShown = PetHasActionBar()

    for _, button in pairs(self.buttons) do
        if petBarShown and GetPetActionInfo(button:GetID()) then
            button:Show()
        else
            button:Hide()
        end
    end
end

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local PetBarModule = RazerNaga:NewModule('PetBar', 'AceEvent-3.0')

function PetBarModule:Load()
    self.bar = PetBar:New()

    self:RegisterEvent('UPDATE_BINDINGS')
end

function PetBarModule:Unload()
    self:UnregisterAllEvents()

    if self.bar then
        self.bar:Free()
        self.bar = nil
    end
end

function PetBarModule:UPDATE_BINDINGS()
    self.bar:ForButtons('UpdateHotkeys')
end