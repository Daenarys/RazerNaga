--[[
	fadeManager.lua
		Handles fading out frames when not moused over
		Necessary since using the blizzard fading functions can cause issues in combat
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')

--[[ Code to watch frames as they're moused over ]]--

local watched = {}

local MouseOverWatcher = RazerNaga.Timer:New()

MouseOverWatcher.delay = 0.15

function MouseOverWatcher:OnFinished()
	for f in pairs(watched) do
		if f:IsFocus() then
			if not f.focused then
				f.focused = true
				f:Fade()
			end
		else
			if f.focused then
				f.focused = nil
				f:Fade()
			end
		end
	end

	if next(watched) then
		self:Start()
	end
end

function MouseOverWatcher:Add(f)
	if watched[f] then return end

	watched[f] = true
	f.focused = f:IsFocus() and true or nil
	f:UpdateAlpha()

	if not self:IsRunning() then
		self:Start()
	end
end

function MouseOverWatcher:Remove(f)
	if not watched[f] then return end

	watched[f] = nil
	f.focused = nil
	f:UpdateAlpha()
end

RazerNaga.MouseOverWatcher = MouseOverWatcher