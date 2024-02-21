if not _G.QuestFrame then return end

hooksecurefunc(_G.QuestSessionManager, 'NotifyDialogShow', function(_, dialog)
	if dialog.isSkinned then return end

	ApplyDialogBorder(dialog.Border)

	dialog.isSkinned = true
end)