local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_TimeManager" then
		TimeManagerFrame:SetTitle(TIMEMANAGER_TITLE)

		ApplyDropDown(TimeManagerAlarmTimeFrame.HourDropdown)
		ApplyDropDown(TimeManagerAlarmTimeFrame.MinuteDropdown)
		ApplyDropDown(TimeManagerAlarmTimeFrame.AMPMDropdown)
	end
end)