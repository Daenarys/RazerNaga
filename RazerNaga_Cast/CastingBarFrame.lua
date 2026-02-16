RAZERNAGA_CASTING_BAR_TYPES = {
	applyingcrafting = { 
		filling = "ui-castingbar-filling-applyingcrafting",
		full = "ui-castingbar-full-applyingcrafting",
		glow = "ui-castingbar-full-glow-applyingcrafting",
	},
	applyingtalents = { 
		filling = "ui-castingbar-filling-standard",
		full = "ui-castingbar-full-standard",
		glow = "ui-castingbar-full-glow-standard",
	},
	standard = { 
		filling = "ui-castingbar-filling-standard",
		full = "ui-castingbar-full-standard",
		glow = "ui-castingbar-full-glow-standard",
	},
	empowered = { 
		filling = "",
		full = "",
		glow = "",
	},
	channel = { 
		filling = "ui-castingbar-filling-channel",
		full = "ui-castingbar-full-channel",
		glow = "ui-castingbar-full-glow-channel",
	},
	uninterruptable = {
		filling = "ui-castingbar-uninterruptable",
		full = "ui-castingbar-uninterruptable",
		glow = "ui-castingbar-full-glow-standard",
	},
	interrupted = { 
		filling = "ui-castingbar-interrupted",
		full = "ui-castingbar-interrupted",
		glow = "ui-castingbar-full-glow-standard",
	},
}

RazerNagaCastingBarMixin = {}

function RazerNagaCastingBarMixin:OnLoad(unit, showTradeSkills, showShield)
	self:SetUnit(unit, showTradeSkills, showShield)

	self.showCastbar = true

	local point, relativeTo, relativePoint, offsetX, offsetY = self.Spark:GetPoint(1)
	if ( point == "CENTER" ) then
		self.Spark.offsetY = offsetY
	end
end

function RazerNagaCastingBarMixin:UpdateShownState(desiredShow)
	if desiredShow ~= nil then
		self:SetShown(desiredShow)
		return
	end

	self:SetShown(self.casting and self:ShouldShowCastBar())
end

function RazerNagaCastingBarMixin:SetUnit(unit, showTradeSkills, showShield)
	if self.unit ~= unit then
		self.unit = unit
		self.showTradeSkills = showTradeSkills
		self.showShield = showShield

		self.casting = nil
		self.channeling = nil
		self.reverseChanneling = nil
		
		self:StopAnims()

		if unit then
			self:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_DELAYED", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_UPDATE", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_STOP", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_START", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_UPDATE", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_EMPOWER_STOP", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_START", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", unit)
			self:RegisterUnitEvent("UNIT_SPELLCAST_FAILED", unit)
			self:RegisterEvent("PLAYER_ENTERING_WORLD")

			self:OnEvent("PLAYER_ENTERING_WORLD")
		else
			self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
			self:UnregisterEvent("UNIT_SPELLCAST_DELAYED")
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
			self:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
			self:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_START")
			self:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_UPDATE")
			self:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_STOP")
			self:UnregisterEvent("UNIT_SPELLCAST_START")
			self:UnregisterEvent("UNIT_SPELLCAST_STOP")
			self:UnregisterEvent("UNIT_SPELLCAST_FAILED")
			self:UnregisterEvent("PLAYER_ENTERING_WORLD")

			local desiredShowFalse = false
			self:UpdateShownState(desiredShowFalse)
		end
	end
end

function RazerNagaCastingBarMixin:GetEffectiveType(isChannel, notInterruptible, isTradeSkill, isEmpowered)
	if isTradeSkill then
		return "applyingcrafting"
	end
	if notInterruptible then
		return "uninterruptable"
	end
	if isChannel then
		return "channel"
	end
	if isEmpowered then
		return "empowered"
	end
	return "standard"
end

function RazerNagaCastingBarMixin:GetTypeInfo(barType)
	if not barType then
		barType = "standard"
	end
	return RAZERNAGA_CASTING_BAR_TYPES[barType]
end

function RazerNagaCastingBarMixin:HandleInterruptOrSpellFailed(empoweredInterrupt, event, ...)
	if ( empoweredInterrupt or (self:IsShown() and (self.casting and select(2, ...) == self.castID) and (not self.FadeOutAnim or not self.FadeOutAnim:IsPlaying()))) then
		self.barType = "interrupted" -- failed and interrupted use same bar art

		--We don't want to show the full state for the empowered texture since it produces a gradient.
		self:SetStatusBarTexture(empoweredInterrupt and nil or self:GetTypeInfo(self.barType).full)

		self:ShowSpark()

		if ( self.Text ) then
			if ( event == "UNIT_SPELLCAST_FAILED" ) then
				self.Text:SetText(FAILED)
			else
				self.Text:SetText(INTERRUPTED)
			end
		end

		self.casting = nil
		self.channeling = nil
		self.reverseChanneling = nil

		self:PlayInterruptAnims()
	end
end 

function RazerNagaCastingBarMixin:HandleCastStop(event, ...)
	if ( not self:IsVisible() ) then
		local desiredShowFalse = false
		self:UpdateShownState(desiredShowFalse)
	end
	if ( (self.casting and event == "UNIT_SPELLCAST_STOP" and select(2, ...) == self.castID) or
	    ((self.channeling or self.reverseChanneling) and (event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_EMPOWER_STOP")) ) then
		
		local castComplete = select(4, ...)
		if(event == "UNIT_SPELLCAST_EMPOWER_STOP" and not castComplete) then
			self:HandleInterruptOrSpellFailed(true, event, ...)
			return 
		end 
		
		-- Cast info not available once stopped, so update bar based on cached barType
		local barTypeInfo = self:GetTypeInfo(self.barType)
		self:SetStatusBarTexture(barTypeInfo.full)

		if not self.reverseChanneling then
			self:HideSpark()
		end

		if ( self.Flash ) then
			self.Flash:SetAtlas(barTypeInfo.glow)
			self.Flash:SetAlpha(0.0)
			self.Flash:Show()
		end
		if not self.reverseChanneling and not self.channeling then
			self:SetValue(self.maxValue)
		end

		self:PlayFadeAnim()

		if ( event == "UNIT_SPELLCAST_STOP" ) then
			self.casting = nil
		else
			self.channeling = nil
			if (self.reverseChanneling) then
				self.casting = nil
			end
			self.reverseChanneling = nil
		end
	end
end

function RazerNagaCastingBarMixin:OnEvent(event, ...)
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
		    self:FinishSpell()
		end
	end

	if ( arg1 ~= unit ) then
		return
	end

	if ( event == "UNIT_SPELLCAST_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			local desiredShowFalse = false
			self:UpdateShownState(desiredShowFalse)
			return
		end

		self.barType = self:GetEffectiveType(false, notInterruptible, isTradeSkill, false)
		self:SetStatusBarTexture(self:GetTypeInfo(self.barType).filling)

		self:ShowSpark()

		self.value = (GetTime() - (startTime / 1000))
		self.maxValue = (endTime - startTime) / 1000
		self:SetMinMaxValues(0, self.maxValue)
		self:SetValue(self.value)
		if ( self.Text ) then
			self.Text:SetText(text)
		end
		self.casting = true
		self.castID = castID
		self.channeling = nil
		self.reverseChanneling = nil
		
		self:StopAnims()
		self:ApplyAlpha(1.0)

		self:UpdateShownState(self:ShouldShowCastBar())
	elseif ( event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_EMPOWER_STOP") then
		self:HandleCastStop(event, ...)
	elseif ( event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" ) then
		self:HandleInterruptOrSpellFailed(false, event, ...)
	elseif ( event == "UNIT_SPELLCAST_DELAYED" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill, castID, notInterruptible = UnitCastingInfo(unit)
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				local desiredShowFalse = false
				self:UpdateShownState(desiredShowFalse)
				return
			end
			self.value = (GetTime() - (startTime / 1000))
			self.maxValue = (endTime - startTime) / 1000
			self:SetMinMaxValues(0, self.maxValue)
			if ( not self.casting ) then
				self.barType = self:GetEffectiveType(false, notInterruptible, isTradeSkill, false)
				self:SetStatusBarTexture(self:GetTypeInfo(self.barType).filling)
				self:ShowSpark()
				if ( self.Flash ) then
					self.Flash:SetAlpha(0.0)
					self.Flash:Hide()
				end
				self.casting = true
				self.channeling = nil
				self.reverseChanneling = nil

				self:StopAnims()
			end
		end
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_START" or event == "UNIT_SPELLCAST_EMPOWER_START" ) then
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID, _, numStages = UnitChannelInfo(unit)
		if ( not name or (not self.showTradeSkills and isTradeSkill)) then
			-- if there is no name, there is no bar
			local desiredShowFalse = false
			self:UpdateShownState(desiredShowFalse)
			return
		end

		self.maxValue = (endTime - startTime) / 1000

		self.barType = self:GetEffectiveType(not isChargeSpell, notInterruptible, isTradeSkill, isChargeSpell)

		self:SetStatusBarTexture(self:GetTypeInfo(self.barType).filling)
		
		if (isChargeSpell) then
			self.value = GetTime() - (startTime / 1000)
		else
			self.value = (endTime / 1000) - GetTime()
		end

		self:ShowSpark()

		self:SetMinMaxValues(0, self.maxValue)
		self:SetValue(self.value)
		if ( self.Text ) then
			self.Text:SetText(text)
		end
		if (isChargeSpell) then
			self.reverseChanneling = true
			self.casting = true
			self.channeling = false
		else
			self.reverseChanneling = nil
			self.casting = nil
			self.channeling = true
		end
		
		self:StopAnims()
		self:ApplyAlpha(1.0)

		self:UpdateShownState(self:ShouldShowCastBar())
	elseif ( event == "UNIT_SPELLCAST_CHANNEL_UPDATE" or event == "UNIT_SPELLCAST_EMPOWER_UPDATE" ) then
		if ( self:IsShown() ) then
			local name, text, texture, startTime, endTime, isTradeSkill = UnitChannelInfo(unit)
			if ( not name or (not self.showTradeSkills and isTradeSkill)) then
				-- if there is no name, there is no bar
				local desiredShowFalse = false
				self:UpdateShownState(desiredShowFalse)
				return
			end
			self.value = ((endTime / 1000) - GetTime())
			self.maxValue = (endTime - startTime) / 1000
			self:SetMinMaxValues(0, self.maxValue)
			self:SetValue(self.value)
		end
	end
end

function RazerNagaCastingBarMixin:OnUpdate(elapsed)
	if ( self.casting or self.reverseChanneling) then
		self.value = self.value + elapsed
		if ( self.value >= self.maxValue ) then
			self:SetValue(self.maxValue)
			if (not self.reverseChanneling) then
				self:FinishSpell()
			else
				if self.FlashLoopingAnim and not self.FlashLoopingAnim:IsPlaying() then
					self.FlashLoopingAnim:Play()
					self.Flash:Show()
				end
			end
			self:HideSpark()
			return
		end
		self:SetValue(self.value)
		if ( self.Flash ) then
			self.Flash:Hide()
		end
	elseif ( self.channeling ) then
		self.value = self.value - elapsed
		if ( self.value <= 0 ) then
			self:FinishSpell()
			return
		end
		self:SetValue(self.value)
		if ( self.Flash ) then
			self.Flash:Hide()
		end
	end

	if ( self.casting or self.reverseChanneling or self.channeling ) then
		if ( self.Spark ) then
			local sparkPosition = (self.value / self.maxValue) * self:GetWidth()
			self.Spark:SetPoint("CENTER", self, "LEFT", sparkPosition, self.Spark.offsetY or 0)
		end
	end
end

function RazerNagaCastingBarMixin:ApplyAlpha(alpha)
	self:SetAlpha(alpha)
end

function RazerNagaCastingBarMixin:FinishSpell()
	if self.maxValue and not self.reverseChanneling and not self.channeling then
		self:SetValue(self.maxValue)
	end
	local barTypeInfo = self:GetTypeInfo(self.barType)
	self:SetStatusBarTexture(barTypeInfo.full)

	self:HideSpark()

	if ( self.Flash ) then
		self.Flash:SetAtlas(barTypeInfo.glow)
		self.Flash:SetAlpha(0.0)
		self.Flash:Show()
	end
	
	self:PlayFadeAnim()
	
	self.casting = nil
	self.channeling = nil
	self.reverseChanneling = nil
end

function RazerNagaCastingBarMixin:ShowSpark()
	if ( self.Spark ) then
		self.Spark:Show()
	end

	local currentBarType = self.barType

	if currentBarType == "interrupted" then
		self.Spark:SetAtlas("ui-castingbar-pip-red")
		self.Spark.offsetY = 0
	elseif currentBarType == "empowered" then
		self.Spark:SetAtlas("ui-castingbar-empower-cursor")
		self.Spark.offsetY = 4
	else
		self.Spark:SetAtlas("ui-castingbar-pip")
		self.Spark.offsetY = 0
	end
end

function RazerNagaCastingBarMixin:HideSpark()
	if ( self.Spark ) then
		self.Spark:Hide()
	end
end

function RazerNagaCastingBarMixin:PlayInterruptAnims()
	if self.HoldFadeOutAnim then
		self.HoldFadeOutAnim:Play()
	end
end

function RazerNagaCastingBarMixin:StopInterruptAnims()
	if self.HoldFadeOutAnim then
		self.HoldFadeOutAnim:Stop()
	end
end

function RazerNagaCastingBarMixin:PlayFadeAnim()
	if self.FadeOutAnim and self:GetAlpha() > 0 and self:IsVisible() then
		if self.reverseChanneling and self.CurrSpellStage < self.NumStages then
			self.HoldFadeOutAnim:Play()
		else
			self.FadeOutAnim:Play()
		end
	end
end

function RazerNagaCastingBarMixin:StopFinishAnims()
	if self.FadeOutAnim then
		self.FadeOutAnim:Stop()
	end
end

function RazerNagaCastingBarMixin:StopAnims()
	self:StopInterruptAnims()
	self:StopFinishAnims()
end

function RazerNagaCastingBarMixin:ShouldShowCastBar()
	return self.showCastbar and (self.unit ~= nil)
end