--[[
	hoverMenu.lua
		A popup menu that is displayed when hovering over a RazerNaga frame in configuration mode
--]]

local HoverMenu = CreateFrame('Frame', nil, UIParent)
HoverMenu:Hide()

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')
local ICON_SHOW_MENU = [[Interface\Addons\RazerNaga\Icons\Configure]]
local ICON_SHOW_FRAME = [[Interface\Addons\RazerNaga\Icons\Show]]
local ICON_HIDE_FRAME = [[Interface\Addons\RazerNaga\Icons\Hide]]

RazerNaga.HoverMenu = HoverMenu

function HoverMenu:Set(frame)
	if not self.isLoaded then
		self:Load()
	end

	if self.owner then
		self.owner.drag:UnlockHighlight()
	end

	self.owner = frame
	if frame then
		self:Hide()
		self:SetPoint('BOTTOMLEFT', frame, 'TOPLEFT')
		frame.drag:LockHighlight()
		UIFrameFadeIn(self, 0.1)
	else
		self:Hide()
	end
end

function HoverMenu:Free()
	self:Set(nil)
end

function HoverMenu:IsOwned(frame)
	return self.owner == frame
end

function HoverMenu:OnUpdate(elapsed)
	if not(MouseIsOver(self, 2, -2, -2, 2) or MouseIsOver(self.owner, 2, -2, -2, 2)) then
		self:Set(nil)
	end
end

function HoverMenu:Load()
	self:SetFrameStrata('DIALOG')
	self:SetToplevel(true)
	self:EnableMouse(true)
	self:SetClampedToScreen(true)
	self:SetWidth(40)
	self:SetHeight(18)

	--show menu
	local toggleVisibility = self:CreateToggleVisibilityButton()
	toggleVisibility:SetPoint('LEFT')

	--show/hide frame
	local showMenu = self:CreateToggleConfigMenuButton()
	showMenu:SetPoint('LEFT', toggleVisibility, 'RIGHT', 0, 0)

	self:SetScript('OnUpdate', self.OnUpdate)
	self.isLoaded = true
end


local function basicButton_SetTexture(self, texture)
	self:GetNormalTexture():SetTexture(texture)
	self:GetPushedTexture():SetTexture(texture)
end

function HoverMenu:CreateBasicButton(width, height, texture)
	local b = CreateFrame('Button', nil, self)

	local nt = b:CreateTexture()
	nt:SetAllPoints(b)
	b:SetNormalTexture(nt)

	local pt = b:CreateTexture()
	pt:SetTexCoord(-0.03, 1.03, -0.03, 1.03)
	pt:SetVertexColor(0.9, 0.9, 0.9)
	pt:SetAllPoints(b)
	b:SetPushedTexture(pt)

	b:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])

	b:SetWidth(width)
	b:SetHeight(height or width)

	b.SetTexture = basicButton_SetTexture
	b:SetTexture(texture)

	return b
end

function HoverMenu:CreateToggleVisibilityButton()
	local b = self:CreateBasicButton(20, 20, ICON_HIDE_FRAME)

	b.UpdateIcon = function(self)
		if self:GetParent().owner:FrameIsShown() then
			self:SetTexture(ICON_HIDE_FRAME)
		else
			self:SetTexture(ICON_SHOW_FRAME)
		end
	end

	b.UpdateTooltip = function(self)
		if self:GetParent().owner:FrameIsShown() then
			GameTooltip:SetText(L.ToggleVisibilityHelpHide)
		else
			GameTooltip:SetText(L.ToggleVisibilityHelpShow)
		end
	end

	b:SetScript('OnShow', function(self)
		self:UpdateIcon()
	end)

	b:SetScript('OnClick', function(self)
		self:GetParent().owner:ToggleFrame()
		self:UpdateIcon()
	end)

	b:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		self:UpdateTooltip()
	end)

	b:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return b
end

function HoverMenu:CreateToggleConfigMenuButton()
	local b = self:CreateBasicButton(20, 20, ICON_SHOW_MENU)

	b:SetScript('OnClick', function(self)
		self:GetParent().owner:ShowMenu()
	end)

	b:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
		GameTooltip:SetText(L.ConfigureBarHelp)
	end)

	b:SetScript('OnLeave', function(self)
		GameTooltip:Hide()
	end)

	return b
end