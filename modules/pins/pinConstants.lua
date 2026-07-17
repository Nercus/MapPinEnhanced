---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")


---@enum (key) PinColor
Pins.PIN_COLORS_BY_NAME = {
    ["Red"] = CreateColor(0.929, 0.239, 0.212, 1),
    ["Orange"] = CreateColor(0.953, 0.506, 0.157, 1),
    ["Pale"] = CreateColor(0.925, 0.678, 0.412, 1),
    ["Yellow"] = CreateColor(0.949, 0.788, 0.149, 1),
    ["Green"] = CreateColor(0.349, 0.780, 0.345, 1),
    ["LightBlue"] = CreateColor(0.286, 0.753, 0.925, 1),
    ["DarkBlue"] = CreateColor(0.349, 0.518, 1.000, 1),
    ["Purple"] = CreateColor(0.639, 0.388, 0.925, 1),
    ["Pink"] = CreateColor(0.925, 0.424, 0.737, 1),
}

---@type PinColor
Pins.DEFAULT_COLOR = "Yellow"

---@class PinIcon
---@field path string the path to the icon, if usesAtlas is true, this is the atlas name
---@field usesAtlas boolean if true, the path is an atlas, otherwise it is a file path
---@field offset {x: number, y: number}? optional offset for the icon, if not set, it will be
---@field scale number? optional scale for the icon, if not set, it will be 1

---@type PinIcon[] different icon that have some offsets and information about how to use them, icons outside this list can still be used but may look weird in some cases
Pins.PIN_ICONS = {
    ["delves-bountiful"] = {
        path = "delves-bountiful",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["delves-regular"] = {
        path = "delves-regular",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["Dungeon"] = {
        path = "Dungeon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1.3
    },
    ["Raid"] = {
        path = "Raid",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1.3
    },
    ["VignetteKill-SuperTracked"] = {
        path = "VignetteKill-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["VignetteKill"] = {
        path = "VignetteKill",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["minimap-genericevent-hornicon-supertracked"] = {
        path = "minimap-genericevent-hornicon-supertracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["questbonusobjective-SuperTracked"] = {
        path = "questbonusobjective-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["vignettekillboss-SuperTracked"] = {
        path = "vignettekillboss-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["VignetteKillElite-SuperTracked"] = {
        path = "VignetteKillElite-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["QuestNormal"] = {
        path = "QuestNormal",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["TaxiNode_Continent_Alliance"] = {
        path = "TaxiNode_Continent_Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["AllianceWarfrontMapBanner"] = {
        path = "AllianceWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["HordeWarfrontMapBanner"] = {
        path = "HordeWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
}
