local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" or name == "Blizzard_Wardrobe" then
		WardrobeFrameCloseButton:SetSize(32, 32)
		WardrobeFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		WardrobeFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		WardrobeFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		WardrobeFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		WardrobeFrameCloseButton:ClearAllPoints()
		WardrobeFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		WardrobeFrameCloseButton:SetFrameLevel(2)

		WardrobeFrame.PortraitContainer.CircleMask:Hide()

		WardrobeFramePortrait:SetSize(61, 61)
		WardrobeFramePortrait:ClearAllPoints()
		WardrobeFramePortrait:SetPoint("TOPLEFT", -6, 8)

		WardrobeFrame.TitleContainer:ClearAllPoints()
		WardrobeFrame.TitleContainer:SetPoint("TOPLEFT", WardrobeFrame, "TOPLEFT", 58, 0)
		WardrobeFrame.TitleContainer:SetPoint("TOPRIGHT", WardrobeFrame, "TOPRIGHT", -58, 0)

		WardrobeFrame:CreateTexture("WardrobeFrameTitleBg")
		WardrobeFrame.TitleBg = WardrobeFrameTitleBg
		WardrobeFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		WardrobeFrame.TitleBg:SetSize(256, 18)
		WardrobeFrame.TitleBg:SetHorizTile(true)
		WardrobeFrame.TitleBg:ClearAllPoints()
		WardrobeFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		WardrobeFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		WardrobeFrame.TopTileStreaks:ClearAllPoints()
		WardrobeFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		WardrobeFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(WardrobeFrame.NineSlice)
		ApplyDialogBorder(WardrobeOutfitFrame.Border)
	end
end)