local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GarrisonUI" then
		GarrisonCapacitiveDisplayFrameCloseButton:SetSize(32, 32)
		GarrisonCapacitiveDisplayFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		GarrisonCapacitiveDisplayFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		GarrisonCapacitiveDisplayFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		GarrisonCapacitiveDisplayFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		GarrisonCapacitiveDisplayFrameCloseButton:ClearAllPoints()
		GarrisonCapacitiveDisplayFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		GarrisonCapacitiveDisplayFrameCloseButton:SetFrameLevel(2)

		GarrisonCapacitiveDisplayFrame.PortraitContainer.CircleMask:Hide()

		GarrisonCapacitiveDisplayFramePortrait:SetSize(61, 61)
		GarrisonCapacitiveDisplayFramePortrait:ClearAllPoints()
		GarrisonCapacitiveDisplayFramePortrait:SetPoint("TOPLEFT", -6, 8)

		GarrisonCapacitiveDisplayFrame.TitleContainer:ClearAllPoints()
		GarrisonCapacitiveDisplayFrame.TitleContainer:SetPoint("TOPLEFT", GarrisonCapacitiveDisplayFrame, "TOPLEFT", 58, 0)
		GarrisonCapacitiveDisplayFrame.TitleContainer:SetPoint("TOPRIGHT", GarrisonCapacitiveDisplayFrame, "TOPRIGHT", -58, 0)

		GarrisonCapacitiveDisplayFrame:CreateTexture("GarrisonCapacitiveDisplayFrameTitleBg")
		GarrisonCapacitiveDisplayFrame.TitleBg = GarrisonCapacitiveDisplayFrameTitleBg
		GarrisonCapacitiveDisplayFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		GarrisonCapacitiveDisplayFrame.TitleBg:SetSize(256, 18)
		GarrisonCapacitiveDisplayFrame.TitleBg:SetHorizTile(true)
		GarrisonCapacitiveDisplayFrame.TitleBg:ClearAllPoints()
		GarrisonCapacitiveDisplayFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		GarrisonCapacitiveDisplayFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		GarrisonCapacitiveDisplayFrame.TopTileStreaks:ClearAllPoints()
		GarrisonCapacitiveDisplayFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		GarrisonCapacitiveDisplayFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(GarrisonCapacitiveDisplayFrame.NineSlice)
	end
end)