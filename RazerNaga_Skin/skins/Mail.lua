if _G.MailFrame then
	MailFrameCloseButton:SetSize(32, 32)
	MailFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
	MailFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	MailFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
	MailFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
	MailFrameCloseButton:ClearAllPoints()
	MailFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
	MailFrameCloseButton:SetFrameLevel(2)

	MailFrame.PortraitContainer.CircleMask:Hide()

	MailFramePortrait:SetSize(61, 61)
	MailFramePortrait:ClearAllPoints()
	MailFramePortrait:SetPoint("TOPLEFT", -6, 8)

	MailFrame.TitleContainer:ClearAllPoints()
	MailFrame.TitleContainer:SetPoint("TOPLEFT", MailFrame, "TOPLEFT", 85, 0)
	MailFrame.TitleContainer:SetPoint("TOPRIGHT", MailFrame, "TOPRIGHT", -58, 0)

	MailFrame:CreateTexture("MailFrameTitleBg")
	MailFrame.TitleBg = MailFrameTitleBg
	MailFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
	MailFrame.TitleBg:SetSize(256, 18)
	MailFrame.TitleBg:SetHorizTile(true)
	MailFrame.TitleBg:ClearAllPoints()
	MailFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
	MailFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

	MailFrame.TopTileStreaks:ClearAllPoints()
	MailFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
	MailFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

	ApplyNineSlicePortrait(MailFrame.NineSlice)

	MailFrameTab2:ClearAllPoints()
	MailFrameTab2:SetPoint("LEFT", MailFrameTab1, "RIGHT", -8, 0)

	for i = 1, 2 do
		ApplyBottomTab(_G['MailFrameTab'..i])

		_G["MailFrameTab"..i]:HookScript("OnShow", function()
			MailFrameTab1:SetWidth(45 + MailFrameTab1:GetFontString():GetStringWidth())
			MailFrameTab2:SetWidth(40 + MailFrameTab2:GetFontString():GetStringWidth())
		end)
	end

	SendMailScrollFrame.ScrollBar:SetSize(25, 560)
	SendMailScrollFrame.ScrollBar:ClearAllPoints()
	SendMailScrollFrame.ScrollBar:SetPoint("TOPLEFT", SendMailScrollFrame, "TOPRIGHT", 3, 3)
	SendMailScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", SendMailScrollFrame, "BOTTOMRIGHT", 6, -2)

	ApplyScrollBarArrow(SendMailScrollFrame.ScrollBar)
	ApplyScrollBarTrack(SendMailScrollFrame.ScrollBar.Track)
	ApplyScrollBarThumb(SendMailScrollFrame.ScrollBar.Track.Thumb)
end

if _G.OpenMailFrame then
	OpenMailFrameCloseButton:SetSize(32, 32)
	OpenMailFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
	OpenMailFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
	OpenMailFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
	OpenMailFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
	OpenMailFrameCloseButton:ClearAllPoints()
	OpenMailFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
	OpenMailFrameCloseButton:SetFrameLevel(2)

	OpenMailFrame.PortraitContainer.CircleMask:Hide()

	OpenMailFramePortrait:SetSize(61, 61)
	OpenMailFramePortrait:ClearAllPoints()
	OpenMailFramePortrait:SetPoint("TOPLEFT", -6, 8)

	OpenMailFrame.TitleContainer:ClearAllPoints()
	OpenMailFrame.TitleContainer:SetPoint("TOPLEFT", OpenMailFrame, "TOPLEFT", 85, 0)
	OpenMailFrame.TitleContainer:SetPoint("TOPRIGHT", OpenMailFrame, "TOPRIGHT", -58, 0)

	OpenMailFrame:CreateTexture("OpenMailFrameTitleBg")
	OpenMailFrame.TitleBg = OpenMailFrameTitleBg
	OpenMailFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", true)
	OpenMailFrame.TitleBg:SetHorizTile(true)
	OpenMailFrame.TitleBg:ClearAllPoints()
	OpenMailFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
	OpenMailFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

	OpenMailFrame.TopTileStreaks:ClearAllPoints()
	OpenMailFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
	OpenMailFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

	ApplyNineSlicePortrait(OpenMailFrame.NineSlice)

	OpenMailScrollFrame.ScrollBar:SetSize(25, 560)
	OpenMailScrollFrame.ScrollBar:ClearAllPoints()
	OpenMailScrollFrame.ScrollBar:SetPoint("TOPLEFT", OpenMailScrollFrame, "TOPRIGHT", 3, 3)
	OpenMailScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", OpenMailScrollFrame, "BOTTOMRIGHT", 6, -2)

	ApplyScrollBarArrow(OpenMailScrollFrame.ScrollBar)
	ApplyScrollBarTrack(OpenMailScrollFrame.ScrollBar.Track)
	ApplyScrollBarThumb(OpenMailScrollFrame.ScrollBar.Track.Thumb)
end