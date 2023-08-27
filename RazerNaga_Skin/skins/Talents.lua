local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_ClassTalentUI" then
		ClassTalentFrameCloseButton:SetSize(32, 32)
		ClassTalentFrameCloseButton:SetDisabledTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled")
		ClassTalentFrameCloseButton:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
		ClassTalentFrameCloseButton:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
		ClassTalentFrameCloseButton:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		ClassTalentFrameCloseButton:ClearAllPoints()
		ClassTalentFrameCloseButton:SetPoint("TOPRIGHT", 5.6, 5)
		ClassTalentFrameCloseButton:SetFrameLevel(2)

		ClassTalentFrame.PortraitContainer.CircleMask:Hide()

		ClassTalentFramePortrait:SetSize(61, 61)
		ClassTalentFramePortrait:ClearAllPoints()
		ClassTalentFramePortrait:SetPoint("TOPLEFT", -6, 8)

		ClassTalentFrame.TitleContainer:ClearAllPoints()
		ClassTalentFrame.TitleContainer:SetPoint("TOPLEFT", ClassTalentFrame, "TOPLEFT", 58, 0)
		ClassTalentFrame.TitleContainer:SetPoint("TOPRIGHT", ClassTalentFrame, "TOPRIGHT", -58, 0)

		ClassTalentFrame:CreateTexture("ClassTalentFrameTitleBg")
		ClassTalentFrame.TitleBg = ClassTalentFrameTitleBg
		ClassTalentFrame.TitleBg:SetAtlas("_UI-Frame-TitleTileBg", false)
		ClassTalentFrame.TitleBg:SetSize(256, 18)
		ClassTalentFrame.TitleBg:SetHorizTile(true)
		ClassTalentFrame.TitleBg:ClearAllPoints()
		ClassTalentFrame.TitleBg:SetPoint("TOPLEFT", 2, -3)
		ClassTalentFrame.TitleBg:SetPoint("TOPRIGHT", -25, -3)

		ClassTalentFrame.TopTileStreaks:ClearAllPoints()
		ClassTalentFrame.TopTileStreaks:SetPoint("TOPLEFT", 0, -21)
		ClassTalentFrame.TopTileStreaks:SetPoint("TOPRIGHT", -2, -21)

		ApplyNineSlicePortrait(ClassTalentFrame.NineSlice)

		for i = 1, _G.ClassTalentFrame.TabSystem:GetNumChildren() do
			local tab = select(i, _G.ClassTalentFrame.TabSystem:GetChildren())

			ApplyBottomTab(tab)
		end

		hooksecurefunc(ClassTalentFrame.TabSystem, 'Layout', function(self)
			self.tabs[1]:SetWidth(45 + self.tabs[1]:GetFontString():GetStringWidth())
			self.tabs[2]:ClearAllPoints()
			self.tabs[2]:SetPoint("LEFT", self.tabs[1], "RIGHT", -15, 0)
        end)

        hooksecurefunc(ClassTalentFrame.SpecTab, 'UpdateSpecFrame', function(frame)
			for specContentFrame in frame.SpecContentFramePool:EnumerateActive() do
				local role = GetSpecializationRole(specContentFrame.specIndex, false, false);
				
				specContentFrame.RoleIcon:SetTexCoord(GetTexCoordsForRole(role));
				specContentFrame.RoleIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-ROLES")
			end
        end)
	end
end)