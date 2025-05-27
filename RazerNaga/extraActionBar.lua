local ExtraActionBarFrame = _G.ExtraActionBarFrame
if not ExtraActionBarFrame then
    return
end

local RazerNaga = _G.RazerNaga

--[[ bar ]]--

local ExtraBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function ExtraBar:New()
	local frame = RazerNaga.Frame.New(self, 'extra')

	-- attach the ExtraActionBarFrame to the bar
	local container = ExtraActionBarFrame

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

	-- onshow/hide call UpdateManagedFramePositions on the blizzard end so
	-- turn that bit off
	ExtraActionBarFrame:SetScript("OnShow", nil)
	ExtraActionBarFrame:SetScript("OnHide", nil)
end

function ExtraBarController:Load()
    self.frame = ExtraBar:New()
end

function ExtraBarController:Unload()
	self.frame:Free()
end