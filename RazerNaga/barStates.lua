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
local class = select(2, UnitClass('player'))
if class == 'WARRIOR' then      
    addState('class', 'battle', '[form:1]', GetSpellInfo(2457))
    addState('class', 'defensive', '[form:2]', GetSpellInfo(71))
    addState('class', 'berserker', '[form:3]', GetSpellInfo(2458))
elseif class == 'DRUID' then
    addState('class', 'moonkin', '[bonusbar:4]', GetSpellInfo(24858))
    addState('class', 'bear', '[bonusbar:3]', GetSpellInfo(5487))
    addState('class', 'tree', function() return format('[form:%d]', GetNumShapeshiftForms() + 1) end, GetSpellInfo(33891))
    addState('class', 'prowl', '[bonusbar:1,stealth]', GetSpellInfo(5215))
    addState('class', 'cat', '[bonusbar:1]', GetSpellInfo(768))
elseif class == 'PRIEST' then
    addState('class', 'shadow', '[bonusbar:1]', GetSpellInfo(15473))
elseif class == 'ROGUE' then
    ---addState('class', 'vanish', '[bonusbar:1,form:3]', GetSpellInfo(1856))
    addState('class', 'shadowdance', '[form:3]', GetSpellInfo(51713) .. '/' .. GetSpellInfo(1856))
    addState('class', 'stealth', '[bonusbar:1]', GetSpellInfo(1784))
elseif class == 'WARLOCK' then
    addState('class', 'meta', '[form:1]', GetSpellInfo(103958))
    -- addState('class', 'darkapotheosis', '[form:2]', GetSpellInfo(114168))
elseif class == 'MONK' then
    addState('class', 'tiger', '[bonusbar:1]', GetSpellInfo(103985))
    addState('class', 'ox', '[bonusbar:2]', GetSpellInfo(115069))
    addState('class', 'serpent', '[bonusbar:3]', GetSpellInfo(115070))      
end

-- race
local race = select(2, UnitRace('player'))
if race == 'NightElf' then
    addState('class', 'shadowmeld', '[stealth]', GetSpellInfo(58984))
end

-- target reaction
addState('target', 'help', '[help]')
addState('target', 'harm', '[harm]')
addState('target', 'notarget', '[noexists]')