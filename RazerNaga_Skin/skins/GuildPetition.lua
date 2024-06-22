if _G.GuildRegistrarFrame then
	GuildRegistrarFrame.ScrollBar:SetSize(25, 560)
	GuildRegistrarFrame.ScrollBar:ClearAllPoints()
	GuildRegistrarFrame.ScrollBar:SetPoint("TOPLEFT", GuildRegistrarFrame, "TOPRIGHT", -30, -60)
	GuildRegistrarFrame.ScrollBar:SetPoint("BOTTOMLEFT", GuildRegistrarFrame, "BOTTOMRIGHT", -27, 24)

	ApplyScrollBarArrow(GuildRegistrarFrame.ScrollBar)
	ApplyScrollBarTrack(GuildRegistrarFrame.ScrollBar.Track)
	ApplyScrollBarThumb(GuildRegistrarFrame.ScrollBar.Track.Thumb)
end

if _G.PetitionFrame then
	PetitionFrame.ScrollBar:SetSize(25, 560)
	PetitionFrame.ScrollBar:ClearAllPoints()
	PetitionFrame.ScrollBar:SetPoint("TOPLEFT", PetitionFrame, "TOPRIGHT", -30, -60)
	PetitionFrame.ScrollBar:SetPoint("BOTTOMLEFT", PetitionFrame, "BOTTOMRIGHT", -27, 24)

	ApplyScrollBarArrow(PetitionFrame.ScrollBar)
	ApplyScrollBarTrack(PetitionFrame.ScrollBar.Track)
	ApplyScrollBarThumb(PetitionFrame.ScrollBar.Track.Thumb)
end