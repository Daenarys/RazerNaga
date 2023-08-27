--hide the buff expand toggle
hooksecurefunc(BuffFrame.CollapseAndExpandButton, "UpdateOrientation", function(self)
	self:Hide()
end)