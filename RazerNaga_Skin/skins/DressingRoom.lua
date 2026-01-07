if not _G.DressUpFrame then return end

ApplyDropDown(DressUpFrameOutfitDropdown)

hooksecurefunc(DressUpFrame, "ConfigureSize", function(self, isMinimized)
	if isMinimized then
		self.OutfitDropdown:SetPoint("TOP", -37, -29)
	else
		self.OutfitDropdown:SetWidth(178)
		self.OutfitDropdown:SetPoint("TOP", -23, -29)
	end
end)