
-- à = \195\160
-- â = \195\162
-- ç = \195\167
-- è = \195\168
-- é = \195\169
-- ê = \195\170
-- î = \195\174
-- ï = \195\175
-- ô = \195\180
-- û = \195\187

local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'frFR')
if not L then return end

--system messages
L.Updated = 'Mis \195\160 jours vers la version %s'

--profiles
L.ProfileCreated = 'Cr\195\169\195\169 un nouveau profil « %s »'
L.ProfileLoaded = 'R\195\169gl\195\169 le profil sur « %s »'
L.ProfileDeleted = 'Supprim\195\169 le profil « %s »'
L.ProfileCopied = 'Copi\195\169 les param\195\168tres de « %s »'
L.ProfileReset = 'R\195\169initialis\195\169 le profil « %s »'
L.CantDeleteCurrentProfile = 'Impossible de supprimer le profil actuel'
L.InvalidProfile = 'Profil « %s » non valide'
--slash command help
L.ConfigDesc = 'Bascule en mode configuration'

L.SetScaleDesc = 'D\195\169finit l\’\195\169chelle de <frameList>'
L.SetAlphaDesc = 'D\195\169finit l\’opacit\195\169 de <frameList>'
L.SetFadeDesc = 'D\195\169finit l\’opacit\195\169 de fondu de <frameList>'

L.SetColsDesc = 'D\195\169finit le nombre de colonnes pour <frameList>'
L.SetPadDesc = 'D\195\169finit le niveau de remplissage pour <frameList>'
L.SetSpacingDesc = 'D\195\169finit le niveau d’espacement pour <frameList>'

L.ShowFramesDesc = 'Afficher la <frameList> donn\195\169e'
L.HideFramesDesc = 'Masque la <frameList> donn\195\169e'
L.ToggleFramesDesc = 'Bascule sur la <frameList> donn\195\169e'
--slash commands for profiles
L.SetDesc = 'Permute les param\195\168tres sur <profile>'
L.SaveDesc = 'Enregistre les param\195\168tres actuels et les permute sur <profile>'
L.CopyDesc = 'Copie les param\195\168tres \195\160 partir de <profile>'
L.DeleteDesc = 'Supprime <profile>'
L.ResetDesc = 'Retourne aux param\195\168tres par d\195\169faut'
L.ListDesc = 'Liste tous les profils'
L.AvailableProfiles = 'Profils disponibles'
L.PrintVersionDesc = 'Imprime la version actuelle'
--dragFrame tooltips
L.ShowConfig = '<Clic droit> pour effectuer la configuration'
L.HideBar = '<Clic avec le bouton central ou clic droit> pour masquer'
L.ShowBar = '<Clic avec le bouton central ou clic droit> pour afficher'
L.SetAlpha = '<Molette de la souris> pour d\195\169finir l’opacit\195\169 (|cffffffff%d|r)'
--minimap button stuff
L.ConfigEnterTip = '<Clic gauche> pour entrer en mode configuration'
L.ConfigExitTip = '<Clic gauche> pour sortir du mode configuration'
L.BindingEnterTip = '<Majuscule Clic gauche> pour entrer en mode liaison'
L.BindingExitTip = '<Majuscule Clic gauche> pour sortir du mode liaison'
L.ShowOptionsTip = '<Clic droit> pour afficher le menu des options'
--helper dialog stuff
L.ConfigMode = 'Mode configuration'
L.ConfigModeHelp = '<Faites glisser> les barres pour les d\195\169placer.'
--lynn localization items
L.EnableAutomaticBindings = 'Toujours utiliser les boutons Razer Naga'
L.BindingSet = 'Permutation 123/Num'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Configuration des liaisons touches pour la disposition %s – touches %s'
--L.AcceptBindingChangesPrompt ='Accepter les modifications de liaison ?'
L.CannotAlterBindingsInCombat = 'Impossible de modifier les liaisons en combat '
L.EnableAutoBindingsPrompt = [[
Razer Naga peut garantir que les boutons du pav\195\169 num\195\169rique sont configur\195\169s pour l\’action et les barres de compagnons, mais l\’activation de cette fonction peut affecter vos liaisons de touches.

Voulez-vous activer cette fonction \195\160 ce stade ? Si vous ne voulez pas le faire maintenant, vous pouvez toujours activer cette option ult\195\169rieurement \195\160 partir du menu de configuration.]]
L.BindKeysManuallyPrompt = 'Arr\195\170ter d\’utiliser uniquement les boutons Razer Naga et configurer manuellement les liaisons de touches ?'

--lynn tooltips
L.SwitchTo4x3 = 'R\195\169organiser votre action et les barres de compagnons dans une disposition 4x3.'
L.SwitchTo3x4 = 'R\195\169organiser votre action et les barres de compagnons dans une disposition 3x4.'
L.AutomaticBindingsToggle = 'Cochez cette case pour garantir que les boutons Razer Naga sont toujours li\195\169s \195\160 l\’action et aux barres de compagnons.'
L.ConfigModeExit = 'Cliquez sur cet \195\169l\195\169ment pour sortir du mode configuration.'
L.ConfigModeShowOptions = 'Cliquez sur cet \195\169l\195\169ment pour sortir du mode configuration et afficher le menu des options.'
L.ConfigModeSwitchToBindingMode = 'Cliquez sur cet \195\169l\195\169ment pour arr\195\170ter d\’utiliser uniquement les boutons Razer Naga et configurer manuellement les liaisons de touches.'
L.BindingSetHelp = 'Ce param\195\168tre doit \195\170tre r\195\169gl\195\169 pour correspondre au commutateur de votre souris.\n\nIl d\195\169termine les touches li\195\169es lorsque l\’option « Toujours utiliser les boutons Razer Naga » est coch\195\169e.\n\n« 123 » signifie que les les touches 1,2,3,4,5,6,7,8,9,-,= sont li\195\169es.\n\n« Num » signifique que les touches Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ sont li\195\169es.\n\nLes touches de modification seront mises en correspondance tel que cela est d\195\169termin\195\169 par vos param\195\168tres.'
L.SimpleBindingHelp = 'Touches 1, 2, 3, 4, 5, 6, 7, 8, 9, -, ='
L.AvancedBindingSetHelp = 'Touches Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+'

--bar tooltips
L.PetBarHelp = 'Affiche les actions d\’un compagnon, lors de la commande d\’un compagnon.'

L.ClassBarHelp_DRUID = 'Affiche toutes les formes de d\195\169guisement Druide apprises.'
L.ClassBarHelp_ROGUE = 'Affiche la furtivit\195\169 Rogue, si disponible.'
L.ClassBarHelp_PALADIN = 'Affiche les auras Paladin.'
L.ClassBarHelp_WARRIOR = 'Affiche les positions Warrior disponibles.'
L.ClassBarHelp_PRIEST = 'Affiche la forme d’ombre Priest, si disponible.'
L.ClassBarHelp_WARLOCK = 'Affiche la m\195\169tamorphose Warlock, si disponible.'
L.ClassBarHelp_DEATHKNIGHT = 'Affiche les pr\195\169sences Deathknight disponibles.'
L.ClassBarHelp_HUNTER = 'Affiche les aspects de chasseur.'

L.CastBarHelp = 'Affiche une barre de progression lorsque vous jetez un sort\nou que vous effectuez un tradeskill.'
L.RollBarHelp = 'Affiche les \195\169l\195\169ments \195\160 appliquer dans un groupe.'
L.VehicleBarHelp = 'Affiche les boutons cabr\195\169, piqu\195\169 et quitter du v\195\169hicule. Les \195\169l\195\169ments affich\195\169s d\195\169pendent du type de v\195\169hicule dans lequel vous \195\170tes. Toutes les autres actions du v\195\169hicule s\’affichent dans la barre des possessions.'
L.ExtraBarHelp = 'Affichez les actions spŽcifiques pour certaines rencontres de raid.'

--hover menu tooltips
L.ConfigureBarHelp = 'Configurer cette barre.'
L.ToggleVisibilityHelpHide = 'Masquer cette barre.'
L.ToggleVisibilityHelpShow = 'Afficher cette barre.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga n\’a pas pu effectuer correctement le chargement car %s, qui est incompatible avec RazerNaga, est charg\195\169. Pour charger RazerNaga, d\195\169sactivez toute autre extension de barre d’action qui pourrait s\’ex\195\169cuter.'
