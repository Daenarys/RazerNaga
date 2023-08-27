local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AlliedRacesUI" then
		AlliedRacesFrameCloseButton:SetSize(32, 32)
		AlliedRacesFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		AlliedRacesFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		AlliedRacesFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		AlliedRacesFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		AlliedRacesFrameCloseButton:ClearAllPoints()
		AlliedRacesFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		AlliedRacesFrameCloseButton:SetFrameLevel(2)

		AlliedRacesFrame.PortraitContainer.CircleMask:Hide()

		AlliedRacesFramePortrait:SetSize(61, 61)
		AlliedRacesFramePortrait:ClearAllPoints()
		AlliedRacesFramePortrait:SetPoint("TOPLEFT", -6, 8)

		AlliedRacesFrame.TitleContainer:ClearAllPoints()
		AlliedRacesFrame.TitleContainer:SetPoint("TOPLEFT", AlliedRacesFrame, "TOPLEFT", 58, 0)
		AlliedRacesFrame.TitleContainer:SetPoint("TOPRIGHT", AlliedRacesFrame, "TOPRIGHT", -58, 0)

		AlliedRacesFrame:CreateTexture("AlliedRacesFrameTitleBg")
		AlliedRacesFrame.TitleBg = AlliedRacesFrameTitleBg
		AlliedRacesFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		AlliedRacesFrame.TitleBg:SetSize(256, 18)
		AlliedRacesFrame.TitleBg:SetHorizTile(true)
		AlliedRacesFrame.TitleBg:ClearAllPoints()
		AlliedRacesFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		AlliedRacesFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		AlliedRacesFrame.TopTileStreaks:ClearAllPoints()
		AlliedRacesFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		AlliedRacesFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(AlliedRacesFrame.NineSlice)

		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetSize(25, 560)
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:ClearAllPoints()
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", AlliedRacesFrame.RaceInfoFrame.ScrollFrame, "TOPRIGHT", -2, 59)
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", AlliedRacesFrame.RaceInfoFrame.ScrollFrame, "BOTTOMRIGHT", -2, -5)

		if (AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Background == nil) then
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Background = AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Background:SetColorTexture(0, 0, 0, 1)
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar)
		ApplyScrollBarTrack(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Track.Thumb)
	end
end)