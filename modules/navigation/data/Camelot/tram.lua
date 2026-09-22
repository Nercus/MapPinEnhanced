---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local TRAM = {

    -- Zone: Ironforge (map 1455)
    -- Ironforge (map 1455 72.90,50.27) -> Stormwind City (map 1453 60.36,12.47) via tram
    {
        fromPointID = 200102,
        fromMap = 1455,
        fromX = 0.729,
        fromY = 0.5027,
        toPointID = 200096,
        toMap = 1453,
        toX = 0.6036,
        toY = 0.1247,
        type = "tram",
        travelDuration = 500,
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
    -- Stormwind City (map 1453 60.36,12.47) -> Ironforge (map 1455 72.90,50.27) via tram
    {
        fromPointID = 200096,
        fromMap = 1453,
        fromX = 0.6036,
        fromY = 0.1247,
        toPointID = 200102,
        toMap = 1455,
        toX = 0.729,
        toY = 0.5027,
        type = "tram",
        travelDuration = 500,
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
