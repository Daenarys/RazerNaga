--[[
	frame.lua
		A RazerNaga frame, a generic container object
--]]

local Frame = RazerNaga:CreateClass('Frame')

local active = {}
local unused = {}

--constructor
function Frame:New(id, tooltipText)
	local id = tonumber(id) or id

	local f = self:Restore(id) or self:Create(id)
	f:LoadSettings()
	f.buttons = {}
	f:SetTooltipText(tooltipText)
	
	if RazerNaga.OverrideController then
		RazerNaga.OverrideController:Add(f)
	end
	
	f:OnAcquire(id)

	active[id] = f
	return f
end

function Frame:Create(id)
	local f = self:Bind(CreateFrame('Frame', format('RazerNagaFrame%s', id), UIParent, 'SecureHandlerStateTemplate'))

	f:SetClampedToScreen(true)
	f:SetMovable(true)
	
	f.id = id
	f:SetAttribute('id', id)

	f:SetAttribute('_onstate-alpha', [[
		self:CallMethod('Fade')
	]])
	f:SetAttribute('_onstate-display', [[
		self:RunAttribute('UpdateShown')
	]])
	f:SetAttribute('_onstate-hidden', [[
		self:RunAttribute('UpdateShown')
	]])
	f:SetAttribute('_onstate-overrideui', [[
		self:RunAttribute('UpdateShown')
	]])
	f:SetAttribute('_onstate-petbattleui', [[
		self:RunAttribute('UpdateShown')
	]])
	f:SetAttribute('_onstate-showinoverrideui', [[
		self:RunAttribute('UpdateShown')
	]])
	f:SetAttribute("_onstate-showinpetbattleui", [[
		self:RunAttribute("UpdateShown")
	]])
	f:SetAttribute('UpdateShown', [[
		if self:GetAttribute("state-hidden") then
			self:Hide()
			return
		end

		local isOverrideUIShown = self:GetAttribute('state-overrideui') and true or false
		local isPetBattleUIShown = self:GetAttribute('state-petbattleui') and true or false

		if isPetBattleUIShown and not self:GetAttribute('state-showinpetbattleui') then
			self:Hide()
			return
		end

		if isOverrideUIShown and not self:GetAttribute('state-showinoverrideui') then
			self:Hide()
			return
		end

		local displayState = self:GetAttribute('state-display')
		if displayState == 'hide' then
			if self:GetAttribute('state-alpha') then
				self:SetAttribute('state-alpha', nil)
			end
			self:Hide()
			return
		end

		local stateAlpha = tonumber(displayState)
		if self:GetAttribute('state-alpha') ~= stateAlpha then
			self:SetAttribute('state-alpha', stateAlpha)
		end
		self:Show()
	]])

	f.drag = RazerNaga.DragFrame:New(f)
	
	f:OnCreate(id)

	return f
end

function Frame:Restore(id)
	local f = unused[id]
	if f then
		unused[id] = nil
		f:OnRestore(id)
		return f
	end
end

--destructor
function Frame:Free(deleteSettings)
	active[self.id] = nil

	UnregisterStateDriver(self, 'display', 'show')
	RazerNaga.MouseOverWatcher:Remove(self)
	
	if RazerNaga.OverrideController then
        RazerNaga.OverrideController:Remove(self)
    end

	self.docked = nil

	self:ClearAllPoints()
	self:SetUserPlaced(false)
	self.drag:Hide()
	self:Hide()
	
	self:OnRelease(self.id, deleteSettings)

	unused[self.id] = self
end

function Frame:Delete()
	self:Free()
	RazerNaga:SetFrameSets(self.id, nil)
end

--[[ New API ]]--

-- called when a frame is acquired from the pool
function Frame:OnAcquire(id)
    if self.OnEnable then
        RazerNaga:Printf('Bar %q called deprecated method OnEnable', id)
        self:OnEnable()
    end
end

-- called when a frame is first created
function Frame:OnCreate(id)
end

-- called when a frame is pulled in from the inactive pool
function Frame:OnRestore(id)
end

-- called when a frame is sent to the inactive pool
function Frame:OnRelease(id, deleteSettings)
    if self.OnFree then
        RazerNaga:Printf('Bar %q called deprecated method OnFree', id)
        self:OnFree()
    end
end

function Frame:OnLoadSettings()
end

--[[ Initialization ]]--

function Frame:LoadSettings()
	self.sets = RazerNaga:GetFrameSets(self.id) or RazerNaga:SetFrameSets(self.id, self:GetDefaults()) --get defaults must be provided by anything implementing the Frame type
	self:Reposition()

	if self.sets.hidden then
		self:HideFrame()
	else
		self:ShowFrame()
	end

	if RazerNaga:Locked() then
		self:Lock()
	else
		self:Unlock()
	end

	self:UpdateShowStates()

	self:ShowInOverrideUI(self:ShowingInOverrideUI())
	self:ShowInPetBattleUI(self:ShowingInPetBattleUI())
	
	self:OnLoadSettings()
end

--[[ Layout ]]--

--this function is used in a lot of places, but never called in Frame
function Frame:LoadButtons()
	if not self.AddButton then return end

	for i = 1, self:NumButtons() do
		self:AddButton(i)
	end

	self:UpdateClickThrough()
end

function Frame:RemoveButton(i)
	local b = self.buttons and self.buttons[i]
	if b and b.Free then
		b:Free()
		self.buttons[i] = nil
	end
end

function Frame:UpdateButtonCount(numButtons)
	for i = numButtons + 1, #self.buttons do
		self:RemoveButton(i)
	end

	for i = #self.buttons + 1, numButtons do
		self:AddButton(i)
	end
end

function Frame:SetNumButtons(numButtons)
	self.sets.numButtons = numButtons
	self:UpdateButtonCount(self:NumButtons())
	self:Layout()
end

function Frame:GetButton(i)
	return i <= self:NumButtons() and self.buttons[i]
end

function Frame:NumButtons()
	return self.sets.numButtons or 0
end

function Frame:SetColumns(columns)
	if columns ~= self:NumButtons() then
		self.sets.columns = columns
	else
		self.sets.columns = false
	end
	self:Layout()
end

function Frame:NumColumns()
	return self.sets.columns or self:NumButtons()
end

function Frame:SetSpacing(spacing)
	self.sets.spacing = spacing
	self:Layout()
end

function Frame:GetSpacing()
	return self.sets.spacing or 0
end

function Frame:SetPadding(w, h)
	self.sets.padW = w
	self.sets.padH = h or w
	self:Layout()
end

function Frame:GetPadding()
	local w = self.sets.padW or 0
	local h = self.sets.padH or w
	return w, h
end

--the wackiness here is for backward compaitbility reasons, since I did not implement true defaults
function Frame:SetLeftToRight(isLeftToRight)
	local isRightToLeft = not isLeftToRight

	self.sets.isRightToLeft = isRightToLeft and true or false
	self:Layout()
end

function Frame:GetLeftToRight()
	return not self.sets.isRightToLeft
end

function Frame:SetTopToBottom(isTopToBottom)
	local isBottomToTop = not isTopToBottom

	self.sets.isBottomToTop = isBottomToTop and true or false
	self:Layout()
end

function Frame:GetTopToBottom()
	return not self.sets.isBottomToTop
end

function Frame:Layout()
	local width, height

	if #self.buttons > 0 then
		local cols = min(self:NumColumns(), #self.buttons)
		local rows = ceil(#self.buttons / cols)
		local pW, pH = self:GetPadding()
		local spacing = self:GetSpacing()
		local isLeftToRight = self:GetLeftToRight()
		local isTopToBottom = self:GetTopToBottom()

		local b = self.buttons[1]
		local w = b:GetWidth() + spacing
		local h = b:GetHeight() + spacing

		for i,b in pairs(self.buttons) do
			local col
			local row
			if isLeftToRight then
				col = (i-1) % cols
			else
				col = (cols-1) - (i-1) % cols
			end

			if isTopToBottom then
				row = ceil(i / cols) - 1
			else
				row = rows - ceil(i / cols)
			end

			b:ClearAllPoints()
			b:SetPoint('TOPLEFT', w*col + pW, -(h*row + pH))
		end

		width = w*cols - spacing + pW*2
		height = h*ceil(#self.buttons/cols) - spacing + pH*2
	else
		width = 30
		height = 30
	end

	self:SetSize(max(width, 8), max(height, 8))
end

function Frame:TrySetSize(width, height)
    if not _G.InCombatLockdown() then
        self:SetSize(width, height)
        return true
    end

    return false
end

--[[ Scaling ]]--

function Frame:SetFrameScale(newScale, scaleAnchored)
	local newScale = newScale or 1
	local oldScale = self:GetFrameScale()
	local ratio = oldScale / newScale

	self.sets.scale = newScale
	self:Rescale()

	if not self:GetAnchor() then
		local point, x, y = self:GetSavedFramePosition()

		self:SetAndSaveFramePosition(point, x * ratio, y * ratio)
	end

	if scaleAnchored then
		for _, f in self:GetAll() do
			if f:GetAnchor() == self then
				f:SetFrameScale(newScale, true)
			end
		end
	end
end

function Frame:Rescale()
	self:SetScale(self:GetFrameScale())
	self.drag:SetScale(self:GetFrameScale())
end

function Frame:GetFrameScale()
	return self.sets.scale or 1
end


--[[ Opacity ]]--

hooksecurefunc(Frame, 'SetAlpha', function(self, alpha)
	self:OnSetAlpha(alpha)
end)

-- empty hook
function Frame:OnSetAlpha(alpha)

end

function Frame:SetFrameAlpha(alpha)
	if alpha == 1 then
		self.sets.alpha = nil
	else
		self.sets.alpha = alpha
	end

	self:UpdateAlpha()
end

function Frame:GetFrameAlpha()
	return self.sets.alpha or 1
end

--faded opacity (mouse not over the frame)
function Frame:SetFadeMultiplier(alpha)
	local alpha = alpha or 1

	if alpha == 1 then
		self.sets.fadeAlpha = nil
	else
		self.sets.fadeAlpha = alpha
	end

	self:UpdateWatched()
	self:UpdateAlpha()
end

function Frame:GetFadeMultiplier()
	return self.sets.fadeAlpha or 1
end

function Frame:UpdateAlpha()
	self:SetAlpha(self:GetExpectedAlpha())

	if RazerNaga:IsLinkedOpacityEnabled() then
		self:ForDocked('UpdateAlpha')
	end
end

--returns the opacity value we expect the frame to be at in its current state
function Frame:GetExpectedAlpha()
	--if this is a docked frame and linked opacity is enabled
	--then return the expected opacity of the parent frame
	if RazerNaga:IsLinkedOpacityEnabled() then
		local anchor = (self:GetAnchor())
		if anchor and anchor:FrameIsShown() then
			return anchor:GetExpectedAlpha()
		end
	end

	--if the frame is moused over, then return the frame's normal opacity
	if self.focused then
		return self:GetFrameAlpha()
	end

	--if there's a statealpha value for the frame, then use it
	local stateAlpha = self:GetAttribute('state-alpha')
	if stateAlpha then
		return stateAlpha / 100
	end

	return self:GetFrameAlpha() * self:GetFadeMultiplier()
end


--[[ Mouseover Checking ]]--

local function isChildFocus(...)
	local focus = GetMouseFocus()
	for i = 1, select('#', ...) do
		if focus == select(i, ...) then
			return true
		end
	end
	for i = 1, select('#', ...) do
		local f = select(i, ...)
		if f:IsShown() and isChildFocus(f:GetChildren()) then
			return true
		end
	end
	return false
end

local function isDescendant(frame, ...)
	for i = 1, select('#', ...) do
		local f = select(i, ...)
		if frame == f then
			return true
		end
	end
	for i = 1, select('#', ...) do
		local f = select(i, ...)
		if isDescendant(frame, f:GetChildren()) then
			return true
		end
	end
	return false
end

--returns all frames docked to the given frame
function Frame:IsFocus()
	if self:IsMouseOver(1, -1, -1, 1) then
		return (GetMouseFocus() == WorldFrame) or isChildFocus(self:GetChildren())
	end
	if SpellFlyout and SpellFlyout:IsMouseOver(1, -1, -1, 1) and isDescendant(SpellFlyout:GetParent(), self) then
		return true
	end
	return RazerNaga:IsLinkedOpacityEnabled() and self:IsDockedFocus()
end

function Frame:IsDockedFocus()
	local docked = self.docked
	if docked then
		for _,f in pairs(docked) do
			if f:IsFocus()  then
				return true
			end
		end
	end
	return false
end


--[[ Fading ]]--

local function fader_Create(parent)
	local fadeGroup = parent:CreateAnimationGroup()
	fadeGroup:SetLooping('NONE')
	fadeGroup:SetScript('OnFinished', function(self) parent:SetAlpha(self.targetAlpha) end)

	local fade = fadeGroup:CreateAnimation('Alpha')
	fade:SetSmoothing('NONE')
	-- fade:SetOrder(1)

	return function(targetAlpha, duration)
		if fadeGroup:IsPlaying() then
			fadeGroup:Pause()
			parent:SetAlpha(parent:GetAlpha() + (fade:GetToAlpha() - fade:GetFromAlpha()) * fade:GetProgress())
		end

		fadeGroup.targetAlpha = targetAlpha
		fade:SetFromAlpha(parent:GetAlpha())
		fade:SetToAlpha(targetAlpha)
		fade:SetDuration(duration)
		fadeGroup:Play()
	end
end

local Fade = setmetatable({}, {__index = function(t, parent)
	local fade = fader_Create(parent)
	t[parent] = fade
	return fade
end})


--fades the frame from the current opacity setting
--to the expected setting
function Frame:Fade()
	if floor(abs(self:GetExpectedAlpha()*100 - self:GetAlpha()*100)) == 0 then
		return
	end

	if not self:FrameIsShown() then
		return
	end

	Fade[self](self:GetExpectedAlpha(), 0.1)
	if RazerNaga:IsLinkedOpacityEnabled() then
		self:ForDocked('Fade')
	end
end


--[[ Visibility ]]--

function Frame:ShowFrame()
	self.sets.hidden = nil
	
	self:SetAttribute('state-hidden', nil)
	self.drag:UpdateColor()
	self:UpdateWatched()
	self:UpdateAlpha()

	if RazerNaga:IsLinkedOpacityEnabled() then
		self:ForDocked('ShowFrame')
	end
end

function Frame:HideFrame()
	self.sets.hidden = true
	
	self:SetAttribute('state-hidden', true)
	self.drag:UpdateColor()
	self:UpdateWatched()
	self:UpdateAlpha()

	if RazerNaga:IsLinkedOpacityEnabled() then
		self:ForDocked('HideFrame')
	end
end

function Frame:ToggleFrame()
	if self:FrameIsShown() then
		self:HideFrame()
	else
		self:ShowFrame()
	end
end

function Frame:FrameIsShown()
	return not self.sets.hidden
end


--[[ Perspectives Visibility ]] --

function Frame:ShowInOverrideUI(enable)
	self.sets.showInOverrideUI = enable and true or false
	self:SetAttribute('state-showinoverrideui', enable)
end

function Frame:ShowingInOverrideUI()
	return self.sets.showInOverrideUI
end

function Frame:ShowInPetBattleUI(enable)
	self.sets.showInPetBattleUI = enable and true or false
	self:SetAttribute('state-showinpetbattleui', enable)
end

function Frame:ShowingInPetBattleUI()
	return self.sets.showInPetBattleUI
end


--[[ Clickthrough ]]--

function Frame:SetClickThrough(enable)
	self.sets.clickThrough = enable and true or false
	self:UpdateClickThrough()
end

function Frame:GetClickThrough()
	return self.sets.clickThrough
end

function Frame:UpdateClickThrough()
	local buttons = self.buttons
	if not buttons then return end

	local clickThrough = self:GetClickThrough()
	for i, button in pairs(self.buttons) do
		if clickThrough then
			button:EnableMouse(false)
		else
			button:EnableMouse(true)
		end
	end
end


--[[ Show states ]]--

function Frame:SetShowStates(states)
	self.sets.showstates = states or false
	self:UpdateShowStates()
end

function Frame:GetShowStates()
	local states = self.sets.showstates

	--hack to convert [combat] into [combat]show;hide in case a user is using the old style of showstates
	if states then
		if states:sub(#states) == ']' then
			states = states .. 'show;hide'
			self.sets.showstates = states
		end
	end

	return states
end

function Frame:UpdateShowStates()
	local showstates = self:GetShowStates()

	if showstates then
		RegisterStateDriver(self, 'display', showstates)
	else
		UnregisterStateDriver(self, 'display')

		if self:GetAttribute('state-display') then
			self:SetAttribute('state-display', nil)
		end
	end
end


--[[ Lock/Unlock ]]--

function Frame:Lock()
	self.drag:Hide()
end

function Frame:Unlock()
	self.drag:Show()
end


--[[ Display Name ]]--

function Frame:OverrideDisplayName(name)
	self.displayName = name or nil
	self.drag:SetText(self:GetDisplayName())
end

function Frame:GetDisplayName()
	if self.displayName then
		return ('%s (%s)'):format(self.displayName, self.id)
	end
	return self.id
end

--[[ Sticky Bars ]]--

Frame.stickyTolerance = 1

function Frame:StickToEdge()
	local point, x, y = self:GetRelativeFramePosition()
	local rTolerance = self.stickyTolerance / self:GetFrameScale()
	local changed = false

	if abs(x) <= rTolerance then
		x = 0
		changed = true
	end

	if abs(y) <= rTolerance then
		y = 0
		changed = true
	end

	--save this junk if we've done something
	if changed then
		self:SetAndSaveFramePosition(point, x, y)
	end
end

function Frame:Stick()
	local rTolerance = self.stickyTolerance / self:GetFrameScale()

	self:ClearAnchor()

	--only do sticky code if the alt key is not currently down
	if RazerNaga:Sticky() and not IsAltKeyDown() then
		--try to stick to a bar, then try to stick to a screen edge
		for _, f in self:GetAll() do
			if f ~= self then
				local point = FlyPaper.Stick(self, f, rTolerance)
				if point then
					self:SetAnchor(f, point)
					break
				end
			end
		end

		if not self:GetAnchor() then
			self:StickToEdge()
		end
	end

	self:SaveRelativeFramePosition()
end

function Frame:Reanchor()
	local f, point = self:GetAnchor()

	if not(f and FlyPaper.StickToPoint(self, f, point)) then
		self:ClearAnchor()
		self:Reposition()
	else
		self:SetAnchor(f, point)
	end
end

function Frame:SetAnchor(anchor, point)
	self:ClearAnchor()

	if anchor.docked then
		local found = false
		for i,f in pairs(anchor.docked) do
			if f == self then
				found = i
				break
			end
		end
		if not found then
			tinsert(anchor.docked, self)
		end
	else
		anchor.docked = {self}
	end

	self.sets.anchor = anchor.id .. point
	self:UpdateWatched()
	self:UpdateAlpha()
end

function Frame:ClearAnchor()
	local anchor, point = self:GetAnchor()

	if anchor and anchor.docked then
		for i,f in pairs(anchor.docked) do
			if f == self then
				tremove(anchor.docked, i)
				break
			end
		end

		if not next(anchor.docked) then
			anchor.docked = nil
		end
	end

	self.sets.anchor = nil
	self:UpdateWatched()
	self:UpdateAlpha()
end

function Frame:GetAnchor()
	local anchorString = self.sets.anchor

	if anchorString then
		local pointStart = #anchorString - 1
		return self:Get(anchorString:sub(1, pointStart - 1)), anchorString:sub(pointStart)
	end
end


--[[ Positioning ]]--

function Frame:SetFramePosition(...)
	self:ClearAllPoints()
	self:SetPoint(...)
end

function Frame:SetAndSaveFramePosition(point, x, y)
	self:SetFramePosition(point, x, y)
	self:SaveFramePosition(point, x, y)
end



--[[ Relative Positioning ]]--

function Frame:SaveRelativeFramePosition()
	self:SaveFramePosition(self:GetRelativeFramePosition())
end

function Frame:GetRelativeFramePosition()
	local scale = self:GetScale() or 1
	local left = self:GetLeft() or 0
	local top = self:GetTop() or 0
	local right = self:GetRight() or 0
	local bottom = self:GetBottom() or 0

	local parent = self:GetParent() or _G['UIParent']
	local pwidth = parent:GetWidth() / self:GetScale()
	local pheight = parent:GetHeight() / self:GetScale()

	local x , y, point
	if left < (pwidth - right) and left < abs((left+right)/2 - pwidth/2) then
		x = left
		point = 'LEFT'
	elseif (pwidth - right) < abs((left + right)/2 - pwidth/2) then
		x = right - pwidth
		point = 'RIGHT'
	else
		x = (left+right)/2 - pwidth/2
		point = '';
	end

	if bottom < (pheight - top) and bottom < abs((bottom + top)/2 - pheight/2) then
		y = bottom
		point = 'BOTTOM' .. point
	elseif (pheight - top) < abs((bottom + top)/2 - pheight/2) then
		y = top - pheight
		point = 'TOP' .. point
	else
		y = (bottom + top)/2 - pheight/2
	end

	if point == '' then
		point = 'CENTER'
	end

	return point, x, y
end


--[[ Position Saving ]]--

local roundPoint = function(point)
	local point = point or 0

	if point > 0 then
		point = floor(point + 0.5)
	else
		point = ceil(point - 0.5)
	end

	return point
end

function Frame:Reposition()
	self:Rescale()
	self:SetFramePosition(self:GetSavedFramePosition())
end

function Frame:SaveFramePosition(point, x, y)
	local point = point or 'CENTER'
	local x = roundPoint(x)
	local y = roundPoint(y)

	local sets = self.sets
	sets.point = point
	sets.x = x
	sets.y = y

	self:SetUserPlaced(true)
end

function Frame:GetSavedFramePosition()
	local sets = self.sets
	local point = sets.point or 'CENTER'
	local x = sets.x or 0
	local y = sets.y or 0

	return point, x, y
end


--[[ Menus ]]--

function Frame:CreateMenu()
	self.menu = RazerNaga:NewMenu(self.id)
	self.menu:AddLayoutPanel()
	self.menu:AddAdvancedPanel()
end

function Frame:ShowMenu()
	if RazerNaga:IsConfigAddonEnabled() then
		if not self.menu then
			self:CreateMenu()
		end

		local menu = self.menu
		if menu then
			if menu:IsShown() and menu:GetOwner() == self then
				menu:Hide()
			else
				menu:Hide()
				menu:SetOwner(self)
				menu:ShowFirstPanel()
				menu:Show()
			end
		end
	end
end


--[[ Tooltip Text ]]--

function Frame:SetTooltipText(text)
	self.tooltipText = text
end

function Frame:GetTooltipText()
	return self.tooltipText
end


--[[ Mouseover Watching ]]--

function Frame:UpdateWatched()
	if self:FrameIsShown() and self:GetFadeMultiplier() < 1 and not(RazerNaga:IsLinkedOpacityEnabled() and self:GetAnchor()) then
		RazerNaga.MouseOverWatcher:Add(self)
	else
		RazerNaga.MouseOverWatcher:Remove(self)
	end
end

--[[ Highlighting (lynn addition) ]]--

local backdrop = {
	-- path to the background texture
	bgFile = nil,
	-- path to the border texture
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]],
	-- true to repeat the background texture to fill the frame, false to scale it
	tile = false,
	-- size (width or height) of the square repeating background tiles (in pixels)
	tileSize = 16,
	-- thickness of edge segments and square size of edge corners (in pixels)
	edgeSize = 16,
	-- distance from the edges of the frame to those of the background texture (in pixels)
	insets = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0
	}
}

local function createBorder(self)
	local f = CreateFrame('Frame', nil, self, BackdropTemplateMixin and 'BackdropTemplate')
	f:SetToplevel(true)
	f:SetPoint('TOPLEFT', -4, 4, self)
	f:SetPoint('BOTTOMRIGHT', 4, -4, self)
	f:SetBackdrop(backdrop)
	f:SetBackdropBorderColor(1, 0.8, 0, 1)
	f:Hide()

	return f
end


--[[ Metafunctions ]]--

function Frame:CallMethod(method, ...)
    local func = self[method]

    if type(func) == 'function' then
        return func(self, ...)
    else
        error(('Frame %s does not have a method named %q'):format(self.id, method), 2)
    end
end

function Frame:MaybeCallMethod(method, ...)
    local func = self[method]

    if type(func) == 'function' then
        return func(self, ...)
    end
end

function Frame:Get(id)
	return active[tonumber(id) or id]
end

function Frame:GetAll()
	return pairs(active)
end

function Frame:ForDocked(method, ...)
	if self.docked then
		for _, f in pairs(self.docked) do
			local action = f[method]
			if action then
				action(f, ...)
			end
		end
	end
end

function Frame:ForEach(method, ...)
    for _, frame in self:GetAll() do
        frame:MaybeCallMethod(method, ...)
    end
end

--takes a frameId, and performs the specified action on that frame
--this adds two special IDs, 'all' for all frames and '<number>-<number>' for a range of IDs
function Frame:ForFrame(id, method, ...)
	if id == 'all' then
		self:ForEach(method, ...)
	else
		local startID, endID = tostring(id):match('(%d+)-(%d+)')
		startID = tonumber(startID)
		endID = tonumber(endID)

		if startID and endID then
			if startID > endID then
				local t = startID
				startID = endID
				endID = t
			end

			for i = startID, endID do
				local f = self:Get(i)
				if f then
					local action = f[method]
					if action then
						action(f, ...)
					end
				end
			end
		else
			local f = self:Get(id)
			if f then
				local action = f[method]
				if action then
					action(f, ...)
				end
			end
		end
	end
end

--[[ exports ]]--

RazerNaga.Frame = Frame