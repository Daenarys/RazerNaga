function ApplyScrollBarArrow(frame)
	frame.Back:SetSize(18, 16)
	frame.Back:SetNormalAtlas("UI-ScrollBar-ScrollUpButton-Up")
	frame.Back:SetPushedAtlas("UI-ScrollBar-ScrollUpButton-Down")
	frame.Back:SetDisabledAtlas("UI-ScrollBar-ScrollUpButton-Disabled")
	frame.Back:SetHighlightAtlas("UI-ScrollBar-ScrollUpButton-Highlight")
	frame.Back:ClearAllPoints()
	frame.Back:SetPoint("TOPLEFT", 4, -4)

	frame.Forward:SetSize(18, 16)
	frame.Forward:SetNormalAtlas("UI-ScrollBar-ScrollDownButton-Up")
	frame.Forward:SetPushedAtlas("UI-ScrollBar-ScrollDownButton-Down")
	frame.Forward:SetDisabledAtlas("UI-ScrollBar-ScrollDownButton-Disabled")
	frame.Forward:SetHighlightAtlas("UI-ScrollBar-ScrollDownButton-Highlight")
	frame.Forward:ClearAllPoints()
	frame.Forward:SetPoint("BOTTOMLEFT", 4, 4)
end

function ApplyScrollBarTrack(frame)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", 4, -22)
	frame:SetPoint("BOTTOMRIGHT", -4, 22)
	
	frame.Begin:SetAtlas("UI-ScrollBar-EndCap-Top", true)
	frame.Begin:ClearAllPoints()
	frame.Begin:SetPoint("TOPLEFT", -4, 22)

	frame.End:SetAtlas("UI-ScrollBar-EndCap-Bottom", true)
	frame.End:ClearAllPoints()
	frame.End:SetPoint("BOTTOMLEFT", -4, -22)

	frame.Middle:SetAtlas("!UI-ScrollBar-Center", true)
end

function ApplyScrollBarThumb(frame)
	frame:SetWidth(18)

	frame.Begin:SetAtlas("UI-ScrollBar-Knob-EndCap-Top", true)
	frame.End:SetAtlas("UI-ScrollBar-Knob-EndCap-Bottom", true)
	frame.Middle:SetAtlas("UI-ScrollBar-Knob-Center", true)

	frame.Middle:ClearAllPoints()
	frame.Middle:SetPoint("TOPLEFT", 0, -5)
	frame.Middle:SetPoint("BOTTOMRIGHT", 0, 5)

	frame.upBeginTexture = "UI-ScrollBar-Knob-EndCap-Top"
	frame.upMiddleTexture = "UI-ScrollBar-Knob-Center"
	frame.upEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom"
	frame.overBeginTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Top"
	frame.overMiddleTexture = "UI-ScrollBar-Knob-MouseOver-Center"
	frame.overEndTexture = "UI-ScrollBar-Knob-MouseOver-EndCap-Bottom"
	frame.downBeginTexture = "UI-ScrollBar-Knob-EndCap-Top-Disabled"
	frame.downMiddleTexture = "UI-ScrollBar-Knob-Center-Disabled"
	frame.downEndTexture = "UI-ScrollBar-Knob-EndCap-Bottom-Disabled"
end

function ApplyDropDown(frame)
	frame.Background:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\CommonDropdownClassic")
	frame.Background:SetTexCoord(0.480469, 0.964844, 0.00390625, 0.144531)
	frame.Background:ClearAllPoints()
	frame.Background:SetPoint("TOPLEFT", -2, 1)
	frame.Background:SetPoint("BOTTOMRIGHT", 2, -4)

	frame.Arrow:SetSize(22, 22)
	frame.Arrow:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\CommonDropdownClassic")
	frame.Arrow:SetTexCoord(0.199219, 0.308594, 0.832031, 0.941406)
	frame.Arrow:ClearAllPoints()
	frame.Arrow:SetPoint("RIGHT", -2, -1)

	frame.Text:SetFontObject(GameFontHighlightSmall)
	frame.Text:ClearAllPoints()
	frame.Text:SetPoint("TOPRIGHT", frame.Arrow, "LEFT")
	frame.Text:SetPoint("TOPLEFT", 9, -8)

	hooksecurefunc(frame, "OnButtonStateChanged", function(self)
		self.Arrow:SetSize(22, 22)
		self.Arrow:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\CommonDropdownClassic")
		if self:IsEnabled() then
			if self:IsDownOver() then
				self.Arrow:SetTexCoord(0.199219, 0.308594, 0.714844, 0.824219)
			elseif self:IsOver() then
				self.Arrow:SetTexCoord(0.808594, 0.917969, 0.269531, 0.378906)
			elseif self:IsDown() then
				self.Arrow:SetTexCoord(0.199219, 0.308594, 0.597656, 0.707031)
			else
				self.Arrow:SetTexCoord(0.199219, 0.308594, 0.832031, 0.941406)
			end
		else
			self.Arrow:SetTexCoord(0.808594, 0.917969, 0.152344, 0.261719)
		end
	end)
end

function ApplyFilterDropDown(frame)
	frame.Background:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\CommonDropdownClassic")
	frame.Background:SetTexCoord(0.660156, 0.980469, 0.480469, 0.589844)
	frame.Background:ClearAllPoints()
	frame.Background:SetPoint("TOPLEFT", -3, 1)
	frame.Background:SetPoint("BOTTOMRIGHT", 3, -5)

	frame.Text:SetFontObject(GameFontHighlightSmall)

	hooksecurefunc(frame, "OnButtonStateChanged", function(self)
		self.Background:SetTexture("Interface\\AddOns\\RazerNaga_Skin\\icons\\CommonDropdownClassic")
		if self:IsEnabled() then
			if self:IsDownOver() then
				self.Background:SetTexCoord(0.332031, 0.652344, 0.480469, 0.589844)
			elseif self:IsOver() then
				self.Background:SetTexCoord(0.480469, 0.800781, 0.269531, 0.378906)
			elseif self:IsDown() then
				self.Background:SetTexCoord(0.00390625, 0.324219, 0.480469, 0.589844)
			else
				self.Background:SetTexCoord(0.660156, 0.980469, 0.480469, 0.589844)
			end
		else
			self.Background:SetTexCoord(0.480469, 0.800781, 0.152344, 0.261719)
		end
	end)
end