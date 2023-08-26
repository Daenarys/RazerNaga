local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ArtifactUI" then
		ArtifactFrame.CloseButton:SetSize(32, 32)
		ArtifactFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ArtifactFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ArtifactFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ArtifactFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ArtifactFrame.CloseButton:ClearAllPoints()
		ArtifactFrame.CloseButton:SetPoint("TOPRIGHT", 8, 7)

		ApplyBottomTab(ArtifactFrameTab1)

		ArtifactFrameTab1:HookScript("OnShow", function(self)
			self:SetWidth(46 + self:GetFontString():GetStringWidth())
		end)
	end
end)