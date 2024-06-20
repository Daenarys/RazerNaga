if not _G.CharacterFrame then return end

ReputationFrame.ScrollBar:SetSize(25, 560)
ReputationFrame.ScrollBar:ClearAllPoints()
ReputationFrame.ScrollBar:SetPoint("TOPLEFT", ReputationFrame.ScrollBox, "TOPRIGHT", -1, 3)
ReputationFrame.ScrollBar:SetPoint("BOTTOMLEFT", ReputationFrame.ScrollBox, "BOTTOMRIGHT", 2, -1)

if (ReputationFrame.ScrollBar.Backplate == nil) then
	ReputationFrame.ScrollBar.Backplate = ReputationFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	ReputationFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	ReputationFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(ReputationFrame.ScrollBar)
ApplyScrollBarTrack(ReputationFrame.ScrollBar.Track)
ApplyScrollBarThumb(ReputationFrame.ScrollBar.Track.Thumb)

TokenFrame.ScrollBar:SetSize(25, 560)
TokenFrame.ScrollBar:ClearAllPoints()
TokenFrame.ScrollBar:SetPoint("TOPLEFT", TokenFrame.ScrollBox, "TOPRIGHT", -1, 3)
TokenFrame.ScrollBar:SetPoint("BOTTOMLEFT", TokenFrame.ScrollBox, "BOTTOMRIGHT", 2, -1)

if (TokenFrame.ScrollBar.Backplate == nil) then
	TokenFrame.ScrollBar.Backplate = TokenFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	TokenFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	TokenFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(TokenFrame.ScrollBar)
ApplyScrollBarTrack(TokenFrame.ScrollBar.Track)
ApplyScrollBarThumb(TokenFrame.ScrollBar.Track.Thumb)

TokenFrame.CurrencyTransferLogToggleButton:ClearAllPoints()
TokenFrame.CurrencyTransferLogToggleButton:SetPoint("TOPRIGHT", -11, -32)

PaperDollFrame.TitleManagerPane.ScrollBar:SetSize(25, 560)
PaperDollFrame.TitleManagerPane.ScrollBar:ClearAllPoints()
PaperDollFrame.TitleManagerPane.ScrollBar:SetPoint("TOPLEFT", PaperDollFrame.TitleManagerPane.ScrollBox, "TOPRIGHT", 2, 0)
PaperDollFrame.TitleManagerPane.ScrollBar:SetPoint("BOTTOMLEFT", PaperDollFrame.TitleManagerPane.ScrollBox, "BOTTOMRIGHT", 2, -1)

if (PaperDollFrame.TitleManagerPane.ScrollBar.Backplate == nil) then
	PaperDollFrame.TitleManagerPane.ScrollBar.Backplate = PaperDollFrame.TitleManagerPane.ScrollBar:CreateTexture(nil, "BACKGROUND")
	PaperDollFrame.TitleManagerPane.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	PaperDollFrame.TitleManagerPane.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(PaperDollFrame.TitleManagerPane.ScrollBar)
ApplyScrollBarTrack(PaperDollFrame.TitleManagerPane.ScrollBar.Track)
ApplyScrollBarThumb(PaperDollFrame.TitleManagerPane.ScrollBar.Track.Thumb)

PaperDollFrame.EquipmentManagerPane.ScrollBar:SetSize(25, 560)
PaperDollFrame.EquipmentManagerPane.ScrollBar:ClearAllPoints()
PaperDollFrame.EquipmentManagerPane.ScrollBar:SetPoint("TOPLEFT", PaperDollFrame.EquipmentManagerPane.ScrollBox, "TOPRIGHT", 2, 23)
PaperDollFrame.EquipmentManagerPane.ScrollBar:SetPoint("BOTTOMLEFT", PaperDollFrame.EquipmentManagerPane.ScrollBox, "BOTTOMRIGHT", 2, -1)

if (PaperDollFrame.EquipmentManagerPane.ScrollBar.Backplate == nil) then
	PaperDollFrame.EquipmentManagerPane.ScrollBar.Backplate = PaperDollFrame.EquipmentManagerPane.ScrollBar:CreateTexture(nil, "BACKGROUND")
	PaperDollFrame.EquipmentManagerPane.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	PaperDollFrame.EquipmentManagerPane.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(PaperDollFrame.EquipmentManagerPane.ScrollBar)
ApplyScrollBarTrack(PaperDollFrame.EquipmentManagerPane.ScrollBar.Track)
ApplyScrollBarThumb(PaperDollFrame.EquipmentManagerPane.ScrollBar.Track.Thumb)

GearManagerPopupFrame.IconSelector.ScrollBar:SetSize(25, 560)
GearManagerPopupFrame.IconSelector.ScrollBar:ClearAllPoints()
GearManagerPopupFrame.IconSelector.ScrollBar:SetPoint("TOPRIGHT", -3, 30)
GearManagerPopupFrame.IconSelector.ScrollBar:SetPoint("BOTTOMRIGHT", -3, -2)

if (GearManagerPopupFrame.IconSelector.ScrollBar.Backplate == nil) then
	GearManagerPopupFrame.IconSelector.ScrollBar.Backplate = GearManagerPopupFrame.IconSelector.ScrollBar:CreateTexture(nil, "BACKGROUND")
	GearManagerPopupFrame.IconSelector.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	GearManagerPopupFrame.IconSelector.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(GearManagerPopupFrame.IconSelector.ScrollBar)
ApplyScrollBarTrack(GearManagerPopupFrame.IconSelector.ScrollBar.Track)
ApplyScrollBarThumb(GearManagerPopupFrame.IconSelector.ScrollBar.Track.Thumb)

hooksecurefunc(CharacterFrame, "UpdateSize", function(self)
	if ReputationFrame:IsShown() then
		self:SetWidth(338)
	elseif TokenFrame:IsShown() then
		self:SetWidth(338)
	end
end)

hooksecurefunc("PaperDollFrame_UpdateStats", function()
	local level = UnitLevel("player")
	local MIN_PLAYER_LEVEL_FOR_ITEM_LEVEL_DISPLAY = 70

	if ( level >= MIN_PLAYER_LEVEL_FOR_ITEM_LEVEL_DISPLAY ) then
		CharacterStatsPane.ItemLevelCategory:Show()
		CharacterStatsPane.ItemLevelFrame:Show()
		CharacterStatsPane.AttributesCategory:ClearAllPoints()
		CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane.ItemLevelFrame, "BOTTOM", 0, 0)
	else
		CharacterStatsPane.ItemLevelCategory:Hide()
		CharacterStatsPane.ItemLevelFrame:Hide()
		CharacterStatsPane.AttributesCategory:ClearAllPoints()
		CharacterStatsPane.AttributesCategory:SetPoint("TOP", CharacterStatsPane, "TOP", 0, -2)
	end
end)

CharacterModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP")
end)

PaperDollFrame:HookScript("OnShow", function()
	CharacterModelScene.ControlFrame:Hide()
end)