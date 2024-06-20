local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GuildBankUI" then
		GuildBankFrame.Log.ScrollBar:SetSize(25, 560)
		GuildBankFrame.Log.ScrollBar:ClearAllPoints()
		GuildBankFrame.Log.ScrollBar:SetPoint("TOPLEFT", GuildBankMessageFrame, "TOPRIGHT", -3, 5)
		GuildBankFrame.Log.ScrollBar:SetPoint("BOTTOMLEFT", GuildBankMessageFrame, "BOTTOMRIGHT", 0, -3)

		ApplyScrollBarArrow(GuildBankFrame.Log.ScrollBar)
		ApplyScrollBarTrack(GuildBankFrame.Log.ScrollBar.Track)
		ApplyScrollBarThumb(GuildBankFrame.Log.ScrollBar.Track.Thumb)

		GuildBankInfoScrollFrame.ScrollBar:SetSize(25, 560)
		GuildBankInfoScrollFrame.ScrollBar:ClearAllPoints()
		GuildBankInfoScrollFrame.ScrollBar:SetPoint("TOPLEFT", GuildBankInfoScrollFrame, "TOPRIGHT", -5, 3)
		GuildBankInfoScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", GuildBankInfoScrollFrame, "BOTTOMRIGHT", -2, -3)

		ApplyScrollBarArrow(GuildBankInfoScrollFrame.ScrollBar)
		ApplyScrollBarTrack(GuildBankInfoScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(GuildBankInfoScrollFrame.ScrollBar.Track.Thumb)
	end
end)