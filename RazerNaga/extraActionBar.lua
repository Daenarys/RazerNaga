local ExtraAbilityContainer = _G.ExtraAbilityContainer
if not ExtraAbilityContainer then
    return
end

local RazerNaga = _G.RazerNaga

--[[ bar ]]--

local ExtraBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function ExtraBar:New()
	local frame = RazerNaga.Frame.New(self, 'extra')

	-- attach the ExtraAbilityContainer to the bar
	local container = ExtraAbilityContainer

	container:ClearAllPoints()
	container:SetPoint('CENTER', frame.header)
	container:SetParent(frame.header)
	container:SetToplevel(false)

	frame.container = container

	-- drop need for showstates for this case, as the extra bar can show in more
	-- conditions with shadowlands
    if frame:GetShowStates() == '[extrabar]show;hide' then
        frame:SetShowStates(nil)
    end

	frame:Layout()

	return frame
end

function ExtraBar:GetDefaults()
	return {
		point = 'CENTER',
		x = -244,
		y = 0,
	}
end

function ExtraBar:Layout()
    local w, h = 256, 120
    local pW, pH = self:GetPadding()

    self:SetSize(w + pW, h + pH)
end

function ExtraBar:CreateMenu()
	local menu = RazerNaga:NewMenu(self.id)

	self:AddLayoutPanel(menu)

	self.menu = menu

	return menu
end

function ExtraBar:AddLayoutPanel(menu)
	local panel = menu:NewPanel(LibStub('AceLocale-3.0'):GetLocale('RazerNaga-Config').Layout)

	panel.opacitySlider = panel:NewOpacitySlider()
	panel.fadeSlider = panel:NewFadeSlider()
	panel.scaleSlider = panel:NewScaleSlider()
	panel.paddingSlider = panel:NewPaddingSlider()

	return panel
end


--[[ module ]]--

local ExtraBarController = RazerNaga:NewModule('ExtraBar')

function ExtraBarController:OnInitialize()
	-- disable mouse interactions on the extra action bar
	-- as it can sometimes block the UI from being interactive
	if ExtraActionBarFrame:IsMouseEnabled() then
		ExtraActionBarFrame:EnableMouse(false)
	end

	-- prevent the stock UI from messing with the extra ability bar position
	ExtraActionBarFrame.ignoreFramePositionManager = true
	ExtraAbilityContainer.ignoreFramePositionManager = true

	-- onshow/hide call UpdateManagedFramePositions on the blizzard end so
	-- turn that bit off
	ExtraAbilityContainer:SetScript("OnShow", nil)
	ExtraAbilityContainer:SetScript("OnHide", nil)
end

function ExtraBarController:OnEnable()
	self:ApplyTitanPanelWorkarounds()
end

function ExtraBarController:Load()
    self.frame = ExtraBar:New()
end

function ExtraBarController:Unload()
	self.frame:Free()
end

-- Titan panel will attempt to take control of the ExtraActionBarFrame and break
-- its position and ability to be usable. This is because Titan Panel doesn't
-- check to see if another addon has taken control of the bar
--
-- To resolve this, we call TitanMovable_AddonAdjust() for the extra ability bar
-- frames to let titan panel know we are handling positions for the extra bar
function ExtraBarController:ApplyTitanPanelWorkarounds()
    local adjust = _G.TitanMovable_AddonAdjust
    if not adjust then return end

    adjust('ExtraAbilityContainer', true)
    adjust("ExtraActionBarFrame", true)
    return true
end