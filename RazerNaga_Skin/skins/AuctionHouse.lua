local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionHouseUI" then
		AuctionHouseFrame.CategoriesList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CategoriesList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CategoriesList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CategoriesList.ScrollBox, "TOPRIGHT", -1, 3)
		AuctionHouseFrame.CategoriesList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CategoriesList.ScrollBox, "BOTTOMRIGHT", 2, -1)

		if (AuctionHouseFrame.CategoriesList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.CategoriesList.ScrollBar.Backplate = AuctionHouseFrame.CategoriesList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.CategoriesList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.CategoriesList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CategoriesList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CategoriesList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CategoriesList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Backplate = AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.BrowseResultsFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Backplate = AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CommoditiesBuyFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Backplate = AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.ItemBuyFrame.ItemList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.CommoditiesSellList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.CommoditiesSellList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.CommoditiesSellList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.CommoditiesSellList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Backplate = AuctionHouseFrame.CommoditiesSellList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.CommoditiesSellList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.CommoditiesSellList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.CommoditiesSellList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.CommoditiesSellList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.ItemSellList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrame.ItemSellList.ScrollBar:ClearAllPoints()
		AuctionHouseFrame.ItemSellList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrame.ItemSellList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.ItemSellList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrame.ItemSellList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.ItemSellList.ScrollBar.Backplate == nil) then
			AuctionHouseFrame.ItemSellList.ScrollBar.Backplate = AuctionHouseFrame.ItemSellList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.ItemSellList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.ItemSellList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrame.ItemSellList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.ItemSellList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.ItemSellList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBox, "TOPRIGHT", 1, 0)
		AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBox, "BOTTOMRIGHT", 4, -2)

		if (AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Backplate == nil) then
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Backplate = AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.SummaryList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Backplate == nil) then
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Backplate = AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.AllAuctionsList.ScrollBar.Track.Thumb)

		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetSize(25, 560)
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:ClearAllPoints()
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Backplate == nil) then
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Backplate = AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Backplate:SetAllPoints()
		end
		
		ApplyScrollBarArrow(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrameAuctionsFrame.BidsList.ScrollBar.Track.Thumb)

		AuctionHouseFrame.WoWTokenResults.DummyScrollBar:SetSize(25, 560)
		AuctionHouseFrame.WoWTokenResults.DummyScrollBar:ClearAllPoints()
		AuctionHouseFrame.WoWTokenResults.DummyScrollBar:SetPoint("TOPLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "TOPRIGHT", 2, 3)
		AuctionHouseFrame.WoWTokenResults.DummyScrollBar:SetPoint("BOTTOMLEFT", AuctionHouseFrameAuctionsFrame.BidsList.ScrollBox, "BOTTOMRIGHT", 5, -3)

		if (AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Backplate == nil) then
			AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Backplate = AuctionHouseFrame.WoWTokenResults.DummyScrollBar:CreateTexture(nil, "BACKGROUND")
			AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Backplate:SetAllPoints()
		end
		
		ApplyScrollBarArrow(AuctionHouseFrame.WoWTokenResults.DummyScrollBar)
		ApplyScrollBarTrack(AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Track)
		ApplyScrollBarThumb(AuctionHouseFrame.WoWTokenResults.DummyScrollBar.Track.Thumb)

		ApplyDropDown(AuctionHouseFrame.ItemSellFrame.Duration.Dropdown)
		ApplyFilterDropDown(AuctionHouseFrame.SearchBar.FilterButton)
	end
end)