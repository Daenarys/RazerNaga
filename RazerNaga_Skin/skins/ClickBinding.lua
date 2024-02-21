local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ClickBindingUI" then
		ClickBindingFrame.ScrollBar:SetSize(25, 560)
		ClickBindingFrame.ScrollBar:ClearAllPoints()
		ClickBindingFrame.ScrollBar:SetPoint("TOPLEFT", ClickBindingFrame.ScrollBox, "TOPRIGHT", 5, 4)
		ClickBindingFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClickBindingFrame.ScrollBox, "BOTTOMRIGHT", 8, -2)

		if (ClickBindingFrame.ScrollBar.BG == nil) then
			ClickBindingFrame.ScrollBar.BG = ClickBindingFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
			ClickBindingFrame.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			ClickBindingFrame.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(ClickBindingFrame.ScrollBar)
		ApplyScrollBarTrack(ClickBindingFrame.ScrollBar.Track)
		ApplyScrollBarThumb(ClickBindingFrame.ScrollBar.Track.Thumb)
	end
end)