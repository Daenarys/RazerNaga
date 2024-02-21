local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ProfessionsCustomerOrders" then
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBox, "TOPRIGHT", -4, 3)
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBox, "BOTTOMRIGHT", -1, -1)

		if (ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.BG == nil) then
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.BG = ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Track.Thumb)

		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBox, "TOPRIGHT", -10, 3)
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBox, "BOTTOMRIGHT", -7, 1)

		if (ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.BG == nil) then
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.BG = ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Track.Thumb)

		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBox, "TOPRIGHT", -7, 3)
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBox, "BOTTOMRIGHT", -4, -1)

		if (ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.BG == nil) then
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.BG = ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Track.Thumb)
	end
end)