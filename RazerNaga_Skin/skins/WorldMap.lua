if not _G.WorldMapFrame then return end

for _, f in next, WorldMapFrame.overlayFrames do
	if WorldMapActivityTrackerMixin and f.OnLoad == WorldMapActivityTrackerMixin.OnLoad then
		hooksecurefunc(f, "Show", function()
			f:Hide()
		end)
	end
end

local Dropdown, Tracking, Pin, MapLegend = unpack(WorldMapFrame.overlayFrames)
MapLegend:Hide()

hooksecurefunc(POIButtonMixin, "UpdateButtonStyle", function(poiButton)
	local style = poiButton:GetStyle()
	local questID = poiButton:GetQuestID()

	if poiButton.TimeLowFrame then
		poiButton.TimeLowFrame:SetSize(18, 18)
		poiButton.TimeLowFrame:SetPoint("CENTER", -8, -7)
	end

	if poiButton.Glow then
		poiButton.Glow:SetSize(45, 45)
		poiButton.Glow:SetTexture("Interface\\WorldMap\\UI-QuestPoi-IconGlow")
	end

	if poiButton.LinkGlow then
		poiButton.LinkGlow:SetSize(45, 45)
		poiButton.LinkGlow:SetTexture("Interface\\WorldMap\\UI-QuestPoi-IconGlow")
	end

	if style == POIButtonUtil.Style.QuestThreat then
		if poiButton:IsSelected() then
			poiButton.NormalTexture:SetAtlas("UI-QuestPoi-QuestNumber-SuperTracked")
			poiButton.PushedTexture:SetAtlas("UI-QuestPoi-QuestNumber-Pressed-SuperTracked")
		else
			poiButton.NormalTexture:SetAtlas("UI-QuestPoi-QuestNumber")
			poiButton.PushedTexture:SetAtlas("UI-QuestPoi-QuestNumber-Pressed")
		end
		poiButton.HighlightTexture:SetAtlas("UI-QuestPoi-InnerGlow")
	elseif style == POIButtonUtil.Style.WorldQuest then
		local info = C_QuestLog.GetQuestTagInfo(questID)
		if info then
			if (poiButton.Display.Icon:GetAtlas() == "Worldquest-icon") then
				poiButton.Display.Icon:SetAtlas("worldquest-questmarker-questbang")
				poiButton.Display.Icon:SetSize(6, 15)
			elseif (poiButton.Display.Icon:GetAtlas() == "worldquest-icon-petbattle") then
				poiButton.Display.Icon:SetSize(11, 9)
			elseif (poiButton.Display.Icon:GetAtlas() == "worldquest-icon-race") then
				poiButton.Display.Icon:SetSize(17, 14)
			end
		end
	elseif style == POIButtonUtil.Style.AreaPOI then
		if poiButton.Display.SubTypeIcon then
			poiButton.Display.SubTypeIcon:SetAlpha(0)
		end
	end
end)

hooksecurefunc(BaseMapPoiPinMixin, "OnAcquired", function(self)
	if self.Texture then
		-- taxis
		if (self.Texture:GetAtlas() == "TaxiNode_Alliance") then
			self.Texture:SetSize(18, 18)
			self.HighlightTexture:SetSize(18, 18)
		elseif (self.Texture:GetAtlas() == "TaxiNode_Horde") then
			self.Texture:SetSize(18, 18)
			self.HighlightTexture:SetSize(18, 18)
		elseif (self.Texture:GetAtlas() == "TaxiNode_Neutral") then
			self.Texture:SetSize(18, 18)
			self.HighlightTexture:SetSize(18, 18)
		elseif (self.Texture:GetAtlas() == "TaxiNode_Undiscovered") then
			self.Texture:SetSize(18, 18)
			self.HighlightTexture:SetSize(18, 18)
		end
	end
end)