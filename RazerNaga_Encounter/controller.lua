local AddonName, Addon = ...
local EncounterBarModule = RazerNaga:NewModule('EncounterBar', 'AceEvent-3.0')

function EncounterBarModule:Load()
	if not self.loaded then
		self:OnFirstLoad()
		self.loaded = true
	end

	self.frame = Addon.EncounterBar:New()
end

function EncounterBarModule:Unload()
	self.frame:Free()
end

function EncounterBarModule:PLAYER_LOGOUT()
	PlayerPowerBarAlt:SetUserPlaced(false)
end

function EncounterBarModule:OnFirstLoad()
	PlayerPowerBarAlt:SetMovable(true)
	PlayerPowerBarAlt:SetUserPlaced(true)

	PlayerPowerBarAlt:SetScript("OnShow", nil)
	PlayerPowerBarAlt:SetScript("OnHide", nil)

	self:RegisterEvent("PLAYER_LOGOUT")
end