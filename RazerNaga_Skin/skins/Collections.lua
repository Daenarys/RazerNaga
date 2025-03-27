local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" then
		hooksecurefunc(WardrobeCollectionFrame, "SetContainer", function(self, parent)
			if parent == CollectionsJournal then
				self.ItemsCollectionFrame.ModelR1C1:SetPoint("TOP", -238, -85)
				self.ItemsCollectionFrame.PagingFrame:SetPoint("BOTTOM", 22, 38)
				self.ItemsCollectionFrame.SlotsFrame:SetPoint("TOPLEFT", 18, -20)
				self.ItemsCollectionFrame.WeaponDropdown:SetPoint("TOPRIGHT", -20, -23)
			end
		end)

		hooksecurefunc(WardrobeCollectionFrame, "SetTab", function(self)
			if self.activeFrame == self.ItemsCollectionFrame then
				self.ClassDropdown:Hide()
			elseif self.activeFrame == self.SetsCollectionFrame then
				self.ClassDropdown:Show()
			end
		end)
	end
end)