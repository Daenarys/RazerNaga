if not _G.TabardFrame then return end

TabardFrameCloseButton:SetSize(32, 32)
TabardFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
TabardFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
TabardFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
TabardFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
TabardFrameCloseButton:ClearAllPoints()
TabardFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
TabardFrameCloseButton:SetFrameLevel(2)

TabardFrame.PortraitContainer.CircleMask:Hide()

TabardFramePortrait:SetSize(61, 61)
TabardFramePortrait:ClearAllPoints()
TabardFramePortrait:SetPoint("TOPLEFT", -6, 8)

TabardFrame.TitleContainer:ClearAllPoints()
TabardFrame.TitleContainer:SetPoint("TOPLEFT", TabardFrame, "TOPLEFT", 58, 0)
TabardFrame.TitleContainer:SetPoint("TOPRIGHT", TabardFrame, "TOPRIGHT", -58, 0)

TabardFrame:CreateTexture("TabardFrameTitleBg")
TabardFrame.TitleBg = TabardFrameTitleBg
TabardFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
TabardFrame.TitleBg:SetSize(256, 18)
TabardFrame.TitleBg:SetHorizTile(true)
TabardFrame.TitleBg:ClearAllPoints()
TabardFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
TabardFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

TabardFrame.TopTileStreaks:ClearAllPoints()
TabardFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
TabardFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(TabardFrame.NineSlice)