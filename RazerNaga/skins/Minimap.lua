Minimap:HookScript("OnEvent", function(self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		MinimapCluster:SetSize(192, 192)
		MinimapCluster:ClearAllPoints()
		MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT")
		MinimapCluster:SetHitRectInsets(30, 10, 0, 30)
		Minimap:SetSize(140, 140)
		Minimap:ClearAllPoints()
		Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -17, -22)
		MinimapBackdrop:SetSize(192,192)
		MinimapBackdrop:ClearAllPoints()
		MinimapBackdrop:SetPoint("CENTER", Minimap, "CENTER", -9, -24)
		MinimapBackdrop:CreateTexture("MinimapBorder", "ARTWORK")
		MinimapBorder:ClearAllPoints()
		MinimapBorder:SetAllPoints(MinimapBackdrop)
		MinimapBorder:SetTexture("Interface\\Minimap\\UI-Minimap-Border")
		MinimapBorder:SetDrawLayer("ARTWORK", 7)
		MinimapBorder:SetTexCoord(0.25, 1, 0.125, 0.875)
		MinimapCompassTexture:ClearAllPoints()
		MinimapCompassTexture:SetPoint("CENTER", Minimap, "CENTER", -2, 0)
		MinimapCompassTexture:SetTexture("Interface\\Minimap\\CompassRing", "OVERLAY")
		MinimapCompassTexture:SetSize(256, 256)
		MinimapCompassTexture:SetDrawLayer("OVERLAY", 0)
		MinimapBackdrop:CreateTexture("MinimapNorthTag")
		MinimapNorthTag:ClearAllPoints()
		MinimapNorthTag:SetPoint("CENTER", Minimap, "CENTER", 0, 67)
		MinimapNorthTag:SetTexture("Interface\\Minimap\\CompassNorthTag", "OVERLAY")
		MinimapNorthTag:SetSize(16, 16)
		MinimapNorthTag:SetDrawLayer("OVERLAY", 0)

		hooksecurefunc(MinimapCluster, "SetRotateMinimap", function(self, rotateMinimap)
			if (rotateMinimap) then
				MinimapCompassTexture:Show()
				MinimapNorthTag:Hide()
			else
				MinimapCompassTexture:Hide()
				MinimapNorthTag:Show()
			end
		end)

		if (GetCVar("rotateMinimap") == "1") then
			MinimapCompassTexture:Show()
			MinimapNorthTag:Hide()
		else
			MinimapCompassTexture:Hide()
			MinimapNorthTag:Show()
		end

		local iZoom = Minimap:GetZoom()
		if (iZoom+1 < Minimap:GetZoomLevels()) then
			Minimap:SetZoom(iZoom+1)
			Minimap:SetZoom(iZoom)
		else
			Minimap:SetZoom(0)
			Minimap:SetZoom(iZoom)
		end

		hooksecurefunc(MinimapCluster, 'HighlightSystem', function(self)
		    self.Selection:Hide()
			EditModeMagnetismManager:UnregisterFrame(self)
		end)

		hooksecurefunc(MinimapCluster, "Layout", function(self)
			self:SetSize(192, 192)
		end)

		local ldbi = LibStub ~= nil and LibStub:GetLibrary("LibDBIcon-1.0", true)
		if (ldbi ~= nil) then
			for _, v in pairs(ldbi:GetButtonList()) do
				ldbi:Refresh(v)
			end
		end

		TimeManagerClockButton:SetParent(Minimap)
		TimeManagerClockButton:ClearAllPoints()
		TimeManagerClockButton:SetPoint("CENTER", 0, -75)
		TimeManagerClockButton:SetFrameStrata("LOW")
		TimeManagerClockButton:SetFrameLevel(5)
		TimeManagerClockButton:SetSize(60, 28)

		if (TimeManagerClockButtonBackground == nil) then
			TimeManagerClockButtonBackground = TimeManagerClockButton:CreateTexture("TimeManagerClockButtonBackground", "BORDER")
			TimeManagerClockButtonBackground:ClearAllPoints()
			TimeManagerClockButtonBackground:SetAllPoints(TimeManagerClockButton)
			TimeManagerClockButtonBackground:SetTexture("Interface\\TimeManager\\ClockBackground")
			TimeManagerClockButtonBackground:SetTexCoord(0.015625, 0.8125, 0.015625, 0.390625)
		end

		TimeManagerClockTicker:ClearAllPoints()
		TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton, "CENTER", 2, 1)

		if (ExpansionLandingPageMinimapButton:GetNormalTexture():GetAtlas() == "dragonflight-landingbutton-up") then
			ExpansionLandingPageMinimapButton:SetScale(0.84)
			ExpansionLandingPageMinimapButton:ClearAllPoints()
			ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", 42, -146)
			ExpansionLandingPageMinimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
		else
			ExpansionLandingPageMinimapButton:ClearAllPoints()
			ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", 32, -118)
		end

		hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIconForGarrison", function(self)
			self:ClearAllPoints()
			self:SetPoint("TOPLEFT", 32, -118)
		end)

		GameTimeFrame:SetParent(Minimap)
		GameTimeFrame:ClearAllPoints()
		GameTimeFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 20, -2)
		GameTimeFrame:SetSize(40, 40)
		GameTimeFrame:SetHitRectInsets(6, 0, 5, 10)
		GameTimeFrame:SetFrameStrata("LOW")
		GameTimeFrame:SetFrameLevel(5)

		hooksecurefunc("GameTimeFrame_SetDate", function()
			GameTimeFrame:SetText(C_DateAndTime.GetCurrentCalendarTime().monthDay)
			GameTimeFrame:SetNormalTexture("Interface\\Calendar\\UI-Calendar-Button")
			GameTimeFrame:GetNormalTexture():SetTexCoord(0, 0.390625, 0, 0.78125)
			GameTimeFrame:SetPushedTexture("Interface\\Calendar\\UI-Calendar-Button")
			GameTimeFrame:GetPushedTexture():SetTexCoord(0.5, 0.890625, 0, 0.78125)
			GameTimeFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
			GameTimeFrame:GetNormalTexture():SetDrawLayer("BACKGROUND")
			GameTimeFrame:GetPushedTexture():SetDrawLayer("BACKGROUND")
			GameTimeFrame:GetFontString():SetDrawLayer("BACKGROUND")
		end)

		GameTimeFrame:SetNormalTexture("Interface\\Calendar\\UI-Calendar-Button")
		GameTimeFrame:GetNormalTexture():SetTexCoord(0, 0.390625, 0, 0.78125)
		GameTimeFrame:SetPushedTexture("Interface\\Calendar\\UI-Calendar-Button")
		GameTimeFrame:GetPushedTexture():SetTexCoord(0.5, 0.890625, 0, 0.78125)
		GameTimeFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
		GameTimeFrame:SetNormalFontObject("GameFontBlack")
		GameTimeFrame:SetFontString(GameTimeFrame:CreateFontString(nil, "BACKGROUND", "GameFontBlack"))
		GameTimeFrame:GetFontString():ClearAllPoints()
		GameTimeFrame:GetFontString():SetPoint("CENTER", -2, -1)
		GameTimeFrame:GetNormalTexture():SetDrawLayer("BACKGROUND")
		GameTimeFrame:GetPushedTexture():SetDrawLayer("BACKGROUND")
		GameTimeFrame:GetFontString():SetDrawLayer("BACKGROUND")
		local currentCalendarTime = C_DateAndTime.GetCurrentCalendarTime();
		GameTimeFrame:SetText(currentCalendarTime.monthDay);

		MinimapCluster.Tracking:SetParent(MinimapBackdrop)
		MinimapCluster.Tracking:ClearAllPoints()
		MinimapCluster.Tracking:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 9, -45)
		MinimapCluster.Tracking:SetSize(32, 32)
		MinimapCluster.Tracking.Background:SetParent(MinimapCluster.Tracking)
		MinimapCluster.Tracking.Background:ClearAllPoints()
		MinimapCluster.Tracking.Background:SetPoint("TOPLEFT", MinimapCluster.Tracking, "TOPLEFT", 2, -4)
		MinimapCluster.Tracking.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")
		MinimapCluster.Tracking.Background:SetSize(25, 25)
		MinimapCluster.Tracking.Background:SetAlpha(0.6)
		MinimapCluster.Tracking.Button:SetParent(MinimapCluster.Tracking)
		MinimapCluster.Tracking.Button:ClearAllPoints()
		MinimapCluster.Tracking.Button:SetPoint("TOPLEFT", MinimapCluster.Tracking, "TOPLEFT", 0, 0)
		MinimapCluster.Tracking.Button:SetFrameStrata("LOW")
		MinimapCluster.Tracking.Button:SetFrameLevel(5)
		MinimapCluster.Tracking.Button:SetSize(32, 32)
		MinimapCluster.Tracking.Button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")

		MinimapCluster.Tracking.Button:GetNormalTexture():SetTexture(nil)
		MinimapCluster.Tracking.Button:GetNormalTexture():SetAlpha(0)
		MinimapCluster.Tracking.Button:GetNormalTexture():Hide()
		MinimapCluster.Tracking.Button:GetPushedTexture():SetTexture(nil)
		MinimapCluster.Tracking.Button:GetNormalTexture():SetAlpha(0)
		MinimapCluster.Tracking.Button:GetNormalTexture():Hide()
		MinimapCluster.Tracking.Button:CreateTexture("MiniMapTrackingButtonBorder", "BORDER")
		MinimapCluster.Tracking.ButtonBorder = MiniMapTrackingButtonBorder
		MinimapCluster.Tracking.ButtonBorder:ClearAllPoints()
		MinimapCluster.Tracking.ButtonBorder:SetPoint("TOPLEFT", MinimapCluster.Tracking.Button, "TOPLEFT", 0, 0)
		MinimapCluster.Tracking.ButtonBorder:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")
		MinimapCluster.Tracking.ButtonBorder:SetSize(54, 54)
		MinimapCluster.Tracking.ButtonBorder:SetDrawLayer("BORDER", 0)
		MinimapCluster.Tracking:CreateTexture("MiniMapTrackingIcon", "ARTWORK")
		MinimapCluster.Tracking.MiniMapTrackingIcon = MiniMapTrackingIcon
		MinimapCluster.Tracking.MiniMapTrackingIcon:ClearAllPoints()
		MinimapCluster.Tracking.MiniMapTrackingIcon:SetPoint("TOPLEFT", MinimapCluster.Tracking, "TOPLEFT", 6, -6)
		MinimapCluster.Tracking.MiniMapTrackingIcon:SetTexture("Interface\\Minimap\\Tracking\\None")
		MinimapCluster.Tracking.MiniMapTrackingIcon:SetSize(20, 20)
		MinimapCluster.Tracking.MiniMapTrackingIcon:Show()
		MinimapCluster.Tracking:CreateTexture("MiniMapTrackingIconOverlay", "OVERLAY")
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay = MiniMapTrackingIconOverlay
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay:ClearAllPoints()
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay:SetAllPoints(MinimapCluster.Tracking.MiniMapTrackingIcon)
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay:SetSize(20, 20)
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay:SetColorTexture(0, 0, 0, 0.5)
		MinimapCluster.Tracking.MiniMapTrackingIconOverlay:Hide()

		MinimapCluster.Tracking.Button:HookScript("OnMouseDown", function()
			MinimapCluster.Tracking.MiniMapTrackingIcon:SetPoint("TOPLEFT", MinimapCluster.Tracking, "TOPLEFT", 8, -8)
			MinimapCluster.Tracking.MiniMapTrackingIconOverlay:Show()
		end)
		MinimapCluster.Tracking.Button:HookScript("OnMouseUp", function()
			MinimapCluster.Tracking.MiniMapTrackingIcon:SetPoint("TOPLEFT", MinimapCluster.Tracking, "TOPLEFT", 6, -6)
			MinimapCluster.Tracking.MiniMapTrackingIconOverlay:Hide()
		end)

		Minimap.ZoomIn:SetParent(MinimapBackdrop)
		Minimap.ZoomIn:ClearAllPoints()
		Minimap.ZoomIn:SetPoint("CENTER", MinimapBackdrop, "CENTER", 72, -25)
		Minimap.ZoomIn:SetFrameStrata("MEDIUM")
		Minimap.ZoomIn:SetFrameLevel(4)
		Minimap.ZoomIn:SetSize(32, 32)
		Minimap.ZoomIn:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Up")
		Minimap.ZoomIn:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Down")
		Minimap.ZoomIn:SetDisabledTexture("Interface\\Minimap\\UI-Minimap-ZoomInButton-Disabled")
		Minimap.ZoomIn:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
		Minimap.ZoomIn:SetHitRectInsets(4, 4, 2, 6)
		Minimap.ZoomOut:SetParent(MinimapBackdrop)
		Minimap.ZoomOut:ClearAllPoints()
		Minimap.ZoomOut:SetPoint("CENTER", MinimapBackdrop, "CENTER", 50, -43)
		Minimap.ZoomOut:SetFrameStrata("MEDIUM")
		Minimap.ZoomOut:SetFrameLevel(4)
		Minimap.ZoomOut:SetSize(32, 32)
		Minimap.ZoomOut:SetNormalTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Up")
		Minimap.ZoomOut:SetPushedTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Down")
		Minimap.ZoomOut:SetDisabledTexture("Interface\\Minimap\\UI-Minimap-ZoomOutButton-Disabled")
		Minimap.ZoomOut:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
		Minimap.ZoomOut:SetHitRectInsets(4, 4, 2, 6)

		Minimap:HookScript("OnLeave", function(self)
			self.ZoomIn:Show()
			self.ZoomOut:Show()
		end)

		Minimap.ZoomIn:Show()
		Minimap.ZoomOut:Show()

		MinimapCluster.IndicatorFrame.MailFrame:ClearAllPoints()
		MinimapCluster.IndicatorFrame.MailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 24, -37)
		MinimapCluster.IndicatorFrame.MailFrame:SetSize(33, 33)
		MinimapCluster.IndicatorFrame.MailFrame:SetFrameStrata("LOW")

		MinimapCluster.IndicatorFrame.CraftingOrderFrame:ClearAllPoints()
		MinimapCluster.IndicatorFrame.CraftingOrderFrame:SetPoint("TOPLEFT", MinimapCluster.IndicatorFrame, "TOPLEFT", 0, 0)
		MinimapCluster.IndicatorFrame.CraftingOrderFrame:SetSize(33, 33)
		MinimapCluster.IndicatorFrame.CraftingOrderFrame:SetFrameStrata("LOW")

		MinimapCluster.IndicatorFrame.MailFrame:SetFrameLevel(6)
		MinimapCluster.IndicatorFrame.CraftingOrderFrame:SetFrameLevel(5)

		MinimapCluster.IndicatorFrame:SetParent(MinimapCluster)
		MinimapCluster.IndicatorFrame:ClearAllPoints()
		MinimapCluster.IndicatorFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 24, -37)
		MinimapCluster.IndicatorFrame:SetSize(33, 33)
		MinimapCluster.IndicatorFrame:SetFrameStrata("LOW")
		MinimapCluster.IndicatorFrame:SetFrameLevel(4)

		hooksecurefunc(MinimapCluster.IndicatorFrame, "Layout", function(self)
			self:SetSize(33, 33)
			self.MailFrame:ClearAllPoints()
			self.MailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 24, -37)
			self.CraftingOrderFrame:ClearAllPoints()
			self.CraftingOrderFrame:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
		end)

		hooksecurefunc("MiniMapIndicatorFrame_UpdatePosition", function()
			MinimapCluster.IndicatorFrame:ClearAllPoints()
			MinimapCluster.IndicatorFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 24, -37)
		end)

		MiniMapMailIcon:ClearAllPoints()
		MiniMapMailIcon:SetPoint("TOPLEFT", MinimapCluster.IndicatorFrame.MailFrame, "TOPLEFT", 7, -6)
		MiniMapMailIcon:SetTexture("Interface\\Icons\\INV_Letter_15")
		MiniMapMailIcon:SetSize(18, 18)
		MiniMapMailIcon:SetDrawLayer("ARTWORK", 0)

		MiniMapCraftingOrderIcon:ClearAllPoints()
		MiniMapCraftingOrderIcon:SetPoint("TOPLEFT", MinimapCluster.IndicatorFrame.CraftingOrderFrame, "TOPLEFT", 7, -6)
		MiniMapCraftingOrderIcon:SetTexture("Interface\\Icons\\INV_Hammer_12")
		MiniMapCraftingOrderIcon:SetSize(18, 18)
		MiniMapCraftingOrderIcon:SetDrawLayer("ARTWORK", 0)

		MinimapCluster.IndicatorFrame.MailFrame:CreateTexture("MiniMapMailBorder", "OVERLAY")
		MiniMapMailBorder:ClearAllPoints()
		MiniMapMailBorder:SetPoint("TOPLEFT", MinimapCluster.IndicatorFrame.MailFrame, "TOPLEFT", 0, 0)
		MiniMapMailBorder:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")
		MiniMapMailBorder:SetSize(52, 52)
		MiniMapMailBorder:SetDrawLayer("OVERLAY", 0)

		MinimapCluster.IndicatorFrame.CraftingOrderFrame:CreateTexture("MiniMapMailBorder2", "OVERLAY")
		MiniMapMailBorder2:ClearAllPoints()
		MiniMapMailBorder2:SetPoint("TOPLEFT", MinimapCluster.IndicatorFrame.CraftingOrderFrame, "TOPLEFT", 0, 0)
		MiniMapMailBorder2:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")
		MiniMapMailBorder2:SetSize(52, 52)
		MiniMapMailBorder2:SetDrawLayer("OVERLAY", 0)

		MinimapCluster.InstanceDifficulty:Hide()

		if (MiniMap_MiniMapInstanceDifficulty) == nil then
			local MiniMap_MiniMapInstanceDifficulty = CreateFrame("Frame", "MiniMap_MiniMapInstanceDifficulty", MinimapCluster)
			MiniMap_MiniMapInstanceDifficulty:SetFrameStrata("LOW")
			MiniMap_MiniMapInstanceDifficulty:SetFrameLevel(11)
			MiniMap_MiniMapInstanceDifficulty:SetSize(38, 46)
			MiniMap_MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -13, 5)
			MiniMap_MiniMapInstanceDifficulty:Hide()
			local MiniMap_MiniMapInstanceDifficultyTexture = MiniMap_MiniMapInstanceDifficulty:CreateTexture("MiniMap_MiniMapInstanceDifficultyTexture", "ARTWORK")
			MiniMap_MiniMapInstanceDifficultyTexture:SetSize(64, 46)
			MiniMap_MiniMapInstanceDifficultyTexture:SetTexture("Interface\\Minimap\\UI-DungeonDifficulty-Button")
			MiniMap_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4140625)
			MiniMap_MiniMapInstanceDifficultyTexture:SetPoint("CENTER", MiniMap_MiniMapInstanceDifficulty, "CENTER", 0, 0)
			local MiniMap_MiniMapInstanceDifficultyText = MiniMap_MiniMapInstanceDifficulty:CreateFontString("MiniMap_MiniMapInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
			MiniMap_MiniMapInstanceDifficultyText:SetJustifyH("CENTER")
			MiniMap_MiniMapInstanceDifficultyText:SetJustifyV("MIDDLE")
			MiniMap_MiniMapInstanceDifficultyText:SetPoint("CENTER", MiniMap_MiniMapInstanceDifficulty, "CENTER", -1, -7)
			
			local MiniMap_GuildInstanceDifficulty = CreateFrame("Frame", "MiniMap_GuildInstanceDifficulty", MinimapCluster)
			MiniMap_GuildInstanceDifficulty:SetFrameStrata("LOW")
			MiniMap_GuildInstanceDifficulty:SetFrameLevel(11)
			MiniMap_GuildInstanceDifficulty:SetSize(38, 46)
			MiniMap_GuildInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -13, 5)
			MiniMap_GuildInstanceDifficulty:Hide()
			local MiniMap_GuildInstanceDifficultyBackground = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyBackground", "BACKGROUND")
			MiniMap_GuildInstanceDifficulty.background = MiniMap_GuildInstanceDifficultyBackground
			MiniMap_GuildInstanceDifficultyBackground:SetSize(41, 53)
			MiniMap_GuildInstanceDifficultyBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyBackground:SetTexCoord(0.0078125, 0.328125, 0.015625, 0.84375)
			MiniMap_GuildInstanceDifficultyBackground:SetPoint("TOPLEFT", MiniMap_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
			local MiniMap_GuildInstanceDifficultyDarkBackground = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyDarkBackground", "BORDER")
			MiniMap_GuildInstanceDifficultyDarkBackground:SetSize(30, 21)
			MiniMap_GuildInstanceDifficultyDarkBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyDarkBackground:SetTexCoord(0.6796875, 0.9140625, 0.015625, 0.34375)
			MiniMap_GuildInstanceDifficultyDarkBackground:SetPoint("BOTTOM", MiniMap_GuildInstanceDifficultyBackground, "BOTTOM", 0, 7)
			MiniMap_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
			local MiniMap_GuildInstanceDifficultyEmblem = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyEmblem", "ARTWORK")
			MiniMap_GuildInstanceDifficulty.emblem = MiniMap_GuildInstanceDifficultyEmblem
			MiniMap_GuildInstanceDifficultyEmblem:SetSize(16, 16)
			MiniMap_GuildInstanceDifficultyEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
			MiniMap_GuildInstanceDifficultyEmblem:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
			MiniMap_GuildInstanceDifficultyEmblem:SetPoint("TOPLEFT", MiniMap_GuildInstanceDifficulty, "TOPLEFT", 12, -10)
			local MiniMap_GuildInstanceDifficultyBorder = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyBorder", "ARTWORK")
			MiniMap_GuildInstanceDifficulty.border = MiniMap_GuildInstanceDifficultyBorder
			MiniMap_GuildInstanceDifficultyBorder:SetSize(41, 53)
			MiniMap_GuildInstanceDifficultyBorder:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyBorder:SetTexCoord(0.34375, 0.6640625, 0.015625, 0.84375)
			MiniMap_GuildInstanceDifficultyBorder:SetPoint("BOTTOMLEFT", MiniMap_GuildInstanceDifficulty, "BOTTOMLEFT", 0, 0)
			local MiniMap_GuildInstanceDifficultyHeroicTexture = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyHeroicTexture", "ARTWORK")
			MiniMap_GuildInstanceDifficultyHeroicTexture:SetSize(12, 13)
			MiniMap_GuildInstanceDifficultyHeroicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyHeroicTexture:SetTexCoord(0.6796875, 0.7734375, 0.65625, 0.859375)
			MiniMap_GuildInstanceDifficultyHeroicTexture:SetPoint("BOTTOMLEFT", MiniMap_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
			local MiniMap_GuildInstanceDifficultyMythicTexture = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyMythicTexture", "ARTWORK")
			MiniMap_GuildInstanceDifficultyMythicTexture:SetSize(12, 13)
			MiniMap_GuildInstanceDifficultyMythicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyMythicTexture:SetTexCoord(0.7734375, 0.8671875, 0.65625, 0.859375)
			MiniMap_GuildInstanceDifficultyMythicTexture:SetPoint("BOTTOMLEFT", MiniMap_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
			local MiniMap_GuildInstanceDifficultyChallengeModeTexture = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyChallengeModeTexture", "ARTWORK")
			MiniMap_GuildInstanceDifficultyChallengeModeTexture:SetSize(12, 12)
			MiniMap_GuildInstanceDifficultyChallengeModeTexture:SetTexture("Interface\\Common\\mini-hourglass")
			MiniMap_GuildInstanceDifficultyChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
			MiniMap_GuildInstanceDifficultyChallengeModeTexture:SetPoint("BOTTOMLEFT", MiniMap_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
			local MiniMap_GuildInstanceDifficultyText = MiniMap_GuildInstanceDifficulty:CreateFontString("MiniMap_GuildInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
			MiniMap_GuildInstanceDifficultyText:SetJustifyH("CENTER")
			MiniMap_GuildInstanceDifficultyText:SetJustifyV("MIDDLE")
			MiniMap_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", MiniMap_GuildInstanceDifficulty, "BOTTOMLEFT", 20, 8)
			MiniMap_GuildInstanceDifficultyText:SetText("25")
			local MiniMap_GuildInstanceDifficultyHanger = MiniMap_GuildInstanceDifficulty:CreateTexture("MiniMap_GuildInstanceDifficultyHanger", "OVERLAY")
			MiniMap_GuildInstanceDifficultyHanger:SetSize(39, 16)
			MiniMap_GuildInstanceDifficultyHanger:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
			MiniMap_GuildInstanceDifficultyHanger:SetTexCoord(0.6796875, 0.984375, 0.375, 0.625)
			MiniMap_GuildInstanceDifficultyHanger:SetPoint("TOPLEFT", MiniMap_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
			
			local MiniMap_MiniMapChallengeMode = CreateFrame("Frame", "MiniMap_MiniMapChallengeMode", MinimapCluster)
			MiniMap_MiniMapChallengeMode:SetFrameStrata("LOW")
			MiniMap_MiniMapChallengeMode:SetFrameLevel(11)
			MiniMap_MiniMapChallengeMode:SetSize(27, 36)
			MiniMap_MiniMapChallengeMode:SetPoint("TOPLEFT", Minimap, "TOPLEFT", -19, 11)
			MiniMap_MiniMapChallengeMode:Hide()
			local MiniMap_MiniMapChallengeModeTexture = MiniMap_MiniMapChallengeMode:CreateTexture("MiniMap_MiniMapChallengeModeTexture", "BACKGROUND")
			MiniMap_MiniMapChallengeModeTexture:SetSize(64, 64)
			MiniMap_MiniMapChallengeModeTexture:SetTexture("Interface\\Challenges\\challenges-minimap-banner")
			MiniMap_MiniMapChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
			MiniMap_MiniMapChallengeModeTexture:SetPoint("CENTER", MiniMap_MiniMapChallengeMode, "CENTER", 0, 0)
			
			MiniMap_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
			MiniMap_MiniMapInstanceDifficulty:RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED")
			MiniMap_MiniMapInstanceDifficulty:RegisterEvent("UPDATE_INSTANCE_INFO")
			MiniMap_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_GUILD_UPDATE")
			MiniMap_MiniMapInstanceDifficulty:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
			
			function MiniMap_MiniMapInstanceDifficulty:MiniMapInstanceDifficulty_Update()
				local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize = GetInstanceInfo()
				local _, _, isHeroic, isChallengeMode, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
				if ( self.isGuildGroup ) then
					if ( instanceGroupSize == 0 ) then
						MiniMap_GuildInstanceDifficultyText:SetText("")
						MiniMap_GuildInstanceDifficultyDarkBackground:SetAlpha(0)
						MiniMap_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -16)
					else
						MiniMap_GuildInstanceDifficultyText:SetText(instanceGroupSize)
						MiniMap_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
						MiniMap_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -10)
					end
					MiniMap_GuildInstanceDifficultyText:ClearAllPoints()
					if ( isHeroic or isChallengeMode or displayMythic or displayHeroic ) then
						local symbolTexture
						if ( isChallengeMode ) then
							symbolTexture = MiniMap_GuildInstanceDifficultyChallengeModeTexture
							MiniMap_GuildInstanceDifficultyHeroicTexture:Hide()
							MiniMap_GuildInstanceDifficultyMythicTexture:Hide()
						elseif ( displayMythic ) then
							symbolTexture = MiniMap_GuildInstanceDifficultyMythicTexture
							MiniMap_GuildInstanceDifficultyHeroicTexture:Hide()
							MiniMap_GuildInstanceDifficultyChallengeModeTexture:Hide()
						else
							symbolTexture = MiniMap_GuildInstanceDifficultyHeroicTexture
							MiniMap_GuildInstanceDifficultyChallengeModeTexture:Hide()
							MiniMap_GuildInstanceDifficultyMythicTexture:Hide()
						end
						if ( instanceGroupSize < 10 ) then
							symbolTexture:SetPoint("BOTTOMLEFT", 11, 7)
							MiniMap_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 23, 8)
						elseif ( instanceGroupSize > 19 ) then
							symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
							MiniMap_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 20, 8)
						else
							symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
							MiniMap_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 19, 8)
						end
						symbolTexture:Show()
					else
						MiniMap_GuildInstanceDifficultyHeroicTexture:Hide()
						MiniMap_GuildInstanceDifficultyChallengeModeTexture:Hide()
						MiniMap_GuildInstanceDifficultyMythicTexture:Hide()
						MiniMap_GuildInstanceDifficultyText:SetPoint("BOTTOM", 2, 8)
					end
					self:Hide()
					SetSmallGuildTabardTextures("player", MiniMap_GuildInstanceDifficulty.emblem, MiniMap_GuildInstanceDifficulty.background, MiniMap_GuildInstanceDifficulty.border)
					MiniMap_GuildInstanceDifficulty:Show()
					MiniMap_MiniMapChallengeMode:Hide()
				elseif ( isChallengeMode ) then
					MiniMap_MiniMapChallengeMode:Show()
					self:Hide()
					MiniMap_GuildInstanceDifficulty:Hide()
				elseif ( instanceType == "raid" or isHeroic or displayMythic or displayHeroic ) then
					MiniMap_MiniMapInstanceDifficultyText:SetText(instanceGroupSize)
					local xOffset = 0
					if ( instanceGroupSize >= 10 and instanceGroupSize <= 19 ) then
						xOffset = -1
					end
					if ( displayMythic ) then
						MiniMap_MiniMapInstanceDifficultyTexture:SetTexCoord(0.25, 0.5, 0.0703125, 0.4296875)
						MiniMap_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -8)
					elseif ( isHeroic or displayHeroic ) then
						MiniMap_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4296875)
						MiniMap_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -8)
					else
						MiniMap_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.5703125, 0.9296875)
						MiniMap_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, 6)
					end
					self:Show()
					MiniMap_GuildInstanceDifficulty:Hide()
					MiniMap_MiniMapChallengeMode:Hide()
				else
					self:Hide()
					MiniMap_GuildInstanceDifficulty:Hide()
					MiniMap_MiniMapChallengeMode:Hide()
				end
			end
			MiniMap_MiniMapInstanceDifficulty:SetScript("OnEvent", function(self, event, ...)
				if ( event == "GUILD_PARTY_STATE_UPDATED" ) then
					local isGuildGroup = ...
					if ( isGuildGroup ~= self.isGuildGroup ) then
						self.isGuildGroup = isGuildGroup
						self:MiniMapInstanceDifficulty_Update()
					end
				elseif ( event == "PLAYER_DIFFICULTY_CHANGED") then
					self:MiniMapInstanceDifficulty_Update()
				elseif ( event == "UPDATE_INSTANCE_INFO" or event == "INSTANCE_GROUP_SIZE_CHANGED" ) then
					self:MiniMapInstanceDifficulty_Update()
				elseif ( event == "PLAYER_GUILD_UPDATE" ) then
					local tabard = MiniMap_GuildInstanceDifficulty
					SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background, tabard.border)
					if not( IsInGuild() ) then
						self.isGuildGroup = nil
						self:MiniMapInstanceDifficulty_Update()
					end
				end
			end)
			MiniMap_MiniMapInstanceDifficulty:SetScript("OnEnter", function(self)
				local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize, lfgID = GetInstanceInfo()
				local isLFR = select(8, GetDifficultyInfo(difficulty))
				if (isLFR and lfgID) then
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 8, 8)
					local name = GetLFGDungeonInfo(lfgID)
					GameTooltip:SetText(RAID_FINDER, 1, 1, 1)
					GameTooltip:AddLine(name)
					GameTooltip:Show()
				end
			end)
			MiniMap_MiniMapInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
			
			MiniMap_GuildInstanceDifficulty:SetScript("OnEnter", function(self)
				local guildName = GetGuildInfo("player")
				local _, instanceType, _, _, maxPlayers = GetInstanceInfo()
				local _, numGuildPresent, numGuildRequired, xpMultiplier = InGuildParty()
				if ( instanceType == "arena" ) then
					maxPlayers = numGuildRequired
				end
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT", 8, 8)
				GameTooltip:SetText(GUILD_GROUP, 1, 1, 1)
				if ( xpMultiplier < 1 ) then
					GameTooltip:AddLine(strformat(GUILD_ACHIEVEMENTS_ELIGIBLE_MINXP, numGuildRequired, maxPlayers, guildName, xpMultiplier * 100), nil, nil, nil, true)
				elseif ( xpMultiplier > 1 ) then
					GameTooltip:AddLine(strformat(GUILD_ACHIEVEMENTS_ELIGIBLE_MAXXP, guildName, xpMultiplier * 100), nil, nil, nil, true)
				else
					if ( instanceType == "party" and maxPlayers == 5 ) then
						numGuildRequired = 4
					end
					GameTooltip:AddLine(strformat(GUILD_ACHIEVEMENTS_ELIGIBLE, numGuildRequired, maxPlayers, guildName), nil, nil, nil, true)
				end
				GameTooltip:Show()
			end)
			MiniMap_GuildInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
		end

		CreateFrame("Button", "MinimapZoneTextButton", MinimapCluster)
		MinimapZoneTextButton:SetSize(140, 12)
		MinimapZoneTextButton:ClearAllPoints()
		MinimapZoneTextButton:SetPoint("CENTER", 0, 83)
		MinimapZoneTextButton:SetFrameStrata("LOW")
		MinimapZoneTextButton:SetFrameLevel(3)
		MinimapZoneText:SetParent(MinimapZoneTextButton)
		MinimapZoneText:SetSize(140, 12)
		MinimapZoneText:ClearAllPoints()
		MinimapZoneText:SetPoint("CENTER", MinimapZoneTextButton, "TOP", 0, -6)
		MinimapZoneText:SetDrawLayer("BACKGROUND")
		MinimapZoneText:SetJustifyH("CENTER")
		MinimapBackdrop:CreateTexture("MinimapBorderTop", "ARTWORK")
		MinimapBorderTop:SetSize(192, 32)
		MinimapBorderTop:ClearAllPoints()
		MinimapBorderTop:SetPoint("TOPRIGHT", MinimapCluster, "TOPRIGHT")
		MinimapBorderTop:SetTexture("Interface\\Minimap\\UI-Minimap-Border")
		MinimapBorderTop:SetTexCoord(0.25, 1, 0, 0.125)
		MinimapCluster.BorderTop.BottomEdge:Hide()
		MinimapCluster.BorderTop.Center:Hide()
		MinimapCluster.BorderTop.TopEdge:Hide()
		MinimapCluster.BorderTop.LeftEdge:Hide()
		MinimapCluster.BorderTop.RightEdge:Hide()
		MinimapCluster.BorderTop.BottomLeftCorner:Hide()
		MinimapCluster.BorderTop.TopLeftCorner:Hide()
		MinimapCluster.BorderTop.BottomRightCorner:Hide()
		MinimapCluster.BorderTop.TopRightCorner:Hide()

		MiniMapWorldMapButton = MinimapCluster.ZoneTextButton
		MiniMapWorldMapButton:SetSize(32, 32)
		MiniMapWorldMapButton:ClearAllPoints()
		MiniMapWorldMapButton:SetPoint("TOPRIGHT", MinimapBackdrop, "TOPRIGHT", -2, 23)
		MiniMapWorldMapButton:SetFrameStrata("LOW")
		MiniMapWorldMapButton:SetFrameLevel(4)
		MiniMapWorldMapButton:SetNormalTexture("Interface\\Minimap\\UI-Minimap-WorldMapSquare")
		MiniMapWorldMapButton:GetNormalTexture():SetSize(32, 32)
		MiniMapWorldMapButton:GetNormalTexture():SetTexCoord(0.0, 1, 0, 0.5)
		MiniMapWorldMapButton:SetPushedTexture("Interface\\Minimap\\UI-Minimap-WorldMapSquare")
		MiniMapWorldMapButton:GetPushedTexture():SetSize(32, 32)
		MiniMapWorldMapButton:GetPushedTexture():SetTexCoord(0.0, 1, 0.5, 1)
		MiniMapWorldMapButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		MiniMapWorldMapButton:GetHighlightTexture():SetSize(28, 28)
		MiniMapWorldMapButton:GetHighlightTexture():ClearAllPoints()
		MiniMapWorldMapButton:GetHighlightTexture():SetPoint("TOPRIGHT", MiniMapWorldMapButton, "TOPRIGHT", 2, -2)

		MinimapZoneTextButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_LEFT")
			local pvpType, isSubZonePvP, factionName = GetZonePVPInfo()
			local zoneName = GetZoneText();
			local subzoneName = GetSubZoneText();
			if ( subzoneName == zoneName ) then
				subzoneName = "";
			end
			GameTooltip:AddLine( zoneName, 1.0, 1.0, 1.0 );
			if ( pvpType == "sanctuary" ) then
				GameTooltip:AddLine( subzoneName, 0.41, 0.8, 0.94 );
				GameTooltip:AddLine(SANCTUARY_TERRITORY, 0.41, 0.8, 0.94);
			elseif ( pvpType == "arena" ) then
				GameTooltip:AddLine( subzoneName, 1.0, 0.1, 0.1 );
				GameTooltip:AddLine(FREE_FOR_ALL_TERRITORY, 1.0, 0.1, 0.1);
			elseif ( pvpType == "friendly" ) then
				if (factionName and factionName ~= "") then
					GameTooltip:AddLine( subzoneName, 0.1, 1.0, 0.1 );
					GameTooltip:AddLine(format(FACTION_CONTROLLED_TERRITORY, factionName), 0.1, 1.0, 0.1);
				end
			elseif ( pvpType == "hostile" ) then
				if (factionName and factionName ~= "") then
					GameTooltip:AddLine( subzoneName, 1.0, 0.1, 0.1 );
					GameTooltip:AddLine(format(FACTION_CONTROLLED_TERRITORY, factionName), 1.0, 0.1, 0.1);
				end
			elseif ( pvpType == "contested" ) then
				GameTooltip:AddLine( subzoneName, 1.0, 0.7, 0.0 );
				GameTooltip:AddLine(CONTESTED_TERRITORY, 1.0, 0.7, 0.0);
			elseif ( pvpType == "combat" ) then
				GameTooltip:AddLine( subzoneName, 1.0, 0.1, 0.1 );
				GameTooltip:AddLine(COMBAT_ZONE, 1.0, 0.1, 0.1);
			else
				GameTooltip:AddLine( subzoneName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b );
			end
			GameTooltip:Show();
		end)

		MinimapZoneTextButton:SetScript("OnLeave", function()
			GameTooltip_Hide()
		end)

		MiniMapWorldMapButton.tooltipText = MicroButtonTooltipText(WORLDMAP_BUTTON, "TOGGLEWORLDMAP")
		MiniMapWorldMapButton.newbieText = NEWBIE_TOOLTIP_WORLDMAP
		MiniMapWorldMapButton:RegisterEvent("UPDATE_BINDINGS")

		MiniMapWorldMapButton:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip_SetTitle(GameTooltip, self.tooltipText)
			GameTooltip:Show()
		end)

		MiniMapWorldMapButton:SetScript("OnLeave", GameTooltip_Hide)

		MiniMapWorldMapButton:SetScript("OnEvent", function(self)
			self.tooltipText = MicroButtonTooltipText(WORLDMAP_BUTTON, "TOGGLEWORLDMAP")
			self.newbieText = NEWBIE_TOOLTIP_WORLDMAP
		end)
	end
end)

--queuestatusbutton
local function MinimapButton_OnMouseDown(self, button)
	if ( self.isDown ) then
		return;
	end
	local button = _G[self:GetName().."Icon"];
	local point, relativeTo, relativePoint, offsetX, offsetY = button:GetPoint();
	button:SetPoint(point, relativeTo, relativePoint, offsetX+1, offsetY-1);
	self.isDown = 1;
end

local function MinimapButton_OnMouseUp(self)
	if ( not self.isDown ) then
		return;
	end
	local button = _G[self:GetName().."Icon"];
	local point, relativeTo, relativePoint, offsetX, offsetY = button:GetPoint();
	button:SetPoint(point, relativeTo, relativePoint, offsetX-1, offsetY+1);
	self.isDown = nil;
end

local LFG_EYE_TEXTURES = { };
LFG_EYE_TEXTURES["default"] = { file = "Interface\\LFGFrame\\LFG-Eye", width = 512, height = 256, frames = 29, iconSize = 64, delay = 0.1 };
LFG_EYE_TEXTURES["raid"] = { file = "Interface\\LFGFrame\\LFR-Anim", width = 256, height = 256, frames = 16, iconSize = 64, delay = 0.05 };
LFG_EYE_TEXTURES["unknown"] = { file = "Interface\\LFGFrame\\WaitAnim", width = 128, height = 128, frames = 4, iconSize = 64, delay = 0.25 };

QueueStatusButton:SetParent(MinimapBackdrop)
QueueStatusButton:SetFrameLevel(6)
QueueStatusButton:SetSize(33, 33)
QueueStatusButton:ClearAllPoints()
QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 22, -101)

QueueStatusButton:CreateTexture("QueueStatusButtonBorder")
QueueStatusButton.ButtonBorder = QueueStatusButtonBorder
QueueStatusButton.ButtonBorder:ClearAllPoints()
QueueStatusButton.ButtonBorder:SetPoint("TOPLEFT", QueueStatusButton, "TOPLEFT", 1, 0)
QueueStatusButton.ButtonBorder:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")
QueueStatusButton.ButtonBorder:SetSize(52, 52)

hooksecurefunc("QueueStatusDropDown_Show", function()
	DropDownList1:ClearAllPoints()
	DropDownList1:SetPoint("BOTTOMLEFT", QueueStatusButton, "BOTTOMLEFT", 0, -61)
end)

hooksecurefunc(QueueStatusButton, "UpdatePosition", function(self)
	self:SetParent(MinimapBackdrop)
	self:SetFrameLevel(6)
	self:SetSize(33, 33)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 22, -101)
end)

local function EyeTemplate_OnUpdate(self, elapsed)
	local textureInfo = LFG_EYE_TEXTURES[self.queueType or "default"];
	AnimateTexCoords(self.texture, textureInfo.width, textureInfo.height, textureInfo.iconSize, textureInfo.iconSize, textureInfo.frames, elapsed, textureInfo.delay)
end

local function EyeTemplate_StartAnimating()
	QueueStatusButton.Eye:SetScript("OnUpdate", EyeTemplate_OnUpdate);
end

local function EyeTemplate_StopAnimating()
	QueueStatusButton.Eye:SetScript("OnUpdate", nil);
	if ( QueueStatusButton.Eye.texture.frame ) then
		QueueStatusButton.Eye.texture.frame = 1;	--To start the animation over.
	end
	local textureInfo = LFG_EYE_TEXTURES[QueueStatusButton.Eye.queueType or "default"];
	QueueStatusButton.Eye.texture:SetTexCoord(0, textureInfo.iconSize / textureInfo.width, 0, textureInfo.iconSize / textureInfo.height);
end

local function QueueStatusButton_OnUpdate(self, elapsed)
	if ( self:IsShown() ) then
		self.Eye.texture:Show();
	else
		self.Eye.texture:Hide();
	end

	if ( self.Eye:IsStaticMode() ) then
		EyeTemplate_StopAnimating(self.Eye);
	end

	self.Eye.texture:SetTexture("Interface\\LFGFrame\\LFG-Eye")
	self.Eye.texture:SetSize(31, 31)

	self.Highlight:SetAtlas("groupfinder-eye-highlight", true)
	self.Highlight:ClearAllPoints()
	self.Highlight:SetPoint("CENTER", self, "CENTER", -1, 1)

	self:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
	self:GetHighlightTexture():ClearAllPoints()
	self:GetHighlightTexture():SetPoint("CENTER", self, "CENTER", -1, 1)

	self.Eye.EyeInitial:Hide()
	self.Eye.EyeSearchingLoop:Hide()
	self.Eye.EyeMouseOver:Hide()
	self.Eye.EyeFoundInitial:Hide()
	self.Eye.EyeFoundLoop:Hide()
	self.Eye.GlowBackLoop:Hide()
	self.Eye.EyePokeInitial:Hide()
	self.Eye.EyePokeLoop:Hide()
	self.Eye.EyePokeEnd:Hide()
end

QueueStatusButton:HookScript("OnUpdate", QueueStatusButton_OnUpdate)
QueueStatusButton:HookScript("OnHide", function(self)
	if (self.isDown) then
		MinimapButton_OnMouseUp(self);
	end
end)
QueueStatusButton:HookScript("OnMouseDown", MinimapButton_OnMouseDown)
QueueStatusButton:HookScript("OnMouseUp", MinimapButton_OnMouseUp)

--queuestatusframe
QueueStatusFrame:ClearAllPoints();
QueueStatusFrame:SetPoint("TOPRIGHT", QueueStatusButton, "TOPLEFT", -1, 1);

hooksecurefunc(QueueStatusFrame, "UpdatePosition", function(self)
	self:ClearAllPoints();
	self:SetPoint("TOPRIGHT", QueueStatusButton, "TOPLEFT", -1, 1);
end)

hooksecurefunc(QueueStatusFrame, "Update", function(self)
	local animateEye;

	--Try each LFG type
	for i=1, NUM_LE_LFG_CATEGORYS do
		local mode, submode = GetLFGMode(i);
		if ( mode and submode ~= "noteleport" ) then
			if ( mode == "queued" ) then
				animateEye = true;
			end
		end
	end

	--Try LFGList entries
	local isActive = C_LFGList.HasActiveEntryInfo();
	if ( isActive ) then
		animateEye = true;
	end

	--Try LFGList applications
	local apps = C_LFGList.GetApplications();
	for i=1, #apps do
		local _, appStatus = C_LFGList.GetApplicationInfo(apps[i]);
		if ( appStatus == "applied" or appStatus == "invited" ) then
			if ( appStatus == "applied" ) then
				animateEye = true;
			end
		end
	end

	--Try all PvP queues
	for i=1, GetMaxBattlefieldID() do
		local status, mapName, teamSize, registeredMatch, suspend = GetBattlefieldStatus(i);
		if ( status and status ~= "none" ) then
			if ( status == "queued" and not suspend ) then
				animateEye = true;
			end
		end
	end

	--Try all World PvP queues
	for i=1, MAX_WORLD_PVP_QUEUES do
		local status, mapName, queueID = GetWorldPVPQueueStatus(i);
		if ( status and status ~= "none" ) then
			if ( status == "queued" ) then
				animateEye = true;
			end
		end
	end

	--Pet Battle PvP Queue
	local pbStatus = C_PetBattles.GetPVPMatchmakingInfo();
	if ( pbStatus ) then
		if ( pbStatus == "queued" ) then
			animateEye = true;
		end
	end

	if ( animateEye ) then
		EyeTemplate_StartAnimating(QueueStatusButton.Eye);
	else
		EyeTemplate_StopAnimating(QueueStatusButton.Eye);
	end
end)