local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ProfessionsCustomerOrders" then
		ProfessionsCustomerOrdersFrameCloseButton:SetSize(32, 32)
		ProfessionsCustomerOrdersFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ProfessionsCustomerOrdersFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ProfessionsCustomerOrdersFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ProfessionsCustomerOrdersFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ProfessionsCustomerOrdersFrameCloseButton:ClearAllPoints()
		ProfessionsCustomerOrdersFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ProfessionsCustomerOrdersFrameCloseButton:SetFrameLevel(2)

		ProfessionsCustomerOrdersFrame.PortraitContainer.CircleMask:Hide()

		ProfessionsCustomerOrdersFramePortrait:SetSize(61, 61)
		ProfessionsCustomerOrdersFramePortrait:ClearAllPoints()
		ProfessionsCustomerOrdersFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ProfessionsCustomerOrdersFrame.TitleContainer:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.TitleContainer:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame, "TOPLEFT", 58, 0)
		ProfessionsCustomerOrdersFrame.TitleContainer:SetPoint("TOPRIGHT", ProfessionsCustomerOrdersFrame, "TOPRIGHT", -58, 0)

		ProfessionsCustomerOrdersFrame:CreateTexture("ProfessionsCustomerOrdersFrameTitleBg")
		ProfessionsCustomerOrdersFrame.TitleBg = ProfessionsCustomerOrdersFrameTitleBg
		ProfessionsCustomerOrdersFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ProfessionsCustomerOrdersFrame.TitleBg:SetSize(256, 18)
		ProfessionsCustomerOrdersFrame.TitleBg:SetHorizTile(true)
		ProfessionsCustomerOrdersFrame.TitleBg:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ProfessionsCustomerOrdersFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ProfessionsCustomerOrdersFrame.TopTileStreaks:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ProfessionsCustomerOrdersFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ProfessionsCustomerOrdersFrame.NineSlice)

		ProfessionsCustomerOrdersFrameOrdersTab:ClearAllPoints()
		ProfessionsCustomerOrdersFrameOrdersTab:SetPoint("LEFT", ProfessionsCustomerOrdersFrameBrowseTab, "RIGHT", -15, 0)

		ApplyBottomTab(ProfessionsCustomerOrdersFrameBrowseTab)
		ApplyBottomTab(ProfessionsCustomerOrdersFrameOrdersTab)

		ProfessionsCustomerOrdersFrame:HookScript("OnShow", function()
			ProfessionsCustomerOrdersFrameBrowseTab:SetWidth(50 + ProfessionsCustomerOrdersFrameBrowseTab:GetFontString():GetStringWidth())
			ProfessionsCustomerOrdersFrameOrdersTab:SetWidth(50 + ProfessionsCustomerOrdersFrameOrdersTab:GetFontString():GetStringWidth())
		end)

		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBox, "TOPRIGHT", -4, 3)
		ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBox, "BOTTOMRIGHT", -1, -1)

		if (ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Background == nil) then
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Background = ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.BrowseOrders.CategoryList.ScrollBar.Track.Thumb)

		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBox, "TOPRIGHT", -10, 3)
		ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBox, "BOTTOMRIGHT", -7, 1)

		if (ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Background == nil) then
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Background = ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.BrowseOrders.RecipeList.ScrollBar.Track.Thumb)

		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetSize(25, 560)
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:ClearAllPoints()
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetPoint("TOPLEFT", ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBox, "TOPRIGHT", -7, 3)
		ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:SetPoint("BOTTOMLEFT", ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBox, "BOTTOMRIGHT", -4, -1)

		if (ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Background == nil) then
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Background = ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar)
		ApplyScrollBarTrack(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Track)
		ApplyScrollBarThumb(ProfessionsCustomerOrdersFrame.MyOrdersPage.OrderList.ScrollBar.Track.Thumb)
	end
end)