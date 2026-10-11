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
        travelDuration = 236,
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
        travelDuration = 525,
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
        travelDuration = 267,
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
        travelDuration = 295,
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
        travelDuration = 310,
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
        travelDuration = 368,
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
        travelDuration = 226,
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
        travelDuration = 336,
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
        travelDuration = 292,
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
        travelDuration = 328,
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
        travelDuration = 414,
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
        travelDuration = 280,
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
        travelDuration = 306,
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

    -- Feralas (map 1444 31.01,39.51) -> Feralas (map 1444 43.13,42.76) via ship
    {
        fromPointID = 1300006,
        fromMap = 1444,
        fromX = 0.3101,
        fromY = 0.3951,
        toPointID = 1300007,
        toMap = 1444,
        toX = 0.4313,
        toY = 0.4276,
        type = "ship",
        travelDuration = 219,
    },
    -- Feralas (map 1444 43.13,42.76) -> Feralas (map 1444 31.01,39.51) via ship
    {
        fromPointID = 1300007,
        fromMap = 1444,
        fromX = 0.4313,
        fromY = 0.4276,
        toPointID = 1300006,
        toMap = 1444,
        toX = 0.3101,
        toY = 0.3951,
        type = "ship",
        travelDuration = 325,
    },
    -- Tanaris (map 1446 68.58,22.99) -> Riverglades (map 2548 80.60,54.61) via ship
    {
        fromPointID = 1300008,
        fromMap = 1446,
        fromX = 0.6858,
        fromY = 0.2299,
        toPointID = 1300009,
        toMap = 2548,
        toX = 0.806,
        toY = 0.5461,
        type = "ship",
        travelDuration = 248,
    },
    -- Riverglades (map 2548 80.60,54.61) -> Tanaris (map 1446 68.58,22.99) via ship
    {
        fromPointID = 1300009,
        fromMap = 2548,
        fromX = 0.806,
        fromY = 0.5461,
        toPointID = 1300008,
        toMap = 1446,
        toX = 0.6858,
        toY = 0.2299,
        type = "ship",
        travelDuration = 249,
    },
}

Navigation:RegisterPathData("ship", SHIP)
