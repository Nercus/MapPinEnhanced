---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local PHASESWITCH = {

    -- Zone: Tirisfal Glades (map 18)
    -- Tirisfal Glades (map 18 69.45,62.80) -> Tirisfal Glades (map 2070 69.45,62.80) via phaseswitch
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200639,
        toMap = 2070,
        toX = 0.6945,
        toY = 0.628,
        type = "phaseswitch",
        gossip = {
            gossipOptionID = 49019,
            npcID = 141488,
        },
        requirement = {
            operation = "check",
            kind = "currentMap",
            value = 18,
        },
    },

    -- Zone: Tirisfal Glades (map 2070)
    -- Tirisfal Glades (map 2070 69.45,62.80) -> Tirisfal Glades (map 18 69.45,62.80) via phaseswitch
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200052,
        toMap = 18,
        toX = 0.6945,
        toY = 0.628,
        type = "phaseswitch",
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
        requirement = {
            operation = "check",
            kind = "currentMap",
            value = 2070,
        },
    },
}

Navigation:RegisterPathData("phaseswitch", PHASESWITCH)
