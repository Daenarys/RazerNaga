local states = {}

local GetSpellName
if type(GetSpellInfo) == "function" then
    GetSpellName = function(spell) return (GetSpellInfo(spell)) end
else
    GetSpellName = C_Spell.GetSpellName
end

local function getStateIterator(type, i)
    for j = i + 1, #states do
        local state = states[j]
        if state and ((not type) or state.type == type) then
            return j, state
        end
    end
end

local BarStates = {
    add = function(_, state, index)
        if index then
            return table.insert(states, index, state)
        end
        return table.insert(states, state)
    end,

    getAll = function(_, type)
        return getStateIterator, type, 0
    end,

    get = function(_, id)
        for _, v in pairs(states) do
            if v.id == id then
                return v
            end
        end
    end,

    map = function(_, f)
        local results = {}
        for _, v in ipairs(states) do
            if f(v) then
                table.insert(results, v)
            end
        end
        return results
    end
}

RazerNaga.BarStates = BarStates

local function addState(stateType, stateId, stateValue, stateText)
    return BarStates:add {
        type = stateType,
        id = stateId,
        value = stateValue,
        text = stateText
    }
end

-- some class states are a bit dynamic
-- druid forms, for instance, can vary based on how many different abilities
-- are known
local function addFormState(stateType, stateId, spellID)
    local lookupFormConditional = function()
        for i = 1, GetNumShapeshiftForms() do
            local _, _, _, formSpellID = GetShapeshiftFormInfo(i)

            if spellID == formSpellID then
                return ('[form:%d]'):format(i)
            end
        end
    end

    local name = GetSpellName(spellID)

    addState(stateType, stateId, lookupFormConditional, name)
end

-- keybindings
addState('modifier', 'selfcast', '[mod:SELFCAST]', AUTO_SELF_CAST_KEY_TEXT)
addState('modifier', 'ctrlAltShift', '[mod:alt,mod:ctrl,mod:shift]')
addState('modifier', 'ctrlAlt', '[mod:alt,mod:ctrl]')
addState('modifier', 'altShift', '[mod:alt,mod:shift]')
addState('modifier', 'ctrlShift', '[mod:ctrl,mod:shift]')
addState('modifier', 'alt', '[mod:alt]', ALT_KEY)
addState('modifier', 'ctrl', '[mod:ctrl]', CTRL_KEY)
addState('modifier', 'shift', '[mod:shift]', SHIFT_KEY)
addState('modifier', 'meta', '[mod:meta]')

-- paging
for i = 2, NUM_ACTIONBAR_PAGES do
    addState('page', ('page%d'):format(i), ('[bar:%d]'):format(i), _G['BINDING_NAME_ACTIONPAGE' .. i])
end

-- class
local class = UnitClassBase('player')
local race = select(2, UnitRace('player'))

if class == 'DRUID' then
	addState('class', 'bear', '[bonusbar:3]', GetSpellName(5487))
	addState('class', 'prowl', '[bonusbar:1,stealth]', GetSpellName(5215))
	addState('class', 'cat', '[bonusbar:1]', GetSpellName(768))
	addState('class', 'moonkin', '[bonusbar:4]', GetSpellName(24858))
	addFormState('class', 'tree', 114282)
	addFormState('class', 'travel', 783)
	addFormState('class', 'stag', 210053)
elseif class == 'EVOKER' then
    addState('class', 'soar', '[bonusbar:1]', GetSpellName(369536))
elseif class == 'PALADIN' then
	addFormState('class', 'concentration', 317920)
	addFormState('class', 'crusader', 32223)
	addFormState('class', 'devotion', 465)
	addFormState('class', 'retribution', 183435)
elseif class == 'ROGUE' then
    if GetSpellName(185313) then
        addState('class', 'shadowdance', '[bonusbar:1,form:2]', GetSpellName(185313))
    end
    addState('class', 'stealth', '[bonusbar:1]', GetSpellName(1784))
end

-- race
if race == 'NightElf' then
    local name = (GetSpellName(58984) or GetSpellName(20580))

    if name then
        addState('class', 'shadowmeld', '[stealth]', name)
    end
end

-- target reaction
addState('target', 'help', '[help]')
addState('target', 'harm', '[harm]')
addState('target', 'notarget', '[noexists]')