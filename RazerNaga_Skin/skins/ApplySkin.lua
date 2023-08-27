function ApplyDialogBorder(frame)
	frame.TopEdge:SetSize(32, 32)
	frame.TopEdge:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png", true)
	frame.TopEdge:SetTexCoord(0, 0.5, 0.13671875, 0.26171875)
	frame.TopEdge:ClearAllPoints()
	frame.TopEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "TOPRIGHT")
	frame.TopEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "TOPLEFT")

	frame.TopLeftCorner:SetSize(32, 32)
	frame.TopLeftCorner:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png")
	frame.TopLeftCorner:SetTexCoord(0.015625, 0.515625, 0.53515625, 0.66015625)
	frame.TopLeftCorner:ClearAllPoints()
	frame.TopLeftCorner:SetPoint("TOPLEFT")

	frame.TopRightCorner:SetSize(32, 32)
	frame.TopRightCorner:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png")
	frame.TopRightCorner:SetTexCoord(0.015625, 0.515625, 0.66796875, 0.79296875)
	frame.TopRightCorner:ClearAllPoints()
	frame.TopRightCorner:SetPoint("TOPRIGHT")

	frame.BottomEdge:SetSize(32, 32)
	frame.BottomEdge:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png", true)
	frame.BottomEdge:SetTexCoord(0, 0.5, 0.00390625, 0.12890625)
	frame.BottomEdge:ClearAllPoints()
	frame.BottomEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "BOTTOMRIGHT")
	frame.BottomEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "BOTTOMLEFT")

	frame.BottomLeftCorner:SetSize(32, 32)
	frame.BottomLeftCorner:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png")
	frame.BottomLeftCorner:SetTexCoord(0.015625, 0.515625, 0.26953125, 0.39453125)
	frame.BottomLeftCorner:ClearAllPoints()
	frame.BottomLeftCorner:SetPoint("BOTTOMLEFT")

	frame.BottomRightCorner:SetSize(32, 32)
	frame.BottomRightCorner:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetal.png")
	frame.BottomRightCorner:SetTexCoord(0.015625, 0.515625, 0.40234375, 0.52734375)
	frame.BottomRightCorner:ClearAllPoints()
	frame.BottomRightCorner:SetPoint("BOTTOMRIGHT")

	frame.LeftEdge:SetSize(32, 32)
	frame.LeftEdge:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetalVertical.png", false, true)
	frame.LeftEdge:SetTexCoord(0.0078125, 0.2578125, 0, 1)
	frame.LeftEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "BOTTOMLEFT")
	frame.LeftEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "TOPLEFT")

	frame.RightEdge:SetSize(32, 32)
	frame.RightEdge:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\UIFrameDiamondMetalVertical.png", false, true)
	frame.RightEdge:SetTexCoord(0.2734375, 0.5234375, 0, 1)
	frame.RightEdge:ClearAllPoints()
	frame.RightEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "BOTTOMRIGHT")
	frame.RightEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "TOPRIGHT")
end

function ApplyNineSliceNoPortrait(frame)
	frame.TopEdge:SetSize(128, 132)
	frame.TopEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.TopEdge:SetTexCoord(0, 1, 0.263671875, 0.521484375)
	frame.TopEdge:ClearAllPoints()
	frame.TopEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "TOPRIGHT")
	frame.TopEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "TOPLEFT")

	frame.TopLeftCorner:SetSize(132, 132)
	frame.TopLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopLeftCorner:SetTexCoord(0.525390625, 0.783203125, 0.001953125, 0.259765625)
	frame.TopLeftCorner:ClearAllPoints()
	frame.TopLeftCorner:SetPoint("TOPLEFT", -12, 16)

	frame.TopRightCorner:SetSize(132, 132)
	frame.TopRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopRightCorner:SetTexCoord(0.001953125, 0.259765625, 0.263671875, 0.521484375)
	frame.TopRightCorner:ClearAllPoints()
	frame.TopRightCorner:SetPoint("TOPRIGHT", 4, 16)

	frame.BottomEdge:SetSize(128, 132)
	frame.BottomEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.BottomEdge:SetTexCoord(0, 1, 0.001953125, 0.259765625)
	frame.BottomEdge:ClearAllPoints()
	frame.BottomEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "BOTTOMRIGHT")
	frame.BottomEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "BOTTOMLEFT")

	frame.BottomLeftCorner:SetSize(132, 132)
	frame.BottomLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomLeftCorner:SetTexCoord(0.001953125, 0.259765625, 0.001953125, 0.259765625)
	frame.BottomLeftCorner:ClearAllPoints()
	frame.BottomLeftCorner:SetPoint("BOTTOMLEFT", -12, -3)

	frame.BottomRightCorner:SetSize(132, 132)
	frame.BottomRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomRightCorner:SetTexCoord(0.263671875, 0.521484375, 0.001953125, 0.259765625)
	frame.BottomRightCorner:ClearAllPoints()
	frame.BottomRightCorner:SetPoint("BOTTOMRIGHT", 4, -3)

	frame.LeftEdge:SetSize(132, 128)
	frame.LeftEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.LeftEdge:SetTexCoord(0.001953125, 0.259765625, 0, 1)
	frame.LeftEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "BOTTOMLEFT")
	frame.LeftEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "TOPLEFT")

	frame.RightEdge:SetSize(132, 132)
	frame.RightEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.RightEdge:SetTexCoord(0.263671875, 0.521484375, 0, 1)
	frame.RightEdge:ClearAllPoints()
	frame.RightEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "BOTTOMRIGHT")
	frame.RightEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "TOPRIGHT")
end

function ApplyNineSliceNoPortraitMinimizable(frame)
	frame.TopEdge:SetSize(128, 132)
	frame.TopEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.TopEdge:SetTexCoord(0, 1, 0.263671875, 0.521484375)
	frame.TopEdge:ClearAllPoints()
	frame.TopEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "TOPRIGHT")
	frame.TopEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "TOPLEFT")

	frame.TopLeftCorner:SetSize(132, 132)
	frame.TopLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopLeftCorner:SetTexCoord(0.525390625, 0.783203125, 0.001953125, 0.259765625)
	frame.TopLeftCorner:ClearAllPoints()
	frame.TopLeftCorner:SetPoint("TOPLEFT", -12, 16)

	frame.TopRightCorner:SetSize(132, 132)
	frame.TopRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopRightCorner:SetTexCoord(0.001953125, 0.259765625, 0.525390625, 0.783203125)
	frame.TopRightCorner:ClearAllPoints()
	frame.TopRightCorner:SetPoint("TOPRIGHT", 4, 16)

	frame.BottomEdge:SetSize(128, 132)
	frame.BottomEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.BottomEdge:SetTexCoord(0, 1, 0.001953125, 0.259765625)
	frame.BottomEdge:ClearAllPoints()
	frame.BottomEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "BOTTOMRIGHT")
	frame.BottomEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "BOTTOMLEFT")

	frame.BottomLeftCorner:SetSize(132, 132)
	frame.BottomLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomLeftCorner:SetTexCoord(0.001953125, 0.259765625, 0.001953125, 0.259765625)
	frame.BottomLeftCorner:ClearAllPoints()
	frame.BottomLeftCorner:SetPoint("BOTTOMLEFT", -12, -3)

	frame.BottomRightCorner:SetSize(132, 132)
	frame.BottomRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomRightCorner:SetTexCoord(0.263671875, 0.521484375, 0.001953125, 0.259765625)
	frame.BottomRightCorner:ClearAllPoints()
	frame.BottomRightCorner:SetPoint("BOTTOMRIGHT", 4, -3)

	frame.LeftEdge:SetSize(132, 128)
	frame.LeftEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.LeftEdge:SetTexCoord(0.001953125, 0.259765625, 0, 1)
	frame.LeftEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "BOTTOMLEFT")
	frame.LeftEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "TOPLEFT")

	frame.RightEdge:SetSize(132, 132)
	frame.RightEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.RightEdge:SetTexCoord(0.263671875, 0.521484375, 0, 1)
	frame.RightEdge:ClearAllPoints()
	frame.RightEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "BOTTOMRIGHT")
	frame.RightEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "TOPRIGHT")
end

function ApplyNineSlicePortrait(frame)
	frame.TopEdge:SetSize(128, 132)
	frame.TopEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.TopEdge:SetTexCoord(0, 1, 0.263671875, 0.521484375)
	frame.TopEdge:ClearAllPoints()
	frame.TopEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "TOPRIGHT")
	frame.TopEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "TOPLEFT")

	frame.TopLeftCorner:SetSize(132, 132)
	frame.TopLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopLeftCorner:SetTexCoord(0.263671875, 0.521484375, 0.263671875, 0.521484375)
	frame.TopLeftCorner:ClearAllPoints()
	frame.TopLeftCorner:SetPoint("TOPLEFT", -13, 16)

	frame.TopRightCorner:SetSize(132, 132)
	frame.TopRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopRightCorner:SetTexCoord(0.001953125, 0.259765625, 0.263671875, 0.521484375)
	frame.TopRightCorner:ClearAllPoints()
	frame.TopRightCorner:SetPoint("TOPRIGHT", 4, 16)

	frame.BottomEdge:SetSize(128, 132)
	frame.BottomEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.BottomEdge:SetTexCoord(0, 1, 0.001953125, 0.259765625)
	frame.BottomEdge:ClearAllPoints()
	frame.BottomEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "BOTTOMRIGHT")
	frame.BottomEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "BOTTOMLEFT")

	frame.BottomLeftCorner:SetSize(132, 132)
	frame.BottomLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomLeftCorner:SetTexCoord(0.001953125, 0.259765625, 0.001953125, 0.259765625)
	frame.BottomLeftCorner:ClearAllPoints()
	frame.BottomLeftCorner:SetPoint("BOTTOMLEFT", -13, -3)

	frame.BottomRightCorner:SetSize(132, 132)
	frame.BottomRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomRightCorner:SetTexCoord(0.263671875, 0.521484375, 0.001953125, 0.259765625)
	frame.BottomRightCorner:ClearAllPoints()
	frame.BottomRightCorner:SetPoint("BOTTOMRIGHT", 4, -3)

	frame.LeftEdge:SetSize(132, 128)
	frame.LeftEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.LeftEdge:SetTexCoord(0.001953125, 0.259765625, 0, 1)
	frame.LeftEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "BOTTOMLEFT")
	frame.LeftEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "TOPLEFT")

	frame.RightEdge:SetSize(132, 132)
	frame.RightEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.RightEdge:SetTexCoord(0.263671875, 0.521484375, 0, 1)
	frame.RightEdge:ClearAllPoints()
	frame.RightEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "BOTTOMRIGHT")
	frame.RightEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "TOPRIGHT")
end

function ApplyNineSlicePortraitMinimizable(frame)
	frame.TopEdge:SetSize(128, 132)
	frame.TopEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.TopEdge:SetTexCoord(0, 1, 0.263671875, 0.521484375)
	frame.TopEdge:ClearAllPoints()
	frame.TopEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "TOPRIGHT")
	frame.TopEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "TOPLEFT")

	frame.TopLeftCorner:SetSize(132, 132)
	frame.TopLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopLeftCorner:SetTexCoord(0.263671875, 0.521484375, 0.263671875, 0.521484375)
	frame.TopLeftCorner:ClearAllPoints()
	frame.TopLeftCorner:SetPoint("TOPLEFT", -13, 16)

	frame.TopRightCorner:SetSize(132, 132)
	frame.TopRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.TopRightCorner:SetTexCoord(0.001953125, 0.259765625, 0.525390625, 0.783203125)
	frame.TopRightCorner:ClearAllPoints()
	frame.TopRightCorner:SetPoint("TOPRIGHT", 4, 16)

	frame.BottomEdge:SetSize(128, 132)
	frame.BottomEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalHorizontal", true)
	frame.BottomEdge:SetTexCoord(0, 1, 0.001953125, 0.259765625)
	frame.BottomEdge:ClearAllPoints()
	frame.BottomEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "BOTTOMRIGHT")
	frame.BottomEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "BOTTOMLEFT")

	frame.BottomLeftCorner:SetSize(132, 132)
	frame.BottomLeftCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomLeftCorner:SetTexCoord(0.001953125, 0.259765625, 0.001953125, 0.259765625)
	frame.BottomLeftCorner:ClearAllPoints()
	frame.BottomLeftCorner:SetPoint("BOTTOMLEFT", -13, -3)

	frame.BottomRightCorner:SetSize(132, 132)
	frame.BottomRightCorner:SetTexture("Interface\\FrameGeneral\\UIFrameMetal")
	frame.BottomRightCorner:SetTexCoord(0.263671875, 0.521484375, 0.001953125, 0.259765625)
	frame.BottomRightCorner:ClearAllPoints()
	frame.BottomRightCorner:SetPoint("BOTTOMRIGHT", 4, -3)

	frame.LeftEdge:SetSize(132, 128)
	frame.LeftEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.LeftEdge:SetTexCoord(0.001953125, 0.259765625, 0, 1)
	frame.LeftEdge:SetPoint("TOPLEFT", frame.TopLeftCorner, "BOTTOMLEFT")
	frame.LeftEdge:SetPoint("BOTTOMLEFT", frame.BottomLeftCorner, "TOPLEFT")

	frame.RightEdge:SetSize(132, 132)
	frame.RightEdge:SetTexture("Interface\\FrameGeneral\\UIFrameMetalVertical", false, true)
	frame.RightEdge:SetTexCoord(0.263671875, 0.521484375, 0, 1)
	frame.RightEdge:ClearAllPoints()
	frame.RightEdge:SetPoint("TOPRIGHT", frame.TopRightCorner, "BOTTOMRIGHT")
	frame.RightEdge:SetPoint("BOTTOMRIGHT", frame.BottomRightCorner, "TOPRIGHT")
end

function ApplyScrollBarArrow(frame)
	frame.Back:SetSize(18, 16)
	frame.Back:SetNormalAtlas("UI-ScrollBar-ScrollUpButton-Up")
	frame.Back:SetPushedAtlas("UI-ScrollBar-ScrollUpButton-Down")
	frame.Back:SetDisabledAtlas("UI-ScrollBar-ScrollUpButton-Disabled")
	frame.Back:SetHighlightAtlas("UI-ScrollBar-ScrollUpButton-Highlight")
	frame.Back:ClearAllPoints()
	frame.Back:SetPoint("TOPLEFT", 4, -4)

	frame.Forward:SetSize(18, 16)
	frame.Forward:SetNormalAtlas("UI-ScrollBar-ScrollDownButton-Up")
	frame.Forward:SetPushedAtlas("UI-ScrollBar-ScrollDownButton-Down")
	frame.Forward:SetDisabledAtlas("UI-ScrollBar-ScrollDownButton-Disabled")
	frame.Forward:SetHighlightAtlas("UI-ScrollBar-ScrollDownButton-Highlight")
	frame.Forward:SetPoint("BOTTOMLEFT", 4, 4)
end

function ApplyScrollBarTrack(frame)
	frame:SetWidth(18)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", 4, -22)
	frame:SetPoint("BOTTOMRIGHT", -4, 22)
	
	frame.Begin:SetAtlas("UI-ScrollBar-EndCap-Top", true)
	frame.Begin:ClearAllPoints()
	frame.Begin:SetPoint("TOPLEFT", -4, 22)

	frame.End:SetAtlas("UI-ScrollBar-EndCap-Bottom", true)
	frame.End:ClearAllPoints()
	frame.End:SetPoint("BOTTOMLEFT", -4, -22)

	frame.Middle:SetAtlas("!UI-ScrollBar-Center", true)
	frame.Middle:ClearAllPoints()
	frame.Middle:SetPoint("TOPLEFT", frame.Begin, "BOTTOMLEFT")
	frame.Middle:SetPoint("BOTTOMRIGHT", frame.End, "TOPRIGHT")
end

function ApplyScrollBarThumb(frame)
	frame:SetWidth(18)
	frame.Begin:SetAtlas("UI-ScrollBar-Knob-EndCap-Top")
	frame.End:SetAtlas("UI-ScrollBar-Knob-EndCap-Bottom")
	frame.Middle:SetAtlas("UI-ScrollBar-Knob-Center")
	frame.upBeginTexture = "UI-ScrollBar-Knob-EndCap-Top"
	frame.upMiddleTexture = "UI-ScrollBar-Knob-Center"
	frame.upEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom"
	frame.overBeginTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Top"
	frame.overMiddleTexture = "UI-ScrollBar-Knob-MouseOver-Center"
	frame.overEndTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Bottom"
	frame.downBeginTexture = "UI-ScrollBar-Knob-EndCap-Top-Disabled"
	frame.downMiddleTexture = "UI-ScrollBar-Knob-Center-Disabled"
	frame.downEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom-Disabled"
	frame.Middle:ClearAllPoints()
	frame.Middle:SetPoint("TOPLEFT", 0, -5)
	frame.Middle:SetPoint("BOTTOMRIGHT", 0, 5)
end

function ApplyBottomTab(frame)
	frame.LeftActive:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	frame.LeftActive:SetTexCoord(0, 0.15625, 0, 0.546875)
	frame.LeftActive:SetSize(20, 35)
	frame.LeftActive:SetPoint("TOPLEFT")

	frame.RightActive:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	frame.RightActive:SetTexCoord(0.84375, 1, 0, 0.546875)
	frame.RightActive:SetSize(20, 35)
	frame.RightActive:SetPoint("TOPRIGHT")

	frame.MiddleActive:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab")
	frame.MiddleActive:SetTexCoord(0.15625, 0.84375, 0, 0.546875)
	frame.MiddleActive:SetSize(88, 35)
	frame.MiddleActive:SetHorizTile(false)

	frame.Left:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	frame.Left:SetTexCoord(0, 0.15625, 0, 1)
	frame.Left:SetSize(20, 32)
	frame.Left:SetPoint("TOPLEFT", 0, -1)

	frame.Right:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	frame.Right:SetTexCoord(0.84375, 1, 0, 1)
	frame.Right:SetSize(20, 32)
	frame.Right:SetPoint("TOPRIGHT", 0, -1)

	frame.Middle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InActiveTab")
	frame.Middle:SetTexCoord(0.15625, 0.84375, 0, 1)
	frame.Middle:SetSize(88, 32)
	frame.Middle:SetHorizTile(false)

	frame.LeftHighlight:Hide()
	frame.MiddleHighlight:Hide()
	frame.RightHighlight:Hide()

	frame:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-RealHighlight")
	frame:GetHighlightTexture():ClearAllPoints()
	frame:GetHighlightTexture():SetPoint("TOPLEFT", 3, 5)
	frame:GetHighlightTexture():SetPoint("BOTTOMRIGHT", -3, 0)
end

function ApplyTopTab(frame)
	frame.LeftActive:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Active")
	frame.LeftActive:SetTexCoord(0, 0.25, 0, 1)
	frame.LeftActive:SetSize(16, 32)
	frame.LeftActive:SetPoint("BOTTOMLEFT")

	frame.RightActive:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Active")
	frame.RightActive:SetTexCoord(0.75, 1, 0, 1)
	frame.RightActive:SetSize(16, 32)
	frame.RightActive:SetPoint("BOTTOMRIGHT")

	frame.MiddleActive:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Active")
	frame.MiddleActive:SetTexCoord(0.25, 0.75, 0, 1)
	frame.MiddleActive:SetSize(32, 32)
	frame.MiddleActive:SetHorizTile(false)

	frame.Left:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Inactive")
	frame.Left:SetTexCoord(0, 0.25, 0, 1)
	frame.Left:SetSize(16, 32)
	frame.Left:SetPoint("BOTTOMLEFT")

	frame.Right:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Inactive")
	frame.Right:SetTexCoord(0.75, 1, 0, 1)
	frame.Right:SetSize(16, 32)
	frame.Right:SetPoint("TOPRIGHT")

	frame.Middle:SetTexture("Interface\\HelpFrame\\HelpFrameTab-Inactive")
	frame.Middle:SetTexCoord(0.25, 0.75, 0, 1)
	frame.Middle:SetSize(32, 32)
	frame.Middle:SetHorizTile(false)

	frame.LeftHighlight:Hide()
	frame.MiddleHighlight:Hide()
	frame.RightHighlight:Hide()

	frame:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
	frame:GetHighlightTexture():ClearAllPoints()
	frame:GetHighlightTexture():SetPoint("TOPLEFT", 2, -8)
	frame:GetHighlightTexture():SetPoint("BOTTOMRIGHT", 2, -8)
end