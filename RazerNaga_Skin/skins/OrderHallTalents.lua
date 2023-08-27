local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_OrderHallUI" then
		hooksecurefunc(OrderHallTalentFrame, 'RefreshAllData', function(frame)
			OrderHallTalentFrameCloseButton:SetSize(32, 32)
			OrderHallTalentFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
			OrderHallTalentFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
			OrderHallTalentFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
			OrderHallTalentFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			OrderHallTalentFrameCloseButton:ClearAllPoints()
			OrderHallTalentFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
			OrderHallTalentFrameCloseButton:SetFrameLevel(2)

			OrderHallTalentFrame.PortraitContainer.CircleMask:Hide()

			OrderHallTalentFramePortrait:SetSize(61, 61)
			OrderHallTalentFramePortrait:ClearAllPoints()
			OrderHallTalentFramePortrait:SetPoint("TOPLEFT", -6, 8)

			OrderHallTalentFrame.TitleContainer:ClearAllPoints()
			OrderHallTalentFrame.TitleContainer:SetPoint("TOPLEFT", OrderHallTalentFrame, "TOPLEFT", 58, 0)
			OrderHallTalentFrame.TitleContainer:SetPoint("TOPRIGHT", OrderHallTalentFrame, "TOPRIGHT", -58, 0)

			OrderHallTalentFrame:CreateTexture("OrderHallTalentFrameTitleBg")
			OrderHallTalentFrame.TitleBg = OrderHallTalentFrameTitleBg
			OrderHallTalentFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
			OrderHallTalentFrame.TitleBg:SetSize(256, 18)
			OrderHallTalentFrame.TitleBg:SetHorizTile(true)
			OrderHallTalentFrame.TitleBg:ClearAllPoints()
			OrderHallTalentFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
			OrderHallTalentFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

			OrderHallTalentFrame.TopTileStreaks:ClearAllPoints()
			OrderHallTalentFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
			OrderHallTalentFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

			ApplyNineSlicePortrait(OrderHallTalentFrame.NineSlice)
		end)
	end
end)