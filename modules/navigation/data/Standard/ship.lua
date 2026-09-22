---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local SHIP = {

    -- Zone: Amirdrassil (map 2239)
    -- Amirdrassil (map 2239 49.12,1.40) -> Ruins of Gilneas (map 217 63.64,95.76) via ship
    {
        fromPointID = 1100223,
        fromMap = 2239,
        fromX = 0.4912,
        fromY = 0.014,
        toPointID = 200389,
        toMap = 217,
        toX = 0.6364,
        toY = 0.9576,
        type = "ship",
    },

    -- Zone: Boralus (map 1161)
    -- Boralus (map 1161 77.62,26.15) -> Stormwind City (map 84 22.43,55.93) via ship
    {
        fromPointID = 800088,
        fromMap = 1161,
        fromX = 0.7762,
        fromY = 0.2615,
        toPointID = 200280,
        toMap = 84,
        toX = 0.2243,
        toY = 0.5593,
        type = "ship",
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
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },

    -- Zone: Borean Tundra (map 114)
    -- Borean Tundra (map 114 59.68,69.41) -> Stormwind City (map 84 18.02,25.84) via ship
    {
        fromPointID = 400010,
        fromMap = 114,
        fromX = 0.5968,
        fromY = 0.6941,
        toPointID = 200279,
        toMap = 84,
        toX = 0.1802,
        toY = 0.2584,
        type = "ship",
        travelDuration = 177,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "flag",
                            value = "legionBoatLock",
                        },
                    },
                },
            },
        },
    },
    -- Borean Tundra (map 114 78.92,53.65) -> Dragonblight (map 115 47.94,78.76) via ship
    {
        fromPointID = 400014,
        fromMap = 114,
        fromX = 0.7892,
        fromY = 0.5365,
        toPointID = 400021,
        toMap = 115,
        toX = 0.4794,
        toY = 0.7876,
        type = "ship",
    },

    -- Zone: Dazar'alor (map 1165)
    -- Dazar'alor (map 1165 52.83,95.78) -> Zuldazar (map 862 53.68,61.56) via ship
    {
        fromPointID = 900093,
        fromMap = 1165,
        fromX = 0.5283,
        fromY = 0.9578,
        toPointID = 900016,
        toMap = 862,
        toX = 0.5368,
        toY = 0.6156,
        type = "ship",
        travelDuration = 30,
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
    -- Dazar'alor (map 1165 52.83,95.78) -> Zuldazar (map 862 69.50,67.00) via ship
    {
        fromPointID = 900093,
        fromMap = 1165,
        fromX = 0.5283,
        fromY = 0.9578,
        toPointID = 900026,
        toMap = 862,
        toX = 0.695,
        toY = 0.67,
        type = "ship",
        travelDuration = 50,
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

    -- Zone: Dragonblight (map 115)
    -- Dragonblight (map 115 47.94,78.76) -> Borean Tundra (map 114 78.92,53.65) via ship
    {
        fromPointID = 400021,
        fromMap = 115,
        fromX = 0.4794,
        fromY = 0.7876,
        toPointID = 400014,
        toMap = 114,
        toX = 0.7892,
        toY = 0.5365,
        type = "ship",
    },
    -- Dragonblight (map 115 49.64,78.43) -> Howling Fjord (map 117 23.46,57.75) via ship
    {
        fromPointID = 400025,
        fromMap = 115,
        fromX = 0.4964,
        fromY = 0.7843,
        toPointID = 400052,
        toMap = 117,
        toX = 0.2346,
        toY = 0.5775,
        type = "ship",
    },

    -- Zone: Dustwallow Marsh (map 70)
    -- Dustwallow Marsh (map 70 71.51,56.34) -> Wetlands (map 56 6.37,62.24) via ship
    {
        fromPointID = 100178,
        fromMap = 70,
        fromX = 0.7151,
        fromY = 0.5634,
        toPointID = 200261,
        toMap = 56,
        toX = 0.0637,
        toY = 0.6224,
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

    -- Zone: Echo Isles (map 463)
    -- Echo Isles (map 463 70.90,38.23) -> Zuldazar (map 862 58.02,65.07) via ship
    {
        fromPointID = 100445,
        fromMap = 463,
        fromX = 0.709,
        fromY = 0.3823,
        toPointID = 900021,
        toMap = 862,
        toX = 0.5802,
        toY = 0.6507,
        type = "ship",
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
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },

    -- Zone: Howling Fjord (map 117)
    -- Howling Fjord (map 117 23.46,57.75) -> Dragonblight (map 115 49.64,78.43) via ship
    {
        fromPointID = 400052,
        fromMap = 117,
        fromX = 0.2346,
        fromY = 0.5775,
        toPointID = 400025,
        toMap = 115,
        toX = 0.4964,
        toY = 0.7843,
        type = "ship",
    },
    -- Howling Fjord (map 117 61.33,62.60) -> Wetlands (map 56 5.10,55.72) via ship
    {
        fromPointID = 400063,
        fromMap = 117,
        fromX = 0.6133,
        fromY = 0.626,
        toPointID = 200260,
        toMap = 56,
        toX = 0.051,
        toY = 0.5572,
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

    -- Zone: Northern Barrens (map 10)
    -- Northern Barrens (map 10 70.16,73.27) -> The Cape of Stranglethorn (map 210 39.02,67.01) via ship
    {
        fromPointID = 100053,
        fromMap = 10,
        fromX = 0.7016,
        fromY = 0.7327,
        toPointID = 200379,
        toMap = 210,
        toX = 0.3902,
        toY = 0.6701,
        type = "ship",
    },

    -- Zone: Ruins of Gilneas (map 217)
    -- Ruins of Gilneas (map 217 63.64,95.76) -> Amirdrassil (map 2239 49.12,1.40) via ship
    {
        fromPointID = 200389,
        fromMap = 217,
        fromX = 0.6364,
        fromY = 0.9576,
        toPointID = 1100223,
        toMap = 2239,
        toX = 0.4912,
        toY = 0.014,
        type = "ship",
    },

    -- Zone: Stormwind City (map 84)
    -- Stormwind City (map 84 18.02,25.84) -> Borean Tundra (map 114 59.68,69.41) via ship
    {
        fromPointID = 200279,
        fromMap = 84,
        fromX = 0.1802,
        fromY = 0.2584,
        toPointID = 400010,
        toMap = 114,
        toX = 0.5968,
        toY = 0.6941,
        type = "ship",
        travelDuration = 177,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "flag",
                            value = "legionBoatLock",
                        },
                    },
                },
            },
        },
    },
    -- Stormwind City (map 84 22.43,55.93) -> Boralus (map 1161 77.62,26.15) via ship
    {
        fromPointID = 200280,
        fromMap = 84,
        fromX = 0.2243,
        fromY = 0.5593,
        toPointID = 800088,
        toMap = 1161,
        toX = 0.7762,
        toY = 0.2615,
        type = "ship",
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
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },
    -- Stormwind City (map 84 22.51,56.18) -> The Waking Shores (map 2022 82.16,30.76) via ship
    {
        fromPointID = 200281,
        fromMap = 84,
        fromX = 0.2251,
        fromY = 0.5618,
        toPointID = 1100013,
        toMap = 2022,
        toX = 0.8216,
        toY = 0.3076,
        type = "ship",
        travelDuration = 150,
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

    -- Zone: The Cape of Stranglethorn (map 210)
    -- The Cape of Stranglethorn (map 210 39.02,67.01) -> Northern Barrens (map 10 70.16,73.27) via ship
    {
        fromPointID = 200379,
        fromMap = 210,
        fromX = 0.3902,
        fromY = 0.6701,
        toPointID = 100053,
        toMap = 10,
        toX = 0.7016,
        toY = 0.7327,
        type = "ship",
    },

    -- Zone: The Waking Shores (map 2022)
    -- The Waking Shores (map 2022 82.16,30.76) -> Stormwind City (map 84 22.51,56.18) via ship
    {
        fromPointID = 1100013,
        fromMap = 2022,
        fromX = 0.8216,
        fromY = 0.3076,
        toPointID = 200281,
        toMap = 84,
        toX = 0.2251,
        toY = 0.5618,
        type = "ship",
        travelDuration = 150,
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

    -- Zone: Wetlands (map 56)
    -- Wetlands (map 56 5.10,55.72) -> Howling Fjord (map 117 61.33,62.60) via ship
    {
        fromPointID = 200260,
        fromMap = 56,
        fromX = 0.051,
        fromY = 0.5572,
        toPointID = 400063,
        toMap = 117,
        toX = 0.6133,
        toY = 0.626,
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
    -- Wetlands (map 56 6.37,62.24) -> Dustwallow Marsh (map 70 71.51,56.34) via ship
    {
        fromPointID = 200261,
        fromMap = 56,
        fromX = 0.0637,
        fromY = 0.6224,
        toPointID = 100178,
        toMap = 70,
        toX = 0.7151,
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

    -- Zone: Zuldazar (map 862)
    -- Zuldazar (map 862 47.93,70.48) -> Zuldazar (map 862 53.68,61.56) via ship
    {
        fromPointID = 900015,
        fromMap = 862,
        fromX = 0.4793,
        fromY = 0.7048,
        toPointID = 900016,
        toMap = 862,
        toX = 0.5368,
        toY = 0.6156,
        type = "ship",
        travelDuration = 30,
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
    -- Zuldazar (map 862 53.68,61.56) -> Dazar'alor (map 1165 52.83,95.78) via ship
    {
        fromPointID = 900016,
        fromMap = 862,
        fromX = 0.5368,
        fromY = 0.6156,
        toPointID = 900093,
        toMap = 1165,
        toX = 0.5283,
        toY = 0.9578,
        type = "ship",
        travelDuration = 30,
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
    -- Zuldazar (map 862 53.68,61.56) -> Zuldazar (map 862 47.93,70.48) via ship
    {
        fromPointID = 900016,
        fromMap = 862,
        fromX = 0.5368,
        fromY = 0.6156,
        toPointID = 900015,
        toMap = 862,
        toX = 0.4793,
        toY = 0.7048,
        type = "ship",
        travelDuration = 30,
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
    -- Zuldazar (map 862 58.02,65.07) -> Echo Isles (map 463 70.90,38.23) via ship
    {
        fromPointID = 900021,
        fromMap = 862,
        fromX = 0.5802,
        fromY = 0.6507,
        toPointID = 100445,
        toMap = 463,
        toX = 0.709,
        toY = 0.3823,
        type = "ship",
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
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Zuldazar (map 862 69.50,67.00) -> Dazar'alor (map 1165 52.83,95.78) via ship
    {
        fromPointID = 900026,
        fromMap = 862,
        fromX = 0.695,
        fromY = 0.67,
        toPointID = 900093,
        toMap = 1165,
        toX = 0.5283,
        toY = 0.9578,
        type = "ship",
        travelDuration = 50,
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
    -- Zuldazar (map 862 69.50,67.00) -> Zuldazar (map 862 82.43,46.85) via ship
    {
        fromPointID = 900026,
        fromMap = 862,
        fromX = 0.695,
        fromY = 0.67,
        toPointID = 900031,
        toMap = 862,
        toX = 0.8243,
        toY = 0.4685,
        type = "ship",
        travelDuration = 45,
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
    -- Zuldazar (map 862 78.66,12.62) -> Zuldazar (map 862 82.43,46.85) via ship
    {
        fromPointID = 900029,
        fromMap = 862,
        fromX = 0.7866,
        fromY = 0.1262,
        toPointID = 900031,
        toMap = 862,
        toX = 0.8243,
        toY = 0.4685,
        type = "ship",
        travelDuration = 50,
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
    -- Zuldazar (map 862 82.43,46.85) -> Zuldazar (map 862 69.50,67.00) via ship
    {
        fromPointID = 900031,
        fromMap = 862,
        fromX = 0.8243,
        fromY = 0.4685,
        toPointID = 900026,
        toMap = 862,
        toX = 0.695,
        toY = 0.67,
        type = "ship",
        travelDuration = 45,
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
    -- Zuldazar (map 862 82.43,46.85) -> Zuldazar (map 862 78.66,12.62) via ship
    {
        fromPointID = 900031,
        fromMap = 862,
        fromX = 0.8243,
        fromY = 0.4685,
        toPointID = 900029,
        toMap = 862,
        toX = 0.7866,
        toY = 0.1262,
        type = "ship",
        travelDuration = 50,
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

Navigation:RegisterPathData("ship", SHIP)
