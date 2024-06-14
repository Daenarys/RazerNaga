if not _G.ExpansionLandingPage then return end

ExpansionLandingPage:HookScript("OnShow", function(self)
	for _, child in next, { self.Overlay:GetChildren() } do
	    if WarWithinLandingOverlayMixin and child.OnLoad == WarWithinLandingOverlayMixin.OnLoad then
			child.MajorFactionList.ScrollBar:SetSize(25, 560)
			child.MajorFactionList.ScrollBar:ClearAllPoints()
			child.MajorFactionList.ScrollBar:SetPoint("TOPLEFT", child.MajorFactionList.ScrollBox, "TOPRIGHT", -1, -7)
			child.MajorFactionList.ScrollBar:SetPoint("BOTTOMLEFT", child.MajorFactionList.ScrollBox, "BOTTOMRIGHT", 2, -1)

			if (child.MajorFactionList.ScrollBar.Backplate == nil) then
				child.MajorFactionList.ScrollBar.Backplate = child.MajorFactionList.ScrollBar:CreateTexture(nil, "BACKGROUND")
				child.MajorFactionList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
				child.MajorFactionList.ScrollBar.Backplate:SetAllPoints()
			end

			child.MajorFactionList.ScrollBar.Track:ClearAllPoints()
			child.MajorFactionList.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
			child.MajorFactionList.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

			child.MajorFactionList.ScrollBar.Track.Begin:Hide()
			child.MajorFactionList.ScrollBar.Track.End:Hide()
			child.MajorFactionList.ScrollBar.Track.Middle:Hide()

			ApplyScrollBarArrow(child.MajorFactionList.ScrollBar)
			ApplyScrollBarThumb(child.MajorFactionList.ScrollBar.Track.Thumb)
	 	end
	end
end)