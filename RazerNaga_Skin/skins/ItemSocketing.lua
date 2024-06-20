local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ItemSocketingUI" then
		ItemSocketingScrollFrame.ScrollBar:SetSize(25, 560)
		ItemSocketingScrollFrame.ScrollBar:ClearAllPoints()
		ItemSocketingScrollFrame.ScrollBar:SetPoint("TOPLEFT", ItemSocketingScrollFrame, "TOPRIGHT", -22, 1)
		ItemSocketingScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", ItemSocketingScrollFrame, "BOTTOMRIGHT", -22, -5)

		ApplyScrollBarArrow(ItemSocketingScrollFrame.ScrollBar)
		ApplyScrollBarTrack(ItemSocketingScrollFrame.ScrollBar.Track)
		ApplyScrollBarThumb(ItemSocketingScrollFrame.ScrollBar.Track.Thumb)
	end
end)