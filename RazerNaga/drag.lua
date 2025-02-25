--[[
	drag.lua
		A RazerNaga frame component that controls frame movement
--]]

local Drag = RazerNaga:CreateClass('Button')
RazerNaga.DragFrame = Drag

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')


function Drag:New(owner)
	local f = self:Bind(CreateFrame('Button', nil, UIParent))
	f.owner = owner

	f:EnableMouseWheel(true)
	f:SetClampedToScreen(true)
	f:SetFrameStrata(owner:GetFrameStrata())
	f:SetAllPoints(owner)
	f:SetFrameLevel(owner:GetFrameLevel() + 5)

	local bg = f:CreateTexture(nil, 'BACKGROUND')
	bg:SetColorTexture(1, 1, 1, 0.4)
	bg:SetAllPoints(f)
	f:SetNormalTexture(bg)

	local t = f:CreateTexture(nil, 'BACKGROUND')
	t:SetColorTexture(0.2, 0.3, 0.4, 0.5)
	t:SetAllPoints(f)
	f:SetHighlightTexture(t)

	f:SetNormalFontObject('GameFontNormalLarge')
	f:SetText(owner.id)

	f:RegisterForClicks('AnyUp')
	f:RegisterForDrag('LeftButton')
	f:SetScript('OnMouseDown', self.StartMoving)
	f:SetScript('OnMouseUp', self.StopMoving)
	f:SetScript('OnMouseWheel', self.OnMouseWheel)
	f:SetScript('OnClick', self.OnClick)
	f:SetScript('OnEnter', self.OnEnter)
	f:SetScript('OnLeave', self.OnLeave)
	f:Hide()

	return f
end


function Drag:OnEnter()
	RazerNaga.HoverMenu:Set(self.owner)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT')
	self:UpdateTooltip()
end

function Drag:UpdateTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine(format('Bar: %s', self:GetText():gsub('^%l', string.upper)), 1, 1, 1, 1)

	local tooltipText = self.owner:GetTooltipText()
	if tooltipText then
		GameTooltip:AddLine(tooltipText .. '\n', nil, nil, nil, nil, 1)
	end

	if self.owner.ShowMenu then
		GameTooltip:AddLine(L.ShowConfig, nil, nil, nil, nil, 1)
	end

	if self.owner:IsShown() then
		GameTooltip:AddLine(L.HideBar, nil, nil, nil, nil, 1)
	else
		GameTooltip:AddLine(L.ShowBar, nil, nil, nil, nil, 1)
	end

	GameTooltip:AddLine(format(L.SetAlpha, ceil(self.owner:GetFrameAlpha()*100)), nil, nil, nil, nil, 1)

	GameTooltip:Show()
end

function Drag:OnLeave()
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

function Drag:HideTooltipAndMenu()
	if RazerNaga.HoverMenu:IsOwned(self.owner) then
		RazerNaga.HoverMenu:Free()
	end
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide()
	end
end

function Drag:StartMoving(button)
	if button == 'LeftButton' then
		self.isMoving = true
		self.owner:StartMoving()
		self:HideTooltipAndMenu()
	end
end

function Drag:StopMoving()
	if self.isMoving then
		self.isMoving = nil
		self.owner:StopMovingOrSizing()
		self.owner:Stick()
		self:OnEnter()
	end
end

function Drag:OnMouseWheel(arg1)
	local newAlpha = min(max(self.owner:GetFrameAlpha() + (arg1 * 0.1), 0), 1)
	if newAlpha ~= self.owner:GetAlpha() then
		self.owner:SetFrameAlpha(newAlpha)
		self:UpdateTooltip()
	end
end

function Drag:OnClick(button)
	if button == 'RightButton' then
		if IsShiftKeyDown() then
			self.owner:ToggleFrame()
		else
			self.owner:ShowMenu()
		end
	elseif button == 'MiddleButton' then
		self.owner:ToggleFrame()
	end
	self:OnEnter()
end

--updates the drag button color of a given bar if its attached to another bar
function Drag:UpdateColor()
	if self.owner:IsShown() then
		if self.owner:GetAnchor() then
			self:GetNormalTexture():SetColorTexture(0, 0.2, 0.2, 0.4)
		else
			self:GetNormalTexture():SetColorTexture(0, 0.5, 0.7, 0.4)
		end
	else
		if self.owner:GetAnchor() then
			self:GetNormalTexture():SetColorTexture(0.1, 0.1, 0.1, 0.4)
		else
			self:GetNormalTexture():SetColorTexture(0.5, 0.5, 0.5, 0.4)
		end
	end
end