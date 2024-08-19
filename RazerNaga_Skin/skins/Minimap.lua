Minimap:HookScript("OnEvent", function(self, event, ...)
	if PlayerGetTimerunningSeasonID() then
		ExpansionLandingPageMinimapButton:Hide()
	end

	ExpansionLandingPageMinimapButton:ClearAllPoints()
	ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", 25, -173)

	hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIcon", function(self)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", 25, -173)
	end)
end)