local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ItemSocketingUI" then
		ItemSocketingFrameCloseButton:SetSize(32, 32)
		ItemSocketingFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ItemSocketingFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ItemSocketingFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ItemSocketingFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ItemSocketingFrameCloseButton:ClearAllPoints()
		ItemSocketingFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ItemSocketingFrameCloseButton:SetFrameLevel(2)

		ItemSocketingFrame.PortraitContainer.CircleMask:Hide()

		ItemSocketingFramePortrait:SetSize(61, 61)
		ItemSocketingFramePortrait:ClearAllPoints()
		ItemSocketingFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ItemSocketingFrame.TitleContainer:ClearAllPoints()
		ItemSocketingFrame.TitleContainer:SetPoint("TOPLEFT", ItemSocketingFrame, "TOPLEFT", 58, 0)
		ItemSocketingFrame.TitleContainer:SetPoint("TOPRIGHT", ItemSocketingFrame, "TOPRIGHT", -58, 0)

		ItemSocketingFrame:CreateTexture("ItemSocketingFrameTitleBg")
		ItemSocketingFrame.TitleBg = ItemSocketingFrameTitleBg
		ItemSocketingFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ItemSocketingFrame.TitleBg:SetSize(256, 18)
		ItemSocketingFrame.TitleBg:SetHorizTile(true)
		ItemSocketingFrame.TitleBg:ClearAllPoints()
		ItemSocketingFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ItemSocketingFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ItemSocketingFrame.TopTileStreaks:ClearAllPoints()
		ItemSocketingFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ItemSocketingFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ItemSocketingFrame.NineSlice)
	end
end)