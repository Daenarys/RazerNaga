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

	BaseBagSlotButton_UpdateTextures = function(self)
		self:GetNormalTexture():SetTexture("Interface\\Buttons\\UI-Quickslot2")
		self:GetNormalTexture():SetSize(50, 50)
		self:GetNormalTexture():SetAlpha(1)
		self:GetNormalTexture():ClearAllPoints()
		self:GetNormalTexture():SetPoint("CENTER", self, "CENTER", 0, -1)
		self:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
		self:GetPushedTexture():SetSize(30, 30)
		self:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
		self:GetHighlightTexture():SetSize(30, 30)
		self.SlotHighlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
		self.SlotHighlightTexture:SetBlendMode("ADD")
		self.SlotHighlightTexture:SetSize(30, 30)
	end

	for i = 0, 3 do
		local bagSlot = _G["CharacterBag"..i.."Slot"]
		hooksecurefunc(bagSlot, "SetItemButtonQuality", ItemButtonMixin.SetItemButtonQuality)
		hooksecurefunc(bagSlot, "UpdateTextures", BaseBagSlotButton_UpdateTextures)
	end

	ItemButtonMixin.SetItemButtonQuality(CharacterBag0Slot, GetInventoryItemQuality("player", CharacterBag0Slot:GetID()), GetInventoryItemID("player", CharacterBag0Slot:GetID()), CharacterBag0Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag1Slot, GetInventoryItemQuality("player", CharacterBag1Slot:GetID()), GetInventoryItemID("player", CharacterBag1Slot:GetID()), CharacterBag1Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag2Slot, GetInventoryItemQuality("player", CharacterBag2Slot:GetID()), GetInventoryItemID("player", CharacterBag2Slot:GetID()), CharacterBag2Slot.HasPaperDollAzeriteItemOverlay)
	ItemButtonMixin.SetItemButtonQuality(CharacterBag3Slot, GetInventoryItemQuality("player", CharacterBag3Slot:GetID()), GetInventoryItemID("player", CharacterBag3Slot:GetID()), CharacterBag3Slot.HasPaperDollAzeriteItemOverlay)
	C_Timer.After(8, function()
		ItemButtonMixin.SetItemButtonQuality(CharacterBag0Slot, GetInventoryItemQuality("player", CharacterBag0Slot:GetID()), GetInventoryItemID("player", CharacterBag0Slot:GetID()), CharacterBag0Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag1Slot, GetInventoryItemQuality("player", CharacterBag1Slot:GetID()), GetInventoryItemID("player", CharacterBag1Slot:GetID()), CharacterBag1Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag2Slot, GetInventoryItemQuality("player", CharacterBag2Slot:GetID()), GetInventoryItemID("player", CharacterBag2Slot:GetID()), CharacterBag2Slot.HasPaperDollAzeriteItemOverlay)
		ItemButtonMixin.SetItemButtonQuality(CharacterBag3Slot, GetInventoryItemQuality("player", CharacterBag3Slot:GetID()), GetInventoryItemID("player", CharacterBag3Slot:GetID()), CharacterBag3Slot.HasPaperDollAzeriteItemOverlay)
	end)

	CharacterBag0Slot.CircleMask:Hide()
	BaseBagSlotButton_UpdateTextures(CharacterBag0Slot)
	CharacterBag0Slot:SetSize(30, 30)
	CharacterBag0Slot.IconBorder:SetSize(30, 30)
	CharacterBag0Slot:ClearAllPoints()
	CharacterBag0Slot:SetPoint("RIGHT", MainMenuBarBackpackButton, "LEFT", -4, -4)
	CharacterBag1Slot.CircleMask:Hide()
	BaseBagSlotButton_UpdateTextures(CharacterBag1Slot)
	CharacterBag1Slot:SetSize(30, 30)
	CharacterBag1Slot.IconBorder:SetSize(30, 30)
	CharacterBag1Slot:ClearAllPoints()
	CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", -2, 0)
	CharacterBag2Slot.CircleMask:Hide()
	BaseBagSlotButton_UpdateTextures(CharacterBag2Slot)
	CharacterBag2Slot:SetSize(30, 30)
	CharacterBag2Slot.IconBorder:SetSize(30, 30)
	CharacterBag2Slot:ClearAllPoints()
	CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", -2, 0)
	CharacterBag3Slot.CircleMask:Hide()
	BaseBagSlotButton_UpdateTextures(CharacterBag3Slot)
	CharacterBag3Slot:SetSize(30, 30)
	CharacterBag3Slot.IconBorder:SetSize(30, 30)
	CharacterBag3Slot:ClearAllPoints()
	CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", -2, 0)
	MainMenuBarBackpackButton.CircleMask:Hide()
	BaseBagSlotButton_UpdateTextures(MainMenuBarBackpackButton)
	MainMenuBarBackpackButtonIconTexture:SetTexture("Interface\\Buttons\\Button-Backpack-Up")
	MainMenuBarBackpackButton:SetSize(30, 30)
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("TOPRIGHT", -4, -4)
	MainMenuBarBackpackButtonCount:SetPoint("CENTER", 0, -7)

	RazerNaga:Masque('Bag Bar', b, {Icon = _G[b:GetName() .. 'IconTexture']})

	local function Disable_BagButtons()
		MainMenuBarBackpackButton:Disable();
		SetDesaturation(MainMenuBarBackpackButtonIconTexture, true);
		CharacterBag0Slot:Disable();
		SetDesaturation(CharacterBag0SlotIconTexture, true);
		CharacterBag0Slot.IconBorder:Hide()
		CharacterBag1Slot:Disable();
		SetDesaturation(CharacterBag1SlotIconTexture, true);
		CharacterBag1Slot.IconBorder:Hide()
		CharacterBag2Slot:Disable();
		SetDesaturation(CharacterBag2SlotIconTexture, true);
		CharacterBag2Slot.IconBorder:Hide()
		CharacterBag3Slot:Disable();
		SetDesaturation(CharacterBag3SlotIconTexture, true);
		CharacterBag3Slot.IconBorder:Hide()
	end

	local function Enable_BagButtons()
		MainMenuBarBackpackButton:Enable();
		SetDesaturation(MainMenuBarBackpackButtonIconTexture, false);
		CharacterBag0Slot:Enable();
		SetDesaturation(CharacterBag0SlotIconTexture, false);
		CharacterBag0Slot.IconBorder:Show()
		CharacterBag1Slot:Enable();
		SetDesaturation(CharacterBag1SlotIconTexture, false);
		CharacterBag1Slot.IconBorder:Show()
		CharacterBag2Slot:Enable();
		SetDesaturation(CharacterBag2SlotIconTexture, false);
		CharacterBag2Slot.IconBorder:Show()
		CharacterBag3Slot:Enable();
		SetDesaturation(CharacterBag3SlotIconTexture, false);
		CharacterBag3Slot.IconBorder:Show()
	end

	GameMenuFrame:HookScript("OnShow", function(self)
		Disable_BagButtons()
	end)

	GameMenuFrame:HookScript("OnHide", function(self)
		Enable_BagButtons()
	end)

	b.skinned = true
end

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

local BagBarController = RazerNaga:NewModule('BagBar', 'AceEvent-3.0')

function BagBarController:OnInitialize()
	local noopFunc = function() end

	CharacterReagentBag0Slot.SetBarExpanded = noopFunc
	CharacterBag3Slot.SetBarExpanded = noopFunc
	CharacterBag2Slot.SetBarExpanded = noopFunc
	CharacterBag1Slot.SetBarExpanded = noopFunc
	CharacterBag0Slot.SetBarExpanded = noopFunc

	if BagBarExpandToggle then
		BagBarExpandToggle:Hide()
	end

	if CharacterReagentBag0Slot then
		CharacterReagentBag0Slot:Hide()
	end

	if MainMenuBarManager then
		EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", MainMenuBarManager)
		EventRegistry:UnegisterFrameEventAndCallback("VARIABLES_LOADED", MainMenuBarManager)
	end
	if BagsBar then
		EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", BagsBar)
		hooksecurefunc(BagsBar, "Layout", function() 
			self:LayoutBagBar() 
		end)
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

function BagBarController:LayoutBagBar()
    if self.frame then
        self.frame:Layout()
    end
end