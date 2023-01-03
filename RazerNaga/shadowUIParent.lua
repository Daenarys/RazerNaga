--[[ 
	shadowUIParent.lua
		A hidden frame with the same dimensions as the UIParent
--]]

--[[ globals ]]--

local RazerNaga = _G['RazerNaga']

local ShadowUIParent = RazerNaga:CreateHiddenFrame('Frame', nil, UIParent)

ShadowUIParent:SetAllPoints(UIParent)

--[[ exports ]]--

RazerNaga.ShadowUIParent = ShadowUIParent
