if not _G.PVEFrame then return end

ScenarioQueueFrameRandomScrollFrame.ScrollBar:Hide()

hooksecurefunc("GroupFinderFrame_EvaluateButtonVisibility", function(self)
	if not PlayerGetTimerunningSeasonID() then
		self.groupButton1:SetPoint("TOPLEFT", 10, -101)
		self.groupButton2:SetPoint("TOP", self.groupButton1, "BOTTOM", 0, -30)
		self.groupButton3:SetPoint("TOP", self.groupButton2, "BOTTOM", 0, -30)
	end
end)