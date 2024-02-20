local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Communities" then
		CommunitiesFrame:HookScript("OnUpdate", function(self)
			local displayMode = self:GetDisplayMode();
			if displayMode == COMMUNITIES_FRAME_DISPLAY_MODES.MINIMIZED then
				CommunitiesFrame.Chat.ScrollBar:SetSize(25, 560)
				CommunitiesFrame.Chat.ScrollBar:ClearAllPoints()
				CommunitiesFrame.Chat.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrame.Chat.MessageFrame, "TOPRIGHT", 5, 5)
				CommunitiesFrame.Chat.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.Chat.MessageFrame, "BOTTOMRIGHT", 2, -9)

				ApplyScrollBarArrow(CommunitiesFrame.Chat.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrame.Chat.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrame.Chat.ScrollBar.Track.Thumb)
			else
				CommunitiesFrameCommunitiesList.ScrollBar:SetSize(25, 560)
				CommunitiesFrameCommunitiesList.ScrollBar:ClearAllPoints()
				CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "TOPRIGHT", -2, 0)
				CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "BOTTOMRIGHT", 1, -5)

				if (CommunitiesFrameCommunitiesList.ScrollBar.BG == nil) then
					CommunitiesFrameCommunitiesList.ScrollBar.BG = CommunitiesFrameCommunitiesList.ScrollBar:CreateTexture(nil, "BACKGROUND");
					CommunitiesFrameCommunitiesList.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
					CommunitiesFrameCommunitiesList.ScrollBar.BG:SetAllPoints()
				end

				ApplyScrollBarArrow(CommunitiesFrameCommunitiesList.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrameCommunitiesList.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrameCommunitiesList.ScrollBar.Track.Thumb)

				CommunitiesFrame.Chat.ScrollBar:SetSize(25, 560)
				CommunitiesFrame.Chat.ScrollBar:ClearAllPoints()
				CommunitiesFrame.Chat.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrame.Chat.MessageFrame, "TOPRIGHT", 8, 5)
				CommunitiesFrame.Chat.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.Chat.MessageFrame, "BOTTOMRIGHT", 8, -30)

				ApplyScrollBarArrow(CommunitiesFrame.Chat.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrame.Chat.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrame.Chat.ScrollBar.Track.Thumb)

				CommunitiesFrame.MemberList.ScrollBar:SetSize(25, 560)
				CommunitiesFrame.MemberList.ScrollBar:ClearAllPoints()
				CommunitiesFrame.MemberList.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrame.MemberList, "TOPRIGHT", -3, 3)
				CommunitiesFrame.MemberList.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.MemberList, "BOTTOMRIGHT", 0, -2)

				ApplyScrollBarArrow(CommunitiesFrame.MemberList.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrame.MemberList.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrame.MemberList.ScrollBar.Track.Thumb)

				CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar:SetSize(25, 560)
				CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar:ClearAllPoints()
				CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrame.GuildBenefitsFrame.Rewards, "TOPRIGHT", -2, 3)
				CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.GuildBenefitsFrame.Rewards, "BOTTOMRIGHT", 1, -4)

				ApplyScrollBarArrow(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrame.GuildBenefitsFrame.Rewards.ScrollBar.Track.Thumb)

				CommunitiesFrameGuildDetailsFrameNews.ScrollBar:SetSize(25, 560)
				CommunitiesFrameGuildDetailsFrameNews.ScrollBar:ClearAllPoints()
				CommunitiesFrameGuildDetailsFrameNews.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrameGuildDetailsFrameNews, "TOPRIGHT", -13, 3)
				CommunitiesFrameGuildDetailsFrameNews.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameGuildDetailsFrameNews, "BOTTOMRIGHT", -10, -4)

				ApplyScrollBarArrow(CommunitiesFrameGuildDetailsFrameNews.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrameGuildDetailsFrameNews.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrameGuildDetailsFrameNews.ScrollBar.Track.Thumb)

				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar:SetSize(25, 560)
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar:ClearAllPoints()
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", CommunitiesGuildLogFrame.Container.ScrollFrame, "TOPRIGHT", -1, 2)
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesGuildLogFrame.Container.ScrollFrame, "BOTTOMRIGHT", 2, -4)

				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track:SetWidth(18)
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track:ClearAllPoints()
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track.Begin:Hide()
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track.End:Hide()
				CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track.Middle:Hide()

				ApplyScrollBarArrow(CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar)
				ApplyScrollBarThumb(CommunitiesGuildLogFrame.Container.ScrollFrame.ScrollBar.Track.Thumb)

				ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar:SetSize(25, 560)
				ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar:ClearAllPoints()
				ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar:SetPoint("TOPLEFT", ClubFinderCommunityAndGuildFinderFrame.CommunityCards, "TOPRIGHT", -20, 3)
				ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar:SetPoint("BOTTOMLEFT", ClubFinderCommunityAndGuildFinderFrame.CommunityCards, "BOTTOMRIGHT", -17, -3)

				ApplyScrollBarArrow(ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar)
				ApplyScrollBarTrack(ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar.Track)
				ApplyScrollBarThumb(ClubFinderCommunityAndGuildFinderFrame.CommunityCards.ScrollBar.Track.Thumb)

				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar:SetSize(25, 560)
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar:ClearAllPoints()
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", CommunitiesGuildTextEditFrame.Container.ScrollFrame, "TOPRIGHT", -1, 2)
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesGuildTextEditFrame.Container.ScrollFrame, "BOTTOMRIGHT", 2, -4)

				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track:SetWidth(18)
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track:ClearAllPoints()
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track.Begin:Hide()
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track.End:Hide()
				CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track.Middle:Hide()

				ApplyScrollBarArrow(CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar)
				ApplyScrollBarThumb(CommunitiesGuildTextEditFrame.Container.ScrollFrame.ScrollBar.Track.Thumb)

				ApplyDialogBorder(CommunitiesFrame.GuildMemberDetailFrame.Border)
				ApplyDialogBorder(CommunitiesFrame.RecruitmentDialog.BG)
			end
		end)
	end
end)