---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local TRAM = {

    -- Zone: Ironforge (map 1455)
    -- Ironforge (map 1455 78.02,51.37) -> Stormwind City (map 1453 69.58,30.27) via tram
    {
        fromPointID = 200105,
        fromMap = 1455,
        fromX = 0.7802,
        fromY = 0.5137,
        toPointID = 200099,
        toMap = 1453,
        toX = 0.6958,
        toY = 0.3027,
        type = "tram",
        transportSchedule = { routeID = 176080, fromDock = 1101, toDock = 1102 },
        -- Two loading transitions plus station walks, rounded up at 7 yd/s.
        transportAccessSeconds = 38,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },

    -- Zone: Stormwind City (map 1453)
    -- Stormwind City (map 1453 69.58,30.27) -> Ironforge (map 1455 78.02,51.37) via tram
    {
        fromPointID = 200099,
        fromMap = 1453,
        fromX = 0.6958,
        fromY = 0.3027,
        toPointID = 200105,
        toMap = 1455,
        toX = 0.7802,
        toY = 0.5137,
        type = "tram",
        transportSchedule = { routeID = 176080, fromDock = 1102, toDock = 1101 },
        -- Two loading transitions plus station walks, rounded up at 7 yd/s.
        transportAccessSeconds = 38,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
}

Navigation:RegisterPathData("tram", TRAM)
