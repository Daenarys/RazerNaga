local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_NewPlayerExperienceGuide" then
		GuideFrameCloseButton:SetSize(32, 32)
		GuideFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		GuideFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		GuideFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		GuideFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		GuideFrameCloseButton:ClearAllPoints()
		GuideFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		GuideFrameCloseButton:SetFrameLevel(2)

		GuideFrame.PortraitContainer.CircleMask:Hide()

		GuideFramePortrait:SetSize(61, 61)
		GuideFramePortrait:ClearAllPoints()
		GuideFramePortrait:SetPoint("TOPLEFT", -6, 8)

		GuideFrame.TitleContainer:ClearAllPoints()
		GuideFrame.TitleContainer:SetPoint("TOPLEFT", GuideFrame, "TOPLEFT", 58, 0)
		GuideFrame.TitleContainer:SetPoint("TOPRIGHT", GuideFrame, "TOPRIGHT", -58, 0)

		GuideFrame:CreateTexture("GuideFrameTitleBg")
		GuideFrame.TitleBg = GuideFrameTitleBg
		GuideFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		GuideFrame.TitleBg:SetSize(256, 18)
		GuideFrame.TitleBg:SetHorizTile(true)
		GuideFrame.TitleBg:ClearAllPoints()
		GuideFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		GuideFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		GuideFrame.TopTileStreaks:ClearAllPoints()
		GuideFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		GuideFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(GuideFrame.NineSlice)

		GuideFrame.ScrollFrame.ScrollBar:SetSize(25, 560)
		GuideFrame.ScrollFrame.ScrollBar:ClearAllPoints()
		GuideFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", GuideFrame.ScrollFrame, "TOPRIGHT", -2, 70)
		GuideFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", GuideFrame.ScrollFrame, "BOTTOMRIGHT", 1, -1)

		if (GuideFrame.ScrollFrame.ScrollBar.Background == nil) then
			GuideFrame.ScrollFrame.ScrollBar.Background = GuideFrame.ScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
			GuideFrame.ScrollFrame.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			GuideFrame.ScrollFrame.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(GuideFrame.ScrollFrame.ScrollBar)
		ApplyScrollBarTrack(GuideFrame.ScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(GuideFrame.ScrollFrame.ScrollBar.Track.Thumb)
	end
end)