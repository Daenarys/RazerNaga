if not _G.DressUpFrame then return end

DressUpFrameCloseButton:SetSize(32, 32)
DressUpFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
DressUpFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
DressUpFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
DressUpFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
DressUpFrameCloseButton:ClearAllPoints()
DressUpFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
DressUpFrameCloseButton:SetFrameLevel(2)

DressUpFrame.MaxMinButtonFrame:SetSize(32, 32)
DressUpFrame.MaxMinButtonFrame:ClearAllPoints()
DressUpFrame.MaxMinButtonFrame:SetPoint("RIGHT", DressUpFrameCloseButton, "LEFT", 8.5, 0)
DressUpFrame.MaxMinButtonFrame:SetFrameLevel(2)

DressUpFrame.MaxMinButtonFrame.MaximizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Up")
DressUpFrame.MaxMinButtonFrame.MaximizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Down")
DressUpFrame.MaxMinButtonFrame.MaximizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Disabled")
DressUpFrame.MaxMinButtonFrame.MaximizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

DressUpFrame.MaxMinButtonFrame.MinimizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Up")
DressUpFrame.MaxMinButtonFrame.MinimizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Down")
DressUpFrame.MaxMinButtonFrame.MinimizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Disabled")
DressUpFrame.MaxMinButtonFrame.MinimizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

DressUpFrame.PortraitContainer.CircleMask:Hide()

DressUpFramePortrait:SetSize(61, 61)
DressUpFramePortrait:ClearAllPoints()
DressUpFramePortrait:SetPoint("TOPLEFT", -6, 8)

DressUpFrame.TitleContainer:ClearAllPoints()
DressUpFrame.TitleContainer:SetPoint("TOPLEFT", DressUpFrame, "TOPLEFT", 58, 0)
DressUpFrame.TitleContainer:SetPoint("TOPRIGHT", DressUpFrame, "TOPRIGHT", -58, 0)

DressUpFrame:CreateTexture("DressUpFrameTitleBg")
DressUpFrame.TitleBg = DressUpFrameTitleBg
DressUpFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
DressUpFrame.TitleBg:SetSize(256, 18)
DressUpFrame.TitleBg:SetHorizTile(true)
DressUpFrame.TitleBg:ClearAllPoints()
DressUpFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
DressUpFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

DressUpFrame.TopTileStreaks:ClearAllPoints()
DressUpFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
DressUpFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortraitMinimizable(DressUpFrame.NineSlice)

SideDressUpFrameCloseButton:SetSize(32, 32)
SideDressUpFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
SideDressUpFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
SideDressUpFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
SideDressUpFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")