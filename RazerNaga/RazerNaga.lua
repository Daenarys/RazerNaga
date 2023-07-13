--[[
	RazerNaga.lua
		Driver for RazerNaga Frames
--]]

local AddonName, Addon = ...

RazerNaga = LibStub('AceAddon-3.0'):NewAddon(AddonName, 'AceEvent-3.0', 'AceConsole-3.0')
local L = LibStub('AceLocale-3.0'):GetLocale(AddonName)

local CURRENT_VERSION = GetAddOnMetadata(AddonName, 'Version')
local CONFIG_ADDON_NAME = AddonName .. '_Config'


--[[ Startup ]]--

function RazerNaga:OnInitialize()
	--register database events
	self.db = LibStub('AceDB-3.0'):New('RazerNagaDB', self:GetDefaults(), UnitClass('player'))
	self.db.RegisterCallback(self, 'OnNewProfile')
	self.db.RegisterCallback(self, 'OnProfileChanged')
	self.db.RegisterCallback(self, 'OnProfileCopied')
	self.db.RegisterCallback(self, 'OnProfileReset')
	self.db.RegisterCallback(self, 'OnProfileDeleted')

	--version update
	if RazerNagaVersion then
		if RazerNagaVersion ~= CURRENT_VERSION then
			self:UpdateSettings(RazerNagaVersion:match('(%w+)%.(%w+)%.(%w+)'))
			self:UpdateVersion()
		end
	--new user
	else
		RazerNagaVersion = CURRENT_VERSION
	end

	--slash command support
	self:RegisterSlashCommands()

	--create a loader for the options menu
	local f = CreateFrame('Frame', nil, InterfaceOptionsFrame)
	f:SetScript('OnShow', function(self)
		self:SetScript('OnShow', nil)
		LoadAddOn('RazerNaga_Config')
	end)

	--keybound support
	local kb = LibStub('LibKeyBound-1.0')
	kb.RegisterCallback(self, 'LIBKEYBOUND_ENABLED')
	kb.RegisterCallback(self, 'LIBKEYBOUND_DISABLED')
end

function RazerNaga:OnEnable()
	local incompatibleAddon = self:GetFirstLoadedIncompatibleAddon()
	if incompatibleAddon then
		self:ShowIncompatibleAddonDialog(incompatibleAddon)
		return
	end

	self:HideBlizzard()
	self:CreateDataBrokerPlugin()
	self:Load()
end

function RazerNaga:CreateDataBrokerPlugin()
	local dataObject = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject(AddonName, {
		type = 'launcher',

		icon = [[Interface\Addons\RazerNaga\Icons\RazerNagaMini]],

		OnClick = function(_, button)
			if button == 'LeftButton' then
				if IsShiftKeyDown() then
					RazerNaga:ToggleBindingMode()
				else
					RazerNaga:ToggleLockedFrames()
				end
			elseif button == 'RightButton' then
				RazerNaga:ShowOptions()
			end
		end,

		OnTooltipShow = function(tooltip)
			if not tooltip or not tooltip.AddLine then return end
			tooltip:AddLine(AddonName)

			if RazerNaga:Locked() then
				tooltip:AddLine(L.ConfigEnterTip)
			else
				tooltip:AddLine(L.ConfigExitTip)
			end

			local KB = LibStub('LibKeyBound-1.0', true)
			if KB then
				if KB:IsShown() then
					tooltip:AddLine(L.BindingExitTip)
				else
					tooltip:AddLine(L.BindingEnterTip)
				end
			end

			if self:IsConfigAddonEnabled() then
				tooltip:AddLine(L.ShowOptionsTip)
			end
		end,
	})

	LibStub('LibDBIcon-1.0'):Register(AddonName, dataObject, self.db.profile.minimap)
end

--[[ Version Updating ]]--

function RazerNaga:GetDefaults()
	local defaults = {
		global = {
			tKeymap = {
				'CTRL-SHIFT',
				'CTRL',
				'SHIFT',
				'ALT',
				'ALT-SHIFT',
				'ALT-CTRL',
				'ALT-CTRL-SHIFT',
			},
			tKeyColors = {
				{r = 60, g = 143, b = 157, a = 255}, --perfect sky
				{r = 255, g = 193, b = 72, a = 255}, --pringles cheese
				{r = 146, g = 181, b = 97, a = 255}, --no less courage
				{r = 223, g = 108, b = 17, a = 255}, --something toxic
				{r = 194, g = 38, b = 182, a = 255}, --electric magenta
				{r = 177, g = 68, b = 35, a = 255},   --earth gives we take
				{r = 63, g = 48, b = 103, a = 255},   --curtains to heaven
			}
		},

		profile = {
			possessBar = 1,

			sticky = false,
			linkedOpacity = false,
			showMacroText = true,
			showBindingText = true,
			showTooltips = true,
			showTooltipsCombat = true,
			useVehicleUI = true,

			minimap = {
				hide = false,
			},

			ab = {
				count = 10,
				showgrid = true,
			},

			frames = {},

			--lynn settings
			firstLoad = true,
			autoBindKeys = false,
			highlightModifiers = false,
			bindingSet = 'Simple',

			--anansi settings
			showTPanel = 'always',

			tKeyNames = {
				'T1',
				'T2',
				'T3',
				'T4',
				'T5',
				'T6',
				'T7'
			},

			enableTKeyNotifications = true,
		}
	}

	--load three by four layout settings
	self.SettingsLoader:ReplaceSettings(defaults.profile, self.SettingsLoader:GetThreeByFour())

	return defaults
end

function RazerNaga:UpdateSettings(major, minor, bugfix)
	if self:ShouldUpgradePagingSettings(major, minor, bugfix) then
		self:UpgradePagingSettings()
	end

	if self:ShouldFixRogueSettings(major, minor, bugfix) then
		self:FixRoguePagingSettings()
	end
end

function RazerNaga:ShouldUpgradePagingSettings(major, minor, bugfix)
	return (tonumber(major) == 1 and tonumber(minor) < 6)
end

function RazerNaga:ShouldFixRogueSettings(major, minor, bugfix)
	return (tonumber(major) == 1 and tonumber(minor) < 7)
end

function RazerNaga:UpgradePagingSettings()
	--perform state translation to handle updates from older versions
	for profile,sets in pairs(self.db.sv.profiles) do
		if sets.frames then
			for frameId, frameSets in pairs(sets.frames) do
				if frameSets.pages then
					for class, oldStates in pairs(frameSets.pages) do
						local newStates = {}

						--convert class states
						if class == 'WARRIOR' then
							newStates['battle'] = oldStates['[bonusbar:1]']
							newStates['defensive'] = oldStates['[bonusbar:2]']
							newStates['berserker'] = oldStates['[bonusbar:3]']
						elseif class == 'DRUID' then
							newStates['moonkin'] = oldStates['[bonusbar:4]']
							newStates['bear'] = oldStates['[bonusbar:3]']
							newStates['tree'] = oldStates['[bonusbar:2]']
							newStates['prowl'] = oldStates['[bonusbar:1,stealth]']
							newStates['cat'] = oldStates['[bonusbar:1]']
						elseif class == 'PRIEST' then
							newStates['shadow'] = oldStates['[bonusbar:1]']
						elseif class == 'ROGUE' then
							newStates['vanish'] = oldStates['[bonusbar:1,form:3]']
							newStates['shadowdance'] = oldStates['[bonusbar:2]'] or oldStates['form:3']
							newStates['stealth'] = oldStates['[bonusbar:1]']
						elseif class == 'WARLOCK' then
							newStates['meta'] = oldStates['[form:2]']
						end

						--modifier states
						for i, state in RazerNaga.BarStates:getAll('modifier') do
							newStates[state.id] = oldStates[state.value]
						end

						--possess states
						for i, state in RazerNaga.BarStates:getAll('possess') do
							newStates[state.id] = oldStates[state.value]
						end

						--page states
						for i, state in RazerNaga.BarStates:getAll('page') do
							newStates[state.id] = oldStates[state.value]
						end

						--targeting states
						for i, state in RazerNaga.BarStates:getAll('target') do
							newStates[state.id] = oldStates[state.value]
						end

						frameSets.pages[class] = newStates
					end
				end
			end
		end
	end
end

function RazerNaga:FixRoguePagingSettings()
	--perform state translation to handle updates from older versions
	for profile,sets in pairs(self.db.sv.profiles) do
		if sets.frames then
			for frameId, frameSets in pairs(sets.frames) do
				if frameSets.pages then
					for class, states in pairs(frameSets.pages) do
						if class == 'ROGUE' then
							states['shadowdance'] = (states['shadowdance'] or states['stealth'])
						end
					end
				end
			end
		end
	end
end

function RazerNaga:UpdateVersion()
	RazerNagaVersion = CURRENT_VERSION

	self:Print(string.format(L.Updated, RazerNagaVersion))
end


--Load is called  when the addon is first enabled, and also whenever a profile is loaded
function RazerNaga:Load()
	for i, module in self:IterateModules() do
		if module.Load then
			module:Load()
		end
	end

	self.Frame:ForAll('Reanchor')
	self:UpdateMinimapButton()

	--show auto binder dialog, if fist load of this profile
	if self:IsFirstLoad() then
		self.AutoBinder:ShowEnableAutoBindingsDialog()
		self:SetFirstLoad(false)
	end
end

--unload is called when we're switching profiles
function RazerNaga:Unload()
	--unload any module stuff
	for i, module in self:IterateModules() do
		if module.Unload then
			module:Unload()
		end
	end
end


--[[ Blizzard Stuff Hiding ]]--

function RazerNaga:HideBlizzard()
	local HiddenFrame = CreateFrame("Frame", nil, UIParent)
	HiddenFrame:SetAllPoints(UIParent)
	HiddenFrame:Hide()

	local purgeKey = function(t, k)
		t[k] = nil
		local c = 42
		repeat
			if t[c] == nil then
				t[c] = nil
			end
			c = c + 1
		until issecurevariable(t, k)
	end

	local function apply(func, ...)
	    for i = 1, select('#', ...) do
	        local name = (select(i, ...))
	        local frame = _G[name]

	        if frame then
	            func(frame)
	        else
	            RazerNaga:Printf('Could not find frame %q', name)
	        end
	    end
	end

	local function banish(frame)
	    -- remove some EditMode hooks
		if frame.system then
			-- purge the show state to avoid any taint concerns
			purgeKey(frame, "isShownExternal")
		end

		-- EditMode overrides the Hide function, avoid calling it as it can taint
		if frame.HideBase then
			frame:HideBase()
		else
			frame:Hide()
		end
		frame:SetParent(HiddenFrame)
	end

	local function unregisterEvents(frame)
	    frame:UnregisterAllEvents()
	end

	local function disableActionButtons(frame)
	    local buttons = frame.actionButtons
	    if type(buttons) ~= "table" then
	        return
	    end

	    for _, button in pairs(buttons) do
	        button:SetAttribute('statehidden', true)
	        button:Hide()
	    end
	end

	apply(banish,
		"MainMenuBar",
		"MicroButtonAndBagsBar",
		"BagsBar",
		"MicroMenu",
		"MicroMenuContainer",
		"MultiBarBottomLeft",
		"MultiBarBottomRight",
		"MultiBarLeft",
		"MultiBarRight",
		"MultiBar5",
		"MultiBar6",
		"MultiBar7",
		"StanceBar",
		"PetActionBar",
		"PossessActionBar",
		"StatusTrackingBarManager",
		"MainMenuBarVehicleLeaveButton"
	)

	apply(unregisterEvents,
		"BagsBar",
		"MicroMenu",
		"PossessActionBar",
		"MainMenuBarVehicleLeaveButton"
	)

	apply(disableActionButtons,
		"MainMenuBar",
		"MultiBarBottomLeft",
		"MultiBarBottomRight",
		"MultiBarLeft",
		"MultiBarRight",
		"MultiBar5",
		"MultiBar6",
		"MultiBar7",
		"PossessActionBar"
	)

	self:UpdateUseOverrideUI()
end

function RazerNaga:SetUseOverrideUI(enable)
	self.db.profile.useOverrideUI = enable and true or false
	self:UpdateUseOverrideUI()
end

function RazerNaga:UsingOverrideUI()
	return self.db.profile.useOverrideUI
end

function RazerNaga:UpdateUseOverrideUI()
	local usingOverrideUI = self:UsingOverrideUI()

	self.OverrideController:SetAttribute('state-useoverrideui', usingOverrideUI)

	local oab = _G['OverrideActionBar']
	oab:ClearAllPoints()
	if usingOverrideUI then
		oab:SetPoint('BOTTOM')
	else
		oab:SetPoint('LEFT', oab:GetParent(), 'RIGHT', 100, 0)
	end
end


--[[ Keybound Events ]]--

function RazerNaga:LIBKEYBOUND_ENABLED()
	for _,frame in self.Frame:GetAll() do
		if frame.KEYBOUND_ENABLED then
			frame:KEYBOUND_ENABLED()
		end
	end
end

function RazerNaga:LIBKEYBOUND_DISABLED()
	for _,frame in self.Frame:GetAll() do
		if frame.KEYBOUND_DISABLED then
			frame:KEYBOUND_DISABLED()
		end
	end
end


--[[ Profile Functions ]]--

function RazerNaga:SaveProfile(name)
	local toCopy = self.db:GetCurrentProfile()
	if name and name ~= toCopy then
		self:Unload()
		self.db:SetProfile(name)
		self.db:CopyProfile(toCopy)
		self.isNewProfile = nil
		self:Load()
	end
end

function RazerNaga:SetProfile(name)
	local profile = self:MatchProfile(name)
	if profile and profile ~= self.db:GetCurrentProfile() then
		self:Unload()
		self.db:SetProfile(profile)
		self.isNewProfile = nil
		self:Load()
	else
		self:Print(format(L.InvalidProfile, name or 'null'))
	end
end

function RazerNaga:DeleteProfile(name)
	local profile = self:MatchProfile(name)
	if profile and profile ~= self.db:GetCurrentProfile() then
		self.db:DeleteProfile(profile)
	else
		self:Print(L.CantDeleteCurrentProfile)
	end
end

function RazerNaga:CopyProfile(name)
	if name and name ~= self.db:GetCurrentProfile() and self:MatchProfileExact(name) then
		self:Unload()
		self.db:CopyProfile(name)
		self.isNewProfile = nil
		self:Load()
	end
end

function RazerNaga:ResetProfile()
	self:Unload()
	self.db:ResetProfile()
	self.isNewProfile = true
	self:Load()
end

function RazerNaga:ListProfiles()
	self:Print(L.AvailableProfiles)

	local current = self.db:GetCurrentProfile()
	for _,k in ipairs(self.db:GetProfiles()) do
		if k == current then
			print(' - ' .. k, 1, 1, 0)
		else
			print(' - ' .. k)
		end
	end
end

function RazerNaga:MatchProfile(name)
	local name = name:lower()
	local nameRealm = name .. ' - ' .. GetRealmName():lower()
	local match

	for i, k in ipairs(self.db:GetProfiles()) do
		local key = k:lower()
		if key == name then
			return k
		elseif key == nameRealm then
			match = k
		end
	end
	return match
end

function RazerNaga:MatchProfileExact(name)
	local name = name:lower()

	for i, k in ipairs(self.db:GetProfiles()) do
		local key = k:lower()
		if key == name then
			return true
		end
	end
end


--[[ Profile Events ]]--

function RazerNaga:OnNewProfile(msg, db, name)
	self.isNewProfile = true
	self:Print(format(L.ProfileCreated, name))
end

function RazerNaga:OnProfileDeleted(msg, db, name)
	self:Print(format(L.ProfileDeleted, name))
end

function RazerNaga:OnProfileChanged(msg, db, name)
	self:Print(format(L.ProfileLoaded, name))
end

function RazerNaga:OnProfileCopied(msg, db, name)
	self:Print(format(L.ProfileCopied, name))
end

function RazerNaga:OnProfileReset(msg, db)
	self:Print(format(L.ProfileReset, db:GetCurrentProfile()))
end


--[[ Settings...Setting ]]--

function RazerNaga:SetFrameSets(id, sets)
	local id = tonumber(id) or id
	self.db.profile.frames[id] = sets

	return self.db.profile.frames[id]
end

function RazerNaga:GetFrameSets(id)
	return self.db.profile.frames[tonumber(id) or id]
end


--[[ Options Menu Display ]]--

function RazerNaga:ShowOptions()
	if InCombatLockdown() then
		self:Printf(_G.ERR_NOT_IN_COMBAT)
		return
	end

	if LoadAddOn('RazerNaga_Config') then
		InterfaceOptionsFrame_OpenToCategory(self.Options)
		InterfaceOptionsFrame_OpenToCategory(self.Options)
		return true
	end
	return false
end

function RazerNaga:NewMenu(id)
	if not self.Menu then
		LoadAddOn('RazerNaga_Config')
	end

	return self.Menu and self.Menu:New(id)
end


--[[ Slash Commands ]]--

function RazerNaga:RegisterSlashCommands()
	self:RegisterChatCommand('razernaga', 'OnCmd')
	self:RegisterChatCommand('rz', 'OnCmd')
end

function RazerNaga:OnCmd(args)
	local cmd = string.split(' ', args):lower() or args:lower()

	--frame functions
	if cmd == 'config' or cmd == 'lock' then
		self:ToggleLockedFrames()
	elseif cmd == 'scale' then
		self:ScaleFrames(select(2, string.split(' ', args)))
	elseif cmd == 'setalpha' then
		self:SetOpacityForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'fade' then
		self:SetFadeForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'setcols' then
		self:SetColumnsForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'pad' then
		self:SetPaddingForFrames(select(2, string.split(' ', args)))
	elseif cmd == 'space' then
		self:SetSpacingForFrame(select(2, string.split(' ', args)))
	elseif cmd == 'show' then
		self:ShowFrames(select(2, string.split(' ', args)))
	elseif cmd == 'hide' then
		self:HideFrames(select(2, string.split(' ', args)))
	elseif cmd == 'toggle' then
		self:ToggleFrames(select(2, string.split(' ', args)))
	--actionbar functions
	elseif cmd == 'numbars' then
		self:SetNumBars(tonumber(select(2, string.split(' ', args))))
	elseif cmd == 'numbuttons' then
		self:SetNumButtons(tonumber(select(2, string.split(' ', args))))
	--profile functions
	elseif cmd == 'save' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:SaveProfile(profileName)
	elseif cmd == 'set' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:SetProfile(profileName)
	elseif cmd == 'copy' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:CopyProfile(profileName)
	elseif cmd == 'delete' then
		local profileName = string.join(' ', select(2, string.split(' ', args)))
		self:DeleteProfile(profileName)
	elseif cmd == 'reset' then
		self:ResetProfile()
	elseif cmd == 'list' then
		self:ListProfiles()
	elseif cmd == 'version' then
		self:PrintVersion()
	elseif cmd == 'help' or cmd == '?' then
		self:PrintHelp()
	elseif cmd == 'statedump' then
		self.OverrideController:DumpStates()
	elseif cmd == 'configstatus' then
		local status = self:IsConfigAddonEnabled() and 'ENABLED' or 'DISABLED'
		print(('Config Mode Status: %s'):format(status))
	--options stuff
	else
		if not self:ShowOptions() then
			self:PrintHelp()
		end
	end
end

do
	local function PrintCmd(cmd, desc)
		print(format(' - |cFF33FF99%s|r: %s', cmd, desc))
	end

	function RazerNaga:PrintHelp(cmd)
		self:Print('Commands (/dom, /RazerNaga)')

		PrintCmd('config', L.ConfigDesc)
		PrintCmd('scale <frameList> <scale>', L.SetScaleDesc)
		PrintCmd('setalpha <frameList> <opacity>', L.SetAlphaDesc)
		PrintCmd('fade <frameList> <opacity>', L.SetFadeDesc)
		PrintCmd('setcols <frameList> <columns>', L.SetColsDesc)
		PrintCmd('pad <frameList> <padding>', L.SetPadDesc)
		PrintCmd('space <frameList> <spacing>', L.SetSpacingDesc)
		PrintCmd('show <frameList>', L.ShowFramesDesc)
		PrintCmd('hide <frameList>', L.HideFramesDesc)
		PrintCmd('toggle <frameList>', L.ToggleFramesDesc)
		PrintCmd('save <profile>', L.SaveDesc)
		PrintCmd('set <profile>', L.SetDesc)
		PrintCmd('copy <profile>', L.CopyDesc)
		PrintCmd('delete <profile>', L.DeleteDesc)
		PrintCmd('reset', L.ResetDesc)
		PrintCmd('list', L.ListDesc)
		PrintCmd('version', L.PrintVersionDesc)
	end
end

--version info
function RazerNaga:PrintVersion()
	self:Print(RazerNagaVersion)
end

function RazerNaga:IsConfigAddonEnabled()
	return GetAddOnEnableState(UnitName('player'), AddonName .. '_Config') >= 1
end


--[[ Configuration Functions ]]--

--moving
RazerNaga.locked = true

function RazerNaga:ShowConfigHelper()
	self.ConfigModeDialog:Show()
end

function RazerNaga:HideConfigHelper()
	self.ConfigModeDialog:Hide()
end

function RazerNaga:SetLock(enable)
	if InCombatLockdown() then
		self:Printf(_G.ERR_NOT_IN_COMBAT)
		return
	end

	self.locked = enable or false

	if self:Locked() then
		self.Frame:ForAll('Lock')
		self:HideConfigHelper()
	else
		self.Frame:ForAll('Unlock')
		LibStub('LibKeyBound-1.0'):Deactivate()
		self:ShowConfigHelper()
	end
	self.Envoy:Send('CONFIG_MODE_UPDATE', not enable)
end

function RazerNaga:Locked()
	return self.locked
end

function RazerNaga:ToggleLockedFrames()
	self:SetLock(not self:Locked())
end


--[[ Bindings Mode ]]--

--binding confirmation dialog
StaticPopupDialogs['RAZER_NAGA_CONFIRM_BIND_MANUALLY'] = {
	text = L.BindKeysManuallyPrompt,
	button1 = YES,
	button2 = NO,
	OnAccept = function(self) RazerNaga.AutoBinder:SetEnableAutomaticBindings(false); RazerNaga:ToggleBindingMode() end,
	OnCancel = function(self) end,
	hideOnEscape = 1,
	timeout = 0,
	exclusive = 1,
}


function RazerNaga:ToggleBindingMode()
	if self.AutoBinder:IsAutoBindingEnabled() then
		StaticPopup_Show('RAZER_NAGA_CONFIRM_BIND_MANUALLY')
	else
		self:SetLock(true)
		LibStub('LibKeyBound-1.0'):Toggle()
	end
end

--scale
function RazerNaga:ScaleFrames(...)
	local numArgs = select('#', ...)
	local scale = tonumber(select(numArgs, ...))

	if scale and scale > 0 and scale <= 10 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFrameScale', scale)
		end
	end
end

--opacity
function RazerNaga:SetOpacityForFrames(...)
	local numArgs = select('#', ...)
	local alpha = tonumber(select(numArgs, ...))

	if alpha and alpha >= 0 and alpha <= 1 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFrameAlpha', alpha)
		end
	end
end

--faded opacity
function RazerNaga:SetFadeForFrames(...)
	local numArgs = select('#', ...)
	local alpha = tonumber(select(numArgs, ...))

	if alpha and alpha >= 0 and alpha <= 1 then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetFadeMultiplier', alpha)
		end
	end
end

--columns
function RazerNaga:SetColumnsForFrames(...)
	local numArgs = select('#', ...)
	local cols = tonumber(select(numArgs, ...))

	if cols then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetColumns', cols)
		end
	end
end

--spacing
function RazerNaga:SetSpacingForFrame(...)
	local numArgs = select('#', ...)
	local spacing = tonumber(select(numArgs, ...))

	if spacing then
		for i = 1, numArgs - 1 do
			self.Frame:ForFrame(select(i, ...), 'SetSpacing', spacing)
		end
	end
end

--padding
function RazerNaga:SetPaddingForFrames(...)
	local numArgs = select('#', ...)
	local pW, pH = select(numArgs - 1, ...)

	if tonumber(pW) and tonumber(pH) then
		for i = 1, numArgs - 2 do
			self.Frame:ForFrame(select(i, ...), 'SetPadding', tonumber(pW), tonumber(pH))
		end
	end
end

--visibility
function RazerNaga:ShowFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'ShowFrame')
	end
end

function RazerNaga:HideFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'HideFrame')
	end
end

function RazerNaga:ToggleFrames(...)
	for i = 1, select('#', ...) do
		self.Frame:ForFrame(select(i, ...), 'ToggleFrame')
	end
end

--clickthrough
function RazerNaga:SetClickThroughForFrames(...)
	local numArgs = select('#', ...)
	local enable = select(numArgs - 1, ...)

	for i = 1, numArgs - 2 do
		self.Frame:ForFrame(select(i, ...), 'SetClickThrough', tonumber(enable) == 1)
	end
end

--empty button display
function RazerNaga:ToggleGrid()
	self:SetShowGrid(not self:ShowGrid())
end

function RazerNaga:SetShowGrid(enable)
	self.db.profile.showgrid = enable or false

	self.ActionBar:ForAll('UpdateGrid')
end

function RazerNaga:ShowGrid()
	return self.db.profile.showgrid
end

--right click selfcast
function RazerNaga:SetRightClickUnit(unit)
	self.db.profile.ab.rightClickUnit = unit
	self.ActionBar:ForAll('UpdateRightClickUnit')
end

function RazerNaga:GetRightClickUnit()
	return self.db.profile.ab.rightClickUnit
end

--binding text
function RazerNaga:SetShowBindingText(enable)
	self.db.profile.showBindingText = enable or false

	for _,f in self.Frame:GetAll() do
		if f.buttons then
			for _,b in pairs(f.buttons) do
				if b.UpdateHotkey then
					b:UpdateHotkey()
				end
			end
		end
	end
end

function RazerNaga:ShowBindingText()
	return self.db.profile.showBindingText
end

--macro text
function RazerNaga:SetShowMacroText(enable)
	self.db.profile.showMacroText = enable or false

	for _,f in self.Frame:GetAll() do
		if f.buttons then
			for _,b in pairs(f.buttons) do
				if b.UpdateMacro then
					b:UpdateMacro()
				end
			end
		end
	end
end

function RazerNaga:ShowMacroText()
	return self.db.profile.showMacroText
end

--possess bar settings
function RazerNaga:SetOverrideBar(id)
	local prevBar = self:GetOverrideBar()
	self.db.profile.possessBar = id
	local newBar = self:GetOverrideBar()

	prevBar:UpdateOverrideBar()
	newBar:UpdateOverrideBar()
end

function RazerNaga:GetOverrideBar()
	return self.Frame:Get(self.db.profile.possessBar)
end

--action bar numbers
function RazerNaga:SetNumBars(count)
	count = max(min(count, 120), 1) --sometimes, I do entertaininig things

	if count ~= self:NumBars() then
		self.ActionBar:ForAll('Delete')
		self.db.profile.ab.count = count

		for i = 1, self:NumBars() do
			self.ActionBar:New(i)
		end
	end
end

function RazerNaga:SetNumButtons(count)
	self:SetNumBars(120 / count)
end

function RazerNaga:NumBars()
	return self.db.profile.ab.count
end


--tooltips
function RazerNaga:ShowTooltips()
	return self.db.profile.showTooltips
end

function RazerNaga:SetShowTooltips(enable)
	self.db.profile.showTooltips = enable or false
	self:GetModule('Tooltips'):SetShowTooltips(enable)
end

function RazerNaga:SetShowCombatTooltips(enable)
	self.db.profile.showTooltipsCombat = enable or false
	self:GetModule('Tooltips'):SetShowTooltipsInCombat(enable)
end

function RazerNaga:ShowCombatTooltips()
	return self.db.profile.showTooltipsCombat
end


--minimap button
function RazerNaga:SetShowMinimap(enable)
	self.db.profile.minimap.hide = not enable
	self:UpdateMinimapButton()
end

function RazerNaga:ShowingMinimap()
	return not self.db.profile.minimap.hide
end

function RazerNaga:UpdateMinimapButton()
	if self:ShowingMinimap() then
		LibStub('LibDBIcon-1.0'):Show('RazerNaga')
	else
		LibStub('LibDBIcon-1.0'):Hide('RazerNaga')
	end
end

function RazerNaga:SetMinimapButtonPosition(angle)
	self.db.profile.minimapPos = angle
end

function RazerNaga:GetMinimapButtonPosition(angle)
	return self.db.profile.minimapPos
end

--sticky bars
function RazerNaga:SetSticky(enable)
	self.db.profile.sticky = enable or false
	if not enable then
		self.Frame:ForAll('Stick')
		self.Frame:ForAll('Reposition')
	end
end

function RazerNaga:Sticky()
	return self.db.profile.sticky
end

--linked opacity
function RazerNaga:SetLinkedOpacity(enable)
	self.db.profile.linkedOpacity = enable or false
	self.Frame:ForAll('UpdateWatched')
	self.Frame:ForAll('UpdateAlpha')
end

function RazerNaga:IsLinkedOpacityEnabled()
	return self.db.profile.linkedOpacity
end

--load and position the lfg eye
if not (IsAddOnLoaded("ClassicMinimap")) then
	hooksecurefunc(QueueStatusButton, "UpdatePosition", function(self)
		self:SetParent(MinimapBackdrop)
		self:SetFrameLevel(6)
		self:ClearAllPoints()
		self:SetPoint("TOPLEFT", MinimapBackdrop, "TOPLEFT", 45, -217)
		self:SetScale(0.85)
	end)
end

--first load of profile
function RazerNaga:IsFirstLoad()
	return self.db.profile.firstLoad
end

function RazerNaga:SetFirstLoad(enable)
	self.db.profile.firstLoad = enable or false
end

--[[ Masque Support ]]--

function RazerNaga:Masque(group, button, buttonData)
	local Masque = LibStub('Masque', true)
	if Masque then
		Masque:Group('RazerNaga', group):AddButton(button, buttonData)
		return true
	end
end

function RazerNaga:RemoveMasque(group, button)
	local Masque = LibStub('Masque', true)
	if Masque then
		Masque:Group('RazerNaga', group):RemoveButton(button)
		return true
	end
end


--[[ Incompatibility Check ]]--

local INCOMPATIBLE_ADDONS = {
	'Dominos',
	'Bartender4',
}

StaticPopupDialogs['RAZER_NAGA_INCOMPATIBLE_ADDON_LOADED'] = {
	text = L.IncompatibleAddonLoaded,
	button1 = OKAY,
	hideOnEscape = 1,
	timeout = 0,
	exclusive = 1,
}

--returns true if another popular actionbar addon is loaded, and false otherwise
function RazerNaga:GetFirstLoadedIncompatibleAddon()
	for i, addon in ipairs(INCOMPATIBLE_ADDONS) do
		local enabled = select(4, GetAddOnInfo(addon))
		if enabled then
			return addon
		end
	end
	return nil
end

--displays the incompatible addon dialog
function RazerNaga:ShowIncompatibleAddonDialog(addonName)
	StaticPopupDialogs['RAZER_NAGA_INCOMPATIBLE_ADDON_LOADED'].text = string.format(L.IncompatibleAddonLoaded, addonName)
	StaticPopup_Show('RAZER_NAGA_INCOMPATIBLE_ADDON_LOADED')
end


--[[ Utility Functions ]]--

--utility function: create a widget class
function RazerNaga:CreateClass(type, parentClass)
	local class = CreateFrame(type)
	class.mt = {__index = class}

	if parentClass then
		class = setmetatable(class, {__index = parentClass})
		class.super = parentClass
	end

	function class:Bind(o)
		return setmetatable(o, self.mt)
	end

	return class
end