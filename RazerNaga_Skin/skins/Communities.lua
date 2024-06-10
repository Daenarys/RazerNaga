if not _G.CommunitiesFrame then return end

CommunitiesFrame:HookScript("OnUpdate", function(self)
	local displayMode = self:GetDisplayMode()
	if displayMode == COMMUNITIES_FRAME_DISPLAY_MODES.MINIMIZED then
		self.Chat.ScrollBar:SetSize(25, 560)
		self.Chat.ScrollBar:ClearAllPoints()
		self.Chat.ScrollBar:SetPoint("TOPLEFT", self.Chat.MessageFrame, "TOPRIGHT", 5, 5)
		self.Chat.ScrollBar:SetPoint("BOTTOMLEFT", self.Chat.MessageFrame, "BOTTOMRIGHT", 2, -9)

		ApplyScrollBarArrow(self.Chat.ScrollBar)
		ApplyScrollBarTrack(self.Chat.ScrollBar.Track)
		ApplyScrollBarThumb(self.Chat.ScrollBar.Track.Thumb)
	else
		CommunitiesFrameCommunitiesList.ScrollBar:SetSize(25, 560)
		CommunitiesFrameCommunitiesList.ScrollBar:ClearAllPoints()
		CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "TOPRIGHT", -2, 0)
		CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "BOTTOMRIGHT", 1, -5)

		if (CommunitiesFrameCommunitiesList.ScrollBar.Backplate == nil) then
			CommunitiesFrameCommunitiesList.ScrollBar.Backplate = CommunitiesFrameCommunitiesList.ScrollBar:CreateTexture(nil, "BACKGROUND")
			CommunitiesFrameCommunitiesList.ScrollBar.Backplate:SetColorTexture(0, 0, 0, 1)
			CommunitiesFrameCommunitiesList.ScrollBar.Backplate:SetAllPoints()
		end

		ApplyScrollBarArrow(CommunitiesFrameCommunitiesList.ScrollBar)
		ApplyScrollBarTrack(CommunitiesFrameCommunitiesList.ScrollBar.Track)
		ApplyScrollBarThumb(CommunitiesFrameCommunitiesList.ScrollBar.Track.Thumb)

		self.Chat.ScrollBar:SetSize(25, 560)
		self.Chat.ScrollBar:ClearAllPoints()
		self.Chat.ScrollBar:SetPoint("TOPLEFT", self.Chat.MessageFrame, "TOPRIGHT", 8, 5)
		self.Chat.ScrollBar:SetPoint("BOTTOMLEFT", self.Chat.MessageFrame, "BOTTOMRIGHT", 8, -30)

		ApplyScrollBarArrow(self.Chat.ScrollBar)
		ApplyScrollBarTrack(self.Chat.ScrollBar.Track)
		ApplyScrollBarThumb(self.Chat.ScrollBar.Track.Thumb)

		self.MemberList.ScrollBar:SetSize(25, 560)
		self.MemberList.ScrollBar:ClearAllPoints()
		self.MemberList.ScrollBar:SetPoint("TOPLEFT", self.MemberList, "TOPRIGHT", -3, 3)
		self.MemberList.ScrollBar:SetPoint("BOTTOMLEFT", self.MemberList, "BOTTOMRIGHT", 0, -2)

		ApplyScrollBarArrow(self.MemberList.ScrollBar)
		ApplyScrollBarTrack(self.MemberList.ScrollBar.Track)
		ApplyScrollBarThumb(self.MemberList.ScrollBar.Track.Thumb)

		self.GuildBenefitsFrame.Rewards.ScrollBar:SetSize(25, 560)
		self.GuildBenefitsFrame.Rewards.ScrollBar:ClearAllPoints()
		self.GuildBenefitsFrame.Rewards.ScrollBar:SetPoint("TOPLEFT", self.GuildBenefitsFrame.Rewards, "TOPRIGHT", -2, 3)
		self.GuildBenefitsFrame.Rewards.ScrollBar:SetPoint("BOTTOMLEFT", self.GuildBenefitsFrame.Rewards, "BOTTOMRIGHT", 1, -4)

		ApplyScrollBarArrow(self.GuildBenefitsFrame.Rewards.ScrollBar)
		ApplyScrollBarTrack(self.GuildBenefitsFrame.Rewards.ScrollBar.Track)
		ApplyScrollBarThumb(self.GuildBenefitsFrame.Rewards.ScrollBar.Track.Thumb)

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
	end
end)

ApplyDropDown(ClubFinderGuildFinderFrame.OptionsList.ClubFilterDropdown)
ApplyDropDown(ClubFinderGuildFinderFrame.OptionsList.ClubSizeDropdown)
ApplyDropDown(ClubFinderCommunityAndGuildFinderFrame.OptionsList.ClubFilterDropdown)
ApplyDropDown(ClubFinderCommunityAndGuildFinderFrame.OptionsList.SortByDropdown)