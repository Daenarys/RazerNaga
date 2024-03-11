--------------------------------------------------------------------------------
-- Action Bar
-- A pool of action bars
--------------------------------------------------------------------------------
local RazerNaga = _G[...]

local ACTION_BUTTON_COUNT = 120

local ActionBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

ActionBar.class = UnitClassBase('player')

-- Metatable magic. Basically this says, "create a new table for this index"
-- I do this so that I only create page tables for classes the user is actually
-- playing
ActionBar.defaultOffsets = {
    __index = function(t, i)
        t[i] = {}
        return t[i]
    end
}

-- Metatable magic.  Basically this says, 'create a new table for this index,
-- with these defaults. I do this so that I only create page tables for classes
-- the user is actually playing
ActionBar.mainbarOffsets = {
    __index = function(t, i)
        local pages = {
            page2 = 1,
            page3 = 2,
            page4 = 3,
            page5 = 4,
            page6 = 5
        }

        if i == 'DRUID' then
            pages.cat = 6
            pages.bear = 8
            pages.moonkin = 9
            pages.tree = 7
        elseif i == 'EVOKER' then
            pages.soar = 7
        elseif i == 'ROGUE' then
            pages.stealth = 6
            pages.shadowdance = 6
        end

        t[i] = pages
        return pages
    end
}

ActionBar:Extend('OnLoadSettings', function(self)
    self.sets.pages = setmetatable(self.sets.pages or {}, self.id == 1 and self.mainbarOffsets or self.defaultOffsets)

    self.pages = self.sets.pages[self.class]
end)

ActionBar:Extend('OnAcquire', function(self)
    self:SetAttribute("checkselfcast", true)
    self:SetAttribute("checkfocuscast", true)
    self:SetAttribute("checkmouseovercast", true)

    self:LoadStateController()
    self:UpdateStateDriver()
    self:UpdateGrid()
    self:UpdateRightClickUnit()
    self:UpdateFlyoutDirection()
end)

-- TODO: change the position code to be based more on the number of action bars
function ActionBar:GetDefaults()
    return {
        point = 'BOTTOM',
        x = 0,
        y = 14 + (ActionButton1:GetHeight() + 4) * (self.id - 1),
        pages = {},
        spacing = 4,
        padW = 2,
        padH = 2,
        numButtons = self:MaxLength()
    }
end

-- returns the maximum possible size for a given bar
function ActionBar:MaxLength()
    return floor(ACTION_BUTTON_COUNT / RazerNaga:NumBars())
end

function ActionBar:AcquireButton(index)
    local id = index + (self.id - 1) * self:MaxLength()
    local button = RazerNaga.ActionButton:GetOrCreateActionButton(id, self)

    button:SetAttributeNoHandler('index', index)

    return button
end

function ActionBar:ReleaseButton(button)
    button:SetAlpha(0)
end

function ActionBar:OnAttachButton(button)
    button:SetAttribute("action", button:GetAttribute("index") + (self:GetAttribute("actionOffset") or 0))
    
    button:SetFlyoutDirection(self:GetFlyoutDirection())
    button:SetShowMacroText(RazerNaga:ShowMacroText())

    if button:HasAction() then
        button:SetAlpha(1)
    end

    RazerNaga:GetModule('Tooltips'):Register(button)
end

function ActionBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

-- paging
function ActionBar:SetOffset(stateId, page)
    self.pages[stateId] = page
    self:UpdateStateDriver()
end

function ActionBar:GetOffset(stateId)
    return self.pages[stateId]
end

function ActionBar:UpdateStateDriver()
    local conditions

    for _, state in RazerNaga.BarStates:getAll() do
        local offset = self:GetOffset(state.id)

        if offset then
            local condition

            if type(state.value) == 'function' then
                condition = state.value()
            else
                condition = state.value
            end

            if condition then
                local page = Wrap(self.id + offset, RazerNaga:NumBars())

                if conditions then
                    conditions = strjoin(';', conditions, (condition .. page))
                else
                    conditions = (condition .. page)
                end
            end
        end
    end

    if conditions then
        RegisterStateDriver(self, 'page', strjoin(';', conditions, self.id))
    else
        UnregisterStateDriver(self, 'page')
        self:SetAttribute('state-page', self.id)
    end
end

function ActionBar:LoadStateController()
    self:SetAttribute('barLength', self:MaxLength())
    self:SetAttribute('overrideBarLength', NUM_ACTIONBAR_BUTTONS)

    self:SetAttribute('_onstate-overridebar', [[ self:RunAttribute('UpdateOffset') ]])
    self:SetAttribute('_onstate-overridepage', [[ self:RunAttribute('UpdateOffset') ]])
    self:SetAttribute('_onstate-page', [[ self:RunAttribute('UpdateOffset') ]])

    self:SetAttribute('UpdateOffset', [[
        local offset = 0

        local overridePage = self:GetAttribute('state-overridepage') or 0
        if overridePage > 0 and self:GetAttribute('state-overridebar') then
            offset = (overridePage - 1) * self:GetAttribute('overrideBarLength')
        else
            local page = self:GetAttribute('state-page') or 1

            offset = (page - 1) * self:GetAttribute('barLength')
        end

        self:SetAttribute('actionOffset', offset)
        control:ChildUpdate('offset', offset)
    ]])

    self:UpdateOverrideBar()
end

function ActionBar:UpdateOverrideBar()
    self:SetAttribute('state-overridebar', self:IsOverrideBar())
end

function ActionBar:IsOverrideBar()
    return RazerNaga.db.profile.possessBar == self.id
end

-- grid
function ActionBar:ShowGrid()
    for _,b in pairs(self.buttons) do
        if b:IsShown() then
            b:SetAlpha(1.0)
        end
    end
end

function ActionBar:HideGrid()
    for _,b in pairs(self.buttons) do
        if b:IsShown() and not b:HasAction() and not RazerNaga:ShowGrid() then
            b:SetAlpha(0.0)
        end
    end
end

function ActionBar:UpdateGrid()
    if RazerNaga:ShowGrid() then
        self:ShowGrid()
    else
        self:HideGrid()
    end
end

function ActionBar:UpdateSlot()
    for _,b in pairs(self.buttons) do
        if b:IsShown() and b:HasAction() then
            b:SetAlpha(1.0)
        end
    end
end

function ActionBar:KEYBOUND_ENABLED()
    self:ShowGrid()
end

function ActionBar:KEYBOUND_DISABLED()
    self:HideGrid()
end

-- right click unit
function ActionBar:UpdateRightClickUnit()
    self:SetAttribute('*unit2', RazerNaga:GetRightClickUnit())
end

-- flyout direction calculations
function ActionBar:GetFlyoutDirection()
    local w, h = self:GetSize()
    local isVertical = w < h
    local anchor = self:GetPoint()

    if isVertical then
        if anchor and anchor:match('LEFT') then
            return 'RIGHT'
        end
        return 'LEFT'
    end

    if anchor and anchor:match('TOP') then
        return 'DOWN'
    end
    return 'UP'
end

function ActionBar:UpdateFlyoutDirection()
    self:ForButtons('SetFlyoutDirection', self:GetFlyoutDirection())
end

--------------------------------------------------------------------------------
-- Menu
--------------------------------------------------------------------------------

do
    local L

    --state slider template
    local function ConditionSlider_OnShow(self)
        self:SetMinMaxValues(-1, RazerNaga:NumBars() - 1)
        self:SetValue(self:GetParent().owner:GetOffset(self.stateId) or -1)
        self:UpdateText(self:GetValue())
    end

    local function ConditionSlider_UpdateValue(self, value)
        self:GetParent().owner:SetOffset(self.stateId, (value > -1 and value) or nil)
    end

    local function ConditionSlider_UpdateText(self, value)
        if value > -1 then
            local page = (self:GetParent().owner.id + value - 1) % RazerNaga:NumBars() + 1
            self.valText:SetFormattedText(L.Bar, page)
        else
            self.valText:SetText(DISABLE)
        end
    end

    local function ConditionSlider_New(panel, stateId, text)
        local s = panel:NewSlider(stateId, 0, 1, 1)
        s.OnShow = ConditionSlider_OnShow
        s.UpdateValue = ConditionSlider_UpdateValue
        s.UpdateText = ConditionSlider_UpdateText
        s.stateId = stateId

        s:SetWidth(s:GetWidth() + 28)

        local title = _G[s:GetName() .. 'Text']
        title:ClearAllPoints()
        title:SetPoint('BOTTOMLEFT', s, 'TOPLEFT')
        title:SetJustifyH('LEFT')
        title:SetText(text or L['State_' .. stateId:upper()])

        local value = s.valText
        value:ClearAllPoints()
        value:SetPoint('BOTTOMRIGHT', s, 'TOPRIGHT')
        value:SetJustifyH('RIGHT')

        return s
    end

    local function AddLayout(self)
        local p = self:AddLayoutPanel()

        local size = p:NewSlider(L.Size, 1, 1, 1)
        size.OnShow = function(self)
            self:SetMinMaxValues(1, self:GetParent().owner:MaxLength())
            self:SetValue(self:GetParent().owner:NumButtons())
        end

        size.UpdateValue = function(self, value)
            self:GetParent().owner:SetNumButtons(value)
            _G[self:GetParent():GetName() .. L.Columns]:OnShow()
        end
    end

    local function AddAdvancedLayout(self)
        self:AddAdvancedPanel()
    end

    --GetSpellInfo(spellID) is awesome for localization
    local function addStatePanel(self, name, type)
        local states = RazerNaga.BarStates:map(function(s) return s.type == type end)

        if #states > 0 then
            local p = self:NewPanel(name)

            for i = #states, 1, -1 do
                local state = states[i]
                local slider = ConditionSlider_New(p, state.id, state.text)
            end
        end
    end

    local function AddClass(self)
        addStatePanel(self, UnitClass('player'), 'class')
    end

    local function AddPaging(self)
        addStatePanel(self, L.QuickPaging, 'page')
    end

    local function AddModifier(self)
        addStatePanel(self, L.Modifiers, 'modifier')
    end

    local function AddTargeting(self)
        addStatePanel(self, L.Targeting, 'target')
    end

    local function AddShowState(self)
        local p = self:NewPanel(L.ShowStates)
        p.height = 56

        local editBox = CreateFrame('EditBox', p:GetName() .. 'StateText', p,  'InputBoxTemplate')
        editBox:SetWidth(148) editBox:SetHeight(20)
        editBox:SetPoint('TOPLEFT', 12, -10)
        editBox:SetAutoFocus(false)
        editBox:SetScript('OnShow', function(self)
            self:SetText(self:GetParent().owner:GetShowStates() or '')
        end)
        editBox:SetScript('OnEnterPressed', function(self)
            local text = self:GetText()
            self:GetParent().owner:SetShowStates(text ~= '' and text or nil)
        end)
        editBox:SetScript('OnEditFocusLost', function(self) self:HighlightText(0, 0) end)
        editBox:SetScript('OnEditFocusGained', function(self) self:HighlightText() end)

        local set = CreateFrame('Button', p:GetName() .. 'Set', p, 'UIPanelButtonTemplate')
        set:SetWidth(30) set:SetHeight(20)
        set:SetText(L.Set)
        set:SetScript('OnClick', function(self)
            local text = editBox:GetText()
            self:GetParent().owner:SetShowStates(text ~= '' and text or nil)
            editBox:SetText(self:GetParent().owner:GetShowStates() or '')
        end)
        set:SetPoint('BOTTOMRIGHT', -8, 2)

        return p
    end

    function ActionBar:CreateMenu()
        local menu = RazerNaga:NewMenu(self.id)

        L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config')
        AddLayout(menu)
        AddClass(menu)
        AddPaging(menu)
        AddModifier(menu)
        AddTargeting(menu)
        AddShowState(menu)
        AddAdvancedLayout(menu)

        ActionBar.menu = menu
    end
end

-- exports
RazerNaga.ActionBar = ActionBar

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local ActionBarsModule = RazerNaga:NewModule('ActionBars', 'AceEvent-3.0')

function ActionBarsModule:Load()
    self:SetBarCount(RazerNaga:NumBars())

    self:RegisterEvent('UPDATE_SHAPESHIFT_FORMS')
    RazerNaga.RegisterCallback(self, "ACTIONBAR_COUNT_UPDATED")
    self:RegisterEvent("ACTIONBAR_SHOWGRID")
    self:RegisterEvent("ACTIONBAR_HIDEGRID")
    self:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    self:RegisterEvent("SPELLS_CHANGED")
end

function ActionBarsModule:Unload()
    self:UnregisterAllEvents()
    self:ForActive('Free')
    self.active = nil
end

-- events
function ActionBarsModule:ACTIONBAR_COUNT_UPDATED(_, count)
    self:SetBarCount(count)
end

function ActionBarsModule:UPDATE_SHAPESHIFT_FORMS()
    if InCombatLockdown() then
        return
    end

    self:ForActive('UpdateStateDriver')
end

function ActionBarsModule:ACTIONBAR_SHOWGRID()
    self:ForActive('ShowGrid')
end

function ActionBarsModule:ACTIONBAR_HIDEGRID()
    self:ForActive('HideGrid')
end

function ActionBarsModule:ACTIONBAR_SLOT_CHANGED()
    self:ForActive('UpdateSlot')
end

function ActionBarsModule:SPELLS_CHANGED()
    self:ForActive('UpdateGrid')
end

function ActionBarsModule:SetBarCount(count)
    self:ForActive('Free')

    if count > 0 then
        self.active = {}

        for i = 1, count do
            self.active[i] = RazerNaga.ActionBar:New(i)
        end
    else
        self.active = nil
    end
end

function ActionBarsModule:ForActive(method, ...)
    if self.active then
        for _, bar in pairs(self.active) do
            bar:CallMethod(method, ...)
        end
    end
end