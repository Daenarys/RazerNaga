if not _G.SpellBookFrame then return end

SpellBookFrameCloseButton:SetSize(32, 32)
SpellBookFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
SpellBookFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
SpellBookFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
SpellBookFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
SpellBookFrameCloseButton:ClearAllPoints()
SpellBookFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
SpellBookFrameCloseButton:SetFrameLevel(2)

SpellBookFrame.PortraitContainer.CircleMask:Hide()

SpellBookFramePortrait:SetSize(61, 61)
SpellBookFramePortrait:ClearAllPoints()
SpellBookFramePortrait:SetPoint("TOPLEFT", -6, 8)

SpellBookFrame.TitleContainer:ClearAllPoints()
SpellBookFrame.TitleContainer:SetPoint("TOPLEFT", SpellBookFrame, "TOPLEFT", 58, 0)
SpellBookFrame.TitleContainer:SetPoint("TOPRIGHT", SpellBookFrame, "TOPRIGHT", -58, 0)

SpellBookFrame:CreateTexture("SpellBookFrameTitleBg")
SpellBookFrame.TitleBg = SpellBookFrameTitleBg
SpellBookFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
SpellBookFrame.TitleBg:SetSize(256, 18)
SpellBookFrame.TitleBg:SetHorizTile(true)
SpellBookFrame.TitleBg:ClearAllPoints()
SpellBookFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
SpellBookFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

SpellBookFrame.TopTileStreaks:ClearAllPoints()
SpellBookFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
SpellBookFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

SpellBookFrameTutorialButton.Ring:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")

ApplyNineSlicePortrait(SpellBookFrame.NineSlice)

for i = 1, 3 do
	ApplyBottomTab(_G['SpellBookFrameTabButton'..i])

	_G["SpellBookFrameTabButton"..i]:HookScript("OnShow", function(self)
		SpellBookFrameTabButton1:SetWidth(40 + SpellBookFrameTabButton1:GetFontString():GetStringWidth())
		SpellBookFrameTabButton2:SetWidth(40 + SpellBookFrameTabButton2:GetFontString():GetStringWidth())
		SpellBookFrameTabButton3:SetWidth(58 + SpellBookFrameTabButton3:GetFontString():GetStringWidth())
	end)
	
	hooksecurefunc("SpellBookFrame_Update", function()
		SpellBookFrameTabButton1:ClearAllPoints()
		SpellBookFrameTabButton1:SetPoint("TOPLEFT", SpellBookFrame, "BOTTOMLEFT", 0, 1)
		SpellBookFrameTabButton2:ClearAllPoints()
		SpellBookFrameTabButton2:SetPoint("LEFT", SpellBookFrameTabButton1, "RIGHT", -15, 0)
		SpellBookFrameTabButton3:ClearAllPoints()
		SpellBookFrameTabButton3:SetPoint("LEFT", SpellBookFrameTabButton2, "RIGHT", -15, 0)
	end)
end