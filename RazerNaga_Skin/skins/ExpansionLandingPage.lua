if not _G.ExpansionLandingPage then return end

ExpansionLandingPage:HookScript("OnShow", function(self)
	for _, child in next, { self.Overlay:GetChildren() } do
	    if WarWithinLandingOverlayMixin and child.OnLoad == WarWithinLandingOverlayMixin.OnLoad then
	    	child:SetPoint("CENTER", -47, 32)
	 	end
	end
end)