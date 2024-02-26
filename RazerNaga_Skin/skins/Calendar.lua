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
	end
end)