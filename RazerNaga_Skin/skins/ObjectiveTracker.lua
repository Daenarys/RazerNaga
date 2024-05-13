if not _G.ObjectiveTrackerFrame then return end

hooksecurefunc("ObjectiveTracker_Update", function()
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:SetDisabledAtlas("RedButton-MiniCondense-disabled")
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:SetNormalAtlas("RedButton-MiniCondense")
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:SetPushedAtlas("RedButton-MiniCondense-pressed")
	ObjectiveTrackerFrame.HeaderMenu.MinimizeButton:SetHighlightAtlas("RedButton-Highlight")
end)