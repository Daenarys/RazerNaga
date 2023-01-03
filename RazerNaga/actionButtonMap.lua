--[[
	actionButtonMap.lua
		Maps Blizzard action buttons to their default action IDs
--]]

--[[ globals ]]--

local RazerNaga = _G[...]
local BlizzardActionButtons = {}

local function addBar(bar, page)
    if not (bar and bar.actionButtons) then return end

    page = page or bar:GetAttribute("actionpage")

    -- when assigning buttons, we skip bar 12 (totems)
	-- so shift pages above 12 down one
    if page > 12 then
        page = page - 1
    end

    local offset = (page - 1) * NUM_ACTIONBAR_BUTTONS

    for i, button in pairs(bar.actionButtons) do
        BlizzardActionButtons[i + offset] = button
     end
end
    addBar(MainMenuBar, 1) -- 1
    addBar(MultiBarRight) -- 3
    addBar(MultiBarLeft) -- 4
    addBar(MultiBarBottomRight) -- 5
    addBar(MultiBarBottomLeft) -- 6
    addBar(MultiBar5) -- 13
    addBar(MultiBar6) -- 14
    addBar(MultiBar7) -- 15

--[[ exports ]]--

RazerNaga.BlizzardActionButtons = BlizzardActionButtons