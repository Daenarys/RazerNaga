if not _G.PetFrame then return end

PetFrame:SetSize(128, 53)
PetFrame:SetFrameStrata("MEDIUM")

PetFrameTexture:SetTexture("Interface\\TargetingFrame\\UI-SmallTargetingFrame")
PetFrameTexture:SetSize(128, 64)
PetFrameTexture:SetPoint("TOPLEFT", 0, -2)
PetFrameTexture:SetDrawLayer("ARTWORK", 7)

PetFrameFlash:SetTexture("Interface\\TargetingFrame\\UI-PartyFrame-Flash")
PetFrameFlash:SetSize(128, 64)
PetFrameFlash:SetPoint("TOPLEFT", -4, 11)
PetFrameFlash:SetTexCoord(0, 1, 1, 0)
PetFrameFlash:SetDrawLayer("BACKGROUND", 0)

PetName:ClearAllPoints()
PetName:SetPoint("BOTTOMLEFT", 53, 34)
PetName:SetWidth(0)

PetPortrait:ClearAllPoints()
PetPortrait:SetPoint("TOPLEFT", 7, -6)

PetFrameHealthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
PetFrameHealthBar:SetStatusBarColor(0, 1, 0)
PetFrameHealthBar:SetFrameLevel(1)
PetFrameHealthBar:SetSize(69, 8)
PetFrameHealthBar:ClearAllPoints()
PetFrameHealthBar:SetPoint("TOPLEFT", 47, -22)
PetFrameHealthBarMask:Hide()

PetFrameManaBar:SetFrameLevel(1)
PetFrameManaBar:SetSize(69, 8)
PetFrameManaBar:ClearAllPoints()
PetFrameManaBar:SetPoint("TOPLEFT", 47, -29)
PetFrameManaBarMask:Hide()

PetFrameHealthBarText:SetParent(PetFrame)
PetFrameHealthBarText:ClearAllPoints()
PetFrameHealthBarText:SetPoint("CENTER", PetFrameHealthBar, 1, 0)
PetFrameHealthBarTextLeft:SetParent(PetFrame)
PetFrameHealthBarTextRight:SetParent(PetFrame)
PetFrameHealthBarTextRight:ClearAllPoints()
PetFrameHealthBarTextRight:SetPoint("RIGHT", PetFrameHealthBar, -2, 0)
			
PetFrameManaBarText:SetParent(PetFrame)
PetFrameManaBarText:SetPoint("CENTER", PetFrameManaBar, 1, -2)
PetFrameManaBarTextLeft:SetParent(PetFrame)
PetFrameManaBarTextLeft:ClearAllPoints()
PetFrameManaBarTextLeft:SetPoint("LEFT", PetFrameManaBar, 0, -2)
PetFrameManaBarTextRight:SetParent(PetFrame)
PetFrameManaBarTextRight:ClearAllPoints()
PetFrameManaBarTextRight:SetPoint("RIGHT", PetFrame, "TOPLEFT", 113, -35)

PetFrameOverAbsorbGlow:SetParent(PetFrame)
PetFrameOverAbsorbGlow:SetDrawLayer("ARTWORK", 7)

PetAttackModeTexture:SetTexture("Interface\\TargetingFrame\\UI-Player-AttackStatus")
PetAttackModeTexture:SetSize(76, 64)
PetAttackModeTexture:ClearAllPoints()
PetAttackModeTexture:SetPoint("TOPLEFT", 6, -9)
PetAttackModeTexture:SetTexCoord(0.703125, 1, 0, 1)

PetHitIndicator:ClearAllPoints()
PetHitIndicator:SetPoint("TOPLEFT", -4, -15)