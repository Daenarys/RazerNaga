if not _G.AddonList then return end

AddonList:SetSize(500, 478)
AddonList.ForceLoad:SetPoint("TOP", 75, -30)
AddonList.SearchBox:Hide()
AddonList.ScrollBox:ClearAllPoints()
AddonList.ScrollBox:SetPoint("TOPLEFT", 7, -64)

hooksecurefunc(AddonList, "UpdatePerformance", function(self)
	self.Performance:Hide()
end)