if not _G.HelpFrame then return end

_G.HelpFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 24)
end)