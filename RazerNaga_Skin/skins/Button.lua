-- restore old button animations
local function OverlayGlowAnimOutFinished(animGroup)
	local overlay = animGroup:GetParent()
	local frame = overlay:GetParent()
	overlay:Hide()
	frame.ActionButtonOverlay = nil
end

local function OverlayGlow_OnHide(self)
	if self.animOut:IsPlaying() then
		self.animOut:Stop()
		OverlayGlowAnimOutFinished(self.animOut)
	end
end

local function OverlayGlow_OnUpdate(self, elapsed)
	AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, 0.01)
	local cooldown = self:GetParent().cooldown
	if cooldown and cooldown:IsShown() and cooldown:GetCooldownDuration() > 3000 then
		self:SetAlpha(0.5)
	else
		self:SetAlpha(1.0)
	end
end

local function CreateScaleAnim(group, target, order, duration, x, y, delay)
	local scale = group:CreateAnimation("Scale")
	scale:SetTarget(target)
	scale:SetOrder(order)
	scale:SetDuration(duration)
	scale:SetScale(x, y)

	if delay then
		scale:SetStartDelay(delay)
	end
end

local function CreateAlphaAnim(group, target, order, duration, fromAlpha, toAlpha, delay)
	local alpha = group:CreateAnimation("Alpha")
	alpha:SetTarget(target)
	alpha:SetOrder(order)
	alpha:SetDuration(duration)
	alpha:SetFromAlpha(fromAlpha)
	alpha:SetToAlpha(toAlpha)

	if delay then
		alpha:SetStartDelay(delay)
	end
end

local function AnimIn_OnPlay(group)
	local frame = group:GetParent()
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

local function AnimIn_OnFinished(group)
	local frame = group:GetParent()
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

hooksecurefunc("ActionButton_SetupOverlayGlow", function(button)
    if button.SpellActivationAlert then
        button.SpellActivationAlert:SetAlpha(0)
    end

    if button.ActionButtonOverlay then
        return;
    end

    local name = button:GetName()
    local overlay = CreateFrame("Frame", name, UIParent)

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

	-- setup antimations
	overlay.animIn = overlay:CreateAnimationGroup()
	CreateScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 1.5, 1.5)
	CreateAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 0, 1)
	CreateScaleAnim(overlay.animIn, overlay.innerGlow,      1, 0.3, 2, 2)
	CreateScaleAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 2, 2)
	CreateAlphaAnim(overlay.animIn, overlay.innerGlowOver,  1, 0.3, 1, 0)
	CreateScaleAnim(overlay.animIn, overlay.outerGlow,      1, 0.3, 0.5, 0.5)
	CreateScaleAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 0.5, 0.5)
	CreateAlphaAnim(overlay.animIn, overlay.outerGlowOver,  1, 0.3, 1, 0)
	CreateScaleAnim(overlay.animIn, overlay.spark,          1, 0.2, 2/3, 2/3, 0.2)
	CreateAlphaAnim(overlay.animIn, overlay.spark,          1, 0.2, 1, 0, 0.2)
	CreateAlphaAnim(overlay.animIn, overlay.innerGlow,      1, 0.2, 1, 0, 0.3)
	CreateAlphaAnim(overlay.animIn, overlay.ants,           1, 0.2, 0, 1, 0.3)
	overlay.animIn:SetScript("OnPlay", AnimIn_OnPlay)
	overlay.animIn:SetScript("OnFinished", AnimIn_OnFinished)

	overlay.animOut = overlay:CreateAnimationGroup()
	CreateAlphaAnim(overlay.animOut, overlay.outerGlowOver, 1, 0.2, 0, 1)
	CreateAlphaAnim(overlay.animOut, overlay.ants,          1, 0.2, 1, 0)
	CreateAlphaAnim(overlay.animOut, overlay.outerGlowOver, 2, 0.2, 1, 0)
	CreateAlphaAnim(overlay.animOut, overlay.outerGlow,     2, 0.2, 1, 0)
	overlay.animOut:SetScript("OnFinished", OverlayGlowAnimOutFinished)

	-- scripts
	overlay:SetScript("OnUpdate", OverlayGlow_OnUpdate)
	overlay:SetScript("OnHide", OverlayGlow_OnHide)

	local frameWidth, frameHeight = button:GetSize()
	overlay:SetParent(button)
	overlay:SetFrameLevel(button:GetFrameLevel() + 5)
	overlay:ClearAllPoints()
	overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4)
	overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2)
	overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2)
	overlay.animIn:Play()
	button.ActionButtonOverlay = overlay
end)

hooksecurefunc("ActionButton_ShowOverlayGlow", function(button)
	if button.ActionButtonOverlay then
		if button.ActionButtonOverlay.animOut:IsPlaying() then
			button.ActionButtonOverlay.animOut:Stop()
			button.ActionButtonOverlay.animIn:Play()
		end
	end
end)

hooksecurefunc("ActionButton_HideOverlayGlow", function(button)
	if button.ActionButtonOverlay then
		if button.ActionButtonOverlay.animIn:IsPlaying() then
			button.ActionButtonOverlay.animIn:Stop()
		end
		if button:IsVisible() then
			button.ActionButtonOverlay.animOut:Play()
		else
			OverlayGlowAnimOutFinished(button.ActionButtonOverlay.animOut)
		end
	end
end)

hooksecurefunc("StartChargeCooldown", function(parent)
    parent.chargeCooldown:SetAllPoints(parent)
end)

hooksecurefunc("CooldownFrame_Set", function(self)
	if not self:IsForbidden() then
		self:SetEdgeTexture("Interface\\Cooldown\\edge")
	end
end)

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