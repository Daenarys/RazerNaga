local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PlayerSpells" then
		ApplyDropDown(PlayerSpellsFrame.TalentsFrame.LoadSystem.Dropdown)

		HeroTalentsSelectionDialog:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("TOP", 0, -62)
		end)
	end
end)