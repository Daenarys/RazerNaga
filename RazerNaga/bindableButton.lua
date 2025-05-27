--[[
	bindableButton.lua
		An abstract button class used to allow keybound to work transparently on both the stock blizzard bindings, and click bindings
--]]

--[[ Globals ]]--

local _G = _G
local RazerNaga = _G['RazerNaga']
local KeyBound = LibStub('LibKeyBound-1.0')


--[[ Class ]]--

local BindableButton = RazerNaga:CreateClass('CheckButton'); RazerNaga.BindableButton = BindableButton

--there's a nice assumption here: all hotkey text will use the same naming convention
--the call here is wacky because this functionality is actually called for the blizzard buttons _before_ I'm able to bind the action button methods to them
function BindableButton:UpdateHotkey(buttonType)
	local key = BindableButton.GetHotkey(self, buttonType)
	
	self.HotKey:SetSize(36, 10)
	
	if key ~= ''  and RazerNaga:ShowBindingText() and self.buttonType == 'BONUSACTIONBUTTON' then
		self.HotKey:SetText(key)
		self.HotKey:Show()
		self.HotKey:ClearAllPoints()
		self.HotKey:SetPoint("TOPLEFT", -2, -3)
	elseif key ~= ''  and RazerNaga:ShowBindingText() and self.buttonType == 'SHAPESHIFTBUTTON' then
		self.HotKey:SetText(key)
		self.HotKey:Show()
		self.HotKey:ClearAllPoints()
		self.HotKey:SetPoint("TOPLEFT", -1, -3)
	elseif key ~= ''  and RazerNaga:ShowBindingText() then
		self.HotKey:SetText(key)
		self.HotKey:Show()
		self.HotKey:ClearAllPoints()
		self.HotKey:SetPoint("TOPLEFT", 1, -3)
	else
		self.HotKey:SetText('') --blank out non blank text, such as RANGE_INDICATOR
		self.HotKey:Hide()
	end
end

--returns what hotkey to display for the button
--priority is auto binding set key, then blizzard binding key, then click binding key
function BindableButton:GetHotkey(buttonType)
	local key = BindableButton.GetAutoBindingDisplayKey(self) or BindableButton.GetBlizzBindings(self, buttonType) or BindableButton.GetClickBindings(self)
	return key and KeyBound:ToShortKey(tostring(key)) or ''
end

--returns all blizzard bindings assigned to the button
function BindableButton:GetBlizzBindings(buttonType)
	local buttonType = buttonType or self.buttonType
	if buttonType then
		local id = self:GetAttribute('bindingid') or self:GetID()
		return GetBindingKey(buttonType .. id)
	end
end

--returns all click bindings assigned to the button
function BindableButton:GetClickBindings()
	return GetBindingKey(('CLICK %s:LeftButton'):format(self:GetName()))
end

--returns a comma separated list of all bindings for the given action button
--used for keybound support
do
	local strjoin = string.join
	local select = select
	local unpack = unpack
	local _mapTemp = {}

	local function map(func, ...)
		for k, v in pairs(_mapTemp) do
			_mapTemp[k] = nil
		end

		for i = 1, select('#', ...) do
			local arg = (select(i, ...))
			_mapTemp[i] = func(arg)
		end

		return unpack(_mapTemp)
	end

	local function getKeyStrings(...)
		return strjoin(', ', map(GetBindingText, ...))
	end

	function BindableButton:GetBindings()
		local blizzKeys = getKeyStrings(self:GetBlizzBindings())
		local clickKeys = getKeyStrings(self:GetClickBindings())

		if blizzKeys then
			if clickKeys then
				return strjoin(', ', blizzKeys, clickKeys)
			end
			return blizzKeys
		else
			return clickKeys
		end
	end
end

--set bindings (more keybound support)
function BindableButton:SetKey(key)
	if self.buttonType then
		local id = self:GetAttribute('bindingid') or self:GetID()
		SetBinding(key, self.buttonType .. id)
	else
		SetBindingClick(key, self:GetName(), 'LeftButton')
	end
end

--clears all bindings from the button (keybound support again)
local function ClearBindings(...)
	for i = 1, select('#', ...) do
		SetBinding(select(i, ...), nil)
	end
end

function BindableButton:ClearBindings()
	ClearBindings(self:GetBlizzBindings())
	ClearBindings(self:GetClickBindings())
end


--[[ lynn auto binding settings, for display override purposes ]]--

function BindableButton:SetAutoBinding(key)
	self:SetAutoBindingDisplayKey(key)
	self:SetKey(key)
end

function BindableButton:SetAutoBindingDisplayKey(key)
	self.autoBinding = key
end

function BindableButton:ClearAutoBindingDisplayKey()
	self:SetAutoBindingDisplayKey(nil)
end

function BindableButton:GetAutoBindingDisplayKey()
	return self.autoBinding
end