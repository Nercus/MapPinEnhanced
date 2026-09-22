---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local SHIP = {

    -- Zone: Darkshore (map 1439)
    -- Darkshore (map 1439 33.19,40.13) -> Teldrassil (map 1438 54.86,96.79) via ship
    {
        fromPointID = 100029,
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
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.7154,
        fromY = 0.5634,
        toPointID = 200091,
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

    -- Zone: Stranglethorn Vale (map 1434)
    -- Stranglethorn Vale (map 1434 25.92,73.15) -> The Barrens (map 1413 63.66,38.65) via ship
    {
        fromPointID = 200079,
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
        toPointID = 100029,
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
        toPointID = 200079,
        toMap = 1434,
        toX = 0.2592,
        toY = 0.7315,
        type = "ship",
    },

    -- Zone: Wetlands (map 1437)
    -- Wetlands (map 1437 5.08,63.40) -> Dustwallow Marsh (map 1445 71.54,56.34) via ship
    {
        fromPointID = 200091,
        fromMap = 1437,
        fromX = 0.0508,
        fromY = 0.634,
        toPointID = 100060,
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
