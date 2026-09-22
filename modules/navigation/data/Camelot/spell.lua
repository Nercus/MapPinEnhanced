---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local SPELL = {

    -- Zone: Darnassus (map 1457)
    -- current position -> Darnassus (map 1457 40.13,81.83) via spell
    {
        toPointID = 100101,
        toMap = 1457,
        toX = 0.4013,
        toY = 0.8183,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3565,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3565,
                },
            },
        },
        spellID = 3565,
    },

    -- Zone: Ironforge (map 1455)
    -- current position -> Ironforge (map 1455 25.52,8.41) via spell
    {
        toPointID = 200100,
        toMap = 1455,
        toX = 0.2552,
        toY = 0.0841,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3562,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3562,
                },
            },
        },
        spellID = 3562,
    },

    -- Zone: Moonglade (map 1450)
    -- current position -> Moonglade (map 1450 56.26,32.46) via spell
    {
        toPointID = 100087,
        toMap = 1450,
        toX = 0.5626,
        toY = 0.3246,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 18960,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 18960,
                },
            },
        },
        spellID = 18960,
    },

    -- Zone: Orgrimmar (map 1454)
    -- current position -> Orgrimmar (map 1454 38.57,85.95) via spell
    {
        toPointID = 100094,
        toMap = 1454,
        toX = 0.3857,
        toY = 0.8595,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3567,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3567,
                },
            },
        },
        spellID = 3567,
    },

    -- Zone: Stormwind City (map 1453)
    -- current position -> Stormwind City (map 1453 38.01,80.84) via spell
    {
        toPointID = 200095,
        toMap = 1453,
        toX = 0.3801,
        toY = 0.8084,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3561,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3561,
                },
            },
        },
        spellID = 3561,
    },

    -- Zone: Thunder Bluff (map 1456)
    -- current position -> Thunder Bluff (map 1456 22.35,16.52) via spell
    {
        toPointID = 100097,
        toMap = 1456,
        toX = 0.2235,
        toY = 0.1652,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3566,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3566,
                },
            },
        },
        spellID = 3566,
    },

    -- Zone: Undercity (map 1458)
    -- current position -> Undercity (map 1458 84.65,16.32) via spell
    {
        toPointID = 200106,
        toMap = 1458,
        toX = 0.8465,
        toY = 0.1632,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 3563,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 3563,
                },
            },
        },
        spellID = 3563,
    },
}

Navigation:RegisterPathData("spell", SPELL)
