local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_IslandsQueueUI" then
		IslandsQueueFrameCloseButton:SetSize(32, 32)
		IslandsQueueFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		IslandsQueueFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		IslandsQueueFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		IslandsQueueFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		IslandsQueueFrameCloseButton:ClearAllPoints()
		IslandsQueueFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		IslandsQueueFrameCloseButton:SetFrameLevel(2)

		IslandsQueueFrame.PortraitContainer.CircleMask:Hide()

		IslandsQueueFramePortrait:SetSize(61, 61)
		IslandsQueueFramePortrait:ClearAllPoints()
		IslandsQueueFramePortrait:SetPoint("TOPLEFT", -6, 8)

		IslandsQueueFrame.TutorialFrame.CloseButton:SetSize(32, 32)
		IslandsQueueFrame.TutorialFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		IslandsQueueFrame.TutorialFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		IslandsQueueFrame.TutorialFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		IslandsQueueFrame.TutorialFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

		IslandsQueueFrame.HelpButton.Ring:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\MiniMap-TrackingBorder.png")

		ApplyNineSlicePortrait(IslandsQueueFrame.NineSlice)
	end
end)