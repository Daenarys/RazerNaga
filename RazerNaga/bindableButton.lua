﻿-- Binding code that's shared between the various flavors of action buttons
local RazerNaga = _G[...]
local KeyBound = LibStub('LibKeyBound-1.0')

-- binding method definitions
-- returns the binding action associated with the button
local function getButtonBindingAction(button)
    return button:GetAttribute("commandName")
end

local function getButtonActionName(button)
    return button:GetName()
end

local function getButtonBindings(button)
    return GetBindingKey(getButtonBindingAction(button))
end

-- returns what hotkey to display for the button
local function getButtonHotkey(button)
    local key = (getButtonBindings(button))

    if key then
        return KeyBound:ToShortKey(key)
    end

    return ''
end

-- returns a space separated list of all bindings for the given button
local function getButtonBindingsList(button)
    return strjoin(' ', getButtonBindings(button))
end

-- set bindings
local function setButtonBinding(button, key)
    return SetBinding(key, getButtonBindingAction(button))
end

-- clears all bindings from the button
local function clearButtonBindings(button)
    local key = (getButtonBindings(button))

    while key do
        SetBinding(key, nil)
        key = (getButtonBindings(button))
    end
end

-- used to implement keybinding support without applying all of the LibKeyBound
-- interface methods via a mixin
local BindableButtonProxy = RazerNaga:CreateHiddenFrame('Frame', "RazerNaga" .. 'BindableButtonProxy')

-- call a thing if the thing exists
local function whenExists(obj, func, ...)
    if obj then
        return func(obj, ...)
    end
end

function BindableButtonProxy:GetHotkey()
    return whenExists(self:GetParent(), getButtonHotkey)
end

function BindableButtonProxy:SetKey(key)
    return whenExists(self:GetParent(), setButtonBinding, key)
end

function BindableButtonProxy:GetBindings()
    return whenExists(self:GetParent(), getButtonBindingsList)
end

function BindableButtonProxy:ClearBindings()
    return whenExists(self:GetParent(), clearButtonBindings)
end

function BindableButtonProxy:GetActionName()
    return whenExists(self:GetParent(), getButtonActionName) or UNKNOWN
end

BindableButtonProxy:SetScript('OnLeave', function(self)
    self:ClearAllPoints()
    self:SetParent(nil)
end)

-- methods to inject onto a bar to add in common binding functionality
local BindableButton = {}

-- adds quickbinding support to buttons
function BindableButton:AddQuickBindingSupport(button)
    button:HookScript('OnEnter', BindableButton.OnEnter)

    if button.UpdateHotkeys then
        hooksecurefunc(button, 'UpdateHotkeys', BindableButton.UpdateHotkeys)
    else
        button.UpdateHotkeys = BindableButton.UpdateHotkeys
    end

    button:UpdateHotkeys()
end

function BindableButton:UpdateHotkeys()
    local key = (self.GetHotkey or getButtonHotkey)(self) or ''
    local hotkey = self.HotKey

    hotkey:SetText(key)
    hotkey:SetShown(key ~= '')

    if key ~= '' and RazerNaga:ShowBindingText() and self.buttonType == 'BONUSACTIONBUTTON' then
        hotkey:ClearAllPoints()
        hotkey:SetPoint("TOPLEFT", -2, -3)
    elseif key ~= '' and RazerNaga:ShowBindingText() and self.buttonType == 'SHAPESHIFTBUTTON' then
        hotkey:ClearAllPoints()
        hotkey:SetPoint("TOPLEFT", -2, -3)
    elseif key ~= '' and RazerNaga:ShowBindingText() then
        hotkey:ClearAllPoints()
        hotkey:SetPoint("TOPLEFT", 3, -3)
    end
end

function BindableButton:OnEnter()
    if not KeyBound:IsShown() then
        return
    end

    BindableButtonProxy:ClearAllPoints()
    BindableButtonProxy:SetParent(self)
    BindableButtonProxy:SetAllPoints()

    KeyBound:Set(BindableButtonProxy)
end

-- exports
RazerNaga.BindableButton = BindableButton