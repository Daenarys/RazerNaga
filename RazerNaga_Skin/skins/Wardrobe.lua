local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" or name == "Blizzard_Wardrobe" then
		WardrobeTransmogFrame.ModelScene.ControlFrame:HookScript("OnShow", function(self)
			self:ClearAllPoints()
			self:SetPoint("TOP")
		end)
	end
end)