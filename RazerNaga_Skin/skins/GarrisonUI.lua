local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GarrisonUI" then
		if _G.GarrisonBuildingFrame then
			GarrisonBuildingFrame.CloseButton:SetSize(32, 32)
			GarrisonBuildingFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonBuildingFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonBuildingFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonBuildingFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonBuildingFrame.CloseButton:ClearAllPoints()
			GarrisonBuildingFrame.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			GarrisonBuildingFrameTutorialButton.Ring:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\MiniMap-TrackingBorder.png")
		end
		if _G.GarrisonMissionFrame then
			GarrisonMissionFrame.CloseButton:SetSize(32, 32)
			GarrisonMissionFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonMissionFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonMissionFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonMissionFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonMissionFrame.CloseButton:ClearAllPoints()
			GarrisonMissionFrame.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:ClearAllPoints()
			GarrisonMissionFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			GarrisonMissionFrameMissions.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameMissions.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameMissions.ScrollBar.Background == nil) then
				GarrisonMissionFrameMissions.ScrollBar.Background = GarrisonMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonMissionFrameMissions.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				GarrisonMissionFrameMissions.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameMissions.ScrollBar.Track.Thumb)

			GarrisonMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameFollowers.ScrollBar.Background == nil) then
				GarrisonMissionFrameFollowers.ScrollBar.Background = GarrisonMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonMissionFrameFollowers.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				GarrisonMissionFrameFollowers.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameFollowers.ScrollBar.Track.Thumb)
		end
		if _G.GarrisonRecruiterFrame then
			GarrisonRecruiterFrameCloseButton:SetSize(32, 32)
			GarrisonRecruiterFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonRecruiterFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonRecruiterFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonRecruiterFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonRecruiterFrameCloseButton:ClearAllPoints()
			GarrisonRecruiterFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
			GarrisonRecruiterFrameCloseButton:SetFrameLevel(2)
			
			GarrisonRecruiterFrame.PortraitContainer.CircleMask:Hide()

			GarrisonRecruiterFramePortrait:SetSize(61, 61)
			GarrisonRecruiterFramePortrait:ClearAllPoints()
			GarrisonRecruiterFramePortrait:SetPoint("TOPLEFT", -6, 8)

			GarrisonRecruiterFrame:CreateTexture("GarrisonRecruiterFrameTitleBg")
			GarrisonRecruiterFrame.TitleBg = GarrisonRecruiterFrameTitleBg
			GarrisonRecruiterFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
			GarrisonRecruiterFrame.TitleBg:SetSize(256, 18)
			GarrisonRecruiterFrame.TitleBg:SetHorizTile(true)
			GarrisonRecruiterFrame.TitleBg:ClearAllPoints()
			GarrisonRecruiterFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
			GarrisonRecruiterFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

			GarrisonRecruiterFrame.TopTileStreaks:ClearAllPoints()
			GarrisonRecruiterFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
			GarrisonRecruiterFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

			ApplyNineSlicePortrait(GarrisonRecruiterFrame.NineSlice)
		end
		if _G.GarrisonShipyardFrame then
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetSize(32, 32)
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonShipyardFrame.BorderFrame.CloseButton2:ClearAllPoints()
			GarrisonShipyardFrame.BorderFrame.CloseButton2:SetPoint("TOPRIGHT", 4, 5)

			GarrisonShipyardFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonShipyardFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "TOPRIGHT", 4, 3)
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "BOTTOMRIGHT", 7, -1)

			if (GarrisonShipyardFrameFollowers.ScrollBar.Background == nil) then
				GarrisonShipyardFrameFollowers.ScrollBar.Background = GarrisonShipyardFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonShipyardFrameFollowers.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				GarrisonShipyardFrameFollowers.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonShipyardFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonShipyardFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonShipyardFrameFollowers.ScrollBar.Track.Thumb)

			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:ClearAllPoints()
			GarrisonShipyardFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", 5, 5)
		end
		if _G.OrderHallMissionFrame then
			OrderHallMissionFrame.CloseButton:SetSize(32, 32)
			OrderHallMissionFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			OrderHallMissionFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			OrderHallMissionFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			OrderHallMissionFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			OrderHallMissionFrame.CloseButton:ClearAllPoints()
			OrderHallMissionFrame.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:ClearAllPoints()
			OrderHallMissionFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			OrderHallMissionFrameMissions.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameMissions.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameMissions.ScrollBar.Background == nil) then
				OrderHallMissionFrameMissions.ScrollBar.Background = OrderHallMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				OrderHallMissionFrameMissions.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				OrderHallMissionFrameMissions.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameMissions.ScrollBar.Track.Thumb)
			
			OrderHallMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameFollowers.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameFollowers.ScrollBar.Background == nil) then
				OrderHallMissionFrameFollowers.ScrollBar.Background = OrderHallMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				OrderHallMissionFrameFollowers.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				OrderHallMissionFrameFollowers.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameFollowers.ScrollBar.Track.Thumb)

			for i = 1, 2 do
				ApplyBottomTab(_G['OrderHallMissionFrameTab'..i])

				_G['OrderHallMissionFrameTab'..i]:HookScript("OnShow", function(self)
					self:SetWidth(40 + self:GetFontString():GetStringWidth())
					OrderHallMissionFrameTab2:ClearAllPoints()
					OrderHallMissionFrameTab2:SetPoint("LEFT", OrderHallMissionFrameTab1, "RIGHT", -15, 0)
				end)
			end
		end
		if _G.BFAMissionFrame then
			BFAMissionFrame.CloseButton:SetSize(32, 32)
			BFAMissionFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			BFAMissionFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			BFAMissionFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			BFAMissionFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			BFAMissionFrame.CloseButton:ClearAllPoints()
			BFAMissionFrame.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			BFAMissionFrame.MissionTab.MissionPage.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			BFAMissionFrame.MissionTab.MissionPage.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			BFAMissionFrame.MissionTab.MissionPage.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			BFAMissionFrame.MissionTab.MissionPage.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			BFAMissionFrame.MissionTab.MissionPage.CloseButton:ClearAllPoints()
			BFAMissionFrame.MissionTab.MissionPage.CloseButton:SetPoint("TOPRIGHT", 5, 5)

			BFAMissionFrameMissions.ScrollBar:SetSize(25, 560)
			BFAMissionFrameMissions.ScrollBar:ClearAllPoints()
			BFAMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameMissions.ScrollBar.Background == nil) then
				BFAMissionFrameMissions.ScrollBar.Background = BFAMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				BFAMissionFrameMissions.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				BFAMissionFrameMissions.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameMissions.ScrollBar.Track.Thumb)

			BFAMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			BFAMissionFrameFollowers.ScrollBar:ClearAllPoints()
			BFAMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameFollowers.ScrollBar.Background == nil) then
				BFAMissionFrameFollowers.ScrollBar.Background = BFAMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				BFAMissionFrameFollowers.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
				BFAMissionFrameFollowers.ScrollBar.Background:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameFollowers.ScrollBar.Track.Thumb)

			for i = 1, 3 do
				ApplyBottomTab(_G['BFAMissionFrameTab'..i])

				_G['BFAMissionFrameTab'..i]:HookScript("OnShow", function(self)
					self:SetWidth(40 + self:GetFontString():GetStringWidth())
					BFAMissionFrameTab2:ClearAllPoints()
					BFAMissionFrameTab2:SetPoint("LEFT", BFAMissionFrameTab1, "RIGHT", -15, 0)
					BFAMissionFrameTab3:ClearAllPoints()
					BFAMissionFrameTab3:SetPoint("LEFT", BFAMissionFrameTab2, "RIGHT", -15, 0)
				end)
			end
		end
		if _G.CovenantMissionFrame then
			CovenantMissionFrame.CloseButton:SetSize(32, 32)
			CovenantMissionFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			CovenantMissionFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			CovenantMissionFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			CovenantMissionFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

			CovenantMissionFrame.MissionTab.MissionPage.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			CovenantMissionFrame.MissionTab.MissionPage.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			CovenantMissionFrame.MissionTab.MissionPage.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			CovenantMissionFrame.MissionTab.MissionPage.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

			for i = 1, 2 do
				ApplyBottomTab(_G['CovenantMissionFrameTab'..i])

				_G['CovenantMissionFrameTab'..i]:HookScript("OnShow", function(self)
					self:SetWidth(40 + self:GetFontString():GetStringWidth())
					CovenantMissionFrameTab2:ClearAllPoints()
					CovenantMissionFrameTab2:SetPoint("LEFT", CovenantMissionFrameTab1, "RIGHT", -15, 0)
				end)
			end
		end
	end
end)