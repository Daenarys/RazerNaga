local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Calendar" then
		CalendarCloseButton:SetSize(32, 32)
		CalendarCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		CalendarCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		CalendarCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		CalendarCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		CalendarCloseButton:ClearAllPoints()
		CalendarCloseButton:SetPoint("TOPRIGHT", 5, -14)

		CalendarViewHolidayCloseButton:SetSize(32, 32)
		CalendarViewHolidayCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		CalendarViewHolidayCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		CalendarViewHolidayCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		CalendarViewHolidayCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		CalendarViewHolidayCloseButton:ClearAllPoints()
		CalendarViewHolidayCloseButton:SetPoint("TOPRIGHT", -3, -3)

		CalendarViewHolidayCloseButton.Corner = CalendarViewHolidayCloseButton:CreateTexture(nil, "BACKGROUND")
		CalendarViewHolidayCloseButton.Corner:SetSize(32, 32)
		CalendarViewHolidayCloseButton.Corner:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Corner")
		CalendarViewHolidayCloseButton.Corner:ClearAllPoints()
		CalendarViewHolidayCloseButton.Corner:SetPoint("TOPRIGHT", -4, -4)
		
		CalendarViewHolidayFrame.Header.LeftBG:SetSize(32, 41)
		CalendarViewHolidayFrame.Header.LeftBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarViewHolidayFrame.Header.LeftBG:SetTexCoord(0.22265625, 0.34375, 0, 0.640625)

		CalendarViewHolidayFrame.Header.CenterBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarViewHolidayFrame.Header.CenterBG:SetTexCoord(0.34375, 0.65234375, 0, 0.640625)
		CalendarViewHolidayFrame.Header.CenterBG:SetHorizTile(false)

		CalendarViewHolidayFrame.Header.RightBG:SetSize(32, 41)
		CalendarViewHolidayFrame.Header.RightBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarViewHolidayFrame.Header.RightBG:SetTexCoord(0.65234375, 0.77734375, 0, 0.640625)

		ApplyDialogBorder(CalendarViewHolidayFrame.Border)

		CalendarEventPickerFrame.Header.LeftBG:SetSize(32, 41)
		CalendarEventPickerFrame.Header.LeftBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarEventPickerFrame.Header.LeftBG:SetTexCoord(0.22265625, 0.34375, 0, 0.640625)

		CalendarEventPickerFrame.Header.CenterBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarEventPickerFrame.Header.CenterBG:SetTexCoord(0.34375, 0.65234375, 0, 0.640625)
		CalendarEventPickerFrame.Header.CenterBG:SetHorizTile(false)

		CalendarEventPickerFrame.Header.RightBG:SetSize(32, 41)
		CalendarEventPickerFrame.Header.RightBG:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
		CalendarEventPickerFrame.Header.RightBG:SetTexCoord(0.65234375, 0.77734375, 0, 0.640625)

		ApplyDialogBorder(CalendarEventPickerFrame.Border)

		CalendarEventPickerFrame.ScrollBar:SetSize(25, 560)
		CalendarEventPickerFrame.ScrollBar:ClearAllPoints()
		CalendarEventPickerFrame.ScrollBar:SetPoint("TOPLEFT", CalendarEventPickerFrame.ScrollBox, "TOPRIGHT", -1, 15)
		CalendarEventPickerFrame.ScrollBar:SetPoint("BOTTOMLEFT", CalendarEventPickerFrame.ScrollBox, "BOTTOMRIGHT", 2, -3)

		ApplyScrollBarArrow(CalendarEventPickerFrame.ScrollBar)
		ApplyScrollBarTrack(CalendarEventPickerFrame.ScrollBar.Track)
		ApplyScrollBarThumb(CalendarEventPickerFrame.ScrollBar.Track.Thumb)
	end
end)