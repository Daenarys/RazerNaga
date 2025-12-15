if not _G.FriendsFrame then return end

FriendsFrame:SetWidth(338)
WhoFrameColumnHeader4Middle:SetWidth(48)

FriendsFrameBattlenetFrame:ClearAllPoints()
FriendsFrameBattlenetFrame:SetPoint("TOPLEFT", FriendsTabHeader, "TOPLEFT", 109, -26)

FriendsFrameBattlenetFrame.ContactsMenuButton.Icon:Hide()
FriendsFrameBattlenetFrame.ContactsMenuButton:SetNormalTexture("Interface\\FriendsFrame\\broadcast-normal")
FriendsFrameBattlenetFrame.ContactsMenuButton:SetPushedTexture("Interface\\FriendsFrame\\broadcast-press")

hooksecurefunc(FriendsTabHeader.TabSystem, 'Layout', function(self)
	self.tabs[1]:SetWidth(36 + self.tabs[1]:GetFontString():GetStringWidth())
end)