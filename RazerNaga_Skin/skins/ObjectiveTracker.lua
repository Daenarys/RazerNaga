if not _G.ObjectiveTrackerFrame then return end

ObjectiveTrackerFrame.Header:Hide()

local function SetCollapsed(self, collapsed)
	local normalTexture = self.MinimizeButton:GetNormalTexture()
	local pushedTexture = self.MinimizeButton:GetPushedTexture()

	if collapsed then
		normalTexture:SetAtlas("ui-questtrackerbutton-expand-all", true)
		pushedTexture:SetAtlas("ui-questtrackerbutton-expand-all-pressed", true)
	else
		normalTexture:SetAtlas("ui-questtrackerbutton-collapse-all", true)
		pushedTexture:SetAtlas("ui-questtrackerbutton-collapse-all-pressed", true)
	end
end

local trackers = {
	_G.AchievementObjectiveTracker,
	_G.AdventureObjectiveTracker,
	_G.BonusObjectiveTracker,
	_G.CampaignQuestObjectiveTracker,
	_G.MonthlyActivitiesObjectiveTracker,
	_G.ProfessionsRecipeTracker,
	_G.QuestObjectiveTracker,
	_G.ScenarioObjectiveTracker,
	_G.UIWidgetObjectiveTracker,
	_G.WorldQuestObjectiveTracker
}

for _, tracker in pairs(trackers) do
	tracker.Header.Background:SetAtlas("UI-QuestTracker-Primary-Objective-Header")
	tracker.Header.Background:SetSize(290, 35)
	tracker.Header.Background:SetPoint("CENTER", 0, 1)
	tracker.Header.Text:SetPoint("LEFT", 12, 0)
	tracker.Header.MinimizeButton:SetPoint("RIGHT", -8, 0)
	tracker.Header.MinimizeButton:SetHighlightAtlas("UI-QuestTrackerButton-Red-Highlight", "ADD")
	SetCollapsed(tracker.Header, _G.ObjectiveTrackerFrame.isCollapsed)
	hooksecurefunc(tracker.Header, 'SetCollapsed', SetCollapsed)
end

hooksecurefunc(ObjectiveTrackerFrame, "Update", function(self)
	if not self.modules then
		return
	end

	local prevModule = nil
	for i, module in ipairs(self.modules) do
		local heightUsed = module:GetContentsHeight()
		if heightUsed > 0 then
			if prevModule then
				module:SetPoint("TOP", prevModule, "BOTTOM", 0, -self.moduleSpacing)
			else
				module:SetPoint("TOP")
			end
			prevModule = module
		end
	end
end)