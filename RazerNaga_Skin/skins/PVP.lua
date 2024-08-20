if PVPMatchScoreboard then
	PVPMatchScoreboard:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint("CENTER")
	end)
end

if PVPMatchResults then
	PVPMatchResults:HookScript("OnShow", function(self)
		self:ClearAllPoints()
		self:SetPoint("CENTER")
	end)
end