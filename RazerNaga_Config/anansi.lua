--[[
	Anansi specific options for the Razer Naga addon
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config')
local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi', true)
if not Anansi then return end

local Config = Anansi.Config

--name, parent, title, subtitle, icon)
local AnansiOptions = RazerNaga.Panel:New('RazerAnansiOptions', nil, L.Anansi, L.AnansiDescription , [[Interface\Addons\RazerNaga\Icons\RazerNaga]])
RazerNaga.AnansiOptions = AnansiOptions

--[[ Buttons ]]--

--toggle config mode
local resyncKeys = AnansiOptions:NewButton(L.AnansiResyncKeys, 136, 22)
resyncKeys:SetScript('OnClick', function(self) Anansi:ResyncKeys() end)
resyncKeys:SetPoint('TOPLEFT', 12, -80)


--[[ Checkbuttons ]]--

--TPanel display options
local tPanelDisplay
do
	local dd = RazerNaga.Dropdown:New('Show Anansi T-Panel on Hover', AnansiOptions, 160)
	dd:SetPoint('TOPLEFT', resyncKeys, 'BOTTOMLEFT', -16, -24)

	dd.SetSavedValue = function(self, value) 
		Config:SetShowTPanelOnHover(value)
	end

	dd.GetSavedValue = function(self) 
		return Config:ShowingTPanelOnHover()
	end
	
	dd.GetSavedText = function(self)
		local state = Config:ShowingTPanelOnHover()
		return L['AnansiShowTPanel_' .. (state or 'never')]
	end
	
	dd:SetScript('OnShow', function(self)
		self:UpdateValue()
	end)

	UIDropDownMenu_Initialize(dd, function(self)
		for i, v in ipairs{'always', 'ooc', 'config', 'never'} do
			self:AddItem(L['AnansiShowTPanel_' .. v], v)
		end
	end)
	
	tPanelDisplay = dd
end

--Add fade out T-Key bars checkbox
local fadeTBars = AnansiOptions:NewCheckButton(
	L.AnansiAutoFadeTKeyBars,
	function() return Config:AutoFadingTBars() end,
	function(checked) Config:SetAutoFadeTBars(checked) end
)
fadeTBars:SetPoint('TOPLEFT', tPanelDisplay, 'BOTTOMLEFT', 16, -4)

local enableNotifications = AnansiOptions:NewCheckButton(
	L.AnansiEnableTKeyNotifications,
	function() return Config:TKeyNotificationsEnabled() end,
	function(checked) Config:SetEnableTKeyNotifications(checked) end
)
enableNotifications:SetPoint('TOPLEFT', fadeTBars, 'BOTTOMLEFT', 0, -2)

--add panel to name tKeys
do
	local tPanel = CreateFrame('Frame', '$parentTPanel', AnansiOptions)
	tPanel:SetSize(512, 128)
	tPanel:SetPoint('TOPLEFT', enableNotifications, 'BOTTOMLEFT', 0, -24)
	
	local title = tPanel:CreateFontString('$parentTitle', 'ARTWORK', 'GameFontNormal')
	title:SetPoint('BOTTOMLEFT', tPanel, 'TOPLEFT', 8, 2)
	title:SetText(L.AnansiTKeyNames)
	
	local bg = tPanel:CreateTexture('$parentBackground', 'BACKGROUND')
	bg:SetAllPoints(tPanel)
	bg:SetTexture([[Interface\Addons\RazerAnansi\images\T]])
	bg:SetAlpha(0.8)
	
	local editBoxes = {}
	for tKey = 1, Config:NumTKeys() do
		local editBox = CreateFrame('EditBox', '$parentTKey' .. tKey, tPanel, 'InputBoxTemplate')
		editBox:SetID(tKey)
		editBox:SetAutoFocus(false)
		editBox:SetJustifyH('CENTER')
		editBox:SetFontObject('GameFontHighlightLarge')
		
		editBox:SetScript('OnShow', function(self)
			self:SetText(Config:GetTKeyName(self:GetID()))
		end)
		
		editBox:SetScript('OnEnterPressed', function(self) 
			self:ClearFocus()
		end)		
		
		editBox:SetScript('OnTextChanged', function(self, isUserInput)
			local text = self:GetText()
			if isUserInput then
				Config:SetTKeyName(self:GetID(), text)
			end
		end)
		
		editBox:SetScript('OnTabPressed', function(self)
			local nextEditBox
			if self:GetID() < Config:NumTKeys() then
				nextEditBox = self:GetParent().editBoxes[self:GetID() + 1]
			else
				nextEditBox = self:GetParent().editBoxes[1]
			end
			nextEditBox:SetFocus()
		end)
		
		editBox:SetScript('OnEditFocusLost', function(self)
			self:HighlightText(0, 0)
		end)
		
		editBox:SetScript('OnEditFocusGained', function(self)
			self:HighlightText()
		end)
		
		table.insert(editBoxes, editBox)
	end
	tPanel.editBoxes = editBoxes
	
	local editBoxWidth = 80
	local editBoxHeight = 16
	local editBoxOffset = 18
	editBoxes[1]:SetSize(editBoxWidth, editBoxHeight)
	editBoxes[1]:SetPoint('TOPLEFT', 22, -44)

	editBoxes[2]:SetSize(editBoxWidth, editBoxHeight)
	editBoxes[2]:SetPoint('LEFT', editBoxes[1], 'RIGHT', editBoxOffset, 0)
	
	editBoxes[3]:SetSize(editBoxWidth, editBoxHeight)
	editBoxes[3]:SetPoint('LEFT', editBoxes[2], 'RIGHT', editBoxOffset, 0)
	
	editBoxes[4]:SetSize(editBoxWidth, editBoxHeight)
	editBoxes[4]:SetPoint('LEFT', editBoxes[3], 'RIGHT', editBoxOffset, 0)
	
	editBoxes[5]:SetSize(editBoxWidth, editBoxHeight)
	editBoxes[5]:SetPoint('LEFT', editBoxes[4], 'RIGHT', editBoxOffset, 0)
	
	editBoxes[6]:SetSize(80, editBoxHeight)
	editBoxes[6]:SetPoint('TOPLEFT', editBoxes[1], 'BOTTOMLEFT', 0, -28)
	
	editBoxes[7]:SetSize(80, editBoxHeight)
	editBoxes[7]:SetPoint('TOPRIGHT', editBoxes[5], 'BOTTOMRIGHT', 0, -28)
end

--[[ Events ]]--

-- function AnansiOptions:Load()
	-- RazerNaga.Envoy:Register(self, 'TPANEL_UPDATE_AUTO_SHOW')
	-- self:EnableTPanelCheckButtons(Config:ShowingTPanelOnHover())
-- end

-- function AnansiOptions:TPANEL_UPDATE_AUTO_SHOW(msg, enable)
	-- self:EnableTPanelCheckButtons(enable)
-- end

-- function AnansiOptions:EnableTPanelCheckButtons(enable)
	-- if enable then
		-- showTPanelOutOfCombat:Enable()
		-- showTPanelInCombat:Enable()
	-- else
		-- showTPanelOutOfCombat:Disable()
		-- showTPanelInCombat:Disable()		
	-- end
-- end

-- AnansiOptions:Load()
