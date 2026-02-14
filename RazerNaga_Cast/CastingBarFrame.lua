local CASTING_BAR_ALPHA_STEP = 0.05
local CASTING_BAR_FLASH_STEP = 0.2
local CASTING_BAR_HOLD_TIME = 1

function CastingBarFrame_OnLoad(self, unit, showTradeSkills)
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterUnitEvent("UNIT_SPELLCAST_START", unit)
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit)
	self:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit)

	self.unit = unit
	self.showTradeSkills = showTradeSkills
	self.casting = nil
	self.channeling = nil
	self.holdTime = 0
	self.showCastbar = true
end

function CastingBarFrame_OnEvent(self, event, ...)
	local arg1 = ...
	
	local unit = self.unit
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		local nameChannel = UnitChannelInfo(unit)
		local nameSpell = UnitCastingInfo(unit)
		if ( nameChannel ) then
			event = "UNIT_SPELLCAST_CHANNEL_START"
			arg1 = unit
		elseif ( nameSpell ) then
			event = "UNIT_SPELLCAST_START"
			arg1 = unit
		else
		    CastingBarFrame_FinishSpell(self)
		end
	end

	if ( arg1 ~= unit ) then
		return
	end

	if ( event == "UNIT_SPELLCAST_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			self:Hide()
			return
		end
		self:SetStatusBarTexture("ui-castingbar-filling-standard")
		self.Flash:SetAtlas("ui-castingbar-full-glow-standard")
		if ( self.Spark ) then
			self.Spark:Show()
		end
		self.value = (GetTime() - (startTime / 1000))
		self.maxValue = (endTime - startTime) / 1000
		self:SetMinMaxValues(0, self.maxValue)
		self:SetValue(self.value)
		if ( self.Text ) then
			self.Text:SetText(text)
		end
		self:SetAlpha(1.0)
		self.holdTime = 0
		self.casting = true
		self.castID = castID
		self.channeling = nil
		self.fadeOut = nil
		if ( self.showCastbar ) then
			self:Show()
		end
	elseif ( event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP") then
		if ( not self:IsVisible() ) then
			self:Hide()
		end
		if ( (self.casting and event == "UNIT_SPELLCAST_STOP" and select(2, ...) == self.castID) or
		     (self.channeling and event == "UNIT_SPELLCAST_CHANNEL_STOP") ) then
			if ( self.Spark ) then
				self.Spark:Hide()
			end
			if ( self.Flash ) then
				self.Flash:SetAlpha(0.0)
				self.Flash:Show()
			end
			self:SetValue(self.maxValue)
			if ( event == "UNIT_SPELLCAST_STOP" ) then
				self.casting = nil
			else
				self.channeling = nil
			end
			self.flash = true
			self.fadeOut = true
			self.holdTime = 0
		end
	elseif ( event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" ) then
		if ( self:IsShown() and
		     (self.casting and select(2, ...) == self.castID) and not self.fadeOut ) then
			self:SetValue(self.maxValue)
			self:SetStatusBarTexture("ui-castingbar-interrupted")
			if ( self.Spark ) then
				self.Spark:Hide()
			end
			if ( self.Text ) then
				if ( event == "UNIT_SPELLCAST_FAILED" ) then
					self.Text:SetText(FAILED)
				else
					self.Text:SetText(INTERRUPTED)
				end
			end
			self.casting = nil
			self.channeling = nil
			self.fadeOut = true
			self.holdTime = GetTime() + CASTING_BAR_HOLD_TIME
		end
	elseif ( event == "UNIT_SPELLCAST_DELAYED" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				self:Hide()
				return
			end
			self.value = (GetTime() - (startTime / 1000))
			self.maxValue = (endTime - startTime) / 1000
			self:SetMinMaxValues(0, self.maxValue)
			if ( not self.casting ) then
				self:SetStatusBarTexture("ui-castingbar-filling-standard")
				if ( self.Spark ) then
					self.Spark:Show()
				end
				if ( self.Flash ) then
					self.Flash:SetAlpha(0.0)
					self.Flash:Hide()
				end
				self.casting = true
				self.channeling = nil
				self.flash = nil
				self.fadeOut = nil
			end
		end
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID, _, numStages = UnitChannelInfo(unit)
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			self:Hide()
			return
		end
		self:SetStatusBarTexture("ui-castingbar-filling-channel")
		self.Flash:SetAtlas("ui-castingbar-full-glow-channel")
		self.value = ((endTime / 1000) - GetTime())
		self.maxValue = (endTime - startTime) / 1000
		self:SetMinMaxValues(0, self.maxValue)
		self:SetValue(self.value)
		if ( self.Text ) then
			self.Text:SetText(text)
		end
		if ( self.Spark ) then
			self.Spark:Hide()
		end
		self:SetAlpha(1.0)
		self.holdTime = 0
		self.casting = nil
		self.channeling = true
		self.fadeOut = nil
		if ( self.showCastbar ) then
			self:Show()
		end
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_UPDATE" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				self:Hide()
				return
			end
			self.value = ((endTime / 1000) - GetTime())
			self.maxValue = (endTime - startTime) / 1000
			self:SetMinMaxValues(0, self.maxValue)
			self:SetValue(self.value)
		end
	end
end

function CastingBarFrame_OnUpdate(self, elapsed)
	if ( self.casting ) then
		self.value = self.value + elapsed
		if ( self.value >= self.maxValue ) then
			self:SetValue(self.maxValue)
			CastingBarFrame_FinishSpell(self)
			return
		end
		self:SetValue(self.value)
		if ( self.Flash ) then
			self.Flash:Hide()
		end
		if ( self.Spark ) then
			local sparkPosition = (self.value / self.maxValue) * self:GetWidth()
			self.Spark:SetPoint("CENTER", self, "LEFT", sparkPosition, 0)
		end
	elseif ( self.channeling ) then
		self.value = self.value - elapsed
		if ( self.value <= 0 ) then
			CastingBarFrame_FinishSpell(self)
			return
		end
		self:SetValue(self.value)
		if ( self.Flash ) then
			self.Flash:Hide()
		end
	elseif ( GetTime() < self.holdTime ) then
		return
	elseif ( self.flash ) then
		local alpha = 0
		if ( self.Flash ) then
			alpha = self.Flash:GetAlpha() + CASTING_BAR_FLASH_STEP
		end
		if ( alpha < 1 ) then
			if ( self.Flash ) then
				self.Flash:SetAlpha(alpha)
			end
		else
			if ( self.Flash ) then
				self.Flash:SetAlpha(1.0)
			end
			self.flash = nil
		end
	elseif ( self.fadeOut ) then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP
		if ( alpha > 0 ) then
			self:SetAlpha(alpha)
		else
			self.fadeOut = nil
			self:Hide()
		end
	end
end

function CastingBarFrame_FinishSpell(self)
	self:SetStatusBarTexture("ui-castingbar-full-channel")
	if ( self.Spark ) then
		self.Spark:Hide()
	end
	if ( self.Flash ) then
		self.Flash:SetAtlas("ui-castingbar-full-glow-channel")
		self.Flash:SetAlpha(0.0)
		self.Flash:Show()
	end
	self.flash = true
	self.fadeOut = true
	self.casting = nil
	self.channeling = nil
end