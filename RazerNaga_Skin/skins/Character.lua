if not _G.CharacterFrame then return end

PaperDollFrame:HookScript("OnShow", function()
	CharacterModelScene.ControlFrame:Hide()
end)

CharacterModelScene.ControlFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOP")
end)