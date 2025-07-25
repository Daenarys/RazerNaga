if not _G.PlayerPowerBarAlt then return end

local RazerNaga = _G[...]
local EncounterBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function EncounterBar:New()
	local frame = EncounterBar.proto.New(self, 'encounter')

	frame:ShowInOverrideUI(true)
	frame:ShowInPetBattleUI(true)
	frame:Layout()

	return frame
end

EncounterBar:Extend('OnCreate', function(self)
	self.frames = {}

	local ppb = PlayerPowerBarAlt
	if ppb then
		ppb:ClearAllPoints()
		ppb:SetParent(self)
		ppb:SetPoint('CENTER', self)

		if type(ppb.SetupPlayerPowerBarPosition) == "function" then
			hooksecurefunc(ppb, "SetupPlayerPowerBarPosition", function(bar)
				if bar:GetParent() ~= self then
					bar:SetParent(self)
					bar:ClearAllPoints()
					bar:SetPoint('CENTER', self)
				end
			end)
		end

		if type(UnitPowerBarAlt_SetUp) == "function" then
			hooksecurefunc("UnitPowerBarAlt_SetUp", function(bar)
				if bar.isPlayerBar and bar:GetParent() ~= self then
					bar:SetParent(self)
					bar:ClearAllPoints()
					bar:SetPoint('CENTER', self)
				end
			end)
		end

		ppb:HookScript("OnSizeChanged", function() self:Layout() end)

		self.frames[#self.frames+1] = ppb
	end
end)

function EncounterBar:GetDefaults()
	return { point = 'CENTER' }
end

-- always reparent + position the bar due to UIParent.lua moving it whenever its shown
function EncounterBar:Layout()
	for _, frame in pairs(self.frames) do
		local w, h = frame:GetSize()

		width = math.max(w, 36 * 6)
		height = math.max(h, 36)
	end

	if width > 0 and height > 0 then
		local pW, pH = self:GetPadding()
		self:TrySetSize(width + pW, height + pH)
	else
		self:TrySetSize(36 * 6, 36)
	end
end

-- module
local EncounterBarModule = RazerNaga:NewModule('EncounterBar', 'AceEvent-3.0')

function EncounterBarModule:Load()
	if self.frame == nil then
		self.frame = EncounterBar:New()
	end
end

function EncounterBarModule:Unload()
    if self.frame then
        self.frame:Free()
        self.frame = nil
    end
end

function EncounterBarModule:OnFirstLoad()
	local ppb = PlayerPowerBarAlt
	if ppb then
		-- the standard UI will check to see if the power bar is user placed before
		-- doing anything to its position, so mark as user placed to prevent that
		-- from happening
		ppb:SetMovable(true)
		ppb:SetUserPlaced(true)

		-- tell blizzard that we don't it to manage this frame's position
		ppb.ignoreFramePositionManager = true

		self:RegisterEvent("PLAYER_LOGOUT")
	end
end

function EncounterBarModule:PLAYER_LOGOUT()
	-- SetUserPlaced is persistent, so revert upon logout
	local ppb = PlayerPowerBarAlt
	if ppb then
		ppb:SetUserPlaced(false)
	end
end