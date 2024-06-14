if _G.CurrencyTransferLog then
	CurrencyTransferLog.ScrollBar:SetSize(25, 560)
	CurrencyTransferLog.ScrollBar:ClearAllPoints()
	CurrencyTransferLog.ScrollBar:SetPoint("TOPLEFT", CurrencyTransferLog.ScrollBox, "TOPRIGHT", -2, 2)
	CurrencyTransferLog.ScrollBar:SetPoint("BOTTOMLEFT", CurrencyTransferLog.ScrollBox, "BOTTOMRIGHT", -2, 0)

	if (CurrencyTransferLog.ScrollBar.Backplate == nil) then
		CurrencyTransferLog.ScrollBar.Backplate = CurrencyTransferLog.ScrollBar:CreateTexture(nil, "BACKGROUND")
		CurrencyTransferLog.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
		CurrencyTransferLog.ScrollBar.Backplate:SetAllPoints()
	end

	ApplyScrollBarArrow(CurrencyTransferLog.ScrollBar)
	ApplyScrollBarTrack(CurrencyTransferLog.ScrollBar.Track)
	ApplyScrollBarThumb(CurrencyTransferLog.ScrollBar.Track.Thumb)
end

if _G.CurrencyTransferMenu then
	ApplyDropDown(CurrencyTransferMenu.SourceSelector.Dropdown)
end