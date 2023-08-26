if not _G.ItemTextFrame then return end

ItemTextFrameCloseButton:SetSize(32, 32)
ItemTextFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
ItemTextFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
ItemTextFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
ItemTextFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
ItemTextFrameCloseButton:ClearAllPoints()
ItemTextFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
ItemTextFrameCloseButton:SetFrameLevel(2)

ItemTextFrame.PortraitContainer.CircleMask:Hide()

ItemTextFramePortrait:SetSize(61, 61)
ItemTextFramePortrait:ClearAllPoints()
ItemTextFramePortrait:SetPoint("TOPLEFT", -6, 8)

ItemTextFrameTitleText:ClearAllPoints()
ItemTextFrameTitleText:SetPoint("CENTER", -10, 0)
ItemTextFrameTitleText:SetWidth(225)

ItemTextFrame:CreateTexture("ItemTextFrameTitleBg")
ItemTextFrame.TitleBg = ItemTextFrameTitleBg
ItemTextFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
ItemTextFrame.TitleBg:SetSize(256, 18)
ItemTextFrame.TitleBg:SetHorizTile(true)
ItemTextFrame.TitleBg:ClearAllPoints()
ItemTextFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
ItemTextFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

ItemTextFrame.TopTileStreaks:ClearAllPoints()
ItemTextFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
ItemTextFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(ItemTextFrame.NineSlice)

ItemTextScrollFrame.ScrollBar:SetSize(25, 560)
ItemTextScrollFrame.ScrollBar:ClearAllPoints()
ItemTextScrollFrame.ScrollBar:SetPoint("TOPLEFT", ItemTextScrollFrame, "TOPRIGHT", 1, 3)
ItemTextScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", ItemTextScrollFrame, "BOTTOMRIGHT", 4, -2)

if (ItemTextScrollFrame.ScrollBar.Background == nil) then
	ItemTextScrollFrame.ScrollBar.Background = ItemTextScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
	ItemTextScrollFrame.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
	ItemTextScrollFrame.ScrollBar.Background:SetAllPoints()
end

ApplyScrollBarArrow(ItemTextScrollFrame.ScrollBar)
ApplyScrollBarTrack(ItemTextScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(ItemTextScrollFrame.ScrollBar.Track.Thumb)

ItemTextFrame:HookScript("OnEvent", function(self, event)
	if ( event == "ITEM_TEXT_READY" ) then
		local defaultXSize = 512;
		local defaultYSize = 543;
		ItemTextFramePageBg:SetSize(defaultXSize, defaultYSize)
		ItemTextFramePageBg:SetTexture("Interface\\QuestFrame\\QuestBG")
	end
end)