local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_AuctionHouseUI" then
		ApplyDialogBorder(AuctionHouseFrame.BuyDialog.Border)
	end
end)