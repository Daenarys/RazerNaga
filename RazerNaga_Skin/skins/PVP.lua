local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PVPUI" then
		ApplyDropDown(HonorFrameTypeDropdown)
		HonorFrameTypeDropdown.Text:SetJustifyH("RIGHT")
		HonorFrameTypeDropdown.Text:SetPoint("TOPLEFT", 9, -7)
	end
end)