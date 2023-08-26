local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_SubscriptionInterstitialUI" then
		SubscriptionInterstitialFrame.TitleContainer:ClearAllPoints()
		SubscriptionInterstitialFrame.TitleContainer:SetPoint("TOPLEFT", SubscriptionInterstitialFrame, "TOPLEFT", 58, 0)
		SubscriptionInterstitialFrame.TitleContainer:SetPoint("TOPRIGHT", SubscriptionInterstitialFrame, "TOPRIGHT", -58, 0)

		SubscriptionInterstitialFrame.CloseButton:SetSize(32, 32)
		SubscriptionInterstitialFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		SubscriptionInterstitialFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		SubscriptionInterstitialFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		SubscriptionInterstitialFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		SubscriptionInterstitialFrame.CloseButton:ClearAllPoints()
		SubscriptionInterstitialFrame.CloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		SubscriptionInterstitialFrame.CloseButton:SetFrameLevel(2)

		SubscriptionInterstitialFrameBg:ClearAllPoints()
		SubscriptionInterstitialFrameBg:SetPoint("TOPLEFT", SubscriptionInterstitialFrame, "TOPLEFT", 2, -21)
		SubscriptionInterstitialFrameBg:SetPoint("BOTTOMRIGHT", SubscriptionInterstitialFrame, "BOTTOMRIGHT", -2, 2)

		SubscriptionInterstitialFrame:CreateTexture("SubscriptionInterstitialFrameTitleBg")
		SubscriptionInterstitialFrame.TitleBg = SubscriptionInterstitialFrameTitleBg
		SubscriptionInterstitialFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		SubscriptionInterstitialFrame.TitleBg:SetSize(256, 18)
		SubscriptionInterstitialFrame.TitleBg:SetHorizTile(true)
		SubscriptionInterstitialFrame.TitleBg:ClearAllPoints()
		SubscriptionInterstitialFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		SubscriptionInterstitialFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ApplyNineSliceNoPortrait(SubscriptionInterstitialFrame.NineSlice)
	end
end)