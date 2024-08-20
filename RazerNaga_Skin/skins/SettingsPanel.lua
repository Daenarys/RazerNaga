if not _G.SettingsPanel then return end

SettingsPanel.CloseButton:Hide()

SettingsPanel:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 5)
end)