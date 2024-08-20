if not _G.CharacterFrame then return end

TokenFrame.CurrencyTransferLogToggleButton:ClearAllPoints()
TokenFrame.CurrencyTransferLogToggleButton:SetPoint("TOPRIGHT", -11, -32)

hooksecurefunc(CharacterFrame, "UpdateSize", function(self)
	if ReputationFrame:IsShown() then
		self:SetWidth(338)
	elseif TokenFrame:IsShown() then
		self:SetWidth(338)
	end
end)

hooksecurefunc("PaperDollFrame_UpdateStats", function()
	local level = UnitLevel("player")
	local MIN_PLAYER_LEVEL_FOR_ITEM_LEVEL_DISPLAY = 70

	if ( level >= MIN_PLAYER_LEVEL_FOR_ITEM_LEVEL_DISPLAY ) then
		CharacterStatsPane.ItemLevelCategory:Show()
		CharacterStatsPane.ItemLevelFrame:Show()
		CharacterStatsPane.AttributesCategory:ClearAllPoints()
		CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane.ItemLevelFrame, "BOTTOM", 0, 0)
	else
		CharacterStatsPane.ItemLevelCategory:Hide()
		CharacterStatsPane.ItemLevelFrame:Hide()
		CharacterStatsPane.AttributesCategory:ClearAllPoints()
		CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane, "TOP", 0, -2)
	end
end)

CharacterModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP")
end)

PaperDollFrame:HookScript("OnShow", function()
	CharacterModelScene.ControlFrame:Hide()
end)