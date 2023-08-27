if not _G.PlayerFrame then return end

hooksecurefunc("PlayerFrame_ToPlayerArt", function(self)
	self.PlayerFrameContainer:SetFrameLevel(4)
	
	self.PlayerFrameContainer.FrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
	self.PlayerFrameContainer.FrameTexture:SetTexCoord(1, 0.09375, 0, 0.78125)
	self.PlayerFrameContainer.FrameTexture:SetSize(232, 100)
	self.PlayerFrameContainer.FrameTexture:ClearAllPoints()
	self.PlayerFrameContainer.FrameTexture:SetPoint("TOPLEFT", self.PlayerFrameContainer, "TOPLEFT", -20, -5)

	self.PlayerFrameContainer.AlternatePowerFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
	self.PlayerFrameContainer.AlternatePowerFrameTexture:SetTexCoord(1, 0.09375, 0, 0.78125)
	self.PlayerFrameContainer.AlternatePowerFrameTexture:SetSize(232, 100)
	self.PlayerFrameContainer.AlternatePowerFrameTexture:ClearAllPoints()
	self.PlayerFrameContainer.AlternatePowerFrameTexture:SetPoint("TOPLEFT", self.PlayerFrameContainer, "TOPLEFT", -20, -5)
	
	self.PlayerFrameContainer.PlayerPortrait:SetSize(64, 64)
	self.PlayerFrameContainer.PlayerPortrait:ClearAllPoints()
	self.PlayerFrameContainer.PlayerPortrait:SetPoint("TOPLEFT", 22, -17)
	self.PlayerFrameContainer.PlayerPortraitMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")

	self.PlayerFrameContent.PlayerFrameContentContextual:SetFrameLevel(5)

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:ClearAllPoints()
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:SetPoint("TOPLEFT", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, "TOPRIGHT", -9, 0);
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:SetPoint("BOTTOMLEFT", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, "BOTTOMRIGHT", 9, 0);
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.OverAbsorbGlow:SetParent(self.PlayerFrameContainer)

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TextString:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.LeftText:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.RightText:SetParent(self.PlayerFrameContainer)

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.TextString:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.LeftText:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.RightText:SetParent(self.PlayerFrameContainer)

	if (self.Background == nil) then
		self.Background = self:CreateTexture(nil, "BACKGROUND");
		self.Background:SetSize(119, 41)
		self.Background:SetColorTexture(0, 0, 0, 0.5)
		self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 86, -26);
	else
		self.Background:SetSize(119, 41)
		self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 86, -26);
	end

	local FrameFlash = self.PlayerFrameContainer.FrameFlash
	FrameFlash:SetParent(self)
	FrameFlash:SetSize(242, 93)
	FrameFlash:ClearAllPoints()
	FrameFlash:SetPoint("CENTER", -2, -2)
	FrameFlash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
	FrameFlash:SetTexCoord(0.9453125, 0, 0, 0.181640625)
	FrameFlash:SetDrawLayer("BACKGROUND", 0)

	local StatusTexture = self.PlayerFrameContent.PlayerFrameContentMain.StatusTexture
	StatusTexture:SetParent(self.PlayerFrameContent.PlayerFrameContentContextual)
	StatusTexture:SetSize(190, 66)
	StatusTexture:ClearAllPoints()
	StatusTexture:SetPoint("TOPLEFT", 15, -13)
	StatusTexture:SetTexture("Interface\\CharacterFrame\\UI-Player-Status")
	StatusTexture:SetTexCoord(0, 0.74609375, 0, 0.53125)
	StatusTexture:SetBlendMode("ADD")
	
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetStatusBarColor(0, 1, 0)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetSize(119, 12)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetPoint("TOPLEFT", 88, -46)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.HealthBarMask:Hide()

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TextString:SetPoint("CENTER", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, -1, 0)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.LeftText:SetPoint("LEFT", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, 2, 0)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.RightText:SetPoint("RIGHT", -28, -2)

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:SetSize(119, 12)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:SetPoint("TOPLEFT", 88, -57)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.FullPowerFrame:SetSize(119, 12)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.ManaBarMask:Hide()

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.TextString:SetPoint("CENTER", self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar, -1, -1)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.LeftText:SetPoint("LEFT", 90, -13)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.RightText:SetPoint("RIGHT", -28, -13)

	self.PlayerFrameContent.PlayerFrameContentContextual.GroupIndicator:SetPoint("BOTTOMRIGHT", self, "TOPLEFT", 161, -26)
	self.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon:SetPoint("TOPLEFT", 75, -20)
	
	PlayerHitIndicator:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)

	PlayerLevelText:Show()

	if _G.AlternatePowerBar then
		AlternatePowerBar:SetSize(104, 12)
		AlternatePowerBar:ClearAllPoints()
		AlternatePowerBar:SetPoint("TOPLEFT", PlayerFrameAlternatePowerBarArea, "TOPLEFT", 94, -70);

		AlternatePowerBarText:SetPoint("CENTER", AlternatePowerBar, "CENTER", 0, -1)
		AlternatePowerBar.LeftText:SetPoint("LEFT", AlternatePowerBar, "LEFT", 0, -1)
		AlternatePowerBar.RightText:SetPoint("RIGHT", AlternatePowerBar, "RIGHT", 0, -1)

		if (AlternatePowerBar.Background == nil) then
			AlternatePowerBar.Background = AlternatePowerBar:CreateTexture(nil, "BACKGROUND");
			AlternatePowerBar.Background:SetAllPoints()
			AlternatePowerBar.Background:SetColorTexture(0, 0, 0, 0.5)
		end

		if (AlternatePowerBar.Border == nil) then
			AlternatePowerBar.Border = AlternatePowerBar:CreateTexture(nil, "ARTWORK");
			AlternatePowerBar.Border:SetSize(0, 16)
			AlternatePowerBar.Border:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
			AlternatePowerBar.Border:SetTexCoord(0.125, 0.250, 1, 0)
			AlternatePowerBar.Border:SetPoint("TOPLEFT", 4, 0)
			AlternatePowerBar.Border:SetPoint("TOPRIGHT", -4, 0)
		end

		if (AlternatePowerBar.LeftBorder == nil) then
			AlternatePowerBar.LeftBorder = AlternatePowerBar:CreateTexture(nil, "ARTWORK");
			AlternatePowerBar.LeftBorder:SetSize(16, 16)
			AlternatePowerBar.LeftBorder:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
			AlternatePowerBar.LeftBorder:SetTexCoord(0, 0.125, 1, 0)
			AlternatePowerBar.LeftBorder:SetPoint("RIGHT", AlternatePowerBar.Border, "LEFT")
		end

		if (AlternatePowerBar.RightBorder == nil) then
			AlternatePowerBar.RightBorder = AlternatePowerBar:CreateTexture(nil, "ARTWORK");
			AlternatePowerBar.RightBorder:SetSize(16, 16)
			AlternatePowerBar.RightBorder:SetTexture("Interface\\CharacterFrame\\UI-CharacterFrame-GroupIndicator")
			AlternatePowerBar.RightBorder:SetTexCoord(0.125, 0, 1, 0)
			AlternatePowerBar.RightBorder:SetPoint("LEFT", AlternatePowerBar.Border, "RIGHT")
		end

		hooksecurefunc(AlternatePowerBar, "EvaluateUnit", function(self)
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
			self:SetStatusBarColor(0, 0, 1);

			if self.PowerBarMask then
				self.PowerBarMask:Hide()
			end
		end)
	end

	if _G.MonkStaggerBar then
		MonkStaggerBar:SetSize(94, 12)
		MonkStaggerBar:ClearAllPoints()
		MonkStaggerBar:SetPoint("TOPLEFT", PlayerFrameAlternatePowerBarArea, "TOPLEFT", 98, -70);

		MonkStaggerBar.PowerBarMask:Hide()

		MonkStaggerBarText:SetPoint("CENTER", MonkStaggerBar, "CENTER", 0, -1)
		MonkStaggerBar.LeftText:SetPoint("LEFT", MonkStaggerBar, "LEFT", 0, -1)
		MonkStaggerBar.RightText:SetPoint("RIGHT", MonkStaggerBar, "RIGHT", 0, -1)

		if (MonkStaggerBar.Background == nil) then
			MonkStaggerBar.Background = MonkStaggerBar:CreateTexture(nil, "BACKGROUND");
			MonkStaggerBar.Background:SetSize(128, 16)
			MonkStaggerBar.Background:SetTexture("Interface\\PlayerFrame\\MonkManaBar")
			MonkStaggerBar.Background:SetTexCoord(0, 1, 0.5, 1)
			MonkStaggerBar.Background:SetPoint("TOPLEFT", -17, 0)
		end

		if (MonkStaggerBar.Border == nil) then
			MonkStaggerBar.Border = MonkStaggerBar:CreateTexture(nil, "ARTWORK");
			MonkStaggerBar.Border:SetSize(128, 16)
			MonkStaggerBar.Border:SetTexture("Interface\\PlayerFrame\\MonkManaBar")
			MonkStaggerBar.Border:SetTexCoord(0, 1, 0, 0.5)
			MonkStaggerBar.Border:SetPoint("TOPLEFT", -17, 0)
		end

		hooksecurefunc(MonkStaggerBar, "EvaluateUnit", function(self)
			self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
			self:SetStatusBarColor(0, 0, 1);
		end)
	end
end)

hooksecurefunc("PlayerFrame_ToVehicleArt", function(self)
	self.PlayerFrameContainer:SetFrameLevel(4)

	self.PlayerFrameContainer.VehicleFrameTexture:ClearAllPoints()
	self.PlayerFrameContainer.VehicleFrameTexture:SetPoint("TOPLEFT", self.PlayerFrameContainer, "TOPLEFT", -4, 5)
	self.PlayerFrameContainer.VehicleFrameTexture:SetSize(240, 120)
	self.PlayerFrameContainer.VehicleFrameTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame")

	self.PlayerFrameContainer.PlayerPortraitMask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetPoint("TOPLEFT", 100, -45);
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetWidth(100);
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar:SetHeight(12);

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TextString:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.LeftText:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.RightText:SetParent(self.PlayerFrameContainer)

	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.TextString:SetPoint("CENTER", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, 0, -1)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.LeftText:SetPoint("LEFT", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, 0, -1)
	self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar.RightText:SetPoint("RIGHT", self.PlayerFrameContent.PlayerFrameContentMain.HealthBarArea.HealthBar, 0, -1)

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:SetPoint("TOPLEFT", 100, -57);
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:SetWidth(100);
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar:SetHeight(12);

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.TextString:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.LeftText:SetParent(self.PlayerFrameContainer)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.RightText:SetParent(self.PlayerFrameContainer)

	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.TextString:SetPoint("CENTER", self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar, 0, 0)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.LeftText:SetPoint("LEFT", self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar,  0, 0)
	self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar.RightText:SetPoint("RIGHT", self.PlayerFrameContent.PlayerFrameContentMain.ManaBarArea.ManaBar, 0, 0)

	if (self.Background == nil) then
		self.Background = self:CreateTexture(nil, "BACKGROUND");
		self.Background:SetSize(114, 41)
		self.Background:SetColorTexture(0, 0, 0, 0.5)
		self.Background:SetPoint("TOPLEFT", 85, -25);
	else
		self.Background:SetSize(114, 41)
		self.Background:SetPoint("TOPLEFT", 85, -25);
	end

	self.PlayerFrameContent.PlayerFrameContentContextual.GroupIndicator:SetPoint("BOTTOMRIGHT", self, "TOPLEFT", 161, -26)
	self.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon:SetPoint("TOPLEFT", 75, -20)

	PlayerLevelText:Hide()

	PlayerName:SetParent(self.PlayerFrameContainer)
	PlayerName:ClearAllPoints()
	PlayerName:SetPoint("TOPLEFT", self.PlayerFrameContainer, "TOPLEFT", 96, -26.5)
end)

hooksecurefunc("PlayerFrame_UpdateLevel", function()
	PlayerLevelText:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)
	PlayerLevelText:SetDrawLayer("ARTWORK")
	PlayerLevelText:ClearAllPoints();
	PlayerLevelText:SetPoint("CENTER", PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual, "CENTER", -81, -22)
end)

hooksecurefunc("PlayerFrame_UpdatePartyLeader", function()
	local leaderIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.LeaderIcon;
	leaderIcon:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
	leaderIcon:SetSize(16, 16)
	leaderIcon:ClearAllPoints()
	leaderIcon:SetPoint("TOPLEFT", 20, -17)

	local guideIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.GuideIcon;
	guideIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	guideIcon:SetSize(19, 19)
	guideIcon:ClearAllPoints()
	guideIcon:SetPoint("TOPLEFT", 20, -17)
	guideIcon:SetTexCoord(0, 0.296875, 0.015625, 0.3125)
end)

hooksecurefunc("PlayerFrame_UpdatePlayerNameTextAnchor", function()
	PlayerName:ClearAllPoints()
	PlayerName:SetJustifyH("CENTER")
	PlayerName:SetPoint("TOPLEFT", PlayerFrame.PlayerFrameContainer, "TOPLEFT", 98, -31)
end)

hooksecurefunc("PlayerFrame_UpdatePlayerRestLoop", function()
	local playerRestLoop = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerRestLoop;

	playerRestLoop:Hide();
	playerRestLoop.PlayerRestLoopAnim:Stop();
end)


hooksecurefunc("PlayerFrame_UpdatePvPStatus", function()
	local factionGroup = UnitFactionGroup(PlayerFrame.unit);

	if (factionGroup == "Alliance") then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PVPIcon:ClearAllPoints()
		PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PVPIcon:SetPoint("TOPLEFT", 7, -25)
	elseif (factionGroup == "Horde") then
		PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PVPIcon:ClearAllPoints()
		PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PVPIcon:SetPoint("TOPLEFT", -2, -23)
	end
	
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:ClearAllPoints()
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:SetPoint("TOPLEFT", -5, -18)
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PrestigePortrait:SetParent(PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual)

	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PvpTimerText:ClearAllPoints()
	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PvpTimerText:SetPoint("TOPLEFT", 8, -8)
end)

hooksecurefunc("PlayerFrame_UpdateRolesAssigned", function()
	local roleIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RoleIcon;
	local role =  UnitGroupRolesAssigned("player");

	roleIcon:SetSize(19, 19)
	roleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
	
	if ( role == "TANK" or role == "HEALER" or role == "DAMAGER") then
		roleIcon:SetTexCoord(GetTexCoordsForRoleSmallCircle(role));
		roleIcon:Show();
	else
		roleIcon:Hide();
	end

	if (UnitHasVehiclePlayerFrameUI("player")) then
		PlayerLevelText:Hide()
	else
		PlayerLevelText:Show()
	end
end)

local attackIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIcon;
attackIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
attackIcon:SetTexCoord(0.5, 1.0, 0, 0.484375)
attackIcon:SetSize(32, 31)
attackIcon:ClearAllPoints();
attackIcon:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -8, 13)

local restIcon = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:CreateTexture(nil, "OVERLAY")
PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.restIcon = restIcon;
restIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon")
restIcon:SetTexCoord(0, 0.5, 0, 0.421875)
restIcon:SetSize(31, 31)
restIcon:ClearAllPoints()
restIcon:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -9, 12)

local attackIconGlow = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:CreateTexture(nil, "OVERLAY")
PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.AttackIconGlow = attackIconGlow;
attackIconGlow:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
attackIconGlow:SetTexCoord(0.5, 1, 0.5, 1)
attackIconGlow:SetBlendMode("ADD")
attackIconGlow:SetSize(32, 32)
attackIconGlow:ClearAllPoints();
attackIconGlow:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -10, 12)

local restIconGlow = PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual:CreateTexture(nil, "OVERLAY")
PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.RestIconGlow = restIconGlow;
restIconGlow:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
restIconGlow:SetTexCoord(0, 0.5, 0.5, 1)
restIconGlow:SetBlendMode("ADD")
restIconGlow:SetSize(32, 32)
restIconGlow:ClearAllPoints();
restIconGlow:SetPoint("TOPLEFT", PlayerLevelText, "TOPLEFT", -10, 11)

hooksecurefunc("PlayerFrame_UpdateStatus", function()
	local statusTexture = PlayerFrame.PlayerFrameContent.PlayerFrameContentMain.StatusTexture;

	PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon:Hide()
	
	PlayerFrame.inCombat = UnitAffectingCombat("player")
	if ( UnitHasVehiclePlayerFrameUI("player") ) then
		statusTexture:Hide()
		attackIcon:Hide()
		attackIconGlow:Hide()
		restIcon:Hide()
		restIconGlow:Hide()
	elseif ( IsResting() and not PlayerFrame.inCombat) then
		statusTexture:SetVertexColor(1.0, 0.88, 0.25, 1.0)
		statusTexture:Show()
		attackIcon:Hide()
		attackIconGlow:Hide()
		restIcon:Show()
		restIconGlow:Show()
	elseif ( PlayerFrame.inCombat ) then
		statusTexture:SetVertexColor(1.0, 0.0, 0.0, 1.0)
		statusTexture:Show()
		attackIcon:Show()
		attackIconGlow:Show()
		restIcon:Hide()
		restIconGlow:Hide()
	elseif ( PlayerFrame.onHateList ) then
		attackIcon:Show();
		attackIconGlow:Hide()
		restIcon:Hide();
		restIconGlow:Hide();
	else
		statusTexture:Hide()
		attackIcon:Hide()
		attackIconGlow:Hide()
		restIcon:Hide()
		restIconGlow:Hide()
	end
end)

hooksecurefunc(PlayerFrame, "menu", function(self)
	DropDownList1:ClearAllPoints()
	DropDownList1:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 86, 22)
end)

PlayerFrame:HookScript("OnEvent", function(self)
	if self.classPowerBar then
		if (select(2, UnitClass('player')) == 'DRUID') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 31, -29)
		elseif (select(2, UnitClass('player')) == 'MAGE') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 29, -29)
		elseif (select(2, UnitClass('player')) == 'MONK') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:SetScale(0.90)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 33, -32)
		elseif (select(2, UnitClass('player')) == 'PALADIN') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:SetScale(0.90)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 33, -39)
		elseif (select(2, UnitClass('player')) == 'ROGUE') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 31, -28)
		elseif (select(2, UnitClass('player')) == 'WARLOCK') then
			self.classPowerBar:SetParent(self)
			self.classPowerBar:SetScale(0.98)
			self.classPowerBar:ClearAllPoints()
			self.classPowerBar:SetPoint("CENTER", self, 28, -33)
		end
	elseif (select(2, UnitClass('player')) == 'DEATHKNIGHT') then
		RuneFrame:SetParent(self)
		RuneFrame:SetScale(0.92)
		RuneFrame:ClearAllPoints()
		RuneFrame:SetPoint("CENTER", self, 33, -31)
	elseif (select(2, UnitClass('player')) == 'EVOKER') then
		EssencePlayerFrame:SetParent(self)
		EssencePlayerFrame:ClearAllPoints()
		EssencePlayerFrame:SetPoint("CENTER", self, 29, -30)
	else
		return;
	end
end)

PlayerFrame:HookScript("OnUpdate", function(self)
	if (self.PlayerFrameContent.PlayerFrameContentMain.StatusTexture:IsShown()) then
		local alpha = 255;
		local counter = self.statusCounter;
		local sign = self.statusSign;

		if (counter > 0.5) then
			sign = -sign;
			self.statusSign = sign;
		end
		counter = mod(counter, 0.5);
		self.statusCounter = counter;

		if (sign == 1) then
			alpha = (55 + (counter * 400)) / 255;
		else
			alpha = (255 - (counter * 400)) / 255;
		end
		if (self.PlayerFrameContent.PlayerFrameContentContextual.AttackIconGlow:IsShown()) then
			self.PlayerFrameContent.PlayerFrameContentContextual.AttackIconGlow:SetAlpha(alpha);
		end
		if (self.PlayerFrameContent.PlayerFrameContentContextual.RestIconGlow:IsShown()) then
			self.PlayerFrameContent.PlayerFrameContentContextual.RestIconGlow:SetAlpha(alpha);
		end
	end
end)

hooksecurefunc(TotemFrame, "Update", function(self)
	self:ClearAllPoints()
	self:SetPoint("TOPLEFT", PlayerFrame, "TOPLEFT", -6, -92)

	for _, child in pairs({self:GetChildren()}) do
		child.Border:SetSize(38, 38)
		child.Border:SetTexture("Interface\\CharacterFrame\\TotemBorder")
		child.Border:ClearAllPoints()
		child.Border:SetPoint("CENTER")
	end
end)