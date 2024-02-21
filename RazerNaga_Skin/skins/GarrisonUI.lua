local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GarrisonUI" then
		if _G.GarrisonMissionFrame then
			GarrisonMissionFrameMissions.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameMissions.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameMissions.ScrollBar.BG == nil) then
				GarrisonMissionFrameMissions.ScrollBar.BG = GarrisonMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonMissionFrameMissions.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				GarrisonMissionFrameMissions.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameMissions.ScrollBar.Track.Thumb)

			GarrisonMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonMissionFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			GarrisonMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (GarrisonMissionFrameFollowers.ScrollBar.BG == nil) then
				GarrisonMissionFrameFollowers.ScrollBar.BG = GarrisonMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonMissionFrameFollowers.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				GarrisonMissionFrameFollowers.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonMissionFrameFollowers.ScrollBar.Track.Thumb)
		end
		if _G.GarrisonShipyardFrame then
			GarrisonShipyardFrameFollowers.ScrollBar:SetSize(25, 560)
			GarrisonShipyardFrameFollowers.ScrollBar:ClearAllPoints()
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("TOPLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "TOPRIGHT", 4, 3)
			GarrisonShipyardFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", GarrisonShipyardFrameFollowers.ScrollBox, "BOTTOMRIGHT", 7, -1)

			if (GarrisonShipyardFrameFollowers.ScrollBar.BG == nil) then
				GarrisonShipyardFrameFollowers.ScrollBar.BG = GarrisonShipyardFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				GarrisonShipyardFrameFollowers.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				GarrisonShipyardFrameFollowers.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(GarrisonShipyardFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(GarrisonShipyardFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(GarrisonShipyardFrameFollowers.ScrollBar.Track.Thumb)
		end
		if _G.OrderHallMissionFrame then
			OrderHallMissionFrameMissions.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameMissions.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameMissions.ScrollBar.BG == nil) then
				OrderHallMissionFrameMissions.ScrollBar.BG = OrderHallMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				OrderHallMissionFrameMissions.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				OrderHallMissionFrameMissions.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameMissions.ScrollBar.Track.Thumb)
			
			OrderHallMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			OrderHallMissionFrameFollowers.ScrollBar:ClearAllPoints()
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", OrderHallMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			OrderHallMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", OrderHallMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (OrderHallMissionFrameFollowers.ScrollBar.BG == nil) then
				OrderHallMissionFrameFollowers.ScrollBar.BG = OrderHallMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				OrderHallMissionFrameFollowers.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				OrderHallMissionFrameFollowers.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(OrderHallMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(OrderHallMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(OrderHallMissionFrameFollowers.ScrollBar.Track.Thumb)
		end
		if _G.BFAMissionFrame then
			BFAMissionFrameMissions.ScrollBar:SetSize(25, 560)
			BFAMissionFrameMissions.ScrollBar:ClearAllPoints()
			BFAMissionFrameMissions.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameMissions.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameMissions.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameMissions.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameMissions.ScrollBar.BG == nil) then
				BFAMissionFrameMissions.ScrollBar.BG = BFAMissionFrameMissions.ScrollBar:CreateTexture(nil, "BACKGROUND");
				BFAMissionFrameMissions.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				BFAMissionFrameMissions.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameMissions.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameMissions.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameMissions.ScrollBar.Track.Thumb)

			BFAMissionFrameFollowers.ScrollBar:SetSize(25, 560)
			BFAMissionFrameFollowers.ScrollBar:ClearAllPoints()
			BFAMissionFrameFollowers.ScrollBar:SetPoint("TOPLEFT", BFAMissionFrameFollowers.ScrollBox, "TOPRIGHT", -4, 3)
			BFAMissionFrameFollowers.ScrollBar:SetPoint("BOTTOMLEFT", BFAMissionFrameFollowers.ScrollBox, "BOTTOMRIGHT", -1, -1)

			if (BFAMissionFrameFollowers.ScrollBar.BG == nil) then
				BFAMissionFrameFollowers.ScrollBar.BG = BFAMissionFrameFollowers.ScrollBar:CreateTexture(nil, "BACKGROUND");
				BFAMissionFrameFollowers.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
				BFAMissionFrameFollowers.ScrollBar.BG:SetAllPoints()
			end

			ApplyScrollBarArrow(BFAMissionFrameFollowers.ScrollBar)
			ApplyScrollBarTrack(BFAMissionFrameFollowers.ScrollBar.Track)
			ApplyScrollBarThumb(BFAMissionFrameFollowers.ScrollBar.Track.Thumb)
		end
	end
end)