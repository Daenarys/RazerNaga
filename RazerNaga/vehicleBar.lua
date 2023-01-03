if not PossessActionBar then return end
--[[
	vehicleBar.lua
		Handles the exit button for vehicles and taxis
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
local L = LibStub('AceLocale-3.0'):GetLocale('RazerNaga')

-- missing APis in classic
local UnitControllingVehicle = _G.UnitControllingVehicle or function() return false end
local CanExitVehicle = _G.CanExitVehicle or function() return false end
local POSSESS_CANCEL_SLOT = _G.POSSESS_CANCEL_SLOT or 2


--[[ button ]]--

local function possessButton_OnClick(self)
    self:SetChecked(false)

    if UnitOnTaxi("player") then
        TaxiRequestEarlyLanding()

        -- Show that the request for landing has been received.
        --self.icon:SetDesaturated(true)
        self:SetChecked(true)
        self:Disable()
    elseif CanExitVehicle() then
        VehicleExit()
    else
        CancelPetPossess()
    end
end

local function possessButton_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

    if UnitOnTaxi("player") then
        GameTooltip_SetTitle(GameTooltip, TAXI_CANCEL)
        GameTooltip:AddLine(TAXI_CANCEL_DESCRIPTION, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
    elseif UnitControllingVehicle("player") and CanExitVehicle() then
        GameTooltip_SetTitle(GameTooltip, LEAVE_VEHICLE)
    else
        GameTooltip:SetText(CANCEL)
    end

    GameTooltip:Show()
end

local function possessButton_OnLeave(self)
    if GameTooltip:IsOwned(self) then
        GameTooltip:Hide()
    end
end

local function possessButton_OnCreate(self)
    self:SetScript("OnClick", possessButton_OnClick)
    self:SetScript("OnEnter", possessButton_OnEnter)
    self:SetScript("OnLeave", possessButton_OnLeave)

    RazerNaga.BindableButton:AddQuickBindingSupport(self)
end

local function getOrCreatePossessButton(id)
    local name = ('%sVehicleButton%d'):format('RazerNaga', id)
    local button = _G[name]

    if not button then
        if SmallActionButtonMixin then
            button = CreateFrame("CheckButton", name, nil, "SmallActionButtonTemplate", id)
            button.cooldown:SetSwipeColor(0, 0, 0)
        else
            button = CreateFrame("CheckButton", name, nil, "ActionButtonTemplate", id)
            button:SetSize(30, 30)
        end

        possessButton_OnCreate(button)
    end

    return button
end


--[[ bar ]]--

local VehicleBar = RazerNaga:CreateClass('Frame', RazerNaga.ButtonBar)

function VehicleBar:New()
    return VehicleBar.proto.New(self, 'vehicle')
end


-- disable UpdateDisplayConditions as we're not using showstates for this
function VehicleBar:GetShowStates()
	return '[canexitvehicle][possessbar]show;hide'
end

function VehicleBar:GetDefaults()
    return {
        point = 'CENTER',
        x = -244,
        y = 0
    }
end

function VehicleBar:NumButtons()
    return 1
end

function VehicleBar:AcquireButton()
    return getOrCreatePossessButton(POSSESS_CANCEL_SLOT)
end

function VehicleBar:OnAttachButton(button)
    button:Show()
    button:UpdateHotkeys()

    RazerNaga:GetModule('Tooltips'):Register(button)
end

function VehicleBar:OnDetachButton(button)
    RazerNaga:GetModule('Tooltips'):Unregister(button)
end

function VehicleBar:Update()
    local button = self.buttons[1]
    local texture = (GetPossessInfo(button:GetID()))
    local icon = button.icon

    if (UnitControllingVehicle("player") and CanExitVehicle()) or not texture then
        icon:SetTexture([[Interface\Vehicles\UI-Vehicles-Button-Exit-Up]])
        icon:SetTexCoord(0.140625, 0.859375, 0.140625, 0.859375)
    else
        icon:SetTexture(texture)
        icon:SetTexCoord(0, 1, 0, 1)
    end

    icon:SetVertexColor(1, 1, 1)
    icon:SetDesaturated(false)
	
	-- hide the actionbutton texture
	button.NormalTexture:SetTexture()

    button:SetChecked(false)
    button:Enable()
end

function VehicleBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	self:AddLayoutPanel(menu)

	self.menu = menu

	return menu
end

function VehicleBar:AddLayoutPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel.opacitySlider = panel:NewOpacitySlider()
	panel.fadeSlider = panel:NewFadeSlider()
	panel.scaleSlider = panel:NewScaleSlider()
	panel.paddingSlider = panel:NewPaddingSlider()

	return panel
end


--[[ exports ]]--

RazerNaga.VehicleBar = VehicleBar


--[[ module ]]--

local VehicleBarModule = RazerNaga:NewModule('VehicleBar', 'AceEvent-3.0')

function VehicleBarModule:Load()
    if not self.loaded then
        self:OnFirstLoad()
        self.loaded = true
    end

    self.bar = VehicleBar:New()

    self:RegisterEvent("UNIT_ENTERED_VEHICLE", "Update")
    self:RegisterEvent("UNIT_EXITED_VEHICLE", "Update")
    self:RegisterEvent("UPDATE_BONUS_ACTIONBAR", "Update")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
    self:RegisterEvent("VEHICLE_UPDATE", "Update")
    self:RegisterEvent("UPDATE_MULTI_CAST_ACTIONBAR", "Update")
    self:RegisterEvent("UPDATE_OVERRIDE_ACTIONBAR", "Update")
    self:RegisterEvent("UPDATE_POSSESS_BAR", "Update")
    self:RegisterEvent("UPDATE_VEHICLE_ACTIONBAR", "Update")
end

function VehicleBarModule:Unload()
    self:UnregisterAllEvents()

    if self.bar then
        self.bar:Free()
    end
end

function VehicleBarModule:OnFirstLoad()
    self.Update = RazerNaga:Defer(self.Update, 0.01, self)
end

function VehicleBarModule:Update()
    if self.bar then
        self.bar:Update()
    end
end