if not _G.TotemFrame then return end

hooksecurefunc(TotemFrame, "Update", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -5, -90)
end)