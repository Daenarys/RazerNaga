CfClassPowerBar = {};

function CfClassPowerBar:OnLoad()
	self:Setup();
end

function CfClassPowerBar:GetUnit()
	local unit = self.unit or self:GetParent():GetParent().unit;
	return unit or "player";
end

function CfClassPowerBar:SetTooltip(tooltipTitle, tooltip)
	self.tooltipTitle = tooltipTitle;
	self.tooltip = tooltip;

	if (self.tooltipTitle and self.tooltip) then
		self:SetScript("OnEnter", self.OnEnter);
		self:SetScript("OnLeave", self.OnLeave);
	else
		self:SetScript("OnEnter", nil);
		self:SetScript("OnLeave", nil);
	end
end

function CfClassPowerBar:SetPowerTokens(...)
	local tokens = {}

	for i = 1, select("#", ...) do
		local tokenType = select(i, ...);
		tokens[tokenType] = true;
	end

	self.powerTokens = tokens;
end

function CfClassPowerBar:UsesPowerToken(tokenType)
	return self.powerTokens and self.powerTokens[tokenType];
end

function CfClassPowerBar:OnEvent(event, ...)
	if ( event == "UNIT_POWER_FREQUENT" ) then
		local unitToken, powerToken = ...;
		if ( unitToken ~= self:GetUnit() ) then
			return false;
		end
		if ( self:UsesPowerToken(powerToken) ) then
			self:UpdatePower();
		end
	elseif ( event == "PLAYER_ENTERING_WORLD" or event == "UNIT_DISPLAYPOWER" ) then
		self:UpdatePower();
	elseif (event == "PLAYER_TALENT_UPDATE" ) then
		self:Setup();
		self:UpdatePower();
	else
		return false;
	end

	return true;
end

function CfClassPowerBar:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(self.tooltipTitle, 1, 1, 1);
	GameTooltip:AddLine(self.tooltip, nil, nil, nil, true);
	GameTooltip:Show();
end

function CfClassPowerBar:OnLeave()
	GameTooltip:Hide();
end

function CfClassPowerBar:Setup()
	local _, class = UnitClass("player");
	local spec = GetSpecialization();
	local showBar = false;

	if ( class == self.class ) then
		if ( not self.spec or spec == self.spec ) then
			PlayerFrame.CfClassPowerBar = self;
			self:RegisterUnitEvent("UNIT_POWER_FREQUENT", "player");
			self:RegisterEvent("PLAYER_ENTERING_WORLD");
			self:RegisterEvent("UNIT_DISPLAYPOWER");
			showBar = true;
		else
			self:UnregisterEvent("UNIT_POWER_FREQUENT");
			self:UnregisterEvent("PLAYER_ENTERING_WORLD");
			self:UnregisterEvent("UNIT_DISPLAYPOWER");
		end

		self:RegisterEvent("PLAYER_TALENT_UPDATE");
	end

	self:SetShown(showBar);
	return showBar;
end

function CfClassPowerBar:TurnOn(frame, texture, toAlpha)
	local alphaValue = texture:GetAlpha();
	frame.Fadein:Stop();
	frame.Fadeout:Stop();
	texture:SetAlpha(alphaValue);
	frame.on = true;
	if (alphaValue < toAlpha) then
		if (texture:IsVisible()) then
			frame.Fadein.AlphaAnim:SetFromAlpha(alphaValue);
			frame.Fadein:Play();
		else
			texture:SetAlpha(toAlpha);
		end
	end
end

function CfClassPowerBar:TurnOff(frame, texture, toAlpha)
	local alphaValue = texture:GetAlpha();
	frame.Fadein:Stop();
	frame.Fadeout:Stop();
	texture:SetAlpha(alphaValue);
	frame.on = false;
	if (alphaValue > toAlpha) then
		if (texture:IsVisible()) then
			frame.Fadeout.AlphaAnim:SetFromAlpha(alphaValue);
			frame.Fadeout:Play();
		else
			texture:SetAlpha(toAlpha);
		end
	end
end