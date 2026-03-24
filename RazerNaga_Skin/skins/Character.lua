if not _G.CharacterFrame then return end

CharacterFrame.Background:Hide()
ReputationFrame.filterDropdown:Hide()
TokenFrame.CurrencyTransferLogToggleButton:Hide()
TokenFrame.filterDropdown:Hide()

if (ReputationFrame.FactionLabel == nil) then
	ReputationFrame.FactionLabel = ReputationFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ReputationFrame.FactionLabel:SetText(FACTION)
	ReputationFrame.FactionLabel:SetPoint("TOPLEFT", 70, -42)
end
if (ReputationFrame.StandingLabel == nil) then
	ReputationFrame.StandingLabel = ReputationFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	ReputationFrame.StandingLabel:SetText(STANDING)
	ReputationFrame.StandingLabel:SetPoint("TOPLEFT", 215, -42)
end

hooksecurefunc(ReputationHeaderMixin, "Initialize", function(self)
	if not self.IsSkinned then
		self.Name:SetPoint("LEFT", 20, 0)

		self.Left:SetAlpha(0)
		self.Right:SetAlpha(0)
		self.Middle:SetAlpha(0)

		if (self.ExpandOrCollapseButton == nil) then
			self.ExpandOrCollapseButton = self:CreateTexture(nil, "ARTWORK")
			self.ExpandOrCollapseButton:SetSize(16, 16)
			self.ExpandOrCollapseButton:SetPoint("LEFT")
		end

		self.HighlightLeft:SetAlpha(0)
		self.HighlightRight:SetAlpha(0)
		self.HighlightMiddle:SetAlpha(0)

		self:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
		self:GetHighlightTexture():SetAllPoints(self.ExpandOrCollapseButton)

		self.IsSkinned = true
	end

	if self:IsCollapsed() then
		self.ExpandOrCollapseButton:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")
	else
		self.ExpandOrCollapseButton:SetTexture("Interface\\Buttons\\UI-MinusButton-Up")
	end
end)

hooksecurefunc(TokenHeaderMixin, "Initialize", function(self)
	if not self.IsSkinned then
		self.Name:SetPoint("LEFT", 22, 0)

		if self.Left then
			self.Left:SetSize(76, 16)
			self.Left:ClearAllPoints()
			self.Left:SetPoint("LEFT")
			self.Left:SetTexture("Interface\\Buttons\\CollapsibleHeader")
			self.Left:SetTexCoord(0.17578125, 0.47265625, 0.29687500, 0.54687500)
		end

		if self.Right then
			self.Right:ClearAllPoints()
			self.Right:SetPoint("RIGHT")

			hooksecurefunc(self, "UpdateCollapsedState", function()
				self.Right:SetSize(76, 16)
				self.Right:SetTexture("Interface\\Buttons\\CollapsibleHeader")
				self.Right:SetTexCoord(0.17578125, 0.47265625, 0.01562500, 0.26562500)
			end)
		end

		if self.Middle then
			self.Middle:SetSize(0, 16)
			self.Middle:ClearAllPoints()
			self.Middle:SetPoint("LEFT", self.Left, "RIGHT", -20, 0)
			self.Middle:SetPoint("RIGHT", self.Right, "LEFT", 20, 0)
			self.Middle:SetTexture("Interface\\Buttons\\CollapsibleHeader")
			self.Middle:SetTexCoord(0.48046875, 0.98046875, 0.01562500, 0.26562500)
		end

		if (self.ExpandIcon == nil) then
			self.ExpandIcon = self:CreateTexture(nil, "OVERLAY")
			self.ExpandIcon:SetSize(7, 7)
			self.ExpandIcon:SetTexture("Interface\\Buttons\\UI-PlusMinus-Buttons")
			self.ExpandIcon:SetPoint("LEFT", 8, 0)
		end

		self.HighlightLeft:SetAlpha(0)
		self.HighlightRight:SetAlpha(0)
		self.HighlightMiddle:SetAlpha(0)

		self:SetHighlightTexture("Interface\\TokenFrame\\UI-TokenFrame-CategoryButton")
		self:GetHighlightTexture():SetTexCoord(0, 1, 0.609375, 0.796875)
		self:GetHighlightTexture():ClearAllPoints()
		self:GetHighlightTexture():SetPoint("TOPLEFT", 3, -7)
		self:GetHighlightTexture():SetPoint("BOTTOMRIGHT", -3, 7)

		self.IsSkinned = true
	end

	if self:IsCollapsed() then
		self.ExpandIcon:SetTexCoord(0, 0.4375, 0, 0.4375)
	else
		self.ExpandIcon:SetTexCoord(0.5625, 1, 0, 0.4375)
	end
end)

ApplyDropDown(GearManagerPopupFrame.BorderBox.IconTypeDropdown)

hooksecurefunc(CharacterFrame, "UpdatePortrait", function(self)
	self:SetPortraitToSpecIcon()
end)

hooksecurefunc(CharacterFrame, "UpdateSize", function(self)
	if ReputationFrame:IsShown() or TokenFrame:IsShown() then
		self:SetWidth(338)
	end
end)

hooksecurefunc(CharacterFrame, "UpdateTitle", function(self)
	self:SetTitleColor(HIGHLIGHT_FONT_COLOR)
	self:SetTitle(UnitPVPName("player"))
end)