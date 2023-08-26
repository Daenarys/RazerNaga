local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ScrappingMachineUI" then
		ScrappingMachineFrameCloseButton:SetSize(32, 32)
		ScrappingMachineFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ScrappingMachineFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ScrappingMachineFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ScrappingMachineFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ScrappingMachineFrameCloseButton:ClearAllPoints()
		ScrappingMachineFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ScrappingMachineFrameCloseButton:SetFrameLevel(2)

		ScrappingMachineFrame.PortraitContainer.CircleMask:Hide()

		ScrappingMachineFramePortrait:SetSize(61, 61)
		ScrappingMachineFramePortrait:ClearAllPoints()
		ScrappingMachineFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ScrappingMachineFrame.TitleContainer:ClearAllPoints()
		ScrappingMachineFrame.TitleContainer:SetPoint("TOPLEFT", ScrappingMachineFrame, "TOPLEFT", 58, 0)
		ScrappingMachineFrame.TitleContainer:SetPoint("TOPRIGHT", ScrappingMachineFrame, "TOPRIGHT", -58, 0)

		ScrappingMachineFrame:CreateTexture("ScrappingMachineFrameTitleBg")
		ScrappingMachineFrame.TitleBg = ScrappingMachineFrameTitleBg
		ScrappingMachineFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ScrappingMachineFrame.TitleBg:SetSize(256, 18)
		ScrappingMachineFrame.TitleBg:SetHorizTile(true)
		ScrappingMachineFrame.TitleBg:ClearAllPoints()
		ScrappingMachineFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ScrappingMachineFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ScrappingMachineFrame.TopTileStreaks:ClearAllPoints()
		ScrappingMachineFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ScrappingMachineFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ScrappingMachineFrame.NineSlice)
		
		hooksecurefunc(ScrappingMachineFrame, "Show", function()
			if _G.ContainerFrame1MoneyFrame then
				_G.ContainerFrame1MoneyFrame:ClearAllPoints()
				_G.ContainerFrame1MoneyFrame:SetPoint("TOPRIGHT", _G.ContainerFrame1, "TOPRIGHT", -2, -272)
			end
		end)
	end
end)