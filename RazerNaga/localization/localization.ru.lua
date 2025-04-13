
local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'ruRU')
if not L then return end

--system messages
L.Updated = 'Обновлен до версии %s'

--profiles
L.ProfileCreated = 'Создан новый профиль "%s"'
L.ProfileLoaded = 'Установлен профиль для "%s"'
L.ProfileDeleted = 'Удален профиль "%s"'
L.ProfileCopied = 'Скопированы настройки из "%s"'
L.ProfileReset = 'Сбросить профиль "%s"'
L.CantDeleteCurrentProfile = 'Невозможно удалить текущий профиль'
L.InvalidProfile = 'Недопустимый профиль "%s"'

--slash command help
L.ConfigDesc = 'Переключает режим настройки'

L.SetScaleDesc = 'Устанавливает масштаб <frameList>'
L.SetAlphaDesc = 'Устанавливает непрозрачность <frameList>'
L.SetFadeDesc = 'Устанавливает затухание непрозрачности <frameList>'

L.SetColsDesc = 'Устанавливает количество колонок для <frameList>'
L.SetPadDesc = 'Устанавливает уровень заполнения для <frameList>'
L.SetSpacingDesc = 'Устанавливает уровень интервала для <frameList>'

L.ShowFramesDesc = 'Отображает заданный <frameList>'
L.HideFramesDesc = 'Скрывает заданный <frameList>'
L.ToggleFramesDesc = 'Переключает заданный <frameList>'

--slash commands for profiles
L.SetDesc = 'Переключает настройки для <profile>'
L.SaveDesc = 'Сохраняет текущие настройки и переключает на <profile>'
L.CopyDesc = 'Копирует настройки из <profile>'
L.DeleteDesc = 'Удаляет <profile>'
L.ResetDesc = 'Возвращает параметры по умолчанию'
L.ListDesc = 'Выводит список всех профилей'
L.AvailableProfiles = 'Доступные профили'
L.PrintVersionDesc = 'Выводит на печать текущую версию'

--dragFrame tooltips
L.ShowConfig = '<Правый щелчок> для настройки'
L.HideBar = '<Средний щелчок или Shift-Правый щелчок> для скрытия'
L.ShowBar = '<Средний щелчок или Shift-Правый щелчок> для отображения'
L.SetAlpha = '<Колесико мыши> для установки непрозрачности (|cffffffff%d|r)'

--minimap button stuff
L.ConfigEnterTip = '<Левый щелчок> для перехода в режим настройки'
L.ConfigExitTip = '<Левый щелчок> для выхода из режима настройки'
L.BindingEnterTip = '<Shift Левый щелчок> для перехода в режим ручной привязки'
L.BindingExitTip = '<Shift Левый щелчок> для выхода из режима ручной привязки'
L.ShowOptionsTip = '<Правый щелчок> для отображения меню свойств'

--helper dialog stuff
L.ConfigMode = 'Режим настройки'
L.ConfigModeHelp = 'Для перемещения <перетащите> любую панель.'

--lynn localization items
L.EnableAutomaticBindings = 'Всегда использовать кнопки Razer Naga'
L.BindingSet = '123/Num переключатель'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = 'Настройка привязки клавиш для раскладки %s – клавиши %s'
--L.AcceptBindingChangesPrompt ='Принять изменения привязки?'
L.CannotAlterBindingsInCombat = 'Нельзя изменить привязку в сражении'
L.EnableAutoBindingsPrompt = [[
Razer Naga может гарантировать, что кнопки вспомогательной клавиатуры настроены для действий и панелей любимцев, но включение этой функции может повлиять на текущие привязки клавиш.

Хотите включить эту возможность сейчас? Если вы не хотите делать это прямо сейчас, ее всегда можно включить позже в меню настройки.]]
L.BindKeysManuallyPrompt = 'Прекратить использование кнопок Razer Naga и вручную настроить привязки клавиш?'

--lynn tooltips
L.SwitchTo4x3 = 'Перегруппировать действия и панели любимцев для раскладки 4x3.'
L.SwitchTo3x4 = 'Перегруппировать действия и панели любимцев для раскладки 3x4.'
L.AutomaticBindingsToggle = 'Установите этот флажок, чтобы кнопки Razer Naga всегда назначались для действий и панелей любимцев.'
L.ConfigModeExit = 'Для выхода из режима настройки щелкните здесь.'
L.ConfigModeShowOptions = 'Щелкните здесь для выхода из режима настройки и отображения меню свойств.'
L.ConfigModeSwitchToBindingMode = 'Щелкните здесь, чтобы прекратить использование кнопок Razer Naga и вручную настроить привязки клавиш.'
L.BindingSetHelp = 'Этот параметр должен соответствовать переключателю на вашей мыши. \n\nОн определяет какие клавиши имеют привязку, если отмечен флажок "Всегда использовать кнопки Razer Naga". \n\n"123" означает что назначены клавиши 1,2,3,4,5,6,7,8,9,-,=. \n\n"Num" означает что назначены клавиши Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+. Соответствия для модифицирующих клавиш определяется вашими настройками.'
L.SimpleBindingHelp = 'Клавиши 1, 2, 3, 4, 5, 6, 7, 8, 9, -, ='
L.AvancedBindingSetHelp = 'Клавиши Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+'

--bar tooltips
L.PetBarHelp = 'Отображает действия в режиме управления любимцем.'

L.ClassBarHelp_DRUID = 'Отображает все изученные Друидом смены форм.'
L.ClassBarHelp_ROGUE = 'Если доступно, отображает режим скрытности мошенника.Вора.'
L.ClassBarHelp_PALADIN = 'Отображает доступные Паладину ауры.'
L.ClassBarHelp_WARRIOR = 'Отображает доступные позиции Воина.'
L.ClassBarHelp_PRIEST = 'Если доступно, отображает теневую форму Священника.'
L.ClassBarHelp_WARLOCK = 'Если доступно, отображает превращения Колдуна.'
L.ClassBarHelp_DEATHKNIGHT = 'Отображает доступные присутствия Рыцаря Смерти.'
L.ClassBarHelp_HUNTER = 'Отображает доступные аспекты охотника.'

L.CastBarHelp = 'Отображает индикатор выполнения при наложении заклинания \n или использовании профессионального навыка.'
L.RollBarHelp = 'Отображает пункты для прокрутки в режиме группы.'
L.VehicleBarHelp = [[
Отображает смещение угла прицеливания транспортного средства вверх и вниз, а также 
кнопки выхода. Отображаемые пункты определяются 
типом используемого транспортного средства. Все остальные 
действия с транспортным средством отображены на панели владения.]]
L.ExtraBarHelp = 'Отображение действий, характерных для определённых рейдов'

--hover menu tooltips
L.ConfigureBarHelp = 'Настроить эту панель.'
L.ToggleVisibilityHelpHide = 'Скрыть эту панель.'
L.ToggleVisibilityHelpShow = 'Показать эту панель.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga не смог загрузится надлежащим образом, поскольку загружен %s, с которым он не совместим. Чтобы загрузить RazerNaga, необходимо отключить любые другие запущенные дополнения для панели действий.'
