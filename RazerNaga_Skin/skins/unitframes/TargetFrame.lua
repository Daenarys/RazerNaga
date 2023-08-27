if not _G.TargetFrame then return end

local function SkinFrame(frame)
	local contextual = frame.TargetFrameContent.TargetFrameContentContextual;
	local contentMain = frame.TargetFrameContent.TargetFrameContentMain;
	local nameText = contentMain.Name;
	local FrameHealthBar = contentMain.HealthBar;
	local FrameManaBar = contentMain.ManaBar;

	nameText:SetWidth(100)
	nameText:ClearAllPoints()
	nameText:SetJustifyH("CENTER")
	nameText:SetPoint("TOPLEFT", frame.TargetFrameContainer, "TOPLEFT", 36, -33)
	nameText:SetParent(frame.TargetFrameContainer)
	
	FrameHealthBar.OverAbsorbGlow:ClearAllPoints()
	FrameHealthBar.OverAbsorbGlow:SetPoint("TOPLEFT", FrameHealthBar, "TOPRIGHT", -6, 0);
	FrameHealthBar.OverAbsorbGlow:SetPoint("BOTTOMLEFT", FrameHealthBar, "BOTTOMRIGHT", 6, 0);
	FrameHealthBar.OverAbsorbGlow:SetParent(contextual)
	
	FrameHealthBar.TextString:SetParent(frame.TargetFrameContainer)
	FrameHealthBar.RightText:SetParent(frame.TargetFrameContainer)
	FrameHealthBar.LeftText:SetParent(frame.TargetFrameContainer)
	FrameHealthBar.DeadText:SetParent(frame.TargetFrameContainer)

	FrameManaBar.TextString:SetParent(frame.TargetFrameContainer)
	FrameManaBar.RightText:SetParent(frame.TargetFrameContainer)
	FrameManaBar.LeftText:SetParent(frame.TargetFrameContainer)

	if (frame.Background == nil) then
		frame.Background = frame:CreateTexture(nil, "BACKGROUND");
		frame.Background:SetColorTexture(0, 0, 0, 0.5)
	end

	contextual.NumericalThreat:ClearAllPoints()
	contextual.NumericalThreat:SetPoint("BOTTOM", contentMain.ReputationColor, "TOP", -3, -4)
	contextual.NumericalThreat:SetParent(frame)

	contextual.RaidTargetIcon:ClearAllPoints()
	contextual.RaidTargetIcon:SetPoint("CENTER", frame.TargetFrameContainer.Portrait, "TOP", 1, -2)

	contentMain.ReputationColor:SetSize(119, 19)
	contentMain.ReputationColor:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-LevelBackground")
	contentMain.ReputationColor:ClearAllPoints()
	contentMain.ReputationColor:SetPoint("TOPRIGHT", -88, -29)

	if (GetCVar("comboPointLocation") == "1") then
		ComboFrame:SetPoint("TOPRIGHT", TargetFrame, -25, -20)
	end

	hooksecurefunc(frame, "CheckClassification", function(self)
		local classification = UnitClassification(self.unit);

		local leaderIcon = contextual.LeaderIcon;
		leaderIcon:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon")
		leaderIcon:SetSize(16, 16)
		leaderIcon:ClearAllPoints()
		leaderIcon:SetPoint("TOPRIGHT", -24, -17)

		local guideIcon = contextual.GuideIcon;
		guideIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES")
		guideIcon:SetSize(19, 19)
		guideIcon:ClearAllPoints()
		guideIcon:SetPoint("TOPRIGHT", -20, -17)
		guideIcon:SetTexCoord(0, 0.296875, 0.015625, 0.3125)

		local questIcon = contextual.QuestIcon;
		questIcon:SetTexture("Interface\\TargetingFrame\\PortraitQuestBadge")
		questIcon:SetSize(32, 32)
		questIcon:ClearAllPoints()
		questIcon:SetPoint("TOP", 32, -19)

		contentMain.ReputationColor:Show()
		
		contextual:SetFrameStrata("MEDIUM")
		contextual.BossIcon:Hide();

		self.TargetFrameContainer:SetFrameStrata("MEDIUM")
		self.TargetFrameContainer.Portrait:SetSize(64, 64)
		self.TargetFrameContainer.Portrait:ClearAllPoints()
		self.TargetFrameContainer.Portrait:SetPoint("TOPRIGHT", self, "TOPRIGHT", -22, -19)

		FrameHealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		FrameHealthBar:SetStatusBarColor(0, 1, 0)		
		FrameHealthBar:SetSize(119, 12)
		FrameHealthBar:ClearAllPoints()
		FrameHealthBar:SetPoint("TOPLEFT", 26, -48)
		FrameHealthBar.HealthBarMask:Hide()
		FrameHealthBar.TextString:SetPoint("CENTER", FrameHealthBar, "CENTER", 1, 1)
		FrameHealthBar.LeftText:SetPoint("LEFT", FrameHealthBar, "LEFT", 2, 1)
		FrameHealthBar.RightText:SetPoint("RIGHT", FrameHealthBar, "RIGHT", -3, 1)
		FrameHealthBar.DeadText:SetPoint("CENTER", FrameHealthBar, "CENTER", 1, 1)
		
		FrameManaBar:SetSize(119, 12)
		FrameManaBar:ClearAllPoints()
		FrameManaBar:SetPoint("TOPLEFT", 26, -59)
		FrameManaBar.ManaBarMask:Hide()
		FrameManaBar.TextString:SetPoint("CENTER", FrameManaBar, "CENTER", 1, -1)
		FrameManaBar.LeftText:SetPoint("LEFT", FrameManaBar, "LEFT", 2, -1)
		FrameManaBar.RightText:SetPoint("RIGHT", FrameManaBar, "RIGHT", -3, -1)

		self.TargetFrameContainer.FrameTexture:Hide()
		self.TargetFrameContainer.BossPortraitFrameTexture:Hide()
		
		if (self.TargetFrameContainer.ClassicTexture == nil) then
			self.TargetFrameContainer.ClassicTexture = self.TargetFrameContainer:CreateTexture(nil, "ARTWORK")
		end

		if ( classification == "rareelite" ) then
			self.Background:SetSize(119, 41)
			self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 26, -29);
			self.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite");
			self.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			self.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			self.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", self.TargetFrameContainer, "TOPLEFT", 20, -7)
			self.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			self.TargetFrameContainer.Flash:SetParent(self)
			self.TargetFrameContainer.Flash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
			self.TargetFrameContainer.Flash:SetSize(242, 112)
			self.TargetFrameContainer.Flash:ClearAllPoints()
			self.TargetFrameContainer.Flash:SetPoint("CENTER", 3, -4)
			self.TargetFrameContainer.Flash:SetTexCoord(0, 0.9453125, 0.181640625, 0.400390625)
			self.TargetFrameContainer.Flash:SetDrawLayer("BACKGROUND", 0)
		elseif ( classification == "worldboss" or classification == "elite" ) then
			self.Background:SetSize(119, 41)
			self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 26, -29);
			self.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Elite");
			self.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			self.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			self.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", self.TargetFrameContainer, "TOPLEFT", 20, -7)
			self.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			self.TargetFrameContainer.Flash:SetParent(self)
			self.TargetFrameContainer.Flash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
			self.TargetFrameContainer.Flash:SetSize(242, 112)
			self.TargetFrameContainer.Flash:ClearAllPoints()
			self.TargetFrameContainer.Flash:SetPoint("CENTER", 3, -4)
			self.TargetFrameContainer.Flash:SetTexCoord(0, 0.9453125, 0.181640625, 0.400390625)
			self.TargetFrameContainer.Flash:SetDrawLayer("BACKGROUND", 0)
		elseif ( classification == "rare" ) then
			self.Background:SetSize(119, 41)
			self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 26, -29);
			self.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare");
			self.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			self.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			self.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", self.TargetFrameContainer, "TOPLEFT", 20, -7)
			self.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			self.TargetFrameContainer.Flash:SetParent(self)
			self.TargetFrameContainer.Flash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
			self.TargetFrameContainer.Flash:SetSize(242, 93)
			self.TargetFrameContainer.Flash:ClearAllPoints()
			self.TargetFrameContainer.Flash:SetPoint("CENTER", 1, -3)
			self.TargetFrameContainer.Flash:SetTexCoord(0, 0.9453125, 0, 0.181640625)
			self.TargetFrameContainer.Flash:SetDrawLayer("BACKGROUND", 0)
		elseif ( classification == "minus" ) then
			self.Background:SetSize(119, 12);
			self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 26, -50);
			self.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
			self.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			self.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			self.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", self.TargetFrameContainer, "TOPLEFT", 20, -7)
			self.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			self.TargetFrameContent.TargetFrameContentMain.ManaBar:Hide()
			self.TargetFrameContent.TargetFrameContentMain.ManaBar.TextString:Hide()
			self.TargetFrameContent.TargetFrameContentMain.ManaBar.LeftText:Hide()
			self.TargetFrameContent.TargetFrameContentMain.ManaBar.RightText:Hide()
			self.TargetFrameContainer.Flash:SetParent(self)
			self.TargetFrameContainer.Flash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus-Flash")
			self.TargetFrameContainer.Flash:SetSize(256, 128)
			self.TargetFrameContainer.Flash:ClearAllPoints()
			self.TargetFrameContainer.Flash:SetPoint("CENTER", 8, -20)
			self.TargetFrameContainer.Flash:SetTexCoord(0, 1, 0, 1)
			self.TargetFrameContainer.Flash:SetDrawLayer("BACKGROUND", 0)
			contentMain.ReputationColor:Hide()
		else
			self.Background:SetSize(119, 41)
			self.Background:SetPoint("TOPLEFT", self, "TOPLEFT", 26, -29);
			self.TargetFrameContainer.ClassicTexture:ClearAllPoints()
			self.TargetFrameContainer.ClassicTexture:SetPoint("TOPLEFT", self.TargetFrameContainer, "TOPLEFT", 20, -7)
			self.TargetFrameContainer.ClassicTexture:SetSize(232, 100)
			self.TargetFrameContainer.ClassicTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame")
			self.TargetFrameContainer.ClassicTexture:SetTexCoord(0.09375, 1, 0, 0.78125)
			self.TargetFrameContainer.ClassicTexture:SetVertexColor(self.TargetFrameContainer.FrameTexture:GetVertexColor())
			self.TargetFrameContainer.Flash:SetParent(self)
			self.TargetFrameContainer.Flash:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash")
			self.TargetFrameContainer.Flash:SetSize(242, 93)
			self.TargetFrameContainer.Flash:ClearAllPoints()
			self.TargetFrameContainer.Flash:SetPoint("CENTER", 1, -3)
			self.TargetFrameContainer.Flash:SetTexCoord(0, 0.9453125, 0, 0.181640625)
			self.TargetFrameContainer.Flash:SetDrawLayer("BACKGROUND", 0)
		end
	end)

	hooksecurefunc(frame, "CheckFaction", function(self)
		if (self.showPVP) then
			local factionGroup = UnitFactionGroup(self.unit);
			if (factionGroup == "Alliance") then
				contextual.PvpIcon:ClearAllPoints()
				contextual.PvpIcon:SetPoint("TOPRIGHT", -4, -27)
			elseif (factionGroup == "Horde") then
				contextual.PvpIcon:ClearAllPoints()
				contextual.PvpIcon:SetPoint("TOPRIGHT", 3, -25)
			end
			contextual.PrestigePortrait:ClearAllPoints()
			contextual.PrestigePortrait:SetPoint("TOPRIGHT", 5, -20)
		end
	end)

	hooksecurefunc(frame, "CheckLevel", function(self)
		local levelText = self.TargetFrameContent.TargetFrameContentMain.LevelText;
		local highLevelTexture = contextual.HighLevelTexture;
		local petBattle = contextual.PetBattleIcon;

		levelText:ClearAllPoints();
		levelText:SetParent(contextual)
		levelText:SetPoint("CENTER", contextual, "CENTER", 82, -24)

		highLevelTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Skull")
		highLevelTexture:SetSize(16, 16)
		highLevelTexture:ClearAllPoints();
		highLevelTexture:SetParent(contextual)
		highLevelTexture:SetPoint("CENTER", contextual, "CENTER", 82, -24)

		petBattle:ClearAllPoints();
		petBattle:SetParent(contextual)
		petBattle:SetPoint("CENTER", contextual, "CENTER", 82, 24)
	end)

	hooksecurefunc(frame, "menu", function(self)
		DropDownList1:ClearAllPoints()
		DropDownList1:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 140, 3)
	end)

	if (frame.totFrame) then
		local function fixDebuffs()
			local frameName = frame.totFrame:GetName();
			local suffix = "Debuff";
			local frameNameWithSuffix = frameName..suffix;
			for i= 1, 4 do
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

		frame.totFrame:SetFrameStrata("HIGH")
		frame.totFrame:ClearAllPoints()
		frame.totFrame:SetPoint("TOPLEFT", frame, "BOTTOMRIGHT", -108, 28)

		if (frame.totFrame.Background == nil) then
			frame.totFrame.Background = frame.totFrame.HealthBar:CreateTexture(nil, "BACKGROUND");
			frame.totFrame.Background:SetColorTexture(0, 0, 0, 0.5)
			frame.totFrame.Background:SetSize(46, 15)
			frame.totFrame.Background:ClearAllPoints()
			frame.totFrame.Background:SetPoint("BOTTOMLEFT", frame.totFrame, "BOTTOMLEFT", 45, 20);
		end
		
		frame.totFrame.FrameTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetofTargetFrame")
		frame.totFrame.FrameTexture:SetTexCoord(0.015625, 0.7265625, 0, 0.703125)
		frame.totFrame.FrameTexture:SetSize(93, 45)
		frame.totFrame.FrameTexture:ClearAllPoints()
		frame.totFrame.FrameTexture:SetPoint("TOPLEFT", frame.totFrame, "TOPLEFT", 0, 0)

		frame.totFrame.Name:SetWidth(100)
		frame.totFrame.Name:ClearAllPoints()
		frame.totFrame.Name:SetPoint("BOTTOMLEFT", 42, 6)
		
		frame.totFrame.HealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
		frame.totFrame.HealthBar:SetStatusBarColor(0, 1, 0)
		frame.totFrame.HealthBar:SetSize(46, 7)
		frame.totFrame.HealthBar:ClearAllPoints()
		frame.totFrame.HealthBar:SetPoint("TOPRIGHT", -29, -15)
		frame.totFrame.HealthBar:SetFrameLevel(1)
		frame.totFrame.HealthBar.DeadText:SetParent(frame.totFrame)
		
		frame.totFrame.ManaBar:SetSize(46, 7)
		frame.totFrame.ManaBar:ClearAllPoints()
		frame.totFrame.ManaBar:SetPoint("TOPRIGHT", -29, -23)
		frame.totFrame.ManaBar:SetFrameLevel(1)

		hooksecurefunc(frame.totFrame, "Update", function(self)
			if (self) then
				self.HealthBar.HealthBarMask:Hide()
				self.ManaBar.ManaBarMask:Hide()

				fixDebuffs()
			end
		end)
	end
end

SkinFrame(FocusFrame)
SkinFrame(TargetFrame)