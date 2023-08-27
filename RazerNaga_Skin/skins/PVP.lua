local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PVPUI" then
		HonorFrame.SpecificScrollBar:SetSize(25, 560)
		HonorFrame.SpecificScrollBar:ClearAllPoints()
		HonorFrame.SpecificScrollBar:SetPoint("TOPLEFT", HonorFrame.SpecificScrollBox, "TOPRIGHT", -2, 3)
		HonorFrame.SpecificScrollBar:SetPoint("BOTTOMLEFT", HonorFrame.SpecificScrollBox, "BOTTOMRIGHT", 1, -1)

		ApplyScrollBarArrow(HonorFrame.SpecificScrollBar)
		ApplyScrollBarTrack(HonorFrame.SpecificScrollBar.Track)
		ApplyScrollBarThumb(HonorFrame.SpecificScrollBar.Track.Thumb)

		for _, roleButton in pairs({
			_G.HonorFrame.HealerIcon,
			_G.HonorFrame.TankIcon,
			_G.HonorFrame.DPSIcon,
			_G.ConquestFrame.DPSIcon,
			_G.ConquestFrame.HealerIcon,
			_G.ConquestFrame.TankIcon,
		}) do
			local checkButton = roleButton.checkButton or roleButton.CheckButton

			checkButton:SetSize(24, 24)
			checkButton:SetScale(1)
			checkButton:ClearAllPoints()
			checkButton:SetPoint("BOTTOMLEFT", -5, -5)
			checkButton:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
			checkButton:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
			checkButton:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
			checkButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			checkButton:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		end
	end
end)

PVPReadyDialogRoleIcon.texture:SetTexture("Interface\\LFGFrame\\UI-LFG-ICONS-ROLEBACKGROUNDS")

hooksecurefunc('PVPReadyDialog_Display', function(self, _, _, _, queueType, _, role)
	if role == 'DAMAGER' then
		_G.PVPReadyDialogRoleIcon.texture:SetTexCoord(GetTexCoordsForRole("DAMAGER"))
	elseif role == 'TANK' then
		_G.PVPReadyDialogRoleIcon.texture:SetTexCoord(GetTexCoordsForRole("TANK"))
	elseif role == 'HEALER' then
		_G.PVPReadyDialogRoleIcon.texture:SetTexCoord(GetTexCoordsForRole("HEALER"))
	end
end)