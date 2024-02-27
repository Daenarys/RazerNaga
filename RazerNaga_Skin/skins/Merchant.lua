if not _G.MerchantFrame then return end

MerchantFrameBottomLeftBorder:SetSize(256, 61)
MerchantFrameBottomLeftBorder:SetTexture("Interface\\MerchantFrame\\UI-Merchant-BottomBorder")
MerchantFrameBottomLeftBorder:SetTexCoord(0, 1, 0, 0.4765625)

if not MerchantFrameBottomRightBorder then
	MerchantFrame:CreateTexture("MerchantFrameBottomRightBorder", "OVERLAY")
	MerchantFrameBottomRightBorder:SetSize(76, 61)
	MerchantFrameBottomRightBorder:SetTexture("Interface\\MerchantFrame\\UI-Merchant-BottomBorder")
	MerchantFrameBottomRightBorder:SetTexCoord(0, 0.296875, 0.4765625, 0.953125)
	MerchantFrameBottomRightBorder:SetPoint("LEFT", MerchantFrameBottomLeftBorder, "RIGHT")
end

hooksecurefunc("MerchantFrame_UpdateMerchantInfo", function()
	MerchantBuyBackItemItemButton.UndoFrame:Hide()
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

	MerchantRepairItemButton:DisableDrawLayer("BACKGROUND")
	MerchantRepairAllButton:DisableDrawLayer("BACKGROUND")
	MerchantGuildBankRepairButton:DisableDrawLayer("BACKGROUND")
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
			MerchantGuildBankRepairButton:SetWidth(32);
			MerchantGuildBankRepairButton:SetHeight(32);
			MerchantRepairAllButton:SetWidth(32);
			MerchantRepairAllButton:SetHeight(32);
			MerchantRepairItemButton:SetWidth(32);
			MerchantRepairItemButton:SetHeight(32);
			MerchantRepairItemButton:SetPoint("RIGHT", MerchantRepairAllButton, "LEFT", -4, 0);

			MerchantGuildBankRepairButton:SetPoint("LEFT", MerchantRepairAllButton, "RIGHT", 4, 0)

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