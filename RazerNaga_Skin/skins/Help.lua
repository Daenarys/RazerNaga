if not _G.HelpFrame then return end

HelpFrame.TitleContainer:ClearAllPoints()
HelpFrame.TitleContainer:SetPoint("TOPLEFT", HelpFrame, "TOPLEFT", 58, 0)
HelpFrame.TitleContainer:SetPoint("TOPRIGHT", HelpFrame, "TOPRIGHT", -58, 0)

HelpFrame.CloseButton:SetSize(32, 32)
HelpFrame.CloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
HelpFrame.CloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
HelpFrame.CloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
HelpFrame.CloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
HelpFrame.CloseButton:ClearAllPoints()
HelpFrame.CloseButton:SetPoint("TOPRIGHT", 5.6, 5)
HelpFrame.CloseButton:SetFrameLevel(2)

HelpFrameBg:ClearAllPoints()
HelpFrameBg:SetPoint("TOPLEFT", 3, -20)
HelpFrameBg:SetPoint("BOTTOMRIGHT", -2, 2)

HelpFrame:CreateTexture("HelpFrameTitleBg")
HelpFrame.TitleBg = HelpFrameTitleBg
HelpFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
HelpFrame.TitleBg:SetSize(256, 18)
HelpFrame.TitleBg:SetHorizTile(true)
HelpFrame.TitleBg:ClearAllPoints()
HelpFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
HelpFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

ApplyNineSliceNoPortrait(HelpFrame.NineSlice)

_G.HelpFrame:HookScript("OnShow", function(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", 0, 24)
end)