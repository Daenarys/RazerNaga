if not _G.MerchantFrame then return end

MerchantFrameCloseButton:SetSize(32, 32)
MerchantFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
MerchantFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
MerchantFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
MerchantFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
MerchantFrameCloseButton:ClearAllPoints()
MerchantFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
MerchantFrameCloseButton:SetFrameLevel(2)

MerchantFrame.PortraitContainer.CircleMask:Hide()

MerchantFramePortrait:SetSize(61, 61)
MerchantFramePortrait:ClearAllPoints()
MerchantFramePortrait:SetPoint("TOPLEFT", -6, 8)

MerchantFrame.TitleContainer:ClearAllPoints()
MerchantFrame.TitleContainer:SetPoint("TOPLEFT", MerchantFrame, "TOPLEFT", 58, 0)
MerchantFrame.TitleContainer:SetPoint("TOPRIGHT", MerchantFrame, "TOPRIGHT", -58, 0)

MerchantFrame:CreateTexture("MerchantFrameTitleBg")
MerchantFrame.TitleBg = MerchantFrameTitleBg
MerchantFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
MerchantFrame.TitleBg:SetSize(256, 18)
MerchantFrame.TitleBg:SetHorizTile(true)
MerchantFrame.TitleBg:ClearAllPoints()
MerchantFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
MerchantFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

MerchantFrame.TopTileStreaks:ClearAllPoints()
MerchantFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
MerchantFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(MerchantFrame.NineSlice)

MerchantFrameBottomLeftBorder:SetSize(256, 61)
MerchantFrameBottomLeftBorder:SetTexture("Interface\\MerchantFrame\\UI-Merchant-BottomBorder")
MerchantFrameBottomLeftBorder:SetTexCoord(0, 1, 0, 0.4765625)

MerchantFrame:CreateTexture("MerchantFrameBottomRightBorder", "OVERLAY")
MerchantFrameBottomRightBorder:SetSize(76, 61)
MerchantFrameBottomRightBorder:SetTexture("Interface\\MerchantFrame\\UI-Merchant-BottomBorder")
MerchantFrameBottomRightBorder:SetTexCoord(0, 0.296875, 0.4765625, 0.953125)
MerchantFrameBottomRightBorder:SetPoint("LEFT", MerchantFrameBottomLeftBorder, "RIGHT")

MerchantFrameTab2:ClearAllPoints()
MerchantFrameTab2:SetPoint("LEFT", MerchantFrameTab1, "RIGHT", -16, 0)

for i = 1, 2 do
	ApplyBottomTab(_G['MerchantFrameTab'..i])

	_G["MerchantFrameTab"..i]:HookScript("OnShow", function(self)
		self:SetWidth(40 + self:GetFontString():GetStringWidth())
	end)
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
	UndoFrame:Hide()
	MerchantSellAllJunkButton:Hide()
	MerchantFrameBottomRightBorder:Show();
	MerchantBuyBackItemNameFrame:Show()

	local numBuybackItems = GetNumBuybackItems();
	local buybackName = GetBuybackItemInfo(numBuybackItems);
	if ( buybackName ) then
		MerchantBuyBackItemMoneyFrame:Show();
		
	else
		MerchantBuyBackItemMoneyFrame:Hide();
	end

	MerchantBuyBackItem:SetSize(153, 37)
	MerchantBuyBackItem:ClearAllPoints()
	MerchantBuyBackItem:SetPoint("TOPLEFT", MerchantItem10, "BOTTOMLEFT", 0, -53)
	MerchantBuyBackItemItemButton:SetItemButtonScale(1)
	MerchantBuyBackItemName:SetSize(90, 30)
	MerchantBuyBackItemName:ClearAllPoints()
	MerchantBuyBackItemName:SetPoint("LEFT", MerchantBuyBackItemSlotTexture, "RIGHT", -5, 10)
	MerchantBuyBackItemNameFrame:SetSize(128, 64)

	MerchantRepairItemButton.Icon:SetTexture("Interface\\MerchantFrame\\UI-Merchant-RepairIcons")
	MerchantRepairItemButton.Icon:SetTexCoord(0, 0.28125, 0, 0.5625)
	MerchantRepairItemButton:DisableDrawLayer("BACKGROUND")
	MerchantRepairAllButton.Icon:SetTexture("Interface\\MerchantFrame\\UI-Merchant-RepairIcons")
	MerchantRepairAllButton.Icon:SetTexCoord(0.28125, 0.5625, 0, 0.5625)
	MerchantRepairAllButton:DisableDrawLayer("BACKGROUND")
	MerchantGuildBankRepairButton:SetSize(32, 32)
	MerchantGuildBankRepairButton:ClearAllPoints()
	MerchantGuildBankRepairButton:SetPoint("LEFT", MerchantRepairAllButton, "RIGHT", 4, 0)
	MerchantGuildBankRepairButton:DisableDrawLayer("BACKGROUND")
	MerchantGuildBankRepairButton.Icon:SetTexture("Interface\\MerchantFrame\\UI-Merchant-RepairIcons")
	MerchantGuildBankRepairButton.Icon:SetTexCoord(0.5625, 0.84375, 0, 0.5625)

	if _G.ContainerFrame1MoneyFrame then
		_G.ContainerFrame1MoneyFrame:ClearAllPoints()
		_G.ContainerFrame1MoneyFrame:SetPoint("TOPRIGHT", _G.ContainerFrame1, "TOPRIGHT", -2, -272)
	end
end)

local MerchantRepairText = MerchantFrame:CreateFontString(nil, "BORDER", "GameFontHighlightSmall")
MerchantRepairText:SetText(REPAIR_ITEMS)
MerchantRepairText:Hide();

hooksecurefunc("MerchantFrame_UpdateBuybackInfo", function()
	MerchantFrameBottomRightBorder:Hide();
	MerchantRepairText:Hide();
end)

hooksecurefunc("MerchantFrame_UpdateRepairButtons", function()
	if ( CanMerchantRepair() ) then
		if ( CanGuildBankRepair() ) then
			MerchantRepairAllButton:SetWidth(32);
			MerchantRepairAllButton:SetHeight(32);
			MerchantRepairItemButton:SetWidth(32);
			MerchantRepairItemButton:SetHeight(32);
			MerchantRepairItemButton:SetPoint("RIGHT", MerchantRepairAllButton, "LEFT", -4, 0);

			MerchantRepairAllButton:SetPoint("BOTTOMRIGHT", MerchantFrame, "BOTTOMLEFT", 100, 30);
			MerchantRepairText:ClearAllPoints();
			MerchantRepairText:SetPoint("CENTER", MerchantFrame, "BOTTOMLEFT", 80, 68);
		else
			MerchantRepairAllButton:SetWidth(36);
			MerchantRepairAllButton:SetHeight(36);
			MerchantRepairItemButton:SetWidth(36);
			MerchantRepairItemButton:SetHeight(36);
			MerchantRepairItemButton:SetPoint("RIGHT", MerchantRepairAllButton, "LEFT", -2, 0);

			MerchantRepairAllButton:SetPoint("BOTTOMRIGHT", MerchantFrame, "BOTTOMLEFT", 160, 32);
			MerchantRepairText:ClearAllPoints();
			MerchantRepairText:SetPoint("BOTTOMLEFT", MerchantFrame, "BOTTOMLEFT", 14, 45);
		end
		MerchantRepairText:Show();
	else
		MerchantRepairText:Hide();
	end
end)