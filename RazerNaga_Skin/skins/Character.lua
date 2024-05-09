if not _G.CharacterFrame then return end

_G.PaperDollFrame:HookScript("OnShow", function()
	CharacterModelScene.ControlFrame:Hide()
end)

_G.CharacterModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP", -4, 1)

	self.zoomInButton:ClearAllPoints()
	self.zoomInButton:SetPoint("LEFT", 2, 0)

	self.zoomOutButton:ClearAllPoints()
	self.zoomOutButton:SetPoint("LEFT", self.zoomInButton, "RIGHT", -8, 0)

	self.rotateLeftButton:ClearAllPoints()
	self.rotateLeftButton:SetPoint("LEFT", self.zoomOutButton, "RIGHT", -8, 0)

	self.rotateRightButton:ClearAllPoints()
	self.rotateRightButton:SetPoint("LEFT", self.rotateLeftButton, "RIGHT", -8, 0)

	self.resetButton:ClearAllPoints()
	self.resetButton:SetPoint("LEFT", self.rotateRightButton, "RIGHT", -8, 0)
end)