if not _G.WorldMapFrame then return end

for _, f in next, WorldMapFrame.overlayFrames do
    if WorldMapActivityTrackerMixin and f.OnLoad == WorldMapActivityTrackerMixin.OnLoad then
    	hooksecurefunc(f, "Show", function()
			f:Hide()
		end)
    end
end