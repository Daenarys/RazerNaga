-- Translator ZamestoTV

local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'ruRU')
if not L then return end

--system messages
L.Updated = 'Обновлено до версии %s'

--profiles
L.ProfileCreated = 'Создан новый профиль "%s"'
L.ProfileLoaded = 'Установлен профиль "%s"'
L.ProfileDeleted = 'Удалён профиль "%s"'
L.ProfileCopied = 'Скопированы настройки из "%s"'
L.ProfileReset = 'Сброс профиля "%s"'
L.CantDeleteCurrentProfile = 'Нельзя удалить текущий профиль'
L.InvalidProfile = 'Недействительный профиль "%s"'

--slash command help
L.ConfigDesc = 'Переключает режим настройки'

L.SetScaleDesc = 'Устанавливает масштаб для <frameList>'
L.SetAlphaDesc = 'Устанавливает прозрачность для <frameList>'
L.SetFadeDesc = 'Устанавливает прозрачность в неактивном состоянии для <frameList>'

L.SetColsDesc = 'Устанавливает количество столбцов для <frameList>'
L.SetPadDesc = 'Устанавливает уровень отступа для <frameList>'
L.SetSpacingDesc = 'Устанавливает уровень интервала для <frameList>'

L.ShowFramesDesc = 'Показывает указанный <frameList>'
L.HideFramesDesc = 'Скрывает указанный <frameList>'
L.ToggleFramesDesc = 'Переключает видимость указанного <frameList>'

--slash commands for profiles
L.SetDesc = 'Переключает настройки на <profile>'
L.SaveDesc = 'Сохраняет текущие настройки и переключает на <profile>'
L.CopyDesc = 'Копирует настройки из <profile>'
L.DeleteDesc = 'Удаляет <profile>'
L.ResetDesc = 'Возвращает настройки по умолчанию'
L.ListDesc = 'Список всех профилей'
L.AvailableProfiles = 'Доступные профили'
L.PrintVersionDesc = 'Выводит текущую версию'

--dragFrame tooltips
L.ShowConfig = '<ПКМ> для настройки'
L.HideBar = '<СКМ или Shift-ПКМ> для скрытия'
L.ShowBar = '<СКМ или Shift-ПКМ> для показа'
L.SetAlpha = '<Колёсико мыши> для установки прозрачности (|cffffffff%d|r)'

--minimap button stuff
L.ConfigEnterTip = '<ЛКМ> для входа в режим настройки'
L.ConfigExitTip = '<ЛКМ> для выхода из режима настройки'
L.BindingEnterTip = '<Shift-ЛКМ> для входа в режим ручной привязки'
L.BindingExitTip = '<Shift-ЛКМ> для выхода из режима ручной привязки'
L.ShowOptionsTip = '<ПКМ> для показа меню настроек'

--helper dialog stuff
L.ConfigMode = 'Режим настройки'
L.ConfigModeHelp = '<Перетаскивание> любой панели для её перемещения.'

--lynn localization items
L.EnableAutomaticBindings = 'Всегда использовать кнопки Razer Naga'
L.BindingSet = 'Переключатель 123/Num'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Настройка привязки клавиш для макета %s - клавиши %s'
L.CannotAlterBindingsInCombat = 'Нельзя изменять привязки в бою'
L.EnableAutoBindingsPrompt = [[
Razer Naga может гарантировать, что кнопки на клавиатуре настроены для панелей действий и питомцев, но включение этой функции может повлиять на ваши текущие привязки клавиш.

Хотите включить эту функцию сейчас? Если вы не хотите этого сейчас, вы всегда можете включить эту опцию позже в меню настроек.]]
L.BindKeysManuallyPrompt = 'Прекратить использовать только кнопки Razer Naga и настроить привязки клавиш вручную?'

--lynn tooltips
L.SwitchTo4x3 = 'Перестроить панели действий и питомцев в макет 4x3.'
L.SwitchTo3x4 = 'Перестроить панели действий и питомцев в макет 3x4.'
L.AutomaticBindingsToggle = 'Установите этот флажок, чтобы кнопки Razer Naga всегда были привязаны к панелям действий и питомцев.'
L.ConfigModeExit = 'Нажмите, чтобы выйти из режима настройки.'
L.ConfigModeShowOptions = 'Нажмите, чтобы выйти из режима настройки и открыть меню настроек.'
L.ConfigModeSwitchToBindingMode = 'Нажмите, чтобы прекратить использовать только кнопки Razer Naga и настроить привязки клавиш вручную.'
L.BindingSetHelp = 'Эта настройка должна соответствовать переключателю на вашей мыши.\n\nОна определяет, какие клавиши привязываются, когда включена опция "Всегда использовать кнопки Razer Naga".\n\n"123" означает, что привязаны клавиши 1, 2, 3, 4, 5, 6, 7, 8, 9, -, =.\n\n"Num" означает, что привязаны клавиши Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+.\n\nМодификаторы будут привязаны в соответствии с вашими настройками.' 
L.SimpleBindingHelp = 'Клавиши 1, 2, 3, 4, 5, 6, 7, 8, 9, -, ='
L.AvancedBindingSetHelp = 'Клавиши Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+'

--bar tooltips
L.PetBarHelp = 'Отображает действия питомца, когда вы управляете питомцем.'

L.ClassBarHelp_DRUID = 'Отображает все изученные формы превращения друида.'
L.ClassBarHelp_ROGUE = 'Отображает невидимость разбойника, если доступна.'
L.ClassBarHelp_PALADIN = 'Отображает доступные ауры паладина.'
L.ClassBarHelp_WARRIOR = 'Отображает доступные стойки воина.'
L.ClassBarHelp_PRIEST = 'Отображает форму тьмы жреца, если доступна.'
L.ClassBarHelp_WARLOCK = 'Отображает метаморфозу чернокнижника, если доступна.'
L.ClassBarHelp_DEATHKNIGHT = 'Отображает доступные присутствия рыцаря смерти.'
L.ClassBarHelp_HUNTER = 'Отображает доступные аспекты охотника.'
L.ClassBarHelp_MONK = 'Отображает доступные стойки монаха.'

L.CastBarHelp = 'Отображает полосу прогресса при произнесении заклинания\nили выполнении ремесла.'
L.RollBarHelp = 'Отображает предметы для розыгрыша, когда вы в группе.'
L.VehicleBarHelp = [[
Отображает кнопки наклона вверх, наклона вниз и 
выхода из транспорта. Какие элементы отображаются, 
зависит от типа транспорта. Все остальные действия 
транспорта отображаются на панели управления.]]
L.ExtraBarHelp = 'Отображает действия, специфичные для определённых рейдовых встреч.'

--hover menu tooltips
L.ConfigureBarHelp = 'Настроить эту панель.'
L.ToggleVisibilityHelpHide = 'Скрыть эту панель.'
L.ToggleVisibilityHelpShow = 'Показать эту панель.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga не удалось загрузить должным образом, так как загружен %s, с которым RazerNaga несовместим. Пожалуйста, отключите другие аддоны панелей действий, чтобы загрузить RazerNaga.'

L.ChangeSummary = 'Сводка изменений:'
L.TryAgain = 'Попробовать снова'
