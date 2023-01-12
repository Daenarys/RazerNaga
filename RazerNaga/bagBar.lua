--[[
	bagBar.lua
		Defines the RazerNaga bagBar object
--]]

--[[ Bag Bar ]]--

local BagBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function BagBar:New()
	local f = self.proto.New(self, 'bags')
	f:Reload()

	return f
end

function BagBar:SkinButton(b)
	if b.skinned then return end

	RazerNaga.BaseBagSlotButton_UpdateTextures = function(self)
		self:GetPushedTexture():SetAtlas(nil)
		self:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress", "ADD")
		self:GetPushedTexture():SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self:GetPushedTexture():SetSize(30, 30)
		self:GetPushedTexture():SetAlpha(1)
		
		self:GetHighlightTexture():SetAtlas(nil)
		self:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
		self:GetHighlightTexture():SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self:GetHighlightTexture():SetSize(30, 30)
		self:GetHighlightTexture():SetAlpha(1)
		
		self.SlotHighlightTexture:SetAtlas(nil)
		self.SlotHighlightTexture:SetTexture("Interface\\Buttons\\CheckButtonHilight")
		self.SlotHighlightTexture:SetBlendMode("ADD")
		self.SlotHighlightTexture:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		self.SlotHighlightTexture:SetSize(30, 30)
		self.SlotHighlightTexture:SetAlpha(1)
		
		self:GetNormalTexture():SetAtlas(nil)
	end
	
	for i = 0, 3 do
		local bagSlot = _G["CharacterBag"..i.."Slot"]
		bagSlot.IconBorder:SetTexture("Interface\\Common\\WhiteIconFrame")
		bagSlot.IconBorder:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		bagSlot.IconBorder:SetSize(30, 30)
		bagSlot.IconBorder:SetDrawLayer("OVERLAY")
		bagSlot.IconBorder:SetAlpha(1)
		bagSlot.IconBorder:SetPoint("CENTER", bagSlot, "CENTER", 0, 0)
		hooksecurefunc(bagSlot, "SetItemButtonQuality", ItemButtonMixin.SetItemButtonQuality)
		hooksecurefunc(bagSlot, "UpdateTextures", RazerNaga.BaseBagSlotButton_UpdateTextures)
	end
	hooksecurefunc(MainMenuBarBackpackButton, "UpdateTextures", RazerNaga.BaseBagSlotButton_UpdateTextures)
	
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
	RazerNaga.BaseBagSlotButton_UpdateTextures(CharacterBag0Slot)
	CharacterBag0SlotNormalTexture:Hide()
	CharacterBag0Slot:SetSize(30, 30)
	CharacterBag0Slot.IconBorder:SetSize(30, 30)
	CharacterBag0Slot:ClearAllPoints()
	CharacterBag0Slot:SetPoint("RIGHT", MainMenuBarBackpackButton, "LEFT", -2, 0)
	CharacterBag0Slot:SetFrameStrata("MEDIUM")
	CharacterBag0Slot:SetFrameLevel(3)
	CharacterBag1Slot.CircleMask:Hide()
	RazerNaga.BaseBagSlotButton_UpdateTextures(CharacterBag1Slot)
	CharacterBag1SlotNormalTexture:Hide()
	CharacterBag1Slot:SetSize(30, 30)
	CharacterBag1Slot.IconBorder:SetSize(30, 30)
	CharacterBag1Slot:ClearAllPoints()
	CharacterBag1Slot:SetPoint("RIGHT", CharacterBag0Slot, "LEFT", -2, 0)
	CharacterBag1Slot:SetFrameStrata("MEDIUM")
	CharacterBag1Slot:SetFrameLevel(3)
	CharacterBag2Slot.CircleMask:Hide()
	RazerNaga.BaseBagSlotButton_UpdateTextures(CharacterBag2Slot)
	CharacterBag2SlotNormalTexture:Hide()
	CharacterBag2Slot:SetSize(30, 30)
	CharacterBag2Slot.IconBorder:SetSize(30, 30)
	CharacterBag2Slot:ClearAllPoints()
	CharacterBag2Slot:SetPoint("RIGHT", CharacterBag1Slot, "LEFT", -2, 0)
	CharacterBag2Slot:SetFrameStrata("MEDIUM")
	CharacterBag2Slot:SetFrameLevel(3)
	CharacterBag3Slot.CircleMask:Hide()
	RazerNaga.BaseBagSlotButton_UpdateTextures(CharacterBag3Slot)
	CharacterBag3SlotNormalTexture:Hide()
	CharacterBag3Slot:SetSize(30, 30)
	CharacterBag3Slot.IconBorder:SetSize(30, 30)
	CharacterBag3Slot:ClearAllPoints()
	CharacterBag3Slot:SetPoint("RIGHT", CharacterBag2Slot, "LEFT", -2, 0)
	CharacterBag3Slot:SetFrameStrata("MEDIUM")
	CharacterBag3Slot:SetFrameLevel(3)
	MainMenuBarBackpackButton.CircleMask:Hide()
	RazerNaga.BaseBagSlotButton_UpdateTextures(MainMenuBarBackpackButton)
	MainMenuBarBackpackButtonIconTexture:SetTexture("Interface\\Buttons\\Button-Backpack-Up")
	MainMenuBarBackpackButton:SetSize(30, 30)
	MainMenuBarBackpackButton.IconBorder:SetSize(30, 30)
	MainMenuBarBackpackButton:ClearAllPoints()
	MainMenuBarBackpackButton:SetPoint("BOTTOMRIGHT", -4, 6)
	MainMenuBarBackpackButton:SetFrameStrata("MEDIUM")
	MainMenuBarBackpackButton:SetFrameLevel(3)

	MainMenuBarBackpackButtonCount:SetPoint("CENTER", 0, -6)

	RazerNaga:Masque('Bag Bar', b, {Icon = _G[b:GetName() .. 'IconTexture']})

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
	b:SetParent(self)
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
    -- use our own handling for the blizzard bag bar
    if MainMenuBarManager then
        EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", MainMenuBarManager)
        EventRegistry:UnegisterFrameEventAndCallback("VARIABLES_LOADED", MainMenuBarManager)
    elseif BagsBar then
        EventRegistry:UnregisterCallback("MainMenuBarManager.OnExpandChanged", BagsBar)
        hooksecurefunc(BagsBar, "Layout", function() self:LayoutBagBar() end)
    end

    if BagBarExpandToggle then
        BagBarExpandToggle:Hide()
    end

    if CharacterReagentBag0Slot then
        CharacterReagentBag0Slot:Hide()
    end
end

function BagBarController:Load()
    if self.frame == nil then
        self.frame = BagBar:New()
    end
end

function BagBarController:Unload()
    if self.frame ~= nil then
        self.frame:Free()
        self.frame = nil
    end
end

function BagBarController:LayoutBagBar()
    if InCombatLockdown() then
        self.needsUpdate = true
        return
    end

    if self.frame then
        self.frame:Layout()
    end

    self.needsUpdate = nil
end