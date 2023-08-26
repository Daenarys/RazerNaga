if not _G.QuestLogPopupDetailFrame then return end

QuestLogPopupDetailFrameCloseButton:SetSize(32, 32)
QuestLogPopupDetailFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
QuestLogPopupDetailFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
QuestLogPopupDetailFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
QuestLogPopupDetailFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
QuestLogPopupDetailFrameCloseButton:ClearAllPoints()
QuestLogPopupDetailFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
QuestLogPopupDetailFrameCloseButton:SetFrameLevel(2)

QuestLogPopupDetailFrame.PortraitContainer.CircleMask:Hide()

QuestLogPopupDetailFramePortrait:SetSize(61, 61)
QuestLogPopupDetailFramePortrait:ClearAllPoints()
QuestLogPopupDetailFramePortrait:SetPoint("TOPLEFT", -6, 8)

QuestLogPopupDetailFrame.TitleContainer:ClearAllPoints()
QuestLogPopupDetailFrame.TitleContainer:SetPoint("TOPLEFT", QuestLogPopupDetailFrame, "TOPLEFT", 58, 0)
QuestLogPopupDetailFrame.TitleContainer:SetPoint("TOPRIGHT", QuestLogPopupDetailFrame, "TOPRIGHT", -58, 0)

QuestLogPopupDetailFrame:CreateTexture("QuestLogPopupDetailFrameTitleBg")
QuestLogPopupDetailFrame.TitleBg = QuestLogPopupDetailFrameTitleBg
QuestLogPopupDetailFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
QuestLogPopupDetailFrame.TitleBg:SetSize(256, 18)
QuestLogPopupDetailFrame.TitleBg:SetHorizTile(true)
QuestLogPopupDetailFrame.TitleBg:ClearAllPoints()
QuestLogPopupDetailFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
QuestLogPopupDetailFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

QuestLogPopupDetailFrame.TopTileStreaks:ClearAllPoints()
QuestLogPopupDetailFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
QuestLogPopupDetailFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(QuestLogPopupDetailFrame.NineSlice)

QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetSize(25, 560)
QuestLogPopupDetailFrameScrollFrame.ScrollBar:ClearAllPoints()
QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestLogPopupDetailFrameScrollFrame, "TOPRIGHT", 1, 3)
QuestLogPopupDetailFrameScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestLogPopupDetailFrameScrollFrame, "BOTTOMRIGHT", 4, -1)

ApplyScrollBarArrow(QuestLogPopupDetailFrameScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestLogPopupDetailFrameScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestLogPopupDetailFrameScrollFrame.ScrollBar.Track.Thumb)