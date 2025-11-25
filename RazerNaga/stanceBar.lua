--------------------------------------------------------------------------------
-- Stance bar
-- Lets you move around the bar for displaying forms/stances/etc
--------------------------------------------------------------------------------
local RazerNaga = _G[...]

-- don't bother loading the module if the player is currently playing something without a stance
if not ({
    DRUID = true,
    EVOKER = true,
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

local StanceButtons = setmetatable({}, {
    __index = function(self, index)
        local button =  (StanceBar and StanceBar.actionButtons[index])
            or _G['StanceButton' .. index]

        if button then
            button.buttonType = 'SHAPESHIFTBUTTON'
            button:SetAttribute("commandName", "SHAPESHIFTBUTTON" .. index)
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
    return StanceButtons[index]
end

function StanceBar:OnAttachButton(button)
    button:UpdateHotkeys()
    RazerNaga:GetModule('Tooltips'):Register(button)
end

function StanceBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local StanceBarModule = RazerNaga:NewModule('StanceBar')

function StanceBarModule:Load()
    self.bar = StanceBar:New()
end

function StanceBarModule:Unload()
    if self.bar then
        self.bar:Free()
        self.bar = nil
    end
end