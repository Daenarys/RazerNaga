--[[ Globals ]]--

local AddonName, Addon = ...
local Timer = RazerNaga.Timer
local unpack = unpack

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


--[[ Debounce ]]--

local Debounce = {}; RazerNaga.Debounce = Debounce

Debounce.DefaultDelay = 0.1 --how long to wait between calls, in seconds

setmetatable(Debounce, {
	__call = function(self, ...)
		return self:New(...)
	end
})

function Debounce:New(func, wait, isImmediate)
	local args, argCount

	local timer = Timer:New{
		delay = wait,

		OnFinished = function(self)
			if not isImmediate then
				if argCount > 1 then
					func(unpack(args, 1, argCount))
				elseif argCount > 0 then
					func(args)
				else
					func()
				end
			end		
		end 
	}

	return function(...)
	    local callNow = isImmediate and not timer:IsRunning()

	    if not timer:IsRunning() then
	    	timer:Start()
		end

	    if callNow then
	    	func(...)
	    else
	    	-- a minor optimization to make sure that we don't create
	    	-- a billion tables if the user is never passing more than one argument to the function
	    	argCount = select('#', ...)
	    	if argCount > 1 then
	    		args = { ... }
	    	else
	    		args = ...
	    	end
	    end
	end
end