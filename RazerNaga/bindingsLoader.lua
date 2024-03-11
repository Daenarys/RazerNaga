--[[
	bindingsLoader.lua
		Methods for loading RazerNaga bindings
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local BindingsLoader = {}; RazerNaga.BindingsLoader = BindingsLoader
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

local AVAILABLE_MODIFIERS = {
	'NONE',
	'ALT',
	'CTRL',
	'SHIFT',
	'ALT-CTRL',
	'ALT-SHIFT',
	'CTRL-SHIFT',
	'ALT-CTRL-SHIFT'
}

local MODIFIER_NAMES = {
	['NONE'] = NONE,
	['CTRL'] = CTRL_KEY,
	['ALT'] = ALT_KEY,
	['SHIFT'] = SHIFT_KEY,
	['ALT-CTRL'] = L.AltKey .. '-' .. CTRL_KEY_TEXT,
	['CTRL-SHIFT'] = CTRL_KEY_TEXT .. '-' .. SHIFT_KEY_TEXT,
	['ALT-SHIFT'] = L.AltKey .. '-' .. SHIFT_KEY_TEXT,
	['ALT-CTRL-SHIFT'] = L.AltKey .. '-' .. CTRL_KEY_TEXT .. '-' .. SHIFT_KEY_TEXT
}

-- special case for wow post a 7.1 for shift + numpad
local SHIFT_KEY_MODIFIER_OVERRIDES = {
	NUMPAD1 = 'END',
	NUMPAD2 = 'DARROW',
	NUMPAD3 = 'PAGEDOWN',
	NUMPAD4 = 'LARROW',
	NUMPAD6 = 'RARROW',
	NUMPAD7 = 'HOME',
	NUMPAD8 = 'UARROW',
	NUMPAD9 = 'PAGEUP',
	NUMPAD0 = 'INSERT'
}

local bindingsSets = {}

local function isValidBlizzardBindingSet(bindingSet)
	return bindingSet == 1 or bindingSet == 2
end


--binding set registration
function BindingsLoader:AddBindingsSet(set)
	assert(set, 'No set provided')

	table.insert(bindingsSets, set)
end


function BindingsLoader:LoadBindings(set)
	assert(set, 'No set provided')

	if InCombatLockdown() then
		RazerNaga:Print(L.CannotAlterBindingsInCombat)
	end

	for id, frame in RazerNaga.Frame:GetAll() do
		local modifier = self:GetFrameModifier(frame)
		if modifier and self:IsAutoBindingEnabled(frame) then
			self:AssignBindingsToFrame(frame, set.bindings, modifier)
		end
	end

	local bindingSet = GetCurrentBindingSet()
	if isValidBlizzardBindingSet(bindingSet) then
		SaveBindings(bindingSet)
	end
end

function BindingsLoader:AssignBindingsToFrame(frame, bindings, modifier)
	assert(frame and bindings and modifier, 'Usage: BindingsLoader:AssignBindingsToFrame(frame, bindings, modifier)')

	for i = 1, min(#bindings, frame:NumButtons()) do
		local key = bindings[i]
		local override = SHIFT_KEY_MODIFIER_OVERRIDES[key]
		local modifier = modifier

		if override and modifier:match('SHIFT') then
			modifier = modifier:gsub('(%-?SHIFT)', '')
			key = override
		end

		if modifier and modifier ~= '' and modifier ~= 'NONE' then
			key = modifier .. '-' .. key
		end

		frame:GetButton(i):SetAutoBinding(key)
	end
end


--[[ Accessor Methods ]]--

--retrieves a the bindings set for the current layout based on the given id
--returns the set we're currently using
function BindingsLoader:SetBindingSetID(id)
	assert(id, 'No set id provided')

	RazerNaga.db.profile.bindingSet = id
	RazerNaga.AutoBinder:EnforceBindings()
end

function BindingsLoader:GetBindingsSetByID(id)
	assert(id, 'No set id provided')

	for i, set in self:GetAvailableBindingsSets() do
		if set.id == id then
			return set
		end
	end
	return nil
end

--returns the id of the current binding set we're using
function BindingsLoader:GetCurrentBindingsSetID()
	return RazerNaga.db.profile.bindingSet or 'Simple'
end

function BindingsLoader:GetCurrentBindingsSet()
	return self:GetBindingsSetByID(self:GetCurrentBindingsSetID())
end


--set iterators
local function getSetsForLayoutIterator(layout, i)
	for j = i + 1, #bindingsSets do
		local set = bindingsSets[j]
		if set and set.layout == layout then
			return j, set
		end
	end
end

--return an iterator for all sets for the current layout
function BindingsLoader:GetAvailableBindingsSets()
	local layout = RazerNaga.SettingsLoader:GetLayoutType()
	return getSetsForLayoutIterator, layout, 0
end


--[[ Modifier Assignments, Frame -> Modifier ]]--

--helper methods for doing things without haivng to enforce bindings, since binding enforcement is a bit slow
local function clearAutoBindings(frame)
	for i = 1, frame:NumButtons() do
		frame:GetButton(i):ClearAutoBindingDisplayKey()
	end
end

local function setFrameModifier(frame, modifier)
	if frame then
		frame.sets.autoBindingModifier = modifier or false
		RazerNaga.Envoy:Send('FRAME_UPDATE_MODIFIER', frame, modifier)
	end
end

local function enableAutomaticBindings(frame)
	if frame then
		frame.sets.enableAutoBinding = true
		RazerNaga.Envoy:Send('FRAME_UPDATE_AUTO_BINDINGS', frame, true)
	end
end

local function disableAutomaticBindings(frame)
	if frame then
		clearAutoBindings(frame)
		frame.sets.enableAutoBinding = false
		RazerNaga.Envoy:Send('FRAME_UPDATE_AUTO_BINDINGS', frame, false)
	end
end

function BindingsLoader:SetFrameModifier(frame, modifier)
	assert(frame and modifier, 'Usage: BindingsLoader:SetFrameModifier(frame, modifier)')

	--handle case where we're removing a modifier assignment for a bar
	if self:IsAutoBindingEnabled(frame) then
		local prevFrame = self:GetActiveModifierAssignment(modifier)
		if prevFrame ~= frame then
			disableAutomaticBindings(prevFrame)
			setFrameModifier(frame, modifier)
			RazerNaga.AutoBinder:EnforceBindings()
		end
	else
		setFrameModifier(frame, modifier)
	end
end

function BindingsLoader:GetFrameModifier(frame)
	assert(frame, 'Usage: BindingsLoader:GetFrameModifier(frame)')
	return frame.sets.autoBindingModifier
end

function BindingsLoader:SetEnableAutoBinding(frame, enable)
	assert(frame, 'Usage: BindingsLoader:SetEnableAutoBinding(frame, enable)')

	if enable then
		local modifier = self:GetFrameModifier(frame)
		if modifier then
			local activeFrame = self:GetActiveModifierAssignment(modifier)
			if activeFrame then
				disableAutomaticBindings(activeFrame)
			end
		end
		enableAutomaticBindings(frame)
	else
		disableAutomaticBindings(frame)
	end
	RazerNaga.AutoBinder:EnforceBindings()
end

function BindingsLoader:IsAutoBindingEnabled(frame)
	assert(frame, 'Usage: BindingsLoader:GetFrameModifier(frame)')
	return frame.sets.enableAutoBinding
end


--[[ Modifier Listing ]]--

function BindingsLoader:GetActiveModifierAssignment(modifier)
	assert(modifier, 'Usage: BindingsLoader:GetActiveModifierAssignment(modifier)')

	for id, frame in RazerNaga.Frame:GetAll() do
		if self:IsAutoBindingEnabled(frame) and self:GetFrameModifier(frame) == modifier then
			return frame
		end
	end
	return nil
end

function BindingsLoader:GetAvailableModifiers()
	return pairs(AVAILABLE_MODIFIERS)
end

function BindingsLoader:GetLocalizedModiferName(modifier)
	return MODIFIER_NAMES[modifier]
end


--[[
	Binding Sets
--]]


--simple set
BindingsLoader:AddBindingsSet{
	id = 'Simple',
	localizedName = L.Simple,
	tooltip = L.SimpleBindingHelp,
	layout = '3x4',
	bindings = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		0,
		'-',
		'=',
	},
	nagaKeys = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12
	},
}

BindingsLoader:AddBindingsSet{
	id = 'Simple',
	localizedName = L.Simple,
	tooltip = L.SimpleBindingHelp,
	layout = '4x3',
	bindings = {
		3,
		6,
		9,
		'=',
		2,
		5,
		8,
		'-',
		1,
		4,
		7,
		0,
	},
	nagaKeys = {
		3,
		6,
		9,
		12,
		2,
		5,
		8,
		11,
		1,
		4,
		7,
		10
	},
}

--advanced set
BindingsLoader:AddBindingsSet{
	id = 'Advanced',
	localizedName = L.Advanced,
	tooltip = L.AvancedBindingSetHelp,
	layout = '3x4',
	bindings = {
		'NUMPAD1',
		'NUMPAD2',
		'NUMPAD3',
		'NUMPAD4',
		'NUMPAD5',
		'NUMPAD6',
		'NUMPAD7',
		'NUMPAD8',
		'NUMPAD9',
		'NUMPAD0',
		'NUMPADMINUS',
		'NUMPADPLUS',
	},
	nagaKeys = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11,
		12
	},
}

BindingsLoader:AddBindingsSet{
	id = 'Advanced',
	localizedName = L.Advanced,
	tooltip = L.AvancedBindingSetHelp,
	layout = '4x3',
	bindings = {
		'NUMPAD3',
		'NUMPAD6',
		'NUMPAD9',
		'NUMPADPLUS',
		'NUMPAD2',
		'NUMPAD5',
		'NUMPAD8',
		'NUMPADMINUS',
		'NUMPAD1',
		'NUMPAD4',
		'NUMPAD7',
		'NUMPAD0',
	},
	nagaKeys = {
		3,
		6,
		9,
		12,
		2,
		5,
		8,
		11,
		1,
		4,
		7,
		10
	},
}