if not _G.WorldMapFrame then return end

for _, f in next, WorldMapFrame.overlayFrames do
	if WorldMapActivityTrackerMixin and f.OnLoad == WorldMapActivityTrackerMixin.OnLoad then
		hooksecurefunc(f, "Show", function()
			f:Hide()
		end)
	end
end

local Dropdown, Tracking, Pin = unpack(WorldMapFrame.overlayFrames)
Tracking.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")
if (Tracking.IconOverlay == nil) then
	Tracking.IconOverlay = Tracking:CreateTexture(nil, "OVERLAY")
	Tracking.IconOverlay:SetPoint("TOPLEFT", Tracking.Icon)
	Tracking.IconOverlay:SetPoint("BOTTOMRIGHT", Tracking.Icon)
	Tracking.IconOverlay:SetColorTexture(0, 0, 0, 0.5)
	Tracking.IconOverlay:Hide()
end
hooksecurefunc(Tracking, "RefreshFilterCounter", function(self)
	self.FilterCounter:Hide()
	self.FilterCounterBanner:Hide()
end)
hooksecurefunc(Tracking, "ValidateResetState", function(self)
	self.ResetButton:SetShown(false)
end)
Tracking:HookScript("OnMouseDown", function(self)
	self.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")
	self.Icon:SetPoint("TOPLEFT", 8, -8)
	self.IconOverlay:Show()
end)
Tracking:HookScript("OnMouseUp", function(self)
	self.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")
	self.Icon:SetPoint("TOPLEFT", 7, -6)
	self.IconOverlay:Hide()
end)
Pin:SetPoint("TOPRIGHT", WorldMapFrame.ScrollContainer, "TOPRIGHT", -36, -2)