---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

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
    },
}

Navigation:RegisterPathData("zeppelin", ZEPPELIN)
