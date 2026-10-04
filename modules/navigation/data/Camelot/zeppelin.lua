---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Reconciled with VSS_Skeleton_Camelot.lua (2026-09-28); existing point IDs retained.
local ZEPPELIN = {

    -- Zone: Durotar (map 1411)
    -- Durotar (map 1411 50.57,12.66) -> Stranglethorn Vale (map 1434 31.35,30.12) via zeppelin
    {
        fromPointID = 100004,
        fromMap = 1411,
        fromX = 0.5057,
        fromY = 0.1266,
        toPointID = 200083,
        toMap = 1434,
        toX = 0.3135,
        toY = 0.3012,
        type = "zeppelin",
        transportSchedule = { routeID = 285, fromDock = 4, toDock = 3 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 114,
    },
    -- Durotar (map 1411 50.82,13.81) -> Tirisfal Glades (map 1420 60.70,58.76) via zeppelin
    {
        fromPointID = 100005,
        fromMap = 1411,
        fromX = 0.5082,
        fromY = 0.1381,
        toPointID = 200020,
        toMap = 1420,
        toX = 0.607,
        toY = 0.5876,
        type = "zeppelin",
        transportSchedule = { routeID = 302, fromDock = 13, toDock = 14 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 170,
    },

    -- Zone: Stranglethorn Vale (map 1434)
    -- Stranglethorn Vale (map 1434 31.35,30.12) -> Durotar (map 1411 50.57,12.66) via zeppelin
    {
        fromPointID = 200083,
        fromMap = 1434,
        fromX = 0.3135,
        fromY = 0.3012,
        toPointID = 100004,
        toMap = 1411,
        toX = 0.5057,
        toY = 0.1266,
        type = "zeppelin",
        transportSchedule = { routeID = 285, fromDock = 3, toDock = 4 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 141,
    },
    -- Stranglethorn Vale (map 1434 31.53,29.15) -> Tirisfal Glades (map 1420 61.88,59.10) via zeppelin
    {
        fromPointID = 200084,
        fromMap = 1434,
        fromX = 0.3153,
        fromY = 0.2915,
        toPointID = 200022,
        toMap = 1420,
        toX = 0.6188,
        toY = 0.591,
        type = "zeppelin",
        transportSchedule = { routeID = 301, fromDock = 11, toDock = 12 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 151,
    },

    -- Zone: Tirisfal Glades (map 1420)
    -- Tirisfal Glades (map 1420 60.70,58.76) -> Durotar (map 1411 50.82,13.81) via zeppelin
    {
        fromPointID = 200020,
        fromMap = 1420,
        fromX = 0.607,
        fromY = 0.5876,
        toPointID = 100005,
        toMap = 1411,
        toX = 0.5082,
        toY = 0.1381,
        type = "zeppelin",
        transportSchedule = { routeID = 302, fromDock = 14, toDock = 13 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 140,
    },
    -- Tirisfal Glades (map 1420 61.88,59.10) -> Stranglethorn Vale (map 1434 31.53,29.15) via zeppelin
    {
        fromPointID = 200022,
        fromMap = 1420,
        fromX = 0.6188,
        fromY = 0.591,
        toPointID = 200084,
        toMap = 1434,
        toX = 0.3153,
        toY = 0.2915,
        type = "zeppelin",
        transportSchedule = { routeID = 301, fromDock = 12, toDock = 11 },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        travelDuration = 135,
    },

    -- Additions from VSS_Skeleton_Camelot.lua (2026-09-28).
    -- Alterac Mountains (map 1416 12.83,51.17) -> Zephras Isle (map 2521 65.84,83.81) via zeppelin
    {
        fromPointID = 1300010,
        fromMap = 1416,
        fromX = 0.1283,
        fromY = 0.5117,
        toPointID = 1300011,
        toMap = 2521,
        toX = 0.6584,
        toY = 0.8381,
        type = "zeppelin",
        transportSchedule = { routeID = 11398, fromDock = 20, toDock = 21 },
        travelDuration = 151,
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
    -- Zephras Isle (map 2521 65.84,83.81) -> Alterac Mountains (map 1416 12.83,51.17) via zeppelin
    {
        fromPointID = 1300011,
        fromMap = 2521,
        fromX = 0.6584,
        fromY = 0.8381,
        toPointID = 1300010,
        toMap = 1416,
        toX = 0.1283,
        toY = 0.5117,
        type = "zeppelin",
        transportSchedule = { routeID = 11398, fromDock = 21, toDock = 20 },
        travelDuration = 170,
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
    -- Mulgore (map 1412 34.33,26.05) -> Zephras Isle (map 2521 57.75,81.00) via zeppelin
    {
        fromPointID = 1300012,
        fromMap = 1412,
        fromX = 0.3433,
        fromY = 0.2605,
        toPointID = 1300013,
        toMap = 2521,
        toX = 0.5775,
        toY = 0.81,
        type = "zeppelin",
        transportSchedule = { routeID = 11457, fromDock = 22, toDock = 23 },
        travelDuration = 135,
    },
    -- Zephras Isle (map 2521 57.75,81.00) -> Mulgore (map 1412 34.33,26.05) via zeppelin
    {
        fromPointID = 1300013,
        fromMap = 2521,
        fromX = 0.5775,
        fromY = 0.81,
        toPointID = 1300012,
        toMap = 1412,
        toX = 0.3433,
        toY = 0.2605,
        type = "zeppelin",
        transportSchedule = { routeID = 11457, fromDock = 23, toDock = 22 },
        travelDuration = 174,
    },
}

Navigation:RegisterPathData("zeppelin", ZEPPELIN)
