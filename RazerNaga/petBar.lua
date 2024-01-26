--[[
	petBar.lua
		A RazerNaga pet bar
--]]


--[[ Globals ]]--

local _G = _G
local RazerNaga = _G['RazerNaga']
local KeyBound = LibStub('LibKeyBound-1.0')
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local format = string.format
local unused = {}


--[[ Pet Button ]]--

local PetButton = RazerNaga:CreateClass('CheckButton', RazerNaga.BindableButton)

function PetButton:New(id)
	local b = self:Restore(id) or self:Create(id)

	RazerNaga.BindingsController:Register(b)
	RazerNaga:GetModule('Tooltips'):Register(b)

	return b
end

function PetButton:Create(id)
	local b = self:Bind(_G['PetActionButton' .. id])
	b.buttonType = 'BONUSACTIONBUTTON'
	
	b:HookScript('OnEnter', self.OnEnter)

	--override keybinding display
	hooksecurefunc(b, 'SetHotkeys', PetButton.UpdateHotkey)

	if b.UpdateButtonArt then
		b.UpdateButtonArt = function() end
	end

	return b
end

function PetButton:Restore(id)
	local b = unused and unused[id]
	if b then
		unused[id] = nil
		b:Show()

		return b
	end
end

--saving them thar memories
function PetButton:Free()
	unused[self:GetID()] = self

	RazerNaga.BindingsController:Unregister(self)
	RazerNaga:GetModule('Tooltips'):Unregister(self)

	self:SetParent(nil)
	self:Hide()
end

--keybound support
function PetButton:OnEnter()
	KeyBound:Set(self)
end


--[[ Pet Bar ]]--

local PetBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function PetBar:New()
	local f = self.super.New(self, 'pet')
	f:SetTooltipText(L.PetBarHelp)
	f:LoadButtons()
	f:Layout()

	return f
end

function PetBar:GetShowStates()
    if UnitClassBase("player") == "WARLOCK" then
        local eyeOfKilrogg = GetSpellInfo(126)
        return ('[channeling:%s]hide;[@pet,exists,nopossessbar]show;hide'):format(eyeOfKilrogg)
    end

    return '[@pet,exists,nopossessbar]show;hide'
end

function PetBar:GetDefaults()
	return {
		point = 'CENTER',
		x = 0,
		y = -32,
		spacing = 6
	}
end

--RazerNaga frame method overrides
function PetBar:NumButtons()
	return NUM_PET_ACTION_SLOTS
end

function PetBar:AddButton(i)
	local b = PetButton:New(i)
	b:SetParent(self.header)
	self.buttons[i] = b
end

function PetBar:RemoveButton(i)
	local b = self.buttons[i]
	self.buttons[i] = nil
	b:Free()
end


--[[ keybound  support ]]--

function PetBar:KEYBOUND_ENABLED()
	self.header:SetAttribute('state-visibility', 'display')

	for _, button in pairs(self.buttons) do
		button:Show()
	end
end

function PetBar:KEYBOUND_DISABLED()
	self:UpdateShowStates()

	local petBarShown = PetHasActionBar()

	for _, button in pairs(self.buttons) do
		if petBarShown and GetPetActionInfo(button:GetID()) then
			button:Show()
		else
			button:Hide()
		end
	end
end

--[[ controller good times ]]--

local PetBarController = RazerNaga:NewModule('PetBar')

function PetBarController:Load()
	self.frame = PetBar:New()
end

function PetBarController:Unload()
	if self.frame then
		self.frame:Free()
		self.frame = nil
	end
end