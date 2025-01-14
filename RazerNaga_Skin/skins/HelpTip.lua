if not _G.HelpTip then return end

hooksecurefunc(HelpTip, "Show", function(self)
	for frame in self.framePool:EnumerateActive() do
		frame.CloseButton:SetSize(24, 24)
		frame.CloseButton:SetDisabledAtlas("RedButton-Exit-Disabled")
		frame.CloseButton:SetNormalAtlas("RedButton-Exit")
		frame.CloseButton:SetPushedAtlas("RedButton-exit-pressed")
		frame.CloseButton:SetHighlightAtlas("RedButton-Highlight", "ADD")
		frame.CloseButton:ClearAllPoints()
		frame.CloseButton:SetPoint("TOPRIGHT", 5, 5)
		frame.CloseButton.Texture:Hide()
	end
end)