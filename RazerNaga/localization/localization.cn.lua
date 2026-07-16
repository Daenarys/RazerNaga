
local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'zhCN')
if not L then return end

--system messages
--L.NewPlayer = '建立新配置 %s'
L.Updated = '已更新到 版本 v%s'

--profiles
L.ProfileCreated = '已创建新配置文件“%s”'
L.ProfileLoaded = '将配置文件设置为“%s”'
L.ProfileDeleted = '已删除配置文件“%s”'
L.ProfileCopied = '已从“%s”复制设置'
L.ProfileReset = '重设配置文件“%s”'
L.CantDeleteCurrentProfile = '无法删除当前配置文件'
L.InvalidProfile = '无效配置文件“%s”'

--slash command help
--L.ShowOptionsDesc = '显示设置菜单'
L.ConfigDesc = '切换配置模式'

L.SetScaleDesc = '设置<框架列表>的大小'
L.SetAlphaDesc = '设置<框架列表>的不透明度'
L.SetFadeDesc = '设置<框架列表>的淡出参数'

L.SetColsDesc = '设置<框架列表>的列数'
L.SetPadDesc = '设置<框架列表>的填充级别'
L.SetSpacingDesc = '设置<框架列表>的间距级别'

L.ShowFramesDesc = '显示既定的<框架列表>'
L.HideFramesDesc = '隐藏既定的<框架列表>'
L.ToggleFramesDesc = '切换既定的<框架列表>'

--slash commands for profiles
L.SetDesc = '将设置切换到<配置文件>'
L.SaveDesc = '保存当前设置，然后切换到<配置文件>'
L.CopyDesc = '从<配置文件>复制设置'
L.DeleteDesc = '删除<配置文件>'
L.ResetDesc = '还原为默认设置'
L.ListDesc = '列出所有配置文件'
L.AvailableProfiles = '可用配置文件'
L.PrintVersionDesc = '打印当前版本'

--dragFrame tooltips
L.ShowConfig = '<右键单击>进行配置'
L.HideBar = '<中键单击或移右键单击>隐藏'
L.ShowBar = '<中键单击或移右键单击>显示'
L.SetAlpha = '<鼠标滚轮>设置不透明度 (|cffffffff%d|r)'
--minimap button stuff
L.ConfigEnterTip = '<左键单击>输入配置模式'
L.ConfigExitTip = '<左键单击>退出配置模式'
L.BindingEnterTip = '<移左键单击>输入手动绑定模式'
L.BindingExitTip = '<移左键单击>退出手动绑定模式'
L.ShowOptionsTip = '<右键单击>显示选项菜单'

--helper dialog stuff
L.ConfigMode = '配置模式'
L.ConfigModeHelp = '<拖动>任意条将其移动。'

--lynn localization items
L.EnableAutomaticBindings = '始终使用那伽梵蛇游戏鼠标按钮'
L.BindingSet = '123/Num 切换'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = '为 %s 格式配置键绑定 – %s 键'
--L.AcceptBindingChangesPrompt = '是否接受绑定更改？'
L.CannotAlterBindingsInCombat = '无法在战斗时更改绑定'
L.EnableAutoBindingsPrompt = [[
那伽梵蛇游戏鼠标可确保将键盘上的按钮配置为用于动作栏和宠物栏，但是启用此功能可能会影响当前键绑定。

现在是否启用此功能？如果不想立即启用此功能，您可以稍后从配置菜单中启用该选项。]]
L.BindKeysManuallyPrompt = '是否停止仅使用那伽梵蛇游戏鼠标按钮，然后手动配置键绑定？'

--lynn tooltips
L.SwitchTo4x3 = '将您的操作栏和宠物栏重新调整为 4x3 格式。'
L.SwitchTo3x4 = '将您的操作栏和宠物栏重新调整为 3x4 格式。'
L.AutomaticBindingsToggle = '检查此框，确保那伽梵蛇游戏鼠标按钮始终与操作栏和宠物栏绑定。'
L.ConfigModeExit = '单击此按钮，退出配置模式。'
L.ConfigModeShowOptions = '单击此按钮，退出配置模式，然后显示选项菜单。'
L.ConfigModeSwitchToBindingMode = '单击此按钮，停止仅使用那伽梵蛇游戏鼠标按钮，然后手动配置键绑定。'
L.BindingSetHelp = '应将此设置设置为与鼠标的切换相匹配。\n\n当“始终使用那伽梵蛇游戏鼠标按钮”选项被勾选时，会检查那些键已经被绑定了。\n\n“123”指如下按键被绑定：1、2、3、4、5、6、7、8、9、-、=。\n\n“Num”指如下按键被绑定：Num1、Num2、Num3、Num4、Num5、Num6、Num7、Num8、Num9、Num0、Num-、Num+。\n\n修改者键依您的设置而定。' 
L.SimpleBindingHelp = '1、2、3、4、5、6、7、8、9、-、= 键'
L.AvancedBindingSetHelp = 'Num1、Num2、Num3、Num4、Num5、Num6、Num7、Num8、Num9、Num0、Num-、Num+ 键'

--bar tooltips
L.PetBarHelp = '控制宠物时，显示宠物动作。'

L.ClassBarHelp_DRUID = '显示所有已经习得的德鲁伊变身形态。'
L.ClassBarHelp_ROGUE = '显示盗贼的潜行状态（如果可用）。'
L.ClassBarHelp_PALADIN = '显示可用的游侠光环。'
L.ClassBarHelp_WARRIOR = '显示可用的战士姿态。'
L.ClassBarHelp_PRIEST = '显示牧师的暗影形态（如果可用）。'
L.ClassBarHelp_WARLOCK = '显示术士变形（如果可用）。'
L.ClassBarHelp_DEATHKNIGHT = '显示可用的死亡骑士灵气。'
L.ClassBarHelp_HUNTER = '显示可用的猎人守护技能'

L.CastBarHelp = '施魔法\n或施展贸易技能时显示进度条。'
L.RollBarHelp = '显示一个组中的可循环商品。'
L.VehicleBarHelp = [[
显示车辆抬高、降低以及 
退出按钮。显示的商品取决于 
您使用的车辆类型。所有其他 
车辆操作显示在进度条中。]]
L.ExtraBarHelp = '在某些特定的Raid战中显示额外的动作栏'

--hover menu tooltips
L.ConfigureBarHelp = '配置此栏。'
L.ToggleVisibilityHelpHide = '隐藏此栏。'
L.ToggleVisibilityHelpShow = '显示此栏。'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = '无法正常加载那伽梵蛇游戏鼠标，因为已加载了与其不兼容的 %s。请禁用所有其他您可能正在运行的动作栏插件，以便加载那伽梵蛇游戏鼠标。'