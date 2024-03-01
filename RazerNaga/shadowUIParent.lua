local RazerNaga = _G[...]

local ShadowUIParent = RazerNaga:CreateHiddenFrame('Frame', nil, UIParent)

ShadowUIParent:SetAllPoints(UIParent)

RazerNaga.ShadowUIParent = ShadowUIParent