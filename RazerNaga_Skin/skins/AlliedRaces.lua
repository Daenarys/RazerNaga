local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AlliedRacesUI" then
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetSize(25, 560)
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:ClearAllPoints()
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", AlliedRacesFrame.RaceInfoFrame.ScrollFrame, "TOPRIGHT", -2, 59)
		AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", AlliedRacesFrame.RaceInfoFrame.ScrollFrame, "BOTTOMRIGHT", -2, -5)

		if (AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Backplate == nil) then
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Backplate = AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar)
		ApplyScrollBarTrack(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(AlliedRacesFrame.RaceInfoFrame.ScrollFrame.ScrollBar.Track.Thumb)
	end
end)