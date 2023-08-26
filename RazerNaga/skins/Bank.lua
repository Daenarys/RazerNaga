if not _G.BankFrame then return end

BankFrameCloseButton:SetSize(32, 32)
BankFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
BankFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
BankFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
BankFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
BankFrameCloseButton:ClearAllPoints()
BankFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
BankFrameCloseButton:SetFrameLevel(2)

BankFrame.PortraitContainer.CircleMask:Hide()

BankFramePortrait:SetSize(61, 61)
BankFramePortrait:ClearAllPoints()
BankFramePortrait:SetPoint("TOPLEFT", -6, 8)

BankFrame.TitleContainer:ClearAllPoints()
BankFrame.TitleContainer:SetPoint("TOPLEFT", BankFrame, "TOPLEFT", 58, 0)
BankFrame.TitleContainer:SetPoint("TOPRIGHT", BankFrame, "TOPRIGHT", -58, 0)

BankFrame:CreateTexture("BankFrameTitleBg")
BankFrame.TitleBg = BankFrameTitleBg
BankFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
BankFrame.TitleBg:SetSize(256, 18)
BankFrame.TitleBg:SetHorizTile(true)
BankFrame.TitleBg:ClearAllPoints()
BankFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
BankFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

BankFrame.TopTileStreaks:ClearAllPoints()
BankFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
BankFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(BankFrame.NineSlice)

BankFrameTab2:ClearAllPoints()
BankFrameTab2:SetPoint("LEFT", BankFrameTab1, "RIGHT", -15, 0)

for i = 1, 2 do
	ApplyBottomTab(_G['BankFrameTab'..i])

	_G["BankFrameTab"..i]:HookScript("OnShow", function(self)
		if _G["BankFrameTab"..i] == BankFrameTab1 then
			self:SetWidth(49 + self:GetFontString():GetStringWidth())
		elseif _G["BankFrameTab"..i] == BankFrameTab2 then
			self:SetWidth(40 + self:GetFontString():GetStringWidth())
		end
	end)
end

hooksecurefunc(BankFrame, "Show", function()
	if _G.ContainerFrame1MoneyFrame then
		_G.ContainerFrame1MoneyFrame:ClearAllPoints()
		_G.ContainerFrame1MoneyFrame:SetPoint("TOPRIGHT", _G.ContainerFrame1, "TOPRIGHT", -2, -272)
	end
end)