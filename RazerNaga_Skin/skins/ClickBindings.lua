local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ClickBindingUI" then
		ClickBindingFrame.ScrollBar:SetSize(25, 560)
		ClickBindingFrame.ScrollBar:ClearAllPoints()
		ClickBindingFrame.ScrollBar:SetPoint("TOPLEFT", ClickBindingFrame.ScrollBox, "TOPRIGHT", 5, 4)
		ClickBindingFrame.ScrollBar:SetPoint("BOTTOMLEFT", ClickBindingFrame.ScrollBox, "BOTTOMRIGHT", 8, -4)

		if (ClickBindingFrame.ScrollBar.Backplate == nil) then
			ClickBindingFrame.ScrollBar.Backplate = ClickBindingFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
			ClickBindingFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			ClickBindingFrame.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(ClickBindingFrame.ScrollBar)
		ApplyScrollBarTrack(ClickBindingFrame.ScrollBar.Track)
		ApplyScrollBarThumb(ClickBindingFrame.ScrollBar.Track.Thumb)
	end
end)