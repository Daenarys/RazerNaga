if not _G.LootFrame then return end

LootFrame.ClosePanelButton:SetSize(32, 32)
LootFrame.ClosePanelButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
LootFrame.ClosePanelButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
LootFrame.ClosePanelButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
LootFrame.ClosePanelButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
LootFrame.ClosePanelButton:ClearAllPoints()
LootFrame.ClosePanelButton:SetPoint("TOPRIGHT", 4, 5)

LootFrameTitleText:ClearAllPoints()
LootFrameTitleText:SetPoint("CENTER", -10, 0)

LootFrame:CreateTexture("LootFrameTitleBg")
LootFrame.TitleBg = LootFrameTitleBg
LootFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
LootFrame.TitleBg:SetSize(256, 18)
LootFrame.TitleBg:SetHorizTile(true)
LootFrame.TitleBg:ClearAllPoints()
LootFrame.TitleBg:SetPoint("TOPLEFT", 8, -3)
LootFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

LootFrame.NineSlice.TopEdge:SetAtlas("_UI-Frame-TitleTile", true)
LootFrame.NineSlice.TopEdge:SetHorizTile(true)
LootFrame.NineSlice.TopEdge:ClearAllPoints()
LootFrame.NineSlice.TopEdge:SetPoint("TOPLEFT", LootFrame.NineSlice.TopLeftCorner, "TOPRIGHT")
LootFrame.NineSlice.TopEdge:SetPoint("TOPRIGHT", LootFrame.NineSlice.TopRightCorner, "TOPLEFT")

LootFrame.NineSlice.TopLeftCorner:SetAtlas("UI-Frame-TopLeftCornerNoPortrait", true)
LootFrame.NineSlice.TopLeftCorner:ClearAllPoints()
LootFrame.NineSlice.TopLeftCorner:SetPoint("TOPLEFT", 0, 1)

LootFrame.NineSlice.TopRightCorner:SetAtlas("UI-Frame-TopCornerRight", true)
LootFrame.NineSlice.TopRightCorner:ClearAllPoints()
LootFrame.NineSlice.TopRightCorner:SetPoint("TOPRIGHT", 0, 1)

LootFrame.NineSlice.BottomEdge:SetAtlas("_UI-Frame-Bot", true)
LootFrame.NineSlice.BottomEdge:SetHorizTile(true)
LootFrame.NineSlice.BottomEdge:ClearAllPoints()
LootFrame.NineSlice.BottomEdge:SetPoint("BOTTOMLEFT", LootFrame.NineSlice.BottomLeftCorner, "BOTTOMRIGHT", 0, 0)
LootFrame.NineSlice.BottomEdge:SetPoint("BOTTOMRIGHT", LootFrame.NineSlice.BottomRightCorner, "BOTTOMLEFT", 0, 0)

LootFrame.NineSlice.BottomLeftCorner:SetAtlas("UI-Frame-BotCornerLeft", true)
LootFrame.NineSlice.BottomLeftCorner:ClearAllPoints()
LootFrame.NineSlice.BottomLeftCorner:SetPoint("BOTTOMLEFT", 0, -5)

LootFrame.NineSlice.BottomRightCorner:SetAtlas("UI-Frame-BotCornerRight", true)
LootFrame.NineSlice.BottomRightCorner:ClearAllPoints()
LootFrame.NineSlice.BottomRightCorner:SetPoint("BOTTOMRIGHT", 0, -5)

LootFrame.NineSlice.LeftEdge:SetAtlas("!UI-Frame-LeftTile", true)
LootFrame.NineSlice.LeftEdge:SetVertTile(true)
LootFrame.NineSlice.LeftEdge:ClearAllPoints()
LootFrame.NineSlice.LeftEdge:SetPoint("TOPLEFT", LootFrame.NineSlice.TopLeftCorner, "BOTTOMLEFT")
LootFrame.NineSlice.LeftEdge:SetPoint("BOTTOMLEFT", LootFrame.NineSlice.BottomLeftCorner, "TOPLEFT")

LootFrame.NineSlice.RightEdge:SetAtlas("!UI-Frame-RightTile", true)
LootFrame.NineSlice.RightEdge:SetVertTile(true)
LootFrame.NineSlice.RightEdge:ClearAllPoints()
LootFrame.NineSlice.RightEdge:SetPoint("TOPRIGHT", LootFrame.NineSlice.TopRightCorner, "BOTTOMRIGHT", 1, 0)
LootFrame.NineSlice.RightEdge:SetPoint("BOTTOMRIGHT", LootFrame.NineSlice.BottomRightCorner, "TOPRIGHT")

LootFrame.ScrollBar:SetSize(25, 560)
LootFrame.ScrollBar:ClearAllPoints()
LootFrame.ScrollBar:SetPoint("TOPLEFT", LootFrame.ScrollBox, "TOPRIGHT", -8, 2)
LootFrame.ScrollBar:SetPoint("BOTTOMLEFT", LootFrame.ScrollBox, "BOTTOMRIGHT", -5, -2)

ApplyScrollBarArrow(LootFrame.ScrollBar)
ApplyScrollBarTrack(LootFrame.ScrollBar.Track)
ApplyScrollBarThumb(LootFrame.ScrollBar.Track.Thumb)