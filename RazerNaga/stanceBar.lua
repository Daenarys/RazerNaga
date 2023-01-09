if not StanceBar then return end
--[[
	stanceBar.lua
		A RazerNaga stance bar
--]]

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

--[[ globals ]]--

local RazerNaga = _G[...]
local KeyBound = LibStub('LibKeyBound-1.0')


--[[ Bar ]]--

local StanceBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

local playerClass = (select(2, UnitClass('Player')))

function StanceBar:New()
   local f =  StanceBar.proto.New(self, 'class')

   local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
   f:SetTooltipText(L['ClassBarHelp_' .. playerClass])

   return f
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
    return _G.StanceBar.actionButtons[index]
end

function StanceBar:OnAttachButton(button)
    button:Show()
    button:UpdateHotkeys()

    RazerNaga:GetModule('Tooltips'):Register(button)
end

function StanceBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end


--[[ exports ]]--

RazerNaga.StanceBar = StanceBar


--[[ custom menu ]]--

function StanceBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	menu:AddBindingSelectorPanel()
	menu:AddLayoutPanel()
	menu:AddAdvancedPanel()

	StanceBar.menu = menu
end


--[[ Module ]]--

local StanceBarModule = RazerNaga:NewModule('StanceBar', 'AceEvent-3.0')

function StanceBarModule:Load()
    if not self.loaded then
        self:OnFirstLoad()
        self.loaded = true
    end

    self.bar = StanceBar:New()

    self:RegisterEvent("PLAYER_ENTERING_WORLD", 'UpdateNumForms')
    self:RegisterEvent("PLAYER_REGEN_ENABLED", 'UpdateNumForms')
end

function StanceBarModule:Unload()
    self:UnregisterAllEvents()

    if self.bar then
        self.bar:Free()
    end
end

function StanceBarModule:OnFirstLoad()
    for _, button in pairs(_G.StanceBar.actionButtons) do
        -- turn off cooldown edges
        button.cooldown:SetDrawEdge(false)

        -- turn off constant usability updates
        button:SetScript("OnUpdate", nil)

        -- register mouse clicks
        button:EnableMouseWheel(true)

        -- apply a custom button skin
        button.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
        button.NormalTexture:SetPoint("TOPLEFT", -10, 10)
        button.NormalTexture:SetPoint("BOTTOMRIGHT", 10, -10)
        button.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
        button.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
        button.HighlightTexture:SetSize(28, 28)
        button.HighlightTexture:SetBlendMode("ADD")

        -- apply hooks for quick binding
        RazerNaga.BindableButton:AddQuickBindingSupport(button)
    end
end

function StanceBarModule:UpdateNumForms()
    if not InCombatLockdown() then
        self.bar:UpdateNumButtons()
    end
end