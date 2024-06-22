local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_DebugTools" then
		TableAttributeDisplay.LinesScrollFrame.ScrollBar:SetSize(25, 560)
		TableAttributeDisplay.LinesScrollFrame.ScrollBar:ClearAllPoints()
		TableAttributeDisplay.LinesScrollFrame.ScrollBar:SetPoint("TOPLEFT", TableAttributeDisplay.LinesScrollFrame, "TOPRIGHT", 5, 3)
		TableAttributeDisplay.LinesScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", TableAttributeDisplay.LinesScrollFrame, "BOTTOMRIGHT", 5, -14)

		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track:ClearAllPoints()
		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track.Begin:Hide()
		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track.End:Hide()
		TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track.Middle:Hide()

		ApplyScrollBarArrow(TableAttributeDisplay.LinesScrollFrame.ScrollBar)
		ApplyScrollBarThumb(TableAttributeDisplay.LinesScrollFrame.ScrollBar.Track.Thumb)

		TableAttributeDisplay.ScrollFrameArt:ClearAllPoints()
		TableAttributeDisplay.ScrollFrameArt:SetPoint("TOPLEFT", TableAttributeDisplay.LinesScrollFrame, "TOPLEFT", 0, 6)
		TableAttributeDisplay.ScrollFrameArt:SetPoint("BOTTOMRIGHT", TableAttributeDisplay.LinesScrollFrame.ScrollBar, "BOTTOMRIGHT",  4, -2)
	end
end)