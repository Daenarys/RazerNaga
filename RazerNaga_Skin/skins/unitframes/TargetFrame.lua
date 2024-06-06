if not _G.TargetFrame then return end

hooksecurefunc(TargetFrame, "CheckClassification", function(self)
	local classification = UnitClassification(self.unit)
	local bossPortraitFrameTexture = self.TargetFrameContainer.BossPortraitFrameTexture
	if (classification == "rare") then
		bossPortraitFrameTexture:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Silver", TextureKitConstants.UseAtlasSize)
		bossPortraitFrameTexture:SetPoint("TOPRIGHT", -11, -8)
	elseif (classification == "elite") then
		bossPortraitFrameTexture:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged", TextureKitConstants.UseAtlasSize)
		bossPortraitFrameTexture:SetPoint("TOPRIGHT", 8, -7)
	end
	self.TargetFrameContent.TargetFrameContentContextual.BossIcon:Hide()
end)