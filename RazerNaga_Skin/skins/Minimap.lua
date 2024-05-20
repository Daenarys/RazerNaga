Minimap:HookScript("OnEvent", function(self, event, ...)
	if PlayerGetTimerunningSeasonID() then
		ExpansionLandingPageMinimapButton:Hide()
	end
end)