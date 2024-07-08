---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

--- Holds all the constants for the addon

MapPinEnhanced.CONSTANTS = {}


MapPinEnhanced.CONSTANTS.PIN_COLORS = {
    { color = CreateColorFromBytes(237, 179, 20, 1),  colorName = "Yellow" },
    { color = CreateColorFromBytes(96, 236, 29, 1),   colorName = "Green" },
    { color = CreateColorFromBytes(132, 196, 237, 1), colorName = "LightBlue" },
    { color = CreateColorFromBytes(42, 93, 237, 1),   colorName = "DarkBlue" },
    { color = CreateColorFromBytes(190, 139, 237, 1), colorName = "Purple" },
    { color = CreateColorFromBytes(251, 109, 197, 1), colorName = "Pink" },
    { color = CreateColorFromBytes(235, 15, 14, 1),   colorName = "Red" },
    { color = CreateColorFromBytes(237, 114, 63, 1),  colorName = "Orange" },
    { color = CreateColorFromBytes(235, 183, 139, 1), colorName = "Pale" },
}

MapPinEnhanced.CONSTANTS.PIN_COLORS_BY_NAME = {
    ["Yellow"] = CreateColorFromBytes(237, 179, 20, 1),
    ["Green"] = CreateColorFromBytes(96, 236, 29, 1),
    ["LightBlue"] = CreateColorFromBytes(132, 196, 237, 1),
    ["DarkBlue"] = CreateColorFromBytes(42, 93, 237, 1),
    ["Purple"] = CreateColorFromBytes(190, 139, 237, 1),
    ["Pink"] = CreateColorFromBytes(251, 109, 197, 1),
    ["Red"] = CreateColorFromBytes(235, 15, 14, 1),
    ["Orange"] = CreateColorFromBytes(237, 114, 63, 1),
    ["Pale"] = CreateColorFromBytes(235, 183, 139, 1),
}
