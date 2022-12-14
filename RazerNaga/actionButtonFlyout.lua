--[[
	actionButtonFlyout.lua
		Reimplements flyout actions for action buttons
--]]

--[[ globals ]]--

local RazerNaga = _G[...]

-- A precalculated list of all known valid flyout ids. Not robust, but also sparse.
local VALID_FLYOUT_IDS = { 1, 8, 9, 10, 11, 12, 66, 67, 84, 92, 93, 96, 103, 106, 217, 219, 220, 222, 223, 224, 225, 226, 227, 229 }

-- layout fonstants from SpellFlyout.lua
local SPELLFLYOUT_DEFAULT_SPACING = 4
local SPELLFLYOUT_INITIAL_SPACING = 7

local SpellFlyoutButton = {}

function SpellFlyoutButton:OnEnter()
	if GetCVar("UberTooltips") == "1" then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 4, 4)

		if GameTooltip:SetSpellByID(self.spellID) then
			self.UpdateTooltip = self.OnEnter
		else
			self.UpdateTooltip = nil
		end
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(self.spellName, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)

		self.UpdateTooltip = nil
	end
end

function SpellFlyoutButton:OnLeave()
	GameTooltip:Hide()
end

function SpellFlyoutButton:OnFlyoutUpdated()
	local flyoutID = self:GetAttribute("flyoutID")
	local flyoutIndex = self:GetAttribute("flyoutIndex")
	local spellID, overrideSpellID, isKnown, spellName = GetFlyoutSlotInfo(flyoutID, flyoutIndex)

	self.icon:SetTexture(GetSpellTexture(overrideSpellID))
	self.icon:SetDesaturated(not isKnown)
	self.icon:Show()

	self.spellID = spellID
	self.spellName = spellName

	self:Update()
end

function SpellFlyoutButton:Update()
	self:UpdateCooldown()
	self:UpdateState()
	self:UpdateUsable()
	self:UpdateCount()
end

function SpellFlyoutButton:UpdateState()
	if IsCurrentSpell(self.spellID) then
		self:SetChecked(true)
	else
		self:SetChecked(false)
	end
end

function SpellFlyoutButton:UpdateUsable()
	local isUsable, notEnoughMana = IsUsableSpell(self.spellID)

	if isUsable then
		self.icon:SetVertexColor(1, 1, 1)
	elseif notEnoughMana then
		self.icon:SetVertexColor(0.5, 0.5, 1)
	else
		self.icon:SetVertexColor(0.4, 0.4, 0.4)
	end
end

function SpellFlyoutButton:UpdateCount()
	if IsConsumableSpell(self.spellID) then
		local count = GetSpellCount(self.spellID)
		if count > (self.maxDisplayCount or 9999) then
			self.Count:SetText("*")
		else
			self.Count:SetText(count)
		end
	else
		self.Count:SetText("")
	end
end

SpellFlyoutButton.UpdateCooldown = ActionButton_UpdateCooldown

SpellFlyoutButton_OnClickPre = [[
	if button == "LeftButton" then
		return nil, control:IsShown()
	end
]]

SpellFlyoutButton_OnClickPost = [[
	if message then
		self:GetParent():Hide()
	end
]]

local function createSpellFlyoutButton(parent, id)
	local name = ('%sSpellFlyoutButton%d'):format('RazerNaga', id)
	local template = 'SecureActionButtonTemplate, SecureHandlerDragTemplate, SmallActionButtonTemplate'

	local button = RazerNaga:CreateHiddenFrame('CheckButton', name, parent, template)

	_G[button:GetName().."Icon"]:SetTexCoord(4/64, 60/64, 4/64, 60/64)
	button.NormalTexture:SetTexture()
	button.HighlightTexture:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
	button.HighlightTexture:SetBlendMode("ADD")

	Mixin(button, SpellFlyoutButton)

	button:SetAttribute("type", "spell")

	button:RegisterForClicks("AnyUp", "AnyDown")
	button:RegisterForDrag("LeftButton")
	button:SetScript("OnEnter", button.OnEnter)
	button:SetScript("OnLeave", button.OnLeave)
	parent:WrapScript(button, "OnClick", SpellFlyoutButton_OnClickPre, SpellFlyoutButton_OnClickPost)

	return button
end

local SpellFlyout = RazerNaga:CreateHiddenFrame('Frame', nil, nil, 'SecureHandlerShowHideTemplate')

function SpellFlyout:OnLoad()
	self:SetFrameStrata("DIALOG")

	self.buttons = {}

	self:Execute(([[
		FLYOUT_INFO = newtable()
		FLYOUT_SLOTS = newtable()

		SPELLFLYOUT_DEFAULT_SPACING = %d
		SPELLFLYOUT_INITIAL_SPACING = %d
	]]):format(
		SPELLFLYOUT_DEFAULT_SPACING,
		SPELLFLYOUT_INITIAL_SPACING
	))

	self.Background = CreateFrame('Frame', nil, self)
	self.Background:SetAllPoints()

	self.Background.Start = self.Background:CreateTexture(nil, 'BACKGROUND')
	self.Background.Start:Hide()

	self.Background.End = self:CreateTexture(nil, "BACKGROUND")
	self.Background.End:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton")
	self.Background.End:SetSize(37,22)
	self.Background.End:SetTexCoord(0.01562500,0.59375000,0.74218750,0.91406250)

	self.Background.HorizontalMiddle = self:CreateTexture(nil, "BACKGROUND")
	self.Background.HorizontalMiddle:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton-FlyoutMidLeft")
	self.Background.HorizontalMiddle:SetHorizTile(true)
	self.Background.HorizontalMiddle:SetSize(32,37)
	self.Background.HorizontalMiddle:SetTexCoord(0,1,0,0.578125)

	self.Background.VerticalMiddle = self:CreateTexture(nil, "BACKGROUND")
	self.Background.VerticalMiddle:SetTexture("Interface\\Buttons\\ActionBarFlyoutButton-FlyoutMid")
	self.Background.VerticalMiddle:SetVertTile(true)
	self.Background.VerticalMiddle:SetSize(37,32)
	self.Background.VerticalMiddle:SetTexCoord(0,0.578125,0,1)

	self:SetScript("OnEvent", function(frame, event, ...)
		local handler = frame[event]
		if type(handler) == "function" then
			handler(frame, event, ...)
		end
	end)

	self:SetAttribute("_onshow", [[ self:CallMethod("OnShow") ]])
	self:SetAttribute("_onhide", [[ self:CallMethod("OnHide");  self:Hide(true) ]])

	self:RegisterEvent("PLAYER_LOGIN")
	self:RegisterEvent("SPELL_FLYOUT_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")

	self.OnLoad = nil
end

function SpellFlyout:PLAYER_LOGIN()
	self:UpdateKnownFlyouts()
end

function SpellFlyout:CURRENT_SPELL_CAST_CHANGED()
	self:ForShown("UpdateState")
end

function SpellFlyout:PLAYER_REGEN_ENABLED()
	if self.needsFlyoutUpdates then
		self:UpdateKnownFlyouts()
		self.needsFlyoutUpdates = nil
	end
end

function SpellFlyout:SPELL_UPDATE_COOLDOWN()
	self:ForShown("UpdateCooldown")
end

function SpellFlyout:SPELL_UPDATE_USABLE()
	self:ForShown("UpdateUsable")
end

function SpellFlyout:SPELL_FLYOUT_UPDATE(_, flyoutID)
	if flyoutID then
		self:UpdateFlyout(flyoutID)
	end

	self:ForShown("Update")
end

function SpellFlyout:OnShow()
	if not self.eventsRegistered then
		self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")
		self:RegisterEvent("SPELL_FLYOUT_UPDATE")
		self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		self:RegisterEvent("SPELL_UPDATE_USABLE")

		self.eventsRegistered = true
	end
end

function SpellFlyout:OnHide()
	if self.eventsRegistered then
		self:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")
		self:RegisterEvent("SPELL_FLYOUT_UPDATE")
		self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		self:RegisterEvent("SPELL_UPDATE_USABLE")

		self.eventsRegistered = nil
	end
end

SpellFlyout:SetAttribute("Toggle", [[
	local flyoutID = ...
	local parent = self:GetAttribute("caller")

	if self:IsShown() and parent == self:GetParent() then
		self:Hide()
		return
	end

	local flyout = FLYOUT_INFO[flyoutID]
	local numSlots = flyout and flyout.numSlots or 0
	local isKnown = flyout and flyout.isKnown or false

	self:SetParent(parent)

	if numSlots == 0 or not isKnown then
		self:Hide()
		return
	end

	local direction = parent:GetAttribute("flyoutDirection") or "UP"
	self:SetAttribute("direction", direction)

	local prevButton = nil
	local numButtons = 0

	for i = 1, numSlots do
		if flyout[i].isKnown then
			numButtons = numButtons + 1

			local button = FLYOUT_SLOTS[numButtons]

			button:ClearAllPoints()

			if direction == "UP" then
				if prevButton then
					button:SetPoint("BOTTOM", prevButton, "TOP", 0, SPELLFLYOUT_DEFAULT_SPACING)
				else
					button:SetPoint("BOTTOM", self, "BOTTOM", 0, SPELLFLYOUT_INITIAL_SPACING)
				end
			elseif direction == "DOWN" then
				if prevButton then
					button:SetPoint("TOP", prevButton, "BOTTOM", 0, -SPELLFLYOUT_DEFAULT_SPACING)
				else
					button:SetPoint("TOP", self, "TOP", 0, -SPELLFLYOUT_INITIAL_SPACING)
				end
			elseif direction == "LEFT" then
				if prevButton then
					button:SetPoint("RIGHT", prevButton, "LEFT", -SPELLFLYOUT_DEFAULT_SPACING, 0)
				else
					button:SetPoint("RIGHT", self, "RIGHT", -SPELLFLYOUT_INITIAL_SPACING, 0)
				end
			elseif direction == "RIGHT" then
				if prevButton then
					button:SetPoint("LEFT", prevButton, "RIGHT", SPELLFLYOUT_DEFAULT_SPACING, 0)
				else
					button:SetPoint("LEFT", self, "LEFT", SPELLFLYOUT_INITIAL_SPACING, 0)
				end
			end

			button:SetAttribute("spell", flyout[i].spellID)
			button:SetAttribute("flyoutID", flyoutID)
			button:SetAttribute("flyoutIndex", i)
			button:Enable()
			button:Show()
			button:CallMethod("OnFlyoutUpdated")

			prevButton = button
		end
	end

	for i = numButtons + 1, #FLYOUT_SLOTS do
		FLYOUT_SLOTS[i]:Hide()
	end

	if numButtons == 0 then
		self:Hide()
		return
	end

	local bW = FLYOUT_SLOTS[1]:GetWidth()
	local bH = FLYOUT_SLOTS[1]:GetHeight()
	local vertical = false

	self:ClearAllPoints()

	if direction == "UP" then
		self:SetPoint("BOTTOM", parent, "TOP")
		vertical = true
	elseif direction == "DOWN" then
		self:SetPoint("TOP", parent, "BOTTOM")
		vertical = true
	elseif direction == "LEFT" then
		self:SetPoint("RIGHT", parent, "LEFT")
	elseif direction == "RIGHT" then
		self:SetPoint("LEFT", parent, "RIGHT")
	end

	if vertical then
		self:SetWidth(bW + (SPELLFLYOUT_DEFAULT_SPACING * 2))
		self:SetHeight(SPELLFLYOUT_INITIAL_SPACING + (bH + SPELLFLYOUT_DEFAULT_SPACING) * numButtons)
	else
		self:SetWidth(SPELLFLYOUT_INITIAL_SPACING + (bW + SPELLFLYOUT_DEFAULT_SPACING) * numButtons)
		self:SetHeight(bH + (SPELLFLYOUT_DEFAULT_SPACING * 2))
	end

	self:CallMethod("LayoutTextures", direction, 0)
	self:Show()
]])

function SpellFlyout:LayoutTextures(direction, distance)
	self.direction = direction
	self.Background.End:ClearAllPoints()

	if (direction == "UP") then
		self.Background.End:SetPoint("TOP");
		SetClampedTextureRotation(self.Background.End, 0);
		self.Background.HorizontalMiddle:Hide();
		self.Background.VerticalMiddle:Show();
		self.Background.VerticalMiddle:ClearAllPoints();
		self.Background.VerticalMiddle:SetPoint("TOP", self.Background.End, "BOTTOM");
		self.Background.VerticalMiddle:SetPoint("BOTTOM", 0, distance);
	elseif (direction == "DOWN") then
		self.Background.End:SetPoint("BOTTOM");
		SetClampedTextureRotation(self.Background.End, 180);
		self.Background.HorizontalMiddle:Hide();
		self.Background.VerticalMiddle:Show();
		self.Background.VerticalMiddle:ClearAllPoints();
		self.Background.VerticalMiddle:SetPoint("BOTTOM", self.Background.End, "TOP");
		self.Background.VerticalMiddle:SetPoint("TOP", 0, -distance);
	elseif (direction == "LEFT") then
		self.Background.End:SetPoint("LEFT");
		SetClampedTextureRotation(self.Background.End, 270);
		self.Background.VerticalMiddle:Hide();
		self.Background.HorizontalMiddle:Show();
		self.Background.HorizontalMiddle:ClearAllPoints();
		self.Background.HorizontalMiddle:SetPoint("LEFT", self.Background.End, "RIGHT");
		self.Background.HorizontalMiddle:SetPoint("RIGHT", -distance, 0);
	elseif (direction == "RIGHT") then
		self.Background.End:SetPoint("RIGHT");
		SetClampedTextureRotation(self.Background.End, 90);
		self.Background.VerticalMiddle:Hide();
		self.Background.HorizontalMiddle:Show();
		self.Background.HorizontalMiddle:ClearAllPoints();
		self.Background.HorizontalMiddle:SetPoint("RIGHT", self.Background.End, "LEFT");
		self.Background.HorizontalMiddle:SetPoint("LEFT", distance, 0);
	end
	
	self:SetBorderColor(0.7, 0.7, 0.7);
end

SpellFlyout.SetBorderColor = SpellFlyout_SetBorderColor

-- Bartender4 and Dominos implement roughly the same lookup here
-- but we've chosen to precalculate the array because the ID list is fairly sparse (23 in total)
function SpellFlyout:UpdateKnownFlyouts()
	if InCombatLockdown() then
		self.needsFlyoutUpdates = true
		return
	end

	local slotsNeeded = 0

	for i = 1, #VALID_FLYOUT_IDS do
		local numSlots = self:UpdateFlyoutInfo(VALID_FLYOUT_IDS[i])

		if numSlots > slotsNeeded then
			slotsNeeded = numSlots
		end
	end

	self:Embiggen(slotsNeeded)
end

function SpellFlyout:UpdateFlyout(flyoutID)
	if InCombatLockdown() then
		self.needsFlyoutUpdates = true
		return
	end

	local numSlots = self:UpdateFlyoutInfo(flyoutID)

	if numSlots > #self.buttons then
		self:Embiggen(numSlots)
		return true
	end

	return false
end

function SpellFlyout:UpdateFlyoutInfo(flyoutID)
	local _, _, numSlots, isKnown = GetFlyoutInfo(flyoutID)

	self:Execute(([[
		local flyoutID = %d
		local numSlots = %d
		local isKnown = %q == "true"

		local data = FLYOUT_INFO[flyoutID] or newtable()
		data.numSlots = numSlots
		data.isKnown = isKnown

		FLYOUT_INFO[flyoutID] = data

		-- clear the known state of any newly unused slots
		for i = numSlots + 1, #data do
			data[i].isKnown = false
		end
	]]):format(
		flyoutID,
		numSlots,
		tostring(isKnown)
	))

	for slotID = 1, numSlots do
		local spellID, _, isSlotKnown = GetFlyoutSlotInfo(flyoutID, slotID)

		if isSlotKnown then
			local petIndex, petName = GetCallPetSpellInfo(spellID)
			if petIndex and not (petName and petName ~= "") then
				isSlotKnown = false
			end
		end

		self:Execute(([[
			local flyoutID = %d
			local slotID = %d
			local spellID = %d
			local isKnown = %q == "true"

			local data = FLYOUT_INFO[flyoutID][slotID] or newtable()
			data.spellID = spellID
			data.isKnown = isKnown

			FLYOUT_INFO[flyoutID][slotID] = data
		]]):format(
			flyoutID,
			slotID,
			spellID,
			tostring(isSlotKnown)
		))
	end

	return numSlots
end

-- create any additional flyout buttons that we need
function SpellFlyout:Embiggen(size)
	local buttons = self.buttons

	for i = #buttons + 1, size do
		local button = createSpellFlyoutButton(self, i)

		self:SetFrameRef("flyoutSlotToAdd", button)
		self:Execute([[ tinsert(FLYOUT_SLOTS, self:GetFrameRef("flyoutSlotToAdd")) ]])

		buttons[i] = button
	end
end

function SpellFlyout:ForShown(method, ...)
	for _, button in pairs(self.buttons) do
		if button:IsShown() then
			button[method](button, ...)
		end
	end
end

SpellFlyout:OnLoad()

--[[ exports ]]--

RazerNaga.SpellFlyout = SpellFlyout