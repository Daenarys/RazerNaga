local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PVPUI" then
		HonorFrame.SpecificScrollBar:SetSize(25, 560)
		HonorFrame.SpecificScrollBar:ClearAllPoints()
		HonorFrame.SpecificScrollBar:SetPoint("TOPLEFT", HonorFrame.SpecificScrollBox, "TOPRIGHT", -2, 3)
		HonorFrame.SpecificScrollBar:SetPoint("BOTTOMLEFT", HonorFrame.SpecificScrollBox, "BOTTOMRIGHT", 1, -1)

		ApplyScrollBarArrow(HonorFrame.SpecificScrollBar)
		ApplyScrollBarTrack(HonorFrame.SpecificScrollBar.Track)
		ApplyScrollBarThumb(HonorFrame.SpecificScrollBar.Track.Thumb)

		ApplyDropDown(HonorFrameTypeDropdown)
	end
end)

PVPMatchScoreboard.Content.ScrollBar:SetSize(25, 560)
PVPMatchScoreboard.Content.ScrollBar:ClearAllPoints()
PVPMatchScoreboard.Content.ScrollBar:SetPoint("TOPLEFT", PVPMatchScoreboard.Content, "TOPRIGHT", -25, -2)
PVPMatchScoreboard.Content.ScrollBar:SetPoint("BOTTOMLEFT", PVPMatchScoreboard.Content, "BOTTOMRIGHT", -25, 40)

ApplyScrollBarArrow(PVPMatchScoreboard.Content.ScrollBar)
ApplyScrollBarTrack(PVPMatchScoreboard.Content.ScrollBar.Track)
ApplyScrollBarThumb(PVPMatchScoreboard.Content.ScrollBar.Track.Thumb)

PVPMatchScoreboard:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER")
end)

PVPMatchResults.content.scrollBar:SetSize(25, 560)
PVPMatchResults.content.scrollBar:ClearAllPoints()
PVPMatchResults.content.scrollBar:SetPoint("TOPLEFT", PVPMatchResults.content, "TOPRIGHT", -25, -3)
PVPMatchResults.content.scrollBar:SetPoint("BOTTOMLEFT", PVPMatchResults.content, "BOTTOMRIGHT", -25, 122)

ApplyScrollBarArrow(PVPMatchResults.content.scrollBar)
ApplyScrollBarTrack(PVPMatchResults.content.scrollBar.Track)
ApplyScrollBarThumb(PVPMatchResults.content.scrollBar.Track.Thumb)

PVPMatchResults:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER")
end)