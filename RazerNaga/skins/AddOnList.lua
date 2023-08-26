if not _G.AddonList then return end

AddonList.TitleContainer:ClearAllPoints()
AddonList.TitleContainer:SetPoint("TOPLEFT", AddonList, "TOPLEFT", 58, 0)
AddonList.TitleContainer:SetPoint("TOPRIGHT", AddonList, "TOPRIGHT", -58, 0)

AddonListCloseButton:SetSize(32, 32)
AddonListCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
AddonListCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
AddonListCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
AddonListCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
AddonListCloseButton:ClearAllPoints()
AddonListCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
AddonListCloseButton:SetFrameLevel(2)

AddonListBg:ClearAllPoints()
AddonListBg:SetPoint("TOPLEFT", AddonList, "TOPLEFT", 2, -21)
AddonListBg:SetPoint("BOTTOMRIGHT", AddonList, "BOTTOMRIGHT", -2, 2)

AddonListInset:ClearAllPoints()
AddonListInset:SetPoint("TOPLEFT", AddonList, "TOPLEFT", 4, -60)
AddonListInset:SetPoint("BOTTOMRIGHT", AddonList, "BOTTOMRIGHT", -6, 26)

AddonList:CreateTexture("AddonListTitleBg")
AddonList.TitleBg = AddonListTitleBg
AddonList.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
AddonList.TitleBg:SetSize(256, 18)
AddonList.TitleBg:SetHorizTile(true)
AddonList.TitleBg:ClearAllPoints()
AddonList.TitleBg:SetPoint("TOPLEFT", 2, -3)
AddonList.TitleBg:SetPoint("TOPRIGHT", -25, -3)

AddonList.TopTileStreaks:ClearAllPoints()
AddonList.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
AddonList.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSliceNoPortrait(AddonList.NineSlice)

AddonList.ScrollBox:ClearAllPoints()
AddonList.ScrollBox:SetPoint("TOPLEFT", AddonList, "TOPLEFT", 8, -68)

AddonList.ScrollBar:SetSize(25, 560)
AddonList.ScrollBar:ClearAllPoints()
AddonList.ScrollBar:SetPoint("TOPLEFT", AddonList.ScrollBox, "TOPRIGHT", -6, 5)
AddonList.ScrollBar:SetPoint("BOTTOMLEFT", AddonList.ScrollBox, "BOTTOMRIGHT", -3, 2)

ApplyScrollBarArrow(AddonList.ScrollBar)
ApplyScrollBarTrack(AddonList.ScrollBar.Track)
ApplyScrollBarThumb(AddonList.ScrollBar.Track.Thumb)

_G.AddonList:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 24)
end)