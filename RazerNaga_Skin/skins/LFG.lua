if not _G.PVEFrame then return end

GroupFinderFrame:HookScript("OnShow", function()
	SetPortraitToTexture(PVEFramePortrait, "Interface\\LFGFrame\\UI-LFG-PORTRAIT")
end)

LFDQueueFrameSpecific.ScrollBar:SetSize(25, 560)
LFDQueueFrameSpecific.ScrollBar:ClearAllPoints()
LFDQueueFrameSpecific.ScrollBar:SetPoint("TOPLEFT", LFDQueueFrameSpecific.ScrollBox, "TOPRIGHT", 2, 3)
LFDQueueFrameSpecific.ScrollBar:SetPoint("BOTTOMLEFT", LFDQueueFrameSpecific.ScrollBox, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(LFDQueueFrameSpecific.ScrollBar)
ApplyScrollBarTrack(LFDQueueFrameSpecific.ScrollBar.Track)
ApplyScrollBarThumb(LFDQueueFrameSpecific.ScrollBar.Track.Thumb)

LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetSize(25, 560)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:ClearAllPoints()
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "TOPRIGHT", -3, 2)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "BOTTOMRIGHT", 0, -2)

if (LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.BG == nil) then
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.BG = LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:CreateTexture(nil, "BACKGROUND");
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.BG:SetColorTexture(0, 0, 0, .65)
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.BG:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track.Thumb)

LFGListFrame.SearchPanel.ScrollBar:SetSize(25, 560)
LFGListFrame.SearchPanel.ScrollBar:ClearAllPoints()
LFGListFrame.SearchPanel.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.SearchPanel.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.SearchPanel.ScrollBox, "BOTTOMRIGHT", 3, -1)

if (LFGListFrame.SearchPanel.ScrollBar.BG == nil) then
	LFGListFrame.SearchPanel.ScrollBar.BG = LFGListFrame.SearchPanel.ScrollBar:CreateTexture(nil, "BACKGROUND");
	LFGListFrame.SearchPanel.ScrollBar.BG:SetColorTexture(0, 0, 0, .65)
	LFGListFrame.SearchPanel.ScrollBar.BG:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.SearchPanel.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.SearchPanel.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.SearchPanel.ScrollBar.Track.Thumb)

LFGListFrame.ApplicationViewer.ScrollBar:SetSize(25, 560)
LFGListFrame.ApplicationViewer.ScrollBar:ClearAllPoints()
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "BOTTOMRIGHT", 3, -3)

if (LFGListFrame.ApplicationViewer.ScrollBar.BG == nil) then
	LFGListFrame.ApplicationViewer.ScrollBar.BG = LFGListFrame.ApplicationViewer.ScrollBar:CreateTexture(nil, "BACKGROUND");
	LFGListFrame.ApplicationViewer.ScrollBar.BG:SetColorTexture(0, 0, 0, .65)
	LFGListFrame.ApplicationViewer.ScrollBar.BG:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.ApplicationViewer.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.ApplicationViewer.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.ApplicationViewer.ScrollBar.Track.Thumb)

ApplyDialogBorder(LFDReadyCheckPopup.Border)
ApplyDialogBorder(LFDRoleCheckPopup.Border)
ApplyDialogBorder(LFGDungeonReadyDialog.Border)
ApplyDialogBorder(LFGDungeonReadyStatus.Border)
ApplyDialogBorder(LFGInvitePopup.Border)
ApplyDialogBorder(LFGListApplicationDialog.Border)
ApplyDialogBorder(LFGListInviteDialog.Border)
ApplyDialogBorder(LFGListFrame.EntryCreation.ActivityFinder.Dialog.Border)
ApplyDialogBorder(RolePollPopup.Border)