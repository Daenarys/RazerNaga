--[[ 
	Action Button.lua
		A RazerNaga action button
--]]

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
		return _G['MultiBar5Button' .. (id-12)]
	elseif id <= 36 then
		return _G['MultiBarRightButton' .. (id-24)]
	elseif id <= 48 then
		return _G['MultiBarLeftButton' .. (id-36)]
	elseif id <= 60 then
		return _G['MultiBarBottomRightButton' .. (id-48)]
	elseif id <= 72 then
		return _G['MultiBarBottomLeftButton' .. (id-60)]
	elseif id <= 84 then
		return _G['MultiBar6Button' .. (id-72)]
	elseif id <= 96 then
		return _G['MultiBar7Button' .. (id-84)]
	end
	return CreateFrame('CheckButton', 'RazerNagaActionButton' .. (id-96), nil, 'ActionBarButtonTemplate')
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
		        self:SetAlpha(1.0)
		    else
		        self:SetAlpha(0.0)
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
		b:SetSize(36, 36)
		b:Skin()

		if b.UpdateHotKeys then
			hooksecurefunc(b, 'UpdateHotkeys', self.UpdateHotkey)
		end

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

--override the old update hotkeys function
if ActionButton_UpdateHotkeys then
	hooksecurefunc('ActionButton_UpdateHotkeys', ActionButton.UpdateHotkey)
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

function ActionButton:UpdateState()
	self:UpdateState()
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
		self.PushedTexture:SetSize(36, 36)
		self.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
		self.HighlightTexture:SetSize(36, 36)
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
		self.QuickKeybindHighlightTexture:SetAtlas("bags-newitem")
		self.QuickKeybindHighlightTexture:ClearAllPoints()
		self.QuickKeybindHighlightTexture:SetPoint("TOPLEFT", -2, 2)
		self.QuickKeybindHighlightTexture:SetPoint("BOTTOMRIGHT", 2, -2)
		self.QuickKeybindHighlightTexture:SetBlendMode("ADD")
		self.QuickKeybindHighlightTexture:SetAlpha(0.5)
		self.Border:ClearAllPoints()
		self.Border:SetPoint("TOPLEFT", -3, 3)
		self.Border:SetPoint("BOTTOMRIGHT", 3, -3)
		self.cooldown:ClearAllPoints()
		self.cooldown:SetAllPoints()
		self.Flash:SetTexture([[Interface\Buttons\UI-QuickslotRed]])
		self.Flash:ClearAllPoints()
		self.Flash:SetAllPoints()
		self.Count:ClearAllPoints()
		self.Count:SetPoint("BOTTOMRIGHT", -2, 2)

		self.FlyoutContainer = CreateFrame("Frame", nil, self)
		self.FlyoutContainer:SetAllPoints()

		self.FlyoutArrow = self.FlyoutContainer:CreateTexture()
		self.FlyoutArrow:SetSize(23, 11)
		self.FlyoutArrow:SetDrawLayer("ARTWORK", 2)
		self.FlyoutArrow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
		self.FlyoutArrow:SetTexCoord(0.62500000, 0.98437500, 0.74218750, 0.82812500)
		self.FlyoutArrow:Hide()

		self.FlyoutBorder = self.FlyoutContainer:CreateTexture()
		self.FlyoutBorder:SetSize(42, 42)
		self.FlyoutBorder:SetPoint("CENTER")
		self.FlyoutBorder:SetDrawLayer("ARTWORK", 1)
		self.FlyoutBorder:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
		self.FlyoutBorder:SetTexCoord(0.01562500, 0.67187500, 0.39843750, 0.72656250)
		self.FlyoutBorder:Hide()

		self.FlyoutShadow = self:CreateTexture()
		self.FlyoutShadow:SetSize(48, 48)
		self.FlyoutShadow:SetPoint("CENTER")
		self.FlyoutShadow:SetDrawLayer("ARTWORK", 1)
		self.FlyoutShadow:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
		self.FlyoutShadow:SetTexCoord(0.01562500, 0.76562500, 0.00781250, 0.38281250)
		self.FlyoutShadow:Hide()

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
			if not self.FlyoutArrow then return end

        	local actionType = GetActionInfo(self.action);
			if (actionType == "flyout") then
				local arrowDistance;

				if ((RazerNaga.SpellFlyout and RazerNaga.SpellFlyout:IsShown() and RazerNaga.SpellFlyout:GetParent() == self) or GetMouseFocus() == self) then
					self.FlyoutBorder:Show();
					self.FlyoutShadow:Show();
					arrowDistance = 5;
				else
					self.FlyoutBorder:Hide();
					self.FlyoutShadow:Hide();
					arrowDistance = 2;
				end
				self.FlyoutArrow:Show();
				self.FlyoutArrow:ClearAllPoints();
				local direction = self:GetAttribute("flyoutDirection");
				if (direction == "LEFT") then
					self.FlyoutArrow:SetPoint("LEFT", self, "LEFT", -arrowDistance, 0);
					SetClampedTextureRotation(self.FlyoutArrow, 270);
				elseif (direction == "RIGHT") then
					self.FlyoutArrow:SetPoint("RIGHT", self, "RIGHT", arrowDistance, 0);
					SetClampedTextureRotation(self.FlyoutArrow, 90);
				elseif (direction == "DOWN") then
					self.FlyoutArrow:SetPoint("BOTTOM", self, "BOTTOM", 0, -arrowDistance);
					SetClampedTextureRotation(self.FlyoutArrow, 180);
				else
					self.FlyoutArrow:SetPoint("TOP", self, "TOP", 0, arrowDistance);
					SetClampedTextureRotation(self.FlyoutArrow, 0);
				end
			else
				self.FlyoutArrow:Hide()
				self.FlyoutBorder:Hide()
				self.FlyoutShadow:Hide()
			end
			self.FlyoutArrowContainer:Hide()
			self.FlyoutBorderShadow:Hide()
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
    end
end

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

hooksecurefunc("ActionButtonCooldown_OnCooldownDone", function(cooldown)
	cooldown:SetDrawBling(true)
end)

hooksecurefunc("ActionButton_SetupOverlayGlow", function(button)
	if button.SpellActivationAlert then
		button.SpellActivationAlert:SetAlpha(0)
	end

	if button.ActionButtonOverlay then
		return;
	end

	local name = button:GetName()
	local overlay = CreateFrame("Frame", nil, button)
	
	-- spark
	overlay.spark = overlay:CreateTexture(name .. "Spark", "BACKGROUND")
	overlay.spark:SetPoint("CENTER")
	overlay.spark:SetAlpha(0)
	overlay.spark:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)
	
	-- inner glow
	overlay.innerGlow = overlay:CreateTexture(name .. "InnerGlow", "ARTWORK")
	overlay.innerGlow:SetPoint("CENTER")
	overlay.innerGlow:SetAlpha(0)
	overlay.innerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	
	-- inner glow over
	overlay.innerGlowOver = overlay:CreateTexture(name .. "InnerGlowOver", "ARTWORK")
	overlay.innerGlowOver:SetPoint("TOPLEFT", overlay.innerGlow, "TOPLEFT")
	overlay.innerGlowOver:SetPoint("BOTTOMRIGHT", overlay.innerGlow, "BOTTOMRIGHT")
	overlay.innerGlowOver:SetAlpha(0)
	overlay.innerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.innerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)
	
	-- outer glow
	overlay.outerGlow = overlay:CreateTexture(name .. "OuterGlow", "ARTWORK")
	overlay.outerGlow:SetPoint("CENTER")
	overlay.outerGlow:SetAlpha(0)
	overlay.outerGlow:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	
	-- outer glow over
	overlay.outerGlowOver = overlay:CreateTexture(name .. "OuterGlowOver", "ARTWORK")
	overlay.outerGlowOver:SetPoint("TOPLEFT", overlay.outerGlow, "TOPLEFT")
	overlay.outerGlowOver:SetPoint("BOTTOMRIGHT", overlay.outerGlow, "BOTTOMRIGHT")
	overlay.outerGlowOver:SetAlpha(0)
	overlay.outerGlowOver:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
	overlay.outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)
	
	-- ants
	overlay.ants = overlay:CreateTexture(name .. "Ants", "OVERLAY")
	overlay.ants:SetPoint("CENTER")
	overlay.ants:SetAlpha(0)
	overlay.ants:SetTexture([[Interface\SpellActivationOverlay\IconAlertAnts]])
	
	overlay.OnUpdate = function(button, elapsed)
		AnimateTexCoords(button.ants, 256, 256, 48, 48, 22, elapsed, 0.01)
		local cooldown = button:GetParent().cooldown
		-- we need some threshold to avoid dimming the glow during the gdc
		-- (using 1500 exactly seems risky, what if casting speed is slowed or something?)
		if(cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration() > 3000) then
			button:SetAlpha(0.5)
		else
			button:SetAlpha(1.0)
		end
	end
	overlay:SetScript("OnUpdate", overlay.OnUpdate)
	
	overlay.OnHide = function(button)
		if ( button.animOut:IsPlaying() ) then
			button.animOut:Stop()
			button.animOut:OnFinished()
		end
	end
	overlay:SetScript("OnHide", overlay.OnHide)
	
	local tmpanim
	overlay.animIn = overlay:CreateAnimationGroup()
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.spark)
	tmpanim:SetDuration(0.2)
	tmpanim:SetScale(1.5, 1.5)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.spark)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(0)
	tmpanim:SetToAlpha(1)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.innerGlow)
	tmpanim:SetDuration(0.3)
	tmpanim:SetScale(2, 2)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.innerGlowOver)
	tmpanim:SetDuration(0.3)
	tmpanim:SetScale(2, 2)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.innerGlowOver)
	tmpanim:SetDuration(0.3)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.outerGlow)
	tmpanim:SetDuration(0.3)
	tmpanim:SetScale(0.5, 0.5)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.outerGlowOver)
	tmpanim:SetDuration(0.3)
	tmpanim:SetScale(0.5, 0.5)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.outerGlowOver)
	tmpanim:SetDuration(0.3)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Scale")
	tmpanim:SetTarget(overlay.spark)
	tmpanim:SetStartDelay(0.2)
	tmpanim:SetDuration(0.2)
	tmpanim:SetScale(0.666666, 0.666666)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.spark)
	tmpanim:SetStartDelay(0.2)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.innerGlow)
	tmpanim:SetStartDelay(0.3)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animIn:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.ants)
	tmpanim:SetStartDelay(0.3)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(0)
	tmpanim:SetToAlpha(1)
	tmpanim:SetOrder(1)
	
	overlay.animIn.OnPlay = function(button)
		local frame = button:GetParent()
		local frameWidth, frameHeight = frame:GetSize()
		frame.spark:SetSize(frameWidth, frameHeight)
		frame.spark:SetAlpha(0.3)
		frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
		frame.innerGlow:SetAlpha(1.0)
		frame.innerGlowOver:SetAlpha(1.0)
		frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
		frame.outerGlow:SetAlpha(1.0)
		frame.outerGlowOver:SetAlpha(1.0)
		frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
		frame.ants:SetAlpha(0)
		frame:Show()
	end
	overlay.animIn:SetScript("OnPlay", overlay.animIn.OnPlay)
	
	overlay.animIn.OnFinished = function(button)
		local frame = button:GetParent()
		local frameWidth, frameHeight = frame:GetSize()
		frame.spark:SetAlpha(0)
		frame.innerGlow:SetAlpha(0)
		frame.innerGlow:SetSize(frameWidth, frameHeight)
		frame.innerGlowOver:SetAlpha(0.0)
		frame.outerGlow:SetSize(frameWidth, frameHeight)
		frame.outerGlowOver:SetAlpha(0.0)
		frame.outerGlowOver:SetSize(frameWidth, frameHeight)
		frame.ants:SetAlpha(1.0)
	end
	overlay.animIn:SetScript("OnFinished", overlay.animIn.OnFinished)
	
	overlay.animOut = overlay:CreateAnimationGroup()
	
	tmpanim = overlay.animOut:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.outerGlowOver)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(0)
	tmpanim:SetToAlpha(1)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animOut:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.ants)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(1)
	
	tmpanim = overlay.animOut:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.outerGlowOver)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(2)
	
	tmpanim = overlay.animOut:CreateAnimation("Alpha")
	tmpanim:SetTarget(overlay.outerGlow)
	tmpanim:SetDuration(0.2)
	tmpanim:SetFromAlpha(1)
	tmpanim:SetToAlpha(0)
	tmpanim:SetOrder(2)
	
	overlay.animOut.OnFinished = function(button)
		local frame = button:GetParent()
		frame:Hide()
	end
	overlay.animOut:SetScript("OnFinished", overlay.animOut.OnFinished)
	
	button.ActionButtonOverlay = overlay
	local frameWidth, frameHeight = button:GetSize()
	overlay:ClearAllPoints();
	overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4)
	overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
	overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
	overlay:Hide()
	
	hooksecurefunc("ActionButton_ShowOverlayGlow", function(button)
		if not (button.ActionButtonOverlay) then
			return
		end
		if button.ActionButtonOverlay.animOut:IsPlaying() then
			button.ActionButtonOverlay.animOut:Stop()
		end
		if not button.ActionButtonOverlay:IsShown() then
			button.ActionButtonOverlay.animIn:Play()
		end
	end)

	hooksecurefunc("ActionButton_HideOverlayGlow", function(button)
		if not (button.ActionButtonOverlay) then
			return
		end
		if button.ActionButtonOverlay.animIn:IsPlaying() then
			button.ActionButtonOverlay.animIn:Stop()
		end
		if button:IsVisible() then
			button.ActionButtonOverlay.animOut:Play()
		else
			button.ActionButtonOverlay.animOut:OnFinished()
		end
	end)
end)