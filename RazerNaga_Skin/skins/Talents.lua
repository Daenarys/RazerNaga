local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PlayerSpells" then
		ApplyDropDown(PlayerSpellsFrame.TalentsFrame.LoadSystem.Dropdown)
	end
end)