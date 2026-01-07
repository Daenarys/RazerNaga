if not _G.EditModeManagerFrame then return end

ApplyDropDown(EditModeManagerFrame.LayoutDropdown)

EditModeSystemSettingsDialog:HookScript("OnShow", function(self)
	for _, frame in next, { self.Settings:GetChildren() } do
		if frame.Dropdown then
			ApplyDropDown(frame.Dropdown)
		end
	end
end)