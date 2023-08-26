local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TimeManager" then
		TimeManagerFrameCloseButton:SetSize(32, 32)
		TimeManagerFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		TimeManagerFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		TimeManagerFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		TimeManagerFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		TimeManagerFrameCloseButton:ClearAllPoints()
		TimeManagerFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		TimeManagerFrameCloseButton:SetFrameLevel(4)

		TimeManagerFrame.PortraitContainer.CircleMask:Hide()

		TimeManagerFramePortrait:SetSize(61, 61)
		TimeManagerFramePortrait:ClearAllPoints()
		TimeManagerFramePortrait:SetPoint("TOPLEFT", -6, 8)

		TimeManagerFrame.TitleContainer:ClearAllPoints()
		TimeManagerFrame.TitleContainer:SetPoint("TOPLEFT", TimeManagerFrame, "TOPLEFT", 74, 0)
		TimeManagerFrame.TitleContainer:SetPoint("TOPRIGHT", TimeManagerFrame, "TOPRIGHT", -41, 0)

		TimeManagerFrameTitleText:SetTextColor(255, 255, 255, 1)
		TimeManagerFrameTitleText:SetText(TIMEMANAGER_TITLE)

		TimeManagerFrame:CreateTexture("TimeManagerFrameTitleBg")
		TimeManagerFrame.TitleBg = TimeManagerFrameTitleBg
		TimeManagerFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		TimeManagerFrame.TitleBg:SetSize(256, 18)
		TimeManagerFrame.TitleBg:SetHorizTile(true)
		TimeManagerFrame.TitleBg:ClearAllPoints()
		TimeManagerFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		TimeManagerFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		TimeManagerFrame.TopTileStreaks:ClearAllPoints()
		TimeManagerFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		TimeManagerFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(TimeManagerFrame.NineSlice)
		
		StopwatchCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		StopwatchCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		StopwatchCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		StopwatchCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		StopwatchCloseButton:ClearAllPoints()
		StopwatchCloseButton:SetPoint("TOPRIGHT", 1, 1)
	end
end)