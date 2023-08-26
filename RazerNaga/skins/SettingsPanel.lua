if not _G.SettingsPanel then return end

SettingsPanel.ClosePanelButton:Hide()

SettingsPanel.Bg:ClearAllPoints()
SettingsPanel.Bg:SetPoint("TOPLEFT", 12, -12)
SettingsPanel.Bg:SetPoint("BOTTOMRIGHT", -12, 12)

if not SettingsPanelHeader then
	SettingsPanel:CreateTexture("SettingsPanelHeader", "OVERLAY")
	SettingsPanelHeader:SetSize(256, 64)
	SettingsPanelHeader:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	SettingsPanelHeader:SetPoint("TOP", 0, 12)
end

SettingsPanel.NineSlice.Text:ClearAllPoints()
SettingsPanel.NineSlice.Text:SetPoint("CENTER", SettingsPanelHeader, "CENTER", 0, 12)

ApplyDialogBorder(SettingsPanel.NineSlice)

SettingsPanel.Container.SettingsList.ScrollBar:SetSize(25, 560)
SettingsPanel.Container.SettingsList.ScrollBar:ClearAllPoints()
SettingsPanel.Container.SettingsList.ScrollBar:SetPoint("TOPLEFT", SettingsPanel.Container.SettingsList.ScrollBox, "TOPRIGHT", -4, 2)
SettingsPanel.Container.SettingsList.ScrollBar:SetPoint("BOTTOMLEFT", SettingsPanel.Container.SettingsList.ScrollBox, "BOTTOMRIGHT", -1, 0)

if (SettingsPanel.Container.SettingsList.ScrollBar.Background == nil) then
	SettingsPanel.Container.SettingsList.ScrollBar.Background = SettingsPanel.Container.SettingsList.ScrollBar:CreateTexture(nil, "BACKGROUND");
	SettingsPanel.Container.SettingsList.ScrollBar.Background:SetColorTexture(0, 0, 0, .25)
	SettingsPanel.Container.SettingsList.ScrollBar.Background:SetAllPoints()
end

SettingsPanel.Container.SettingsList.ScrollBar.Track:SetWidth(18)
SettingsPanel.Container.SettingsList.ScrollBar.Track:ClearAllPoints()
SettingsPanel.Container.SettingsList.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
SettingsPanel.Container.SettingsList.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

SettingsPanel.Container.SettingsList.ScrollBar.Track.Begin:Hide()
SettingsPanel.Container.SettingsList.ScrollBar.Track.End:Hide()
SettingsPanel.Container.SettingsList.ScrollBar.Track.Middle:Hide()

ApplyScrollBarArrow(SettingsPanel.Container.SettingsList.ScrollBar)
ApplyScrollBarThumb(SettingsPanel.Container.SettingsList.ScrollBar.Track.Thumb)

hooksecurefunc(SettingsPanel.Container.SettingsList.ScrollBox, 'Update', function(frame)
	for _, child in next, { frame.ScrollTarget:GetChildren() } do
		if child.CheckBox then
			child.CheckBox:SetNormalTexture("Interface\\Buttons\\UI-CheckBox-Up")
			child.CheckBox:SetPushedTexture("Interface\\Buttons\\UI-CheckBox-Down")
			child.CheckBox:SetHighlightTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
			child.CheckBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check")
			child.CheckBox:SetDisabledCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check-Disabled")
		end
	end
end)

_G.SettingsPanel:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 5)
end)