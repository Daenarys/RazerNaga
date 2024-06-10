if not _G.GroupLootHistoryFrame then return end

GroupLootHistoryFrame.ScrollBox:ClearAllPoints()
GroupLootHistoryFrame.ScrollBox:SetPoint("TOPLEFT", 4, -82)
GroupLootHistoryFrame.ScrollBox:SetPoint("BOTTOMRIGHT", GroupLootHistoryFrame, "BOTTOMLEFT", 237, 4)

GroupLootHistoryFrame.ScrollBar:SetSize(25, 560)
GroupLootHistoryFrame.ScrollBar:ClearAllPoints()
GroupLootHistoryFrame.ScrollBar:SetPoint("TOPLEFT", GroupLootHistoryFrame.ScrollBox, "TOPRIGHT", -4, 1)
GroupLootHistoryFrame.ScrollBar:SetPoint("BOTTOMLEFT", GroupLootHistoryFrame.ScrollBox, "BOTTOMRIGHT", -3, -1)

if (GroupLootHistoryFrame.ScrollBar.Backplate == nil) then
	GroupLootHistoryFrame.ScrollBar.Backplate = GroupLootHistoryFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	GroupLootHistoryFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	GroupLootHistoryFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(GroupLootHistoryFrame.ScrollBar)
ApplyScrollBarTrack(GroupLootHistoryFrame.ScrollBar.Track)
ApplyScrollBarThumb(GroupLootHistoryFrame.ScrollBar.Track.Thumb)