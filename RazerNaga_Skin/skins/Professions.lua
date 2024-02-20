local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Professions" then
		ProfessionsFrame.CraftingPage.RecipeList.ScrollBar:SetSize(25, 560)
		ProfessionsFrame.CraftingPage.RecipeList.ScrollBar:ClearAllPoints()
		ProfessionsFrame.CraftingPage.RecipeList.ScrollBar:SetPoint("TOPLEFT", ProfessionsFrame.CraftingPage.RecipeList.ScrollBox, "TOPRIGHT", -8, -5)
		ProfessionsFrame.CraftingPage.RecipeList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsFrame.CraftingPage.RecipeList.ScrollBox, "BOTTOMRIGHT", -5, -4)

		if (ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.BG == nil) then
			ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.BG = ProfessionsFrame.CraftingPage.RecipeList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsFrame.CraftingPage.RecipeList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsFrame.CraftingPage.RecipeList.ScrollBar.Track.Thumb)

		ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar:SetSize(25, 560)
		ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar:ClearAllPoints()
		ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar:SetPoint("TOPLEFT", ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBox, "TOPRIGHT", -6, 3)
		ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBox, "BOTTOMRIGHT", 3, -4)

		if (ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.BG == nil) then
			ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.BG = ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsFrame.OrdersPage.BrowseFrame.RecipeList.ScrollBar.Track.Thumb)

		ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar:SetSize(25, 560)
		ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar:ClearAllPoints()
		ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar:SetPoint("TOPLEFT", ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBox, "TOPRIGHT", -8, 3)
		ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBox, "BOTTOMRIGHT", 5, -1)

		if (ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.BG == nil) then
			ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.BG = ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsFrame.OrdersPage.BrowseFrame.OrderList.ScrollBar.Track.Thumb)
	end
end)