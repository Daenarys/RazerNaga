local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AzeriteRespecUI" then
		AzeriteRespecFrameCloseButton:SetSize(32, 32)
		AzeriteRespecFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		AzeriteRespecFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		AzeriteRespecFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		AzeriteRespecFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		AzeriteRespecFrameCloseButton:ClearAllPoints()
		AzeriteRespecFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		AzeriteRespecFrameCloseButton:SetFrameLevel(2)

		AzeriteRespecFrame.PortraitContainer.CircleMask:Hide()

		AzeriteRespecFramePortrait:SetSize(61, 61)
		AzeriteRespecFramePortrait:ClearAllPoints()
		AzeriteRespecFramePortrait:SetPoint("TOPLEFT", -6, 8)

		AzeriteRespecFrame.TitleContainer:ClearAllPoints()
		AzeriteRespecFrame.TitleContainer:SetPoint("TOPLEFT", AzeriteRespecFrame, "TOPLEFT", 58, 0)
		AzeriteRespecFrame.TitleContainer:SetPoint("TOPRIGHT", AzeriteRespecFrame, "TOPRIGHT", -58, 0)

		AzeriteRespecFrame.TopTileStreaks:ClearAllPoints()
		AzeriteRespecFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		AzeriteRespecFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(AzeriteRespecFrame.NineSlice)
	end
end)