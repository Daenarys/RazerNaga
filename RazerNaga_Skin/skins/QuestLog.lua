if not _G.QuestLogPopupDetailFrame then return end

QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetSize(25, 560)
QuestLogPopupDetailFrameScrollFrame.ScrollBar:ClearAllPoints()
QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestLogPopupDetailFrameScrollFrame, "TOPRIGHT", 1, 3)
QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestLogPopupDetailFrameScrollFrame, "BOTTOMRIGHT", 4, -1)

ApplyScrollBarArrow(QuestLogPopupDetailFrameScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestLogPopupDetailFrameScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestLogPopupDetailFrameScrollFrame.ScrollBar.Track.Thumb)