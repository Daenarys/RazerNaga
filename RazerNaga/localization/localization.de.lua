
local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'deDE')
if not L then return end

--system messages
L.Updated = 'Auf v%s aktualisiert'

--profiles
L.ProfileCreated = 'Neues Profil "%s" erstellt'
L.ProfileLoaded = 'Profil auf "%s" eingestellt'
L.ProfileDeleted = 'Profil "%s" gelöscht'
L.ProfileCopied = 'Einstellungen von "%s" kopiert'
L.ProfileReset = 'Profil "%s" zurücksetzen'
L.CantDeleteCurrentProfile = 'Das aktuelle Profil kann nicht gelöscht werden'
L.InvalidProfile = 'Ungültiges Profil "%s"'

--slash command help
L.ConfigDesc = 'Wechselt Konfigurationsmodus'

L.SetScaleDesc = 'Legt den Wert <frameList> fest'
L.SetAlphaDesc = 'Legt die Transparenz <frameList> fest'
L.SetFadeDesc = 'Legt die verblasste Transparenz <frameList> fest'

L.SetColsDesc = 'Legt die Spaltenanzahl für <frameList> fest'
L.SetPadDesc = 'Legt das Füll-Niveau <frameList> fest'
L.SetSpacingDesc = 'Legt den Grad der Spationierung für <frameList> fest'

L.ShowFramesDesc = 'Blendet festgelegten <frameList> ein'
L.HideFramesDesc = 'Blendet festgelegten <frameList> aus'
L.ToggleFramesDesc = 'Wechselt den festgelegten <frameList>'

--slash commands for profiles
L.SetDesc = 'Wechselt Einstellungen nach <profile>'
L.SaveDesc = 'Speichert aktuelle Einstellungen und wechselt zu <profile>'
L.CopyDesc = 'Kopiert Einstellungen von <profile>'
L.DeleteDesc = 'Löscht <profile>'
L.ResetDesc = 'Kehrt zu den Standardeinstellungen zurück'
L.ListDesc = 'Listet alle Profile auf'
L.AvailableProfiles = 'Verfügbare Profile'
L.PrintVersionDesc = 'Druckt die aktuelle Version'

--dragFrame tooltips
L.ShowConfig = 'Konfigurieren per <Rechtsklick>'
L.HideBar = 'Ausblenden per <Mittelklick oder Shift-Rechtsklick>'
L.ShowBar = 'Einblenden per <Mittelklick oder Shift-Rechtsklick>'
L.SetAlpha = 'Transparenz (|cffffffff%d|r) per <Mausrad> einstellen'

--minimap button stuff
L.ConfigEnterTip = 'Per <Linksklick> in den Konfigurationsmodus wechseln'
L.ConfigExitTip = 'Per <Linksklick> Konfigurationsmodus verlassen'
L.BindingEnterTip = 'Per <Shift-Linksklick> in den manuellen Zuweisungsmodus wechseln'
L.BindingExitTip = 'Den manuellen Zuweisungsmodus per <Shift-Linksklick> verlassen'
L.ShowOptionsTip = 'Per <Rechtsklick> das Menü Optionen anzeigen'

--helper dialog stuff
L.ConfigMode = 'Konfigurationsmodus'
L.ConfigModeHelp = 'Zum Bewegen, beliebigen Balken per <Drag> ziehen.'

--lynn localization items
L.EnableAutomaticBindings = 'Immer Razer Naga Tasten verwenden'
L.BindingSet = '123/Num Wechsel'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Tastenzuweisungen für %s Layout – %s Tasten werden konfiguriert'
--L.AcceptBindingChangesPrompt ='Zuweisungsänderungen übernehmen?'
L.CannotAlterBindingsInCombat = 'Während des Spiels können keine Zuweisungsänderungen vorgenommen werden'
L.EnableAutoBindingsPrompt = [[
Razer Naga kann sicherstellen, dass die Tasten auf der Tastatur für die Aktions- und Begleiterleisten konfiguriert sind. Die Aktivierung dieser Funktion kann jedoch die aktuellen Tastaturzuweisungen beeinflussen.

Soll diese Funktion zu diesem Zeitpunkt aktiviert werden? Wenn diese Option im Moment nicht ausgeführt werden soll, kann sie im Konfigurationsmenü zu einem späteren Zeitpunkt aktiviert werden.]]
L.BindKeysManuallyPrompt = 'Nicht weiter ausschließlich Razer Naga Tasten verwenden und Tastenzuweisungen manuell konfigurieren?'

--lynn tooltips
L.SwitchTo4x3 = 'Das Layout der Aktions- und Begleiterleisten in ein 4x3 Layout ändern.'
L.SwitchTo3x4 = 'Das Layout der Aktions- und Begleiterleisten in ein 3x4 Layout ändern.'
L.AutomaticBindingsToggle = 'Dieses Kästchen markieren, um sicherzustellen, dass die Razer Naga Tasten immer den Aktions- und Begleiterleisten zugewiesen sind.'
L.ConfigModeExit = 'Hier klicken, um den Konfigurationsmodus zu verlassen.'
L.ConfigModeShowOptions = 'Hier klicken, um den Konfigurationsmodus zu verlassen und das Optionsmenü anzuzeigen.'
L.ConfigModeSwitchToBindingMode = 'Hier klicken, um nicht mehr ausschließlich Razer Naga Tasten zu verwenden und Tastenzuweisungen manuell konfigurieren.'
L.BindingSetHelp = 'Diese Einstellung sollte so festgelegt werden, dass sie mit dem Schalter auf der Maus übereinstimmmt.\n\nSie legt fest, welche Tasten zugewiesen sind, wenn "Immer Razer Naga Tasten verwenden" markiert ist.\n\n"123" bedeutet, dass die 1,2,3,4,5,6,7,8,9,-,= Tasten zugewiesen sind.\n\n"Num" bedeutet, dass Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ Tasten zugewiesen sind.\n\nUmschalttasten werden entsprechend der festgelegten Einstellungen zugeordnet.'
L.SimpleBindingHelp = '1, 2, 3, 4, 5, 6, 7, 8, 9, -, = Tasten'
L.AvancedBindingSetHelp = 'Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ Tasten'

--bar tooltips
L.PetBarHelp = 'Zeigt Begleiter-Aktionen an, wenn man Kontrolle über einen Begleiter hat.'

L.ClassBarHelp_DRUID = 'Zeigt alle erlernten Formen der Druiden-Gestaltwandlung an. '
L.ClassBarHelp_ROGUE = 'Zeigt die Verstohlenheit von Schurken an, falls vorhanden.'
L.ClassBarHelp_PALADIN = 'Zeigt vorhandene Paladin-Auras an.'
L.ClassBarHelp_WARRIOR = 'Zeigt vorhandene Krieger-Haltungen an.'
L.ClassBarHelp_PRIEST = 'Zeigt Priester-Schattengestalt an, falls vorhanden.'
L.ClassBarHelp_WARLOCK = 'Zeigt Zauberer-Metamorphose an, falls vorhanden.'
L.ClassBarHelp_DEATHKNIGHT = 'Zeigt die Anwesenheit von vorhandenen Todesrittern an.'
L.ClassBarHelp_HUNTER = 'Zeigt verfügbare Jäger Aspekte.'

L.CastBarHelp = 'Zeigt eine Zeitlaufleiste an, wenn ein Zauber \ngesprochen oder eine Handwerkstätigkeit ausgeübt wird.'
L.RollBarHelp = 'Zeigt die Gegenstände an, um die gewürfelt wird, wenn man in einer Gruppe ist.'
L.VehicleBarHelp = [[
Zeigt die Aufwärts- und Abwärtsbewegung der Fahrzeugwaffe und  
Beenden-Tasten an. Welche Gegenstände angezeigt werden, hängt davon ab,
in was für einem Fahrzeugtyp du dich befindest. Alle anderen
Fahrzeug-Aktionen werden in der Besitz-Leiste angezeigt.]]
L.ExtraBarHelp = 'Spezielle Aktionen für bestimmte Raid-Encounter anzeigen.'

--hover menu tooltips
L.ConfigureBarHelp = 'Diese Leiste konfigurieren.'
L.ToggleVisibilityHelpHide = 'Diese Leiste ausblenden.'
L.ToggleVisibilityHelpShow = 'Diese Leiste einblenden.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga konnte nicht richtig laden, weil %s geladen wurde, mit dem RazerNaga nicht kompatibel ist. Andere Aktionsleisten-Add-ons, die möglicherweise ausgeführt werden, deativieren, um RazerNaga zu laden.'
