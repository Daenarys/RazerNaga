if not ExtraAbilityContainer then return end

--[[
	extraActionBar.lua
		The RazerNaga extra action bar
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
local L = LibStub("AceLocale-3.0"):GetLocale('RazerNaga')

--[[ bar ]]--

local ExtraAbilityBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function ExtraAbilityBar:New()
    return ExtraAbilityBar.proto.New(self, 'extra')
end

ExtraAbilityBar:Extend('OnAcquire',  function(self)
    self:RepositionExtraAbilityContainer()
    self:Layout()
end)

function ExtraAbilityBar:GetDefaults()
    return {
        point = 'BOTTOM',
        x = 0,
        y = 160,
        showInPetBattleUI = true,
        showInOverrideUI = true
    }
end

function ExtraAbilityBar:Layout()
    local w, h = 256, 120
    local pW, pH = self:GetPadding()

    self:SetSize(w + pW, h + pH)
end

function ExtraAbilityBar:RepositionExtraAbilityContainer()
    local container = ExtraAbilityContainer

    container:SetParent(self)
    container:ClearAllPointsBase()
    container:SetPointBase('CENTER', self)
end

function ExtraAbilityBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	self:AddLayoutPanel(menu)

	self.menu = menu

	return menu
end

function ExtraAbilityBar:AddLayoutPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel.opacitySlider = panel:NewOpacitySlider()
	panel.fadeSlider = panel:NewFadeSlider()
	panel.scaleSlider = panel:NewScaleSlider()
	panel.paddingSlider = panel:NewPaddingSlider()

	return panel
end

--[[ module ]]--

local ExtraAbilityBarModule = RazerNaga:NewModule('ExtraAbilityBar')

function ExtraAbilityBarModule:Load()
    if not self.loaded then
        self:OnFirstLoad()
        self.loaded = true
    end

    self.frame = ExtraAbilityBar:New()
end

function ExtraAbilityBarModule:Unload()
    if self.frame then
        self.frame:Free()
    end
end

function ExtraAbilityBarModule:OnFirstLoad()
    self:ApplyTitanPanelWorkarounds()

    -- disable mouse interactions on the extra action bar
    -- as it can sometimes block the UI from being interactive
    if ExtraActionBarFrame:IsMouseEnabled() then
        ExtraActionBarFrame:EnableMouse(false)
    end

    -- onshow/hide call UpdateManagedFramePositions on the blizzard end so
    -- turn that bit off
    ExtraAbilityContainer:SetScript("OnShow", nil)
    ExtraAbilityContainer:SetScript("OnHide", nil)

    -- also reposition whenever edit mode tries to do so
    hooksecurefunc(ExtraAbilityContainer, 'ApplySystemAnchor', function()
        self:RepositionExtraAbilityContainer()
    end)
end

function ExtraAbilityBarModule:RepositionExtraAbilityContainer()
    if (not self.frame) then return end

    local _, relFrame = ExtraAbilityContainer:GetPoint()

    if self.frame ~= relFrame then
        self.frame:RepositionExtraAbilityContainer()
    end
end


-- Titan panel will attempt to take control of the ExtraActionBarFrame and break
-- its position and ability to be usable. This is because Titan Panel doesn't
-- check to see if another addon has taken control of the bar
--
-- To resolve this, we call TitanMovable_AddonAdjust() for the extra ability bar
-- frames to let titan panel know we are handling positions for the extra bar
function ExtraAbilityBarModule:ApplyTitanPanelWorkarounds()
    local adjust = _G.TitanMovable_AddonAdjust
    if not adjust then return end

    adjust('ExtraAbilityContainer', true)
    adjust("ExtraActionBarFrame", true)
    return true
end