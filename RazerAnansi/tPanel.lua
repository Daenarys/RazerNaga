--[[
	T-Panel
		This is a frame that's shown when hovering over a bar in order to display what T-Key the bar is associated with
--]]

local RazerNaga = LibStub('AceAddon-3.0'):GetAddon('RazerNaga')
local Anansi = RazerNaga:GetModule('Anansi')
local TPanel = CreateFrame('Frame', nil, UIParent); TPanel:Hide(); Anansi.TPanel = TPanel

--[[ frame events ]]--

function TPanel:OnShow()
	self.nextUpdate = 0
end

function TPanel:OnUpdate(elapsed)
	local nextUpdate = (self.nextUpdate or 0) - elapsed
	if nextUpdate > 0 then
		self.nextUpdate = nextUpdate
	else
		self.nextUpdate = 0.3

		if not(self:IsMouseOver(2, -2, -2, 2) or self.owner:IsMouseOver(2, -2, -2, 2)) then
			self:Release()
		else
			self:UpdatePosition()
		end
	end
end


--[[ attach/detach tPanel to/from frame ]]--

function TPanel:Set(frame)
	if not self.isLoaded then
		self:Load()
	end

	self.owner = frame
	if frame then
		self:Hide()
		self:UpdateDisplay()
		UIFrameFadeIn(self, 0.1)
	else
		self:Hide()
	end

	return self
end

function TPanel:Release()
	self:Set(nil)
	return self
end

function TPanel:IsOwned(frame)
	return self.owner == frame
end


--[[ update display text ]]--

function TPanel:UpdateDisplay()
	local tKey = Anansi:GetFrameTKey(self.owner)
	
	self.bg:SetTexture(self:GetTPanelTexture(tKey))
	self.bg:SetAlpha(0.8)
	
	return self
end

function TPanel:GetTPanelTexture(tKey)
	return ([[Interface\Addons\RazerAnansi\images\T%d-small]]):format(tKey)
end


--[[ update panel position ]]--

function TPanel:UpdatePosition()
	self:ClearAllPoints()
	local x, y = GetCursorPosition()
	local yOffset = (not RazerNaga:Locked()) and 20 or 0

	--adjust panel display position based on where the owner frame is at on screen
	if y > GetScreenHeight() * 0.5 then
		self:SetPoint('TOP', self.owner, 'BOTTOM', 0, -2)
	else
		self:SetPoint('BOTTOM', self.owner, 'TOP', 0, 2 + yOffset)
	end

	return self
end

--[[ add stuff to panel dynamically ]]--

function TPanel:Load()
	self:SetSize(1024/8, 256/8)
	self:SetFrameStrata('DIALOG')
	self:SetToplevel(true)
	self:EnableMouse(false)
	self:SetClampedToScreen(true)

	local bg = self:CreateTexture(nil, 'ARTWORK')
	bg:SetAllPoints(self)
	self.bg = bg
	
	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnUpdate', self.OnUpdate)
	self.isLoaded = true

	return self
end