if not _G.FriendsFrame then return end

FriendsListFrame.ScrollBar:SetSize(25, 560)
FriendsListFrame.ScrollBar:ClearAllPoints()
FriendsListFrame.ScrollBar:SetPoint("TOPLEFT", FriendsListFrame.ScrollBox, "TOPRIGHT", -2, 3)
FriendsListFrame.ScrollBar:SetPoint("BOTTOMLEFT", FriendsListFrame.ScrollBox, "BOTTOMRIGHT", 1, -3)

ApplyScrollBarArrow(FriendsListFrame.ScrollBar)
ApplyScrollBarTrack(FriendsListFrame.ScrollBar.Track)
ApplyScrollBarThumb(FriendsListFrame.ScrollBar.Track.Thumb)

IgnoreListFrame.ScrollBar:SetSize(25, 560)
IgnoreListFrame.ScrollBar:ClearAllPoints()
IgnoreListFrame.ScrollBar:SetPoint("TOPLEFT", IgnoreListFrame.ScrollBox, "TOPRIGHT", -2, 3)
IgnoreListFrame.ScrollBar:SetPoint("BOTTOMLEFT", IgnoreListFrame.ScrollBox, "BOTTOMRIGHT", 1, -1)

ApplyScrollBarArrow(IgnoreListFrame.ScrollBar)
ApplyScrollBarTrack(IgnoreListFrame.ScrollBar.Track)
ApplyScrollBarThumb(IgnoreListFrame.ScrollBar.Track.Thumb)

RecruitAFriendFrame.RecruitList.ScrollBar:SetSize(25, 560)
RecruitAFriendFrame.RecruitList.ScrollBar:ClearAllPoints()
RecruitAFriendFrame.RecruitList.ScrollBar:SetPoint("TOPLEFT", RecruitAFriendFrame.RecruitList.ScrollBox, "TOPRIGHT", -2, 3)
RecruitAFriendFrame.RecruitList.ScrollBar:SetPoint("BOTTOMLEFT", RecruitAFriendFrame.RecruitList.ScrollBox, "BOTTOMRIGHT", 1, -3)

ApplyScrollBarArrow(RecruitAFriendFrame.RecruitList.ScrollBar)
ApplyScrollBarTrack(RecruitAFriendFrame.RecruitList.ScrollBar.Track)
ApplyScrollBarThumb(RecruitAFriendFrame.RecruitList.ScrollBar.Track.Thumb)

ApplyDialogBorder(RecruitAFriendRecruitmentFrame.Border)
ApplyDialogBorder(RecruitAFriendRewardsFrame.Border)

WhoFrame.ScrollBar:SetSize(25, 560)
WhoFrame.ScrollBar:ClearAllPoints()
WhoFrame.ScrollBar:SetPoint("TOPLEFT", WhoFrame.ScrollBox, "TOPRIGHT", -2, 3)
WhoFrame.ScrollBar:SetPoint("BOTTOMLEFT", WhoFrame.ScrollBox, "BOTTOMRIGHT", 1, -18)

ApplyScrollBarArrow(WhoFrame.ScrollBar)
ApplyScrollBarTrack(WhoFrame.ScrollBar.Track)
ApplyScrollBarThumb(WhoFrame.ScrollBar.Track.Thumb)

QuickJoinFrame.ScrollBar:SetSize(25, 560)
QuickJoinFrame.ScrollBar:ClearAllPoints()
QuickJoinFrame.ScrollBar:SetPoint("TOPLEFT", QuickJoinFrame.ScrollBox, "TOPRIGHT", -1, 4)
QuickJoinFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuickJoinFrame.ScrollBox, "BOTTOMRIGHT", 2, -2)

ApplyScrollBarArrow(QuickJoinFrame.ScrollBar)
ApplyScrollBarTrack(QuickJoinFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuickJoinFrame.ScrollBar.Track.Thumb)

ApplyDialogBorder(AddFriendFrame.Border)

RaidInfoFrame.ScrollBar:SetSize(25, 560)
RaidInfoFrame.ScrollBar:ClearAllPoints()
RaidInfoFrame.ScrollBar:SetPoint("TOPLEFT", RaidInfoFrame.ScrollBox, "TOPRIGHT", 4, 3)
RaidInfoFrame.ScrollBar:SetPoint("BOTTOMLEFT", RaidInfoFrame.ScrollBox, "BOTTOMRIGHT", 7, -2)

ApplyScrollBarArrow(RaidInfoFrame.ScrollBar)
ApplyScrollBarTrack(RaidInfoFrame.ScrollBar.Track)
ApplyScrollBarThumb(RaidInfoFrame.ScrollBar.Track.Thumb)

ApplyDialogHeader(RaidInfoFrame.Header)
ApplyDialogBorder(RaidInfoFrame.Border)