local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GarrisonUI" then
		if _G.GarrisonBuildingFrame then
			GarrisonBuildingFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonMissionFrame then
			GarrisonMissionFrameMissions.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameMissions.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameMissions.ScrollBar.Backplate == nil) then
				GarrisonMissionFrameMissions.ScrollBar.Backplate = GarrisonMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonMissionFrameMissions.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonMissionFrameMissions.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameMissions.ScrollBar.Track.Thumb)

			GarrisonMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameFollowers.ScrollBar.Backplate == nil) then
				GarrisonMissionFrameFollowers.ScrollBar.Backplate = GarrisonMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonMissionFrameFollowers.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonMissionFrameFollowers.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameFollowers.ScrollBar.Track.Thumb)

			GarrisonMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonShipyardFrame then
			GarrisonShipyardFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonShipyardFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "TOPRIGHT", 4, 3)
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "BOTTOMRIGHT", 7, -1)

			if (GarrisonShipyardFrameFollowers.ScrollBar.Backplate == nil) then
				GarrisonShipyardFrameFollowers.ScrollBar.Backplate = GarrisonShipyardFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonShipyardFrameFollowers.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonShipyardFrameFollowers.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonShipyardFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonShipyardFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonShipyardFrameFollowers.ScrollBar.Track.Thumb)

			GarrisonShipyardFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.OrderHallMissionFrame then
			OrderHallMissionFrameMissions.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameMissions.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameMissions.ScrollBar.Backplate == nil) then
				OrderHallMissionFrameMissions.ScrollBar.Backplate = OrderHallMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND")
				OrderHallMissionFrameMissions.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				OrderHallMissionFrameMissions.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameMissions.ScrollBar.Track.Thumb)
			
			OrderHallMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameFollowers.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameFollowers.ScrollBar.Backplate == nil) then
				OrderHallMissionFrameFollowers.ScrollBar.Backplate = OrderHallMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND")
				OrderHallMissionFrameFollowers.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				OrderHallMissionFrameFollowers.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameFollowers.ScrollBar.Track.Thumb)

			OrderHallMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.BFAMissionFrame then
			BFAMissionFrameMissions.ScrollBar:SetSize(25, 560)
			BFAMissionFrameMissions.ScrollBar:ClearAllPoints()
			BFAMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameMissions.ScrollBar.Backplate == nil) then
				BFAMissionFrameMissions.ScrollBar.Backplate = BFAMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND")
				BFAMissionFrameMissions.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				BFAMissionFrameMissions.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameMissions.ScrollBar.Track.Thumb)

			BFAMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			BFAMissionFrameFollowers.ScrollBar:ClearAllPoints()
			BFAMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameFollowers.ScrollBar.Backplate == nil) then
				BFAMissionFrameFollowers.ScrollBar.Backplate = BFAMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND")
				BFAMissionFrameFollowers.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				BFAMissionFrameFollowers.ScrollBar.Backplate:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameFollowers.ScrollBar.Track.Thumb)

			BFAMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.CovenantMissionFrame then
			CovenantMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonLandingPageReportList then
			GarrisonLandingPageReportList.ScrollBar:SetSize(25, 560)
			GarrisonLandingPageReportList.ScrollBar:ClearAllPoints()
			GarrisonLandingPageReportList.ScrollBar:SetPoint("TOPLEFT", GarrisonLandingPageReportList.ScrollBox, "TOPRIGHT", -20, 1)
			GarrisonLandingPageReportList.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonLandingPageReportList.ScrollBox, "BOTTOMRIGHT", -17, -5)

			if (GarrisonLandingPageReportList.ScrollBar.Backplate == nil) then
				GarrisonLandingPageReportList.ScrollBar.Backplate = GarrisonLandingPageReportList.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonLandingPageReportList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonLandingPageReportList.ScrollBar.Backplate:SetAllPoints()
			end

			GarrisonLandingPageReportList.ScrollBar.Track:ClearAllPoints()
			GarrisonLandingPageReportList.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
			GarrisonLandingPageReportList.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

			GarrisonLandingPageReportList.ScrollBar.Track.Begin:Hide()
			GarrisonLandingPageReportList.ScrollBar.Track.End:Hide()
			GarrisonLandingPageReportList.ScrollBar.Track.Middle:Hide()

			ApplyScrollBarArrow(GarrisonLandingPageReportList.ScrollBar)
			ApplyScrollBarThumb(GarrisonLandingPageReportList.ScrollBar.Track.Thumb)
		end
		if _G.GarrisonLandingPageFollowerList then
			GarrisonLandingPageFollowerList.ScrollBar:SetSize(25, 560)
			GarrisonLandingPageFollowerList.ScrollBar:ClearAllPoints()
			GarrisonLandingPageFollowerList.ScrollBar:SetPoint("TOPLEFT", GarrisonLandingPageFollowerList.ScrollBox, "TOPRIGHT", -20, 1)
			GarrisonLandingPageFollowerList.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonLandingPageFollowerList.ScrollBox, "BOTTOMRIGHT", -17, -5)

			if (GarrisonLandingPageFollowerList.ScrollBar.Backplate == nil) then
				GarrisonLandingPageFollowerList.ScrollBar.Backplate = GarrisonLandingPageFollowerList.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonLandingPageFollowerList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonLandingPageFollowerList.ScrollBar.Backplate:SetAllPoints()
			end

			GarrisonLandingPageFollowerList.ScrollBar.Track:SetWidth(18)
			GarrisonLandingPageFollowerList.ScrollBar.Track:ClearAllPoints()
			GarrisonLandingPageFollowerList.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
			GarrisonLandingPageFollowerList.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

			ApplyScrollBarArrow(GarrisonLandingPageFollowerList.ScrollBar)
			ApplyScrollBarTrack(GarrisonLandingPageFollowerList.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonLandingPageFollowerList.ScrollBar.Track.Thumb)
		end
		if _G.GarrisonRecruitSelectFrame then
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar:SetSize(25, 560)
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar:ClearAllPoints()
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar:SetPoint("TOPLEFT", GarrisonRecruitSelectFrame.FollowerList.ScrollBox, "TOPRIGHT", -4, 0)
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonRecruitSelectFrame.FollowerList.ScrollBox, "BOTTOMRIGHT", -1, -3)

			if (GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Backplate == nil) then
				GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Backplate = GarrisonRecruitSelectFrame.FollowerList.ScrollBar:CreateTexture(nil, "BACKGROUND")
				GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Backplate:SetAllPoints()
			end

			GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track:SetWidth(18)
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track:ClearAllPoints()
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
			GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

			ApplyScrollBarArrow(GarrisonRecruitSelectFrame.FollowerList.ScrollBar)
			ApplyScrollBarTrack(GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonRecruitSelectFrame.FollowerList.ScrollBar.Track.Thumb)

			GarrisonRecruitSelectFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonMonumentFrame then
			GarrisonMonumentFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("BOTTOM", 0 , 125)
			end)
		end
	end
end)