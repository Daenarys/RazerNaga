if not _G.GossipFrame then return end

GossipFrameCloseButton:SetSize(32, 32)
GossipFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
GossipFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
GossipFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
GossipFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
GossipFrameCloseButton:ClearAllPoints()
GossipFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
GossipFrameCloseButton:SetFrameLevel(2)

GossipFrame.PortraitContainer.CircleMask:Hide()

GossipFramePortrait:SetSize(61, 61)
GossipFramePortrait:ClearAllPoints()
GossipFramePortrait:SetPoint("TOPLEFT", -6, 8)

GossipFrame.TitleContainer:ClearAllPoints()
GossipFrame.TitleContainer:SetPoint("TOPLEFT", GossipFrame, "TOPLEFT", 66, -1)
GossipFrame.TitleContainer:SetPoint("TOPRIGHT", GossipFrame, "TOPRIGHT", -60, 1)

GossipFrame:CreateTexture("GossipFrameTitleBg")
GossipFrame.TitleBg = GossipFrameTitleBg
GossipFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
GossipFrame.TitleBg:SetSize(256, 18)
GossipFrame.TitleBg:SetHorizTile(true)
GossipFrame.TitleBg:ClearAllPoints()
GossipFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
GossipFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

GossipFrame.TopTileStreaks:ClearAllPoints()
GossipFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
GossipFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(GossipFrame.NineSlice)

GossipFrame.GreetingPanel.ScrollBox:ClearAllPoints()
GossipFrame.GreetingPanel.ScrollBox:SetPoint("TOPLEFT", 5, -65)

GossipFrame.GreetingPanel.ScrollBar:SetSize(25, 560)
GossipFrame.GreetingPanel.ScrollBar:ClearAllPoints()
GossipFrame.GreetingPanel.ScrollBar:SetPoint("TOPLEFT", GossipFrame.GreetingPanel.ScrollBox, "TOPRIGHT", 2, 3)
GossipFrame.GreetingPanel.ScrollBar:SetPoint("BOTTOMLEFT", GossipFrame.GreetingPanel.ScrollBox, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(GossipFrame.GreetingPanel.ScrollBar)
ApplyScrollBarTrack(GossipFrame.GreetingPanel.ScrollBar.Track)
ApplyScrollBarThumb(GossipFrame.GreetingPanel.ScrollBar.Track.Thumb)

hooksecurefunc(GossipFrame, "HandleShow", function(self, textureKit)
	if not textureKit then
		local defaultXSize = 510;
		local defaultYSize = 620;
		self.Background:SetSize(defaultXSize, defaultYSize);
		self.Background:SetTexture("Interface/QuestFrame/QuestBG");
	end
end)