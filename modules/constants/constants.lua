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



MapPinEnhanced.CONSTANTS.DECIMAL_SEPARATOR = tonumber("0.5") and "," or "."


MapPinEnhanced.CONSTANTS.MENU_COLOR_BUTTON_PATTERN =
"|TInterface\\AddOns\\MapPinEnhanced\\assets\\MPHColourPicker_Body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"


---@type table<number, string>
MapPinEnhanced.CONSTANTS.MAPID_SUFFIXES = {
    [195] = "1",                                -- Kaja'mine
    [196] = "2",                                -- Kaja'mine
    [197] = "3",                                -- Kaja'mine
    [579] = "1",                                -- Lunarfall Excavation
    [580] = "2",                                -- Lunarfall Excavation
    [581] = "3",                                -- Lunarfall Excavation
    [585] = "1",                                -- Frostwall Minem
    [586] = "2",                                -- Frostwall Mine
    [587] = "3",                                -- Frostwall Mine
    [943] = FACTION_HORDE --[[@as string]],     -- Arathi Highlands Horde
    [1044] = FACTION_ALLIANCE --[[@as string]], -- Arathi Highlands Alliance
}

---@type table<number, Enum.UIMapType>
MapPinEnhanced.CONSTANTS.MAPID_MAPTYPE_OVERRIDE = {
    [101] = Enum.UIMapType.World,  -- Outland
    [125] = Enum.UIMapType.Zone,   -- Dalaran
    [126] = Enum.UIMapType.Micro,
    [501] = Enum.UIMapType.Zone,   -- Dalaran
    [502] = Enum.UIMapType.Micro,
    [572] = Enum.UIMapType.World,  -- Draenor
    [582] = Enum.UIMapType.Zone,   -- Lunarfall
    [590] = Enum.UIMapType.Zone,   -- Frostwall
    [625] = Enum.UIMapType.Orphan, -- Dalaran
    [626] = Enum.UIMapType.Micro,  -- Dalaran
    [627] = Enum.UIMapType.Zone,
    [628] = Enum.UIMapType.Micro,
    [629] = Enum.UIMapType.Micro,
}
