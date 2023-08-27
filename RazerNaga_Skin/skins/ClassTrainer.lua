local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TrainerUI" then
		ClassTrainerFrameCloseButton:SetSize(32, 32)
		ClassTrainerFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ClassTrainerFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ClassTrainerFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ClassTrainerFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ClassTrainerFrameCloseButton:ClearAllPoints()
		ClassTrainerFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ClassTrainerFrameCloseButton:SetFrameLevel(2)

		ClassTrainerFrame.PortraitContainer.CircleMask:Hide()

		ClassTrainerFramePortrait:SetSize(61, 61)
		ClassTrainerFramePortrait:ClearAllPoints()
		ClassTrainerFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ClassTrainerFrame.TitleContainer:ClearAllPoints()
		ClassTrainerFrame.TitleContainer:SetPoint("TOPLEFT", ClassTrainerFrame, "TOPLEFT", 58, 0)
		ClassTrainerFrame.TitleContainer:SetPoint("TOPRIGHT", ClassTrainerFrame, "TOPRIGHT", -58, 0)

		ClassTrainerFrame:CreateTexture("ClassTrainerFrameTitleBg")
		ClassTrainerFrame.TitleBg = ClassTrainerFrameTitleBg
		ClassTrainerFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ClassTrainerFrame.TitleBg:SetSize(256, 18)
		ClassTrainerFrame.TitleBg:SetHorizTile(true)
		ClassTrainerFrame.TitleBg:ClearAllPoints()
		ClassTrainerFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ClassTrainerFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ClassTrainerFrame.TopTileStreaks:ClearAllPoints()
		ClassTrainerFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ClassTrainerFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ClassTrainerFrame.NineSlice)

		ClassTrainerFrame.ScrollBar:SetSize(25, 560)
		ClassTrainerFrame.ScrollBar:ClearAllPoints()
		ClassTrainerFrame.ScrollBar:SetPoint("TOPLEFT", ClassTrainerFrame.ScrollBox, "TOPRIGHT", -1, 3)
		ClassTrainerFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClassTrainerFrame.ScrollBox, "BOTTOMRIGHT", 2, -4)

		ApplyScrollBarArrow(ClassTrainerFrame.ScrollBar)
		ApplyScrollBarTrack(ClassTrainerFrame.ScrollBar.Track)
		ApplyScrollBarThumb(ClassTrainerFrame.ScrollBar.Track.Thumb)
	end
end)