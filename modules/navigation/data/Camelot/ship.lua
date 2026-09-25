---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local SHIP = {

    -- Zone: Darkshore (map 1439)
    -- Darkshore (map 1439 30.74,41.03) -> Stormwind City (map 1453 22.53,56.20) via ship
    {
        fromPointID = 100029,
        fromMap = 1439,
        fromX = 0.3074,
        fromY = 0.4103,
        toPointID = 200097,
        toMap = 1453,
        toX = 0.2253,
        toY = 0.562,
        type = "ship",
    },
    -- Darkshore (map 1439 32.42,43.77) -> Hillsbrad Foothills (map 1424 50.57,69.67) via ship
    {
        fromPointID = 100030,
        fromMap = 1439,
        fromX = 0.3242,
        fromY = 0.4377,
        toPointID = 200046,
        toMap = 1424,
        toX = 0.5057,
        toY = 0.6967,
        type = "ship",
    },
    -- Darkshore (map 1439 32.42,43.77) -> Wetlands (map 1437 4.64,57.17) via ship
    {
        fromPointID = 100030,
        fromMap = 1439,
        fromX = 0.3242,
        fromY = 0.4377,
        toPointID = 200092,
        toMap = 1437,
        toX = 0.0464,
        toY = 0.5717,
        type = "ship",
    },
    -- Darkshore (map 1439 33.19,40.13) -> Teldrassil (map 1438 54.86,96.79) via ship
    {
        fromPointID = 100031,
        fromMap = 1439,
        fromX = 0.3319,
        fromY = 0.4013,
        toPointID = 100025,
        toMap = 1438,
        toX = 0.5486,
        toY = 0.9679,
        type = "ship",
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
        toRegion = "ruttheran",
    },

    -- Zone: Dustwallow Marsh (map 1445)
    -- Dustwallow Marsh (map 1445 71.54,56.34) -> Wetlands (map 1437 5.08,63.40) via ship
    {
        fromPointID = 100062,
        fromMap = 1445,
        fromX = 0.7154,
        fromY = 0.5634,
        toPointID = 200093,
        toMap = 1437,
        toX = 0.0508,
        toY = 0.634,
        type = "ship",
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

    -- Zone: Hillsbrad Foothills (map 1424)
    -- Hillsbrad Foothills (map 1424 50.57,69.67) -> Darkshore (map 1439 32.42,43.77) via ship
    {
        fromPointID = 200046,
        fromMap = 1424,
        fromX = 0.5057,
        fromY = 0.6967,
        toPointID = 100030,
        toMap = 1439,
        toX = 0.3242,
        toY = 0.4377,
        type = "ship",
    },

    -- Zone: Stormwind City (map 1453)
    -- Stormwind City (map 1453 22.53,56.20) -> Darkshore (map 1439 30.74,41.03) via ship
    {
        fromPointID = 200097,
        fromMap = 1453,
        fromX = 0.2253,
        fromY = 0.562,
        toPointID = 100029,
        toMap = 1439,
        toX = 0.3074,
        toY = 0.4103,
        type = "ship",
    },

    -- Zone: Stranglethorn Vale (map 1434)
    -- Stranglethorn Vale (map 1434 25.92,73.15) -> The Barrens (map 1413 63.66,38.65) via ship
    {
        fromPointID = 200080,
        fromMap = 1434,
        fromX = 0.2592,
        fromY = 0.7315,
        toPointID = 100023,
        toMap = 1413,
        toX = 0.6366,
        toY = 0.3865,
        type = "ship",
    },

    -- Zone: Teldrassil (map 1438)
    -- Teldrassil (map 1438 54.86,96.79) -> Darkshore (map 1439 33.19,40.13) via ship
    {
        fromPointID = 100025,
        fromMap = 1438,
        fromX = 0.5486,
        fromY = 0.9679,
        toPointID = 100031,
        toMap = 1439,
        toX = 0.3319,
        toY = 0.4013,
        type = "ship",
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
        fromRegion = "ruttheran",
    },

    -- Zone: The Barrens (map 1413)
    -- The Barrens (map 1413 63.66,38.65) -> Stranglethorn Vale (map 1434 25.92,73.15) via ship
    {
        fromPointID = 100023,
        fromMap = 1413,
        fromX = 0.6366,
        fromY = 0.3865,
        toPointID = 200080,
        toMap = 1434,
        toX = 0.2592,
        toY = 0.7315,
        type = "ship",
    },

    -- Zone: Wetlands (map 1437)
    -- Wetlands (map 1437 4.64,57.17) -> Hillsbrad Foothills (map 1424 50.57,69.67) via ship
    {
        fromPointID = 200092,
        fromMap = 1437,
        fromX = 0.0464,
        fromY = 0.5717,
        toPointID = 200046,
        toMap = 1424,
        toX = 0.5057,
        toY = 0.6967,
        type = "ship",
    },
    -- Wetlands (map 1437 4.64,57.17) -> Darkshore (map 1439 32.42,43.77) via ship
    {
        fromPointID = 200092,
        fromMap = 1437,
        fromX = 0.0464,
        fromY = 0.5717,
        toPointID = 100030,
        toMap = 1439,
        toX = 0.3242,
        toY = 0.4377,
        type = "ship",
    },
    -- Wetlands (map 1437 5.08,63.40) -> Dustwallow Marsh (map 1445 71.54,56.34) via ship
    {
        fromPointID = 200093,
        fromMap = 1437,
        fromX = 0.0508,
        fromY = 0.634,
        toPointID = 100062,
        toMap = 1445,
        toX = 0.7154,
        toY = 0.5634,
        type = "ship",
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

Navigation:RegisterPathData("ship", SHIP)
