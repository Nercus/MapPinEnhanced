---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


-- *** Using Phanx's method to localize strings ***
-- You can find the original code here: https://phanx.net/addons/tutorials/localize
local L = setmetatable({}, {
    __index = function(t, k)
        local v = tostring(k)
        rawset(t, k, v)
        return v
    end
})

MapPinEnhanced.L = L
MapPinEnhanced.locale = GetLocale()
