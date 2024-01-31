--[[
	castBar.lua
		A dominos based casting bar
--]]

local DCB = RazerNaga:NewModule('CastingBar')
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local CastBar, CastingBar

function DCB:Load()
	self.frame = CastBar:New()
end

function DCB:Unload()
	self.frame:Free()
end

--[[ CastingBarFrame Object ]]--

local CASTING_BAR_ALPHA_STEP = 0.05;
local CASTING_BAR_FLASH_STEP = 0.2;
local CASTING_BAR_HOLD_TIME = 1;

function CastingBarFrame_OnLoad(self, unit, showTradeSkills, showShield)
	CastingBarFrame_SetStartCastColor(self, 1.0, 0.7, 0.0);
	CastingBarFrame_SetStartChannelColor(self, 0.0, 1.0, 0.0);
	CastingBarFrame_SetFinishedCastColor(self, 0.0, 1.0, 0.0);
	CastingBarFrame_SetNonInterruptibleCastColor(self, 0.7, 0.7, 0.7);
	CastingBarFrame_SetFailedCastColor(self, 1.0, 0.0, 0.0);

	CastingBarFrame_SetUseStartColorForFinished(self, true);
	CastingBarFrame_SetUseStartColorForFlash(self, true);

	CastingBarFrame_SetUnit(self, unit, showTradeSkills, showShield);

	self.showCastbar = true;

	local point, relativeTo, relativePoint, offsetX, offsetY = self.Spark:GetPoint();
	if ( point == "CENTER" ) then
		self.Spark.offsetY = offsetY;
	end
end

function CastingBarFrame_SetStartCastColor(self, r, g, b)
	self.startCastColor = CreateColor(r, g, b);
end

function CastingBarFrame_SetStartChannelColor(self, r, g, b)
	self.startChannelColor = CreateColor(r, g, b);
end

function CastingBarFrame_SetFinishedCastColor(self, r, g, b)
	self.finishedCastColor = CreateColor(r, g, b);
end

function CastingBarFrame_SetFailedCastColor(self, r, g, b)
	self.failedCastColor = CreateColor(r, g, b);
end

function CastingBarFrame_SetNonInterruptibleCastColor(self, r, g, b)
	self.nonInterruptibleColor = CreateColor(r, g, b);
end

function CastingBarFrame_SetUseStartColorForFinished(self, finishedColorSameAsStart)
	self.finishedColorSameAsStart = finishedColorSameAsStart;
end

function CastingBarFrame_SetUseStartColorForFlash(self, flashColorSameAsStart)
	self.flashColorSameAsStart = flashColorSameAsStart;
end

function CastingBarFrame_AddWidgetForFade(self, widget)
	if not self.additionalFadeWidgets then
		self.additionalFadeWidgets = {};
	end
	self.additionalFadeWidgets[widget] = true;
end

function CastingBarFrame_SetUnit(self, unit, showTradeSkills, showShield)
	if self.unit ~= unit then
		self.unit = unit;
		self.showTradeSkills = showTradeSkills;
		self.showShield = showShield;

		self.casting = nil;
		self.channeling = nil;
		self.holdTime = 0;
		self.fadeOut = nil;

		if unit then
			self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
			self:RegisterEvent("UNIT_SPELLCAST_DELAYED");
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
			self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
			self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE");
			self:RegisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE");
			self:RegisterEvent("PLAYER_ENTERING_WORLD");
			self:RegisterUnitEvent("UNIT_SPELLCAST_START", unit);
			self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit);
			self:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit);

			CastingBarFrame_OnEvent(self, "PLAYER_ENTERING_WORLD")
		else
			self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
			self:UnregisterEvent("UNIT_SPELLCAST_DELAYED");
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START");
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
			self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTIBLE");
			self:UnregisterEvent("UNIT_SPELLCAST_NOT_INTERRUPTIBLE");
			self:UnregisterEvent("PLAYER_ENTERING_WORLD");
			self:UnregisterEvent("UNIT_SPELLCAST_START");
			self:UnregisterEvent("UNIT_SPELLCAST_STOP");
			self:UnregisterEvent("UNIT_SPELLCAST_FAILED");

			self:Hide();
		end
	end
end

function CastingBarFrame_GetEffectiveStartColor(self, isChannel, notInterruptible)
	if self.nonInterruptibleColor and notInterruptible then
		return self.nonInterruptibleColor;
	end	
	return isChannel and self.startChannelColor or self.startCastColor;
end

function CastingBarFrame_OnEvent(self, event, ...)
	local arg1 = ...;
	
	local unit = self.unit;
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		local nameChannel = UnitChannelInfo(unit);
		local nameSpell = UnitCastingInfo(unit);
		if ( nameChannel ) then
			event = "UNIT_SPELLCAST_CHANNEL_START";
			arg1 = unit;
		elseif ( nameSpell ) then
			event = "UNIT_SPELLCAST_START";
			arg1 = unit;
		else
		    CastingBarFrame_FinishSpell(self);
		end
	end

	if ( arg1 ~= unit ) then
		return;
	end
	
	if ( event == "UNIT_SPELLCAST_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit);
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			self:Hide();
			return;
		end

		local startColor = CastingBarFrame_GetEffectiveStartColor(self, false, notInterruptible);
		self:SetStatusBarColor(startColor:GetRGB());
		if self.flashColorSameAsStart then
			self.Flash:SetVertexColor(startColor:GetRGB());
		else
			self.Flash:SetVertexColor(1, 1, 1);
		end
		
		if ( self.Spark ) then
			self.Spark:Show();
		end
		self.value = (GetTime() - (startTime / 1000));
		self.maxValue = (endTime - startTime) / 1000;
		self:SetMinMaxValues(0, self.maxValue);
		self:SetValue(self.value);
		if ( self.Text ) then
			self.Text:SetText(text);
		end
		if ( self.Icon ) then
			self.Icon:SetTexture(texture);
			if ( self.iconWhenNoninterruptible ) then
				self.Icon:SetShown(not notInterruptible);
			end
		end
		CastingBarFrame_ApplyAlpha(self, 1.0);
		self.holdTime = 0;
		self.casting = true;
		self.castID = castID;
		self.channeling = nil;
		self.fadeOut = nil;

		if ( self.BorderShield ) then
			if ( self.showShield and notInterruptible ) then
				self.BorderShield:Show();
				if ( self.BarBorder ) then
					self.BarBorder:Hide();
				end
			else
				self.BorderShield:Hide();
				if ( self.BarBorder ) then
					self.BarBorder:Show();
				end
			end
		end
		if ( self.showCastbar ) then
			self:Show();
		end

	elseif ( event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP") then
		if ( not self:IsVisible() ) then
			self:Hide();
		end
		if ( (self.casting and event == "UNIT_SPELLCAST_STOP" and select(2, ...) == self.castID) or
		     (self.channeling and event == "UNIT_SPELLCAST_CHANNEL_STOP") ) then
			if ( self.Spark ) then
				self.Spark:Hide();
			end
			if ( self.Flash ) then
				self.Flash:SetAlpha(0.0);
				self.Flash:Show();
			end
			self:SetValue(self.maxValue);
			if ( event == "UNIT_SPELLCAST_STOP" ) then
				self.casting = nil;
				if not self.finishedColorSameAsStart then
					self:SetStatusBarColor(self.finishedCastColor:GetRGB());
				end
			else
				self.channeling = nil;
			end
			self.flash = true;
			self.fadeOut = true;
			self.holdTime = 0;
		end
	elseif ( event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" ) then
		if ( self:IsShown() and
		     (self.casting and select(2, ...) == self.castID) and not self.fadeOut ) then
			self:SetValue(self.maxValue);
			self:SetStatusBarColor(self.failedCastColor:GetRGB());
			if ( self.Spark ) then
				self.Spark:Hide();
			end
			if ( self.Text ) then
				if ( event == "UNIT_SPELLCAST_FAILED" ) then
					self.Text:SetText(FAILED);
				else
					self.Text:SetText(INTERRUPTED);
				end
			end
			self.casting = nil;
			self.channeling = nil;
			self.fadeOut = true;
			self.holdTime = GetTime() + CASTING_BAR_HOLD_TIME;
		end
	elseif ( event == "UNIT_SPELLCAST_DELAYED" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit);
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				self:Hide();
				return;
			end
			self.value = (GetTime() - (startTime / 1000));
			self.maxValue = (endTime - startTime) / 1000;
			self:SetMinMaxValues(0, self.maxValue);
			if ( not self.casting ) then
				self:SetStatusBarColor(CastingBarFrame_GetEffectiveStartColor(self, false, notInterruptible):GetRGB());
				if ( self.Spark ) then
					self.Spark:Show();
				end
				if ( self.Flash ) then
					self.Flash:SetAlpha(0.0);
					self.Flash:Hide();
				end
				self.casting = true;
				self.channeling = nil;
				self.flash = nil;
				self.fadeOut = nil;
			end
		end
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(unit);
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			-- if there is no name, there is no bar
			self:Hide();
			return;
		end

		local startColor = CastingBarFrame_GetEffectiveStartColor(self, true, notInterruptible);
		if self.flashColorSameAsStart then
			self.Flash:SetVertexColor(startColor:GetRGB());
		else
			self.Flash:SetVertexColor(1, 1, 1);
		end
		self:SetStatusBarColor(startColor:GetRGB());
		self.value = (endTime / 1000) - GetTime();
		self.maxValue = (endTime - startTime) / 1000;
		self:SetMinMaxValues(0, self.maxValue);
		self:SetValue(self.value);
		if ( self.Text ) then
			self.Text:SetText(text);
		end
		if ( self.Icon ) then
			self.Icon:SetTexture(texture);
		end
		if ( self.Spark ) then
			self.Spark:Hide();
		end
		CastingBarFrame_ApplyAlpha(self, 1.0);
		self.holdTime = 0;
		self.casting = nil;
		self.channeling = true;
		self.fadeOut = nil;
		if ( self.BorderShield ) then
			if ( self.showShield and notInterruptible ) then
				self.BorderShield:Show();
				if ( self.BarBorder ) then
					self.BarBorder:Hide();
				end
			else
				self.BorderShield:Hide();
				if ( self.BarBorder ) then
					self.BarBorder:Show();
				end
			end
		end
		if ( self.showCastbar ) then
			self:Show();
		end
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_UPDATE" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit);
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				self:Hide();
				return;
			end
			self.value = ((endTime / 1000) - GetTime());
			self.maxValue = (endTime - startTime) / 1000;
			self:SetMinMaxValues(0, self.maxValue);
			self:SetValue(self.value);
		end
	elseif ( event == "UNIT_SPELLCAST_INTERRUPTIBLE" or event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE" ) then
		CastingBarFrame_UpdateInterruptibleState(self, event == "UNIT_SPELLCAST_NOT_INTERRUPTIBLE");
	end
end

function CastingBarFrame_UpdateInterruptibleState(self, notInterruptible)
	if ( self.casting or self.channeling ) then
		local startColor = CastingBarFrame_GetEffectiveStartColor(self, self.channeling, notInterruptible);
		self:SetStatusBarColor(startColor:GetRGB());

		if self.flashColorSameAsStart then
			self.Flash:SetVertexColor(startColor:GetRGB());
		end

		if ( self.BorderShield ) then
			if ( self.showShield and notInterruptible ) then
				self.BorderShield:Show();
				if ( self.BarBorder ) then
					self.BarBorder:Hide();
				end
			else
				self.BorderShield:Hide();
				if ( self.BarBorder ) then
					self.BarBorder:Show();
				end
			end
		end

		if ( self.Icon and self.iconWhenNoninterruptible ) then
			self.Icon:SetShown(not notInterruptible);
		end
	end
end

function CastingBarFrame_OnUpdate(self, elapsed)
	if ( self.casting ) then
		self.value = self.value + elapsed;
		if ( self.value >= self.maxValue ) then
			self:SetValue(self.maxValue);
			CastingBarFrame_FinishSpell(self, self.Spark, self.Flash);
			return;
		end
		self:SetValue(self.value);
		if ( self.Flash ) then
			self.Flash:Hide();
		end
		if ( self.Spark ) then
			local sparkPosition = (self.value / self.maxValue) * self:GetWidth();
			self.Spark:SetPoint("CENTER", self, "LEFT", sparkPosition, self.Spark.offsetY or 2);
		end
	elseif ( self.channeling ) then
		self.value = self.value - elapsed;
		if ( self.value <= 0 ) then
			CastingBarFrame_FinishSpell(self, self.Spark, self.Flash);
			return;
		end
		self:SetValue(self.value);
		if ( self.Flash ) then
			self.Flash:Hide();
		end
	elseif ( GetTime() < self.holdTime ) then
		return;
	elseif ( self.flash ) then
		local alpha = 0;
		if ( self.Flash ) then
			alpha = self.Flash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		end
		if ( alpha < 1 ) then
			if ( self.Flash ) then
				self.Flash:SetAlpha(alpha);
			end
		else
			if ( self.Flash ) then
				self.Flash:SetAlpha(1.0);
			end
			self.flash = nil;
		end
	elseif ( self.fadeOut ) then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if ( alpha > 0 ) then
			CastingBarFrame_ApplyAlpha(self, alpha);
		else
			self.fadeOut = nil;
			self:Hide();
		end
	end
end

function CastingBarFrame_ApplyAlpha(self, alpha)
	self:SetAlpha(alpha);
	if self.additionalFadeWidgets then
		for widget in pairs(self.additionalFadeWidgets) do
			widget:SetAlpha(alpha);
		end
	end
end

function CastingBarFrame_FinishSpell(self)
	if not self.finishedColorSameAsStart then
		self:SetStatusBarColor(self.finishedCastColor:GetRGB());
	end
	if ( self.Spark ) then
		self.Spark:Hide();
	end
	if ( self.Flash ) then
		self.Flash:SetAlpha(0.0);
		self.Flash:Show();
	end
	self.flash = true;
	self.fadeOut = true;
	self.casting = nil;
	self.channeling = nil;
end

--[[ RazerNaga Frame Object ]]--

CastBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function CastBar:New()
	local f = self.super.New(self, 'cast')
	f:SetTooltipText(L.CastBarHelp)
	f:SetFrameStrata('HIGH')

	if not f.cast then
		f.cast = CastingBar:New(f)
		f.header:SetParent(nil)
		f.header:ClearAllPoints()
	end

	f:UpdateText()
	f:Layout()

	return f
end

function CastBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = 30,
		showText = true,
	}
end

function CastBar:ToggleText(enable)
	self.sets.showText = enable or false
	self:UpdateText()
end

function CastBar:UpdateText()
	if self.sets.showText then
		self.cast.Time:Show()
	else
		self.cast.Time:Hide()
	end
	self.cast:AdjustWidth()
end

function CastBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	local time = panel:NewCheckButton(RazerNaga_SHOW_TIME)
	time:SetScript('OnClick', function(b) self:ToggleText(b:GetChecked()) end)
	time:SetScript('OnShow', function(b) b:SetChecked(self.sets.showText) end)

	panel:NewOpacitySlider()
	panel:NewFadeSlider()
	panel:NewScaleSlider()
	panel:NewPaddingSlider()

	self.menu = menu
end

function CastBar:Layout()
	self:SetWidth(max(self.cast:GetWidth() + 4 + self:GetPadding()*2, 8))
	self:SetHeight(max(24 + self:GetPadding()*2, 8))
end

--[[ CastingBar Object ]]--

CastingBar = RazerNaga:CreateClass('StatusBar')

local BORDER_SCALE = 197/150
local TEXT_PADDING = 18

function CastingBar:New(parent)
	local f = self:Bind(CreateFrame('StatusBar', 'RazerNagaCastingBar', parent, 'RazerNagaCastingBarTemplate'))
	f:SetPoint('CENTER')

	f.normalWidth = f:GetWidth()
	f:SetScript('OnUpdate', f.OnUpdate)
	f:SetScript('OnEvent', f.OnEvent)

	return f
end

function CastingBar:OnEvent(event, ...)
	CastingBarFrame_OnEvent(self, event, ...)

	local unit, spell = ...
	if unit == self.unit then
		if event == 'UNIT_SPELLCAST_FAILED' or event == 'UNIT_SPELLCAST_INTERRUPTED' then
			self.failed = true
		elseif event == 'UNIT_SPELLCAST_START' or event == 'UNIT_SPELLCAST_CHANNEL_START' then
			self.failed = nil
		end
		self:UpdateColor(spell)
	end
end

function CastingBar:OnUpdate(elapsed)
	CastingBarFrame_OnUpdate(self, elapsed)

	if self.casting then
		self.Time:SetFormattedText('%.1f', self.maxValue - self.value)
		self:AdjustWidth()
	elseif self.channeling then
		self.Time:SetFormattedText('%.1f', self.value)
		self:AdjustWidth()
	end
end

function CastingBar:AdjustWidth()
	local textWidth = self.Text:GetStringWidth() + TEXT_PADDING
	local timeWidth = (self.Time:IsShown() and (self.Time:GetStringWidth() + 4) * 2) or 0
	local width = textWidth + timeWidth

	if width < self.normalWidth then
		width = self.normalWidth
	end

	local diff = math.abs(width - self:GetWidth())

	if diff > TEXT_PADDING then
		self:SetWidth(width)
		self.Border:SetWidth(width * BORDER_SCALE)
		self.Flash:SetWidth(width * BORDER_SCALE)

		self:GetParent():Layout()
	end
end

function CastingBar:UpdateColor(spell)
	if self.failed then
		self:SetStatusBarColor(0.86, 0.08, 0.24)
	elseif spell and IsHelpfulSpell(spell) then
		self:SetStatusBarColor(0.31, 0.78, 0.47)
	elseif spell and IsHarmfulSpell(spell) then
		self:SetStatusBarColor(0.63, 0.36, 0.94)
	else
		self:SetStatusBarColor(1, 0.7, 0)
	end
end

--hide the old casting bar
PlayerCastingBarFrame:UnregisterAllEvents()
PlayerCastingBarFrame:Hide()