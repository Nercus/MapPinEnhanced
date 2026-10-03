---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Reconciled with VSS_Skeleton_Camelot.lua (2026-09-28); existing point IDs retained.
local PORTAL = {

    -- Zone: Darnassus (map 1457)
    -- Darnassus (map 1457 30.06,41.44) -> Teldrassil (map 1438 55.91,89.64) via portal
    {
        fromPointID = 100102,
        fromMap = 1457,
        fromX = 0.3006,
        fromY = 0.4144,
        toPointID = 100026,
        toMap = 1438,
        toX = 0.5591,
        toY = 0.8964,
        type = "portal",
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
        travelDuration = 5,
    },

    -- Zone: Teldrassil (map 1438)
    -- Teldrassil (map 1438 55.91,89.64) -> Darnassus (map 1457 30.06,41.44) via portal
    {
        fromPointID = 100026,
        fromMap = 1438,
        fromX = 0.5591,
        fromY = 0.8964,
        toPointID = 100102,
        toMap = 1457,
        toX = 0.3006,
        toY = 0.4144,
        type = "portal",
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
        travelDuration = 5,
    },

    -- Additions from VSS_Skeleton_Camelot.lua (2026-09-28).
    -- Alterac Mountains (map 1416 12.05,56.23) -> Stormwind City (map 1453 50.04,86.99) via portal
    {
        fromPointID = 1300004,
        fromMap = 1416,
        fromX = 0.1205,
        fromY = 0.5623,
        toPointID = 1300005,
        toMap = 1453,
        toX = 0.5004,
        toY = 0.8699,
        type = "portal",
        travelDuration = 5,
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
    -- Stormwind City (map 1453 50.04,86.99) -> Alterac Mountains (map 1416 12.05,56.23) via portal
    {
        fromPointID = 1300005,
        fromMap = 1453,
        fromX = 0.5004,
        fromY = 0.8699,
        toPointID = 1300004,
        toMap = 1416,
        toX = 0.1205,
        toY = 0.5623,
        type = "portal",
        travelDuration = 5,
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

Navigation:RegisterPathData("portal", PORTAL)
