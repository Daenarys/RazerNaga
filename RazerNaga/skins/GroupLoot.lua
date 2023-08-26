if not _G.GroupLootHistoryFrame then return end

GroupLootHistoryFrame.ClosePanelButton:SetSize(32, 32)
GroupLootHistoryFrame.ClosePanelButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
GroupLootHistoryFrame.ClosePanelButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
GroupLootHistoryFrame.ClosePanelButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
GroupLootHistoryFrame.ClosePanelButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
GroupLootHistoryFrame.ClosePanelButton:ClearAllPoints()
GroupLootHistoryFrame.ClosePanelButton:SetPoint("TOPRIGHT", 5.6, 5)
GroupLootHistoryFrame.ClosePanelButton:SetFrameLevel(2)

GroupLootHistoryFrame.TitleContainer:ClearAllPoints()
GroupLootHistoryFrame.TitleContainer:SetPoint("TOPLEFT", GroupLootHistoryFrame, "TOPLEFT", 66, -1)
GroupLootHistoryFrame.TitleContainer:SetPoint("TOPRIGHT", GroupLootHistoryFrame, "TOPRIGHT", -60, 1)

GroupLootHistoryFrame:CreateTexture("GroupLootHistoryFrameTitleBg")
GroupLootHistoryFrame.TitleBg = GroupLootHistoryFrameTitleBg
GroupLootHistoryFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
GroupLootHistoryFrame.TitleBg:SetSize(256, 18)
GroupLootHistoryFrame.TitleBg:SetHorizTile(true)
GroupLootHistoryFrame.TitleBg:ClearAllPoints()
GroupLootHistoryFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
GroupLootHistoryFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

GroupLootHistoryFrameBg:ClearAllPoints()
GroupLootHistoryFrameBg:SetPoint("TOPLEFT", 3, -20)
GroupLootHistoryFrameBg:SetPoint("BOTTOMRIGHT", -2, 2)

ApplyNineSliceNoPortrait(GroupLootHistoryFrame.NineSlice)

GroupLootHistoryFrame.ScrollBar:SetSize(25, 560)
GroupLootHistoryFrame.ScrollBar:ClearAllPoints()
GroupLootHistoryFrame.ScrollBar:SetPoint("TOPLEFT", GroupLootHistoryFrame.ScrollBox, "TOPRIGHT", -4, 3)
GroupLootHistoryFrame.ScrollBar:SetPoint("BOTTOMLEFT", GroupLootHistoryFrame.ScrollBox, "BOTTOMRIGHT", -1, -1)

if (GroupLootHistoryFrame.ScrollBar.Background == nil) then
	GroupLootHistoryFrame.ScrollBar.Background = GroupLootHistoryFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
	GroupLootHistoryFrame.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
	GroupLootHistoryFrame.ScrollBar.Background:SetAllPoints()
end

ApplyScrollBarArrow(GroupLootHistoryFrame.ScrollBar)
ApplyScrollBarTrack(GroupLootHistoryFrame.ScrollBar.Track)
ApplyScrollBarThumb(GroupLootHistoryFrame.ScrollBar.Track.Thumb)

GroupLootHistoryFrame.ScrollBox:ClearAllPoints()
GroupLootHistoryFrame.ScrollBox:SetPoint("TOPLEFT", 0, -82)
GroupLootHistoryFrame.ScrollBox:SetPoint("BOTTOMRIGHT", GroupLootHistoryFrame, "BOTTOMLEFT", 237, 4)