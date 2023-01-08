--[[
	skin.lua
		a custom RazerNaga UI skin
--]]

RazerNagaUI = LibStub("AceAddon-3.0"):NewAddon("RazerNagaUI", "AceConsole-3.0")

RazerNagaUI.frame = RazerNagaUI.frame or CreateFrame("Frame", "RazerNagaUIFrame")

function RazerNagaUI:OnEvent(event, ...) -- functions created in "object:method"-style have an implicit first parameter of "self", which points to object
	RazerNagaUI[event](RazerNagaUI, ...) -- route event parameters to RazerNagaUI:event methods
end
RazerNagaUI.frame:SetScript("OnEvent", RazerNagaUI.OnEvent)

local _
local strformat = string.format
local type = type
local pairs = pairs
local C_DateAndTime_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local GetDifficultyInfo = GetDifficultyInfo
local GetInstanceInfo = GetInstanceInfo
local GetLFGDungeonInfo = GetLFGDungeonInfo
local GetGuildInfo = GetGuildInfo
local InGuildParty = InGuildParty
local p, h, o, u, i = ...

-- First function fired
function RazerNagaUI:OnInitialize()
	self:ExtraFramesFunc(true)
end

-- Function that executes functionalities of the 'ExtraFramesFunc' function that need to be executed after the first "PLAYER_ENTERING_WORLD" event
function RazerNagaUI:EFF_PLAYER_ENTERING_WORLD()
	-- [Minimap]
	MinimapCluster:SetSize(192, 192)
	MinimapCluster:SetHitRectInsets(30, 10, 0, 30)
	MinimapCluster:SetScale(1)
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT")
	Minimap:SetSize(140, 140)
	Minimap:ClearAllPoints()
	Minimap:SetPoint("CENTER", MinimapCluster, "TOP", 9, -92)
	MinimapBackdrop:ClearAllPoints()
	MinimapBackdrop:SetPoint("CENTER", MinimapCluster, "CENTER", 0, -20)
	MinimapBackdrop:SetSize(192,192)
	MinimapBackdrop:CreateTexture("MinimapBorder", "ARTWORK")
	MinimapBorder:ClearAllPoints()
	MinimapBorder:SetAllPoints(MinimapBackdrop)
	MinimapBorder:SetTexture("Interface\\Minimap\\UI-Minimap-Border", "ARTWORK")
	MinimapBorder:SetDrawLayer("ARTWORK", 0)
	MinimapBorder:SetTexCoord(0.25, 0.125, 0.25, 0.875, 1, 0.125, 1, 0.875)
	MinimapCompassTexture:ClearAllPoints()
	MinimapCompassTexture:SetPoint("CENTER", Minimap, "CENTER", -2, 0)
	MinimapCompassTexture:SetTexture("Interface\\Minimap\\CompassRing", "OVERLAY")
	MinimapCompassTexture:SetSize(256, 256)	-- 365x365 scaled 0.7 = 255.5x255.5
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
	
	hooksecurefunc(ExpansionLandingPageMinimapButton, "UpdateIconForGarrison", function()
		ExpansionLandingPageMinimapButton:ClearAllPoints()
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 37, -122)
	end)
	ExpansionLandingPageMinimapButton:ClearAllPoints()
	ExpansionLandingPageMinimapButton:SetSize(44, 44)
	ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 37, -122)
	local ldbi = LibStub ~= nil and LibStub:GetLibrary("LibDBIcon-1.0", true)
	if (ldbi ~= nil) then
		for _, v in pairs(ldbi:GetButtonList()) do
			ldbi:Refresh(v)
		end
	end
	
	TimeManagerClockButton:SetParent(Minimap)
	TimeManagerClockButton:ClearAllPoints()
	TimeManagerClockButton:SetPoint("CENTER", Minimap, "CENTER", 0, -75)
	TimeManagerClockButton:SetFrameStrata("LOW")
	TimeManagerClockButton:SetFrameLevel(5)
	TimeManagerClockButton:SetSize(60, 28)
	--TimeManagerClockButton:SetHitRectInsets(8, 5, 3, 3)	--is already the default value
	local TimeManagerClockButtonBackground = TimeManagerClockButton:CreateTexture("TimeManagerClockButtonBackground", "BORDER")
	TimeManagerClockButtonBackground:ClearAllPoints()
	TimeManagerClockButtonBackground:SetAllPoints(TimeManagerClockButton)
	TimeManagerClockButtonBackground:SetTexture("Interface\\TimeManager\\ClockBackground")
	TimeManagerClockButtonBackground:SetTexCoord(0.015625, 0.8125, 0.015625, 0.390625)
	TimeManagerClockButtonBackground:Show()
	
	GameTimeFrame:SetParent(Minimap)
	GameTimeFrame:ClearAllPoints()
	GameTimeFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 20, -2)
	GameTimeFrame:SetSize(40, 40)
	GameTimeFrame:SetHitRectInsets(6, 0, 5, 10)
	GameTimeFrame:SetFrameStrata("LOW")
	GameTimeFrame:SetFrameLevel(5)
	
	hooksecurefunc("GameTimeFrame_SetDate", function()
		GameTimeFrame:SetText(C_DateAndTime_GetCurrentCalendarTime().monthDay)
		GameTimeFrame:SetNormalTexture("Interface\\Calendar\\UI-Calendar-Button")
		GameTimeFrame:GetNormalTexture():SetTexCoord(0, 0, 0, 0.78125, 0.390625, 0, 0.390625, 0.78125)
		GameTimeFrame:SetPushedTexture("Interface\\Calendar\\UI-Calendar-Button")
		GameTimeFrame:GetPushedTexture():SetTexCoord(0.5, 0, 0.5, 0.78125, 0.890625, 0, 0.890625, 0.78125)
		GameTimeFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
		--GameTimeFrame:GetHighlightTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)	--not needed
		GameTimeFrame:GetNormalTexture():SetDrawLayer("BACKGROUND")
		GameTimeFrame:GetPushedTexture():SetDrawLayer("BACKGROUND")
		GameTimeFrame:GetFontString():SetDrawLayer("BACKGROUND")
	end)
	GameTimeFrame:SetNormalTexture("Interface\\Calendar\\UI-Calendar-Button")
	GameTimeFrame:GetNormalTexture():SetTexCoord(0, 0, 0, 0.78125, 0.390625, 0, 0.390625, 0.78125)
	GameTimeFrame:SetPushedTexture("Interface\\Calendar\\UI-Calendar-Button")
	GameTimeFrame:GetPushedTexture():SetTexCoord(0.5, 0, 0.5, 0.78125, 0.890625, 0, 0.890625, 0.78125)
	GameTimeFrame:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD")
	--GameTimeFrame:GetHighlightTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)	--not needed
	GameTimeFrame:SetNormalFontObject("GameFontBlack")
	GameTimeFrame:SetFontString(GameTimeFrame:CreateFontString(nil, "BACKGROUND", "GameFontBlack"))
	GameTimeFrame:GetFontString():ClearAllPoints()
	GameTimeFrame:GetFontString():SetPoint("CENTER", GameTimeFrame, "CENTER", -1, -1)
	GameTimeFrame:GetNormalTexture():SetDrawLayer("BACKGROUND")
	GameTimeFrame:GetPushedTexture():SetDrawLayer("BACKGROUND")
	GameTimeFrame:GetFontString():SetDrawLayer("BACKGROUND")
	GameTimeFrame:SetText(C_DateAndTime_GetCurrentCalendarTime().monthDay)
	
	MinimapCluster.Tracking:SetParent(MinimapBackdrop)
	MinimapCluster.Tracking:ClearAllPoints()
	MinimapCluster.Tracking:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 9, -45)
	MinimapCluster.Tracking:SetFrameStrata("LOW")
	MinimapCluster.Tracking:SetFrameLevel(4)
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
	MinimapCluster.Tracking.ButtonBorder:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder")
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
	Minimap.ZoomIn:SetFrameStrata("LOW")
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
	Minimap.ZoomOut:SetFrameStrata("LOW")
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
	
	MinimapCluster.MailFrame:SetParent(MinimapCluster)
	MinimapCluster.MailFrame:ClearAllPoints()
	MinimapCluster.MailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 24, -37)
	MinimapCluster.MailFrame:SetSize(33, 33)
	MinimapCluster.MailFrame:SetFrameStrata("LOW")
	MinimapCluster.MailFrame:SetFrameLevel(4)
	
	MiniMapMailIcon:ClearAllPoints()
	MiniMapMailIcon:SetPoint("TOPLEFT", MinimapCluster.MailFrame, "TOPLEFT", 7, -6)
	MiniMapMailIcon:SetTexture("Interface\\Icons\\INV_Letter_15")
	MiniMapMailIcon:SetSize(18, 18)
	MiniMapMailIcon:SetDrawLayer("ARTWORK", 0)
	
	MinimapCluster.MailFrame:CreateTexture("MiniMapMailBorder", "OVERLAY")
	MiniMapMailBorder:ClearAllPoints()
	MiniMapMailBorder:SetPoint("TOPLEFT", MinimapCluster.MailFrame, "TOPLEFT", 0, 0)
	MiniMapMailBorder:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder")
	MiniMapMailBorder:SetSize(52, 52)
	MiniMapMailBorder:SetDrawLayer("OVERLAY", 0)
	
	MinimapCluster.InstanceDifficulty:Hide()
	
	local RazerNagaUI_MiniMapInstanceDifficulty = CreateFrame("Frame", "RazerNagaUI_MiniMapInstanceDifficulty", MinimapCluster)
	RazerNagaUI_MiniMapInstanceDifficulty:SetFrameStrata("LOW")
	RazerNagaUI_MiniMapInstanceDifficulty:SetFrameLevel(11)
	RazerNagaUI_MiniMapInstanceDifficulty:SetSize(38, 46)
	RazerNagaUI_MiniMapInstanceDifficulty:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 22, -17)
	RazerNagaUI_MiniMapInstanceDifficulty:Hide()
	local RazerNagaUI_MiniMapInstanceDifficultyTexture = RazerNagaUI_MiniMapInstanceDifficulty:CreateTexture("RazerNagaUI_MiniMapInstanceDifficultyTexture", "ARTWORK")
	RazerNagaUI_MiniMapInstanceDifficultyTexture:SetSize(64, 46)
	RazerNagaUI_MiniMapInstanceDifficultyTexture:SetTexture("Interface\\Minimap\\UI-DungeonDifficulty-Button")
	RazerNagaUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4140625)
	RazerNagaUI_MiniMapInstanceDifficultyTexture:SetPoint("CENTER", RazerNagaUI_MiniMapInstanceDifficulty, "CENTER", 0, 0)
	local RazerNagaUI_MiniMapInstanceDifficultyText = RazerNagaUI_MiniMapInstanceDifficulty:CreateFontString("RazerNagaUI_MiniMapInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
	RazerNagaUI_MiniMapInstanceDifficultyText:SetJustifyH("CENTER")
	RazerNagaUI_MiniMapInstanceDifficultyText:SetJustifyV("MIDDLE")
	RazerNagaUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", RazerNagaUI_MiniMapInstanceDifficulty, "CENTER", -1, -7)
	
	local RazerNagaUI_GuildInstanceDifficulty = CreateFrame("Frame", "RazerNagaUI_GuildInstanceDifficulty", MinimapCluster)
	RazerNagaUI_GuildInstanceDifficulty:SetFrameStrata("LOW")
	RazerNagaUI_GuildInstanceDifficulty:SetFrameLevel(11)
	RazerNagaUI_GuildInstanceDifficulty:SetSize(38, 46)
	RazerNagaUI_GuildInstanceDifficulty:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 22, -17)
	RazerNagaUI_GuildInstanceDifficulty:Hide()
	local RazerNagaUI_GuildInstanceDifficultyBackground = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyBackground", "BACKGROUND")
	RazerNagaUI_GuildInstanceDifficulty.background = RazerNagaUI_GuildInstanceDifficultyBackground
	RazerNagaUI_GuildInstanceDifficultyBackground:SetSize(41, 53)
	RazerNagaUI_GuildInstanceDifficultyBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyBackground:SetTexCoord(0.0078125, 0.328125, 0.015625, 0.84375)
	RazerNagaUI_GuildInstanceDifficultyBackground:SetPoint("TOPLEFT", RazerNagaUI_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
	local RazerNagaUI_GuildInstanceDifficultyDarkBackground = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyDarkBackground", "BORDER")
	RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetSize(30, 21)
	RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetTexCoord(0.6796875, 0.9140625, 0.015625, 0.34375)
	RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetPoint("BOTTOM", RazerNagaUI_GuildInstanceDifficultyBackground, "BOTTOM", 0, 7)
	RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
	local RazerNagaUI_GuildInstanceDifficultyEmblem = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyEmblem", "ARTWORK")
	RazerNagaUI_GuildInstanceDifficulty.emblem = RazerNagaUI_GuildInstanceDifficultyEmblem
	RazerNagaUI_GuildInstanceDifficultyEmblem:SetSize(16, 16)
	RazerNagaUI_GuildInstanceDifficultyEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
	RazerNagaUI_GuildInstanceDifficultyEmblem:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	RazerNagaUI_GuildInstanceDifficultyEmblem:SetPoint("TOPLEFT", RazerNagaUI_GuildInstanceDifficulty, "TOPLEFT", 12, -10)
	local RazerNagaUI_GuildInstanceDifficultyBorder = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyBorder", "ARTWORK")
	RazerNagaUI_GuildInstanceDifficulty.border = RazerNagaUI_GuildInstanceDifficultyBorder
	RazerNagaUI_GuildInstanceDifficultyBorder:SetSize(41, 53)
	RazerNagaUI_GuildInstanceDifficultyBorder:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyBorder:SetTexCoord(0.34375, 0.6640625, 0.015625, 0.84375)
	RazerNagaUI_GuildInstanceDifficultyBorder:SetPoint("BOTTOMLEFT", RazerNagaUI_GuildInstanceDifficulty, "BOTTOMLEFT", 0, 0)
	local RazerNagaUI_GuildInstanceDifficultyHeroicTexture = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyHeroicTexture", "ARTWORK")
	RazerNagaUI_GuildInstanceDifficultyHeroicTexture:SetSize(12, 13)
	RazerNagaUI_GuildInstanceDifficultyHeroicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyHeroicTexture:SetTexCoord(0.6796875, 0.7734375, 0.65625, 0.859375)
	RazerNagaUI_GuildInstanceDifficultyHeroicTexture:SetPoint("BOTTOMLEFT", RazerNagaUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local RazerNagaUI_GuildInstanceDifficultyMythicTexture = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyMythicTexture", "ARTWORK")
	RazerNagaUI_GuildInstanceDifficultyMythicTexture:SetSize(12, 13)
	RazerNagaUI_GuildInstanceDifficultyMythicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyMythicTexture:SetTexCoord(0.7734375, 0.8671875, 0.65625, 0.859375)
	RazerNagaUI_GuildInstanceDifficultyMythicTexture:SetPoint("BOTTOMLEFT", RazerNagaUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture", "ARTWORK")
	RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:SetSize(12, 12)
	RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:SetTexture("Interface\\Common\\mini-hourglass")
	RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:SetPoint("BOTTOMLEFT", RazerNagaUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local RazerNagaUI_GuildInstanceDifficultyText = RazerNagaUI_GuildInstanceDifficulty:CreateFontString("RazerNagaUI_GuildInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
	RazerNagaUI_GuildInstanceDifficultyText:SetJustifyH("CENTER")
	RazerNagaUI_GuildInstanceDifficultyText:SetJustifyV("MIDDLE")
	RazerNagaUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", RazerNagaUI_GuildInstanceDifficulty, "BOTTOMLEFT", 20, 8)
	RazerNagaUI_GuildInstanceDifficultyText:SetText("25")
	local RazerNagaUI_GuildInstanceDifficultyHanger = RazerNagaUI_GuildInstanceDifficulty:CreateTexture("RazerNagaUI_GuildInstanceDifficultyHanger", "OVERLAY")
	RazerNagaUI_GuildInstanceDifficultyHanger:SetSize(39, 16)
	RazerNagaUI_GuildInstanceDifficultyHanger:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	RazerNagaUI_GuildInstanceDifficultyHanger:SetTexCoord(0.6796875, 0.984375, 0.375, 0.625)
	RazerNagaUI_GuildInstanceDifficultyHanger:SetPoint("TOPLEFT", RazerNagaUI_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
	
	local RazerNagaUI_MiniMapChallengeMode = CreateFrame("Frame", "RazerNagaUI_MiniMapChallengeMode", MinimapCluster)
	RazerNagaUI_MiniMapChallengeMode:SetFrameStrata("LOW")
	RazerNagaUI_MiniMapChallengeMode:SetFrameLevel(11)
	RazerNagaUI_MiniMapChallengeMode:SetSize(27, 36)
	RazerNagaUI_MiniMapChallengeMode:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 28, -23)
	RazerNagaUI_MiniMapChallengeMode:Hide()
	local RazerNagaUI_MiniMapChallengeModeTexture = RazerNagaUI_MiniMapChallengeMode:CreateTexture("RazerNagaUI_MiniMapChallengeModeTexture", "BACKGROUND")
	RazerNagaUI_MiniMapChallengeModeTexture:SetSize(64, 46)
	RazerNagaUI_MiniMapChallengeModeTexture:SetTexture("Interface\\Challenges\\challenges-minimap-banner")
	RazerNagaUI_MiniMapChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	RazerNagaUI_MiniMapChallengeModeTexture:SetPoint("CENTER", RazerNagaUI_MiniMapChallengeMode, "CENTER", 0, 0)
	
	RazerNagaUI_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	RazerNagaUI_MiniMapInstanceDifficulty:RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED")
	RazerNagaUI_MiniMapInstanceDifficulty:RegisterEvent("UPDATE_INSTANCE_INFO")
	RazerNagaUI_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_GUILD_UPDATE")
	RazerNagaUI_MiniMapInstanceDifficulty:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
	
	function RazerNagaUI_MiniMapInstanceDifficulty:MiniMapInstanceDifficulty_Update()
		local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize = GetInstanceInfo()
		local _, _, isHeroic, isChallengeMode, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
		if ( self.isGuildGroup ) then
			if ( instanceGroupSize == 0 ) then
				RazerNagaUI_GuildInstanceDifficultyText:SetText("")
				RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0)
				RazerNagaUI_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -16)
			else
				RazerNagaUI_GuildInstanceDifficultyText:SetText(instanceGroupSize)
				RazerNagaUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
				RazerNagaUI_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -10)
			end
			RazerNagaUI_GuildInstanceDifficultyText:ClearAllPoints()
			if ( isHeroic or isChallengeMode or displayMythic or displayHeroic ) then
				local symbolTexture
				if ( isChallengeMode ) then
					symbolTexture = RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture
					RazerNagaUI_GuildInstanceDifficultyHeroicTexture:Hide()
					RazerNagaUI_GuildInstanceDifficultyMythicTexture:Hide()
				elseif ( displayMythic ) then
					symbolTexture = RazerNagaUI_GuildInstanceDifficultyMythicTexture
					RazerNagaUI_GuildInstanceDifficultyHeroicTexture:Hide()
					RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
				else
					symbolTexture = RazerNagaUI_GuildInstanceDifficultyHeroicTexture
					RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
					RazerNagaUI_GuildInstanceDifficultyMythicTexture:Hide()
				end
				if ( instanceGroupSize < 10 ) then
					symbolTexture:SetPoint("BOTTOMLEFT", 11, 7)
					RazerNagaUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 23, 8)
				elseif ( instanceGroupSize > 19 ) then
					symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
					RazerNagaUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 20, 8)
				else
					symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
					RazerNagaUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 19, 8)
				end
				symbolTexture:Show()
			else
				RazerNagaUI_GuildInstanceDifficultyHeroicTexture:Hide()
				RazerNagaUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
				RazerNagaUI_GuildInstanceDifficultyMythicTexture:Hide()
				RazerNagaUI_GuildInstanceDifficultyText:SetPoint("BOTTOM", 2, 8)
			end
			self:Hide()
			SetSmallGuildTabardTextures("player", RazerNagaUI_GuildInstanceDifficulty.emblem, RazerNagaUI_GuildInstanceDifficulty.background, RazerNagaUI_GuildInstanceDifficulty.border)
			RazerNagaUI_GuildInstanceDifficulty:Show()
			RazerNagaUI_MiniMapChallengeMode:Hide()
		elseif ( isChallengeMode ) then
			RazerNagaUI_MiniMapChallengeMode:Show()
			self:Hide()
			RazerNagaUI_GuildInstanceDifficulty:Hide()
		elseif ( instanceType == "raid" or isHeroic or displayMythic or displayHeroic ) then
			RazerNagaUI_MiniMapInstanceDifficultyText:SetText(instanceGroupSize)
			local xOffset = 0
			if ( instanceGroupSize >= 10 and instanceGroupSize <= 19 ) then
				xOffset = -1
			end
			if ( displayMythic ) then
				RazerNagaUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0.25, 0.5, 0.0703125, 0.4296875)
				RazerNagaUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -9)
			elseif ( isHeroic or displayHeroic ) then
				RazerNagaUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4296875)
				RazerNagaUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -9)
			else
				RazerNagaUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.5703125, 0.9296875)
				RazerNagaUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, 5)
			end
			self:Show()
			RazerNagaUI_GuildInstanceDifficulty:Hide()
			RazerNagaUI_MiniMapChallengeMode:Hide()
		else
			self:Hide()
			RazerNagaUI_GuildInstanceDifficulty:Hide()
			RazerNagaUI_MiniMapChallengeMode:Hide()
		end
	end
	RazerNagaUI_MiniMapInstanceDifficulty:SetScript("OnEvent", function(self, event, ...)
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
			local tabard = RazerNagaUI_GuildInstanceDifficulty
			SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background, tabard.border)
			if not( IsInGuild() ) then
				self.isGuildGroup = nil
				self:MiniMapInstanceDifficulty_Update()
			end
		end
	end)
	RazerNagaUI_MiniMapInstanceDifficulty:SetScript("OnEnter", function(self)
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
	RazerNagaUI_MiniMapInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
	
	RazerNagaUI_GuildInstanceDifficulty:SetScript("OnEnter", function(self)
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
	RazerNagaUI_GuildInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
	
	hooksecurefunc(MinimapCluster, "SetHeaderUnderneath", function(self, headerUnderneath)
		self.Minimap:ClearAllPoints()
		self.Minimap:SetPoint("CENTER", self, "TOP", 9, -92)
		self.BorderTop:ClearAllPoints()
		self.BorderTop:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", 0, 0)
		self.MailFrame:ClearAllPoints()
		self.MailFrame:SetPoint("TOPRIGHT", self.Minimap, "TOPRIGHT", 24, -37)
	end)
	
	CreateFrame("Button", "MinimapZoneTextButton", MinimapCluster)
	MinimapZoneTextButton:ClearAllPoints()
	MinimapZoneTextButton:SetPoint("CENTER", MinimapCluster, "CENTER", 0, 83)
	MinimapZoneTextButton:SetSize(140, 12)
	MinimapZoneTextButton:SetFrameStrata("LOW")
	MinimapZoneTextButton:SetFrameLevel(2)
	MinimapZoneText:SetParent(MinimapZoneTextButton)
	MinimapZoneText:ClearAllPoints()
	MinimapZoneText:SetPoint("CENTER", MinimapZoneTextButton, "TOP", 3, -6)
	MinimapZoneText:SetSize(140, 12)
	MinimapZoneText:SetDrawLayer("BACKGROUND")
	MinimapZoneText:SetJustifyH("CENTER")
	MinimapBackdrop:CreateTexture("MinimapBorderTop", "ARTWORK")
	MinimapBorderTop:ClearAllPoints()
	MinimapBorderTop:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT")
	MinimapBorderTop:SetTexture("Interface\\Minimap\\UI-Minimap-Border")
	MinimapBorderTop:SetTexCoord(0.25, 0, 0.25, 0.125, 1, 0, 1, 0.125)
	MinimapBorderTop:SetSize(192, 32)
	MinimapBorderTop:SetDrawLayer("ARTWORK", 0)
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
	MiniMapWorldMapButton:ClearAllPoints()
	MiniMapWorldMapButton:SetPoint("TOPRIGHT", MinimapBackdrop, "TOPRIGHT", -2, 23)
	MiniMapWorldMapButton:SetSize(32, 32)
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
	
	RazerNagaUI.Minimap_SetTooltip = function(pvpType, factionName)
		if (GameTooltip:IsOwned(MinimapZoneTextButton)) then
			GameTooltip:SetOwner(MinimapZoneTextButton, "ANCHOR_LEFT")
			local zoneName = GetZoneText()
			local subzoneName = GetSubZoneText()
			if (subzoneName == zoneName) then
				subzoneName = ""
			end
			GameTooltip:AddLine(zoneName, 1.0, 1.0, 1.0)
			if (pvpType == "sanctuary") then
				GameTooltip:AddLine(subzoneName, 0.41, 0.8, 0.94)
				GameTooltip:AddLine(SANCTUARY_TERRITORY, 0.41, 0.8, 0.94)
			elseif (pvpType == "arena") then
				GameTooltip:AddLine(subzoneName, 1.0, 0.1, 0.1)
				GameTooltip:AddLine(FREE_FOR_ALL_TERRITORY, 1.0, 0.1, 0.1)
			elseif (pvpType == "friendly") then
				if (factionName and factionName ~= "") then
					GameTooltip:AddLine(subzoneName, 0.1, 1.0, 0.1)
					GameTooltip:AddLine(format(FACTION_CONTROLLED_TERRITORY, factionName), 0.1, 1.0, 0.1)
				end
			elseif (pvpType == "hostile") then
				if (factionName and factionName ~= "") then
					GameTooltip:AddLine(subzoneName, 1.0, 0.1, 0.1)
					GameTooltip:AddLine(format(FACTION_CONTROLLED_TERRITORY, factionName), 1.0, 0.1, 0.1)
				end
			elseif (pvpType == "contested") then
				GameTooltip:AddLine(subzoneName, 1.0, 0.7, 0.0)
				GameTooltip:AddLine(CONTESTED_TERRITORY, 1.0, 0.7, 0.0)
			elseif (pvpType == "combat") then
				GameTooltip:AddLine(subzoneName, 1.0, 0.1, 0.1 )
				GameTooltip:AddLine(COMBAT_ZONE, 1.0, 0.1, 0.1)
			else
				GameTooltip:AddLine(subzoneName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
			end
			GameTooltip:Show()
		end
	end
	hooksecurefunc("Minimap_SetTooltip", RazerNagaUI.Minimap_SetTooltip)
	MinimapZoneTextButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		local pvpType, _, factionName = GetZonePVPInfo()
		RazerNagaUI.Minimap_SetTooltip(pvpType, factionName)
		GameTooltip:Show()
	end)
	MinimapZoneTextButton:SetScript("OnLeave", function(self)
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
	
	-- [QueueStatusButton]
	QueueStatusButton:SetParent(MinimapBackdrop)
	QueueStatusButton:ClearAllPoints()
	QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 36, -157)
	QueueStatusButton:SetFrameStrata("LOW")
	QueueStatusButton:SetFrameLevel(5)
	QueueStatusButton:SetScale(0.65)

	-- [UnitFrames]
	function PermaHide(frameToHide)
		frameToHide:Hide()
		hooksecurefunc(frameToHide, "Show", function()
			frameToHide:Hide()
		end)
	end

	function ApplyFrame(frame)
		local contextual = frame.TargetFrameContent.TargetFrameContentContextual;
		PermaHide(contextual.PrestigeBadge)
		PermaHide(contextual.PrestigePortrait)
		PermaHide(contextual.PvpIcon)
		PermaHide(frame.TargetFrameContainer.Flash)
		PermaHide(PetFrameHealthBarMask)
		PermaHide(PetFrameManaBarMask)
		PermaHide(PetFrameOverAbsorbGlow)

		frame.Background = frame:CreateTexture(nil, "ARTWORK");
		frame.Background:SetPoint("TOPLEFT", frame, "TOPLEFT", 26, -29);
		frame.Background:SetSize(119, 41)
		frame.Background:SetColorTexture(0, 0, 0, 0.5)
		frame.TargetFrameContent.TargetFrameContentMain.HealthBar:SetStatusBarColor(0, 1, 0);

		if (GetCVar("comboPointLocation") == "1") then
			ComboFrame:SetPoint("TOPRIGHT", TargetFrame, -25, -20)
		end
		
		local function PositionTargetBars()
			local powerColor = GetPowerBarColor(UnitPowerType(frame.unit))

			local FrameManaBar = frame.TargetFrameContent.TargetFrameContentMain.ManaBar;
			local FrameHealthBar = frame.TargetFrameContent.TargetFrameContentMain.HealthBar;

			FrameHealthBar:ClearAllPoints()
			FrameHealthBar:SetSize(119, 12);
			FrameHealthBar:SetPoint("TOPLEFT", 26, -48);
			FrameHealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")

			FrameManaBar:ClearAllPoints()
			FrameManaBar:SetSize(119, 12);
			FrameManaBar:SetPoint("TOPLEFT", 26, -59);

			local atlas = GetAtlasForBar(FrameManaBar)

			if (atlas) then
				if (FrameManaBar.SetStatusBarAtlas) then
					FrameManaBar:SetStatusBarAtlas(atlas)
				end
				FrameManaBar:SetStatusBarColor(1, 1, 1)
			else			
				FrameManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				FrameManaBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
			end

			local frameNameText = frame.TargetFrameContent.TargetFrameContentMain.Name;
			frameNameText:ClearAllPoints()
			frameNameText:SetJustifyH("CENTER")
			frameNameText:SetPoint("TOPLEFT", frame.TargetFrameContainer, "TOPLEFT", 40, -33)
			frameNameText:SetParent(frame.TargetFrameContainer)

			FrameHealthBar.TextString:SetParent(frame.TargetFrameContainer)
			FrameHealthBar.RightText:SetParent(frame.TargetFrameContainer)
			FrameHealthBar.LeftText:SetParent(frame.TargetFrameContainer)

			FrameManaBar.TextString:SetParent(frame.TargetFrameContainer)
			FrameManaBar.RightText:SetParent(frame.TargetFrameContainer)
			FrameManaBar.LeftText:SetParent(frame.TargetFrameContainer)
			
			frame.TargetFrameContent.TargetFrameContentMain.ManaBar.RightText:SetPoint("RIGHT", frame.TargetFrameContent.TargetFrameContentMain.ManaBar, "RIGHT", -4, 0)
		end

		local function CreateNameBackground()
			if (frame.nameBackground == nil) then
				frame.nameBackground = frame.TargetFrameContainer:CreateTexture(nil, "BACKGROUND")
			end

			frame.nameBackground:SetSize(119, 19)
			frame.nameBackground:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-LevelBackground")
			frame.nameBackground:ClearAllPoints()
			frame.nameBackground:SetPoint("TOPRIGHT", frame.TargetFrameContent.TargetFrameContentMain, "TOPRIGHT", -88, -30)
			if ( not UnitPlayerControlled(frame.unit) and UnitIsTapDenied(frame.unit) ) then
				frame.nameBackground:SetVertexColor(0.5, 0.5, 0.5);
			else
				local r,g,b = UnitSelectionColor(frame.unit)
				frame.nameBackground:SetVertexColor(r,g,b);
			end
		end

		hooksecurefunc(frame, "CheckClassification", function()
			CreateNameBackground()

			local leaderIcon = frame.TargetFrameContent.TargetFrameContentContextual.LeaderIcon;
			leaderIcon:ClearAllPoints()
			leaderIcon:SetPoint("TOPRIGHT", -22, -18)

			frame.TargetFrameContainer.FrameTexture:Hide()
			if (frame.TargetFrameContainer.ClassicTexture == nil) then
				frame.TargetFrameContainer.ClassicTexture = frame.TargetFrameContainer:CreateTexture(nil, "ARTWORK")
			end
			frame.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			frame.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", frame.TargetFrameContainer, "TOPLEFT", 20, -7)
			frame.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			frame.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
			--<TexCoords left="0.09375" right="1.0" top="0" bottom="0.78125"/>
			frame.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			frame.TargetFrameContainer.ClassicTexture:SetVertexColor(frame.TargetFrameContainer.FrameTexture:GetVertexColor())
			frame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
			frame.TargetFrameContainer.Portrait:SetSize(64, 64)
			frame.TargetFrameContainer.Portrait:ClearAllPoints()
			frame.TargetFrameContainer.Portrait:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -22, -20)
			frame.TargetFrameContainer:SetFrameStrata("MEDIUM")
			frame.TargetFrameContainer.BossPortraitFrameTexture:SetDrawLayer("BACKGROUND", 1)
			frame.TargetFrameContent.TargetFrameContentContextual:SetFrameStrata("MEDIUM")
		end)

		local function fixDebuffs()
			local frameName = frame.totFrame:GetName();
			local suffix = "Debuff";
			local frameNameWithSuffix = frameName..suffix;
			for i=1,4 do
				local debuffName = frameNameWithSuffix..i;
				_G[debuffName]:ClearAllPoints()
				if (i == 1) then
					_G[debuffName]:SetPoint("TOPLEFT", frame.totFrame, "TOPRIGHT", -23, -8)
				elseif (i==2) then
					_G[debuffName]:SetPoint("TOPLEFT", frame.totFrame, "TOPRIGHT", -10, -8)
				elseif (i==3) then
					_G[debuffName]:SetPoint("TOPLEFT", frame.totFrame, "TOPRIGHT", -23, -21)
				elseif (i==4) then
					_G[debuffName]:SetPoint("TOPLEFT", frame.totFrame, "TOPRIGHT", -10, -21)
				end
			end
		end

		hooksecurefunc(frame, "Update", function()
			PositionTargetBars();
			if (frame.totFrame) then
				frame.totFrame:ClearAllPoints()
				if (not InCombatLockdown()) then
					frame.totFrame:SetPoint("TOPLEFT", frame, "BOTTOMRIGHT", -83, 17)
				end
				frame.totFrame.FrameTexture:Hide()

				local powerColor = GetPowerBarColor(UnitPowerType(frame.totFrame.unit))

				frame.totFrame.HealthBar.HealthBarMask:Hide()
				frame.totFrame.HealthBar:ClearAllPoints()
				frame.totFrame.HealthBar:SetPoint("TOPRIGHT", -29, -15)
				frame.totFrame.HealthBar:SetSize(46, 7)
				frame.totFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				frame.totFrame.HealthBar:SetStatusBarColor(0, 1, 0);
				frame.totFrame.HealthBar:SetFrameLevel(1)

				frame.totFrame.ManaBar.ManaBarMask:Hide()
				frame.totFrame.ManaBar:ClearAllPoints()
				frame.totFrame.ManaBar:SetPoint("TOPRIGHT", -29, -23)
				frame.totFrame.ManaBar:SetSize(46, 7)
				frame.totFrame.ManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
				frame.totFrame.ManaBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
				frame.totFrame.ManaBar:SetFrameLevel(1)

				if (frame.totFrame.ClassicTexture == nil) then
					frame.totFrame.ClassicTexture = frame.totFrame:CreateTexture(nil, "BORDER")
				end
				frame.totFrame.ClassicTexture:ClearAllPoints()
				frame.totFrame.ClassicTexture:SetPoint("TOPLEFT", frame.totFrame, "TOPLEFT", 0, 0)
				frame.totFrame.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetofTargetFrame")
				-- <TexCoords left="0.015625" right="0.7265625" top="0" bottom="0.703125"/>
				frame.totFrame.ClassicTexture:SetTexCoord(0.015625, 0.7265625, 0, 0.703125)
				frame.totFrame.ClassicTexture:SetSize(93, 45)

				frame.totFrame.name:ClearAllPoints();
				frame.totFrame.name:SetPoint("BOTTOMLEFT", 42, 5)
				fixDebuffs()
			end
		end)

		hooksecurefunc(frame, "CheckLevel", function()
			local contextual = frame.TargetFrameContent.TargetFrameContentContextual
			local levelText = frame.TargetFrameContent.TargetFrameContentMain.LevelText;
			local petBattle = contextual.PetBattleIcon;
			local highLevelTexture = contextual.HighLevelTexture;

			highLevelTexture:ClearAllPoints();
			highLevelTexture:SetParent(contextual)
			highLevelTexture:SetPoint("CENTER", contextual, "CENTER", 81, -24)

			petBattle:ClearAllPoints();
			petBattle:SetParent(contextual)
			petBattle:SetPoint("CENTER", contextual, "CENTER", 81, 24)

			levelText:ClearAllPoints();
			levelText:SetParent(contextual)
			levelText:SetPoint("CENTER", contextual, "CENTER", 81, -24)
		end)

		hooksecurefunc(frame, "CreateTargetofTarget", function()
			if (frame.totFrame) then
				frame.totFrame.FrameTexture:Hide()
			end
		end)
		
		frame:HookScript("OnEvent", function(s, e, ...)
			PositionTargetBars()
		end)


		if (frame.totFrame) then
			frame.totFrame:RegisterEvent("UNIT_AURA")
			frame.totFrame:HookScript("OnEvent", function(s, e, ...)
				local arg1 = ...;
				if ((not (arg1 == "")) and (not (arg1 == nil)) and
					(not (s.unit == "")) and (not (s.unit == nil)) and
					 UnitIsUnit(arg1, s.unit)) then
					RefreshDebuffs(s, s.unit, nil, nil, true)
				end
			end)
		end
	end

	-- [PlayerFrame]
	local PlayerFrameManaBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar
	local PlayerFrameHealthBar = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar
	local PlayerFrameManaBarText = PlayerFrameManaBar.ManaBarText
	local PlayerFrameHealthBarText = PlayerFrameHealthBar.TextString
	local PlayerFrameManaBarTextLeft = PlayerFrameManaBar.LeftText
	local PlayerFrameManaBarTextRight = PlayerFrameManaBar.RightText
	local PlayerFrameHealthBarTextLeft = PlayerFrameHealthBar.LeftText
	local PlayerFrameHealthBarTextRight = PlayerFrameHealthBar.RightText
	local ranOnce = false

	function GetAtlasForBar(self)
		local atlas = nil
		if (self.powerType and (self.powerType >= 11 or self.powerType == 8)) then
			atlas = PowerBarColor[self.powerType].atlas
		end
		return atlas
	end

	local function updateBarTexture(self, texture)
		local atlas = GetAtlasForBar(self)
		if (atlas) then
			if (self.SetStatusBarAtlas) then
				self:SetStatusBarAtlas(atlas)
			end
		else
			if (texture == "Interface\\TargetingFrame\\UI-StatusBar") then return end
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		end
	end
	local function updateManaBarColor(self, r, g, b, a)
		local color = {};
		color.r = 1;
		color.g = 1;
		color.b = 1;
		local atlas = GetAtlasForBar(self)
		if (not atlas and self.powerType) then
			color = GetPowerBarColor(self.powerType)
		end
		if (color.r ~= r or color.g ~= g or color.b ~= b) then
			self:SetStatusBarColor(color.r, color.g, color.b)
		end
	end

	local function updateBarColor(self, r, g, b, a)
		local color = {};
		color.r = 0;
		color.g = 1;
		color.b = 0;
		if (self.powerType) then
			color = GetPowerBarColor(self.powerType)
		end
		if (color.r ~= r or color.g ~= g or color.b ~= b) then
			self:SetStatusBarColor(color.r, color.g, color.b)
		end
	end

	PlayerFrame.PlayerFrameContainer.FrameTexture:ClearAllPoints()
	PlayerFrame.PlayerFrameContainer.FrameTexture:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContainer, "TOPLEFT", -20, -5)
	PlayerFrame.PlayerFrameContainer.FrameTexture:SetSize(232, 100)
	PlayerFrame.PlayerFrameContainer.FrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
	--<TexCoords left="1.0" right="0.09375" top="0" bottom="0.78125"/>
	PlayerFrame.PlayerFrameContainer.FrameTexture:SetTexCoord(1, 0.09375, 0, 0.78125)
	PlayerFrame.PlayerFrameContainer:SetFrameLevel(4)
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:SetFrameLevel(5)
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetSize(64, 64)
	PlayerFrame.PlayerFrameContainer.PlayerPortraitMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
	PlayerFrame.PlayerFrameContainer.PlayerPortrait:SetDrawLayer("BACKGROUND")
	PlayerFrame.PlayerFrameContainer.PlayerPortraitMask:SetDrawLayer("BACKGROUND")

	PlayerFrameHealthBarText:SetParent(PlayerFrame.PlayerFrameContainer)
	PlayerFrameManaBarText:SetParent(PlayerFrame.PlayerFrameContainer)
	PlayerFrameHealthBarTextLeft:SetParent(PlayerFrame.PlayerFrameContainer)
	PlayerFrameManaBarTextLeft:SetParent(PlayerFrame.PlayerFrameContainer)
	PlayerFrameHealthBarTextRight:SetParent(PlayerFrame.PlayerFrameContainer)
	PlayerFrameManaBarTextRight:SetParent(PlayerFrame.PlayerFrameContainer)

	PlayerFrame.Background = PlayerFrame:CreateTexture(nil, "ARTWORK");
	PlayerFrame.Background:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", 86, -26);
	PlayerFrame.Background:SetSize(119, 41)
	PlayerFrame.Background:SetColorTexture(0, 0, 0, 0.5)

	local attackIconGlow = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:CreateTexture(nil, "ARTWORK")
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIconGlow = attackIconGlow;
	attackIconGlow:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	attackIconGlow:SetTexCoord(0.5, 1.0, 0.5, 1)
	attackIconGlow:SetBlendMode("ADD")
	attackIconGlow:SetSize(32, 32)
	attackIconGlow:ClearAllPoints();
	attackIconGlow:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -9, 12)

	local function RunOncePlayer()
		if (not ranOnce) then
			ranOnce = true
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture);
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigeBadge)
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait)
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon)
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.ManaBarMask)
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.HealthBarMask)
			PermaHide(PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.PlayerFrameHealthBarAnimatedLoss)
			PermaHide(PlayerFrameManaBar.FeedbackFrame)
			PermaHide(PlayerFrame.threatIndicator)
			if (GetCVar("comboPointLocation") == "1") then
				PermaHide(ComboPointPlayerFrame)
			end
		end
	end

	local function HookBars(frameToHook, colorHook, hookColor)
		updateBarTexture(frameToHook);
		colorHook(frameToHook);
		hooksecurefunc(frameToHook, "SetStatusBarTexture", updateBarTexture)
		if (hookColor) then
			hooksecurefunc(frameToHook, "SetStatusBarColor", colorHook)
		end
	end

	HookBars(PlayerFrameHealthBar, updateBarColor)
	HookBars(PlayerFrameManaBar, updateManaBarColor, true)

	hooksecurefunc("PlayerFrame_ToPlayerArt", function()
		RunOncePlayer()
		PlayerFrameHealthBar:SetSize(119, 12);
		PlayerFrameHealthBar:SetPoint("TOPLEFT", 88, -46);

		PlayerFrameManaBar:SetSize(119, 12);
		PlayerFrameManaBar:SetPoint("TOPLEFT", 88, -57);
	 end)

	 hooksecurefunc("PlayerFrame_UpdatePlayerNameTextAnchor", function()
		PlayerName:ClearAllPoints()
		PlayerName:SetJustifyH("CENTER")
		PlayerName:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContainer, "TOPLEFT", 98, -31)
	 end)

	 hooksecurefunc("PlayerFrame_UpdateLevel", function()
		PlayerLevelText:ClearAllPoints();
		PlayerLevelText:SetPoint("CENTER", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual, "CENTER", -81, -22)
		PlayerLevelText:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
		PlayerHitIndicator:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
	 end)

	 hooksecurefunc("PlayerFrame_UpdateRolesAssigned", function()
		local roleIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon;
		local role =  UnitGroupRolesAssigned("player");
		local hasIcon = false;

		roleIcon:SetSize(19, 19)
		roleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
		roleIcon:ClearAllPoints();
		roleIcon:SetPoint("TOPLEFT", 75, -20)
		if ( role == "TANK" or role == "HEALER" or role == "DAMAGER") then
			roleIcon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role));
			hasIcon = true
		end

		roleIcon:SetShown(hasIcon);
		PlayerLevelText:SetShown(true);
		PlayerFrame_UpdateStatus()
	 end)

	local function holyPower(self)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", 10, 15)
	end
	local function alternatePower(self)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", 30, 5)
	end
	hooksecurefunc("AlternatePowerBar_OnEvent", alternatePower)
	PaladinPowerBarFrame:HookScript("OnEvent", holyPower)

	hooksecurefunc("PlayerFrame_UpdateStatus", function()
		local attackIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIcon;
		local attackIconGlow = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIconGlow;
		local restIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RestIcon;
		local restLoop = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerRestLoop;
		restLoop:Hide();

		if (restIcon == nil) then
			PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RestIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:CreateTexture(nil, "OVERLAY")
			restIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RestIcon
		end

		attackIcon:SetDrawLayer("ARTWORK", 1)
		attackIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
		attackIcon:SetTexCoord(0.5, 1.0, 0, 0.5)
		attackIcon:SetSize(32, 32)
		attackIcon:ClearAllPoints();
		attackIcon:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -9, 12)

		restIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
		restIcon:SetTexCoord(0, 0.5, 0, 0.421875)
		restIcon:SetSize(31, 33)
		restIcon:ClearAllPoints();
		restIcon:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -9, 12)

		PlayerFrame.inCombat = UnitAffectingCombat("player")
		if (IsResting()) then
			restIcon:Show()

			attackIcon:Hide()
			attackIconGlow:Hide()
			PlayerLevelText:Hide()
		elseif (PlayerFrame.inCombat) then
			attackIcon:Show()
			attackIconGlow:Show()

			PlayerLevelText:Hide()
			restIcon:Hide()
		else
			PlayerLevelText:Show()

			attackIcon:Hide()
			attackIconGlow:Hide()
			restIcon:Hide()
		end
	end)

	hooksecurefunc("PlayerFrame_UpdatePartyLeader", function()
		local leaderIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.LeaderIcon;
		leaderIcon:ClearAllPoints()
		leaderIcon:SetPoint("TOPLEFT", 22, -18)
	end)

	if (IsAddOnLoaded("BigDebuffs")) then
		hooksecurefunc(BigDebuffs, "UNIT_AURA", function(self, unit) 
			local frame = self.UnitFrames[unit]
	   		 if not frame then return end
			 if frame.mask then
				if frame.unit == "player" then
					frame.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
				end
			 end
		end)
	end

	-- [PetFrame]
    local function PetFrame_OnEvent()
    	local powerColor = GetPowerBarColor(UnitPowerType(PetFrame.unit))
    	PetFrame:ClearAllPoints()
    	PetFrame:SetSize(128, 53)
    	PetFrame:SetPoint("TOPLEFT", PlayerFrame, 40, -97)
    	PetFrame:SetHitRectInsets(7, 66, 6, 7)
    	PetFrameFlash:ClearAllPoints()
    	PetFrameFlash:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash")
    	PetFrameFlash:SetSize(128, 64)
    	PetFrameFlash:SetPoint("TOPLEFT", PetFrame, "TOPLEFT", -4, 11)
    	PetFrameFlash:SetTexCoord(0, 1, 1, 0)
    	PetFrameTexture:ClearAllPoints()
		PetFrameTexture:SetPoint("TOPLEFT", PlayerFrame, 40, -97)
		PetFrameTexture:SetSize(128, 64)
		PetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-SmallTargetingFrame")
		PetFrameTexture:SetDrawLayer("OVERLAY", 0)
		PetPortrait:SetSize(37, 37)
		PetFrameHealthBar:SetFrameLevel(3)
		PetFrameHealthBar:SetSize(69, 8)
		PetFrameHealthBar:SetPoint("TOPLEFT", PetFrame, 47, -22)
		PetFrameHealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		PetFrameHealthBar:SetStatusBarColor(0, 1, 0)
		PetFrameManaBar:SetFrameLevel(3)
		PetFrameManaBar:SetSize(71, 8)
		PetFrameManaBar:SetPoint("TOPLEFT", PetFrame, 46, -29)
		PetFrameManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		PetFrameManaBar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
		PetName:ClearAllPoints()
		PetName:SetPoint("BOTTOMLEFT", PetFrame, 52, 35)
    end

    self.EventFrame = CreateFrame("Frame")
    self.EventFrame:RegisterEvent("PET_UI_UPDATE")
    self.EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.EventFrame:RegisterUnitEvent("UNIT_PET", "player");
    self.EventFrame:SetScript("OnEvent", PetFrame_OnEvent)

	-- [TargetFrame]
	ApplyFrame(TargetFrame)

	-- [FocusFrame]
	ApplyFrame(FocusFrame)
end

-- Main function that modifies the additional frames that RazerNagaUI handles
function RazerNagaUI:ExtraFramesFunc(isLogin)
	if (isLogin) then
		RazerNagaUI.OnEvent_PEW_eff = true
		if (not RazerNagaUI.frame:IsEventRegistered("PLAYER_ENTERING_WORLD")) then
			RazerNagaUI.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	else
		RazerNagaUI:EFF_PLAYER_ENTERING_WORLD()
	end
end

-- Function to manage the PLAYER_ENTERING_WORLD event. Here we do modifications to interface elements that may not have been fully loaded before this event.
function RazerNagaUI:PLAYER_ENTERING_WORLD()
	RazerNagaUI.frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if (RazerNagaUI.OnEvent_PEW_eff) then
		RazerNagaUI.OnEvent_PEW_eff = false
		RazerNagaUI:EFF_PLAYER_ENTERING_WORLD()
	end
end