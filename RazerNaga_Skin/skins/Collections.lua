local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_Collections" then
		MountJournal.ScrollBar:SetSize(25, 560)
		MountJournal.ScrollBar:ClearAllPoints()
		MountJournal.ScrollBar:SetPoint("TOPLEFT", MountJournal.ScrollBox, "TOPRIGHT", 1, 36)
		MountJournal.ScrollBar:SetPoint("BOTTOMLEFT", MountJournal.ScrollBox, "BOTTOMRIGHT", 4, -4)

		if (MountJournal.ScrollBar.BG == nil) then
			MountJournal.ScrollBar.BG = MountJournal.ScrollBar:CreateTexture(nil, "BACKGROUND");
			MountJournal.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			MountJournal.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(MountJournal.ScrollBar)
		ApplyScrollBarTrack(MountJournal.ScrollBar.Track)
		ApplyScrollBarThumb(MountJournal.ScrollBar.Track.Thumb)

		PetJournal.ScrollBar:SetSize(25, 560)
		PetJournal.ScrollBar:ClearAllPoints()
		PetJournal.ScrollBar:SetPoint("TOPLEFT", PetJournal.ScrollBox, "TOPRIGHT", 1, 36)
		PetJournal.ScrollBar:SetPoint("BOTTOMLEFT", PetJournal.ScrollBox, "BOTTOMRIGHT", 4, -4)

		if (PetJournal.ScrollBar.BG == nil) then
			PetJournal.ScrollBar.BG = PetJournal.ScrollBar:CreateTexture(nil, "BACKGROUND");
			PetJournal.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			PetJournal.ScrollBar.BG:SetAllPoints()
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

		if (WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.BG == nil) then
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.BG = WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar:CreateTexture(nil, "BACKGROUND");
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar)
		ApplyScrollBarTrack(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Track)
		ApplyScrollBarThumb(WardrobeCollectionFrame.SetsCollectionFrame.ListContainer.ScrollBar.Track.Thumb)
	end
end)