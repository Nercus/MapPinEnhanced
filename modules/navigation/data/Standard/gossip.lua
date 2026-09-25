---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local GOSSIP = {

    -- Zone: Boralus (map 1161)
    -- Boralus (map 1161 67.95,26.69) -> Vol'dun (map 864 35.60,33.17) via gossip
    {
        fromPointID = 800076,
        fromMap = 1161,
        fromX = 0.6795,
        fromY = 0.2669,
        toPointID = 900056,
        toMap = 864,
        toX = 0.356,
        toY = 0.3317,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 48163,
            npcID = 135681,
        },
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
                    kind = "questCompleted",
                    value = 51572,
                },
            },
        },
    },
    -- Boralus (map 1161 67.95,26.69) -> Zuldazar (map 862 40.68,70.86) via gossip
    {
        fromPointID = 800076,
        fromMap = 1161,
        fromX = 0.6795,
        fromY = 0.2669,
        toPointID = 900010,
        toMap = 862,
        toX = 0.4068,
        toY = 0.7086,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 48171,
            npcID = 135681,
        },
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
                    kind = "questCompleted",
                    value = 51308,
                },
            },
        },
    },
    -- Boralus (map 1161 67.95,26.69) -> Nazmir (map 863 61.95,39.92) via gossip
    {
        fromPointID = 800076,
        fromMap = 1161,
        fromX = 0.6795,
        fromY = 0.2669,
        toPointID = 900048,
        toMap = 863,
        toX = 0.6195,
        toY = 0.3992,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 48170,
            npcID = 135681,
        },
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
                    kind = "questCompleted",
                    value = 51571,
                },
            },
        },
    },

    -- Zone: Dazar'alor (map 1165)
    -- Dazar'alor (map 1165 41.83,87.61) -> Mechagon Island (map 1462 75.73,21.32) via gossip
    {
        fromPointID = 900086,
        fromMap = 1165,
        fromX = 0.4183,
        fromY = 0.8761,
        toPointID = 800104,
        toMap = 1462,
        toX = 0.7573,
        toY = 0.2132,
        type = "gossip",
        travelDuration = 20,
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
                    kind = "questCompleted",
                    value = 55651,
                },
            },
        },
    },

    -- Zone: Drustvar (map 896)
    -- Drustvar (map 896 20.60,43.34) -> Zuldazar (map 862 58.40,62.50) via gossip
    {
        fromPointID = 800022,
        fromMap = 896,
        fromX = 0.206,
        fromY = 0.4334,
        toPointID = 900023,
        toMap = 862,
        toX = 0.584,
        toY = 0.625,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51340,
                },
            },
        },
    },

    -- Zone: Mechagon Island (map 1462)
    -- Mechagon Island (map 1462 75.49,22.66) -> Dazar'alor (map 1165 41.75,87.43) via gossip
    {
        fromPointID = 800103,
        fromMap = 1462,
        fromX = 0.7549,
        fromY = 0.2266,
        toPointID = 900085,
        toMap = 1165,
        toX = 0.4175,
        toY = 0.8743,
        type = "gossip",
        travelDuration = 20,
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
                    kind = "questCompleted",
                    value = 55651,
                },
            },
        },
    },

    -- Zone: Nazmir (map 863)
    -- Nazmir (map 863 62.06,40.08) -> Boralus (map 1161 70.22,27.06) via gossip
    {
        fromPointID = 900049,
        fromMap = 863,
        fromX = 0.6206,
        fromY = 0.4008,
        toPointID = 800083,
        toMap = 1161,
        toX = 0.7022,
        toY = 0.2706,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 48827,
            npcID = 139620,
        },
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
                    kind = "questCompleted",
                    value = 51571,
                },
            },
        },
    },

    -- Zone: Oribos (map 1670)
    -- Oribos (map 1670 38.88,70.00) -> Zereth Mortis (map 1970 33.27,69.43) via gossip
    {
        fromPointID = 1000169,
        fromMap = 1670,
        fromX = 0.3888,
        fromY = 0.7,
        toPointID = 1000323,
        toMap = 1970,
        toX = 0.3327,
        toY = 0.6943,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 53550,
            npcID = 159478,
        },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 64957,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 64944,
                },
            },
        },
    },

    -- Zone: Silithus (map 81)
    -- Silithus (map 81 78.93,21.97) -> Chamber of Heart (map 1021 50.22,35.92) via gossip
    {
        fromPointID = 100246,
        fromMap = 81,
        fromX = 0.7893,
        fromY = 0.2197,
        toPointID = 100459,
        toMap = 1021,
        toX = 0.5022,
        toY = 0.3592,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 47635,
            npcID = 128607,
        },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Silithus",
                },
            },
        },
    },

    -- Zone: Stormsong Valley (map 942)
    -- Stormsong Valley (map 942 51.43,33.75) -> Zuldazar (map 862 58.40,62.50) via gossip
    {
        fromPointID = 800048,
        fromMap = 942,
        fromX = 0.5143,
        fromY = 0.3375,
        toPointID = 900023,
        toMap = 862,
        toX = 0.584,
        toY = 0.625,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51696,
                },
            },
        },
    },
    -- Stormsong Valley (map 942 51.95,24.46) -> Zuldazar (map 862 58.40,62.50) via gossip
    {
        fromPointID = 800049,
        fromMap = 942,
        fromX = 0.5195,
        fromY = 0.2446,
        toPointID = 900023,
        toMap = 862,
        toX = 0.584,
        toY = 0.625,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51532,
                },
            },
        },
    },

    -- Zone: The Vindicaar (map 831)
    -- Krokuun (map 831 43.42,23.19) -> Arcatraz L (map 889 41.20,74.29) via gossip
    {
        fromPointID = 700288,
        fromMap = 831,
        fromX = 0.4342,
        fromY = 0.2319,
        toPointID = 300163,
        toMap = 889,
        toX = 0.412,
        toY = 0.7429,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 46719,
            npcID = 121263,
        },
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questActive",
                    value = 47134,
                },
            },
        },
    },

    -- Zone: Tiragarde Sound (map 895)
    -- Tiragarde Sound (map 895 87.85,51.18) -> Zuldazar (map 862 58.40,62.50) via gossip
    {
        fromPointID = 800017,
        fromMap = 895,
        fromX = 0.8785,
        fromY = 0.5118,
        toPointID = 900023,
        toMap = 862,
        toX = 0.584,
        toY = 0.625,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51421,
                },
            },
        },
    },

    -- Zone: Tirisfal Glades (map 18)
    -- Tirisfal Glades (map 18 69.45,62.80) -> Hellfire Peninsula (map 100 89.16,49.56) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 300020,
        toMap = 100,
        toX = 0.8916,
        toY = 0.4956,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 69.45,62.80) -> Silvermoon City (map 110 49.49,14.80) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200340,
        toMap = 110,
        toX = 0.4949,
        toY = 0.148,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 69.45,62.80) -> Howling Fjord (map 117 79.00,28.92) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 400065,
        toMap = 117,
        toX = 0.79,
        toY = 0.2892,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 69.45,62.80) -> Northern Stranglethorn (map 50 37.23,50.48) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200223,
        toMap = 50,
        toX = 0.3723,
        toY = 0.5048,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 69.45,62.80) -> Orgrimmar (map 85 57.10,89.81) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 69.45,62.80) -> Undercity (map 90 89.16,49.56) via gossip
    {
        fromPointID = 200052,
        fromMap = 18,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200333,
        toMap = 90,
        toX = 0.8916,
        toY = 0.4956,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },

    -- Zone: Tirisfal Glades (map 2070)
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Hellfire Peninsula (map 100 89.16,49.56) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 300020,
        toMap = 100,
        toX = 0.8916,
        toY = 0.4956,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Silvermoon City (map 110 49.49,14.80) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200340,
        toMap = 110,
        toX = 0.4949,
        toY = 0.148,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Howling Fjord (map 117 79.00,28.92) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 400065,
        toMap = 117,
        toX = 0.79,
        toY = 0.2892,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Northern Stranglethorn (map 50 37.23,50.48) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200223,
        toMap = 50,
        toX = 0.3723,
        toY = 0.5048,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Orgrimmar (map 85 57.10,89.81) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 69.45,62.80) -> Undercity (map 90 89.16,49.56) via gossip
    {
        fromPointID = 200639,
        fromMap = 2070,
        fromX = 0.6945,
        fromY = 0.628,
        toPointID = 200333,
        toMap = 90,
        toX = 0.8916,
        toY = 0.4956,
        type = "gossip",
        travelDuration = 10,
        gossip = {
            gossipOptionID = 49018,
            npcID = 141488,
        },
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
                    value = "UndercityOoze",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 51443,
                },
            },
        },
    },

    -- Zone: Vol'dun (map 864)
    -- Vol'dun (map 864 34.91,33.76) -> Boralus (map 1161 70.22,27.06) via gossip
    {
        fromPointID = 900055,
        fromMap = 864,
        fromX = 0.3491,
        fromY = 0.3376,
        toPointID = 800083,
        toMap = 1161,
        toX = 0.7022,
        toY = 0.2706,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 48172,
            npcID = 135681,
        },
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
                    kind = "questCompleted",
                    value = 51229,
                },
            },
        },
    },
    -- Vol'dun (map 864 36.69,34.28) -> Boralus (map 1161 70.22,27.06) via gossip
    {
        fromPointID = 900057,
        fromMap = 864,
        fromX = 0.3669,
        fromY = 0.3428,
        toPointID = 800083,
        toMap = 1161,
        toX = 0.7022,
        toY = 0.2706,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51229,
                },
            },
        },
    },

    -- Zone: Zuldazar (map 862)
    -- Zuldazar (map 862 40.46,71.03) -> Boralus (map 1161 70.22,27.06) via gossip
    {
        fromPointID = 900006,
        fromMap = 862,
        fromX = 0.4046,
        fromY = 0.7103,
        toPointID = 800083,
        toMap = 1161,
        toX = 0.7022,
        toY = 0.2706,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 49161,
            npcID = 143334,
        },
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
                    kind = "questCompleted",
                    value = 51418,
                },
            },
        },
    },
    -- Zuldazar (map 862 58.46,62.99) -> Tiragarde Sound (map 895 88.20,51.16) via gossip
    {
        fromPointID = 900024,
        fromMap = 862,
        fromX = 0.5846,
        fromY = 0.6299,
        toPointID = 800019,
        toMap = 895,
        toX = 0.882,
        toY = 0.5116,
        type = "gossip",
        travelDuration = 1,
        gossip = {
            gossipOptionID = 38346,
            npcID = 135690,
        },
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
                    kind = "questCompleted",
                    value = 51800,
                },
            },
        },
    },
    -- Zuldazar (map 862 58.46,62.99) -> Drustvar (map 896 20.61,43.69) via gossip
    {
        fromPointID = 900024,
        fromMap = 862,
        fromX = 0.5846,
        fromY = 0.6299,
        toPointID = 800023,
        toMap = 896,
        toX = 0.2061,
        toY = 0.4369,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51801,
                },
            },
        },
    },
    -- Zuldazar (map 862 58.46,62.99) -> Stormsong Valley (map 942 51.98,24.49) via gossip
    {
        fromPointID = 900024,
        fromMap = 862,
        fromX = 0.5846,
        fromY = 0.6299,
        toPointID = 800050,
        toMap = 942,
        toX = 0.5198,
        toY = 0.2449,
        type = "gossip",
        travelDuration = 1,
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
                    kind = "questCompleted",
                    value = 51802,
                },
            },
        },
    },
}

Navigation:RegisterPathData("gossip", GOSSIP)
