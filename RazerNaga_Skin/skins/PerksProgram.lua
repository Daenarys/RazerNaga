local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PerksProgram" then
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetSize(25, 560)
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:ClearAllPoints()
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetPoint("TOPLEFT", PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBox, "TOPRIGHT", -5, 4)
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetPoint("BOTTOMLEFT", PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBox, "BOTTOMRIGHT", -2, 0)

		if (PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.BG == nil) then
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.BG = PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:CreateTexture(nil, "BACKGROUND");
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar)
		ApplyScrollBarTrack(PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track)
		ApplyScrollBarThumb(PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track.Thumb)

		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:SetSize(25, 560)
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:ClearAllPoints()
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:SetPoint("TOPLEFT", PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBox, "TOPRIGHT", 5, 1)
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:SetPoint("BOTTOMLEFT", PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBox, "BOTTOMRIGHT", 8, -3)

		if (PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.BG == nil) then
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.BG = PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:CreateTexture(nil, "BACKGROUND");
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.BG:SetColorTexture(0, 0, 0, .85)
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.BG:SetAllPoints()
		end

		ApplyScrollBarArrow(PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar)
		ApplyScrollBarTrack(PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track)
		ApplyScrollBarThumb(PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track.Thumb)
	end
end)