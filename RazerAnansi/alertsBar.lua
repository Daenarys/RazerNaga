local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi'); _G['Anansi'] = Anansi

local AnansiFont = CreateFont('RazerAnansi_Font')
AnansiFont:SetFont([[Interface\AddOns\RazerAnansi\Fonts\RAZER.ttf]], 28, "")
AnansiFont:SetShadowColor(0, 0, 0, 0.5)
AnansiFont:SetShadowOffset(1, -1)


--[[
	alertsFrame
		a text item on the alert frame
--]]

local ALERT_DURATION = 2


local AlertFrame = RazerNaga:CreateClass('Frame')

function AlertFrame:New(parent)
	local frame = self:Bind(CreateFrame('Frame', nil, parent))
	frame:SetPoint('TOP')
	frame:SetSize(parent:GetWidth(), 86)

	-- local bg = frame:CreateTexture()
	-- bg:SetAllPoints(frame)
	-- bg:SetTexture(0, 0, 0, 0.5)

	local spellText = frame:CreateFontString(nil, 'OVERLAY', 'RazerAnansi_Font')
	spellText:SetPoint('TOP')
	spellText:SetJustifyH('CENTER')
	frame.spellText = spellText

	local tKeyComboFrame = CreateFrame('Frame', nil, frame)
	tKeyComboFrame:SetPoint('TOP', spellText, 'BOTTOM', 0, -4)
	tKeyComboFrame:SetSize(233, 50)

	local tKeyTexture = tKeyComboFrame:CreateTexture(nil, 'OVERLAY')
	tKeyTexture:SetPoint('LEFT', tKeyComboFrame, 'LEFT')
	tKeyTexture:SetSize(165, 50)
	tKeyTexture:SetTexCoord(0.15, 0.85, 0.1, 0.9)
	frame.tKeyTexture = tKeyTexture

	local keyText = tKeyComboFrame:CreateFontString(nil, 'OVERLAY', 'RazerAnansi_Font')
	keyText:SetPoint('LEFT', tKeyTexture, 'RIGHT', 0, 0)
	keyText:SetJustifyH('CENTER')
	keyText:SetJustifyV('CENTER')
	keyText:SetSize(16, 16)
	keyText:SetText('+')
	frame.keyText = keyText

	local keyTexture = frame:CreateTexture(nil, 'OVERLAY')
	keyTexture:SetPoint('LEFT', keyText, 'RIGHT', 4, -3)
	keyTexture:SetSize(44, 44)
	frame.keyTexture = keyTexture

	local group = frame:CreateAnimationGroup()
	group:SetScript('OnFinished', frame.OnAnimationFinished)
	frame.animation = group

	local fadeOut = group:CreateAnimation('Alpha')
	fadeOut:SetFromAlpha(1)
	fadeOut:SetToAlpha(0)
	fadeOut:SetStartDelay(ALERT_DURATION * 0.8)
	fadeOut:SetDuration(ALERT_DURATION * 0.2)
	-- fadeOut:SetOrder(0)

	local move = group:CreateAnimation('Path')
	move:SetSmoothing('NONE')
	move:SetDuration(ALERT_DURATION)
	-- move:SetOrder(0)

	local p1 = move:CreateControlPoint()
	p1:SetOffset(0, -192)
	-- p1:SetOrder(1)
	frame.p1 = p1

	return frame
end

function AlertFrame:ShowTKeyMessage(spellId, tKey, nagaKey)
	local tKeyTexture = self:GetTKeyTexture(tKey)
	local nagaKeyTexture = self:GetNagaKeyTexture(tKey, nagaKey)
	local spellName = GetSpellInfo(spellId)
	local r, g, b = Anansi.Config:GetTKeyColor(tKey)

	r = r/255
	g = g/255
	b = b/255

	self.tKeyTexture:SetTexture(tKeyTexture)

	self.keyTexture:SetTexture(nagaKeyTexture)

	self.spellText:SetText(spellName)
	self.spellText:SetTextColor(0.6, 0.6, 0.6)


	self.keyText:SetTextColor(r, g, b)

	self:Show()
	self.p1:SetOffset(0, -(self:GetParent():GetHeight() - self:GetHeight()) * self:GetParent():GetEffectiveScale())
	self.animation:Play()

	return self
end

function AlertFrame.OnAnimationFinished(animation)
	local parent = animation:GetParent()
	if parent.OnFinished then
		parent:OnFinished()
	end
	parent:Hide()
end

function AlertFrame:GetTKeyTexture(tKey)
	if not tKey then
		return [[Interface\Addons\RazerAnansi\images\None_tpanel]]
	end
	return ([[Interface\Addons\RazerAnansi\images\T%d_set]]):format(tKey)
end

function AlertFrame:GetNagaKeyTexture(tKey, nagaKey)
	return ([[Interface\Addons\RazerAnansi\images\keys\T%d_%d]]):format(tKey or 1, nagaKey)
end


--[[
	alertsQueue
		A queue for displaying alert messages
--]]

local AlertsQueue = RazerNaga.Timer:New()

AlertsQueue.duration = 0.5
AlertsQueue.messages = {}


--[[ events ]]--

function AlertsQueue:OnFinished()
	self:Update()
	if next(self.messages) then
		self:Start()
	end
end

function AlertsQueue:Update()
	local msg = self:PopMessage()
	if msg then
		RazerNaga.Frame:Get('alerts'):GetAlertFrame():ShowTKeyMessage(msg.spellId, msg.tKey, msg.nagaKey)
	end
end

function AlertsQueue:PushMessage(spellId, tKey, nagaKey)
	table.insert(self.messages, {
		['spellId'] = spellId,
		['tKey'] = tKey,
		['nagaKey'] = nagaKey
	})

	if not self:IsRunning() then
		self.nextUpdate = 0
		self:Start()
	end
end

function AlertsQueue:PopMessage()
	local i, msg = next(self.messages)
	if i then
		table.remove(self.messages, i)
		return msg
	end
end


--[[
	alertsBar
		A generic frame for displaying alert messages to the user
--]]

local AlertsBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame); Anansi.AlertsBar = AlertsBar

local unused = {}

function AlertsBar:New()
	local f = self.proto.New(self, 'alerts')
	f:SetFrameStrata('HIGH')
	f:Layout()

	return f
end

function AlertsBar:GetDefaults()
	return {
		point = 'TOP',
		x = 0,
		y = -60,
	}
end

function AlertsBar:ShowTKeyMessage(spellId, tKey, nagaKey)
	AlertsQueue:PushMessage(spellId, tKey, nagaKey)
end


function AlertsBar:GetAlertFrame()
	local index, frame = next(unused)
	if frame then
		table.remove(unused, index)
		return frame
	end

	local frame = AlertFrame:New(self)
	frame.OnFinished = self.OnAlertFinished
	return frame
end

function AlertsBar.OnAlertFinished(alert)
	table.insert(unused, alert)
end

function AlertsBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel:NewOpacitySlider()
	panel:NewFadeSlider()
	panel:NewScaleSlider()
	panel:NewPaddingSlider()

	self.menu = menu
end

function AlertsBar:Layout()
	local pw, ph = self:GetPadding()
	self:SetSize(246 + pw, 428 + ph)
end

--[[
do
--test image
local f = AlertFrame:New(UIParent)
f:ShowTKeyMessage(7384, 1, 1)
f.animation:Stop()
end
--]]