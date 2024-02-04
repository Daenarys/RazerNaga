local OverrideController = CreateFrame('Frame', nil, nil, 'SecureHandlerAttributeTemplate')
RazerNaga.OverrideController = OverrideController

function OverrideController:OnLoad()
	self:SetAttributeNoHandler("_onattributechanged", [[
		if name == "overrideui" then
			for _, frame in pairs(myFrames) do
				frame:SetAttribute("state-overrideui", value == 1)
			end
		elseif name == "petbattleui" then
			for _, frame in pairs(myFrames) do
				frame:SetAttribute("state-petbattleui", value == 1)
			end
		elseif name == "overridepage" then
			for _, frame in pairs(myFrames) do
				frame:SetAttribute("state-overridepage", value)
			end
		else
			local page
			if HasVehicleActionBar and HasVehicleActionBar() then
				page = GetVehicleBarIndex() or 0
			elseif HasOverrideActionBar and HasOverrideActionBar() then
				page = GetOverrideBarIndex() or 0
			elseif HasTempShapeshiftActionBar and HasTempShapeshiftActionBar() then
				page = GetTempShapeshiftBarIndex() or 0
			elseif GetBonusBarOffset() > 4 then
				page = GetBonusBarOffset() + 6
			else
				page = 0
			end

			if self:GetAttribute("overridepage") ~= page then
				self:SetAttribute("overridepage", page)
			end
		end
	]])

	self:WrapScript(OverrideActionBarButton1, "OnShow", [[
		control:SetAttribute("overrideui", 1)
	]])

	self:WrapScript(OverrideActionBarButton1, "OnHide", [[
		control:SetAttribute("overrideui", 0)
	]])

	-- init
	self:Execute([[ myFrames = table.new() ]])

	for attribute, driver in pairs {
		form = '[form]1;0',
		overridebar = '[overridebar]1;0',
		possessbar = '[possessbar]1;0',
		sstemp = '[shapeshift]1;0',
		vehicle = '[@vehicle,exists]1;0',
		vehicleui = '[vehicleui]1;0',
		petbattleui = '[petbattle]1;0',
		bonusbar = '[bonusbar:5]1;0'
	} do
		RegisterAttributeDriver(self, attribute, driver)
	end

	RazerNaga.RegisterCallback(self, 'LAYOUT_LOADED')
	RazerNaga.RegisterCallback(self, 'USE_OVERRRIDE_UI_CHANGED')
	self:SetAttributeNoHandler('overrideui', OverrideActionBarButton1:IsVisible())
	self.OnLoad = nil
end

function OverrideController:LAYOUT_LOADED()
	self:SetShowOverrideUI(RazerNaga:UsingOverrideUI())
end

function OverrideController:USE_OVERRRIDE_UI_CHANGED(_, show)
	self:SetShowOverrideUI(show)
end

function OverrideController:Add(frame)
	self:SetFrameRef('add', frame)
	self:Execute([[ table.insert(myFrames, self:GetFrameRef('add')) ]])

	-- initialize state
	frame:SetAttribute('state-overrideui', tonumber(self:GetAttribute('overrideui')) == 1)
	frame:SetAttribute('state-petbattleui', tonumber(self:GetAttribute('petbattleui')) == 1)
	frame:SetAttribute('state-overridepage', self:GetAttribute('overridepage') or 0)
end

function OverrideController:Remove(frame)
	self:SetFrameRef('rem', frame)

	self:Execute([[
		for i, frame in pairs(myFrames) do
			if frame == self:GetFrameRef('rem') then
				table.remove(myFrames, i)
				break
			end
		end
	]])
end

local originalParent = nil
function OverrideController:SetShowOverrideUI(show)
	if show then
		if originalParent ~= nil then
			OverrideActionBar:SetParent(originalParent)
			originalParent = nil
		end
	elseif originalParent == nil then
		originalParent = OverrideActionBar:GetParent()
		OverrideActionBar:SetParent(UIHider)
	end
end

function OverrideController:OverrideBarActive()
	return (self:GetAttribute("overridepage") or 0) > 10
end

OverrideController:OnLoad()