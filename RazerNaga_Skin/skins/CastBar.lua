--Target & Boss
local function CastbarStyle(frame)
    frame.Background:SetColorTexture(0, 0, 0, 0.5)
    frame.Border:ClearAllPoints()
    frame.Border:SetPoint("TOPLEFT", -23, 20)
    frame.Border:SetPoint("TOPRIGHT", 23, 20)
    frame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
    frame.Border:SetSize(0, 49)
    frame.BorderShield:SetTexture("Interface\\CastingBar\\UI-CastingBar-Small-Shield")
    frame.BorderShield:ClearAllPoints()
    frame.BorderShield:SetPoint("TOPLEFT", -28, 20)
    frame.BorderShield:SetPoint("TOPRIGHT", 18, 20)
    frame.BorderShield:SetSize(0, 49)
    frame.Text:ClearAllPoints()
    frame.Text:SetPoint("CENTER", frame, "CENTER", 0, 1)
    frame.Text:SetWidth(130)
    frame.TextBorder:Hide()
    frame.Icon:ClearAllPoints()
    frame.Icon:SetPoint("TOPLEFT", -21, 3)
    frame.Icon:SetSize(16, 16)
end 

local function SetAtlasTexture(frame)
    local Castbar = frame:GetParent()
    local barType = Castbar.barType 
    
    if (frame.NewFlash == nil) then
        frame.NewFlash = frame:GetParent():CreateTexture(nil, "OVERLAY")
        frame.NewFlash:SetSize(0, 49)
        frame.NewFlash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
        frame.NewFlash:ClearAllPoints()
        frame.NewFlash:SetPoint("TOPLEFT", -23, 20)
        frame.NewFlash:SetPoint("TOPRIGHT", 23, 20)
        frame.NewFlash:SetBlendMode("ADD")
        frame.NewFlash:SetAlpha(0)
        frame.NewFlashAnim = frame.NewFlash:CreateAnimationGroup()
        frame.NewFlashAnim:SetToFinalAlpha(true)
        local anim = frame.NewFlashAnim:CreateAnimation("Alpha") 
        anim:SetDuration(0.2)
        anim:SetFromAlpha(1)
        anim:SetToAlpha(0)
    end
      
    frame.NewFlashAnim:Play()

    if (barType == "channel") then
        frame.NewFlash:SetVertexColor(0, 1, 0)
    elseif (barType == "uninterruptable") then
        frame.NewFlash:SetVertexColor(0.7, 0.7, 0.7)
    elseif (barType == "empowered") then
        frame.NewFlash:SetVertexColor(0, 0, 0)
    else
        frame.NewFlash:SetVertexColor(1, 0.7, 0)
    end
end

local function HookOnEvent(self, event, ...)
    local parentFrame = self:GetParent();
    local useSpellbarAnchor = (not parentFrame.buffsOnTop) and ((parentFrame.haveToT and parentFrame.auraRows > 2) or ((not parentFrame.haveToT) and parentFrame.auraRows > 0));
    local relativeKey = useSpellbarAnchor and parentFrame.spellbarAnchor or parentFrame;
    local pointX = useSpellbarAnchor and 20 or  (parentFrame.smallSize and 40 or 45);
    local pointY = useSpellbarAnchor and -15 or (parentFrame.smallSize and 3 or 5);

    if ((not useSpellbarAnchor) and parentFrame.haveToT) then
        pointY = parentFrame.smallSize and -30 or -28;
    end

    self:SetPoint("TOPLEFT", relativeKey, "BOTTOMLEFT", pointX, pointY);
end

TargetFrame.spellbar:HookScript("OnEvent", HookOnEvent)
FocusFrame.spellbar:HookScript("OnEvent", HookOnEvent)

local function SkinTargetCastbar(frame)
    --General Textures
    CastbarStyle(frame)

    --Flash Texture
    hooksecurefunc(frame.Flash, "SetAtlas", SetAtlasTexture)

    --Castbar OnShow
    hooksecurefunc(frame, 'UpdateShownState', function(self)
        if not (self.barType == "empowered") then
            self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
            self.Spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
            self.Spark:SetSize(32, 32)
            self.Spark:ClearAllPoints()
            self.Spark:SetPoint("CENTER", 0, 0)
            self.Spark:SetBlendMode("ADD")
            self:SetFrameStrata("HIGH")
            if self.channeling then
                self.Spark:Hide()
            end
            local FadeOutAnim = self.FadeOutAnim:CreateAnimation("Alpha") 
            FadeOutAnim:SetDuration(0.2)
            FadeOutAnim:SetFromAlpha(1)
            FadeOutAnim:SetToAlpha(0)
        end
    end)

    --Force our texture on Animation Finish
    hooksecurefunc(frame, 'PlayFinishAnim', function(self)
        if not (self.barType == "empowered") then
            self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        end
    end)

    --Interrupted
    hooksecurefunc(frame, 'PlayInterruptAnims', function(self)
        self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        self.Spark:Hide()
    end)

    --Castbar Color (Type)
    hooksecurefunc(frame, 'GetTypeInfo', function(self)
        self:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
        if ( self.barType == "interrupted") then
            self:SetStatusBarColor(1, 0, 0)
            self:SetValue(100)
        elseif (self.barType == "channel") then
            self:SetStatusBarColor(0, 1, 0)
        elseif (self.barType == "uninterruptable") then
            self:SetStatusBarColor(0.7, 0.7, 0.7)
        else
            self:SetStatusBarColor(1, 0.7, 0)
        end
    end)

    if frame == TargetFrame or FocusFrame then
        hooksecurefunc(frame, "AdjustPosition", HookOnEvent)
    end
end

SkinTargetCastbar(TargetFrame.spellbar)
SkinTargetCastbar(FocusFrame.spellbar)

for _, frame in _G.pairs(_G.BossTargetFrameContainer.BossTargetFrames) do
    SkinTargetCastbar(frame.spellbar)
end