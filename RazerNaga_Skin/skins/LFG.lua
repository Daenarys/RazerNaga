if not _G.PVEFrame then return end

ScenarioQueueFrameRandomScrollFrame.ScrollBar:Hide()

LFDQueueFrameRandomScrollFrame.ScrollBar:SetSize(25, 560)
LFDQueueFrameRandomScrollFrame.ScrollBar:ClearAllPoints()
LFDQueueFrameRandomScrollFrame.ScrollBar:SetPoint("TOPLEFT", LFDQueueFrameRandomScrollFrame, "TOPRIGHT", 2, 8)
LFDQueueFrameRandomScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", LFDQueueFrameRandomScrollFrame, "BOTTOMRIGHT", 5, -9)

if (LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate == nil) then
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate = LFDQueueFrameRandomScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFDQueueFrameRandomScrollFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFDQueueFrameRandomScrollFrame.ScrollBar)
ApplyScrollBarTrack(LFDQueueFrameRandomScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(LFDQueueFrameRandomScrollFrame.ScrollBar.Track.Thumb)

LFDQueueFrameSpecific.ScrollBar:SetSize(25, 560)
LFDQueueFrameSpecific.ScrollBar:ClearAllPoints()
LFDQueueFrameSpecific.ScrollBar:SetPoint("TOPLEFT", LFDQueueFrameSpecific.ScrollBox, "TOPRIGHT", 5, 0)
LFDQueueFrameSpecific.ScrollBar:SetPoint("BOTTOMLEFT", LFDQueueFrameSpecific.ScrollBox, "BOTTOMRIGHT", 5, 0)

ApplyScrollBarArrow(LFDQueueFrameSpecific.ScrollBar)
ApplyScrollBarTrack(LFDQueueFrameSpecific.ScrollBar.Track)
ApplyScrollBarThumb(LFDQueueFrameSpecific.ScrollBar.Track.Thumb)

LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetSize(25, 560)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:ClearAllPoints()
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "TOPRIGHT", -3, 2)
LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBox, "BOTTOMRIGHT", 0, -2)

if (LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate == nil) then
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate = LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.EntryCreation.ActivityFinder.Dialog.ScrollBar.Track.Thumb)

LFGListFrame.SearchPanel.ScrollBar:SetSize(25, 560)
LFGListFrame.SearchPanel.ScrollBar:ClearAllPoints()
LFGListFrame.SearchPanel.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.SearchPanel.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.SearchPanel.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.SearchPanel.ScrollBox, "BOTTOMRIGHT", 3, -1)

if (LFGListFrame.SearchPanel.ScrollBar.Backplate == nil) then
	LFGListFrame.SearchPanel.ScrollBar.Backplate = LFGListFrame.SearchPanel.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.SearchPanel.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.SearchPanel.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.SearchPanel.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.SearchPanel.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.SearchPanel.ScrollBar.Track.Thumb)

LFGListFrame.ApplicationViewer.ScrollBar:SetSize(25, 560)
LFGListFrame.ApplicationViewer.ScrollBar:ClearAllPoints()
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("TOPLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "TOPRIGHT", 0, 3)
LFGListFrame.ApplicationViewer.ScrollBar:SetPoint("BOTTOMLEFT", LFGListFrame.ApplicationViewer.ScrollBox, "BOTTOMRIGHT", 3, -3)

if (LFGListFrame.ApplicationViewer.ScrollBar.Backplate == nil) then
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate = LFGListFrame.ApplicationViewer.ScrollBar:CreateTexture(nil, "BACKGROUND")
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	LFGListFrame.ApplicationViewer.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(LFGListFrame.ApplicationViewer.ScrollBar)
ApplyScrollBarTrack(LFGListFrame.ApplicationViewer.ScrollBar.Track)
ApplyScrollBarThumb(LFGListFrame.ApplicationViewer.ScrollBar.Track.Thumb)

RaidFinderQueueFrameScrollFrame.ScrollBar:SetSize(25, 560)
RaidFinderQueueFrameScrollFrame.ScrollBar:ClearAllPoints()
RaidFinderQueueFrameScrollFrame.ScrollBar:SetPoint("TOPLEFT", RaidFinderQueueFrameScrollFrame, "TOPRIGHT", 2, 3)
RaidFinderQueueFrameScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", RaidFinderQueueFrameScrollFrame, "BOTTOMRIGHT", 5, 0)

if (RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate == nil) then
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate = RaidFinderQueueFrameScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND")
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
	RaidFinderQueueFrameScrollFrame.ScrollBar.Backplate:SetAllPoints()
end

ApplyScrollBarArrow(RaidFinderQueueFrameScrollFrame.ScrollBar)
ApplyScrollBarTrack(RaidFinderQueueFrameScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(RaidFinderQueueFrameScrollFrame.ScrollBar.Track.Thumb)

ApplyDropDown(LFDQueueFrameTypeDropdown)
ApplyDropDown(RaidFinderQueueFrameSelectionDropdown)
ApplyDropDown(ScenarioQueueFrameTypeDropdown)
ApplyDropDown(LFGListEntryCreationGroupDropdown)
ApplyDropDown(LFGListEntryCreationActivityDropdown)
ApplyDropDown(LFGListEntryCreationPlayStyleDropdown)
ApplyFilterDropDown(LFGListFrame.SearchPanel.FilterButton)

hooksecurefunc('LFGListGroupDataDisplayRoleCount_Update', function(self)
	self.TankIcon:SetAtlas("groupfinder-icon-role-large-tank")
	self.HealerIcon:SetAtlas("groupfinder-icon-role-large-heal")
	self.DamagerIcon:SetAtlas("groupfinder-icon-role-large-dps")
end)

hooksecurefunc('LFGListApplicationDialog_UpdateRoles', function(self)
	self.TankButton:SetNormalTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
	self.TankButton:GetNormalTexture():SetTexCoord(GetTexCoordsForRole("TANK"))
	self.HealerButton:SetNormalTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
	self.HealerButton:GetNormalTexture():SetTexCoord(GetTexCoordsForRole("HEALER"))
	self.DamagerButton:SetNormalTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
	self.DamagerButton:GetNormalTexture():SetTexCoord(GetTexCoordsForRole("DAMAGER"))
end)

hooksecurefunc('LFGListApplicationViewer_UpdateRoleIcons', function(member, grayedOut, tank, healer, damage)
	local LFG_LIST_GROUP_DATA_ATLASES = {
		TANK = "groupfinder-icon-role-large-tank",
		HEALER = "groupfinder-icon-role-large-heal",
		DAMAGER = "groupfinder-icon-role-large-dps",
	};

	local role1 = tank and "TANK" or (healer and "HEALER" or (damage and "DAMAGER"))
	local role2 = (tank and healer and "HEALER") or ((tank or healer) and damage and "DAMAGER")
	local role3 = (tank and healer and damage and "DAMAGER")
	member.RoleIcon1:GetNormalTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role1])
	member.RoleIcon1:GetHighlightTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role1])
	if ( role2 ) then
		member.RoleIcon2:GetNormalTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role2])
		member.RoleIcon2:GetHighlightTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role2])
	end
	if ( role3 ) then
		member.RoleIcon3:GetNormalTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role3])
		member.RoleIcon3:GetHighlightTexture():SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role3])
	end
end)

hooksecurefunc('LFGListGroupDataDisplayEnumerate_Update', function(self, numPlayers, displayData, disabled, iconOrder)
	local LFG_LIST_GROUP_DATA_ATLASES = {
		TANK = "groupfinder-icon-role-large-tank",
		HEALER = "groupfinder-icon-role-large-heal",
		DAMAGER = "groupfinder-icon-role-large-dps",
	};

	--Note that icons are numbered from right to left
	if iconOrder == LFG_LIST_GROUP_DATA_ROLE_ORDER then
		local iconIndex = numPlayers;
		for i=1, #iconOrder do
			local role = iconOrder[i];
			for j=1, displayData[iconOrder[i]] do
				local icon = self.Icons[iconIndex];
				icon.RoleIconWithBackground:Hide()
				icon.RoleIcon:Show()
				icon.RoleIcon:SetSize(18, 18)
				icon.RoleIcon:SetAtlas(LFG_LIST_GROUP_DATA_ATLASES[role], false)
				icon.ClassCircle:Hide()
				iconIndex = iconIndex - 1;
				if ( iconIndex < 1 ) then
					return;
				end
			end
		end
	end
end)

hooksecurefunc("GroupFinderFrame_EvaluateButtonVisibility", function(self)
	if not PlayerGetTimerunningSeasonID() then
		self.groupButton1:SetPoint("TOPLEFT", 10, -101)
		self.groupButton2:SetPoint("TOP", self.groupButton1, "BOTTOM", 0, -30)
		self.groupButton3:SetPoint("TOP", self.groupButton2, "BOTTOM", 0, -30)
	end
end)