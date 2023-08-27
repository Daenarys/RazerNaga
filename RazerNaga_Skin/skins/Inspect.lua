local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_InspectUI" then
		InspectFrameCloseButton:SetSize(32, 32)
		InspectFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		InspectFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		InspectFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		InspectFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		InspectFrameCloseButton:ClearAllPoints()
		InspectFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		InspectFrameCloseButton:SetFrameLevel(2)

		InspectFrame.PortraitContainer.CircleMask:Hide()

		InspectFramePortrait:SetSize(61, 61)
		InspectFramePortrait:ClearAllPoints()
		InspectFramePortrait:SetPoint("TOPLEFT", -6, 8)

		InspectFrame.TitleContainer:ClearAllPoints()
		InspectFrame.TitleContainer:SetPoint("TOPLEFT", InspectFrame, "TOPLEFT", 58, 0)
		InspectFrame.TitleContainer:SetPoint("TOPRIGHT", InspectFrame, "TOPRIGHT", -58, 0)

		InspectFrame:CreateTexture("InspectFrameTitleBg")
		InspectFrame.TitleBg = InspectFrameTitleBg
		InspectFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		InspectFrame.TitleBg:SetSize(256, 18)
		InspectFrame.TitleBg:SetHorizTile(true)
		InspectFrame.TitleBg:ClearAllPoints()
		InspectFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		InspectFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		InspectFrame.TopTileStreaks:ClearAllPoints()
		InspectFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		InspectFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(InspectFrame.NineSlice)

		InspectFrameTab2:ClearAllPoints()
		InspectFrameTab2:SetPoint("LEFT", InspectFrameTab1, "RIGHT", -16, 0)
		InspectFrameTab3:ClearAllPoints()
		InspectFrameTab3:SetPoint("LEFT", InspectFrameTab2, "RIGHT", -16, 0)

		for i = 1, 3 do
			ApplyBottomTab(_G['InspectFrameTab'..i])

			_G["InspectFrameTab"..i]:HookScript("OnShow", function()
				InspectFrameTab1:SetWidth(40 + InspectFrameTab1:GetFontString():GetStringWidth())
				InspectFrameTab2:SetWidth(56 + InspectFrameTab2:GetFontString():GetStringWidth())
				InspectFrameTab3:SetWidth(50 + InspectFrameTab3:GetFontString():GetStringWidth())
			end)
		end
	end
end)