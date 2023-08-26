local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionHouseUI" then
		AuctionHouseFrameCloseButton:SetSize(32, 32)
		AuctionHouseFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		AuctionHouseFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		AuctionHouseFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		AuctionHouseFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		AuctionHouseFrameCloseButton:ClearAllPoints()
		AuctionHouseFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		AuctionHouseFrameCloseButton:SetFrameLevel(2)

		AuctionHouseFrame.PortraitContainer.CircleMask:Hide()

		AuctionHouseFramePortrait:SetSize(61, 61)
		AuctionHouseFramePortrait:ClearAllPoints()
		AuctionHouseFramePortrait:SetPoint("TOPLEFT", -6, 8)

		AuctionHouseFrame.TitleContainer:ClearAllPoints()
		AuctionHouseFrame.TitleContainer:SetPoint("TOPLEFT", AuctionHouseFrame, "TOPLEFT", 58, 0)
		AuctionHouseFrame.TitleContainer:SetPoint("TOPRIGHT", AuctionHouseFrame, "TOPRIGHT", -58, 0)

		AuctionHouseFrame:CreateTexture("AuctionHouseFrameTitleBg")
		AuctionHouseFrame.TitleBg = AuctionHouseFrameTitleBg
		AuctionHouseFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		AuctionHouseFrame.TitleBg:SetSize(256, 18)
		AuctionHouseFrame.TitleBg:SetHorizTile(true)
		AuctionHouseFrame.TitleBg:ClearAllPoints()
		AuctionHouseFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		AuctionHouseFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		AuctionHouseFrame.TopTileStreaks:ClearAllPoints()
		AuctionHouseFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		AuctionHouseFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(AuctionHouseFrame.NineSlice)

		AuctionHouseFrameSellTab:ClearAllPoints()
		AuctionHouseFrameSellTab:SetPoint("LEFT", AuctionHouseFrameBuyTab, "RIGHT", -15, 0)
		AuctionHouseFrameAuctionsTab:ClearAllPoints()
		AuctionHouseFrameAuctionsTab:SetPoint("LEFT", AuctionHouseFrameSellTab, "RIGHT", -15, 0)

		ApplyBottomTab(AuctionHouseFrameBuyTab)
		ApplyBottomTab(AuctionHouseFrameSellTab)
		ApplyBottomTab(AuctionHouseFrameAuctionsTab)

		AuctionHouseFrame:HookScript("OnShow", function()
			AuctionHouseFrameBuyTab:SetWidth(89 + AuctionHouseFrameBuyTab:GetFontString():GetStringWidth())
			AuctionHouseFrameSellTab:SetWidth(90 + AuctionHouseFrameSellTab:GetFontString():GetStringWidth())
			AuctionHouseFrameAuctionsTab:SetWidth(63 + AuctionHouseFrameAuctionsTab:GetFontString():GetStringWidth())
		end)

		ApplyTopTab(AuctionHouseFrameAuctionsFrameAuctionsTab)

		AuctionHouseFrameAuctionsFrameAuctionsTab:HookScript("OnShow", function(self)
			self:SetWidth(55 + self:GetFontString():GetStringWidth())
		end)

		AuctionHouseFrameAuctionsFrameBidsTab:ClearAllPoints()
		AuctionHouseFrameAuctionsFrameBidsTab:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrameAuctionsTab, "TOPRIGHT")

		ApplyTopTab(AuctionHouseFrameAuctionsFrameBidsTab)

		AuctionHouseFrameAuctionsFrameBidsTab:HookScript("OnShow", function(self)
			self:SetWidth(78 + self:GetFontString():GetStringWidth())
		end)

		AuctionHouseFrame.CategoriesList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CategoriesList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CategoriesList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CategoriesList.ScrollBox, "TOPRIGHT", -1, 3)
		AuctionHouseFrame.CategoriesList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CategoriesList.ScrollBox, "BOTTOMRIGHT", 2, -1)

		if (AuctionHouseFrame.CategoriesList.ScrollBar.Background == nil) then
			AuctionHouseFrame.CategoriesList.ScrollBar.Background = AuctionHouseFrame.CategoriesList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.CategoriesList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.CategoriesList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CategoriesList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CategoriesList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CategoriesList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Background == nil) then
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Background = AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Background == nil) then
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Background = AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Background == nil) then
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Background = AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CommoditiesSellList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CommoditiesSellList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.CommoditiesSellList.ScrollBar.Background == nil) then
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Background = AuctionHouseFrame.CommoditiesSellList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CommoditiesSellList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CommoditiesSellList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CommoditiesSellList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.ItemSellList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.ItemSellList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.ItemSellList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.ItemSellList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.ItemSellList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.ItemSellList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.ItemSellList.ScrollBar.Background == nil) then
			AuctionHouseFrame.ItemSellList.ScrollBar.Background = AuctionHouseFrame.ItemSellList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrame.ItemSellList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrame.ItemSellList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.ItemSellList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.ItemSellList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.ItemSellList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBox, "TOPRIGHT", 1, 0)
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBox, "BOTTOMRIGHT", 4, -2)

		if (AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Background == nil) then
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Background = AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Background == nil) then
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Background = AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Background == nil) then
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Background = AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Background:SetAllPoints()
		end
		
		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Track.Thumb)

		hooksecurefunc(AuctionHouseFrame, "Show", function()
			if _G.ContainerFrame1MoneyFrame then
				_G.ContainerFrame1MoneyFrame:ClearAllPoints()
				_G.ContainerFrame1MoneyFrame:SetPoint("TOPRIGHT", _G.ContainerFrame1, "TOPRIGHT", -2, -272)
			end
		end)
	end
end)