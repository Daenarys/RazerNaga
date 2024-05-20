for i = 1, NUM_CHAT_WINDOWS do
    -- fix blizz 10.1 bug
    hooksecurefunc("FloatingChatFrame_Update", function()
        _G["ChatFrame"..i].Background:SetPoint("TOPLEFT", _G["ChatFrame"..i], "TOPLEFT", -2, 3);
        _G["ChatFrame"..i].Background:SetPoint("TOPRIGHT", _G["ChatFrame"..i], "TOPRIGHT", 13, 3);
        _G["ChatFrame"..i].Background:SetPoint("BOTTOMLEFT", _G["ChatFrame"..i], "BOTTOMLEFT", -2, -6);
        _G["ChatFrame"..i].Background:SetPoint("BOTTOMRIGHT", _G["ChatFrame"..i], "BOTTOMRIGHT", 13, -6);
    end)

    local tab = _G['ChatFrame'..i..'Tab']
    if tab then
        tab.Text:SetPoint("CENTER", 0, -6)
    end
end

_G.QuickJoinToastButton:HookScript("OnUpdate", function(self)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMLEFT", ChatAlertFrame, "BOTTOMLEFT")
end)

_G.ChatConfigFrame:HookScript("OnShow", function(self)
    self:ClearAllPoints()
    self:SetPoint("CENTER")
end)