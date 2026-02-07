local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Transmog" then
		ApplyDropDown(TransmogFrame.OutfitPopup.BorderBox.IconTypeDropdown)
		ApplyDropDown(TransmogFrame.WardrobeCollection.TabContent.ItemsFrame.WeaponDropdown)

		hooksecurefunc(TransmogFrame.WardrobeCollection.TabContent.SituationsFrame, "Refresh", function(frame)
			for situationFrame in TransmogFrame.WardrobeCollection.TabContent.SituationsFrame.SituationFramePool:EnumerateActive() do
				ApplyDropDown(situationFrame.Dropdown)
			end
		end)

		ApplyFilterDropDown(TransmogFrame.WardrobeCollection.TabContent.ItemsFrame.FilterButton)
		ApplyFilterDropDown(TransmogFrame.WardrobeCollection.TabContent.SetsFrame.FilterButton)
	end
end)