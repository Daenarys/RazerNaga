Minimap:HookScript("OnEvent", function(self, event, ...)
	if PlayerGetTimerunningSeasonID() then
		ExpansionLandingPageMinimapButton:Hide()
	end

	if (ExpansionLandingPageMinimapButton:GetNormalTexture():GetAtlas() == "dragonflight-landingbutton-up") then
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", 25, -173)
	elseif (ExpansionLandingPageMinimapButton:GetNormalTexture():GetAtlas() == "warwithin-landingbutton-up") then
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", 25, -173)
	end

	hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIcon", function(self)
		if (self:GetNormalTexture():GetAtlas() == "dragonflight-landingbutton-up") then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", 25, -173)
		elseif (self:GetNormalTexture():GetAtlas() == "warwithin-landingbutton-up") then
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", 25, -173)
		end
	end)
end)