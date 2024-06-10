if not _G.ChannelFrame then return end

ChannelFrame.ChannelRoster.ScrollBar:SetSize(25, 560)
ChannelFrame.ChannelRoster.ScrollBar:ClearAllPoints()
ChannelFrame.ChannelRoster.ScrollBar:SetPoint("TOPLEFT", ChannelFrame.ChannelRoster.ScrollBox, "TOPRIGHT", 2, 3)
ChannelFrame.ChannelRoster.ScrollBar:SetPoint("BOTTOMLEFT", ChannelFrame.ChannelRoster.ScrollBox, "BOTTOMRIGHT", 2, -6)

ApplyScrollBarArrow(ChannelFrame.ChannelRoster.ScrollBar)
ApplyScrollBarTrack(ChannelFrame.ChannelRoster.ScrollBar.Track)
ApplyScrollBarThumb(ChannelFrame.ChannelRoster.ScrollBar.Track.Thumb)