CfClassResourceBarMixin = {};

function CfClassResourceBarMixin:OnLoad()
	if self.usePooledResourceButtons then
		self.classResourceButtonPool = CreateFramePool("FRAME", self, self.resourcePointTemplate, self.resourcePointReleaseFunc);
		self.classResourceButtonTable = { };
	end

	if(self.powerToken) then
		if(self.powerToken2) then
			self:SetPowerTokens(self.powerToken, self.powerToken2);
		else
			self:SetPowerTokens(self.powerToken);
		end
	end
	if(self.showTooltip) then
		self:SetTooltip(self.tooltip1, self.tooltip2);
	end
	self.maxUsablePoints = self.maxUsablePoints or 5;
	self.resourceBarMixin.OnLoad(self);
end

function CfClassResourceBarMixin:OnEvent(event, arg1, arg2)
	if(event == "PLAYER_LEVEL_UP") then 
		local unit = self.unit or self:GetParent().unit;
		unit = unit or "player";
		if(self.requiredShownLevel and UnitLevel(unit) >= self.requiredShownLevel) then
			self:UnregisterEvent("PLAYER_LEVEL_UP");
			self:HandleBarSetup();
		end
	elseif (event == "UNIT_DISPLAYPOWER" or event == "PLAYER_ENTERING_WORLD") then
		self:Setup();
	elseif (event == "UNIT_MAXPOWER") then
		self:UpdateMaxPower();
	elseif (event == "UNIT_POWER_POINT_CHARGE") then
		if self.UpdateChargedPowerPoints then
			self:UpdateChargedPowerPoints();
		else
			self:UpdatePower();
		end
	else
		self.resourceBarMixin.OnEvent(self, event, arg1, arg2);
	end
end

function CfClassResourceBarMixin:HandleBarSetup()
	local frameLevel = self:GetParent() and self:GetParent():GetFrameLevel() + 2 or self:GetFrameLevel(); 
	self:SetFrameLevel(frameLevel);
	if (self.showBarFunc) then
		self.showBarFunc(self);
	else
		self:Show();
	end
	self:UpdateMaxPower();
	if(self.resourceBarMixin.UpdateMaxPower) then 
		self.resourceBarMixin.UpdateMaxPower(self);
	end
	self:UpdatePower();
end

function CfClassResourceBarMixin:Setup()
	local showBar = false;
	self.xOffset = select(4, self:GetPoint());

	if UnitInVehicle("player") then
		self.xOffset = 43;
		showBar = PlayerVehicleHasComboPoints();
	else
		showBar = self.resourceBarMixin.Setup(self);
		if(self.shouldShowBarFunc) then
			showBar = self.shouldShowBarFunc(self);
		end
	end

	if showBar then
		self.unit = self.unit or self:GetParent():GetParent().unit or "player";
		self:RegisterUnitEvent("UNIT_POWER_FREQUENT", self.unit);
		self:RegisterUnitEvent("UNIT_MAXPOWER", self.unit);
		self:RegisterUnitEvent("UNIT_POWER_POINT_CHARGE", self.unit);
		if (self.unit == "player" and self.requiredShownLevel and UnitLevel(self.unit) < self.requiredShownLevel) then
			self:RegisterEvent("PLAYER_LEVEL_UP");
		else
			self:HandleBarSetup();
		end
	else
		if (self.hideBarFunc) then
			self.hideBarFunc(self);
		else
			self:Hide();
		end
		self:UnregisterEvent("UNIT_POWER_FREQUENT");
		self:UnregisterEvent("UNIT_MAXPOWER");
		self:UnregisterEvent("UNIT_POWER_POINT_CHARGE");
	end
end

function CfClassResourceBarMixin:UpdateMaxPower()
	local oldMaxPoints = self.maxUsablePoints;
	self.unit = self.unit or self:GetParent():GetParent().unit or "player";
	self.maxUsablePoints = UnitPowerMax(self.unit, self.powerType);

	if self.usePooledResourceButtons then
		if oldMaxPoints and self.maxUsablePoints == oldMaxPoints and self.classResourceButtonTable and #self.classResourceButtonTable == self.maxUsablePoints then
			return;
		end

		self.classResourceButtonPool:ReleaseAll();
		self.classResourceButtonTable = { };
	
		for i = 1, self.maxUsablePoints do
			local resourcePoint = self.classResourceButtonPool:Acquire();
			self.classResourceButtonTable[i] = resourcePoint;
			if(self.resourcePointSetupFunc) then
				self.resourcePointSetupFunc(resourcePoint);
			end
			resourcePoint.layoutIndex = i;
			resourcePoint:Show();
		end
	
		self:Layout();
		self:UpdatePower();
	end
end

function CfClassResourceBarMixin:UpdatePower()
end