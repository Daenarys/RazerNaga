local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Communities" then
		CommunitiesFrame:HookScript("OnUpdate", function(self)
			local displayMode = self:GetDisplayMode();
			if displayMode == COMMUNITIES_FRAME_DISPLAY_MODES.MINIMIZED then
				CommunitiesFrameCloseButton:SetSize(32, 32)
				CommunitiesFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
				CommunitiesFrameCloseButton:ClearAllPoints()
				CommunitiesFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
				CommunitiesFrameCloseButton:SetFrameLevel(2)

				self.MaxMinButtonFrame:SetSize(32, 32)
				self.MaxMinButtonFrame:ClearAllPoints()
				self.MaxMinButtonFrame:SetPoint("RIGHT", CommunitiesFrameCloseButton, "LEFT", 8.5, 0)
				self.MaxMinButtonFrame:SetFrameLevel(2)

				self.MaxMinButtonFrame.MaximizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Up")
				self.MaxMinButtonFrame.MaximizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Down")
				self.MaxMinButtonFrame.MaximizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Disabled")
				self.MaxMinButtonFrame.MaximizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

				self.MaxMinButtonFrame.MinimizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Up")
				self.MaxMinButtonFrame.MinimizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Down")
				self.MaxMinButtonFrame.MinimizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Disabled")
				self.MaxMinButtonFrame.MinimizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

				self.TitleContainer:ClearAllPoints()
				self.TitleContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 58, 0)
				self.TitleContainer:SetPoint("TOPRIGHT", self, "TOPRIGHT", -58, 0)

				self:CreateTexture("CommunitiesFrameMinTitleBg")
				self.TitleBg = CommunitiesFrameMinTitleBg
				self.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
				self.TitleBg:SetSize(256, 18)
				self.TitleBg:SetHorizTile(true)
				self.TitleBg:ClearAllPoints()
				self.TitleBg:SetPoint("TOPLEFT", 2, -3)
				self.TitleBg:SetPoint("TOPRIGHT", -25, -3)

				self.TopTileStreaks:ClearAllPoints()
				self.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
				self.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

				ApplyNineSliceNoPortraitMinimizable(self.NineSlice)

				CommunitiesFrame.Chat.ScrollBar:SetSize(25, 560)
				CommunitiesFrame.Chat.ScrollBar:ClearAllPoints()
				CommunitiesFrame.Chat.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrame.Chat.MessageFrame, "TOPRIGHT", 5, 5)
				CommunitiesFrame.Chat.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrame.Chat.MessageFrame, "BOTTOMRIGHT", 2, -9)

				ApplyScrollBarArrow(CommunitiesFrame.Chat.ScrollBar)
				ApplyScrollBarTrack(CommunitiesFrame.Chat.ScrollBar.Track)
				ApplyScrollBarThumb(CommunitiesFrame.Chat.ScrollBar.Track.Thumb)
			else
				CommunitiesFrameCloseButton:SetSize(32, 32)
				CommunitiesFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
				CommunitiesFrameCloseButton:ClearAllPoints()
				CommunitiesFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
				CommunitiesFrameCloseButton:SetFrameLevel(2)

				CommunitiesGuildLogFrameCloseButton:SetSize(32, 32)
				CommunitiesGuildLogFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesGuildLogFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesGuildLogFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesGuildLogFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
				CommunitiesGuildLogFrameCloseButton:ClearAllPoints()
				CommunitiesGuildLogFrameCloseButton:SetPoint("TOPRIGHT", -2, -2)

				GuildControlUICloseButton:SetSize(32, 32)
				GuildControlUICloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				GuildControlUICloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				GuildControlUICloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				GuildControlUICloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
				GuildControlUICloseButton:ClearAllPoints()
				GuildControlUICloseButton:SetPoint("TOPRIGHT", -2, -2)

				self.MaxMinButtonFrame:SetSize(32, 32)
				self.MaxMinButtonFrame:ClearAllPoints()
				self.MaxMinButtonFrame:SetPoint("RIGHT", CommunitiesFrameCloseButton, "LEFT", 8.5, 0)
				self.MaxMinButtonFrame:SetFrameLevel(2)

				self.MaxMinButtonFrame.MaximizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Up")
				self.MaxMinButtonFrame.MaximizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Down")
				self.MaxMinButtonFrame.MaximizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-BiggerButton-Disabled")
				self.MaxMinButtonFrame.MaximizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

				self.MaxMinButtonFrame.MinimizeButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Up")
				self.MaxMinButtonFrame.MinimizeButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Down")
				self.MaxMinButtonFrame.MinimizeButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-SmallerButton-Disabled")
				self.MaxMinButtonFrame.MinimizeButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
				
				self.PortraitContainer.CircleMask:Hide()

				CommunitiesFramePortrait:SetSize(61, 61)
				CommunitiesFramePortrait:ClearAllPoints()
				CommunitiesFramePortrait:SetPoint("TOPLEFT", -6, 8)

				self.TitleContainer:ClearAllPoints()
				self.TitleContainer:SetPoint("TOPLEFT", self, "TOPLEFT", 58, 0)
				self.TitleContainer:SetPoint("TOPRIGHT", self, "TOPRIGHT", -58, 0)

				self:CreateTexture("CommunitiesFrameMaxTitleBg")
				self.TitleBg = CommunitiesFrameMaxTitleBg
				self.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
				self.TitleBg:SetSize(256, 18)
				self.TitleBg:SetHorizTile(true)
				self.TitleBg:ClearAllPoints()
				self.TitleBg:SetPoint("TOPLEFT", 2, -3)
				self.TitleBg:SetPoint("TOPRIGHT", -25, -3)

				self.TopTileStreaks:ClearAllPoints()
				self.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
				self.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

				ApplyNineSlicePortraitMinimizable(self.NineSlice)
				
				CommunitiesFrameCommunitiesList.ScrollBar:SetSize(25, 560)
				CommunitiesFrameCommunitiesList.ScrollBar:ClearAllPoints()
				CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("TOPLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "TOPRIGHT", -2, -38)
				CommunitiesFrameCommunitiesList.ScrollBar:SetPoint("BOTTOMLEFT", CommunitiesFrameCommunitiesList.ScrollBox, "BOTTOMRIGHT", 1, -5)

				if (CommunitiesFrameCommunitiesList.ScrollBar.Background == nil) then
					CommunitiesFrameCommunitiesList.ScrollBar.Background = CommunitiesFrameCommunitiesList.ScrollBar:CreateTexture(nil, "BACKGROUND");
					CommunitiesFrameCommunitiesList.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
					CommunitiesFrameCommunitiesList.ScrollBar.Background:SetAllPoints()
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

				CommunitiesGuildTextEditFrameCloseButton:SetSize(32, 32)
				CommunitiesGuildTextEditFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesGuildTextEditFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesGuildTextEditFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesGuildTextEditFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

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
			
				ClubFinderGuildFinderFrame.OptionsList.TankRoleFrame.Icon:SetAtlas("UI-Frame-TankIcon", true)
				ClubFinderGuildFinderFrame.OptionsList.HealerRoleFrame.Icon:SetAtlas("UI-Frame-HealerIcon", true)
				ClubFinderGuildFinderFrame.OptionsList.DpsRoleFrame.Icon:SetAtlas("UI-Frame-DpsIcon", true)

				ClubFinderCommunityAndGuildFinderFrame.OptionsList.TankRoleFrame.Icon:SetAtlas("UI-Frame-TankIcon", true)
				ClubFinderCommunityAndGuildFinderFrame.OptionsList.HealerRoleFrame.Icon:SetAtlas("UI-Frame-HealerIcon", true)
				ClubFinderCommunityAndGuildFinderFrame.OptionsList.DpsRoleFrame.Icon:SetAtlas("UI-Frame-DpsIcon", true)

				CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SetSize(32, 32)
				CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesFrame.GuildMemberDetailFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")

				ApplyDialogBorder(CommunitiesFrame.GuildMemberDetailFrame.Border)
				ApplyDialogBorder(CommunitiesFrame.RecruitmentDialog.BG)

				CommunitiesGuildNewsFiltersFrame.CloseButton:SetSize(32, 32)
				CommunitiesGuildNewsFiltersFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
				CommunitiesGuildNewsFiltersFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
				CommunitiesGuildNewsFiltersFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
				CommunitiesGuildNewsFiltersFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
			end
		end)
	end
end)