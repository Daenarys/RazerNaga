--[[
	T-Panel Watcher
		Methods for constantly checking to determine if a T-Panel needs to be displayed near a T-Bar or not
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi')
local TPanelWatcher = RazerNaga.Timer:New(); Anansi.TPanelWatcher = TPanelWatcher
local watched = {}

TPanelWatcher.delay = 0.15


--[[ events ]]--

function TPanelWatcher:OnFinished()
	self:Update()
	
	if next(watched) and Anansi:CanShowTPanel() then
		self:Start()
	end
end

function TPanelWatcher:Update()
	for frame in pairs(watched) do
		Anansi:UpdateTPanelShown(frame)
	end
end


--[[ general tracking ]]--

function TPanelWatcher:Enable()
	if not self:IsRunning() then
		self:Start()
	end
end

function TPanelWatcher:Disable()
	if self:IsRunning() then
		self:Update()
		self:Stop()
	end
end

function TPanelWatcher:UpdateEnabled()
	if next(watched) and Anansi:CanShowTPanel() then
		self:Enable()
	else
		self:Disable()
	end
end


--[[ frame tracking ]]--

function TPanelWatcher:Watch(frame)
	if watched[frame] then return end

	watched[frame] = true
	self:UpdateEnabled()
end

function TPanelWatcher:Ignore(frame)
	if not watched[frame] then return end

	watched[frame] = nil
	self:UpdateEnabled()
end

function TPanelWatcher:UpdateWatch(frame)
	if Anansi:GetFrameTKey(frame) then
		self:Watch(frame)
	else
		self:Ignore(frame)
	end
end

function TPanelWatcher:UpdateWatchForAll()
	for id, frame in RazerNaga.Frame:GetAll() do
		self:UpdateWatch(frame)
	end
end