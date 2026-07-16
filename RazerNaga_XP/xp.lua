--[[
        xp.lua
			The dominos xp bar
--]]

local FRIEND_ID_FACTION_COLOR_INDEX = 5 --color index to use for friend factions
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

-- compatibility shims
local AZERITE_API_EXISTS = _G.C_AzeriteItem ~= nil
local IsInActiveWorldPVP = _G.IsInActiveWorldPVP or function() return false end
local GetHonorExhaustion = _G.GetHonorExhaustion or function() return 0 end

--[[ Module Stuff ]]--


local XPBarModule = RazerNaga:NewModule('xp', 'AceEvent-3.0')
local XP

function XPBarModule:Load()
	if AZERITE_API_EXISTS then
		self.bars = {
			XP:New('xp', { 'honor', 'reputation', 'xp' }),
			XP:New('artifact', { 'artifact', 'azerite' })
		}

		-- azerite events
		self:RegisterEvent('AZERITE_ITEM_EXPERIENCE_CHANGED')
	else
		self.bars = {
			XP:New('xp', { 'honor', 'reputation', 'xp' }),
			XP:New('artifact', { 'artifact' })
		}
	end

	-- common events
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('UPDATE_EXHAUSTION')
	self:RegisterEvent('PLAYER_UPDATE_RESTING')

	-- xp bar events
	self:RegisterEvent('PLAYER_XP_UPDATE')

	-- reputation events
	self:RegisterEvent('UPDATE_FACTION')

	-- honor events
	self:RegisterEvent("HONOR_XP_UPDATE");
	self:RegisterEvent("HONOR_LEVEL_UPDATE");

	-- artifact events
	self:RegisterEvent('ARTIFACT_XP_UPDATE')
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

function XPBarModule:Unload()
	for i, bar in pairs(self.bars) do
		bar:Free()
	end

	self.bars = {}
end

function XPBarModule:PLAYER_ENTERING_WORLD()
	self:UpdateAllBars()
end

function XPBarModule:UPDATE_EXHAUSTION()
	self:UpdateAllBars()
end

function XPBarModule:PLAYER_UPDATE_RESTING()
	self:UpdateAllBars()
end

function XPBarModule:PLAYER_XP_UPDATE()
	self:UpdateAllBars()
end

function XPBarModule:UPDATE_FACTION()
	self:UpdateAllBars()
end

function XPBarModule:ARTIFACT_XP_UPDATE()
	self:UpdateAllBars()
end

function XPBarModule:AZERITE_ITEM_EXPERIENCE_CHANGED()
	self:UpdateAllBars()
end

function XPBarModule:UNIT_INVENTORY_CHANGED(_, unit)
	if unit ~= 'player' then return end

	self:UpdateAllBars()
end

function XPBarModule:HONOR_XP_UPDATE()
	self:UpdateAllBars()
end

function XPBarModule:HONOR_LEVEL_UPDATE()
	self:UpdateAllBars()
end

function XPBarModule:UpdateAllBars()
	for _, bar in pairs(self.bars) do
		if not bar:IsModeLocked() then
			bar:UpdateMode()
		end
	end
end


--[[ XP Object ]]--

XP = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function XP:New(id, modes)
	local f = self.super.New(self, id)
	if not f.value then
		f:Load()
	end

	f.modes = modes
	f:SetFrameStrata('BACKGROUND')
	f:Layout()
	f:UpdateTexture()
	f:UpdateTextShown()
	f:UpdateMode(true)

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

function XP:OnClick()
	if self:IsModeLocked() then
		self:SetNextMode()
	end
end

function XP:OnEnter()
	self:UpdateTextShown()
end

function XP:OnLeave()
	self:UpdateTextShown()
end

function XP:OnModeChanged()
	local mode = self:GetMode()

	if mode == 'reputation' then
		return self:WatchReputation()
	end

	if mode == 'honor' then
		return self:WatchHonor()
	end

	if mode == 'artifact' then
		return self:WatchArtifact()
	end

	if mode == 'azerite' and AZERITE_API_EXISTS then
		return self:WatchAzerite()
	end

	if mode == 'xp' then
		return self:WatchExperience()
	end
end

function XP:UpdateMode(force)
	if self:IsModeLocked() then
		self:SetMode(self:GetMode(), force)
	else
		for i, mode in ipairs(self.modes) do
			if self:IsValidMode(mode) or i == #self.modes then
				self:SetMode(mode, force)
				return
			end
		end
	end
end

function XP:SetMode(mode, force)
	if (self:GetMode() ~= mode) or force then
		self.sets.mode = mode
		self:OnModeChanged()
	end
end

function XP:GetMode()
	return self.sets.mode or self.modes[1]
end

function XP:SetNextMode()
	local index = self:GetModeIndex()
	if index < #self.modes then
		index = index + 1
	else
		index = 1
	end

	self:SetMode(self.modes[index])
end

function XP:GetModeIndex()
	for i, mode in pairs(self.modes) do
		if mode == self:GetMode() then
			return i
		end
	end

	return self.modes[1]
end

function XP:SetModeLocked(lock)
	self.sets.modeLocked = lock or false
	self:UpdateMode()
end

function XP:IsModeLocked()
	return self.sets.modeLocked
end

function XP:IsValidMode(mode)
	if mode == 'reputation' then
		return GetWatchedFactionInfo()
	end

	if mode == 'honor' then
		return IsWatchingHonorAsXP() or C_PvP.IsActiveBattlefield() or IsInActiveWorldPVP()
	end

	if mode == 'artifact' then
		return HasArtifactEquipped()
	end

	if mode == 'azerite' then
		return AZERITE_API_EXISTS and C_AzeriteItem.HasActiveAzeriteItem()
	end

	return mode == 'xp'
end

--[[ Experience ]]--

do
	function XP:WatchExperience()
		self:UnregisterAllEvents()
		self:SetScript('OnEvent', self.OnXPEvent)

		self:RegisterEvent('UPDATE_EXHAUSTION')
		self:RegisterEvent('PLAYER_XP_UPDATE')
		self:RegisterEvent('PLAYER_LEVEL_UP')
		self:RegisterEvent('PLAYER_LOGIN')

		self.rest:SetStatusBarColor(0.25, 0.25, 1)
		self.value:SetStatusBarColor(0.6, 0, 0.6)
		self.bg:SetVertexColor(0.3, 0, 0.3, 0.6)
		self:UpdateExperience()
	end

	function XP:OnXPEvent()
		self:UpdateExperience()
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
end


--[[ Reputation ]]--

do
	function XP:WatchReputation()
		self:UnregisterAllEvents()
		self:RegisterEvent('UPDATE_FACTION')
		self:SetScript('OnEvent', self.OnRepEvent)

		self.rest:SetValue(0)
		self.rest:SetStatusBarColor(0, 0, 0, 0)
		self:UpdateReputation()
	end

	function XP:OnRepEvent()
		self:UpdateReputation()
	end

	function XP:UpdateReputation()
		local name, reaction, min, max, value, factionID = GetWatchedFactionInfo()

		-- show nothing if not watching a faction
		if not name then
			local color = FACTION_BAR_COLORS[#FACTION_BAR_COLORS]
			self.value:SetStatusBarColor(color.r, color.g, color.b)
			self.bg:SetVertexColor(color.r - 0.3, color.g - 0.3, color.b - 0.3, 0.6)
			self.value:SetMinMaxValues(0, 1)
			self.value:SetValue(0)
			self.text:SetText(_G.REPUTATION)
			return
		end

		local friendID, friendRep, _, _, _, _, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)

		if friendID then
			if nextFriendThreshold then
				min, max, value = friendThreshold, nextFriendThreshold, friendRep
			else
				-- max rank, make it look like a full bar
				min, max, value = 0, 1, 1;
			end

			reaction = FRIEND_ID_FACTION_COLOR_INDEX
		end

		max = max - min
		value = value - min

		local color = FACTION_BAR_COLORS[reaction]
		self.value:SetStatusBarColor(color.r, color.g, color.b)
		self.bg:SetVertexColor(color.r - 0.3, color.g - 0.3, color.b - 0.3, 0.6)

		self.value:SetMinMaxValues(0, max)
		self.value:SetValue(value)

		--update statusbar text
		textEnv.faction = name
		textEnv.rep = value
		textEnv.repMax = max
		textEnv.tnl = max - value
		textEnv.pct = max > 0 and round(value / max * 100) or 0

		if friendID then
			textEnv.repLevel = friendTextLevel
		else
			textEnv.repLevel = _G['FACTION_STANDING_LABEL' .. reaction]
		end

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
end


--[[ Honor ]]--

do
	function XP:WatchHonor()
		self:UnregisterAllEvents()
		self:RegisterEvent('PLAYER_LOGIN')
		self:RegisterEvent('HONOR_XP_UPDATE')

		self:SetScript('OnEvent', self.OnHonorEvent)

		self.value:SetStatusBarColor(1.0, 0.24, 0, 1)
		self.rest:SetStatusBarColor(1.0, 0.71, 0, 1)
		self.bg:SetVertexColor(1 / 3, 0.24 / 3, 0, 0.6)

		self:UpdateHonor()
	end

	function XP:OnHonorEvent(event)
		self:UpdateHonor()
	end

	function XP:UpdateHonor()
		local value = UnitHonor('player')
		local max = UnitHonorMax('player')
		local rest = GetHonorExhaustion() or 0

		self.value:SetMinMaxValues(0, max)
		self.value:SetValue(value)

		self.rest:SetMinMaxValues(0, max)
		self.rest:SetValue(rest)

		--update statusbar text
		textEnv.label = _G.HONOR
		textEnv.val = value
		textEnv.valMax = max
		textEnv.tnl = max - value
		textEnv.pct = (max > 0 and round((value / max) * 100)) or 0
		textEnv.rest = rest

		local getHonorText = assert(loadstring(self:GetHonorFormat(), "getHonorText"))
		setfenv(getHonorText, textEnv)
		self.text:SetText(getHonorText())
	end

	function XP:SetHonorFormat(fmt)
		if self:GetHonorFormat() ~= fmt then
			self.sets.honorFormat = fmt

			if self:GetMode() == 'honor' then
				self:UpdateValue()
			end
		end
	end

	function XP:GetHonorFormat()
		return self.sets.honorFormat or [[
			if rest and rest > 0 then
				return format("%s: %s / %s (+%s) [%s%%]", label, comma(val), comma(valMax), comma(rest), pct)
			end
			return format("%s: %s / %s [%s%%]", label, comma(val), comma(valMax), pct)
		]]
	end
end


--[[ Artifact ]]--

do
	function XP:WatchArtifact()
		self:UnregisterAllEvents()
		self:RegisterEvent('ARTIFACT_XP_UPDATE')
		self:RegisterEvent("UNIT_INVENTORY_CHANGED")
		self:RegisterEvent("UPDATE_EXTRA_ACTIONBAR")
		self:SetScript('OnEvent', self.OnArtifactEvent)

		local r, g, b, a = 1.0, 0.24, 0, 1
		self.value:SetStatusBarColor(r, g, b, a)
		self.rest:SetStatusBarColor(0, 0, 0, 0)
		self.rest:SetValue(0)
		self.bg:SetVertexColor(r / 3, g / 3, b / 3, 0.6)

		self:UpdateArtifact()
	end

	function XP:OnArtifactEvent(event, ...)
		if event == 'UNIT_INVENTORY_CHANGED' and ... == 'player' then
			self:UpdateArtifact()
		elseif event == 'ARTIFACT_XP_UPDATE' or event == 'UPDATE_EXTRA_ACTIONBAR' then
			self:UpdateArtifact()
		end
	end

	function XP:UpdateArtifact()
        if not HasArtifactEquipped() then
            self.value:SetMinMaxValues(0, 1)
			self.value:SetValue(0)
            self.text:SetText(_G.ARTIFACT_POWER)
            return
        end

		local value, max = self:GetArtifactBarValues()
		self.value:SetMinMaxValues(0, max)
		self.value:SetValue(value)

		--update statusbar text
		textEnv.val = value
		textEnv.valMax = max
		textEnv.tnl = max - value
		textEnv.pct = (max > 0 and round((value / max) * 100)) or 0

		local getArtifactText = assert(loadstring(self:GetArtifactFormat(), "getArtifactText"))
		setfenv(getArtifactText, textEnv)
		self.text:SetText(getArtifactText())
	end

	if _G.ArtifactBarGetNumArtifactTraitsPurchasableFromXP ~= nil then
		function XP:GetArtifactBarValues()
			local artifactItemID, _, _, _, artifactTotalXP, artifactPointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
			if not artifactItemID then
				return 0, 0
			end

			local _, xp, xpForNextPoint = ArtifactBarGetNumArtifactTraitsPurchasableFromXP(artifactPointsSpent, artifactTotalXP, artifactTier)

			return xp, xpForNextPoint
		end
	else
		function XP:GetArtifactBarValues()
			local _, _, _, _, xp, pointsSpent, _, _, _, _, _, _, artifactTier = C_ArtifactUI.GetEquippedArtifactInfo()
			local pointsAvailable = 0
			local nextRankCost = C_ArtifactUI.GetCostForPointAtRank(pointsSpent + pointsAvailable, artifactTier) or 0

			while xp >= nextRankCost and nextRankCost > 0 do
				xp = xp - nextRankCost
				pointsAvailable = pointsAvailable + 1
				nextRankCost = C_ArtifactUI.GetCostForPointAtRank(pointsSpent + pointsAvailable, artifactTier) or 0
			end

			return xp, nextRankCost
		end
	end

	function XP:SetArtifactFormat(fmt)
		if self:GetArtifactFormat() ~= fmt then
			self.sets.artifactFormat = fmt

			if self:GetMode() == 'artifact' then
				self:UpdateArtifact()
			end
		end
	end

	function XP:GetArtifactFormat()
		return self.sets.artifactFormat
			or [[ return format("%s / %s [%s%%]", comma(val), comma(valMax), pct) ]]
	end
end

--[[ Azerite ]]--

if C_AzeriteItem ~= nil then
	function XP:WatchAzerite()
		self:UnregisterAllEvents()
		self:RegisterEvent("AZERITE_ITEM_EXPERIENCE_CHANGED")
		self:SetScript('OnEvent', self.OnAzeriteEvent)

		local r, g, b, a = ARTIFACT_BAR_COLOR:GetRGBA()
		self.value:SetStatusBarColor(r, g, b, a)
		self.rest:SetStatusBarColor(0, 0, 0, 0)
		self.rest:SetValue(0)
		self.bg:SetVertexColor(r / 3, g / 3, b / 3, 0.6)

		self:UpdateAzerite()
	end

	function XP:OnAzeriteEvent(event, ...)
		self:UpdateAzerite()
	end

	function XP:UpdateAzerite()
        if not C_AzeriteItem.HasActiveAzeriteItem() then
            self.value:SetMinMaxValues(0, 1)
			self.value:SetValue(0)
            self.text:SetFormattedText(AZERITE_POWER_BAR, 0)
            return
		end

		local value, max = self:GetAzeriteBarValues()
		self.value:SetMinMaxValues(0, max)
		self.value:SetValue(value)

		--update statusbar text
		textEnv.val = value
		textEnv.valMax = max
		textEnv.tnl = max - value
		textEnv.pct = (max > 0 and round((value / max) * 100)) or 0

		local getAzeriteText = assert(loadstring(self:GetAzeriteFormat(), "getAzeriteText"))
		setfenv(getAzeriteText, textEnv)
		self.text:SetText(getAzeriteText())
	end

	function XP:GetAzeriteBarValues()
		local azeriteItemLocation = C_AzeriteItem.FindActiveAzeriteItem()
		if not azeriteItemLocation then
			return 0, 1
		end

		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		if AzeriteUtil.IsAzeriteItemLocationBankBag(azeriteItemLocation) then
			return 0, 1
		end

		local value, max = C_AzeriteItem.GetAzeriteItemXPInfo(azeriteItemLocation)

		return value, max
	end

	function XP:SetAzeriteFormat(fmt)
		if self:GetAzeriteFormat() ~= fmt then
			self.sets.azeriteFormat = fmt

			if self:GetMode() == 'azerite' then
				self:UpdateAzerite()
			end
		end
	end

	function XP:GetAzeriteFormat()
		return self.sets.azeriteFormat
			or [[ return format("%s / %s [%s%%]", comma(val), comma(valMax), pct) ]]
	end
end

--[[ Layout ]]--

function XP:Layout()
	self:SetWidth(GetScreenWidth() * (self.sets.width or 1))
	self:SetHeight(self.sets.height or 14)
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


--[[ Text ]]--

function XP:UpdateTextShown()
	if self:IsMouseOver() or self.sets.alwaysShowText then
		self.text:Show()
	else
		self.text:Hide()
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

local function AddLayoutPanel(menu, hasMultipleModes)
	local p = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	p:NewOpacitySlider()
	p:NewFadeSlider()
	p:NewScaleSlider()
	CreateHeightSlider(p)
	CreateWidthSlider(p)

	local showText = p:NewCheckButton(L.AlwaysShowText)
	showText:SetScript('OnClick', function(self) self:GetParent().owner:ToggleText(self:GetChecked()) end)
	showText:SetScript('OnShow', function(self) self:SetChecked(self:GetParent().owner.sets.alwaysShowText) end)

	if hasMultipleModes then
		local lockMode = p:NewCheckButton(_G.LOCK .. ' ' .. _G.DISPLAY .. ' ' .. _G.MODE)
		lockMode:SetScript('OnClick', function(self) self:GetParent().owner:SetModeLocked(self:GetChecked()) end)
		lockMode:SetScript('OnShow', function(self) self:GetParent().owner:IsModeLocked() end)
	end
end


--[[
	Texture Picker
--]]

--yeah I know I'm bad in that I didn't capitialize some constants
local NUM_ITEMS = 9
local width, height, offset = 140, 20, 2

local function TextureButton_OnClick(self)
	self:GetParent().owner:SetTexture(self:GetText())
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
	local currentTexture = self.owner.sets.texture

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
	AddLayoutPanel(menu, #self.modes > 1)
	AddTexturePanel(menu)

	self.menu = menu
end
