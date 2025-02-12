-- hide default buttons
TextToSpeechButtonFrame:Hide()

-- move down friends microbutton
QuickJoinToastButton:HookScript("OnUpdate", function(self)
    self:ClearAllPoints()
    self:SetPoint("BOTTOMLEFT", ChatAlertFrame, "BOTTOMLEFT")
end)