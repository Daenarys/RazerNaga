--[[
	configModeDialog.lua
		The RazerNaga config mode dialog display
--]]

local RazerNaga = RazerNaga
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

local ConfigModeDialog = CreateFrame('Frame', 'RazerNagaConfigHelperDialog', UIParent)
ConfigModeDialog:SetPoint('TOP', 0, -24)
ConfigModeDialog:SetScript('OnShow', function(self) self:Load() end)
ConfigModeDialog:Hide()

RazerNaga.ConfigModeDialog = ConfigModeDialog

function ConfigModeDialog:Load()
	self:SetFrameStrata('DIALOG')
	self:SetMovable(true)
	self:SetToplevel(true)
	self:EnableMouse(true)
	self:SetClampedToScreen(true)
	self:SetWidth(360)
	self:SetHeight(192)
	self:RegisterForDrag('LeftButton')
	self:SetScript('OnShow', function() PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end)
	self:SetScript('OnHide', function() PlaySound(SOUNDKIT.GS_TITLE_OPTION_EXIT) end)
	self:SetScript('OnDragStart', function() self:StartMoving() end)
	self:SetScript('OnDragStop', function() self:StopMovingOrSizing() end)

	local border = CreateFrame('Frame', nil, self, 'DialogBorderTemplate')

	local header = CreateFrame('Frame', nil, self, 'DialogHeaderTemplate')
	header:SetWidth(170) 
	header:SetPoint('TOP', 0, 12)

	local title = header:CreateFontString(nil, 'ARTWORK')
	title:SetFontObject('GameFontNormal')
	title:SetPoint('TOP', header, 'TOP', 0, -14)
	title:SetText(L.ConfigMode)

	local desc = self:CreateFontString(nil, 'ARTWORK')
	desc:SetFontObject('GameFontHighlight')
	desc:SetJustifyV('TOP')
	desc:SetJustifyH('CENTER')
	desc:SetPoint('TOPLEFT', 18, -32)
	desc:SetPoint('BOTTOMRIGHT', -18, 120)
	desc:SetText(L.ConfigModeHelp)

	--menu buttons
	local exitConfig = self:CreateExitButton()
	exitConfig:SetPoint('TOPRIGHT')

	--ui menu display
	local bindingMode = self:CreateBindingModeButton()
	bindingMode:SetPoint('TOPLEFT', 12, -12)

	local uiMenu = self:CreateUIMenuButton()
	uiMenu:SetPoint('LEFT', bindingMode, 'RIGHT', 2, 0)

	--lynn setttings (rotate layout, binding set picker, auto binder toggle, per character toggle)
	local bindingSetPicker = self:CreateBindingSetPicker()
	bindingSetPicker:SetPoint('BOTTOMLEFT', 0, 66)

	local rotator = self:CreateRotateButton()
	rotator:SetPoint('TOPLEFT', bindingSetPicker, 'TOPRIGHT', -4, 7)

	local autoBinder = self:CreateAutoBindingToggle()
	autoBinder:SetPoint('TOPLEFT', bindingSetPicker, 'BOTTOMLEFT', 14, -4)

	local perChar = self:CreatePerCharacterBindingToggle()
	perChar:SetPoint('TOPLEFT', autoBinder, 'BOTTOMLEFT')

	--force all widgets to init to proper values, since they use onshow scripts
	self:Hide()
	self:Show()
end

--[[ Widgets ]]--

function ConfigModeDialog:CreateRotateButton()
	local rotator = CreateFrame('Button', self:GetName() .. 'LayoutRotator', self)
	local nt = rotator:CreateTexture(rotator:GetName() .. 'NormalTexture')
	nt:SetAllPoints(rotator)
	rotator:SetNormalTexture(nt)

	local pt = rotator:CreateTexture(rotator:GetName() .. 'PushedTexture')
	pt:SetAllPoints(rotator)
	rotator:SetPushedTexture(pt)

	rotator:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])

	rotator:SetWidth(32)
	rotator:SetHeight(32)

	rotator.UpdateTexture = function(self)
		local texture
		if RazerNaga.SettingsLoader:GetLayoutType() == '3x4' then
			texture = [[Interface\Addons\RazerNaga\Icons\V2H]]
		else
			texture = [[Interface\Addons\RazerNaga\Icons\H2V]]
		end

		_G[self:GetName() .. 'NormalTexture']:SetTexture(texture)
		_G[self:GetName() .. 'PushedTexture']:SetTexture(texture)
		_G[self:GetName() .. 'PushedTexture']:SetTexCoord(-0.03, 1.03, -0.03, 1.03)
		_G[self:GetName() .. 'PushedTexture']:SetVertexColor(0.9, 0.9, 0.9)
	end

	rotator:SetScript('OnShow', rotator.UpdateTexture)

	rotator.UpdateTooltip = function(self)
		local layoutType = RazerNaga.SettingsLoader:GetLayoutType()

		if layoutType == '3x4' then
			GameTooltip:SetText(L.SwitchTo4x3)
		else
			GameTooltip:SetText(L.SwitchTo3x4)
		end

		GameTooltip:Show()
	end

	rotator:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		self:UpdateTooltip()
	end)

	rotator:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return rotator
end

function ConfigModeDialog:CreateBindingSetPicker()
	local info = {}
	local function AddItem(text, value, func, checked, arg1, tooltip)
		info.text = text
		info.func = func
		info.value = value
		info.checked = checked
		info.arg1 = arg1
		info.tooltipTitle = tooltip
		UIDropDownMenu_AddButton(info)
	end

	local dd = CreateFrame('Frame', self:GetName() .. 'BindingSet', self, 'UIDropDownMenuTemplate')
	dd:EnableMouse(true)

	local text = dd:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalSmall')
	text:SetPoint('BOTTOMLEFT', dd, 'TOPLEFT', 21, 0)
	text:SetText(L.BindingSet)

	dd:SetScript('OnShow', function(self)
		UIDropDownMenu_SetWidth(self, 110)
		UIDropDownMenu_Initialize(self, self.Initialize)
		UIDropDownMenu_SetSelectedValue(self, "123")
	end)

	dd:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.BindingSetHelp, nil, nil, nil, nil, 1)
	end)
	dd:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	dd.Initialize = function(self)
		AddItem("123")
		AddItem("Num")
	end

	return dd
end

function ConfigModeDialog:CreateAutoBindingToggle()
	local autoBindings = CreateFrame('CheckButton', self:GetName() .. 'AutoBindings', self, 'InterfaceOptionsCheckButtonTemplate')
	_G[autoBindings:GetName() .. 'Text']:SetFontObject('GameFontNormal')
	_G[autoBindings:GetName() .. 'Text']:SetText(L.EnableAutomaticBindings)
	_G[autoBindings:GetName() .. 'Text']:SetTextColor(255, 255, 255, 1)
	_G[autoBindings:GetName() .. 'Text']:SetPoint("LEFT", autoBindings, "RIGHT", 2, 1)

	autoBindings:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.AutomaticBindingsToggle, nil, nil, nil, nil, 1)
	end)

	autoBindings:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return autoBindings
end

function ConfigModeDialog:CreatePerCharacterBindingToggle()
	local perCharBindings = CreateFrame('CheckButton', self:GetName() .. 'PerCharBindings', self, 'InterfaceOptionsCheckButtonTemplate')
	_G[perCharBindings:GetName() .. 'Text']:SetFontObject('GameFontNormal')
	_G[perCharBindings:GetName() .. 'Text']:SetText(CHARACTER_SPECIFIC_KEYBINDINGS)
	_G[perCharBindings:GetName() .. 'Text']:SetTextColor(255, 255, 255, 1)
	_G[perCharBindings:GetName() .. 'Text']:SetPoint("LEFT", perCharBindings, "RIGHT", 2, 1)

	perCharBindings:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(CHARACTER_SPECIFIC_KEYBINDING_TOOLTIP, nil, nil, nil, nil, 1)
	end)

	perCharBindings:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return perCharBindings
end

function ConfigModeDialog:CreateExitButton()
	local exitConfig = CreateFrame('Button', self:GetName() .. 'ExitConfig', self, 'UIPanelCloseButton')

	exitConfig:SetScript('OnClick', function() RazerNaga:SetLock(true) end)

	exitConfig:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.ConfigModeExit, nil, nil, nil, nil, 1)
	end)

	exitConfig:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return exitConfig
end

function ConfigModeDialog:CreateBasicButton(name, width, height)
	local b = CreateFrame('Button', self:GetName() .. name, self)

	local nt = b:CreateTexture(b:GetName() .. 'NormalTexture')
	nt:SetAllPoints(b)
	b:SetNormalTexture(nt)

	local pt = b:CreateTexture(b:GetName() .. 'PushedTexture')
	pt:SetTexCoord(-0.03, 1.03, -0.03, 1.03)
	pt:SetVertexColor(0.9, 0.9, 0.9)
	pt:SetAllPoints(b)
	b:SetPushedTexture(pt)

	b:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])

	b:SetWidth(width)
	b:SetHeight(height or width)

	return b
end

function ConfigModeDialog:CreateUIMenuButton()
	local b = self:CreateBasicButton('ShowOptionsMenu', 16)
	_G[b:GetName() .. 'NormalTexture']:SetTexture([[Interface\Addons\RazerNaga\Icons\Configure]])
	_G[b:GetName() .. 'PushedTexture']:SetTexture([[Interface\Addons\RazerNaga\Icons\Configure]])

	b:SetScript('OnClick', function(self)
		RazerNaga:SetLock(true)
		RazerNaga:ShowOptions()
	end)

	b:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.ConfigModeShowOptions, nil, nil, nil, nil, 1)
	end)

	b:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return b
end

function ConfigModeDialog:CreateBindingModeButton()
	local b = self:CreateBasicButton('SwitchToBindingMode', 16)
	_G[b:GetName() .. 'NormalTexture']:SetTexture([[Interface\Addons\RazerNaga\Icons\Manual]])
	_G[b:GetName() .. 'PushedTexture']:SetTexture([[Interface\Addons\RazerNaga\Icons\Manual]])

	b:SetScript('OnClick', function(self)
		RazerNaga:ToggleBindingMode()
	end)

	b:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.ConfigModeSwitchToBindingMode, nil, nil, nil, nil, 1)
	end)

	b:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return b
end