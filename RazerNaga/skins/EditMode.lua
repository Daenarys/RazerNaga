if not _G.EditModeManagerFrame then return end

EditModeManagerFrame.CloseButton:SetSize(32, 32)
EditModeManagerFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
EditModeManagerFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
EditModeManagerFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
EditModeManagerFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
EditModeManagerFrame.CloseButton:ClearAllPoints()
EditModeManagerFrame.CloseButton:SetPoint("TOPRIGHT", -2, -3)

EditModeManagerFrame.Tutorial.Ring:SetTexture("Interface\\AddOns\\RazerNaga\\icons\\MiniMap-TrackingBorder.png")

EditModeManagerFrame.Title:Hide()

if not EditModeManagerFrameHeader then
	EditModeManagerFrame:CreateTexture("EditModeManagerFrameHeader", "OVERLAY")
	EditModeManagerFrameHeader:SetSize(256, 64)
	EditModeManagerFrameHeader:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
	EditModeManagerFrameHeader:SetPoint("TOP", 0, 12)
end

if not EditModeManagerFrameHeaderText then
	EditModeManagerFrame:CreateFontString("EditModeManagerFrameHeaderText", "OVERLAY", "GameFontNormal")
	EditModeManagerFrameHeaderText:SetText(HUD_EDIT_MODE_TITLE)
	EditModeManagerFrameHeaderText:SetPoint("TOP", EditModeManagerFrameHeader, 0, -14)
end

ApplyDialogBorder(EditModeManagerFrame.Border)

EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar:SetSize(25, 560)
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar:ClearAllPoints()
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar:SetPoint("TOPLEFT", EditModeManagerFrame.AccountSettings.SettingsContainer, "TOPRIGHT", -24, 2)
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar:SetPoint("BOTTOMLEFT", EditModeManagerFrame.AccountSettings.SettingsContainer, "BOTTOMRIGHT", -21, -2)

if (EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Background == nil) then
	EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Background = EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar:CreateTexture(nil, "BACKGROUND");
	EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Background:SetColorTexture(0, 0, 0, .25)
	EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Background:SetAllPoints()
end

EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track:SetWidth(18)
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track:ClearAllPoints()
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track.Begin:Hide()
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track.End:Hide()
EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track.Middle:Hide()

ApplyScrollBarArrow(EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar)
ApplyScrollBarThumb(EditModeManagerFrame.AccountSettings.SettingsContainer.ScrollBar.Track.Thumb)

EditModeSystemSettingsDialog.CloseButton:SetSize(32, 32)
EditModeSystemSettingsDialog.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
EditModeSystemSettingsDialog.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
EditModeSystemSettingsDialog.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
EditModeSystemSettingsDialog.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
EditModeSystemSettingsDialog.CloseButton:ClearAllPoints()
EditModeSystemSettingsDialog.CloseButton:SetPoint("TOPRIGHT", -2, -3)

ApplyDialogBorder(EditModeSystemSettingsDialog.Border)
ApplyDialogBorder(EditModeNewLayoutDialog.Border)
ApplyDialogBorder(EditModeImportLayoutDialog.Border)