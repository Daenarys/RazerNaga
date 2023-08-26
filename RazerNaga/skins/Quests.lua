if not _G.QuestFrame then return end

QuestFrameCloseButton:SetSize(32, 32)
QuestFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
QuestFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
QuestFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
QuestFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
QuestFrameCloseButton:ClearAllPoints()
QuestFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
QuestFrameCloseButton:SetFrameLevel(2)

QuestFrame.PortraitContainer.CircleMask:Hide()

QuestFramePortrait:SetSize(61, 61)
QuestFramePortrait:ClearAllPoints()
QuestFramePortrait:SetPoint("TOPLEFT", -6, 8)

QuestFrame.TitleContainer:ClearAllPoints()
QuestFrame.TitleContainer:SetPoint("TOPLEFT", QuestFrame, "TOPLEFT", 73, -1)
QuestFrame.TitleContainer:SetPoint("TOPRIGHT", QuestFrame, "TOPRIGHT", -47, 1)

QuestFrameTitleText:SetTextColor(255, 255, 255, 1)

QuestFrame:CreateTexture("QuestFrameTitleBg")
QuestFrame.TitleBg = QuestFrameTitleBg
QuestFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
QuestFrame.TitleBg:SetSize(256, 18)
QuestFrame.TitleBg:SetHorizTile(true)
QuestFrame.TitleBg:ClearAllPoints()
QuestFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
QuestFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

QuestFrame.TopTileStreaks:ClearAllPoints()
QuestFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
QuestFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

ApplyNineSlicePortrait(QuestFrame.NineSlice)

QuestScrollFrame.ScrollBar:SetSize(25, 560)
QuestScrollFrame.ScrollBar:ClearAllPoints()
QuestScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 2, 2)
QuestScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestScrollFrame, "BOTTOMRIGHT", 5, -2)

ApplyScrollBarArrow(QuestScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestScrollFrame.ScrollBar.Track.Thumb)

QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar:SetSize(25, 560)
QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar:ClearAllPoints()
QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestScrollFrame, "TOPRIGHT", 2, 2)
QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestScrollFrame, "BOTTOMRIGHT", 5, -2)

ApplyScrollBarArrow(QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestMapFrame.CampaignOverview.ScrollFrame.ScrollBar.Track.Thumb)

QuestDetailScrollFrame.ScrollBar:SetSize(25, 560)
QuestDetailScrollFrame.ScrollBar:ClearAllPoints()
QuestDetailScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestDetailScrollFrame, "TOPRIGHT", 2, 3)
QuestDetailScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestDetailScrollFrame, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(QuestDetailScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestDetailScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestDetailScrollFrame.ScrollBar.Track.Thumb)

QuestGreetingScrollFrame.ScrollBar:SetSize(25, 560)
QuestGreetingScrollFrame.ScrollBar:ClearAllPoints()
QuestGreetingScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestGreetingScrollFrame, "TOPRIGHT", 2, 3)
QuestGreetingScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestGreetingScrollFrame, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(QuestGreetingScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestGreetingScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestGreetingScrollFrame.ScrollBar.Track.Thumb)

QuestMapDetailsScrollFrame.ScrollBar:SetWidth(20)
QuestMapDetailsScrollFrame.ScrollBar:ClearAllPoints()
QuestMapDetailsScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestMapDetailsScrollFrame, "TOPRIGHT", 0, 0)
QuestMapDetailsScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestMapDetailsScrollFrame, "BOTTOMRIGHT", 0, 0)

if (QuestMapDetailsScrollFrame.ScrollBar.Background == nil) then
	QuestMapDetailsScrollFrame.ScrollBar.Background = QuestMapDetailsScrollFrame.ScrollBar:CreateTexture(nil, "BACKGROUND");
	QuestMapDetailsScrollFrame.ScrollBar.Background:SetColorTexture(0, 0, 0, .5)
	QuestMapDetailsScrollFrame.ScrollBar.Background:SetAllPoints()
end

QuestMapDetailsScrollFrame.ScrollBar.Track.Begin:Hide()
QuestMapDetailsScrollFrame.ScrollBar.Track.End:Hide()
QuestMapDetailsScrollFrame.ScrollBar.Track.Middle:Hide()

ApplyScrollBarThumb(QuestMapDetailsScrollFrame.ScrollBar.Track.Thumb)

QuestMapDetailsScrollFrame.ScrollBar.Back:SetSize(18, 16)
QuestMapDetailsScrollFrame.ScrollBar.Back:SetNormalAtlas("UI-ScrollBar-ScrollUpButton-Up")
QuestMapDetailsScrollFrame.ScrollBar.Back:SetPushedAtlas("UI-ScrollBar-ScrollUpButton-Down")
QuestMapDetailsScrollFrame.ScrollBar.Back:SetDisabledAtlas("UI-ScrollBar-ScrollUpButton-Disabled")
QuestMapDetailsScrollFrame.ScrollBar.Back:SetHighlightAtlas("UI-ScrollBar-ScrollUpButton-Highlight")

QuestMapDetailsScrollFrame.ScrollBar.Forward:SetSize(18, 16)
QuestMapDetailsScrollFrame.ScrollBar.Forward:SetNormalAtlas("UI-ScrollBar-ScrollDownButton-Up")
QuestMapDetailsScrollFrame.ScrollBar.Forward:SetPushedAtlas("UI-ScrollBar-ScrollDownButton-Down")
QuestMapDetailsScrollFrame.ScrollBar.Forward:SetDisabledAtlas("UI-ScrollBar-ScrollDownButton-Disabled")
QuestMapDetailsScrollFrame.ScrollBar.Forward:SetHighlightAtlas("UI-ScrollBar-ScrollDownButton-Highlight")

QuestProgressScrollFrame.ScrollBar:SetSize(25, 560)
QuestProgressScrollFrame.ScrollBar:ClearAllPoints()
QuestProgressScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestProgressScrollFrame, "TOPRIGHT", 2, 3)
QuestProgressScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestProgressScrollFrame, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(QuestProgressScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestProgressScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestProgressScrollFrame.ScrollBar.Track.Thumb)

QuestRewardScrollFrame.ScrollBar:SetSize(25, 560)
QuestRewardScrollFrame.ScrollBar:ClearAllPoints()
QuestRewardScrollFrame.ScrollBar:SetPoint("TOPLEFT", QuestRewardScrollFrame, "TOPRIGHT", 2, 3)
QuestRewardScrollFrame.ScrollBar:SetPoint("BOTTOMLEFT", QuestRewardScrollFrame, "BOTTOMRIGHT", 5, -1)

ApplyScrollBarArrow(QuestRewardScrollFrame.ScrollBar)
ApplyScrollBarTrack(QuestRewardScrollFrame.ScrollBar.Track)
ApplyScrollBarThumb(QuestRewardScrollFrame.ScrollBar.Track.Thumb)

local defaultXSize = 510;
local defaultYSize = 620;

QuestFrameDetailPanel:HookScript("OnShow", function(self)
	self.Bg:SetSize(defaultXSize, defaultYSize);
	self.Bg:SetTexture("Interface/QuestFrame/QuestBG");
end)

QuestFrameGreetingPanel:HookScript("OnShow", function(self)
	self.Bg:SetSize(defaultXSize, defaultYSize);
	self.Bg:SetTexture("Interface/QuestFrame/QuestBG");
end)

QuestFrameProgressPanel:HookScript("OnShow", function(self)
	self.Bg:SetSize(defaultXSize, defaultYSize);
	self.Bg:SetTexture("Interface/QuestFrame/QuestBG");
end)

QuestFrameRewardPanel:HookScript("OnShow", function(self)
	self.Bg:SetSize(defaultXSize, defaultYSize);
	self.Bg:SetTexture("Interface/QuestFrame/QuestBG");
end)

QuestLogPopupDetailFrame:HookScript("OnShow", function(self)
	self.Bg:SetSize(defaultXSize, defaultYSize);
	self.Bg:SetTexture("Interface/QuestFrame/QuestBG");
end)

hooksecurefunc(_G.CampaignCollapseButtonMixin, 'UpdateState', function(self, isCollapsed)
	if isCollapsed then
		self:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
		self:SetPushedTexture("Interface\\Buttons\\UI-PlusButton-Down")
	else
		self:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
		self:SetPushedTexture("Interface\\Buttons\\UI-MinusButton-Down")
	end
	self:SetSize(16, 16)
end)

hooksecurefunc('QuestLogQuests_Update', function()
		for _, child in next, { _G.QuestMapFrame.QuestsFrame.Contents:GetChildren() } do
		if child.ButtonText and not child.questID then
			child:SetSize(16, 16)
			for _, tex in next, { child:GetRegions() } do
				if tex.GetAtlas then
					local atlas = tex:GetAtlas()
					if atlas == 'Campaign_HeaderIcon_Closed' then
						tex:SetTexture("Interface\\Buttons\\UI-PlusButton-Up")
					elseif atlas == 'Campaign_HeaderIcon_ClosedPressed' then
						tex:SetTexture("Interface\\Buttons\\UI-PlusButton-Down")
					elseif atlas == 'Campaign_HeaderIcon_Open' then
						tex:SetTexture("Interface\\Buttons\\UI-MinusButton-Up")
					elseif atlas == 'Campaign_HeaderIcon_OpenPressed' then
						tex:SetTexture("Interface\\Buttons\\UI-MinusButton-Down")
					end
				end
			end
		end
	end
end)