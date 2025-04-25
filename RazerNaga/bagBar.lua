--[[
	bagBar.lua
		Defines the RazerNaga bagBar object
--]]

--[[ Bag Bar ]]--

local BagBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function BagBar:New()
	local f = self.super.New(self, 'bags')
	f:Reload()

	return f
end

function BagBar:SkinButton(b)
	if b.skinned then return end

	b:SetSize(30, 30)

	if b.IconBorder ~= nil then
		b.IconBorder:SetSize(30, 30)
	end

	if b.IconOverlay ~= nil then
		b.IconOverlay:SetSize(30, 30)
	end

	if b.CircleMask then
		b.CircleMask:Hide()
	end

	local function updateTextures(self)
		self:GetNormalTexture():SetTexture("Interface\\Buttons\\UI-Quickslot2")
		self:GetNormalTexture():SetSize(50, 50)
		self:GetNormalTexture():SetAlpha(1)
		self:GetNormalTexture():ClearAllPoints()
		self:GetNormalTexture():SetPoint("CENTER", 0, -1)
		self:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		self:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		self:GetHighlightTexture():SetAlpha(1)
		self.SlotHighlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
		self.SlotHighlightTexture:SetBlendMode("ADD")
	end

	hooksecurefunc(b, "SetItemButtonQuality", ItemButtonMixin.SetItemButtonQuality)
	hooksecurefunc(b, "UpdateTextures", updateTextures)

	updateTextures(b)
	MainMenuBarBackpackButtonIconTexture:SetTexture("Interface\\Buttons\\Button-Backpack-Up")
	MainMenuBarBackpackButtonCount:ClearAllPoints()
	MainMenuBarBackpackButtonCount:SetPoint("CENTER", 1, -7)

	b.skinned = true
end

local function Disable_BagButtons()
	for i, bagButton in MainMenuBarBagManager:EnumerateBagButtons() do
		bagButton:Disable()
		SetDesaturation(bagButton.icon, true)
	end
end

local function Enable_BagButtons()
	for i, bagButton in MainMenuBarBagManager:EnumerateBagButtons() do
		bagButton:Enable()
		SetDesaturation(bagButton.icon, false)
	end
end

GameMenuFrame:HookScript("OnShow", function()
	Disable_BagButtons()
end)

GameMenuFrame:HookScript("OnHide", function()
	Enable_BagButtons()
end)

function BagBar:GetDefaults()
	return {
		point = 'BOTTOMRIGHT',
		spacing = 2,
	}
end

function BagBar:SetSetOneBag(enable)
	self.sets.oneBag = enable or false
	self:Reload()
end

function BagBar:Reload()
	if not self.bags then
		self.bags = {}
	else
		for i = 1, #self.bags do
			self.bags[i] = nil
		end
	end

	if not self.sets.oneBag then
		local startSlot = NUM_BAG_SLOTS - 1
		for slot = startSlot, 0, -1 do
			table.insert(self.bags, _G[string.format('CharacterBag%dSlot', slot)])
		end
	end

	table.insert(self.bags, _G['MainMenuBarBackpackButton'])

	self:SetNumButtons(#self.bags)
	self:UpdateClickThrough()
end


--[[ Frame Overrides ]]--

function BagBar:AddButton(i)
	local b = self.bags[i]
	b:SetParent(self.header)
	b:Show()
	self:SkinButton(b)

	self.buttons[i] = b
end

function BagBar:RemoveButton(i)
	local b = self.buttons[i]
	if b then
		b:SetParent(nil)
		b:Hide()
		self.buttons[i] = nil
	end
end

function BagBar:UpdateButtonCount(numButtons)
	for i = 1, #self.buttons do
		self:RemoveButton(i)
	end

	for i = 1, numButtons do
		self:AddButton(i)
	end
end

function BagBar:NumButtons()
	return #self.bags
end

function BagBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	local panel = menu:AddLayoutPanel()
	local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config')

	--add onebag and showkeyring options
	local oneBag = panel:NewCheckButton(L.OneBag)
	oneBag:SetScript('OnShow', function()
		oneBag:SetChecked(self.sets.oneBag)
	end)

	oneBag:SetScript('OnClick', function()
		self:SetSetOneBag(oneBag:GetChecked())
		_G[panel:GetName() .. L.Columns]:OnShow()
	end)


	menu:AddAdvancedPanel()
	self.menu = menu
end

--[[ Bag Bar Controller ]]

local BagBarController = RazerNaga:NewModule('BagBar')

function BagBarController:OnInitialize()
	if not self.frame then
		local noopFunc = function() end

		CharacterReagentBag0Slot.SetBarExpanded = noopFunc
		CharacterBag3Slot.SetBarExpanded = noopFunc
		CharacterBag2Slot.SetBarExpanded = noopFunc
		CharacterBag1Slot.SetBarExpanded = noopFunc
		CharacterBag0Slot.SetBarExpanded = noopFunc
		BagsBar.Layout = noopFunc
	end

    if BagsBar and BagsBar.Layout then
    	hooksecurefunc(BagsBar, "Layout", function()
    		if InCombatLockdown() then return end

			if self.frame then
				self.frame:Layout()
			end
    	end)
        EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", BagsBar)
    end
end

function BagBarController:Load()
	self.frame = BagBar:New()
end

function BagBarController:Unload()
	if self.frame then
		self.frame:Free()
		self.frame = nil
	end
end