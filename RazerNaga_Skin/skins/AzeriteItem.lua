local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AzeriteUI" then
		AzeriteEmpoweredItemUICloseButton:SetSize(32, 32)
		AzeriteEmpoweredItemUICloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		AzeriteEmpoweredItemUICloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		AzeriteEmpoweredItemUICloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		AzeriteEmpoweredItemUICloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		AzeriteEmpoweredItemUICloseButton:ClearAllPoints()
		AzeriteEmpoweredItemUICloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		AzeriteEmpoweredItemUICloseButton:SetFrameLevel(2)

		AzeriteEmpoweredItemUI.BorderFrame.PortraitContainer.CircleMask:Hide()

		AzeriteEmpoweredItemUIPortrait:SetSize(61, 61)
		AzeriteEmpoweredItemUIPortrait:ClearAllPoints()
		AzeriteEmpoweredItemUIPortrait:SetPoint("TOPLEFT", -6, 8)

		AzeriteEmpoweredItemUI.BorderFrame.TitleContainer:ClearAllPoints()
		AzeriteEmpoweredItemUI.BorderFrame.TitleContainer:SetPoint("TOPLEFT", AzeriteEmpoweredItemUI, "TOPLEFT", 58, 0)
		AzeriteEmpoweredItemUI.BorderFrame.TitleContainer:SetPoint("TOPRIGHT", AzeriteEmpoweredItemUI, "TOPRIGHT", -58, 0)

		AzeriteEmpoweredItemUI:CreateTexture("AzeriteEmpoweredItemUITitleBg")
		AzeriteEmpoweredItemUI.TitleBg = AzeriteEmpoweredItemUITitleBg
		AzeriteEmpoweredItemUI.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		AzeriteEmpoweredItemUI.TitleBg:SetSize(256, 18)
		AzeriteEmpoweredItemUI.TitleBg:SetHorizTile(true)
		AzeriteEmpoweredItemUI.TitleBg:ClearAllPoints()
		AzeriteEmpoweredItemUI.TitleBg:SetPoint("TOPLEFT", 2, -3)
		AzeriteEmpoweredItemUI.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		AzeriteEmpoweredItemUI.BorderFrame.TopTileStreaks:ClearAllPoints()
		AzeriteEmpoweredItemUI.BorderFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		AzeriteEmpoweredItemUI.BorderFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(AzeriteEmpoweredItemUI.BorderFrame.NineSlice)
	end
end)