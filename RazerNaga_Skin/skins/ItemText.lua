if not _G.ItemTextFrame then return end

ItemTextScrollFrame.ScrollBar:SetSize(25, 560)
ItemTextScrollFrame.ScrollBar:ClearAllPoints()
ItemTextScrollFrame.ScrollBar:SetPoint("TOPLEFT", ItemTextScrollFrame, "TOPRIGHT", 1, 3)
ItemTextScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", ItemTextScrollFrame, "BOTTOMRIGHT", 4, -2)

if (ItemTextScrollFrame.ScrollBar.Backplate == nil) then
	ItemTextScrollFrame.ScrollBar.Backplate = ItemTextScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	ItemTextScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	ItemTextScrollFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(ItemTextScrollFrame.ScrollBar)
ApplyScrollBarTrack(ItemTextScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(ItemTextScrollFrame.ScrollBar.Track.Thumb)