local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ItemUpgradeUI" then
		ItemUpgradeFrameCloseButton:SetSize(32, 32)
		ItemUpgradeFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ItemUpgradeFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ItemUpgradeFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ItemUpgradeFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ItemUpgradeFrameCloseButton:ClearAllPoints()
		ItemUpgradeFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ItemUpgradeFrameCloseButton:SetFrameLevel(2)

		ItemUpgradeFrame.PortraitContainer.CircleMask:Hide()

		ItemUpgradeFramePortrait:SetSize(61, 61)
		ItemUpgradeFramePortrait:ClearAllPoints()
		ItemUpgradeFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ItemUpgradeFrame.TitleContainer:ClearAllPoints()
		ItemUpgradeFrame.TitleContainer:SetPoint("TOPLEFT", ItemUpgradeFrame, "TOPLEFT", 58, 0)
		ItemUpgradeFrame.TitleContainer:SetPoint("TOPRIGHT", ItemUpgradeFrame, "TOPRIGHT", -58, 0)

		ItemUpgradeFrame:CreateTexture("ItemUpgradeFrameTitleBg")
		ItemUpgradeFrame.TitleBg = ItemUpgradeFrameTitleBg
		ItemUpgradeFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ItemUpgradeFrame.TitleBg:SetSize(256, 18)
		ItemUpgradeFrame.TitleBg:SetHorizTile(true)
		ItemUpgradeFrame.TitleBg:ClearAllPoints()
		ItemUpgradeFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ItemUpgradeFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ItemUpgradeFrame.TopTileStreaks:ClearAllPoints()
		ItemUpgradeFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ItemUpgradeFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ItemUpgradeFrame.NineSlice)
	end
end)