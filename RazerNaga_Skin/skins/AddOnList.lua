if not _G.AddonList then return end

_G.AddonList:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 24)
end)