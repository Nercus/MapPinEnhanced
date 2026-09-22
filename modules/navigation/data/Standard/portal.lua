---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local PORTAL = {

    -- Zone: Aberrus, the Shadowed Crucible (map 2166)
    -- Aberrus, the Shadowed Crucible (map 2166 51.10,95.59) -> Zaralek Cavern (map 2133 48.46,9.94) via portal
    {
        fromPointID = 1100169,
        fromMap = 2166,
        fromX = 0.511,
        fromY = 0.9559,
        toPointID = 1100150,
        toMap = 2133,
        toX = 0.4846,
        toY = 0.0994,
        type = "portal",
    },

    -- Zone: Abyssal Depths (map 204)
    -- Abyssal Depths (map 204 69.49,24.99) -> Throne of the Tides (map 322 49.85,88.23) via portal
    {
        fromPointID = 200366,
        fromMap = 204,
        fromX = 0.6949,
        fromY = 0.2499,
        toPointID = 200550,
        toMap = 322,
        toX = 0.4985,
        toY = 0.8823,
        type = "portal",
    },

    -- Zone: Acherus: The Ebon Hold (map 647)
    -- Broken Shore (map 647 33.96,36.30) -> Broken Shore (map 648 37.77,39.76) via portal
    {
        fromPointID = 700118,
        fromMap = 647,
        fromX = 0.3396,
        fromY = 0.363,
        toPointID = 700123,
        toMap = 648,
        toX = 0.3777,
        toY = 0.3976,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39757,
                },
            },
        },
    },

    -- Zone: Acherus: The Ebon Hold (map 648)
    -- Broken Shore (map 648 24.69,33.74) -> Dalaran L (map 627 60.93,44.73) via portal
    {
        fromPointID = 700120,
        fromMap = 648,
        fromX = 0.2469,
        fromY = 0.3374,
        toPointID = 700021,
        toMap = 627,
        toX = 0.6093,
        toY = 0.4473,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39832,
                },
            },
        },
    },
    -- Broken Shore (map 648 35.41,37.52) -> Broken Shore (map 647 36.25,38.55) via portal
    {
        fromPointID = 700122,
        fromMap = 648,
        fromX = 0.3541,
        fromY = 0.3752,
        toPointID = 700119,
        toMap = 647,
        toX = 0.3625,
        toY = 0.3855,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39757,
                },
            },
        },
    },

    -- Zone: Ahn'Qiraj (map 320)
    -- Ahn'Qiraj (map 320 52.00,26.92) -> Ahn'Qiraj: The Fallen Kingdom (map 327 46.78,7.45) via portal
    {
        fromPointID = 100398,
        fromMap = 320,
        fromX = 0.52,
        fromY = 0.2692,
        toPointID = 100404,
        toMap = 327,
        toX = 0.4678,
        toY = 0.0745,
        type = "portal",
    },

    -- Zone: Ahn'Qiraj: The Fallen Kingdom (map 327)
    -- Ahn'Qiraj: The Fallen Kingdom (map 327 46.78,7.45) -> Ahn'Qiraj (map 320 52.00,26.92) via portal
    {
        fromPointID = 100404,
        fromMap = 327,
        fromX = 0.4678,
        fromY = 0.0745,
        toPointID = 100398,
        toMap = 320,
        toX = 0.52,
        toY = 0.2692,
        type = "portal",
    },
    -- Ahn'Qiraj: The Fallen Kingdom (map 327 58.92,14.29) -> Ruins of Ahn'Qiraj (map 247 60.51,11.70) via portal
    {
        fromPointID = 100406,
        fromMap = 327,
        fromX = 0.5892,
        fromY = 0.1429,
        toPointID = 100366,
        toMap = 247,
        toX = 0.6051,
        toY = 0.117,
        type = "portal",
    },

    -- Zone: Ahn'kahet: The Old Kingdom (map 132)
    -- Ahn'kahet: The Old Kingdom (map 132 88.99,79.12) -> Dragonblight (map 115 28.47,51.72) via portal
    {
        fromPointID = 400144,
        fromMap = 132,
        fromX = 0.8899,
        fromY = 0.7912,
        toPointID = 400019,
        toMap = 115,
        toX = 0.2847,
        toY = 0.5172,
        type = "portal",
    },

    -- Zone: Algeth'ar Academy (map 2099)
    -- Algeth'ar Academy (map 2099 0.00,0.00) -> Thaldraszus (map 2025 58.27,42.22) via portal
    {
        fromPointID = 1100100,
        fromMap = 2099,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100067,
        toMap = 2025,
        toX = 0.5827,
        toY = 0.4222,
        type = "portal",
    },

    -- Zone: Altar of Fangs (map 2588)
    -- Altar of Fangs (map 2588 48.95,18.11) -> Vaults of Atal'Utek (map 2509 47.24,68.55) via portal
    {
        fromPointID = 200859,
        fromMap = 2588,
        fromX = 0.4895,
        fromY = 0.1811,
        toPointID = 200762,
        toMap = 2509,
        toX = 0.4724,
        toY = 0.6855,
        type = "portal",
    },

    -- Zone: Amirdrassil (map 2232)
    -- Amirdrassil, The Dream's Hope (map 2232 27.29,31.04) -> The Emerald Dream (map 2200 27.29,31.04) via portal
    {
        fromPointID = 1100205,
        fromMap = 2232,
        fromX = 0.2729,
        fromY = 0.3104,
        toPointID = 1100195,
        toMap = 2200,
        toX = 0.2729,
        toY = 0.3104,
        type = "portal",
    },

    -- Zone: Amirdrassil (map 2239)
    -- Amirdrassil (map 2239 51.40,18.35) -> Feralas (map 69 45.14,41.73) via portal
    {
        fromPointID = 1100225,
        fromMap = 2239,
        fromX = 0.514,
        fromY = 0.1835,
        toPointID = 100153,
        toMap = 69,
        toX = 0.4514,
        toY = 0.4173,
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
    },
    -- Amirdrassil (map 2239 55.18,64.86) -> Val'sharah (map 641 54.84,72.96) via portal
    {
        fromPointID = 1100227,
        fromMap = 2239,
        fromX = 0.5518,
        fromY = 0.6486,
        toPointID = 700096,
        toMap = 641,
        toX = 0.5484,
        toY = 0.7296,
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
    },
    -- Amirdrassil (map 2239 55.41,64.90) -> Mount Hyjal (map 198 63.49,23.37) via portal
    {
        fromPointID = 1100228,
        fromMap = 2239,
        fromX = 0.5541,
        fromY = 0.649,
        toPointID = 100334,
        toMap = 198,
        toX = 0.6349,
        toY = 0.2337,
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
    },
    -- Amirdrassil (map 2239 55.44,64.58) -> Darkshore (map 62 53.62,18.77) via portal
    {
        fromPointID = 1100229,
        fromMap = 2239,
        fromX = 0.5544,
        fromY = 0.6458,
        toPointID = 100088,
        toMap = 62,
        toX = 0.5362,
        toY = 0.1877,
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
    },
    -- Amirdrassil (map 2239 55.49,63.66) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 1100230,
        fromMap = 2239,
        fromX = 0.5549,
        fromY = 0.6366,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },

    -- Zone: Antoran Wastes (map 885)
    -- Antoran Wastes (map 885 54.85,62.59) -> Antorus (map 910 91.00,69.00) via portal
    {
        fromPointID = 700307,
        fromMap = 885,
        fromX = 0.5485,
        fromY = 0.6259,
        toPointID = 700320,
        toMap = 910,
        toX = 0.91,
        toY = 0.69,
        type = "portal",
    },
    -- Antoran Wastes (map 885 55.35,29.53) -> Invasion Point Naigtal (map 924 25.20,29.85) via portal
    {
        fromPointID = 700308,
        fromMap = 885,
        fromX = 0.5535,
        fromY = 0.2953,
        toPointID = 700327,
        toMap = 924,
        toX = 0.252,
        toY = 0.2985,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5374,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 55.35,29.53) -> Invasion Point Naigtal (map 924 71.95,57.46) via portal
    {
        fromPointID = 700308,
        fromMap = 885,
        fromX = 0.5535,
        fromY = 0.2953,
        toPointID = 700328,
        toMap = 924,
        toX = 0.7195,
        toY = 0.5746,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5374,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 55.75,19.28) -> Invasion Point Bonich (map 922 45.39,48.18) via portal
    {
        fromPointID = 700309,
        fromMap = 885,
        fromX = 0.5575,
        fromY = 0.1928,
        toPointID = 700323,
        toMap = 922,
        toX = 0.4539,
        toY = 0.4818,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5371,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 55.75,19.28) -> Invasion Point Bonich (map 922 69.54,63.16) via portal
    {
        fromPointID = 700309,
        fromMap = 885,
        fromX = 0.5575,
        fromY = 0.1928,
        toPointID = 700324,
        toMap = 922,
        toX = 0.6954,
        toY = 0.6316,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5371,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 60.24,42.98) -> Invasion Point Cen'gar (map 923 27.39,28.40) via portal
    {
        fromPointID = 700310,
        fromMap = 885,
        fromX = 0.6024,
        fromY = 0.4298,
        toPointID = 700325,
        toMap = 923,
        toX = 0.2739,
        toY = 0.284,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5370,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 60.24,42.98) -> Invasion Point Cen'gar (map 923 65.76,69.57) via portal
    {
        fromPointID = 700310,
        fromMap = 885,
        fromX = 0.6024,
        fromY = 0.4298,
        toPointID = 700326,
        toMap = 923,
        toX = 0.6576,
        toY = 0.6957,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5370,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 61.96,30.19) -> Invasion Point Vilemus (map 927 81.54,39.51) via portal
    {
        fromPointID = 700311,
        fromMap = 885,
        fromX = 0.6196,
        fromY = 0.3019,
        toPointID = 700333,
        toMap = 927,
        toX = 0.8154,
        toY = 0.3951,
        type = "portal",
    },
    -- Antoran Wastes (map 885 61.96,30.19) -> Invasion Point Alluradel (map 928 70.41,66.34) via portal
    {
        fromPointID = 700311,
        fromMap = 885,
        fromX = 0.6196,
        fromY = 0.3019,
        toPointID = 700335,
        toMap = 928,
        toX = 0.7041,
        toY = 0.6634,
        type = "portal",
    },
    -- Antoran Wastes (map 885 63.91,63.14) -> Invasion Point Meto (map 930 24.03,27.66) via portal
    {
        fromPointID = 700312,
        fromMap = 885,
        fromX = 0.6391,
        fromY = 0.6314,
        toPointID = 700338,
        toMap = 930,
        toX = 0.2403,
        toY = 0.2766,
        type = "portal",
    },
    -- Antoran Wastes (map 885 63.91,63.14) -> Invasion Point Meto (map 930 29.35,32.05) via portal
    {
        fromPointID = 700312,
        fromMap = 885,
        fromX = 0.6391,
        fromY = 0.6314,
        toPointID = 700339,
        toMap = 930,
        toX = 0.2935,
        toY = 0.3205,
        type = "portal",
    },
    -- Antoran Wastes (map 885 64.59,69.16) -> Invasion Point Aurinor (map 921 20.45,52.72) via portal
    {
        fromPointID = 700313,
        fromMap = 885,
        fromX = 0.6459,
        fromY = 0.6916,
        toPointID = 700321,
        toMap = 921,
        toX = 0.2045,
        toY = 0.5272,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5373,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 64.59,69.16) -> Invasion Point Aurinor (map 921 81.75,39.02) via portal
    {
        fromPointID = 700313,
        fromMap = 885,
        fromX = 0.6459,
        fromY = 0.6916,
        toPointID = 700322,
        toMap = 921,
        toX = 0.8175,
        toY = 0.3902,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5373,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 67.03,33.31) -> Invasion Point Sangua (map 925 24.18,50.61) via portal
    {
        fromPointID = 700314,
        fromMap = 885,
        fromX = 0.6703,
        fromY = 0.3331,
        toPointID = 700329,
        toMap = 925,
        toX = 0.2418,
        toY = 0.5061,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5369,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 67.03,33.31) -> Invasion Point Sangua (map 925 50.91,48.01) via portal
    {
        fromPointID = 700314,
        fromMap = 885,
        fromX = 0.6703,
        fromY = 0.3331,
        toPointID = 700330,
        toMap = 925,
        toX = 0.5091,
        toY = 0.4801,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5369,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 67.47,39.85) -> Invasion Point Alluradel (map 928 69.96,62.58) via portal
    {
        fromPointID = 700315,
        fromMap = 885,
        fromX = 0.6747,
        fromY = 0.3985,
        toPointID = 700334,
        toMap = 928,
        toX = 0.6996,
        toY = 0.6258,
        type = "portal",
    },
    -- Antoran Wastes (map 885 72.65,65.33) -> Invasion Point Val (map 926 55.07,35.85) via portal
    {
        fromPointID = 700316,
        fromMap = 885,
        fromX = 0.7265,
        fromY = 0.6533,
        toPointID = 700332,
        toMap = 926,
        toX = 0.5507,
        toY = 0.3585,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5372,
                },
            },
        },
    },
    -- Antoran Wastes (map 885 72.68,65.22) -> Invasion Point Val (map 926 38.78,74.46) via portal
    {
        fromPointID = 700317,
        fromMap = 885,
        fromX = 0.7268,
        fromY = 0.6522,
        toPointID = 700331,
        toMap = 926,
        toX = 0.3878,
        toY = 0.7446,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5372,
                },
            },
        },
    },

    -- Zone: Antorus, the Burning Throne (map 910)
    -- Antorus (map 910 91.00,69.00) -> Antoran Wastes (map 885 54.85,62.59) via portal
    {
        fromPointID = 700320,
        fromMap = 910,
        fromX = 0.91,
        fromY = 0.69,
        toPointID = 700307,
        toMap = 885,
        toX = 0.5485,
        toY = 0.6259,
        type = "portal",
    },

    -- Zone: Arathi Highlands (map 14)
    -- Arathi Highlands (map 14 21.96,65.15) -> Boralus (map 1161 66.81,25.06) via portal
    {
        fromPointID = 200006,
        fromMap = 14,
        fromX = 0.2196,
        fromY = 0.6515,
        toPointID = 800074,
        toMap = 1161,
        toX = 0.6681,
        toY = 0.2506,
        type = "portal",
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
                            kind = "phase",
                            value = "Old Arathi",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Warfront Arathi Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53198,
                },
            },
        },
    },
    -- Arathi Highlands (map 14 27.44,29.38) -> Dazar'alor (map 1165 51.66,93.82) via portal
    {
        fromPointID = 200008,
        fromMap = 14,
        fromX = 0.2744,
        fromY = 0.2938,
        toPointID = 900089,
        toMap = 1165,
        toX = 0.5166,
        toY = 0.9382,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Arathi",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Warfront Arathi Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53212,
                },
            },
        },
    },

    -- Zone: Arcantina (map 2541)
    -- Arcantina (map 2541 50.61,88.88) -> Silvermoon City M (map 2393 56.36,70.75) via portal
    {
        fromPointID = 200830,
        fromMap = 2541,
        fromX = 0.5061,
        fromY = 0.8888,
        toPointID = 200668,
        toMap = 2393,
        toX = 0.5636,
        toY = 0.7075,
        type = "portal",
    },

    -- Zone: Arcatraz (map 890)
    -- Arcatraz L (map 890 22.13,75.91) -> Krokuun (map 831 45.36,24.20) via portal
    {
        fromPointID = 300164,
        fromMap = 890,
        fromX = 0.2213,
        fromY = 0.7591,
        toPointID = 700289,
        toMap = 831,
        toX = 0.4536,
        toY = 0.242,
        type = "portal",
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

    -- Zone: Archival Assault (map 2452)
    -- Archival Assault (map 2452 39.17,88.46) -> K'aresh (map 2371 55.09,48.07) via portal
    {
        fromPointID = 1200197,
        fromMap = 2452,
        fromX = 0.3917,
        fromY = 0.8846,
        toPointID = 1200163,
        toMap = 2371,
        toX = 0.5509,
        toY = 0.4807,
        type = "portal",
    },

    -- Zone: Ardenweald (map 1565)
    -- Ardenweald (map 1565 20.29,66.96) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000126,
        fromMap = 1565,
        fromX = 0.2029,
        fromY = 0.6696,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 26.45,51.25) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000128,
        fromMap = 1565,
        fromX = 0.2645,
        fromY = 0.5125,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 29.50,34.61) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000129,
        fromMap = 1565,
        fromX = 0.295,
        fromY = 0.3461,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 35.41,54.11) -> Mists of Tirna Scithe (map 1669 0.00,0.00) via portal
    {
        fromPointID = 1000132,
        fromMap = 1565,
        fromX = 0.3541,
        fromY = 0.5411,
        toPointID = 1000163,
        toMap = 1669,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Ardenweald (map 1565 41.11,69.53) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000134,
        fromMap = 1565,
        fromX = 0.4111,
        fromY = 0.6953,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 49.39,27.55) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000135,
        fromMap = 1565,
        fromX = 0.4939,
        fromY = 0.2755,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 53.28,79.04) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000138,
        fromMap = 1565,
        fromX = 0.5328,
        fromY = 0.7904,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 57.49,42.63) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000140,
        fromMap = 1565,
        fromX = 0.5749,
        fromY = 0.4263,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 65.73,60.26) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000144,
        fromMap = 1565,
        fromX = 0.6573,
        fromY = 0.6026,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Ardenweald (map 1565 68.66,66.71) -> De Other Side (map 1680 0.00,0.00) via portal
    {
        fromPointID = 1000146,
        fromMap = 1565,
        fromX = 0.6866,
        fromY = 0.6671,
        toPointID = 1000204,
        toMap = 1680,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Ardenweald (map 1565 73.72,25.21) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000148,
        fromMap = 1565,
        fromX = 0.7372,
        fromY = 0.2521,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },

    -- Zone: Ascension Coliseum (map 1711)
    -- Ascension Coliseum (map 1711 69.86,17.87) -> Elysian Hold (map 1707 29.79,41.85) via portal
    {
        fromPointID = 1000272,
        fromMap = 1711,
        fromX = 0.6986,
        fromY = 0.1787,
        toPointID = 1000263,
        toMap = 1707,
        toX = 0.2979,
        toY = 0.4185,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "covenant",
                                    value = "Kyrian",
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 60496,
                                },
                            },
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 60496,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Ashenvale (map 63)
    -- Ashenvale (map 63 16.49,10.99) -> Blackfathom Deeps (map 221 0.00,0.00) via portal
    {
        fromPointID = 100103,
        fromMap = 63,
        fromX = 0.1649,
        fromY = 0.1099,
        toPointID = 100344,
        toMap = 221,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Atal'Aman (map 2535)
    -- Atal Aman M (map 2535 24.83,49.41) -> Eversong Woods M (map 2395 63.79,80.01) via portal
    {
        fromPointID = 200829,
        fromMap = 2535,
        fromX = 0.2483,
        fromY = 0.4941,
        toPointID = 200678,
        toMap = 2395,
        toX = 0.6379,
        toY = 0.8001,
        type = "portal",
    },

    -- Zone: Atal'Dazar (map 934)
    -- Atal'Dazar (map 934 0.00,0.00) -> Zuldazar (map 862 43.35,39.48) via portal
    {
        fromPointID = 900067,
        fromMap = 934,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 900011,
        toMap = 862,
        toX = 0.4335,
        toY = 0.3948,
        type = "portal",
    },

    -- Zone: Auchenai Crypts (map 256)
    -- Auchenai Crypts (map 256 44.12,75.10) -> Terokkar Forest (map 108 34.30,65.61) via portal
    {
        fromPointID = 300111,
        fromMap = 256,
        fromX = 0.4412,
        fromY = 0.751,
        toPointID = 300077,
        toMap = 108,
        toX = 0.343,
        toY = 0.6561,
        type = "portal",
    },

    -- Zone: Auchindoun (map 593)
    -- Auchindoun (map 593 49.70,90.20) -> Talador (map 535 46.40,73.80) via portal
    {
        fromPointID = 600127,
        fromMap = 593,
        fromX = 0.497,
        fromY = 0.902,
        toPointID = 600042,
        toMap = 535,
        toX = 0.464,
        toY = 0.738,
        type = "portal",
    },

    -- Zone: Azj-Kahet - Lower (map 2256)
    -- Azj-Kahet (map 2256 61.29,84.28) -> Azj-Kahet (map 2255 64.22,75.90) via portal
    {
        fromPointID = 1200075,
        fromMap = 2256,
        fromX = 0.6129,
        fromY = 0.8428,
        toPointID = 1200069,
        toMap = 2255,
        toX = 0.6422,
        toY = 0.759,
        type = "portal",
        travelDuration = 3,
    },

    -- Zone: Azj-Kahet (map 2255)
    -- Azj-Kahet (map 2255 45.05,18.76) -> The Spiral Weave (map 2347 56.28,93.17) via portal
    {
        fromPointID = 1200060,
        fromMap = 2255,
        fromX = 0.4505,
        fromY = 0.1876,
        toPointID = 1200150,
        toMap = 2347,
        toX = 0.5628,
        toY = 0.9317,
        type = "portal",
    },
    -- Azj-Kahet (map 2255 46.82,69.30) -> City of Threads (map 2343 46.87,10.36) via portal
    {
        fromPointID = 1200061,
        fromMap = 2255,
        fromX = 0.4682,
        fromY = 0.693,
        toPointID = 1200136,
        toMap = 2343,
        toX = 0.4687,
        toY = 0.1036,
        type = "portal",
    },
    -- Azj-Kahet (map 2255 57.48,41.61) -> Dornogal (map 2339 63.61,52.59) via portal
    {
        fromPointID = 1200065,
        fromMap = 2255,
        fromX = 0.5748,
        fromY = 0.4161,
        toPointID = 1200132,
        toMap = 2339,
        toX = 0.6361,
        toY = 0.5259,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 78248,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 79573,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Azjol-Nerub (map 157)
    -- Azjol-Nerub (map 157 88.47,76.32) -> Dragonblight (map 115 28.43,47.00) via portal
    {
        fromPointID = 400183,
        fromMap = 157,
        fromX = 0.8847,
        fromY = 0.7632,
        toPointID = 400018,
        toMap = 115,
        toX = 0.2843,
        toY = 0.47,
        type = "portal",
    },

    -- Zone: Azjol-Nerub (map 159)
    -- Azjol-Nerub (map 159 9.44,93.32) -> Dragonblight (map 115 25.96,50.90) via portal
    {
        fromPointID = 400186,
        fromMap = 159,
        fromX = 0.0944,
        fromY = 0.9332,
        toPointID = 400017,
        toMap = 115,
        toX = 0.2596,
        toY = 0.509,
        type = "portal",
    },

    -- Zone: Azsuna (map 630)
    -- Azsuna (map 630 46.66,41.41) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 700046,
        fromMap = 630,
        fromX = 0.4666,
        fromY = 0.4141,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },
    -- Azsuna (map 630 46.67,41.30) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 700047,
        fromMap = 630,
        fromX = 0.4667,
        fromY = 0.413,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
    -- Azsuna (map 630 47.58,28.08) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700050,
        fromMap = 630,
        fromX = 0.4758,
        fromY = 0.2808,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44060,
                },
            },
        },
    },
    -- Azsuna (map 630 48.30,80.23) -> Vault of the Wardens (map 677 70.28,77.60) via portal
    {
        fromPointID = 700052,
        fromMap = 630,
        fromX = 0.483,
        fromY = 0.8023,
        toPointID = 700137,
        toMap = 677,
        toX = 0.7028,
        toY = 0.776,
        type = "portal",
    },
    -- Azsuna (map 630 48.30,80.23) -> Vault of the Wardens 2 (map 710 70.28,77.60) via portal
    {
        fromPointID = 700052,
        fromMap = 630,
        fromX = 0.483,
        fromY = 0.8023,
        toPointID = 700222,
        toMap = 710,
        toX = 0.7028,
        toY = 0.776,
        type = "portal",
    },
    -- Azsuna (map 630 57.95,15.15) -> Hall of the Guardian (map 734 55.06,39.65) via portal
    {
        fromPointID = 700056,
        fromMap = 630,
        fromX = 0.5795,
        fromY = 0.1515,
        toPointID = 700255,
        toMap = 734,
        toX = 0.5506,
        toY = 0.3965,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Azsuna (map 630 61.12,41.11) -> Eye of Azshara (map 713 47.59,87.41) via portal
    {
        fromPointID = 700057,
        fromMap = 630,
        fromX = 0.6112,
        fromY = 0.4111,
        toPointID = 700223,
        toMap = 713,
        toX = 0.4759,
        toY = 0.8741,
        type = "portal",
    },

    -- Zone: Azuremyst Isle (map 97)
    -- Azuremyst Isle (map 97 20.40,54.17) -> Darkshore (map 62 45.95,18.74) via portal
    {
        fromPointID = 100303,
        fromMap = 97,
        fromX = 0.204,
        fromY = 0.5417,
        toPointID = 100083,
        toMap = 62,
        toX = 0.4595,
        toY = 0.1874,
        type = "portal",
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
                            kind = "phase",
                            value = "Old Darnassus",
                        },
                    },
                },
            },
        },
    },
    -- Azuremyst Isle (map 97 20.40,54.17) -> Teldrassil (map 57 52.38,89.47) via portal
    {
        fromPointID = 100303,
        fromMap = 97,
        fromX = 0.204,
        fromY = 0.5417,
        toPointID = 100068,
        toMap = 57,
        toX = 0.5238,
        toY = 0.8947,
        type = "portal",
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
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },

    -- Zone: Badlands (map 15)
    -- Badlands (map 15 40.91,10.27) -> Uldaman Legacy of Tyr (map 2071 0.00,0.00) via portal
    {
        fromPointID = 200016,
        fromMap = 15,
        fromX = 0.4091,
        fromY = 0.1027,
        toPointID = 200640,
        toMap = 2071,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Badlands (map 15 82.81,33.98) -> Badlands (map 15 88.06,32.49) via portal
    {
        fromPointID = 200030,
        fromMap = 15,
        fromX = 0.828078,
        fromY = 0.339781,
        toPointID = 200031,
        toMap = 15,
        toX = 0.880642,
        toY = 0.324937,
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
    },
    -- Badlands (map 15 88.06,32.49) -> Badlands (map 15 82.81,33.98) via portal
    {
        fromPointID = 200031,
        fromMap = 15,
        fromX = 0.880642,
        fromY = 0.324937,
        toPointID = 200030,
        toMap = 15,
        toX = 0.828078,
        toY = 0.339781,
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
    },

    -- Zone: Baradin Hold (map 282)
    -- Baradin Hold (map 282 48.00,91.80) -> Tol Barad (map 244 47.66,52.65) via portal
    {
        fromPointID = 200495,
        fromMap = 282,
        fromX = 0.48,
        fromY = 0.918,
        toPointID = 200465,
        toMap = 244,
        toX = 0.4766,
        toY = 0.5265,
        type = "portal",
    },

    -- Zone: Bastion (map 1533)
    -- Bastion (map 1533 40.13,55.20) -> The Necrotic Wake (map 1666 0.00,0.00) via portal
    {
        fromPointID = 1000032,
        fromMap = 1533,
        fromX = 0.4013,
        fromY = 0.552,
        toPointID = 1000158,
        toMap = 1666,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Bastion (map 1533 40.57,21.10) -> Bastion (map 1533 41.73,23.45) via portal
    {
        fromPointID = 1000034,
        fromMap = 1533,
        fromX = 0.4057,
        fromY = 0.211,
        toPointID = 1000036,
        toMap = 1533,
        toX = 0.4173,
        toY = 0.2345,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 41.67,23.32) -> Bastion (map 1533 40.49,20.95) via portal
    {
        fromPointID = 1000035,
        fromMap = 1533,
        fromX = 0.4167,
        fromY = 0.2332,
        toPointID = 1000033,
        toMap = 1533,
        toX = 0.4049,
        toY = 0.2095,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 46.95,48.91) -> Bastion (map 1533 50.71,46.79) via portal
    {
        fromPointID = 1000041,
        fromMap = 1533,
        fromX = 0.4695,
        fromY = 0.4891,
        toPointID = 1000044,
        toMap = 1533,
        toX = 0.5071,
        toY = 0.4679,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 50.55,46.80) -> Bastion (map 1533 46.86,49.16) via portal
    {
        fromPointID = 1000043,
        fromMap = 1533,
        fromX = 0.5055,
        fromY = 0.468,
        toPointID = 1000040,
        toMap = 1533,
        toX = 0.4686,
        toY = 0.4916,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 52.99,38.02) -> Bastion (map 1533 53.21,45.03) via portal
    {
        fromPointID = 1000047,
        fromMap = 1533,
        fromX = 0.5299,
        fromY = 0.3802,
        toPointID = 1000048,
        toMap = 1533,
        toX = 0.5321,
        toY = 0.4503,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 53.30,44.90) -> Bastion (map 1533 52.99,37.84) via portal
    {
        fromPointID = 1000050,
        fromMap = 1533,
        fromX = 0.533,
        fromY = 0.449,
        toPointID = 1000046,
        toMap = 1533,
        toX = 0.5299,
        toY = 0.3784,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 53.34,48.64) -> Bastion (map 1533 56.11,52.91) via portal
    {
        fromPointID = 1000051,
        fromMap = 1533,
        fromX = 0.5334,
        fromY = 0.4864,
        toPointID = 1000055,
        toMap = 1533,
        toX = 0.5611,
        toY = 0.5291,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 54.32,64.04) -> Bastion (map 1533 57.80,67.00) via portal
    {
        fromPointID = 1000052,
        fromMap = 1533,
        fromX = 0.5432,
        fromY = 0.6404,
        toPointID = 1000057,
        toMap = 1533,
        toX = 0.578,
        toY = 0.67,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60013,
                },
            },
        },
    },
    -- Bastion (map 1533 55.98,52.76) -> Bastion (map 1533 53.26,48.52) via portal
    {
        fromPointID = 1000054,
        fromMap = 1533,
        fromX = 0.5598,
        fromY = 0.5276,
        toPointID = 1000049,
        toMap = 1533,
        toX = 0.5326,
        toY = 0.4852,
        type = "portal",
        travelDuration = 1,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 59196,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 59196,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 63893,
                        },
                    },
                },
            },
        },
    },
    -- Bastion (map 1533 57.70,67.17) -> Bastion (map 1533 54.36,64.15) via portal
    {
        fromPointID = 1000056,
        fromMap = 1533,
        fromX = 0.577,
        fromY = 0.6717,
        toPointID = 1000053,
        toMap = 1533,
        toX = 0.5436,
        toY = 0.6415,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60013,
                },
            },
        },
    },
    -- Bastion (map 1533 58.60,28.52) -> Spires of Ascension (map 1693 0.00,0.00) via portal
    {
        fromPointID = 1000058,
        fromMap = 1533,
        fromX = 0.586,
        fromY = 0.2852,
        toPointID = 1000218,
        toMap = 1693,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Bastion (map 1533 58.73,28.96) -> Elysian Hold (map 1707 41.17,71.10) via portal
    {
        fromPointID = 1000059,
        fromMap = 1533,
        fromX = 0.5873,
        fromY = 0.2896,
        toPointID = 1000264,
        toMap = 1707,
        toX = 0.4117,
        toY = 0.711,
        type = "portal",
        travelDuration = 18,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },
    -- Bastion (map 1533 59.00,11.63) -> Elysian Hold (map 1707 22.38,29.10) via portal
    {
        fromPointID = 1000060,
        fromMap = 1533,
        fromX = 0.59,
        fromY = 0.1163,
        toPointID = 1000261,
        toMap = 1707,
        toX = 0.2238,
        toY = 0.291,
        type = "portal",
        travelDuration = 12,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },
    -- Bastion (map 1533 67.90,27.34) -> Elysian Hold (map 1707 63.00,93.81) via portal
    {
        fromPointID = 1000061,
        fromMap = 1533,
        fromX = 0.679,
        fromY = 0.2734,
        toPointID = 1000270,
        toMap = 1707,
        toX = 0.63,
        toY = 0.9381,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },

    -- Zone: Battle of Dazar'alor (map 1352)
    -- Battle of Dazar'alor (map 1352 49.29,91.20) -> Dazar'alor (map 1165 38.90,2.79) via portal
    {
        fromPointID = 900101,
        fromMap = 1352,
        fromX = 0.4929,
        fromY = 0.912,
        toPointID = 900084,
        toMap = 1165,
        toX = 0.389,
        toY = 0.0279,
        type = "portal",
    },

    -- Zone: Black Rook Hold (map 751)
    -- Black Rook Hold (map 751 29.63,10.30) -> Val'sharah (map 641 37.15,50.20) via portal
    {
        fromPointID = 700273,
        fromMap = 751,
        fromX = 0.2963,
        fromY = 0.103,
        toPointID = 700087,
        toMap = 641,
        toX = 0.3715,
        toY = 0.502,
        type = "portal",
    },

    -- Zone: Black Temple (map 340)
    -- Black Temple (map 340 21.89,59.54) -> Shadowmoon Valley (map 104 71.03,46.65) via portal
    {
        fromPointID = 300149,
        fromMap = 340,
        fromX = 0.2189,
        fromY = 0.5954,
        toPointID = 300054,
        toMap = 104,
        toX = 0.7103,
        toY = 0.4665,
        type = "portal",
    },

    -- Zone: Blackfathom Deeps (map 221)
    -- Blackfathom Deeps (map 221 0.00,0.00) -> Ashenvale (map 63 16.49,10.99) via portal
    {
        fromPointID = 100344,
        fromMap = 221,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100103,
        toMap = 63,
        toX = 0.1649,
        toY = 0.1099,
        type = "portal",
    },

    -- Zone: Blackrock Caverns (map 283)
    -- Blackrock Caverns (map 283 32.02,70.10) -> Burning Steppes (map 34 70.00,53.30) via portal
    {
        fromPointID = 200496,
        fromMap = 283,
        fromX = 0.3202,
        fromY = 0.701,
        toPointID = 200157,
        toMap = 34,
        toX = 0.7,
        toY = 0.533,
        type = "portal",
    },

    -- Zone: Blackrock Depths (map 1186)
    -- Shadowforge City (map 1186 59.30,26.43) -> Stormwind City (map 84 54.49,17.25) via portal
    {
        fromPointID = 200629,
        fromMap = 1186,
        fromX = 0.593,
        fromY = 0.2643,
        toPointID = 200308,
        toMap = 84,
        toX = 0.5449,
        toY = 0.1725,
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
    },

    -- Zone: Blackrock Depths (map 242)
    -- Blackrock Depths (map 242 34.70,77.80) -> Burning Steppes (map 35 40.00,17.00) via portal
    {
        fromPointID = 200431,
        fromMap = 242,
        fromX = 0.347,
        fromY = 0.778,
        toPointID = 200160,
        toMap = 35,
        toX = 0.4,
        toY = 0.17,
        type = "portal",
    },

    -- Zone: Blackrock Depths (map 243)
    -- Blackrock Depths (map 243 68.80,38.20) -> Molten Core (map 232 26.60,25.00) via portal
    {
        fromPointID = 200463,
        fromMap = 243,
        fromX = 0.688,
        fromY = 0.382,
        toPointID = 200409,
        toMap = 232,
        toX = 0.266,
        toY = 0.25,
        type = "portal",
    },

    -- Zone: Blackrock Foundry (map 598)
    -- Blackrock Foundry (map 598 41.00,86.90) -> Gorgrond (map 543 51.55,27.23) via portal
    {
        fromPointID = 600129,
        fromMap = 598,
        fromX = 0.41,
        fromY = 0.869,
        toPointID = 600096,
        toMap = 543,
        toX = 0.5155,
        toY = 0.2723,
        type = "portal",
    },

    -- Zone: Blackrock Mountain (map 33)
    -- Burning Steppes (map 33 64.30,70.90) -> Blackwing Lair (map 287 52.50,83.60) via portal
    {
        fromPointID = 200148,
        fromMap = 33,
        fromX = 0.643,
        fromY = 0.709,
        toPointID = 200506,
        toMap = 287,
        toX = 0.525,
        toY = 0.836,
        type = "portal",
    },
    -- Burning Steppes (map 33 65.60,42.20) -> Blackwing Lair (map 287 52.50,83.60) via portal
    {
        fromPointID = 200149,
        fromMap = 33,
        fromX = 0.656,
        fromY = 0.422,
        toPointID = 200506,
        toMap = 287,
        toX = 0.525,
        toY = 0.836,
        type = "portal",
    },
    -- Burning Steppes (map 33 78.78,31.60) -> Upper Blackrock Spire 2 (map 616 37.20,32.50) via portal
    {
        fromPointID = 200152,
        fromMap = 33,
        fromX = 0.7878,
        fromY = 0.316,
        toPointID = 200627,
        toMap = 616,
        toX = 0.372,
        toY = 0.325,
        type = "portal",
    },
    -- Burning Steppes (map 33 80.40,41.30) -> Blackrock Spire (map 253 37.90,43.30) via portal
    {
        fromPointID = 200154,
        fromMap = 33,
        fromX = 0.804,
        fromY = 0.413,
        toPointID = 200489,
        toMap = 253,
        toX = 0.379,
        toY = 0.433,
        type = "portal",
    },

    -- Zone: Blackrock Mountain (map 34)
    -- Burning Steppes (map 34 70.00,53.30) -> Blackrock Caverns (map 283 32.02,70.10) via portal
    {
        fromPointID = 200157,
        fromMap = 34,
        fromX = 0.7,
        fromY = 0.533,
        toPointID = 200496,
        toMap = 283,
        toX = 0.3202,
        toY = 0.701,
        type = "portal",
    },

    -- Zone: Blackrock Mountain (map 35)
    -- Burning Steppes (map 35 33.06,23.12) -> BRD Pet Battle (map 1578 42.33,57.01) via portal
    {
        fromPointID = 200158,
        fromMap = 35,
        fromX = 0.3306,
        fromY = 0.2312,
        toPointID = 200632,
        toMap = 1578,
        toX = 0.4233,
        toY = 0.5701,
        type = "portal",
    },
    -- Burning Steppes (map 35 40.00,17.00) -> Blackrock Depths (map 242 34.70,77.80) via portal
    {
        fromPointID = 200160,
        fromMap = 35,
        fromX = 0.4,
        fromY = 0.17,
        toPointID = 200431,
        toMap = 242,
        toX = 0.347,
        toY = 0.778,
        type = "portal",
    },
    -- Burning Steppes (map 35 54.10,83.10) -> Molten Core (map 232 26.50,24.30) via portal
    {
        fromPointID = 200161,
        fromMap = 35,
        fromX = 0.541,
        fromY = 0.831,
        toPointID = 200408,
        toMap = 232,
        toX = 0.265,
        toY = 0.243,
        type = "portal",
    },

    -- Zone: Blackrock Spire (map 253)
    -- Blackrock Spire (map 253 37.90,43.30) -> Burning Steppes (map 33 80.40,41.30) via portal
    {
        fromPointID = 200489,
        fromMap = 253,
        fromX = 0.379,
        fromY = 0.433,
        toPointID = 200154,
        toMap = 33,
        toX = 0.804,
        toY = 0.413,
        type = "portal",
    },

    -- Zone: Blackwing Descent (map 285)
    -- Blackwing Descent (map 285 46.80,61.00) -> Burning Steppes (map 36 23.18,26.38) via portal
    {
        fromPointID = 200501,
        fromMap = 285,
        fromX = 0.468,
        fromY = 0.61,
        toPointID = 200166,
        toMap = 36,
        toX = 0.2318,
        toY = 0.2638,
        type = "portal",
    },

    -- Zone: Blackwing Lair (map 287)
    -- Blackwing Lair (map 287 52.50,83.60) -> Burning Steppes (map 33 64.30,70.90) via portal
    {
        fromPointID = 200506,
        fromMap = 287,
        fromX = 0.525,
        fromY = 0.836,
        toPointID = 200148,
        toMap = 33,
        toX = 0.643,
        toY = 0.709,
        type = "portal",
    },
    -- Blackwing Lair (map 287 52.50,83.60) -> Burning Steppes (map 33 65.60,42.20) via portal
    {
        fromPointID = 200506,
        fromMap = 287,
        fromX = 0.525,
        fromY = 0.836,
        toPointID = 200149,
        toMap = 33,
        toX = 0.656,
        toY = 0.422,
        type = "portal",
    },

    -- Zone: Blade's Edge Mountains (map 105)
    -- Blade's Edge Mountains (map 105 39.63,77.39) -> Frostfire Ridge (map 525 37.53,60.71) via portal
    {
        fromPointID = 300057,
        fromMap = 105,
        fromX = 0.3963,
        fromY = 0.7739,
        toPointID = 600005,
        toMap = 525,
        toX = 0.3753,
        toY = 0.6071,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Blade's Edge Mountains (map 105 46.40,64.05) -> Frostfire Ridge (map 525 21.82,45.31) via portal
    {
        fromPointID = 300058,
        fromMap = 105,
        fromX = 0.464,
        fromY = 0.6405,
        toPointID = 600002,
        toMap = 525,
        toX = 0.2182,
        toY = 0.4531,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Blade's Edge Mountains (map 105 59.11,71.69) -> Gorgrond (map 543 49.41,73.66) via portal
    {
        fromPointID = 300061,
        fromMap = 105,
        fromX = 0.5911,
        fromY = 0.7169,
        toPointID = 600094,
        toMap = 543,
        toX = 0.4941,
        toY = 0.7366,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Blade's Edge Mountains (map 105 66.20,26.33) -> Gorgrond (map 543 50.82,31.43) via portal
    {
        fromPointID = 300063,
        fromMap = 105,
        fromX = 0.662,
        fromY = 0.2633,
        toPointID = 600095,
        toMap = 543,
        toX = 0.5082,
        toY = 0.3143,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Blade's Edge Mountains (map 105 69.35,23.62) -> Gruul's Lair (map 330 81.87,78.11) via portal
    {
        fromPointID = 300064,
        fromMap = 105,
        fromX = 0.6935,
        fromY = 0.2362,
        toPointID = 300143,
        toMap = 330,
        toX = 0.8187,
        toY = 0.7811,
        type = "portal",
    },

    -- Zone: Blasted Lands (map 17)
    -- Blasted Lands (map 17 55.01,54.27) -> Stormshield (map 622 31.71,52.48) via portal
    {
        fromPointID = 200037,
        fromMap = 17,
        fromX = 0.5501,
        fromY = 0.5427,
        toPointID = 600134,
        toMap = 622,
        toX = 0.3171,
        toY = 0.5248,
        type = "portal",
        travelDuration = 999,
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
                    kind = "maxLevelExclusive",
                    value = 10,
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Blasted Lands",
                        },
                    },
                },
            },
        },
    },
    -- Blasted Lands (map 17 55.01,54.27) -> Stormshield (map 622 31.71,52.48) via portal
    {
        fromPointID = 200037,
        fromMap = 17,
        fromX = 0.5501,
        fromY = 0.5427,
        toPointID = 600134,
        toMap = 622,
        toX = 0.3171,
        toY = 0.5248,
        type = "portal",
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
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Blasted Lands",
                        },
                    },
                },
            },
        },
    },
    -- Blasted Lands (map 17 55.01,54.27) -> Warspear (map 624 44.42,35.53) via portal
    {
        fromPointID = 200037,
        fromMap = 17,
        fromX = 0.5501,
        fromY = 0.5427,
        toPointID = 600138,
        toMap = 624,
        toX = 0.4442,
        toY = 0.3553,
        type = "portal",
        travelDuration = 999,
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
    -- Blasted Lands (map 17 55.01,54.27) -> Warspear (map 624 44.42,35.53) via portal
    {
        fromPointID = 200037,
        fromMap = 17,
        fromX = 0.5501,
        fromY = 0.5427,
        toPointID = 600138,
        toMap = 624,
        toX = 0.4442,
        toY = 0.3553,
        type = "portal",
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
    -- Blasted Lands (map 17 55.01,54.27) -> Hellfire Peninsula (map 100 89.56,50.22) via portal
    {
        fromPointID = 200037,
        fromMap = 17,
        fromX = 0.5501,
        fromY = 0.5427,
        toPointID = 300025,
        toMap = 100,
        toX = 0.8956,
        toY = 0.5022,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Blasted Lands",
                },
            },
        },
    },
    -- Blasted Lands (map 17 72.65,49.51) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200038,
        fromMap = 17,
        fromX = 0.7265,
        fromY = 0.4951,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    kind = "minLevel",
                    value = 10,
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Blasted Lands",
                        },
                    },
                },
            },
        },
    },

    -- Zone: Bloodmaul Slag Mines (map 573)
    -- Bloodmaul Slag Mines (map 573 51.50,83.30) -> Frostfire Ridge (map 525 49.80,24.70) via portal
    {
        fromPointID = 600120,
        fromMap = 573,
        fromX = 0.515,
        fromY = 0.833,
        toPointID = 600010,
        toMap = 525,
        toX = 0.498,
        toY = 0.247,
        type = "portal",
    },

    -- Zone: Boralus (map 1161)
    -- Boralus (map 1161 50.05,46.69) -> Northern Barrens (map 11 22.88,82.42) via portal
    {
        fromPointID = 800069,
        fromMap = 1161,
        fromX = 0.5005,
        fromY = 0.4669,
        toPointID = 100055,
        toMap = 11,
        toX = 0.2288,
        toY = 0.8242,
        type = "portal",
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
                    value = 45423,
                },
            },
        },
    },
    -- Boralus (map 1161 50.05,46.69) -> Westfall (map 52 41.42,71.22) via portal
    {
        fromPointID = 800069,
        fromMap = 1161,
        fromX = 0.5005,
        fromY = 0.4669,
        toPointID = 200249,
        toMap = 52,
        toX = 0.4142,
        toY = 0.7122,
        type = "portal",
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
                    value = 46291,
                },
            },
        },
    },
    -- Boralus (map 1161 50.05,46.69) -> Dun Morogh (map 30 31.94,71.70) via portal
    {
        fromPointID = 800069,
        fromMap = 1161,
        fromX = 0.5005,
        fromY = 0.4669,
        toPointID = 200136,
        toMap = 30,
        toX = 0.3194,
        toY = 0.717,
        type = "portal",
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
                    value = 54185,
                },
            },
        },
    },
    -- Boralus (map 1161 50.05,46.69) -> Eastern Plaguelands (map 23 43.23,19.96) via portal
    {
        fromPointID = 800069,
        fromMap = 1161,
        fromX = 0.5005,
        fromY = 0.4669,
        toPointID = 200091,
        toMap = 23,
        toX = 0.4323,
        toY = 0.1996,
        type = "portal",
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
                    value = 56491,
                },
            },
        },
    },
    -- Boralus (map 1161 50.05,46.69) -> Burning Steppes (map 35 33.53,23.90) via portal
    {
        fromPointID = 800069,
        fromMap = 1161,
        fromX = 0.5005,
        fromY = 0.4669,
        toPointID = 200159,
        toMap = 35,
        toX = 0.3353,
        toY = 0.239,
        type = "portal",
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
                    value = 58457,
                },
            },
        },
    },
    -- Boralus (map 1161 66.19,24.72) -> Arathi Highlands (map 14 21.58,65.14) via portal
    {
        fromPointID = 800072,
        fromMap = 1161,
        fromX = 0.6619,
        fromY = 0.2472,
        toPointID = 200005,
        toMap = 14,
        toX = 0.2158,
        toY = 0.6514,
        type = "portal",
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
                    kind = "phase",
                    value = "Warfront Arathi Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53194,
                },
            },
        },
    },
    -- Boralus (map 1161 66.22,24.42) -> Darkshore (map 62 46.72,34.73) via portal
    {
        fromPointID = 800073,
        fromMap = 1161,
        fromX = 0.6622,
        fromY = 0.2442,
        toPointID = 100086,
        toMap = 62,
        toX = 0.4672,
        toY = 0.3473,
        type = "portal",
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
                    kind = "phase",
                    value = "Warfront Darkshore Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53194,
                },
            },
        },
    },
    -- Boralus (map 1161 69.65,15.92) -> Silithus (map 81 41.41,45.19) via portal
    {
        fromPointID = 800077,
        fromMap = 1161,
        fromX = 0.6965,
        fromY = 0.1592,
        toPointID = 100240,
        toMap = 81,
        toX = 0.4141,
        toY = 0.4519,
        type = "portal",
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
                    value = 50,
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Boralus (map 1161 69.84,15.29) -> Nazjatar (map 1355 39.96,52.84) via portal
    {
        fromPointID = 800079,
        fromMap = 1161,
        fromX = 0.6984,
        fromY = 0.1529,
        toPointID = 1300027,
        toMap = 1355,
        toX = 0.3996,
        toY = 0.5284,
        type = "portal",
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
                    value = 54972,
                },
            },
        },
    },
    -- Boralus (map 1161 70.13,16.79) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 800081,
        fromMap = 1161,
        fromX = 0.7013,
        fromY = 0.1679,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "BFA",
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Boralus (map 1161 72.10,15.45) -> Siege of Boralus (map 1162 75.33,20.81) via portal
    {
        fromPointID = 800086,
        fromMap = 1161,
        fromX = 0.721,
        fromY = 0.1545,
        toPointID = 800090,
        toMap = 1162,
        toX = 0.7533,
        toY = 0.2081,
        type = "portal",
    },

    -- Zone: Borean Tundra (map 114)
    -- Borean Tundra (map 114 27.50,25.98) -> The Nexus (map 129 36.20,88.00) via portal
    {
        fromPointID = 400001,
        fromMap = 114,
        fromX = 0.275,
        fromY = 0.2598,
        toPointID = 400143,
        toMap = 129,
        toX = 0.362,
        toY = 0.88,
        type = "portal",
    },
    -- Borean Tundra (map 114 27.50,25.98) -> The Oculus (map 142 61.30,47.58) via portal
    {
        fromPointID = 400001,
        fromMap = 114,
        fromX = 0.275,
        fromY = 0.2598,
        toPointID = 400161,
        toMap = 142,
        toX = 0.613,
        toY = 0.4758,
        type = "portal",
    },
    -- Borean Tundra (map 114 27.55,26.65) -> The Eye of Eternity (map 881 31.80,59.50) via portal
    {
        fromPointID = 400002,
        fromMap = 114,
        fromX = 0.2755,
        fromY = 0.2665,
        toPointID = 400242,
        toMap = 881,
        toX = 0.318,
        toY = 0.595,
        type = "portal",
    },

    -- Zone: Brackenhide Hollow (map 2096)
    -- Brackenhide Hollow (map 2096 0.00,0.00) -> The Azure Span (map 2024 11.48,48.91) via portal
    {
        fromPointID = 1100095,
        fromMap = 2096,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100046,
        toMap = 2024,
        toX = 0.1148,
        toY = 0.4891,
        type = "portal",
    },

    -- Zone: Brawl'gar Arena (map 503)
    -- Brawl'gar Arena (map 503 55.53,14.28) -> Orgrimmar (map 85 70.57,30.92) via portal
    {
        fromPointID = 100449,
        fromMap = 503,
        fromX = 0.5553,
        fromY = 0.1428,
        toPointID = 100288,
        toMap = 85,
        toX = 0.7057,
        toY = 0.3092,
        type = "portal",
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

    -- Zone: Broken Shore (map 646)
    -- Broken Shore (map 646 44.81,61.32) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700115,
        fromMap = 646,
        fromX = 0.4481,
        fromY = 0.6132,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 46734,
                },
            },
        },
    },
    -- Broken Shore (map 646 64.53,20.81) -> Tomb of Sargeras (map 850 45.20,90.20) via portal
    {
        fromPointID = 700116,
        fromMap = 646,
        fromX = 0.6453,
        fromY = 0.2081,
        toPointID = 700294,
        toMap = 850,
        toX = 0.452,
        toY = 0.902,
        type = "portal",
    },
    -- Broken Shore (map 646 64.70,16.59) -> Cathedral of Eternal Night (map 845 46.80,90.20) via portal
    {
        fromPointID = 700117,
        fromMap = 646,
        fromX = 0.647,
        fromY = 0.1659,
        toPointID = 700293,
        toMap = 845,
        toX = 0.468,
        toY = 0.902,
        type = "portal",
    },

    -- Zone: Burning Steppes (map 36)
    -- Burning Steppes (map 36 23.18,26.38) -> Blackwing Descent (map 285 46.80,61.00) via portal
    {
        fromPointID = 200166,
        fromMap = 36,
        fromX = 0.2318,
        fromY = 0.2638,
        toPointID = 200501,
        toMap = 285,
        toX = 0.468,
        toY = 0.61,
        type = "portal",
    },

    -- Zone: Castle Nathria (map 1735)
    -- Castle Nathria (map 1735 0.00,0.00) -> Revendreth (map 1525 46.37,41.50) via portal
    {
        fromPointID = 1000276,
        fromMap = 1735,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000012,
        toMap = 1525,
        toX = 0.4637,
        toY = 0.415,
        type = "portal",
    },

    -- Zone: Cathedral of Eternal Night (map 845)
    -- Cathedral of Eternal Night (map 845 46.80,90.20) -> Broken Shore (map 646 64.70,16.59) via portal
    {
        fromPointID = 700293,
        fromMap = 845,
        fromX = 0.468,
        fromY = 0.902,
        toPointID = 700117,
        toMap = 646,
        toX = 0.647,
        toY = 0.1659,
        type = "portal",
    },

    -- Zone: Caverns of Time (map 74)
    -- Tanaris (map 74 58.20,26.69) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 100204,
        fromMap = 74,
        fromX = 0.582,
        fromY = 0.2669,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },
    -- Tanaris (map 74 58.97,26.78) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 100205,
        fromMap = 74,
        fromX = 0.5897,
        fromY = 0.2678,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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

    -- Zone: Caverns of Time (map 75)
    -- Tanaris (map 75 22.50,64.40) -> Well of Eternity (map 398 27.82,63.37) via portal
    {
        fromPointID = 100206,
        fromMap = 75,
        fromX = 0.225,
        fromY = 0.644,
        toPointID = 100414,
        toMap = 398,
        toX = 0.2782,
        toY = 0.6337,
        type = "portal",
    },
    -- Tanaris (map 75 26.90,35.90) -> Old Hillsbrad Foothills (map 274 23.23,24.80) via portal
    {
        fromPointID = 100207,
        fromMap = 75,
        fromX = 0.269,
        fromY = 0.359,
        toPointID = 100376,
        toMap = 274,
        toX = 0.2323,
        toY = 0.248,
        type = "portal",
    },
    -- Tanaris (map 75 36.30,83.20) -> The Black Morass (map 273 52.06,0.15) via portal
    {
        fromPointID = 100208,
        fromMap = 75,
        fromX = 0.363,
        fromY = 0.832,
        toPointID = 100375,
        toMap = 273,
        toX = 0.5206,
        toY = 0.0015,
        type = "portal",
    },
    -- Tanaris (map 75 57.40,82.60) -> The Culling of Stratholme (map 130 87.51,71.21) via portal
    {
        fromPointID = 100209,
        fromMap = 75,
        fromX = 0.574,
        fromY = 0.826,
        toPointID = 100319,
        toMap = 130,
        toX = 0.8751,
        toY = 0.7121,
        type = "portal",
    },
    -- Tanaris (map 75 57.60,29.60) -> End Time (map 401 80.73,44.20) via portal
    {
        fromPointID = 100210,
        fromMap = 75,
        fromX = 0.576,
        fromY = 0.296,
        toPointID = 100419,
        toMap = 401,
        toX = 0.8073,
        toY = 0.442,
        type = "portal",
    },
    -- Tanaris (map 75 61.97,26.97) -> Dragon Soul (map 409 50.00,84.00) via portal
    {
        fromPointID = 100212,
        fromMap = 75,
        fromX = 0.6197,
        fromY = 0.2697,
        toPointID = 100426,
        toMap = 409,
        toX = 0.5,
        toY = 0.84,
        type = "portal",
    },
    -- Tanaris (map 75 67.20,29.40) -> Hour of Twilight (map 399 48.51,19.72) via portal
    {
        fromPointID = 100213,
        fromMap = 75,
        fromX = 0.672,
        fromY = 0.294,
        toPointID = 100415,
        toMap = 399,
        toX = 0.4851,
        toY = 0.1972,
        type = "portal",
    },

    -- Zone: Chamber of Heart (map 1021)
    -- Chamber of Heart (map 1021 50.09,30.45) -> Silithus (map 81 41.41,45.19) via portal
    {
        fromPointID = 100457,
        fromMap = 1021,
        fromX = 0.5009,
        fromY = 0.3045,
        toPointID = 100240,
        toMap = 81,
        toX = 0.4141,
        toY = 0.4519,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Chamber of Heart (map 1021 50.13,73.20) -> Orgrimmar Vision (map 1469 52.10,83.85) via portal
    {
        fromPointID = 100458,
        fromMap = 1021,
        fromX = 0.5013,
        fromY = 0.732,
        toPointID = 100464,
        toMap = 1469,
        toX = 0.521,
        toY = 0.8385,
        type = "portal",
    },
    -- Chamber of Heart (map 1021 50.13,73.20) -> Stormwind Vision (map 1470 52.18,51.67) via portal
    {
        fromPointID = 100458,
        fromMap = 1021,
        fromX = 0.5013,
        fromY = 0.732,
        toPointID = 200631,
        toMap = 1470,
        toX = 0.5218,
        toY = 0.5167,
        type = "portal",
    },

    -- Zone: Cinderbrew Meadery (map 2335)
    -- Cinderbrew Meadery (map 2335 23.91,52.38) -> Isle of Dorn (map 2248 76.71,43.78) via portal
    {
        fromPointID = 1200116,
        fromMap = 2335,
        fromX = 0.2391,
        fromY = 0.5238,
        toPointID = 1200053,
        toMap = 2248,
        toX = 0.7671,
        toY = 0.4378,
        type = "portal",
    },

    -- Zone: City of Echoes (map 2357)
    -- City of Echoes (map 2357 76.14,78.68) -> Nerub'ar (map 2216 51.94,46.80) via portal
    {
        fromPointID = 1200152,
        fromMap = 2357,
        fromX = 0.7614,
        fromY = 0.7868,
        toPointID = 1200040,
        toMap = 2216,
        toX = 0.5194,
        toY = 0.468,
        type = "portal",
    },

    -- Zone: City of Threads - Lower (map 2216)
    -- Nerub'ar (map 2216 51.94,46.80) -> City of Echoes (map 2357 76.14,78.68) via portal
    {
        fromPointID = 1200040,
        fromMap = 2216,
        fromX = 0.5194,
        fromY = 0.468,
        toPointID = 1200152,
        toMap = 2357,
        toX = 0.7614,
        toY = 0.7868,
        type = "portal",
    },
    -- Nerub'ar (map 2216 67.66,24.65) -> Tak-Rethan Abyss (map 2259 52.74,12.96) via portal
    {
        fromPointID = 1200042,
        fromMap = 2216,
        fromX = 0.6766,
        fromY = 0.2465,
        toPointID = 1200077,
        toMap = 2259,
        toX = 0.5274,
        toY = 0.1296,
        type = "portal",
    },

    -- Zone: City of Threads (map 2213)
    -- Nerub'ar (map 2213 34.78,72.83) -> Nerub'ar Palace (map 2292 71.66,10.76) via portal
    {
        fromPointID = 1200001,
        fromMap = 2213,
        fromX = 0.3478,
        fromY = 0.7283,
        toPointID = 1200084,
        toMap = 2292,
        toX = 0.7166,
        toY = 0.1076,
        type = "portal",
    },
    -- Nerub'ar (map 2213 58.67,66.68) -> The Underkeep (map 2299 31.90,21.39) via portal
    {
        fromPointID = 1200002,
        fromMap = 2213,
        fromX = 0.5867,
        fromY = 0.6668,
        toPointID = 1200092,
        toMap = 2299,
        toX = 0.319,
        toY = 0.2139,
        type = "portal",
    },

    -- Zone: City of Threads (map 2343)
    -- City of Threads (map 2343 46.87,10.36) -> Azj-Kahet (map 2255 46.82,69.30) via portal
    {
        fromPointID = 1200136,
        fromMap = 2343,
        fromX = 0.4687,
        fromY = 0.1036,
        toPointID = 1200061,
        toMap = 2255,
        toX = 0.4682,
        toY = 0.693,
        type = "portal",
    },

    -- Zone: Collegiate Calamity (map 2577)
    -- Collegiate Calamity (map 2577 69.40,82.10) -> Silvermoon City M (map 2393 40.27,53.05) via portal
    {
        fromPointID = 200848,
        fromMap = 2577,
        fromX = 0.694,
        fromY = 0.821,
        toPointID = 200661,
        toMap = 2393,
        toX = 0.4027,
        toY = 0.5305,
        type = "portal",
    },

    -- Zone: Court of Stars (map 761)
    -- Court of Stars (map 761 6.84,68.64) -> Suramar (map 680 50.68,65.49) via portal
    {
        fromPointID = 700274,
        fromMap = 761,
        fromX = 0.0684,
        fromY = 0.6864,
        toPointID = 700182,
        toMap = 680,
        toX = 0.5068,
        toY = 0.6549,
        type = "portal",
    },

    -- Zone: Crystalsong Forest (map 127)
    -- Crystalsong Forest (map 127 15.74,42.47) -> Dalaran (map 125 55.92,46.79) via portal
    {
        fromPointID = 400130,
        fromMap = 127,
        fromX = 0.1574,
        fromY = 0.4247,
        toPointID = 400120,
        toMap = 125,
        toX = 0.5592,
        toY = 0.4679,
        type = "portal",
    },

    -- Zone: Dalaran (map 125)
    -- Dalaran (map 125 22.31,39.67) -> Dalaran (map 125 26.84,44.71) via portal
    {
        fromPointID = 400110,
        fromMap = 125,
        fromX = 0.2231,
        fromY = 0.3967,
        toPointID = 400113,
        toMap = 125,
        toX = 0.2684,
        toY = 0.4471,
        type = "portal",
    },
    -- Dalaran (map 125 25.96,44.14) -> Dalaran (map 125 23.95,39.43) via portal
    {
        fromPointID = 400112,
        fromMap = 125,
        fromX = 0.2596,
        fromY = 0.4414,
        toPointID = 400111,
        toMap = 125,
        toX = 0.2395,
        toY = 0.3943,
        type = "portal",
    },
    -- Dalaran (map 125 40.10,62.81) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 400116,
        fromMap = 125,
        fromX = 0.401,
        fromY = 0.6281,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },
    -- Dalaran (map 125 55.33,25.45) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 400118,
        fromMap = 125,
        fromX = 0.5533,
        fromY = 0.2545,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
    -- Dalaran (map 125 55.93,46.77) -> Crystalsong Forest (map 127 15.81,42.85) via portal
    {
        fromPointID = 400121,
        fromMap = 125,
        fromX = 0.5593,
        fromY = 0.4677,
        toPointID = 400131,
        toMap = 127,
        toX = 0.1581,
        toY = 0.4285,
        type = "portal",
    },
    -- Dalaran (map 125 68.60,70.39) -> The Violet Hold (map 168 46.15,98.03) via portal
    {
        fromPointID = 400123,
        fromMap = 125,
        fromX = 0.686,
        fromY = 0.7039,
        toPointID = 400204,
        toMap = 168,
        toX = 0.4615,
        toY = 0.9803,
        type = "portal",
    },

    -- Zone: Dalaran (map 626)
    -- Dalaran L (map 626 29.48,22.02) -> Dalaran L (map 627 46.44,26.01) via portal
    {
        fromPointID = 700001,
        fromMap = 626,
        fromX = 0.2948,
        fromY = 0.2202,
        toPointID = 700011,
        toMap = 627,
        toX = 0.4644,
        toY = 0.2601,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 40832,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40832,
                        },
                    },
                },
            },
        },
    },
    -- Dalaran L (map 626 39.67,21.52) -> Dalaran L (map 627 54.20,32.68) via portal
    {
        fromPointID = 700002,
        fromMap = 626,
        fromX = 0.3967,
        fromY = 0.2152,
        toPointID = 700015,
        toMap = 627,
        toX = 0.542,
        toY = 0.3268,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 40832,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40832,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Dalaran (map 627)
    -- Dalaran L (map 627 32.59,69.96) -> Eastern Plaguelands (map 24 39.42,61.46) via portal
    {
        fromPointID = 700004,
        fromMap = 627,
        fromX = 0.3259,
        fromY = 0.6996,
        toPointID = 200100,
        toMap = 24,
        toX = 0.3942,
        toY = 0.6146,
        type = "portal",
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
                    value = 38566,
                },
            },
        },
    },
    -- Dalaran L (map 627 39.55,63.22) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 700008,
        fromMap = 627,
        fromX = 0.3955,
        fromY = 0.6322,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },
    -- Dalaran L (map 627 39.61,57.24) -> Netherlight Temple (map 702 49.64,75.50) via portal
    {
        fromPointID = 700009,
        fromMap = 627,
        fromX = 0.3961,
        fromY = 0.5724,
        toPointID = 700215,
        toMap = 702,
        toX = 0.4964,
        toY = 0.755,
        type = "portal",
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
                    value = 40938,
                },
            },
        },
    },
    -- Dalaran L (map 627 49.26,47.62) -> Dalaran L (map 629 63.38,23.87) via portal
    {
        fromPointID = 700013,
        fromMap = 627,
        fromX = 0.4926,
        fromY = 0.4762,
        toPointID = 700042,
        toMap = 629,
        toX = 0.6338,
        toY = 0.2387,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },
    -- Dalaran L (map 627 55.25,23.93) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 700016,
        fromMap = 627,
        fromX = 0.5525,
        fromY = 0.2393,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },
    -- Dalaran L (map 627 58.61,39.34) -> Northern Barrens (map 11 22.88,82.42) via portal
    {
        fromPointID = 700017,
        fromMap = 627,
        fromX = 0.5861,
        fromY = 0.3934,
        toPointID = 100055,
        toMap = 11,
        toX = 0.2288,
        toY = 0.8242,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 45423,
                },
            },
        },
    },
    -- Dalaran L (map 627 58.61,39.34) -> Westfall (map 52 41.42,71.22) via portal
    {
        fromPointID = 700017,
        fromMap = 627,
        fromX = 0.5861,
        fromY = 0.3934,
        toPointID = 200249,
        toMap = 52,
        toX = 0.4142,
        toY = 0.7122,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 46291,
                },
            },
        },
    },
    -- Dalaran L (map 627 58.61,39.34) -> Dun Morogh (map 30 31.94,71.70) via portal
    {
        fromPointID = 700017,
        fromMap = 627,
        fromX = 0.5861,
        fromY = 0.3934,
        toPointID = 200136,
        toMap = 30,
        toX = 0.3194,
        toY = 0.717,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 54185,
                },
            },
        },
    },
    -- Dalaran L (map 627 58.61,39.34) -> Eastern Plaguelands (map 23 43.23,19.96) via portal
    {
        fromPointID = 700017,
        fromMap = 627,
        fromX = 0.5861,
        fromY = 0.3934,
        toPointID = 200091,
        toMap = 23,
        toX = 0.4323,
        toY = 0.1996,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 56491,
                },
            },
        },
    },
    -- Dalaran L (map 627 58.61,39.34) -> Burning Steppes (map 35 33.53,23.90) via portal
    {
        fromPointID = 700017,
        fromMap = 627,
        fromX = 0.5861,
        fromY = 0.3934,
        toPointID = 200159,
        toMap = 35,
        toX = 0.3353,
        toY = 0.239,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 58457,
                },
            },
        },
    },
    -- Dalaran L (map 627 61.92,13.49) -> Eastern Plaguelands (map 24 39.42,61.46) via portal
    {
        fromPointID = 700024,
        fromMap = 627,
        fromX = 0.6192,
        fromY = 0.1349,
        toPointID = 200100,
        toMap = 24,
        toX = 0.3942,
        toY = 0.6146,
        type = "portal",
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
                    value = 38566,
                },
            },
        },
    },
    -- Dalaran L (map 627 63.00,17.70) -> Netherlight Temple (map 702 49.64,75.50) via portal
    {
        fromPointID = 700025,
        fromMap = 627,
        fromX = 0.63,
        fromY = 0.177,
        toPointID = 700215,
        toMap = 702,
        toX = 0.4964,
        toY = 0.755,
        type = "portal",
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
                    value = 40938,
                },
            },
        },
    },
    -- Dalaran L (map 627 66.94,69.16) -> Violet Hold (map 732 50.95,69.91) via portal
    {
        fromPointID = 700026,
        fromMap = 627,
        fromX = 0.6694,
        fromY = 0.6916,
        toPointID = 700252,
        toMap = 732,
        toX = 0.5095,
        toY = 0.6991,
        type = "portal",
    },
    -- Dalaran L (map 627 67.03,48.18) -> The Maelstrom L (map 726 30.75,53.07) via portal
    {
        fromPointID = 700027,
        fromMap = 627,
        fromX = 0.6703,
        fromY = 0.4818,
        toPointID = 700249,
        toMap = 726,
        toX = 0.3075,
        toY = 0.5307,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39746,
                },
            },
        },
    },
    -- Dalaran L (map 627 72.85,41.21) -> Trueshot Lodge (map 739 33.25,49.43) via portal
    {
        fromPointID = 700030,
        fromMap = 627,
        fromX = 0.7285,
        fromY = 0.4121,
        toPointID = 700263,
        toMap = 739,
        toX = 0.3325,
        toY = 0.4943,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40953,
                },
            },
        },
    },
    -- Dalaran L (map 627 74.22,49.26) -> Krokuun (map 831 61.15,81.36) via portal
    {
        fromPointID = 700031,
        fromMap = 627,
        fromX = 0.7422,
        fromY = 0.4926,
        toPointID = 700290,
        toMap = 831,
        toX = 0.6115,
        toY = 0.8136,
        type = "portal",
    },
    -- Dalaran L (map 627 75.23,47.22) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700032,
        fromMap = 627,
        fromX = 0.7523,
        fromY = 0.4722,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39654,
                },
            },
        },
    },
    -- Dalaran L (map 627 98.02,69.27) -> Mardum, the Shattered Abyss (map 720 59.18,85.75) via portal
    {
        fromPointID = 700034,
        fromMap = 627,
        fromX = 0.9802,
        fromY = 0.6927,
        toPointID = 700241,
        toMap = 720,
        toX = 0.5918,
        toY = 0.8575,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42872,
                },
            },
        },
    },

    -- Zone: Dalaran (map 628)
    -- Dalaran L (map 628 27.85,44.50) -> Dreadscar Rift (map 717 72.52,37.47) via portal
    {
        fromPointID = 700036,
        fromMap = 628,
        fromX = 0.2785,
        fromY = 0.445,
        toPointID = 700239,
        toMap = 717,
        toX = 0.7252,
        toY = 0.3747,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40729,
                },
            },
        },
    },

    -- Zone: Dalaran (map 629)
    -- Dalaran L (map 629 31.95,71.43) -> Deadwind Pass (map 42 47.24,75.40) via portal
    {
        fromPointID = 700039,
        fromMap = 629,
        fromX = 0.3195,
        fromY = 0.7143,
        toPointID = 200194,
        toMap = 42,
        toX = 0.4724,
        toY = 0.754,
        type = "portal",
    },
    -- Dalaran L (map 629 33.72,78.88) -> Telogrus Rift (map 971 25.34,27.89) via portal
    {
        fromPointID = 700040,
        fromMap = 629,
        fromX = 0.3372,
        fromY = 0.7888,
        toPointID = 700345,
        toMap = 971,
        toX = 0.2534,
        toY = 0.2789,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 79010,
                },
            },
        },
    },
    -- Dalaran L (map 629 64.88,21.12) -> Dalaran L (map 627 49.04,48.04) via portal
    {
        fromPointID = 700043,
        fromMap = 629,
        fromX = 0.6488,
        fromY = 0.2112,
        toPointID = 700012,
        toMap = 627,
        toX = 0.4904,
        toY = 0.4804,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },

    -- Zone: Darkflame Cleft (map 2303)
    -- Darkflame Cleft (map 2303 16.52,68.90) -> The Ringing Deeps (map 2214 55.50,21.50) via portal
    {
        fromPointID = 1200095,
        fromMap = 2303,
        fromX = 0.1652,
        fromY = 0.689,
        toPointID = 1200017,
        toMap = 2214,
        toX = 0.555,
        toY = 0.215,
        type = "portal",
    },

    -- Zone: Darkheart Thicket (map 733)
    -- Darkheart Thicket (map 733 36.71,14.16) -> Val'sharah (map 641 59.06,31.21) via portal
    {
        fromPointID = 700253,
        fromMap = 733,
        fromX = 0.3671,
        fromY = 0.1416,
        toPointID = 700104,
        toMap = 641,
        toX = 0.5906,
        toY = 0.3121,
        type = "portal",
    },

    -- Zone: Darkmoon Island (map 407)
    -- Darkmoon Island (map 407 50.56,90.75) -> Elwynn Forest (map 37 41.87,68.17) via portal
    {
        fromPointID = 1300020,
        fromMap = 407,
        fromX = 0.5056,
        fromY = 0.9075,
        toPointID = 200180,
        toMap = 37,
        toX = 0.4187,
        toY = 0.6817,
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
    },
    -- Darkmoon Island (map 407 50.56,90.75) -> Mulgore (map 7 36.49,35.11) via portal
    {
        fromPointID = 1300020,
        fromMap = 407,
        fromX = 0.5056,
        fromY = 0.9075,
        toPointID = 100032,
        toMap = 7,
        toX = 0.3649,
        toY = 0.3511,
        type = "portal",
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
    -- Darkmoon Island (map 407 51.22,23.12) -> Elwynn Forest (map 37 41.87,68.17) via portal
    {
        fromPointID = 1300021,
        fromMap = 407,
        fromX = 0.5122,
        fromY = 0.2312,
        toPointID = 200180,
        toMap = 37,
        toX = 0.4187,
        toY = 0.6817,
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
    },
    -- Darkmoon Island (map 407 51.22,23.12) -> Mulgore (map 7 36.49,35.11) via portal
    {
        fromPointID = 1300021,
        fromMap = 407,
        fromX = 0.5122,
        fromY = 0.2312,
        toPointID = 100032,
        toMap = 7,
        toX = 0.3649,
        toY = 0.3511,
        type = "portal",
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

    -- Zone: Darkshore (map 1332)
    -- Darkshore Warfront (map 1332 52.70,21.28) -> Dazar'alor (map 1165 51.66,93.82) via portal
    {
        fromPointID = 100460,
        fromMap = 1332,
        fromX = 0.527,
        fromY = 0.2128,
        toPointID = 900089,
        toMap = 1165,
        toX = 0.5166,
        toY = 0.9382,
        type = "portal",
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
                    value = 54042,
                },
            },
        },
    },

    -- Zone: Darkshore (map 62)
    -- Darkshore (map 62 46.24,35.11) -> Dazar'alor (map 1165 51.66,93.82) via portal
    {
        fromPointID = 100084,
        fromMap = 62,
        fromX = 0.4624,
        fromY = 0.3511,
        toPointID = 900089,
        toMap = 1165,
        toX = 0.5166,
        toY = 0.9382,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Darnassus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Warfront Darkshore Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 54416,
                },
            },
        },
    },
    -- Darkshore (map 62 48.02,36.28) -> Boralus (map 1161 66.81,25.06) via portal
    {
        fromPointID = 100087,
        fromMap = 62,
        fromX = 0.4802,
        fromY = 0.3628,
        toPointID = 800074,
        toMap = 1161,
        toX = 0.6681,
        toY = 0.2506,
        type = "portal",
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
                            kind = "phase",
                            value = "Old Darnassus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Warfront Darkshore Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 54871,
                },
            },
        },
    },
    -- Darkshore (map 62 53.70,18.71) -> Amirdrassil (map 2239 54.92,63.88) via portal
    {
        fromPointID = 100089,
        fromMap = 62,
        fromX = 0.537,
        fromY = 0.1871,
        toPointID = 1100226,
        toMap = 2239,
        toX = 0.5492,
        toY = 0.6388,
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
    },

    -- Zone: Darnassus (map 89)
    -- Darnassus (map 89 36.79,50.44) -> Teldrassil (map 57 55.07,88.38) via portal
    {
        fromPointID = 100298,
        fromMap = 89,
        fromX = 0.3679,
        fromY = 0.5044,
        toPointID = 100071,
        toMap = 57,
        toX = 0.5507,
        toY = 0.8838,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },
    -- Darnassus (map 89 43.99,78.18) -> Hellfire Peninsula (map 100 89.17,50.86) via portal
    {
        fromPointID = 100300,
        fromMap = 89,
        fromX = 0.4399,
        fromY = 0.7818,
        toPointID = 300021,
        toMap = 100,
        toX = 0.8917,
        toY = 0.5086,
        type = "portal",
        travelDuration = 999,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "maxLevelExclusive",
                            value = 10,
                        },
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "phase",
                                    value = "Old Darnassus",
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Darnassus (map 89 43.99,78.18) -> Hellfire Peninsula (map 100 89.17,50.86) via portal
    {
        fromPointID = 100300,
        fromMap = 89,
        fromX = 0.4399,
        fromY = 0.7818,
        toPointID = 300021,
        toMap = 100,
        toX = 0.8917,
        toY = 0.5086,
        type = "portal",
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
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },
    -- Darnassus (map 89 44.23,78.70) -> The Exodar (map 103 47.62,59.82) via portal
    {
        fromPointID = 100301,
        fromMap = 89,
        fromX = 0.4423,
        fromY = 0.787,
        toPointID = 100312,
        toMap = 103,
        toX = 0.4762,
        toY = 0.5982,
        type = "portal",
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
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },

    -- Zone: Dazar'alor (map 1163)
    -- Dazar'alor (map 1163 62.95,85.50) -> Nazjatar (map 1355 47.54,62.35) via portal
    {
        fromPointID = 900072,
        fromMap = 1163,
        fromX = 0.6295,
        fromY = 0.855,
        toPointID = 1300030,
        toMap = 1355,
        toX = 0.4754,
        toY = 0.6235,
        type = "portal",
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
                    value = 55053,
                },
            },
        },
    },
    -- Dazar'alor (map 1163 73.60,77.38) -> Thunder Bluff (map 88 22.21,16.87) via portal
    {
        fromPointID = 900076,
        fromMap = 1163,
        fromX = 0.736,
        fromY = 0.7738,
        toPointID = 100295,
        toMap = 88,
        toX = 0.2221,
        toY = 0.1687,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "BFA",
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Dazar'alor (map 1163 73.67,85.43) -> Silithus (map 81 41.41,45.19) via portal
    {
        fromPointID = 900077,
        fromMap = 1163,
        fromX = 0.7367,
        fromY = 0.8543,
        toPointID = 100240,
        toMap = 81,
        toX = 0.4141,
        toY = 0.4519,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
                {
                    operation = "any",
                    children = {
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "phase",
                                    value = "Old Silithus",
                                },
                            },
                        },
                        {
                            operation = "check",
                            kind = "maxLevelExclusive",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Dazar'alor (map 1163 73.99,62.22) -> Silvermoon City (map 110 58.26,19.24) via portal
    {
        fromPointID = 900078,
        fromMap = 1163,
        fromX = 0.7399,
        fromY = 0.6222,
        toPointID = 200341,
        toMap = 110,
        toX = 0.5826,
        toY = 0.1924,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "BFA",
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Dazar'alor (map 1163 74.05,69.75) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 900079,
        fromMap = 1163,
        fromX = 0.7405,
        fromY = 0.6975,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "BFA",
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },

    -- Zone: Dazar'alor (map 1165)
    -- Dazar'alor (map 1165 38.90,2.79) -> Battle of Dazar'alor (map 1352 49.29,91.20) via portal
    {
        fromPointID = 900084,
        fromMap = 1165,
        fromX = 0.389,
        fromY = 0.0279,
        toPointID = 900101,
        toMap = 1352,
        toX = 0.4929,
        toY = 0.912,
        type = "portal",
    },
    -- Dazar'alor (map 1165 44.25,92.62) -> The MOTHERLODE!! (map 1010 0.00,0.00) via portal
    {
        fromPointID = 900087,
        fromMap = 1165,
        fromX = 0.4425,
        fromY = 0.9262,
        toPointID = 1300025,
        toMap = 1010,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Dazar'alor (map 1165 51.92,94.59) -> Arathi Highlands (map 14 27.40,29.95) via portal
    {
        fromPointID = 900090,
        fromMap = 1165,
        fromX = 0.5192,
        fromY = 0.9459,
        toPointID = 200007,
        toMap = 14,
        toX = 0.274,
        toY = 0.2995,
        type = "portal",
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
                    value = "Warfront Arathi Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53208,
                },
            },
        },
    },
    -- Dazar'alor (map 1165 51.99,94.55) -> Darkshore (map 62 46.31,35.00) via portal
    {
        fromPointID = 900091,
        fromMap = 1165,
        fromX = 0.5199,
        fromY = 0.9455,
        toPointID = 100085,
        toMap = 62,
        toX = 0.4631,
        toY = 0.35,
        type = "portal",
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
                    value = "Warfront Darkshore Control",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 53208,
                },
            },
        },
    },
    -- Dazar'alor (map 1165 56.32,30.79) -> Dun Morogh (map 30 31.94,71.70) via portal
    {
        fromPointID = 900095,
        fromMap = 1165,
        fromX = 0.5632,
        fromY = 0.3079,
        toPointID = 200136,
        toMap = 30,
        toX = 0.3194,
        toY = 0.717,
        type = "portal",
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
                    value = 54185,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 46931,
                },
            },
        },
    },
    -- Dazar'alor (map 1165 56.32,30.79) -> Eastern Plaguelands (map 23 43.23,19.96) via portal
    {
        fromPointID = 900095,
        fromMap = 1165,
        fromX = 0.5632,
        fromY = 0.3079,
        toPointID = 200091,
        toMap = 23,
        toX = 0.4323,
        toY = 0.1996,
        type = "portal",
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
                    value = 56491,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 46931,
                },
            },
        },
    },

    -- Zone: De Other Side (map 1680)
    -- De Other Side (map 1680 0.00,0.00) -> Ardenweald (map 1565 68.66,66.71) via portal
    {
        fromPointID = 1000204,
        fromMap = 1680,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000146,
        toMap = 1565,
        toX = 0.6866,
        toY = 0.6671,
        type = "portal",
    },

    -- Zone: Deadwind Pass (map 42)
    -- Deadwind Pass (map 42 46.72,70.20) -> Karazhan L (map 814 63.90,61.30) via portal
    {
        fromPointID = 200192,
        fromMap = 42,
        fromX = 0.4672,
        fromY = 0.702,
        toPointID = 200628,
        toMap = 814,
        toX = 0.639,
        toY = 0.613,
        type = "portal",
    },
    -- Deadwind Pass (map 42 46.81,74.60) -> Karazhan (map 350 58.76,76.11) via portal
    {
        fromPointID = 200193,
        fromMap = 42,
        fromX = 0.4681,
        fromY = 0.746,
        toPointID = 200566,
        toMap = 350,
        toX = 0.5876,
        toY = 0.7611,
        type = "portal",
    },

    -- Zone: Deepholm (map 207)
    -- Deepholm (map 207 47.70,51.98) -> The Stonecore (map 324 54.27,93.90) via portal
    {
        fromPointID = 1300011,
        fromMap = 207,
        fromX = 0.477,
        fromY = 0.5198,
        toPointID = 1300019,
        toMap = 324,
        toX = 0.5427,
        toY = 0.939,
        type = "portal",
    },
    -- Deepholm (map 207 48.53,53.84) -> Stormwind City (map 84 74.46,18.34) via portal
    {
        fromPointID = 1300012,
        fromMap = 207,
        fromX = 0.4853,
        fromY = 0.5384,
        toPointID = 200318,
        toMap = 84,
        toX = 0.7446,
        toY = 0.1834,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 27123,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Deepholm (map 207 50.93,53.10) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 1300016,
        fromMap = 207,
        fromX = 0.5093,
        fromY = 0.531,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 27123,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },

    -- Zone: Deeprun Tram (map 499)
    -- Deeprun Tram (map 499 42.53,11.53) -> Stormwind City (map 84 69.62,31.11) via portal
    {
        fromPointID = 200623,
        fromMap = 499,
        fromX = 0.4253,
        fromY = 0.1153,
        toPointID = 200312,
        toMap = 84,
        toX = 0.6962,
        toY = 0.3111,
        type = "portal",
    },
    -- Deeprun Tram (map 499 45.77,12.47) -> Ironforge (map 87 76.93,51.25) via portal
    {
        fromPointID = 200624,
        fromMap = 499,
        fromX = 0.4577,
        fromY = 0.1247,
        toPointID = 200326,
        toMap = 87,
        toX = 0.7693,
        toY = 0.5125,
        type = "portal",
    },

    -- Zone: Den of Nalorakk (map 2564)
    -- Den of Nalorakk (map 2564 0.00,0.00) -> Zul Aman M (map 2437 29.79,84.51) via portal
    {
        fromPointID = 200833,
        fromMap = 2564,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200722,
        toMap = 2437,
        toX = 0.2979,
        toY = 0.8451,
        type = "portal",
    },

    -- Zone: Dire Maul (map 235)
    -- Dire Maul (map 235 71.13,93.54) -> Feralas (map 69 62.51,24.89) via portal
    {
        fromPointID = 100349,
        fromMap = 235,
        fromX = 0.7113,
        fromY = 0.9354,
        toPointID = 100161,
        toMap = 69,
        toX = 0.6251,
        toY = 0.2489,
        type = "portal",
    },

    -- Zone: Dire Maul (map 236)
    -- Dire Maul (map 236 93.42,75.90) -> Feralas (map 69 60.31,31.30) via portal
    {
        fromPointID = 100354,
        fromMap = 236,
        fromX = 0.9342,
        fromY = 0.759,
        toPointID = 100159,
        toMap = 69,
        toX = 0.6031,
        toY = 0.313,
        type = "portal",
    },
    -- Dire Maul (map 236 93.53,47.68) -> Feralas (map 69 60.32,30.12) via portal
    {
        fromPointID = 100355,
        fromMap = 236,
        fromX = 0.9353,
        fromY = 0.4768,
        toPointID = 100160,
        toMap = 69,
        toX = 0.6032,
        toY = 0.3012,
        type = "portal",
    },

    -- Zone: Dire Maul (map 239)
    -- Dire Maul (map 239 6.71,38.29) -> Feralas (map 69 64.80,30.20) via portal
    {
        fromPointID = 100360,
        fromMap = 239,
        fromX = 0.0671,
        fromY = 0.3829,
        toPointID = 100162,
        toMap = 69,
        toX = 0.648,
        toY = 0.302,
        type = "portal",
    },
    -- Dire Maul (map 239 28.22,84.76) -> Feralas (map 69 66.77,34.84) via portal
    {
        fromPointID = 100361,
        fromMap = 239,
        fromX = 0.2822,
        fromY = 0.8476,
        toPointID = 100164,
        toMap = 69,
        toX = 0.6677,
        toY = 0.3484,
        type = "portal",
    },
    -- Dire Maul (map 239 92.12,45.20) -> Feralas (map 69 76.45,35.90) via portal
    {
        fromPointID = 100363,
        fromMap = 239,
        fromX = 0.9212,
        fromY = 0.452,
        toPointID = 100166,
        toMap = 69,
        toX = 0.7645,
        toY = 0.359,
        type = "portal",
    },

    -- Zone: Dire Maul (map 240)
    -- Dire Maul (map 240 36.74,38.45) -> Feralas (map 69 66.11,26.31) via portal
    {
        fromPointID = 100364,
        fromMap = 240,
        fromX = 0.3674,
        fromY = 0.3845,
        toPointID = 100163,
        toMap = 69,
        toX = 0.6611,
        toY = 0.2631,
        type = "portal",
    },

    -- Zone: Dornogal (map 2339)
    -- Dornogal (map 2339 29.77,59.67) -> Vault of Memory (map 2367 49.94,35.95) via portal
    {
        fromPointID = 1200117,
        fromMap = 2339,
        fromX = 0.2977,
        fromY = 0.5967,
        toPointID = 1200155,
        toMap = 2367,
        toX = 0.4994,
        toY = 0.3595,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83271,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83271,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 79573,
                        },
                    },
                },
            },
        },
    },
    -- Dornogal (map 2339 31.47,35.64) -> The Rookery (map 2315 88.76,46.52) via portal
    {
        fromPointID = 1200118,
        fromMap = 2339,
        fromX = 0.3147,
        fromY = 0.3564,
        toPointID = 1200103,
        toMap = 2315,
        toX = 0.8876,
        toY = 0.4652,
        type = "portal",
    },
    -- Dornogal (map 2339 34.67,68.29) -> Orgrimmar Vision (map 1469 51.89,82.74) via portal
    {
        fromPointID = 1200120,
        fromMap = 2339,
        fromX = 0.3467,
        fromY = 0.6829,
        toPointID = 100462,
        toMap = 1469,
        toX = 0.5189,
        toY = 0.8274,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 87328,
                },
            },
        },
    },
    -- Dornogal (map 2339 34.67,68.29) -> Vision of Stormwind (map 2404 53.27,53.16) via portal
    {
        fromPointID = 1200120,
        fromMap = 2339,
        fromX = 0.3467,
        fromY = 0.6829,
        toPointID = 200679,
        toMap = 2404,
        toX = 0.5327,
        toY = 0.5316,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 87328,
                },
            },
        },
    },
    -- Dornogal (map 2339 38.15,27.23) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 1200121,
        fromMap = 2339,
        fromX = 0.3815,
        fromY = 0.2723,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 80321,
                                },
                            },
                        },
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 79573,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Dornogal (map 2339 40.31,22.70) -> Tazavesh (map 2472 62.58,94.40) via portal
    {
        fromPointID = 1200123,
        fromMap = 2339,
        fromX = 0.4031,
        fromY = 0.227,
        toPointID = 1200236,
        toMap = 2472,
        toX = 0.6258,
        toY = 0.944,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84957,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84957,
                        },
                    },
                },
            },
        },
    },
    -- Dornogal (map 2339 41.18,22.68) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 1200124,
        fromMap = 2339,
        fromX = 0.4118,
        fromY = 0.2268,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 80321,
                                },
                            },
                        },
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 79573,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Dornogal (map 2339 45.97,49.21) -> Red Dawn Arathi (map 2372 21.97,38.88) via portal
    {
        fromPointID = 1200128,
        fromMap = 2339,
        fromX = 0.4597,
        fromY = 0.4921,
        toPointID = 200653,
        toMap = 2372,
        toX = 0.2197,
        toY = 0.3888,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84638,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84638,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 85529,
                        },
                    },
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Dornogal (map 2339 48.61,48.62) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 1200129,
        fromMap = 2339,
        fromX = 0.4861,
        fromY = 0.4862,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Dornogal (map 2339 52.47,50.47) -> Undermine (map 2346 27.83,54.02) via portal
    {
        fromPointID = 1200130,
        fromMap = 2339,
        fromX = 0.5247,
        fromY = 0.5047,
        toPointID = 1200142,
        toMap = 2346,
        toX = 0.2783,
        toY = 0.5402,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83137,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83137,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Dornogal (map 2339 53.98,38.72) -> Millenia's Threshold (map 2266 43.55,49.90) via portal
    {
        fromPointID = 1200131,
        fromMap = 2339,
        fromX = 0.5398,
        fromY = 0.3872,
        toPointID = 1100237,
        toMap = 2266,
        toX = 0.4355,
        toY = 0.499,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Dornogal (map 2339 63.61,52.59) -> Azj-Kahet (map 2255 57.48,41.61) via portal
    {
        fromPointID = 1200132,
        fromMap = 2339,
        fromX = 0.6361,
        fromY = 0.5259,
        toPointID = 1200065,
        toMap = 2255,
        toX = 0.5748,
        toY = 0.4161,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 78248,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 79573,
                        },
                    },
                },
            },
        },
    },
    -- Dornogal (map 2339 73.55,5.29) -> Siren Isle (map 2369 70.69,53.49) via portal
    {
        fromPointID = 1200134,
        fromMap = 2339,
        fromX = 0.7355,
        fromY = 0.0529,
        toPointID = 1200158,
        toMap = 2369,
        toX = 0.7069,
        toY = 0.5349,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84720,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84720,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Dragon Soul (map 409)
    -- Dragon Soul (map 409 49.16,59.04) -> Dragon Soul (map 410 32.66,45.49) via portal
    {
        fromPointID = 100425,
        fromMap = 409,
        fromX = 0.4916,
        fromY = 0.5904,
        toPointID = 100431,
        toMap = 410,
        toX = 0.3266,
        toY = 0.4549,
        type = "portal",
    },
    -- Dragon Soul (map 409 50.00,84.00) -> Tanaris (map 75 61.97,26.97) via portal
    {
        fromPointID = 100426,
        fromMap = 409,
        fromX = 0.5,
        fromY = 0.84,
        toPointID = 100212,
        toMap = 75,
        toX = 0.6197,
        toY = 0.2697,
        type = "portal",
    },
    -- Dragon Soul (map 409 50.70,60.63) -> Dragon Soul (map 412 52.42,14.22) via portal
    {
        fromPointID = 100428,
        fromMap = 409,
        fromX = 0.507,
        fromY = 0.6063,
        toPointID = 100434,
        toMap = 412,
        toX = 0.5242,
        toY = 0.1422,
        type = "portal",
    },
    -- Dragon Soul (map 409 51.29,59.31) -> Dragon Soul (map 411 55.38,79.72) via portal
    {
        fromPointID = 100429,
        fromMap = 409,
        fromX = 0.5129,
        fromY = 0.5931,
        toPointID = 100432,
        toMap = 411,
        toX = 0.5538,
        toY = 0.7972,
        type = "portal",
    },

    -- Zone: Dragon Soul (map 410)
    -- Dragon Soul (map 410 22.98,40.36) -> Dragon Soul (map 409 50.25,59.76) via portal
    {
        fromPointID = 100430,
        fromMap = 410,
        fromX = 0.2298,
        fromY = 0.4036,
        toPointID = 100427,
        toMap = 409,
        toX = 0.5025,
        toY = 0.5976,
        type = "portal",
    },

    -- Zone: Dragon Soul (map 411)
    -- Dragon Soul (map 411 57.76,88.77) -> Dragon Soul (map 409 50.25,59.76) via portal
    {
        fromPointID = 100433,
        fromMap = 411,
        fromX = 0.5776,
        fromY = 0.8877,
        toPointID = 100427,
        toMap = 409,
        toX = 0.5025,
        toY = 0.5976,
        type = "portal",
    },

    -- Zone: Dragon Soul (map 412)
    -- Dragon Soul (map 412 52.42,14.22) -> Dragon Soul (map 409 50.70,60.63) via portal
    {
        fromPointID = 100434,
        fromMap = 412,
        fromX = 0.5242,
        fromY = 0.1422,
        toPointID = 100428,
        toMap = 409,
        toX = 0.507,
        toY = 0.6063,
        type = "portal",
    },

    -- Zone: Dragon Soul (map 415)
    -- Dragon Soul (map 415 31.93,82.91) -> Dragon Soul (map 409 50.25,59.76) via portal
    {
        fromPointID = 100435,
        fromMap = 415,
        fromX = 0.3193,
        fromY = 0.8291,
        toPointID = 100427,
        toMap = 409,
        toX = 0.5025,
        toY = 0.5976,
        type = "portal",
    },

    -- Zone: Dragonblight (map 115)
    -- Dragonblight (map 115 25.96,50.90) -> Azjol-Nerub (map 159 9.44,93.32) via portal
    {
        fromPointID = 400017,
        fromMap = 115,
        fromX = 0.2596,
        fromY = 0.509,
        toPointID = 400186,
        toMap = 159,
        toX = 0.0944,
        toY = 0.9332,
        type = "portal",
    },
    -- Dragonblight (map 115 28.47,51.72) -> Ahn'kahet: The Old Kingdom (map 132 88.99,79.12) via portal
    {
        fromPointID = 400019,
        fromMap = 115,
        fromX = 0.2847,
        fromY = 0.5172,
        toPointID = 400144,
        toMap = 132,
        toX = 0.8899,
        toY = 0.7912,
        type = "portal",
    },
    -- Dragonblight (map 115 60.00,56.85) -> The Obsidian Sanctum (map 155 64.00,50.00) via portal
    {
        fromPointID = 400026,
        fromMap = 115,
        fromX = 0.6,
        fromY = 0.5685,
        toPointID = 400181,
        toMap = 155,
        toX = 0.64,
        toY = 0.5,
        type = "portal",
    },
    -- Dragonblight (map 115 61.20,52.76) -> The Ruby Sanctum (map 200 49.01,31.40) via portal
    {
        fromPointID = 400028,
        fromMap = 115,
        fromX = 0.612,
        fromY = 0.5276,
        toPointID = 400241,
        toMap = 200,
        toX = 0.4901,
        toY = 0.314,
        type = "portal",
    },
    -- Dragonblight (map 115 61.27,52.68) -> The Ruby Sanctum (map 200 49.00,30.40) via portal
    {
        fromPointID = 400029,
        fromMap = 115,
        fromX = 0.6127,
        fromY = 0.5268,
        toPointID = 400240,
        toMap = 200,
        toX = 0.49,
        toY = 0.304,
        type = "portal",
    },
    -- Dragonblight (map 115 87.44,51.11) -> Naxxramas (map 166 54.10,49.80) via portal
    {
        fromPointID = 400033,
        fromMap = 115,
        fromX = 0.8744,
        fromY = 0.5111,
        toPointID = 400199,
        toMap = 166,
        toX = 0.541,
        toY = 0.498,
        type = "portal",
    },

    -- Zone: Drak'Tharon Keep (map 160)
    -- Drak'Tharon Keep (map 160 29.38,80.96) -> Zul'Drak (map 121 28.52,86.93) via portal
    {
        fromPointID = 400188,
        fromMap = 160,
        fromX = 0.2938,
        fromY = 0.8096,
        toPointID = 400096,
        toMap = 121,
        toX = 0.2852,
        toY = 0.8693,
        type = "portal",
    },

    -- Zone: Dread Wastes (map 422)
    -- Dread Wastes (map 422 38.86,35.02) -> Heart of Fear (map 474 34.00,87.40) via portal
    {
        fromPointID = 500134,
        fromMap = 422,
        fromX = 0.3886,
        fromY = 0.3502,
        toPointID = 500197,
        toMap = 474,
        toX = 0.34,
        toY = 0.874,
        type = "portal",
    },
    -- Dread Wastes (map 422 75.09,21.29) -> Vale of Eternal Blossoms (map 390 14.20,76.72) via portal
    {
        fromPointID = 500141,
        fromMap = 422,
        fromX = 0.7509,
        fromY = 0.2129,
        toPointID = 500107,
        toMap = 390,
        toX = 0.142,
        toY = 0.7672,
        type = "portal",
    },

    -- Zone: Dreadscar Rift (map 717)
    -- Dreadscar Rift (map 717 74.16,38.35) -> Dalaran L (map 628 29.20,43.97) via portal
    {
        fromPointID = 700240,
        fromMap = 717,
        fromX = 0.7416,
        fromY = 0.3835,
        toPointID = 700037,
        toMap = 628,
        toX = 0.292,
        toY = 0.4397,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40729,
                },
            },
        },
    },

    -- Zone: Drustvar (map 896)
    -- Drustvar (map 896 33.68,12.33) -> Waycrest Manor (map 1015 0.00,0.00) via portal
    {
        fromPointID = 800027,
        fromMap = 896,
        fromX = 0.3368,
        fromY = 0.1233,
        toPointID = 800061,
        toMap = 1015,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Durotar (map 1)
    -- Durotar (map 1 41.53,16.01) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 100007,
        fromMap = 1,
        fromX = 0.4153,
        fromY = 0.1601,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.53,16.01) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 100007,
        fromMap = 1,
        fromX = 0.4153,
        fromY = 0.1601,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.53,16.01) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 100007,
        fromMap = 1,
        fromX = 0.4153,
        fromY = 0.1601,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.53,16.01) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 100007,
        fromMap = 1,
        fromX = 0.4153,
        fromY = 0.1601,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.54,16.00) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 100008,
        fromMap = 1,
        fromX = 0.4154,
        fromY = 0.16,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.54,16.00) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 100008,
        fromMap = 1,
        fromX = 0.4154,
        fromY = 0.16,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.54,16.00) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 100008,
        fromMap = 1,
        fromX = 0.4154,
        fromY = 0.16,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 41.54,16.00) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 100008,
        fromMap = 1,
        fromX = 0.4154,
        fromY = 0.16,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Durotar (map 1 66.00,1.00) -> The Jade Forest (map 371 28.50,14.00) via portal
    {
        fromPointID = 100020,
        fromMap = 1,
        fromX = 0.66,
        fromY = 0.01,
        toPointID = 500001,
        toMap = 371,
        toX = 0.285,
        toY = 0.14,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 31769,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "flag",
                            value = "legionOn",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "check",
                    kind = "maxLevelExclusive",
                    value = 50,
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },
    -- Durotar (map 1 66.00,1.00) -> The Jade Forest (map 371 28.50,14.00) via portal
    {
        fromPointID = 100020,
        fromMap = 1,
        fromX = 0.66,
        fromY = 0.01,
        toPointID = 500001,
        toMap = 371,
        toX = 0.285,
        toY = 0.14,
        type = "portal",
        travelDuration = 999,
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
                    kind = "maxLevelExclusive",
                    value = 10,
                },
            },
        },
    },

    -- Zone: Duskwood (map 47)
    -- Duskwood (map 47 46.57,35.64) -> Emerald Dreamway (map 715 38.85,65.99) via portal
    {
        fromPointID = 200203,
        fromMap = 47,
        fromX = 0.4657,
        fromY = 0.3564,
        toPointID = 700231,
        toMap = 715,
        toX = 0.3885,
        toY = 0.6599,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: Dustwallow Marsh (map 70)
    -- Dustwallow Marsh (map 70 52.89,77.46) -> Onyxia's Lair (map 248 34.00,21.00) via portal
    {
        fromPointID = 100176,
        fromMap = 70,
        fromX = 0.5289,
        fromY = 0.7746,
        toPointID = 100367,
        toMap = 248,
        toX = 0.34,
        toY = 0.21,
        type = "portal",
    },

    -- Zone: Earthcrawl Mines (map 2269)
    -- Earthcrawl Mines (map 2269 46.20,9.54) -> Isle of Dorn (map 2248 38.55,73.93) via portal
    {
        fromPointID = 1200078,
        fromMap = 2269,
        fromX = 0.462,
        fromY = 0.0954,
        toPointID = 1200044,
        toMap = 2248,
        toX = 0.3855,
        toY = 0.7393,
        type = "portal",
    },

    -- Zone: Eastern Kingdoms (map 13)
    -- Eastern Kingdoms (map 13 41.47,70.19) -> The Jade Forest (map 371 46.23,85.17) via portal
    {
        fromPointID = 200002,
        fromMap = 13,
        fromX = 0.4147,
        fromY = 0.7019,
        toPointID = 500015,
        toMap = 371,
        toX = 0.4623,
        toY = 0.8517,
        type = "portal",
        travelDuration = 999,
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
                    kind = "maxLevelExclusive",
                    value = 10,
                },
            },
        },
    },
    -- Eastern Kingdoms (map 13 41.47,70.19) -> The Jade Forest (map 371 46.23,85.17) via portal
    {
        fromPointID = 200002,
        fromMap = 13,
        fromX = 0.4147,
        fromY = 0.7019,
        toPointID = 500015,
        toMap = 371,
        toX = 0.4623,
        toY = 0.8517,
        type = "portal",
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
                    kind = "maxLevelExclusive",
                    value = 50,
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 10,
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 29548,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Eastern Plaguelands (map 23)
    -- Eastern Plaguelands (map 23 26.51,11.67) -> Stratholme (map 317 64.46,88.52) via portal
    {
        fromPointID = 200088,
        fromMap = 23,
        fromX = 0.2651,
        fromY = 0.1167,
        toPointID = 200546,
        toMap = 317,
        toX = 0.6446,
        toY = 0.8852,
        type = "portal",
    },
    -- Eastern Plaguelands (map 23 27.61,11.63) -> Stratholme (map 317 68.02,88.46) via portal
    {
        fromPointID = 200089,
        fromMap = 23,
        fromX = 0.2761,
        fromY = 0.1163,
        toPointID = 200547,
        toMap = 317,
        toX = 0.6802,
        toY = 0.8846,
        type = "portal",
    },
    -- Eastern Plaguelands (map 23 43.82,17.42) -> Stratholme (map 318 67.74,86.29) via portal
    {
        fromPointID = 200092,
        fromMap = 23,
        fromX = 0.4382,
        fromY = 0.1742,
        toPointID = 200548,
        toMap = 318,
        toX = 0.6774,
        toY = 0.8629,
        type = "portal",
    },
    -- Eastern Plaguelands (map 23 54.38,8.77) -> Ghostlands (map 95 52.22,97.43) via portal
    {
        fromPointID = 200095,
        fromMap = 23,
        fromX = 0.5438,
        fromY = 0.0877,
        toPointID = 200338,
        toMap = 95,
        toX = 0.5222,
        toY = 0.9743,
        type = "portal",
    },

    -- Zone: Eco-Dome Al'dani (map 2449)
    -- Eco-Dome Al'dani (map 2449 0.00,0.00) -> Tazavesh (map 2472 43.88,3.76) via portal
    {
        fromPointID = 1200196,
        fromMap = 2449,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1200234,
        toMap = 2472,
        toX = 0.4388,
        toY = 0.0376,
        type = "portal",
    },

    -- Zone: Elwynn Forest (map 37)
    -- Elwynn Forest (map 37 34.53,51.43) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 200174,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5143,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.43) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 200174,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5143,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.43) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 200174,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5143,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.43) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 200174,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5143,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.44) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 200175,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5144,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.44) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 200175,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5144,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.44) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 200175,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5144,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 34.53,51.44) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 200175,
        fromMap = 37,
        fromX = 0.3453,
        fromY = 0.5144,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Elwynn Forest (map 37 41.79,69.48) -> Darkmoon Island (map 407 51.29,23.86) via portal
    {
        fromPointID = 200179,
        fromMap = 37,
        fromX = 0.4179,
        fromY = 0.6948,
        toPointID = 1300022,
        toMap = 407,
        toX = 0.5129,
        toY = 0.2386,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "DARKMOON FAIRE",
                },
            },
        },
    },

    -- Zone: Elysian Hold (map 1707)
    -- Elysian Hold (map 1707 22.38,29.10) -> Bastion (map 1533 59.00,11.63) via portal
    {
        fromPointID = 1000261,
        fromMap = 1707,
        fromX = 0.2238,
        fromY = 0.291,
        toPointID = 1000060,
        toMap = 1533,
        toX = 0.59,
        toY = 0.1163,
        type = "portal",
        travelDuration = 12,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },
    -- Elysian Hold (map 1707 28.18,42.34) -> Ascension Coliseum (map 1711 70.08,23.15) via portal
    {
        fromPointID = 1000262,
        fromMap = 1707,
        fromX = 0.2818,
        fromY = 0.4234,
        toPointID = 1000273,
        toMap = 1711,
        toX = 0.7008,
        toY = 0.2315,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "covenant",
                                    value = "Kyrian",
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 60496,
                                },
                            },
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 60496,
                        },
                    },
                },
            },
        },
    },
    -- Elysian Hold (map 1707 41.17,71.10) -> Bastion (map 1533 58.73,28.96) via portal
    {
        fromPointID = 1000264,
        fromMap = 1707,
        fromX = 0.4117,
        fromY = 0.711,
        toPointID = 1000059,
        toMap = 1533,
        toX = 0.5873,
        toY = 0.2896,
        type = "portal",
        travelDuration = 18,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },
    -- Elysian Hold (map 1707 46.54,66.79) -> The Maw (map 1543 42.55,43.77) via portal
    {
        fromPointID = 1000266,
        fromMap = 1707,
        fromX = 0.4654,
        fromY = 0.6679,
        toPointID = 1000109,
        toMap = 1543,
        toX = 0.4255,
        toY = 0.4377,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63824,
                },
            },
        },
    },
    -- Elysian Hold (map 1707 48.82,64.79) -> Oribos (map 1671 44.68,58.91) via portal
    {
        fromPointID = 1000267,
        fromMap = 1707,
        fromX = 0.4882,
        fromY = 0.6479,
        toPointID = 1000183,
        toMap = 1671,
        toX = 0.4468,
        toY = 0.5891,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
            },
        },
    },
    -- Elysian Hold (map 1707 63.00,93.81) -> Bastion (map 1533 67.90,27.34) via portal
    {
        fromPointID = 1000270,
        fromMap = 1707,
        fromX = 0.63,
        fromY = 0.9381,
        toPointID = 1000061,
        toMap = 1533,
        toX = 0.679,
        toY = 0.2734,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 60,
                },
            },
        },
    },

    -- Zone: Emerald Dream (map 2200)
    -- The Emerald Dream (map 2200 27.29,31.04) -> Amirdrassil, The Dream's Hope (map 2232 27.29,31.04) via portal
    {
        fromPointID = 1100195,
        fromMap = 2200,
        fromX = 0.2729,
        fromY = 0.3104,
        toPointID = 1100205,
        toMap = 2232,
        toX = 0.2729,
        toY = 0.3104,
        type = "portal",
    },
    -- The Emerald Dream (map 2200 73.05,52.52) -> Ohn'ahran Plains (map 2023 18.37,52.37) via portal
    {
        fromPointID = 1100204,
        fromMap = 2200,
        fromX = 0.7305,
        fromY = 0.5252,
        toPointID = 1100015,
        toMap = 2023,
        toX = 0.1837,
        toY = 0.5237,
        type = "portal",
    },

    -- Zone: Emerald Dreamway (map 715)
    -- Emerald Dreamway (map 715 22.73,38.50) -> Feralas (map 69 51.20,11.03) via portal
    {
        fromPointID = 700224,
        fromMap = 715,
        fromX = 0.2273,
        fromY = 0.385,
        toPointID = 100156,
        toMap = 69,
        toX = 0.512,
        toY = 0.1103,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 25.71,80.55) -> Moonglade (map 80 67.59,60.19) via portal
    {
        fromPointID = 700225,
        fromMap = 715,
        fromX = 0.2571,
        fromY = 0.8055,
        toPointID = 100237,
        toMap = 80,
        toX = 0.6759,
        toY = 0.6019,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 31.60,25.91) -> Grizzly Hills (map 116 50.43,29.75) via portal
    {
        fromPointID = 700228,
        fromMap = 715,
        fromX = 0.316,
        fromY = 0.2591,
        toPointID = 400045,
        toMap = 116,
        toX = 0.5043,
        toY = 0.2975,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 40.02,70.02) -> Duskwood (map 47 46.59,37.06) via portal
    {
        fromPointID = 700232,
        fromMap = 715,
        fromX = 0.4002,
        fromY = 0.7002,
        toPointID = 200204,
        toMap = 47,
        toX = 0.4659,
        toY = 0.3706,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 45.68,23.52) -> The Dreamgrove (map 747 54.30,24.97) via portal
    {
        fromPointID = 700234,
        fromMap = 715,
        fromX = 0.4568,
        fromY = 0.2352,
        toPointID = 700267,
        toMap = 747,
        toX = 0.543,
        toY = 0.2497,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 50.91,66.51) -> The Hinterlands (map 26 62.49,23.50) via portal
    {
        fromPointID = 700236,
        fromMap = 715,
        fromX = 0.5091,
        fromY = 0.6651,
        toPointID = 200116,
        toMap = 26,
        toX = 0.6249,
        toY = 0.235,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Emerald Dreamway (map 715 53.87,53.17) -> Mount Hyjal (map 198 59.29,25.83) via portal
    {
        fromPointID = 700238,
        fromMap = 715,
        fromX = 0.5387,
        fromY = 0.5317,
        toPointID = 100329,
        toMap = 198,
        toX = 0.5929,
        toY = 0.2583,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: End Time (map 401)
    -- End Time (map 401 79.76,45.52) -> End Time (map 402 41.88,80.19) via portal
    {
        fromPointID = 100418,
        fromMap = 401,
        fromX = 0.7976,
        fromY = 0.4552,
        toPointID = 100420,
        toMap = 402,
        toX = 0.4188,
        toY = 0.8019,
        type = "portal",
    },
    -- End Time (map 401 79.76,45.52) -> End Time (map 403 34.34,43.19) via portal
    {
        fromPointID = 100418,
        fromMap = 401,
        fromX = 0.7976,
        fromY = 0.4552,
        toPointID = 100421,
        toMap = 403,
        toX = 0.3434,
        toY = 0.4319,
        type = "portal",
    },
    -- End Time (map 401 79.76,45.52) -> End Time (map 404 75.23,62.82) via portal
    {
        fromPointID = 100418,
        fromMap = 401,
        fromX = 0.7976,
        fromY = 0.4552,
        toPointID = 100422,
        toMap = 404,
        toX = 0.7523,
        toY = 0.6282,
        type = "portal",
    },
    -- End Time (map 401 79.76,45.52) -> End Time (map 405 46.10,21.40) via portal
    {
        fromPointID = 100418,
        fromMap = 401,
        fromX = 0.7976,
        fromY = 0.4552,
        toPointID = 100423,
        toMap = 405,
        toX = 0.461,
        toY = 0.214,
        type = "portal",
    },
    -- End Time (map 401 79.76,45.52) -> End Time (map 406 35.40,79.14) via portal
    {
        fromPointID = 100418,
        fromMap = 401,
        fromX = 0.7976,
        fromY = 0.4552,
        toPointID = 100424,
        toMap = 406,
        toX = 0.354,
        toY = 0.7914,
        type = "portal",
    },
    -- End Time (map 401 80.73,44.20) -> Tanaris (map 75 57.60,29.60) via portal
    {
        fromPointID = 100419,
        fromMap = 401,
        fromX = 0.8073,
        fromY = 0.442,
        toPointID = 100210,
        toMap = 75,
        toX = 0.576,
        toY = 0.296,
        type = "portal",
    },

    -- Zone: End Time (map 402)
    -- End Time (map 402 41.88,80.19) -> End Time (map 401 79.76,45.52) via portal
    {
        fromPointID = 100420,
        fromMap = 402,
        fromX = 0.4188,
        fromY = 0.8019,
        toPointID = 100418,
        toMap = 401,
        toX = 0.7976,
        toY = 0.4552,
        type = "portal",
    },
    -- End Time (map 402 41.88,80.19) -> End Time (map 403 34.34,43.19) via portal
    {
        fromPointID = 100420,
        fromMap = 402,
        fromX = 0.4188,
        fromY = 0.8019,
        toPointID = 100421,
        toMap = 403,
        toX = 0.3434,
        toY = 0.4319,
        type = "portal",
    },
    -- End Time (map 402 41.88,80.19) -> End Time (map 404 75.23,62.82) via portal
    {
        fromPointID = 100420,
        fromMap = 402,
        fromX = 0.4188,
        fromY = 0.8019,
        toPointID = 100422,
        toMap = 404,
        toX = 0.7523,
        toY = 0.6282,
        type = "portal",
    },
    -- End Time (map 402 41.88,80.19) -> End Time (map 405 46.10,21.40) via portal
    {
        fromPointID = 100420,
        fromMap = 402,
        fromX = 0.4188,
        fromY = 0.8019,
        toPointID = 100423,
        toMap = 405,
        toX = 0.461,
        toY = 0.214,
        type = "portal",
    },
    -- End Time (map 402 41.88,80.19) -> End Time (map 406 35.40,79.14) via portal
    {
        fromPointID = 100420,
        fromMap = 402,
        fromX = 0.4188,
        fromY = 0.8019,
        toPointID = 100424,
        toMap = 406,
        toX = 0.354,
        toY = 0.7914,
        type = "portal",
    },

    -- Zone: End Time (map 403)
    -- End Time (map 403 34.34,43.19) -> End Time (map 401 79.76,45.52) via portal
    {
        fromPointID = 100421,
        fromMap = 403,
        fromX = 0.3434,
        fromY = 0.4319,
        toPointID = 100418,
        toMap = 401,
        toX = 0.7976,
        toY = 0.4552,
        type = "portal",
    },
    -- End Time (map 403 34.34,43.19) -> End Time (map 402 41.88,80.19) via portal
    {
        fromPointID = 100421,
        fromMap = 403,
        fromX = 0.3434,
        fromY = 0.4319,
        toPointID = 100420,
        toMap = 402,
        toX = 0.4188,
        toY = 0.8019,
        type = "portal",
    },
    -- End Time (map 403 34.34,43.19) -> End Time (map 404 75.23,62.82) via portal
    {
        fromPointID = 100421,
        fromMap = 403,
        fromX = 0.3434,
        fromY = 0.4319,
        toPointID = 100422,
        toMap = 404,
        toX = 0.7523,
        toY = 0.6282,
        type = "portal",
    },
    -- End Time (map 403 34.34,43.19) -> End Time (map 405 46.10,21.40) via portal
    {
        fromPointID = 100421,
        fromMap = 403,
        fromX = 0.3434,
        fromY = 0.4319,
        toPointID = 100423,
        toMap = 405,
        toX = 0.461,
        toY = 0.214,
        type = "portal",
    },
    -- End Time (map 403 34.34,43.19) -> End Time (map 406 35.40,79.14) via portal
    {
        fromPointID = 100421,
        fromMap = 403,
        fromX = 0.3434,
        fromY = 0.4319,
        toPointID = 100424,
        toMap = 406,
        toX = 0.354,
        toY = 0.7914,
        type = "portal",
    },

    -- Zone: End Time (map 404)
    -- End Time (map 404 75.23,62.82) -> End Time (map 401 79.76,45.52) via portal
    {
        fromPointID = 100422,
        fromMap = 404,
        fromX = 0.7523,
        fromY = 0.6282,
        toPointID = 100418,
        toMap = 401,
        toX = 0.7976,
        toY = 0.4552,
        type = "portal",
    },
    -- End Time (map 404 75.23,62.82) -> End Time (map 402 41.88,80.19) via portal
    {
        fromPointID = 100422,
        fromMap = 404,
        fromX = 0.7523,
        fromY = 0.6282,
        toPointID = 100420,
        toMap = 402,
        toX = 0.4188,
        toY = 0.8019,
        type = "portal",
    },
    -- End Time (map 404 75.23,62.82) -> End Time (map 403 34.34,43.19) via portal
    {
        fromPointID = 100422,
        fromMap = 404,
        fromX = 0.7523,
        fromY = 0.6282,
        toPointID = 100421,
        toMap = 403,
        toX = 0.3434,
        toY = 0.4319,
        type = "portal",
    },
    -- End Time (map 404 75.23,62.82) -> End Time (map 405 46.10,21.40) via portal
    {
        fromPointID = 100422,
        fromMap = 404,
        fromX = 0.7523,
        fromY = 0.6282,
        toPointID = 100423,
        toMap = 405,
        toX = 0.461,
        toY = 0.214,
        type = "portal",
    },
    -- End Time (map 404 75.23,62.82) -> End Time (map 406 35.40,79.14) via portal
    {
        fromPointID = 100422,
        fromMap = 404,
        fromX = 0.7523,
        fromY = 0.6282,
        toPointID = 100424,
        toMap = 406,
        toX = 0.354,
        toY = 0.7914,
        type = "portal",
    },

    -- Zone: End Time (map 405)
    -- End Time (map 405 46.10,21.40) -> End Time (map 401 79.76,45.52) via portal
    {
        fromPointID = 100423,
        fromMap = 405,
        fromX = 0.461,
        fromY = 0.214,
        toPointID = 100418,
        toMap = 401,
        toX = 0.7976,
        toY = 0.4552,
        type = "portal",
    },
    -- End Time (map 405 46.10,21.40) -> End Time (map 402 41.88,80.19) via portal
    {
        fromPointID = 100423,
        fromMap = 405,
        fromX = 0.461,
        fromY = 0.214,
        toPointID = 100420,
        toMap = 402,
        toX = 0.4188,
        toY = 0.8019,
        type = "portal",
    },
    -- End Time (map 405 46.10,21.40) -> End Time (map 403 34.34,43.19) via portal
    {
        fromPointID = 100423,
        fromMap = 405,
        fromX = 0.461,
        fromY = 0.214,
        toPointID = 100421,
        toMap = 403,
        toX = 0.3434,
        toY = 0.4319,
        type = "portal",
    },
    -- End Time (map 405 46.10,21.40) -> End Time (map 404 75.23,62.82) via portal
    {
        fromPointID = 100423,
        fromMap = 405,
        fromX = 0.461,
        fromY = 0.214,
        toPointID = 100422,
        toMap = 404,
        toX = 0.7523,
        toY = 0.6282,
        type = "portal",
    },
    -- End Time (map 405 46.10,21.40) -> End Time (map 406 35.40,79.14) via portal
    {
        fromPointID = 100423,
        fromMap = 405,
        fromX = 0.461,
        fromY = 0.214,
        toPointID = 100424,
        toMap = 406,
        toX = 0.354,
        toY = 0.7914,
        type = "portal",
    },

    -- Zone: End Time (map 406)
    -- End Time (map 406 35.40,79.14) -> End Time (map 401 79.76,45.52) via portal
    {
        fromPointID = 100424,
        fromMap = 406,
        fromX = 0.354,
        fromY = 0.7914,
        toPointID = 100418,
        toMap = 401,
        toX = 0.7976,
        toY = 0.4552,
        type = "portal",
    },
    -- End Time (map 406 35.40,79.14) -> End Time (map 402 41.88,80.19) via portal
    {
        fromPointID = 100424,
        fromMap = 406,
        fromX = 0.354,
        fromY = 0.7914,
        toPointID = 100420,
        toMap = 402,
        toX = 0.4188,
        toY = 0.8019,
        type = "portal",
    },
    -- End Time (map 406 35.40,79.14) -> End Time (map 403 34.34,43.19) via portal
    {
        fromPointID = 100424,
        fromMap = 406,
        fromX = 0.354,
        fromY = 0.7914,
        toPointID = 100421,
        toMap = 403,
        toX = 0.3434,
        toY = 0.4319,
        type = "portal",
    },
    -- End Time (map 406 35.40,79.14) -> End Time (map 404 75.23,62.82) via portal
    {
        fromPointID = 100424,
        fromMap = 406,
        fromX = 0.354,
        fromY = 0.7914,
        toPointID = 100422,
        toMap = 404,
        toX = 0.7523,
        toY = 0.6282,
        type = "portal",
    },
    -- End Time (map 406 35.40,79.14) -> End Time (map 405 46.10,21.40) via portal
    {
        fromPointID = 100424,
        fromMap = 406,
        fromX = 0.354,
        fromY = 0.7914,
        toPointID = 100423,
        toMap = 405,
        toX = 0.461,
        toY = 0.214,
        type = "portal",
    },

    -- Zone: Eredath (map 882)
    -- Eredath (map 882 22.30,55.89) -> The Seat of the Triumvirate (map 903 21.90,86.20) via portal
    {
        fromPointID = 700301,
        fromMap = 882,
        fromX = 0.223,
        fromY = 0.5589,
        toPointID = 700319,
        toMap = 903,
        toX = 0.219,
        toY = 0.862,
        type = "portal",
    },
    -- Eredath (map 882 38.82,12.52) -> Invasion Point Aurinor (map 921 20.45,52.72) via portal
    {
        fromPointID = 700302,
        fromMap = 882,
        fromX = 0.3882,
        fromY = 0.1252,
        toPointID = 700321,
        toMap = 921,
        toX = 0.2045,
        toY = 0.5272,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5367,
                },
            },
        },
    },
    -- Eredath (map 882 38.82,12.52) -> Invasion Point Aurinor (map 921 81.75,39.02) via portal
    {
        fromPointID = 700302,
        fromMap = 882,
        fromX = 0.3882,
        fromY = 0.1252,
        toPointID = 700322,
        toMap = 921,
        toX = 0.8175,
        toY = 0.3902,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5367,
                },
            },
        },
    },
    -- Eredath (map 882 45.24,50.79) -> Invasion Point Sotanathor (map 931 24.14,50.49) via portal
    {
        fromPointID = 700303,
        fromMap = 882,
        fromX = 0.4524,
        fromY = 0.5079,
        toPointID = 700340,
        toMap = 931,
        toX = 0.2414,
        toY = 0.5049,
        type = "portal",
    },
    -- Eredath (map 882 45.24,50.79) -> Invasion Point Sotanathor (map 931 26.29,46.22) via portal
    {
        fromPointID = 700303,
        fromMap = 882,
        fromX = 0.4524,
        fromY = 0.5079,
        toPointID = 700341,
        toMap = 931,
        toX = 0.2629,
        toY = 0.4622,
        type = "portal",
    },
    -- Eredath (map 882 61.01,18.74) -> Invasion Point Bonich (map 922 45.39,48.18) via portal
    {
        fromPointID = 700304,
        fromMap = 882,
        fromX = 0.6101,
        fromY = 0.1874,
        toPointID = 700323,
        toMap = 922,
        toX = 0.4539,
        toY = 0.4818,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5366,
                },
            },
        },
    },
    -- Eredath (map 882 61.01,18.74) -> Invasion Point Bonich (map 922 69.54,63.16) via portal
    {
        fromPointID = 700304,
        fromMap = 882,
        fromX = 0.6101,
        fromY = 0.1874,
        toPointID = 700324,
        toMap = 922,
        toX = 0.6954,
        toY = 0.6316,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5366,
                },
            },
        },
    },
    -- Eredath (map 882 70.51,38.47) -> Invasion Point Naigtal (map 924 25.20,29.85) via portal
    {
        fromPointID = 700305,
        fromMap = 882,
        fromX = 0.7051,
        fromY = 0.3847,
        toPointID = 700327,
        toMap = 924,
        toX = 0.252,
        toY = 0.2985,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5368,
                },
            },
        },
    },
    -- Eredath (map 882 70.51,38.47) -> Invasion Point Naigtal (map 924 71.95,57.46) via portal
    {
        fromPointID = 700305,
        fromMap = 882,
        fromX = 0.7051,
        fromY = 0.3847,
        toPointID = 700328,
        toMap = 924,
        toX = 0.7195,
        toY = 0.5746,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5368,
                },
            },
        },
    },

    -- Zone: Eversong Woods (map 2395)
    -- Eversong Woods M (map 2395 35.37,78.82) -> Windrunner Spire (map 2492 0.00,0.00) via portal
    {
        fromPointID = 200672,
        fromMap = 2395,
        fromX = 0.3537,
        fromY = 0.7882,
        toPointID = 200731,
        toMap = 2492,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Eversong Woods M (map 2395 45.14,46.93) -> Harandar (map 2413 75.70,53.64) via portal
    {
        fromPointID = 200674,
        fromMap = 2395,
        fromX = 0.4514,
        fromY = 0.4693,
        toPointID = 200707,
        toMap = 2413,
        toX = 0.757,
        toY = 0.5364,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86899,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86899,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86898,
                        },
                    },
                },
            },
        },
    },
    -- Eversong Woods M (map 2395 45.54,86.35) -> Voidholme (map 2502 16.36,59.76) via portal
    {
        fromPointID = 200676,
        fromMap = 2395,
        fromX = 0.4554,
        fromY = 0.8635,
        toPointID = 200750,
        toMap = 2502,
        toX = 0.1636,
        toY = 0.5976,
        type = "portal",
    },
    -- Eversong Woods M (map 2395 63.79,80.01) -> Atal Aman M (map 2535 24.83,49.41) via portal
    {
        fromPointID = 200678,
        fromMap = 2395,
        fromX = 0.6379,
        fromY = 0.8001,
        toPointID = 200829,
        toMap = 2535,
        toX = 0.2483,
        toY = 0.4941,
        type = "portal",
    },

    -- Zone: Excavation Site 9 (map 2396)
    -- Excavation Site 9 (map 2396 48.75,3.62) -> The Ringing Deeps (map 2214 76.81,98.29) via portal
    {
        fromPointID = 1200172,
        fromMap = 2396,
        fromX = 0.4875,
        fromY = 0.0362,
        toPointID = 1200023,
        toMap = 2214,
        toX = 0.7681,
        toY = 0.9829,
        type = "portal",
    },
    -- Excavation Site 9 (map 2396 48.75,3.63) -> The Ringing Deeps (map 2214 76.82,98.29) via portal
    {
        fromPointID = 1200173,
        fromMap = 2396,
        fromX = 0.4875,
        fromY = 0.0363,
        toPointID = 1200024,
        toMap = 2214,
        toX = 0.7682,
        toY = 0.9829,
        type = "portal",
    },

    -- Zone: Eye of Azshara (map 713)
    -- Eye of Azshara (map 713 47.59,87.41) -> Azsuna (map 630 61.12,41.11) via portal
    {
        fromPointID = 700223,
        fromMap = 713,
        fromX = 0.4759,
        fromY = 0.8741,
        toPointID = 700057,
        toMap = 630,
        toX = 0.6112,
        toY = 0.4111,
        type = "portal",
    },

    -- Zone: Felsoul Hold (map 682)
    -- Suramar (map 682 53.60,36.80) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700208,
        fromMap = 682,
        fromX = 0.536,
        fromY = 0.368,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 60,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41575,
                },
            },
        },
    },

    -- Zone: Feralas (map 69)
    -- Feralas (map 69 44.91,42.74) -> Amirdrassil (map 2239 54.92,63.88) via portal
    {
        fromPointID = 100152,
        fromMap = 69,
        fromX = 0.4491,
        fromY = 0.4274,
        toPointID = 1100226,
        toMap = 2239,
        toX = 0.5492,
        toY = 0.6388,
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
    },
    -- Feralas (map 69 51.34,10.59) -> Emerald Dreamway (map 715 27.64,40.69) via portal
    {
        fromPointID = 100157,
        fromMap = 69,
        fromX = 0.5134,
        fromY = 0.1059,
        toPointID = 700227,
        toMap = 715,
        toX = 0.2764,
        toY = 0.4069,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Feralas (map 69 60.31,31.30) -> Dire Maul (map 236 93.42,75.90) via portal
    {
        fromPointID = 100159,
        fromMap = 69,
        fromX = 0.6031,
        fromY = 0.313,
        toPointID = 100354,
        toMap = 236,
        toX = 0.9342,
        toY = 0.759,
        type = "portal",
    },
    -- Feralas (map 69 60.32,30.12) -> Dire Maul (map 236 93.53,47.68) via portal
    {
        fromPointID = 100160,
        fromMap = 69,
        fromX = 0.6032,
        fromY = 0.3012,
        toPointID = 100355,
        toMap = 236,
        toX = 0.9353,
        toY = 0.4768,
        type = "portal",
    },
    -- Feralas (map 69 62.51,24.89) -> Dire Maul (map 235 71.13,93.54) via portal
    {
        fromPointID = 100161,
        fromMap = 69,
        fromX = 0.6251,
        fromY = 0.2489,
        toPointID = 100349,
        toMap = 235,
        toX = 0.7113,
        toY = 0.9354,
        type = "portal",
    },
    -- Feralas (map 69 64.80,30.20) -> Dire Maul (map 239 6.71,38.29) via portal
    {
        fromPointID = 100162,
        fromMap = 69,
        fromX = 0.648,
        fromY = 0.302,
        toPointID = 100360,
        toMap = 239,
        toX = 0.0671,
        toY = 0.3829,
        type = "portal",
    },
    -- Feralas (map 69 66.77,34.84) -> Dire Maul (map 239 28.22,84.76) via portal
    {
        fromPointID = 100164,
        fromMap = 69,
        fromX = 0.6677,
        fromY = 0.3484,
        toPointID = 100361,
        toMap = 239,
        toX = 0.2822,
        toY = 0.8476,
        type = "portal",
    },
    -- Feralas (map 69 76.45,35.90) -> Dire Maul (map 239 92.12,45.20) via portal
    {
        fromPointID = 100166,
        fromMap = 69,
        fromX = 0.7645,
        fromY = 0.359,
        toPointID = 100363,
        toMap = 239,
        toX = 0.9212,
        toY = 0.452,
        type = "portal",
    },

    -- Zone: Firelands (map 368)
    -- Firelands (map 368 25.50,92.00) -> Mount Hyjal (map 198 47.43,78.00) via portal
    {
        fromPointID = 100411,
        fromMap = 368,
        fromX = 0.255,
        fromY = 0.92,
        toPointID = 100327,
        toMap = 198,
        toX = 0.4743,
        toY = 0.78,
        type = "portal",
    },

    -- Zone: Firelands (map 738)
    -- Firelands L (map 738 25.02,92.64) -> The Maelstrom L (map 726 30.54,59.78) via portal
    {
        fromPointID = 100452,
        fromMap = 738,
        fromX = 0.2502,
        fromY = 0.9264,
        toPointID = 700248,
        toMap = 726,
        toX = 0.3054,
        toY = 0.5978,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42208,
                },
            },
        },
    },

    -- Zone: Forgotten Depths (map 2621)
    -- Forgotten Depths (map 2621 71.97,19.95) -> Val (map 2599 42.91,71.57) via portal
    {
        fromPointID = 200888,
        fromMap = 2621,
        fromX = 0.7197,
        fromY = 0.1995,
        toPointID = 200865,
        toMap = 2599,
        toX = 0.4291,
        toY = 0.7157,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Founder's Point (map 2352)
    -- Founder's Point (map 2352 57.42,26.63) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 200650,
        fromMap = 2352,
        fromX = 0.5742,
        fromY = 0.2663,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                    value = 93057,
                },
            },
        },
    },
    -- Founder's Point (map 2352 57.43,26.62) -> Player House (map 8001 1.00,1.00) via portal
    {
        fromPointID = 200651,
        fromMap = 2352,
        fromX = 0.5743,
        fromY = 0.2662,
        toPointID = 1300086,
        toMap = 8001,
        toX = 0.01,
        toY = 0.01,
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
    },

    -- Zone: Freehold (map 936)
    -- Freehold (map 936 0.00,0.00) -> Tiragarde Sound (map 895 84.45,78.88) via portal
    {
        fromPointID = 800040,
        fromMap = 936,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 800014,
        toMap = 895,
        toX = 0.8445,
        toY = 0.7888,
        type = "portal",
    },

    -- Zone: Frostfire Ridge (map 525)
    -- Frostfire Ridge (map 525 21.82,45.31) -> Blade's Edge Mountains (map 105 46.40,64.05) via portal
    {
        fromPointID = 600002,
        fromMap = 525,
        fromX = 0.2182,
        fromY = 0.4531,
        toPointID = 300058,
        toMap = 105,
        toX = 0.464,
        toY = 0.6405,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Frostfire Ridge (map 525 37.53,60.71) -> Blade's Edge Mountains (map 105 39.63,77.39) via portal
    {
        fromPointID = 600005,
        fromMap = 525,
        fromX = 0.3753,
        fromY = 0.6071,
        toPointID = 300057,
        toMap = 105,
        toX = 0.3963,
        toY = 0.7739,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Frostfire Ridge (map 525 49.80,24.70) -> Bloodmaul Slag Mines (map 573 51.50,83.30) via portal
    {
        fromPointID = 600010,
        fromMap = 525,
        fromX = 0.498,
        fromY = 0.247,
        toPointID = 600120,
        toMap = 573,
        toX = 0.515,
        toY = 0.833,
        type = "portal",
    },

    -- Zone: Frostwall (map 590)
    -- Frostwall (map 590 75.17,48.57) -> Warspear (map 624 44.42,35.53) via portal
    {
        fromPointID = 600126,
        fromMap = 590,
        fromX = 0.7517,
        fromY = 0.4857,
        toPointID = 600138,
        toMap = 624,
        toX = 0.4442,
        toY = 0.3553,
        type = "portal",
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
                    kind = "garrison",
                    value = {
                        level = 3,
                        type = 2,
                    },
                },
            },
        },
    },

    -- Zone: Fungal Folly (map 2249)
    -- Fungal Folly (map 2249 68.99,89.03) -> Isle of Dorn (map 2248 51.87,65.51) via portal
    {
        fromPointID = 1200054,
        fromMap = 2249,
        fromX = 0.6899,
        fromY = 0.8903,
        toPointID = 1200047,
        toMap = 2248,
        toX = 0.5187,
        toY = 0.6551,
        type = "portal",
    },

    -- Zone: Fungal Terminus (map 1819)
    -- Fungal Terminus (map 1819 38.65,48.02) -> Ardenweald (map 1565 49.39,27.55) via portal
    {
        fromPointID = 1000285,
        fromMap = 1819,
        fromX = 0.3865,
        fromY = 0.4802,
        toPointID = 1000135,
        toMap = 1565,
        toX = 0.4939,
        toY = 0.2755,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 41.47,40.07) -> Ardenweald (map 1565 29.51,34.63) via portal
    {
        fromPointID = 1000286,
        fromMap = 1819,
        fromX = 0.4147,
        fromY = 0.4007,
        toPointID = 1000130,
        toMap = 1565,
        toX = 0.2951,
        toY = 0.3463,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 41.97,61.14) -> Ardenweald (map 1565 65.73,60.26) via portal
    {
        fromPointID = 1000287,
        fromMap = 1819,
        fromX = 0.4197,
        fromY = 0.6114,
        toPointID = 1000144,
        toMap = 1565,
        toX = 0.6573,
        toY = 0.6026,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 45.79,66.38) -> Ardenweald (map 1565 73.69,25.22) via portal
    {
        fromPointID = 1000288,
        fromMap = 1819,
        fromX = 0.4579,
        fromY = 0.6638,
        toPointID = 1000147,
        toMap = 1565,
        toX = 0.7369,
        toY = 0.2522,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 46.87,35.40) -> Ardenweald (map 1565 41.09,69.54) via portal
    {
        fromPointID = 1000289,
        fromMap = 1819,
        fromX = 0.4687,
        fromY = 0.354,
        toPointID = 1000133,
        toMap = 1565,
        toX = 0.4109,
        toY = 0.6954,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 51.80,35.59) -> Ardenweald (map 1565 26.44,51.25) via portal
    {
        fromPointID = 1000290,
        fromMap = 1819,
        fromX = 0.518,
        fromY = 0.3559,
        toPointID = 1000127,
        toMap = 1565,
        toX = 0.2644,
        toY = 0.5125,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 52.69,67.91) -> Ardenweald (map 1565 53.28,79.06) via portal
    {
        fromPointID = 1000291,
        fromMap = 1819,
        fromX = 0.5269,
        fromY = 0.6791,
        toPointID = 1000139,
        toMap = 1565,
        toX = 0.5328,
        toY = 0.7906,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 54.98,53.13) -> The Maw (map 1543 22.94,43.90) via portal
    {
        fromPointID = 1000292,
        fromMap = 1819,
        fromX = 0.5498,
        fromY = 0.5313,
        toPointID = 1000088,
        toMap = 1543,
        toX = 0.2294,
        toY = 0.439,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63823,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 56.45,37.37) -> Ardenweald (map 1565 57.50,42.59) via portal
    {
        fromPointID = 1000293,
        fromMap = 1819,
        fromX = 0.5645,
        fromY = 0.3737,
        toPointID = 1000141,
        toMap = 1565,
        toX = 0.575,
        toY = 0.4259,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 58.78,43.56) -> Ardenweald (map 1565 20.28,66.95) via portal
    {
        fromPointID = 1000294,
        fromMap = 1819,
        fromX = 0.5878,
        fromY = 0.4356,
        toPointID = 1000125,
        toMap = 1565,
        toX = 0.2028,
        toY = 0.6695,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Fungal Terminus (map 1819 58.81,62.18) -> Heart of the Forest (map 1702 55.33,27.40) via portal
    {
        fromPointID = 1000295,
        fromMap = 1819,
        fromX = 0.5881,
        fromY = 0.6218,
        toPointID = 1000256,
        toMap = 1702,
        toX = 0.5533,
        toY = 0.274,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },

    -- Zone: Gate of the Setting Sun (map 437)
    -- Gate of the Setting Sun (map 437 61.30,87.80) -> Vale of Eternal Blossoms (map 390 15.90,74.30) via portal
    {
        fromPointID = 500160,
        fromMap = 437,
        fromX = 0.613,
        fromY = 0.878,
        toPointID = 500108,
        toMap = 390,
        toX = 0.159,
        toY = 0.743,
        type = "portal",
    },

    -- Zone: Ghostlands (map 95)
    -- Ghostlands (map 95 52.22,97.43) -> Eastern Plaguelands (map 23 54.38,8.77) via portal
    {
        fromPointID = 200338,
        fromMap = 95,
        fromX = 0.5222,
        fromY = 0.9743,
        toPointID = 200095,
        toMap = 23,
        toX = 0.5438,
        toY = 0.0877,
        type = "portal",
    },
    -- Ghostlands (map 95 82.28,64.30) -> Zul'Aman (map 333 7.32,52.97) via portal
    {
        fromPointID = 200339,
        fromMap = 95,
        fromX = 0.8228,
        fromY = 0.643,
        toPointID = 200554,
        toMap = 333,
        toX = 0.0732,
        toY = 0.5297,
        type = "portal",
    },

    -- Zone: Gnarldor Isle (map 2635)
    -- Gnarldor Isle (map 2635 77.03,46.37) -> The Coiled Isle (map 2512 64.40,77.79) via portal
    {
        fromPointID = 200891,
        fromMap = 2635,
        fromX = 0.7703,
        fromY = 0.4637,
        toPointID = 200795,
        toMap = 2512,
        toX = 0.644,
        toY = 0.7779,
        type = "portal",
    },

    -- Zone: Gnomeregan (map 228)
    -- Gnomeregan (map 228 64.33,28.96) -> Dun Morogh (map 30 30.00,74.70) via portal
    {
        fromPointID = 200403,
        fromMap = 228,
        fromX = 0.6433,
        fromY = 0.2896,
        toPointID = 200135,
        toMap = 30,
        toX = 0.3,
        toY = 0.747,
        type = "portal",
    },

    -- Zone: Gorgrond (map 543)
    -- Gorgrond (map 543 45.40,13.50) -> Iron Docks (map 595 30.60,44.50) via portal
    {
        fromPointID = 600092,
        fromMap = 543,
        fromX = 0.454,
        fromY = 0.135,
        toPointID = 600128,
        toMap = 595,
        toX = 0.306,
        toY = 0.445,
        type = "portal",
    },
    -- Gorgrond (map 543 49.41,73.66) -> Blade's Edge Mountains (map 105 59.11,71.69) via portal
    {
        fromPointID = 600094,
        fromMap = 543,
        fromX = 0.4941,
        fromY = 0.7366,
        toPointID = 300061,
        toMap = 105,
        toX = 0.5911,
        toY = 0.7169,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Gorgrond (map 543 50.82,31.43) -> Blade's Edge Mountains (map 105 66.20,26.33) via portal
    {
        fromPointID = 600095,
        fromMap = 543,
        fromX = 0.5082,
        fromY = 0.3143,
        toPointID = 300063,
        toMap = 105,
        toX = 0.662,
        toY = 0.2633,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Gorgrond (map 543 51.55,27.23) -> Blackrock Foundry (map 598 41.00,86.90) via portal
    {
        fromPointID = 600096,
        fromMap = 543,
        fromX = 0.5155,
        fromY = 0.2723,
        toPointID = 600129,
        toMap = 598,
        toX = 0.41,
        toY = 0.869,
        type = "portal",
    },
    -- Gorgrond (map 543 55.00,31.30) -> Grimrail Depot (map 606 32.40,31.90) via portal
    {
        fromPointID = 600098,
        fromMap = 543,
        fromX = 0.55,
        fromY = 0.313,
        toPointID = 600131,
        toMap = 606,
        toX = 0.324,
        toY = 0.319,
        type = "portal",
    },
    -- Gorgrond (map 543 59.60,45.60) -> The Everbloom (map 620 72.40,55.70) via portal
    {
        fromPointID = 600102,
        fromMap = 543,
        fromX = 0.596,
        fromY = 0.456,
        toPointID = 600133,
        toMap = 620,
        toX = 0.724,
        toY = 0.557,
        type = "portal",
    },

    -- Zone: Greater Invasion Point: Inquisitor Meto (map 930)
    -- Invasion Point Meto (map 930 24.03,27.66) -> Antoran Wastes (map 885 63.91,63.14) via portal
    {
        fromPointID = 700338,
        fromMap = 930,
        fromX = 0.2403,
        fromY = 0.2766,
        toPointID = 700312,
        toMap = 885,
        toX = 0.6391,
        toY = 0.6314,
        type = "portal",
    },
    -- Invasion Point Meto (map 930 29.35,32.05) -> Antoran Wastes (map 885 63.91,63.14) via portal
    {
        fromPointID = 700339,
        fromMap = 930,
        fromX = 0.2935,
        fromY = 0.3205,
        toPointID = 700312,
        toMap = 885,
        toX = 0.6391,
        toY = 0.6314,
        type = "portal",
    },

    -- Zone: Greater Invasion Point: Matron Folnuna (map 929)
    -- Invasion Point Folnuna (map 929 28.31,21.44) -> Krokuun (map 830 60.62,25.73) via portal
    {
        fromPointID = 700336,
        fromMap = 929,
        fromX = 0.2831,
        fromY = 0.2144,
        toPointID = 700285,
        toMap = 830,
        toX = 0.6062,
        toY = 0.2573,
        type = "portal",
    },
    -- Invasion Point Folnuna (map 929 28.46,30.09) -> Krokuun (map 830 60.62,25.73) via portal
    {
        fromPointID = 700337,
        fromMap = 929,
        fromX = 0.2846,
        fromY = 0.3009,
        toPointID = 700285,
        toMap = 830,
        toX = 0.6062,
        toY = 0.2573,
        type = "portal",
    },

    -- Zone: Greater Invasion Point: Mistress Alluradel (map 928)
    -- Invasion Point Alluradel (map 928 69.96,62.58) -> Antoran Wastes (map 885 67.47,39.85) via portal
    {
        fromPointID = 700334,
        fromMap = 928,
        fromX = 0.6996,
        fromY = 0.6258,
        toPointID = 700315,
        toMap = 885,
        toX = 0.6747,
        toY = 0.3985,
        type = "portal",
    },
    -- Invasion Point Alluradel (map 928 70.41,66.34) -> Antoran Wastes (map 885 61.96,30.19) via portal
    {
        fromPointID = 700335,
        fromMap = 928,
        fromX = 0.7041,
        fromY = 0.6634,
        toPointID = 700311,
        toMap = 885,
        toX = 0.6196,
        toY = 0.3019,
        type = "portal",
    },

    -- Zone: Greater Invasion Point: Pit Lord Vilemus (map 927)
    -- Invasion Point Vilemus (map 927 81.54,39.51) -> Antoran Wastes (map 885 61.96,30.19) via portal
    {
        fromPointID = 700333,
        fromMap = 927,
        fromX = 0.8154,
        fromY = 0.3951,
        toPointID = 700311,
        toMap = 885,
        toX = 0.6196,
        toY = 0.3019,
        type = "portal",
    },

    -- Zone: Greater Invasion Point: Sotanathor (map 931)
    -- Invasion Point Sotanathor (map 931 24.14,50.49) -> Eredath (map 882 45.24,50.79) via portal
    {
        fromPointID = 700340,
        fromMap = 931,
        fromX = 0.2414,
        fromY = 0.5049,
        toPointID = 700303,
        toMap = 882,
        toX = 0.4524,
        toY = 0.5079,
        type = "portal",
    },
    -- Invasion Point Sotanathor (map 931 26.29,46.22) -> Eredath (map 882 45.24,50.79) via portal
    {
        fromPointID = 700341,
        fromMap = 931,
        fromX = 0.2629,
        fromY = 0.4622,
        toPointID = 700303,
        toMap = 882,
        toX = 0.4524,
        toY = 0.5079,
        type = "portal",
    },

    -- Zone: Grim Batol (map 293)
    -- Grim Batol (map 293 12.15,55.67) -> Twilight Highlands (map 241 19.14,53.84) via portal
    {
        fromPointID = 200517,
        fromMap = 293,
        fromX = 0.1215,
        fromY = 0.5567,
        toPointID = 200411,
        toMap = 241,
        toX = 0.1914,
        toY = 0.5384,
        type = "portal",
    },

    -- Zone: Grimrail Depot (map 606)
    -- Grimrail Depot (map 606 32.40,31.90) -> Gorgrond (map 543 55.00,31.30) via portal
    {
        fromPointID = 600131,
        fromMap = 606,
        fromX = 0.324,
        fromY = 0.319,
        toPointID = 600098,
        toMap = 543,
        toX = 0.55,
        toY = 0.313,
        type = "portal",
    },

    -- Zone: Grizzly Hills (map 116)
    -- Grizzly Hills (map 116 50.32,29.18) -> Emerald Dreamway (map 715 32.40,29.53) via portal
    {
        fromPointID = 400044,
        fromMap = 116,
        fromX = 0.5032,
        fromY = 0.2918,
        toPointID = 700229,
        toMap = 715,
        toX = 0.324,
        toY = 0.2953,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: Gruul's Lair (map 330)
    -- Gruul's Lair (map 330 81.87,78.11) -> Blade's Edge Mountains (map 105 69.35,23.62) via portal
    {
        fromPointID = 300143,
        fromMap = 330,
        fromX = 0.8187,
        fromY = 0.7811,
        toPointID = 300064,
        toMap = 105,
        toX = 0.6935,
        toY = 0.2362,
        type = "portal",
    },

    -- Zone: Gulf of Memory (map 2505)
    -- Gulf Of Memory (map 2505 51.50,8.56) -> Harandar (map 2413 36.71,49.74) via portal
    {
        fromPointID = 200755,
        fromMap = 2505,
        fromX = 0.515,
        fromY = 0.0856,
        toPointID = 200698,
        toMap = 2413,
        toX = 0.3671,
        toY = 0.4974,
        type = "portal",
    },

    -- Zone: Gundrak (map 154)
    -- Gundrak (map 154 58.99,30.92) -> Zul'Drak (map 121 76.12,20.92) via portal
    {
        fromPointID = 400180,
        fromMap = 154,
        fromX = 0.5899,
        fromY = 0.3092,
        toPointID = 400105,
        toMap = 121,
        toX = 0.7612,
        toY = 0.2092,
        type = "portal",
    },

    -- Zone: Hall of Communion (map 888)
    -- Hall of Communion (map 888 49.78,8.80) -> Dalaran L (map 627 39.65,50.54) via portal
    {
        fromPointID = 400244,
        fromMap = 888,
        fromX = 0.4978,
        fromY = 0.088,
        toPointID = 700010,
        toMap = 627,
        toX = 0.3965,
        toY = 0.5054,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 47330,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 46206,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Hall of the Guardian (map 734)
    -- Hall of the Guardian (map 734 54.75,44.45) -> Highmountain (map 650 31.41,63.82) via portal
    {
        fromPointID = 700254,
        fromMap = 734,
        fromX = 0.5475,
        fromY = 0.4445,
        toPointID = 700128,
        toMap = 650,
        toX = 0.3141,
        toY = 0.6382,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Hall of the Guardian (map 734 55.06,39.65) -> Azsuna (map 630 57.95,15.15) via portal
    {
        fromPointID = 700255,
        fromMap = 734,
        fromX = 0.5506,
        fromY = 0.3965,
        toPointID = 700056,
        toMap = 630,
        toX = 0.5795,
        toY = 0.1515,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Hall of the Guardian (map 734 57.30,90.46) -> Dalaran L (map 627 67.52,46.47) via portal
    {
        fromPointID = 700256,
        fromMap = 734,
        fromX = 0.573,
        fromY = 0.9046,
        toPointID = 700028,
        toMap = 627,
        toX = 0.6752,
        toY = 0.4647,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41114,
                },
            },
        },
    },
    -- Hall of the Guardian (map 734 60.26,51.78) -> Suramar (map 680 33.43,50.44) via portal
    {
        fromPointID = 700259,
        fromMap = 734,
        fromX = 0.6026,
        fromY = 0.5178,
        toPointID = 700146,
        toMap = 680,
        toX = 0.3343,
        toY = 0.5044,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Hall of the Guardian (map 734 66.78,46.52) -> Val'sharah (map 641 51.24,56.09) via portal
    {
        fromPointID = 700260,
        fromMap = 734,
        fromX = 0.6678,
        fromY = 0.4652,
        toPointID = 700092,
        toMap = 641,
        toX = 0.5124,
        toY = 0.5609,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Hall of the Guardian (map 734 67.12,41.71) -> Stormheim (map 634 31.34,60.51) via portal
    {
        fromPointID = 700261,
        fromMap = 734,
        fromX = 0.6712,
        fromY = 0.4171,
        toPointID = 700065,
        toMap = 634,
        toX = 0.3134,
        toY = 0.6051,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },

    -- Zone: Hallowfall (map 2215)
    -- Hallowfall (map 2215 34.28,47.31) -> Nightfall Sanctum (map 2277 80.80,16.25) via portal
    {
        fromPointID = 1200025,
        fromMap = 2215,
        fromX = 0.3428,
        fromY = 0.4731,
        toPointID = 1200079,
        toMap = 2277,
        toX = 0.808,
        toY = 0.1625,
        type = "portal",
    },
    -- Hallowfall (map 2215 41.36,49.26) -> Priory of the Sacred Flame (map 2308 80.99,47.60) via portal
    {
        fromPointID = 1200028,
        fromMap = 2215,
        fromX = 0.4136,
        fromY = 0.4926,
        toPointID = 1200097,
        toMap = 2308,
        toX = 0.8099,
        toY = 0.476,
        type = "portal",
    },
    -- Hallowfall (map 2215 50.70,53.56) -> The Sinkhole (map 2301 51.59,5.75) via portal
    {
        fromPointID = 1200032,
        fromMap = 2215,
        fromX = 0.507,
        fromY = 0.5356,
        toPointID = 1200093,
        toMap = 2301,
        toX = 0.5159,
        toY = 0.0575,
        type = "portal",
    },
    -- Hallowfall (map 2215 54.94,63.17) -> The Dawnbreaker (map 2359 76.14,78.68) via portal
    {
        fromPointID = 1200034,
        fromMap = 2215,
        fromX = 0.5494,
        fromY = 0.6317,
        toPointID = 1200154,
        toMap = 2359,
        toX = 0.7614,
        toY = 0.7868,
        type = "portal",
    },
    -- Hallowfall (map 2215 65.42,61.69) -> Skittering Breach (map 2310 83.68,54.72) via portal
    {
        fromPointID = 1200035,
        fromMap = 2215,
        fromX = 0.6542,
        fromY = 0.6169,
        toPointID = 1200099,
        toMap = 2310,
        toX = 0.8368,
        toY = 0.5472,
        type = "portal",
    },
    -- Hallowfall (map 2215 71.37,31.15) -> Mycomancer Cavern (map 2312 14.00,35.80) via portal
    {
        fromPointID = 1200036,
        fromMap = 2215,
        fromX = 0.7137,
        fromY = 0.3115,
        toPointID = 1200100,
        toMap = 2312,
        toX = 0.14,
        toY = 0.358,
        type = "portal",
    },

    -- Zone: Halls Of Infusion (map 2082)
    -- Halls of Infusion (map 2082 0.00,0.00) -> Thaldraszus (map 2025 59.13,60.44) via portal
    {
        fromPointID = 1100088,
        fromMap = 2082,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100069,
        toMap = 2025,
        toX = 0.5913,
        toY = 0.6044,
        type = "portal",
    },

    -- Zone: Halls of Atonement (map 1663)
    -- Halls of Atonement (map 1663 0.00,0.00) -> Revendreth (map 1525 78.58,49.22) via portal
    {
        fromPointID = 1000153,
        fromMap = 1663,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000029,
        toMap = 1525,
        toX = 0.7858,
        toY = 0.4922,
        type = "portal",
    },

    -- Zone: Halls of Lightning (map 138)
    -- Halls of Lightning (map 138 7.38,53.81) -> The Storm Peaks (map 120 45.38,21.37) via portal
    {
        fromPointID = 400157,
        fromMap = 138,
        fromX = 0.0738,
        fromY = 0.5381,
        toPointID = 400091,
        toMap = 120,
        toX = 0.4538,
        toY = 0.2137,
        type = "portal",
    },

    -- Zone: Halls of Origination (map 297)
    -- Halls of Origination (map 297 0.00,0.00) -> Uldum New (map 1527 69.09,53.15) via portal
    {
        fromPointID = 100385,
        fromMap = 297,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100472,
        toMap = 1527,
        toX = 0.6909,
        toY = 0.5315,
        type = "portal",
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

    -- Zone: Halls of Origination (map 299)
    -- Halls of Origination (map 299 49.91,93.73) -> Uldum (map 249 69.09,52.97) via portal
    {
        fromPointID = 100392,
        fromMap = 299,
        fromX = 0.4991,
        fromY = 0.9373,
        toPointID = 100371,
        toMap = 249,
        toX = 0.6909,
        toY = 0.5297,
        type = "portal",
    },

    -- Zone: Halls of Reflection (map 185)
    -- Halls of Reflection (map 185 47.33,80.81) -> Icecrown (map 118 55.46,90.88) via portal
    {
        fromPointID = 400214,
        fromMap = 185,
        fromX = 0.4733,
        fromY = 0.8081,
        toPointID = 400073,
        toMap = 118,
        toX = 0.5546,
        toY = 0.9088,
        type = "portal",
    },
    -- Halls of Reflection (map 185 47.33,80.81) -> Pit of Saron (map 184 32.30,6.81) via portal
    {
        fromPointID = 400214,
        fromMap = 185,
        fromX = 0.4733,
        fromY = 0.8081,
        toPointID = 400212,
        toMap = 184,
        toX = 0.323,
        toY = 0.0681,
        type = "portal",
    },

    -- Zone: Halls of Stone (map 140)
    -- Halls of Stone (map 140 34.40,36.20) -> The Storm Peaks (map 120 39.50,26.92) via portal
    {
        fromPointID = 400160,
        fromMap = 140,
        fromX = 0.344,
        fromY = 0.362,
        toPointID = 400088,
        toMap = 120,
        toX = 0.395,
        toY = 0.2692,
        type = "portal",
    },

    -- Zone: Halls of Valor (map 704)
    -- Halls of Valor (map 704 47.72,8.68) -> Stormheim (map 634 72.65,70.52) via portal
    {
        fromPointID = 700217,
        fromMap = 704,
        fromX = 0.4772,
        fromY = 0.0868,
        toPointID = 700081,
        toMap = 634,
        toX = 0.7265,
        toY = 0.7052,
        type = "portal",
    },

    -- Zone: Harandar (map 2413)
    -- Harandar (map 2413 26.24,78.09) -> The Blinding Vale (map 2500 0.00,0.00) via portal
    {
        fromPointID = 200695,
        fromMap = 2413,
        fromX = 0.2624,
        fromY = 0.7809,
        toPointID = 200748,
        toMap = 2500,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Harandar (map 2413 36.71,49.74) -> Gulf Of Memory (map 2505 51.50,8.56) via portal
    {
        fromPointID = 200698,
        fromMap = 2413,
        fromX = 0.3671,
        fromY = 0.4974,
        toPointID = 200755,
        toMap = 2505,
        toX = 0.515,
        toY = 0.0856,
        type = "portal",
    },
    -- Harandar (map 2413 53.36,55.42) -> Silvermoon City M (map 2393 36.57,68.80) via portal
    {
        fromPointID = 200700,
        fromMap = 2413,
        fromX = 0.5336,
        fromY = 0.5542,
        toPointID = 200658,
        toMap = 2393,
        toX = 0.3657,
        toY = 0.688,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41804,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86899,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86899,
                        },
                    },
                },
            },
        },
    },
    -- Harandar (map 2413 61.33,63.01) -> Dreamrift (map 2531 0.00,0.00) via portal
    {
        fromPointID = 200702,
        fromMap = 2413,
        fromX = 0.6133,
        fromY = 0.6301,
        toPointID = 200823,
        toMap = 2531,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Harandar (map 2413 73.67,66.34) -> Sporefall (map 2427 24.20,8.25) via portal
    {
        fromPointID = 200706,
        fromMap = 2413,
        fromX = 0.7367,
        fromY = 0.6634,
        toPointID = 200714,
        toMap = 2427,
        toX = 0.242,
        toY = 0.0825,
        type = "portal",
    },
    -- Harandar (map 2413 75.88,54.84) -> Eversong Woods M (map 2395 45.17,46.97) via portal
    {
        fromPointID = 200708,
        fromMap = 2413,
        fromX = 0.7588,
        fromY = 0.5484,
        toPointID = 200675,
        toMap = 2395,
        toX = 0.4517,
        toY = 0.4697,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86883,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86883,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86897,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Heart of Fear (map 474)
    -- Heart of Fear (map 474 34.00,87.40) -> Dread Wastes (map 422 38.86,35.02) via portal
    {
        fromPointID = 500197,
        fromMap = 474,
        fromX = 0.34,
        fromY = 0.874,
        toPointID = 500134,
        toMap = 422,
        toX = 0.3886,
        toY = 0.3502,
        type = "portal",
    },

    -- Zone: Heart of the Forest (map 1701)
    -- Heart of the Forest (map 1701 53.69,38.26) -> Heart of the Forest (map 1703 43.94,60.67) via portal
    {
        fromPointID = 1000252,
        fromMap = 1701,
        fromX = 0.5369,
        fromY = 0.3826,
        toPointID = 1000260,
        toMap = 1703,
        toX = 0.4394,
        toY = 0.6067,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 58160,
                },
            },
        },
    },

    -- Zone: Heart of the Forest (map 1702)
    -- Heart of the Forest (map 1702 55.29,26.63) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000255,
        fromMap = 1702,
        fromX = 0.5529,
        fromY = 0.2663,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },
    -- Heart of the Forest (map 1702 57.33,65.57) -> Queen's Conservatory (map 1662 73.47,48.05) via portal
    {
        fromPointID = 1000257,
        fromMap = 1702,
        fromX = 0.5733,
        fromY = 0.6557,
        toPointID = 1000152,
        toMap = 1662,
        toX = 0.7347,
        toY = 0.4805,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63046,
                },
            },
        },
    },
    -- Heart of the Forest (map 1702 59.90,28.47) -> Oribos (map 1671 44.68,58.91) via portal
    {
        fromPointID = 1000258,
        fromMap = 1702,
        fromX = 0.599,
        fromY = 0.2847,
        toPointID = 1000183,
        toMap = 1671,
        toX = 0.4468,
        toY = 0.5891,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57583,
                },
            },
        },
    },

    -- Zone: Heart of the Forest (map 1703)
    -- Heart of the Forest (map 1703 36.12,63.68) -> Heart of the Forest (map 1701 53.96,38.73) via portal
    {
        fromPointID = 1000259,
        fromMap = 1703,
        fromX = 0.3612,
        fromY = 0.6368,
        toPointID = 1000253,
        toMap = 1701,
        toX = 0.5396,
        toY = 0.3873,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 58160,
                },
            },
        },
    },

    -- Zone: Helheim (map 649)
    -- Helheim (map 649 66.83,48.14) -> Stormheim (map 634 73.54,39.51) via portal
    {
        fromPointID = 700125,
        fromMap = 649,
        fromX = 0.6683,
        fromY = 0.4814,
        toPointID = 700082,
        toMap = 634,
        toX = 0.7354,
        toY = 0.3951,
        type = "portal",
    },

    -- Zone: Hellfire Citadel (map 661)
    -- Hellfire Citadel (map 661 70.20,43.80) -> Tanaan Jungle (map 534 45.60,53.54) via portal
    {
        fromPointID = 600143,
        fromMap = 661,
        fromX = 0.702,
        fromY = 0.438,
        toPointID = 600029,
        toMap = 534,
        toX = 0.456,
        toY = 0.5354,
        type = "portal",
    },

    -- Zone: Hellfire Peninsula (map 100)
    -- Hellfire Peninsula (map 100 45.95,51.87) -> The Blood Furnace (map 261 47.75,90.56) via portal
    {
        fromPointID = 300005,
        fromMap = 100,
        fromX = 0.4595,
        fromY = 0.5187,
        toPointID = 300120,
        toMap = 261,
        toX = 0.4775,
        toY = 0.9056,
        type = "portal",
    },
    -- Hellfire Peninsula (map 100 47.48,52.02) -> The Shattered Halls (map 246 61.14,92.81) via portal
    {
        fromPointID = 300006,
        fromMap = 100,
        fromX = 0.4748,
        fromY = 0.5202,
        toPointID = 300110,
        toMap = 246,
        toX = 0.6114,
        toY = 0.9281,
        type = "portal",
    },
    -- Hellfire Peninsula (map 100 47.54,52.05) -> Magtheridon's Lair (map 331 62.72,18.03) via portal
    {
        fromPointID = 300007,
        fromMap = 100,
        fromX = 0.4754,
        fromY = 0.5205,
        toPointID = 300144,
        toMap = 331,
        toX = 0.6272,
        toY = 0.1803,
        type = "portal",
    },
    -- Hellfire Peninsula (map 100 47.59,53.59) -> Hellfire Ramparts (map 347 50.06,70.37) via portal
    {
        fromPointID = 300008,
        fromMap = 100,
        fromX = 0.4759,
        fromY = 0.5359,
        toPointID = 300162,
        toMap = 347,
        toX = 0.5006,
        toY = 0.7037,
        type = "portal",
    },
    -- Hellfire Peninsula (map 100 54.98,48.87) -> Tanaan Jungle (map 534 49.56,50.73) via portal
    {
        fromPointID = 300010,
        fromMap = 100,
        fromX = 0.5498,
        fromY = 0.4887,
        toPointID = 600031,
        toMap = 534,
        toX = 0.4956,
        toY = 0.5073,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Hellfire Peninsula (map 100 64.04,21.73) -> Tanaan Jungle (map 534 56.34,26.83) via portal
    {
        fromPointID = 300013,
        fromMap = 100,
        fromX = 0.6404,
        fromY = 0.2173,
        toPointID = 600032,
        toMap = 534,
        toX = 0.5634,
        toY = 0.2683,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Hellfire Peninsula (map 100 80.38,51.60) -> Tanaan Jungle (map 534 70.30,54.53) via portal
    {
        fromPointID = 300015,
        fromMap = 100,
        fromX = 0.8038,
        fromY = 0.516,
        toPointID = 600037,
        toMap = 534,
        toX = 0.703,
        toY = 0.5453,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Hellfire Peninsula (map 100 88.57,47.70) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 300018,
        fromMap = 100,
        fromX = 0.8857,
        fromY = 0.477,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },
    -- Hellfire Peninsula (map 100 88.62,52.81) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 300019,
        fromMap = 100,
        fromX = 0.8862,
        fromY = 0.5281,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
    -- Hellfire Peninsula (map 100 89.22,51.00) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 300022,
        fromMap = 100,
        fromX = 0.8922,
        fromY = 0.51,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
    -- Hellfire Peninsula (map 100 89.23,49.45) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 300023,
        fromMap = 100,
        fromX = 0.8923,
        fromY = 0.4945,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },

    -- Zone: Hellfire Ramparts (map 347)
    -- Hellfire Ramparts (map 347 50.06,70.37) -> Hellfire Peninsula (map 100 47.59,53.59) via portal
    {
        fromPointID = 300162,
        fromMap = 347,
        fromX = 0.5006,
        fromY = 0.7037,
        toPointID = 300008,
        toMap = 100,
        toX = 0.4759,
        toY = 0.5359,
        type = "portal",
    },

    -- Zone: Helmouth Cliffs (map 706)
    -- Helmouth Cliffs (map 706 46.77,78.55) -> Stormheim (map 634 52.49,45.26) via portal
    {
        fromPointID = 700218,
        fromMap = 706,
        fromX = 0.4677,
        fromY = 0.7855,
        toPointID = 700074,
        toMap = 634,
        toX = 0.5249,
        toY = 0.4526,
        type = "portal",
    },

    -- Zone: Highmaul (map 611)
    -- Highmaul (map 611 36.60,35.80) -> Nagrand D (map 550 32.94,38.36) via portal
    {
        fromPointID = 600132,
        fromMap = 611,
        fromX = 0.366,
        fromY = 0.358,
        toPointID = 600105,
        toMap = 550,
        toX = 0.3294,
        toY = 0.3836,
        type = "portal",
    },

    -- Zone: Highmountain (map 650)
    -- Highmountain (map 650 31.41,63.82) -> Hall of the Guardian (map 734 54.75,44.45) via portal
    {
        fromPointID = 700128,
        fromMap = 650,
        fromX = 0.3141,
        fromY = 0.6382,
        toPointID = 700254,
        toMap = 734,
        toX = 0.5475,
        toY = 0.4445,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Highmountain (map 650 49.56,68.66) -> Neltharion's Lair (map 731 96.35,40.19) via portal
    {
        fromPointID = 700131,
        fromMap = 650,
        fromX = 0.4956,
        fromY = 0.6866,
        toPointID = 700251,
        toMap = 731,
        toX = 0.9635,
        toY = 0.4019,
        type = "portal",
    },

    -- Zone: Hour of Twilight (map 399)
    -- Hour of Twilight (map 399 48.51,19.72) -> Tanaris (map 75 67.20,29.40) via portal
    {
        fromPointID = 100415,
        fromMap = 399,
        fromX = 0.4851,
        fromY = 0.1972,
        toPointID = 100213,
        toMap = 75,
        toX = 0.672,
        toY = 0.294,
        type = "portal",
    },

    -- Zone: Howling Fjord (map 117)
    -- Howling Fjord (map 117 57.27,46.67) -> Utgarde Keep (map 133 0.00,0.00) via portal
    {
        fromPointID = 400059,
        fromMap = 117,
        fromX = 0.5727,
        fromY = 0.4667,
        toPointID = 400145,
        toMap = 133,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Howling Fjord (map 117 57.27,46.69) -> Utgarde Pinnacle (map 137 44.33,14.19) via portal
    {
        fromPointID = 400060,
        fromMap = 117,
        fromX = 0.5727,
        fromY = 0.4669,
        toPointID = 400154,
        toMap = 137,
        toX = 0.4433,
        toY = 0.1419,
        type = "portal",
    },

    -- Zone: Icecrown Citadel (map 186)
    -- Icecrown Citadel (map 186 38.98,17.17) -> Icecrown Citadel (map 186 38.98,71.11) via portal
    {
        fromPointID = 400215,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.1717,
        toPointID = 400216,
        toMap = 186,
        toX = 0.3898,
        toY = 0.7111,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,17.17) -> Icecrown Citadel (map 187 45.60,80.43) via portal
    {
        fromPointID = 400215,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.1717,
        toPointID = 400219,
        toMap = 187,
        toX = 0.456,
        toY = 0.8043,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,17.17) -> Icecrown Citadel (map 188 51.50,76.26) via portal
    {
        fromPointID = 400215,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.1717,
        toPointID = 400223,
        toMap = 188,
        toX = 0.515,
        toY = 0.7626,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,17.17) -> Icecrown Citadel (map 189 26.11,33.30) via portal
    {
        fromPointID = 400215,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.1717,
        toPointID = 400225,
        toMap = 189,
        toX = 0.2611,
        toY = 0.333,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,17.17) -> Icecrown Citadel (map 190 51.87,74.32) via portal
    {
        fromPointID = 400215,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.1717,
        toPointID = 400231,
        toMap = 190,
        toX = 0.5187,
        toY = 0.7432,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,71.11) -> Icecrown Citadel (map 186 38.98,17.17) via portal
    {
        fromPointID = 400216,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.7111,
        toPointID = 400215,
        toMap = 186,
        toX = 0.3898,
        toY = 0.1717,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,71.11) -> Icecrown Citadel (map 187 45.60,80.43) via portal
    {
        fromPointID = 400216,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.7111,
        toPointID = 400219,
        toMap = 187,
        toX = 0.456,
        toY = 0.8043,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,71.11) -> Icecrown Citadel (map 188 51.50,76.26) via portal
    {
        fromPointID = 400216,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.7111,
        toPointID = 400223,
        toMap = 188,
        toX = 0.515,
        toY = 0.7626,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,71.11) -> Icecrown Citadel (map 189 26.11,33.30) via portal
    {
        fromPointID = 400216,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.7111,
        toPointID = 400225,
        toMap = 189,
        toX = 0.2611,
        toY = 0.333,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 38.98,71.11) -> Icecrown Citadel (map 190 51.87,74.32) via portal
    {
        fromPointID = 400216,
        fromMap = 186,
        fromX = 0.3898,
        fromY = 0.7111,
        toPointID = 400231,
        toMap = 190,
        toX = 0.5187,
        toY = 0.7432,
        type = "portal",
    },
    -- Icecrown Citadel (map 186 39.00,7.80) -> Icecrown (map 118 53.83,87.15) via portal
    {
        fromPointID = 400217,
        fromMap = 186,
        fromX = 0.39,
        fromY = 0.078,
        toPointID = 400070,
        toMap = 118,
        toX = 0.5383,
        toY = 0.8715,
        type = "portal",
    },

    -- Zone: Icecrown Citadel (map 187)
    -- Icecrown Citadel (map 187 45.60,80.43) -> Icecrown Citadel (map 186 38.98,17.17) via portal
    {
        fromPointID = 400219,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8043,
        toPointID = 400215,
        toMap = 186,
        toX = 0.3898,
        toY = 0.1717,
        type = "portal",
    },
    -- Icecrown Citadel (map 187 45.60,80.43) -> Icecrown Citadel (map 186 38.98,71.11) via portal
    {
        fromPointID = 400219,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8043,
        toPointID = 400216,
        toMap = 186,
        toX = 0.3898,
        toY = 0.7111,
        type = "portal",
    },
    -- Icecrown Citadel (map 187 45.60,80.43) -> Icecrown Citadel (map 188 51.50,76.26) via portal
    {
        fromPointID = 400219,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8043,
        toPointID = 400223,
        toMap = 188,
        toX = 0.515,
        toY = 0.7626,
        type = "portal",
    },
    -- Icecrown Citadel (map 187 45.60,80.43) -> Icecrown Citadel (map 189 26.11,33.30) via portal
    {
        fromPointID = 400219,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8043,
        toPointID = 400225,
        toMap = 189,
        toX = 0.2611,
        toY = 0.333,
        type = "portal",
    },
    -- Icecrown Citadel (map 187 45.60,80.43) -> Icecrown Citadel (map 190 51.87,74.32) via portal
    {
        fromPointID = 400219,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8043,
        toPointID = 400231,
        toMap = 190,
        toX = 0.5187,
        toY = 0.7432,
        type = "portal",
    },

    -- Zone: Icecrown Citadel (map 188)
    -- Icecrown Citadel (map 188 51.50,76.26) -> Icecrown Citadel (map 186 38.98,17.17) via portal
    {
        fromPointID = 400223,
        fromMap = 188,
        fromX = 0.515,
        fromY = 0.7626,
        toPointID = 400215,
        toMap = 186,
        toX = 0.3898,
        toY = 0.1717,
        type = "portal",
    },
    -- Icecrown Citadel (map 188 51.50,76.26) -> Icecrown Citadel (map 186 38.98,71.11) via portal
    {
        fromPointID = 400223,
        fromMap = 188,
        fromX = 0.515,
        fromY = 0.7626,
        toPointID = 400216,
        toMap = 186,
        toX = 0.3898,
        toY = 0.7111,
        type = "portal",
    },
    -- Icecrown Citadel (map 188 51.50,76.26) -> Icecrown Citadel (map 187 45.60,80.43) via portal
    {
        fromPointID = 400223,
        fromMap = 188,
        fromX = 0.515,
        fromY = 0.7626,
        toPointID = 400219,
        toMap = 187,
        toX = 0.456,
        toY = 0.8043,
        type = "portal",
    },
    -- Icecrown Citadel (map 188 51.50,76.26) -> Icecrown Citadel (map 189 26.11,33.30) via portal
    {
        fromPointID = 400223,
        fromMap = 188,
        fromX = 0.515,
        fromY = 0.7626,
        toPointID = 400225,
        toMap = 189,
        toX = 0.2611,
        toY = 0.333,
        type = "portal",
    },
    -- Icecrown Citadel (map 188 51.50,76.26) -> Icecrown Citadel (map 190 51.87,74.32) via portal
    {
        fromPointID = 400223,
        fromMap = 188,
        fromX = 0.515,
        fromY = 0.7626,
        toPointID = 400231,
        toMap = 190,
        toX = 0.5187,
        toY = 0.7432,
        type = "portal",
    },

    -- Zone: Icecrown Citadel (map 189)
    -- Icecrown Citadel (map 189 26.11,33.30) -> Icecrown Citadel (map 186 38.98,17.17) via portal
    {
        fromPointID = 400225,
        fromMap = 189,
        fromX = 0.2611,
        fromY = 0.333,
        toPointID = 400215,
        toMap = 186,
        toX = 0.3898,
        toY = 0.1717,
        type = "portal",
    },
    -- Icecrown Citadel (map 189 26.11,33.30) -> Icecrown Citadel (map 186 38.98,71.11) via portal
    {
        fromPointID = 400225,
        fromMap = 189,
        fromX = 0.2611,
        fromY = 0.333,
        toPointID = 400216,
        toMap = 186,
        toX = 0.3898,
        toY = 0.7111,
        type = "portal",
    },
    -- Icecrown Citadel (map 189 26.11,33.30) -> Icecrown Citadel (map 187 45.60,80.43) via portal
    {
        fromPointID = 400225,
        fromMap = 189,
        fromX = 0.2611,
        fromY = 0.333,
        toPointID = 400219,
        toMap = 187,
        toX = 0.456,
        toY = 0.8043,
        type = "portal",
    },
    -- Icecrown Citadel (map 189 26.11,33.30) -> Icecrown Citadel (map 188 51.50,76.26) via portal
    {
        fromPointID = 400225,
        fromMap = 189,
        fromX = 0.2611,
        fromY = 0.333,
        toPointID = 400223,
        toMap = 188,
        toX = 0.515,
        toY = 0.7626,
        type = "portal",
    },
    -- Icecrown Citadel (map 189 26.11,33.30) -> Icecrown Citadel (map 190 51.87,74.32) via portal
    {
        fromPointID = 400225,
        fromMap = 189,
        fromX = 0.2611,
        fromY = 0.333,
        toPointID = 400231,
        toMap = 190,
        toX = 0.5187,
        toY = 0.7432,
        type = "portal",
    },

    -- Zone: Icecrown Citadel (map 190)
    -- Icecrown Citadel (map 190 51.87,74.32) -> Icecrown Citadel (map 186 38.98,17.17) via portal
    {
        fromPointID = 400231,
        fromMap = 190,
        fromX = 0.5187,
        fromY = 0.7432,
        toPointID = 400215,
        toMap = 186,
        toX = 0.3898,
        toY = 0.1717,
        type = "portal",
    },
    -- Icecrown Citadel (map 190 51.87,74.32) -> Icecrown Citadel (map 186 38.98,71.11) via portal
    {
        fromPointID = 400231,
        fromMap = 190,
        fromX = 0.5187,
        fromY = 0.7432,
        toPointID = 400216,
        toMap = 186,
        toX = 0.3898,
        toY = 0.7111,
        type = "portal",
    },
    -- Icecrown Citadel (map 190 51.87,74.32) -> Icecrown Citadel (map 187 45.60,80.43) via portal
    {
        fromPointID = 400231,
        fromMap = 190,
        fromX = 0.5187,
        fromY = 0.7432,
        toPointID = 400219,
        toMap = 187,
        toX = 0.456,
        toY = 0.8043,
        type = "portal",
    },
    -- Icecrown Citadel (map 190 51.87,74.32) -> Icecrown Citadel (map 188 51.50,76.26) via portal
    {
        fromPointID = 400231,
        fromMap = 190,
        fromX = 0.5187,
        fromY = 0.7432,
        toPointID = 400223,
        toMap = 188,
        toX = 0.515,
        toY = 0.7626,
        type = "portal",
    },
    -- Icecrown Citadel (map 190 51.87,74.32) -> Icecrown Citadel (map 189 26.11,33.30) via portal
    {
        fromPointID = 400231,
        fromMap = 190,
        fromX = 0.5187,
        fromY = 0.7432,
        toPointID = 400225,
        toMap = 189,
        toX = 0.2611,
        toY = 0.333,
        type = "portal",
    },

    -- Zone: Icecrown (map 118)
    -- Icecrown (map 118 53.83,87.15) -> Icecrown Citadel (map 186 39.00,7.80) via portal
    {
        fromPointID = 400070,
        fromMap = 118,
        fromX = 0.5383,
        fromY = 0.8715,
        toPointID = 400217,
        toMap = 186,
        toX = 0.39,
        toY = 0.078,
        type = "portal",
    },
    -- Icecrown (map 118 54.78,91.80) -> Pit of Saron (map 184 40.91,80.52) via portal
    {
        fromPointID = 400071,
        fromMap = 118,
        fromX = 0.5478,
        fromY = 0.918,
        toPointID = 400213,
        toMap = 184,
        toX = 0.4091,
        toY = 0.8052,
        type = "portal",
    },
    -- Icecrown (map 118 54.92,89.76) -> The Forge of Souls (map 183 66.05,88.89) via portal
    {
        fromPointID = 400072,
        fromMap = 118,
        fromX = 0.5492,
        fromY = 0.8976,
        toPointID = 400211,
        toMap = 183,
        toX = 0.6605,
        toY = 0.8889,
        type = "portal",
    },
    -- Icecrown (map 118 55.46,90.88) -> Halls of Reflection (map 185 47.33,80.81) via portal
    {
        fromPointID = 400073,
        fromMap = 118,
        fromX = 0.5546,
        fromY = 0.9088,
        toPointID = 400214,
        toMap = 185,
        toX = 0.4733,
        toY = 0.8081,
        type = "portal",
    },
    -- Icecrown (map 118 74.17,20.52) -> Trial of the Champion (map 171 51.18,30.24) via portal
    {
        fromPointID = 400075,
        fromMap = 118,
        fromX = 0.7417,
        fromY = 0.2052,
        toPointID = 400207,
        toMap = 171,
        toX = 0.5118,
        toY = 0.3024,
        type = "portal",
    },
    -- Icecrown (map 118 75.08,21.81) -> Trial of the Crusader (map 172 64.50,52.60) via portal
    {
        fromPointID = 400076,
        fromMap = 118,
        fromX = 0.7508,
        fromY = 0.2181,
        toPointID = 400209,
        toMap = 172,
        toX = 0.645,
        toY = 0.526,
        type = "portal",
    },

    -- Zone: Invasion Point: Aurinor (map 921)
    -- Invasion Point Aurinor (map 921 20.45,52.72) -> Eredath (map 882 38.82,12.52) via portal
    {
        fromPointID = 700321,
        fromMap = 921,
        fromX = 0.2045,
        fromY = 0.5272,
        toPointID = 700302,
        toMap = 882,
        toX = 0.3882,
        toY = 0.1252,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5367,
                },
            },
        },
    },
    -- Invasion Point Aurinor (map 921 20.45,52.72) -> Antoran Wastes (map 885 64.59,69.16) via portal
    {
        fromPointID = 700321,
        fromMap = 921,
        fromX = 0.2045,
        fromY = 0.5272,
        toPointID = 700313,
        toMap = 885,
        toX = 0.6459,
        toY = 0.6916,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5373,
                },
            },
        },
    },
    -- Invasion Point Aurinor (map 921 81.75,39.02) -> Eredath (map 882 38.82,12.52) via portal
    {
        fromPointID = 700322,
        fromMap = 921,
        fromX = 0.8175,
        fromY = 0.3902,
        toPointID = 700302,
        toMap = 882,
        toX = 0.3882,
        toY = 0.1252,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5367,
                },
            },
        },
    },
    -- Invasion Point Aurinor (map 921 81.75,39.02) -> Antoran Wastes (map 885 64.59,69.16) via portal
    {
        fromPointID = 700322,
        fromMap = 921,
        fromX = 0.8175,
        fromY = 0.3902,
        toPointID = 700313,
        toMap = 885,
        toX = 0.6459,
        toY = 0.6916,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5373,
                },
            },
        },
    },

    -- Zone: Invasion Point: Bonich (map 922)
    -- Invasion Point Bonich (map 922 45.39,48.18) -> Eredath (map 882 61.01,18.74) via portal
    {
        fromPointID = 700323,
        fromMap = 922,
        fromX = 0.4539,
        fromY = 0.4818,
        toPointID = 700304,
        toMap = 882,
        toX = 0.6101,
        toY = 0.1874,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5366,
                },
            },
        },
    },
    -- Invasion Point Bonich (map 922 45.39,48.18) -> Antoran Wastes (map 885 55.75,19.28) via portal
    {
        fromPointID = 700323,
        fromMap = 922,
        fromX = 0.4539,
        fromY = 0.4818,
        toPointID = 700309,
        toMap = 885,
        toX = 0.5575,
        toY = 0.1928,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5371,
                },
            },
        },
    },
    -- Invasion Point Bonich (map 922 69.54,63.16) -> Eredath (map 882 61.01,18.74) via portal
    {
        fromPointID = 700324,
        fromMap = 922,
        fromX = 0.6954,
        fromY = 0.6316,
        toPointID = 700304,
        toMap = 882,
        toX = 0.6101,
        toY = 0.1874,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5366,
                },
            },
        },
    },
    -- Invasion Point Bonich (map 922 69.54,63.16) -> Antoran Wastes (map 885 55.75,19.28) via portal
    {
        fromPointID = 700324,
        fromMap = 922,
        fromX = 0.6954,
        fromY = 0.6316,
        toPointID = 700309,
        toMap = 885,
        toX = 0.5575,
        toY = 0.1928,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5371,
                },
            },
        },
    },

    -- Zone: Invasion Point: Cen'gar (map 923)
    -- Invasion Point Cen'gar (map 923 27.39,28.40) -> Krokuun (map 830 68.66,81.80) via portal
    {
        fromPointID = 700325,
        fromMap = 923,
        fromX = 0.2739,
        fromY = 0.284,
        toPointID = 700286,
        toMap = 830,
        toX = 0.6866,
        toY = 0.818,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5359,
                },
            },
        },
    },
    -- Invasion Point Cen'gar (map 923 27.39,28.40) -> Antoran Wastes (map 885 60.24,42.98) via portal
    {
        fromPointID = 700325,
        fromMap = 923,
        fromX = 0.2739,
        fromY = 0.284,
        toPointID = 700310,
        toMap = 885,
        toX = 0.6024,
        toY = 0.4298,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5370,
                },
            },
        },
    },
    -- Invasion Point Cen'gar (map 923 65.76,69.57) -> Krokuun (map 830 68.66,81.80) via portal
    {
        fromPointID = 700326,
        fromMap = 923,
        fromX = 0.6576,
        fromY = 0.6957,
        toPointID = 700286,
        toMap = 830,
        toX = 0.6866,
        toY = 0.818,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5359,
                },
            },
        },
    },
    -- Invasion Point Cen'gar (map 923 65.76,69.57) -> Antoran Wastes (map 885 60.24,42.98) via portal
    {
        fromPointID = 700326,
        fromMap = 923,
        fromX = 0.6576,
        fromY = 0.6957,
        toPointID = 700310,
        toMap = 885,
        toX = 0.6024,
        toY = 0.4298,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5370,
                },
            },
        },
    },

    -- Zone: Invasion Point: Naigtal (map 924)
    -- Invasion Point Naigtal (map 924 25.20,29.85) -> Eredath (map 882 70.51,38.47) via portal
    {
        fromPointID = 700327,
        fromMap = 924,
        fromX = 0.252,
        fromY = 0.2985,
        toPointID = 700305,
        toMap = 882,
        toX = 0.7051,
        toY = 0.3847,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5368,
                },
            },
        },
    },
    -- Invasion Point Naigtal (map 924 25.20,29.85) -> Antoran Wastes (map 885 55.35,29.53) via portal
    {
        fromPointID = 700327,
        fromMap = 924,
        fromX = 0.252,
        fromY = 0.2985,
        toPointID = 700308,
        toMap = 885,
        toX = 0.5535,
        toY = 0.2953,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5374,
                },
            },
        },
    },
    -- Invasion Point Naigtal (map 924 71.95,57.46) -> Eredath (map 882 70.51,38.47) via portal
    {
        fromPointID = 700328,
        fromMap = 924,
        fromX = 0.7195,
        fromY = 0.5746,
        toPointID = 700305,
        toMap = 882,
        toX = 0.7051,
        toY = 0.3847,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5368,
                },
            },
        },
    },
    -- Invasion Point Naigtal (map 924 71.95,57.46) -> Antoran Wastes (map 885 55.35,29.53) via portal
    {
        fromPointID = 700328,
        fromMap = 924,
        fromX = 0.7195,
        fromY = 0.5746,
        toPointID = 700308,
        toMap = 885,
        toX = 0.5535,
        toY = 0.2953,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5374,
                },
            },
        },
    },

    -- Zone: Invasion Point: Sangua (map 925)
    -- Invasion Point Sangua (map 925 24.18,50.61) -> Krokuun (map 830 73.44,33.84) via portal
    {
        fromPointID = 700329,
        fromMap = 925,
        fromX = 0.2418,
        fromY = 0.5061,
        toPointID = 700287,
        toMap = 830,
        toX = 0.7344,
        toY = 0.3384,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5350,
                },
            },
        },
    },
    -- Invasion Point Sangua (map 925 24.18,50.61) -> Antoran Wastes (map 885 67.03,33.31) via portal
    {
        fromPointID = 700329,
        fromMap = 925,
        fromX = 0.2418,
        fromY = 0.5061,
        toPointID = 700314,
        toMap = 885,
        toX = 0.6703,
        toY = 0.3331,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5369,
                },
            },
        },
    },
    -- Invasion Point Sangua (map 925 50.91,48.01) -> Krokuun (map 830 73.44,33.84) via portal
    {
        fromPointID = 700330,
        fromMap = 925,
        fromX = 0.5091,
        fromY = 0.4801,
        toPointID = 700287,
        toMap = 830,
        toX = 0.7344,
        toY = 0.3384,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5350,
                },
            },
        },
    },
    -- Invasion Point Sangua (map 925 50.91,48.01) -> Antoran Wastes (map 885 67.03,33.31) via portal
    {
        fromPointID = 700330,
        fromMap = 925,
        fromX = 0.5091,
        fromY = 0.4801,
        toPointID = 700314,
        toMap = 885,
        toX = 0.6703,
        toY = 0.3331,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5369,
                },
            },
        },
    },

    -- Zone: Invasion Point: Val (map 926)
    -- Invasion Point Val (map 926 38.78,74.46) -> Krokuun (map 830 38.49,60.97) via portal
    {
        fromPointID = 700331,
        fromMap = 926,
        fromX = 0.3878,
        fromY = 0.7446,
        toPointID = 700283,
        toMap = 830,
        toX = 0.3849,
        toY = 0.6097,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5360,
                },
            },
        },
    },
    -- Invasion Point Val (map 926 38.78,74.46) -> Antoran Wastes (map 885 72.68,65.22) via portal
    {
        fromPointID = 700331,
        fromMap = 926,
        fromX = 0.3878,
        fromY = 0.7446,
        toPointID = 700317,
        toMap = 885,
        toX = 0.7268,
        toY = 0.6522,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5372,
                },
            },
        },
    },
    -- Invasion Point Val (map 926 55.07,35.85) -> Krokuun (map 830 38.49,60.97) via portal
    {
        fromPointID = 700332,
        fromMap = 926,
        fromX = 0.5507,
        fromY = 0.3585,
        toPointID = 700283,
        toMap = 830,
        toX = 0.3849,
        toY = 0.6097,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5360,
                },
            },
        },
    },
    -- Invasion Point Val (map 926 55.07,35.85) -> Antoran Wastes (map 885 72.65,65.33) via portal
    {
        fromPointID = 700332,
        fromMap = 926,
        fromX = 0.5507,
        fromY = 0.3585,
        toPointID = 700316,
        toMap = 885,
        toX = 0.7265,
        toY = 0.6533,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5372,
                },
            },
        },
    },

    -- Zone: Iron Docks (map 595)
    -- Iron Docks (map 595 30.60,44.50) -> Gorgrond (map 543 45.40,13.50) via portal
    {
        fromPointID = 600128,
        fromMap = 595,
        fromX = 0.306,
        fromY = 0.445,
        toPointID = 600092,
        toMap = 543,
        toX = 0.454,
        toY = 0.135,
        type = "portal",
    },

    -- Zone: Ironforge (map 87)
    -- Ironforge (map 87 76.93,51.25) -> Deeprun Tram (map 499 45.77,12.47) via portal
    {
        fromPointID = 200326,
        fromMap = 87,
        fromX = 0.7693,
        fromY = 0.5125,
        toPointID = 200624,
        toMap = 499,
        toX = 0.4577,
        toY = 0.1247,
        type = "portal",
    },

    -- Zone: Isle of Dorn (map 2248)
    -- Isle of Dorn (map 2248 37.41,72.86) -> The Ringing Deeps (map 2214 61.53,76.95) via portal
    {
        fromPointID = 1200043,
        fromMap = 2248,
        fromX = 0.3741,
        fromY = 0.7286,
        toPointID = 1200019,
        toMap = 2214,
        toX = 0.6153,
        toY = 0.7695,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 84220,
                },
            },
        },
    },
    -- Isle of Dorn (map 2248 38.55,73.93) -> Earthcrawl Mines (map 2269 46.20,9.54) via portal
    {
        fromPointID = 1200044,
        fromMap = 2248,
        fromX = 0.3855,
        fromY = 0.7393,
        toPointID = 1200078,
        toMap = 2269,
        toX = 0.462,
        toY = 0.0954,
        type = "portal",
    },
    -- Isle of Dorn (map 2248 51.87,65.51) -> Fungal Folly (map 2249 68.99,89.03) via portal
    {
        fromPointID = 1200047,
        fromMap = 2248,
        fromX = 0.5187,
        fromY = 0.6551,
        toPointID = 1200054,
        toMap = 2249,
        toX = 0.6899,
        toY = 0.8903,
        type = "portal",
    },
    -- Isle of Dorn (map 2248 62.17,42.72) -> Kriegval's Rest (map 2250 31.49,26.85) via portal
    {
        fromPointID = 1200049,
        fromMap = 2248,
        fromX = 0.6217,
        fromY = 0.4272,
        toPointID = 1200055,
        toMap = 2250,
        toX = 0.3149,
        toY = 0.2685,
        type = "portal",
    },
    -- Isle of Dorn (map 2248 67.35,31.01) -> The Ringing Deeps (map 2214 49.20,44.59) via portal
    {
        fromPointID = 1200050,
        fromMap = 2248,
        fromX = 0.6735,
        fromY = 0.3101,
        toPointID = 1200016,
        toMap = 2214,
        toX = 0.492,
        toY = 0.4459,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 82195,
                },
            },
        },
    },
    -- Isle of Dorn (map 2248 76.71,43.78) -> Cinderbrew Meadery (map 2335 23.91,52.38) via portal
    {
        fromPointID = 1200053,
        fromMap = 2248,
        fromX = 0.7671,
        fromY = 0.4378,
        toPointID = 1200116,
        toMap = 2335,
        toX = 0.2391,
        toY = 0.5238,
        type = "portal",
    },

    -- Zone: Isle of Quel'Danas (map 122)
    -- Isle of Quel'Danas (map 122 44.25,45.75) -> Sunwell Plateau (map 335 30.94,36.41) via portal
    {
        fromPointID = 200345,
        fromMap = 122,
        fromX = 0.4425,
        fromY = 0.4575,
        toPointID = 200555,
        toMap = 335,
        toX = 0.3094,
        toY = 0.3641,
        type = "portal",
    },
    -- Isle of Quel'Danas (map 122 61.28,30.92) -> Magisters' Terrace (map 349 42.53,90.01) via portal
    {
        fromPointID = 200348,
        fromMap = 122,
        fromX = 0.6128,
        fromY = 0.3092,
        toPointID = 200561,
        toMap = 349,
        toX = 0.4253,
        toY = 0.9001,
        type = "portal",
    },

    -- Zone: Isle of Quel'Danas (map 2424)
    -- Isle of Quel Danas M (map 2424 46.38,40.62) -> Parhelion Plaza (map 2545 82.63,34.13) via portal
    {
        fromPointID = 200709,
        fromMap = 2424,
        fromX = 0.4638,
        fromY = 0.4062,
        toPointID = 200831,
        toMap = 2545,
        toX = 0.8263,
        toY = 0.3413,
        type = "portal",
    },
    -- Isle of Quel Danas M (map 2424 52.60,85.11) -> March on Quel Danas (map 2533 0.00,0.00) via portal
    {
        fromPointID = 200710,
        fromMap = 2424,
        fromX = 0.526,
        fromY = 0.8511,
        toPointID = 200826,
        toMap = 2533,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Isle of Quel Danas M (map 2424 63.53,15.48) -> Magisters Terrace M (map 2515 0.00,0.00) via portal
    {
        fromPointID = 200712,
        fromMap = 2424,
        fromX = 0.6353,
        fromY = 0.1548,
        toPointID = 200800,
        toMap = 2515,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Isle of Thunder (map 504)
    -- Isle of Thunder (map 504 28.37,52.98) -> Townlong Steppes (map 388 50.70,73.16) via portal
    {
        fromPointID = 500205,
        fromMap = 504,
        fromX = 0.2837,
        fromY = 0.5298,
        toPointID = 500093,
        toMap = 388,
        toX = 0.507,
        toY = 0.7316,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 32212,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32680,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 28.60,52.79) -> Isle of Thunder (map 504 33.06,52.84) via portal
    {
        fromPointID = 500208,
        fromMap = 504,
        fromX = 0.286,
        fromY = 0.5279,
        toPointID = 500212,
        toMap = 504,
        toX = 0.3306,
        toY = 0.5284,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 32212,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32212,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 31.62,83.61) -> Isle of Thunder (map 504 34.78,89.26) via portal
    {
        fromPointID = 500209,
        fromMap = 504,
        fromX = 0.3162,
        fromY = 0.8361,
        toPointID = 500215,
        toMap = 504,
        toX = 0.3478,
        toY = 0.8926,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 32644,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32681,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 33.02,52.72) -> Isle of Thunder (map 504 28.50,51.55) via portal
    {
        fromPointID = 500211,
        fromMap = 504,
        fromX = 0.3302,
        fromY = 0.5272,
        toPointID = 500207,
        toMap = 504,
        toX = 0.285,
        toY = 0.5155,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 32212,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32212,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 33.22,32.69) -> Townlong Steppes (map 388 50.70,73.16) via portal
    {
        fromPointID = 500213,
        fromMap = 504,
        fromX = 0.3322,
        fromY = 0.3269,
        toPointID = 500093,
        toMap = 388,
        toX = 0.507,
        toY = 0.7316,
        type = "portal",
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
                    value = 32212,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 34.86,89.41) -> Isle of Thunder (map 504 31.63,83.78) via portal
    {
        fromPointID = 500216,
        fromMap = 504,
        fromX = 0.3486,
        fromY = 0.8941,
        toPointID = 500210,
        toMap = 504,
        toX = 0.3163,
        toY = 0.8378,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 32644,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32681,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 35.33,90.57) -> Townlong Steppes (map 388 49.76,68.89) via portal
    {
        fromPointID = 500218,
        fromMap = 504,
        fromX = 0.3533,
        fromY = 0.9057,
        toPointID = 500090,
        toMap = 388,
        toX = 0.4976,
        toY = 0.6889,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 32644,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32681,
                },
            },
        },
    },
    -- Isle of Thunder (map 504 52.06,45.03) -> Isle of Thunder (map 504 62.82,32.29) via portal
    {
        fromPointID = 500221,
        fromMap = 504,
        fromX = 0.5206,
        fromY = 0.4503,
        toPointID = 500224,
        toMap = 504,
        toX = 0.6282,
        toY = 0.3229,
        type = "portal",
    },
    -- Isle of Thunder (map 504 62.82,32.29) -> Isle of Thunder (map 504 52.06,45.03) via portal
    {
        fromPointID = 500224,
        fromMap = 504,
        fromX = 0.6282,
        fromY = 0.3229,
        toPointID = 500221,
        toMap = 504,
        toX = 0.5206,
        toY = 0.4503,
        type = "portal",
    },
    -- Isle of Thunder (map 504 63.64,32.37) -> Throne of Thunder (map 508 31.70,25.80) via portal
    {
        fromPointID = 500225,
        fromMap = 504,
        fromX = 0.6364,
        fromY = 0.3237,
        toPointID = 500234,
        toMap = 508,
        toX = 0.317,
        toY = 0.258,
        type = "portal",
    },
    -- Isle of Thunder (map 504 64.71,73.48) -> Townlong Steppes (map 388 49.76,68.89) via portal
    {
        fromPointID = 500227,
        fromMap = 504,
        fromX = 0.6471,
        fromY = 0.7348,
        toPointID = 500090,
        toMap = 388,
        toX = 0.4976,
        toY = 0.6889,
        type = "portal",
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
                    value = 32644,
                },
            },
        },
    },

    -- Zone: K'aresh (map 2371)
    -- K'aresh (map 2371 41.71,21.53) -> Manaforge Omega (map 2460 76.81,9.50) via portal
    {
        fromPointID = 1200159,
        fromMap = 2371,
        fromX = 0.4171,
        fromY = 0.2153,
        toPointID = 1200208,
        toMap = 2460,
        toX = 0.7681,
        toY = 0.095,
        type = "portal",
    },
    -- K'aresh (map 2371 55.09,48.07) -> Archival Assault (map 2452 39.17,88.46) via portal
    {
        fromPointID = 1200163,
        fromMap = 2371,
        fromX = 0.5509,
        fromY = 0.4807,
        toPointID = 1200197,
        toMap = 2452,
        toX = 0.3917,
        toY = 0.8846,
        type = "portal",
    },

    -- Zone: Karazhan (map 350)
    -- Karazhan (map 350 58.76,76.11) -> Deadwind Pass (map 42 46.81,74.60) via portal
    {
        fromPointID = 200566,
        fromMap = 350,
        fromX = 0.5876,
        fromY = 0.7611,
        toPointID = 200193,
        toMap = 42,
        toX = 0.4681,
        toY = 0.746,
        type = "portal",
    },

    -- Zone: Karazhan (map 814)
    -- Karazhan L (map 814 63.90,61.30) -> Deadwind Pass (map 42 46.72,70.20) via portal
    {
        fromPointID = 200628,
        fromMap = 814,
        fromX = 0.639,
        fromY = 0.613,
        toPointID = 200192,
        toMap = 42,
        toX = 0.4672,
        toY = 0.702,
        type = "portal",
    },

    -- Zone: Kings' Rest (map 1004)
    -- King's Rest (map 1004 87.94,47.17) -> Zuldazar (map 862 37.49,39.47) via portal
    {
        fromPointID = 900068,
        fromMap = 1004,
        fromX = 0.8794,
        fromY = 0.4717,
        toPointID = 900002,
        toMap = 862,
        toX = 0.3749,
        toY = 0.3947,
        type = "portal",
    },

    -- Zone: Korthia (map 1961)
    -- Korthia (map 1961 49.35,63.87) -> Korthia (map 1961 60.43,28.02) via portal
    {
        fromPointID = 1000315,
        fromMap = 1961,
        fromX = 0.4935,
        fromY = 0.6387,
        toPointID = 1000318,
        toMap = 1961,
        toX = 0.6043,
        toY = 0.2802,
        type = "portal",
    },
    -- Korthia (map 1961 60.84,28.55) -> Korthia (map 1961 49.14,63.88) via portal
    {
        fromPointID = 1000319,
        fromMap = 1961,
        fromX = 0.6084,
        fromY = 0.2855,
        toPointID = 1000314,
        toMap = 1961,
        toX = 0.4914,
        toY = 0.6388,
        type = "portal",
    },
    -- Korthia (map 1961 64.47,24.06) -> Oribos (map 1671 37.40,33.44) via portal
    {
        fromPointID = 1000321,
        fromMap = 1961,
        fromX = 0.6447,
        fromY = 0.2406,
        toPointID = 1000180,
        toMap = 1671,
        toX = 0.374,
        toY = 0.3344,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 63855,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63665,
                },
            },
        },
    },

    -- Zone: Krasarang Wilds (map 418)
    -- Krasarang Wilds (map 418 50.47,22.42) -> Valley of the Four Winds (map 376 51.25,77.50) via portal
    {
        fromPointID = 500125,
        fromMap = 418,
        fromX = 0.5047,
        fromY = 0.2242,
        toPointID = 500034,
        toMap = 376,
        toX = 0.5125,
        toY = 0.775,
        type = "portal",
    },

    -- Zone: Kriegval's Rest (map 2250)
    -- Kriegval's Rest (map 2250 31.49,26.85) -> Isle of Dorn (map 2248 62.17,42.72) via portal
    {
        fromPointID = 1200055,
        fromMap = 2250,
        fromX = 0.3149,
        fromY = 0.2685,
        toPointID = 1200049,
        toMap = 2248,
        toX = 0.6217,
        toY = 0.4272,
        type = "portal",
    },

    -- Zone: Krokuun (map 830)
    -- Krokuun (map 830 38.49,60.97) -> Invasion Point Val (map 926 38.78,74.46) via portal
    {
        fromPointID = 700283,
        fromMap = 830,
        fromX = 0.3849,
        fromY = 0.6097,
        toPointID = 700331,
        toMap = 926,
        toX = 0.3878,
        toY = 0.7446,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5360,
                },
            },
        },
    },
    -- Krokuun (map 830 38.49,60.97) -> Invasion Point Val (map 926 55.07,35.85) via portal
    {
        fromPointID = 700283,
        fromMap = 830,
        fromX = 0.3849,
        fromY = 0.6097,
        toPointID = 700332,
        toMap = 926,
        toX = 0.5507,
        toY = 0.3585,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5360,
                },
            },
        },
    },
    -- Krokuun (map 830 60.62,25.73) -> Invasion Point Folnuna (map 929 28.31,21.44) via portal
    {
        fromPointID = 700285,
        fromMap = 830,
        fromX = 0.6062,
        fromY = 0.2573,
        toPointID = 700336,
        toMap = 929,
        toX = 0.2831,
        toY = 0.2144,
        type = "portal",
    },
    -- Krokuun (map 830 60.62,25.73) -> Invasion Point Folnuna (map 929 28.46,30.09) via portal
    {
        fromPointID = 700285,
        fromMap = 830,
        fromX = 0.6062,
        fromY = 0.2573,
        toPointID = 700337,
        toMap = 929,
        toX = 0.2846,
        toY = 0.3009,
        type = "portal",
    },
    -- Krokuun (map 830 68.66,81.80) -> Invasion Point Cen'gar (map 923 27.39,28.40) via portal
    {
        fromPointID = 700286,
        fromMap = 830,
        fromX = 0.6866,
        fromY = 0.818,
        toPointID = 700325,
        toMap = 923,
        toX = 0.2739,
        toY = 0.284,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5359,
                },
            },
        },
    },
    -- Krokuun (map 830 68.66,81.80) -> Invasion Point Cen'gar (map 923 65.76,69.57) via portal
    {
        fromPointID = 700286,
        fromMap = 830,
        fromX = 0.6866,
        fromY = 0.818,
        toPointID = 700326,
        toMap = 923,
        toX = 0.6576,
        toY = 0.6957,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5359,
                },
            },
        },
    },
    -- Krokuun (map 830 73.44,33.84) -> Invasion Point Sangua (map 925 24.18,50.61) via portal
    {
        fromPointID = 700287,
        fromMap = 830,
        fromX = 0.7344,
        fromY = 0.3384,
        toPointID = 700329,
        toMap = 925,
        toX = 0.2418,
        toY = 0.5061,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5350,
                },
            },
        },
    },
    -- Krokuun (map 830 73.44,33.84) -> Invasion Point Sangua (map 925 50.91,48.01) via portal
    {
        fromPointID = 700287,
        fromMap = 830,
        fromX = 0.7344,
        fromY = 0.3384,
        toPointID = 700330,
        toMap = 925,
        toX = 0.5091,
        toY = 0.4801,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "poiActive",
                    value = 5350,
                },
            },
        },
    },

    -- Zone: Kun-Lai Summit (map 379)
    -- Kun-Lai Summit (map 379 36.70,47.50) -> Shado-Pan Monastery (map 443 84.90,56.10) via portal
    {
        fromPointID = 500046,
        fromMap = 379,
        fromX = 0.367,
        fromY = 0.475,
        toPointID = 500174,
        toMap = 443,
        toX = 0.849,
        toY = 0.561,
        type = "portal",
    },
    -- Kun-Lai Summit (map 379 59.58,39.20) -> Mogu'shan Vaults (map 471 75.20,73.10) via portal
    {
        fromPointID = 500066,
        fromMap = 379,
        fromX = 0.5958,
        fromY = 0.392,
        toPointID = 500192,
        toMap = 471,
        toX = 0.752,
        toY = 0.731,
        type = "portal",
    },

    -- Zone: Legacy of Scholomance (map 306)
    -- Old Scholomance (map 306 0.00,0.00) -> Western Plaguelands (map 22 69.76,71.79) via portal
    {
        fromPointID = 200526,
        fromMap = 306,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200084,
        toMap = 22,
        toX = 0.6976,
        toY = 0.7179,
        type = "portal",
    },

    -- Zone: Light's Hope Chapel (map 24)
    -- Eastern Plaguelands (map 24 37.57,64.10) -> Dalaran L (map 627 33.69,68.01) via portal
    {
        fromPointID = 200099,
        fromMap = 24,
        fromX = 0.3757,
        fromY = 0.641,
        toPointID = 700005,
        toMap = 627,
        toX = 0.3369,
        toY = 0.6801,
        type = "portal",
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
                    value = 38566,
                },
            },
        },
    },
    -- Eastern Plaguelands (map 24 37.57,64.10) -> Dalaran L (map 627 61.27,14.82) via portal
    {
        fromPointID = 200099,
        fromMap = 24,
        fromX = 0.3757,
        fromY = 0.641,
        toPointID = 700022,
        toMap = 627,
        toX = 0.6127,
        toY = 0.1482,
        type = "portal",
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
                    value = 38566,
                },
            },
        },
    },

    -- Zone: Lost City of the Tol'vir (map 277)
    -- Lost City of the Tol'vir (map 277 0.00,0.00) -> Uldum New (map 1527 60.55,64.32) via portal
    {
        fromPointID = 100377,
        fromMap = 277,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100471,
        toMap = 1527,
        toX = 0.6055,
        toY = 0.6432,
        type = "portal",
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
    -- Lost City of the Tol'vir (map 277 31.78,16.78) -> Uldum (map 249 60.55,64.32) via portal
    {
        fromPointID = 100378,
        fromMap = 277,
        fromX = 0.3178,
        fromY = 0.1678,
        toPointID = 100370,
        toMap = 249,
        toX = 0.6055,
        toY = 0.6432,
        type = "portal",
    },

    -- Zone: Lunarfall (map 582)
    -- Lunarfall (map 582 70.18,27.49) -> Stormshield (map 622 31.71,52.48) via portal
    {
        fromPointID = 600122,
        fromMap = 582,
        fromX = 0.7018,
        fromY = 0.2749,
        toPointID = 600134,
        toMap = 622,
        toX = 0.3171,
        toY = 0.5248,
        type = "portal",
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
                    kind = "garrison",
                    value = {
                        level = 3,
                        type = 2,
                    },
                },
            },
        },
    },

    -- Zone: Magister's Terrace (map 2515)
    -- Magisters Terrace M (map 2515 0.00,0.00) -> Isle of Quel Danas M (map 2424 63.53,15.48) via portal
    {
        fromPointID = 200800,
        fromMap = 2515,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200712,
        toMap = 2424,
        toX = 0.6353,
        toY = 0.1548,
        type = "portal",
    },

    -- Zone: Magisters' Terrace (map 348)
    -- Magisters' Terrace (map 348 4.63,50.20) -> Isle of Quel'Danas (map 122 47.10,30.69) via portal
    {
        fromPointID = 200559,
        fromMap = 348,
        fromX = 0.0463,
        fromY = 0.502,
        toPointID = 200346,
        toMap = 122,
        toX = 0.471,
        toY = 0.3069,
        type = "portal",
    },

    -- Zone: Magisters' Terrace (map 349)
    -- Magisters' Terrace (map 349 42.53,90.01) -> Isle of Quel'Danas (map 122 61.28,30.92) via portal
    {
        fromPointID = 200561,
        fromMap = 349,
        fromX = 0.4253,
        fromY = 0.9001,
        toPointID = 200348,
        toMap = 122,
        toX = 0.6128,
        toY = 0.3092,
        type = "portal",
    },

    -- Zone: Magtheridon's Lair (map 331)
    -- Magtheridon's Lair (map 331 62.72,18.03) -> Hellfire Peninsula (map 100 47.54,52.05) via portal
    {
        fromPointID = 300144,
        fromMap = 331,
        fromX = 0.6272,
        fromY = 0.1803,
        toPointID = 300007,
        toMap = 100,
        toX = 0.4754,
        toY = 0.5205,
        type = "portal",
    },

    -- Zone: Maisara Caverns (map 2501)
    -- Maisara Caverns (map 2501 0.00,0.00) -> Zul Aman M (map 2437 43.74,39.43) via portal
    {
        fromPointID = 200749,
        fromMap = 2501,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200727,
        toMap = 2437,
        toX = 0.4374,
        toY = 0.3943,
        type = "portal",
    },

    -- Zone: Maldraxxus (map 1536)
    -- Maldraxxus (map 1536 25.86,43.27) -> Seat of the Primus (map 1698 58.71,25.85) via portal
    {
        fromPointID = 1000063,
        fromMap = 1536,
        fromX = 0.2586,
        fromY = 0.4327,
        toPointID = 1000228,
        toMap = 1698,
        toX = 0.5871,
        toY = 0.2585,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Maldraxxus (map 1536 37.13,67.56) -> Maldraxxus (map 1536 38.06,66.83) via portal
    {
        fromPointID = 1000066,
        fromMap = 1536,
        fromX = 0.3713,
        fromY = 0.6756,
        toPointID = 1000069,
        toMap = 1536,
        toX = 0.3806,
        toY = 0.6683,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60453,
                },
            },
        },
    },
    -- Maldraxxus (map 1536 37.99,66.96) -> Maldraxxus (map 1536 37.10,67.69) via portal
    {
        fromPointID = 1000068,
        fromMap = 1536,
        fromX = 0.3799,
        fromY = 0.6696,
        toPointID = 1000065,
        toMap = 1536,
        toX = 0.371,
        toY = 0.6769,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60453,
                },
            },
        },
    },
    -- Maldraxxus (map 1536 50.40,73.99) -> Seat of the Primus (map 1698 58.71,25.85) via portal
    {
        fromPointID = 1000075,
        fromMap = 1536,
        fromX = 0.504,
        fromY = 0.7399,
        toPointID = 1000228,
        toMap = 1698,
        toX = 0.5871,
        toY = 0.2585,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Maldraxxus (map 1536 51.64,16.39) -> Seat of the Primus (map 1698 58.92,34.24) via portal
    {
        fromPointID = 1000077,
        fromMap = 1536,
        fromX = 0.5164,
        fromY = 0.1639,
        toPointID = 1000230,
        toMap = 1698,
        toX = 0.5892,
        toY = 0.3424,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Maldraxxus (map 1536 53.09,52.87) -> Theater of Pain (map 1683 0.00,0.00) via portal
    {
        fromPointID = 1000078,
        fromMap = 1536,
        fromX = 0.5309,
        fromY = 0.5287,
        toPointID = 1000208,
        toMap = 1683,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Maldraxxus (map 1536 59.60,65.31) -> Plaguefall (map 1674 0.00,0.00) via portal
    {
        fromPointID = 1000082,
        fromMap = 1536,
        fromX = 0.596,
        fromY = 0.6531,
        toPointID = 1000196,
        toMap = 1674,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Maldraxxus (map 1536 74.46,33.64) -> Seat of the Primus (map 1698 58.92,34.24) via portal
    {
        fromPointID = 1000085,
        fromMap = 1536,
        fromX = 0.7446,
        fromY = 0.3364,
        toPointID = 1000230,
        toMap = 1698,
        toX = 0.5892,
        toY = 0.3424,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },

    -- Zone: Mana-Tombs (map 272)
    -- Mana-Tombs (map 272 33.52,17.29) -> Terokkar Forest (map 108 39.64,57.63) via portal
    {
        fromPointID = 300142,
        fromMap = 272,
        fromX = 0.3352,
        fromY = 0.1729,
        toPointID = 300082,
        toMap = 108,
        toX = 0.3964,
        toY = 0.5763,
        type = "portal",
    },

    -- Zone: Manaforge Omega (map 2460)
    -- Manaforge Omega (map 2460 76.81,9.50) -> K'aresh (map 2371 41.71,21.53) via portal
    {
        fromPointID = 1200208,
        fromMap = 2460,
        fromX = 0.7681,
        fromY = 0.095,
        toPointID = 1200159,
        toMap = 2371,
        toX = 0.4171,
        toY = 0.2153,
        type = "portal",
    },

    -- Zone: Maraudon (map 280)
    -- Maraudon (map 280 62.16,28.18) -> Desolace (map 67 78.40,55.30) via portal
    {
        fromPointID = 100382,
        fromMap = 280,
        fromX = 0.6216,
        fromY = 0.2818,
        toPointID = 100145,
        toMap = 67,
        toX = 0.784,
        toY = 0.553,
        type = "portal",
    },
    -- Maraudon (map 280 78.48,68.45) -> Desolace (map 68 52.40,23.80) via portal
    {
        fromPointID = 100383,
        fromMap = 280,
        fromX = 0.7848,
        fromY = 0.6845,
        toPointID = 100149,
        toMap = 68,
        toX = 0.524,
        toY = 0.238,
        type = "portal",
    },

    -- Zone: Maraudon (map 67)
    -- Desolace (map 67 78.40,55.30) -> Maraudon (map 280 62.16,28.18) via portal
    {
        fromPointID = 100145,
        fromMap = 67,
        fromX = 0.784,
        fromY = 0.553,
        toPointID = 100382,
        toMap = 280,
        toX = 0.6216,
        toY = 0.2818,
        type = "portal",
    },

    -- Zone: Maraudon (map 68)
    -- Desolace (map 68 44.30,76.70) -> Maraudon (map 280 28.10,35.50) via portal
    {
        fromPointID = 100146,
        fromMap = 68,
        fromX = 0.443,
        fromY = 0.767,
        toPointID = 100381,
        toMap = 280,
        toX = 0.281,
        toY = 0.355,
        type = "portal",
    },
    -- Desolace (map 68 52.40,23.80) -> Maraudon (map 280 78.48,68.45) via portal
    {
        fromPointID = 100149,
        fromMap = 68,
        fromX = 0.524,
        fromY = 0.238,
        toPointID = 100383,
        toMap = 280,
        toX = 0.7848,
        toY = 0.6845,
        type = "portal",
    },

    -- Zone: March on Quel'Danas (map 2533)
    -- March on Quel Danas (map 2533 0.00,0.00) -> Isle of Quel Danas M (map 2424 52.60,85.11) via portal
    {
        fromPointID = 200826,
        fromMap = 2533,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200710,
        toMap = 2424,
        toX = 0.526,
        toY = 0.8511,
        type = "portal",
    },

    -- Zone: Mardum, the Shattered Abyss (map 720)
    -- Mardum, the Shattered Abyss (map 720 59.23,91.93) -> Dalaran L (map 627 77.11,49.61) via portal
    {
        fromPointID = 700242,
        fromMap = 720,
        fromX = 0.5923,
        fromY = 0.9193,
        toPointID = 700033,
        toMap = 627,
        toX = 0.7711,
        toY = 0.4961,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42872,
                },
            },
        },
    },

    -- Zone: Mechagon City (map 1573)
    -- Mechagon City (map 1573 20.48,60.22) -> Stormwind City (map 84 54.11,16.48) via portal
    {
        fromPointID = 800112,
        fromMap = 1573,
        fromX = 0.2048,
        fromY = 0.6022,
        toPointID = 200307,
        toMap = 84,
        toX = 0.5411,
        toY = 0.1648,
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
    },

    -- Zone: Mechagon Island (map 1462)
    -- Mechagon Island (map 1462 73.01,36.46) -> Mechagon (map 1490 0.00,0.00) via portal
    {
        fromPointID = 800101,
        fromMap = 1462,
        fromX = 0.7301,
        fromY = 0.3646,
        toPointID = 800105,
        toMap = 1490,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Mechagon (map 1490)
    -- Mechagon (map 1490 0.00,0.00) -> Mechagon Island (map 1462 73.01,36.46) via portal
    {
        fromPointID = 800105,
        fromMap = 1490,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 800101,
        toMap = 1462,
        toX = 0.7301,
        toY = 0.3646,
        type = "portal",
    },

    -- Zone: Millenia's Threshold (map 2266)
    -- Millenia's Threshold (map 2266 43.55,49.90) -> Dornogal (map 2339 53.98,38.72) via portal
    {
        fromPointID = 1100237,
        fromMap = 2266,
        fromX = 0.4355,
        fromY = 0.499,
        toPointID = 1200131,
        toMap = 2339,
        toX = 0.5398,
        toY = 0.3872,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Millenia's Threshold (map 2266 60.53,69.47) -> Eredath (map 882 20.60,59.47) via portal
    {
        fromPointID = 1100238,
        fromMap = 2266,
        fromX = 0.6053,
        fromY = 0.6947,
        toPointID = 700299,
        toMap = 882,
        toX = 0.206,
        toY = 0.5947,
        type = "portal",
    },
    -- Millenia's Threshold (map 2266 64.54,43.67) -> Spires of Arak (map 542 35.83,20.21) via portal
    {
        fromPointID = 1100239,
        fromMap = 2266,
        fromX = 0.6454,
        fromY = 0.4367,
        toPointID = 600075,
        toMap = 542,
        toX = 0.3583,
        toY = 0.2021,
        type = "portal",
    },
    -- Millenia's Threshold (map 2266 70.44,72.85) -> Thaldraszus (map 2025 57.78,45.84) via portal
    {
        fromPointID = 1100240,
        fromMap = 2266,
        fromX = 0.7044,
        fromY = 0.7285,
        toPointID = 1100065,
        toMap = 2025,
        toX = 0.5778,
        toY = 0.4584,
        type = "portal",
    },
    -- Millenia's Threshold (map 2266 74.39,47.09) -> Icecrown (map 118 49.28,89.86) via portal
    {
        fromPointID = 1100241,
        fromMap = 2266,
        fromX = 0.7439,
        fromY = 0.4709,
        toPointID = 400068,
        toMap = 118,
        toX = 0.4928,
        toY = 0.8986,
        type = "portal",
    },

    -- Zone: Mists of Tirna Scithe (map 1669)
    -- Mists of Tirna Scithe (map 1669 0.00,0.00) -> Ardenweald (map 1565 35.41,54.11) via portal
    {
        fromPointID = 1000163,
        fromMap = 1669,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000132,
        toMap = 1565,
        toX = 0.3541,
        toY = 0.5411,
        type = "portal",
    },

    -- Zone: Mogu'shan Palace (map 453)
    -- Mogu'shan Palace (map 453 0.00,0.00) -> Vale of Eternal Blossoms New (map 1530 81.60,29.88) via portal
    {
        fromPointID = 500180,
        fromMap = 453,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 500292,
        toMap = 1530,
        toX = 0.816,
        toY = 0.2988,
        type = "portal",
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
    -- Mogu'shan Palace (map 453 0.00,0.00) -> Vale of Eternal Blossoms (map 390 80.90,32.60) via portal
    {
        fromPointID = 500180,
        fromMap = 453,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 500116,
        toMap = 390,
        toX = 0.809,
        toY = 0.326,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "OldVale",
                },
            },
        },
    },

    -- Zone: Mogu'shan Vaults (map 471)
    -- Mogu'shan Vaults (map 471 75.20,73.10) -> Kun-Lai Summit (map 379 59.58,39.20) via portal
    {
        fromPointID = 500192,
        fromMap = 471,
        fromX = 0.752,
        fromY = 0.731,
        toPointID = 500066,
        toMap = 379,
        toX = 0.5958,
        toY = 0.392,
        type = "portal",
    },

    -- Zone: Molten Core (map 232)
    -- Molten Core (map 232 26.50,24.30) -> Burning Steppes (map 35 54.10,83.10) via portal
    {
        fromPointID = 200408,
        fromMap = 232,
        fromX = 0.265,
        fromY = 0.243,
        toPointID = 200161,
        toMap = 35,
        toX = 0.541,
        toY = 0.831,
        type = "portal",
    },
    -- Molten Core (map 232 26.60,25.00) -> Blackrock Depths (map 243 68.80,38.20) via portal
    {
        fromPointID = 200409,
        fromMap = 232,
        fromX = 0.266,
        fromY = 0.25,
        toPointID = 200463,
        toMap = 243,
        toX = 0.688,
        toY = 0.382,
        type = "portal",
    },

    -- Zone: Molten Front (map 338)
    -- Molten Front (map 338 53.02,83.70) -> Mount Hyjal (map 198 27.46,55.94) via portal
    {
        fromPointID = 100410,
        fromMap = 338,
        fromX = 0.5302,
        fromY = 0.837,
        toPointID = 100323,
        toMap = 198,
        toX = 0.2746,
        toY = 0.5594,
        type = "portal",
    },

    -- Zone: Moonglade (map 80)
    -- Moonglade (map 80 68.14,60.28) -> Emerald Dreamway (map 715 26.31,77.76) via portal
    {
        fromPointID = 100238,
        fromMap = 80,
        fromX = 0.6814,
        fromY = 0.6028,
        toPointID = 700226,
        toMap = 715,
        toX = 0.2631,
        toY = 0.7776,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: Mount Hyjal (map 198)
    -- Mount Hyjal (map 198 27.48,56.37) -> Molten Front (map 338 51.74,84.42) via portal
    {
        fromPointID = 100324,
        fromMap = 198,
        fromX = 0.2748,
        fromY = 0.5637,
        toPointID = 100409,
        toMap = 338,
        toX = 0.5174,
        toY = 0.8442,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 29199,
                },
            },
        },
    },
    -- Mount Hyjal (map 198 47.43,78.00) -> Firelands (map 368 25.50,92.00) via portal
    {
        fromPointID = 100327,
        fromMap = 198,
        fromX = 0.4743,
        fromY = 0.78,
        toPointID = 100411,
        toMap = 368,
        toX = 0.255,
        toY = 0.92,
        type = "portal",
    },
    -- Mount Hyjal (map 198 59.09,26.09) -> Emerald Dreamway (map 715 51.59,51.89) via portal
    {
        fromPointID = 100328,
        fromMap = 198,
        fromX = 0.5909,
        fromY = 0.2609,
        toPointID = 700237,
        toMap = 715,
        toX = 0.5159,
        toY = 0.5189,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- Mount Hyjal (map 198 62.44,22.72) -> Amirdrassil (map 2239 54.92,63.88) via portal
    {
        fromPointID = 100331,
        fromMap = 198,
        fromX = 0.6244,
        fromY = 0.2272,
        toPointID = 1100226,
        toMap = 2239,
        toX = 0.5492,
        toY = 0.6388,
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
    },
    -- Mount Hyjal (map 198 62.62,23.12) -> Stormwind City (map 84 74.46,18.34) via portal
    {
        fromPointID = 100332,
        fromMap = 198,
        fromX = 0.6262,
        fromY = 0.2312,
        toPointID = 200318,
        toMap = 84,
        toX = 0.7446,
        toY = 0.1834,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 25316,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Mount Hyjal (map 198 63.48,24.43) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 100333,
        fromMap = 198,
        fromX = 0.6348,
        fromY = 0.2443,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 25316,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },

    -- Zone: Mulgore (map 7)
    -- Mulgore (map 7 36.85,35.86) -> Darkmoon Island (map 407 51.29,23.86) via portal
    {
        fromPointID = 100033,
        fromMap = 7,
        fromX = 0.3685,
        fromY = 0.3586,
        toPointID = 1300022,
        toMap = 407,
        toX = 0.5129,
        toY = 0.2386,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "DARKMOON FAIRE",
                },
            },
        },
    },

    -- Zone: Murder Row (map 2433)
    -- Murder Row (map 2433 0.00,0.00) -> Silvermoon City M (map 2393 57.20,61.06) via portal
    {
        fromPointID = 200715,
        fromMap = 2433,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200671,
        toMap = 2393,
        toX = 0.572,
        toY = 0.6106,
        type = "portal",
    },

    -- Zone: Mycomancer Cavern (map 2312)
    -- Mycomancer Cavern (map 2312 14.00,35.80) -> Hallowfall (map 2215 71.37,31.15) via portal
    {
        fromPointID = 1200100,
        fromMap = 2312,
        fromX = 0.14,
        fromY = 0.358,
        toPointID = 1200036,
        toMap = 2215,
        toX = 0.7137,
        toY = 0.3115,
        type = "portal",
    },

    -- Zone: Nagrand (map 107)
    -- Nagrand (map 107 41.27,59.04) -> Nagrand D (map 550 50.35,57.21) via portal
    {
        fromPointID = 300069,
        fromMap = 107,
        fromX = 0.4127,
        fromY = 0.5904,
        toPointID = 600108,
        toMap = 550,
        toX = 0.5035,
        toY = 0.5721,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Nagrand (map 107 60.36,25.56) -> Nagrand D (map 550 71.41,21.94) via portal
    {
        fromPointID = 300071,
        fromMap = 107,
        fromX = 0.6036,
        fromY = 0.2556,
        toPointID = 600113,
        toMap = 550,
        toX = 0.7141,
        toY = 0.2194,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Nagrand (map 550)
    -- Nagrand D (map 550 32.94,38.36) -> Highmaul (map 611 36.60,35.80) via portal
    {
        fromPointID = 600105,
        fromMap = 550,
        fromX = 0.3294,
        fromY = 0.3836,
        toPointID = 600132,
        toMap = 611,
        toX = 0.366,
        toY = 0.358,
        type = "portal",
    },
    -- Nagrand D (map 550 50.35,57.21) -> Nagrand (map 107 41.27,59.04) via portal
    {
        fromPointID = 600108,
        fromMap = 550,
        fromX = 0.5035,
        fromY = 0.5721,
        toPointID = 300069,
        toMap = 107,
        toX = 0.4127,
        toY = 0.5904,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Nagrand D (map 550 71.41,21.94) -> Nagrand (map 107 60.36,25.56) via portal
    {
        fromPointID = 600113,
        fromMap = 550,
        fromX = 0.7141,
        fromY = 0.2194,
        toPointID = 300071,
        toMap = 107,
        toX = 0.6036,
        toY = 0.2556,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Nagrand D (map 550 81.13,8.97) -> Zangarmarsh (map 102 49.19,55.37) via portal
    {
        fromPointID = 600116,
        fromMap = 550,
        fromX = 0.8113,
        fromY = 0.0897,
        toPointID = 300033,
        toMap = 102,
        toX = 0.4919,
        toY = 0.5537,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Nagrand D (map 550 88.36,22.84) -> Zangarmarsh (map 102 68.20,88.46) via portal
    {
        fromPointID = 600118,
        fromMap = 550,
        fromX = 0.8836,
        fromY = 0.2284,
        toPointID = 300042,
        toMap = 102,
        toX = 0.682,
        toY = 0.8846,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Naigtal (map 2600)
    -- Naigtal (map 2600 46.55,83.60) -> Voidstorm (map 2405 51.42,71.32) via portal
    {
        fromPointID = 200870,
        fromMap = 2600,
        fromX = 0.4655,
        fromY = 0.836,
        toPointID = 200689,
        toMap = 2405,
        toX = 0.5142,
        toY = 0.7132,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96052,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96052,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97072,
                        },
                    },
                },
            },
        },
    },
    -- Naigtal (map 2600 48.65,82.79) -> Voidstorm (map 2405 51.42,71.32) via portal
    {
        fromPointID = 200871,
        fromMap = 2600,
        fromX = 0.4865,
        fromY = 0.8279,
        toPointID = 200689,
        toMap = 2405,
        toX = 0.5142,
        toY = 0.7132,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97072,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97072,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Naxxramas (map 166)
    -- Naxxramas (map 166 54.10,49.80) -> Dragonblight (map 115 87.44,51.11) via portal
    {
        fromPointID = 400199,
        fromMap = 166,
        fromX = 0.541,
        fromY = 0.498,
        toPointID = 400033,
        toMap = 115,
        toX = 0.8744,
        toY = 0.5111,
        type = "portal",
    },

    -- Zone: Nazjatar (map 1355)
    -- Nazjatar (map 1355 39.97,52.58) -> Boralus (map 1161 69.95,15.77) via portal
    {
        fromPointID = 1300028,
        fromMap = 1355,
        fromX = 0.3997,
        fromY = 0.5258,
        toPointID = 800080,
        toMap = 1161,
        toX = 0.6995,
        toY = 0.1577,
        type = "portal",
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
                    value = 54972,
                },
            },
        },
    },
    -- Nazjatar (map 1355 47.27,62.78) -> Dazar'alor (map 1163 67.84,81.23) via portal
    {
        fromPointID = 1300029,
        fromMap = 1355,
        fromX = 0.4727,
        fromY = 0.6278,
        toPointID = 900073,
        toMap = 1163,
        toX = 0.6784,
        toY = 0.8123,
        type = "portal",
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
                    value = 55053,
                },
            },
        },
    },
    -- Nazjatar (map 1355 50.38,12.45) -> The Eternal Palace (map 1528 50.36,4.52) via portal
    {
        fromPointID = 1300031,
        fromMap = 1355,
        fromX = 0.5038,
        fromY = 0.1245,
        toPointID = 1300051,
        toMap = 1528,
        toX = 0.5036,
        toY = 0.0452,
        type = "portal",
    },

    -- Zone: Nazjatar (map 1528)
    -- The Eternal Palace (map 1528 47.34,31.90) -> The Eternal Palace (map 1512 0.00,0.00) via portal
    {
        fromPointID = 1300049,
        fromMap = 1528,
        fromX = 0.4734,
        fromY = 0.319,
        toPointID = 1300034,
        toMap = 1512,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- The Eternal Palace (map 1528 47.38,33.20) -> Nazjatar (map 1355 50.45,26.40) via portal
    {
        fromPointID = 1300050,
        fromMap = 1528,
        fromX = 0.4738,
        fromY = 0.332,
        toPointID = 1300032,
        toMap = 1355,
        toX = 0.5045,
        toY = 0.264,
        type = "portal",
    },

    -- Zone: Nazmir (map 863)
    -- Nazmir (map 863 51.38,64.83) -> The Underrot (map 1041 0.00,0.00) via portal
    {
        fromPointID = 900045,
        fromMap = 863,
        fromX = 0.5138,
        fromY = 0.6483,
        toPointID = 900070,
        toMap = 1041,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Nazmir (map 863 53.80,62.62) -> Uldir (map 1148 52.21,93.83) via portal
    {
        fromPointID = 900047,
        fromMap = 863,
        fromX = 0.538,
        fromY = 0.6262,
        toPointID = 900071,
        toMap = 1148,
        toX = 0.5221,
        toY = 0.9383,
        type = "portal",
    },

    -- Zone: Neltharion's Lair (map 731)
    -- Neltharion's Lair (map 731 96.35,40.19) -> Highmountain (map 650 49.56,68.66) via portal
    {
        fromPointID = 700251,
        fromMap = 731,
        fromX = 0.9635,
        fromY = 0.4019,
        toPointID = 700131,
        toMap = 650,
        toX = 0.4956,
        toY = 0.6866,
        type = "portal",
    },

    -- Zone: Neltharus (map 2080)
    -- Neltharus (map 2080 0.00,0.00) -> The Waking Shores (map 2022 25.36,56.75) via portal
    {
        fromPointID = 1100085,
        fromMap = 2080,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100003,
        toMap = 2022,
        toX = 0.2536,
        toY = 0.5675,
        type = "portal",
    },

    -- Zone: Nerub-ar Palace (map 2292)
    -- Nerub'ar Palace (map 2292 71.66,10.76) -> Nerub'ar (map 2213 34.78,72.83) via portal
    {
        fromPointID = 1200084,
        fromMap = 2292,
        fromX = 0.7166,
        fromY = 0.1076,
        toPointID = 1200001,
        toMap = 2213,
        toX = 0.3478,
        toY = 0.7283,
        type = "portal",
    },

    -- Zone: Netherlight Temple (map 702)
    -- Netherlight Temple (map 702 49.75,80.72) -> Dalaran L (map 627 38.73,57.39) via portal
    {
        fromPointID = 700216,
        fromMap = 702,
        fromX = 0.4975,
        fromY = 0.8072,
        toPointID = 700007,
        toMap = 627,
        toX = 0.3873,
        toY = 0.5739,
        type = "portal",
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
                    value = 40938,
                },
            },
        },
    },
    -- Netherlight Temple (map 702 49.75,80.72) -> Dalaran L (map 627 61.65,17.39) via portal
    {
        fromPointID = 700216,
        fromMap = 702,
        fromX = 0.4975,
        fromY = 0.8072,
        toPointID = 700023,
        toMap = 627,
        toX = 0.6165,
        toY = 0.1739,
        type = "portal",
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
                    value = 40938,
                },
            },
        },
    },

    -- Zone: Netherstorm (map 109)
    -- Netherstorm (map 109 70.62,69.78) -> The Mechanar (map 267 49.41,83.51) via portal
    {
        fromPointID = 300096,
        fromMap = 109,
        fromX = 0.7062,
        fromY = 0.6978,
        toPointID = 300134,
        toMap = 267,
        toX = 0.4941,
        toY = 0.8351,
        type = "portal",
    },
    -- Netherstorm (map 109 71.76,54.93) -> The Botanica (map 266 89.59,41.09) via portal
    {
        fromPointID = 300097,
        fromMap = 109,
        fromX = 0.7176,
        fromY = 0.5493,
        toPointID = 300132,
        toMap = 266,
        toX = 0.8959,
        toY = 0.4109,
        type = "portal",
    },
    -- Netherstorm (map 109 73.56,63.71) -> Tempest Keep (map 334 50.06,91.93) via portal
    {
        fromPointID = 300098,
        fromMap = 109,
        fromX = 0.7356,
        fromY = 0.6371,
        toPointID = 300146,
        toMap = 334,
        toX = 0.5006,
        toY = 0.9193,
        type = "portal",
    },
    -- Netherstorm (map 109 74.49,57.68) -> The Arcatraz (map 269 41.26,81.70) via portal
    {
        fromPointID = 300099,
        fromMap = 109,
        fromX = 0.7449,
        fromY = 0.5768,
        toPointID = 300137,
        toMap = 269,
        toX = 0.4126,
        toY = 0.817,
        type = "portal",
    },

    -- Zone: New Tinkertown (map 30)
    -- Dun Morogh (map 30 30.00,74.70) -> Gnomeregan (map 228 64.33,28.96) via portal
    {
        fromPointID = 200135,
        fromMap = 30,
        fromX = 0.3,
        fromY = 0.747,
        toPointID = 200403,
        toMap = 228,
        toX = 0.6433,
        toY = 0.2896,
        type = "portal",
    },

    -- Zone: Nexus Point Xenas (map 2556)
    -- Nexus Point Xenas (map 2556 0.00,0.00) -> Voidstorm (map 2405 64.93,61.78) via portal
    {
        fromPointID = 200832,
        fromMap = 2556,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200694,
        toMap = 2405,
        toX = 0.6493,
        toY = 0.6178,
        type = "portal",
    },

    -- Zone: Nightfall Sanctum (map 2277)
    -- Nightfall Sanctum (map 2277 80.80,16.25) -> Hallowfall (map 2215 34.28,47.31) via portal
    {
        fromPointID = 1200079,
        fromMap = 2277,
        fromX = 0.808,
        fromY = 0.1625,
        toPointID = 1200025,
        toMap = 2215,
        toX = 0.3428,
        toY = 0.4731,
        type = "portal",
    },

    -- Zone: Northern Stranglethorn (map 50)
    -- Northern Stranglethorn (map 50 37.54,50.99) -> Tirisfal Glades (map 18 69.30,62.75) via portal
    {
        fromPointID = 200224,
        fromMap = 50,
        fromX = 0.3754,
        fromY = 0.5099,
        toPointID = 200051,
        toMap = 18,
        toX = 0.693,
        toY = 0.6275,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "phase",
                                    value = "Old Undercity",
                                },
                            },
                        },
                        {
                            operation = "check",
                            kind = "phase",
                            value = "UndercityCharred",
                        },
                        {
                            operation = "check",
                            kind = "phase",
                            value = "UndercityOoze",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Northern Stranglethorn (map 50 37.54,50.99) -> Undercity (map 90 84.58,16.33) via portal
    {
        fromPointID = 200224,
        fromMap = 50,
        fromX = 0.3754,
        fromY = 0.5099,
        toPointID = 200331,
        toMap = 90,
        toX = 0.8458,
        toY = 0.1633,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Northern Stranglethorn (map 50 72.18,32.91) -> Zul'Gurub (map 337 30.23,48.85) via portal
    {
        fromPointID = 200229,
        fromMap = 50,
        fromX = 0.7218,
        fromY = 0.3291,
        toPointID = 200558,
        toMap = 337,
        toX = 0.3023,
        toY = 0.4885,
        type = "portal",
    },
    -- Northern Stranglethorn (map 50 79.69,77.68) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 200231,
        fromMap = 50,
        fromX = 0.7969,
        fromY = 0.7768,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Northern Stranglethorn (map 50 79.69,77.68) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 200231,
        fromMap = 50,
        fromX = 0.7969,
        fromY = 0.7768,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },

    -- Zone: Ny'alotha (map 1580)
    -- Ny'alotha, the Waking City (map 1580 0.00,0.00) -> Uldum New (map 1527 55.17,43.93) via portal
    {
        fromPointID = 1300052,
        fromMap = 1580,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100468,
        toMap = 1527,
        toX = 0.5517,
        toY = 0.4393,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "UldumInvasionCenter",
                },
            },
        },
    },
    -- Ny'alotha, the Waking City (map 1580 0.00,0.00) -> Vale of Eternal Blossoms New (map 1530 40.08,45.52) via portal
    {
        fromPointID = 1300052,
        fromMap = 1580,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 500285,
        toMap = 1530,
        toX = 0.4008,
        toY = 0.4552,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "ValeInvasionRight",
                },
            },
        },
    },

    -- Zone: Ohn'ahran Plains (map 2023)
    -- Ohn'ahran Plains (map 2023 18.37,52.37) -> The Emerald Dream (map 2200 73.05,52.52) via portal
    {
        fromPointID = 1100015,
        fromMap = 2023,
        fromX = 0.1837,
        fromY = 0.5237,
        toPointID = 1100204,
        toMap = 2200,
        toX = 0.7305,
        toY = 0.5252,
        type = "portal",
    },
    -- Ohn'ahran Plains (map 2023 60.84,38.96) -> The Nokhud Offensive (map 2093 0.00,0.00) via portal
    {
        fromPointID = 1100029,
        fromMap = 2023,
        fromX = 0.6084,
        fromY = 0.3896,
        toPointID = 1100091,
        toMap = 2093,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Old Hillsbrad Foothills (map 274)
    -- Old Hillsbrad Foothills (map 274 23.23,24.80) -> Tanaris (map 75 26.90,35.90) via portal
    {
        fromPointID = 100376,
        fromMap = 274,
        fromX = 0.2323,
        fromY = 0.248,
        toPointID = 100207,
        toMap = 75,
        toX = 0.269,
        toY = 0.359,
        type = "portal",
    },

    -- Zone: Onyxia's Lair (map 248)
    -- Onyxia's Lair (map 248 34.00,21.00) -> Dustwallow Marsh (map 70 52.89,77.46) via portal
    {
        fromPointID = 100367,
        fromMap = 248,
        fromX = 0.34,
        fromY = 0.21,
        toPointID = 100176,
        toMap = 70,
        toX = 0.5289,
        toY = 0.7746,
        type = "portal",
    },

    -- Zone: Operation: Floodgate (map 2387)
    -- Operation: Floodgate (map 2387 42.25,11.73) -> The Ringing Deeps (map 2214 42.02,39.39) via portal
    {
        fromPointID = 1200169,
        fromMap = 2387,
        fromX = 0.4225,
        fromY = 0.1173,
        toPointID = 1200011,
        toMap = 2214,
        toX = 0.4202,
        toY = 0.3939,
        type = "portal",
    },

    -- Zone: Orgrimmar (map 85)
    -- Orgrimmar (map 85 38.15,75.28) -> Thunder Totem (map 652 44.18,64.07) via portal
    {
        fromPointID = 100254,
        fromMap = 85,
        fromX = 0.3815,
        fromY = 0.7528,
        toPointID = 700135,
        toMap = 652,
        toX = 0.4418,
        toY = 0.6407,
        type = "portal",
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
                    kind = "race",
                    value = "HighmountainTauren",
                },
            },
        },
    },
    -- Orgrimmar (map 85 38.59,75.89) -> Suramar (map 680 59.55,85.29) via portal
    {
        fromPointID = 100255,
        fromMap = 85,
        fromX = 0.3859,
        fromY = 0.7589,
        toPointID = 700194,
        toMap = 680,
        toX = 0.5955,
        toY = 0.8529,
        type = "portal",
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
                    kind = "race",
                    value = "Nightborne",
                },
            },
        },
    },
    -- Orgrimmar (map 85 47.40,39.27) -> Tol Barad Peninsula (map 245 55.78,80.06) via portal
    {
        fromPointID = 100260,
        fromMap = 85,
        fromX = 0.474,
        fromY = 0.3927,
        toPointID = 200466,
        toMap = 245,
        toX = 0.5578,
        toY = 0.8006,
        type = "portal",
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
                    kind = "minLevel",
                    value = 30,
                },
            },
        },
    },
    -- Orgrimmar (map 85 48.23,62.17) -> Mulgore (map 7 36.49,35.11) via portal
    {
        fromPointID = 100261,
        fromMap = 85,
        fromX = 0.4823,
        fromY = 0.6217,
        toPointID = 100032,
        toMap = 7,
        toX = 0.3649,
        toY = 0.3511,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "DARKMOON FAIRE",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 48.87,38.55) -> Uldum New (map 1527 54.90,34.25) via portal
    {
        fromPointID = 100262,
        fromMap = 85,
        fromX = 0.4887,
        fromY = 0.3855,
        toPointID = 100467,
        toMap = 1527,
        toX = 0.549,
        toY = 0.3425,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
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
                        {
                            operation = "check",
                            kind = "maxLevelExclusive",
                            value = 10,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 48.87,38.55) -> Uldum (map 249 54.90,34.25) via portal
    {
        fromPointID = 100262,
        fromMap = 85,
        fromX = 0.4887,
        fromY = 0.3855,
        toPointID = 100369,
        toMap = 249,
        toX = 0.549,
        toY = 0.3425,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 28112,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 49.23,36.52) -> Kelp'thar Forest (map 201 45.14,23.33) via portal
    {
        fromPointID = 100263,
        fromMap = 85,
        fromX = 0.4923,
        fromY = 0.3652,
        toPointID = 200357,
        toMap = 201,
        toX = 0.4514,
        toY = 0.2333,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 25222,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 25924,
                },
            },
        },
    },
    -- Orgrimmar (map 85 49.23,36.52) -> Shimmering Expanse (map 205 49.50,40.50) via portal
    {
        fromPointID = 100263,
        fromMap = 85,
        fromX = 0.4923,
        fromY = 0.3652,
        toPointID = 200374,
        toMap = 205,
        toX = 0.495,
        toY = 0.405,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 26784,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 25222,
                },
            },
        },
    },
    -- Orgrimmar (map 85 49.23,36.52) -> Abyssal Depths (map 204 51.40,61.01) via portal
    {
        fromPointID = 100263,
        fromMap = 85,
        fromX = 0.4923,
        fromY = 0.3652,
        toPointID = 200362,
        toMap = 204,
        toX = 0.514,
        toY = 0.6101,
        type = "portal",
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
                    value = 26784,
                },
            },
        },
    },
    -- Orgrimmar (map 85 50.22,39.44) -> Twilight Highlands (map 241 73.63,53.39) via portal
    {
        fromPointID = 100267,
        fromMap = 85,
        fromX = 0.5022,
        fromY = 0.3944,
        toPointID = 200425,
        toMap = 241,
        toX = 0.7363,
        toY = 0.5339,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 26784,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 50.74,55.57) -> Undercity (map 90 84.58,16.33) via portal
    {
        fromPointID = 100268,
        fromMap = 85,
        fromX = 0.5074,
        fromY = 0.5557,
        toPointID = 200331,
        toMap = 90,
        toX = 0.8458,
        toY = 0.1633,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Orgrimmar (map 85 50.74,55.57) -> Tirisfal Glades L (map 2070 69.30,62.75) via portal
    {
        fromPointID = 100268,
        fromMap = 85,
        fromX = 0.5074,
        fromY = 0.5557,
        toPointID = 200638,
        toMap = 2070,
        toX = 0.693,
        toY = 0.6275,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },
    -- Orgrimmar (map 85 50.74,55.57) -> Tirisfal Glades L (map 2070 69.30,62.75) via portal
    {
        fromPointID = 100268,
        fromMap = 85,
        fromX = 0.5074,
        fromY = 0.5557,
        toPointID = 200638,
        toMap = 2070,
        toX = 0.693,
        toY = 0.6275,
        type = "portal",
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
            },
        },
    },
    -- Orgrimmar (map 85 50.84,36.29) -> Deepholm (map 207 50.59,52.94) via portal
    {
        fromPointID = 100269,
        fromMap = 85,
        fromX = 0.5084,
        fromY = 0.3629,
        toPointID = 1300015,
        toMap = 207,
        toX = 0.5059,
        toY = 0.5294,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 27123,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 51.13,38.28) -> Mount Hyjal (map 198 63.49,23.37) via portal
    {
        fromPointID = 100270,
        fromMap = 85,
        fromX = 0.5113,
        fromY = 0.3828,
        toPointID = 100334,
        toMap = 198,
        toX = 0.6349,
        toY = 0.2337,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 25316,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 54.57,90.36) -> Silvermoon City (map 110 58.26,19.24) via portal
    {
        fromPointID = 100272,
        fromMap = 85,
        fromX = 0.5457,
        fromY = 0.9036,
        toPointID = 200341,
        toMap = 110,
        toX = 0.5826,
        toY = 0.1924,
        type = "portal",
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
    -- Orgrimmar (map 85 55.18,92.05) -> Warspear (map 624 44.42,35.53) via portal
    {
        fromPointID = 100273,
        fromMap = 85,
        fromX = 0.5518,
        fromY = 0.9205,
        toPointID = 600138,
        toMap = 624,
        toX = 0.4442,
        toY = 0.3553,
        type = "portal",
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
    -- Orgrimmar (map 85 55.98,88.20) -> Silvermoon City M (map 2393 52.85,65.51) via portal
    {
        fromPointID = 100275,
        fromMap = 85,
        fromX = 0.5598,
        fromY = 0.882,
        toPointID = 200667,
        toMap = 2393,
        toX = 0.5285,
        toY = 0.6551,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86852,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 56.23,91.74) -> Dalaran (map 125 55.92,46.79) via portal
    {
        fromPointID = 100276,
        fromMap = 85,
        fromX = 0.5623,
        fromY = 0.9174,
        toPointID = 400120,
        toMap = 125,
        toX = 0.5592,
        toY = 0.4679,
        type = "portal",
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
    -- Orgrimmar (map 85 56.40,92.56) -> Tanaris (map 74 54.60,28.30) via portal
    {
        fromPointID = 100277,
        fromMap = 85,
        fromX = 0.564,
        fromY = 0.9256,
        toPointID = 100203,
        toMap = 74,
        toX = 0.546,
        toY = 0.283,
        type = "portal",
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
    -- Orgrimmar (map 85 57.11,87.30) -> Valdrakken (map 2112 59.55,41.46) via portal
    {
        fromPointID = 100279,
        fromMap = 85,
        fromX = 0.5711,
        fromY = 0.873,
        toPointID = 1100113,
        toMap = 2112,
        toX = 0.5955,
        toY = 0.4146,
        type = "portal",
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
                    value = 67030,
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.16,90.71) -> Blasted Lands (map 17 55.00,50.00) via portal
    {
        fromPointID = 100280,
        fromMap = 85,
        fromX = 0.5716,
        fromY = 0.9071,
        toPointID = 200036,
        toMap = 17,
        toX = 0.55,
        toY = 0.5,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 60123,
                                },
                            },
                        },
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "chromieTime",
                                    value = 6,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.16,90.71) -> Hellfire Peninsula (map 100 89.39,50.22) via portal
    {
        fromPointID = 100280,
        fromMap = 85,
        fromX = 0.5716,
        fromY = 0.9071,
        toPointID = 300024,
        toMap = 100,
        toX = 0.8939,
        toY = 0.5022,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60123,
                        },
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "chromieTime",
                                    value = 6,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.23,88.21) -> Azsuna (map 630 47.00,40.89) via portal
    {
        fromPointID = 100281,
        fromMap = 85,
        fromX = 0.5723,
        fromY = 0.8821,
        toPointID = 700048,
        toMap = 630,
        toX = 0.47,
        toY = 0.4089,
        type = "portal",
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
    -- Orgrimmar (map 85 57.46,92.28) -> The Jade Forest (map 371 28.56,13.98) via portal
    {
        fromPointID = 100282,
        fromMap = 85,
        fromX = 0.5746,
        fromY = 0.9228,
        toPointID = 500003,
        toMap = 371,
        toX = 0.2856,
        toY = 0.1398,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 31769,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 40,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.51,91.65) -> Shattrath City (map 111 53.01,49.21) via portal
    {
        fromPointID = 100283,
        fromMap = 85,
        fromX = 0.5751,
        fromY = 0.9165,
        toPointID = 300103,
        toMap = 111,
        toX = 0.5301,
        toY = 0.4921,
        type = "portal",
        travelDuration = 999,
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
                    kind = "maxLevelExclusive",
                    value = 10,
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.51,91.65) -> Shattrath City (map 111 53.01,49.21) via portal
    {
        fromPointID = 100283,
        fromMap = 85,
        fromX = 0.5751,
        fromY = 0.9165,
        toPointID = 300103,
        toMap = 111,
        toX = 0.5301,
        toY = 0.4921,
        type = "portal",
        travelDuration = 30,
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
                    kind = "minLevel",
                    value = 10,
                },
            },
        },
    },
    -- Orgrimmar (map 85 57.89,89.84) -> Dazar'alor (map 1163 71.96,82.78) via portal
    {
        fromPointID = 100284,
        fromMap = 85,
        fromX = 0.5789,
        fromY = 0.8984,
        toPointID = 900075,
        toMap = 1163,
        toX = 0.7196,
        toY = 0.8278,
        type = "portal",
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
    -- Orgrimmar (map 85 58.32,87.85) -> Oribos (map 1670 20.34,50.31) via portal
    {
        fromPointID = 100285,
        fromMap = 85,
        fromX = 0.5832,
        fromY = 0.8785,
        toPointID = 1000165,
        toMap = 1670,
        toX = 0.2034,
        toY = 0.5031,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60151,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 58.58,91.36) -> Dornogal (map 2339 41.29,27.45) via portal
    {
        fromPointID = 100286,
        fromMap = 85,
        fromX = 0.5858,
        fromY = 0.9136,
        toPointID = 1200125,
        toMap = 2339,
        toX = 0.4129,
        toY = 0.2745,
        type = "portal",
        travelDuration = 30,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 80321,
                                },
                            },
                        },
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 79573,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Orgrimmar (map 85 58.98,89.53) -> Razorwind Shores (map 2351 54.31,49.32) via portal
    {
        fromPointID = 100287,
        fromMap = 85,
        fromX = 0.5898,
        fromY = 0.8953,
        toPointID = 100487,
        toMap = 2351,
        toX = 0.5431,
        toY = 0.4932,
        type = "portal",
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
    -- Orgrimmar (map 85 70.57,30.92) -> Brawl'gar Arena (map 503 55.53,14.28) via portal
    {
        fromPointID = 100288,
        fromMap = 85,
        fromX = 0.7057,
        fromY = 0.3092,
        toPointID = 100449,
        toMap = 503,
        toX = 0.5553,
        toY = 0.1428,
        type = "portal",
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

    -- Zone: Orgrimmar (map 86)
    -- Orgrimmar (map 86 70.33,48.92) -> Ragefire Chasm (map 213 0.00,0.00) via portal
    {
        fromPointID = 100291,
        fromMap = 86,
        fromX = 0.7033,
        fromY = 0.4892,
        toPointID = 100342,
        toMap = 213,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Oribos (map 1670)
    -- Oribos (map 1670 20.85,54.77) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 1000167,
        fromMap = 1670,
        fromX = 0.2085,
        fromY = 0.5477,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60151,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Oribos (map 1670 20.86,45.67) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 1000168,
        fromMap = 1670,
        fromX = 0.2086,
        fromY = 0.4567,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60151,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Oribos (map 1670 47.02,50.34) -> Oribos (map 1671 43.38,51.56) via portal
    {
        fromPointID = 1000170,
        fromMap = 1670,
        fromX = 0.4702,
        fromY = 0.5034,
        toPointID = 1000181,
        toMap = 1671,
        toX = 0.4338,
        toY = 0.5156,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1670 52.08,57.92) -> Oribos (map 1671 49.52,60.92) via portal
    {
        fromPointID = 1000173,
        fromMap = 1670,
        fromX = 0.5208,
        fromY = 0.5792,
        toPointID = 1000186,
        toMap = 1671,
        toX = 0.4952,
        toY = 0.6092,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1670 52.10,42.74) -> Oribos (map 1671 49.38,42.00) via portal
    {
        fromPointID = 1000175,
        fromMap = 1670,
        fromX = 0.521,
        fromY = 0.4274,
        toPointID = 1000185,
        toMap = 1671,
        toX = 0.4938,
        toY = 0.42,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1670 57.14,50.36) -> Oribos (map 1671 55.66,51.62) via portal
    {
        fromPointID = 1000176,
        fromMap = 1670,
        fromX = 0.5714,
        fromY = 0.5036,
        toPointID = 1000191,
        toMap = 1671,
        toX = 0.5566,
        toY = 0.5162,
        type = "portal",
        travelDuration = 1,
    },

    -- Zone: Oribos (map 1671)
    -- Oribos (map 1671 29.16,20.89) -> Korthia (map 1961 64.38,24.11) via portal
    {
        fromPointID = 1000179,
        fromMap = 1671,
        fromX = 0.2916,
        fromY = 0.2089,
        toPointID = 1000320,
        toMap = 1961,
        toX = 0.6438,
        toY = 0.2411,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 63855,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63665,
                },
            },
        },
    },
    -- Oribos (map 1671 43.44,51.57) -> Oribos (map 1670 47.12,50.30) via portal
    {
        fromPointID = 1000182,
        fromMap = 1671,
        fromX = 0.4344,
        fromY = 0.5157,
        toPointID = 1000171,
        toMap = 1670,
        toX = 0.4712,
        toY = 0.503,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1671 49.27,50.88) -> The Maw (map 1543 44.95,40.99) via portal
    {
        fromPointID = 1000184,
        fromMap = 1671,
        fromX = 0.4927,
        fromY = 0.5088,
        toPointID = 1000114,
        toMap = 1543,
        toX = 0.4495,
        toY = 0.4099,
        type = "portal",
        travelDuration = 15,
    },
    -- Oribos (map 1671 49.55,60.85) -> Oribos (map 1670 52.07,57.86) via portal
    {
        fromPointID = 1000188,
        fromMap = 1671,
        fromX = 0.4955,
        fromY = 0.6085,
        toPointID = 1000172,
        toMap = 1670,
        toX = 0.5207,
        toY = 0.5786,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1671 49.56,42.35) -> Oribos (map 1670 52.10,42.44) via portal
    {
        fromPointID = 1000189,
        fromMap = 1671,
        fromX = 0.4956,
        fromY = 0.4235,
        toPointID = 1000174,
        toMap = 1670,
        toX = 0.521,
        toY = 0.4244,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1671 49.59,25.44) -> Zereth Mortis (map 1970 33.27,69.43) via portal
    {
        fromPointID = 1000190,
        fromMap = 1671,
        fromX = 0.4959,
        fromY = 0.2544,
        toPointID = 1000323,
        toMap = 1970,
        toX = 0.3327,
        toY = 0.6943,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 64957,
                },
            },
        },
    },
    -- Oribos (map 1671 55.68,51.59) -> Oribos (map 1670 57.14,50.36) via portal
    {
        fromPointID = 1000192,
        fromMap = 1671,
        fromX = 0.5568,
        fromY = 0.5159,
        toPointID = 1000176,
        toMap = 1670,
        toX = 0.5714,
        toY = 0.5036,
        type = "portal",
        travelDuration = 1,
    },
    -- Oribos (map 1671 60.86,68.36) -> Revendreth (map 1525 70.00,84.00) via portal
    {
        fromPointID = 1000193,
        fromMap = 1671,
        fromX = 0.6086,
        fromY = 0.6836,
        toPointID = 1000024,
        toMap = 1525,
        toX = 0.7,
        toY = 0.84,
        type = "portal",
        travelDuration = 53,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 13878,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57025,
                },
            },
        },
    },
    -- Oribos (map 1671 60.86,68.36) -> Ardenweald (map 1565 68.00,18.00) via portal
    {
        fromPointID = 1000193,
        fromMap = 1671,
        fromX = 0.6086,
        fromY = 0.6836,
        toPointID = 1000145,
        toMap = 1565,
        toX = 0.68,
        toY = 0.18,
        type = "portal",
        travelDuration = 53,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 14164,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60338,
                },
            },
        },
    },
    -- Oribos (map 1671 60.86,68.36) -> Maldraxxus (map 1536 50.00,41.00) via portal
    {
        fromPointID = 1000193,
        fromMap = 1671,
        fromX = 0.6086,
        fromY = 0.6836,
        toPointID = 1000072,
        toMap = 1536,
        toX = 0.5,
        toY = 0.41,
        type = "portal",
        travelDuration = 53,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 14206,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57386,
                },
            },
        },
    },
    -- Oribos (map 1671 60.86,68.36) -> Bastion (map 1533 37.85,76.52) via portal
    {
        fromPointID = 1000193,
        fromMap = 1671,
        fromX = 0.6086,
        fromY = 0.6836,
        toPointID = 1000031,
        toMap = 1533,
        toX = 0.3785,
        toY = 0.7652,
        type = "portal",
        travelDuration = 53,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 14281,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60156,
                },
            },
        },
    },

    -- Zone: Parhelion Plaza (map 2545)
    -- Parhelion Plaza (map 2545 82.63,34.13) -> Isle of Quel Danas M (map 2424 46.38,40.62) via portal
    {
        fromPointID = 200831,
        fromMap = 2545,
        fromX = 0.8263,
        fromY = 0.3413,
        toPointID = 200709,
        toMap = 2424,
        toX = 0.4638,
        toY = 0.4062,
        type = "portal",
    },

    -- Zone: Pit of Saron (map 184)
    -- Pit of Saron (map 184 32.30,6.81) -> Halls of Reflection (map 185 47.33,80.81) via portal
    {
        fromPointID = 400212,
        fromMap = 184,
        fromX = 0.323,
        fromY = 0.0681,
        toPointID = 400214,
        toMap = 185,
        toX = 0.4733,
        toY = 0.8081,
        type = "portal",
    },
    -- Pit of Saron (map 184 40.91,80.52) -> Icecrown (map 118 54.78,91.80) via portal
    {
        fromPointID = 400213,
        fromMap = 184,
        fromX = 0.4091,
        fromY = 0.8052,
        toPointID = 400071,
        toMap = 118,
        toX = 0.5478,
        toY = 0.918,
        type = "portal",
    },

    -- Zone: Plaguefall (map 1674)
    -- Plaguefall (map 1674 0.00,0.00) -> Maldraxxus (map 1536 59.60,65.31) via portal
    {
        fromPointID = 1000196,
        fromMap = 1674,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000082,
        toMap = 1536,
        toX = 0.596,
        toY = 0.6531,
        type = "portal",
    },

    -- Zone: Player House (map 8001)
    -- Player House (map 8001 1.00,1.00) -> Founder's Point (map 2352 57.43,26.62) via portal
    {
        fromPointID = 1300086,
        fromMap = 8001,
        fromX = 0.01,
        fromY = 0.01,
        toPointID = 200651,
        toMap = 2352,
        toX = 0.5743,
        toY = 0.2662,
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
    },
    -- Player House (map 8001 1.00,1.00) -> Razorwind Shores (map 2351 54.31,49.32) via portal
    {
        fromPointID = 1300086,
        fromMap = 8001,
        fromX = 0.01,
        fromY = 0.01,
        toPointID = 100487,
        toMap = 2351,
        toX = 0.5431,
        toY = 0.4932,
        type = "portal",
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

    -- Zone: Priory of the Sacred Flame (map 2308)
    -- Priory of the Sacred Flame (map 2308 80.99,47.60) -> Hallowfall (map 2215 41.36,49.26) via portal
    {
        fromPointID = 1200097,
        fromMap = 2308,
        fromX = 0.8099,
        fromY = 0.476,
        toPointID = 1200028,
        toMap = 2215,
        toX = 0.4136,
        toY = 0.4926,
        type = "portal",
    },

    -- Zone: Queen's Conservatory (map 1662)
    -- Queen's Conservatory (map 1662 73.47,48.05) -> Heart of the Forest (map 1702 57.33,65.57) via portal
    {
        fromPointID = 1000152,
        fromMap = 1662,
        fromX = 0.7347,
        fromY = 0.4805,
        toPointID = 1000257,
        toMap = 1702,
        toX = 0.5733,
        toY = 0.6557,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63046,
                },
            },
        },
    },

    -- Zone: Ragefire Chasm (map 213)
    -- Ragefire Chasm (map 213 0.00,0.00) -> Orgrimmar (map 86 70.33,48.92) via portal
    {
        fromPointID = 100342,
        fromMap = 213,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100291,
        toMap = 86,
        toX = 0.7033,
        toY = 0.4892,
        type = "portal",
    },

    -- Zone: Razorfen Downs (map 300)
    -- Razorfen Downs (map 300 0.00,0.00) -> Thousand Needles (map 64 47.65,23.65) via portal
    {
        fromPointID = 100393,
        fromMap = 300,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100122,
        toMap = 64,
        toX = 0.4765,
        toY = 0.2365,
        type = "portal",
    },

    -- Zone: Razorfen Kraul (map 301)
    -- Razorfen Kraul (map 301 69.89,82.97) -> Southern Barrens (map 199 40.72,94.39) via portal
    {
        fromPointID = 100394,
        fromMap = 301,
        fromX = 0.6989,
        fromY = 0.8297,
        toPointID = 100339,
        toMap = 199,
        toX = 0.4072,
        toY = 0.9439,
        type = "portal",
    },

    -- Zone: Razorwind Shores (map 2351)
    -- Razorwind Shores (map 2351 53.92,49.37) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 100486,
        fromMap = 2351,
        fromX = 0.5392,
        fromY = 0.4937,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
    -- Razorwind Shores (map 2351 54.31,49.32) -> Player House (map 8001 1.00,1.00) via portal
    {
        fromPointID = 100487,
        fromMap = 2351,
        fromX = 0.5431,
        fromY = 0.4932,
        toPointID = 1300086,
        toMap = 8001,
        toX = 0.01,
        toY = 0.01,
        type = "portal",
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

    -- Zone: Revendreth (map 1525)
    -- Revendreth (map 1525 24.84,50.28) -> Revendreth (map 1525 31.98,46.70) via portal
    {
        fromPointID = 1000001,
        fromMap = 1525,
        fromX = 0.2484,
        fromY = 0.5028,
        toPointID = 1000009,
        toMap = 1525,
        toX = 0.3198,
        toY = 0.467,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57536,
                },
            },
        },
    },
    -- Revendreth (map 1525 25.47,26.83) -> Sinfall (map 1700 81.05,48.97) via portal
    {
        fromPointID = 1000002,
        fromMap = 1525,
        fromX = 0.2547,
        fromY = 0.2683,
        toPointID = 1000250,
        toMap = 1700,
        toX = 0.8105,
        toY = 0.4897,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60164,
                },
            },
        },
    },
    -- Revendreth (map 1525 27.93,43.05) -> Ember Court (map 1644 33.76,47.29) via portal
    {
        fromPointID = 1000004,
        fromMap = 1525,
        fromX = 0.2793,
        fromY = 0.4305,
        toPointID = 1000149,
        toMap = 1644,
        toX = 0.3376,
        toY = 0.4729,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
            },
        },
    },
    -- Revendreth (map 1525 29.35,42.67) -> Sinfall (map 1699 23.65,57.06) via portal
    {
        fromPointID = 1000005,
        fromMap = 1525,
        fromX = 0.2935,
        fromY = 0.4267,
        toPointID = 1000235,
        toMap = 1699,
        toX = 0.2365,
        toY = 0.5706,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 59327,
                },
            },
        },
    },
    -- Revendreth (map 1525 31.98,46.70) -> Revendreth (map 1525 24.84,50.28) via portal
    {
        fromPointID = 1000009,
        fromMap = 1525,
        fromX = 0.3198,
        fromY = 0.467,
        toPointID = 1000001,
        toMap = 1525,
        toX = 0.2484,
        toY = 0.5028,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57536,
                },
            },
        },
    },
    -- Revendreth (map 1525 43.48,57.07) -> Sinfall (map 1700 58.26,36.49) via portal
    {
        fromPointID = 1000011,
        fromMap = 1525,
        fromX = 0.4348,
        fromY = 0.5707,
        toPointID = 1000244,
        toMap = 1700,
        toX = 0.5826,
        toY = 0.3649,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60160,
                },
            },
        },
    },
    -- Revendreth (map 1525 46.37,41.50) -> Castle Nathria (map 1735 0.00,0.00) via portal
    {
        fromPointID = 1000012,
        fromMap = 1525,
        fromX = 0.4637,
        fromY = 0.415,
        toPointID = 1000276,
        toMap = 1735,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Revendreth (map 1525 51.07,30.22) -> Sanguine Depths (map 1675 0.00,0.00) via portal
    {
        fromPointID = 1000014,
        fromMap = 1525,
        fromX = 0.5107,
        fromY = 0.3022,
        toPointID = 1000198,
        toMap = 1675,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Revendreth (map 1525 56.74,32.46) -> Sinfall (map 1699 46.08,49.50) via portal
    {
        fromPointID = 1000016,
        fromMap = 1525,
        fromX = 0.5674,
        fromY = 0.3246,
        toPointID = 1000242,
        toMap = 1699,
        toX = 0.4608,
        toY = 0.495,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60147,
                },
            },
        },
    },
    -- Revendreth (map 1525 57.38,28.67) -> Revendreth (map 1525 58.91,30.34) via portal
    {
        fromPointID = 1000017,
        fromMap = 1525,
        fromX = 0.5738,
        fromY = 0.2867,
        toPointID = 1000021,
        toMap = 1525,
        toX = 0.5891,
        toY = 0.3034,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57885,
                },
            },
        },
    },
    -- Revendreth (map 1525 58.24,62.72) -> Sinfall (map 1700 71.85,19.77) via portal
    {
        fromPointID = 1000019,
        fromMap = 1525,
        fromX = 0.5824,
        fromY = 0.6272,
        toPointID = 1000249,
        toMap = 1700,
        toX = 0.7185,
        toY = 0.1977,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60165,
                },
            },
        },
    },
    -- Revendreth (map 1525 58.73,30.29) -> Revendreth (map 1525 57.42,28.60) via portal
    {
        fromPointID = 1000020,
        fromMap = 1525,
        fromX = 0.5873,
        fromY = 0.3029,
        toPointID = 1000018,
        toMap = 1525,
        toX = 0.5742,
        toY = 0.286,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57885,
                },
            },
        },
    },
    -- Revendreth (map 1525 70.76,75.48) -> Sinfall (map 1699 42.12,36.22) via portal
    {
        fromPointID = 1000026,
        fromMap = 1525,
        fromX = 0.7076,
        fromY = 0.7548,
        toPointID = 1000241,
        toMap = 1699,
        toX = 0.4212,
        toY = 0.3622,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60060,
                },
            },
        },
    },
    -- Revendreth (map 1525 73.61,43.94) -> Sinfall (map 1700 63.57,53.53) via portal
    {
        fromPointID = 1000028,
        fromMap = 1525,
        fromX = 0.7361,
        fromY = 0.4394,
        toPointID = 1000245,
        toMap = 1700,
        toX = 0.6357,
        toY = 0.5353,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60159,
                },
            },
        },
    },
    -- Revendreth (map 1525 78.58,49.22) -> Halls of Atonement (map 1663 0.00,0.00) via portal
    {
        fromPointID = 1000029,
        fromMap = 1525,
        fromX = 0.7858,
        fromY = 0.4922,
        toPointID = 1000153,
        toMap = 1663,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Ruby Life Pools (map 2095)
    -- Ruby Life Pools (map 2095 0.00,0.00) -> The Waking Shores (map 2022 60.21,75.53) via portal
    {
        fromPointID = 1100093,
        fromMap = 2095,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100007,
        toMap = 2022,
        toX = 0.6021,
        toY = 0.7553,
        type = "portal",
    },

    -- Zone: Ruins of Ahn'Qiraj (map 247)
    -- Ruins of Ahn'Qiraj (map 247 60.51,11.70) -> Ahn'Qiraj: The Fallen Kingdom (map 327 58.92,14.29) via portal
    {
        fromPointID = 100366,
        fromMap = 247,
        fromX = 0.6051,
        fromY = 0.117,
        toPointID = 100406,
        toMap = 327,
        toX = 0.5892,
        toY = 0.1429,
        type = "portal",
    },

    -- Zone: Sanctum of Chronology (map 2190)
    -- Dawn of the Infinite (map 2190 33.17,20.88) -> Thaldraszus (map 2025 61.16,84.49) via portal
    {
        fromPointID = 1100180,
        fromMap = 2190,
        fromX = 0.3317,
        fromY = 0.2088,
        toPointID = 1100072,
        toMap = 2025,
        toX = 0.6116,
        toY = 0.8449,
        type = "portal",
    },

    -- Zone: Sanctum of Domination (map 1998)
    -- Sanctum of Domination (map 1998 0.00,0.00) -> The Maw (map 1543 69.79,31.89) via portal
    {
        fromPointID = 1000346,
        fromMap = 1998,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000124,
        toMap = 1543,
        toX = 0.6979,
        toY = 0.3189,
        type = "portal",
    },

    -- Zone: Sanguine Depths (map 1675)
    -- Sanguine Depths (map 1675 0.00,0.00) -> Revendreth (map 1525 51.07,30.22) via portal
    {
        fromPointID = 1000198,
        fromMap = 1675,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000014,
        toMap = 1525,
        toX = 0.5107,
        toY = 0.3022,
        type = "portal",
    },

    -- Zone: Scarlet Halls (map 431)
    -- Scarlet Halls (map 431 34.30,90.10) -> Tirisfal Glades (map 19 78.50,58.20) via portal
    {
        fromPointID = 200603,
        fromMap = 431,
        fromX = 0.343,
        fromY = 0.901,
        toPointID = 200060,
        toMap = 19,
        toX = 0.785,
        toY = 0.582,
        type = "portal",
    },

    -- Zone: Scarlet Monastery Entrance (map 19)
    -- Tirisfal Glades (map 19 69.40,25.10) -> Scarlet Monastery (map 302 75.70,45.80) via portal
    {
        fromPointID = 200059,
        fromMap = 19,
        fromX = 0.694,
        fromY = 0.251,
        toPointID = 200524,
        toMap = 302,
        toX = 0.757,
        toY = 0.458,
        type = "portal",
    },
    -- Tirisfal Glades (map 19 78.50,58.20) -> Scarlet Halls (map 431 34.30,90.10) via portal
    {
        fromPointID = 200060,
        fromMap = 19,
        fromX = 0.785,
        fromY = 0.582,
        toPointID = 200603,
        toMap = 431,
        toX = 0.343,
        toY = 0.901,
        type = "portal",
    },

    -- Zone: Scarlet Monastery (map 302)
    -- Scarlet Monastery (map 302 75.70,45.80) -> Tirisfal Glades (map 19 69.40,25.10) via portal
    {
        fromPointID = 200524,
        fromMap = 302,
        fromX = 0.757,
        fromY = 0.458,
        toPointID = 200059,
        toMap = 19,
        toX = 0.694,
        toY = 0.251,
        type = "portal",
    },

    -- Zone: Scholomance (map 476)
    -- Scholomance (map 476 18.10,60.90) -> Western Plaguelands (map 22 69.10,72.90) via portal
    {
        fromPointID = 200616,
        fromMap = 476,
        fromX = 0.181,
        fromY = 0.609,
        toPointID = 200083,
        toMap = 22,
        toX = 0.691,
        toY = 0.729,
        type = "portal",
    },

    -- Zone: Seat of the Primus (map 1698)
    -- Seat of the Primus (map 1698 56.38,31.48) -> Oribos (map 1671 44.68,58.91) via portal
    {
        fromPointID = 1000226,
        fromMap = 1698,
        fromX = 0.5638,
        fromY = 0.3148,
        toPointID = 1000183,
        toMap = 1671,
        toX = 0.4468,
        toY = 0.5891,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Seat of the Primus (map 1698 56.44,37.02) -> Maldraxxus (map 1536 26.08,43.01) via portal
    {
        fromPointID = 1000227,
        fromMap = 1698,
        fromX = 0.5644,
        fromY = 0.3702,
        toPointID = 1000064,
        toMap = 1536,
        toX = 0.2608,
        toY = 0.4301,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Seat of the Primus (map 1698 58.82,22.95) -> Maldraxxus (map 1536 50.39,73.42) via portal
    {
        fromPointID = 1000229,
        fromMap = 1698,
        fromX = 0.5882,
        fromY = 0.2295,
        toPointID = 1000074,
        toMap = 1536,
        toX = 0.5039,
        toY = 0.7342,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Seat of the Primus (map 1698 61.58,30.50) -> Maldraxxus (map 1536 74.27,33.64) via portal
    {
        fromPointID = 1000231,
        fromMap = 1698,
        fromX = 0.6158,
        fromY = 0.305,
        toPointID = 1000084,
        toMap = 1536,
        toX = 0.7427,
        toY = 0.3364,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Seat of the Primus (map 1698 61.62,37.75) -> Maldraxxus (map 1536 51.14,16.37) via portal
    {
        fromPointID = 1000232,
        fromMap = 1698,
        fromX = 0.6162,
        fromY = 0.3775,
        toPointID = 1000076,
        toMap = 1536,
        toX = 0.5114,
        toY = 0.1637,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 63059,
                },
            },
        },
    },
    -- Seat of the Primus (map 1698 62.98,34.28) -> The Maw (map 1543 43.28,58.58) via portal
    {
        fromPointID = 1000233,
        fromMap = 1698,
        fromX = 0.6298,
        fromY = 0.3428,
        toPointID = 1000110,
        toMap = 1543,
        toX = 0.4328,
        toY = 0.5858,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63543,
                },
            },
        },
    },

    -- Zone: Sepulcher of the First Ones (map 2047)
    -- Sepulcher of the First Ones (map 2047 0.00,0.00) -> Zereth Mortis (map 1970 81.02,53.40) via portal
    {
        fromPointID = 1000365,
        fromMap = 2047,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000330,
        toMap = 1970,
        toX = 0.8102,
        toY = 0.534,
        type = "portal",
    },

    -- Zone: Serpentshrine Cavern (map 332)
    -- Serpentshrine Cavern (map 332 13.49,61.14) -> Zangarmarsh (map 102 51.90,32.78) via portal
    {
        fromPointID = 300145,
        fromMap = 332,
        fromX = 0.1349,
        fromY = 0.6114,
        toPointID = 300038,
        toMap = 102,
        toX = 0.519,
        toY = 0.3278,
        type = "portal",
    },

    -- Zone: Sethekk Halls (map 258)
    -- Sethekk Halls (map 258 73.35,36.47) -> Terokkar Forest (map 108 44.95,65.61) via portal
    {
        fromPointID = 300116,
        fromMap = 258,
        fromX = 0.7335,
        fromY = 0.3647,
        toPointID = 300083,
        toMap = 108,
        toX = 0.4495,
        toY = 0.6561,
        type = "portal",
    },

    -- Zone: Shado-Pan Monastery (map 443)
    -- Shado-Pan Monastery (map 443 84.90,56.10) -> Kun-Lai Summit (map 379 36.70,47.50) via portal
    {
        fromPointID = 500174,
        fromMap = 443,
        fromX = 0.849,
        fromY = 0.561,
        toPointID = 500046,
        toMap = 379,
        toX = 0.367,
        toY = 0.475,
        type = "portal",
    },

    -- Zone: Shadow Enclave (map 2502)
    -- Voidholme (map 2502 16.36,59.76) -> Eversong Woods M (map 2395 45.54,86.35) via portal
    {
        fromPointID = 200750,
        fromMap = 2502,
        fromX = 0.1636,
        fromY = 0.5976,
        toPointID = 200676,
        toMap = 2395,
        toX = 0.4554,
        toY = 0.8635,
        type = "portal",
    },

    -- Zone: Shadow Labyrinth (map 260)
    -- Shadow Labyrinth (map 260 22.01,12.45) -> Terokkar Forest (map 108 39.63,73.60) via portal
    {
        fromPointID = 300119,
        fromMap = 260,
        fromX = 0.2201,
        fromY = 0.1245,
        toPointID = 300081,
        toMap = 108,
        toX = 0.3963,
        toY = 0.736,
        type = "portal",
    },

    -- Zone: Shadowfang Keep (map 316)
    -- Shadowfang Keep (map 316 69.46,60.97) -> Silverpine Forest (map 21 44.75,67.79) via portal
    {
        fromPointID = 200545,
        fromMap = 316,
        fromX = 0.6946,
        fromY = 0.6097,
        toPointID = 200062,
        toMap = 21,
        toX = 0.4475,
        toY = 0.6779,
        type = "portal",
    },

    -- Zone: Shadowguard Point (map 2506)
    -- Shadowguard Point (map 2506 46.43,87.96) -> Voidstorm (map 2405 37.38,47.74) via portal
    {
        fromPointID = 200756,
        fromMap = 2506,
        fromX = 0.4643,
        fromY = 0.8796,
        toPointID = 200683,
        toMap = 2405,
        toX = 0.3738,
        toY = 0.4774,
        type = "portal",
    },

    -- Zone: Shadowmoon Burial Grounds (map 574)
    -- Shadowmoon Burial Grounds (map 574 12.00,68.40) -> Shadowmoon Valley D (map 539 31.90,42.50) via portal
    {
        fromPointID = 600121,
        fromMap = 574,
        fromX = 0.12,
        fromY = 0.684,
        toPointID = 600062,
        toMap = 539,
        toX = 0.319,
        toY = 0.425,
        type = "portal",
    },

    -- Zone: Shadowmoon Valley (map 104)
    -- Shadowmoon Valley (map 104 27.10,33.36) -> Shadowmoon Valley D (map 539 32.33,28.76) via portal
    {
        fromPointID = 300051,
        fromMap = 104,
        fromX = 0.271,
        fromY = 0.3336,
        toPointID = 600064,
        toMap = 539,
        toX = 0.3233,
        toY = 0.2876,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Shadowmoon Valley (map 104 61.53,46.07) -> Shadowmoon Valley D (map 539 60.02,48.37) via portal
    {
        fromPointID = 300052,
        fromMap = 104,
        fromX = 0.6153,
        fromY = 0.4607,
        toPointID = 600070,
        toMap = 539,
        toX = 0.6002,
        toY = 0.4837,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Shadowmoon Valley (map 104 71.03,46.65) -> Black Temple (map 340 21.89,59.54) via portal
    {
        fromPointID = 300054,
        fromMap = 104,
        fromX = 0.7103,
        fromY = 0.4665,
        toPointID = 300149,
        toMap = 340,
        toX = 0.2189,
        toY = 0.5954,
        type = "portal",
    },

    -- Zone: Shadowmoon Valley (map 539)
    -- Shadowmoon Valley D (map 539 31.90,42.50) -> Shadowmoon Burial Grounds (map 574 12.00,68.40) via portal
    {
        fromPointID = 600062,
        fromMap = 539,
        fromX = 0.319,
        fromY = 0.425,
        toPointID = 600121,
        toMap = 574,
        toX = 0.12,
        toY = 0.684,
        type = "portal",
    },
    -- Shadowmoon Valley D (map 539 32.33,28.76) -> Shadowmoon Valley (map 104 27.10,33.36) via portal
    {
        fromPointID = 600064,
        fromMap = 539,
        fromX = 0.3233,
        fromY = 0.2876,
        toPointID = 300051,
        toMap = 104,
        toX = 0.271,
        toY = 0.3336,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Shadowmoon Valley D (map 539 60.02,48.37) -> Shadowmoon Valley (map 104 61.53,46.07) via portal
    {
        fromPointID = 600070,
        fromMap = 539,
        fromX = 0.6002,
        fromY = 0.4837,
        toPointID = 300052,
        toMap = 104,
        toX = 0.6153,
        toY = 0.4607,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Shattered Locus (map 684)
    -- Suramar (map 684 40.93,13.69) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700209,
        fromMap = 684,
        fromX = 0.4093,
        fromY = 0.1369,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42230,
                },
            },
        },
    },

    -- Zone: Shattrath City (map 111)
    -- Shattrath City (map 111 48.57,42.02) -> Isle of Quel'Danas (map 122 48.25,34.48) via portal
    {
        fromPointID = 300101,
        fromMap = 111,
        fromX = 0.4857,
        fromY = 0.4202,
        toPointID = 200347,
        toMap = 122,
        toX = 0.4825,
        toY = 0.3448,
        type = "portal",
    },
    -- Shattrath City (map 111 56.81,48.85) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 300105,
        fromMap = 111,
        fromX = 0.5681,
        fromY = 0.4885,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
    -- Shattrath City (map 111 57.21,48.27) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 300106,
        fromMap = 111,
        fromX = 0.5721,
        fromY = 0.4827,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
        travelDuration = 15,
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

    -- Zone: Sholazar Basin (map 119)
    -- Sholazar Basin (map 119 40.38,83.20) -> Un'Goro Crater (map 78 50.53,7.71) via portal
    {
        fromPointID = 400082,
        fromMap = 119,
        fromX = 0.4038,
        fromY = 0.832,
        toPointID = 100229,
        toMap = 78,
        toX = 0.5053,
        toY = 0.0771,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 12546,
                },
            },
        },
    },
    -- Sholazar Basin (map 119 40.40,83.00) -> Un'Goro Crater (map 78 50.40,7.90) via portal
    {
        fromPointID = 400083,
        fromMap = 119,
        fromX = 0.404,
        fromY = 0.83,
        toPointID = 100228,
        toMap = 78,
        toX = 0.504,
        toY = 0.079,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 12613,
                },
            },
        },
    },
    -- Sholazar Basin (map 119 88.43,53.00) -> Hall of Communion (map 888 43.69,82.00) via portal
    {
        fromPointID = 400085,
        fromMap = 119,
        fromX = 0.8843,
        fromY = 0.53,
        toPointID = 400243,
        toMap = 888,
        toX = 0.4369,
        toY = 0.82,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 47330,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 46206,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Shrine of Seven Stars (map 394)
    -- Shrine of Seven Stars (map 394 71.66,35.94) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 500119,
        fromMap = 394,
        fromX = 0.7166,
        fromY = 0.3594,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },

    -- Zone: Shrine of Two Moons (map 392)
    -- Shrine of Two Moons (map 392 73.35,42.69) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 500118,
        fromMap = 392,
        fromX = 0.7335,
        fromY = 0.4269,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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

    -- Zone: Shrine of the Storm (map 1039)
    -- Shrine of the Storm (map 1039 45.50,7.97) -> Stormsong Valley (map 942 78.97,26.48) via portal
    {
        fromPointID = 800062,
        fromMap = 1039,
        fromX = 0.455,
        fromY = 0.0797,
        toPointID = 800059,
        toMap = 942,
        toX = 0.7897,
        toY = 0.2648,
        type = "portal",
    },

    -- Zone: Sidestreet Sluice (map 2420)
    -- Sidestreet Sluice (map 2420 48.89,71.44) -> Undermine (map 2346 35.19,51.44) via portal
    {
        fromPointID = 1200186,
        fromMap = 2420,
        fromX = 0.4889,
        fromY = 0.7144,
        toPointID = 1200143,
        toMap = 2346,
        toX = 0.3519,
        toY = 0.5144,
        type = "portal",
    },

    -- Zone: Siege of Boralus (map 1162)
    -- Siege of Boralus (map 1162 75.33,20.81) -> Boralus (map 1161 72.10,15.45) via portal
    {
        fromPointID = 800090,
        fromMap = 1162,
        fromX = 0.7533,
        fromY = 0.2081,
        toPointID = 800086,
        toMap = 1161,
        toX = 0.721,
        toY = 0.1545,
        type = "portal",
    },

    -- Zone: Siege of Niuzao Temple (map 458)
    -- Siege of Niuzao Temple (map 458 64.90,86.90) -> Townlong Steppes (map 388 34.70,81.40) via portal
    {
        fromPointID = 500188,
        fromMap = 458,
        fromX = 0.649,
        fromY = 0.869,
        toPointID = 500086,
        toMap = 388,
        toX = 0.347,
        toY = 0.814,
        type = "portal",
    },

    -- Zone: Siege of Orgrimmar (map 557)
    -- Siege of Orgrimmar (map 557 0.00,0.00) -> Vale of Eternal Blossoms New (map 1530 72.86,41.91) via portal
    {
        fromPointID = 500264,
        fromMap = 557,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 500290,
        toMap = 1530,
        toX = 0.7286,
        toY = 0.4191,
        type = "portal",
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
    -- Siege of Orgrimmar (map 557 0.00,0.00) -> Vale of Eternal Blossoms (map 390 73.96,42.15) via portal
    {
        fromPointID = 500264,
        fromMap = 557,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 500113,
        toMap = 390,
        toX = 0.7396,
        toY = 0.4215,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "OldVale",
                },
            },
        },
    },

    -- Zone: Silithus (map 81)
    -- Silithus (map 81 41.48,44.85) -> Boralus (map 1161 70.18,15.87) via portal
    {
        fromPointID = 100241,
        fromMap = 81,
        fromX = 0.4148,
        fromY = 0.4485,
        toPointID = 800082,
        toMap = 1161,
        toX = 0.7018,
        toY = 0.1587,
        type = "portal",
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
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Silithus (map 81 41.61,45.20) -> Dazar'alor (map 1163 68.28,64.58) via portal
    {
        fromPointID = 100242,
        fromMap = 81,
        fromX = 0.4161,
        fromY = 0.452,
        toPointID = 900074,
        toMap = 1163,
        toX = 0.6828,
        toY = 0.6458,
        type = "portal",
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
                    kind = "minLevel",
                    value = 10,
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Silithus (map 81 43.20,44.50) -> Chamber of Heart (map 1021 50.22,35.92) via portal
    {
        fromPointID = 100243,
        fromMap = 81,
        fromX = 0.432,
        fromY = 0.445,
        toPointID = 100459,
        toMap = 1021,
        toX = 0.5022,
        toY = 0.3592,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },
    -- Silithus (map 81 43.20,44.50) -> Chamber of Heart (map 1473 50.22,35.92) via portal
    {
        fromPointID = 100243,
        fromMap = 81,
        fromX = 0.432,
        fromY = 0.445,
        toPointID = 100465,
        toMap = 1473,
        toX = 0.5022,
        toY = 0.3592,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Silithus",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "BFA",
                },
            },
        },
    },

    -- Zone: Silvermoon City (map 110)
    -- Silvermoon City (map 110 49.49,14.80) -> Tirisfal Glades (map 18 69.30,62.75) via portal
    {
        fromPointID = 200340,
        fromMap = 110,
        fromX = 0.4949,
        fromY = 0.148,
        toPointID = 200051,
        toMap = 18,
        toX = 0.693,
        toY = 0.6275,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "phase",
                                    value = "Old Undercity",
                                },
                            },
                        },
                        {
                            operation = "check",
                            kind = "phase",
                            value = "UndercityCharred",
                        },
                        {
                            operation = "check",
                            kind = "phase",
                            value = "UndercityOoze",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Silvermoon City (map 110 49.49,14.80) -> Tirisfal Glades (map 18 59.45,67.44) via portal
    {
        fromPointID = 200340,
        fromMap = 110,
        fromX = 0.4949,
        fromY = 0.148,
        toPointID = 200045,
        toMap = 18,
        toX = 0.5945,
        toY = 0.6744,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Silvermoon City (map 110 49.49,14.80) -> Tirisfal Glades L (map 2070 59.40,67.45) via portal
    {
        fromPointID = 200340,
        fromMap = 110,
        fromX = 0.4949,
        fromY = 0.148,
        toPointID = 200634,
        toMap = 2070,
        toX = 0.594,
        toY = 0.6745,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },
    -- Silvermoon City (map 110 58.54,18.66) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200343,
        fromMap = 110,
        fromX = 0.5854,
        fromY = 0.1866,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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

    -- Zone: Silvermoon City (map 2393)
    -- Silvermoon City M (map 2393 35.28,66.15) -> Voidstorm (map 2405 34.20,60.53) via portal
    {
        fromPointID = 200655,
        fromMap = 2393,
        fromX = 0.3528,
        fromY = 0.6615,
        toPointID = 200681,
        toMap = 2405,
        toX = 0.342,
        toY = 0.6053,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86549,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86549,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86510,
                        },
                    },
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 35.28,66.18) -> Voidstorm (map 2405 51.64,70.20) via portal
    {
        fromPointID = 200656,
        fromMap = 2393,
        fromX = 0.3528,
        fromY = 0.6618,
        toPointID = 200691,
        toMap = 2405,
        toX = 0.5164,
        toY = 0.702,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86510,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86510,
                        },
                    },
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 36.96,67.99) -> Harandar (map 2413 53.14,55.35) via portal
    {
        fromPointID = 200659,
        fromMap = 2393,
        fromX = 0.3696,
        fromY = 0.6799,
        toPointID = 200699,
        toMap = 2413,
        toX = 0.5314,
        toY = 0.5535,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "achievement",
                    value = 41804,
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 39.32,31.68) -> The Darkway (map 2525 44.71,15.45) via portal
    {
        fromPointID = 200660,
        fromMap = 2393,
        fromX = 0.3932,
        fromY = 0.3168,
        toPointID = 200813,
        toMap = 2525,
        toX = 0.4471,
        toY = 0.1545,
        type = "portal",
    },
    -- Silvermoon City M (map 2393 40.27,53.05) -> Collegiate Calamity (map 2577 69.40,82.10) via portal
    {
        fromPointID = 200661,
        fromMap = 2393,
        fromX = 0.4027,
        fromY = 0.5305,
        toPointID = 200848,
        toMap = 2577,
        toX = 0.694,
        toY = 0.821,
        type = "portal",
    },
    -- Silvermoon City M (map 2393 41.97,58.29) -> Millenia's Threshold (map 2266 38.31,48.18) via portal
    {
        fromPointID = 200662,
        fromMap = 2393,
        fromX = 0.4197,
        fromY = 0.5829,
        toPointID = 1100236,
        toMap = 2266,
        toX = 0.3831,
        toY = 0.4818,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 90,
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 47.93,48.08) -> Val (map 2599 61.83,15.98) via portal
    {
        fromPointID = 200663,
        fromMap = 2393,
        fromX = 0.4793,
        fromY = 0.4808,
        toPointID = 200867,
        toMap = 2599,
        toX = 0.6183,
        toY = 0.1598,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97071,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97071,
                        },
                    },
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 47.93,48.08) -> Naigtal (map 2600 48.65,82.79) via portal
    {
        fromPointID = 200663,
        fromMap = 2393,
        fromX = 0.4793,
        fromY = 0.4808,
        toPointID = 200871,
        toMap = 2600,
        toX = 0.4865,
        toY = 0.8279,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97072,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97072,
                        },
                    },
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 47.93,51.95) -> The Lycaneum (map 2649 56.46,14.00) via portal
    {
        fromPointID = 200664,
        fromMap = 2393,
        fromX = 0.4793,
        fromY = 0.5195,
        toPointID = 200905,
        toMap = 2649,
        toX = 0.5646,
        toY = 0.14,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 96233,
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 52.17,65.21) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200665,
        fromMap = 2393,
        fromX = 0.5217,
        fromY = 0.6521,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86852,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 52.63,64.51) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 200666,
        fromMap = 2393,
        fromX = 0.5263,
        fromY = 0.6451,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86852,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 56.88,67.48) -> The Coiled Isle (map 2512 58.17,48.48) via portal
    {
        fromPointID = 200669,
        fromMap = 2393,
        fromX = 0.5688,
        fromY = 0.6748,
        toPointID = 200793,
        toMap = 2512,
        toX = 0.5817,
        toY = 0.4848,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96532,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96532,
                        },
                    },
                },
            },
        },
    },
    -- Silvermoon City M (map 2393 57.20,61.06) -> Murder Row (map 2433 0.00,0.00) via portal
    {
        fromPointID = 200671,
        fromMap = 2393,
        fromX = 0.572,
        fromY = 0.6106,
        toPointID = 200715,
        toMap = 2433,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Silverpine Forest (map 21)
    -- Silverpine Forest (map 21 44.75,67.79) -> Shadowfang Keep (map 316 69.46,60.97) via portal
    {
        fromPointID = 200062,
        fromMap = 21,
        fromX = 0.4475,
        fromY = 0.6779,
        toPointID = 200545,
        toMap = 316,
        toX = 0.6946,
        toY = 0.6097,
        type = "portal",
    },

    -- Zone: Sinfall (map 1699)
    -- Sinfall (map 1699 17.70,61.34) -> Revendreth (map 1525 29.57,42.53) via portal
    {
        fromPointID = 1000234,
        fromMap = 1699,
        fromX = 0.177,
        fromY = 0.6134,
        toPointID = 1000006,
        toMap = 1525,
        toX = 0.2957,
        toY = 0.4253,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 59327,
                },
            },
        },
    },
    -- Sinfall (map 1699 36.55,48.19) -> Sinfall (map 1700 68.86,39.54) via portal
    {
        fromPointID = 1000236,
        fromMap = 1699,
        fromX = 0.3655,
        fromY = 0.4819,
        toPointID = 1000247,
        toMap = 1700,
        toX = 0.6886,
        toY = 0.3954,
        type = "portal",
        travelDuration = 1,
    },
    -- Sinfall (map 1699 38.16,61.06) -> The Maw (map 1543 29.75,18.42) via portal
    {
        fromPointID = 1000239,
        fromMap = 1699,
        fromX = 0.3816,
        fromY = 0.6106,
        toPointID = 1000096,
        toMap = 1543,
        toX = 0.2975,
        toY = 0.1842,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63822,
                },
            },
        },
    },
    -- Sinfall (map 1699 41.95,48.50) -> Revendreth (map 1525 29.62,42.51) via portal
    {
        fromPointID = 1000240,
        fromMap = 1699,
        fromX = 0.4195,
        fromY = 0.485,
        toPointID = 1000007,
        toMap = 1525,
        toX = 0.2962,
        toY = 0.4251,
        type = "portal",
    },
    -- Sinfall (map 1699 42.12,36.22) -> Revendreth (map 1525 70.76,75.48) via portal
    {
        fromPointID = 1000241,
        fromMap = 1699,
        fromX = 0.4212,
        fromY = 0.3622,
        toPointID = 1000026,
        toMap = 1525,
        toX = 0.7076,
        toY = 0.7548,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60060,
                },
            },
        },
    },
    -- Sinfall (map 1699 46.08,49.50) -> Revendreth (map 1525 56.74,32.46) via portal
    {
        fromPointID = 1000242,
        fromMap = 1699,
        fromX = 0.4608,
        fromY = 0.495,
        toPointID = 1000016,
        toMap = 1525,
        toX = 0.5674,
        toY = 0.3246,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60147,
                },
            },
        },
    },
    -- Sinfall (map 1699 62.44,26.59) -> Oribos (map 1671 44.68,58.91) via portal
    {
        fromPointID = 1000243,
        fromMap = 1699,
        fromX = 0.6244,
        fromY = 0.2659,
        toPointID = 1000183,
        toMap = 1671,
        toX = 0.4468,
        toY = 0.5891,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetwork",
                    value = 3,
                },
            },
        },
    },

    -- Zone: Sinfall (map 1700)
    -- Sinfall (map 1700 58.26,36.49) -> Revendreth (map 1525 43.48,57.07) via portal
    {
        fromPointID = 1000244,
        fromMap = 1700,
        fromX = 0.5826,
        fromY = 0.3649,
        toPointID = 1000011,
        toMap = 1525,
        toX = 0.4348,
        toY = 0.5707,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60160,
                },
            },
        },
    },
    -- Sinfall (map 1700 63.57,53.53) -> Revendreth (map 1525 73.61,43.94) via portal
    {
        fromPointID = 1000245,
        fromMap = 1700,
        fromX = 0.6357,
        fromY = 0.5353,
        toPointID = 1000028,
        toMap = 1525,
        toX = 0.7361,
        toY = 0.4394,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60159,
                },
            },
        },
    },
    -- Sinfall (map 1700 67.24,47.29) -> Revendreth (map 1525 29.62,42.51) via portal
    {
        fromPointID = 1000246,
        fromMap = 1700,
        fromX = 0.6724,
        fromY = 0.4729,
        toPointID = 1000007,
        toMap = 1525,
        toX = 0.2962,
        toY = 0.4251,
        type = "portal",
    },
    -- Sinfall (map 1700 70.64,38.24) -> Sinfall (map 1699 37.91,47.23) via portal
    {
        fromPointID = 1000248,
        fromMap = 1700,
        fromX = 0.7064,
        fromY = 0.3824,
        toPointID = 1000237,
        toMap = 1699,
        toX = 0.3791,
        toY = 0.4723,
        type = "portal",
        travelDuration = 1,
    },
    -- Sinfall (map 1700 71.85,19.77) -> Revendreth (map 1525 58.24,62.72) via portal
    {
        fromPointID = 1000249,
        fromMap = 1700,
        fromX = 0.7185,
        fromY = 0.1977,
        toPointID = 1000019,
        toMap = 1525,
        toX = 0.5824,
        toY = 0.6272,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60165,
                },
            },
        },
    },
    -- Sinfall (map 1700 81.05,48.97) -> Revendreth (map 1525 25.47,26.83) via portal
    {
        fromPointID = 1000250,
        fromMap = 1700,
        fromX = 0.8105,
        fromY = 0.4897,
        toPointID = 1000002,
        toMap = 1525,
        toX = 0.2547,
        toY = 0.2683,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 3,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60164,
                },
            },
        },
    },

    -- Zone: Siren Isle (map 2369)
    -- Siren Isle (map 2369 50.32,15.37) -> The Forgotten Vault (map 2375 61.39,12.70) via portal
    {
        fromPointID = 1200156,
        fromMap = 2369,
        fromX = 0.5032,
        fromY = 0.1537,
        toPointID = 1200168,
        toMap = 2375,
        toX = 0.6139,
        toY = 0.127,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84723,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84723,
                        },
                    },
                },
            },
        },
    },
    -- Siren Isle (map 2369 67.96,38.52) -> The Ringing Deeps (map 2214 41.92,30.23) via portal
    {
        fromPointID = 1200157,
        fromMap = 2369,
        fromX = 0.6796,
        fromY = 0.3852,
        toPointID = 1200010,
        toMap = 2214,
        toX = 0.4192,
        toY = 0.3023,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84720,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84720,
                        },
                    },
                },
            },
        },
    },
    -- Siren Isle (map 2369 70.69,53.49) -> Dornogal (map 2339 73.55,5.29) via portal
    {
        fromPointID = 1200158,
        fromMap = 2369,
        fromX = 0.7069,
        fromY = 0.5349,
        toPointID = 1200134,
        toMap = 2339,
        toX = 0.7355,
        toY = 0.0529,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84720,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84720,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Skittering Breach (map 2310)
    -- Skittering Breach (map 2310 83.68,54.72) -> Hallowfall (map 2215 65.42,61.69) via portal
    {
        fromPointID = 1200099,
        fromMap = 2310,
        fromX = 0.8368,
        fromY = 0.5472,
        toPointID = 1200035,
        toMap = 2215,
        toX = 0.6542,
        toY = 0.6169,
        type = "portal",
    },

    -- Zone: Skyhold (map 695)
    -- Skyhold (map 695 58.34,24.98) -> Stormheim (map 634 60.42,51.05) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700076,
        toMap = 634,
        toX = 0.6042,
        toY = 0.5105,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39654,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Thunder Totem (map 750 41.57,44.02) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700272,
        toMap = 750,
        toX = 0.4157,
        toY = 0.4402,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41359,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Dalaran L (map 627 72.42,46.00) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700029,
        toMap = 627,
        toX = 0.7242,
        toY = 0.46,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42815,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Azsuna (map 630 47.55,27.87) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700049,
        toMap = 630,
        toX = 0.4755,
        toY = 0.2787,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44060,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Val'sharah (map 641 55.01,72.49) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700099,
        toMap = 641,
        toX = 0.5501,
        toY = 0.7249,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44061,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Suramar (map 680 33.82,49.38) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700147,
        toMap = 680,
        toX = 0.3382,
        toY = 0.4938,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44062,
                },
            },
        },
    },
    -- Skyhold (map 695 58.34,24.98) -> Broken Shore (map 646 44.27,62.99) via portal
    {
        fromPointID = 700213,
        fromMap = 695,
        fromX = 0.5834,
        fromY = 0.2498,
        toPointID = 700114,
        toMap = 646,
        toX = 0.4427,
        toY = 0.6299,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 46734,
                },
            },
        },
    },

    -- Zone: Skyreach (map 601)
    -- Skyreach (map 601 60.50,25.90) -> Spires of Arak (map 542 35.60,33.70) via portal
    {
        fromPointID = 600130,
        fromMap = 601,
        fromX = 0.605,
        fromY = 0.259,
        toPointID = 600074,
        toMap = 542,
        toX = 0.356,
        toY = 0.337,
        type = "portal",
    },

    -- Zone: Slayer's Rise (map 2444)
    -- Slayers Rise (map 2444 53.67,33.08) -> Voidscar Arena (map 2574 0.00,0.00) via portal
    {
        fromPointID = 200730,
        fromMap = 2444,
        fromX = 0.5367,
        fromY = 0.3308,
        toPointID = 200842,
        toMap = 2574,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Southern Barrens (map 199)
    -- Southern Barrens (map 199 40.72,94.39) -> Razorfen Kraul (map 301 69.89,82.97) via portal
    {
        fromPointID = 100339,
        fromMap = 199,
        fromX = 0.4072,
        fromY = 0.9439,
        toPointID = 100394,
        toMap = 301,
        toX = 0.6989,
        toY = 0.8297,
        type = "portal",
    },

    -- Zone: Spires Of Ascension (map 1693)
    -- Spires of Ascension (map 1693 0.00,0.00) -> Bastion (map 1533 58.60,28.52) via portal
    {
        fromPointID = 1000218,
        fromMap = 1693,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000058,
        toMap = 1533,
        toX = 0.586,
        toY = 0.2852,
        type = "portal",
    },

    -- Zone: Spires of Arak (map 542)
    -- Spires of Arak (map 542 35.60,33.70) -> Skyreach (map 601 60.50,25.90) via portal
    {
        fromPointID = 600074,
        fromMap = 542,
        fromX = 0.356,
        fromY = 0.337,
        toPointID = 600130,
        toMap = 601,
        toX = 0.605,
        toY = 0.259,
        type = "portal",
    },
    -- Spires of Arak (map 542 47.40,12.45) -> Terokkar Forest (map 108 70.78,75.88) via portal
    {
        fromPointID = 600081,
        fromMap = 542,
        fromX = 0.474,
        fromY = 0.1245,
        toPointID = 300088,
        toMap = 108,
        toX = 0.7078,
        toY = 0.7588,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Sporefall (map 2427)
    -- Sporefall (map 2427 24.20,8.25) -> Harandar (map 2413 73.67,66.34) via portal
    {
        fromPointID = 200714,
        fromMap = 2427,
        fromX = 0.242,
        fromY = 0.0825,
        toPointID = 200706,
        toMap = 2413,
        toX = 0.7367,
        toY = 0.6634,
        type = "portal",
    },

    -- Zone: Stormheim (map 634)
    -- Stormheim (map 634 31.34,60.51) -> Hall of the Guardian (map 734 67.12,41.71) via portal
    {
        fromPointID = 700065,
        fromMap = 634,
        fromX = 0.3134,
        fromY = 0.6051,
        toPointID = 700261,
        toMap = 734,
        toX = 0.6712,
        toY = 0.4171,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Stormheim (map 634 37.48,64.23) -> Stormheim (map 634 41.30,80.10) via portal
    {
        fromPointID = 700068,
        fromMap = 634,
        fromX = 0.3748,
        fromY = 0.6423,
        toPointID = 700069,
        toMap = 634,
        toX = 0.413,
        toY = 0.801,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 37.48,64.23) -> Stormheim (map 634 42.79,82.67) via portal
    {
        fromPointID = 700068,
        fromMap = 634,
        fromX = 0.3748,
        fromY = 0.6423,
        toPointID = 700070,
        toMap = 634,
        toX = 0.4279,
        toY = 0.8267,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 37.48,64.23) -> Stormheim (map 634 44.83,77.39) via portal
    {
        fromPointID = 700068,
        fromMap = 634,
        fromX = 0.3748,
        fromY = 0.6423,
        toPointID = 700072,
        toMap = 634,
        toX = 0.4483,
        toY = 0.7739,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 44.66,59.51) -> Stormheim (map 634 41.30,80.10) via portal
    {
        fromPointID = 700071,
        fromMap = 634,
        fromX = 0.4466,
        fromY = 0.5951,
        toPointID = 700069,
        toMap = 634,
        toX = 0.413,
        toY = 0.801,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 44.66,59.51) -> Stormheim (map 634 42.79,82.67) via portal
    {
        fromPointID = 700071,
        fromMap = 634,
        fromX = 0.4466,
        fromY = 0.5951,
        toPointID = 700070,
        toMap = 634,
        toX = 0.4279,
        toY = 0.8267,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 44.66,59.51) -> Stormheim (map 634 44.83,77.39) via portal
    {
        fromPointID = 700071,
        fromMap = 634,
        fromX = 0.4466,
        fromY = 0.5951,
        toPointID = 700072,
        toMap = 634,
        toX = 0.4483,
        toY = 0.7739,
        type = "portal",
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
                    value = 38624,
                },
            },
        },
    },
    -- Stormheim (map 634 52.49,45.26) -> Helmouth Cliffs (map 706 46.77,78.55) via portal
    {
        fromPointID = 700074,
        fromMap = 634,
        fromX = 0.5249,
        fromY = 0.4526,
        toPointID = 700218,
        toMap = 706,
        toX = 0.4677,
        toY = 0.7855,
        type = "portal",
    },
    -- Stormheim (map 634 60.18,52.23) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700075,
        fromMap = 634,
        fromX = 0.6018,
        fromY = 0.5223,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39654,
                },
            },
        },
    },
    -- Stormheim (map 634 71.18,72.73) -> Trial of Valor (map 807 51.00,10.00) via portal
    {
        fromPointID = 700079,
        fromMap = 634,
        fromX = 0.7118,
        fromY = 0.7273,
        toPointID = 700282,
        toMap = 807,
        toX = 0.51,
        toY = 0.1,
        type = "portal",
    },
    -- Stormheim (map 634 72.65,70.52) -> Halls of Valor (map 704 47.72,8.68) via portal
    {
        fromPointID = 700081,
        fromMap = 634,
        fromX = 0.7265,
        fromY = 0.7052,
        toPointID = 700217,
        toMap = 704,
        toX = 0.4772,
        toY = 0.0868,
        type = "portal",
    },
    -- Stormheim (map 634 73.70,39.29) -> Helheim (map 649 66.25,47.63) via portal
    {
        fromPointID = 700083,
        fromMap = 634,
        fromX = 0.737,
        fromY = 0.3929,
        toPointID = 700124,
        toMap = 649,
        toX = 0.6625,
        toY = 0.4763,
        type = "portal",
    },

    -- Zone: Stormshield (map 622)
    -- Stormshield (map 622 36.38,41.15) -> Tanaan Jungle (map 534 57.53,60.32) via portal
    {
        fromPointID = 600135,
        fromMap = 622,
        fromX = 0.3638,
        fromY = 0.4115,
        toPointID = 600034,
        toMap = 534,
        toX = 0.5753,
        toY = 0.6032,
        type = "portal",
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
                    value = 38445,
                },
            },
        },
    },
    -- Stormshield (map 622 60.81,37.87) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 600136,
        fromMap = 622,
        fromX = 0.6081,
        fromY = 0.3787,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },

    -- Zone: Stormsong Valley (map 942)
    -- Stormsong Valley (map 942 78.97,26.48) -> Shrine of the Storm (map 1039 45.50,7.97) via portal
    {
        fromPointID = 800059,
        fromMap = 942,
        fromX = 0.7897,
        fromY = 0.2648,
        toPointID = 800062,
        toMap = 1039,
        toX = 0.455,
        toY = 0.0797,
        type = "portal",
    },

    -- Zone: Stormstout Brewery (map 441)
    -- Stormstout Brewery (map 441 79.40,39.70) -> Valley of the Four Winds (map 376 36.00,69.10) via portal
    {
        fromPointID = 500167,
        fromMap = 441,
        fromX = 0.794,
        fromY = 0.397,
        toPointID = 500033,
        toMap = 376,
        toX = 0.36,
        toY = 0.691,
        type = "portal",
    },

    -- Zone: Stormwind City (map 84)
    -- Stormwind City (map 84 23.86,56.10) -> Darnassus (map 89 43.47,78.67) via portal
    {
        fromPointID = 200282,
        fromMap = 84,
        fromX = 0.2386,
        fromY = 0.561,
        toPointID = 100299,
        toMap = 89,
        toX = 0.4347,
        toY = 0.7867,
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
    },
    -- Stormwind City (map 84 40.85,92.75) -> Boralus (map 1161 70.62,16.98) via portal
    {
        fromPointID = 200283,
        fromMap = 84,
        fromX = 0.4085,
        fromY = 0.9275,
        toPointID = 800085,
        toMap = 1161,
        toX = 0.7062,
        toY = 0.1698,
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
    },
    -- Stormwind City (map 84 41.36,89.82) -> Stormshield (map 622 31.71,52.48) via portal
    {
        fromPointID = 200284,
        fromMap = 84,
        fromX = 0.4136,
        fromY = 0.8982,
        toPointID = 600134,
        toMap = 622,
        toX = 0.3171,
        toY = 0.5248,
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
    },
    -- Stormwind City (map 84 42.08,91.34) -> Azsuna (map 630 47.00,40.89) via portal
    {
        fromPointID = 200285,
        fromMap = 84,
        fromX = 0.4208,
        fromY = 0.9134,
        toPointID = 700048,
        toMap = 630,
        toX = 0.47,
        toY = 0.4089,
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
    },
    -- Stormwind City (map 84 43.34,97.45) -> Amirdrassil (map 2239 54.92,63.88) via portal
    {
        fromPointID = 200286,
        fromMap = 84,
        fromX = 0.4334,
        fromY = 0.9745,
        toPointID = 1100226,
        toMap = 2239,
        toX = 0.5492,
        toY = 0.6388,
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
    },
    -- Stormwind City (map 84 43.60,87.22) -> The Exodar (map 103 47.62,59.82) via portal
    {
        fromPointID = 200287,
        fromMap = 84,
        fromX = 0.436,
        fromY = 0.8722,
        toPointID = 100312,
        toMap = 103,
        toX = 0.4762,
        toY = 0.5982,
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
    },
    -- Stormwind City (map 84 43.72,85.35) -> Tanaris (map 74 54.60,28.30) via portal
    {
        fromPointID = 200288,
        fromMap = 84,
        fromX = 0.4372,
        fromY = 0.8535,
        toPointID = 100203,
        toMap = 74,
        toX = 0.546,
        toY = 0.283,
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
    },
    -- Stormwind City (map 84 44.36,88.71) -> Dalaran (map 125 55.92,46.79) via portal
    {
        fromPointID = 200289,
        fromMap = 84,
        fromX = 0.4436,
        fromY = 0.8871,
        toPointID = 400120,
        toMap = 125,
        toX = 0.5592,
        toY = 0.4679,
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
    },
    -- Stormwind City (map 84 44.91,85.72) -> Shattrath City (map 111 54.97,40.23) via portal
    {
        fromPointID = 200290,
        fromMap = 84,
        fromX = 0.4491,
        fromY = 0.8572,
        toPointID = 300104,
        toMap = 111,
        toX = 0.5497,
        toY = 0.4023,
        type = "portal",
        travelDuration = 999,
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
                    kind = "maxLevelExclusive",
                    value = 10,
                },
            },
        },
    },
    -- Stormwind City (map 84 44.91,85.72) -> Shattrath City (map 111 54.97,40.23) via portal
    {
        fromPointID = 200290,
        fromMap = 84,
        fromX = 0.4491,
        fromY = 0.8572,
        toPointID = 300104,
        toMap = 111,
        toX = 0.5497,
        toY = 0.4023,
        type = "portal",
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
    -- Stormwind City (map 84 45.70,87.16) -> The Jade Forest (map 371 46.18,85.07) via portal
    {
        fromPointID = 200291,
        fromMap = 84,
        fromX = 0.457,
        fromY = 0.8716,
        toPointID = 500014,
        toMap = 371,
        toX = 0.4618,
        toY = 0.8507,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 31735,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 40,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 46.85,93.45) -> Founder's Point (map 2352 57.43,26.62) via portal
    {
        fromPointID = 200293,
        fromMap = 84,
        fromX = 0.4685,
        fromY = 0.9345,
        toPointID = 200651,
        toMap = 2352,
        toX = 0.5743,
        toY = 0.2662,
        type = "portal",
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
                    value = 93057,
                },
            },
        },
    },
    -- Stormwind City (map 84 47.55,94.98) -> Oribos (map 1670 20.34,50.31) via portal
    {
        fromPointID = 200294,
        fromMap = 84,
        fromX = 0.4755,
        fromY = 0.9498,
        toPointID = 1000165,
        toMap = 1670,
        toX = 0.2034,
        toY = 0.5031,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60151,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 48.06,11.06) -> Vindicaar Scenario (map 940 49.95,46.23) via portal
    {
        fromPointID = 200295,
        fromMap = 84,
        fromX = 0.4806,
        fromY = 0.1106,
        toPointID = 700342,
        toMap = 940,
        toX = 0.4995,
        toY = 0.4623,
        type = "portal",
    },
    -- Stormwind City (map 84 48.13,91.95) -> Dornogal (map 2339 41.29,27.45) via portal
    {
        fromPointID = 200296,
        fromMap = 84,
        fromX = 0.4813,
        fromY = 0.9195,
        toPointID = 1200125,
        toMap = 2339,
        toX = 0.4129,
        toY = 0.2745,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 80321,
                                },
                            },
                        },
                        {
                            operation = "all",
                            children = {
                                {
                                    operation = "check",
                                    kind = "minLevel",
                                    value = 70,
                                },
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 79573,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 48.77,95.23) -> Silvermoon City M (map 2393 52.85,65.51) via portal
    {
        fromPointID = 200297,
        fromMap = 84,
        fromX = 0.4877,
        fromY = 0.9523,
        toPointID = 200667,
        toMap = 2393,
        toX = 0.5285,
        toY = 0.6551,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86852,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 48.78,8.98) -> Mechagon City (map 1573 21.10,64.71) via portal
    {
        fromPointID = 200298,
        fromMap = 84,
        fromX = 0.4878,
        fromY = 0.0898,
        toPointID = 800113,
        toMap = 1573,
        toX = 0.211,
        toY = 0.6471,
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
    },
    -- Stormwind City (map 84 48.89,93.43) -> Valdrakken (map 2112 59.55,41.46) via portal
    {
        fromPointID = 200299,
        fromMap = 84,
        fromX = 0.4889,
        fromY = 0.9343,
        toPointID = 1100113,
        toMap = 2112,
        toX = 0.5955,
        toY = 0.4146,
        type = "portal",
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
                    value = 67030,
                },
            },
        },
    },
    -- Stormwind City (map 84 49.12,87.34) -> Blasted Lands (map 17 54.89,50.11) via portal
    {
        fromPointID = 200300,
        fromMap = 84,
        fromX = 0.4912,
        fromY = 0.8734,
        toPointID = 200035,
        toMap = 17,
        toX = 0.5489,
        toY = 0.5011,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "questCompleted",
                                    value = 60123,
                                },
                            },
                        },
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "chromieTime",
                                    value = 6,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 49.12,87.34) -> Hellfire Peninsula (map 100 90.00,50.00) via portal
    {
        fromPointID = 200300,
        fromMap = 84,
        fromX = 0.4912,
        fromY = 0.8734,
        toPointID = 300026,
        toMap = 100,
        toX = 0.9,
        toY = 0.5,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 60123,
                        },
                        {
                            operation = "not",
                            children = {
                                {
                                    operation = "check",
                                    kind = "chromieTime",
                                    value = 6,
                                },
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 49.74,10.67) -> Shadowforge City (map 1186 61.44,24.35) via portal
    {
        fromPointID = 200304,
        fromMap = 84,
        fromX = 0.4974,
        fromY = 0.1067,
        toPointID = 200630,
        toMap = 1186,
        toX = 0.6144,
        toY = 0.2435,
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
    },
    -- Stormwind City (map 84 50.42,66.31) -> The Stockade (map 225 50.07,68.09) via portal
    {
        fromPointID = 200305,
        fromMap = 84,
        fromX = 0.5042,
        fromY = 0.6631,
        toPointID = 200393,
        toMap = 225,
        toX = 0.5007,
        toY = 0.6809,
        type = "portal",
    },
    -- Stormwind City (map 84 50.68,8.45) -> Telogrus Rift (map 971 27.69,28.10) via portal
    {
        fromPointID = 200306,
        fromMap = 84,
        fromX = 0.5068,
        fromY = 0.0845,
        toPointID = 700346,
        toMap = 971,
        toX = 0.2769,
        toY = 0.281,
        type = "portal",
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
                    value = 79010,
                },
            },
        },
    },
    -- Stormwind City (map 84 62.26,72.96) -> Elwynn Forest (map 37 41.87,68.17) via portal
    {
        fromPointID = 200310,
        fromMap = 84,
        fromX = 0.6226,
        fromY = 0.7296,
        toPointID = 200180,
        toMap = 37,
        toX = 0.4187,
        toY = 0.6817,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "DARKMOON FAIRE",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 69.62,31.11) -> Deeprun Tram (map 499 42.53,11.53) via portal
    {
        fromPointID = 200312,
        fromMap = 84,
        fromX = 0.6962,
        fromY = 0.3111,
        toPointID = 200623,
        toMap = 499,
        toX = 0.4253,
        toY = 0.1153,
        type = "portal",
    },
    -- Stormwind City (map 84 73.19,19.65) -> Deepholm (map 207 48.73,53.56) via portal
    {
        fromPointID = 200314,
        fromMap = 84,
        fromX = 0.7319,
        fromY = 0.1965,
        toPointID = 1300014,
        toMap = 207,
        toX = 0.4873,
        toY = 0.5356,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 27123,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 73.20,18.37) -> Tol Barad Peninsula (map 245 73.68,60.92) via portal
    {
        fromPointID = 200315,
        fromMap = 84,
        fromX = 0.732,
        fromY = 0.1837,
        toPointID = 200471,
        toMap = 245,
        toX = 0.7368,
        toY = 0.6092,
        type = "portal",
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
                    value = 30,
                },
            },
        },
    },
    -- Stormwind City (map 84 73.30,16.87) -> Kelp'thar Forest (map 201 45.14,23.33) via portal
    {
        fromPointID = 200316,
        fromMap = 84,
        fromX = 0.733,
        fromY = 0.1687,
        toPointID = 200357,
        toMap = 201,
        toX = 0.4514,
        toY = 0.2333,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 25222,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 14482,
                },
            },
        },
    },
    -- Stormwind City (map 84 73.30,16.87) -> Shimmering Expanse (map 205 49.09,56.90) via portal
    {
        fromPointID = 200316,
        fromMap = 84,
        fromX = 0.733,
        fromY = 0.1687,
        toPointID = 200373,
        toMap = 205,
        toX = 0.4909,
        toY = 0.569,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 26219,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 25222,
                },
            },
        },
    },
    -- Stormwind City (map 84 73.30,16.87) -> Abyssal Depths (map 204 55.70,72.80) via portal
    {
        fromPointID = 200316,
        fromMap = 84,
        fromX = 0.733,
        fromY = 0.1687,
        toPointID = 200364,
        toMap = 204,
        toX = 0.557,
        toY = 0.728,
        type = "portal",
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
                    value = 26219,
                },
            },
        },
    },
    -- Stormwind City (map 84 75.24,20.50) -> Uldum (map 249 54.90,34.25) via portal
    {
        fromPointID = 200320,
        fromMap = 84,
        fromX = 0.7524,
        fromY = 0.205,
        toPointID = 100369,
        toMap = 249,
        toX = 0.549,
        toY = 0.3425,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 28112,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 75.34,16.43) -> Twilight Highlands (map 241 79.48,77.79) via portal
    {
        fromPointID = 200321,
        fromMap = 84,
        fromX = 0.7534,
        fromY = 0.1643,
        toPointID = 200429,
        toMap = 241,
        toX = 0.7948,
        toY = 0.7779,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 27537,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Stormwind City (map 84 76.20,18.69) -> Mount Hyjal (map 198 63.49,23.37) via portal
    {
        fromPointID = 200322,
        fromMap = 84,
        fromX = 0.762,
        fromY = 0.1869,
        toPointID = 100334,
        toMap = 198,
        toX = 0.6349,
        toY = 0.2337,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 25316,
                        },
                        {
                            operation = "check",
                            kind = "minLevel",
                            value = 50,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },

    -- Zone: Stratholme (map 317)
    -- Stratholme (map 317 64.46,88.52) -> Eastern Plaguelands (map 23 26.51,11.67) via portal
    {
        fromPointID = 200546,
        fromMap = 317,
        fromX = 0.6446,
        fromY = 0.8852,
        toPointID = 200088,
        toMap = 23,
        toX = 0.2651,
        toY = 0.1167,
        type = "portal",
    },
    -- Stratholme (map 317 68.02,88.46) -> Eastern Plaguelands (map 23 27.61,11.63) via portal
    {
        fromPointID = 200547,
        fromMap = 317,
        fromX = 0.6802,
        fromY = 0.8846,
        toPointID = 200089,
        toMap = 23,
        toX = 0.2761,
        toY = 0.1163,
        type = "portal",
    },

    -- Zone: Stratholme (map 318)
    -- Stratholme (map 318 67.74,86.29) -> Eastern Plaguelands (map 23 43.82,17.42) via portal
    {
        fromPointID = 200548,
        fromMap = 318,
        fromX = 0.6774,
        fromY = 0.8629,
        toPointID = 200092,
        toMap = 23,
        toX = 0.4382,
        toY = 0.1742,
        type = "portal",
    },

    -- Zone: Sunkiller Sanctum (map 2528)
    -- Sunkiller Sanctum (map 2528 65.11,28.37) -> Voidstorm (map 2405 54.78,47.28) via portal
    {
        fromPointID = 200819,
        fromMap = 2528,
        fromX = 0.6511,
        fromY = 0.2837,
        toPointID = 200693,
        toMap = 2405,
        toX = 0.5478,
        toY = 0.4728,
        type = "portal",
    },

    -- Zone: Sunwell Plateau (map 335)
    -- Sunwell Plateau (map 335 30.94,36.41) -> Isle of Quel'Danas (map 122 44.25,45.75) via portal
    {
        fromPointID = 200555,
        fromMap = 335,
        fromX = 0.3094,
        fromY = 0.3641,
        toPointID = 200345,
        toMap = 122,
        toX = 0.4425,
        toY = 0.4575,
        type = "portal",
    },

    -- Zone: Suramar (map 680)
    -- Suramar (map 680 30.83,11.02) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700144,
        fromMap = 680,
        fromX = 0.3083,
        fromY = 0.1102,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43808,
                },
            },
        },
    },
    -- Suramar (map 680 33.08,48.20) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700145,
        fromMap = 680,
        fromX = 0.3308,
        fromY = 0.482,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44062,
                },
            },
        },
    },
    -- Suramar (map 680 33.43,50.44) -> Hall of the Guardian (map 734 60.26,51.78) via portal
    {
        fromPointID = 700146,
        fromMap = 680,
        fromX = 0.3343,
        fromY = 0.5044,
        toPointID = 700259,
        toMap = 734,
        toX = 0.6026,
        toY = 0.5178,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Suramar (map 680 35.89,45.56) -> Suramar (map 684 41.38,15.05) via portal
    {
        fromPointID = 700151,
        fromMap = 680,
        fromX = 0.3589,
        fromY = 0.4556,
        toPointID = 700210,
        toMap = 684,
        toX = 0.4138,
        toY = 0.1505,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42230,
                },
            },
        },
    },
    -- Suramar (map 680 36.01,45.25) -> Suramar (map 680 30.79,10.87) via portal
    {
        fromPointID = 700152,
        fromMap = 680,
        fromX = 0.3601,
        fromY = 0.4525,
        toPointID = 700143,
        toMap = 680,
        toX = 0.3079,
        toY = 0.1087,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43808,
                },
            },
        },
    },
    -- Suramar (map 680 36.10,45.75) -> Suramar (map 682 52.35,36.75) via portal
    {
        fromPointID = 700153,
        fromMap = 680,
        fromX = 0.361,
        fromY = 0.4575,
        toPointID = 700207,
        toMap = 682,
        toX = 0.5235,
        toY = 0.3675,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41575,
                },
            },
        },
    },
    -- Suramar (map 680 36.10,47.23) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700154,
        fromMap = 680,
        fromX = 0.361,
        fromY = 0.4723,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 60,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40956,
                },
            },
        },
    },
    -- Suramar (map 680 36.16,45.05) -> Suramar (map 680 43.61,79.10) via portal
    {
        fromPointID = 700155,
        fromMap = 680,
        fromX = 0.3616,
        fromY = 0.4505,
        toPointID = 700177,
        toMap = 680,
        toX = 0.4361,
        toY = 0.791,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43811,
                },
            },
        },
    },
    -- Suramar (map 680 36.34,44.91) -> Suramar (map 680 36.31,46.89) via portal
    {
        fromPointID = 700157,
        fromMap = 680,
        fromX = 0.3634,
        fromY = 0.4491,
        toPointID = 700156,
        toMap = 680,
        toX = 0.3631,
        toY = 0.4689,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40956,
                },
            },
        },
    },
    -- Suramar (map 680 36.48,44.75) -> Suramar (map 680 47.45,81.97) via portal
    {
        fromPointID = 700159,
        fromMap = 680,
        fromX = 0.3648,
        fromY = 0.4475,
        toPointID = 700180,
        toMap = 680,
        toX = 0.4745,
        toY = 0.8197,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 38649,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42487,
                },
            },
        },
    },
    -- Suramar (map 680 36.49,44.75) -> Suramar (map 680 52.04,78.87) via portal
    {
        fromPointID = 700160,
        fromMap = 680,
        fromX = 0.3649,
        fromY = 0.4475,
        toPointID = 700185,
        toMap = 680,
        toX = 0.5204,
        toY = 0.7887,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42889,
                },
            },
        },
    },
    -- Suramar (map 680 36.70,44.64) -> Suramar (map 680 43.40,60.72) via portal
    {
        fromPointID = 700162,
        fromMap = 680,
        fromX = 0.367,
        fromY = 0.4464,
        toPointID = 700175,
        toMap = 680,
        toX = 0.434,
        toY = 0.6072,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43813,
                },
            },
        },
    },
    -- Suramar (map 680 36.77,45.04) -> Suramar (map 680 54.42,69.53) via portal
    {
        fromPointID = 700163,
        fromMap = 680,
        fromX = 0.3677,
        fromY = 0.4504,
        toPointID = 700187,
        toMap = 680,
        toX = 0.5442,
        toY = 0.6953,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44740,
                },
            },
        },
    },
    -- Suramar (map 680 36.92,44.66) -> Suramar (map 680 42.17,35.38) via portal
    {
        fromPointID = 700164,
        fromMap = 680,
        fromX = 0.3692,
        fromY = 0.4466,
        toPointID = 700173,
        toMap = 680,
        toX = 0.4217,
        toY = 0.3538,
        type = "portal",
        travelDuration = 5,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43809,
                },
            },
        },
    },
    -- Suramar (map 680 36.95,45.00) -> Suramar (map 680 64.09,60.80) via portal
    {
        fromPointID = 700165,
        fromMap = 680,
        fromX = 0.3695,
        fromY = 0.45,
        toPointID = 700196,
        toMap = 680,
        toX = 0.6409,
        toY = 0.608,
        type = "portal",
        travelDuration = 0,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44084,
                },
            },
        },
    },
    -- Suramar (map 680 41.08,61.75) -> The Arcway (map 749 47.99,21.47) via portal
    {
        fromPointID = 700170,
        fromMap = 680,
        fromX = 0.4108,
        fromY = 0.6175,
        toPointID = 700270,
        toMap = 749,
        toX = 0.4799,
        toY = 0.2147,
        type = "portal",
    },
    -- Suramar (map 680 42.03,35.24) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700171,
        fromMap = 680,
        fromX = 0.4203,
        fromY = 0.3524,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43809,
                },
            },
        },
    },
    -- Suramar (map 680 43.41,60.56) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700176,
        fromMap = 680,
        fromX = 0.4341,
        fromY = 0.6056,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 20,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43813,
                },
            },
        },
    },
    -- Suramar (map 680 43.68,79.25) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700178,
        fromMap = 680,
        fromX = 0.4368,
        fromY = 0.7925,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43811,
                },
            },
        },
    },
    -- Suramar (map 680 44.13,59.80) -> The Nighthold (map 764 24.00,91.20) via portal
    {
        fromPointID = 700179,
        fromMap = 680,
        fromX = 0.4413,
        fromY = 0.598,
        toPointID = 700279,
        toMap = 764,
        toX = 0.24,
        toY = 0.912,
        type = "portal",
    },
    -- Suramar (map 680 47.73,81.38) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700181,
        fromMap = 680,
        fromX = 0.4773,
        fromY = 0.8138,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 38649,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42487,
                },
            },
        },
    },
    -- Suramar (map 680 50.68,65.49) -> Court of Stars (map 761 6.84,68.64) via portal
    {
        fromPointID = 700182,
        fromMap = 680,
        fromX = 0.5068,
        fromY = 0.6549,
        toPointID = 700274,
        toMap = 761,
        toX = 0.0684,
        toY = 0.6864,
        type = "portal",
    },
    -- Suramar (map 680 51.98,78.75) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700184,
        fromMap = 680,
        fromX = 0.5198,
        fromY = 0.7875,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42889,
                },
            },
        },
    },
    -- Suramar (map 680 54.47,69.44) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700188,
        fromMap = 680,
        fromX = 0.5447,
        fromY = 0.6944,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44740,
                },
            },
        },
    },
    -- Suramar (map 680 54.48,69.43) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700189,
        fromMap = 680,
        fromX = 0.5448,
        fromY = 0.6943,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 45317,
                },
            },
        },
    },
    -- Suramar (map 680 58.18,87.33) -> Orgrimmar (map 85 40.24,78.12) via portal
    {
        fromPointID = 700191,
        fromMap = 680,
        fromX = 0.5818,
        fromY = 0.8733,
        toPointID = 100256,
        toMap = 85,
        toX = 0.4024,
        toY = 0.7812,
        type = "portal",
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
                    kind = "race",
                    value = "Nightborne",
                },
            },
        },
    },
    -- Suramar (map 680 58.68,87.63) -> Suramar (map 680 59.55,85.29) via portal
    {
        fromPointID = 700192,
        fromMap = 680,
        fromX = 0.5868,
        fromY = 0.8763,
        toPointID = 700194,
        toMap = 680,
        toX = 0.5955,
        toY = 0.8529,
        type = "portal",
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
                    kind = "minLevel",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "race",
                    value = "Nightborne",
                },
            },
        },
    },
    -- Suramar (map 680 64.00,60.43) -> Suramar (map 680 36.40,45.09) via portal
    {
        fromPointID = 700195,
        fromMap = 680,
        fromX = 0.64,
        fromY = 0.6043,
        toPointID = 700158,
        toMap = 680,
        toX = 0.364,
        toY = 0.4509,
        type = "portal",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44084,
                },
            },
        },
    },

    -- Zone: Swamp of Sorrows (map 51)
    -- Swamp of Sorrows (map 51 76.09,45.25) -> The Temple of Atal'Hakkar (map 220 0.00,0.00) via portal
    {
        fromPointID = 200247,
        fromMap = 51,
        fromX = 0.7609,
        fromY = 0.4525,
        toPointID = 200392,
        toMap = 220,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Tak-Rethan Abyss (map 2259)
    -- Tak-Rethan Abyss (map 2259 52.74,12.96) -> Nerub'ar (map 2216 67.66,24.65) via portal
    {
        fromPointID = 1200077,
        fromMap = 2259,
        fromX = 0.5274,
        fromY = 0.1296,
        toPointID = 1200042,
        toMap = 2216,
        toX = 0.6766,
        toY = 0.2465,
        type = "portal",
    },

    -- Zone: Talador (map 535)
    -- Talador (map 535 46.40,73.80) -> Auchindoun (map 593 49.70,90.20) via portal
    {
        fromPointID = 600042,
        fromMap = 535,
        fromX = 0.464,
        fromY = 0.738,
        toPointID = 600127,
        toMap = 593,
        toX = 0.497,
        toY = 0.902,
        type = "portal",
    },
    -- Talador (map 535 50.41,35.19) -> Terokkar Forest (map 108 35.26,12.51) via portal
    {
        fromPointID = 600043,
        fromMap = 535,
        fromX = 0.5041,
        fromY = 0.3519,
        toPointID = 300078,
        toMap = 108,
        toX = 0.3526,
        toY = 0.1251,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Talador (map 535 57.85,80.53) -> Terokkar Forest (map 108 45.37,47.53) via portal
    {
        fromPointID = 600049,
        fromMap = 535,
        fromX = 0.5785,
        fromY = 0.8053,
        toPointID = 300084,
        toMap = 108,
        toX = 0.4537,
        toY = 0.4753,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Talador (map 535 68.42,9.32) -> Zangarmarsh (map 102 82.59,66.13) via portal
    {
        fromPointID = 600052,
        fromMap = 535,
        fromX = 0.6842,
        fromY = 0.0932,
        toPointID = 300047,
        toMap = 102,
        toX = 0.8259,
        toY = 0.6613,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Tanaan Jungle (map 534)
    -- Tanaan Jungle (map 534 45.60,53.54) -> Hellfire Citadel (map 661 70.20,43.80) via portal
    {
        fromPointID = 600029,
        fromMap = 534,
        fromX = 0.456,
        fromY = 0.5354,
        toPointID = 600143,
        toMap = 661,
        toX = 0.702,
        toY = 0.438,
        type = "portal",
    },
    -- Tanaan Jungle (map 534 49.56,50.73) -> Hellfire Peninsula (map 100 54.98,48.87) via portal
    {
        fromPointID = 600031,
        fromMap = 534,
        fromX = 0.4956,
        fromY = 0.5073,
        toPointID = 300010,
        toMap = 100,
        toX = 0.5498,
        toY = 0.4887,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Tanaan Jungle (map 534 56.34,26.83) -> Hellfire Peninsula (map 100 64.04,21.73) via portal
    {
        fromPointID = 600032,
        fromMap = 534,
        fromX = 0.5634,
        fromY = 0.2683,
        toPointID = 300013,
        toMap = 100,
        toX = 0.6404,
        toY = 0.2173,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Tanaan Jungle (map 534 57.45,60.48) -> Stormshield (map 622 31.71,52.48) via portal
    {
        fromPointID = 600033,
        fromMap = 534,
        fromX = 0.5745,
        fromY = 0.6048,
        toPointID = 600134,
        toMap = 622,
        toX = 0.3171,
        toY = 0.5248,
        type = "portal",
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
                    value = 38445,
                },
            },
        },
    },
    -- Tanaan Jungle (map 534 61.02,47.35) -> Warspear (map 624 44.42,35.53) via portal
    {
        fromPointID = 600036,
        fromMap = 534,
        fromX = 0.6102,
        fromY = 0.4735,
        toPointID = 600138,
        toMap = 624,
        toX = 0.4442,
        toY = 0.3553,
        type = "portal",
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
                    value = 37935,
                },
            },
        },
    },
    -- Tanaan Jungle (map 534 70.30,54.53) -> Hellfire Peninsula (map 100 80.38,51.60) via portal
    {
        fromPointID = 600037,
        fromMap = 534,
        fromX = 0.703,
        fromY = 0.5453,
        toPointID = 300015,
        toMap = 100,
        toX = 0.8038,
        toY = 0.516,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Tanaris (map 71)
    -- Tanaris (map 71 39.21,21.21) -> Zul'Farrak (map 219 0.00,0.00) via portal
    {
        fromPointID = 100187,
        fromMap = 71,
        fromX = 0.3921,
        fromY = 0.2121,
        toPointID = 100343,
        toMap = 219,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1989)
    -- Tazavesh, the Veiled Market (map 1989 0.00,0.00) -> Tazavesh (map 2472 36.41,11.99) via portal
    {
        fromPointID = 1000331,
        fromMap = 1989,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1200231,
        toMap = 2472,
        toX = 0.3641,
        toY = 0.1199,
        type = "portal",
    },

    -- Zone: Tazavesh (map 2472)
    -- Tazavesh (map 2472 36.41,11.99) -> Tazavesh, the Veiled Market (map 1989 0.00,0.00) via portal
    {
        fromPointID = 1200231,
        fromMap = 2472,
        fromX = 0.3641,
        fromY = 0.1199,
        toPointID = 1000331,
        toMap = 1989,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Tazavesh (map 2472 43.88,3.76) -> Eco-Dome Al'dani (map 2449 0.00,0.00) via portal
    {
        fromPointID = 1200234,
        fromMap = 2472,
        fromX = 0.4388,
        fromY = 0.0376,
        toPointID = 1200196,
        toMap = 2449,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Tazavesh (map 2472 60.34,93.45) -> The Maw (map 1543 24.89,36.95) via portal
    {
        fromPointID = 1200235,
        fromMap = 2472,
        fromX = 0.6034,
        fromY = 0.9345,
        toPointID = 1000092,
        toMap = 1543,
        toX = 0.2489,
        toY = 0.3695,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 85214,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 85214,
                        },
                    },
                },
            },
        },
    },
    -- Tazavesh (map 2472 62.58,94.40) -> Dornogal (map 2339 40.31,22.70) via portal
    {
        fromPointID = 1200236,
        fromMap = 2472,
        fromX = 0.6258,
        fromY = 0.944,
        toPointID = 1200123,
        toMap = 2339,
        toX = 0.4031,
        toY = 0.227,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84957,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84957,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Teldrassil (map 57)
    -- Teldrassil (map 57 52.27,89.47) -> Azuremyst Isle (map 97 20.52,54.16) via portal
    {
        fromPointID = 100067,
        fromMap = 57,
        fromX = 0.5227,
        fromY = 0.8947,
        toPointID = 100304,
        toMap = 97,
        toX = 0.2052,
        toY = 0.5416,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },
    -- Teldrassil (map 57 55.03,93.72) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 100070,
        fromMap = 57,
        fromX = 0.5503,
        fromY = 0.9372,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },
    -- Teldrassil (map 57 55.07,88.38) -> Darnassus (map 89 36.79,50.44) via portal
    {
        fromPointID = 100071,
        fromMap = 57,
        fromX = 0.5507,
        fromY = 0.8838,
        toPointID = 100298,
        toMap = 89,
        toX = 0.3679,
        toY = 0.5044,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Darnassus",
                },
            },
        },
    },

    -- Zone: Telogrus Rift (map 971)
    -- Telogrus Rift (map 971 24.94,27.91) -> Dalaran L (map 629 35.93,74.75) via portal
    {
        fromPointID = 700344,
        fromMap = 971,
        fromX = 0.2494,
        fromY = 0.2791,
        toPointID = 700041,
        toMap = 629,
        toX = 0.3593,
        toY = 0.7475,
        type = "portal",
    },
    -- Telogrus Rift (map 971 27.99,21.48) -> Stormwind City (map 84 54.52,17.26) via portal
    {
        fromPointID = 700347,
        fromMap = 971,
        fromX = 0.2799,
        fromY = 0.2148,
        toPointID = 200309,
        toMap = 84,
        toX = 0.5452,
        toY = 0.1726,
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
    },

    -- Zone: Tempest Keep (map 334)
    -- Tempest Keep (map 334 50.06,91.93) -> Netherstorm (map 109 73.56,63.71) via portal
    {
        fromPointID = 300146,
        fromMap = 334,
        fromX = 0.5006,
        fromY = 0.9193,
        toPointID = 300098,
        toMap = 109,
        toX = 0.7356,
        toY = 0.6371,
        type = "portal",
    },

    -- Zone: Temple of Sethraliss (map 1038)
    -- Temple of Sethraliss (map 1038 0.00,0.00) -> Vol'dun (map 864 51.94,24.78) via portal
    {
        fromPointID = 900069,
        fromMap = 1038,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 900060,
        toMap = 864,
        toX = 0.5194,
        toY = 0.2478,
        type = "portal",
    },

    -- Zone: Temple of the Jade Serpent (map 429)
    -- Temple of the Jade Serpent (map 429 31.40,45.00) -> The Jade Forest (map 371 56.20,57.90) via portal
    {
        fromPointID = 500144,
        fromMap = 429,
        fromX = 0.314,
        fromY = 0.45,
        toPointID = 500023,
        toMap = 371,
        toX = 0.562,
        toY = 0.579,
        type = "portal",
    },

    -- Zone: Terokkar Forest (map 108)
    -- Terokkar Forest (map 108 34.30,65.61) -> Auchenai Crypts (map 256 44.12,75.10) via portal
    {
        fromPointID = 300077,
        fromMap = 108,
        fromX = 0.343,
        fromY = 0.6561,
        toPointID = 300111,
        toMap = 256,
        toX = 0.4412,
        toY = 0.751,
        type = "portal",
    },
    -- Terokkar Forest (map 108 35.26,12.51) -> Talador (map 535 50.41,35.19) via portal
    {
        fromPointID = 300078,
        fromMap = 108,
        fromX = 0.3526,
        fromY = 0.1251,
        toPointID = 600043,
        toMap = 535,
        toX = 0.5041,
        toY = 0.3519,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Terokkar Forest (map 108 39.63,73.60) -> Shadow Labyrinth (map 260 22.01,12.45) via portal
    {
        fromPointID = 300081,
        fromMap = 108,
        fromX = 0.3963,
        fromY = 0.736,
        toPointID = 300119,
        toMap = 260,
        toX = 0.2201,
        toY = 0.1245,
        type = "portal",
    },
    -- Terokkar Forest (map 108 39.64,57.63) -> Mana-Tombs (map 272 33.52,17.29) via portal
    {
        fromPointID = 300082,
        fromMap = 108,
        fromX = 0.3964,
        fromY = 0.5763,
        toPointID = 300142,
        toMap = 272,
        toX = 0.3352,
        toY = 0.1729,
        type = "portal",
    },
    -- Terokkar Forest (map 108 44.95,65.61) -> Sethekk Halls (map 258 73.35,36.47) via portal
    {
        fromPointID = 300083,
        fromMap = 108,
        fromX = 0.4495,
        fromY = 0.6561,
        toPointID = 300116,
        toMap = 258,
        toX = 0.7335,
        toY = 0.3647,
        type = "portal",
    },
    -- Terokkar Forest (map 108 45.37,47.53) -> Talador (map 535 57.85,80.53) via portal
    {
        fromPointID = 300084,
        fromMap = 108,
        fromX = 0.4537,
        fromY = 0.4753,
        toPointID = 600049,
        toMap = 535,
        toX = 0.5785,
        toY = 0.8053,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Terokkar Forest (map 108 70.78,75.88) -> Spires of Arak (map 542 47.40,12.45) via portal
    {
        fromPointID = 300088,
        fromMap = 108,
        fromX = 0.7078,
        fromY = 0.7588,
        toPointID = 600081,
        toMap = 542,
        toX = 0.474,
        toY = 0.1245,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Terrace of Endless Spring (map 456)
    -- Terrace of Endless Spring (map 456 93.40,49.70) -> The Veiled Stair (map 433 48.45,61.44) via portal
    {
        fromPointID = 500185,
        fromMap = 456,
        fromX = 0.934,
        fromY = 0.497,
        toPointID = 500149,
        toMap = 433,
        toX = 0.4845,
        toY = 0.6144,
        type = "portal",
    },

    -- Zone: Thaldraszus (map 2025)
    -- Thaldraszus (map 2025 58.27,42.22) -> Algeth'ar Academy (map 2099 0.00,0.00) via portal
    {
        fromPointID = 1100067,
        fromMap = 2025,
        fromX = 0.5827,
        fromY = 0.4222,
        toPointID = 1100100,
        toMap = 2099,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Thaldraszus (map 2025 59.13,60.44) -> Halls of Infusion (map 2082 0.00,0.00) via portal
    {
        fromPointID = 1100069,
        fromMap = 2025,
        fromX = 0.5913,
        fromY = 0.6044,
        toPointID = 1100088,
        toMap = 2082,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Thaldraszus (map 2025 61.16,84.49) -> Dawn of the Infinite (map 2190 33.17,20.88) via portal
    {
        fromPointID = 1100072,
        fromMap = 2025,
        fromX = 0.6116,
        fromY = 0.8449,
        toPointID = 1100180,
        toMap = 2190,
        toX = 0.3317,
        toY = 0.2088,
        type = "portal",
    },
    -- Thaldraszus (map 2025 73.15,55.61) -> Vault of the Incarnates (map 2122 0.00,0.00) via portal
    {
        fromPointID = 1100075,
        fromMap = 2025,
        fromX = 0.7315,
        fromY = 0.5561,
        toPointID = 1100122,
        toMap = 2122,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: The Arcatraz (map 269)
    -- The Arcatraz (map 269 41.26,81.70) -> Netherstorm (map 109 74.49,57.68) via portal
    {
        fromPointID = 300137,
        fromMap = 269,
        fromX = 0.4126,
        fromY = 0.817,
        toPointID = 300099,
        toMap = 109,
        toX = 0.7449,
        toY = 0.5768,
        type = "portal",
    },

    -- Zone: The Arcway (map 749)
    -- The Arcway (map 749 47.99,21.47) -> Suramar (map 680 41.08,61.75) via portal
    {
        fromPointID = 700270,
        fromMap = 749,
        fromX = 0.4799,
        fromY = 0.2147,
        toPointID = 700170,
        toMap = 680,
        toX = 0.4108,
        toY = 0.6175,
        type = "portal",
    },

    -- Zone: The Azure Span (map 2024)
    -- The Azure Span (map 2024 11.48,48.91) -> Brackenhide Hollow (map 2096 0.00,0.00) via portal
    {
        fromPointID = 1100046,
        fromMap = 2024,
        fromX = 0.1148,
        fromY = 0.4891,
        toPointID = 1100095,
        toMap = 2096,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- The Azure Span (map 2024 38.86,64.90) -> The Azure Vault (map 2073 0.00,0.00) via portal
    {
        fromPointID = 1100057,
        fromMap = 2024,
        fromX = 0.3886,
        fromY = 0.649,
        toPointID = 1100076,
        toMap = 2073,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- The Azure Span (map 2024 73.67,70.52) -> The Azure Span (map 2024 13.84,50.47) via portal
    {
        fromPointID = 1100061,
        fromMap = 2024,
        fromX = 0.7367,
        fromY = 0.7052,
        toPointID = 1100048,
        toMap = 2024,
        toX = 0.1384,
        toY = 0.5047,
        type = "portal",
    },

    -- Zone: The Azure Vault (map 2073)
    -- The Azure Vault (map 2073 0.00,0.00) -> The Azure Span (map 2024 38.86,64.90) via portal
    {
        fromPointID = 1100076,
        fromMap = 2073,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100057,
        toMap = 2024,
        toX = 0.3886,
        toY = 0.649,
        type = "portal",
    },

    -- Zone: The Bastion of Twilight (map 294)
    -- The Bastion of Twilight (map 294 39.30,53.30) -> Twilight Highlands (map 241 33.97,77.93) via portal
    {
        fromPointID = 200518,
        fromMap = 294,
        fromX = 0.393,
        fromY = 0.533,
        toPointID = 200414,
        toMap = 241,
        toX = 0.3397,
        toY = 0.7793,
        type = "portal",
    },

    -- Zone: The Black Morass (map 273)
    -- The Black Morass (map 273 52.06,0.15) -> Tanaris (map 75 36.30,83.20) via portal
    {
        fromPointID = 100375,
        fromMap = 273,
        fromX = 0.5206,
        fromY = 0.0015,
        toPointID = 100208,
        toMap = 75,
        toX = 0.363,
        toY = 0.832,
        type = "portal",
    },

    -- Zone: The Blinding Vale (map 2500)
    -- The Blinding Vale (map 2500 0.00,0.00) -> Harandar (map 2413 26.24,78.09) via portal
    {
        fromPointID = 200748,
        fromMap = 2500,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200695,
        toMap = 2413,
        toX = 0.2624,
        toY = 0.7809,
        type = "portal",
    },

    -- Zone: The Blood Furnace (map 261)
    -- The Blood Furnace (map 261 47.75,90.56) -> Hellfire Peninsula (map 100 45.95,51.87) via portal
    {
        fromPointID = 300120,
        fromMap = 261,
        fromX = 0.4775,
        fromY = 0.9056,
        toPointID = 300005,
        toMap = 100,
        toX = 0.4595,
        toY = 0.5187,
        type = "portal",
    },

    -- Zone: The Botanica (map 266)
    -- The Botanica (map 266 89.59,41.09) -> Netherstorm (map 109 71.76,54.93) via portal
    {
        fromPointID = 300132,
        fromMap = 266,
        fromX = 0.8959,
        fromY = 0.4109,
        toPointID = 300097,
        toMap = 109,
        toX = 0.7176,
        toY = 0.5493,
        type = "portal",
    },

    -- Zone: The Coiled Isle (map 2512)
    -- The Coiled Isle (map 2512 51.23,30.26) -> Venomfall Deeps (map 2634 50.02,94.76) via portal
    {
        fromPointID = 200789,
        fromMap = 2512,
        fromX = 0.5123,
        fromY = 0.3026,
        toPointID = 200890,
        toMap = 2634,
        toX = 0.5002,
        toY = 0.9476,
        type = "portal",
    },
    -- The Coiled Isle (map 2512 58.17,48.48) -> Silvermoon City M (map 2393 56.88,67.48) via portal
    {
        fromPointID = 200793,
        fromMap = 2512,
        fromX = 0.5817,
        fromY = 0.4848,
        toPointID = 200669,
        toMap = 2393,
        toX = 0.5688,
        toY = 0.6748,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96532,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96532,
                        },
                    },
                },
            },
        },
    },
    -- The Coiled Isle (map 2512 59.57,66.33) -> The Tidebound Grotto (map 2632 26.11,26.36) via portal
    {
        fromPointID = 200794,
        fromMap = 2512,
        fromX = 0.5957,
        fromY = 0.6633,
        toPointID = 200889,
        toMap = 2632,
        toX = 0.2611,
        toY = 0.2636,
        type = "portal",
    },
    -- The Coiled Isle (map 2512 64.40,77.79) -> Gnarldor Isle (map 2635 77.03,46.37) via portal
    {
        fromPointID = 200795,
        fromMap = 2512,
        fromX = 0.644,
        fromY = 0.7779,
        toPointID = 200891,
        toMap = 2635,
        toX = 0.7703,
        toY = 0.4637,
        type = "portal",
    },

    -- Zone: The Culling of Stratholme (map 130)
    -- The Culling of Stratholme (map 130 87.51,71.21) -> Tanaris (map 75 57.40,82.60) via portal
    {
        fromPointID = 100319,
        fromMap = 130,
        fromX = 0.8751,
        fromY = 0.7121,
        toPointID = 100209,
        toMap = 75,
        toX = 0.574,
        toY = 0.826,
        type = "portal",
    },

    -- Zone: The Darkway (map 2525)
    -- The Darkway (map 2525 44.71,15.45) -> Silvermoon City M (map 2393 39.32,31.68) via portal
    {
        fromPointID = 200813,
        fromMap = 2525,
        fromX = 0.4471,
        fromY = 0.1545,
        toPointID = 200660,
        toMap = 2393,
        toX = 0.3932,
        toY = 0.3168,
        type = "portal",
    },

    -- Zone: The Dawnbreaker (map 2359)
    -- The Dawnbreaker (map 2359 76.14,78.68) -> Hallowfall (map 2215 54.94,63.17) via portal
    {
        fromPointID = 1200154,
        fromMap = 2359,
        fromX = 0.7614,
        fromY = 0.7868,
        toPointID = 1200034,
        toMap = 2215,
        toX = 0.5494,
        toY = 0.6317,
        type = "portal",
    },

    -- Zone: The Deadmines (map 291)
    -- The Deadmines (map 291 26.50,13.40) -> Westfall (map 55 25.80,51.10) via portal
    {
        fromPointID = 200513,
        fromMap = 291,
        fromX = 0.265,
        fromY = 0.134,
        toPointID = 200257,
        toMap = 55,
        toX = 0.258,
        toY = 0.511,
        type = "portal",
    },

    -- Zone: The Deadmines (map 292)
    -- The Deadmines (map 292 96.17,51.66) -> Westfall (map 52 41.15,83.19) via portal
    {
        fromPointID = 200516,
        fromMap = 292,
        fromX = 0.9617,
        fromY = 0.5166,
        toPointID = 200248,
        toMap = 52,
        toX = 0.4115,
        toY = 0.8319,
        type = "portal",
    },

    -- Zone: The Deadmines (map 55)
    -- Westfall (map 55 25.80,51.10) -> The Deadmines (map 291 26.50,13.40) via portal
    {
        fromPointID = 200257,
        fromMap = 55,
        fromX = 0.258,
        fromY = 0.511,
        toPointID = 200513,
        toMap = 291,
        toX = 0.265,
        toY = 0.134,
        type = "portal",
    },

    -- Zone: The Den (map 2576)
    -- Harandar (map 2576 61.78,73.48) -> Voidstorm (map 2405 51.64,70.20) via portal
    {
        fromPointID = 200846,
        fromMap = 2576,
        fromX = 0.6178,
        fromY = 0.7348,
        toPointID = 200691,
        toMap = 2405,
        toX = 0.5164,
        toY = 0.702,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "achievement",
                    value = 41806,
                },
            },
        },
    },

    -- Zone: The Dread Pit (map 2302)
    -- The Dread Pit (map 2302 24.81,63.98) -> The Ringing Deeps (map 2214 70.26,37.15) via portal
    {
        fromPointID = 1200094,
        fromMap = 2302,
        fromX = 0.2481,
        fromY = 0.6398,
        toPointID = 1200020,
        toMap = 2214,
        toX = 0.7026,
        toY = 0.3715,
        type = "portal",
    },

    -- Zone: The Dreamgrove (map 747)
    -- The Dreamgrove (map 747 55.66,22.09) -> Emerald Dreamway (map 715 45.10,26.49) via portal
    {
        fromPointID = 700268,
        fromMap = 747,
        fromX = 0.5566,
        fromY = 0.2209,
        toPointID = 700233,
        toMap = 715,
        toX = 0.451,
        toY = 0.2649,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },
    -- The Dreamgrove (map 747 56.51,43.10) -> Dalaran L (map 627 67.52,46.47) via portal
    {
        fromPointID = 700269,
        fromMap = 747,
        fromX = 0.5651,
        fromY = 0.431,
        toPointID = 700028,
        toMap = 627,
        toX = 0.6752,
        toY = 0.4647,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: The Dreamrift (map 2531)
    -- Dreamrift (map 2531 0.00,0.00) -> Harandar (map 2413 61.33,63.01) via portal
    {
        fromPointID = 200823,
        fromMap = 2531,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200702,
        toMap = 2413,
        toX = 0.6133,
        toY = 0.6301,
        type = "portal",
    },

    -- Zone: The Emerald Nightmare (map 777)
    -- The Emerald Nightmare (map 777 43.90,58.40) -> Val'sharah (map 641 56.40,37.00) via portal
    {
        fromPointID = 700280,
        fromMap = 777,
        fromX = 0.439,
        fromY = 0.584,
        toPointID = 700100,
        toMap = 641,
        toX = 0.564,
        toY = 0.37,
        type = "portal",
    },

    -- Zone: The Eternal Palace (map 1512)
    -- The Eternal Palace (map 1512 0.00,0.00) -> The Eternal Palace (map 1528 47.34,31.90) via portal
    {
        fromPointID = 1300034,
        fromMap = 1512,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1300049,
        toMap = 1528,
        toX = 0.4734,
        toY = 0.319,
        type = "portal",
    },

    -- Zone: The Everbloom (map 620)
    -- The Everbloom (map 620 72.40,55.70) -> Gorgrond (map 543 59.60,45.60) via portal
    {
        fromPointID = 600133,
        fromMap = 620,
        fromX = 0.724,
        fromY = 0.557,
        toPointID = 600102,
        toMap = 543,
        toX = 0.596,
        toY = 0.456,
        type = "portal",
    },

    -- Zone: The Exodar (map 103)
    -- The Exodar (map 103 48.34,62.94) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 100313,
        fromMap = 103,
        fromX = 0.4834,
        fromY = 0.6294,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
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
    },

    -- Zone: The Eye of Eternity (map 881)
    -- The Eye of Eternity (map 881 31.80,59.50) -> Borean Tundra (map 114 27.55,26.65) via portal
    {
        fromPointID = 400242,
        fromMap = 881,
        fromX = 0.318,
        fromY = 0.595,
        toPointID = 400002,
        toMap = 114,
        toX = 0.2755,
        toY = 0.2665,
        type = "portal",
    },

    -- Zone: The Forge of Souls (map 183)
    -- The Forge of Souls (map 183 66.05,88.89) -> Icecrown (map 118 54.92,89.76) via portal
    {
        fromPointID = 400211,
        fromMap = 183,
        fromX = 0.6605,
        fromY = 0.8889,
        toPointID = 400072,
        toMap = 118,
        toX = 0.5492,
        toY = 0.8976,
        type = "portal",
    },

    -- Zone: The Forgotten Vault (map 2375)
    -- The Forgotten Vault (map 2375 61.39,12.70) -> Siren Isle (map 2369 50.32,15.37) via portal
    {
        fromPointID = 1200168,
        fromMap = 2375,
        fromX = 0.6139,
        fromY = 0.127,
        toPointID = 1200156,
        toMap = 2369,
        toX = 0.5032,
        toY = 0.1537,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84723,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84723,
                        },
                    },
                },
            },
        },
    },

    -- Zone: The Hinterlands (map 26)
    -- The Hinterlands (map 26 62.30,22.62) -> Emerald Dreamway (map 715 49.42,62.50) via portal
    {
        fromPointID = 200115,
        fromMap = 26,
        fromX = 0.623,
        fromY = 0.2262,
        toPointID = 700235,
        toMap = 715,
        toX = 0.4942,
        toY = 0.625,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40645,
                },
            },
        },
    },

    -- Zone: The Jade Forest (map 371)
    -- The Jade Forest (map 371 28.52,14.02) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 500002,
        fromMap = 371,
        fromX = 0.2852,
        fromY = 0.1402,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
    -- The Jade Forest (map 371 43.83,41.73) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 500007,
        fromMap = 371,
        fromX = 0.4383,
        fromY = 0.4173,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- The Jade Forest (map 371 43.83,41.73) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 500007,
        fromMap = 371,
        fromX = 0.4383,
        fromY = 0.4173,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- The Jade Forest (map 371 46.24,85.17) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 500016,
        fromMap = 371,
        fromX = 0.4624,
        fromY = 0.8517,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                    value = 31735,
                },
            },
        },
    },
    -- The Jade Forest (map 371 56.20,57.90) -> Temple of the Jade Serpent (map 429 31.40,45.00) via portal
    {
        fromPointID = 500023,
        fromMap = 371,
        fromX = 0.562,
        fromY = 0.579,
        toPointID = 500144,
        toMap = 429,
        toX = 0.314,
        toY = 0.45,
        type = "portal",
    },

    -- Zone: The Lycaneum (map 2649)
    -- The Lycaneum (map 2649 55.86,11.64) -> Silvermoon City M (map 2393 52.85,65.51) via portal
    {
        fromPointID = 200904,
        fromMap = 2649,
        fromX = 0.5586,
        fromY = 0.1164,
        toPointID = 200667,
        toMap = 2393,
        toX = 0.5285,
        toY = 0.6551,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 96233,
                },
            },
        },
    },

    -- Zone: The MOTHERLODE!! (map 1010)
    -- The MOTHERLODE!! (map 1010 0.00,0.00) -> Zuldazar (map 862 39.24,71.41) via portal
    {
        fromPointID = 1300025,
        fromMap = 1010,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 900004,
        toMap = 862,
        toX = 0.3924,
        toY = 0.7141,
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
    },
    -- The MOTHERLODE!! (map 1010 0.00,0.00) -> Dazar'alor (map 1165 44.25,92.62) via portal
    {
        fromPointID = 1300025,
        fromMap = 1010,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 900087,
        toMap = 1165,
        toX = 0.4425,
        toY = 0.9262,
        type = "portal",
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

    -- Zone: The Maelstrom (map 726)
    -- The Maelstrom L (map 726 26.71,41.32) -> The Vortex Pinnacle L (map 737 54.14,16.85) via portal
    {
        fromPointID = 700245,
        fromMap = 726,
        fromX = 0.2671,
        fromY = 0.4132,
        toPointID = 100451,
        toMap = 737,
        toX = 0.5414,
        toY = 0.1685,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43002,
                },
            },
        },
    },
    -- The Maelstrom L (map 726 29.78,51.98) -> Dalaran L (map 627 67.52,46.47) via portal
    {
        fromPointID = 700247,
        fromMap = 726,
        fromX = 0.2978,
        fromY = 0.5198,
        toPointID = 700028,
        toMap = 627,
        toX = 0.6752,
        toY = 0.4647,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 39746,
                },
            },
        },
    },
    -- The Maelstrom L (map 726 31.08,61.02) -> Firelands L (map 738 25.79,89.25) via portal
    {
        fromPointID = 700250,
        fromMap = 726,
        fromX = 0.3108,
        fromY = 0.6102,
        toPointID = 100453,
        toMap = 738,
        toX = 0.2579,
        toY = 0.8925,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 42208,
                },
            },
        },
    },

    -- Zone: The Maw (map 1543)
    -- The Maw (map 1543 19.16,47.73) -> The Maw (map 1543 25.18,17.88) via portal
    {
        fromPointID = 1000086,
        fromMap = 1543,
        fromX = 0.1916,
        fromY = 0.4773,
        toPointID = 1000093,
        toMap = 1543,
        toX = 0.2518,
        toY = 0.1788,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 23.01,44.03) -> Fungal Terminus (map 1819 65.75,73.60) via portal
    {
        fromPointID = 1000089,
        fromMap = 1543,
        fromX = 0.2301,
        fromY = 0.4403,
        toPointID = 1000296,
        toMap = 1819,
        toX = 0.6575,
        toY = 0.736,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "NightFae",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63823,
                },
            },
        },
    },
    -- The Maw (map 1543 23.48,31.23) -> The Maw (map 1543 34.81,43.69) via portal
    {
        fromPointID = 1000091,
        fromMap = 1543,
        fromX = 0.2348,
        fromY = 0.3123,
        toPointID = 1000103,
        toMap = 1543,
        toX = 0.3481,
        toY = 0.4369,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 24.89,36.95) -> Tazavesh (map 2472 60.34,93.45) via portal
    {
        fromPointID = 1000092,
        fromMap = 1543,
        fromX = 0.2489,
        fromY = 0.3695,
        toPointID = 1200235,
        toMap = 2472,
        toX = 0.6034,
        toY = 0.9345,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 85214,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 85214,
                        },
                    },
                },
            },
        },
    },
    -- The Maw (map 1543 25.18,17.88) -> The Maw (map 1543 19.16,47.73) via portal
    {
        fromPointID = 1000093,
        fromMap = 1543,
        fromX = 0.2518,
        fromY = 0.1788,
        toPointID = 1000086,
        toMap = 1543,
        toX = 0.1916,
        toY = 0.4773,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 29.69,18.27) -> Sinfall (map 1699 37.98,59.26) via portal
    {
        fromPointID = 1000095,
        fromMap = 1543,
        fromX = 0.2969,
        fromY = 0.1827,
        toPointID = 1000238,
        toMap = 1699,
        toX = 0.3798,
        toY = 0.5926,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Venthyr",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63822,
                },
            },
        },
    },
    -- The Maw (map 1543 33.72,54.84) -> The Maw (map 1543 41.12,58.70) via portal
    {
        fromPointID = 1000097,
        fromMap = 1543,
        fromX = 0.3372,
        fromY = 0.5484,
        toPointID = 1000106,
        toMap = 1543,
        toX = 0.4112,
        toY = 0.587,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63543,
                },
            },
        },
    },
    -- The Maw (map 1543 33.89,56.71) -> The Maw (map 1543 68.78,36.80) via portal
    {
        fromPointID = 1000100,
        fromMap = 1543,
        fromX = 0.3389,
        fromY = 0.5671,
        toPointID = 1000122,
        toMap = 1543,
        toX = 0.6878,
        toY = 0.368,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60284,
                },
            },
        },
    },
    -- The Maw (map 1543 34.81,43.69) -> The Maw (map 1543 23.48,31.23) via portal
    {
        fromPointID = 1000103,
        fromMap = 1543,
        fromX = 0.3481,
        fromY = 0.4369,
        toPointID = 1000091,
        toMap = 1543,
        toX = 0.2348,
        toY = 0.3123,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 40.94,59.03) -> The Maw (map 1543 33.84,54.83) via portal
    {
        fromPointID = 1000105,
        fromMap = 1543,
        fromX = 0.4094,
        fromY = 0.5903,
        toPointID = 1000098,
        toMap = 1543,
        toX = 0.3384,
        toY = 0.5483,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63543,
                },
            },
        },
    },
    -- The Maw (map 1543 42.37,43.66) -> Elysian Hold (map 1707 46.14,66.19) via portal
    {
        fromPointID = 1000107,
        fromMap = 1543,
        fromX = 0.4237,
        fromY = 0.4366,
        toPointID = 1000265,
        toMap = 1707,
        toX = 0.4614,
        toY = 0.6619,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Kyrian",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 1,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63824,
                },
            },
        },
    },
    -- The Maw (map 1543 42.38,42.16) -> Oribos (map 1670 19.24,50.31) via portal
    {
        fromPointID = 1000108,
        fromMap = 1543,
        fromX = 0.4238,
        fromY = 0.4216,
        toPointID = 1000164,
        toMap = 1670,
        toX = 0.1924,
        toY = 0.5031,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 59874,
                },
            },
        },
    },
    -- The Maw (map 1543 43.45,58.40) -> Seat of the Primus (map 1698 58.92,34.24) via portal
    {
        fromPointID = 1000111,
        fromMap = 1543,
        fromX = 0.4345,
        fromY = 0.584,
        toPointID = 1000230,
        toMap = 1698,
        toX = 0.5892,
        toY = 0.3424,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "covenant",
                    value = "Necrolord",
                },
                {
                    operation = "check",
                    kind = "covenantNetworkMin",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63543,
                },
            },
        },
    },
    -- The Maw (map 1543 43.53,39.90) -> The Maw (map 1543 33.87,55.15) via portal
    {
        fromPointID = 1000112,
        fromMap = 1543,
        fromX = 0.4353,
        fromY = 0.399,
        toPointID = 1000099,
        toMap = 1543,
        toX = 0.3387,
        toY = 0.5515,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63543,
                },
            },
        },
    },
    -- The Maw (map 1543 43.53,39.91) -> The Maw (map 1543 35.00,26.80) via portal
    {
        fromPointID = 1000113,
        fromMap = 1543,
        fromX = 0.4353,
        fromY = 0.3991,
        toPointID = 1000104,
        toMap = 1543,
        toX = 0.35,
        toY = 0.268,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63822,
                },
            },
        },
    },
    -- The Maw (map 1543 43.53,39.91) -> The Maw (map 1543 22.41,43.09) via portal
    {
        fromPointID = 1000113,
        fromMap = 1543,
        fromX = 0.4353,
        fromY = 0.3991,
        toPointID = 1000087,
        toMap = 1543,
        toX = 0.2241,
        toY = 0.4309,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questActiveOrComplete",
                    value = 63823,
                },
            },
        },
    },
    -- The Maw (map 1543 48.20,39.39) -> Torghast (map 1911 16.29,47.08) via portal
    {
        fromPointID = 1000116,
        fromMap = 1543,
        fromX = 0.482,
        fromY = 0.3939,
        toPointID = 1000309,
        toMap = 1911,
        toX = 0.1629,
        toY = 0.4708,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60136,
                },
            },
        },
    },
    -- The Maw (map 1543 48.29,41.45) -> The Maw (map 1543 68.89,36.60) via portal
    {
        fromPointID = 1000117,
        fromMap = 1543,
        fromX = 0.4829,
        fromY = 0.4145,
        toPointID = 1000123,
        toMap = 1543,
        toX = 0.6889,
        toY = 0.366,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "achievement",
                    value = 15126,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 48.29,41.45) -> The Maw (map 1543 33.94,56.78) via portal
    {
        fromPointID = 1000117,
        fromMap = 1543,
        fromX = 0.4829,
        fromY = 0.4145,
        toPointID = 1000101,
        toMap = 1543,
        toX = 0.3394,
        toY = 0.5678,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60284,
                },
            },
        },
    },
    -- The Maw (map 1543 48.29,41.45) -> The Maw (map 1543 53.42,63.64) via portal
    {
        fromPointID = 1000117,
        fromMap = 1543,
        fromX = 0.4829,
        fromY = 0.4145,
        toPointID = 1000119,
        toMap = 1543,
        toX = 0.5342,
        toY = 0.6364,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60285,
                },
            },
        },
    },
    -- The Maw (map 1543 48.29,41.45) -> The Maw (map 1543 34.19,14.73) via portal
    {
        fromPointID = 1000117,
        fromMap = 1543,
        fromX = 0.4829,
        fromY = 0.4145,
        toPointID = 1000102,
        toMap = 1543,
        toX = 0.3419,
        toY = 0.1473,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
            },
        },
    },
    -- The Maw (map 1543 68.78,36.80) -> The Maw (map 1543 33.89,56.71) via portal
    {
        fromPointID = 1000122,
        fromMap = 1543,
        fromX = 0.6878,
        fromY = 0.368,
        toPointID = 1000100,
        toMap = 1543,
        toX = 0.3389,
        toY = 0.5671,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 61600,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60284,
                },
            },
        },
    },
    -- The Maw (map 1543 69.79,31.89) -> Sanctum of Domination (map 1998 0.00,0.00) via portal
    {
        fromPointID = 1000124,
        fromMap = 1543,
        fromX = 0.6979,
        fromY = 0.3189,
        toPointID = 1000346,
        toMap = 1998,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: The Mechanar (map 267)
    -- The Mechanar (map 267 49.41,83.51) -> Netherstorm (map 109 70.62,69.78) via portal
    {
        fromPointID = 300134,
        fromMap = 267,
        fromX = 0.4941,
        fromY = 0.8351,
        toPointID = 300096,
        toMap = 109,
        toX = 0.7062,
        toY = 0.6978,
        type = "portal",
    },

    -- Zone: The Mechanar (map 268)
    -- The Mechanar (map 268 27.34,73.16) -> Netherstorm (map 109 70.54,69.64) via portal
    {
        fromPointID = 300135,
        fromMap = 268,
        fromX = 0.2734,
        fromY = 0.7316,
        toPointID = 300095,
        toMap = 109,
        toX = 0.7054,
        toY = 0.6964,
        type = "portal",
    },

    -- Zone: The Necrotic Wake (map 1666)
    -- The Necrotic Wake (map 1666 0.00,0.00) -> Bastion (map 1533 40.13,55.20) via portal
    {
        fromPointID = 1000158,
        fromMap = 1666,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000032,
        toMap = 1533,
        toX = 0.4013,
        toY = 0.552,
        type = "portal",
    },

    -- Zone: The Nexus (map 129)
    -- The Nexus (map 129 36.20,88.00) -> Borean Tundra (map 114 27.50,25.98) via portal
    {
        fromPointID = 400143,
        fromMap = 129,
        fromX = 0.362,
        fromY = 0.88,
        toPointID = 400001,
        toMap = 114,
        toX = 0.275,
        toY = 0.2598,
        type = "portal",
    },

    -- Zone: The Nighthold (map 764)
    -- The Nighthold (map 764 24.00,91.20) -> Suramar (map 680 44.13,59.80) via portal
    {
        fromPointID = 700279,
        fromMap = 764,
        fromX = 0.24,
        fromY = 0.912,
        toPointID = 700179,
        toMap = 680,
        toX = 0.4413,
        toY = 0.598,
        type = "portal",
    },

    -- Zone: The Nokhud Offensive (map 2093)
    -- The Nokhud Offensive (map 2093 0.00,0.00) -> Ohn'ahran Plains (map 2023 60.84,38.96) via portal
    {
        fromPointID = 1100091,
        fromMap = 2093,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100029,
        toMap = 2023,
        toX = 0.6084,
        toY = 0.3896,
        type = "portal",
    },

    -- Zone: The Obsidian Sanctum (map 155)
    -- The Obsidian Sanctum (map 155 64.00,50.00) -> Dragonblight (map 115 60.00,56.85) via portal
    {
        fromPointID = 400181,
        fromMap = 155,
        fromX = 0.64,
        fromY = 0.5,
        toPointID = 400026,
        toMap = 115,
        toX = 0.6,
        toY = 0.5685,
        type = "portal",
    },

    -- Zone: The Oculus (map 142)
    -- The Oculus (map 142 61.30,47.58) -> Borean Tundra (map 114 27.50,25.98) via portal
    {
        fromPointID = 400161,
        fromMap = 142,
        fromX = 0.613,
        fromY = 0.4758,
        toPointID = 400001,
        toMap = 114,
        toX = 0.275,
        toY = 0.2598,
        type = "portal",
    },

    -- Zone: The Oculus (map 143)
    -- The Oculus (map 143 38.45,50.96) -> The Oculus (map 143 47.89,69.30) via portal
    {
        fromPointID = 400162,
        fromMap = 143,
        fromX = 0.3845,
        fromY = 0.5096,
        toPointID = 400163,
        toMap = 143,
        toX = 0.4789,
        toY = 0.693,
        type = "portal",
    },
    -- The Oculus (map 143 47.89,69.30) -> The Oculus (map 143 38.45,50.96) via portal
    {
        fromPointID = 400163,
        fromMap = 143,
        fromX = 0.4789,
        fromY = 0.693,
        toPointID = 400162,
        toMap = 143,
        toX = 0.3845,
        toY = 0.5096,
        type = "portal",
    },

    -- Zone: The Ringing Deeps (map 2214)
    -- The Ringing Deeps (map 2214 41.92,30.23) -> Siren Isle (map 2369 67.96,38.52) via portal
    {
        fromPointID = 1200010,
        fromMap = 2214,
        fromX = 0.4192,
        fromY = 0.3023,
        toPointID = 1200157,
        toMap = 2369,
        toX = 0.6796,
        toY = 0.3852,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 84720,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 84720,
                        },
                    },
                },
            },
        },
    },
    -- The Ringing Deeps (map 2214 42.02,39.39) -> Operation: Floodgate (map 2387 42.25,11.73) via portal
    {
        fromPointID = 1200011,
        fromMap = 2214,
        fromX = 0.4202,
        fromY = 0.3939,
        toPointID = 1200169,
        toMap = 2387,
        toX = 0.4225,
        toY = 0.1173,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 42.18,48.68) -> The Waterworks (map 2251 46.53,10.58) via portal
    {
        fromPointID = 1200013,
        fromMap = 2214,
        fromX = 0.4218,
        fromY = 0.4868,
        toPointID = 1200056,
        toMap = 2251,
        toX = 0.4653,
        toY = 0.1058,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 42.70,8.39) -> The Stonevault (map 2341 53.44,10.68) via portal
    {
        fromPointID = 1200014,
        fromMap = 2214,
        fromX = 0.427,
        fromY = 0.0839,
        toPointID = 1200135,
        toMap = 2341,
        toX = 0.5344,
        toY = 0.1068,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 49.20,44.59) -> Isle of Dorn (map 2248 67.35,31.01) via portal
    {
        fromPointID = 1200016,
        fromMap = 2214,
        fromX = 0.492,
        fromY = 0.4459,
        toPointID = 1200050,
        toMap = 2248,
        toX = 0.6735,
        toY = 0.3101,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 82195,
                },
            },
        },
    },
    -- The Ringing Deeps (map 2214 55.50,21.50) -> Darkflame Cleft (map 2303 16.52,68.90) via portal
    {
        fromPointID = 1200017,
        fromMap = 2214,
        fromX = 0.555,
        fromY = 0.215,
        toPointID = 1200095,
        toMap = 2303,
        toX = 0.1652,
        toY = 0.689,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 61.53,76.95) -> Isle of Dorn (map 2248 37.41,72.86) via portal
    {
        fromPointID = 1200019,
        fromMap = 2214,
        fromX = 0.6153,
        fromY = 0.7695,
        toPointID = 1200043,
        toMap = 2248,
        toX = 0.3741,
        toY = 0.7286,
        type = "portal",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 84220,
                },
            },
        },
    },
    -- The Ringing Deeps (map 2214 70.26,37.15) -> The Dread Pit (map 2302 24.81,63.98) via portal
    {
        fromPointID = 1200020,
        fromMap = 2214,
        fromX = 0.7026,
        fromY = 0.3715,
        toPointID = 1200094,
        toMap = 2302,
        toX = 0.2481,
        toY = 0.6398,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 72.96,73.20) -> Undermine (map 2346 17.29,50.75) via portal
    {
        fromPointID = 1200022,
        fromMap = 2214,
        fromX = 0.7296,
        fromY = 0.732,
        toPointID = 1200139,
        toMap = 2346,
        toX = 0.1729,
        toY = 0.5075,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83151,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83151,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- The Ringing Deeps (map 2214 76.81,98.29) -> Excavation Site 9 (map 2396 48.75,3.62) via portal
    {
        fromPointID = 1200023,
        fromMap = 2214,
        fromX = 0.7681,
        fromY = 0.9829,
        toPointID = 1200172,
        toMap = 2396,
        toX = 0.4875,
        toY = 0.0362,
        type = "portal",
    },
    -- The Ringing Deeps (map 2214 76.82,98.29) -> Excavation Site 9 (map 2396 48.75,3.63) via portal
    {
        fromPointID = 1200024,
        fromMap = 2214,
        fromX = 0.7682,
        fromY = 0.9829,
        toPointID = 1200173,
        toMap = 2396,
        toX = 0.4875,
        toY = 0.0363,
        type = "portal",
    },

    -- Zone: The Rookery (map 2315)
    -- The Rookery (map 2315 88.76,46.52) -> Dornogal (map 2339 31.47,35.64) via portal
    {
        fromPointID = 1200103,
        fromMap = 2315,
        fromX = 0.8876,
        fromY = 0.4652,
        toPointID = 1200118,
        toMap = 2339,
        toX = 0.3147,
        toY = 0.3564,
        type = "portal",
    },

    -- Zone: The Ruby Sanctum (map 200)
    -- The Ruby Sanctum (map 200 49.00,30.40) -> Dragonblight (map 115 61.27,52.68) via portal
    {
        fromPointID = 400240,
        fromMap = 200,
        fromX = 0.49,
        fromY = 0.304,
        toPointID = 400029,
        toMap = 115,
        toX = 0.6127,
        toY = 0.5268,
        type = "portal",
    },
    -- The Ruby Sanctum (map 200 49.01,31.40) -> Dragonblight (map 115 61.20,52.76) via portal
    {
        fromPointID = 400241,
        fromMap = 200,
        fromX = 0.4901,
        fromY = 0.314,
        toPointID = 400028,
        toMap = 115,
        toX = 0.612,
        toY = 0.5276,
        type = "portal",
    },

    -- Zone: The Runecarver's Oubliette (map 1912)
    -- The Runecarver (map 1912 50.33,81.96) -> Torghast (map 1911 16.09,57.84) via portal
    {
        fromPointID = 1000310,
        fromMap = 1912,
        fromX = 0.5033,
        fromY = 0.8196,
        toPointID = 1000308,
        toMap = 1911,
        toX = 0.1609,
        toY = 0.5784,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60267,
                },
            },
        },
    },

    -- Zone: The Seat of the Triumvirate (map 903)
    -- The Seat of the Triumvirate (map 903 21.90,86.20) -> Eredath (map 882 22.30,55.89) via portal
    {
        fromPointID = 700319,
        fromMap = 903,
        fromX = 0.219,
        fromY = 0.862,
        toPointID = 700301,
        toMap = 882,
        toX = 0.223,
        toY = 0.5589,
        type = "portal",
    },

    -- Zone: The Shattered Halls (map 246)
    -- The Shattered Halls (map 246 61.14,92.81) -> Hellfire Peninsula (map 100 47.48,52.02) via portal
    {
        fromPointID = 300110,
        fromMap = 246,
        fromX = 0.6114,
        fromY = 0.9281,
        toPointID = 300006,
        toMap = 100,
        toX = 0.4748,
        toY = 0.5202,
        type = "portal",
    },

    -- Zone: The Sinkhole (map 2301)
    -- The Sinkhole (map 2301 51.59,5.75) -> Hallowfall (map 2215 50.70,53.56) via portal
    {
        fromPointID = 1200093,
        fromMap = 2301,
        fromX = 0.5159,
        fromY = 0.0575,
        toPointID = 1200032,
        toMap = 2215,
        toX = 0.507,
        toY = 0.5356,
        type = "portal",
    },

    -- Zone: The Slave Pens (map 265)
    -- The Slave Pens (map 265 19.95,13.37) -> Zangarmarsh (map 102 48.95,35.70) via portal
    {
        fromPointID = 300131,
        fromMap = 265,
        fromX = 0.1995,
        fromY = 0.1337,
        toPointID = 300032,
        toMap = 102,
        toX = 0.4895,
        toY = 0.357,
        type = "portal",
    },

    -- Zone: The Spiral Weave (map 2347)
    -- The Spiral Weave (map 2347 56.28,93.17) -> Azj-Kahet (map 2255 45.05,18.76) via portal
    {
        fromPointID = 1200150,
        fromMap = 2347,
        fromX = 0.5628,
        fromY = 0.9317,
        toPointID = 1200060,
        toMap = 2255,
        toX = 0.4505,
        toY = 0.1876,
        type = "portal",
    },

    -- Zone: The Steamvault (map 263)
    -- The Steamvault (map 263 17.59,29.76) -> Zangarmarsh (map 102 50.29,33.33) via portal
    {
        fromPointID = 300122,
        fromMap = 263,
        fromX = 0.1759,
        fromY = 0.2976,
        toPointID = 300034,
        toMap = 102,
        toX = 0.5029,
        toY = 0.3333,
        type = "portal",
    },

    -- Zone: The Stockade (map 225)
    -- The Stockade (map 225 50.07,68.09) -> Stormwind City (map 84 50.42,66.31) via portal
    {
        fromPointID = 200393,
        fromMap = 225,
        fromX = 0.5007,
        fromY = 0.6809,
        toPointID = 200305,
        toMap = 84,
        toX = 0.5042,
        toY = 0.6631,
        type = "portal",
    },

    -- Zone: The Stonecore (map 324)
    -- The Stonecore (map 324 54.27,93.90) -> Deepholm (map 207 47.70,51.98) via portal
    {
        fromPointID = 1300019,
        fromMap = 324,
        fromX = 0.5427,
        fromY = 0.939,
        toPointID = 1300011,
        toMap = 207,
        toX = 0.477,
        toY = 0.5198,
        type = "portal",
    },

    -- Zone: The Stonevault (map 2341)
    -- The Stonevault (map 2341 53.44,10.68) -> The Ringing Deeps (map 2214 42.70,8.39) via portal
    {
        fromPointID = 1200135,
        fromMap = 2341,
        fromX = 0.5344,
        fromY = 0.1068,
        toPointID = 1200014,
        toMap = 2214,
        toX = 0.427,
        toY = 0.0839,
        type = "portal",
    },

    -- Zone: The Storm Peaks (map 120)
    -- The Storm Peaks (map 120 39.50,26.92) -> Halls of Stone (map 140 34.40,36.20) via portal
    {
        fromPointID = 400088,
        fromMap = 120,
        fromX = 0.395,
        fromY = 0.2692,
        toPointID = 400160,
        toMap = 140,
        toX = 0.344,
        toY = 0.362,
        type = "portal",
    },
    -- The Storm Peaks (map 120 41.56,17.81) -> Ulduar (map 147 52.80,94.10) via portal
    {
        fromPointID = 400089,
        fromMap = 120,
        fromX = 0.4156,
        fromY = 0.1781,
        toPointID = 400168,
        toMap = 147,
        toX = 0.528,
        toY = 0.941,
        type = "portal",
    },
    -- The Storm Peaks (map 120 45.38,21.37) -> Halls of Lightning (map 138 7.38,53.81) via portal
    {
        fromPointID = 400091,
        fromMap = 120,
        fromX = 0.4538,
        fromY = 0.2137,
        toPointID = 400157,
        toMap = 138,
        toX = 0.0738,
        toY = 0.5381,
        type = "portal",
    },

    -- Zone: The Temple of Atal'Hakkar (map 220)
    -- The Temple of Atal'Hakkar (map 220 0.00,0.00) -> Swamp of Sorrows (map 51 76.09,45.25) via portal
    {
        fromPointID = 200392,
        fromMap = 220,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200247,
        toMap = 51,
        toX = 0.7609,
        toY = 0.4525,
        type = "portal",
    },

    -- Zone: The Tidebound Grotto (map 2632)
    -- The Tidebound Grotto (map 2632 26.11,26.36) -> The Coiled Isle (map 2512 59.57,66.33) via portal
    {
        fromPointID = 200889,
        fromMap = 2632,
        fromX = 0.2611,
        fromY = 0.2636,
        toPointID = 200794,
        toMap = 2512,
        toX = 0.5957,
        toY = 0.6633,
        type = "portal",
    },

    -- Zone: The Underbog (map 262)
    -- The Underbog (map 262 29.68,67.88) -> Zangarmarsh (map 102 54.28,34.40) via portal
    {
        fromPointID = 300121,
        fromMap = 262,
        fromX = 0.2968,
        fromY = 0.6788,
        toPointID = 300040,
        toMap = 102,
        toX = 0.5428,
        toY = 0.344,
        type = "portal",
    },

    -- Zone: The Underkeep (map 2299)
    -- The Underkeep (map 2299 31.90,21.39) -> Nerub'ar (map 2213 58.67,66.68) via portal
    {
        fromPointID = 1200092,
        fromMap = 2299,
        fromX = 0.319,
        fromY = 0.2139,
        toPointID = 1200002,
        toMap = 2213,
        toX = 0.5867,
        toY = 0.6668,
        type = "portal",
    },

    -- Zone: The Underrot (map 1041)
    -- The Underrot (map 1041 0.00,0.00) -> Nazmir (map 863 51.38,64.83) via portal
    {
        fromPointID = 900070,
        fromMap = 1041,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 900045,
        toMap = 863,
        toX = 0.5138,
        toY = 0.6483,
        type = "portal",
    },

    -- Zone: The Veiled Stair (map 433)
    -- The Veiled Stair (map 433 48.45,61.44) -> Terrace of Endless Spring (map 456 93.40,49.70) via portal
    {
        fromPointID = 500149,
        fromMap = 433,
        fromX = 0.4845,
        fromY = 0.6144,
        toPointID = 500185,
        toMap = 456,
        toX = 0.934,
        toY = 0.497,
        type = "portal",
    },

    -- Zone: The Venomous Abyss (map 2606)
    -- The Venomous Abyss (map 2606 49.78,94.15) -> Vaults of Atal'Utek (map 2509 47.25,20.51) via portal
    {
        fromPointID = 200872,
        fromMap = 2606,
        fromX = 0.4978,
        fromY = 0.9415,
        toPointID = 200763,
        toMap = 2509,
        toX = 0.4725,
        toY = 0.2051,
        type = "portal",
    },

    -- Zone: The Vindicaar (map 832)
    -- Krokuun (map 832 43.32,25.27) -> Dalaran L (map 627 60.92,44.72) via portal
    {
        fromPointID = 700291,
        fromMap = 832,
        fromX = 0.4332,
        fromY = 0.2527,
        toPointID = 700019,
        toMap = 627,
        toX = 0.6092,
        toY = 0.4472,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "vindicaarIn",
                    value = "Krokuun",
                },
            },
        },
    },

    -- Zone: The Vindicaar (map 884)
    -- Eredath (map 884 49.33,25.38) -> Dalaran L (map 627 60.92,44.72) via portal
    {
        fromPointID = 700306,
        fromMap = 884,
        fromX = 0.4933,
        fromY = 0.2538,
        toPointID = 700019,
        toMap = 627,
        toX = 0.6092,
        toY = 0.4472,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "vindicaarIn",
                    value = "Mac'Aree",
                },
            },
        },
    },

    -- Zone: The Vindicaar (map 887)
    -- Antoran Wastes (map 887 33.83,55.94) -> Dalaran L (map 627 60.92,44.72) via portal
    {
        fromPointID = 700318,
        fromMap = 887,
        fromX = 0.3383,
        fromY = 0.5594,
        toPointID = 700019,
        toMap = 627,
        toX = 0.6092,
        toY = 0.4472,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "vindicaarIn",
                    value = "Antoran Wastes",
                },
            },
        },
    },

    -- Zone: The Vindicaar (map 941)
    -- Vindicaar Scenario (map 941 43.22,25.16) -> Stormwind City (map 84 54.52,17.26) via portal
    {
        fromPointID = 700343,
        fromMap = 941,
        fromX = 0.4322,
        fromY = 0.2516,
        toPointID = 200309,
        toMap = 84,
        toX = 0.5452,
        toY = 0.1726,
        type = "portal",
    },

    -- Zone: The Violet Hold (map 168)
    -- The Violet Hold (map 168 46.15,98.03) -> Dalaran (map 125 68.60,70.39) via portal
    {
        fromPointID = 400204,
        fromMap = 168,
        fromX = 0.4615,
        fromY = 0.9803,
        toPointID = 400123,
        toMap = 125,
        toX = 0.686,
        toY = 0.7039,
        type = "portal",
    },

    -- Zone: The Voidspire (map 2529)
    -- The Voidspire (map 2529 0.00,0.00) -> Voidstorm (map 2405 45.21,64.79) via portal
    {
        fromPointID = 200820,
        fromMap = 2529,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200686,
        toMap = 2405,
        toX = 0.4521,
        toY = 0.6479,
        type = "portal",
    },

    -- Zone: The Vortex Pinnacle (map 325)
    -- The Vortex Pinnacle (map 325 0.00,0.00) -> Uldum New (map 1527 76.84,84.61) via portal
    {
        fromPointID = 100402,
        fromMap = 325,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100474,
        toMap = 1527,
        toX = 0.7684,
        toY = 0.8461,
        type = "portal",
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
    -- The Vortex Pinnacle (map 325 54.12,16.81) -> Uldum (map 249 76.81,84.55) via portal
    {
        fromPointID = 100403,
        fromMap = 325,
        fromX = 0.5412,
        fromY = 0.1681,
        toPointID = 100374,
        toMap = 249,
        toX = 0.7681,
        toY = 0.8455,
        type = "portal",
    },

    -- Zone: The Vortex Pinnacle (map 737)
    -- The Vortex Pinnacle L (map 737 53.59,16.00) -> The Maelstrom L (map 726 26.79,41.48) via portal
    {
        fromPointID = 100450,
        fromMap = 737,
        fromX = 0.5359,
        fromY = 0.16,
        toPointID = 700246,
        toMap = 726,
        toX = 0.2679,
        toY = 0.4148,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 43002,
                },
            },
        },
    },

    -- Zone: The Waking Shores (map 2022)
    -- The Waking Shores (map 2022 25.36,56.75) -> Neltharus (map 2080 0.00,0.00) via portal
    {
        fromPointID = 1100003,
        fromMap = 2022,
        fromX = 0.2536,
        fromY = 0.5675,
        toPointID = 1100085,
        toMap = 2080,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- The Waking Shores (map 2022 60.21,75.53) -> Ruby Life Pools (map 2095 0.00,0.00) via portal
    {
        fromPointID = 1100007,
        fromMap = 2022,
        fromX = 0.6021,
        fromY = 0.7553,
        toPointID = 1100093,
        toMap = 2095,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: The Wandering Isle (map 709)
    -- The Wandering Isle L (map 709 50.05,54.41) -> Kun-Lai Summit (map 379 48.69,43.12) via portal
    {
        fromPointID = 700219,
        fromMap = 709,
        fromX = 0.5005,
        fromY = 0.5441,
        toPointID = 500057,
        toMap = 379,
        toX = 0.4869,
        toY = 0.4312,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40236,
                },
            },
        },
    },
    -- The Wandering Isle L (map 709 52.39,57.15) -> Dalaran L (map 627 67.52,46.47) via portal
    {
        fromPointID = 700221,
        fromMap = 709,
        fromX = 0.5239,
        fromY = 0.5715,
        toPointID = 700028,
        toMap = 627,
        toX = 0.6752,
        toY = 0.4647,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40236,
                },
            },
        },
    },

    -- Zone: The Waterworks (map 2251)
    -- The Waterworks (map 2251 46.53,10.58) -> The Ringing Deeps (map 2214 42.18,48.68) via portal
    {
        fromPointID = 1200056,
        fromMap = 2251,
        fromX = 0.4653,
        fromY = 0.1058,
        toPointID = 1200013,
        toMap = 2214,
        toX = 0.4218,
        toY = 0.4868,
        type = "portal",
    },

    -- Zone: Theater of Pain (map 1683)
    -- Theater of Pain (map 1683 0.00,0.00) -> Maldraxxus (map 1536 53.09,52.87) via portal
    {
        fromPointID = 1000208,
        fromMap = 1683,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1000078,
        toMap = 1536,
        toX = 0.5309,
        toY = 0.5287,
        type = "portal",
    },

    -- Zone: Thousand Needles (map 64)
    -- Thousand Needles (map 64 47.65,23.65) -> Razorfen Downs (map 300 0.00,0.00) via portal
    {
        fromPointID = 100122,
        fromMap = 64,
        fromX = 0.4765,
        fromY = 0.2365,
        toPointID = 100393,
        toMap = 300,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Throne of Thunder (map 508)
    -- Throne of Thunder (map 508 31.70,25.80) -> Isle of Thunder (map 504 63.64,32.37) via portal
    {
        fromPointID = 500234,
        fromMap = 508,
        fromX = 0.317,
        fromY = 0.258,
        toPointID = 500225,
        toMap = 504,
        toX = 0.6364,
        toY = 0.3237,
        type = "portal",
    },

    -- Zone: Throne of the Four Winds (map 328)
    -- Throne of the Four Winds (map 328 0.00,0.00) -> Uldum New (map 1527 38.25,80.69) via portal
    {
        fromPointID = 100407,
        fromMap = 328,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100466,
        toMap = 1527,
        toX = 0.3825,
        toY = 0.8069,
        type = "portal",
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
    -- Throne of the Four Winds (map 328 47.10,76.30) -> Uldum (map 249 38.38,80.60) via portal
    {
        fromPointID = 100408,
        fromMap = 328,
        fromX = 0.471,
        fromY = 0.763,
        toPointID = 100368,
        toMap = 249,
        toX = 0.3838,
        toY = 0.806,
        type = "portal",
    },

    -- Zone: Throne of the Tides (map 322)
    -- Throne of the Tides (map 322 49.85,88.23) -> Abyssal Depths (map 204 69.49,24.99) via portal
    {
        fromPointID = 200550,
        fromMap = 322,
        fromX = 0.4985,
        fromY = 0.8823,
        toPointID = 200366,
        toMap = 204,
        toX = 0.6949,
        toY = 0.2499,
        type = "portal",
    },

    -- Zone: Thunder Totem (map 652)
    -- Thunder Totem (map 652 46.04,63.74) -> Orgrimmar (map 85 40.24,78.12) via portal
    {
        fromPointID = 700136,
        fromMap = 652,
        fromX = 0.4604,
        fromY = 0.6374,
        toPointID = 100256,
        toMap = 85,
        toX = 0.4024,
        toY = 0.7812,
        type = "portal",
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
                    kind = "race",
                    value = "HighmountainTauren",
                },
            },
        },
    },

    -- Zone: Thunder Totem (map 750)
    -- Thunder Totem (map 750 39.73,42.11) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700271,
        fromMap = 750,
        fromX = 0.3973,
        fromY = 0.4211,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41359,
                },
            },
        },
    },

    -- Zone: Timeless Isle (map 554)
    -- Timeless Isle (map 554 24.32,52.15) -> The Jade Forest (map 371 45.85,84.66) via portal
    {
        fromPointID = 500261,
        fromMap = 554,
        fromX = 0.2432,
        fromY = 0.5215,
        toPointID = 500012,
        toMap = 371,
        toX = 0.4585,
        toY = 0.8466,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "buff",
                    value = 424143,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },

    -- Zone: Tiragarde Sound (map 895)
    -- Tiragarde Sound (map 895 84.45,78.88) -> Freehold (map 936 0.00,0.00) via portal
    {
        fromPointID = 800014,
        fromMap = 895,
        fromX = 0.8445,
        fromY = 0.7888,
        toPointID = 800040,
        toMap = 936,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Tirisfal Glades (map 18)
    -- Tirisfal Glades (map 18 59.09,58.91) -> Howling Fjord (map 117 79.00,28.92) via portal
    {
        fromPointID = 200044,
        fromMap = 18,
        fromX = 0.5909,
        fromY = 0.5891,
        toPointID = 400065,
        toMap = 117,
        toX = 0.79,
        toY = 0.2892,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 59.45,67.44) -> Silvermoon City (map 110 49.49,14.80) via portal
    {
        fromPointID = 200045,
        fromMap = 18,
        fromX = 0.5945,
        fromY = 0.6744,
        toPointID = 200340,
        toMap = 110,
        toX = 0.4949,
        toY = 0.148,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 60.74,58.67) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200046,
        fromMap = 18,
        fromX = 0.6074,
        fromY = 0.5867,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },
    -- Tirisfal Glades (map 18 61.88,59.01) -> Northern Stranglethorn (map 50 37.23,50.48) via portal
    {
        fromPointID = 200049,
        fromMap = 18,
        fromX = 0.6188,
        fromY = 0.5901,
        toPointID = 200223,
        toMap = 50,
        toX = 0.3723,
        toY = 0.5048,
        type = "portal",
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
                    value = "Old Undercity",
                },
            },
        },
    },

    -- Zone: Tirisfal Glades (map 2070)
    -- Tirisfal Glades L (map 2070 59.40,67.45) -> Silvermoon City (map 110 49.49,14.80) via portal
    {
        fromPointID = 200634,
        fromMap = 2070,
        fromX = 0.594,
        fromY = 0.6745,
        toPointID = 200340,
        toMap = 110,
        toX = 0.4949,
        toY = 0.148,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 59.50,66.95) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200635,
        fromMap = 2070,
        fromX = 0.595,
        fromY = 0.6695,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 59.50,67.95) -> Northern Stranglethorn (map 50 37.23,50.48) via portal
    {
        fromPointID = 200636,
        fromMap = 2070,
        fromX = 0.595,
        fromY = 0.6795,
        toPointID = 200223,
        toMap = 50,
        toX = 0.3723,
        toY = 0.5048,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },
    -- Tirisfal Glades L (map 2070 60.11,66.93) -> Howling Fjord (map 117 79.00,28.92) via portal
    {
        fromPointID = 200637,
        fromMap = 2070,
        fromX = 0.6011,
        fromY = 0.6693,
        toPointID = 400065,
        toMap = 117,
        toX = 0.79,
        toY = 0.2892,
        type = "portal",
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
                    value = "UndercityCharred",
                },
            },
        },
    },

    -- Zone: Tol Barad Peninsula (map 245)
    -- Tol Barad Peninsula (map 245 56.30,79.66) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200468,
        fromMap = 245,
        fromX = 0.563,
        fromY = 0.7966,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    kind = "minLevel",
                    value = 30,
                },
            },
        },
    },
    -- Tol Barad Peninsula (map 245 75.23,58.86) -> Stormwind City (map 84 74.46,18.34) via portal
    {
        fromPointID = 200473,
        fromMap = 245,
        fromX = 0.7523,
        fromY = 0.5886,
        toPointID = 200318,
        toMap = 84,
        toX = 0.7446,
        toY = 0.1834,
        type = "portal",
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
                    value = 30,
                },
            },
        },
    },

    -- Zone: Tol Barad (map 244)
    -- Tol Barad (map 244 47.66,52.65) -> Baradin Hold (map 282 48.00,91.80) via portal
    {
        fromPointID = 200465,
        fromMap = 244,
        fromX = 0.4766,
        fromY = 0.5265,
        toPointID = 200495,
        toMap = 282,
        toX = 0.48,
        toY = 0.918,
        type = "portal",
    },

    -- Zone: Tol Dagor (map 1169)
    -- Tol Dagor Isle (map 1169 39.43,68.52) -> Tol Dagor (map 974 0.00,0.00) via portal
    {
        fromPointID = 800094,
        fromMap = 1169,
        fromX = 0.3943,
        fromY = 0.6852,
        toPointID = 800060,
        toMap = 974,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Tol Dagor (map 974)
    -- Tol Dagor (map 974 0.00,0.00) -> Tol Dagor Isle (map 1169 39.43,68.52) via portal
    {
        fromPointID = 800060,
        fromMap = 974,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 800094,
        toMap = 1169,
        toX = 0.3943,
        toY = 0.6852,
        type = "portal",
    },

    -- Zone: Tomb of Sargeras (map 850)
    -- Tomb of Sargeras (map 850 45.20,90.20) -> Broken Shore (map 646 64.53,20.81) via portal
    {
        fromPointID = 700294,
        fromMap = 850,
        fromX = 0.452,
        fromY = 0.902,
        toPointID = 700116,
        toMap = 646,
        toX = 0.6453,
        toY = 0.2081,
        type = "portal",
    },

    -- Zone: Torghast - Entrance (map 1911)
    -- Torghast (map 1911 10.43,47.13) -> The Maw (map 1543 48.14,39.57) via portal
    {
        fromPointID = 1000306,
        fromMap = 1911,
        fromX = 0.1043,
        fromY = 0.4713,
        toPointID = 1000115,
        toMap = 1543,
        toX = 0.4814,
        toY = 0.3957,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60136,
                },
            },
        },
    },
    -- Torghast (map 1911 15.95,62.04) -> The Runecarver (map 1912 50.68,68.81) via portal
    {
        fromPointID = 1000307,
        fromMap = 1911,
        fromX = 0.1595,
        fromY = 0.6204,
        toPointID = 1000311,
        toMap = 1912,
        toX = 0.5068,
        toY = 0.6881,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 60267,
                },
            },
        },
    },

    -- Zone: Townlong Steppes (map 388)
    -- Townlong Steppes (map 388 34.70,81.40) -> Siege of Niuzao Temple (map 458 64.90,86.90) via portal
    {
        fromPointID = 500086,
        fromMap = 388,
        fromX = 0.347,
        fromY = 0.814,
        toPointID = 500188,
        toMap = 458,
        toX = 0.649,
        toY = 0.869,
        type = "portal",
    },
    -- Townlong Steppes (map 388 49.74,68.66) -> Isle of Thunder (map 504 34.86,89.85) via portal
    {
        fromPointID = 500088,
        fromMap = 388,
        fromX = 0.4974,
        fromY = 0.6866,
        toPointID = 500217,
        toMap = 504,
        toX = 0.3486,
        toY = 0.8985,
        type = "portal",
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
                            kind = "questCompleted",
                            value = 32644,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32681,
                },
            },
        },
    },
    -- Townlong Steppes (map 388 49.74,68.67) -> Isle of Thunder (map 504 64.08,72.48) via portal
    {
        fromPointID = 500089,
        fromMap = 388,
        fromX = 0.4974,
        fromY = 0.6867,
        toPointID = 500226,
        toMap = 504,
        toX = 0.6408,
        toY = 0.7248,
        type = "portal",
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
                    value = 32644,
                },
            },
        },
    },
    -- Townlong Steppes (map 388 50.65,73.40) -> Isle of Thunder (map 504 28.39,52.90) via portal
    {
        fromPointID = 500092,
        fromMap = 388,
        fromX = 0.5065,
        fromY = 0.734,
        toPointID = 500206,
        toMap = 504,
        toX = 0.2839,
        toY = 0.529,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 32212,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 32680,
                },
            },
        },
    },
    -- Townlong Steppes (map 388 50.65,73.40) -> Isle of Thunder (map 504 33.25,32.43) via portal
    {
        fromPointID = 500092,
        fromMap = 388,
        fromX = 0.5065,
        fromY = 0.734,
        toPointID = 500214,
        toMap = 504,
        toX = 0.3325,
        toY = 0.3243,
        type = "portal",
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
                    value = 32212,
                },
            },
        },
    },

    -- Zone: Trial of Valor (map 807)
    -- Trial of Valor (map 807 51.00,10.00) -> Stormheim (map 634 71.18,72.73) via portal
    {
        fromPointID = 700282,
        fromMap = 807,
        fromX = 0.51,
        fromY = 0.1,
        toPointID = 700079,
        toMap = 634,
        toX = 0.7118,
        toY = 0.7273,
        type = "portal",
    },

    -- Zone: Trial of the Champion (map 171)
    -- Trial of the Champion (map 171 51.18,30.24) -> Icecrown (map 118 74.17,20.52) via portal
    {
        fromPointID = 400207,
        fromMap = 171,
        fromX = 0.5118,
        fromY = 0.3024,
        toPointID = 400075,
        toMap = 118,
        toX = 0.7417,
        toY = 0.2052,
        type = "portal",
    },

    -- Zone: Trial of the Crusader (map 172)
    -- Trial of the Crusader (map 172 64.50,52.60) -> Icecrown (map 118 75.08,21.81) via portal
    {
        fromPointID = 400209,
        fromMap = 172,
        fromX = 0.645,
        fromY = 0.526,
        toPointID = 400076,
        toMap = 118,
        toX = 0.7508,
        toY = 0.2181,
        type = "portal",
    },

    -- Zone: Trueshot Lodge (map 739)
    -- Trueshot Lodge (map 739 48.63,43.50) -> Dalaran L (map 627 67.52,46.47) via portal
    {
        fromPointID = 700265,
        fromMap = 739,
        fromX = 0.4863,
        fromY = 0.435,
        toPointID = 700028,
        toMap = 627,
        toX = 0.6752,
        toY = 0.4647,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40953,
                },
            },
        },
    },

    -- Zone: Twilight Crypts (map 2503)
    -- Twilight Crypts (map 2503 49.12,10.46) -> Zul Aman M (map 2437 25.41,84.51) via portal
    {
        fromPointID = 200751,
        fromMap = 2503,
        fromX = 0.4912,
        fromY = 0.1046,
        toPointID = 200721,
        toMap = 2437,
        toX = 0.2541,
        toY = 0.8451,
        type = "portal",
    },

    -- Zone: Twilight Highlands (map 241)
    -- Twilight Highlands (map 241 19.14,53.84) -> Grim Batol (map 293 12.15,55.67) via portal
    {
        fromPointID = 200411,
        fromMap = 241,
        fromX = 0.1914,
        fromY = 0.5384,
        toPointID = 200517,
        toMap = 293,
        toX = 0.1215,
        toY = 0.5567,
        type = "portal",
    },
    -- Twilight Highlands (map 241 33.97,77.93) -> The Bastion of Twilight (map 294 39.30,53.30) via portal
    {
        fromPointID = 200414,
        fromMap = 241,
        fromX = 0.3397,
        fromY = 0.7793,
        toPointID = 200518,
        toMap = 294,
        toX = 0.393,
        toY = 0.533,
        type = "portal",
    },
    -- Twilight Highlands (map 241 49.22,81.02) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 200418,
        fromMap = 241,
        fromX = 0.4922,
        fromY = 0.8102,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    value = 90763,
                },
            },
        },
    },
    -- Twilight Highlands (map 241 49.51,81.77) -> Dornogal (map 2339 41.29,27.45) via portal
    {
        fromPointID = 200419,
        fromMap = 241,
        fromX = 0.4951,
        fromY = 0.8177,
        toPointID = 1200125,
        toMap = 2339,
        toX = 0.4129,
        toY = 0.2745,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 90763,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 90762,
                        },
                    },
                },
            },
        },
    },
    -- Twilight Highlands (map 241 50.17,81.66) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 200420,
        fromMap = 241,
        fromX = 0.5017,
        fromY = 0.8166,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                    value = 90762,
                },
            },
        },
    },
    -- Twilight Highlands (map 241 73.56,53.54) -> Orgrimmar (map 85 50.14,37.89) via portal
    {
        fromPointID = 200424,
        fromMap = 241,
        fromX = 0.7356,
        fromY = 0.5354,
        toPointID = 100266,
        toMap = 85,
        toX = 0.5014,
        toY = 0.3789,
        type = "portal",
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
                    value = 26784,
                },
            },
        },
    },
    -- Twilight Highlands (map 241 79.43,77.85) -> Stormwind City (map 84 75.17,16.81) via portal
    {
        fromPointID = 200428,
        fromMap = 241,
        fromX = 0.7943,
        fromY = 0.7785,
        toPointID = 200319,
        toMap = 84,
        toX = 0.7517,
        toY = 0.1681,
        type = "portal",
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
                    value = 27537,
                },
            },
        },
    },

    -- Zone: Uldaman (map 16)
    -- Badlands (map 16 36.70,30.10) -> Uldaman (map 230 67.03,72.71) via portal
    {
        fromPointID = 200032,
        fromMap = 16,
        fromX = 0.367,
        fromY = 0.301,
        toPointID = 200406,
        toMap = 230,
        toX = 0.6703,
        toY = 0.7271,
        type = "portal",
    },

    -- Zone: Uldaman (map 230)
    -- Uldaman (map 230 67.03,72.71) -> Badlands (map 16 36.70,30.10) via portal
    {
        fromPointID = 200406,
        fromMap = 230,
        fromX = 0.6703,
        fromY = 0.7271,
        toPointID = 200032,
        toMap = 16,
        toX = 0.367,
        toY = 0.301,
        type = "portal",
    },

    -- Zone: Uldaman: Legacy of Tyr (map 2071)
    -- Uldaman Legacy of Tyr (map 2071 0.00,0.00) -> Badlands (map 15 40.91,10.27) via portal
    {
        fromPointID = 200640,
        fromMap = 2071,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200016,
        toMap = 15,
        toX = 0.4091,
        toY = 0.1027,
        type = "portal",
    },

    -- Zone: Uldir (map 1148)
    -- Uldir (map 1148 52.21,93.83) -> Nazmir (map 863 53.80,62.62) via portal
    {
        fromPointID = 900071,
        fromMap = 1148,
        fromX = 0.5221,
        fromY = 0.9383,
        toPointID = 900047,
        toMap = 863,
        toX = 0.538,
        toY = 0.6262,
        type = "portal",
    },

    -- Zone: Ulduar (map 147)
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 147 48.51,11.06) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400164,
        fromMap = 147,
        fromX = 0.4851,
        fromY = 0.1106,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 147 48.54,28.08) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400165,
        fromMap = 147,
        fromX = 0.4854,
        fromY = 0.2808,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 147 49.24,47.34) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400166,
        fromMap = 147,
        fromX = 0.4924,
        fromY = 0.4734,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 147 50.98,85.54) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400167,
        fromMap = 147,
        fromX = 0.5098,
        fromY = 0.8554,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },
    -- Ulduar (map 147 52.80,94.10) -> The Storm Peaks (map 120 41.56,17.81) via portal
    {
        fromPointID = 400168,
        fromMap = 147,
        fromX = 0.528,
        fromY = 0.941,
        toPointID = 400089,
        toMap = 120,
        toX = 0.4156,
        toY = 0.1781,
        type = "portal",
    },

    -- Zone: Ulduar (map 148)
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 148 37.10,76.41) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400170,
        fromMap = 148,
        fromX = 0.371,
        fromY = 0.7641,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 148 37.32,0.52) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400172,
        fromMap = 148,
        fromX = 0.3732,
        fromY = 0.0052,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },

    -- Zone: Ulduar (map 149)
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },
    -- Ulduar (map 149 51.02,54.02) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400175,
        fromMap = 149,
        fromX = 0.5102,
        fromY = 0.5402,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },

    -- Zone: Ulduar (map 150)
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 150 66.60,59.98) -> Ulduar (map 151 43.65,62.19) via portal
    {
        fromPointID = 400178,
        fromMap = 150,
        fromX = 0.666,
        fromY = 0.5998,
        toPointID = 400179,
        toMap = 151,
        toX = 0.4365,
        toY = 0.6219,
        type = "portal",
    },

    -- Zone: Ulduar (map 151)
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 147 48.51,11.06) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400164,
        toMap = 147,
        toX = 0.4851,
        toY = 0.1106,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 147 48.54,28.08) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400165,
        toMap = 147,
        toX = 0.4854,
        toY = 0.2808,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 147 49.24,47.34) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400166,
        toMap = 147,
        toX = 0.4924,
        toY = 0.4734,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 147 50.98,85.54) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400167,
        toMap = 147,
        toX = 0.5098,
        toY = 0.8554,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 148 37.10,76.41) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400170,
        toMap = 148,
        toX = 0.371,
        toY = 0.7641,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 148 37.32,0.52) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400172,
        toMap = 148,
        toX = 0.3732,
        toY = 0.0052,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 149 51.02,54.02) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400175,
        toMap = 149,
        toX = 0.5102,
        toY = 0.5402,
        type = "portal",
    },
    -- Ulduar (map 151 43.65,62.19) -> Ulduar (map 150 66.60,59.98) via portal
    {
        fromPointID = 400179,
        fromMap = 151,
        fromX = 0.4365,
        fromY = 0.6219,
        toPointID = 400178,
        toMap = 150,
        toX = 0.666,
        toY = 0.5998,
        type = "portal",
    },

    -- Zone: Uldum (map 1527)
    -- Uldum New (map 1527 38.25,80.69) -> Throne of the Four Winds (map 328 0.00,0.00) via portal
    {
        fromPointID = 100466,
        fromMap = 1527,
        fromX = 0.3825,
        fromY = 0.8069,
        toPointID = 100407,
        toMap = 328,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Uldum New (map 1527 55.17,43.93) -> Ny'alotha, the Waking City (map 1580 0.00,0.00) via portal
    {
        fromPointID = 100468,
        fromMap = 1527,
        fromX = 0.5517,
        fromY = 0.4393,
        toPointID = 1300052,
        toMap = 1580,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "UldumInvasionCenter",
                },
            },
        },
    },
    -- Uldum New (map 1527 56.65,31.67) -> Uldum Vision (map 1571 57.38,31.78) via portal
    {
        fromPointID = 100469,
        fromMap = 1527,
        fromX = 0.5665,
        fromY = 0.3167,
        toPointID = 100481,
        toMap = 1571,
        toX = 0.5738,
        toY = 0.3178,
        type = "portal",
    },
    -- Uldum New (map 1527 60.55,64.32) -> Lost City of the Tol'vir (map 277 0.00,0.00) via portal
    {
        fromPointID = 100471,
        fromMap = 1527,
        fromX = 0.6055,
        fromY = 0.6432,
        toPointID = 100377,
        toMap = 277,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Uldum New (map 1527 69.09,53.15) -> Halls of Origination (map 297 0.00,0.00) via portal
    {
        fromPointID = 100472,
        fromMap = 1527,
        fromX = 0.6909,
        fromY = 0.5315,
        toPointID = 100385,
        toMap = 297,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Uldum New (map 1527 76.84,84.61) -> The Vortex Pinnacle (map 325 0.00,0.00) via portal
    {
        fromPointID = 100474,
        fromMap = 1527,
        fromX = 0.7684,
        fromY = 0.8461,
        toPointID = 100402,
        toMap = 325,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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

    -- Zone: Uldum (map 1571)
    -- Uldum Vision (map 1571 57.38,31.38) -> Uldum New (map 1527 56.65,31.80) via portal
    {
        fromPointID = 100480,
        fromMap = 1571,
        fromX = 0.5738,
        fromY = 0.3138,
        toPointID = 100470,
        toMap = 1527,
        toX = 0.5665,
        toY = 0.318,
        type = "portal",
    },

    -- Zone: Uldum (map 249)
    -- Uldum (map 249 38.38,80.60) -> Throne of the Four Winds (map 328 47.10,76.30) via portal
    {
        fromPointID = 100368,
        fromMap = 249,
        fromX = 0.3838,
        fromY = 0.806,
        toPointID = 100408,
        toMap = 328,
        toX = 0.471,
        toY = 0.763,
        type = "portal",
    },
    -- Uldum (map 249 60.55,64.32) -> Lost City of the Tol'vir (map 277 31.78,16.78) via portal
    {
        fromPointID = 100370,
        fromMap = 249,
        fromX = 0.6055,
        fromY = 0.6432,
        toPointID = 100378,
        toMap = 277,
        toX = 0.3178,
        toY = 0.1678,
        type = "portal",
    },
    -- Uldum (map 249 69.09,52.97) -> Halls of Origination (map 299 49.91,93.73) via portal
    {
        fromPointID = 100371,
        fromMap = 249,
        fromX = 0.6909,
        fromY = 0.5297,
        toPointID = 100392,
        toMap = 299,
        toX = 0.4991,
        toY = 0.9373,
        type = "portal",
    },
    -- Uldum (map 249 76.81,84.55) -> The Vortex Pinnacle (map 325 54.12,16.81) via portal
    {
        fromPointID = 100374,
        fromMap = 249,
        fromX = 0.7681,
        fromY = 0.8455,
        toPointID = 100403,
        toMap = 325,
        toX = 0.5412,
        toY = 0.1681,
        type = "portal",
    },

    -- Zone: Un'Goro Crater (map 78)
    -- Un'Goro Crater (map 78 50.40,7.90) -> Sholazar Basin (map 119 40.40,83.00) via portal
    {
        fromPointID = 100228,
        fromMap = 78,
        fromX = 0.504,
        fromY = 0.079,
        toPointID = 400083,
        toMap = 119,
        toX = 0.404,
        toY = 0.83,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 12613,
                },
            },
        },
    },
    -- Un'Goro Crater (map 78 50.53,7.71) -> Sholazar Basin (map 119 40.38,83.20) via portal
    {
        fromPointID = 100229,
        fromMap = 78,
        fromX = 0.5053,
        fromY = 0.0771,
        toPointID = 400082,
        toMap = 119,
        toX = 0.4038,
        toY = 0.832,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 12546,
                },
            },
        },
    },

    -- Zone: Undercity (map 90)
    -- Undercity (map 90 85.25,17.04) -> Hellfire Peninsula (map 100 89.16,49.56) via portal
    {
        fromPointID = 200332,
        fromMap = 90,
        fromX = 0.8525,
        fromY = 0.1704,
        toPointID = 300020,
        toMap = 100,
        toX = 0.8916,
        toY = 0.4956,
        type = "portal",
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
                    kind = "minLevel",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "phase",
                    value = "Old Undercity",
                },
            },
        },
    },

    -- Zone: Undermine (map 2346)
    -- Undermine (map 2346 17.29,50.75) -> The Ringing Deeps (map 2214 72.96,73.20) via portal
    {
        fromPointID = 1200139,
        fromMap = 2346,
        fromX = 0.1729,
        fromY = 0.5075,
        toPointID = 1200022,
        toMap = 2214,
        toX = 0.7296,
        toY = 0.732,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83151,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83151,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Undermine (map 2346 18.80,52.21) -> Zuldazar (map 862 22.55,54.07) via portal
    {
        fromPointID = 1200140,
        fromMap = 2346,
        fromX = 0.188,
        fromY = 0.5221,
        toPointID = 900001,
        toMap = 862,
        toX = 0.2255,
        toY = 0.5407,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83933,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83933,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Undermine (map 2346 27.83,54.02) -> Dornogal (map 2339 52.47,50.47) via portal
    {
        fromPointID = 1200142,
        fromMap = 2346,
        fromX = 0.2783,
        fromY = 0.5402,
        toPointID = 1200130,
        toMap = 2339,
        toX = 0.5247,
        toY = 0.5047,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83137,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83137,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Undermine (map 2346 35.19,51.44) -> Sidestreet Sluice (map 2420 48.89,71.44) via portal
    {
        fromPointID = 1200143,
        fromMap = 2346,
        fromX = 0.3519,
        fromY = 0.5144,
        toPointID = 1200186,
        toMap = 2420,
        toX = 0.4889,
        toY = 0.7144,
        type = "portal",
    },
    -- Undermine (map 2346 42.11,50.41) -> Liberation of Undermine (map 2406 42.60,52.29) via portal
    {
        fromPointID = 1200145,
        fromMap = 2346,
        fromX = 0.4211,
        fromY = 0.5041,
        toPointID = 1200174,
        toMap = 2406,
        toX = 0.426,
        toY = 0.5229,
        type = "portal",
    },

    -- Zone: Undermine (map 2406)
    -- Liberation of Undermine (map 2406 42.60,52.29) -> Undermine (map 2346 42.11,50.41) via portal
    {
        fromPointID = 1200174,
        fromMap = 2406,
        fromX = 0.426,
        fromY = 0.5229,
        toPointID = 1200145,
        toMap = 2346,
        toX = 0.4211,
        toY = 0.5041,
        type = "portal",
    },

    -- Zone: Upper Blackrock Spire (map 616)
    -- Upper Blackrock Spire 2 (map 616 37.20,32.50) -> Burning Steppes (map 33 78.78,31.60) via portal
    {
        fromPointID = 200627,
        fromMap = 616,
        fromX = 0.372,
        fromY = 0.325,
        toPointID = 200152,
        toMap = 33,
        toX = 0.7878,
        toY = 0.316,
        type = "portal",
    },

    -- Zone: Utgarde Keep (map 133)
    -- Utgarde Keep (map 133 0.00,0.00) -> Howling Fjord (map 117 57.27,46.67) via portal
    {
        fromPointID = 400145,
        fromMap = 133,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 400059,
        toMap = 117,
        toX = 0.5727,
        toY = 0.4667,
        type = "portal",
    },

    -- Zone: Utgarde Pinnacle (map 137)
    -- Utgarde Pinnacle (map 137 44.33,14.19) -> Howling Fjord (map 117 57.27,46.69) via portal
    {
        fromPointID = 400154,
        fromMap = 137,
        fromX = 0.4433,
        fromY = 0.1419,
        toPointID = 400060,
        toMap = 117,
        toX = 0.5727,
        toY = 0.4669,
        type = "portal",
    },

    -- Zone: Val'sharah (map 641)
    -- Val'sharah (map 641 37.15,50.20) -> Black Rook Hold (map 751 29.63,10.30) via portal
    {
        fromPointID = 700087,
        fromMap = 641,
        fromX = 0.3715,
        fromY = 0.502,
        toPointID = 700273,
        toMap = 751,
        toX = 0.2963,
        toY = 0.103,
        type = "portal",
    },
    -- Val'sharah (map 641 51.24,56.09) -> Hall of the Guardian (map 734 66.78,46.52) via portal
    {
        fromPointID = 700092,
        fromMap = 641,
        fromX = 0.5124,
        fromY = 0.5609,
        toPointID = 700260,
        toMap = 734,
        toX = 0.6678,
        toY = 0.4652,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 223413,
                },
            },
        },
    },
    -- Val'sharah (map 641 51.86,58.66) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 700094,
        fromMap = 641,
        fromX = 0.5186,
        fromY = 0.5866,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Val'sharah (map 641 51.86,58.66) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 700094,
        fromMap = 641,
        fromX = 0.5186,
        fromY = 0.5866,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Val'sharah (map 641 54.71,74.89) -> Skyhold (map 695 58.92,36.29) via portal
    {
        fromPointID = 700095,
        fromMap = 641,
        fromX = 0.5471,
        fromY = 0.7489,
        toPointID = 700214,
        toMap = 695,
        toX = 0.5892,
        toY = 0.3629,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "WARRIOR",
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 44061,
                },
            },
        },
    },
    -- Val'sharah (map 641 54.85,71.85) -> Amirdrassil (map 2239 54.92,63.88) via portal
    {
        fromPointID = 700097,
        fromMap = 641,
        fromX = 0.5485,
        fromY = 0.7185,
        toPointID = 1100226,
        toMap = 2239,
        toX = 0.5492,
        toY = 0.6388,
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
    },
    -- Val'sharah (map 641 56.40,37.00) -> The Emerald Nightmare (map 777 43.90,58.40) via portal
    {
        fromPointID = 700100,
        fromMap = 641,
        fromX = 0.564,
        fromY = 0.37,
        toPointID = 700280,
        toMap = 777,
        toX = 0.439,
        toY = 0.584,
        type = "portal",
    },
    -- Val'sharah (map 641 59.06,31.21) -> Darkheart Thicket (map 733 36.71,14.16) via portal
    {
        fromPointID = 700104,
        fromMap = 641,
        fromX = 0.5906,
        fromY = 0.3121,
        toPointID = 700253,
        toMap = 733,
        toX = 0.3671,
        toY = 0.1416,
        type = "portal",
    },

    -- Zone: Val (map 2599)
    -- Val (map 2599 33.76,75.48) -> Void Acropolis (map 2619 39.88,31.99) via portal
    {
        fromPointID = 200864,
        fromMap = 2599,
        fromX = 0.3376,
        fromY = 0.7548,
        toPointID = 200885,
        toMap = 2619,
        toX = 0.3988,
        toY = 0.3199,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },
    -- Val (map 2599 42.91,71.57) -> Forgotten Depths (map 2621 71.97,19.95) via portal
    {
        fromPointID = 200865,
        fromMap = 2599,
        fromX = 0.4291,
        fromY = 0.7157,
        toPointID = 200888,
        toMap = 2621,
        toX = 0.7197,
        toY = 0.1995,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },
    -- Val (map 2599 49.46,97.49) -> Void Acropolis (map 2618 63.49,78.53) via portal
    {
        fromPointID = 200866,
        fromMap = 2599,
        fromX = 0.4946,
        fromY = 0.9749,
        toPointID = 200883,
        toMap = 2618,
        toX = 0.6349,
        toY = 0.7853,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },
    -- Val (map 2599 61.83,15.98) -> Voidstorm (map 2405 51.42,71.32) via portal
    {
        fromPointID = 200867,
        fromMap = 2599,
        fromX = 0.6183,
        fromY = 0.1598,
        toPointID = 200689,
        toMap = 2405,
        toX = 0.5142,
        toY = 0.7132,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97071,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97071,
                        },
                    },
                },
            },
        },
    },
    -- Val (map 2599 63.61,15.91) -> Voidstorm (map 2405 51.42,71.32) via portal
    {
        fromPointID = 200868,
        fromMap = 2599,
        fromX = 0.6361,
        fromY = 0.1591,
        toPointID = 200689,
        toMap = 2405,
        toX = 0.5142,
        toY = 0.7132,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97071,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Valdrakken (map 2112)
    -- Valdrakken (map 2112 26.10,40.99) -> Badlands (map 15 64.66,37.27) via portal
    {
        fromPointID = 1100108,
        fromMap = 2112,
        fromX = 0.261,
        fromY = 0.4099,
        toPointID = 200025,
        toMap = 15,
        toX = 0.6466,
        toY = 0.3727,
        type = "portal",
    },
    -- Valdrakken (map 2112 54.53,63.49) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Valdrakken (map 2112 54.53,63.49) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Valdrakken (map 2112 54.53,63.49) -> The Jade Forest (map 371 43.91,42.26) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 500008,
        toMap = 371,
        toX = 0.4391,
        toY = 0.4226,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Valdrakken (map 2112 54.53,63.49) -> Northern Stranglethorn (map 50 79.60,77.33) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 200230,
        toMap = 50,
        toX = 0.796,
        toY = 0.7733,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Valdrakken (map 2112 54.53,63.49) -> Val'sharah (map 641 51.52,58.44) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 700093,
        toMap = 641,
        toX = 0.5152,
        toY = 0.5844,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Valdrakken (map 2112 54.53,63.49) -> Winterspring (map 83 22.78,46.76) via portal
    {
        fromPointID = 1100110,
        fromMap = 2112,
        fromX = 0.5453,
        fromY = 0.6349,
        toPointID = 100251,
        toMap = 83,
        toX = 0.2278,
        toY = 0.4676,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
            },
        },
    },
    -- Valdrakken (map 2112 56.59,38.26) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 1100111,
        fromMap = 2112,
        fromX = 0.5659,
        fromY = 0.3826,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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
                    value = 67030,
                },
            },
        },
    },
    -- Valdrakken (map 2112 59.79,41.71) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 1100114,
        fromMap = 2112,
        fromX = 0.5979,
        fromY = 0.4171,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                    value = 67030,
                },
            },
        },
    },
    -- Valdrakken (map 2112 62.60,57.42) -> The Emerald Dream (map 2200 50.61,62.50) via portal
    {
        fromPointID = 1100115,
        fromMap = 2112,
        fromX = 0.626,
        fromY = 0.5742,
        toPointID = 1100198,
        toMap = 2200,
        toX = 0.5061,
        toY = 0.625,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 77572,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 77887,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Vale of Eternal Blossoms (map 1530)
    -- Vale of Eternal Blossoms New (map 1530 40.08,45.52) -> Ny'alotha, the Waking City (map 1580 0.00,0.00) via portal
    {
        fromPointID = 500285,
        fromMap = 1530,
        fromX = 0.4008,
        fromY = 0.4552,
        toPointID = 1300052,
        toMap = 1580,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "ValeInvasionRight",
                },
            },
        },
    },
    -- Vale of Eternal Blossoms New (map 1530 63.72,9.89) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 500289,
        fromMap = 1530,
        fromX = 0.6372,
        fromY = 0.0989,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
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
    -- Vale of Eternal Blossoms New (map 1530 72.86,41.91) -> Siege of Orgrimmar (map 557 0.00,0.00) via portal
    {
        fromPointID = 500290,
        fromMap = 1530,
        fromX = 0.7286,
        fromY = 0.4191,
        toPointID = 500264,
        toMap = 557,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Vale of Eternal Blossoms New (map 1530 80.97,29.48) -> Vale of Eternal Blossoms (map 390 80.48,31.95) via portal
    {
        fromPointID = 500291,
        fromMap = 1530,
        fromX = 0.8097,
        fromY = 0.2948,
        toPointID = 500115,
        toMap = 390,
        toX = 0.8048,
        toY = 0.3195,
        type = "portal",
    },
    -- Vale of Eternal Blossoms New (map 1530 81.60,29.88) -> Mogu'shan Palace (map 453 0.00,0.00) via portal
    {
        fromPointID = 500292,
        fromMap = 1530,
        fromX = 0.816,
        fromY = 0.2988,
        toPointID = 500180,
        toMap = 453,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
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
    -- Vale of Eternal Blossoms New (map 1530 84.49,51.74) -> Vale Vision (map 1570 84.49,52.14) via portal
    {
        fromPointID = 500294,
        fromMap = 1530,
        fromX = 0.8449,
        fromY = 0.5174,
        toPointID = 500302,
        toMap = 1570,
        toX = 0.8449,
        toY = 0.5214,
        type = "portal",
    },
    -- Vale of Eternal Blossoms New (map 1530 91.59,64.30) -> Stormwind City (map 84 46.35,90.23) via portal
    {
        fromPointID = 500296,
        fromMap = 1530,
        fromX = 0.9159,
        fromY = 0.643,
        toPointID = 200292,
        toMap = 84,
        toX = 0.4635,
        toY = 0.9023,
        type = "portal",
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
                            kind = "phase",
                            value = "OldVale",
                        },
                    },
                },
            },
        },
    },

    -- Zone: Vale of Eternal Blossoms (map 1570)
    -- Vale Vision (map 1570 84.49,51.74) -> Vale of Eternal Blossoms New (map 1530 84.20,51.53) via portal
    {
        fromPointID = 500301,
        fromMap = 1570,
        fromX = 0.8449,
        fromY = 0.5174,
        toPointID = 500293,
        toMap = 1530,
        toX = 0.842,
        toY = 0.5153,
        type = "portal",
    },

    -- Zone: Vale of Eternal Blossoms (map 390)
    -- Vale of Eternal Blossoms (map 390 14.20,76.72) -> Dread Wastes (map 422 75.09,21.29) via portal
    {
        fromPointID = 500107,
        fromMap = 390,
        fromX = 0.142,
        fromY = 0.7672,
        toPointID = 500141,
        toMap = 422,
        toX = 0.7509,
        toY = 0.2129,
        type = "portal",
    },
    -- Vale of Eternal Blossoms (map 390 15.90,74.30) -> Gate of the Setting Sun (map 437 61.30,87.80) via portal
    {
        fromPointID = 500108,
        fromMap = 390,
        fromX = 0.159,
        fromY = 0.743,
        toPointID = 500160,
        toMap = 437,
        toX = 0.613,
        toY = 0.878,
        type = "portal",
    },
    -- Vale of Eternal Blossoms (map 390 73.96,42.15) -> Siege of Orgrimmar (map 557 0.00,0.00) via portal
    {
        fromPointID = 500113,
        fromMap = 390,
        fromX = 0.7396,
        fromY = 0.4215,
        toPointID = 500264,
        toMap = 557,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "OldVale",
                },
            },
        },
    },
    -- Vale of Eternal Blossoms (map 390 80.48,31.95) -> Vale of Eternal Blossoms New (map 1530 80.97,29.48) via portal
    {
        fromPointID = 500115,
        fromMap = 390,
        fromX = 0.8048,
        fromY = 0.3195,
        toPointID = 500291,
        toMap = 1530,
        toX = 0.8097,
        toY = 0.2948,
        type = "portal",
    },
    -- Vale of Eternal Blossoms (map 390 80.90,32.60) -> Mogu'shan Palace (map 453 0.00,0.00) via portal
    {
        fromPointID = 500116,
        fromMap = 390,
        fromX = 0.809,
        fromY = 0.326,
        toPointID = 500180,
        toMap = 453,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "phase",
                    value = "OldVale",
                },
            },
        },
    },

    -- Zone: Valley of the Four Winds (map 376)
    -- Valley of the Four Winds (map 376 36.00,69.10) -> Stormstout Brewery (map 441 79.40,39.70) via portal
    {
        fromPointID = 500033,
        fromMap = 376,
        fromX = 0.36,
        fromY = 0.691,
        toPointID = 500167,
        toMap = 441,
        toX = 0.794,
        toY = 0.397,
        type = "portal",
    },
    -- Valley of the Four Winds (map 376 51.25,77.50) -> Krasarang Wilds (map 418 50.47,22.42) via portal
    {
        fromPointID = 500034,
        fromMap = 376,
        fromX = 0.5125,
        fromY = 0.775,
        toPointID = 500125,
        toMap = 418,
        toX = 0.5047,
        toY = 0.2242,
        type = "portal",
    },

    -- Zone: Vault of Memory (map 2367)
    -- Vault of Memory (map 2367 49.94,35.95) -> Dornogal (map 2339 29.77,59.67) via portal
    {
        fromPointID = 1200155,
        fromMap = 2367,
        fromX = 0.4994,
        fromY = 0.3595,
        toPointID = 1200117,
        toMap = 2339,
        toX = 0.2977,
        toY = 0.5967,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83271,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83271,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 79573,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Vault of the Incarnates (map 2122)
    -- Vault of the Incarnates (map 2122 0.00,0.00) -> Thaldraszus (map 2025 73.15,55.61) via portal
    {
        fromPointID = 1100122,
        fromMap = 2122,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100075,
        toMap = 2025,
        toX = 0.7315,
        toY = 0.5561,
        type = "portal",
    },

    -- Zone: Vault of the Wardens (map 677)
    -- Vault of the Wardens (map 677 70.28,77.60) -> Azsuna (map 630 48.30,80.23) via portal
    {
        fromPointID = 700137,
        fromMap = 677,
        fromX = 0.7028,
        fromY = 0.776,
        toPointID = 700052,
        toMap = 630,
        toX = 0.483,
        toY = 0.8023,
        type = "portal",
    },

    -- Zone: Vault of the Wardens (map 710)
    -- Vault of the Wardens 2 (map 710 70.28,77.60) -> Azsuna (map 630 48.30,80.23) via portal
    {
        fromPointID = 700222,
        fromMap = 710,
        fromX = 0.7028,
        fromY = 0.776,
        toPointID = 700052,
        toMap = 630,
        toX = 0.483,
        toY = 0.8023,
        type = "portal",
    },

    -- Zone: Vaults of Atal'Utek (map 2509)
    -- Vaults of Atal'Utek (map 2509 47.24,68.55) -> Altar of Fangs (map 2588 48.95,18.11) via portal
    {
        fromPointID = 200762,
        fromMap = 2509,
        fromX = 0.4724,
        fromY = 0.6855,
        toPointID = 200859,
        toMap = 2588,
        toX = 0.4895,
        toY = 0.1811,
        type = "portal",
    },
    -- Vaults of Atal'Utek (map 2509 47.25,20.51) -> The Venomous Abyss (map 2606 49.78,94.15) via portal
    {
        fromPointID = 200763,
        fromMap = 2509,
        fromX = 0.4725,
        fromY = 0.2051,
        toPointID = 200872,
        toMap = 2606,
        toX = 0.4978,
        toY = 0.9415,
        type = "portal",
    },

    -- Zone: Venomfall Deeps (map 2634)
    -- Venomfall Deeps (map 2634 50.02,94.76) -> The Coiled Isle (map 2512 51.23,30.26) via portal
    {
        fromPointID = 200890,
        fromMap = 2634,
        fromX = 0.5002,
        fromY = 0.9476,
        toPointID = 200789,
        toMap = 2512,
        toX = 0.5123,
        toY = 0.3026,
        type = "portal",
    },

    -- Zone: Violet Hold (map 732)
    -- Violet Hold (map 732 50.95,69.91) -> Dalaran L (map 627 66.94,69.16) via portal
    {
        fromPointID = 700252,
        fromMap = 732,
        fromX = 0.5095,
        fromY = 0.6991,
        toPointID = 700026,
        toMap = 627,
        toX = 0.6694,
        toY = 0.6916,
        type = "portal",
    },

    -- Zone: Vision of Orgrimmar (map 1469)
    -- Orgrimmar Vision (map 1469 51.89,82.74) -> Dornogal (map 2339 34.67,68.29) via portal
    {
        fromPointID = 100462,
        fromMap = 1469,
        fromX = 0.5189,
        fromY = 0.8274,
        toPointID = 1200120,
        toMap = 2339,
        toX = 0.3467,
        toY = 0.6829,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 87328,
                },
            },
        },
    },
    -- Orgrimmar Vision (map 1469 52.05,85.47) -> Chamber of Heart (map 1021 48.71,68.43) via portal
    {
        fromPointID = 100463,
        fromMap = 1469,
        fromX = 0.5205,
        fromY = 0.8547,
        toPointID = 100456,
        toMap = 1021,
        toX = 0.4871,
        toY = 0.6843,
        type = "portal",
    },

    -- Zone: Vision of Stormwind (map 1470)
    -- Stormwind Vision (map 1470 52.18,51.67) -> Chamber of Heart (map 1021 48.71,68.43) via portal
    {
        fromPointID = 200631,
        fromMap = 1470,
        fromX = 0.5218,
        fromY = 0.5167,
        toPointID = 100456,
        toMap = 1021,
        toX = 0.4871,
        toY = 0.6843,
        type = "portal",
    },

    -- Zone: Vision of Stormwind (map 2404)
    -- Vision of Stormwind (map 2404 53.27,53.16) -> Dornogal (map 2339 34.67,68.29) via portal
    {
        fromPointID = 200679,
        fromMap = 2404,
        fromX = 0.5327,
        fromY = 0.5316,
        toPointID = 1200120,
        toMap = 2339,
        toX = 0.3467,
        toY = 0.6829,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 87328,
                },
            },
        },
    },

    -- Zone: Void Acropolis (map 2618)
    -- Void Acropolis (map 2618 63.49,78.53) -> Val (map 2599 49.46,97.49) via portal
    {
        fromPointID = 200883,
        fromMap = 2618,
        fromX = 0.6349,
        fromY = 0.7853,
        toPointID = 200866,
        toMap = 2599,
        toX = 0.4946,
        toY = 0.9749,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Void Acropolis (map 2619)
    -- Void Acropolis (map 2619 39.88,31.99) -> Val (map 2599 33.76,75.48) via portal
    {
        fromPointID = 200885,
        fromMap = 2619,
        fromX = 0.3988,
        fromY = 0.3199,
        toPointID = 200864,
        toMap = 2599,
        toX = 0.3376,
        toY = 0.7548,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Voidscar Arena (map 2574)
    -- Voidscar Arena (map 2574 0.00,0.00) -> Slayers Rise (map 2444 53.67,33.08) via portal
    {
        fromPointID = 200842,
        fromMap = 2574,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200730,
        toMap = 2444,
        toX = 0.5367,
        toY = 0.3308,
        type = "portal",
    },

    -- Zone: Voidstorm (map 2405)
    -- Voidstorm (map 2405 33.98,60.68) -> Silvermoon City M (map 2393 35.28,65.14) via portal
    {
        fromPointID = 200680,
        fromMap = 2405,
        fromX = 0.3398,
        fromY = 0.6068,
        toPointID = 200654,
        toMap = 2393,
        toX = 0.3528,
        toY = 0.6514,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86549,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86549,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86510,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 37.38,47.74) -> Shadowguard Point (map 2506 46.43,87.96) via portal
    {
        fromPointID = 200683,
        fromMap = 2405,
        fromX = 0.3738,
        fromY = 0.4774,
        toPointID = 200756,
        toMap = 2506,
        toX = 0.4643,
        toY = 0.8796,
        type = "portal",
    },
    -- Voidstorm (map 2405 45.21,64.79) -> The Voidspire (map 2529 0.00,0.00) via portal
    {
        fromPointID = 200686,
        fromMap = 2405,
        fromX = 0.4521,
        fromY = 0.6479,
        toPointID = 200820,
        toMap = 2529,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Voidstorm (map 2405 51.42,71.32) -> Val (map 2599 61.83,15.98) via portal
    {
        fromPointID = 200689,
        fromMap = 2405,
        fromX = 0.5142,
        fromY = 0.7132,
        toPointID = 200867,
        toMap = 2599,
        toX = 0.6183,
        toY = 0.1598,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97071,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97071,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 51.42,71.32) -> Naigtal (map 2600 48.65,82.79) via portal
    {
        fromPointID = 200689,
        fromMap = 2405,
        fromX = 0.5142,
        fromY = 0.7132,
        toPointID = 200871,
        toMap = 2600,
        toX = 0.4865,
        toY = 0.8279,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 97072,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97072,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 51.42,71.32) -> Val (map 2599 63.61,15.91) via portal
    {
        fromPointID = 200689,
        fromMap = 2405,
        fromX = 0.5142,
        fromY = 0.7132,
        toPointID = 200868,
        toMap = 2599,
        toX = 0.6361,
        toY = 0.1591,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96051,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96051,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97071,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 51.42,71.32) -> Naigtal (map 2600 46.55,83.60) via portal
    {
        fromPointID = 200689,
        fromMap = 2405,
        fromX = 0.5142,
        fromY = 0.7132,
        toPointID = 200870,
        toMap = 2600,
        toX = 0.4655,
        toY = 0.836,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 96052,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 96052,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 97072,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 51.56,70.29) -> Silvermoon City M (map 2393 35.30,65.23) via portal
    {
        fromPointID = 200690,
        fromMap = 2405,
        fromX = 0.5156,
        fromY = 0.7029,
        toPointID = 200657,
        toMap = 2393,
        toX = 0.353,
        toY = 0.6523,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "achievement",
                            value = 41806,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 86510,
                        },
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 86510,
                        },
                    },
                },
            },
        },
    },
    -- Voidstorm (map 2405 51.71,70.40) -> Harandar (map 2413 53.14,55.35) via portal
    {
        fromPointID = 200692,
        fromMap = 2405,
        fromX = 0.5171,
        fromY = 0.704,
        toPointID = 200699,
        toMap = 2413,
        toX = 0.5314,
        toY = 0.5535,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "achievement",
                    value = 41804,
                },
            },
        },
    },
    -- Voidstorm (map 2405 54.78,47.28) -> Sunkiller Sanctum (map 2528 65.11,28.37) via portal
    {
        fromPointID = 200693,
        fromMap = 2405,
        fromX = 0.5478,
        fromY = 0.4728,
        toPointID = 200819,
        toMap = 2528,
        toX = 0.6511,
        toY = 0.2837,
        type = "portal",
    },
    -- Voidstorm (map 2405 64.93,61.78) -> Nexus Point Xenas (map 2556 0.00,0.00) via portal
    {
        fromPointID = 200694,
        fromMap = 2405,
        fromX = 0.6493,
        fromY = 0.6178,
        toPointID = 200832,
        toMap = 2556,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Vol'dun (map 864)
    -- Vol'dun (map 864 51.94,24.78) -> Temple of Sethraliss (map 1038 0.00,0.00) via portal
    {
        fromPointID = 900060,
        fromMap = 864,
        fromX = 0.5194,
        fromY = 0.2478,
        toPointID = 900069,
        toMap = 1038,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Wailing Caverns (map 11)
    -- Northern Barrens (map 11 23.50,81.29) -> WC Pet Battle (map 825 60.16,60.57) via portal
    {
        fromPointID = 100056,
        fromMap = 11,
        fromX = 0.235,
        fromY = 0.8129,
        toPointID = 100454,
        toMap = 825,
        toX = 0.6016,
        toY = 0.6057,
        type = "portal",
    },
    -- Northern Barrens (map 11 55.03,66.11) -> Wailing Caverns (map 279 0.00,0.00) via portal
    {
        fromPointID = 100064,
        fromMap = 11,
        fromX = 0.5503,
        fromY = 0.6611,
        toPointID = 100379,
        toMap = 279,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Wailing Caverns (map 279)
    -- Wailing Caverns (map 279 0.00,0.00) -> Northern Barrens (map 11 55.03,66.11) via portal
    {
        fromPointID = 100379,
        fromMap = 279,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100064,
        toMap = 11,
        toX = 0.5503,
        toY = 0.6611,
        type = "portal",
    },

    -- Zone: Wailing Caverns (map 825)
    -- WC Pet Battle (map 825 60.23,62.67) -> Northern Barrens (map 11 23.50,81.29) via portal
    {
        fromPointID = 100455,
        fromMap = 825,
        fromX = 0.6023,
        fromY = 0.6267,
        toPointID = 100056,
        toMap = 11,
        toX = 0.235,
        toY = 0.8129,
        type = "portal",
    },

    -- Zone: Warspear (map 624)
    -- Warspear (map 624 53.16,43.91) -> Tanaan Jungle (map 534 60.90,47.30) via portal
    {
        fromPointID = 600140,
        fromMap = 624,
        fromX = 0.5316,
        fromY = 0.4391,
        toPointID = 600035,
        toMap = 534,
        toX = 0.609,
        toY = 0.473,
        type = "portal",
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
                    value = 37935,
                },
            },
        },
    },
    -- Warspear (map 624 60.70,51.60) -> Orgrimmar (map 85 57.10,89.81) via portal
    {
        fromPointID = 600142,
        fromMap = 624,
        fromX = 0.607,
        fromY = 0.516,
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
        type = "portal",
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

    -- Zone: Waycrest Manor (map 1015)
    -- Waycrest Manor (map 1015 0.00,0.00) -> Drustvar (map 896 33.68,12.33) via portal
    {
        fromPointID = 800061,
        fromMap = 1015,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 800027,
        toMap = 896,
        toX = 0.3368,
        toY = 0.1233,
        type = "portal",
    },

    -- Zone: Well of Eternity (map 398)
    -- Well of Eternity (map 398 27.82,63.37) -> Tanaris (map 75 22.50,64.40) via portal
    {
        fromPointID = 100414,
        fromMap = 398,
        fromX = 0.2782,
        fromY = 0.6337,
        toPointID = 100206,
        toMap = 75,
        toX = 0.225,
        toY = 0.644,
        type = "portal",
    },

    -- Zone: Western Plaguelands (map 22)
    -- Western Plaguelands (map 22 69.10,72.90) -> Scholomance (map 476 18.10,60.90) via portal
    {
        fromPointID = 200083,
        fromMap = 22,
        fromX = 0.691,
        fromY = 0.729,
        toPointID = 200616,
        toMap = 476,
        toX = 0.181,
        toY = 0.609,
        type = "portal",
    },
    -- Western Plaguelands (map 22 69.76,71.79) -> Old Scholomance (map 306 0.00,0.00) via portal
    {
        fromPointID = 200084,
        fromMap = 22,
        fromX = 0.6976,
        fromY = 0.7179,
        toPointID = 200526,
        toMap = 306,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Windrunner Spire (map 2492)
    -- Windrunner Spire (map 2492 0.00,0.00) -> Eversong Woods M (map 2395 35.37,78.82) via portal
    {
        fromPointID = 200731,
        fromMap = 2492,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 200672,
        toMap = 2395,
        toX = 0.3537,
        toY = 0.7882,
        type = "portal",
    },

    -- Zone: Winterspring (map 83)
    -- Winterspring (map 83 22.56,46.50) -> Elwynn Forest (map 37 34.48,51.42) via portal
    {
        fromPointID = 100250,
        fromMap = 83,
        fromX = 0.2256,
        fromY = 0.465,
        toPointID = 200173,
        toMap = 37,
        toX = 0.3448,
        toY = 0.5142,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
    },
    -- Winterspring (map 83 22.56,46.50) -> Durotar (map 1 41.43,16.61) via portal
    {
        fromPointID = 100250,
        fromMap = 83,
        fromX = 0.2256,
        fromY = 0.465,
        toPointID = 100006,
        toMap = 1,
        toX = 0.4143,
        toY = 0.1661,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "event",
                    value = "Love is in the Air",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },

    -- Zone: Zandalari Treasury (map 1348)
    -- Zandalari Treasury (map 1348 20.72,80.94) -> Zuldazar (map 862 40.60,70.76) via portal
    {
        fromPointID = 900098,
        fromMap = 1348,
        fromX = 0.2072,
        fromY = 0.8094,
        toPointID = 900008,
        toMap = 862,
        toX = 0.406,
        toY = 0.7076,
        type = "portal",
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
                    kind = "questActive",
                    value = 54169,
                },
            },
        },
    },

    -- Zone: Zangarmarsh (map 102)
    -- Zangarmarsh (map 102 48.95,35.70) -> The Slave Pens (map 265 19.95,13.37) via portal
    {
        fromPointID = 300032,
        fromMap = 102,
        fromX = 0.4895,
        fromY = 0.357,
        toPointID = 300131,
        toMap = 265,
        toX = 0.1995,
        toY = 0.1337,
        type = "portal",
    },
    -- Zangarmarsh (map 102 49.19,55.37) -> Nagrand D (map 550 81.13,8.97) via portal
    {
        fromPointID = 300033,
        fromMap = 102,
        fromX = 0.4919,
        fromY = 0.5537,
        toPointID = 600116,
        toMap = 550,
        toX = 0.8113,
        toY = 0.0897,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Zangarmarsh (map 102 50.29,33.33) -> The Steamvault (map 263 17.59,29.76) via portal
    {
        fromPointID = 300034,
        fromMap = 102,
        fromX = 0.5029,
        fromY = 0.3333,
        toPointID = 300122,
        toMap = 263,
        toX = 0.1759,
        toY = 0.2976,
        type = "portal",
    },
    -- Zangarmarsh (map 102 51.90,32.78) -> Serpentshrine Cavern (map 332 13.49,61.14) via portal
    {
        fromPointID = 300038,
        fromMap = 102,
        fromX = 0.519,
        fromY = 0.3278,
        toPointID = 300145,
        toMap = 332,
        toX = 0.1349,
        toY = 0.6114,
        type = "portal",
    },
    -- Zangarmarsh (map 102 54.28,34.40) -> The Underbog (map 262 29.68,67.88) via portal
    {
        fromPointID = 300040,
        fromMap = 102,
        fromX = 0.5428,
        fromY = 0.344,
        toPointID = 300121,
        toMap = 262,
        toX = 0.2968,
        toY = 0.6788,
        type = "portal",
    },
    -- Zangarmarsh (map 102 68.20,88.46) -> Nagrand D (map 550 88.36,22.84) via portal
    {
        fromPointID = 300042,
        fromMap = 102,
        fromX = 0.682,
        fromY = 0.8846,
        toPointID = 600118,
        toMap = 550,
        toX = 0.8836,
        toY = 0.2284,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },
    -- Zangarmarsh (map 102 82.59,66.13) -> Talador (map 535 68.42,9.32) via portal
    {
        fromPointID = 300047,
        fromMap = 102,
        fromX = 0.8259,
        fromY = 0.6613,
        toPointID = 600052,
        toMap = 535,
        toX = 0.6842,
        toY = 0.0932,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "toyKnown",
                    value = 129929,
                },
            },
        },
    },

    -- Zone: Zaralek Cavern (map 2133)
    -- Zaralek Cavern (map 2133 48.46,9.94) -> Aberrus, the Shadowed Crucible (map 2166 51.10,95.59) via portal
    {
        fromPointID = 1100150,
        fromMap = 2133,
        fromX = 0.4846,
        fromY = 0.0994,
        toPointID = 1100169,
        toMap = 2166,
        toX = 0.511,
        toY = 0.9559,
        type = "portal",
    },

    -- Zone: Zereth Mortis (map 1970)
    -- Zereth Mortis (map 1970 32.87,69.77) -> Oribos (map 1671 49.55,30.04) via portal
    {
        fromPointID = 1000322,
        fromMap = 1970,
        fromX = 0.3287,
        fromY = 0.6977,
        toPointID = 1000187,
        toMap = 1671,
        toX = 0.4955,
        toY = 0.3004,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 64957,
                },
            },
        },
    },
    -- Zereth Mortis (map 1970 81.02,53.40) -> Sepulcher of the First Ones (map 2047 0.00,0.00) via portal
    {
        fromPointID = 1000330,
        fromMap = 1970,
        fromX = 0.8102,
        fromY = 0.534,
        toPointID = 1000365,
        toMap = 2047,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Zul'Aman (map 2437)
    -- Zul Aman M (map 2437 25.41,84.51) -> Twilight Crypts (map 2503 49.12,10.46) via portal
    {
        fromPointID = 200721,
        fromMap = 2437,
        fromX = 0.2541,
        fromY = 0.8451,
        toPointID = 200751,
        toMap = 2503,
        toX = 0.4912,
        toY = 0.1046,
        type = "portal",
    },
    -- Zul Aman M (map 2437 29.79,84.51) -> Den of Nalorakk (map 2564 0.00,0.00) via portal
    {
        fromPointID = 200722,
        fromMap = 2437,
        fromX = 0.2979,
        fromY = 0.8451,
        toPointID = 200833,
        toMap = 2564,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Zul Aman M (map 2437 43.74,39.43) -> Maisara Caverns (map 2501 0.00,0.00) via portal
    {
        fromPointID = 200727,
        fromMap = 2437,
        fromX = 0.4374,
        fromY = 0.3943,
        toPointID = 200749,
        toMap = 2501,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },

    -- Zone: Zul'Aman (map 333)
    -- Zul'Aman (map 333 7.32,52.97) -> Ghostlands (map 95 82.28,64.30) via portal
    {
        fromPointID = 200554,
        fromMap = 333,
        fromX = 0.0732,
        fromY = 0.5297,
        toPointID = 200339,
        toMap = 95,
        toX = 0.8228,
        toY = 0.643,
        type = "portal",
    },

    -- Zone: Zul'Drak (map 121)
    -- Zul'Drak (map 121 28.52,86.93) -> Drak'Tharon Keep (map 160 29.38,80.96) via portal
    {
        fromPointID = 400096,
        fromMap = 121,
        fromX = 0.2852,
        fromY = 0.8693,
        toPointID = 400188,
        toMap = 160,
        toX = 0.2938,
        toY = 0.8096,
        type = "portal",
    },
    -- Zul'Drak (map 121 76.12,20.92) -> Gundrak (map 154 58.99,30.92) via portal
    {
        fromPointID = 400105,
        fromMap = 121,
        fromX = 0.7612,
        fromY = 0.2092,
        toPointID = 400180,
        toMap = 154,
        toX = 0.5899,
        toY = 0.3092,
        type = "portal",
    },

    -- Zone: Zul'Farrak (map 219)
    -- Zul'Farrak (map 219 0.00,0.00) -> Tanaris (map 71 39.21,21.21) via portal
    {
        fromPointID = 100343,
        fromMap = 219,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 100187,
        toMap = 71,
        toX = 0.3921,
        toY = 0.2121,
        type = "portal",
    },

    -- Zone: Zul'Gurub (map 337)
    -- Zul'Gurub (map 337 30.23,48.85) -> Northern Stranglethorn (map 50 72.18,32.91) via portal
    {
        fromPointID = 200558,
        fromMap = 337,
        fromX = 0.3023,
        fromY = 0.4885,
        toPointID = 200229,
        toMap = 50,
        toX = 0.7218,
        toY = 0.3291,
        type = "portal",
    },

    -- Zone: Zuldazar (map 862)
    -- Zuldazar (map 862 22.55,54.07) -> Undermine (map 2346 18.80,52.21) via portal
    {
        fromPointID = 900001,
        fromMap = 862,
        fromX = 0.2255,
        fromY = 0.5407,
        toPointID = 1200140,
        toMap = 2346,
        toX = 0.188,
        toY = 0.5221,
        type = "portal",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questActive",
                            value = 83933,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 83933,
                        },
                        {
                            operation = "check",
                            kind = "achievement",
                            value = {
                                criteria = 1,
                                id = 40900,
                            },
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "minLevel",
                    value = 80,
                },
            },
        },
    },
    -- Zuldazar (map 862 37.49,39.47) -> King's Rest (map 1004 87.94,47.17) via portal
    {
        fromPointID = 900002,
        fromMap = 862,
        fromX = 0.3749,
        fromY = 0.3947,
        toPointID = 900068,
        toMap = 1004,
        toX = 0.8794,
        toY = 0.4717,
        type = "portal",
    },
    -- Zuldazar (map 862 39.24,71.41) -> The MOTHERLODE!! (map 1010 0.00,0.00) via portal
    {
        fromPointID = 900004,
        fromMap = 862,
        fromX = 0.3924,
        fromY = 0.7141,
        toPointID = 1300025,
        toMap = 1010,
        toX = 0.0,
        toY = 0.0,
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
    },
    -- Zuldazar (map 862 40.60,70.70) -> Zandalari Treasury (map 1348 22.41,81.16) via portal
    {
        fromPointID = 900007,
        fromMap = 862,
        fromX = 0.406,
        fromY = 0.707,
        toPointID = 900099,
        toMap = 1348,
        toX = 0.2241,
        toY = 0.8116,
        type = "portal",
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
                    kind = "questActive",
                    value = 54169,
                },
            },
        },
    },
    -- Zuldazar (map 862 43.35,39.48) -> Atal'Dazar (map 934 0.00,0.00) via portal
    {
        fromPointID = 900011,
        fromMap = 862,
        fromX = 0.4335,
        fromY = 0.3948,
        toPointID = 900067,
        toMap = 934,
        toX = 0.0,
        toY = 0.0,
        type = "portal",
    },
    -- Zuldazar (map 862 58.46,62.99) -> Darkshore Warfront (map 1332 54.48,19.00) via portal
    {
        fromPointID = 900024,
        fromMap = 862,
        fromX = 0.5846,
        fromY = 0.6299,
        toPointID = 100461,
        toMap = 1332,
        toX = 0.5448,
        toY = 0.19,
        type = "portal",
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
                    value = 54042,
                },
            },
        },
    },
}

Navigation:RegisterPathData("portal", PORTAL)
