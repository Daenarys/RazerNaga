local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Calendar" then
		CalendarEventPickerFrame.ScrollBar:SetSize(25, 560)
		CalendarEventPickerFrame.ScrollBar:ClearAllPoints()
		CalendarEventPickerFrame.ScrollBar:SetPoint("TOPLEFT", CalendarEventPickerFrame.ScrollBox, "TOPRIGHT", -1, 15)
		CalendarEventPickerFrame.ScrollBar:SetPoint("BOTTOMLEFT", CalendarEventPickerFrame.ScrollBox, "BOTTOMRIGHT", 2, -2)

		ApplyScrollBarArrow(CalendarEventPickerFrame.ScrollBar)
		ApplyScrollBarTrack(CalendarEventPickerFrame.ScrollBar.Track)
		ApplyScrollBarThumb(CalendarEventPickerFrame.ScrollBar.Track.Thumb)

		ApplyDropDown(CalendarCreateEventFrame.EventTypeDropdown)
		ApplyDropDown(CalendarCreateEventFrame.HourDropdown)
		ApplyDropDown(CalendarCreateEventFrame.MinuteDropdown)
		ApplyFilterDropDown(CalendarFrame.FilterButton)
	end
end)