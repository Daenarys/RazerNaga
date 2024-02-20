local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Calendar" then	
		ApplyDialogBorder(CalendarViewHolidayFrame.Border)
		ApplyDialogHeader(CalendarViewHolidayFrame.Header)
		ApplyDialogBorder(CalendarViewRaidFrame.Border)
		ApplyDialogHeader(CalendarViewRaidFrame.Header)
		ApplyDialogBorder(CalendarEventPickerFrame.Border)
		ApplyDialogHeader(CalendarEventPickerFrame.Header)

		CalendarEventPickerFrame.ScrollBar:SetSize(25, 560)
		CalendarEventPickerFrame.ScrollBar:ClearAllPoints()
		CalendarEventPickerFrame.ScrollBar:SetPoint("TOPLEFT", CalendarEventPickerFrame.ScrollBox, "TOPRIGHT", -1, 15)
		CalendarEventPickerFrame.ScrollBar:SetPoint("BOTTOMLEFT", CalendarEventPickerFrame.ScrollBox, "BOTTOMRIGHT", 2, -3)

		ApplyScrollBarArrow(CalendarEventPickerFrame.ScrollBar)
		ApplyScrollBarTrack(CalendarEventPickerFrame.ScrollBar.Track)
		ApplyScrollBarThumb(CalendarEventPickerFrame.ScrollBar.Track.Thumb)
	end
end)