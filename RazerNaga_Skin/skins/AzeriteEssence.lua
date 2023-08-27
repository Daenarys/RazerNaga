local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AzeriteEssenceUI" then
		AzeriteEssenceUICloseButton:SetSize(32, 32)
		AzeriteEssenceUICloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		AzeriteEssenceUICloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		AzeriteEssenceUICloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		AzeriteEssenceUICloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		AzeriteEssenceUICloseButton:ClearAllPoints()
		AzeriteEssenceUICloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		AzeriteEssenceUICloseButton:SetFrameLevel(2)

		AzeriteEssenceUI.PortraitContainer.CircleMask:Hide()

		AzeriteEssenceUIPortrait:SetSize(61, 61)
		AzeriteEssenceUIPortrait:ClearAllPoints()
		AzeriteEssenceUIPortrait:SetPoint("TOPLEFT", -6, 8)

		AzeriteEssenceUI.TitleContainer:ClearAllPoints()
		AzeriteEssenceUI.TitleContainer:SetPoint("TOPLEFT", AzeriteEssenceUI, "TOPLEFT", 58, 0)
		AzeriteEssenceUI.TitleContainer:SetPoint("TOPRIGHT", AzeriteEssenceUI, "TOPRIGHT", -58, 0)

		AzeriteEssenceUI:CreateTexture("AzeriteEssenceUITitleBg")
		AzeriteEssenceUI.TitleBg = AzeriteEssenceUITitleBg
		AzeriteEssenceUI.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		AzeriteEssenceUI.TitleBg:SetSize(256, 18)
		AzeriteEssenceUI.TitleBg:SetHorizTile(true)
		AzeriteEssenceUI.TitleBg:ClearAllPoints()
		AzeriteEssenceUI.TitleBg:SetPoint("TOPLEFT", 2, -3)
		AzeriteEssenceUI.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		AzeriteEssenceUI.TopTileStreaks:ClearAllPoints()
		AzeriteEssenceUI.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		AzeriteEssenceUI.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		AzeriteEssenceUI.PowerLevelBadgeFrame.Ring:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\MiniMap-TrackingBorder.png")

		ApplyNineSlicePortrait(AzeriteEssenceUI.NineSlice)

		AzeriteEssenceUI.EssenceList.ScrollBar:SetSize(25, 560)
		AzeriteEssenceUI.EssenceList.ScrollBar:ClearAllPoints()
		AzeriteEssenceUI.EssenceList.ScrollBar:SetPoint("TOPLEFT", AzeriteEssenceUI.EssenceList.ScrollBox, "TOPRIGHT", -2, 5)
		AzeriteEssenceUI.EssenceList.ScrollBar:SetPoint("BOTTOMLEFT", AzeriteEssenceUI.EssenceList.ScrollBox, "BOTTOMRIGHT", 1, -2)

		ApplyScrollBarArrow(AzeriteEssenceUI.EssenceList.ScrollBar)
		ApplyScrollBarTrack(AzeriteEssenceUI.EssenceList.ScrollBar.Track)
		ApplyScrollBarThumb(AzeriteEssenceUI.EssenceList.ScrollBar.Track.Thumb)
	end
end)