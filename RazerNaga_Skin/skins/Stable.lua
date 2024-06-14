if not _G.StableFrame then return end

StableFrame.StabledPetList.ScrollBar:SetSize(25, 560)
StableFrame.StabledPetList.ScrollBar:ClearAllPoints()
StableFrame.StabledPetList.ScrollBar:SetPoint("TOPLEFT", StableFrame.StabledPetList.ScrollBox, "TOPRIGHT", -7, 6)
StableFrame.StabledPetList.ScrollBar:SetPoint("BOTTOMLEFT", StableFrame.StabledPetList.ScrollBox, "BOTTOMRIGHT", -7, -1)

ApplyScrollBarArrow(StableFrame.StabledPetList.ScrollBar)
ApplyScrollBarTrack(StableFrame.StabledPetList.ScrollBar.Track)
ApplyScrollBarThumb(StableFrame.StabledPetList.ScrollBar.Track.Thumb)

if (StableFrame.StabledPetList.ScrollBar.Backplate == nil) then
	StableFrame.StabledPetList.ScrollBar.Backplate = StableFrame.StabledPetList.ScrollBar:CreateTexture(nil, "BACKGROUND")
	StableFrame.StabledPetList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	StableFrame.StabledPetList.ScrollBar.Backplate:SetAllPoints()
end