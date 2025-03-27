if not _G.ObjectiveTrackerFrame then return end

if ObjectiveTrackerFrame.Header then
	ObjectiveTrackerFrame.Header:Hide()
end

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
	tracker.Header.Background:SetAtlas("Objective-Header", true)
	tracker.Header.Background:SetPoint("TOPLEFT", -19, 14)
	tracker.Header.Text:SetPoint("LEFT", 14, 0)
	tracker.Header.MinimizeButton:SetSize(15, 14)
	tracker.Header.MinimizeButton:SetPoint("RIGHT", -15, 0)
	tracker.Header.MinimizeButton:SetHighlightAtlas("ui-questtrackerbutton-red-highlight", "ADD")
	SetCollapsed(tracker.Header, _G.ObjectiveTrackerFrame.isCollapsed)
	hooksecurefunc(tracker.Header, 'SetCollapsed', SetCollapsed)
	tracker.ContentsFrame:SetPoint("RIGHT", -8, 0)
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
				if module == ScenarioObjectiveTracker then
					module:SetPoint("LEFT", self, "LEFT", -15, 0)
				else
					module:SetPoint("LEFT", self, "LEFT", 5, 0)
				end
			else
				module:SetPoint("TOP")
				if module == ScenarioObjectiveTracker then
					module:SetPoint("LEFT", self, "LEFT", -15, 0)
				else
					module:SetPoint("LEFT", self, "LEFT", 5, 0)
				end
			end
			prevModule = module
		end
	end
end)

hooksecurefunc(ScenarioObjectiveTracker.StageBlock, "UpdateStageBlock", function(block, _, _, _, _, flags)
	if (block.NormalBG:GetAtlas() == "evergreen-scenario-trackerheader") then
		block.NormalBG:SetAtlas("ScenarioTrackerToast", true)
	elseif (block.NormalBG:GetAtlas() == "thewarwithin-scenario-trackerheader") then
		block.NormalBG:SetAtlas("dragonflight-scenario-TrackerHeader", true)
	elseif (block.NormalBG:GetAtlas() == "delves-scenario-TrackerHeader") then
		block.NormalBG:SetAtlas("dragonflight-scenario-TrackerHeader", true)
	end
	block.NormalBG:SetPoint("TOPLEFT", 0, -1)
	block.FinalBG:SetAtlas("ScenarioTrackerToast-FinalFiligree", true)
	block.FinalBG:ClearAllPoints()
	block.FinalBG:SetPoint("TOPLEFT", 4, -5)
	if bit.band(flags, SCENARIO_FLAG_SUPRESS_STAGE_TEXT) == SCENARIO_FLAG_SUPRESS_STAGE_TEXT then
		block.Stage:SetSize(172, 36)
	else
		block.Stage:SetSize(172, 18)
	end
end)

hooksecurefunc(ScenarioObjectiveTracker.StageBlock, "UpdateWidgetRegistration", function(block)
	if block.WidgetContainer.widgetFrames then
		for _, widgetFrame in pairs(block.WidgetContainer.widgetFrames) do
			if widgetFrame.Frame then
				if (widgetFrame.Frame:GetAtlas() == "evergreen-scenario-frame") then
					block.WidgetContainer:SetPoint("TOPLEFT", -2, 0)
				elseif (widgetFrame.Frame:GetAtlas() == "thewarwithin-scenario-frame") then
					block.WidgetContainer:SetPoint("TOPLEFT", 1, -2)
				elseif (widgetFrame.Frame:GetAtlas() == "delves-scenario-frame") then
					block.WidgetContainer:SetPoint("TOPLEFT", -7, 2)
				else
					block.WidgetContainer:SetPoint("TOPLEFT", 0, -1)
				end
			end
		end
	end
end)