if not _G.ObjectiveTrackerFrame then return end

local trackers = {
	_G.AchievementObjectiveTracker,
	_G.AdventureObjectiveTracker,
	_G.BonusObjectiveTracker,
	_G.CampaignQuestObjectiveTracker,
	_G.MonthlyActivitiesObjectiveTracker,
	_G.ProfessionsRecipeTracker,
	_G.QuestObjectiveTracker,
	_G.ScenarioObjectiveTracker,
	_G.WorldQuestObjectiveTracker
}

hooksecurefunc(ObjectiveTrackerFrame, "Update", function(self)
	self.Header:Hide()

	for _, tracker in pairs(trackers) do
		tracker.Header.Background:SetSize(300, 32)
		tracker.Header.Background:SetAtlas("UI-QuestTracker-Primary-Objective-Header")
		tracker.Header.Background:ClearAllPoints()
		tracker.Header.Background:SetPoint("CENTER", 0, 1)

		local button = tracker.Header.MinimizeButton
		if button then
			button:ClearAllPoints()
			button:SetPoint("RIGHT", -6, 0)
			button:SetNormalTexture("Interface/QuestFrame/QuestTracker")
			button:SetPushedTexture("Interface/QuestFrame/QuestTracker")
			button:SetHighlightAtlas("UI-QuestTrackerButton-Red-Highlight", "ADD")

			if tracker:IsCollapsed() then
				button:GetNormalTexture():SetTexCoord(0.933594, 0.96875, 0.242188, 0.316406)
				button:GetPushedTexture():SetTexCoord(0.894531, 0.929688, 0.324219, 0.398438)
			else
				button:GetNormalTexture():SetTexCoord(0.9375, 0.972656, 0.121094, 0.195312)
				button:GetPushedTexture():SetTexCoord(0.894531, 0.929688, 0.242188, 0.316406)
			end
		end
	end
end)