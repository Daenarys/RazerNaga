if not _G.GameMenuFrame then return end

GameMenuFrame.Header:Hide()

ApplyDialogBorder(GameMenuFrame.Border)

if not GameMenuFrameHeader then
	GameMenuFrame:CreateTexture("GameMenuFrameHeader", "ARTWORK")
	GameMenuFrameHeader:SetSize(256, 64)
	GameMenuFrameHeader:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	GameMenuFrameHeader:SetPoint("TOP", 0, 12)
end

if not GameMenuFrameHeaderText then
	local GameMenuFrameHeaderText = GameMenuFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	GameMenuFrameHeaderText:SetText(MAINMENU_BUTTON)
	GameMenuFrameHeaderText:SetPoint("TOP", GameMenuFrameHeader, 0, -14)
end