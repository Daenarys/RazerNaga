--[[
        xp.lua
			The dominos xp bar
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-XP')
local DEFAULT_STATUSBAR_TEXTURE = [[Interface\TargetingFrame\UI-StatusBar]]

--taken from http://lua-users.org/wiki/FormattingNumbers
--a semi clever way to format numbers with commas (ex, 1,000,000)
local round = function(x)
	return math.floor(x + 0.5)
end

local comma = function(n)
	local left, num, right = tostring(n):match('^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)','%1,'):reverse()) .. right
end

local short = TextStatusBar_CapDisplayOfNumericValue

local textEnv = {
	format = string.format,
	math = math,
	string = string,
	short = short,
	round = round,
	comma = comma,
}

--[[ Module Stuff ]]--

local DXP = RazerNaga:NewModule('xp')
local XP

function DXP:Load()
	self.frame = XP:New()
	self.frame:SetFrameStrata('BACKGROUND')
end

function DXP:Unload()
	self.frame:Free()
end


--[[ XP Object ]]--

XP = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function XP:New()
	local f = self.proto.New(self, 'xp')
	if not f.value then
		f:Load()
	end

	f:Layout()
	f:UpdateTexture()
	f:UpdateWatch()
	f:UpdateTextShown()

	return f
end

function XP:GetDefaults()
	return {
		alwaysShowText = true,
		point = 'TOP',
		width = 0.75,
		height = 14,
		y = -32,
		x = 0,
		texture = 'blizzard'
	}
end

function XP:Load()
	local bg = self:CreateTexture(nil, 'BACKGROUND')
	bg:SetAllPoints(self)
	if bg.SetHorizTile then
		bg:SetHorizTile(false)
	end
	self.bg = bg

	local rest = CreateFrame('StatusBar', nil, self)
	rest:EnableMouse(false)
	rest:SetAllPoints(self)
	self.rest = rest

	local value = CreateFrame('StatusBar', nil, rest)
	value:EnableMouse(false)
	value:SetAllPoints(self)
	self.value = value

	local blank = CreateFrame('StatusBar', nil, value)
	blank:EnableMouse(false)
	blank:SetAllPoints(self)
	self.blank = blank

	local text = blank:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
	text:SetPoint('CENTER')
	self.text = text

	local click = CreateFrame('Button', nil, blank)
	click:SetScript('OnClick', function(_, ...) self:OnClick(...) end)
	click:SetScript('OnEnter', function(_, ...) self:OnEnter(...) end)
	click:SetScript('OnLeave', function(_, ...) self:OnLeave(...) end)
	click:RegisterForClicks('anyUp')
	click:SetAllPoints(self)
end

function XP:OnClick(button)
	if button == 'RightButton' and FFF_ReputationWatchBar_OnClick then
		self:SetAlwaysShowXP(false)
		FFF_ReputationWatchBar_OnClick(self, button)
	else
		self:SetAlwaysShowXP(not self.sets.alwaysShowXP)
		self:OnEnter()
	end
	self:UpdateRepWatcherTooltip()
end

function XP:OnEnter()
	self:UpdateTextShown()

	if (FFF_ReputationWatchBar_OnEnter and self:ShouldWatchFaction()) then
		FFF_ReputationWatchBar_OnEnter(self)
	end
end

function XP:OnLeave()
	self:UpdateTextShown()

	if (FFF_ReputationWatchBar_OnLeave) then
		FFF_ReputationWatchBar_OnLeave(self)
	end
end

function XP:UpdateRepWatcherTooltip()
	if GameTooltip:IsOwned(self) and self:ShouldWatchFaction() then
		if FFF_ReputationWatchBar_OnEnter then
			FFF_ReputationWatchBar_OnEnter(self)
		end
	else
		if FFF_ReputationWatchBar_OnLeave then
			FFF_ReputationWatchBar_OnLeave(self)
		end
	end
end

function XP:UpdateWatch()
	if self:ShouldWatchFaction() then
		self:WatchReputation()
	else
		self:WatchExperience()
	end
end

function XP:ShouldWatchFaction()
	return (not self.sets.alwaysShowXP) and C_Reputation.GetWatchedFactionData()
end


--[[ Experience ]]--

function XP:WatchExperience()
	self.watchingXP = true
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', self.OnXPEvent)

	if not self.sets.alwaysShowXP then
		self:RegisterEvent('UPDATE_FACTION')
	end
	self:RegisterEvent('UPDATE_EXHAUSTION')
	self:RegisterEvent('PLAYER_XP_UPDATE')
	self:RegisterEvent('PLAYER_LEVEL_UP')
	self:RegisterEvent('PLAYER_LOGIN')

	self.rest:SetStatusBarColor(0.25, 0.25, 1)
	self.value:SetStatusBarColor(0.6, 0, 0.6)
	self.bg:SetVertexColor(0.3, 0, 0.3, 0.6)
	self:UpdateExperience()
end

function XP:OnXPEvent(event)
	if event == 'UPDATE_FACTION' and self:ShouldWatchFaction() then
		self:WatchReputation()
	else
		self:UpdateExperience()
	end
end

function XP:UpdateExperience()
	local xp, xpMax = UnitXP('player'), UnitXPMax('player')
	local tnl = xpMax - xp
	local pct = (xpMax > 0 and round((xp / xpMax) * 100)) or 0
	local rest = GetXPExhaustion()

	--update statusbar
	self.value:SetMinMaxValues(0, xpMax)
	self.value:SetValue(xp)
	self.rest:SetMinMaxValues(0, xpMax)

	if rest and rest > 0 then
		self.rest:SetValue(xp + rest)
	else
		self.rest:SetValue(0)
	end

	--update statusbar text
	textEnv.label = _G.XP
	textEnv.xp = xp
	textEnv.xpMax = xpMax
	textEnv.tnl = tnl
	textEnv.pct = pct
	textEnv.rest = rest

	local getXPText = assert(loadstring(self:GetXPFormat(), "getXPText"))
	setfenv(getXPText, textEnv)
	self.text:SetText(getXPText())
end

function XP:SetXPFormat(fmt)
	self.sets.xpFormat = fmt
	if self.watchingXP then
		self:UpdateExperience()
	end
end

function XP:GetXPFormat()
	return self.sets.xpFormat or [[
		if rest and rest > 0 then
			return format("%s: %s / %s (+%s) [%s%%]", label, comma(xp), comma(xpMax), comma(rest), pct)
		end
		return format("%s: %s / %s [%s%%]", label, comma(xp), comma(xpMax), pct)
	]]
end



--[[ Reputation ]]--

function XP:WatchReputation()
	self.watchingXP = nil
	self:UnregisterAllEvents()
	self:RegisterEvent('UPDATE_FACTION')
	self:SetScript('OnEvent', self.OnRepEvent)

	self.rest:SetValue(0)
	self.rest:SetStatusBarColor(0, 0, 0, 0)
	self:UpdateReputation()
end

function XP:OnRepEvent(event)
	if self:ShouldWatchFaction() then
		self:UpdateReputation()
	else
		self:UpdateWatch()
	end
end

function XP:UpdateReputation()
	local watchedFactionData = C_Reputation.GetWatchedFactionData()
	if not watchedFactionData or watchedFactionData.factionID == 0 then
		return
	end

	local factionID = watchedFactionData.factionID
	local isShowingNewFaction = self.factionID ~= factionID
	if isShowingNewFaction then
		self.factionID = factionID
		local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID)
		self.friendshipID = reputationInfo.friendshipFactionID
	end

	-- do something different for friendships
	local level
	local isCapped

	local minBar, maxBar, value = watchedFactionData.currentReactionThreshold, watchedFactionData.nextReactionThreshold, watchedFactionData.currentStanding
	if C_Reputation.IsFactionParagon(factionID) then
		local currentValue, threshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
		minBar, maxBar  = 0, threshold
		if currentValue and threshold then
			value = currentValue % threshold
		end
		if hasRewardPending then
			value = value + threshold
		end
	elseif C_Reputation.IsMajorFaction(factionID) then
		local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID)
		minBar, maxBar = 0, majorFactionData.renownLevelThreshold
		level = majorFactionData.renownLevel
	elseif self.friendshipID > 0 then
		local repInfo = C_GossipInfo.GetFriendshipReputation(factionID)
		local repRankInfo = C_GossipInfo.GetFriendshipReputationRanks(factionID)
		level = repRankInfo.currentLevel
		if repInfo.nextThreshold then
			minBar, maxBar, value = repInfo.reactionThreshold, repInfo.nextThreshold, repInfo.standing
		else
			-- max rank, make it look like a full bar
			minBar, maxBar, value = 0, 1, 1
			isCapped = true
		end
	else
		level = watchedFactionData.reaction
		if watchedFactionData.reaction == MAX_REPUTATION_REACTION then
			isCapped = true
		end
	end
	
	maxBar = maxBar - minBar
	value = value - minBar
	if isCapped and maxBar == 0 then
		maxBar = 1000
		value = 999
	end
	minBar = 0

	local color = FACTION_BAR_COLORS[watchedFactionData.reaction]
	if C_Reputation.IsMajorFaction(factionID) then
		self.value:SetStatusBarColor(BLUE_FONT_COLOR.r, BLUE_FONT_COLOR.g, BLUE_FONT_COLOR.b)
		self.bg:SetVertexColor(BLUE_FONT_COLOR.r - 0.3, BLUE_FONT_COLOR.g - 0.3, BLUE_FONT_COLOR.b - 0.3, 0.6)
	else 
		self.value:SetStatusBarColor(color.r, color.g, color.b)
		self.bg:SetVertexColor(color.r - 0.3, color.g - 0.3, color.b - 0.3, 0.6)
	end

	self.value:SetMinMaxValues(0, maxBar)
	self.value:SetValue(value)

	--update statusbar text
	textEnv.faction = watchedFactionData.name
	textEnv.rep = value
	textEnv.repMax = maxBar
	textEnv.tnl = maxBar - value
	textEnv.pct = round(value / maxBar * 100)

	textEnv.repLevel = _G['FACTION_STANDING_LABEL' .. watchedFactionData.reaction]

	local getRepText = assert(loadstring(self:GetRepFormat(), "getRepText"))
	setfenv(getRepText, textEnv)
	self.text:SetText(getRepText())
end

function XP:SetRepFormat(fmt)
	self.sets.repFormat = fmt
	if not self.watchingXP then
		self:UpdateReputation()
	end
end

function XP:GetRepFormat()
	return self.sets.repFormat or [[
		return format('%s: %s / %s (%s)', faction, comma(rep), comma(repMax), repLevel)
	]]
end


--[[ Layout ]]--

function XP:Layout()
	self:SetWidth(GetScreenWidth() * self.sets.width)
	self:SetHeight(self.sets.height)
end

function XP:SetTexture(texture)
	self.sets.texture = texture
	self:UpdateTexture()
end

--update statusbar texture
--if libsharedmedia is not present, then use the stock blizzard statusbar texture
--if libsharedmedia is present, then use the user's selected texture
function XP:UpdateTexture()
	local LSM = LibStub('LibSharedMedia-3.0', true)

	local texture = (LSM and LSM:Fetch('statusbar', self.sets.texture)) or DEFAULT_STATUSBAR_TEXTURE

	self.value:SetStatusBarTexture(texture)
	self.value:GetStatusBarTexture():SetHorizTile(false)

	self.rest:SetStatusBarTexture(texture)
	self.rest:GetStatusBarTexture():SetHorizTile(false)

	self.bg:SetTexture(texture)
	self.bg:SetHorizTile(false)
end


function XP:SetAlwaysShowXP(enable)
	self.sets.alwaysShowXP = enable
	self:UpdateWatch()
end


--[[ Text ]]--

if XP.IsMouseOver then
	function XP:UpdateTextShown()
		if self:IsMouseOver() or self.sets.alwaysShowText then
			self.text:Show()
		else
			self.text:Hide()
		end
	end
else
	function XP:UpdateTextShown()
		if MouseIsOver(self) or self.sets.alwaysShowText then
			self.text:Show()
		else
			self.text:Hide()
		end
	end
end

function XP:ToggleText(enable)
	self.sets.alwaysShowText = enable or false
	self:UpdateTextShown()
end


--[[
	Layout Panel
--]]

local function CreateWidthSlider(p)
	local s = p:NewSlider(L.Width, 1, 100, 1)

	s.OnShow = function(self)
		self:SetValue(self:GetParent().owner.sets.width * 100)
	end

	s.UpdateValue = function(self, value)
		local f = self:GetParent().owner
		f.sets.width = value/100
		f:Layout()
	end
end

local function CreateHeightSlider(p)
	local s = p:NewSlider(L.Height, 1, 128, 1, OnShow)

	s.OnShow = function(self)
		self:SetValue(self:GetParent().owner.sets.height)
	end

	s.UpdateValue = function(self, value)
		local f = self:GetParent().owner
		f.sets.height = value
		f:Layout()
	end
end

local function AddLayoutPanel(menu)
	local p = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	p:NewOpacitySlider()
	p:NewFadeSlider()
	p:NewScaleSlider()
	CreateHeightSlider(p)
	CreateWidthSlider(p)

	local showText = p:NewCheckButton(L.AlwaysShowText)
	showText:SetScript('OnClick', function(self) self:GetParent().owner:ToggleText(self:GetChecked()) end)
	showText:SetScript('OnShow', function(self) self:SetChecked(self:GetParent().owner.sets.alwaysShowText) end)

	local showXP = p:NewCheckButton(L.AlwaysShowXP)
	showXP:SetScript('OnClick', function(self) self:GetParent().owner:SetAlwaysShowXP(self:GetChecked()) end)
	showXP:SetScript('OnShow', function(self) self:SetChecked(self:GetParent().owner.sets.alwaysShowXP) end)
end


--[[
	Texture Picker
--]]

--yeah I know I'm bad in that I didn't capitialize some constants
local NUM_ITEMS = 9
local width, height, offset = 140, 20, 2

local function TextureButton_OnClick(self)
	DXP.frame:SetTexture(self:GetText())
	self:GetParent():UpdateList()
end

local function TextureButton_OnMouseWheel(self, direction)
	local scrollBar = _G[self:GetParent().scroll:GetName() .. 'ScrollBar']
	scrollBar:SetValue(scrollBar:GetValue() - direction * (scrollBar:GetHeight()/2))
	parent:UpdateList()
end

local function TextureButton_Create(name, parent)
	local button = CreateFrame('Button', name, parent)
	button:SetWidth(width)
	button:SetHeight(height)

	button.bg = button:CreateTexture()
	button.bg:SetAllPoints(button)

	local r, g, b = max(random(), 0.2), max(random(), 0.2), max(random(), 0.2)
	button.bg:SetVertexColor(r, g, b)
	button:EnableMouseWheel(true)
	button:SetScript('OnClick', TextureButton_OnClick)
	button:SetScript('OnMouseWheel', TextureButton_OnMouseWheel)
	button:SetNormalFontObject('GameFontNormalLeft')
	button:SetHighlightFontObject('GameFontHighlightLeft')

	return button
end

local function Panel_UpdateList(self)
	local SML = LibStub('LibSharedMedia-3.0')
	local textures = LibStub('LibSharedMedia-3.0'):List('statusbar')
	local currentTexture = DXP.frame.sets.texture

	local scroll = self.scroll
	FauxScrollFrame_Update(scroll, #textures, #self.buttons, height + offset)

	for i,button in pairs(self.buttons) do
		local index = i + scroll.offset

		if index <= #textures then
			button:SetText(textures[index])
			button.bg:SetTexture(SML:Fetch('statusbar', textures[index]))
			button:Show()
		else
			button:Hide()
		end
	end
end

local function AddTexturePanel(menu)
	--only add the texture selector panel if libsharedmedia is present
	local LSM = LibStub('LibSharedMedia-3.0', true)
	if not LSM then
		return
	end

	local p = menu:NewPanel(L.Texture)
	p.UpdateList = Panel_UpdateList
	p:SetScript('OnShow', function() p:UpdateList() end)
	p.textures = LibStub('LibSharedMedia-3.0'):List('statusbar')

	local name = p:GetName()
	local scroll = CreateFrame('ScrollFrame', name .. 'ScrollFrame', p, 'FauxScrollFrameTemplate')
	scroll:SetScript('OnVerticalScroll', function(self, arg1) FauxScrollFrame_OnVerticalScroll(self, arg1, height + offset, function() p:UpdateList() end) end)
	scroll:SetScript('OnShow', function() p.buttons[1]:SetWidth(width) end)
	scroll:SetScript('OnHide', function() p.buttons[1]:SetWidth(width + 20) end)
	scroll:SetPoint('TOPLEFT', 8, 0)
	scroll:SetPoint('BOTTOMRIGHT', -24, 2)
	p.scroll = scroll

	--add list buttons
	p.buttons = {}
	for i = 1, NUM_ITEMS do
		local b = TextureButton_Create(name .. i, p)
		if i == 1 then
			b:SetPoint('TOPLEFT', 4, 0)
		else
			b:SetPoint('TOPLEFT', name .. i-1, 'BOTTOMLEFT', 0, -offset)
			b:SetPoint('TOPRIGHT', name .. i-1, 'BOTTOMRIGHT', 0, -offset)
		end
		p.buttons[i] = b
	end

	p.height = 200
end


--[[ Menu Code ]]--

function XP:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)
	AddLayoutPanel(menu)
	AddTexturePanel(menu)

	self.menu = menu
end