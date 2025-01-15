if not _G.Minimap then return end

Minimap:HookScript("OnEvent", function(self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		ExpansionLandingPageMinimapButton:SetLandingPageIconFromAtlases("plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-down", "plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-up", true)
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", -3, -150)

		hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIcon", function(self)
			self:SetLandingPageIconFromAtlases("plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-down", "plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-up", true)
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", -3, -150)
		end)

		hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIconForGarrison", function(self)
			self:SetLandingPageIconFromAtlases("plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-down", "plunderstorm-landingpagebutton-up", "plunderstorm-landingpagebutton-up", true)
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", -3, -150)
		end)
	end
end)