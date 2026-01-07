if not _G.FriendsFrame then return end

FriendsFrame:SetWidth(338)
WhoFrameColumnHeader1:SetWidth(83)

FriendsFrameBattlenetFrame:ClearAllPoints()
FriendsFrameBattlenetFrame:SetPoint("TOPLEFT", FriendsTabHeader, "TOPLEFT", 109, -26)

ApplyDropDown(FriendsFrameStatusDropdown)
ApplyDropDown(WhoFrameDropdown)

FriendsFrameStatusDropdown:SetWidth(43)
FriendsFrameStatusDropdown:SetPoint("RIGHT", FriendsFrameBattlenetFrame, "LEFT", -5, 0)
FriendsFrameStatusDropdown.Text:ClearAllPoints()
FriendsFrameStatusDropdown.Text:SetPoint("CENTER", -7, -2)

WhoFrameDropdown:SetPoint("TOPLEFT", 0, -2)

hooksecurefunc(FriendsTabHeader.TabSystem, 'Layout', function(self)
	self.tabs[1]:SetWidth(36 + self.tabs[1]:GetFontString():GetStringWidth())
end)