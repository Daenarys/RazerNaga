if not _G.PartyFrame then return end

for frame in PartyFrame.PartyMemberFramePool:EnumerateActive() do
	frame.PartyMemberOverlay.GuideIcon:ClearAllPoints()
	frame.PartyMemberOverlay.GuideIcon:SetPoint("TOPLEFT")
	frame.PartyMemberOverlay.LeaderIcon:ClearAllPoints()
	frame.PartyMemberOverlay.LeaderIcon:SetPoint("TOPLEFT")
end