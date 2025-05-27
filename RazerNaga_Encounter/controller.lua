local AddonName, Addon = ...
local EncounterBarModule = RazerNaga:NewModule('EncounterBar', 'AceEvent-3.0')

function EncounterBarModule:OnInitialize()
	_G['PlayerPowerBarAlt'].ignoreFramePositionManager = true
	
	local timer = CreateFrame('Frame')
	
	timer:Hide()
		
	timer:SetScript('OnUpdate', function()
		self:RepositionBar()
		timer:Hide()
	end)

	hooksecurefunc('UIParent_ManageFramePosition', function()
		timer:Show()
	end)
end

function EncounterBarModule:Load()
	self.frame = Addon.EncounterBar:New()
	self:RegisterEvent('PLAYER_REGEN_ENABLED')
end

function EncounterBarModule:Unload()
	self.frame:Free()
	self:UnregisterEvent('PLAYER_REGEN_ENABLED')
end

function EncounterBarModule:PLAYER_REGEN_ENABLED()
	if self.__NeedToRepositionBar then
		self:RepositionBar()
	end
end

function EncounterBarModule:RepositionBar()
	if InCombatLockdown() then
		self.__NeedToRepositionBar = true
		return 
	end
	
	if self.frame then
		self.frame:Layout()
		self.__NeedToRepositionBar = nil		
	end
end