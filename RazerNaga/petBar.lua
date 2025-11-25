--------------------------------------------------------------------------------
-- Pet Bar
-- A movable action bar for pets
--------------------------------------------------------------------------------
local RazerNaga = _G[...]

--------------------------------------------------------------------------------
-- Button
--------------------------------------------------------------------------------

local PetButtons = setmetatable({}, {
    __index = function(self, index)
        local button =  (PetActionBar and PetActionBar.actionButtons[index])
            or _G['PetActionButton' .. index]

        if button then
            button.buttonType = 'BONUSACTIONBUTTON'
            button:SetAttribute("commandName", "BONUSACTIONBUTTON" .. index)
            RazerNaga.BindableButton:AddQuickBindingSupport(button)
            button.cooldown:SetDrawBling(true)

            self[index] = button
        end

        return button
    end
})

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local PetBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

function PetBar:New()
    return PetBar.proto.New(self, 'pet')
end

function PetBar:GetShowStates()
    return '[@pet,exists,novehicleui,nooverridebar,nopossessbar]show;hide'
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
    return PetButtons[index]
end

function PetBar:OnAttachButton(button)
    button:UpdateHotkeys()
    RazerNaga:GetModule('Tooltips'):Register(button)
end

function PetBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

function PetBar:KEYBOUND_ENABLED()
    self:ForButtons("Show")
end

function PetBar:KEYBOUND_DISABLED()
    local hasPetBar = PetHasActionBar()

    for _, button in pairs(self.buttons) do
        local show = hasPetBar and GetPetActionInfo(button.index or button:GetID())
        button:SetShown(show)
    end
end

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local PetBarModule = RazerNaga:NewModule('PetBar')

function PetBarModule:Load()
    self.bar = PetBar:New()
end

function PetBarModule:Unload()
    if self.bar then
        self.bar:Free()
        self.bar = nil
    end
end