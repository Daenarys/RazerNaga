if _G.MailFrame then
	SendMailScrollFrame.ScrollBar:SetSize(25, 560)
	SendMailScrollFrame.ScrollBar:ClearAllPoints()
	SendMailScrollFrame.ScrollBar:SetPoint("TOPLEFT", SendMailScrollFrame, "TOPRIGHT", 3, 3)
	SendMailScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", SendMailScrollFrame, "BOTTOMRIGHT", 6, -2)

	ApplyScrollBarArrow(SendMailScrollFrame.ScrollBar)
	ApplyScrollBarTrack(SendMailScrollFrame.ScrollBar.Track)
	ApplyScrollBarThumb(SendMailScrollFrame.ScrollBar.Track.Thumb)
end

if _G.OpenMailFrame then
	OpenMailScrollFrame.ScrollBar:SetSize(25, 560)
	OpenMailScrollFrame.ScrollBar:ClearAllPoints()
	OpenMailScrollFrame.ScrollBar:SetPoint("TOPLEFT", OpenMailScrollFrame, "TOPRIGHT", 3, 3)
	OpenMailScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", OpenMailScrollFrame, "BOTTOMRIGHT", 6, -2)

	ApplyScrollBarArrow(OpenMailScrollFrame.ScrollBar)
	ApplyScrollBarTrack(OpenMailScrollFrame.ScrollBar.Track)
	ApplyScrollBarThumb(OpenMailScrollFrame.ScrollBar.Track.Thumb)
end