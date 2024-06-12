local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_NewPlayerExperienceGuide" then
		GuideFrame.ScrollFrame.ScrollBar:SetSize(25, 560)
		GuideFrame.ScrollFrame.ScrollBar:ClearAllPoints()
		GuideFrame.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", GuideFrame.ScrollFrame, "TOPRIGHT", -2, 70)
		GuideFrame.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", GuideFrame.ScrollFrame, "BOTTOMRIGHT", 1, -1)

		if (GuideFrame.ScrollFrame.ScrollBar.Backplate == nil) then
			GuideFrame.ScrollFrame.ScrollBar.Backplate = GuideFrame.ScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
			GuideFrame.ScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			GuideFrame.ScrollFrame.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(GuideFrame.ScrollFrame.ScrollBar)
		ApplyScrollBarTrack(GuideFrame.ScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(GuideFrame.ScrollFrame.ScrollBar.Track.Thumb)
	end
end)