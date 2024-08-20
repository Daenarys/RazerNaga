if not _G.ObjectiveTrackerFrame then return end

hooksecurefunc(ObjectiveTrackerFrame, "Update", function(self)
	self.Header.MinimizeButton:SetNormalTexture("Interface/QuestFrame/QuestTracker")
	self.Header.MinimizeButton:SetPushedTexture("Interface/QuestFrame/QuestTracker")
	self.Header.MinimizeButton:SetHighlightAtlas("UI-QuestTrackerButton-Highlight", "ADD")
	if self:IsCollapsed() then
		self.Header.MinimizeButton:GetNormalTexture():SetTexCoord(0.933594, 0.96875, 0.242188, 0.316406)
		self.Header.MinimizeButton:GetPushedTexture():SetTexCoord(0.894531, 0.929688, 0.324219, 0.398438)
	else
		self.Header.MinimizeButton:GetNormalTexture():SetTexCoord(0.9375, 0.972656, 0.121094, 0.195312)
		self.Header.MinimizeButton:GetPushedTexture():SetTexCoord(0.894531, 0.929688, 0.242188, 0.316406)
	end
end)