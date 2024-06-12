if not _G.AddonList then return end

AddonList.ScrollBar:SetSize(25, 560)
AddonList.ScrollBar:ClearAllPoints()
AddonList.ScrollBar:SetPoint("TOPLEFT", AddonList.ScrollBox, "TOPRIGHT", -2, 2)
AddonList.ScrollBar:SetPoint("BOTTOMLEFT", AddonList.ScrollBox, "BOTTOMRIGHT", -2, 0)

if (AddonList.ScrollBar.Backplate == nil) then
	AddonList.ScrollBar.Backplate = AddonList.ScrollBar:CreateTexture(nil, "BACKGROUND")
	AddonList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	AddonList.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(AddonList.ScrollBar)
ApplyScrollBarTrack(AddonList.ScrollBar.Track)
ApplyScrollBarThumb(AddonList.ScrollBar.Track.Thumb)

ApplyDropDown(AddonList.Dropdown)

AddonList:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 24)
end)