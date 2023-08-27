if not _G.TradeFrame then return end

TradeFrameCloseButton:SetSize(32, 32)
TradeFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
TradeFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
TradeFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
TradeFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
TradeFrameCloseButton:ClearAllPoints()
TradeFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
TradeFrameCloseButton:SetFrameLevel(2)

TradeFrame.PortraitContainer.CircleMask:Hide()

TradeFramePortrait:SetSize(61, 61)
TradeFramePortrait:ClearAllPoints()
TradeFramePortrait:SetPoint("TOPLEFT", -6, 8)

TradeFrameTitleText:ClearAllPoints()
TradeFrameTitleText:SetPoint("CENTER", -17, 1)

TradeFrame:CreateTexture("TradeFrameTitleBg")
TradeFrame.TitleBg = TradeFrameTitleBg
TradeFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
TradeFrame.TitleBg:SetSize(256, 18)
TradeFrame.TitleBg:SetHorizTile(true)
TradeFrame.TitleBg:ClearAllPoints()
TradeFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
TradeFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

TradeFrame.TopTileStreaks:ClearAllPoints()
TradeFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
TradeFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(TradeFrame.NineSlice)

TradeFrame.RecipientOverlay.portraitFrame:SetSize(78, 78)
TradeFrame.RecipientOverlay.portraitFrame:SetAtlas("UI-Frame-Portrait")
TradeFrame.RecipientOverlay.portraitFrame:ClearAllPoints()
TradeFrame.RecipientOverlay.portraitFrame:SetPoint("TOPLEFT", -6, 4)