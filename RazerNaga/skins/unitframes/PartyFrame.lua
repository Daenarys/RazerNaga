if not _G.PartyFrame then return end

for frame in PartyFrame.PartyMemberFramePool:EnumerateActive() do
	frame.Texture:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame")
	frame.Texture:SetSize(128, 64)
	frame.Texture:ClearAllPoints()
	frame.Texture:SetPoint("TOPLEFT", 0, -2)
	frame.Texture:SetDrawLayer("ARTWORK", 7)
	frame.VehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicles-PartyFrame")
	frame.VehicleTexture:SetSize(128, 64)
	frame.VehicleTexture:ClearAllPoints()
	frame.VehicleTexture:SetPoint("TOPLEFT", -6, 6)
	frame.VehicleTexture:SetDrawLayer("ARTWORK", 7)
	frame.NotPresentIcon:ClearAllPoints()
	frame.NotPresentIcon:SetPoint("LEFT", frame, "RIGHT", 3, 5)
	frame.PartyMemberOverlay.LeaderIcon:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
	frame.PartyMemberOverlay.LeaderIcon:SetSize(16, 16)
	frame.PartyMemberOverlay.LeaderIcon:ClearAllPoints()
	frame.PartyMemberOverlay.LeaderIcon:SetPoint("TOPLEFT")
	frame.PartyMemberOverlay.GuideIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	frame.PartyMemberOverlay.GuideIcon:SetTexCoord(0, 0.296875, 0.015625, 0.3125)
	frame.PartyMemberOverlay.GuideIcon:SetSize(19, 19)
	frame.PartyMemberOverlay.GuideIcon:ClearAllPoints()
	frame.PartyMemberOverlay.GuideIcon:SetPoint("TOPLEFT")
	frame.PartyMemberOverlay.PVPIcon:SetPoint("TOPLEFT", -9, -15)
	frame.PartyMemberOverlay.Disconnect:SetPoint("LEFT", -7, -1)
	frame.HealthBar.OverAbsorbGlow:SetDrawLayer("ARTWORK", 7)
	frame.HealthBar.OverAbsorbGlow:SetParent(frame)
	frame.HealthBar.LeftText:SetParent(frame)
	frame.HealthBar.RightText:SetParent(frame)
	frame.HealthBar.CenterText:SetParent(frame)
	frame.ManaBar.LeftText:SetParent(frame)
	frame.ManaBar.RightText:SetParent(frame)
	frame.ManaBar.CenterText:SetParent(frame)

	hooksecurefunc(frame, "ToPlayerArt", function(self)
		self.Name:SetWidth(0)

		self.Flash:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash")
		self.Flash:SetSize(128, 64)
		self.Flash:SetPoint("TOPLEFT", -3, 2)
		self.Flash:SetDrawLayer("BACKGROUND", 0)

		self.PartyMemberOverlay.Status:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
		self.PartyMemberOverlay.Status:SetTexCoord(0, 0.2734375, 0, 0.5625)
		self.PartyMemberOverlay.Status:SetSize(36, 36)
		self.PartyMemberOverlay.Status:ClearAllPoints()
		self.PartyMemberOverlay.Status:SetPoint("CENTER", self.Portrait, 0, 0)
		self.PartyMemberOverlay.Status:SetDrawLayer("ARTWORK", 0)

		self.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		self.HealthBar:SetSize(70, 8)
		self.HealthBar:ClearAllPoints()
		self.HealthBar:SetPoint("TOPLEFT", 47, -12)
		self.HealthBar:SetFrameLevel(2)
		self.HealthBar.HealthBarMask:Hide()
		self.HealthBar.LeftText:ClearAllPoints()
		self.HealthBar.LeftText:SetPoint("LEFT", self.HealthBar, -3, 1)
		self.HealthBar.RightText:ClearAllPoints()
		self.HealthBar.RightText:SetPoint("RIGHT", self.HealthBar, 2, 1)

		self.HealthBar.Background:Show()
		self.HealthBar.Background:SetSize(72, 20)
		self.HealthBar.Background:ClearAllPoints()
		self.HealthBar.Background:SetPoint("TOPLEFT", self, 45, -11)
		self.HealthBar.Background:SetColorTexture(0, 0, 0, 0.5)
		self.HealthBar.Background:SetDrawLayer("BACKGROUND", -7)

		self.ManaBar:SetSize(70, 8)
		self.ManaBar:ClearAllPoints()
		self.ManaBar:SetPoint("TOPLEFT", 45, -21)
		self.ManaBar:SetFrameLevel(2)
		self.ManaBar.ManaBarMask:Hide()
		self.ManaBar.LeftText:ClearAllPoints()
		self.ManaBar.LeftText:SetPoint("LEFT", self.ManaBar, -1, 0)
		self.ManaBar.RightText:ClearAllPoints()
		self.ManaBar.RightText:SetPoint("RIGHT", self.ManaBar, 2, 0)

		if not UnitIsConnected(self:GetUnit()) then
			self.HealthBar:SetStatusBarColor(0.5, 0.5, 0.5);
			self.HealthBar.RightText:SetText("1")
			self.ManaBar:Hide()
			self.ManaBar.LeftText:Hide()
			self.ManaBar.RightText:Hide()
			self.ManaBar.CenterText:Hide()
		else
			self.HealthBar:SetStatusBarColor(0, 1, 0);
		end
	end)

	hooksecurefunc(frame, "UpdateNameTextAnchors", function(self)
		self.Name:SetPoint("TOPLEFT", self, "TOPLEFT", 49, 1.5);
	end)

	hooksecurefunc(frame, "UpdateAssignedRoles", function(self)
		local roleIcon = self.PartyMemberOverlay.RoleIcon;
		local role = UnitGroupRolesAssigned(self:GetUnit());

		if IsInInstance() then
			roleIcon:SetSize(19, 19)
			roleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
			roleIcon:ClearAllPoints();
			roleIcon:SetPoint("TOPLEFT", 7, -33)
			if ( role == "TANK" or role == "HEALER" or role == "DAMAGER") then
				roleIcon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role));
				roleIcon:Show();
			else
				roleIcon:Hide();
			end
		else
			roleIcon:Hide()
		end
	end)
end