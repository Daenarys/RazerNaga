if not _G.PVEFrame then return end

ScenarioQueueFrameRandomScrollFrame.ScrollBar:Hide()

LFDQueueFrameRandomScrollFrame.ScrollBar:SetSize(25, 560)
LFDQueueFrameRandomScrollFrame.ScrollBar:ClearAllPoints()
LFDQueueFrameRandomScrollFrame.ScrollBar:SetPoint("TOPLEFT", LFDQueueFrameRandomScrollFrame, "TOPRIGHT", 2, 8)
LFDQueueFrameRandomScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", LFDQueueFrameRandomScrollFrame, "BOTTOMRIGHT", 5, -9)

if (LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate == nil) then
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate = LFDQueueFrameRandomScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFDQueueFrameRandomScrollFrame.ScrollBar)
ApplyScrollBarTrack(LFDQueueFrameRandomScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(LFDQueueFrameRandomScrollFrame.ScrollBar.Track.Thumb)

LFDQueueFrameSpecific.ScrollBar:SetSize(25, 560)
LFDQueueFrameSpecific.ScrollBar:ClearAllPoints()
LFDQueueFrameSpecific.ScrollBar:SetPoint("TOPLEFT", LFDQueueFrameSpecific.ScrollBox, "TOPRIGHT", 5, 0)
LFDQueueFrameSpecific.ScrollBar:SetPoint("BOTTOMLEFT", LFDQueueFrameSpecific.ScrollBox, "BOTTOMRIGHT", 5, 0)

ApplyScrollBarArrow(LFDQueueFrameSpecific.ScrollBar)
ApplyScrollBarTrack(LFDQueueFrameSpecific.ScrollBar.Track)
ApplyScrollBarThumb(LFDQueueFrameSpecific.ScrollBar.Track.Thumb)

LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetSize(25, 560)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:ClearAllPoints()
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "TOPRIGHT", -3, 2)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "BOTTOMRIGHT", 0, -2)

if (LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate == nil) then
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate = LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track.Thumb)

LFGListFrame.SearchPanel.ScrollBar:SetSize(25, 560)
LFGListFrame.SearchPanel.ScrollBar:ClearAllPoints()
LFGListFrame.SearchPanel.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.SearchPanel.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.SearchPanel.ScrollBox, "BOTTOMRIGHT", 3, -1)

if (LFGListFrame.SearchPanel.ScrollBar.Backplate == nil) then
	LFGListFrame.SearchPanel.ScrollBar.Backplate = LFGListFrame.SearchPanel.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.SearchPanel.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.SearchPanel.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.SearchPanel.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.SearchPanel.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.SearchPanel.ScrollBar.Track.Thumb)

LFGListFrame.ApplicationViewer.ScrollBar:SetSize(25, 560)
LFGListFrame.ApplicationViewer.ScrollBar:ClearAllPoints()
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "BOTTOMRIGHT", 3, -3)

if (LFGListFrame.ApplicationViewer.ScrollBar.Backplate == nil) then
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate = LFGListFrame.ApplicationViewer.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.ApplicationViewer.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.ApplicationViewer.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.ApplicationViewer.ScrollBar.Track.Thumb)

RaidFinderQueueFrameScrollFrame.ScrollBar:SetSize(25, 560)
RaidFinderQueueFrameScrollFrame.ScrollBar:ClearAllPoints()
RaidFinderQueueFrameScrollFrame.ScrollBar:SetPoint("TOPLEFT", RaidFinderQueueFrameScrollFrame, "TOPRIGHT", 2, 3)
RaidFinderQueueFrameScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", RaidFinderQueueFrameScrollFrame, "BOTTOMRIGHT", 5, 0)

if (RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate == nil) then
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate = RaidFinderQueueFrameScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(RaidFinderQueueFrameScrollFrame.ScrollBar)
ApplyScrollBarTrack(RaidFinderQueueFrameScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(RaidFinderQueueFrameScrollFrame.ScrollBar.Track.Thumb)

hooksecurefunc("GroupFinderFrame_EvaluateButtonVisibility", function(self)
	if not PlayerGetTimerunningSeasonID() then
		self.groupButton1:SetPoint("TOPLEFT", 10, -101)
		self.groupButton2:SetPoint("TOP", self.groupButton1, "BOTTOM", 0, -30)
		self.groupButton3:SetPoint("TOP", self.groupButton2, "BOTTOM", 0, -30)
	end
end)