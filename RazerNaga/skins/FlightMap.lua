local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_FlightMap" then
		FlightMapFrameCloseButton:SetSize(32, 32)
		FlightMapFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		FlightMapFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		FlightMapFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		FlightMapFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		FlightMapFrameCloseButton:ClearAllPoints()
		FlightMapFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		FlightMapFrameCloseButton:SetFrameLevel(2)

		FlightMapFrame.BorderFrame.PortraitContainer.CircleMask:Hide()

		FlightMapFramePortrait:SetSize(61, 61)
		FlightMapFramePortrait:ClearAllPoints()
		FlightMapFramePortrait:SetPoint("TOPLEFT", -6, 8)

		FlightMapFrame.BorderFrame.TitleContainer:ClearAllPoints()
		FlightMapFrame.BorderFrame.TitleContainer:SetPoint("TOPLEFT", FlightMapFrame, "TOPLEFT", 58, 0)
		FlightMapFrame.BorderFrame.TitleContainer:SetPoint("TOPRIGHT", FlightMapFrame, "TOPRIGHT", -58, 0)

		FlightMapFrame:CreateTexture("FlightMapFrameTitleBg")
		FlightMapFrame.BorderFrame.TitleBg = FlightMapFrameTitleBg
		FlightMapFrame.BorderFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		FlightMapFrame.BorderFrame.TitleBg:SetSize(256, 18)
		FlightMapFrame.BorderFrame.TitleBg:SetHorizTile(true)
		FlightMapFrame.BorderFrame.TitleBg:ClearAllPoints()
		FlightMapFrame.BorderFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		FlightMapFrame.BorderFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		FlightMapFrame.BorderFrame.TopTileStreaks:ClearAllPoints()
		FlightMapFrame.BorderFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		FlightMapFrame.BorderFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(FlightMapFrame.BorderFrame.NineSlice)
		
		_G.FlightMapFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("CENTER")
		end)
	end
end)