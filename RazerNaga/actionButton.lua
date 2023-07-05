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
		return _G['MultiBarRightButton' .. (id-24)]
	elseif id <= 48 then
		return _G['MultiBarLeftButton' .. (id-36)]
	elseif id <= 60 then
		return _G['MultiBarBottomRightButton' .. (id-48)]
	elseif id <= 72 then
		return _G['MultiBarBottomLeftButton' .. (id-60)]
	end
	return CreateFrame('CheckButton', 'RazerNagaActionButton' .. (id-60), nil, 'ActionBarButtonTemplate')
end

--constructor
function ActionButton:New(id)
	local b = self:Restore(id) or self:Create(id)

	if b then
		b:SetAttribute('showgrid', 0)
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
		    local show = (self:GetAttribute("showgrid") > 0 or HasAction(self:GetAttribute("action")))
		                 and not self:GetAttribute("statehidden")
		    if show then
		        self:SetAlpha(1.0)
		    else
		        self:SetAlpha(0.0)
		    end
		]])

		Bindings:Register(b, b:GetName():match('RazerNagaActionButton%d'))
		Tooltips:Register(b)

		--get rid of range indicator text
		local hotkey = b.HotKey
		if hotkey:GetText() == _G['RANGE_INDICATOR'] then
			hotkey:SetText('')
		end

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
		b:SetSize(36, 36)
		b:Skin()

        RazerNaga.SpellFlyout:WrapScript(b, "OnClick", [[
            if not down then
                local actionType, actionID = GetActionInfo(self:GetAttribute("action"))
                if actionType == "flyout" then
                    control:SetAttribute("caller", self)
                    control:RunAttribute("Toggle", actionID)
                    return false
                end
            end
        ]])

		if b.UpdateHotKeys then
			hooksecurefunc(b, 'UpdateHotkeys', ActionButton.UpdateHotkey)
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
	self:UpdateState()
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
        self.PushedTexture:SetSize(36, 36)
        self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
        self.HighlightTexture:SetSize(36, 36)
        self.HighlightTexture:SetBlendMode("ADD")
        self.CheckedTexture:SetTexture([[Interface\Buttons\CheckButtonHilight]])
        self.CheckedTexture:ClearAllPoints()
        self.CheckedTexture:SetAllPoints()
        self.CheckedTexture:SetBlendMode("ADD")
        self.SpellHighlightTexture:SetPoint("TOPLEFT", -2, 2)
        self.SpellHighlightTexture:SetPoint("BOTTOMRIGHT", 2, -2)
        self.SpellHighlightTexture:SetBlendMode("ADD")
        self.QuickKeybindHighlightTexture:SetPoint("TOPLEFT", -2, 2)
        self.QuickKeybindHighlightTexture:SetPoint("BOTTOMRIGHT", 2, -2)
        self.NewActionTexture:ClearAllPoints()
        self.NewActionTexture:SetAllPoints()
        self.Border:ClearAllPoints()
        self.Border:SetPoint("TOPLEFT", -3, 3)
        self.Border:SetPoint("BOTTOMRIGHT", 3, -3)
        self.cooldown:ClearAllPoints()
        self.cooldown:SetAllPoints()
        self.cooldown:SetDrawBling(true)
        self.Flash:SetTexture([[Interface\Buttons\UI-QuickslotRed]])
        self.Flash:ClearAllPoints()
        self.Flash:SetAllPoints()
        self.HotKey:SetFont('FONTS\\ARIALN.TTF', 12, 'THICKOUTLINE, MONOCHROME')
        self.Count:ClearAllPoints()
        self.Count:SetPoint("BOTTOMRIGHT", -2, 2)
        self.FlyoutBorderShadow:SetSize(48, 48)
        self.FlyoutBorderShadow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
        self.FlyoutBorderShadow:SetTexCoord(0.01562500, 0.76562500, 0.00781250, 0.38281250)
        self.FlyoutBorderShadow:ClearAllPoints()
        self.FlyoutBorderShadow:SetPoint("CENTER")
        self.FlyoutBorderShadow:SetDrawLayer("ARTWORK", 1)

		if (self.FlyoutArrow == nil) then
			self.FlyoutArrow = self:CreateTexture(nil, "OVERLAY")
		end
		self.FlyoutArrow:SetSize(24, 11)
		self.FlyoutArrow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
		self.FlyoutArrow:SetTexCoord(0.62500000, 0.98437500, 0.74218750, 0.82812500)
		self.FlyoutArrow:Hide()

		if (self.RightDivider:IsShown()) then
			self.RightDivider:Hide()
		end
		if (self.BottomDivider:IsShown()) then
			self.BottomDivider:Hide()
		end
		if (self.SlotArt:IsShown()) then
			self.SlotArt:Hide()
		end
		if (self.SlotBackground:IsShown()) then
			self.SlotBackground:Hide()
		end

        hooksecurefunc(self, "UpdateFlyout", function()
			if not self.FlyoutBorderShadow then
				return
			end

        	local actionType = GetActionInfo(self.action);
			if (actionType == "flyout") then
				local arrowDistance;
				if ((RazerNaga.SpellFlyout and RazerNaga.SpellFlyout:IsShown() and RazerNaga.SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
					self.FlyoutBorderShadow:Show()
				else
					self.FlyoutBorderShadow:Hide()
				end
				self.FlyoutArrow:Show()
				self.FlyoutArrow:ClearAllPoints()
				local direction = self:GetAttribute("flyoutDirection");
				if (direction == "LEFT") then
					self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -2, 0);
					SetClampedTextureRotation(self.FlyoutArrow, 270);
				elseif (direction == "RIGHT") then
					self.FlyoutArrow:SetPoint("RIGHT", self, "RIGHT", 2, 0);
					SetClampedTextureRotation(self.FlyoutArrow, 90);
				elseif (direction == "DOWN") then
					self.FlyoutArrow:SetPoint("BOTTOM", self, "BOTTOM", 0, -2);
					SetClampedTextureRotation(self.FlyoutArrow, 180);
				else
					self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, 2);
					SetClampedTextureRotation(self.FlyoutArrow, 0);
				end
			else
				self.FlyoutArrow:Hide();
				self.FlyoutBorderShadow:Hide()
			end
			self.FlyoutArrowContainer:Hide()
		end)

		hooksecurefunc(self, "UpdateButtonArt", function()
	        self.NormalTexture:SetTexture([[Interface\Buttons\UI-Quickslot2]])
	        self.NormalTexture:ClearAllPoints()
	        self.NormalTexture:SetPoint("TOPLEFT", -15, 15)
	        self.NormalTexture:SetPoint("BOTTOMRIGHT", 15, -15)
	        self.NormalTexture:SetVertexColor(1, 1, 1, 0.5)
	        self.PushedTexture:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
	        self.PushedTexture:SetSize(36, 36)

        	if (self.RightDivider:IsShown()) then
				self.RightDivider:Hide()
			end
			if (self.BottomDivider:IsShown()) then
				self.BottomDivider:Hide()
			end
			if (self.SlotArt:IsShown()) then
				self.SlotArt:Hide()
			end
			if (self.SlotBackground:IsShown()) then
				self.SlotBackground:Hide()
			end
        end)

		hooksecurefunc(self, "Update", function(self)
			if ( self.HotKey:GetText() == RANGE_INDICATOR ) then
				self.HotKey:Hide();
			else
				self.HotKey:SetVertexColor(0.6, 0.6, 0.6);
			end
		end)

        hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
            if ( self.HotKey:GetText() == RANGE_INDICATOR ) then
                if ( checksRange ) then
                    self.HotKey:Show();
                    if ( inRange ) then
                        self.HotKey:SetVertexColor(0.6, 0.6, 0.6)
                    else
                        self.HotKey:SetVertexColor(RED_FONT_COLOR:GetRGB());
                    end
                else
                    self.HotKey:Hide();
                end
            else
                if ( checksRange and not inRange ) then
                    self.HotKey:SetVertexColor(RED_FONT_COLOR:GetRGB());
                else
                    self.HotKey:SetVertexColor(0.6, 0.6, 0.6)
                end
            end
        end)
    end
end