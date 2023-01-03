--[[
	classicUI.lua
		restores some old UI elements
--]]

ClassicUI = LibStub("AceAddon-3.0"):NewAddon("ClassicUI", "AceConsole-3.0")

local AceDB = LibStub("AceDB-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")

ClassicUI.frame = ClassicUI.frame or CreateFrame("Frame", "ClassicUIFrame")

function ClassicUI:OnEvent(event, ...) -- functions created in "object:method"-style have an implicit first parameter of "self", which points to object
	ClassicUI[event](ClassicUI, ...) -- route event parameters to ClassicUI:event methods
end
ClassicUI.frame:SetScript("OnEvent", ClassicUI.OnEvent)

local _G = _G
local _
local STANDARD_EPSILON = 0.001
local SCALE_EPSILON = 0.001
local strformat = string.format
local type = type
local pairs = pairs
local SetPortraitTexture = SetPortraitTexture
local ActionBarController_GetCurrentActionBarState = ActionBarController_GetCurrentActionBarState
local BNConnected = BNConnected
local C_DateAndTime_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local C_Club_IsEnabled = C_Club.IsEnabled
local C_Club_IsRestricted = C_Club.IsRestricted
local C_Container_GetContainerNumFreeSlots = C_Container.GetContainerNumFreeSlots
local ContainerFrame_IsReagentBag = ContainerFrame_IsReagentBag
local Kiosk_IsEnabled = Kiosk.IsEnabled
local UIFrameFlashStop = UIFrameFlashStop
local UnitFactionGroup = UnitFactionGroup
local GetFileStreamingStatus = GetFileStreamingStatus
local GetBackgroundLoadingStatus = GetBackgroundLoadingStatus
local IsCommunitiesUIDisabledByTrialAccount = IsCommunitiesUIDisabledByTrialAccount
local GetDifficultyInfo = GetDifficultyInfo
local GetInstanceInfo = GetInstanceInfo
local GetLFGDungeonInfo = GetLFGDungeonInfo
local GetGuildInfo = GetGuildInfo
local InGuildParty = InGuildParty

-- Cache variables
ClassicUI.cached_db_profile = { }

-- Default settings
ClassicUI.defaults = {
	profile = {
		enabled = true,
		barsConfig = {
			['**'] = {
				xOffset = 0,
				yOffset = 0
			},
			['MicroButtons'] = {
				scale = 1,
				useClassicQuestIcon = false,
				useClassicGuildIcon = false,
				useBiggerGuildEmblem = false,
				useClassicMainMenuIcon = false
			},
			['BagsIcons'] = {
				iconBorderAlpha = 1,
				xOffsetReagentBag = 0,
				yOffsetReagentBag = 0
			},
		},
		extraFrames = {
			['Minimap'] = {
				enabled = false,
				xOffset = 0,
				yOffset = 0,
				scale = 1,
				anchorQueueButtonToMinimap = true,
				xOffsetQueueButton = 0,
				yOffsetQueueButton = 0,
				bigQueueButton = false
			},
			['Bags'] = {
				freeSlotCounterMod = 0,		-- 0 = AllItems (default), 1 = AllItems-ReagentItems (addon default), 2 = NormalItems and ReagentItems in two different numbers
				xOffsetFreeSlotsCounter = 0,
				yOffsetFreeSlotsCounter = 0
			}
		},
	}
}

-- First function fired
function ClassicUI:OnInitialize()
	self.db = AceDB:New("ClassicUI_DB", self.defaults, true)
	self:MainFunction(true)
	self:ExtraFramesFunc(true)
end

-- Function that sets the LFG button icon (QueueStatusButton) to a smaller size similar to the classic LFG button
function ClassicUI:QueueButtonSetSmallSize()
	QueueStatusButton:SetSize(33, 33)
	QueueStatusButtonIcon.texture:SetSize(29, 29)
	QueueStatusButtonIcon.EyeInitial.EyeInitialTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyeMouseOver.EyeMouseOverTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyeFoundInitial.EyeFoundInitialTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyeFoundLoop.EyeFoundLoopTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyePokeInitial.EyePokeInitialTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyePokeLoop.EyePokeLoopTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyePokeEnd.EyePokeEndTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyeSearchingLoop.EyeSearchingTexture:SetSize(30, 30)
	QueueStatusButtonIcon.EyeInitial.CircShine:SetSize(28, 28)
	QueueStatusButtonIcon.EyeFoundInitial.SpriteShards:SetSize(51, 51)
	QueueStatusButtonIcon.EyeInitial.GlowFront:SetSize(34, 34)
	QueueStatusButtonIcon.EyeInitial.GlowBack:SetSize(56, 56)
	QueueStatusButtonIcon.EyeFoundInitial.GlowFront:SetSize(34, 34)
	QueueStatusButtonIcon.EyeFoundInitial.GlowBack:SetSize(56, 56)
	QueueStatusButtonIcon.GlowBackLoop.GlowBack:SetSize(56, 56)
end

-- Function that modifies the behavior of the free slots counter in the bag
function ClassicUI:BagsFreeSlotsCounterMod()
	if (ClassicUI.cached_db_profile.extraFrames_Bags_freeSlotCounterMod == 2) then	-- cached db value
		ClassicUI.BACKPACK_FREESLOTS_FORMAT = "(%s+%s)"
	else
		ClassicUI.BACKPACK_FREESLOTS_FORMAT = "(%s)"
	end
	if not ClassicUI.hooked_MainMenuBarBackpackButton_UpdateFreeSlots then
		ClassicUI.MainMenuBarBackpackButton_UpdateFreeSlots = function(self)
			if (ClassicUI.cached_db_profile.extraFrames_Bags_freeSlotCounterMod == 1) then	-- cached db value
				local totalFree, freeSlots, bagFamily = 0
				for i = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					if not(ContainerFrame_IsReagentBag(i)) then
						freeSlots, bagFamily = C_Container_GetContainerNumFreeSlots(i)
						if (bagFamily == 0) then
							totalFree = totalFree + freeSlots
						end
					end
				end
				self.Count:SetText(ClassicUI.BACKPACK_FREESLOTS_FORMAT:format(totalFree))
			elseif (ClassicUI.cached_db_profile.extraFrames_Bags_freeSlotCounterMod == 2) then	-- cached db value
				local totalFree, freeSlots, bagFamily = 0
				local reagentFree = 0
				for i = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
					freeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(i)
					if (bagFamily == 0) then
						if not(ContainerFrame_IsReagentBag(i)) then
							totalFree = totalFree + freeSlots
						else
							reagentFree = reagentFree + freeSlots
						end
					end
				end
				self.Count:SetText(ClassicUI.BACKPACK_FREESLOTS_FORMAT:format(totalFree, reagentFree))
			end
		end
		hooksecurefunc(MainMenuBarBackpackButton, "UpdateFreeSlots", ClassicUI.MainMenuBarBackpackButton_UpdateFreeSlots)
		ClassicUI.hooked_MainMenuBarBackpackButton_UpdateFreeSlots = true
	end
	if (ClassicUI.cached_db_profile.extraFrames_Bags_freeSlotCounterMod ~= 0) then	-- cached db value
		ClassicUI.MainMenuBarBackpackButton_UpdateFreeSlots(MainMenuBarBackpackButton)
	else
		local freeBagSlots = CalculateTotalNumberOfFreeBagSlots()
		MainMenuBarBackpackButton:UpdateFreeSlots()
		MainMenuBarBackpackButton.Count:SetText(ClassicUI.BACKPACK_FREESLOTS_FORMAT:format(freeBagSlots))
	end
end

-- Function that executes functionalities of the 'ExtraFramesFunc' function that need to be executed after the first "PLAYER_ENTERING_WORLD" event
function ClassicUI:EFF_PLAYER_ENTERING_WORLD()
	-- [Minimap]
	if (ClassicUI.db.profile.extraFrames.Minimap.enabled) then
		ClassicUI:EnableOldMinimap()
	end
	
	-- [QueueStatusButton]
	if (ClassicUI.db.profile.extraFrames.Minimap.anchorQueueButtonToMinimap) then
		QueueStatusButton:SetParent(MinimapBackdrop)
		QueueStatusButton:ClearAllPoints()
		if (ClassicUI.db.profile.extraFrames.Minimap.enabled) then
			QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 22 + ClassicUI.db.profile.extraFrames.Minimap.xOffsetQueueButton, -100 + ClassicUI.db.profile.extraFrames.Minimap.yOffsetQueueButton)
		else
			QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", -7 + ClassicUI.db.profile.extraFrames.Minimap.xOffsetQueueButton, -135 + ClassicUI.db.profile.extraFrames.Minimap.yOffsetQueueButton)
		end
		QueueStatusButton:SetFrameStrata("LOW")
		QueueStatusButton:SetFrameLevel(5)
		ClassicUI:QueueButtonSetSmallSize()
	else
		if (ClassicUI:IsEnabled()) then
			QueueStatusButton:SetParent(UIParent)
		end
	end
	
	-- [Bags]
	if (ClassicUI.db.profile.extraFrames.Bags.freeSlotCounterMod ~= 0) then
		ClassicUI:BagsFreeSlotsCounterMod()
	end
	if (ClassicUI.db.profile.extraFrames.Bags.xOffsetFreeSlotsCounter ~= 0) or (ClassicUI.db.profile.extraFrames.Bags.yOffsetFreeSlotsCounter ~= 0) then
		MainMenuBarBackpackButton.Count:ClearAllPoints()
		MainMenuBarBackpackButton.Count:SetPoint("CENTER", MainMenuBarBackpackButton, "CENTER", 0 + ClassicUI.db.profile.extraFrames.Bags.xOffsetFreeSlotsCounter, -10 + ClassicUI.db.profile.extraFrames.Bags.yOffsetFreeSlotsCounter)
	end
end

-- Main function that modifies the additional frames that ClassicUI handles
function ClassicUI:ExtraFramesFunc(isLogin)
	if (isLogin) then
		ClassicUI.OnEvent_PEW_eff = true
		if (not ClassicUI.frame:IsEventRegistered("PLAYER_ENTERING_WORLD")) then
			ClassicUI.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
		end
	else
		ClassicUI:EFF_PLAYER_ENTERING_WORLD()
	end
end

-- Function that performs all the necessary modifications in the interface to bring back the old Minimap
function ClassicUI:EnableOldMinimap()
	MinimapCluster:SetSize(192, 192)
	MinimapCluster:SetHitRectInsets(30, 10, 0, 30)
	MinimapCluster:SetScale(self.db.profile.extraFrames.Minimap.scale)
	MinimapCluster:ClearAllPoints()
	MinimapCluster:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", self.db.profile.extraFrames.Minimap.xOffset, self.db.profile.extraFrames.Minimap.yOffset)
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
		ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 36, -122)
	end)
	ExpansionLandingPageMinimapButton:ClearAllPoints()
	ExpansionLandingPageMinimapButton:SetSize(44, 44)
	ExpansionLandingPageMinimapButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 36, -122)
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
	
	local CUI_MiniMapInstanceDifficulty = CreateFrame("Frame", "CUI_MiniMapInstanceDifficulty", MinimapCluster)
	CUI_MiniMapInstanceDifficulty:SetFrameStrata("LOW")
	CUI_MiniMapInstanceDifficulty:SetFrameLevel(11)
	CUI_MiniMapInstanceDifficulty:SetSize(38, 46)
	CUI_MiniMapInstanceDifficulty:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 22, -17)
	CUI_MiniMapInstanceDifficulty:Hide()
	local CUI_MiniMapInstanceDifficultyTexture = CUI_MiniMapInstanceDifficulty:CreateTexture("CUI_MiniMapInstanceDifficultyTexture", "ARTWORK")
	CUI_MiniMapInstanceDifficultyTexture:SetSize(64, 46)
	CUI_MiniMapInstanceDifficultyTexture:SetTexture("Interface\\Minimap\\UI-DungeonDifficulty-Button")
	CUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4140625)
	CUI_MiniMapInstanceDifficultyTexture:SetPoint("CENTER", CUI_MiniMapInstanceDifficulty, "CENTER", 0, 0)
	local CUI_MiniMapInstanceDifficultyText = CUI_MiniMapInstanceDifficulty:CreateFontString("CUI_MiniMapInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
	CUI_MiniMapInstanceDifficultyText:SetJustifyH("CENTER")
	CUI_MiniMapInstanceDifficultyText:SetJustifyV("MIDDLE")
	CUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", CUI_MiniMapInstanceDifficulty, "CENTER", -1, -7)
	
	local CUI_GuildInstanceDifficulty = CreateFrame("Frame", "CUI_GuildInstanceDifficulty", MinimapCluster)
	CUI_GuildInstanceDifficulty:SetFrameStrata("LOW")
	CUI_GuildInstanceDifficulty:SetFrameLevel(11)
	CUI_GuildInstanceDifficulty:SetSize(38, 46)
	CUI_GuildInstanceDifficulty:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 22, -17)
	CUI_GuildInstanceDifficulty:Hide()
	local CUI_GuildInstanceDifficultyBackground = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyBackground", "BACKGROUND")
	CUI_GuildInstanceDifficulty.background = CUI_GuildInstanceDifficultyBackground
	CUI_GuildInstanceDifficultyBackground:SetSize(41, 53)
	CUI_GuildInstanceDifficultyBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyBackground:SetTexCoord(0.0078125, 0.328125, 0.015625, 0.84375)
	CUI_GuildInstanceDifficultyBackground:SetPoint("TOPLEFT", CUI_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
	local CUI_GuildInstanceDifficultyDarkBackground = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyDarkBackground", "BORDER")
	CUI_GuildInstanceDifficultyDarkBackground:SetSize(30, 21)
	CUI_GuildInstanceDifficultyDarkBackground:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyDarkBackground:SetTexCoord(0.6796875, 0.9140625, 0.015625, 0.34375)
	CUI_GuildInstanceDifficultyDarkBackground:SetPoint("BOTTOM", CUI_GuildInstanceDifficultyBackground, "BOTTOM", 0, 7)
	CUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
	local CUI_GuildInstanceDifficultyEmblem = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyEmblem", "ARTWORK")
	CUI_GuildInstanceDifficulty.emblem = CUI_GuildInstanceDifficultyEmblem
	CUI_GuildInstanceDifficultyEmblem:SetSize(16, 16)
	CUI_GuildInstanceDifficultyEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
	CUI_GuildInstanceDifficultyEmblem:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	CUI_GuildInstanceDifficultyEmblem:SetPoint("TOPLEFT", CUI_GuildInstanceDifficulty, "TOPLEFT", 12, -10)
	local CUI_GuildInstanceDifficultyBorder = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyBorder", "ARTWORK")
	CUI_GuildInstanceDifficulty.border = CUI_GuildInstanceDifficultyBorder
	CUI_GuildInstanceDifficultyBorder:SetSize(41, 53)
	CUI_GuildInstanceDifficultyBorder:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyBorder:SetTexCoord(0.34375, 0.6640625, 0.015625, 0.84375)
	CUI_GuildInstanceDifficultyBorder:SetPoint("BOTTOMLEFT", CUI_GuildInstanceDifficulty, "BOTTOMLEFT", 0, 0)
	local CUI_GuildInstanceDifficultyHeroicTexture = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyHeroicTexture", "ARTWORK")
	CUI_GuildInstanceDifficultyHeroicTexture:SetSize(12, 13)
	CUI_GuildInstanceDifficultyHeroicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyHeroicTexture:SetTexCoord(0.6796875, 0.7734375, 0.65625, 0.859375)
	CUI_GuildInstanceDifficultyHeroicTexture:SetPoint("BOTTOMLEFT", CUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local CUI_GuildInstanceDifficultyMythicTexture = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyMythicTexture", "ARTWORK")
	CUI_GuildInstanceDifficultyMythicTexture:SetSize(12, 13)
	CUI_GuildInstanceDifficultyMythicTexture:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyMythicTexture:SetTexCoord(0.7734375, 0.8671875, 0.65625, 0.859375)
	CUI_GuildInstanceDifficultyMythicTexture:SetPoint("BOTTOMLEFT", CUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local CUI_GuildInstanceDifficultyChallengeModeTexture = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyChallengeModeTexture", "ARTWORK")
	CUI_GuildInstanceDifficultyChallengeModeTexture:SetSize(12, 12)
	CUI_GuildInstanceDifficultyChallengeModeTexture:SetTexture("Interface\\Common\\mini-hourglass")
	CUI_GuildInstanceDifficultyChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	CUI_GuildInstanceDifficultyChallengeModeTexture:SetPoint("BOTTOMLEFT", CUI_GuildInstanceDifficulty, "BOTTOMLEFT", 8, 7)
	local CUI_GuildInstanceDifficultyText = CUI_GuildInstanceDifficulty:CreateFontString("CUI_GuildInstanceDifficultyText", "ARTWORK", "GameFontNormalSmall")
	CUI_GuildInstanceDifficultyText:SetJustifyH("CENTER")
	CUI_GuildInstanceDifficultyText:SetJustifyV("MIDDLE")
	CUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", CUI_GuildInstanceDifficulty, "BOTTOMLEFT", 20, 8)
	CUI_GuildInstanceDifficultyText:SetText("25")
	local CUI_GuildInstanceDifficultyHanger = CUI_GuildInstanceDifficulty:CreateTexture("CUI_GuildInstanceDifficultyHanger", "OVERLAY")
	CUI_GuildInstanceDifficultyHanger:SetSize(39, 16)
	CUI_GuildInstanceDifficultyHanger:SetTexture("Interface\\GuildFrame\\GuildDifficulty")
	CUI_GuildInstanceDifficultyHanger:SetTexCoord(0.6796875, 0.984375, 0.375, 0.625)
	CUI_GuildInstanceDifficultyHanger:SetPoint("TOPLEFT", CUI_GuildInstanceDifficulty, "TOPLEFT", 0, 0)
	
	local CUI_MiniMapChallengeMode = CreateFrame("Frame", "CUI_MiniMapChallengeMode", MinimapCluster)
	CUI_MiniMapChallengeMode:SetFrameStrata("LOW")
	CUI_MiniMapChallengeMode:SetFrameLevel(11)
	CUI_MiniMapChallengeMode:SetSize(27, 36)
	CUI_MiniMapChallengeMode:SetPoint("TOPLEFT", MinimapCluster, "TOPLEFT", 28, -23)
	CUI_MiniMapChallengeMode:Hide()
	local CUI_MiniMapChallengeModeTexture = CUI_MiniMapChallengeMode:CreateTexture("CUI_MiniMapChallengeModeTexture", "BACKGROUND")
	CUI_MiniMapChallengeModeTexture:SetSize(64, 46)
	CUI_MiniMapChallengeModeTexture:SetTexture("Interface\\Challenges\\challenges-minimap-banner")
	CUI_MiniMapChallengeModeTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	CUI_MiniMapChallengeModeTexture:SetPoint("CENTER", CUI_MiniMapChallengeMode, "CENTER", 0, 0)
	
	CUI_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
	CUI_MiniMapInstanceDifficulty:RegisterEvent("INSTANCE_GROUP_SIZE_CHANGED")
	CUI_MiniMapInstanceDifficulty:RegisterEvent("UPDATE_INSTANCE_INFO")
	CUI_MiniMapInstanceDifficulty:RegisterEvent("PLAYER_GUILD_UPDATE")
	CUI_MiniMapInstanceDifficulty:RegisterEvent("GUILD_PARTY_STATE_UPDATED")
	
	function CUI_MiniMapInstanceDifficulty:MiniMapInstanceDifficulty_Update()
		local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance, _, instanceGroupSize = GetInstanceInfo()
		local _, _, isHeroic, isChallengeMode, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
		if ( self.isGuildGroup ) then
			if ( instanceGroupSize == 0 ) then
				CUI_GuildInstanceDifficultyText:SetText("")
				CUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0)
				CUI_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -16)
			else
				CUI_GuildInstanceDifficultyText:SetText(instanceGroupSize)
				CUI_GuildInstanceDifficultyDarkBackground:SetAlpha(0.7)
				CUI_GuildInstanceDifficulty.emblem:SetPoint("TOPLEFT", 12, -10)
			end
			CUI_GuildInstanceDifficultyText:ClearAllPoints()
			if ( isHeroic or isChallengeMode or displayMythic or displayHeroic ) then
				local symbolTexture
				if ( isChallengeMode ) then
					symbolTexture = CUI_GuildInstanceDifficultyChallengeModeTexture
					CUI_GuildInstanceDifficultyHeroicTexture:Hide()
					CUI_GuildInstanceDifficultyMythicTexture:Hide()
				elseif ( displayMythic ) then
					symbolTexture = CUI_GuildInstanceDifficultyMythicTexture
					CUI_GuildInstanceDifficultyHeroicTexture:Hide()
					CUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
				else
					symbolTexture = CUI_GuildInstanceDifficultyHeroicTexture
					CUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
					CUI_GuildInstanceDifficultyMythicTexture:Hide()
				end
				if ( instanceGroupSize < 10 ) then
					symbolTexture:SetPoint("BOTTOMLEFT", 11, 7)
					CUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 23, 8)
				elseif ( instanceGroupSize > 19 ) then
					symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
					CUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 20, 8)
				else
					symbolTexture:SetPoint("BOTTOMLEFT", 8, 7)
					CUI_GuildInstanceDifficultyText:SetPoint("BOTTOMLEFT", 19, 8)
				end
				symbolTexture:Show()
			else
				CUI_GuildInstanceDifficultyHeroicTexture:Hide()
				CUI_GuildInstanceDifficultyChallengeModeTexture:Hide()
				CUI_GuildInstanceDifficultyMythicTexture:Hide()
				CUI_GuildInstanceDifficultyText:SetPoint("BOTTOM", 2, 8)
			end
			self:Hide()
			SetSmallGuildTabardTextures("player", CUI_GuildInstanceDifficulty.emblem, CUI_GuildInstanceDifficulty.background, CUI_GuildInstanceDifficulty.border)
			CUI_GuildInstanceDifficulty:Show()
			CUI_MiniMapChallengeMode:Hide()
		elseif ( isChallengeMode ) then
			CUI_MiniMapChallengeMode:Show()
			self:Hide()
			CUI_GuildInstanceDifficulty:Hide()
		elseif ( instanceType == "raid" or isHeroic or displayMythic or displayHeroic ) then
			CUI_MiniMapInstanceDifficultyText:SetText(instanceGroupSize)
			local xOffset = 0
			if ( instanceGroupSize >= 10 and instanceGroupSize <= 19 ) then
				xOffset = -1
			end
			if ( displayMythic ) then
				CUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0.25, 0.5, 0.0703125, 0.4296875)
				CUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -9)
			elseif ( isHeroic or displayHeroic ) then
				CUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.0703125, 0.4296875)
				CUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, -9)
			else
				CUI_MiniMapInstanceDifficultyTexture:SetTexCoord(0, 0.25, 0.5703125, 0.9296875)
				CUI_MiniMapInstanceDifficultyText:SetPoint("CENTER", xOffset, 5)
			end
			self:Show()
			CUI_GuildInstanceDifficulty:Hide()
			CUI_MiniMapChallengeMode:Hide()
		else
			self:Hide()
			CUI_GuildInstanceDifficulty:Hide()
			CUI_MiniMapChallengeMode:Hide()
		end
	end
	CUI_MiniMapInstanceDifficulty:SetScript("OnEvent", function(self, event, ...)
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
			local tabard = CUI_GuildInstanceDifficulty
			SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background, tabard.border)
			if not( IsInGuild() ) then
				self.isGuildGroup = nil
				self:MiniMapInstanceDifficulty_Update()
			end
		end
	end)
	CUI_MiniMapInstanceDifficulty:SetScript("OnEnter", function(self)
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
	CUI_MiniMapInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
	
	CUI_GuildInstanceDifficulty:SetScript("OnEnter", function(self)
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
	CUI_GuildInstanceDifficulty:SetScript("OnLeave", GameTooltip_Hide)
	
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
	MinimapBorderTop:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", ClassicUI.db.profile.extraFrames.Minimap.xOffset, ClassicUI.db.profile.extraFrames.Minimap.yOffset)
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
	
	ClassicUI.Minimap_SetTooltip = function(pvpType, factionName)
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
	hooksecurefunc("Minimap_SetTooltip", ClassicUI.Minimap_SetTooltip)
	MinimapZoneTextButton:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		local pvpType, _, factionName = GetZonePVPInfo()
		ClassicUI.Minimap_SetTooltip(pvpType, factionName)
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
end

-- Function that executes functionalities of the 'MainFunction' function that need to be executed after the first "PLAYER_ENTERING_WORLD" event
function ClassicUI:MF_PLAYER_ENTERING_WORLD()
	
	-- [QueueStatusButton]
	if (ClassicUI.db.profile.extraFrames.Minimap.anchorQueueButtonToMinimap) then
		QueueStatusButton:SetParent(MinimapBackdrop)
		QueueStatusButton:SetFrameStrata("LOW")
		QueueStatusButton:SetFrameLevel(5)
		if (ClassicUI.db.profile.extraFrames.Minimap.enabled) then
			QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 22 + ClassicUI.db.profile.extraFrames.Minimap.xOffsetQueueButton, -100 + ClassicUI.db.profile.extraFrames.Minimap.yOffsetQueueButton)
		else
			QueueStatusButton:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", -7 + ClassicUI.db.profile.extraFrames.Minimap.xOffsetQueueButton, -135 + ClassicUI.db.profile.extraFrames.Minimap.yOffsetQueueButton)
		end
	else
		QueueStatusButton:SetParent(UIParent)
		QueueStatusButton:SetFrameStrata("MEDIUM")
		QueueStatusButton:SetFrameLevel(53)
		QueueStatusButton:SetPoint("BOTTOMLEFT", MicroButtonAndBagsBar, "BOTTOMLEFT", -45 + ClassicUI.db.profile.extraFrames.Minimap.xOffsetQueueButton, 4 + ClassicUI.db.profile.extraFrames.Minimap.yOffsetQueueButton)
	end
end

-- Function to manage the PLAYER_ENTERING_WORLD event. Here we do modifications to interface elements that may not have been fully loaded before this event.
function ClassicUI:PLAYER_ENTERING_WORLD()
	ClassicUI.frame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	if (ClassicUI.OnEvent_PEW_mf) then
		ClassicUI.OnEvent_PEW_mf = false
		ClassicUI:MF_PLAYER_ENTERING_WORLD()
	end
	if (ClassicUI.OnEvent_PEW_eff) then
		ClassicUI.OnEvent_PEW_eff = false
		ClassicUI:EFF_PLAYER_ENTERING_WORLD()
	end
end

-- Main function that loads the core features of ClassicUI. This function at the end calls to 'ClassicUI:PLAYER_ENTERING_WORLD()'.
function ClassicUI:MainFunction(isLogin)
	-- hide the buff expand toggle
	hooksecurefunc(BuffFrame, "RefreshCollapseExpandButtonState", function(self)
		self.CollapseAndExpandButton:Hide()
	end)
	ClassicUI.hooked_BuffFrame_RefreshCollapseExpandButtonState = true
	BuffFrame.CollapseAndExpandButton:Hide()
	
	-- [MicroButtons]
	ClassicUI.mbWidth = 28
	ClassicUI.mbHeight = 38
	ClassicUI.MicroButtonsGroup = {
		[CharacterMicroButton] = 1,
		[SpellbookMicroButton] = 2,
		[TalentMicroButton] = 3,
		[AchievementMicroButton] = 4,
		[QuestLogMicroButton] = 5,
		[GuildMicroButton] = 6,
		[LFDMicroButton] = 7,
		[CollectionsMicroButton] = 8,
		[EJMicroButton] = 9,
		[StoreMicroButton] = 10,
		[MainMenuMicroButton] = 11
	}
	
	-- [MicroButtons] CharacterMicroButton
	CharacterMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	CharacterMicroButton:SetPoint("BOTTOMLEFT", 556 + ClassicUI.db.profile.barsConfig.MicroButtons.xOffset, 2 + ClassicUI.db.profile.barsConfig.MicroButtons.yOffset)
	CharacterMicroButton:SetFrameStrata("MEDIUM")
	CharacterMicroButton:SetFrameLevel(3)
	CharacterMicroButton:SetNormalAtlas("hud-microbutton-Character-Up", true)
	CharacterMicroButton:SetPushedAtlas("hud-microbutton-Character-Down", true)
	CharacterMicroButton:SetDisabledAtlas("hud-microbutton-Character-Disabled", true)
	CharacterMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	CharacterMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
	CharacterMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
	CharacterMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	CharacterMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Disabled")
	CharacterMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CharacterMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CharacterMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CharacterMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CharacterMicroButton.FlashBorder:SetSize(34, 44)
	CharacterMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] CharacterMicroButton -> Portrait texture
	local CUI_MicroButtonPortrait = CharacterMicroButton:CreateTexture("CUI_MicroButtonPortrait")
	CUI_MicroButtonPortrait:SetPoint("TOP", CharacterMicroButton, "TOP", 0, -7)
	CUI_MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
	CUI_MicroButtonPortrait:SetAlpha(1)
	CUI_MicroButtonPortrait:SetSize(18, 25)
	CUI_MicroButtonPortrait:SetDrawLayer("OVERLAY", 0)
	hooksecurefunc(CharacterMicroButton, "SetPushed", function(self)
		CUI_MicroButtonPortrait:SetTexCoord(0.2666, 0.8666, 0, 0.8333)
		CUI_MicroButtonPortrait:SetAlpha(0.5)
	end)
	hooksecurefunc(CharacterMicroButton, "SetNormal", function(self)
		CUI_MicroButtonPortrait:SetTexCoord(0.2, 0.8, 0.0666, 0.9)
		CUI_MicroButtonPortrait:SetAlpha(1.0)
	end)
	CharacterMicroButton:HookScript("OnEvent", function(self, event, ...)
		if (event == "UNIT_PORTRAIT_UPDATE") then
			local unit = ...
			if (unit == "player") then
				SetPortraitTexture(CUI_MicroButtonPortrait, "player")
			end
		elseif (event == "PORTRAITS_UPDATED") then
			SetPortraitTexture(CUI_MicroButtonPortrait, "player")
		elseif (event == "PLAYER_ENTERING_WORLD") then
			SetPortraitTexture(CUI_MicroButtonPortrait, "player")
		end
	end)
	CharacterMicroButton:RegisterEvent("PLAYER_ENTERING_WORLD")
	CharacterMicroButton:RegisterEvent("UNIT_PORTRAIT_UPDATE")
	CharacterMicroButton:RegisterEvent("PORTRAITS_UPDATED")
	SetPortraitTexture(CUI_MicroButtonPortrait, "player")
	CUI_MicroButtonPortrait:Show()
	
	-- [MicroButtons] SpellbookMicroButton
	SpellbookMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	SpellbookMicroButton:SetPoint("BOTTOMLEFT", CharacterMicroButton, "BOTTOMRIGHT", -2, 0)
	SpellbookMicroButton:SetFrameStrata("MEDIUM")
	SpellbookMicroButton:SetFrameLevel(3)
	SpellbookMicroButton:SetNormalAtlas("hud-microbutton-Spellbook-Up", true)
	SpellbookMicroButton:SetPushedAtlas("hud-microbutton-Spellbook-Down", true)
	SpellbookMicroButton:SetDisabledAtlas("hud-microbutton-Spellbook-Disabled", true)
	SpellbookMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	SpellbookMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Up")
	SpellbookMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Down")
	SpellbookMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	SpellbookMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Spellbook-Disabled")
	SpellbookMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	SpellbookMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	SpellbookMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	SpellbookMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	SpellbookMicroButton.FlashBorder:SetSize(34, 44)
	SpellbookMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] TalentMicroButton
	TalentMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	TalentMicroButton:SetPoint("BOTTOMLEFT", SpellbookMicroButton, "BOTTOMRIGHT", -2, 0)
	TalentMicroButton:SetFrameStrata("MEDIUM")
	TalentMicroButton:SetFrameLevel(3)
	TalentMicroButton:SetNormalAtlas("hud-microbutton-Talents-Up", true)
	TalentMicroButton:SetPushedAtlas("hud-microbutton-Talents-Down", true)
	TalentMicroButton:SetDisabledAtlas("hud-microbutton-Talents-Disabled", true)
	TalentMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	TalentMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Talents-Up")
	TalentMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Talents-Down")
	TalentMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	TalentMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Talents-Disabled")
	TalentMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	TalentMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	TalentMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	TalentMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	TalentMicroButton.FlashBorder:SetSize(34, 44)
	TalentMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] AchievementMicroButton
	AchievementMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	AchievementMicroButton:SetPoint("BOTTOMLEFT", TalentMicroButton, "BOTTOMRIGHT", -2, 0)
	AchievementMicroButton:SetFrameStrata("MEDIUM")
	AchievementMicroButton:SetFrameLevel(3)
	AchievementMicroButton:SetNormalAtlas("hud-microbutton-Achievement-Up", true)
	AchievementMicroButton:SetPushedAtlas("hud-microbutton-Achievement-Down", true)
	AchievementMicroButton:SetDisabledAtlas("hud-microbutton-Achievement-Disabled", true)
	AchievementMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	AchievementMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Up")
	AchievementMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Down")
	AchievementMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	AchievementMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Achievement-Disabled")
	AchievementMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	AchievementMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	AchievementMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	AchievementMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	AchievementMicroButton.FlashBorder:SetSize(34, 44)
	AchievementMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] QuestLogMicroButton
	QuestLogMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	QuestLogMicroButton:SetPoint("BOTTOMLEFT", AchievementMicroButton, "BOTTOMRIGHT", -2, 0)
	QuestLogMicroButton:SetFrameStrata("MEDIUM")
	QuestLogMicroButton:SetFrameLevel(3)
	QuestLogMicroButton:SetNormalAtlas("hud-microbutton-Quest-Up", true)
	QuestLogMicroButton:SetPushedAtlas("hud-microbutton-Quest-Down", true)
	QuestLogMicroButton:SetDisabledAtlas("hud-microbutton-Quest-Disabled", true)
	QuestLogMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	if not(ClassicUI.db.profile.barsConfig.MicroButtons.useClassicQuestIcon) then
		QuestLogMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Quest-Up")
		QuestLogMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Quest-Down")
		QuestLogMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Quest-Disabled")
	else
		QuestLogMicroButton:SetNormalTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Quest-Up-classic")
		QuestLogMicroButton:SetPushedTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Quest-Down-classic")
		QuestLogMicroButton:SetDisabledTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Quest-Disabled-classic")
	end
	QuestLogMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	QuestLogMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	QuestLogMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	QuestLogMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	QuestLogMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	QuestLogMicroButton.FlashBorder:SetSize(34, 44)
	QuestLogMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] GuildMicroButton
	GuildMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	GuildMicroButton:SetPoint("BOTTOMLEFT", QuestLogMicroButton, "BOTTOMRIGHT", -2, 0)
	GuildMicroButton:SetFrameStrata("MEDIUM")
	GuildMicroButton:SetFrameLevel(3)
	GuildMicroButton:SetNormalAtlas("hud-microbutton-Socials-Up", true)
	GuildMicroButton:SetPushedAtlas("hud-microbutton-Socials-Down", true)
	GuildMicroButton:SetDisabledAtlas("hud-microbutton-Socials-Disabled", true)
	GuildMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	if not(ClassicUI.db.profile.barsConfig.MicroButtons.useClassicGuildIcon) then
		GuildMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up")
		GuildMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down")
		GuildMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled")
	else
		GuildMicroButton:SetNormalTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Socials-Up-classic")
		GuildMicroButton:SetPushedTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Socials-Down-classic")
		GuildMicroButton:SetDisabledTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-Socials-Disabled-classic")
	end
	GuildMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	GuildMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	GuildMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	GuildMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	GuildMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	GuildMicroButton.FlashBorder:SetSize(34, 44)
	GuildMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	GuildMicroButton.NotificationOverlay:SetFrameStrata("MEDIUM")
	GuildMicroButton.NotificationOverlay:SetFrameLevel(500)
	GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetAtlas("hud-microbutton-communities-icon-notification")
	GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetSize(18, 18)
	GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:ClearAllPoints()
	GuildMicroButton.NotificationOverlay.UnreadNotificationIcon:SetPoint("CENTER", GuildMicroButton.NotificationOverlay, "TOP", 0, -5)
	
	local GuildMicroButtonTabard = CreateFrame("Frame", "GuildMicroButtonTabard", GuildMicroButton)
	GuildMicroButtonTabard:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	GuildMicroButtonTabard:SetPoint("TOPLEFT", GuildMicroButton, "TOPLEFT", 0, 0)
	GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardBackground", "ARTWORK")
	GuildMicroButtonTabard:Hide()
	GuildMicroButtonTabard.background = GuildMicroButtonTabardBackground
	GuildMicroButtonTabardBackground:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	GuildMicroButtonTabardBackground:SetTexture("Interface\\Buttons\\UI-MicroButton-Guild-Banner")
	GuildMicroButtonTabardBackground:SetTexCoord(0/32, 32/32, 22/64, 64/64)
	GuildMicroButtonTabardBackground:SetPoint("CENTER", GuildMicroButtonTabard, "CENTER", 0, 0)
	GuildMicroButtonTabard:CreateTexture("GuildMicroButtonTabardEmblem", "OVERLAY")
	GuildMicroButtonTabard.emblem = GuildMicroButtonTabardEmblem
	GuildMicroButtonTabardEmblem:SetTexture("Interface\\GuildFrame\\GuildEmblems_01")
	GuildMicroButtonTabardEmblem:SetDrawLayer("OVERLAY", 1)
	if not(ClassicUI.db.profile.barsConfig.MicroButtons.useBiggerGuildEmblem) then
		GuildMicroButtonTabardEmblem:SetSize(14, 14)
	else
		GuildMicroButtonTabardEmblem:SetSize(16, 16)
	end
	GuildMicroButtonTabardEmblem:SetPoint("CENTER", GuildMicroButtonTabard, "CENTER", 0, 0)
	if (ClassicUI.db.profile.barsConfig.MicroButtons.useClassicGuildIcon) then
		GuildMicroButtonTabardEmblem:SetAlpha(0)
		GuildMicroButtonTabardEmblem:Hide()
		GuildMicroButtonTabardBackground:SetAlpha(0)
		GuildMicroButtonTabardBackground:Hide()
		GuildMicroButtonTabard:SetAlpha(0)
		GuildMicroButtonTabard:Hide()
	end
	
	ClassicUI.GuildMicroButton_UpdateTabard = function(forceUpdate)
		local tabard = GuildMicroButtonTabard
		if ( not tabard.needsUpdate and not forceUpdate ) then
			return
		end
		if not(ClassicUI.db.profile.barsConfig.MicroButtons.useClassicGuildIcon) then
			local emblemFilename = select(10, GetGuildLogoInfo())
			if ( emblemFilename ) then
				if ( not tabard:IsShown() ) then
					local button = GuildMicroButton
					button:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Up")
					button:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonCharacter-Down")
					tabard:Show()
				end
				SetSmallGuildTabardTextures("player", tabard.emblem, tabard.background)
			else
				if ( tabard:IsShown() ) then
					local button = GuildMicroButton
					button:SetDisabledAtlas("hud-microbutton-Socials-Disabled", true)
					button:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Socials-Up")
					button:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Socials-Down")
					button:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Socials-Disabled")
					tabard:Hide()
				end
			end
		end
		tabard.needsUpdate = nil
	end
	
	GuildMicroButtonTabard:SetScript("OnEvent", function(self, event, ...)
		if (Kiosk_IsEnabled()) then
			return
		end
		if (event == "PLAYER_GUILD_UPDATE" or event == "NEUTRAL_FACTION_SELECT_RESULT" ) then
			self.needsUpdate = true
			ClassicUI.GuildMicroButton_UpdateTabard()
		end
	end)
	
	hooksecurefunc("UpdateMicroButtons", function(self)
		ClassicUI.GuildMicroButton_UpdateTabard()
		local factionGroup = UnitFactionGroup("player")
		if not( IsCommunitiesUIDisabledByTrialAccount() or factionGroup == "Neutral" or Kiosk_IsEnabled() ) and
		   not( C_Club_IsEnabled() and not BNConnected() ) and
		   not( C_Club_IsEnabled() and C_Club_IsRestricted() ~= Enum.ClubRestrictionReason.None ) and
		      ( CommunitiesFrame and CommunitiesFrame:IsShown() ) or ( GuildFrame and GuildFrame:IsShown() ) then
			GuildMicroButtonTabard:SetPoint("TOPLEFT", -1, -2)
			GuildMicroButtonTabard:SetAlpha(0.70)
		else
			GuildMicroButtonTabard:SetPoint("TOPLEFT", 0, 0)
			GuildMicroButtonTabard:SetAlpha(1)
		end
	end)

	GuildMicroButtonTabard:RegisterEvent("PLAYER_GUILD_UPDATE")
	GuildMicroButtonTabard:RegisterEvent("NEUTRAL_FACTION_SELECT_RESULT")
	ClassicUI.GuildMicroButton_UpdateTabard(true)
	
	-- [MicroButtons] LFDMicroButton
	LFDMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	LFDMicroButton:SetPoint("BOTTOMLEFT", GuildMicroButton, "BOTTOMRIGHT", -3, 0)
	LFDMicroButton:SetFrameStrata("MEDIUM")
	LFDMicroButton:SetFrameLevel(3)
	LFDMicroButton:SetNormalAtlas("hud-microbutton-LFG-Up", true)
	LFDMicroButton:SetPushedAtlas("hud-microbutton-LFG-Down", true)
	LFDMicroButton:SetDisabledAtlas("hud-microbutton-LFG-Disabled", true)
	LFDMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	LFDMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-LFG-Up")
	LFDMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-LFG-Down")
	LFDMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	LFDMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-LFG-Disabled")
	LFDMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	LFDMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	LFDMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	LFDMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	LFDMicroButton.FlashBorder:SetSize(34, 44)
	LFDMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] CollectionsMicroButton
	CollectionsMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	CollectionsMicroButton:SetPoint("BOTTOMLEFT", LFDMicroButton, "BOTTOMRIGHT", -2, 0)
	CollectionsMicroButton:SetFrameStrata("MEDIUM")
	CollectionsMicroButton:SetFrameLevel(3)
	CollectionsMicroButton:SetNormalAtlas("hud-microbutton-Mounts-Up", true)
	CollectionsMicroButton:SetPushedAtlas("hud-microbutton-Mounts-Down", true)
	CollectionsMicroButton:SetDisabledAtlas("hud-microbutton-Mounts-Disabled", true)
	CollectionsMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	CollectionsMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Up")
	CollectionsMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Down")
	CollectionsMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	CollectionsMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-Mounts-Disabled")
	CollectionsMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CollectionsMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CollectionsMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CollectionsMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	CollectionsMicroButton.FlashBorder:SetSize(34, 44)
	CollectionsMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] EJMicroButton
	EJMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	EJMicroButton:SetPoint("BOTTOMLEFT", CollectionsMicroButton, "BOTTOMRIGHT", -2, 0)
	EJMicroButton:SetFrameStrata("MEDIUM")
	EJMicroButton:SetFrameLevel(3)
	EJMicroButton:SetNormalAtlas("hud-microbutton-EJ-Up", true)
	EJMicroButton:SetPushedAtlas("hud-microbutton-EJ-Down", true)
	EJMicroButton:SetDisabledAtlas("hud-microbutton-EJ-Disabled", true)
	EJMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	EJMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-EJ-Up")
	EJMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-EJ-Down")
	EJMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	EJMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-EJ-Disabled")
	EJMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	EJMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	EJMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	EJMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	EJMicroButton.FlashBorder:SetSize(34, 44)
	EJMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] StoreMicroButton
	StoreMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	StoreMicroButton:SetPoint("BOTTOMLEFT", EJMicroButton, "BOTTOMRIGHT", -2, 0)
	StoreMicroButton:SetFrameStrata("MEDIUM")
	StoreMicroButton:SetFrameLevel(3)
	StoreMicroButton:SetNormalAtlas("hud-microbutton-BStore-Up", true)
	StoreMicroButton:SetPushedAtlas("hud-microbutton-BStore-Down", true)
	StoreMicroButton:SetDisabledAtlas("hud-microbutton-BStore-Disabled", true)
	StoreMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	StoreMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-BStore-Up")
	StoreMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-BStore-Down")
	StoreMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	StoreMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-BStore-Disabled")
	StoreMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	StoreMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	StoreMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	StoreMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	StoreMicroButton.FlashBorder:SetSize(34, 44)
	StoreMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	-- [MicroButtons] MainMenuMicroButton
	MainMenuMicroButton:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
	MainMenuMicroButton:SetPoint("BOTTOMLEFT", StoreMicroButton, "BOTTOMRIGHT", -3, 0)
	MainMenuMicroButton:SetFrameStrata("MEDIUM")
	MainMenuMicroButton:SetFrameLevel(3)
	MainMenuMicroButton:SetNormalAtlas("hud-microbutton-MainMenu-Up", true)
	MainMenuMicroButton:SetPushedAtlas("hud-microbutton-MainMenu-Down", true)
	MainMenuMicroButton:SetDisabledAtlas("hud-microbutton-MainMenu-Disabled", true)
	MainMenuMicroButton:SetHighlightAtlas("hud-microbutton-highlight")
	if not(ClassicUI.db.profile.barsConfig.MicroButtons.useClassicMainMenuIcon) then
		MainMenuMicroButton:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
		MainMenuMicroButton:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
		MainMenuMicroButton:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
	else
		MainMenuMicroButton:SetNormalTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Up-classic")
		MainMenuMicroButton:SetPushedTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Down-classic")
		MainMenuMicroButton:SetDisabledTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Disabled-classic")
	end
	MainMenuMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
	MainMenuMicroButton:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	MainMenuMicroButton:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	MainMenuMicroButton:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	MainMenuMicroButton:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
	MainMenuMicroButton.FlashBorder:SetSize(34, 44)
	MainMenuMicroButton.FlashBorder:SetPoint("TOPLEFT", TalentMicroButton, "TOPLEFT", -2, 3)
	
	if (MainMenuMicroButton.MainMenuBarPerformanceBar ~= nil) then
		MainMenuMicroButton.MainMenuBarPerformanceBar:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
		MainMenuMicroButton.MainMenuBarPerformanceBar:SetTexCoord(0/32, 32/32, 22/64, 64/64)
		MainMenuMicroButton.MainMenuBarPerformanceBar:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 0)
		if (ClassicUI.db.profile.barsConfig.MainMenuBar.hideLatencyBar) then
			MainMenuMicroButton.MainMenuBarPerformanceBar:SetAlpha(0)
			MainMenuMicroButton.MainMenuBarPerformanceBar:Hide()
		end
	end
	
	hooksecurefunc("MicroButtonPulse", function(self, duration)
		if (ClassicUI.MicroButtonsGroup[self] ~= nil and self.FlashContent ~= nil) then
			UIFrameFlashStop(self.FlashContent)
		end
	end)
	
	-- [MicroButtons] MainMenuMicroButton -> HelpOpenWebTicketButton
	if (HelpOpenWebTicketButton ~= nil) then
		HelpOpenWebTicketButton:SetParent(MainMenuMicroButton)
		HelpOpenWebTicketButton:SetPoint("CENTER", HelpOpenWebTicketButton:GetParent(), "TOPRIGHT", -3, -4)
	end
	
	-- [MicroButtons] MainMenuMicroButton -> MainMenuBarDownload texture
	local CUI_MainMenuBarDownload = MainMenuMicroButton:CreateTexture("CUI_MainMenuBarDownload")
	CUI_MainMenuBarDownload:SetPoint("BOTTOM", MainMenuMicroButton, "BOTTOM", 0, 7)
	CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Yellow")
	CUI_MainMenuBarDownload:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
	CUI_MainMenuBarDownload:SetSize(28, 28)
	CUI_MainMenuBarDownload:SetDrawLayer("OVERLAY", 0)
	CUI_MainMenuBarDownload:SetAlpha(1)
	CUI_MainMenuBarDownload:Hide()
	
	MainMenuMicroButton:HookScript("OnUpdate", function(self, elapsed)
		if (self.updateInterval >= 1) then	-- PERFORMANCE_BAR_UPDATE_INTERVAL = 1
			local status = GetFileStreamingStatus()
			if ( status == 0 ) then
				status = (GetBackgroundLoadingStatus()~=0) and 1 or 0
			end
			self:SetSize(ClassicUI.mbWidth, ClassicUI.mbHeight)
			self:SetNormalAtlas("hud-microbutton-MainMenu-Up", true)
			self:SetPushedAtlas("hud-microbutton-MainMenu-Down", true)
			self:SetDisabledAtlas("hud-microbutton-MainMenu-Disabled", true)
			self:SetHighlightAtlas("hud-microbutton-highlight")
			self:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight", "ADD")
			self:GetNormalTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
			if ( status == 0 ) then
				if not(ClassicUI.cached_db_profile.barsConfig_MicroButtons_useClassicMainMenuIcon) then	-- cached db value
					self:SetNormalTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Up")
					self:SetPushedTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Down")
					self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButton-MainMenu-Disabled")
				else
					self:SetNormalTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Up-classic")
					self:SetPushedTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Down-classic")
					self:SetDisabledTexture("Interface\\AddOns\\RazerNaga\\icons\\UI-MicroButton-MainMenu-Disabled-classic")
				end
				self:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				self:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				self:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				CUI_MainMenuBarDownload:Hide()
			else
				self:SetNormalTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
				self:SetPushedTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Down")
				self:SetDisabledTexture("Interface\\Buttons\\UI-MicroButtonStreamDL-Up")
				self:GetPushedTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				self:GetHighlightTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				self:GetDisabledTexture():SetTexCoord(0/32, 32/32, 22/64, 64/64)
				if ( status == 1 ) then
					CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Green")
				elseif ( status == 2 ) then
					CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Yellow")
				elseif ( status == 3 ) then
					CUI_MainMenuBarDownload:SetTexture("Interface\\Buttons\\UI-MicroStream-Red")
				end
				CUI_MainMenuBarDownload:Show()
			end
		end
	end)
	
	-- [Bags]
	ClassicUI.BaseBagSlotButton_UpdateTextures = function(self)
		self:GetPushedTexture():SetAtlas(nil)
		self:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress", "ADD")
		self:GetPushedTexture():SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self:GetPushedTexture():SetSize(30, 30)
		self:GetPushedTexture():SetAlpha(1)
		--self:GetPushedTexture():ClearAllPoints()		-- not needed
		--self:GetPushedTexture():SetAllPoints(self)	-- not needed
		
		self:GetHighlightTexture():SetAtlas(nil)
		self:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
		self:GetHighlightTexture():SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self:GetHighlightTexture():SetSize(30, 30)
		self:GetHighlightTexture():SetAlpha(1)
		--self:GetHighlightTexture():ClearAllPoints()	-- not needed
		--self:GetHighlightTexture():SetAllPoints(self)	-- not needed
		
		self.SlotHighlightTexture:SetAtlas(nil)
		self.SlotHighlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
		self.SlotHighlightTexture:SetBlendMode("ADD")
		self.SlotHighlightTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self.SlotHighlightTexture:SetSize(30, 30)
		self.SlotHighlightTexture:SetAlpha(1)
--		--self.SlotHighlightTexture:ClearAllPoints()	-- not needed
--		--self.SlotHighlightTexture:SetAllPoints(self)	-- not needed
		
		self:GetNormalTexture():SetAtlas(nil)
	end
	
	for i = 0, 3 do
		local bagSlot = _G["CharacterBag"..i.."Slot"]
		bagSlot.IconBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
		bagSlot.IconBorder:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		bagSlot.IconBorder:SetSize(30, 30)
		bagSlot.IconBorder:SetDrawLayer("OVERLAY")
		bagSlot.IconBorder:SetAlpha(ClassicUI.db.profile.barsConfig.BagsIcons.iconBorderAlpha)
		bagSlot.IconBorder:SetPoint("CENTER", bagSlot, "CENTER", 0, 0)
		hooksecurefunc(bagSlot, "SetItemButtonQuality", ItemButtonMixin.SetItemButtonQuality)
		hooksecurefunc(bagSlot, "UpdateTextures", ClassicUI.BaseBagSlotButton_UpdateTextures)
	end
	hooksecurefunc(MainMenuBarBackpackButton, "UpdateTextures", ClassicUI.BaseBagSlotButton_UpdateTextures)
	
	ItemButtonMixin.SetItemButtonQuality(CharacterBag0Slot, GetInventoryItemQuality("player", CharacterBag0Slot:GetID()), GetInventoryItemID("player", CharacterBag0Slot:GetID()), CharacterBag0Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag1Slot, GetInventoryItemQuality("player", CharacterBag1Slot:GetID()), GetInventoryItemID("player", CharacterBag1Slot:GetID()), CharacterBag1Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag2Slot, GetInventoryItemQuality("player", CharacterBag2Slot:GetID()), GetInventoryItemID("player", CharacterBag2Slot:GetID()), CharacterBag2Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag3Slot, GetInventoryItemQuality("player", CharacterBag3Slot:GetID()), GetInventoryItemID("player", CharacterBag3Slot:GetID()), CharacterBag3Slot.HasPaperDollAzeriteItemOverlay)
	C_Timer.After(8, function()
		ItemButtonMixin.SetItemButtonQuality(CharacterBag0Slot, GetInventoryItemQuality("player", CharacterBag0Slot:GetID()), GetInventoryItemID("player", CharacterBag0Slot:GetID()), CharacterBag0Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag1Slot, GetInventoryItemQuality("player", CharacterBag1Slot:GetID()), GetInventoryItemID("player", CharacterBag1Slot:GetID()), CharacterBag1Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag2Slot, GetInventoryItemQuality("player", CharacterBag2Slot:GetID()), GetInventoryItemID("player", CharacterBag2Slot:GetID()), CharacterBag2Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag3Slot, GetInventoryItemQuality("player", CharacterBag3Slot:GetID()), GetInventoryItemID("player", CharacterBag3Slot:GetID()), CharacterBag3Slot.HasPaperDollAzeriteItemOverlay)
	end)
	
	CharacterBag0Slot.CircleMask:Hide()
	ClassicUI.BaseBagSlotButton_UpdateTextures(CharacterBag0Slot)
	CharacterBag0SlotNormalTexture:Hide()
	CharacterBag0Slot:SetSize(30, 30)
	CharacterBag0Slot.IconBorder:SetSize(30, 30)
	CharacterBag0Slot:ClearAllPoints()
	CharacterBag0Slot:SetPoint("RIGHT", MainMenuBarBackpackButton, "LEFT", -2, 0)
	CharacterBag0Slot:SetFrameStrata("MEDIUM")
	CharacterBag0Slot:SetFrameLevel(3)
	CharacterBag1Slot.CircleMask:Hide()
	ClassicUI.BaseBagSlotButton_UpdateTextures(CharacterBag1Slot)
	CharacterBag1SlotNormalTexture:Hide()
	CharacterBag1Slot:SetSize(30, 30)
	CharacterBag1Slot.IconBorder:SetSize(30, 30)
	CharacterBag1Slot:ClearAllPoints()
	CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", -2, 0)
	CharacterBag1Slot:SetFrameStrata("MEDIUM")
	CharacterBag1Slot:SetFrameLevel(3)
	CharacterBag2Slot.CircleMask:Hide()
	ClassicUI.BaseBagSlotButton_UpdateTextures(CharacterBag2Slot)
	CharacterBag2SlotNormalTexture:Hide()
	CharacterBag2Slot:SetSize(30, 30)
	CharacterBag2Slot.IconBorder:SetSize(30, 30)
	CharacterBag2Slot:ClearAllPoints()
	CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", -2, 0)
	CharacterBag2Slot:SetFrameStrata("MEDIUM")
	CharacterBag2Slot:SetFrameLevel(3)
	CharacterBag3Slot.CircleMask:Hide()
	ClassicUI.BaseBagSlotButton_UpdateTextures(CharacterBag3Slot)
	CharacterBag3SlotNormalTexture:Hide()
	CharacterBag3Slot:SetSize(30, 30)
	CharacterBag3Slot.IconBorder:SetSize(30, 30)
	CharacterBag3Slot:ClearAllPoints()
	CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", -2, 0)
	CharacterBag3Slot:SetFrameStrata("MEDIUM")
	CharacterBag3Slot:SetFrameLevel(3)
	MainMenuBarBackpackButton.CircleMask:Hide()
	ClassicUI.BaseBagSlotButton_UpdateTextures(MainMenuBarBackpackButton)
	MainMenuBarBackpackButtonIconTexture:SetTexture("Interface\\Buttons\\Button-Backpack-Up")
	MainMenuBarBackpackButton:SetSize(30, 30)
	MainMenuBarBackpackButton.IconBorder:SetSize(30, 30)
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", -4, 6)
	MainMenuBarBackpackButton:SetFrameStrata("MEDIUM")
	MainMenuBarBackpackButton:SetFrameLevel(3)
end