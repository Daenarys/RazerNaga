-- hide default buttons
TextToSpeechButtonFrame:Hide()

QuickJoinToastButton:HookScript("OnUpdate", function(self)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMLEFT", ChatAlertFrame, "BOTTOMLEFT")
end)

ChatConfigFrame:HookScript("OnShow", function(self)
    self:ClearAllPoints()
    self:SetPoint("CENTER")
end)