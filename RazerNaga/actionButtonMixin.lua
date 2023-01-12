--[[ 
    actionButtonMixin.lua
        Additional methods we define on action buttons
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
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
        self.HotKey:SetPoint("TOPRIGHT", -1, -3)
        self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
    end
end

--[[ exports ]]--

RazerNaga.ActionButtonMixin = ActionButtonMixin