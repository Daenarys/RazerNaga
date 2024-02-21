local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Communities" then
		CommunitiesFrame:HookScript("OnUpdate", function(self)
			ApplyDialogBorder(CommunitiesFrame.GuildMemberDetailFrame.Border)
			ApplyDialogBorder(CommunitiesFrame.RecruitmentDialog.BG)
		end)
	end
end)