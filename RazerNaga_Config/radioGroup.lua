--[[
	radioGroup.lua
		Defines a radio button group
--]]

local RadioButton = RazerNaga:CreateClass('CheckButton')

--[[ Define Radio Button Logic Here ]]--

function RadioButton:New(title, value, parent)
	local f = self:Bind(CreateFrame('CheckButton', '$parent' .. title, parent, 'UIRadioButtonTemplate'))
	f:SetSize(20, 20)
	f.title = _G[f:GetName() .. 'Text']
	f.title:SetFontObject('GameFontHighlight')
	f.title:SetText(title)
	f.value = value
	f:SetScript('OnClick', f.OnClick)
	
	return f
end

function RadioButton:SetText(text)
	self.title:SetText(text)
end

function RadioButton:SetValue(value)
	self.value = value
end

function RadioButton:OnClick()
	self:GetParent():Select(self.value)
end


--[[ Radio Group Widget ]]--

local RadioGroup = RazerNaga:CreateClass('Frame')
RadioGroup.columns = 1
RadioGroup.spacing = 2
RadioGroup.padW = 4
RadioGroup.padH = 6

RazerNaga.RadioGroup = RadioGroup

function RadioGroup:New(title, parent)
	local f = self:Bind(CreateFrame('Frame', parent:GetName() .. title, parent, 'TooltipBorderBackdropTemplate'))
	f.buttons = {}

	f:SetBackdropBorderColor(0.4, 0.4, 0.4)
	f:SetBackdropColor(0.15, 0.15, 0.15, 0.5)
	
	f:SetScript('OnShow', f.OnShow)
	
	return f
end


--[[ Frame Events ]]--

function RadioGroup:OnShow()
	self:Select(self:GetSelectedValue(), true)
--	self:Layout()
end

function RadioGroup:OnSelect(value)
	error(format('Undefined method: %s:OnSelect(value)', self:GetName()), 2)
end

function RadioGroup:Add(text, value)
	table.insert(self.buttons, RadioButton:New(text, value, self))
	if self:IsVisible() then
		self:Layout()
	end
end


--[[ Update Methods ]]--

function RadioGroup:Select(value, noUpdate)
	if (not noUpdate) and value ~= self:GetSelectedValue() then
		self:OnSelect(value)
	end

	for _,b in pairs(self.buttons) do
		b:SetChecked(b.value == value)
	end
end

function RadioGroup:SetColumns(columns)
	self.columns = columns
	self:Layout()
end

function RadioGroup:Layout()
	local width, height
	if #self.buttons > 0 then
		local cols = min(self.columns, #self.buttons)
		local rows = ceil(#self.buttons / cols)
		local spacing = self.spacing
		local padW = self.padW
		local padH = self.padH
		
		local w, h = 0, 0
		for i,b in pairs(self.buttons) do
			w = max(w, b:GetWidth() + b.title:GetStringWidth() + 12)
			h = max(h, b:GetHeight())
		end
		w = w + spacing
		h = h + spacing

		for i,b in pairs(self.buttons) do
			local col = (i-1) % cols
			local row = ceil(i / cols) - 1
			b:ClearAllPoints()
			b:SetPoint('TOPLEFT', w*col + padW, -(h*row + padH))
		end

		width = w*cols - spacing + padW*2
		height = h*ceil(#self.buttons/cols) - spacing + padH*2
	else
		width = 0
		height = 0
	end

	self:SetWidth(max(width, 8))
	self:SetHeight(max(height, 8))
end


--[[ Accessors ]]--

function RadioGroup:GetSelectedValue()
	error(format('Undefined method: %s:GetSelectedValue()', self:GetName()), 2)
end