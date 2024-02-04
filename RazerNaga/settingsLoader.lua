--[[
	settingsLoader.lua
		Methods for loading RazerNaga settings
--]]

local SettingsLoader = {}
RazerNaga.SettingsLoader = SettingsLoader

--[[ Local Functions ]]--

--performs a deep table copy
local function tCopy(to, from)
	for k, v in pairs(from) do
		if type(v) == 'table' then
			to[k] = {}
			tCopy(to[k], v);
		else
			to[k] = v;
		end
	end
end

local function removeDefaults(tbl, defaults)
	for k, v in pairs(defaults) do
		if type(tbl[k]) == 'table' and type(v) == 'table' then
			removeDefaults(tbl[k], v)

			if next(tbl[k]) == nil then
				tbl[k] = nil
			end
		elseif tbl[k] == v then
			tbl[k] = nil
		end
	end
end

local function copyDefaults(tbl, defaults)
	for k, v in pairs(defaults) do
		if type(v) == 'table' then
			tbl[k] = copyDefaults(tbl[k] or {}, v)
		elseif tbl[k] == nil then
			tbl[k] = v
		end
	end
	return tbl
end


--[[ Methods ]]--

--loads the given set of settings into the current dominos profile
--any settings that are not contained in settings are not replaced
function SettingsLoader:LoadSettings(settings)
	--tempoarily turn off dominos
	RazerNaga:Unload()

	--copy layout settings
	local oldSettings = self:GetLayoutType() == '3x4' and self:GetThreeByFour() or self:GetFourByThree()
	removeDefaults(RazerNaga.db.profile, oldSettings)
	copyDefaults(RazerNaga.db.profile, settings)

	--reenable dominos
	RazerNaga:Load()
	RazerNaga.AutoBinder:EnforceBindings()

	--hack, need to do a slightly more advanced layout method for the class bar to place it properly across all resolutions
	-- local classBar = RazerNaga.Frame:Get('class')
	-- if classBar then
	-- 	if self:GetLayoutType() == '3x4' then
	-- 		classBar:SetFramePoint('BOTTOMLEFT', UIParent, 'BOTTOMRIGHT', -370, 270)
	-- 	elseif self:GetLayoutType() == '4x3' then
	-- 		classBar:SetFramePoint('BOTTOMLEFT', UIParent, 'BOTTOMRIGHT', -450, 230)
	-- 	end
	-- end
end

--replace any items in toTble that are in fromTbl

function SettingsLoader:ReplaceSettings(toTbl, fromTbl)
	if not fromTbl then return end

	for k, v in pairs(fromTbl) do
		local prevVal = toTbl[k]

		if type(v) == 'table' and type(prevVal) == 'table' then
			self:ReplaceSettings(toTbl[k], v)
		elseif type(v) == 'table' then
			toTbl[k] = {}
			tCopy(toTbl[k], v)
		else
			toTbl[k] = v
		end
	end
end

function SettingsLoader:GetLayoutType()
	return RazerNaga.db.profile.layoutType
end


--[[
	3x4 layout settings
--]]

function SettingsLoader:LoadThreeByFour()
	self.threeByFour = self.threeByFour or self:GetThreeByFour()
	self:LoadSettings(self.threeByFour)
end

function SettingsLoader:GetThreeByFour()
	--this is basically the raw output of the RazerNaga.lua saved variables
	--the only thing I removed was paging information as to not override the user's paging settings
	return {
		layoutType = '3x4',

		ab = {
			count = 10,
		},

		['frames'] = {
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -250,
				['y'] = 110,
				['enableAutoBinding'] = true,
				['autoBindingModifier'] = 'NONE'
			}, -- [1]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 110,
			}, -- [2]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 1,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'RIGHT',
				['spacing'] = 0,
				['x'] = 0,
				['y'] = 0,
			}, -- [3]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 1,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'RIGHT',
				['spacing'] = 0,
				['x'] = -40,
				['y'] = 0,
			}, -- [4]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 12,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = 270,
				['y'] = 52,
			}, -- [5]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 12,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = -270,
				['y'] = 52,
			}, -- [6]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -250,
				['y'] = 305,
			}, -- [7]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 305,
			}, -- [8]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -250,
				['y'] = 500,
			}, -- [9]
			{
			['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 500,
			}, -- [10]
			['cast'] = {
				['anchor'] = false,
				['hidden'] = false,
				['point'] = 'TOP',
				['showText'] = true,
				['x'] = 0,
				['y'] = -220,
			},
			['menu'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['point'] = 'BOTTOM',
				['x'] = 0,
				['y'] = 0,
			},
			['xp'] = {
				['alwaysShowText'] = true,
				['anchor'] = false,
				['height'] = 14,
				['hidden'] = false,
				['point'] = 'BOTTOM',
				['texture'] = 'blizzard',
				['width'] = 0.75,
				['x'] = 0,
				['y'] = 38,
			},
			['vehicle'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 3,
				['point'] = 'BOTTOM',
				['showstates'] = '[target=vehicle,exists]',
				['x'] = -190,
				['y'] = 0,
			},
			['bags'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 6,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = 250,
				['y'] = 0,
			},
			['pet'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 3,
				['hidden'] = false,
				['point'] = 'BOTTOMRIGHT',
				['showstates'] = '[target=pet,exists,nobonusbar:5]',
				['spacing'] = 6,
				['x'] = -400,
				['y'] = 110,
				['enableAutoBinding'] = true,
				['autoBindingModifier'] = 'CTRL'
			},
			['class'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 1,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -306,
				['y'] = 270,
			}
		},
	}
end


--[[
	4x3 layout settings
--]]

function SettingsLoader:LoadFourByThree()
	self.fourByThree = self.fourByThree or self:GetFourByThree()
	self:LoadSettings(self.fourByThree)
end

function SettingsLoader:GetFourByThree()
	return {
		layoutType = '4x3',

		ab = {
			count = 10,
		},

		['frames'] = {
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -290,
				['y'] = 110,
				['enableAutoBinding'] = true,
				['autoBindingModifier'] = 'NONE'
			}, -- [1]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 110,
			}, -- [2]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 1,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'RIGHT',
				['spacing'] = 0,
				['x'] = 0,
				['y'] = 0,
			}, -- [3]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 1,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'RIGHT',
				['spacing'] = 0,
				['x'] = -40,
				['y'] = 0,
			}, -- [4]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 12,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = 270,
				['y'] = 52,
			}, -- [5]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 12,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = -270,
				['y'] = 52,
			}, -- [6]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -290,
				['y'] = 265,
			}, -- [7]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 265,
			}, -- [8]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -290,
				['y'] = 420,
			}, -- [9]
			{
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['alpha'] = 0.9,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['numButtons'] = 12,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -100,
				['y'] = 420,
			}, -- [10]
			['cast'] = {
				['anchor'] = false,
				['hidden'] = false,
				['point'] = 'TOP',
				['showText'] = true,
				['x'] = 0,
				['y'] = -220,
			},
			['menu'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['point'] = 'BOTTOM',
				['x'] = 0,
				['y'] = 0,
			},
			['xp'] = {
				['alwaysShowText'] = true,
				['anchor'] = false,
				['height'] = 14,
				['hidden'] = false,
				['point'] = 'BOTTOM',
				['texture'] = 'blizzard',
				['width'] = 0.75,
				['x'] = 0,
				['y'] = 38,
			},
			['vehicle'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 3,
				['point'] = 'BOTTOM',
				['showstates'] = '[target=vehicle,exists]',
				['x'] = -190,
				['y'] = 0,
			},
			['bags'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 6,
				['point'] = 'BOTTOM',
				['spacing'] = 0,
				['x'] = 250,
				['y'] = 0,
			},
			['pet'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['columns'] = 4,
				['hidden'] = false,
				['point'] = 'BOTTOMRIGHT',
				['showstates'] = '[target=pet,exists,nobonusbar:5]',
				['spacing'] = 6,
				['x'] = -480,
				['y'] = 110,
				['enableAutoBinding'] = true,
				['autoBindingModifier'] = 'CTRL'
			},
			['class'] = {
				['isRightToLeft'] = false,
				['isBottomToTop'] = false,
				['anchor'] = false,
				['hidden'] = false,
				['numButtons'] = 1,
				['padH'] = 2,
				['padW'] = 2,
				['point'] = 'BOTTOMRIGHT',
				['spacing'] = 0,
				['x'] = -386,
				['y'] = 230,
			}
		},
	}
end