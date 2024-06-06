if TextToSpeechButtonFrame then
    TextToSpeechButtonFrame:Hide()
end

QuickJoinToastButton:HookScript("OnUpdate", function(self)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMLEFT", ChatAlertFrame, "BOTTOMLEFT")
end)

ChatConfigFrame:HookScript("OnShow", function(self)
    self:ClearAllPoints()
    self:SetPoint("CENTER")
end)