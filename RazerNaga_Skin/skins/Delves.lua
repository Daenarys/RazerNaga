local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_DelvesDifficultyPicker" then
		ApplyDropDown(DelvesDifficultyPickerFrame.Dropdown)

		DelvesDifficultyPickerFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("CENTER", 0, 50)
		end)
	end
end)

if DelvesCompanionAbilityListFrame then
	ApplyDropDown(DelvesCompanionAbilityListFrame.DelvesCompanionRoleDropdown)
end