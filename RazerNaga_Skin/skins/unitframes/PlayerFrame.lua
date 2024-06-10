if not _G.PlayerFrame then return end

PlayerFrame:HookScript("OnEvent", function(self)
    local classPowerBar = self.classPowerBar
    if (classPowerBar) then
        classPowerBar:UnregisterAllEvents()
        classPowerBar:Hide()
    end
    if (RuneFrame) then
        RuneFrame:UnregisterAllEvents()
        RuneFrame:Hide()
    end
end)

hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
    local _, class = UnitClass("player")
    if ( PlayerFrame.CfClassPowerBar ) then
        PlayerFrame.CfClassPowerBar:Setup()
    elseif ( class == "DEATHKNIGHT" ) then
        CfRuneFrame:Show()
    end
    ComboPointPlayerFrame:Setup()
end)

hooksecurefunc("PlayerFrame_ToVehicleArt", function(self)
    local _, class = UnitClass("player")
    if ( PlayerFrame.CfClassPowerBar ) then
        PlayerFrame.CfClassPowerBar:Hide()
    elseif ( class == "DEATHKNIGHT" ) then
        CfRuneFrame:Hide()
    end
    ComboPointPlayerFrame:Setup()
end)