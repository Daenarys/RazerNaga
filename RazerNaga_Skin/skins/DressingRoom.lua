if not _G.DressUpFrame then return end

DressUpFrame.ModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP")
end)