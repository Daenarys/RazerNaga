local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_PVPUI" then
		if not PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest then
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest = CreateFrame("Frame", nil, PVPQueueFrame.HonorInset.CasualPanel)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetFrameLevel(3)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetSize(84, 70)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetPoint("TOP", 0, -48)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:Hide()

			Mixin(PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest, WeeklyRewardMixin)

			if (PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.FlairTexture == nil) then
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.FlairTexture = PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:CreateTexture(nil, "BACKGROUND")
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.FlairTexture:SetSize(187, 152)
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.FlairTexture:SetAtlas("pvpqueue-chest-background")
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.FlairTexture:SetPoint("CENTER")
			end

			if (PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture == nil) then
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture = PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:CreateTexture(nil, "ARTWORK")
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture:SetPoint("CENTER")
			end

			if (PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight == nil) then
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight = PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:CreateTexture(nil, "HIGHLIGHT")
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetBlendMode("ADD")
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetAlpha(0.2)
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetPoint("CENTER")
			end

			if C_WeeklyRewards.HasAvailableRewards() then
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture:SetAtlas("pvpqueue-chest-dragonflight-greatvault-collect", true)
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetAtlas("pvpqueue-chest-dragonflight-greatvault-collect", true)
			elseif PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:HasUnlockedRewards() then
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture:SetAtlas("pvpqueue-chest-dragonflight-greatvault-complete", true)
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetAtlas("pvpqueue-chest-dragonflight-greatvault-complete", true)
			else
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.ChestTexture:SetAtlas("pvpqueue-chest-dragonflight-greatvault-incomplete", true)
				PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest.Highlight:SetAtlas("pvpqueue-chest-dragonflight-greatvault-incomplete", true)
			end

			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip_SetTitle(GameTooltip, GREAT_VAULT_REWARDS)
				local hasRewards = C_WeeklyRewards.HasAvailableRewards()
				if hasRewards then
					GameTooltip_AddColoredLine(GameTooltip, GREAT_VAULT_REWARDS_WAITING, GREEN_FONT_COLOR)
					GameTooltip_AddBlankLineToTooltip(GameTooltip)
				end
				GameTooltip_AddInstructionLine(GameTooltip, WEEKLY_REWARDS_CLICK_TO_PREVIEW_INSTRUCTIONS)
				GameTooltip:Show()
			end)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetScript("OnLeave", GameTooltip_Hide)
			PVPQueueFrame.HonorInset.CasualPanel.WeeklyChest:SetScript("OnMouseUp", function(self, ...)
				if not ConquestFrame_HasActiveSeason() or InCombatLockdown() then
					return
				end
				WeeklyRewardMixin.OnMouseUp(self, ...)
			end)
		end

		PVPQueueFrame.HonorInset.CasualPanel:HookScript("OnShow", function(self)
			local Label = self.HKLabel
			if(UnitLevel("player") < GetMaxLevelForExpansionLevel(LE_EXPANSION_WAR_WITHIN)) then
				Label:Hide()
				self.WeeklyChest:Hide()
				self.HonorLevelDisplay:SetPoint("TOP", 0, -25)
			else
				Label:SetText(RATED_PVP_WEEKLY_VAULT)
				Label:SetPoint("TOP", 0, -12)
				Label:Show()
				self.WeeklyChest:Show()
				self.HonorLevelDisplay:SetPoint("TOP", self.WeeklyChest, "BOTTOM", 0, -90)
			end
		end)
	end
end)