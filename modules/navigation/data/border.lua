---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local BORDER = {

    -- Zone: Ahn'Qiraj: The Fallen Kingdom (map 327)
    -- Ahn'Qiraj: The Fallen Kingdom (map 327 58.20,7.00) -> Silithus (map 81 35.90,83.30) via border
    {
        fromPointID = 100405,
        fromMap = 327,
        fromX = 0.582,
        fromY = 0.07,
        toPointID = 100239,
        toMap = 81,
        toX = 0.359,
        toY = 0.833,
        type = "border",
    },

    -- Zone: Altar of Domination (map 1823)
    -- Altar of Domination (map 1823 89.73,34.52) -> The Maw (map 1543 23.01,68.40) via border
    {
        fromPointID = 1000305,
        fromMap = 1823,
        fromX = 0.8973,
        fromY = 0.3452,
        toPointID = 1000090,
        toMap = 1543,
        toX = 0.2301,
        toY = 0.684,
        type = "border",
    },

    -- Zone: Ammen Vale (map 468)
    -- Ammen Vale (map 468 23.10,53.50) -> Azuremyst Isle (map 97 67.10,53.80) via border
    {
        fromPointID = 100448,
        fromMap = 468,
        fromX = 0.231,
        fromY = 0.535,
        toPointID = 100309,
        toMap = 97,
        toX = 0.671,
        toY = 0.538,
        type = "border",
    },

    -- Zone: Arathi Highlands (map 14)
    -- Arathi Highlands (map 14 13.70,31.10) -> Hillsbrad Foothills (map 25 68.40,69.80) via border
    {
        fromPointID = 200003,
        fromMap = 14,
        fromX = 0.137,
        fromY = 0.311,
        toPointID = 200107,
        toMap = 25,
        toX = 0.684,
        toY = 0.698,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 10,
                        },
                        {
                            operation = "check",
                            kind = "faction",
                            value = "Horde",
                        },
                    },
                },
            },
        },
    },
    -- Arathi Highlands (map 14 18.30,21.20) -> Hillsbrad Foothills (map 25 74.30,65.20) via border
    {
        fromPointID = 200004,
        fromMap = 14,
        fromX = 0.183,
        fromY = 0.212,
        toPointID = 200109,
        toMap = 25,
        toX = 0.743,
        toY = 0.652,
        type = "border",
    },
    -- Arathi Highlands (map 14 37.00,29.30) -> The Hinterlands (map 26 26.10,69.90) via border
    {
        fromPointID = 200009,
        fromMap = 14,
        fromX = 0.37,
        fromY = 0.293,
        toPointID = 200113,
        toMap = 26,
        toX = 0.261,
        toY = 0.699,
        type = "border",
    },
    -- Arathi Highlands (map 14 38.60,91.00) -> Wetlands (map 56 51.00,10.20) via border
    {
        fromPointID = 200010,
        fromMap = 14,
        fromX = 0.386,
        fromY = 0.91,
        toPointID = 200269,
        toMap = 56,
        toX = 0.51,
        toY = 0.102,
        type = "border",
    },

    -- Zone: Ashenvale (map 63)
    -- Ashenvale (map 63 20.70,15.80) -> Darkshore (map 62 38.80,96.40) via border
    {
        fromPointID = 100107,
        fromMap = 63,
        fromX = 0.207,
        fromY = 0.158,
        toPointID = 100082,
        toMap = 62,
        toX = 0.388,
        toY = 0.964,
        type = "border",
    },
    -- Ashenvale (map 63 36.80,73.80) -> Stonetalon Mountains (map 65 73.30,40.00) via border
    {
        fromPointID = 100111,
        fromMap = 63,
        fromX = 0.368,
        fromY = 0.738,
        toPointID = 100129,
        toMap = 65,
        toX = 0.733,
        toY = 0.4,
        type = "border",
    },
    -- Ashenvale (map 63 55.80,28.80) -> Felwood (map 77 54.70,90.80) via border
    {
        fromPointID = 100114,
        fromMap = 63,
        fromX = 0.558,
        fromY = 0.288,
        toPointID = 100222,
        toMap = 77,
        toX = 0.547,
        toY = 0.908,
        type = "border",
    },
    -- Ashenvale (map 63 68.60,86.80) -> Northern Barrens (map 10 42.80,12.50) via border
    {
        fromPointID = 100115,
        fromMap = 63,
        fromX = 0.686,
        fromY = 0.868,
        toPointID = 100051,
        toMap = 10,
        toX = 0.428,
        toY = 0.125,
        type = "border",
    },
    -- Ashenvale (map 63 95.40,48.40) -> Azshara (map 76 7.80,69.90) via border
    {
        fromPointID = 100118,
        fromMap = 63,
        fromX = 0.954,
        fromY = 0.484,
        toPointID = 100214,
        toMap = 76,
        toX = 0.078,
        toY = 0.699,
        type = "border",
    },

    -- Zone: Ashran (map 588)
    -- Ashran (map 588 42.00,23.40) -> Warspear (map 624 48.30,80.90) via border
    {
        fromPointID = 600125,
        fromMap = 588,
        fromX = 0.42,
        fromY = 0.234,
        toPointID = 600139,
        toMap = 624,
        toX = 0.483,
        toY = 0.809,
        type = "border",
    },

    -- Zone: Azj-Kahet (map 2255)
    -- Azj-Kahet (map 2255 27.00,35.00) -> Hallowfall (map 2215 42.43,81.19) via border
    {
        fromPointID = 1200059,
        fromMap = 2255,
        fromX = 0.27,
        fromY = 0.35,
        toPointID = 1200030,
        toMap = 2215,
        toX = 0.4243,
        toY = 0.8119,
        type = "border",
    },
    -- Azj-Kahet (map 2255 57.53,41.54) -> Dornogal (map 2339 65.67,61.94) via border
    {
        fromPointID = 1200066,
        fromMap = 2255,
        fromX = 0.5753,
        fromY = 0.4154,
        toPointID = 1200133,
        toMap = 2339,
        toX = 0.6567,
        toY = 0.6194,
        type = "border",
    },
    -- Azj-Kahet (map 2255 61.53,8.87) -> Hallowfall (map 2215 73.02,62.53) via border
    {
        fromPointID = 1200068,
        fromMap = 2255,
        fromX = 0.6153,
        fromY = 0.0887,
        toPointID = 1200037,
        toMap = 2215,
        toX = 0.7302,
        toY = 0.6253,
        type = "border",
    },
    -- Azj-Kahet (map 2255 68.00,28.00) -> The Ringing Deeps (map 2214 38.58,67.00) via border
    {
        fromPointID = 1200070,
        fromMap = 2255,
        fromX = 0.68,
        fromY = 0.28,
        toPointID = 1200009,
        toMap = 2214,
        toX = 0.3858,
        toY = 0.67,
        type = "border",
    },

    -- Zone: Azshara (map 76)
    -- Azshara (map 76 7.80,69.90) -> Ashenvale (map 63 95.40,48.40) via border
    {
        fromPointID = 100214,
        fromMap = 76,
        fromX = 0.078,
        fromY = 0.699,
        toPointID = 100118,
        toMap = 63,
        toX = 0.954,
        toY = 0.484,
        type = "border",
    },
    -- Azshara (map 76 26.60,79.20) -> Orgrimmar (map 85 76.50,1.80) via border
    {
        fromPointID = 100216,
        fromMap = 76,
        fromX = 0.266,
        fromY = 0.792,
        toPointID = 100289,
        toMap = 85,
        toX = 0.765,
        toY = 0.018,
        type = "border",
    },

    -- Zone: Azsuna (map 630)
    -- Azsuna (map 630 52.60,5.89) -> Val'sharah (map 641 58.69,92.08) via border
    {
        fromPointID = 700054,
        fromMap = 630,
        fromX = 0.526,
        fromY = 0.0589,
        toPointID = 700102,
        toMap = 641,
        toX = 0.5869,
        toY = 0.9208,
        type = "border",
    },
    -- Azsuna (map 630 66.70,18.43) -> Suramar (map 680 21.54,64.00) via border
    {
        fromPointID = 700058,
        fromMap = 630,
        fromX = 0.667,
        fromY = 0.1843,
        toPointID = 700141,
        toMap = 680,
        toX = 0.2154,
        toY = 0.64,
        type = "border",
    },
    -- Azsuna (map 630 69.65,25.89) -> Suramar (map 680 26.35,74.16) via border
    {
        fromPointID = 700059,
        fromMap = 630,
        fromX = 0.6965,
        fromY = 0.2589,
        toPointID = 700142,
        toMap = 680,
        toX = 0.2635,
        toY = 0.7416,
        type = "border",
    },

    -- Zone: Azuremyst Isle (map 97)
    -- Azuremyst Isle (map 97 36.90,46.90) -> The Exodar (map 103 88.30,64.90) via border
    {
        fromPointID = 100306,
        fromMap = 97,
        fromX = 0.369,
        fromY = 0.469,
        toPointID = 100315,
        toMap = 103,
        toX = 0.883,
        toY = 0.649,
        type = "border",
    },
    -- Azuremyst Isle (map 97 42.00,1.50) -> Bloodmyst Isle (map 106 65.50,95.40) via border
    {
        fromPointID = 100307,
        fromMap = 97,
        fromX = 0.42,
        fromY = 0.015,
        toPointID = 100317,
        toMap = 106,
        toX = 0.655,
        toY = 0.954,
        type = "border",
    },
    -- Azuremyst Isle (map 97 67.10,53.80) -> Ammen Vale (map 468 23.10,53.50) via border
    {
        fromPointID = 100309,
        fromMap = 97,
        fromX = 0.671,
        fromY = 0.538,
        toPointID = 100448,
        toMap = 468,
        toX = 0.231,
        toY = 0.535,
        type = "border",
    },

    -- Zone: Badlands (map 15)
    -- Badlands (map 15 7.40,52.80) -> Searing Gorge (map 32 72.70,55.70) via border
    {
        fromPointID = 200014,
        fromMap = 15,
        fromX = 0.074,
        fromY = 0.528,
        toPointID = 200143,
        toMap = 32,
        toX = 0.727,
        toY = 0.557,
        type = "border",
    },
    -- Badlands (map 15 45.80,7.30) -> Loch Modan (map 48 48.13,79.19) via border
    {
        fromPointID = 200019,
        fromMap = 15,
        fromX = 0.458,
        fromY = 0.073,
        toPointID = 200214,
        toMap = 48,
        toX = 0.4813,
        toY = 0.7919,
        type = "border",
    },
    -- Badlands (map 15 60.70,28.30) -> Badlands (map 15 62.80,35.70) via border
    {
        fromPointID = 200022,
        fromMap = 15,
        fromX = 0.607,
        fromY = 0.283,
        toPointID = 200023,
        toMap = 15,
        toX = 0.628,
        toY = 0.357,
        type = "border",
    },
    -- Badlands (map 15 62.80,35.70) -> Badlands (map 15 60.70,28.30) via border
    {
        fromPointID = 200023,
        fromMap = 15,
        fromX = 0.628,
        fromY = 0.357,
        toPointID = 200022,
        toMap = 15,
        toX = 0.607,
        toY = 0.283,
        type = "border",
    },
    -- Badlands (map 15 66.70,36.30) -> Badlands (map 15 68.70,30.90) via border
    {
        fromPointID = 200026,
        fromMap = 15,
        fromX = 0.667,
        fromY = 0.363,
        toPointID = 200027,
        toMap = 15,
        toX = 0.687,
        toY = 0.309,
        type = "border",
    },
    -- Badlands (map 15 68.70,30.90) -> Badlands (map 15 66.70,36.30) via border
    {
        fromPointID = 200027,
        fromMap = 15,
        fromX = 0.687,
        fromY = 0.309,
        toPointID = 200026,
        toMap = 15,
        toX = 0.667,
        toY = 0.363,
        type = "border",
    },
    -- Badlands (map 15 72.10,31.60) -> Badlands (map 15 75.60,33.20) via border
    {
        fromPointID = 200028,
        fromMap = 15,
        fromX = 0.721,
        fromY = 0.316,
        toPointID = 200029,
        toMap = 15,
        toX = 0.756,
        toY = 0.332,
        type = "border",
    },
    -- Badlands (map 15 75.60,33.20) -> Badlands (map 15 72.10,31.60) via border
    {
        fromPointID = 200029,
        fromMap = 15,
        fromX = 0.756,
        fromY = 0.332,
        toPointID = 200028,
        toMap = 15,
        toX = 0.721,
        toY = 0.316,
        type = "border",
    },

    -- Zone: Bastion (map 1533)
    -- Bastion (map 1533 44.03,24.70) -> Path of Wisdom (map 1713 48.04,90.71) via border
    {
        fromPointID = 1000038,
        fromMap = 1533,
        fromX = 0.4403,
        fromY = 0.247,
        toPointID = 1000274,
        toMap = 1713,
        toX = 0.4804,
        toY = 0.9071,
        type = "border",
    },

    -- Zone: Blade's Edge Mountains (map 105)
    -- Blade's Edge Mountains (map 105 28.50,93.90) -> Zangarmarsh (map 102 43.30,27.50) via border
    {
        fromPointID = 300055,
        fromMap = 105,
        fromX = 0.285,
        fromY = 0.939,
        toPointID = 300030,
        toMap = 102,
        toX = 0.433,
        toY = 0.275,
        type = "border",
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
    -- Blade's Edge Mountains (map 105 52.00,98.80) -> Zangarmarsh (map 102 68.70,32.90) via border
    {
        fromPointID = 300059,
        fromMap = 105,
        fromX = 0.52,
        fromY = 0.988,
        toPointID = 300043,
        toMap = 102,
        toX = 0.687,
        toY = 0.329,
        type = "border",
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
    -- Blade's Edge Mountains (map 105 82.50,28.70) -> Netherstorm (map 109 20.00,56.10) via border
    {
        fromPointID = 300066,
        fromMap = 105,
        fromX = 0.825,
        fromY = 0.287,
        toPointID = 300092,
        toMap = 109,
        toX = 0.2,
        toY = 0.561,
        type = "border",
    },

    -- Zone: Blasted Lands (map 17)
    -- Blasted Lands (map 17 48.90,10.50) -> Swamp of Sorrows (map 51 36.20,66.40) via border
    {
        fromPointID = 200034,
        fromMap = 17,
        fromX = 0.489,
        fromY = 0.105,
        toPointID = 200233,
        toMap = 51,
        toX = 0.362,
        toY = 0.664,
        type = "border",
    },

    -- Zone: Bloodmyst Isle (map 106)
    -- Bloodmyst Isle (map 106 65.50,95.40) -> Azuremyst Isle (map 97 42.00,1.50) via border
    {
        fromPointID = 100317,
        fromMap = 106,
        fromX = 0.655,
        fromY = 0.954,
        toPointID = 100307,
        toMap = 97,
        toX = 0.42,
        toY = 0.015,
        type = "border",
    },

    -- Zone: Boralus (map 1161)
    -- Boralus (map 1161 39.93,48.02) -> Boralus (map 1161 39.93,53.56) via border
    {
        fromPointID = 800064,
        fromMap = 1161,
        fromX = 0.3993,
        fromY = 0.4802,
        toPointID = 800065,
        toMap = 1161,
        toX = 0.3993,
        toY = 0.5356,
        type = "border",
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
    -- Boralus (map 1161 39.93,53.56) -> Boralus (map 1161 39.93,48.02) via border
    {
        fromPointID = 800065,
        fromMap = 1161,
        fromX = 0.3993,
        fromY = 0.5356,
        toPointID = 800064,
        toMap = 1161,
        toX = 0.3993,
        toY = 0.4802,
        type = "border",
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
    -- Boralus (map 1161 43.63,32.47) -> Tiragarde Sound (map 895 67.00,25.63) via border
    {
        fromPointID = 800066,
        fromMap = 1161,
        fromX = 0.4363,
        fromY = 0.3247,
        toPointID = 800005,
        toMap = 895,
        toX = 0.67,
        toY = 0.2563,
        type = "border",
    },
    -- Boralus (map 1161 49.56,19.38) -> Tiragarde Sound (map 895 68.99,24.52) via border
    {
        fromPointID = 800068,
        fromMap = 1161,
        fromX = 0.4956,
        fromY = 0.1938,
        toPointID = 800006,
        toMap = 895,
        toX = 0.6899,
        toY = 0.2452,
        type = "border",
    },
    -- Boralus (map 1161 56.90,51.39) -> Boralus (map 1161 57.95,56.63) via border
    {
        fromPointID = 800070,
        fromMap = 1161,
        fromX = 0.569,
        fromY = 0.5139,
        toPointID = 800071,
        toMap = 1161,
        toX = 0.5795,
        toY = 0.5663,
        type = "border",
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
    -- Boralus (map 1161 57.95,56.63) -> Boralus (map 1161 56.90,51.39) via border
    {
        fromPointID = 800071,
        fromMap = 1161,
        fromX = 0.5795,
        fromY = 0.5663,
        toPointID = 800070,
        toMap = 1161,
        toX = 0.569,
        toY = 0.5139,
        type = "border",
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
    -- Boralus (map 1161 70.34,17.93) -> Tiragarde Sound (map 895 74.42,23.89) via border
    {
        fromPointID = 800084,
        fromMap = 1161,
        fromX = 0.7034,
        fromY = 0.1793,
        toPointID = 800008,
        toMap = 895,
        toX = 0.7442,
        toY = 0.2389,
        type = "border",
    },
    -- Boralus (map 1161 79.25,76.18) -> Tiragarde Sound (map 895 76.83,38.93) via border
    {
        fromPointID = 800089,
        fromMap = 1161,
        fromX = 0.7925,
        fromY = 0.7618,
        toPointID = 800011,
        toMap = 895,
        toX = 0.7683,
        toY = 0.3893,
        type = "border",
    },

    -- Zone: Borean Tundra (map 114)
    -- Borean Tundra (map 114 52.80,7.00) -> Sholazar Basin (map 119 32.20,91.40) via border
    {
        fromPointID = 400007,
        fromMap = 114,
        fromX = 0.528,
        fromY = 0.07,
        toPointID = 400081,
        toMap = 119,
        toX = 0.322,
        toY = 0.914,
        type = "border",
    },
    -- Borean Tundra (map 114 78.90,53.60) -> Dragonblight (map 115 48.00,78.70) via border
    {
        fromPointID = 400013,
        fromMap = 114,
        fromX = 0.789,
        fromY = 0.536,
        toPointID = 400022,
        toMap = 115,
        toX = 0.48,
        toY = 0.787,
        type = "border",
    },
    -- Borean Tundra (map 114 93.70,35.80) -> Dragonblight (map 115 8.20,54.90) via border
    {
        fromPointID = 400015,
        fromMap = 114,
        fromX = 0.937,
        fromY = 0.358,
        toPointID = 400016,
        toMap = 115,
        toX = 0.082,
        toY = 0.549,
        type = "border",
    },

    -- Zone: Burning Steppes (map 36)
    -- Burning Steppes (map 36 20.80,38.20) -> Searing Gorge (map 32 35.30,83.90) via border
    {
        fromPointID = 200164,
        fromMap = 36,
        fromX = 0.208,
        fromY = 0.382,
        toPointID = 200140,
        toMap = 32,
        toX = 0.353,
        toY = 0.839,
        type = "border",
    },
    -- Burning Steppes (map 36 67.30,81.00) -> Redridge Mountains (map 49 43.00,17.00) via border
    {
        fromPointID = 200167,
        fromMap = 36,
        fromX = 0.673,
        fromY = 0.81,
        toPointID = 200218,
        toMap = 49,
        toX = 0.43,
        toY = 0.17,
        type = "border",
    },
    -- Burning Steppes (map 36 83.90,79.70) -> Redridge Mountains (map 49 64.00,17.50) via border
    {
        fromPointID = 200169,
        fromMap = 36,
        fromX = 0.839,
        fromY = 0.797,
        toPointID = 200220,
        toMap = 49,
        toX = 0.64,
        toY = 0.175,
        type = "border",
    },

    -- Zone: Camp Narache (map 462)
    -- Camp Narache (map 462 26.40,16.10) -> Mulgore (map 7 44.70,71.50) via border
    {
        fromPointID = 100442,
        fromMap = 462,
        fromX = 0.264,
        fromY = 0.161,
        toPointID = 100035,
        toMap = 7,
        toX = 0.447,
        toY = 0.715,
        type = "border",
    },

    -- Zone: Coldridge Pass (map 28)
    -- Dun Morogh (map 28 37.30,92.80) -> Coldridge Valley (map 427 73.50,45.20) via border
    {
        fromPointID = 200131,
        fromMap = 28,
        fromX = 0.373,
        fromY = 0.928,
        toPointID = 200600,
        toMap = 427,
        toX = 0.735,
        toY = 0.452,
        type = "border",
    },

    -- Zone: Coldridge Valley (map 427)
    -- Coldridge Valley (map 427 73.50,45.20) -> Dun Morogh (map 28 37.30,92.80) via border
    {
        fromPointID = 200600,
        fromMap = 427,
        fromX = 0.735,
        fromY = 0.452,
        toPointID = 200131,
        toMap = 28,
        toX = 0.373,
        toY = 0.928,
        type = "border",
    },
    -- Coldridge Valley (map 427 73.50,45.70) -> Dun Morogh (map 27 38.30,70.90) via border
    {
        fromPointID = 200601,
        fromMap = 427,
        fromX = 0.735,
        fromY = 0.457,
        toPointID = 200121,
        toMap = 27,
        toX = 0.383,
        toY = 0.709,
        type = "border",
    },

    -- Zone: Crystalsong Forest (map 127)
    -- Crystalsong Forest (map 127 46.10,71.70) -> Dragonblight (map 115 61.30,10.10) via border
    {
        fromPointID = 400134,
        fromMap = 127,
        fromX = 0.461,
        fromY = 0.717,
        toPointID = 400030,
        toMap = 115,
        toX = 0.613,
        toY = 0.101,
        type = "border",
    },
    -- Crystalsong Forest (map 127 58.20,33.20) -> Icecrown (map 118 89.10,84.30) via border
    {
        fromPointID = 400136,
        fromMap = 127,
        fromX = 0.582,
        fromY = 0.332,
        toPointID = 400077,
        toMap = 118,
        toX = 0.891,
        toY = 0.843,
        type = "border",
    },
    -- Crystalsong Forest (map 127 63.60,44.30) -> The Storm Peaks (map 120 30.00,94.80) via border
    {
        fromPointID = 400137,
        fromMap = 127,
        fromX = 0.636,
        fromY = 0.443,
        toPointID = 400086,
        toMap = 120,
        toX = 0.3,
        toY = 0.948,
        type = "border",
    },
    -- Crystalsong Forest (map 127 86.30,44.30) -> The Storm Peaks (map 120 38.60,94.80) via border
    {
        fromPointID = 400140,
        fromMap = 127,
        fromX = 0.863,
        fromY = 0.443,
        toPointID = 400087,
        toMap = 120,
        toX = 0.386,
        toY = 0.948,
        type = "border",
    },
    -- Crystalsong Forest (map 127 97.10,58.50) -> Zul'Drak (map 121 12.00,66.90) via border
    {
        fromPointID = 400142,
        fromMap = 127,
        fromX = 0.971,
        fromY = 0.585,
        toPointID = 400093,
        toMap = 121,
        toX = 0.12,
        toY = 0.669,
        type = "border",
    },

    -- Zone: Darkmoon Island (map 407)
    -- Darkmoon Island (map 407 64.58,67.68) -> Darkmoon Island (map 408 27.92,32.80) via border
    {
        fromPointID = 1300023,
        fromMap = 407,
        fromX = 0.6458,
        fromY = 0.6768,
        toPointID = 1300024,
        toMap = 408,
        toX = 0.2792,
        toY = 0.328,
        type = "border",
    },

    -- Zone: Darkmoon Island (map 408)
    -- Darkmoon Island (map 408 27.92,32.80) -> Darkmoon Island (map 407 64.58,67.68) via border
    {
        fromPointID = 1300024,
        fromMap = 408,
        fromX = 0.2792,
        fromY = 0.328,
        toPointID = 1300023,
        toMap = 407,
        toX = 0.6458,
        toY = 0.6768,
        type = "border",
    },

    -- Zone: Darkshore (map 62)
    -- Darkshore (map 62 38.80,96.40) -> Ashenvale (map 63 20.70,15.80) via border
    {
        fromPointID = 100082,
        fromMap = 62,
        fromX = 0.388,
        fromY = 0.964,
        toPointID = 100107,
        toMap = 63,
        toX = 0.207,
        toY = 0.158,
        type = "border",
    },

    -- Zone: Darnassus (map 89)
    -- Darnassus (map 89 77.00,46.40) -> Teldrassil (map 57 38.10,47.50) via border
    {
        fromPointID = 100302,
        fromMap = 89,
        fromX = 0.77,
        fromY = 0.464,
        toPointID = 100065,
        toMap = 57,
        toX = 0.381,
        toY = 0.475,
        type = "border",
    },

    -- Zone: Deadwind Pass (map 42)
    -- Deadwind Pass (map 42 34.90,35.60) -> Duskwood (map 47 87.70,41.10) via border
    {
        fromPointID = 200191,
        fromMap = 42,
        fromX = 0.349,
        fromY = 0.356,
        toPointID = 200205,
        toMap = 47,
        toX = 0.877,
        toY = 0.411,
        type = "border",
    },
    -- Deadwind Pass (map 42 59.20,41.30) -> Swamp of Sorrows (map 51 16.80,52.00) via border
    {
        fromPointID = 200196,
        fromMap = 42,
        fromX = 0.592,
        fromY = 0.413,
        toPointID = 200232,
        toMap = 51,
        toX = 0.168,
        toY = 0.52,
        type = "border",
    },

    -- Zone: Deathknell (map 465)
    -- Deathknell (map 465 81.40,14.40) -> Tirisfal Glades (map 18 39.30,55.40) via border
    {
        fromPointID = 200608,
        fromMap = 465,
        fromX = 0.814,
        fromY = 0.144,
        toPointID = 200041,
        toMap = 18,
        toX = 0.393,
        toY = 0.554,
        type = "border",
    },

    -- Zone: Desolace (map 66)
    -- Desolace (map 66 42.50,97.30) -> Feralas (map 69 44.90,2.20) via border
    {
        fromPointID = 100135,
        fromMap = 66,
        fromX = 0.425,
        fromY = 0.973,
        toPointID = 100151,
        toMap = 69,
        toX = 0.449,
        toY = 0.022,
        type = "border",
    },
    -- Desolace (map 66 54.20,2.90) -> Stonetalon Mountains (map 65 35.70,77.20) via border
    {
        fromPointID = 100137,
        fromMap = 66,
        fromX = 0.542,
        fromY = 0.029,
        toPointID = 100128,
        toMap = 65,
        toX = 0.357,
        toY = 0.772,
        type = "border",
    },

    -- Zone: Dornogal (map 2339)
    -- Dornogal (map 2339 38.87,59.81) -> The Ringing Deeps (map 2214 38.03,28.36) via border
    {
        fromPointID = 1200122,
        fromMap = 2339,
        fromX = 0.3887,
        fromY = 0.5981,
        toPointID = 1200008,
        toMap = 2214,
        toX = 0.3803,
        toY = 0.2836,
        type = "border",
        travelDuration = 20,
    },
    -- Dornogal (map 2339 65.67,61.94) -> Azj-Kahet (map 2255 57.53,41.54) via border
    {
        fromPointID = 1200133,
        fromMap = 2339,
        fromX = 0.6567,
        fromY = 0.6194,
        toPointID = 1200066,
        toMap = 2255,
        toX = 0.5753,
        toY = 0.4154,
        type = "border",
    },

    -- Zone: Dragonblight (map 115)
    -- Dragonblight (map 115 8.20,54.90) -> Borean Tundra (map 114 93.70,35.80) via border
    {
        fromPointID = 400016,
        fromMap = 115,
        fromX = 0.082,
        fromY = 0.549,
        toPointID = 400015,
        toMap = 114,
        toX = 0.937,
        toY = 0.358,
        type = "border",
    },
    -- Dragonblight (map 115 48.00,78.70) -> Borean Tundra (map 114 78.90,53.60) via border
    {
        fromPointID = 400022,
        fromMap = 115,
        fromX = 0.48,
        fromY = 0.787,
        toPointID = 400013,
        toMap = 114,
        toX = 0.789,
        toY = 0.536,
        type = "border",
    },
    -- Dragonblight (map 115 49.60,78.40) -> Howling Fjord (map 117 23.50,57.80) via border
    {
        fromPointID = 400024,
        fromMap = 115,
        fromX = 0.496,
        fromY = 0.784,
        toPointID = 400053,
        toMap = 117,
        toX = 0.235,
        toY = 0.578,
        type = "border",
    },
    -- Dragonblight (map 115 61.30,10.10) -> Crystalsong Forest (map 127 46.10,71.70) via border
    {
        fromPointID = 400030,
        fromMap = 115,
        fromX = 0.613,
        fromY = 0.101,
        toPointID = 400134,
        toMap = 127,
        toX = 0.461,
        toY = 0.717,
        type = "border",
    },
    -- Dragonblight (map 115 89.00,24.00) -> Zul'Drak (map 121 15.40,89.70) via border
    {
        fromPointID = 400034,
        fromMap = 115,
        fromX = 0.89,
        fromY = 0.24,
        toPointID = 400095,
        toMap = 121,
        toX = 0.154,
        toY = 0.897,
        type = "border",
    },
    -- Dragonblight (map 115 92.00,30.80) -> Grizzly Hills (map 116 8.10,31.20) via border
    {
        fromPointID = 400035,
        fromMap = 115,
        fromX = 0.92,
        fromY = 0.308,
        toPointID = 400037,
        toMap = 116,
        toX = 0.081,
        toY = 0.312,
        type = "border",
    },
    -- Dragonblight (map 115 93.20,64.00) -> Grizzly Hills (map 116 9.40,66.70) via border
    {
        fromPointID = 400036,
        fromMap = 115,
        fromX = 0.932,
        fromY = 0.64,
        toPointID = 400038,
        toMap = 116,
        toX = 0.094,
        toY = 0.667,
        type = "border",
    },

    -- Zone: Dread Wastes (map 422)
    -- Dread Wastes (map 422 45.20,8.80) -> Townlong Steppes (map 388 60.90,83.90) via border
    {
        fromPointID = 500136,
        fromMap = 422,
        fromX = 0.452,
        fromY = 0.088,
        toPointID = 500095,
        toMap = 388,
        toX = 0.609,
        toY = 0.839,
        type = "border",
    },
    -- Dread Wastes (map 422 64.20,10.90) -> Townlong Steppes (map 388 76.00,91.90) via border
    {
        fromPointID = 500140,
        fromMap = 422,
        fromX = 0.642,
        fromY = 0.109,
        toPointID = 500099,
        toMap = 388,
        toX = 0.76,
        toY = 0.919,
        type = "border",
    },

    -- Zone: Drustvar (map 896)
    -- Drustvar (map 896 61.03,14.85) -> Tiragarde Sound (map 895 43.00,32.46) via border
    {
        fromPointID = 800033,
        fromMap = 896,
        fromX = 0.6103,
        fromY = 0.1485,
        toPointID = 800001,
        toMap = 895,
        toX = 0.43,
        toY = 0.3246,
        type = "border",
    },
    -- Drustvar (map 896 73.16,41.94) -> Tiragarde Sound (map 895 52.50,53.79) via border
    {
        fromPointID = 800037,
        fromMap = 896,
        fromX = 0.7316,
        fromY = 0.4194,
        toPointID = 800002,
        toMap = 895,
        toX = 0.525,
        toY = 0.5379,
        type = "border",
    },

    -- Zone: Dun Morogh (map 27)
    -- Dun Morogh (map 27 38.30,70.90) -> Coldridge Valley (map 427 73.50,45.70) via border
    {
        fromPointID = 200121,
        fromMap = 27,
        fromX = 0.383,
        fromY = 0.709,
        toPointID = 200601,
        toMap = 427,
        toX = 0.735,
        toY = 0.457,
        type = "border",
    },
    -- Dun Morogh (map 27 49.10,45.50) -> New Tinkertown (map 469 79.60,56.70) via border
    {
        fromPointID = 200125,
        fromMap = 27,
        fromX = 0.491,
        fromY = 0.455,
        toPointID = 200613,
        toMap = 469,
        toX = 0.796,
        toY = 0.567,
        type = "border",
    },
    -- Dun Morogh (map 27 60.46,33.35) -> Ironforge (map 87 18.02,82.20) via border
    {
        fromPointID = 200126,
        fromMap = 27,
        fromX = 0.6046,
        fromY = 0.3335,
        toPointID = 200323,
        toMap = 87,
        toX = 0.1802,
        toY = 0.822,
        type = "border",
    },
    -- Dun Morogh (map 27 90.00,51.20) -> Loch Modan (map 48 20.80,63.50) via border
    {
        fromPointID = 200129,
        fromMap = 27,
        fromX = 0.9,
        fromY = 0.512,
        toPointID = 200208,
        toMap = 48,
        toX = 0.208,
        toY = 0.635,
        type = "border",
    },
    -- Dun Morogh (map 27 91.70,29.30) -> Loch Modan (map 48 13.20,22.20) via border
    {
        fromPointID = 200130,
        fromMap = 27,
        fromX = 0.917,
        fromY = 0.293,
        toPointID = 200207,
        toMap = 48,
        toX = 0.132,
        toY = 0.222,
        type = "border",
    },

    -- Zone: Durotar (map 1)
    -- Durotar (map 1 34.10,42.40) -> Northern Barrens (map 10 69.00,39.00) via border
    {
        fromPointID = 100004,
        fromMap = 1,
        fromX = 0.341,
        fromY = 0.424,
        toPointID = 100052,
        toMap = 10,
        toX = 0.69,
        toY = 0.39,
        type = "border",
    },
    -- Durotar (map 1 36.83,3.33) -> Orgrimmar War Campaign (map 1534 24.70,66.90) via border
    {
        fromPointID = 100005,
        fromMap = 1,
        fromX = 0.3683,
        fromY = 0.0333,
        toPointID = 100475,
        toMap = 1534,
        toX = 0.247,
        toY = 0.669,
        type = "border",
    },
    -- Durotar (map 1 45.50,11.70) -> Orgrimmar (map 85 49.50,93.20) via border
    {
        fromPointID = 100011,
        fromMap = 1,
        fromX = 0.455,
        fromY = 0.117,
        toPointID = 100265,
        toMap = 85,
        toX = 0.495,
        toY = 0.932,
        type = "border",
    },
    -- Durotar (map 1 50.60,68.40) -> Valley of Trials (map 461 73.40,67.11) via border
    {
        fromPointID = 100012,
        fromMap = 1,
        fromX = 0.506,
        fromY = 0.684,
        toPointID = 100440,
        toMap = 461,
        toX = 0.734,
        toY = 0.6711,
        type = "border",
    },
    -- Durotar (map 1 63.10,80.70) -> Echo Isles (map 463 45.10,42.90) via border
    {
        fromPointID = 100019,
        fromMap = 1,
        fromX = 0.631,
        fromY = 0.807,
        toPointID = 100443,
        toMap = 463,
        toX = 0.451,
        toY = 0.429,
        type = "border",
    },

    -- Zone: Durotar (map 1535)
    -- Durotar War Campaign (map 1535 30.56,36.13) -> Orgrimmar War Campaign (map 1534 49.61,93.48) via border
    {
        fromPointID = 100477,
        fromMap = 1535,
        fromX = 0.3056,
        fromY = 0.3613,
        toPointID = 100476,
        toMap = 1534,
        toX = 0.4961,
        toY = 0.9348,
        type = "border",
    },

    -- Zone: Duskwood (map 47)
    -- Duskwood (map 47 10.60,63.00) -> Westfall (map 52 67.30,62.50) via border
    {
        fromPointID = 200199,
        fromMap = 47,
        fromX = 0.106,
        fromY = 0.63,
        toPointID = 200255,
        toMap = 52,
        toX = 0.673,
        toY = 0.625,
        type = "border",
    },
    -- Duskwood (map 47 44.90,79.20) -> Northern Stranglethorn (map 50 51.30,11.50) via border
    {
        fromPointID = 200202,
        fromMap = 47,
        fromX = 0.449,
        fromY = 0.792,
        toPointID = 200227,
        toMap = 50,
        toX = 0.513,
        toY = 0.115,
        type = "border",
    },
    -- Duskwood (map 47 87.70,41.10) -> Deadwind Pass (map 42 34.90,35.60) via border
    {
        fromPointID = 200205,
        fromMap = 47,
        fromX = 0.877,
        fromY = 0.411,
        toPointID = 200191,
        toMap = 42,
        toX = 0.349,
        toY = 0.356,
        type = "border",
    },
    -- Duskwood (map 47 92.90,12.30) -> Redridge Mountains (map 49 16.00,69.50) via border
    {
        fromPointID = 200206,
        fromMap = 47,
        fromX = 0.929,
        fromY = 0.123,
        toPointID = 200217,
        toMap = 49,
        toX = 0.16,
        toY = 0.695,
        type = "border",
    },

    -- Zone: Dustwallow Marsh (map 70)
    -- Dustwallow Marsh (map 70 28.50,47.20) -> Southern Barrens (map 199 51.60,78.70) via border
    {
        fromPointID = 100172,
        fromMap = 70,
        fromX = 0.285,
        fromY = 0.472,
        toPointID = 100341,
        toMap = 199,
        toX = 0.516,
        toY = 0.787,
        type = "border",
    },
    -- Dustwallow Marsh (map 70 50.30,94.30) -> Thousand Needles (map 64 72.30,46.60) via border
    {
        fromPointID = 100175,
        fromMap = 70,
        fromX = 0.503,
        fromY = 0.943,
        toPointID = 100124,
        toMap = 64,
        toX = 0.723,
        toY = 0.466,
        type = "border",
    },

    -- Zone: Eastern Kingdoms (map 13)
    -- Eastern Kingdoms (map 13 40.34,69.07) -> Stormwind City (map 84 0.00,0.00) via border
    {
        fromPointID = 200001,
        fromMap = 13,
        fromX = 0.4034,
        fromY = 0.6907,
        toPointID = 200278,
        toMap = 84,
        toX = 0.0,
        toY = 0.0,
        type = "border",
    },

    -- Zone: Eastern Plaguelands (map 23)
    -- Eastern Plaguelands (map 23 9.30,66.10) -> Western Plaguelands (map 22 69.10,50.20) via border
    {
        fromPointID = 200085,
        fromMap = 23,
        fromX = 0.093,
        fromY = 0.661,
        toPointID = 200082,
        toMap = 22,
        toX = 0.691,
        toY = 0.502,
        type = "border",
    },

    -- Zone: Echo Isles (map 463)
    -- Echo Isles (map 463 45.10,42.90) -> Durotar (map 1 63.10,80.70) via border
    {
        fromPointID = 100443,
        fromMap = 463,
        fromX = 0.451,
        fromY = 0.429,
        toPointID = 100019,
        toMap = 1,
        toX = 0.631,
        toY = 0.807,
        type = "border",
    },

    -- Zone: Elwynn Forest (map 37)
    -- Elwynn Forest (map 37 21.00,79.70) -> Westfall (map 52 61.80,17.80) via border
    {
        fromPointID = 200171,
        fromMap = 37,
        fromX = 0.21,
        fromY = 0.797,
        toPointID = 200254,
        toMap = 52,
        toX = 0.618,
        toY = 0.178,
        type = "border",
    },
    -- Elwynn Forest (map 37 32.27,49.74) -> Stormwind City (map 84 74.10,92.30) via border
    {
        fromPointID = 200172,
        fromMap = 37,
        fromX = 0.3227,
        fromY = 0.4974,
        toPointID = 200317,
        toMap = 84,
        toX = 0.741,
        toY = 0.923,
        type = "border",
    },
    -- Elwynn Forest (map 37 45.50,48.70) -> Northshire (map 425 23.80,76.70) via border
    {
        fromPointID = 200181,
        fromMap = 37,
        fromX = 0.455,
        fromY = 0.487,
        toPointID = 200598,
        toMap = 425,
        toX = 0.238,
        toY = 0.767,
        type = "border",
    },
    -- Elwynn Forest (map 37 91.20,73.20) -> Redridge Mountains (map 49 13.50,64.30) via border
    {
        fromPointID = 200184,
        fromMap = 37,
        fromX = 0.912,
        fromY = 0.732,
        toPointID = 200216,
        toMap = 49,
        toX = 0.135,
        toY = 0.643,
        type = "border",
    },

    -- Zone: Eversong Woods (map 94)
    -- Eversong Woods (map 94 39.30,30.80) -> Sunstrider Isle (map 467 64.80,74.90) via border
    {
        fromPointID = 200334,
        fromMap = 94,
        fromX = 0.393,
        fromY = 0.308,
        toPointID = 200610,
        toMap = 467,
        toX = 0.648,
        toY = 0.749,
        type = "border",
    },
    -- Eversong Woods (map 94 48.50,90.40) -> Ghostlands (map 95 47.80,13.90) via border
    {
        fromPointID = 200335,
        fromMap = 94,
        fromX = 0.485,
        fromY = 0.904,
        toPointID = 200337,
        toMap = 95,
        toX = 0.478,
        toY = 0.139,
        type = "border",
    },
    -- Eversong Woods (map 94 56.66,49.60) -> Silvermoon City (map 110 72.49,85.26) via border
    {
        fromPointID = 200336,
        fromMap = 94,
        fromX = 0.5666,
        fromY = 0.496,
        toPointID = 200344,
        toMap = 110,
        toX = 0.7249,
        toY = 0.8526,
        type = "border",
    },

    -- Zone: Extractor's Sanatorium (map 1822)
    -- Extractor's Sanatorium (map 1822 19.94,73.08) -> The Maw (map 1543 27.87,20.52) via border
    {
        fromPointID = 1000304,
        fromMap = 1822,
        fromX = 0.1994,
        fromY = 0.7308,
        toPointID = 1000094,
        toMap = 1543,
        toX = 0.2787,
        toY = 0.2052,
        type = "border",
    },

    -- Zone: Felwood (map 77)
    -- Felwood (map 77 54.70,90.80) -> Ashenvale (map 63 55.80,28.80) via border
    {
        fromPointID = 100222,
        fromMap = 77,
        fromX = 0.547,
        fromY = 0.908,
        toPointID = 100114,
        toMap = 63,
        toX = 0.558,
        toY = 0.288,
        type = "border",
    },
    -- Felwood (map 77 64.30,10.30) -> Moonglade (map 80 35.70,72.50) via border
    {
        fromPointID = 100225,
        fromMap = 77,
        fromX = 0.643,
        fromY = 0.103,
        toPointID = 100233,
        toMap = 80,
        toX = 0.357,
        toY = 0.725,
        type = "border",
    },
    -- Felwood (map 77 64.30,10.30) -> Winterspring (map 83 21.20,46.10) via border
    {
        fromPointID = 100225,
        fromMap = 77,
        fromX = 0.643,
        fromY = 0.103,
        toPointID = 100249,
        toMap = 83,
        toX = 0.212,
        toY = 0.461,
        type = "border",
    },

    -- Zone: Feralas (map 69)
    -- Feralas (map 69 44.90,2.20) -> Desolace (map 66 42.50,97.30) via border
    {
        fromPointID = 100151,
        fromMap = 69,
        fromX = 0.449,
        fromY = 0.022,
        toPointID = 100135,
        toMap = 66,
        toX = 0.425,
        toY = 0.973,
        type = "border",
    },
    -- Feralas (map 69 89.30,36.80) -> Thousand Needles (map 64 10.20,4.70) via border
    {
        fromPointID = 100168,
        fromMap = 69,
        fromX = 0.893,
        fromY = 0.368,
        toPointID = 100119,
        toMap = 64,
        toX = 0.102,
        toY = 0.047,
        type = "border",
    },

    -- Zone: Frostfire Ridge (map 525)
    -- Frostfire Ridge (map 525 87.90,72.40) -> Gorgrond (map 543 35.90,78.30) via border
    {
        fromPointID = 600016,
        fromMap = 525,
        fromX = 0.879,
        fromY = 0.724,
        toPointID = 600089,
        toMap = 543,
        toX = 0.359,
        toY = 0.783,
        type = "border",
    },

    -- Zone: Ghostlands (map 95)
    -- Ghostlands (map 95 47.80,13.90) -> Eversong Woods (map 94 48.50,90.40) via border
    {
        fromPointID = 200337,
        fromMap = 95,
        fromX = 0.478,
        fromY = 0.139,
        toPointID = 200335,
        toMap = 94,
        toX = 0.485,
        toY = 0.904,
        type = "border",
    },

    -- Zone: Gorgrond (map 543)
    -- Gorgrond (map 543 35.90,78.30) -> Frostfire Ridge (map 525 87.90,72.40) via border
    {
        fromPointID = 600089,
        fromMap = 543,
        fromX = 0.359,
        fromY = 0.783,
        toPointID = 600016,
        toMap = 525,
        toX = 0.879,
        toY = 0.724,
        type = "border",
    },
    -- Gorgrond (map 543 41.60,95.20) -> Talador (map 535 69.90,0.70) via border
    {
        fromPointID = 600090,
        fromMap = 543,
        fromX = 0.416,
        fromY = 0.952,
        toPointID = 600053,
        toMap = 535,
        toX = 0.699,
        toY = 0.007,
        type = "border",
    },

    -- Zone: Grizzly Hills (map 116)
    -- Grizzly Hills (map 116 8.10,31.20) -> Dragonblight (map 115 92.00,30.80) via border
    {
        fromPointID = 400037,
        fromMap = 116,
        fromX = 0.081,
        fromY = 0.312,
        toPointID = 400035,
        toMap = 115,
        toX = 0.92,
        toY = 0.308,
        type = "border",
    },
    -- Grizzly Hills (map 116 9.40,66.70) -> Dragonblight (map 115 93.20,64.00) via border
    {
        fromPointID = 400038,
        fromMap = 116,
        fromX = 0.094,
        fromY = 0.667,
        toPointID = 400036,
        toMap = 115,
        toX = 0.932,
        toY = 0.64,
        type = "border",
    },
    -- Grizzly Hills (map 116 33.70,81.30) -> Howling Fjord (map 117 24.50,11.30) via border
    {
        fromPointID = 400041,
        fromMap = 116,
        fromX = 0.337,
        fromY = 0.813,
        toPointID = 400054,
        toMap = 117,
        toX = 0.245,
        toY = 0.113,
        type = "border",
    },
    -- Grizzly Hills (map 116 43.00,25.30) -> Zul'Drak (map 121 55.40,91.10) via border
    {
        fromPointID = 400043,
        fromMap = 116,
        fromX = 0.43,
        fromY = 0.253,
        toPointID = 400100,
        toMap = 121,
        toX = 0.554,
        toY = 0.911,
        type = "border",
    },
    -- Grizzly Hills (map 116 58.70,13.80) -> Zul'Drak (map 121 71.90,79.10) via border
    {
        fromPointID = 400046,
        fromMap = 116,
        fromX = 0.587,
        fromY = 0.138,
        toPointID = 400103,
        toMap = 121,
        toX = 0.719,
        toY = 0.791,
        type = "border",
    },
    -- Grizzly Hills (map 116 67.30,70.00) -> Howling Fjord (map 117 53.70,1.30) via border
    {
        fromPointID = 400049,
        fromMap = 116,
        fromX = 0.673,
        fromY = 0.7,
        toPointID = 400058,
        toMap = 117,
        toX = 0.537,
        toY = 0.013,
        type = "border",
    },
    -- Grizzly Hills (map 116 87.90,69.90) -> Howling Fjord (map 117 71.60,1.30) via border
    {
        fromPointID = 400051,
        fromMap = 116,
        fromX = 0.879,
        fromY = 0.699,
        toPointID = 400064,
        toMap = 117,
        toX = 0.716,
        toY = 0.013,
        type = "border",
    },

    -- Zone: Hallowfall (map 2215)
    -- Hallowfall (map 2215 42.43,81.19) -> Azj-Kahet (map 2255 27.00,35.00) via border
    {
        fromPointID = 1200030,
        fromMap = 2215,
        fromX = 0.4243,
        fromY = 0.8119,
        toPointID = 1200059,
        toMap = 2255,
        toX = 0.27,
        toY = 0.35,
        type = "border",
    },
    -- Hallowfall (map 2215 73.02,62.53) -> Azj-Kahet (map 2255 61.53,8.87) via border
    {
        fromPointID = 1200037,
        fromMap = 2215,
        fromX = 0.7302,
        fromY = 0.6253,
        toPointID = 1200068,
        toMap = 2255,
        toX = 0.6153,
        toY = 0.0887,
        type = "border",
    },
    -- Hallowfall (map 2215 79.24,41.94) -> The Ringing Deeps (map 2214 36.42,24.25) via border
    {
        fromPointID = 1200038,
        fromMap = 2215,
        fromX = 0.7924,
        fromY = 0.4194,
        toPointID = 1200007,
        toMap = 2214,
        toX = 0.3642,
        toY = 0.2425,
        type = "border",
    },

    -- Zone: Hellfire Peninsula (map 100)
    -- Hellfire Peninsula (map 100 4.70,50.60) -> Zangarmarsh (map 102 83.00,65.50) via border
    {
        fromPointID = 300001,
        fromMap = 100,
        fromX = 0.047,
        fromY = 0.506,
        toPointID = 300048,
        toMap = 102,
        toX = 0.83,
        toY = 0.655,
        type = "border",
    },
    -- Hellfire Peninsula (map 100 31.10,92.20) -> Terokkar Forest (map 108 58.30,19.30) via border
    {
        fromPointID = 300004,
        fromMap = 100,
        fromX = 0.311,
        fromY = 0.922,
        toPointID = 300086,
        toMap = 108,
        toX = 0.583,
        toY = 0.193,
        type = "border",
    },

    -- Zone: Highmountain (map 650)
    -- Highmountain (map 650 26.63,63.74) -> Val'sharah (map 641 69.35,27.81) via border
    {
        fromPointID = 700126,
        fromMap = 650,
        fromX = 0.2663,
        fromY = 0.6374,
        toPointID = 700107,
        toMap = 641,
        toX = 0.6935,
        toY = 0.2781,
        type = "border",
    },
    -- Highmountain (map 650 59.65,68.94) -> Stormheim (map 634 27.03,38.40) via border
    {
        fromPointID = 700134,
        fromMap = 650,
        fromX = 0.5965,
        fromY = 0.6894,
        toPointID = 700064,
        toMap = 634,
        toX = 0.2703,
        toY = 0.384,
        type = "border",
    },

    -- Zone: Hillsbrad Foothills (map 25)
    -- Hillsbrad Foothills (map 25 29.40,63.30) -> Silverpine Forest (map 21 69.40,80.50) via border
    {
        fromPointID = 200102,
        fromMap = 25,
        fromX = 0.294,
        fromY = 0.633,
        toPointID = 200070,
        toMap = 21,
        toX = 0.694,
        toY = 0.805,
        type = "border",
    },
    -- Hillsbrad Foothills (map 25 65.60,25.90) -> Western Plaguelands (map 22 43.50,88.10) via border
    {
        fromPointID = 200106,
        fromMap = 25,
        fromX = 0.656,
        fromY = 0.259,
        toPointID = 200076,
        toMap = 22,
        toX = 0.435,
        toY = 0.881,
        type = "border",
    },
    -- Hillsbrad Foothills (map 25 68.40,69.80) -> Arathi Highlands (map 14 13.70,31.10) via border
    {
        fromPointID = 200107,
        fromMap = 25,
        fromX = 0.684,
        fromY = 0.698,
        toPointID = 200003,
        toMap = 14,
        toX = 0.137,
        toY = 0.311,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 10,
                        },
                        {
                            operation = "check",
                            kind = "faction",
                            value = "Horde",
                        },
                    },
                },
            },
        },
    },
    -- Hillsbrad Foothills (map 25 73.10,52.80) -> The Hinterlands (map 26 9.70,55.70) via border
    {
        fromPointID = 200108,
        fromMap = 25,
        fromX = 0.731,
        fromY = 0.528,
        toPointID = 200110,
        toMap = 26,
        toX = 0.097,
        toY = 0.557,
        type = "border",
    },
    -- Hillsbrad Foothills (map 25 74.30,65.20) -> Arathi Highlands (map 14 18.30,21.20) via border
    {
        fromPointID = 200109,
        fromMap = 25,
        fromX = 0.743,
        fromY = 0.652,
        toPointID = 200004,
        toMap = 14,
        toX = 0.183,
        toY = 0.212,
        type = "border",
    },

    -- Zone: Howling Fjord (map 117)
    -- Howling Fjord (map 117 23.50,57.80) -> Dragonblight (map 115 49.60,78.40) via border
    {
        fromPointID = 400053,
        fromMap = 117,
        fromX = 0.235,
        fromY = 0.578,
        toPointID = 400024,
        toMap = 115,
        toX = 0.496,
        toY = 0.784,
        type = "border",
    },
    -- Howling Fjord (map 117 24.50,11.30) -> Grizzly Hills (map 116 33.70,81.30) via border
    {
        fromPointID = 400054,
        fromMap = 117,
        fromX = 0.245,
        fromY = 0.113,
        toPointID = 400041,
        toMap = 116,
        toX = 0.337,
        toY = 0.813,
        type = "border",
    },
    -- Howling Fjord (map 117 53.70,1.30) -> Grizzly Hills (map 116 67.30,70.00) via border
    {
        fromPointID = 400058,
        fromMap = 117,
        fromX = 0.537,
        fromY = 0.013,
        toPointID = 400049,
        toMap = 116,
        toX = 0.673,
        toY = 0.7,
        type = "border",
    },
    -- Howling Fjord (map 117 71.60,1.30) -> Grizzly Hills (map 116 87.90,69.90) via border
    {
        fromPointID = 400064,
        fromMap = 117,
        fromX = 0.716,
        fromY = 0.013,
        toPointID = 400051,
        toMap = 116,
        toX = 0.879,
        toY = 0.699,
        type = "border",
    },

    -- Zone: Icecrown (map 118)
    -- Icecrown (map 118 89.10,84.30) -> Crystalsong Forest (map 127 58.20,33.20) via border
    {
        fromPointID = 400077,
        fromMap = 118,
        fromX = 0.891,
        fromY = 0.843,
        toPointID = 400136,
        toMap = 127,
        toX = 0.582,
        toY = 0.332,
        type = "border",
    },

    -- Zone: Ironforge (map 87)
    -- Ironforge (map 87 18.02,82.20) -> Dun Morogh (map 27 60.46,33.35) via border
    {
        fromPointID = 200323,
        fromMap = 87,
        fromX = 0.1802,
        fromY = 0.822,
        toPointID = 200126,
        toMap = 27,
        toX = 0.6046,
        toY = 0.3335,
        type = "border",
    },

    -- Zone: K'aresh (map 2371)
    -- K'aresh (map 2371 56.84,24.09) -> Voidscar Cavern (map 2477 33.80,83.85) via border
    {
        fromPointID = 1200164,
        fromMap = 2371,
        fromX = 0.5684,
        fromY = 0.2409,
        toPointID = 1200238,
        toMap = 2477,
        toX = 0.338,
        toY = 0.8385,
        type = "border",
    },

    -- Zone: Keeper's Rest (map 20)
    -- Tirisfal Glades (map 20 37.57,12.44) -> Tirisfal Glades (map 18 15.18,56.28) via border
    {
        fromPointID = 200061,
        fromMap = 20,
        fromX = 0.3757,
        fromY = 0.1244,
        toPointID = 200039,
        toMap = 18,
        toX = 0.1518,
        toY = 0.5628,
        type = "border",
    },

    -- Zone: Korthia (map 1961)
    -- Korthia (map 1961 40.04,25.94) -> The Maw (map 1543 51.53,90.46) via border
    {
        fromPointID = 1000313,
        fromMap = 1961,
        fromX = 0.4004,
        fromY = 0.2594,
        toPointID = 1000118,
        toMap = 1543,
        toX = 0.5153,
        toY = 0.9046,
        type = "border",
    },
    -- Korthia (map 1961 58.48,13.67) -> The Maw (map 1543 65.61,80.80) via border
    {
        fromPointID = 1000316,
        fromMap = 1961,
        fromX = 0.5848,
        fromY = 0.1367,
        toPointID = 1000121,
        toMap = 1543,
        toX = 0.6561,
        toY = 0.808,
        type = "border",
    },

    -- Zone: Krasarang Wilds (map 418)
    -- Krasarang Wilds (map 418 15.00,36.20) -> Valley of the Four Winds (map 376 10.70,84.30) via border
    {
        fromPointID = 500122,
        fromMap = 418,
        fromX = 0.15,
        fromY = 0.362,
        toPointID = 500026,
        toMap = 376,
        toX = 0.107,
        toY = 0.843,
        type = "border",
    },
    -- Krasarang Wilds (map 418 74.50,4.00) -> Valley of the Four Winds (map 376 82.10,50.70) via border
    {
        fromPointID = 500127,
        fromMap = 418,
        fromX = 0.745,
        fromY = 0.04,
        toPointID = 500041,
        toMap = 376,
        toX = 0.821,
        toY = 0.507,
        type = "border",
    },

    -- Zone: Kun-Lai Summit (map 379)
    -- Kun-Lai Summit (map 379 29.50,64.40) -> Townlong Steppes (map 388 71.00,42.80) via border
    {
        fromPointID = 500044,
        fromMap = 379,
        fromX = 0.295,
        fromY = 0.644,
        toPointID = 500096,
        toMap = 388,
        toX = 0.71,
        toY = 0.428,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.10,89.90) -> Kun-Lai Summit (map 379 44.30,89.90) via border
    {
        fromPointID = 500048,
        fromMap = 379,
        fromX = 0.441,
        fromY = 0.899,
        toPointID = 500049,
        toMap = 379,
        toX = 0.443,
        toY = 0.899,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.30,89.90) -> Kun-Lai Summit (map 379 44.10,89.90) via border
    {
        fromPointID = 500049,
        fromMap = 379,
        fromX = 0.443,
        fromY = 0.899,
        toPointID = 500048,
        toMap = 379,
        toX = 0.441,
        toY = 0.899,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.50,89.06) -> Kun-Lai Summit (map 379 44.50,89.15) via border
    {
        fromPointID = 500050,
        fromMap = 379,
        fromX = 0.445,
        fromY = 0.8906,
        toPointID = 500051,
        toMap = 379,
        toX = 0.445,
        toY = 0.8915,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.50,89.15) -> Kun-Lai Summit (map 379 44.50,89.06) via border
    {
        fromPointID = 500051,
        fromMap = 379,
        fromX = 0.445,
        fromY = 0.8915,
        toPointID = 500050,
        toMap = 379,
        toX = 0.445,
        toY = 0.8906,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.50,90.30) -> Kun-Lai Summit (map 379 44.50,90.60) via border
    {
        fromPointID = 500052,
        fromMap = 379,
        fromX = 0.445,
        fromY = 0.903,
        toPointID = 500053,
        toMap = 379,
        toX = 0.445,
        toY = 0.906,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.50,90.60) -> Kun-Lai Summit (map 379 44.50,90.30) via border
    {
        fromPointID = 500053,
        fromMap = 379,
        fromX = 0.445,
        fromY = 0.906,
        toPointID = 500052,
        toMap = 379,
        toX = 0.445,
        toY = 0.903,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 44.80,90.00) -> Kun-Lai Summit (map 379 45.05,99.98) via border
    {
        fromPointID = 500054,
        fromMap = 379,
        fromX = 0.448,
        fromY = 0.9,
        toPointID = 500055,
        toMap = 379,
        toX = 0.4505,
        toY = 0.9998,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 45.05,99.98) -> Kun-Lai Summit (map 379 44.80,90.00) via border
    {
        fromPointID = 500055,
        fromMap = 379,
        fromX = 0.4505,
        fromY = 0.9998,
        toPointID = 500054,
        toMap = 379,
        toX = 0.448,
        toY = 0.9,
        type = "border",
    },
    -- Kun-Lai Summit (map 379 55.50,93.00) -> Vale of Eternal Blossoms (map 390 44.10,12.80) via border
    {
        fromPointID = 500062,
        fromMap = 379,
        fromX = 0.555,
        fromY = 0.93,
        toPointID = 500111,
        toMap = 390,
        toX = 0.441,
        toY = 0.128,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 31511,
                },
            },
        },
    },
    -- Kun-Lai Summit (map 379 55.50,93.00) -> Vale of Eternal Blossoms (map 390 44.10,12.80) via border
    {
        fromPointID = 500062,
        fromMap = 379,
        fromX = 0.555,
        fromY = 0.93,
        toPointID = 500111,
        toMap = 390,
        toX = 0.441,
        toY = 0.128,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 31512,
                },
            },
        },
    },
    -- Kun-Lai Summit (map 379 55.54,92.77) -> Vale of Eternal Blossoms New (map 1530 44.12,10.42) via border
    {
        fromPointID = 500063,
        fromMap = 379,
        fromX = 0.5554,
        fromY = 0.9277,
        toPointID = 500286,
        toMap = 1530,
        toX = 0.4412,
        toY = 0.1042,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "OldVale",
                        },
                    },
                },
            },
        },
    },
    -- Kun-Lai Summit (map 379 73.30,94.60) -> The Veiled Stair (map 433 31.10,1.70) via border
    {
        fromPointID = 500074,
        fromMap = 379,
        fromX = 0.733,
        fromY = 0.946,
        toPointID = 500148,
        toMap = 433,
        toX = 0.311,
        toY = 0.017,
        type = "border",
    },

    -- Zone: Loch Modan (map 48)
    -- Loch Modan (map 48 13.20,22.20) -> Dun Morogh (map 27 91.70,29.30) via border
    {
        fromPointID = 200207,
        fromMap = 48,
        fromX = 0.132,
        fromY = 0.222,
        toPointID = 200130,
        toMap = 27,
        toX = 0.917,
        toY = 0.293,
        type = "border",
    },
    -- Loch Modan (map 48 20.80,63.50) -> Dun Morogh (map 27 90.00,51.20) via border
    {
        fromPointID = 200208,
        fromMap = 48,
        fromX = 0.208,
        fromY = 0.635,
        toPointID = 200129,
        toMap = 27,
        toX = 0.9,
        toY = 0.512,
        type = "border",
    },
    -- Loch Modan (map 48 25.30,0.20) -> Loch Modan (map 48 25.60,10.50) via border
    {
        fromPointID = 200209,
        fromMap = 48,
        fromX = 0.253,
        fromY = 0.002,
        toPointID = 200210,
        toMap = 48,
        toX = 0.256,
        toY = 0.105,
        type = "border",
    },
    -- Loch Modan (map 48 25.30,0.20) -> Wetlands (map 56 55.10,83.50) via border
    {
        fromPointID = 200209,
        fromMap = 48,
        fromX = 0.253,
        fromY = 0.002,
        toPointID = 200272,
        toMap = 56,
        toX = 0.551,
        toY = 0.835,
        type = "border",
    },
    -- Loch Modan (map 48 25.60,10.50) -> Loch Modan (map 48 25.30,0.20) via border
    {
        fromPointID = 200210,
        fromMap = 48,
        fromX = 0.256,
        fromY = 0.105,
        toPointID = 200209,
        toMap = 48,
        toX = 0.253,
        toY = 0.002,
        type = "border",
    },
    -- Loch Modan (map 48 47.21,73.40) -> Loch Modan (map 48 47.28,76.00) via border
    {
        fromPointID = 200212,
        fromMap = 48,
        fromX = 0.4721,
        fromY = 0.734,
        toPointID = 200213,
        toMap = 48,
        toX = 0.4728,
        toY = 0.76,
        type = "border",
    },
    -- Loch Modan (map 48 47.28,76.00) -> Loch Modan (map 48 47.21,73.40) via border
    {
        fromPointID = 200213,
        fromMap = 48,
        fromX = 0.4728,
        fromY = 0.76,
        toPointID = 200212,
        toMap = 48,
        toX = 0.4721,
        toY = 0.734,
        type = "border",
    },
    -- Loch Modan (map 48 47.28,76.00) -> Loch Modan (map 48 48.21,77.16) via border
    {
        fromPointID = 200213,
        fromMap = 48,
        fromX = 0.4728,
        fromY = 0.76,
        toPointID = 200215,
        toMap = 48,
        toX = 0.4821,
        toY = 0.7716,
        type = "border",
    },
    -- Loch Modan (map 48 48.13,79.19) -> Badlands (map 15 45.80,7.30) via border
    {
        fromPointID = 200214,
        fromMap = 48,
        fromX = 0.4813,
        fromY = 0.7919,
        toPointID = 200019,
        toMap = 15,
        toX = 0.458,
        toY = 0.073,
        type = "border",
    },
    -- Loch Modan (map 48 48.13,79.19) -> Loch Modan (map 48 48.21,77.16) via border
    {
        fromPointID = 200214,
        fromMap = 48,
        fromX = 0.4813,
        fromY = 0.7919,
        toPointID = 200215,
        toMap = 48,
        toX = 0.4821,
        toY = 0.7716,
        type = "border",
    },
    -- Loch Modan (map 48 48.21,77.16) -> Loch Modan (map 48 47.28,76.00) via border
    {
        fromPointID = 200215,
        fromMap = 48,
        fromX = 0.4821,
        fromY = 0.7716,
        toPointID = 200213,
        toMap = 48,
        toX = 0.4728,
        toY = 0.76,
        type = "border",
    },
    -- Loch Modan (map 48 48.21,77.16) -> Loch Modan (map 48 48.13,79.19) via border
    {
        fromPointID = 200215,
        fromMap = 48,
        fromX = 0.4821,
        fromY = 0.7716,
        toPointID = 200214,
        toMap = 48,
        toX = 0.4813,
        toY = 0.7919,
        type = "border",
    },

    -- Zone: Moonglade (map 80)
    -- Moonglade (map 80 35.70,72.50) -> Felwood (map 77 64.30,10.30) via border
    {
        fromPointID = 100233,
        fromMap = 80,
        fromX = 0.357,
        fromY = 0.725,
        toPointID = 100225,
        toMap = 77,
        toX = 0.643,
        toY = 0.103,
        type = "border",
    },

    -- Zone: Mulgore (map 7)
    -- Mulgore (map 7 38.30,33.90) -> Thunder Bluff (map 88 38.10,79.00) via border
    {
        fromPointID = 100034,
        fromMap = 7,
        fromX = 0.383,
        fromY = 0.339,
        toPointID = 100296,
        toMap = 88,
        toX = 0.381,
        toY = 0.79,
        type = "border",
    },
    -- Mulgore (map 7 44.70,71.50) -> Camp Narache (map 462 26.40,16.10) via border
    {
        fromPointID = 100035,
        fromMap = 7,
        fromX = 0.447,
        fromY = 0.715,
        toPointID = 100442,
        toMap = 462,
        toX = 0.264,
        toY = 0.161,
        type = "border",
    },
    -- Mulgore (map 7 67.80,59.90) -> Southern Barrens (map 199 39.80,48.00) via border
    {
        fromPointID = 100040,
        fromMap = 7,
        fromX = 0.678,
        fromY = 0.599,
        toPointID = 100338,
        toMap = 199,
        toX = 0.398,
        toY = 0.48,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevelExclusive",
                    value = 10,
                },
            },
        },
    },

    -- Zone: Nagrand (map 107)
    -- Nagrand (map 107 34.00,13.00) -> Zangarmarsh (map 102 21.00,70.50) via border
    {
        fromPointID = 300068,
        fromMap = 107,
        fromX = 0.34,
        fromY = 0.13,
        toPointID = 300027,
        toMap = 102,
        toX = 0.21,
        toY = 0.705,
        type = "border",
    },
    -- Nagrand (map 107 74.10,32.90) -> Zangarmarsh (map 102 74.10,32.60) via border
    {
        fromPointID = 300072,
        fromMap = 107,
        fromX = 0.741,
        fromY = 0.329,
        toPointID = 300044,
        toMap = 102,
        toX = 0.741,
        toY = 0.326,
        type = "border",
    },
    -- Nagrand (map 107 77.90,82.60) -> Terokkar Forest (map 108 20.30,55.60) via border
    {
        fromPointID = 300073,
        fromMap = 107,
        fromX = 0.779,
        fromY = 0.826,
        toPointID = 300075,
        toMap = 108,
        toX = 0.203,
        toY = 0.556,
        type = "border",
    },
    -- Nagrand (map 107 78.30,54.50) -> Shattrath City (map 111 12.80,56.40) via border
    {
        fromPointID = 300074,
        fromMap = 107,
        fromX = 0.783,
        fromY = 0.545,
        toPointID = 300100,
        toMap = 111,
        toX = 0.128,
        toY = 0.564,
        type = "border",
    },

    -- Zone: Nagrand (map 550)
    -- Nagrand D (map 550 92.40,72.20) -> Talador (map 535 29.70,56.30) via border
    {
        fromPointID = 600119,
        fromMap = 550,
        fromX = 0.924,
        fromY = 0.722,
        toPointID = 600038,
        toMap = 535,
        toX = 0.297,
        toY = 0.563,
        type = "border",
    },

    -- Zone: Nazmir (map 863)
    -- Nazmir (map 863 16.08,69.41) -> Vol'dun (map 864 59.87,71.20) via border
    {
        fromPointID = 900034,
        fromMap = 863,
        fromX = 0.1608,
        fromY = 0.6941,
        toPointID = 900062,
        toMap = 864,
        toX = 0.5987,
        toY = 0.712,
        type = "border",
    },
    -- Nazmir (map 863 21.23,47.85) -> Vol'dun (map 864 63.89,54.52) via border
    {
        fromPointID = 900036,
        fromMap = 863,
        fromX = 0.2123,
        fromY = 0.4785,
        toPointID = 900063,
        toMap = 864,
        toX = 0.6389,
        toY = 0.5452,
        type = "border",
    },
    -- Nazmir (map 863 23.82,34.07) -> Vol'dun (map 864 65.77,44.08) via border
    {
        fromPointID = 900037,
        fromMap = 863,
        fromX = 0.2382,
        fromY = 0.3407,
        toPointID = 900064,
        toMap = 864,
        toX = 0.6577,
        toY = 0.4408,
        type = "border",
    },
    -- Nazmir (map 863 27.67,25.68) -> Vol'dun (map 864 68.96,37.37) via border
    {
        fromPointID = 900038,
        fromMap = 863,
        fromX = 0.2767,
        fromY = 0.2568,
        toPointID = 900065,
        toMap = 864,
        toX = 0.6896,
        toY = 0.3737,
        type = "border",
    },
    -- Nazmir (map 863 31.13,93.94) -> Zuldazar (map 862 46.15,20.37) via border
    {
        fromPointID = 900039,
        fromMap = 863,
        fromX = 0.3113,
        fromY = 0.9394,
        toPointID = 900014,
        toMap = 862,
        toX = 0.4615,
        toY = 0.2037,
        type = "border",
    },
    -- Nazmir (map 863 43.48,91.08) -> Zuldazar (map 862 53.73,18.59) via border
    {
        fromPointID = 900042,
        fromMap = 863,
        fromX = 0.4348,
        fromY = 0.9108,
        toPointID = 900017,
        toMap = 862,
        toX = 0.5373,
        toY = 0.1859,
        type = "border",
    },
    -- Nazmir (map 863 50.35,89.21) -> Zuldazar (map 862 57.99,17.45) via border
    {
        fromPointID = 900043,
        fromMap = 863,
        fromX = 0.5035,
        fromY = 0.8921,
        toPointID = 900020,
        toMap = 862,
        toX = 0.5799,
        toY = 0.1745,
        type = "border",
    },

    -- Zone: Netherstorm (map 109)
    -- Netherstorm (map 109 20.00,56.10) -> Blade's Edge Mountains (map 105 82.50,28.70) via border
    {
        fromPointID = 300092,
        fromMap = 109,
        fromX = 0.2,
        fromY = 0.561,
        toPointID = 300066,
        toMap = 105,
        toX = 0.825,
        toY = 0.287,
        type = "border",
    },

    -- Zone: New Tinkertown (map 469)
    -- New Tinkertown (map 469 79.60,56.70) -> Dun Morogh (map 27 49.10,45.50) via border
    {
        fromPointID = 200613,
        fromMap = 469,
        fromX = 0.796,
        fromY = 0.567,
        toPointID = 200125,
        toMap = 27,
        toX = 0.491,
        toY = 0.455,
        type = "border",
    },

    -- Zone: Northern Barrens (map 10)
    -- Northern Barrens (map 10 27.30,48.00) -> Southern Barrens (map 199 36.70,4.80) via border
    {
        fromPointID = 100049,
        fromMap = 10,
        fromX = 0.273,
        fromY = 0.48,
        toPointID = 100337,
        toMap = 199,
        toX = 0.367,
        toY = 0.048,
        type = "border",
    },
    -- Northern Barrens (map 10 42.80,12.50) -> Ashenvale (map 63 68.60,86.80) via border
    {
        fromPointID = 100051,
        fromMap = 10,
        fromX = 0.428,
        fromY = 0.125,
        toPointID = 100115,
        toMap = 63,
        toX = 0.686,
        toY = 0.868,
        type = "border",
    },
    -- Northern Barrens (map 10 69.00,39.00) -> Durotar (map 1 34.10,42.40) via border
    {
        fromPointID = 100052,
        fromMap = 10,
        fromX = 0.69,
        fromY = 0.39,
        toPointID = 100004,
        toMap = 1,
        toX = 0.341,
        toY = 0.424,
        type = "border",
    },

    -- Zone: Northern Stranglethorn (map 50)
    -- Northern Stranglethorn (map 50 51.10,69.80) -> The Cape of Stranglethorn (map 210 59.20,24.30) via border
    {
        fromPointID = 200226,
        fromMap = 50,
        fromX = 0.511,
        fromY = 0.698,
        toPointID = 200386,
        toMap = 210,
        toX = 0.592,
        toY = 0.243,
        type = "border",
    },
    -- Northern Stranglethorn (map 50 51.30,11.50) -> Duskwood (map 47 44.90,79.20) via border
    {
        fromPointID = 200227,
        fromMap = 50,
        fromX = 0.513,
        fromY = 0.115,
        toPointID = 200202,
        toMap = 47,
        toX = 0.449,
        toY = 0.792,
        type = "border",
    },

    -- Zone: Northshire (map 425)
    -- Northshire (map 425 23.80,76.70) -> Elwynn Forest (map 37 45.50,48.70) via border
    {
        fromPointID = 200598,
        fromMap = 425,
        fromX = 0.238,
        fromY = 0.767,
        toPointID = 200181,
        toMap = 37,
        toX = 0.455,
        toY = 0.487,
        type = "border",
    },

    -- Zone: Ohn'ahran Plains (map 2023)
    -- Ohn'ahran Plains (map 2023 35.74,59.09) -> Ohn'ahran Plains (map 2023 35.77,59.09) via border
    {
        fromPointID = 1100018,
        fromMap = 2023,
        fromX = 0.3574,
        fromY = 0.5909,
        toPointID = 1100019,
        toMap = 2023,
        toX = 0.3577,
        toY = 0.5909,
        type = "border",
        travelDuration = 1,
    },
    -- Ohn'ahran Plains (map 2023 35.77,59.09) -> Ohn'ahran Plains (map 2023 35.74,59.09) via border
    {
        fromPointID = 1100019,
        fromMap = 2023,
        fromX = 0.3577,
        fromY = 0.5909,
        toPointID = 1100018,
        toMap = 2023,
        toX = 0.3574,
        toY = 0.5909,
        type = "border",
        travelDuration = 1,
    },
    -- Ohn'ahran Plains (map 2023 40.46,59.39) -> Zaralek Cavern (map 2133 31.92,80.72) via border
    {
        fromPointID = 1100022,
        fromMap = 2023,
        fromX = 0.4046,
        fromY = 0.5939,
        toPointID = 1100139,
        toMap = 2133,
        toX = 0.3192,
        toY = 0.8072,
        type = "border",
        travelDuration = 1,
    },
    -- Ohn'ahran Plains (map 2023 82.92,31.67) -> Zaralek Cavern (map 2133 75.08,49.46) via border
    {
        fromPointID = 1100036,
        fromMap = 2023,
        fromX = 0.8292,
        fromY = 0.3167,
        toPointID = 1100157,
        toMap = 2133,
        toX = 0.7508,
        toY = 0.4946,
        type = "border",
        travelDuration = 1,
    },
    -- Ohn'ahran Plains (map 2023 88.68,28.78) -> Ohn'ahran Plains (map 2023 88.86,28.73) via border
    {
        fromPointID = 1100041,
        fromMap = 2023,
        fromX = 0.8868,
        fromY = 0.2878,
        toPointID = 1100042,
        toMap = 2023,
        toX = 0.8886,
        toY = 0.2873,
        type = "border",
        travelDuration = 1,
    },
    -- Ohn'ahran Plains (map 2023 88.86,28.73) -> Ohn'ahran Plains (map 2023 88.68,28.78) via border
    {
        fromPointID = 1100042,
        fromMap = 2023,
        fromX = 0.8886,
        fromY = 0.2873,
        toPointID = 1100041,
        toMap = 2023,
        toX = 0.8868,
        toY = 0.2878,
        type = "border",
        travelDuration = 1,
    },

    -- Zone: Orgrimmar (map 1534)
    -- Orgrimmar War Campaign (map 1534 24.70,66.90) -> Durotar (map 1 36.83,3.33) via border
    {
        fromPointID = 100475,
        fromMap = 1534,
        fromX = 0.247,
        fromY = 0.669,
        toPointID = 100005,
        toMap = 1,
        toX = 0.3683,
        toY = 0.0333,
        type = "border",
    },
    -- Orgrimmar War Campaign (map 1534 49.61,93.48) -> Durotar War Campaign (map 1535 30.56,36.13) via border
    {
        fromPointID = 100476,
        fromMap = 1534,
        fromX = 0.4961,
        fromY = 0.9348,
        toPointID = 100477,
        toMap = 1535,
        toX = 0.3056,
        toY = 0.3613,
        type = "border",
    },

    -- Zone: Orgrimmar (map 85)
    -- Orgrimmar (map 85 49.50,93.20) -> Durotar (map 1 45.50,11.70) via border
    {
        fromPointID = 100265,
        fromMap = 85,
        fromX = 0.495,
        fromY = 0.932,
        toPointID = 100011,
        toMap = 1,
        toX = 0.455,
        toY = 0.117,
        type = "border",
    },
    -- Orgrimmar (map 85 76.50,1.80) -> Azshara (map 76 26.60,79.20) via border
    {
        fromPointID = 100289,
        fromMap = 85,
        fromX = 0.765,
        fromY = 0.018,
        toPointID = 100216,
        toMap = 76,
        toX = 0.266,
        toY = 0.792,
        type = "border",
    },

    -- Zone: Path of Wisdom (map 1713)
    -- Path of Wisdom (map 1713 48.04,90.71) -> Bastion (map 1533 44.03,24.70) via border
    {
        fromPointID = 1000274,
        fromMap = 1713,
        fromX = 0.4804,
        fromY = 0.9071,
        toPointID = 1000038,
        toMap = 1533,
        toX = 0.4403,
        toY = 0.247,
        type = "border",
    },

    -- Zone: Pit of Anguish (map 1820)
    -- Pit of Anguish (map 1820 46.35,25.54) -> The Maw (map 1543 54.62,80.06) via border
    {
        fromPointID = 1000297,
        fromMap = 1820,
        fromX = 0.4635,
        fromY = 0.2554,
        toPointID = 1000120,
        toMap = 1543,
        toX = 0.5462,
        toY = 0.8006,
        type = "border",
    },

    -- Zone: Pools Of Power (map 1579)
    -- Pools of Power (map 1579 12.61,74.17) -> Vale of Eternal Blossoms New (map 1530 57.48,38.78) via border
    {
        fromPointID = 500303,
        fromMap = 1579,
        fromX = 0.1261,
        fromY = 0.7417,
        toPointID = 500287,
        toMap = 1530,
        toX = 0.5748,
        toY = 0.3878,
        type = "border",
    },

    -- Zone: Redridge Mountains (map 49)
    -- Redridge Mountains (map 49 13.50,64.30) -> Elwynn Forest (map 37 91.20,73.20) via border
    {
        fromPointID = 200216,
        fromMap = 49,
        fromX = 0.135,
        fromY = 0.643,
        toPointID = 200184,
        toMap = 37,
        toX = 0.912,
        toY = 0.732,
        type = "border",
    },
    -- Redridge Mountains (map 49 16.00,69.50) -> Duskwood (map 47 92.90,12.30) via border
    {
        fromPointID = 200217,
        fromMap = 49,
        fromX = 0.16,
        fromY = 0.695,
        toPointID = 200206,
        toMap = 47,
        toX = 0.929,
        toY = 0.123,
        type = "border",
    },
    -- Redridge Mountains (map 49 43.00,17.00) -> Burning Steppes (map 36 67.30,81.00) via border
    {
        fromPointID = 200218,
        fromMap = 49,
        fromX = 0.43,
        fromY = 0.17,
        toPointID = 200167,
        toMap = 36,
        toX = 0.673,
        toY = 0.81,
        type = "border",
    },
    -- Redridge Mountains (map 49 64.00,17.50) -> Burning Steppes (map 36 83.90,79.70) via border
    {
        fromPointID = 200220,
        fromMap = 49,
        fromX = 0.64,
        fromY = 0.175,
        toPointID = 200169,
        toMap = 36,
        toX = 0.839,
        toY = 0.797,
        type = "border",
    },
    -- Redridge Mountains (map 49 90.20,56.70) -> Swamp of Sorrows (map 51 67.50,14.10) via border
    {
        fromPointID = 200221,
        fromMap = 49,
        fromX = 0.902,
        fromY = 0.567,
        toPointID = 200236,
        toMap = 51,
        toX = 0.675,
        toY = 0.141,
        type = "border",
    },

    -- Zone: Ruins of Gilneas (map 217)
    -- Ruins of Gilneas (map 217 60.20,9.60) -> Silverpine Forest (map 21 45.30,85.70) via border
    {
        fromPointID = 200388,
        fromMap = 217,
        fromX = 0.602,
        fromY = 0.096,
        toPointID = 200063,
        toMap = 21,
        toX = 0.453,
        toY = 0.857,
        type = "border",
    },

    -- Zone: Searing Gorge (map 32)
    -- Searing Gorge (map 32 35.30,83.90) -> Burning Steppes (map 36 20.80,38.20) via border
    {
        fromPointID = 200140,
        fromMap = 32,
        fromX = 0.353,
        fromY = 0.839,
        toPointID = 200164,
        toMap = 36,
        toX = 0.208,
        toY = 0.382,
        type = "border",
    },
    -- Searing Gorge (map 32 72.70,55.70) -> Badlands (map 15 7.40,52.80) via border
    {
        fromPointID = 200143,
        fromMap = 32,
        fromX = 0.727,
        fromY = 0.557,
        toPointID = 200014,
        toMap = 15,
        toX = 0.074,
        toY = 0.528,
        type = "border",
    },

    -- Zone: Shadowglen (map 460)
    -- Shadowglen (map 460 54.90,86.00) -> Teldrassil (map 57 60.60,44.80) via border
    {
        fromPointID = 100437,
        fromMap = 460,
        fromX = 0.549,
        fromY = 0.86,
        toPointID = 100072,
        toMap = 57,
        toX = 0.606,
        toY = 0.448,
        type = "border",
    },

    -- Zone: Shadowmoon Valley (map 104)
    -- Shadowmoon Valley (map 104 18.00,23.70) -> Terokkar Forest (map 108 71.30,50.40) via border
    {
        fromPointID = 300050,
        fromMap = 104,
        fromX = 0.18,
        fromY = 0.237,
        toPointID = 300089,
        toMap = 108,
        toX = 0.713,
        toY = 0.504,
        type = "border",
    },

    -- Zone: Shadowmoon Valley (map 539)
    -- Shadowmoon Valley D (map 539 18.90,12.20) -> Talador (map 535 81.00,58.20) via border
    {
        fromPointID = 600059,
        fromMap = 539,
        fromX = 0.189,
        fromY = 0.122,
        toPointID = 600056,
        toMap = 535,
        toX = 0.81,
        toY = 0.582,
        type = "border",
    },
    -- Shadowmoon Valley D (map 539 23.00,45.40) -> Spires of Arak (map 542 65.20,18.60) via border
    {
        fromPointID = 600060,
        fromMap = 539,
        fromX = 0.23,
        fromY = 0.454,
        toPointID = 600085,
        toMap = 542,
        toX = 0.652,
        toY = 0.186,
        type = "border",
    },

    -- Zone: Shattrath City (map 111)
    -- Shattrath City (map 111 12.80,56.40) -> Nagrand (map 107 78.30,54.50) via border
    {
        fromPointID = 300100,
        fromMap = 111,
        fromX = 0.128,
        fromY = 0.564,
        toPointID = 300074,
        toMap = 107,
        toX = 0.783,
        toY = 0.545,
        type = "border",
    },
    -- Shattrath City (map 111 76.20,77.30) -> Terokkar Forest (map 108 36.00,31.90) via border
    {
        fromPointID = 300108,
        fromMap = 111,
        fromX = 0.762,
        fromY = 0.773,
        toPointID = 300079,
        toMap = 108,
        toX = 0.36,
        toY = 0.319,
        type = "border",
    },
    -- Shattrath City (map 111 88.00,45.00) -> Terokkar Forest (map 108 38.90,24.10) via border
    {
        fromPointID = 300109,
        fromMap = 111,
        fromX = 0.88,
        fromY = 0.45,
        toPointID = 300080,
        toMap = 108,
        toX = 0.389,
        toY = 0.241,
        type = "border",
    },

    -- Zone: Sholazar Basin (map 119)
    -- Sholazar Basin (map 119 32.20,91.40) -> Borean Tundra (map 114 52.80,7.00) via border
    {
        fromPointID = 400081,
        fromMap = 119,
        fromX = 0.322,
        fromY = 0.914,
        toPointID = 400007,
        toMap = 114,
        toX = 0.528,
        toY = 0.07,
        type = "border",
    },

    -- Zone: Silithus (map 81)
    -- Silithus (map 81 35.90,83.30) -> Ahn'Qiraj: The Fallen Kingdom (map 327 58.20,7.00) via border
    {
        fromPointID = 100239,
        fromMap = 81,
        fromX = 0.359,
        fromY = 0.833,
        toPointID = 100405,
        toMap = 327,
        toX = 0.582,
        toY = 0.07,
        type = "border",
    },
    -- Silithus (map 81 86.10,10.60) -> Un'Goro Crater (map 78 29.60,7.40) via border
    {
        fromPointID = 100247,
        fromMap = 81,
        fromX = 0.861,
        fromY = 0.106,
        toPointID = 100226,
        toMap = 78,
        toX = 0.296,
        toY = 0.074,
        type = "border",
    },

    -- Zone: Silvermoon City (map 110)
    -- Silvermoon City (map 110 72.49,85.26) -> Eversong Woods (map 94 56.66,49.60) via border
    {
        fromPointID = 200344,
        fromMap = 110,
        fromX = 0.7249,
        fromY = 0.8526,
        toPointID = 200336,
        toMap = 94,
        toX = 0.5666,
        toY = 0.496,
        type = "border",
    },

    -- Zone: Silverpine Forest (map 21)
    -- Silverpine Forest (map 21 45.30,85.70) -> Ruins of Gilneas (map 217 60.20,9.60) via border
    {
        fromPointID = 200063,
        fromMap = 21,
        fromX = 0.453,
        fromY = 0.857,
        toPointID = 200388,
        toMap = 217,
        toX = 0.602,
        toY = 0.096,
        type = "border",
    },
    -- Silverpine Forest (map 21 64.90,8.40) -> Tirisfal Glades (map 18 53.90,77.10) via border
    {
        fromPointID = 200068,
        fromMap = 21,
        fromX = 0.649,
        fromY = 0.084,
        toPointID = 200043,
        toMap = 18,
        toX = 0.539,
        toY = 0.771,
        type = "border",
    },
    -- Silverpine Forest (map 21 65.50,8.53) -> Tirisfal Glades L (map 2070 53.06,78.34) via border
    {
        fromPointID = 200069,
        fromMap = 21,
        fromX = 0.655,
        fromY = 0.0853,
        toPointID = 200633,
        toMap = 2070,
        toX = 0.5306,
        toY = 0.7834,
        type = "border",
    },
    -- Silverpine Forest (map 21 69.40,80.50) -> Hillsbrad Foothills (map 25 29.40,63.30) via border
    {
        fromPointID = 200070,
        fromMap = 21,
        fromX = 0.694,
        fromY = 0.805,
        toPointID = 200102,
        toMap = 25,
        toX = 0.294,
        toY = 0.633,
        type = "border",
    },

    -- Zone: Southern Barrens (map 199)
    -- Southern Barrens (map 199 29.10,9.00) -> Stonetalon Mountains (map 65 79.70,92.60) via border
    {
        fromPointID = 100336,
        fromMap = 199,
        fromX = 0.291,
        fromY = 0.09,
        toPointID = 100130,
        toMap = 65,
        toX = 0.797,
        toY = 0.926,
        type = "border",
    },
    -- Southern Barrens (map 199 36.70,4.80) -> Northern Barrens (map 10 27.30,48.00) via border
    {
        fromPointID = 100337,
        fromMap = 199,
        fromX = 0.367,
        fromY = 0.048,
        toPointID = 100049,
        toMap = 10,
        toX = 0.273,
        toY = 0.48,
        type = "border",
    },
    -- Southern Barrens (map 199 39.80,48.00) -> Mulgore (map 7 67.80,59.90) via border
    {
        fromPointID = 100338,
        fromMap = 199,
        fromX = 0.398,
        fromY = 0.48,
        toPointID = 100040,
        toMap = 7,
        toX = 0.678,
        toY = 0.599,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevelExclusive",
                    value = 10,
                },
            },
        },
    },
    -- Southern Barrens (map 199 43.30,96.50) -> Thousand Needles (map 64 32.20,20.50) via border
    {
        fromPointID = 100340,
        fromMap = 199,
        fromX = 0.433,
        fromY = 0.965,
        toPointID = 100121,
        toMap = 64,
        toX = 0.322,
        toY = 0.205,
        type = "border",
    },
    -- Southern Barrens (map 199 51.60,78.70) -> Dustwallow Marsh (map 70 28.50,47.20) via border
    {
        fromPointID = 100341,
        fromMap = 199,
        fromX = 0.516,
        fromY = 0.787,
        toPointID = 100172,
        toMap = 70,
        toX = 0.285,
        toY = 0.472,
        type = "border",
    },

    -- Zone: Spires of Arak (map 542)
    -- Spires of Arak (map 542 22.20,21.30) -> Talador (map 535 41.90,98.30) via border
    {
        fromPointID = 600072,
        fromMap = 542,
        fromX = 0.222,
        fromY = 0.213,
        toPointID = 600039,
        toMap = 535,
        toX = 0.419,
        toY = 0.983,
        type = "border",
    },
    -- Spires of Arak (map 542 37.30,14.40) -> Talador (map 535 57.07,91.08) via border
    {
        fromPointID = 600077,
        fromMap = 542,
        fromX = 0.373,
        fromY = 0.144,
        toPointID = 600048,
        toMap = 535,
        toX = 0.5707,
        toY = 0.9108,
        type = "border",
    },
    -- Spires of Arak (map 542 65.20,18.60) -> Shadowmoon Valley D (map 539 23.00,45.40) via border
    {
        fromPointID = 600085,
        fromMap = 542,
        fromX = 0.652,
        fromY = 0.186,
        toPointID = 600060,
        toMap = 539,
        toX = 0.23,
        toY = 0.454,
        type = "border",
    },

    -- Zone: Stonetalon Mountains (map 65)
    -- Stonetalon Mountains (map 65 35.70,77.20) -> Desolace (map 66 54.20,2.90) via border
    {
        fromPointID = 100128,
        fromMap = 65,
        fromX = 0.357,
        fromY = 0.772,
        toPointID = 100137,
        toMap = 66,
        toX = 0.542,
        toY = 0.029,
        type = "border",
    },
    -- Stonetalon Mountains (map 65 73.30,40.00) -> Ashenvale (map 63 36.80,73.80) via border
    {
        fromPointID = 100129,
        fromMap = 65,
        fromX = 0.733,
        fromY = 0.4,
        toPointID = 100111,
        toMap = 63,
        toX = 0.368,
        toY = 0.738,
        type = "border",
    },
    -- Stonetalon Mountains (map 65 79.70,92.60) -> Southern Barrens (map 199 29.10,9.00) via border
    {
        fromPointID = 100130,
        fromMap = 65,
        fromX = 0.797,
        fromY = 0.926,
        toPointID = 100336,
        toMap = 199,
        toX = 0.291,
        toY = 0.09,
        type = "border",
    },

    -- Zone: Stormheim (map 634)
    -- Stormheim (map 634 27.03,38.40) -> Highmountain (map 650 59.65,68.94) via border
    {
        fromPointID = 700064,
        fromMap = 634,
        fromX = 0.2703,
        fromY = 0.384,
        toPointID = 700134,
        toMap = 650,
        toX = 0.5965,
        toY = 0.6894,
        type = "border",
    },
    -- Stormheim (map 634 33.66,76.69) -> Suramar (map 680 64.23,34.17) via border
    {
        fromPointID = 700066,
        fromMap = 634,
        fromX = 0.3366,
        fromY = 0.7669,
        toPointID = 700198,
        toMap = 680,
        toX = 0.6423,
        toY = 0.3417,
        type = "border",
    },

    -- Zone: Stormsong Valley (map 942)
    -- Stormsong Valley (map 942 57.86,86.01) -> Tiragarde Sound (map 895 66.46,8.59) via border
    {
        fromPointID = 800052,
        fromMap = 942,
        fromX = 0.5786,
        fromY = 0.8601,
        toPointID = 800004,
        toMap = 895,
        toX = 0.6646,
        toY = 0.0859,
        type = "border",
    },

    -- Zone: Stormwind City (map 84)
    -- Stormwind City (map 84 0.00,0.00) -> Eastern Kingdoms (map 13 40.34,69.07) via border
    {
        fromPointID = 200278,
        fromMap = 84,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200001,
        toMap = 13,
        toX = 0.4034,
        toY = 0.6907,
        type = "border",
    },
    -- Stormwind City (map 84 66.20,77.18) -> Stormwind City (map 84 74.10,92.30) via border
    {
        fromPointID = 200311,
        fromMap = 84,
        fromX = 0.662,
        fromY = 0.7718,
        toPointID = 200317,
        toMap = 84,
        toX = 0.741,
        toY = 0.923,
        type = "border",
        travelDuration = 5,
    },
    -- Stormwind City (map 84 74.10,92.30) -> Elwynn Forest (map 37 32.27,49.74) via border
    {
        fromPointID = 200317,
        fromMap = 84,
        fromX = 0.741,
        fromY = 0.923,
        toPointID = 200172,
        toMap = 37,
        toX = 0.3227,
        toY = 0.4974,
        type = "border",
    },
    -- Stormwind City (map 84 74.10,92.30) -> Stormwind City (map 84 66.20,77.18) via border
    {
        fromPointID = 200317,
        fromMap = 84,
        fromX = 0.741,
        fromY = 0.923,
        toPointID = 200311,
        toMap = 84,
        toX = 0.662,
        toY = 0.7718,
        type = "border",
        travelDuration = 5,
    },

    -- Zone: Sunstrider Isle (map 467)
    -- Sunstrider Isle (map 467 64.80,74.90) -> Eversong Woods (map 94 39.30,30.80) via border
    {
        fromPointID = 200610,
        fromMap = 467,
        fromX = 0.648,
        fromY = 0.749,
        toPointID = 200334,
        toMap = 94,
        toX = 0.393,
        toY = 0.308,
        type = "border",
    },

    -- Zone: Suramar (map 680)
    -- Suramar (map 680 15.07,24.92) -> Val'sharah (map 641 68.19,66.37) via border
    {
        fromPointID = 700139,
        fromMap = 680,
        fromX = 0.1507,
        fromY = 0.2492,
        toPointID = 700105,
        toMap = 641,
        toX = 0.6819,
        toY = 0.6637,
        type = "border",
    },
    -- Suramar (map 680 21.54,64.00) -> Azsuna (map 630 66.70,18.43) via border
    {
        fromPointID = 700141,
        fromMap = 680,
        fromX = 0.2154,
        fromY = 0.64,
        toPointID = 700058,
        toMap = 630,
        toX = 0.667,
        toY = 0.1843,
        type = "border",
    },
    -- Suramar (map 680 26.35,74.16) -> Azsuna (map 630 69.65,25.89) via border
    {
        fromPointID = 700142,
        fromMap = 680,
        fromX = 0.2635,
        fromY = 0.7416,
        toPointID = 700059,
        toMap = 630,
        toX = 0.6965,
        toY = 0.2589,
        type = "border",
    },
    -- Suramar (map 680 64.23,34.17) -> Stormheim (map 634 33.66,76.69) via border
    {
        fromPointID = 700198,
        fromMap = 680,
        fromX = 0.6423,
        fromY = 0.3417,
        toPointID = 700066,
        toMap = 634,
        toX = 0.3366,
        toY = 0.7669,
        type = "border",
    },

    -- Zone: Swamp of Sorrows (map 51)
    -- Swamp of Sorrows (map 51 16.80,52.00) -> Deadwind Pass (map 42 59.20,41.30) via border
    {
        fromPointID = 200232,
        fromMap = 51,
        fromX = 0.168,
        fromY = 0.52,
        toPointID = 200196,
        toMap = 42,
        toX = 0.592,
        toY = 0.413,
        type = "border",
    },
    -- Swamp of Sorrows (map 51 36.20,66.40) -> Blasted Lands (map 17 48.90,10.50) via border
    {
        fromPointID = 200233,
        fromMap = 51,
        fromX = 0.362,
        fromY = 0.664,
        toPointID = 200034,
        toMap = 17,
        toX = 0.489,
        toY = 0.105,
        type = "border",
    },
    -- Swamp of Sorrows (map 51 67.50,14.10) -> Redridge Mountains (map 49 90.20,56.70) via border
    {
        fromPointID = 200236,
        fromMap = 51,
        fromX = 0.675,
        fromY = 0.141,
        toPointID = 200221,
        toMap = 49,
        toX = 0.902,
        toY = 0.567,
        type = "border",
    },

    -- Zone: Talador (map 535)
    -- Talador (map 535 29.70,56.30) -> Nagrand D (map 550 92.40,72.20) via border
    {
        fromPointID = 600038,
        fromMap = 535,
        fromX = 0.297,
        fromY = 0.563,
        toPointID = 600119,
        toMap = 550,
        toX = 0.924,
        toY = 0.722,
        type = "border",
    },
    -- Talador (map 535 41.90,98.30) -> Spires of Arak (map 542 22.20,21.30) via border
    {
        fromPointID = 600039,
        fromMap = 535,
        fromX = 0.419,
        fromY = 0.983,
        toPointID = 600072,
        toMap = 542,
        toX = 0.222,
        toY = 0.213,
        type = "border",
    },
    -- Talador (map 535 57.07,91.08) -> Spires of Arak (map 542 37.30,14.40) via border
    {
        fromPointID = 600048,
        fromMap = 535,
        fromX = 0.5707,
        fromY = 0.9108,
        toPointID = 600077,
        toMap = 542,
        toX = 0.373,
        toY = 0.144,
        type = "border",
    },
    -- Talador (map 535 69.90,0.70) -> Gorgrond (map 543 41.60,95.20) via border
    {
        fromPointID = 600053,
        fromMap = 535,
        fromX = 0.699,
        fromY = 0.007,
        toPointID = 600090,
        toMap = 543,
        toX = 0.416,
        toY = 0.952,
        type = "border",
    },
    -- Talador (map 535 81.00,58.20) -> Shadowmoon Valley D (map 539 18.90,12.20) via border
    {
        fromPointID = 600056,
        fromMap = 535,
        fromX = 0.81,
        fromY = 0.582,
        toPointID = 600059,
        toMap = 539,
        toX = 0.189,
        toY = 0.122,
        type = "border",
    },

    -- Zone: Tanaris (map 71)
    -- Tanaris (map 71 25.90,66.30) -> Uldum (map 249 70.60,22.50) via border
    {
        fromPointID = 100180,
        fromMap = 71,
        fromX = 0.259,
        fromY = 0.663,
        toPointID = 100372,
        toMap = 249,
        toX = 0.706,
        toY = 0.225,
        type = "border",
    },
    -- Tanaris (map 71 25.98,66.23) -> Uldum New (map 1527 70.51,22.43) via border
    {
        fromPointID = 100181,
        fromMap = 71,
        fromX = 0.2598,
        fromY = 0.6623,
        toPointID = 100473,
        toMap = 1527,
        toX = 0.7051,
        toY = 0.2243,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "OldUldum",
                        },
                    },
                },
            },
        },
    },
    -- Tanaris (map 71 28.00,51.30) -> Un'Goro Crater (map 78 70.80,91.90) via border
    {
        fromPointID = 100182,
        fromMap = 71,
        fromX = 0.28,
        fromY = 0.513,
        toPointID = 100231,
        toMap = 78,
        toX = 0.708,
        toY = 0.919,
        type = "border",
    },
    -- Tanaris (map 71 51.40,22.90) -> Thousand Needles (map 64 75.30,97.00) via border
    {
        fromPointID = 100190,
        fromMap = 71,
        fromX = 0.514,
        fromY = 0.229,
        toPointID = 100125,
        toMap = 64,
        toX = 0.753,
        toY = 0.97,
        type = "border",
    },

    -- Zone: Teldrassil (map 57)
    -- Teldrassil (map 57 38.10,47.50) -> Darnassus (map 89 77.00,46.40) via border
    {
        fromPointID = 100065,
        fromMap = 57,
        fromX = 0.381,
        fromY = 0.475,
        toPointID = 100302,
        toMap = 89,
        toX = 0.77,
        toY = 0.464,
        type = "border",
    },
    -- Teldrassil (map 57 60.60,44.80) -> Shadowglen (map 460 54.90,86.00) via border
    {
        fromPointID = 100072,
        fromMap = 57,
        fromX = 0.606,
        fromY = 0.448,
        toPointID = 100437,
        toMap = 460,
        toX = 0.549,
        toY = 0.86,
        type = "border",
    },

    -- Zone: Terokkar Forest (map 108)
    -- Terokkar Forest (map 108 20.30,55.60) -> Nagrand (map 107 77.90,82.60) via border
    {
        fromPointID = 300075,
        fromMap = 108,
        fromX = 0.203,
        fromY = 0.556,
        toPointID = 300073,
        toMap = 107,
        toX = 0.779,
        toY = 0.826,
        type = "border",
    },
    -- Terokkar Forest (map 108 32.30,4.70) -> Zangarmarsh (map 102 82.20,92.50) via border
    {
        fromPointID = 300076,
        fromMap = 108,
        fromX = 0.323,
        fromY = 0.047,
        toPointID = 300046,
        toMap = 102,
        toX = 0.822,
        toY = 0.925,
        type = "border",
    },
    -- Terokkar Forest (map 108 36.00,31.90) -> Shattrath City (map 111 76.20,77.30) via border
    {
        fromPointID = 300079,
        fromMap = 108,
        fromX = 0.36,
        fromY = 0.319,
        toPointID = 300108,
        toMap = 111,
        toX = 0.762,
        toY = 0.773,
        type = "border",
    },
    -- Terokkar Forest (map 108 38.90,24.10) -> Shattrath City (map 111 88.00,45.00) via border
    {
        fromPointID = 300080,
        fromMap = 108,
        fromX = 0.389,
        fromY = 0.241,
        toPointID = 300109,
        toMap = 111,
        toX = 0.88,
        toY = 0.45,
        type = "border",
    },
    -- Terokkar Forest (map 108 58.30,19.30) -> Hellfire Peninsula (map 100 31.10,92.20) via border
    {
        fromPointID = 300086,
        fromMap = 108,
        fromX = 0.583,
        fromY = 0.193,
        toPointID = 300004,
        toMap = 100,
        toX = 0.311,
        toY = 0.922,
        type = "border",
    },
    -- Terokkar Forest (map 108 71.30,50.40) -> Shadowmoon Valley (map 104 18.00,23.70) via border
    {
        fromPointID = 300089,
        fromMap = 108,
        fromX = 0.713,
        fromY = 0.504,
        toPointID = 300050,
        toMap = 104,
        toX = 0.18,
        toY = 0.237,
        type = "border",
    },

    -- Zone: The Azure Span (map 2024)
    -- The Azure Span (map 2024 18.91,23.35) -> The Azure Span (map 2024 18.91,23.43) via border
    {
        fromPointID = 1100050,
        fromMap = 2024,
        fromX = 0.1891,
        fromY = 0.2335,
        toPointID = 1100051,
        toMap = 2024,
        toX = 0.1891,
        toY = 0.2343,
        type = "border",
        travelDuration = 1,
    },
    -- The Azure Span (map 2024 18.91,23.43) -> The Azure Span (map 2024 18.91,23.35) via border
    {
        fromPointID = 1100051,
        fromMap = 2024,
        fromX = 0.1891,
        fromY = 0.2343,
        toPointID = 1100050,
        toMap = 2024,
        toX = 0.1891,
        toY = 0.2335,
        type = "border",
        travelDuration = 1,
    },
    -- The Azure Span (map 2024 19.04,18.59) -> Zaralek Cavern (map 2133 36.54,94.96) via border
    {
        fromPointID = 1100052,
        fromMap = 2024,
        fromX = 0.1904,
        fromY = 0.1859,
        toPointID = 1100147,
        toMap = 2133,
        toX = 0.3654,
        toY = 0.9496,
        type = "border",
        travelDuration = 1,
    },

    -- Zone: The Cape of Stranglethorn (map 210)
    -- The Cape of Stranglethorn (map 210 42.50,67.10) -> The Cape of Stranglethorn (map 210 44.90,66.00) via border
    {
        fromPointID = 200383,
        fromMap = 210,
        fromX = 0.425,
        fromY = 0.671,
        toPointID = 200384,
        toMap = 210,
        toX = 0.449,
        toY = 0.66,
        type = "border",
    },
    -- The Cape of Stranglethorn (map 210 44.90,66.00) -> The Cape of Stranglethorn (map 210 42.50,67.10) via border
    {
        fromPointID = 200384,
        fromMap = 210,
        fromX = 0.449,
        fromY = 0.66,
        toPointID = 200383,
        toMap = 210,
        toX = 0.425,
        toY = 0.671,
        type = "border",
    },
    -- The Cape of Stranglethorn (map 210 59.20,24.30) -> Northern Stranglethorn (map 50 51.10,69.80) via border
    {
        fromPointID = 200386,
        fromMap = 210,
        fromX = 0.592,
        fromY = 0.243,
        toPointID = 200226,
        toMap = 50,
        toX = 0.511,
        toY = 0.698,
        type = "border",
    },

    -- Zone: The Coiled Isle (map 2512)
    -- The Coiled Isle (map 2512 31.87,64.88) -> The Coiled Isle (map 2512 31.91,64.87) via border
    {
        fromPointID = 200773,
        fromMap = 2512,
        fromX = 0.3187,
        fromY = 0.6488,
        toPointID = 200774,
        toMap = 2512,
        toX = 0.3191,
        toY = 0.6487,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 31.91,64.87) -> The Coiled Isle (map 2512 31.87,64.88) via border
    {
        fromPointID = 200774,
        fromMap = 2512,
        fromX = 0.3191,
        fromY = 0.6487,
        toPointID = 200773,
        toMap = 2512,
        toX = 0.3187,
        toY = 0.6488,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 35.69,67.54) -> Vaults of Atal'Utek (map 2509 42.43,89.80) via border
    {
        fromPointID = 200776,
        fromMap = 2512,
        fromX = 0.3569,
        fromY = 0.6754,
        toPointID = 200760,
        toMap = 2509,
        toX = 0.4243,
        toY = 0.898,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 39.06,41.54) -> Vaults of Atal'Utek (map 2509 58.36,36.10) via border
    {
        fromPointID = 200777,
        fromMap = 2512,
        fromX = 0.3906,
        fromY = 0.4154,
        toPointID = 200768,
        toMap = 2509,
        toX = 0.5836,
        toY = 0.361,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 41.07,62.27) -> Vaults of Atal'Utek (map 2509 51.24,82.08) via border
    {
        fromPointID = 200779,
        fromMap = 2512,
        fromX = 0.4107,
        fromY = 0.6227,
        toPointID = 200764,
        toMap = 2509,
        toX = 0.5124,
        toY = 0.8208,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 43.28,44.20) -> The Coiled Isle (map 2512 43.30,44.27) via border
    {
        fromPointID = 200781,
        fromMap = 2512,
        fromX = 0.4328,
        fromY = 0.442,
        toPointID = 200782,
        toMap = 2512,
        toX = 0.433,
        toY = 0.4427,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 43.30,44.27) -> The Coiled Isle (map 2512 43.28,44.20) via border
    {
        fromPointID = 200782,
        fromMap = 2512,
        fromX = 0.433,
        fromY = 0.4427,
        toPointID = 200781,
        toMap = 2512,
        toX = 0.4328,
        toY = 0.442,
        type = "border",
        travelDuration = 48,
    },
    -- The Coiled Isle (map 2512 45.37,64.90) -> The Coiled Isle (map 2512 45.37,64.90) via border
    {
        fromPointID = 200785,
        fromMap = 2512,
        fromX = 0.4537,
        fromY = 0.649,
        toPointID = 200785,
        toMap = 2512,
        toX = 0.4537,
        toY = 0.649,
        type = "border",
        travelDuration = 48,
    },

    -- Zone: The Exodar (map 103)
    -- The Exodar (map 103 88.30,64.90) -> Azuremyst Isle (map 97 36.90,46.90) via border
    {
        fromPointID = 100315,
        fromMap = 103,
        fromX = 0.883,
        fromY = 0.649,
        toPointID = 100306,
        toMap = 97,
        toX = 0.369,
        toY = 0.469,
        type = "border",
    },

    -- Zone: The Hinterlands (map 26)
    -- The Hinterlands (map 26 9.70,55.70) -> Hillsbrad Foothills (map 25 73.10,52.80) via border
    {
        fromPointID = 200110,
        fromMap = 26,
        fromX = 0.097,
        fromY = 0.557,
        toPointID = 200108,
        toMap = 25,
        toX = 0.731,
        toY = 0.528,
        type = "border",
    },
    -- The Hinterlands (map 26 24.30,42.10) -> Western Plaguelands (map 22 65.10,86.50) via border
    {
        fromPointID = 200112,
        fromMap = 26,
        fromX = 0.243,
        fromY = 0.421,
        toPointID = 200080,
        toMap = 22,
        toX = 0.651,
        toY = 0.865,
        type = "border",
    },
    -- The Hinterlands (map 26 26.10,69.90) -> Arathi Highlands (map 14 37.00,29.30) via border
    {
        fromPointID = 200113,
        fromMap = 26,
        fromX = 0.261,
        fromY = 0.699,
        toPointID = 200009,
        toMap = 14,
        toX = 0.37,
        toY = 0.293,
        type = "border",
    },

    -- Zone: The Jade Forest (map 371)
    -- The Jade Forest (map 371 33.60,64.70) -> Valley of the Four Winds (map 376 90.60,17.70) via border
    {
        fromPointID = 500004,
        fromMap = 371,
        fromX = 0.336,
        fromY = 0.647,
        toPointID = 500043,
        toMap = 376,
        toX = 0.906,
        toY = 0.177,
        type = "border",
    },
    -- The Jade Forest (map 371 44.22,88.43) -> The Jade Forest (map 371 44.46,89.43) via border
    {
        fromPointID = 500009,
        fromMap = 371,
        fromX = 0.4422,
        fromY = 0.8843,
        toPointID = 500010,
        toMap = 371,
        toX = 0.4446,
        toY = 0.8943,
        type = "border",
    },
    -- The Jade Forest (map 371 44.46,89.43) -> The Jade Forest (map 371 44.22,88.43) via border
    {
        fromPointID = 500010,
        fromMap = 371,
        fromX = 0.4446,
        fromY = 0.8943,
        toPointID = 500009,
        toMap = 371,
        toX = 0.4422,
        toY = 0.8843,
        type = "border",
    },
    -- The Jade Forest (map 371 45.66,85.82) -> The Jade Forest (map 371 47.06,87.95) via border
    {
        fromPointID = 500011,
        fromMap = 371,
        fromX = 0.4566,
        fromY = 0.8582,
        toPointID = 500018,
        toMap = 371,
        toX = 0.4706,
        toY = 0.8795,
        type = "border",
    },
    -- The Jade Forest (map 371 47.06,87.95) -> The Jade Forest (map 371 45.66,85.82) via border
    {
        fromPointID = 500018,
        fromMap = 371,
        fromX = 0.4706,
        fromY = 0.8795,
        toPointID = 500011,
        toMap = 371,
        toX = 0.4566,
        toY = 0.8582,
        type = "border",
    },

    -- Zone: The Maw (map 1543)
    -- The Maw (map 1543 23.01,68.40) -> Altar of Domination (map 1823 89.73,34.52) via border
    {
        fromPointID = 1000090,
        fromMap = 1543,
        fromX = 0.2301,
        fromY = 0.684,
        toPointID = 1000305,
        toMap = 1823,
        toX = 0.8973,
        toY = 0.3452,
        type = "border",
    },
    -- The Maw (map 1543 27.87,20.52) -> Extractor's Sanatorium (map 1822 19.94,73.08) via border
    {
        fromPointID = 1000094,
        fromMap = 1543,
        fromX = 0.2787,
        fromY = 0.2052,
        toPointID = 1000304,
        toMap = 1822,
        toX = 0.1994,
        toY = 0.7308,
        type = "border",
    },
    -- The Maw (map 1543 51.53,90.46) -> Korthia (map 1961 40.04,25.94) via border
    {
        fromPointID = 1000118,
        fromMap = 1543,
        fromX = 0.5153,
        fromY = 0.9046,
        toPointID = 1000313,
        toMap = 1961,
        toX = 0.4004,
        toY = 0.2594,
        type = "border",
    },
    -- The Maw (map 1543 54.62,80.06) -> Pit of Anguish (map 1820 46.35,25.54) via border
    {
        fromPointID = 1000120,
        fromMap = 1543,
        fromX = 0.5462,
        fromY = 0.8006,
        toPointID = 1000297,
        toMap = 1820,
        toX = 0.4635,
        toY = 0.2554,
        type = "border",
    },
    -- The Maw (map 1543 65.61,80.80) -> Korthia (map 1961 58.48,13.67) via border
    {
        fromPointID = 1000121,
        fromMap = 1543,
        fromX = 0.6561,
        fromY = 0.808,
        toPointID = 1000316,
        toMap = 1961,
        toX = 0.5848,
        toY = 0.1367,
        type = "border",
    },

    -- Zone: The Ringing Deeps (map 2214)
    -- The Ringing Deeps (map 2214 36.42,24.25) -> Hallowfall (map 2215 79.24,41.94) via border
    {
        fromPointID = 1200007,
        fromMap = 2214,
        fromX = 0.3642,
        fromY = 0.2425,
        toPointID = 1200038,
        toMap = 2215,
        toX = 0.7924,
        toY = 0.4194,
        type = "border",
    },
    -- The Ringing Deeps (map 2214 38.03,28.36) -> Dornogal (map 2339 38.87,59.81) via border
    {
        fromPointID = 1200008,
        fromMap = 2214,
        fromX = 0.3803,
        fromY = 0.2836,
        toPointID = 1200122,
        toMap = 2339,
        toX = 0.3887,
        toY = 0.5981,
        type = "border",
        travelDuration = 20,
    },
    -- The Ringing Deeps (map 2214 38.58,67.00) -> Azj-Kahet (map 2255 68.00,28.00) via border
    {
        fromPointID = 1200009,
        fromMap = 2214,
        fromX = 0.3858,
        fromY = 0.67,
        toPointID = 1200070,
        toMap = 2255,
        toX = 0.68,
        toY = 0.28,
        type = "border",
    },

    -- Zone: The Storm Peaks (map 120)
    -- The Storm Peaks (map 120 30.00,94.80) -> Crystalsong Forest (map 127 63.60,44.30) via border
    {
        fromPointID = 400086,
        fromMap = 120,
        fromX = 0.3,
        fromY = 0.948,
        toPointID = 400137,
        toMap = 127,
        toX = 0.636,
        toY = 0.443,
        type = "border",
    },
    -- The Storm Peaks (map 120 38.60,94.80) -> Crystalsong Forest (map 127 86.30,44.30) via border
    {
        fromPointID = 400087,
        fromMap = 120,
        fromX = 0.386,
        fromY = 0.948,
        toPointID = 400140,
        toMap = 127,
        toX = 0.863,
        toY = 0.443,
        type = "border",
    },

    -- Zone: The Veiled Stair (map 433)
    -- The Veiled Stair (map 433 31.10,1.70) -> Kun-Lai Summit (map 379 73.30,94.60) via border
    {
        fromPointID = 500148,
        fromMap = 433,
        fromX = 0.311,
        fromY = 0.017,
        toPointID = 500074,
        toMap = 379,
        toX = 0.733,
        toY = 0.946,
        type = "border",
    },
    -- The Veiled Stair (map 433 51.70,93.60) -> Valley of the Four Winds (map 376 71.20,20.40) via border
    {
        fromPointID = 500151,
        fromMap = 433,
        fromX = 0.517,
        fromY = 0.936,
        toPointID = 500039,
        toMap = 376,
        toX = 0.712,
        toY = 0.204,
        type = "border",
    },
    -- The Veiled Stair (map 433 56.60,81.50) -> Valley of the Four Winds (map 376 70.10,22.80) via border
    {
        fromPointID = 500152,
        fromMap = 433,
        fromX = 0.566,
        fromY = 0.815,
        toPointID = 500037,
        toMap = 376,
        toX = 0.701,
        toY = 0.228,
        type = "border",
    },

    -- Zone: Thousand Needles (map 64)
    -- Thousand Needles (map 64 10.20,4.70) -> Feralas (map 69 89.30,36.80) via border
    {
        fromPointID = 100119,
        fromMap = 64,
        fromX = 0.102,
        fromY = 0.047,
        toPointID = 100168,
        toMap = 69,
        toX = 0.893,
        toY = 0.368,
        type = "border",
    },
    -- Thousand Needles (map 64 32.20,20.50) -> Southern Barrens (map 199 43.30,96.50) via border
    {
        fromPointID = 100121,
        fromMap = 64,
        fromX = 0.322,
        fromY = 0.205,
        toPointID = 100340,
        toMap = 199,
        toX = 0.433,
        toY = 0.965,
        type = "border",
    },
    -- Thousand Needles (map 64 72.30,46.60) -> Dustwallow Marsh (map 70 50.30,94.30) via border
    {
        fromPointID = 100124,
        fromMap = 64,
        fromX = 0.723,
        fromY = 0.466,
        toPointID = 100175,
        toMap = 70,
        toX = 0.503,
        toY = 0.943,
        type = "border",
    },
    -- Thousand Needles (map 64 75.30,97.00) -> Tanaris (map 71 51.40,22.90) via border
    {
        fromPointID = 100125,
        fromMap = 64,
        fromX = 0.753,
        fromY = 0.97,
        toPointID = 100190,
        toMap = 71,
        toX = 0.514,
        toY = 0.229,
        type = "border",
    },

    -- Zone: Thunder Bluff (map 88)
    -- Thunder Bluff (map 88 38.10,79.00) -> Mulgore (map 7 38.30,33.90) via border
    {
        fromPointID = 100296,
        fromMap = 88,
        fromX = 0.381,
        fromY = 0.79,
        toPointID = 100034,
        toMap = 7,
        toX = 0.383,
        toY = 0.339,
        type = "border",
    },

    -- Zone: Tiragarde Sound (map 895)
    -- Tiragarde Sound (map 895 43.00,32.46) -> Drustvar (map 896 61.03,14.85) via border
    {
        fromPointID = 800001,
        fromMap = 895,
        fromX = 0.43,
        fromY = 0.3246,
        toPointID = 800033,
        toMap = 896,
        toX = 0.6103,
        toY = 0.1485,
        type = "border",
    },
    -- Tiragarde Sound (map 895 52.50,53.79) -> Drustvar (map 896 73.16,41.94) via border
    {
        fromPointID = 800002,
        fromMap = 895,
        fromX = 0.525,
        fromY = 0.5379,
        toPointID = 800037,
        toMap = 896,
        toX = 0.7316,
        toY = 0.4194,
        type = "border",
    },
    -- Tiragarde Sound (map 895 66.46,8.59) -> Stormsong Valley (map 942 57.86,86.01) via border
    {
        fromPointID = 800004,
        fromMap = 895,
        fromX = 0.6646,
        fromY = 0.0859,
        toPointID = 800052,
        toMap = 942,
        toX = 0.5786,
        toY = 0.8601,
        type = "border",
    },
    -- Tiragarde Sound (map 895 67.00,25.63) -> Boralus (map 1161 43.63,32.47) via border
    {
        fromPointID = 800005,
        fromMap = 895,
        fromX = 0.67,
        fromY = 0.2563,
        toPointID = 800066,
        toMap = 1161,
        toX = 0.4363,
        toY = 0.3247,
        type = "border",
    },
    -- Tiragarde Sound (map 895 68.99,24.52) -> Boralus (map 1161 49.56,19.38) via border
    {
        fromPointID = 800006,
        fromMap = 895,
        fromX = 0.6899,
        fromY = 0.2452,
        toPointID = 800068,
        toMap = 1161,
        toX = 0.4956,
        toY = 0.1938,
        type = "border",
    },
    -- Tiragarde Sound (map 895 74.42,23.89) -> Boralus (map 1161 70.34,17.93) via border
    {
        fromPointID = 800008,
        fromMap = 895,
        fromX = 0.7442,
        fromY = 0.2389,
        toPointID = 800084,
        toMap = 1161,
        toX = 0.7034,
        toY = 0.1793,
        type = "border",
    },
    -- Tiragarde Sound (map 895 76.83,38.93) -> Boralus (map 1161 79.25,76.18) via border
    {
        fromPointID = 800011,
        fromMap = 895,
        fromX = 0.7683,
        fromY = 0.3893,
        toPointID = 800089,
        toMap = 1161,
        toX = 0.7925,
        toY = 0.7618,
        type = "border",
    },
    -- Tiragarde Sound (map 895 99.55,47.62) -> Tol Dagor Isle (map 1169 4.42,84.04) via border
    {
        fromPointID = 800020,
        fromMap = 895,
        fromX = 0.9955,
        fromY = 0.4762,
        toPointID = 800091,
        toMap = 1169,
        toX = 0.0442,
        toY = 0.8404,
        type = "border",
    },

    -- Zone: Tirisfal Glades (map 18)
    -- Tirisfal Glades (map 18 15.18,56.28) -> Tirisfal Glades (map 20 37.57,12.44) via border
    {
        fromPointID = 200039,
        fromMap = 18,
        fromX = 0.1518,
        fromY = 0.5628,
        toPointID = 200061,
        toMap = 20,
        toX = 0.3757,
        toY = 0.1244,
        type = "border",
    },
    -- Tirisfal Glades (map 18 39.30,55.40) -> Deathknell (map 465 81.40,14.40) via border
    {
        fromPointID = 200041,
        fromMap = 18,
        fromX = 0.393,
        fromY = 0.554,
        toPointID = 200608,
        toMap = 465,
        toX = 0.814,
        toY = 0.144,
        type = "border",
    },
    -- Tirisfal Glades (map 18 53.90,77.10) -> Silverpine Forest (map 21 64.90,8.40) via border
    {
        fromPointID = 200043,
        fromMap = 18,
        fromX = 0.539,
        fromY = 0.771,
        toPointID = 200068,
        toMap = 21,
        toX = 0.649,
        toY = 0.084,
        type = "border",
    },
    -- Tirisfal Glades (map 18 61.85,65.20) -> Tirisfal Glades (map 18 61.90,65.00) via border
    {
        fromPointID = 200047,
        fromMap = 18,
        fromX = 0.6185,
        fromY = 0.652,
        toPointID = 200050,
        toMap = 18,
        toX = 0.619,
        toY = 0.65,
        type = "border",
    },
    -- Tirisfal Glades (map 18 61.85,69.50) -> Undercity (map 90 66.30,25.30) via border
    {
        fromPointID = 200048,
        fromMap = 18,
        fromX = 0.6185,
        fromY = 0.695,
        toPointID = 200330,
        toMap = 90,
        toX = 0.663,
        toY = 0.253,
        type = "border",
    },
    -- Tirisfal Glades (map 18 61.90,65.00) -> Tirisfal Glades (map 18 61.85,65.20) via border
    {
        fromPointID = 200050,
        fromMap = 18,
        fromX = 0.619,
        fromY = 0.65,
        toPointID = 200047,
        toMap = 18,
        toX = 0.6185,
        toY = 0.652,
        type = "border",
    },
    -- Tirisfal Glades (map 18 84.60,70.30) -> Western Plaguelands (map 22 29.70,57.30) via border
    {
        fromPointID = 200056,
        fromMap = 18,
        fromX = 0.846,
        fromY = 0.703,
        toPointID = 200073,
        toMap = 22,
        toX = 0.297,
        toY = 0.573,
        type = "border",
    },

    -- Zone: Tirisfal Glades (map 2070)
    -- Tirisfal Glades L (map 2070 53.06,78.34) -> Silverpine Forest (map 21 65.50,8.53) via border
    {
        fromPointID = 200633,
        fromMap = 2070,
        fromX = 0.5306,
        fromY = 0.7834,
        toPointID = 200069,
        toMap = 21,
        toX = 0.655,
        toY = 0.0853,
        type = "border",
    },

    -- Zone: Tol Barad Peninsula (map 245)
    -- Tol Barad Peninsula (map 245 66.73,82.02) -> Tol Barad (map 244 40.95,18.53) via border
    {
        fromPointID = 200469,
        fromMap = 245,
        fromX = 0.6673,
        fromY = 0.8202,
        toPointID = 200464,
        toMap = 244,
        toX = 0.4095,
        toY = 0.1853,
        type = "border",
    },

    -- Zone: Tol Barad (map 244)
    -- Tol Barad (map 244 40.95,18.53) -> Tol Barad Peninsula (map 245 66.73,82.02) via border
    {
        fromPointID = 200464,
        fromMap = 244,
        fromX = 0.4095,
        fromY = 0.1853,
        toPointID = 200469,
        toMap = 245,
        toX = 0.6673,
        toY = 0.8202,
        type = "border",
    },

    -- Zone: Tol Dagor (map 1169)
    -- Tol Dagor Isle (map 1169 4.42,84.04) -> Tiragarde Sound (map 895 99.55,47.62) via border
    {
        fromPointID = 800091,
        fromMap = 1169,
        fromX = 0.0442,
        fromY = 0.8404,
        toPointID = 800020,
        toMap = 895,
        toX = 0.9955,
        toY = 0.4762,
        type = "border",
    },

    -- Zone: Townlong Steppes (map 388)
    -- Townlong Steppes (map 388 60.90,83.90) -> Dread Wastes (map 422 45.20,8.80) via border
    {
        fromPointID = 500095,
        fromMap = 388,
        fromX = 0.609,
        fromY = 0.839,
        toPointID = 500136,
        toMap = 422,
        toX = 0.452,
        toY = 0.088,
        type = "border",
    },
    -- Townlong Steppes (map 388 71.00,42.80) -> Kun-Lai Summit (map 379 29.50,64.40) via border
    {
        fromPointID = 500096,
        fromMap = 388,
        fromX = 0.71,
        fromY = 0.428,
        toPointID = 500044,
        toMap = 379,
        toX = 0.295,
        toY = 0.644,
        type = "border",
    },
    -- Townlong Steppes (map 388 76.00,91.90) -> Dread Wastes (map 422 64.20,10.90) via border
    {
        fromPointID = 500099,
        fromMap = 388,
        fromX = 0.76,
        fromY = 0.919,
        toPointID = 500140,
        toMap = 422,
        toX = 0.642,
        toY = 0.109,
        type = "border",
    },

    -- Zone: Twilight Highlands (map 241)
    -- Twilight Highlands (map 241 24.00,37.30) -> Wetlands (map 56 80.00,47.90) via border
    {
        fromPointID = 200412,
        fromMap = 241,
        fromX = 0.24,
        fromY = 0.373,
        toPointID = 200276,
        toMap = 56,
        toX = 0.8,
        toY = 0.479,
        type = "border",
    },
    -- Twilight Highlands (map 241 24.30,37.40) -> Wetlands (map 56 79.00,47.30) via border
    {
        fromPointID = 200413,
        fromMap = 241,
        fromX = 0.243,
        fromY = 0.374,
        toPointID = 200275,
        toMap = 56,
        toX = 0.79,
        toY = 0.473,
        type = "border",
    },

    -- Zone: Uldum (map 1527)
    -- Uldum New (map 1527 70.51,22.43) -> Tanaris (map 71 25.98,66.23) via border
    {
        fromPointID = 100473,
        fromMap = 1527,
        fromX = 0.7051,
        fromY = 0.2243,
        toPointID = 100181,
        toMap = 71,
        toX = 0.2598,
        toY = 0.6623,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "OldUldum",
                        },
                    },
                },
            },
        },
    },

    -- Zone: Uldum (map 249)
    -- Uldum (map 249 70.60,22.50) -> Tanaris (map 71 25.90,66.30) via border
    {
        fromPointID = 100372,
        fromMap = 249,
        fromX = 0.706,
        fromY = 0.225,
        toPointID = 100180,
        toMap = 71,
        toX = 0.259,
        toY = 0.663,
        type = "border",
    },

    -- Zone: Un'Goro Crater (map 78)
    -- Un'Goro Crater (map 78 29.60,7.40) -> Silithus (map 81 86.10,10.60) via border
    {
        fromPointID = 100226,
        fromMap = 78,
        fromX = 0.296,
        fromY = 0.074,
        toPointID = 100247,
        toMap = 81,
        toX = 0.861,
        toY = 0.106,
        type = "border",
    },
    -- Un'Goro Crater (map 78 70.80,91.90) -> Tanaris (map 71 28.00,51.30) via border
    {
        fromPointID = 100231,
        fromMap = 78,
        fromX = 0.708,
        fromY = 0.919,
        toPointID = 100182,
        toMap = 71,
        toX = 0.28,
        toY = 0.513,
        type = "border",
    },

    -- Zone: Undercity (map 90)
    -- Undercity (map 90 66.30,25.30) -> Tirisfal Glades (map 18 61.85,69.50) via border
    {
        fromPointID = 200330,
        fromMap = 90,
        fromX = 0.663,
        fromY = 0.253,
        toPointID = 200048,
        toMap = 18,
        toX = 0.6185,
        toY = 0.695,
        type = "border",
    },

    -- Zone: Val'sharah (map 641)
    -- Val'sharah (map 641 58.69,92.08) -> Azsuna (map 630 52.60,5.89) via border
    {
        fromPointID = 700102,
        fromMap = 641,
        fromX = 0.5869,
        fromY = 0.9208,
        toPointID = 700054,
        toMap = 630,
        toX = 0.526,
        toY = 0.0589,
        type = "border",
    },
    -- Val'sharah (map 641 68.19,66.37) -> Suramar (map 680 15.07,24.92) via border
    {
        fromPointID = 700105,
        fromMap = 641,
        fromX = 0.6819,
        fromY = 0.6637,
        toPointID = 700139,
        toMap = 680,
        toX = 0.1507,
        toY = 0.2492,
        type = "border",
    },
    -- Val'sharah (map 641 69.35,27.81) -> Highmountain (map 650 26.63,63.74) via border
    {
        fromPointID = 700107,
        fromMap = 641,
        fromX = 0.6935,
        fromY = 0.2781,
        toPointID = 700126,
        toMap = 650,
        toX = 0.2663,
        toY = 0.6374,
        type = "border",
    },

    -- Zone: Vale of Eternal Blossoms (map 1530)
    -- Vale of Eternal Blossoms New (map 1530 44.12,10.42) -> Kun-Lai Summit (map 379 55.54,92.77) via border
    {
        fromPointID = 500286,
        fromMap = 1530,
        fromX = 0.4412,
        fromY = 0.1042,
        toPointID = 500063,
        toMap = 379,
        toX = 0.5554,
        toY = 0.9277,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "OldVale",
                        },
                    },
                },
            },
        },
    },
    -- Vale of Eternal Blossoms New (map 1530 57.48,38.78) -> Pools of Power (map 1579 12.61,74.17) via border
    {
        fromPointID = 500287,
        fromMap = 1530,
        fromX = 0.5748,
        fromY = 0.3878,
        toPointID = 500303,
        toMap = 1579,
        toX = 0.1261,
        toY = 0.7417,
        type = "border",
    },

    -- Zone: Vale of Eternal Blossoms (map 390)
    -- Vale of Eternal Blossoms (map 390 11.80,99.90) -> Valley of the Four Winds (map 376 12.30,33.80) via border
    {
        fromPointID = 500106,
        fromMap = 390,
        fromX = 0.118,
        fromY = 0.999,
        toPointID = 500028,
        toMap = 376,
        toX = 0.123,
        toY = 0.338,
        type = "border",
    },
    -- Vale of Eternal Blossoms (map 390 44.10,12.80) -> Kun-Lai Summit (map 379 55.50,93.00) via border
    {
        fromPointID = 500111,
        fromMap = 390,
        fromX = 0.441,
        fromY = 0.128,
        toPointID = 500062,
        toMap = 379,
        toX = 0.555,
        toY = 0.93,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 31511,
                },
            },
        },
    },
    -- Vale of Eternal Blossoms (map 390 44.10,12.80) -> Kun-Lai Summit (map 379 55.50,93.00) via border
    {
        fromPointID = 500111,
        fromMap = 390,
        fromX = 0.441,
        fromY = 0.128,
        toPointID = 500062,
        toMap = 379,
        toX = 0.555,
        toY = 0.93,
        type = "border",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 31512,
                },
            },
        },
    },

    -- Zone: Valley of Trials (map 461)
    -- Valley of Trials (map 461 73.40,67.11) -> Durotar (map 1 50.60,68.40) via border
    {
        fromPointID = 100440,
        fromMap = 461,
        fromX = 0.734,
        fromY = 0.6711,
        toPointID = 100012,
        toMap = 1,
        toX = 0.506,
        toY = 0.684,
        type = "border",
    },

    -- Zone: Valley of the Four Winds (map 376)
    -- Valley of the Four Winds (map 376 10.70,84.30) -> Krasarang Wilds (map 418 15.00,36.20) via border
    {
        fromPointID = 500026,
        fromMap = 376,
        fromX = 0.107,
        fromY = 0.843,
        toPointID = 500122,
        toMap = 418,
        toX = 0.15,
        toY = 0.362,
        type = "border",
    },
    -- Valley of the Four Winds (map 376 12.30,33.80) -> Vale of Eternal Blossoms (map 390 11.80,99.90) via border
    {
        fromPointID = 500028,
        fromMap = 376,
        fromX = 0.123,
        fromY = 0.338,
        toPointID = 500106,
        toMap = 390,
        toX = 0.118,
        toY = 0.999,
        type = "border",
    },
    -- Valley of the Four Winds (map 376 70.10,22.80) -> The Veiled Stair (map 433 56.60,81.50) via border
    {
        fromPointID = 500037,
        fromMap = 376,
        fromX = 0.701,
        fromY = 0.228,
        toPointID = 500152,
        toMap = 433,
        toX = 0.566,
        toY = 0.815,
        type = "border",
    },
    -- Valley of the Four Winds (map 376 71.20,20.40) -> The Veiled Stair (map 433 51.70,93.60) via border
    {
        fromPointID = 500039,
        fromMap = 376,
        fromX = 0.712,
        fromY = 0.204,
        toPointID = 500151,
        toMap = 433,
        toX = 0.517,
        toY = 0.936,
        type = "border",
    },
    -- Valley of the Four Winds (map 376 82.10,50.70) -> Krasarang Wilds (map 418 74.50,4.00) via border
    {
        fromPointID = 500041,
        fromMap = 376,
        fromX = 0.821,
        fromY = 0.507,
        toPointID = 500127,
        toMap = 418,
        toX = 0.745,
        toY = 0.04,
        type = "border",
    },
    -- Valley of the Four Winds (map 376 90.60,17.70) -> The Jade Forest (map 371 33.60,64.70) via border
    {
        fromPointID = 500043,
        fromMap = 376,
        fromX = 0.906,
        fromY = 0.177,
        toPointID = 500004,
        toMap = 371,
        toX = 0.336,
        toY = 0.647,
        type = "border",
    },

    -- Zone: Vaults of Atal'Utek (map 2509)
    -- Vaults of Atal'Utek (map 2509 38.48,82.87) -> The Coiled Isle (map 2512 34.22,64.90) via border
    {
        fromPointID = 200757,
        fromMap = 2509,
        fromX = 0.3848,
        fromY = 0.8287,
        toPointID = 200775,
        toMap = 2512,
        toX = 0.3422,
        toY = 0.649,
        type = "border",
        travelDuration = 48,
    },
    -- Vaults of Atal'Utek (map 2509 55.92,89.26) -> The Coiled Isle (map 2512 42.66,64.87) via border
    {
        fromPointID = 200767,
        fromMap = 2509,
        fromX = 0.5592,
        fromY = 0.8926,
        toPointID = 200780,
        toMap = 2512,
        toX = 0.4266,
        toY = 0.6487,
        type = "border",
        travelDuration = 48,
    },
    -- Vaults of Atal'Utek (map 2509 63.26,43.23) -> The Coiled Isle (map 2512 40.57,44.09) via border
    {
        fromPointID = 200769,
        fromMap = 2509,
        fromX = 0.6326,
        fromY = 0.4323,
        toPointID = 200778,
        toMap = 2512,
        toX = 0.4057,
        toY = 0.4409,
        type = "border",
        travelDuration = 48,
    },

    -- Zone: Voidscar Cavern (map 2477)
    -- Voidscar Cavern (map 2477 33.80,83.85) -> K'aresh (map 2371 56.84,24.09) via border
    {
        fromPointID = 1200238,
        fromMap = 2477,
        fromX = 0.338,
        fromY = 0.8385,
        toPointID = 1200164,
        toMap = 2371,
        toX = 0.5684,
        toY = 0.2409,
        type = "border",
    },

    -- Zone: Vol'dun (map 864)
    -- Vol'dun (map 864 59.87,71.20) -> Nazmir (map 863 16.08,69.41) via border
    {
        fromPointID = 900062,
        fromMap = 864,
        fromX = 0.5987,
        fromY = 0.712,
        toPointID = 900034,
        toMap = 863,
        toX = 0.1608,
        toY = 0.6941,
        type = "border",
    },
    -- Vol'dun (map 864 63.89,54.52) -> Nazmir (map 863 21.23,47.85) via border
    {
        fromPointID = 900063,
        fromMap = 864,
        fromX = 0.6389,
        fromY = 0.5452,
        toPointID = 900036,
        toMap = 863,
        toX = 0.2123,
        toY = 0.4785,
        type = "border",
    },
    -- Vol'dun (map 864 65.77,44.08) -> Nazmir (map 863 23.82,34.07) via border
    {
        fromPointID = 900064,
        fromMap = 864,
        fromX = 0.6577,
        fromY = 0.4408,
        toPointID = 900037,
        toMap = 863,
        toX = 0.2382,
        toY = 0.3407,
        type = "border",
    },
    -- Vol'dun (map 864 68.96,37.37) -> Nazmir (map 863 27.67,25.68) via border
    {
        fromPointID = 900065,
        fromMap = 864,
        fromX = 0.6896,
        fromY = 0.3737,
        toPointID = 900038,
        toMap = 863,
        toX = 0.2767,
        toY = 0.2568,
        type = "border",
    },

    -- Zone: Warspear (map 624)
    -- Warspear (map 624 48.30,80.90) -> Ashran (map 588 42.00,23.40) via border
    {
        fromPointID = 600139,
        fromMap = 624,
        fromX = 0.483,
        fromY = 0.809,
        toPointID = 600125,
        toMap = 588,
        toX = 0.42,
        toY = 0.234,
        type = "border",
    },

    -- Zone: Western Plaguelands (map 22)
    -- Western Plaguelands (map 22 29.70,57.30) -> Tirisfal Glades (map 18 84.60,70.30) via border
    {
        fromPointID = 200073,
        fromMap = 22,
        fromX = 0.297,
        fromY = 0.573,
        toPointID = 200056,
        toMap = 18,
        toX = 0.846,
        toY = 0.703,
        type = "border",
    },
    -- Western Plaguelands (map 22 43.50,88.10) -> Hillsbrad Foothills (map 25 65.60,25.90) via border
    {
        fromPointID = 200076,
        fromMap = 22,
        fromX = 0.435,
        fromY = 0.881,
        toPointID = 200106,
        toMap = 25,
        toX = 0.656,
        toY = 0.259,
        type = "border",
    },
    -- Western Plaguelands (map 22 65.10,86.50) -> The Hinterlands (map 26 24.30,42.10) via border
    {
        fromPointID = 200080,
        fromMap = 22,
        fromX = 0.651,
        fromY = 0.865,
        toPointID = 200112,
        toMap = 26,
        toX = 0.243,
        toY = 0.421,
        type = "border",
    },
    -- Western Plaguelands (map 22 69.10,50.20) -> Eastern Plaguelands (map 23 9.30,66.10) via border
    {
        fromPointID = 200082,
        fromMap = 22,
        fromX = 0.691,
        fromY = 0.502,
        toPointID = 200085,
        toMap = 23,
        toX = 0.093,
        toY = 0.661,
        type = "border",
    },

    -- Zone: Westfall (map 52)
    -- Westfall (map 52 61.80,17.80) -> Elwynn Forest (map 37 21.00,79.70) via border
    {
        fromPointID = 200254,
        fromMap = 52,
        fromX = 0.618,
        fromY = 0.178,
        toPointID = 200171,
        toMap = 37,
        toX = 0.21,
        toY = 0.797,
        type = "border",
    },
    -- Westfall (map 52 67.30,62.50) -> Duskwood (map 47 10.60,63.00) via border
    {
        fromPointID = 200255,
        fromMap = 52,
        fromX = 0.673,
        fromY = 0.625,
        toPointID = 200199,
        toMap = 47,
        toX = 0.106,
        toY = 0.63,
        type = "border",
    },

    -- Zone: Wetlands (map 56)
    -- Wetlands (map 56 49.30,70.60) -> Wetlands (map 56 50.10,71.60) via border
    {
        fromPointID = 200264,
        fromMap = 56,
        fromX = 0.493,
        fromY = 0.706,
        toPointID = 200265,
        toMap = 56,
        toX = 0.501,
        toY = 0.716,
        type = "border",
    },
    -- Wetlands (map 56 49.30,70.60) -> Wetlands (map 56 53.90,70.30) via border
    {
        fromPointID = 200264,
        fromMap = 56,
        fromX = 0.493,
        fromY = 0.706,
        toPointID = 200270,
        toMap = 56,
        toX = 0.539,
        toY = 0.703,
        type = "border",
    },
    -- Wetlands (map 56 50.10,71.60) -> Wetlands (map 56 49.30,70.60) via border
    {
        fromPointID = 200265,
        fromMap = 56,
        fromX = 0.501,
        fromY = 0.716,
        toPointID = 200264,
        toMap = 56,
        toX = 0.493,
        toY = 0.706,
        type = "border",
    },
    -- Wetlands (map 56 50.10,71.60) -> Wetlands (map 56 50.10,71.60) via border
    {
        fromPointID = 200265,
        fromMap = 56,
        fromX = 0.501,
        fromY = 0.716,
        toPointID = 200265,
        toMap = 56,
        toX = 0.501,
        toY = 0.716,
        type = "border",
    },
    -- Wetlands (map 56 50.10,71.60) -> Wetlands (map 56 50.20,78.30) via border
    {
        fromPointID = 200265,
        fromMap = 56,
        fromX = 0.501,
        fromY = 0.716,
        toPointID = 200267,
        toMap = 56,
        toX = 0.502,
        toY = 0.783,
        type = "border",
    },
    -- Wetlands (map 56 50.20,78.30) -> Wetlands (map 56 50.10,71.60) via border
    {
        fromPointID = 200267,
        fromMap = 56,
        fromX = 0.502,
        fromY = 0.783,
        toPointID = 200265,
        toMap = 56,
        toX = 0.501,
        toY = 0.716,
        type = "border",
    },
    -- Wetlands (map 56 50.20,78.30) -> Wetlands (map 56 50.70,82.60) via border
    {
        fromPointID = 200267,
        fromMap = 56,
        fromX = 0.502,
        fromY = 0.783,
        toPointID = 200268,
        toMap = 56,
        toX = 0.507,
        toY = 0.826,
        type = "border",
    },
    -- Wetlands (map 56 50.70,82.60) -> Wetlands (map 56 50.20,78.30) via border
    {
        fromPointID = 200268,
        fromMap = 56,
        fromX = 0.507,
        fromY = 0.826,
        toPointID = 200267,
        toMap = 56,
        toX = 0.502,
        toY = 0.783,
        type = "border",
    },
    -- Wetlands (map 56 50.70,82.60) -> Wetlands (map 56 55.10,83.50) via border
    {
        fromPointID = 200268,
        fromMap = 56,
        fromX = 0.507,
        fromY = 0.826,
        toPointID = 200272,
        toMap = 56,
        toX = 0.551,
        toY = 0.835,
        type = "border",
    },
    -- Wetlands (map 56 51.00,10.20) -> Arathi Highlands (map 14 38.60,91.00) via border
    {
        fromPointID = 200269,
        fromMap = 56,
        fromX = 0.51,
        fromY = 0.102,
        toPointID = 200010,
        toMap = 14,
        toX = 0.386,
        toY = 0.91,
        type = "border",
    },
    -- Wetlands (map 56 53.90,70.30) -> Wetlands (map 56 49.30,70.60) via border
    {
        fromPointID = 200270,
        fromMap = 56,
        fromX = 0.539,
        fromY = 0.703,
        toPointID = 200264,
        toMap = 56,
        toX = 0.493,
        toY = 0.706,
        type = "border",
    },
    -- Wetlands (map 56 53.90,70.30) -> Wetlands (map 56 54.40,70.30) via border
    {
        fromPointID = 200270,
        fromMap = 56,
        fromX = 0.539,
        fromY = 0.703,
        toPointID = 200271,
        toMap = 56,
        toX = 0.544,
        toY = 0.703,
        type = "border",
    },
    -- Wetlands (map 56 54.40,70.30) -> Wetlands (map 56 53.90,70.30) via border
    {
        fromPointID = 200271,
        fromMap = 56,
        fromX = 0.544,
        fromY = 0.703,
        toPointID = 200270,
        toMap = 56,
        toX = 0.539,
        toY = 0.703,
        type = "border",
    },
    -- Wetlands (map 56 55.10,83.50) -> Loch Modan (map 48 25.30,0.20) via border
    {
        fromPointID = 200272,
        fromMap = 56,
        fromX = 0.551,
        fromY = 0.835,
        toPointID = 200209,
        toMap = 48,
        toX = 0.253,
        toY = 0.002,
        type = "border",
    },
    -- Wetlands (map 56 55.10,83.50) -> Wetlands (map 56 50.70,82.60) via border
    {
        fromPointID = 200272,
        fromMap = 56,
        fromX = 0.551,
        fromY = 0.835,
        toPointID = 200268,
        toMap = 56,
        toX = 0.507,
        toY = 0.826,
        type = "border",
    },
    -- Wetlands (map 56 79.00,47.30) -> Twilight Highlands (map 241 24.30,37.40) via border
    {
        fromPointID = 200275,
        fromMap = 56,
        fromX = 0.79,
        fromY = 0.473,
        toPointID = 200413,
        toMap = 241,
        toX = 0.243,
        toY = 0.374,
        type = "border",
    },
    -- Wetlands (map 56 80.00,47.90) -> Twilight Highlands (map 241 24.00,37.30) via border
    {
        fromPointID = 200276,
        fromMap = 56,
        fromX = 0.8,
        fromY = 0.479,
        toPointID = 200412,
        toMap = 241,
        toX = 0.24,
        toY = 0.373,
        type = "border",
    },

    -- Zone: Winterspring (map 83)
    -- Winterspring (map 83 21.20,46.10) -> Felwood (map 77 64.30,10.30) via border
    {
        fromPointID = 100249,
        fromMap = 83,
        fromX = 0.212,
        fromY = 0.461,
        toPointID = 100225,
        toMap = 77,
        toX = 0.643,
        toY = 0.103,
        type = "border",
    },

    -- Zone: Zangarmarsh (map 102)
    -- Zangarmarsh (map 102 21.00,70.50) -> Nagrand (map 107 34.00,13.00) via border
    {
        fromPointID = 300027,
        fromMap = 102,
        fromX = 0.21,
        fromY = 0.705,
        toPointID = 300068,
        toMap = 107,
        toX = 0.34,
        toY = 0.13,
        type = "border",
    },
    -- Zangarmarsh (map 102 43.30,27.50) -> Blade's Edge Mountains (map 105 28.50,93.90) via border
    {
        fromPointID = 300030,
        fromMap = 102,
        fromX = 0.433,
        fromY = 0.275,
        toPointID = 300055,
        toMap = 105,
        toX = 0.285,
        toY = 0.939,
        type = "border",
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
    -- Zangarmarsh (map 102 68.70,32.90) -> Blade's Edge Mountains (map 105 52.00,98.80) via border
    {
        fromPointID = 300043,
        fromMap = 102,
        fromX = 0.687,
        fromY = 0.329,
        toPointID = 300059,
        toMap = 105,
        toX = 0.52,
        toY = 0.988,
        type = "border",
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
    -- Zangarmarsh (map 102 74.10,32.60) -> Nagrand (map 107 74.10,32.90) via border
    {
        fromPointID = 300044,
        fromMap = 102,
        fromX = 0.741,
        fromY = 0.326,
        toPointID = 300072,
        toMap = 107,
        toX = 0.741,
        toY = 0.329,
        type = "border",
    },
    -- Zangarmarsh (map 102 82.20,92.50) -> Terokkar Forest (map 108 32.30,4.70) via border
    {
        fromPointID = 300046,
        fromMap = 102,
        fromX = 0.822,
        fromY = 0.925,
        toPointID = 300076,
        toMap = 108,
        toX = 0.323,
        toY = 0.047,
        type = "border",
    },
    -- Zangarmarsh (map 102 83.00,65.50) -> Hellfire Peninsula (map 100 4.70,50.60) via border
    {
        fromPointID = 300048,
        fromMap = 102,
        fromX = 0.83,
        fromY = 0.655,
        toPointID = 300001,
        toMap = 100,
        toX = 0.047,
        toY = 0.506,
        type = "border",
    },

    -- Zone: Zaralek Cavern (map 2133)
    -- Zaralek Cavern (map 2133 29.96,77.67) -> Ohn'ahran Plains (map 2023 38.45,56.54) via border
    {
        fromPointID = 1100138,
        fromMap = 2133,
        fromX = 0.2996,
        fromY = 0.7767,
        toPointID = 1100020,
        toMap = 2023,
        toX = 0.3845,
        toY = 0.5654,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 34.50,79.77) -> Zaralek Cavern (map 2133 34.64,79.93) via border
    {
        fromPointID = 1100140,
        fromMap = 2133,
        fromX = 0.345,
        fromY = 0.7977,
        toPointID = 1100142,
        toMap = 2133,
        toX = 0.3464,
        toY = 0.7993,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 34.59,97.62) -> The Azure Span (map 2024 17.80,20.28) via border
    {
        fromPointID = 1100141,
        fromMap = 2133,
        fromX = 0.3459,
        fromY = 0.9762,
        toPointID = 1100049,
        toMap = 2024,
        toX = 0.178,
        toY = 0.2028,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 34.64,79.93) -> Zaralek Cavern (map 2133 34.50,79.77) via border
    {
        fromPointID = 1100142,
        fromMap = 2133,
        fromX = 0.3464,
        fromY = 0.7993,
        toPointID = 1100140,
        toMap = 2133,
        toX = 0.345,
        toY = 0.7977,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 35.91,91.02) -> Zaralek Cavern (map 2133 35.94,90.97) via border
    {
        fromPointID = 1100144,
        fromMap = 2133,
        fromX = 0.3591,
        fromY = 0.9102,
        toPointID = 1100145,
        toMap = 2133,
        toX = 0.3594,
        toY = 0.9097,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 35.94,90.97) -> Zaralek Cavern (map 2133 35.91,91.02) via border
    {
        fromPointID = 1100145,
        fromMap = 2133,
        fromX = 0.3594,
        fromY = 0.9097,
        toPointID = 1100144,
        toMap = 2133,
        toX = 0.3591,
        toY = 0.9102,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 73.64,49.34) -> Zaralek Cavern (map 2133 73.67,49.31) via border
    {
        fromPointID = 1100155,
        fromMap = 2133,
        fromX = 0.7364,
        fromY = 0.4934,
        toPointID = 1100156,
        toMap = 2133,
        toX = 0.7367,
        toY = 0.4931,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 73.67,49.31) -> Zaralek Cavern (map 2133 73.64,49.34) via border
    {
        fromPointID = 1100156,
        fromMap = 2133,
        fromX = 0.7367,
        fromY = 0.4931,
        toPointID = 1100155,
        toMap = 2133,
        toX = 0.7364,
        toY = 0.4934,
        type = "border",
        travelDuration = 1,
    },
    -- Zaralek Cavern (map 2133 79.32,46.39) -> Ohn'ahran Plains (map 2023 86.14,26.57) via border
    {
        fromPointID = 1100158,
        fromMap = 2133,
        fromX = 0.7932,
        fromY = 0.4639,
        toPointID = 1100039,
        toMap = 2023,
        toX = 0.8614,
        toY = 0.2657,
        type = "border",
        travelDuration = 1,
    },

    -- Zone: Zul'Drak (map 121)
    -- Zul'Drak (map 121 12.00,66.90) -> Crystalsong Forest (map 127 97.10,58.50) via border
    {
        fromPointID = 400093,
        fromMap = 121,
        fromX = 0.12,
        fromY = 0.669,
        toPointID = 400142,
        toMap = 127,
        toX = 0.971,
        toY = 0.585,
        type = "border",
    },
    -- Zul'Drak (map 121 15.40,89.70) -> Dragonblight (map 115 89.00,24.00) via border
    {
        fromPointID = 400095,
        fromMap = 121,
        fromX = 0.154,
        fromY = 0.897,
        toPointID = 400034,
        toMap = 115,
        toX = 0.89,
        toY = 0.24,
        type = "border",
    },
    -- Zul'Drak (map 121 55.40,91.10) -> Grizzly Hills (map 116 43.00,25.30) via border
    {
        fromPointID = 400100,
        fromMap = 121,
        fromX = 0.554,
        fromY = 0.911,
        toPointID = 400043,
        toMap = 116,
        toX = 0.43,
        toY = 0.253,
        type = "border",
    },
    -- Zul'Drak (map 121 71.90,79.10) -> Grizzly Hills (map 116 58.70,13.80) via border
    {
        fromPointID = 400103,
        fromMap = 121,
        fromX = 0.719,
        fromY = 0.791,
        toPointID = 400046,
        toMap = 116,
        toX = 0.587,
        toY = 0.138,
        type = "border",
    },

    -- Zone: Zuldazar (map 862)
    -- Zuldazar (map 862 46.15,20.37) -> Nazmir (map 863 31.13,93.94) via border
    {
        fromPointID = 900014,
        fromMap = 862,
        fromX = 0.4615,
        fromY = 0.2037,
        toPointID = 900039,
        toMap = 863,
        toX = 0.3113,
        toY = 0.9394,
        type = "border",
    },
    -- Zuldazar (map 862 53.73,18.59) -> Nazmir (map 863 43.48,91.08) via border
    {
        fromPointID = 900017,
        fromMap = 862,
        fromX = 0.5373,
        fromY = 0.1859,
        toPointID = 900042,
        toMap = 863,
        toX = 0.4348,
        toY = 0.9108,
        type = "border",
    },
    -- Zuldazar (map 862 57.99,17.45) -> Nazmir (map 863 50.35,89.21) via border
    {
        fromPointID = 900020,
        fromMap = 862,
        fromX = 0.5799,
        fromY = 0.1745,
        toPointID = 900043,
        toMap = 863,
        toX = 0.5035,
        toY = 0.8921,
        type = "border",
    },
}

Navigation:RegisterPathData("border", BORDER)
