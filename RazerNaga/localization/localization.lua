--[[
	Localization.lua
		Translations for RazerNaga

	English: Default language
--]]

local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'enUS', true)

--system messages
--L.NewPlayer = 'Created new profile for %s'
L.Updated = 'Updated to v%s'

--profiles
L.ProfileCreated = 'Created new profile "%s"'
L.ProfileLoaded = 'Set profile to "%s"'
L.ProfileDeleted = 'Deleted profile "%s"'
L.ProfileCopied = 'Copied settings from "%s"'
L.ProfileReset = 'Reset profile "%s"'
L.CantDeleteCurrentProfile = 'Cannot delete the current profile'
L.InvalidProfile = 'Invalid profile "%s"'

--slash command help
--L.ShowOptionsDesc = 'Shows the options menu'
L.ConfigDesc = 'Toggles configuration mode'

L.SetScaleDesc = 'Sets the scale of <frameList>'
L.SetAlphaDesc = 'Sets the opacity of <frameList>'
L.SetFadeDesc = 'Sets the faded opacity of <frameList>'

L.SetColsDesc = 'Sets the number of columns for <frameList>'
L.SetPadDesc = 'Sets the padding level for <frameList>'
L.SetSpacingDesc = 'Sets the spacing level for <frameList>'

L.ShowFramesDesc = 'Shows the given <frameList>'
L.HideFramesDesc = 'Hides the given <frameList>'
L.ToggleFramesDesc = 'Toggles the given <frameList>'

--slash commands for profiles
L.SetDesc = 'Switches settings to <profile>'
L.SaveDesc = 'Saves current settings and switches to <profile>'
L.CopyDesc = 'Copies settings from <profile>'
L.DeleteDesc = 'Deletes <profile>'
L.ResetDesc = 'Returns to default settings'
L.ListDesc = 'Lists all profiles'
L.AvailableProfiles = 'Available Profiles'
L.PrintVersionDesc = 'Prints the current version'

--dragFrame tooltips
L.ShowConfig = '<Right Click> to configure'
L.HideBar = '<Middle Click or Shift-Right Click> to hide'
L.ShowBar = '<Middle Click or Shift-Right Click> to show'
L.SetAlpha = '<Mousewheel> to set opacity (|cffffffff%d|r)'

--minimap button stuff
L.ConfigEnterTip = '<Left Click> to enter configuration mode'
L.ConfigExitTip = '<Left Click> to exit configuration mode'
L.BindingEnterTip = '<Shift Left Click> to enter manual binding mode'
L.BindingExitTip = '<Shift Left Click> to exit manual binding mode'
L.ShowOptionsTip = '<Right Click> to show the options menu'

--helper dialog stuff
L.ConfigMode = 'Configuration Mode'
L.ConfigModeHelp = '<Drag> any bar to move it.'

--lynn localization items
L.EnableAutomaticBindings = 'Always use Razer Naga buttons'
L.BindingSet = '123/Num Switch'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Configuring key bindings for %s layout - %s keys'
--L.AcceptBindingChangesPrompt = 'Accept Binding Changes?'
L.CannotAlterBindingsInCombat = 'Cannot alter bindings in combat'
L.EnableAutoBindingsPrompt = [[
Razer Naga can ensure that the buttons on the key pad are configured for the action and pet bars, but enabling this feature may affect your current key bindings.

Would you like to enable this feature at this time? If you do not want to right now, you can always enable the option from the configuration menu at a later time.]]
L.BindKeysManuallyPrompt = 'Stop using only Razer Naga buttons and manually configure key bindings?'

--lynn tooltips
L.SwitchTo4x3 = 'Rearrange your action and pet bars to a 4x3 layout.'
L.SwitchTo3x4 = 'Rearrange your action and pet bars to a 3x4 layout.'
L.AutomaticBindingsToggle = 'Check this box to ensure that Razer Naga buttons are always bound to the action and pet bars.'
L.ConfigModeExit = 'Click this to exit configuration mode.'
L.ConfigModeShowOptions = 'Click this to exit configuration mode and display the options menu.'
L.ConfigModeSwitchToBindingMode = 'Click this to stop using only Razer Naga buttons and manually configure key bindings.'
L.BindingSetHelp = 'This setting should be set to match the switch on your mouse.\n\nIt determines which keys are bound when "Always use Razer Naga buttons" is checked.\n\n"123" means that the 1,2,3,4,5,6,7,8,9,-,= keys are bound.\n\n"Num" means that Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ keys are bound.\n\nModifier keys will be mapped as determined by your settings.' 
L.SimpleBindingHelp = '1, 2, 3, 4, 5, 6, 7, 8, 9, -, = keys'
L.AvancedBindingSetHelp = 'Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ keys'

--bar tooltips
L.PetBarHelp = 'Displays pet actions, when in control of a pet.'

L.ClassBarHelp_DRUID = 'Displays all learned Druid shapeshift forms.'
L.ClassBarHelp_ROGUE = 'Displays Rogue Stealth, if available.'
L.ClassBarHelp_PALADIN = 'Displays available Paladin auras.'
L.ClassBarHelp_WARRIOR = 'Displays available Warrior stances.'
L.ClassBarHelp_PRIEST = 'Displays Priest Shadowform, if available.'
L.ClassBarHelp_WARLOCK = 'Displays Warlock Metamorphosis, if available.'
L.ClassBarHelp_DEATHKNIGHT = 'Displays available Deathknight presences.'
L.ClassBarHelp_HUNTER = 'Displays available Hunter aspects.'
L.ClassBarHelp_MONK = 'Displays available Monk stances.'

L.CastBarHelp = 'Displays a progress bar when casting a spell\nor performing a tradeskill.'
L.RollBarHelp = 'Displays items to roll on when in a group.'
L.VehicleBarHelp = [[
Displays the vehicle pitch up, pitch down, and 
exit buttons. What items are displayed is dependent 
on the type of vehicle you are in. All other 
vehicle actions are displayed on the possess bar.]]
L.ExtraBarHelp = 'Displays actions specific to certain raid encounters.'

--hover menu tooltips
L.ConfigureBarHelp = 'Configure this bar.'
L.ToggleVisibilityHelpHide = 'Hide this bar.'
L.ToggleVisibilityHelpShow = 'Show this bar.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga was unable to load properly because %s is loaded, which RazerNaga is incompatible with. Please disable any other action bar addons you may be running to load RazerNaga.'

L.ChangeSummary = 'Change Summary:'
L.BindTKeyPrompt = 'Hold down the key |cff00ff00%s|r and click here to register its binding.'
L.TryAgain = 'Try Again'