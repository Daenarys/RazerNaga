hooksecurefunc(NamePlateClassificationFrameMixin, "UpdateClassificationIndicator", function(frame)
    if (frame.classificationIndicator) then
        local classification = frame:GetClassification()
        if (classification == "rare") then
            frame.classificationIndicator:SetAtlas("nameplates-icon-elite-silver")
        end
    end
end)

local function SkinCastbar(self)
    if self:IsForbidden() then return end

    if self.Text then
        self.Text:ClearAllPoints()
        self.Text:SetPoint("CENTER")
    end

    hooksecurefunc(self, 'SetIsHighlightedCastTarget', function()
        if self.CastTargetIndicator then
            self.CastTargetIndicator:Hide()
        end
    end)
end

local function CreateBorder(frame, r, g, b, a)
    local border
    if frame.CreateTexture then
        border = frame:CreateTexture(nil, "OVERLAY", nil, -1)
    else
        border = frame:GetParent():CreateTexture(nil, "OVERLAY", nil, -1)
    end
    border:SetColorTexture(r, g, b, a)
    border:SetIgnoreParentScale(true)
    return border
end

local function SetupBorderOnFrame(frame, hpBar)
    if frame.border then
        frame.border:Hide()
    end
    if hpBar then
        frame.healthBar.barTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill")
        frame.healthBar.bgTexture:SetAlpha(0)
        frame.healthBar.selectedBorder:SetAlpha(0)
        frame.healthBar.deselectedOverlay:SetAlpha(0)
        -- frame = frame.HealthBarsContainer
        if not frame.background then
            frame.background = frame:CreateTexture(nil, "BACKGROUND")
            frame.background:SetAllPoints(frame)
            frame.background:SetColorTexture(0.2, 0.2, 0.2, 0.85)
        end
    end
    if frame.newBorder then return end
    -- Create borders
    local borderTop = CreateBorder(frame, 0, 0, 0, 1)
    local borderBottom = CreateBorder(frame, 0, 0, 0, 1)
    local borderLeft = CreateBorder(frame, 0, 0, 0, 1)
    local borderRight = CreateBorder(frame, 0, 0, 0, 1)

    -- Store borders in a table
    frame["Textures"] = {borderTop, borderBottom, borderLeft, borderRight}

    -- Initial border thickness
    local borderThickness = 1.1
    local minPixels = 1

    -- Define the SizeBorders function to use PixelUtil
    local function SizeBorders(borderThickness)
        PixelUtil.SetHeight(borderTop, borderThickness, minPixels)
        PixelUtil.SetHeight(borderBottom, borderThickness, minPixels)
        PixelUtil.SetWidth(borderLeft, borderThickness, minPixels)
        PixelUtil.SetWidth(borderRight, borderThickness, minPixels)

        -- Adjust border positions to grow outward
        borderTop:ClearAllPoints()
        PixelUtil.SetPoint(borderTop, "BOTTOMLEFT", frame, "TOPLEFT", 0, 0)
        PixelUtil.SetPoint(borderTop, "BOTTOMRIGHT", frame, "TOPRIGHT", 0, 0)

        borderBottom:ClearAllPoints()
        PixelUtil.SetPoint(borderBottom, "TOPLEFT", frame, "BOTTOMLEFT", 0, 0)
        PixelUtil.SetPoint(borderBottom, "TOPRIGHT", frame, "BOTTOMRIGHT", 0, 0)

        borderLeft:ClearAllPoints()
        PixelUtil.SetPoint(borderLeft, "TOPLEFT", frame, "TOPLEFT", -borderThickness, borderThickness)
        PixelUtil.SetPoint(borderLeft, "BOTTOMLEFT", frame, "BOTTOMLEFT", -borderThickness, -borderThickness)

        borderRight:ClearAllPoints()
        PixelUtil.SetPoint(borderRight, "TOPRIGHT", frame, "TOPRIGHT", borderThickness, borderThickness)
        PixelUtil.SetPoint(borderRight, "BOTTOMRIGHT", frame, "BOTTOMRIGHT", borderThickness, -borderThickness)
    end

    SizeBorders(borderThickness)

    hooksecurefunc(frame.healthBar, "UpdateSelectionBorder", function()
        local isTarget = frame.healthBar:IsTarget()
        local isFocus = frame.healthBar:IsFocus()

        for _, border in ipairs(frame.Textures) do
            if isTarget then
                border:SetColorTexture(1, 1, 1)
            elseif isFocus then
                border:SetColorTexture(1.0, 0.49, 0.039)
            else
                border:SetColorTexture(0, 0, 0)
            end
        end
    end)

    frame.newBorder = true
end

local function GetSafeNameplate(unit)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unit, issecure())
    -- If there's no nameplate or the nameplate doesn't have a UnitFrame, return nils.
    if not nameplate or not nameplate.UnitFrame then return nil, nil end

    local frame = nameplate.UnitFrame
    -- If none of the above conditions are met, return both the nameplate and the frame.
    return nameplate, frame
end

local function HandleNamePlateAdded(unit)
    local nameplate, frame = GetSafeNameplate(unit)
    if not frame then return end

    if frame.castBar then
        SkinCastbar(frame.castBar)
    end

    if frame.name then
        frame.name:SetIgnoreParentScale(true)
    end

    SetupBorderOnFrame(frame.HealthBarsContainer, true)

    hooksecurefunc(frame, "UpdateAnchors", function()
        frame.castBar:SetHeight(12)
        frame.castBar:ClearAllPoints()
        frame.castBar:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 26, 0)
        frame.castBar:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -26, 0)
        frame.castBar.Icon:ClearAllPoints()
        frame.castBar.Icon:SetPoint("CENTER", frame.castBar, "LEFT")
        frame.HealthBarsContainer:SetHeight(6)
        frame.name:ClearAllPoints()
        frame.name:SetPoint("BOTTOM", frame.HealthBarsContainer, "TOP", 0, 4)
        frame.name:SetJustifyH("CENTER")
    end)
end

local frameAdded = CreateFrame("Frame")
frameAdded:RegisterEvent("NAME_PLATE_UNIT_ADDED")
frameAdded:SetScript("OnEvent", function(self, event, unit)
    if C_CVar.GetCVar("nameplateStyle") == "5" then -- Legacy
        HandleNamePlateAdded(unit)
    end
end)