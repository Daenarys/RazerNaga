local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ItemInteractionUI" then
		ItemInteractionFrameCloseButton:SetSize(32, 32)
		ItemInteractionFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ItemInteractionFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ItemInteractionFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ItemInteractionFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ItemInteractionFrameCloseButton:ClearAllPoints()
		ItemInteractionFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ItemInteractionFrameCloseButton:SetFrameLevel(2)

		ItemInteractionFrame.PortraitContainer.CircleMask:Hide()

		ItemInteractionFramePortrait:SetSize(61, 61)
		ItemInteractionFramePortrait:ClearAllPoints()
		ItemInteractionFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ItemInteractionFrame.TitleContainer:ClearAllPoints()
		ItemInteractionFrame.TitleContainer:SetPoint("TOPLEFT", ItemInteractionFrame, "TOPLEFT", 58, 0)
		ItemInteractionFrame.TitleContainer:SetPoint("TOPRIGHT", ItemInteractionFrame, "TOPRIGHT", -58, 0)

		ItemInteractionFrame:CreateTexture("ItemInteractionFrameTitleBg")
		ItemInteractionFrame.TitleBg = ItemInteractionFrameTitleBg
		ItemInteractionFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ItemInteractionFrame.TitleBg:SetSize(256, 18)
		ItemInteractionFrame.TitleBg:SetHorizTile(true)
		ItemInteractionFrame.TitleBg:ClearAllPoints()
		ItemInteractionFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ItemInteractionFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ItemInteractionFrame.TopTileStreaks:ClearAllPoints()
		ItemInteractionFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ItemInteractionFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ItemInteractionFrame.NineSlice)
	end
end)