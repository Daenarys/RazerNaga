if not _G.DressUpFrame then return end

DressUpFrame.SetSelectionPanel.ScrollBar:SetSize(25, 560)
DressUpFrame.SetSelectionPanel.ScrollBar:ClearAllPoints()
DressUpFrame.SetSelectionPanel.ScrollBar:SetPoint("TOPLEFT", DressUpFrame.SetSelectionPanel.ScrollBox, "TOPRIGHT")
DressUpFrame.SetSelectionPanel.ScrollBar:SetPoint("BOTTOMLEFT", DressUpFrame.SetSelectionPanel.ScrollBox, "BOTTOMRIGHT")

DressUpFrame.SetSelectionPanel.ScrollBar.Track:ClearAllPoints()
DressUpFrame.SetSelectionPanel.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
DressUpFrame.SetSelectionPanel.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

DressUpFrame.SetSelectionPanel.ScrollBar.Track.Begin:Hide()
DressUpFrame.SetSelectionPanel.ScrollBar.Track.End:Hide()
DressUpFrame.SetSelectionPanel.ScrollBar.Track.Middle:Hide()

ApplyScrollBarArrow(DressUpFrame.SetSelectionPanel.ScrollBar)
ApplyScrollBarThumb(DressUpFrame.SetSelectionPanel.ScrollBar.Track.Thumb)

DressUpFrame.ModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP")
end)