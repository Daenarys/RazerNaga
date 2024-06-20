if not _G.GossipFrame then return end

GossipFrameTitleText:SetTextColor(255, 255, 255, 1)

GossipFrame.GreetingPanel.ScrollBox:ClearAllPoints()
GossipFrame.GreetingPanel.ScrollBox:SetPoint("TOPLEFT", 5, -65)

GossipFrame.GreetingPanel.ScrollBar:SetSize(25, 560)
GossipFrame.GreetingPanel.ScrollBar:ClearAllPoints()
GossipFrame.GreetingPanel.ScrollBar:SetPoint("TOPLEFT", GossipFrame.GreetingPanel.ScrollBox, "TOPRIGHT", 2, 3)
GossipFrame.GreetingPanel.ScrollBar:SetPoint("BOTTOMLEFT", GossipFrame.GreetingPanel.ScrollBox, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(GossipFrame.GreetingPanel.ScrollBar)
ApplyScrollBarTrack(GossipFrame.GreetingPanel.ScrollBar.Track)
ApplyScrollBarThumb(GossipFrame.GreetingPanel.ScrollBar.Track.Thumb)