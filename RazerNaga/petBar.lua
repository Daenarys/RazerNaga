--[[
    petBar.lua
        A RazerNaga pet bar
--]]


--[[ Globals ]]--

local RazerNaga = _G[...]
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local format = string.format
local unused = {}


--[[ Pet Button ]]--

local PetButton = RazerNaga:CreateClass('CheckButton')

function PetButton:New(id)
    local b = self:Restore(id) or self:Create(id)

    RazerNaga:GetModule('Tooltips'):Register(b)

    return b
end

function PetButton:Create(id)
    local b = self:Bind(_G['PetActionButton' .. id])
    b.buttonType = 'BONUSACTIONBUTTON'
    
    RazerNaga.BindableButton:AddQuickBindingSupport(b)

    b:Skin()

    return b
end

-- if we have button facade support, then skin the button that way
-- otherwise, apply the RazerNaga style to the button to make it pretty
function PetButton:Skin()
    if not RazerNaga:Masque('Pet Bar', self) then
        self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
        self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
        self.NormalTexture:SetSize(54, 54)
        self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
        self.NormalTexture:ClearAllPoints()
        self.NormalTexture:SetPoint("CENTER", 0, -1)
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

function PetButton:Restore(id)
    local b = unused and unused[id]
    if b then
        unused[id] = nil
        b:Show()

        return b
    end
end

--saving them thar memories
function PetButton:Free()
    unused[self:GetID()] = self

    RazerNaga:GetModule('Tooltips'):Unregister(self)

    self:SetParent(nil)
    self:Hide()
end


--[[ Pet Bar ]]--

local PetBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function PetBar:New()
    local f = self.proto.New(self, 'pet')
    f:SetTooltipText(L.PetBarHelp)
    f:LoadButtons()
    f:Layout()

    return f
end

function PetBar:GetShowStates()
    -- workaround: filter out channeling of eye of kilrog when playing a warlock
    -- as it doesn't trigger the possess bar condition properly if you already
    -- have a pet summoned
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

--RazerNaga frame method overrides
function PetBar:NumButtons()
    return NUM_PET_ACTION_SLOTS
end

function PetBar:AddButton(i)
    local b = PetButton:New(i)
    b:SetParent(self)
    self.buttons[i] = b
end

function PetBar:RemoveButton(i)
    local b = self.buttons[i]
    self.buttons[i] = nil
    b:Free()
end


--[[ keybound  support ]]--

function PetBar:KEYBOUND_ENABLED()
    self:SetAttribute('state-visibility', 'display')

    for _, button in pairs(self.buttons) do
        button:Show()
    end
end

function PetBar:KEYBOUND_DISABLED()
    self:UpdateShowStates()

    local petBarShown = PetHasActionBar()

    for _, button in pairs(self.buttons) do
        if petBarShown and GetPetActionInfo(button:GetID()) then
            button:Show()
        else
            button:Hide()
        end
    end
end


--[[ controller good times ]]--

local PetBarController = RazerNaga:NewModule('PetBar')

function PetBarController:Load()
    self.frame = PetBar:New()
end

function PetBarController:Unload()
    if self.frame then
        self.frame:Free()
        self.frame = nil
    end
end