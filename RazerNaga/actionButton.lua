--[[
	Action Button.lua
		A RazerNaga action button
--]]

local RazerNaga = _G[...]
local KeyBound = LibStub('LibKeyBound-1.0')
local Bindings = RazerNaga.BindingsController
local Tooltips = RazerNaga:GetModule('Tooltips')

local ActionButton = RazerNaga:CreateClass('CheckButton', RazerNaga.BindableButton)
RazerNaga.ActionButton = ActionButton
ActionButton.unused = {}
ActionButton.active = {}

local function GetOrCreateActionButton(id)
	if id <= 12 then
		local b = _G['ActionButton' .. id]
		b.buttonType = 'ACTIONBUTTON'
		return b
	elseif id <= 24 then
		return CreateFrame('CheckButton', 'RazerNagaActionButton' .. (id-12), nil, 'ActionBarButtonTemplate')
	elseif id <= 36 then
		local b = _G['MultiBarRightButton' .. (id-24)]
		return b
	elseif id <= 48 then
		local b = _G['MultiBarLeftButton' .. (id-36)]
		return b
	elseif id <= 60 then
		local b = _G['MultiBarBottomRightButton' .. (id-48)]
		return b
	elseif id <= 72 then
		local b = _G['MultiBarBottomLeftButton' .. (id-60)]
		return b
	end
	return CreateFrame('CheckButton', 'RazerNagaActionButton' .. (id-60), nil, 'ActionBarButtonTemplate')
end

--constructor
function ActionButton:New(id)
	local b = self:Restore(id) or self:Create(id)

	if b then
		b:SetAttribute('showgrid', 1)
		b:SetAttribute('action--base', id)
		b:SetAttribute('_childupdate-action', [[
			local state = message
			local overridePage = self:GetParent():GetAttribute('state-overridepage')
			local newActionID

			if state == 'override' then
				newActionID = (self:GetAttribute('button--index') or 1) + (overridePage - 1) * 12
			else
				newActionID = state and self:GetAttribute('action--' .. state) or self:GetAttribute('action--base')
			end

			if newActionID ~= self:GetAttribute('action') then
				self:SetAttribute('action', newActionID)
				self:RunAttribute("UpdateShown")
				self:CallMethod('UpdateState')
			end
		]])
		b:SetAttribute("UpdateShown", [[
			local show = (HasAction(self:GetAttribute("action")))
			and not self:GetAttribute("statehidden")

			if show then
				self:SetAlpha(1)
			else
				self:SetAlpha(0)
			end
		]])

		Bindings:Register(b, b:GetName():match('RazerNagaActionButton%d'))
		Tooltips:Register(b)

		b:UpdateMacro()

		self.active[id] = b
	end

	return b
end

function ActionButton:Create(id)
	local b = GetOrCreateActionButton(id)

	if b then
		self:Bind(b)

		--this is used to preserve the button's old id
		--we cannot simply keep a button's id at > 0 or blizzard code will take control of paging
		--but we need the button's id for the old bindings system
		b:SetAttribute('bindingid', b:GetID())
		b:SetID(0)

		b:ClearAllPoints()
		b:SetAttribute('useparent-actionpage', nil)
		b:SetAttribute('useparent-unit', true)
		b:SetAttribute("statehidden", nil)
		b:EnableMouseWheel(true)

		b:HookScript('OnEnter', self.OnEnter)

		if b.UpdateHotKeys then
			hooksecurefunc(b, 'UpdateHotkeys', self.UpdateHotkey)
		end

		-- pre 10.x button skin
		b:SetSize(36, 36)
		b:Skin()

		if b.cooldown then
			b.cooldown:SetDrawBling(true)
		end

		if b.UpdateButtonArt then
			b.UpdateButtonArt = function() end
		end
	end
	return b
end

function ActionButton:Restore(id)
	local b = self.unused[id]

	if b then
		self.unused[id] = nil

		b:SetAttribute("statehidden", nil)

		self.active[id] = b
		return b
	end
end

--destructor
do
	local HiddenActionButtonFrame = CreateFrame('Frame')
	HiddenActionButtonFrame:Hide()

	function ActionButton:Free()
		local id = self:GetAttribute('action--base')

		self.active[id] = nil

		Tooltips:Unregister(self)
		Bindings:Unregister(self)

		self:SetAttribute("statehidden", true)
		self:SetParent(HiddenActionButtonFrame)
		self:Hide()
		self.action = 0

		self.unused[id] = self
	end
end

--keybound support
function ActionButton:OnEnter()
	KeyBound:Set(self)
end

--macro text
function ActionButton:UpdateMacro()
	if RazerNaga:ShowMacroText() then
		self.Name:Show()
	else
		self.Name:Hide()
	end
end

function ActionButton:SetFlyoutDirection(direction)
	if InCombatLockdown() then return end

	self:SetAttribute('flyoutDirection', direction)
	self:UpdateFlyout()
end

--utility function, resyncs the button's current action, modified by state
function ActionButton:LoadAction()
	local state = self:GetParent():GetAttribute('state-page')
	local id = state and self:GetAttribute('action--' .. state) or self:GetAttribute('action--base')

	self:SetAttribute('action', id)
end

function ActionButton:Skin()
	if not RazerNaga:Masque('Action Bar', self) then
	    self.icon:SetTexCoord(0.06, 0.94, 0.06, 0.94)
	    self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
	    self.NormalTexture:ClearAllPoints()
	    self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
	    self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)
	    self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
	    self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
	    self.PushedTexture:ClearAllPoints()
	    self.PushedTexture:SetAllPoints()
	    self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	    self.HighlightTexture:ClearAllPoints()
	    self.HighlightTexture:SetAllPoints()
	    self.HighlightTexture:SetBlendMode("ADD")
	    self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
	    self.CheckedTexture:ClearAllPoints()
	    self.CheckedTexture:SetAllPoints()
	    self.CheckedTexture:SetBlendMode("ADD")
	    self.NewActionTexture:SetSize(44, 44)
	    self.NewActionTexture:SetAtlas("bags-newitem")
	    self.NewActionTexture:ClearAllPoints()
	    self.NewActionTexture:SetPoint("CENTER")
	    self.NewActionTexture:SetBlendMode("ADD")
	    self.SpellHighlightTexture:SetSize(44, 44)
	    self.SpellHighlightTexture:SetAtlas("bags-newitem")
	    self.SpellHighlightTexture:ClearAllPoints()
	    self.SpellHighlightTexture:SetPoint("CENTER")
	    self.SpellHighlightTexture:SetBlendMode("ADD")
	    self.Border:SetTexture([[Interface\Buttons\UI-ActionButton-Border]])
	    self.Border:SetSize(62, 62)
	    self.Border:ClearAllPoints()
	    self.Border:SetPoint("CENTER")
	    self.Border:SetBlendMode("ADD")
	    self.cooldown:ClearAllPoints()
	    self.cooldown:SetAllPoints()
	    self.Flash:SetTexture([[Interface\Buttons\UI-QuickslotRed]])
	    self.Flash:ClearAllPoints()
	    self.Flash:SetAllPoints()
	    self.Count:ClearAllPoints()
	    self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
	    self.Count:SetDrawLayer("ARTWORK", 2)
	    if self.IconMask then
	        self.IconMask:Hide()
	    end
	   	if self.SlotArt then
	        self.SlotArt:SetAlpha(0)
	    end
	    if self.SlotBackground then
	        self.SlotBackground:SetAlpha(0)
	    end
	end
end

-- disable new animations
if (ActionBarActionEventsFrame) then
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_TARGET")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_RETICLE_CLEAR")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_START")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_EMPOWER_STOP")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
    ActionBarActionEventsFrame:UnregisterEvent("UNIT_SPELLCAST_FAILED")
end