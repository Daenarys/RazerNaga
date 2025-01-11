local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
	if name == "Blizzard_GarrisonUI" then
		if _G.GarrisonBuildingFrame then
			_G.GarrisonBuildingFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonMissionFrame then
			_G.GarrisonMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonShipyardFrame then
			_G.GarrisonShipyardFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.OrderHallMissionFrame then
			_G.OrderHallMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.BFAMissionFrame then
			_G.BFAMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.CovenantMissionFrame then
			_G.CovenantMissionFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonRecruitSelectFrame then
			GarrisonRecruitSelectFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("CENTER")
			end)
		end
		if _G.GarrisonMonumentFrame then
			GarrisonMonumentFrame:HookScript("OnShow", function(self)
				self:ClearAllPoints()
				self:SetPoint("BOTTOM", 0 , 125)
			end)
		end
	end
end)