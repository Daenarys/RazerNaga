if not _G.PVEFrame then return end

hooksecurefunc('LFGDungeonReadyPopup_Update', function()
	local proposalExists, id, typeID, subtypeID, name, backgroundTexture, role, hasResponded, totalEncounters, completedEncounters, numMembers, isLeader, _, _, isSilent = GetLFGProposal()
	
	if ( subtypeID == LFG_SUBTYPEID_SCENARIO ) then
		LFGDungeonReadyDialog.background:SetDrawLayer("BACKGROUND")
		if ( LFG_IsHeroicScenario(id) ) then
			LFGDungeonReadyDialog.background:SetTexture("Interface\\LFGFrame\\UI-LFG-BACKGROUND-HeroicScenario")
		else
			LFGDungeonReadyDialog.background:SetTexture("Interface\\LFGFrame\\UI-LFG-BACKGROUND-RandomScenario")
		end
	end
end)

hooksecurefunc("LFGRewardsFrame_UpdateFrame", function(parentFrame, dungeonID)
	if (dungeonID == 2634 or dungeonID == 744 or dungeonID == 995 or dungeonID == 1146 or dungeonID == 1453 or dungeonID == 1971 or dungeonID == 2274 or dungeonID == 2874) then
		parentFrame.title:SetText(LFG_TYPE_RANDOM_TIMEWALKER_DUNGEON)
		parentFrame.description:SetText(LFD_TIMEWALKER_RANDOM_EXPLANATION)
	end

	parentFrame.title:ClearAllPoints()
	parentFrame.title:SetPoint("TOPLEFT", 10, -8)
end)