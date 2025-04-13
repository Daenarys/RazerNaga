--[[
	Timer Prototype
--]]

local TimerParent = CreateFrame('Frame')

local function Updater_OnFinished(self, ...)
	-- print('Updater_OnFinished', ...)

	self.owner:OnFinished(...)
end

local function Updater_Create(owner)
	-- print('Updater_Create', owner)

	local updater = TimerParent:CreateAnimationGroup()
	updater.owner = owner

	updater:SetLooping('NONE')
	updater:SetScript('OnFinished', Updater_OnFinished)

	local ani = updater:CreateAnimation('Animation')
	ani:SetOrder(1)	
	updater.ani = ani

	return updater
end

local TimerPrototype = {
	delay = 1, --default timer delay, in seconds

	__index = function(self, key)
		return getmetatable(self)[key]
	end,

	GetOrCreateUpdater = function(self)
		local updater = self.updater

		if not updater then
			updater = Updater_Create(self)
			self.updater = updater
		end

		return updater
	end,

	Start = function(self)
		-- print('Timer.Start', self)
		self:Stop()

		local updater = self:GetOrCreateUpdater()
		updater.ani:SetDuration(self.delay)
		updater:Play()
	end,

	Stop = function(self)
		if self:IsRunning() then
			-- print('Timer.Stop', self)
			self.updater:Stop()
		end
	end,

	IsRunning = function(self)
		local result = false
		local updater = self.updater

		if updater then
			result = updater:IsPlaying()
		end

		-- print('Timer.IsRunning', result)
		return result
	end,

	OnFinished = function(self, ...)
		error(2, 'OnFinished was not implemented')
	end
}


--[[
	Timer
--]]

local Timer = {}; RazerNaga.Timer = Timer

function Timer:New(obj)
	return setmetatable(obj or {}, TimerPrototype)
end