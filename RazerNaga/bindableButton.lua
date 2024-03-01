--[[
	bindableButton:
		An abstract button class used to allow keybound to work transparently
		on both the stock blizzard bindings, and click bindings
--]]

local RazerNaga = _G[...]
local KeyBound = LibStub('LibKeyBound-1.0')

local BindableButton = RazerNaga:CreateClass('CheckButton')

-- there's a nice assumption here: all hotkey text will use the same naming
-- convention the call here is wacky because this functionality is actually
-- called for the blizzard buttons _before_ I'm able to bind the action button
-- methods to them
function BindableButton:UpdateHotkey(buttonType)
	local key = BindableButton.GetHotkey(self, buttonType)

	if ( self.HotKey:GetText() == RANGE_INDICATOR ) then
		self.HotKey:Hide();
	else
		self.HotKey:SetVertexColor(ACTIONBAR_HOTKEY_FONT_COLOR:GetRGB());
	end

	if key ~= '' and RazerNaga:ShowBindingText() and self.buttonType == 'BONUSACTIONBUTTON' then
		self.HotKey:SetText(key)
		self.HotKey:ClearAllPoints();
		self.HotKey:SetPoint("TOPLEFT", -2, -3)
		self.HotKey:Show()
	elseif key ~= '' and RazerNaga:ShowBindingText() and self.buttonType == 'SHAPESHIFTBUTTON' then
		self.HotKey:SetText(key)
		self.HotKey:ClearAllPoints()
		self.HotKey:SetPoint("TOPLEFT", -2, -3)
		self.HotKey:Show()
	elseif key ~= '' and RazerNaga:ShowBindingText() then
		self.HotKey:SetText(key)
		self.HotKey:SetSize(32, 10)
		self.HotKey:ClearAllPoints()
		self.HotKey:SetPoint("TOPLEFT", 3, -3)
		self.HotKey:Show()
	else
		--blank out non blank text, such as RANGE_INDICATOR
		self.HotKey:SetText('')
		self.HotKey:Hide()
	end
end

--returns what hotkey to display for the button
function BindableButton:GetHotkey(buttonType)
	local key = BindableButton.GetBlizzBindings(self, buttonType)
			 or BindableButton.GetClickBindings(self)

	return key and KeyBound:ToShortKey(key) or ''
end

-- returns all blizzard bindings assigned to the button
function BindableButton:GetBlizzBindings(buttonType)
	buttonType = buttonType or self.buttonType

	if buttonType then
		local id = self:GetAttribute('bindingid') or self:GetID()
		return GetBindingKey(buttonType .. id)
	end
end

-- returns all click bindings assigned to the button
function BindableButton:GetClickBindings()
	return GetBindingKey(('CLICK %s:LeftButton'):format(self:GetName()))
end

-- returns a comma separated list of all bindings for the given action button
-- used for keybound support
do
    local buffer = {}

    local function addBindings(t, ...)
        for i = 1, select("#", ...) do
            local binding = select(i, ...)
            table.insert(t, GetBindingText(binding))
        end
    end

    function BindableButton:GetBindings()
        wipe(buffer)

        addBindings(buffer, self:GetBlizzBindings())
        addBindings(buffer, self:GetClickBindings())

        return table.concat(buffer, ", ")
    end
end

--set bindings (more keybound support)
function BindableButton:SetKey(key)
	if self.buttonType then
		local id = self:GetAttribute('bindingid') or self:GetID()
		SetBinding(key, self.buttonType .. id)
	else
		SetBindingClick(key, self:GetName(), 'LeftButton')
	end
end

--clears all bindings from the button (keybound support again)
do
	local function clearBindings(...)
		for i = 1, select('#', ...) do
			SetBinding(select(i, ...), nil)
		end
	end

	function BindableButton:ClearBindings()
		clearBindings(self:GetBlizzBindings())
		clearBindings(self:GetClickBindings())
	end
end

--[[ lynn auto binding settings, for display override purposes ]]--

function BindableButton:SetAutoBinding(key)
	self:SetAutoBindingDisplayKey(key)
	self:SetKey(key)
end

function BindableButton:SetAutoBindingDisplayKey(key)
	self.autoBinding = key
end

function BindableButton:ClearAutoBindingDisplayKey()
	self:SetAutoBindingDisplayKey(nil)
end

function BindableButton:GetAutoBindingDisplayKey()
	return self.autoBinding
end

-- exports
RazerNaga.BindableButton = BindableButton