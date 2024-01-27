--[[
	StanceBar.lua: A RazerNaga stance bar
--]]

-- don't bother loading the module if the player is currently playing something without a stance
if not ({
	DRUID = true,
	EVOKER = true,
	PALADIN = true,
	PRIEST = true,
	ROGUE = true,
	WARRIOR = true,
})[UnitClassBase('player')] then
    return
end

--[[ Globals ]]--

local _G = _G
local RazerNaga = _G['RazerNaga']
local KeyBound = LibStub('LibKeyBound-1.0')


--[[ Button ]]--

local StanceButton = RazerNaga:CreateClass('CheckButton', RazerNaga.BindableButton)

do
	local unused = {}

	StanceButton.buttonType = 'SHAPESHIFTBUTTON'

	function StanceButton:New(id)
		local button = self:Restore(id) or self:Create(id)

		RazerNaga.BindingsController:Register(button)
		RazerNaga:GetModule('Tooltips'):Register(button)

		return button
	end

	function StanceButton:Create(id)
		local button = self:Bind(_G['StanceButton' .. id])

		if button then
			button:HookScript('OnEnter', self.OnEnter)
			button:Skin()
			if button.UpdateButtonArt then
				button.UpdateButtonArt = function() end
			end
		end

		return button
	end

	--if we have button facade support, then skin the button that way
	--otherwise, apply the RazerNaga style to the button to make it pretty
	function StanceButton:Skin()
		if not RazerNaga:Masque('Class Bar', self) then
			_G[self:GetName() .. 'Icon']:SetTexCoord(0.06, 0.94, 0.06, 0.94)
			self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
			self.NormalTexture:SetSize(54, 54)
			self.NormalTexture:ClearAllPoints()
			self.NormalTexture:SetPoint("CENTER", 0, -1)
			self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
			self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
			self.PushedTexture:SetSize(30, 30)
			self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
			self.HighlightTexture:SetSize(30, 30)
			self.HighlightTexture:SetBlendMode("ADD")
			self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
			self.CheckedTexture:ClearAllPoints()
			self.CheckedTexture:SetPoint("TOPLEFT", self.icon, "TOPLEFT")
			self.CheckedTexture:SetPoint("BOTTOMRIGHT", self.icon, "BOTTOMRIGHT")
			self.CheckedTexture:SetBlendMode("ADD")
		end
	end

	function StanceButton:Restore(id)
		local b = unused[id]
		if b then
			unused[id] = nil
			b:Show()

			return b
		end
	end

	--saving them thar memories
	function StanceButton:Free()
		unused[self:GetID()] = self

		self:SetParent(nil)
		self:Hide()

		RazerNaga.BindingsController:Unregister(self)
		RazerNaga:GetModule('Tooltips'):Unregister(self)
	end

	--keybound support
	function StanceButton:OnEnter()
		KeyBound:Set(self)
	end
end


--[[ Bar ]]--

local StanceBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

do
	local playerClass = (select(2, UnitClass('Player')))

	function StanceBar:New()
		local f = RazerNaga.Frame.New(self, 'class')

		local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
		f:SetTooltipText(L['ClassBarHelp_' .. playerClass])

		f:SetScript('OnEvent', f.OnEvent)

		f:RegisterEvent('UPDATE_SHAPESHIFT_FORMS')
		f:RegisterEvent('PLAYER_REGEN_ENABLED')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')

		f:UpdateNumForms()

		return f
	end

	function StanceBar:GetDefaults()
		return {
			point = 'CENTER',
			spacing = 2
		}
	end

	function StanceBar:Free()
		self:UnregisterAllEvents()

		self.numForms = nil

		RazerNaga.Frame.Free(self)
	end


	--[[ Events/Messages ]]--

	function StanceBar:OnEvent(event, ...)
		local f = self[event]

		if f and type(f) == 'function' then
			f(self, event, ...)
		end
	end

	function StanceBar:UPDATE_SHAPESHIFT_FORMS()
		self:UpdateNumForms()
	end

	function StanceBar:PLAYER_REGEN_ENABLED()
		self:UpdateNumForms()
	end

	function StanceBar:PLAYER_ENTERING_WORLD()
		self:UpdateNumForms()
	end


	--[[ button stuff]]--

	function StanceBar:LoadButtons()
		self:UpdateForms()
		self:UpdateClickThrough()
	end

	function StanceBar:AddButton(i)
		local b = StanceButton:New(i)

		b:SetParent(self.header)
		self.buttons[i] = b

		return b
	end

	function StanceBar:RemoveButton(i)
		local b = self.buttons[i]

		self.buttons[i] = nil

		b:Free()
	end

	function StanceBar:UpdateNumForms()
		if InCombatLockdown() then
			return
		end

		local oldNumForms = self.numForms
		local numForms = GetNumShapeshiftForms() or 0

		if oldNumForms ~= numForms then
			self.numForms = numForms

			self:SetNumButtons(numForms)
		end
	end

	--[[ custom menu ]]--

	function StanceBar:CreateMenu()
		local menu = RazerNaga:NewMenu(self.id)

		menu:AddBindingSelectorPanel()
		menu:AddLayoutPanel()
		menu:AddAdvancedPanel()

		StanceBar.menu = menu
	end
end


--[[ Module ]]--

do
	local StanceBarController = RazerNaga:NewModule('StanceBar')

	function StanceBarController:Load()
		self.bar = StanceBar:New()
	end

	function StanceBarController:Unload()
		if self.bar then
			self.bar:Free()
		end
	end
end