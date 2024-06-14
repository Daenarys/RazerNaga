if not _G.EditModeManagerFrame then return end

EditModeImportLayoutDialog.ImportBox.ScrollBar:SetWidth(20)
EditModeImportLayoutDialog.ImportBox.ScrollBar:ClearAllPoints()
EditModeImportLayoutDialog.ImportBox.ScrollBar:SetPoint("TOPLEFT", EditModeImportLayoutDialog.ImportBox, "TOPRIGHT", -16, 1)
EditModeImportLayoutDialog.ImportBox.ScrollBar:SetPoint("BOTTOMLEFT", EditModeImportLayoutDialog.ImportBox, "BOTTOMRIGHT", -16, -2)

EditModeImportLayoutDialog.ImportBox.ScrollBar.Track.Begin:Hide()
EditModeImportLayoutDialog.ImportBox.ScrollBar.Track.End:Hide()
EditModeImportLayoutDialog.ImportBox.ScrollBar.Track.Middle:Hide()

ApplyScrollBarThumb(EditModeImportLayoutDialog.ImportBox.ScrollBar.Track.Thumb)

EditModeImportLayoutDialog.ImportBox.ScrollBar.Back:SetSize(18, 16)
EditModeImportLayoutDialog.ImportBox.ScrollBar.Back:SetNormalAtlas("UI-ScrollBar-ScrollUpButton-Up")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Back:SetPushedAtlas("UI-ScrollBar-ScrollUpButton-Down")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Back:SetDisabledAtlas("UI-ScrollBar-ScrollUpButton-Disabled")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Back:SetHighlightAtlas("UI-ScrollBar-ScrollUpButton-Highlight")

EditModeImportLayoutDialog.ImportBox.ScrollBar.Forward:SetSize(18, 16)
EditModeImportLayoutDialog.ImportBox.ScrollBar.Forward:SetNormalAtlas("UI-ScrollBar-ScrollDownButton-Up")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Forward:SetPushedAtlas("UI-ScrollBar-ScrollDownButton-Down")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Forward:SetDisabledAtlas("UI-ScrollBar-ScrollDownButton-Disabled")
EditModeImportLayoutDialog.ImportBox.ScrollBar.Forward:SetHighlightAtlas("UI-ScrollBar-ScrollDownButton-Highlight")