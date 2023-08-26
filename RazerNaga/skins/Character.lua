if not _G.CharacterFrame then return end

CharacterFrameCloseButton:SetSize(32, 32)
CharacterFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
CharacterFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
CharacterFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
CharacterFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
CharacterFrameCloseButton:ClearAllPoints()
CharacterFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
CharacterFrameCloseButton:SetFrameLevel(2)

CharacterFrame.PortraitContainer.CircleMask:Hide()

CharacterFramePortrait:SetSize(61, 61)
CharacterFramePortrait:ClearAllPoints()
CharacterFramePortrait:SetPoint("TOPLEFT", -6, 8)

CharacterFrame.TitleContainer:ClearAllPoints()
CharacterFrame.TitleContainer:SetPoint("TOPLEFT", CharacterFrame, "TOPLEFT", 58, 0)
CharacterFrame.TitleContainer:SetPoint("TOPRIGHT", CharacterFrame, "TOPRIGHT", -58, 0)

CharacterFrame:CreateTexture("CharacterFrameTitleBg")
CharacterFrame.TitleBg = CharacterFrameTitleBg
CharacterFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
CharacterFrame.TitleBg:SetSize(256, 18)
CharacterFrame.TitleBg:SetHorizTile(true)
CharacterFrame.TitleBg:ClearAllPoints()
CharacterFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
CharacterFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

CharacterFrame.TopTileStreaks:ClearAllPoints()
CharacterFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
CharacterFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(CharacterFrame.NineSlice)

CharacterFrameTab2:ClearAllPoints()
CharacterFrameTab2:SetPoint("LEFT", CharacterFrameTab1, "RIGHT", -15, 0)
CharacterFrameTab3:ClearAllPoints()
CharacterFrameTab3:SetPoint("LEFT", CharacterFrameTab2, "RIGHT", -15, 0)

for i = 1, 3 do
	ApplyBottomTab(_G['CharacterFrameTab'..i])

	_G["CharacterFrameTab"..i]:HookScript("OnShow", function(self)
		self:SetWidth(40 + self:GetFontString():GetStringWidth())
	end)
end

ReputationFrame.ScrollBar:SetSize(25, 560)
ReputationFrame.ScrollBar:ClearAllPoints()
ReputationFrame.ScrollBar:SetPoint("TOPLEFT", ReputationFrame.ScrollBox, "TOPRIGHT", -1, 3)
ReputationFrame.ScrollBar:SetPoint("BOTTOMLEFT", ReputationFrame.ScrollBox, "BOTTOMRIGHT", 2, -1)

ApplyScrollBarArrow(ReputationFrame.ScrollBar)
ApplyScrollBarTrack(ReputationFrame.ScrollBar.Track)
ApplyScrollBarThumb(ReputationFrame.ScrollBar.Track.Thumb)

ReputationDetailCloseButton:SetSize(32, 32)
ReputationDetailCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
ReputationDetailCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
ReputationDetailCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
ReputationDetailCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
ReputationDetailCloseButton:ClearAllPoints()
ReputationDetailCloseButton:SetPoint("TOPRIGHT", -3, -3)

if (ReputationDetailFrameCorner == nil) then
	ReputationDetailFrame:CreateTexture("ReputationDetailFrameCorner")
	ReputationDetailFrameCorner:SetSize(32, 32)
	ReputationDetailFrameCorner:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Corner")
	ReputationDetailFrameCorner:ClearAllPoints()
	ReputationDetailFrameCorner:SetPoint("TOPRIGHT", -6, -7)
end

ApplyDialogBorder(ReputationDetailFrame.Border)

TokenFrame.ScrollBar:SetSize(25, 560)
TokenFrame.ScrollBar:ClearAllPoints()
TokenFrame.ScrollBar:SetPoint("TOPLEFT", TokenFrame.ScrollBox, "TOPRIGHT", -1, 3)
TokenFrame.ScrollBar:SetPoint("BOTTOMLEFT", TokenFrame.ScrollBox, "BOTTOMRIGHT", 2, -1)

ApplyScrollBarArrow(TokenFrame.ScrollBar)
ApplyScrollBarTrack(TokenFrame.ScrollBar.Track)
ApplyScrollBarThumb(TokenFrame.ScrollBar.Track.Thumb)

select(4, TokenFramePopup:GetChildren()):SetSize(32, 32)
select(4, TokenFramePopup:GetChildren()):SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
select(4, TokenFramePopup:GetChildren()):SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
select(4, TokenFramePopup:GetChildren()):SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
select(4, TokenFramePopup:GetChildren()):SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
select(4, TokenFramePopup:GetChildren()):ClearAllPoints()
select(4, TokenFramePopup:GetChildren()):SetPoint("TOPRIGHT", -3, -3)

if (TokenFramePopupCorner == nil) then
	TokenFramePopup:CreateTexture("TokenFramePopupCorner")
	TokenFramePopupCorner:SetSize(32, 32)
	TokenFramePopupCorner:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Corner")
	TokenFramePopupCorner:ClearAllPoints()
	TokenFramePopupCorner:SetPoint("TOPRIGHT", -6, -7)
end

ApplyDialogBorder(TokenFramePopup.Border)

PaperDollFrame.TitleManagerPane.ScrollBar:SetSize(25, 560)
PaperDollFrame.TitleManagerPane.ScrollBar:ClearAllPoints()
PaperDollFrame.TitleManagerPane.ScrollBar:SetPoint("TOPLEFT", PaperDollFrame.TitleManagerPane.ScrollBox, "TOPRIGHT", 1, 1)
PaperDollFrame.TitleManagerPane.ScrollBar:SetPoint("BOTTOMLEFT", PaperDollFrame.TitleManagerPane.ScrollBox, "BOTTOMRIGHT", 4, -1)

ApplyScrollBarArrow(PaperDollFrame.TitleManagerPane.ScrollBar)
ApplyScrollBarTrack(PaperDollFrame.TitleManagerPane.ScrollBar.Track)
ApplyScrollBarThumb(PaperDollFrame.TitleManagerPane.ScrollBar.Track.Thumb)

PaperDollFrame.EquipmentManagerPane.ScrollBar:SetSize(25, 560)
PaperDollFrame.EquipmentManagerPane.ScrollBar:ClearAllPoints()
PaperDollFrame.EquipmentManagerPane.ScrollBar:SetPoint("TOPLEFT", PaperDollFrame.EquipmentManagerPane.ScrollBox, "TOPRIGHT", 1, 24)
PaperDollFrame.EquipmentManagerPane.ScrollBar:SetPoint("BOTTOMLEFT", PaperDollFrame.EquipmentManagerPane.ScrollBox, "BOTTOMRIGHT", 4, -1)

ApplyScrollBarArrow(PaperDollFrame.EquipmentManagerPane.ScrollBar)
ApplyScrollBarTrack(PaperDollFrame.EquipmentManagerPane.ScrollBar.Track)
ApplyScrollBarThumb(PaperDollFrame.EquipmentManagerPane.ScrollBar.Track.Thumb)