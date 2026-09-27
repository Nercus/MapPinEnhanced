---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local ITEM = {

    -- Zone: Azshara (map 1447)
    -- current position -> Azshara (map 1447 79.20,73.60) via item
    {
        toPointID = 100070,
        toMap = 1447,
        toX = 0.792,
        toY = 0.736,
        type = "item",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 227925,
                },
            },
        },
    },

    -- Zone: Deadwind Pass (map 1430)
    -- current position -> Deadwind Pass (map 1430 47.24,75.40) via item
    {
        toPointID = 200066,
        toMap = 1430,
        toX = 0.4724,
        toY = 0.754,
        type = "item",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 22589,
                },
            },
        },
    },
    -- current position -> Deadwind Pass (map 1430 47.24,75.40) via item
    {
        toPointID = 200066,
        toMap = 1430,
        toX = 0.4724,
        toY = 0.754,
        type = "item",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 22630,
                },
            },
        },
    },
    -- current position -> Deadwind Pass (map 1430 47.24,75.40) via item
    {
        toPointID = 200066,
        toMap = 1430,
        toX = 0.4724,
        toY = 0.754,
        type = "item",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 22631,
                },
            },
        },
    },
    -- current position -> Deadwind Pass (map 1430 47.24,75.40) via item
    {
        toPointID = 200066,
        toMap = 1430,
        toX = 0.4724,
        toY = 0.754,
        type = "item",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 22632,
                },
            },
        },
    },
}

Navigation:RegisterPathData("item", ITEM)
