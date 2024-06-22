local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TrainerUI" then
		ClassTrainerFrame.ScrollBar:SetSize(25, 560)
		ClassTrainerFrame.ScrollBar:ClearAllPoints()
		ClassTrainerFrame.ScrollBar:SetPoint("TOPLEFT", ClassTrainerFrame.ScrollBox, "TOPRIGHT", -1, 3)
		ClassTrainerFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClassTrainerFrame.ScrollBox, "BOTTOMRIGHT", 2, -4)

		ApplyScrollBarArrow(ClassTrainerFrame.ScrollBar)
		ApplyScrollBarTrack(ClassTrainerFrame.ScrollBar.Track)
		ApplyScrollBarThumb(ClassTrainerFrame.ScrollBar.Track.Thumb)
	end
end)