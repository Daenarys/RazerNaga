--[[
	Localization.lua
		Translations for RazerNaga

	English: Default language
--]]

local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga-Config', 'enUS', true)
L.General = 'General'
L.GeneralPanelDesc = 'General configuration options for Razer Naga'
L.Scale = 'Scale'
L.Opacity = 'Opacity'
L.FadedOpacity = 'Faded Opacity'
L.Visibility = 'Visibility'
L.Spacing = 'Spacing'
L.Padding = 'Padding'
L.Layout = 'Layout'
L.Columns = 'Columns'
L.Size = 'Size'
L.Modifiers = 'Modifiers'
L.QuickPaging = 'Quick Paging'
L.Targeting = 'Targeting'
L.ShowStates = 'Show States'
L.Set = 'Set'
L.Save = 'Save'
L.Copy = 'Copy'
L.Delete = 'Delete'
L.Bar = 'Bar %d'
L.RightClickUnit = 'Right Click Target'
L.RCUPlayer = 'Self'
L.RCUFocus = 'Focus'
L.RCUToT = 'Target of Target'
L.EnterName = 'Enter Name'
L.PossessBar = 'Override Bar'
L.Profiles = 'Profiles'
L.ProfilesPanelDesc = 'Allows you to manage saved Razer Naga layouts'
L.ShowMacroText = 'Show Macro Text'
L.ShowBindingText = 'Show Binding Text'
L.ShowEmptyButtons = 'Show Empty Buttons'
L.LockActionButtons = 'Lock Action Button Positions'
L.EnterBindingMode = 'Bind Keys...'
L.EnterConfigMode = 'Configure Bars...'
L.ActionBarSettings = 'ActionBar %d Settings'
L.BarSettings = '%s Bar Settings'
L.ShowTooltips = 'Show Tooltips'
L.OneBag = 'One Bag'
L.ReagentSlot = 'Show Reagent Slot'
L.StickyBars = 'Sticky Bars'
L.ShowMinimapButton = 'Show Minimap Button'
L.DisableMenuButtons = 'Disable Buttons'
L.EnableAutoBindings = 'Always use Razer Naga buttons'
L.Bindings = 'Bindings'
L.BindingSetModifier = 'Modifier key'

L.Advanced = 'Advanced'
L.LeftToRight = 'Layout Buttons From Left to Right'
L.TopToBottom = 'Layout Buttons From Top to Bottom'
L.LinkedOpacity = 'Docked bars inherit opacity'
L.ClickThrough = 'Enable Click Through'
L.DisableMenuButtons = 'Disable Buttons'
L.ShowOverrideUI = 'Use Blizzard Override Action Bar'
L.ShowInOverrideUI = 'Show With Override UI'
L.ShowInPetBattleUI = 'Show With Pet Battle UI'

--totems
L.ShowTotems = 'Show Totems'
L.ShowTotemRecall = 'Show Recall'

--modifier highlighting
L.HighlightModifiers = 'Highlight Modifier Bars'

--state names
L.State_HELP= 'Help'
L.State_HARM = 'Harm'
L.State_NOTARGET = NONE
L.State_ALTSHIFT = strjoin("-", ALT_KEY_TEXT, SHIFT_KEY_TEXT)
L.State_CTRLALT = strjoin("-", CTRL_KEY_TEXT, ALT_KEY_TEXT)
L.State_CTRLALTSHIFT = strjoin("-", CTRL_KEY_TEXT, ALT_KEY_TEXT, SHIFT_KEY_TEXT)
L.State_CTRLSHIFT = strjoin("-", CTRL_KEY_TEXT, SHIFT_KEY_TEXT)
L.State_META = 'Meta Key'

L.ShowTooltipsCombat = 'Show Tooltips in Combat'