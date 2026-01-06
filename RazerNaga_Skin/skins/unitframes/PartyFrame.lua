if not _G.CompactRaidFrameManager then return end

hooksecurefunc("CompactRaidFrameManager_UpdateOptionsFlowContainer", function()
	local isLeader = UnitIsGroupLeader("player")
	local isAssist = UnitIsGroupAssistant("player")
	local isLeaderOrAssist = isLeader or isAssist

	CompactRaidFrameManager.Background:SetAlpha(0)
	CompactRaidFrameManager.toggleButtonBack:SetAlpha(0)
	CompactRaidFrameManager.toggleButtonForward:SetAlpha(0)

	if (CompactRaidFrameManager.TopLeft == nil) then
		CompactRaidFrameManager.TopLeft = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.TopLeft:SetSize(32, 32)
		CompactRaidFrameManager.TopLeft:SetTexture("Interface\\RaidFrame\\RaidPanel-UpperLeft")
		CompactRaidFrameManager.TopLeft:SetPoint("TOPLEFT", -10, 0)
	end

	if (CompactRaidFrameManager.TopRight == nil) then
		CompactRaidFrameManager.TopRight = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.TopRight:SetSize(32, 32)
		CompactRaidFrameManager.TopRight:SetTexture("Interface\\RaidFrame\\RaidPanel-UpperRight")
	end

	if (CompactRaidFrameManager.BottomLeft == nil) then
		CompactRaidFrameManager.BottomLeft = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.BottomLeft:SetSize(32, 32)
		CompactRaidFrameManager.BottomLeft:SetTexture("Interface\\RaidFrame\\RaidPanel-BottomLeft")
		CompactRaidFrameManager.BottomLeft:SetPoint("BOTTOMLEFT", -10, 0)
	end

	if (CompactRaidFrameManager.BottomRight == nil) then
		CompactRaidFrameManager.BottomRight = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.BottomRight:SetSize(32, 32)
		CompactRaidFrameManager.BottomRight:SetTexture("Interface\\RaidFrame\\RaidPanel-BottomRight")
	end

	if (CompactRaidFrameManager.Top == nil) then
		CompactRaidFrameManager.Top = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.Top:SetSize(0, 16)
		CompactRaidFrameManager.Top:SetTexture("Interface\\RaidFrame\\RaidPanel-UpperMiddle")
		CompactRaidFrameManager.Top:SetHorizTile(true)
		CompactRaidFrameManager.Top:SetPoint("TOPLEFT", CompactRaidFrameManager.TopLeft, "TOPRIGHT", 0, 1)
		CompactRaidFrameManager.Top:SetPoint("TOPRIGHT", CompactRaidFrameManager.TopRight, "TOPLEFT", 0, 1)
	end

	if (CompactRaidFrameManager.Bottom == nil) then
		CompactRaidFrameManager.Bottom = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.Bottom:SetSize(0, 16)
		CompactRaidFrameManager.Bottom:SetTexture("Interface\\RaidFrame\\RaidPanel-BottomMiddle")
		CompactRaidFrameManager.Bottom:SetHorizTile(true)
		CompactRaidFrameManager.Bottom:SetPoint("BOTTOMLEFT", CompactRaidFrameManager.BottomLeft, "BOTTOMRIGHT", 0, -4)
		CompactRaidFrameManager.Bottom:SetPoint("BOTTOMRIGHT", CompactRaidFrameManager.BottomRight, "BOTTOMLEFT", 0, -4)
	end

	if (CompactRaidFrameManager.Right == nil) then
		CompactRaidFrameManager.Right = CompactRaidFrameManager:CreateTexture(nil, "ARTWORK")
		CompactRaidFrameManager.Right:SetSize(16, 0)
		CompactRaidFrameManager.Right:SetTexture("Interface\\RaidFrame\\RaidPanel-Right")
		CompactRaidFrameManager.Right:SetVertTile(true)
		CompactRaidFrameManager.Right:SetPoint("TOPRIGHT", CompactRaidFrameManager.TopRight, "BOTTOMRIGHT", 2, 0)
		CompactRaidFrameManager.Right:SetPoint("BOTTOMRIGHT", CompactRaidFrameManager.BottomRight, "TOPRIGHT", 2, 0)
	end

	if (CompactRaidFrameManager.Bg == nil) then
		CompactRaidFrameManager.Bg = CompactRaidFrameManager:CreateTexture(nil, "BACKGROUND")
		CompactRaidFrameManager.Bg:SetTexture("Interface\\FrameGeneral\\UI-Background-Rock", true, true)
		CompactRaidFrameManager.Bg:SetPoint("TOPLEFT", CompactRaidFrameManager.TopLeft, "TOPLEFT", 7, -6)
		CompactRaidFrameManager.Bg:SetPoint("BOTTOMRIGHT", CompactRaidFrameManager.BottomRight, "BOTTOMRIGHT", -7, 7)
	end

	if (CompactRaidFrameManager.ToggleButton == nil) then
		CompactRaidFrameManager.ToggleButton = CompactRaidFrameManager:CreateTexture(nil, "OVERLAY")
		CompactRaidFrameManager.ToggleButton:SetSize(16, 64)
		CompactRaidFrameManager.ToggleButton:SetTexture("Interface\\RaidFrame\\RaidPanel-Toggle")
		CompactRaidFrameManager.ToggleButton:SetTexCoord(0, 0.5, 0, 1)
		CompactRaidFrameManager.ToggleButton:SetPoint("CENTER", CompactRaidFrameManager.toggleButtonForward, "CENTER")
	end

	if CompactRaidFrameContainer.dividerVerticalPool then
		CompactRaidFrameContainer.dividerVerticalPool:ReleaseAll()
	end

	if CompactRaidFrameContainer.dividerHorizontalPool then
		CompactRaidFrameContainer.dividerHorizontalPool:ReleaseAll()
	end

	if ( CompactRaidFrameManager.collapsed ) then
		if isLeaderOrAssist then
			CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT", -4, 0)
			CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT", -4, 162)
			CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -13, 81)
			CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -13, 81)
		else
			CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT", -4, 0)
			CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT", -4, 120)
			CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -13, 60)
			CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -13, 60)
		end
	else
		CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT")
		CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT")
		CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -9, 0)
		CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -9, 0)
	end
end)

hooksecurefunc("CompactRaidFrameManager_Toggle",function()
	local isLeader = UnitIsGroupLeader("player")
	local isAssist = UnitIsGroupAssistant("player")
	local isLeaderOrAssist = isLeader or isAssist

	if ( CompactRaidFrameManager.collapsed ) then
		if isLeaderOrAssist then
			CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT", -4, 0)
			CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT", -4, 162)
			CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -13, 81)
			CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -13, 81)
		else
			CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT", -4, 0)
			CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT", -4, 120)
			CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -13, 60)
			CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -13, 60)
		end
	else
		CompactRaidFrameManager.TopRight:SetPoint("TOPRIGHT")
		CompactRaidFrameManager.BottomRight:SetPoint("BOTTOMRIGHT")
		CompactRaidFrameManager.toggleButtonBack:SetPoint("RIGHT", -9, 0)
		CompactRaidFrameManager.toggleButtonForward:SetPoint("RIGHT", -9, 0)
	end
end)

hooksecurefunc("CompactRaidFrameManager_Expand", function()
	CompactRaidFrameManager.ToggleButton:SetTexCoord(0.5, 1, 0, 1)
end)

hooksecurefunc("CompactRaidFrameManager_Collapse", function()
	CompactRaidFrameManager.ToggleButton:SetTexCoord(0, 0.5, 0, 1)
end)