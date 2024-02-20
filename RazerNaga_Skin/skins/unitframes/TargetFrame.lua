if not _G.TargetFrame then return end

hooksecurefunc(TargetFrame, "CheckClassification", function(self)
	local classification = UnitClassification(self.unit)
	local bossPortraitFrameTexture = self.TargetFrameContainer.BossPortraitFrameTexture
	if (classification == "rare") then
		bossPortraitFrameTexture:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Rare-Silver", TextureKitConstants.UseAtlasSize)
		bossPortraitFrameTexture:SetPoint("TOPRIGHT", -11, -8)
		bossPortraitFrameTexture:Show()
	elseif (classification == "elite") then
		bossPortraitFrameTexture:SetAtlas("UI-HUD-UnitFrame-Target-PortraitOn-Boss-Gold-Winged", TextureKitConstants.UseAtlasSize)
		bossPortraitFrameTexture:SetPoint("TOPRIGHT", 8, -7)
	end
	self.TargetFrameContent.TargetFrameContentContextual.BossIcon:Hide()
end)

if TargetFrame.TargetFrameContent.TargetFrameContentContextual.LeaderIcon then
	TargetFrame.TargetFrameContent.TargetFrameContentContextual.LeaderIcon:ClearAllPoints()
	TargetFrame.TargetFrameContent.TargetFrameContentContextual.LeaderIcon:SetPoint("TOPRIGHT", -86, -10)
end

if TargetFrame.TargetFrameContent.TargetFrameContentContextual.GuideIcon then
	TargetFrame.TargetFrameContent.TargetFrameContentContextual.GuideIcon:ClearAllPoints()
	TargetFrame.TargetFrameContent.TargetFrameContentContextual.GuideIcon:SetPoint("TOPRIGHT", -86, -10)
end

if TargetFrame.totFrame then
    TargetFrame.totFrame:ClearAllPoints()
    TargetFrame.totFrame:SetPoint("TOPRIGHT", TargetFrame, "BOTTOMRIGHT", 12, 21)
end