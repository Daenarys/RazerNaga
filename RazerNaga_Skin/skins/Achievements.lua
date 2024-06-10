local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AchievementUI" then
		AchievementFrameCategories.ScrollBar:SetSize(25, 560)
		AchievementFrameCategories.ScrollBar:ClearAllPoints()
		AchievementFrameCategories.ScrollBar:SetPoint("TOPLEFT", AchievementFrameCategories.ScrollBox, "TOPRIGHT", -1, 3)
		AchievementFrameCategories.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameCategories.ScrollBox, "BOTTOMRIGHT", 1, -5)

		if (AchievementFrameCategories.ScrollBar.Backplate == nil) then
			AchievementFrameCategories.ScrollBar.Backplate = AchievementFrameCategories.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrameCategories.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrameCategories.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrameCategories.ScrollBar)
		ApplyScrollBarTrack(AchievementFrameCategories.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrameCategories.ScrollBar.Track.Thumb)

		AchievementFrameAchievements.ScrollBar:SetSize(25, 560)
		AchievementFrameAchievements.ScrollBar:ClearAllPoints()
		AchievementFrameAchievements.ScrollBar:SetPoint("TOPLEFT", AchievementFrameAchievements.ScrollBox, "TOPRIGHT", -1, 3)
		AchievementFrameAchievements.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameAchievements.ScrollBox, "BOTTOMRIGHT", 1, -5)

		if (AchievementFrameAchievements.ScrollBar.Backplate == nil) then
			AchievementFrameAchievements.ScrollBar.Backplate = AchievementFrameAchievements.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrameAchievements.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrameAchievements.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrameAchievements.ScrollBar)
		ApplyScrollBarTrack(AchievementFrameAchievements.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrameAchievements.ScrollBar.Track.Thumb)

		AchievementFrameStats.ScrollBar:SetSize(25, 560)
		AchievementFrameStats.ScrollBar:ClearAllPoints()
		AchievementFrameStats.ScrollBar:SetPoint("TOPLEFT", AchievementFrameStats.ScrollBox, "TOPRIGHT", -1, 3)
		AchievementFrameStats.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameStats.ScrollBox, "BOTTOMRIGHT", 1, -5)

		if (AchievementFrameStats.ScrollBar.Backplate == nil) then
			AchievementFrameStats.ScrollBar.Backplate = AchievementFrameStats.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrameStats.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrameStats.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrameStats.ScrollBar)
		ApplyScrollBarTrack(AchievementFrameStats.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrameStats.ScrollBar.Track.Thumb)

		AchievementFrameComparison.AchievementContainer.ScrollBar:SetSize(25, 560)
		AchievementFrameComparison.AchievementContainer.ScrollBar:ClearAllPoints()
		AchievementFrameComparison.AchievementContainer.ScrollBar:SetPoint("TOPLEFT", AchievementFrameComparison.Summary, "TOPRIGHT", 0, -4)
		AchievementFrameComparison.AchievementContainer.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameComparison.AchievementContainer, "BOTTOMRIGHT", 0, 4)

		if (AchievementFrameComparison.AchievementContainer.ScrollBar.Backplate == nil) then
			AchievementFrameComparison.AchievementContainer.ScrollBar.Backplate = AchievementFrameComparison.AchievementContainer.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrameComparison.AchievementContainer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrameComparison.AchievementContainer.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrameComparison.AchievementContainer.ScrollBar)
		ApplyScrollBarTrack(AchievementFrameComparison.AchievementContainer.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrameComparison.AchievementContainer.ScrollBar.Track.Thumb)

		AchievementFrameComparison.StatContainer.ScrollBar:SetSize(25, 560)
		AchievementFrameComparison.StatContainer.ScrollBar:ClearAllPoints()
		AchievementFrameComparison.StatContainer.ScrollBar:SetPoint("TOPLEFT", AchievementFrameComparison.Summary, "TOPRIGHT", 2, -4)
		AchievementFrameComparison.StatContainer.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrameComparison.StatContainer, "BOTTOMRIGHT", -2, 4)

		if (AchievementFrameComparison.StatContainer.ScrollBar.Backplate == nil) then
			AchievementFrameComparison.StatContainer.ScrollBar.Backplate = AchievementFrameComparison.StatContainer.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrameComparison.StatContainer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrameComparison.StatContainer.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrameComparison.StatContainer.ScrollBar)
		ApplyScrollBarTrack(AchievementFrameComparison.StatContainer.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrameComparison.StatContainer.ScrollBar.Track.Thumb)

		AchievementFrame.SearchResults.ScrollBar:SetSize(25, 560)
		AchievementFrame.SearchResults.ScrollBar:ClearAllPoints()
		AchievementFrame.SearchResults.ScrollBar:SetPoint("TOPLEFT", AchievementFrame.SearchResults.ScrollBox, "TOPRIGHT", -5, 2)
		AchievementFrame.SearchResults.ScrollBar:SetPoint("BOTTOMLEFT", AchievementFrame.SearchResults.ScrollBox, "BOTTOMRIGHT", 5, -1)

		if (AchievementFrame.SearchResults.ScrollBar.Backplate == nil) then
			AchievementFrame.SearchResults.ScrollBar.Backplate = AchievementFrame.SearchResults.ScrollBar:CreateTexture(nil, "BACKGROUND")
			AchievementFrame.SearchResults.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			AchievementFrame.SearchResults.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(AchievementFrame.SearchResults.ScrollBar)
		ApplyScrollBarTrack(AchievementFrame.SearchResults.ScrollBar.Track)
		ApplyScrollBarThumb(AchievementFrame.SearchResults.ScrollBar.Track.Thumb)

		ApplyFilterDropDown(AchievementFrameFilterDropdown)
	end
end)