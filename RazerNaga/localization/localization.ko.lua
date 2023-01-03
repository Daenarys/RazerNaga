
local L = LibStub('AceLocale-3.0'):NewLocale('RazerNaga', 'koKR')
if not L then return end

--system messages
L.Updated = 'v%s으로 업데이트됨'

--profiles
L.ProfileCreated = '새 프로파일 "%s" 생성됨'
L.ProfileLoaded = '"%s"로 프로파일 설정됨'
L.ProfileDeleted = '프로파일 "%s" 삭제됨'
L.ProfileCopied = '"%s"에서 설정 복사됨'
L.ProfileReset = '프로파일 "%s" 다시 설정됨'
L.CantDeleteCurrentProfile = '현재 프로파일을 삭제할 수 없습니다.'
L.InvalidProfile = '잘못된 프로파일 "%s"'

--slash command help
L.ConfigDesc = '구성 모드 전환'

L.SetScaleDesc = '<frameList> 배율 설정'
L.SetAlphaDesc = '<frameList> 불투명도 설정'
L.SetFadeDesc = '<frameList> 빛바랜 불투명도 설정'

L.SetColsDesc = '<frameList>의 열 개수 설정'
L.SetPadDesc = '<frameList>의 안쪽 여백 수준 설정'
L.SetSpacingDesc = '<frameList>의 간격 수준 설정'

L.ShowFramesDesc = '주어진 <frameList> 보이기'
L.HideFramesDesc = '주어진 <frameList> 숨기기'
L.ToggleFramesDesc = '주어진 <frameList> 전환'

--slash commands for profiles
L.SetDesc = '설정을 <profile>로 전환'
L.SaveDesc = '현재 설정을 저장하고 <profile>로 전환'
L.CopyDesc = '<profile>에서 설정 복사'
L.DeleteDesc = '<profile> 삭제'
L.ResetDesc = '초기 설정으로 돌아가기'
L.ListDesc = '모든 프로파일 목록 표시'
L.AvailableProfiles = '이용 가능한 프로파일'
L.PrintVersionDesc = '현재 버전 인쇄'

--dragFrame tooltips
L.ShowConfig = '<오른쪽 클릭>하여 구성'
L.HideBar = '<가운데 클릭 또는 오른쪽 클릭으로 전환>하여 숨기기'
L.ShowBar = '<가운데 클릭 또는 오른쪽 클릭으로 전환>하여 보이기'
L.SetAlpha = '<마우스휠>로 불투명도를 (|cffffffff%d|r)으로 설정'

--minimap button stuff
L.ConfigEnterTip = '<왼쪽 클릭>하여 구성 모드 입력'
L.ConfigExitTip = '<왼쪽 클릭>하여 구성 모드 종료'
L.BindingEnterTip = '<왼쪽 클릭 전환>하여 수동 바인딩 모드 입력'
L.BindingExitTip = '<왼쪽 클릭 전환>하여 수동 바인딩 모드 종료'
L.ShowOptionsTip = '<오른쪽 클릭>하여 옵션 메뉴 보이기'

--helper dialog stuff
L.ConfigMode = '구성 모드'
L.ConfigModeHelp = '바를 <드래그>하여 옮깁니다.'

--lynn localization items
L.EnableAutomaticBindings = '언제나 Razer Naga 버튼 사용'
L.BindingSet = '123/Num 전환'
L.Simple = '123'
L.Advanced = 'Num'
L.EnforcingBindings = '%s 레이아웃의 키 바인딩 구성 – %s 키'
--L.AcceptBindingChangesPrompt ='바인딩 변경을 수락할까요?'
L.CannotAlterBindingsInCombat = '전투 중 바인딩을 변경할 수 없음'
L.EnableAutoBindingsPrompt = [[
Razer Naga에서는 키패드의 버튼을 액션바와 펫바에 대해 구성할 수 있지만 이 기능을 활성화하면 현재 키 바인딩에 영향을 줄 수 있습니다.

이 기능을 지금 활성화할까요? 지금 바로 활성화하고 싶지 않은 경우, 나중에 언제든지 구성 메뉴에서 해당 옵션을 활성화할 수 있습니다.]]
L.BindKeysManuallyPrompt = 'Razer Naga 버튼만 사용을 중단하고 키 바인딩을 수동으로 구성할까요?'

--lynn tooltips
L.SwitchTo4x3 = '액션바와 펫바를 4x3 레이아웃으로 재조정합니다.'
L.SwitchTo3x4 = '액션바와 펫바를 3x4 레이아웃으로 재조정합니다.'
L.AutomaticBindingsToggle = '이 상자를 선택하면 Razer Naga 버튼이 언제나 액션바와 펫바에 바인딩됩니다.'
L.ConfigModeExit = '여기를 클릭하여 구성 모드를 종료합니다.'
L.ConfigModeShowOptions = '여기를 클릭하여 구성 모드를 종료하고 옵션 메뉴를 표시합니다.'
L.ConfigModeSwitchToBindingMode = '여기를 클릭하여 Razer Naga 버튼만 사용을 중단하고 키 바인딩을 수동으로 구성합니다.'
L.BindingSetHelp = '이 설정은 마우스의 전환과 일치하도록 설정해야 합니다.\n\n이는 "언제나 Razer Naga 버튼 사용"을 선택했을 때 바인딩되는 키를 결정합니다.\n\n"123"은 1,2,3,4,5,6,7,8,9,-,= 키가 바인딩되어 있다는 것을 의미합니다.\n\n"Num"은 Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ 키가 바인딩되어 있다는 것을 의미합니다.\n\n보조키는 설정에 의해 결정된 대로 맵핑됩니다.'
L.SimpleBindingHelp = '1, 2, 3, 4, 5, 6, 7, 8, 9, -, = 키'
L.AvancedBindingSetHelp = 'Num1, Num2, Num3, Num4, Num5, Num6, Num7, Num8, Num9, Num0, Num-, Num+ 키'

--bar tooltips
L.PetBarHelp = '펫을 컨트롤하고 있을 때 펫 액션을 표시합니다.'

L.ClassBarHelp_DRUID = '학습한 모든 드루이드 변신 형태를 표시합니다.'
L.ClassBarHelp_ROGUE = '이용할 수 있는 경우, 속이기 은신을 표시합니다.'
L.ClassBarHelp_PALADIN = '이용할 수 있는 성기사 오로라를 표시합니다.'
L.ClassBarHelp_WARRIOR = '이용할 수 있는 전사 태세를 표시합니다.'
L.ClassBarHelp_PRIEST = '이용할 수 있는 경우, 사제 그림자 형상을 표시합니다.'
L.ClassBarHelp_WARLOCK = '이용할 수 있는 경우, 마법사 변형를 표시합니다.'
L.ClassBarHelp_DEATHKNIGHT = '이용할 수 있는 죽음의 기사 존재를 표시합니다.'
L.ClassBarHelp_HUNTER = '사냥꾼 모양 표시 가능'

L.CastBarHelp = '마법을 걸거나\n 작업 스킬을 수행할 때 진행바를 표시합니다.'
L.RollBarHelp = '그룹일 때 운행할 아이템을 표시합니다.'
L.VehicleBarHelp = [[
차량 피치 업, 피치 다운 및 종료 버튼을 표시합니다. 어떤 아이템이 표시되는지는 
타고 있는 차량의 유형에 달려 있습니다. 다른 모든 차량 액션은 소유바에 표시됩니다.]]
L.ExtraBarHelp = '특정 레이드 시작시 가능한 버튼 보임 '

--hover menu tooltips
L.ConfigureBarHelp = '이 바를 구성합니다.'
L.ToggleVisibilityHelpHide = '이 바를 숨깁니다.'
L.ToggleVisibilityHelpShow = '이 바를 보입니다.'

--binding set modifiers
L.AltKey = 'ALT'

--incompatible addon prompt
L.IncompatibleAddonLoaded = 'RazerNaga와호환할 수 없는 %s가 로드되어 있으므로 RazerNaga를 제대로 로드할 수 없었습니다. RazerNaga를 로드하려면 실행하고 있는 다른 액션바 애드온을 비활성화하세요.'
