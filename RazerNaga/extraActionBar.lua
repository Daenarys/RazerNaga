if not _G.ExtraActionBarFrame then return end

--------------------------------------------------------------------------------
-- Extra Bar
-- Defines the RazerNaga Extra Bar object
--------------------------------------------------------------------------------

local RazerNaga = _G[...]

--------------------------------------------------------------------------------
-- Bar
--------------------------------------------------------------------------------

local ExtraBar = RazerNaga:CreateClass('Frame', RazerNaga.Frame)

function ExtraBar:New()
	local frame = RazerNaga.Frame.New(self, 'extra')

	local container = ExtraActionBarFrame

	container:ClearAllPoints()
	container:SetPoint('CENTER', frame)
	container:SetParent(frame)
	container:SetToplevel(false)

	frame.container = container

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

--------------------------------------------------------------------------------
-- Menu
--------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------
-- Module
--------------------------------------------------------------------------------

local ExtraBarModule = RazerNaga:NewModule('ExtraBar')

function ExtraBarModule:Load()
    if not self.initialized then
        self.initialized = true

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

    self.frame = ExtraBar:New()
end

function ExtraBarModule:Unload()
	self.frame:Free()
end