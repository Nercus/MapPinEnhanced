---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

--- Holds all the constants for the addon

local L = MapPinEnhanced.L

---@class CONSTANTS
local CONSTANTS = {}
MapPinEnhanced.CONSTANTS = CONSTANTS

CONSTANTS.PIN_COLORS = {
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

CONSTANTS.PIN_COLORS_BY_NAME = {
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

CONSTANTS.DECIMAL_SEPARATOR = IsEuropeanNumbers() and "," or "."
CONSTANTS.MENU_COLOR_BUTTON_PATTERN =
"|TInterface\\AddOns\\MapPinEnhanced\\assets\\forms\\ColourPicker_Body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
CONSTANTS.COORDS_TEXT_PATTERN = "(%.2f, %.2f)"


---@type table<number, string>
CONSTANTS.MAPID_SUFFIXES = {
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
CONSTANTS.MAPID_MAPTYPE_OVERRIDE = {
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


CONSTANTS.DEFAULT_PIN_NAME = L["Map Pin"]
CONSTANTS.DEFAULT_PIN_COLOR = "Yellow"
CONSTANTS.WAY_COMMAND_PATTERN = "/way %s %.2f %.2f %s"
CONSTANTS.PREFIX = "!MPH!"


---@enum OPTIONCATEGORY
CONSTANTS.OPTION_CATEGORIES = {
    General = "General",
    Tracker = "Tracker",
    FloatingPin = "Floating Pin"
}


CONSTANTS.CATEGORY_ORDER = {
    CONSTANTS.OPTION_CATEGORIES.General,
    CONSTANTS.OPTION_CATEGORIES.Tracker,
    CONSTANTS.OPTION_CATEGORIES.FloatingPin
}



CONSTANTS.PIN_TEXTURE_OVERRIDES = {
    ["worldquest-questmarker-questbang"] = "worldquest-tracker-questmarker",
}
