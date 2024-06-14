local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PerksProgram" then
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetSize(25, 560)
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:ClearAllPoints()
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetPoint("TOPLEFT", PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBox, "TOPRIGHT", -6, 4)
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:SetPoint("BOTTOMLEFT", PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBox, "BOTTOMRIGHT", -3, 0)

		if (PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Backplate == nil) then
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Backplate = PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar:CreateTexture(nil, "BACKGROUND")
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, .1)
			PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Backplate:SetAllPoints()
		end

		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track:ClearAllPoints()
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track.Begin:Hide()
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track.End:Hide()
		PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track.Middle:Hide()

		ApplyScrollBarArrow(PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar)
		ApplyScrollBarThumb(PerksProgramFrame.ProductsFrame.ProductsScrollBoxContainer.ScrollBar.Track.Thumb)

		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:SetSize(25, 560)

		if (PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Backplate == nil) then
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Backplate = PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar:CreateTexture(nil, "BACKGROUND")
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Backplate:SetColorTexture(0, 0, 0, .1)
			PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Backplate:SetAllPoints()
		end

		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track:ClearAllPoints()
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track:SetPoint("TOPLEFT", 4, -22)
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track:SetPoint("BOTTOMRIGHT", -4, 22)

		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track.Begin:Hide()
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track.End:Hide()
		PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track.Middle:Hide()

		ApplyScrollBarArrow(PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar)
		ApplyScrollBarThumb(PerksProgramFrame.ProductsFrame.PerksProgramProductDetailsContainerFrame.SetDetailsScrollBoxContainer.ScrollBar.Track.Thumb)
	end
end)