--[[
	controller.lua
		the controller for the RazerNaga encounter bar
--]]

--[[ globals ]]--

local AddonName, Addon = ...
local EncounterBarModule = RazerNaga:NewModule('EncounterBar', 'AceEvent-3.0')


--[[ controller ]]--

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
	-- SetUserPlaced is persistent, so revert upon logout
	PlayerPowerBarAlt:SetUserPlaced(false)
end

function EncounterBarModule:OnFirstLoad()
	-- tell blizzard that we don't it to manage this frame's position
	-- PlayerPowerBarAlt.ignoreFramePositionManager = true

	-- the standard UI will check to see if the power bar is user placed before
	-- doing anything to its position, so mark as user placed to prevent that
	-- from happening
	PlayerPowerBarAlt:SetMovable(true)
	PlayerPowerBarAlt:SetUserPlaced(true)

	-- onshow/hide call UpdateManagedFramePositions on the blizzard end so turn
	-- that bit off
	PlayerPowerBarAlt:SetScript("OnShow", nil)
	PlayerPowerBarAlt:SetScript("OnHide", nil)

	self:RegisterEvent("PLAYER_LOGOUT")
end