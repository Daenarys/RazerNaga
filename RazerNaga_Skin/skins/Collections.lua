local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" then
		CollectionsJournalCloseButton:SetSize(32, 32)
		CollectionsJournalCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		CollectionsJournalCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		CollectionsJournalCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		CollectionsJournalCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		CollectionsJournalCloseButton:ClearAllPoints()
		CollectionsJournalCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		CollectionsJournalCloseButton:SetFrameLevel(2)

		CollectionsJournal.PortraitContainer.CircleMask:Hide()

		CollectionsJournalPortrait:SetSize(61, 61)
		CollectionsJournalPortrait:ClearAllPoints()
		CollectionsJournalPortrait:SetPoint("TOPLEFT", -6, 8)

		CollectionsJournal.TitleContainer:ClearAllPoints()
		CollectionsJournal.TitleContainer:SetPoint("TOPLEFT", CollectionsJournal, "TOPLEFT", 58, 0)
		CollectionsJournal.TitleContainer:SetPoint("TOPRIGHT", CollectionsJournal, "TOPRIGHT", -58, 0)

		CollectionsJournal:CreateTexture("CollectionsJournalTitleBg")
		CollectionsJournal.TitleBg = CollectionsJournalTitleBg
		CollectionsJournal.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		CollectionsJournal.TitleBg:SetSize(256, 18)
		CollectionsJournal.TitleBg:SetHorizTile(true)
		CollectionsJournal.TitleBg:ClearAllPoints()
		CollectionsJournal.TitleBg:SetPoint("TOPLEFT", 2, -3)
		CollectionsJournal.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		CollectionsJournal.TopTileStreaks:ClearAllPoints()
		CollectionsJournal.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		CollectionsJournal.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		PetJournalTutorialButton.Ring:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\MiniMap-TrackingBorder.png")
		WardrobeCollectionFrame.InfoButton.Ring:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\MiniMap-TrackingBorder.png")

		ApplyNineSlicePortrait(CollectionsJournal.NineSlice)

		CollectionsJournalTab2:ClearAllPoints()
		CollectionsJournalTab2:SetPoint("LEFT", CollectionsJournalTab1, "RIGHT", -16, 0)
		CollectionsJournalTab3:ClearAllPoints()
		CollectionsJournalTab3:SetPoint("LEFT", CollectionsJournalTab2, "RIGHT", -16, 0)
		CollectionsJournalTab4:ClearAllPoints()
		CollectionsJournalTab4:SetPoint("LEFT", CollectionsJournalTab3, "RIGHT", -16, 0)
		CollectionsJournalTab5:ClearAllPoints()
		CollectionsJournalTab5:SetPoint("LEFT", CollectionsJournalTab4, "RIGHT", -16, 0)

		for i = 1,5 do
			ApplyBottomTab(_G['CollectionsJournalTab'..i])

			_G["CollectionsJournalTab"..i]:HookScript("OnShow", function(self)
				self:SetWidth(40 + self:GetFontString():GetStringWidth())
			end)
		end

		WardrobeCollectionFrameTab2:ClearAllPoints()
		WardrobeCollectionFrameTab2:SetPoint("LEFT", WardrobeCollectionFrameTab1, "RIGHT")

		for i = 1, 2 do
			ApplyTopTab(_G['WardrobeCollectionFrameTab'..i])

			_G["WardrobeCollectionFrameTab"..i]:HookScript("OnShow", function(self)
				if _G["WardrobeCollectionFrameTab"..i] == WardrobeCollectionFrameTab1 then
					self:SetWidth(58 + self:GetFontString():GetStringWidth())
				elseif _G["WardrobeCollectionFrameTab"..i] == WardrobeCollectionFrameTab2 then
					self:SetWidth(66 + self:GetFontString():GetStringWidth())
				end
			end)
		end

		MountJournal.ScrollBar:SetSize(25, 560)
		MountJournal.ScrollBar:ClearAllPoints()
		MountJournal.ScrollBar:SetPoint("TOPLEFT", MountJournal.ScrollBox, "TOPRIGHT", 1, 36)
		MountJournal.ScrollBar:SetPoint("BOTTOMLEFT", MountJournal.ScrollBox, "BOTTOMRIGHT", 4, -4)

		if (MountJournal.ScrollBar.Background == nil) then
			MountJournal.ScrollBar.Background = MountJournal.ScrollBar:CreateTexture(nil, "BACKGROUND");
			MountJournal.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			MountJournal.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(MountJournal.ScrollBar)
		ApplyScrollBarTrack(MountJournal.ScrollBar.Track)
		ApplyScrollBarThumb(MountJournal.ScrollBar.Track.Thumb)

		PetJournal.ScrollBar:SetSize(25, 560)
		PetJournal.ScrollBar:ClearAllPoints()
		PetJournal.ScrollBar:SetPoint("TOPLEFT", PetJournal.ScrollBox, "TOPRIGHT", 1, 36)
		PetJournal.ScrollBar:SetPoint("BOTTOMLEFT", PetJournal.ScrollBox, "BOTTOMRIGHT", 4, -4)

		if (PetJournal.ScrollBar.Background == nil) then
			PetJournal.ScrollBar.Background = PetJournal.ScrollBar:CreateTexture(nil, "BACKGROUND");
			PetJournal.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			PetJournal.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(PetJournal.ScrollBar)
		ApplyScrollBarTrack(PetJournal.ScrollBar.Track)

		PetJournal.ScrollBar.Track.Thumb:SetWidth(18)
		PetJournal.ScrollBar.Track.Thumb.Begin:SetAtlas("UI-ScrollBar-Knob-EndCap-Top", true)
		PetJournal.ScrollBar.Track.Thumb.End:SetAtlas("UI-ScrollBar-Knob-EndCap-Bottom", true)
		PetJournal.ScrollBar.Track.Thumb.Middle:SetAtlas("UI-ScrollBar-Knob-Center", true)
		PetJournal.ScrollBar.Track.Thumb.upBeginTexture = "UI-ScrollBar-Knob-EndCap-Top"
		PetJournal.ScrollBar.Track.Thumb.upMiddleTexture = "UI-ScrollBar-Knob-Center"
		PetJournal.ScrollBar.Track.Thumb.upEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom"
		PetJournal.ScrollBar.Track.Thumb.overBeginTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Top"
		PetJournal.ScrollBar.Track.Thumb.overMiddleTexture = "UI-ScrollBar-Knob-MouseOver-Center"
		PetJournal.ScrollBar.Track.Thumb.overEndTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Bottom"
		PetJournal.ScrollBar.Track.Thumb.downBeginTexture = "UI-ScrollBar-Knob-EndCap-Top-Disabled"
		PetJournal.ScrollBar.Track.Thumb.downMiddleTexture = "UI-ScrollBar-Knob-Center-Disabled"
		PetJournal.ScrollBar.Track.Thumb.downEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom-Disabled"
		PetJournal.ScrollBar.Track.Thumb.Middle:ClearAllPoints()
		PetJournal.ScrollBar.Track.Thumb.Middle:SetPoint("TOPLEFT", 0, -5)
		PetJournal.ScrollBar.Track.Thumb.Middle:SetPoint("BOTTOMRIGHT", 0, 5)

		WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:SetSize(25, 560)
		WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:ClearAllPoints()
		WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:SetPoint("TOPLEFT", WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBox, "TOPRIGHT", 1, 36)
		WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:SetPoint("BOTTOMLEFT", WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBox, "BOTTOMRIGHT", 4, -8)

		if (WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Background == nil) then
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Background = WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:CreateTexture(nil, "BACKGROUND");
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Background:SetColorTexture(0, 0, 0, .85)
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Background:SetAllPoints()
		end

		ApplyScrollBarArrow(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar)
		ApplyScrollBarTrack(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Track)
		ApplyScrollBarThumb(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Track.Thumb)
		
		MountJournalFilterButton.ResetButton:SetAlpha(0)
		WardrobeCollectionFrame.FilterButton.ResetButton:SetAlpha(0)
	end
end)