local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" then
		if CollectionsJournalTab6 then
			CollectionsJournalTab6:Hide()
		end

		ApplyDropDown(HeirloomsJournal.ClassDropdown)
		ApplyDropDown(WardrobeCollectionFrame.ClassDropdown)
		ApplyDropDown(WardrobeCollectionFrame.ItemsCollectionFrame.WeaponDropdown)
		ApplyDropDown(WardrobeCollectionFrame.SetsCollectionFrame.DetailsFrame.VariantSetsDropdown)

		HeirloomsJournal.ClassDropdown.Text:SetJustifyH("RIGHT")
		HeirloomsJournal.ClassDropdown.Text:SetPoint("TOPLEFT", 9, -7)
		WardrobeCollectionFrame.ClassDropdown.Text:SetJustifyH("RIGHT")
		WardrobeCollectionFrame.ClassDropdown.Text:SetPoint("TOPLEFT", 9, -7)
		WardrobeCollectionFrame.ItemsCollectionFrame.WeaponDropdown.Text:SetJustifyH("RIGHT")
		WardrobeCollectionFrame.ItemsCollectionFrame.WeaponDropdown.Text:SetPoint("TOPLEFT", 9, -7)

		ApplyFilterDropDown(MountJournal.FilterDropdown)
		ApplyFilterDropDown(PetJournal.FilterDropdown)
		ApplyFilterDropDown(ToyBox.FilterDropdown)
		ApplyFilterDropDown(HeirloomsJournal.FilterDropdown)
		ApplyFilterDropDown(WardrobeCollectionFrame.FilterButton)

		hooksecurefunc(WardrobeCollectionFrame, "SetContainer", function(self, parent)
			if parent == CollectionsJournal then
				self.ItemsCollectionFrame.ModelR1C1:SetPoint("TOP", -238, -85)
				self.ItemsCollectionFrame.PagingFrame:SetPoint("BOTTOM", 22, 38)
				self.ItemsCollectionFrame.SlotsFrame:SetPoint("TOPLEFT", 18, -20)
				self.ItemsCollectionFrame.WeaponDropdown:SetPoint("TOPRIGHT", -20, -23)
			end
		end)

		hooksecurefunc(WardrobeCollectionFrame, "SetTab", function(self)
			self.ClassDropdown:Hide()
		end)
	end
end)