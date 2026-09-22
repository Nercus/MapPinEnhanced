---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local SPELL = {

    -- Zone: Acherus: The Ebon Hold (map 648)
    -- current position -> Broken Shore (map 648 27.43,30.43) via spell
    {
        toPointID = 700121,
        toMap = 648,
        toX = 0.2743,
        toY = 0.3043,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 38990,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40935,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40740,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "currentMap",
                            value = 647,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "currentMap",
                            value = 648,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "currentMap",
                            value = 646,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 50977,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 50977,
                },
            },
        },
        spellID = 50977,
    },

    -- Zone: Boralus (map 1161)
    -- current position -> Boralus (map 1161 69.80,15.75) via spell
    {
        toPointID = 800078,
        toMap = 1161,
        toX = 0.698,
        toY = 0.1575,
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
                    value = 281403,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 281403,
                },
            },
        },
        spellID = 281403,
    },

    -- Zone: Dalaran (map 125)
    -- current position -> Dalaran (map 125 55.92,46.79) via spell
    {
        toPointID = 400120,
        toMap = 125,
        toX = 0.5592,
        toY = 0.4679,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 53140,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 53140,
                },
            },
        },
        spellID = 53140,
    },

    -- Zone: Dalaran (map 627)
    -- current position -> Dalaran L (map 627 60.92,44.73) via spell
    {
        toPointID = 700020,
        toMap = 627,
        toX = 0.6092,
        toY = 0.4473,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 224869,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 224869,
                },
            },
        },
        spellID = 224869,
    },

    -- Zone: Darkshore (map 62)
    -- current position -> Darkshore (map 62 45.95,18.74) via spell
    {
        toPointID = 100083,
        toMap = 62,
        toX = 0.4595,
        toY = 0.1874,
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

    -- Zone: Darnassus (map 89)
    -- current position -> Darnassus (map 89 43.47,78.67) via spell
    {
        toPointID = 100299,
        toMap = 89,
        toX = 0.4347,
        toY = 0.7867,
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
                    kind = "phase",
                    value = "Old Darnassus",
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

    -- Zone: Dazar'alor (map 1163)
    -- current position -> Dazar'alor (map 1163 68.28,64.58) via spell
    {
        toPointID = 900074,
        toMap = 1163,
        toX = 0.6828,
        toY = 0.6458,
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
                    value = 281404,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 281404,
                },
            },
        },
        spellID = 281404,
    },

    -- Zone: Dornogal (map 2339)
    -- current position -> Dornogal (map 2339 41.29,27.46) via spell
    {
        toPointID = 1200126,
        toMap = 2339,
        toX = 0.4129,
        toY = 0.2746,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 446540,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 446540,
                },
            },
        },
        spellID = 446540,
    },

    -- Zone: Dustwallow Marsh (map 70)
    -- current position -> Dustwallow Marsh (map 70 66.00,48.99) via spell
    {
        toPointID = 100177,
        toMap = 70,
        toX = 0.66,
        toY = 0.4899,
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
                    value = 49359,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 49359,
                },
            },
        },
        spellID = 49359,
    },

    -- Zone: Eastern Plaguelands (map 23)
    -- current position -> Eastern Plaguelands (map 23 83.72,50.03) via spell
    {
        toPointID = 200098,
        toMap = 23,
        toX = 0.8372,
        toY = 0.5003,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 38990,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40935,
                        },
                    },
                },
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40740,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 50977,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 50977,
                },
            },
        },
        spellID = 50977,
    },

    -- Zone: Emerald Dreamway (map 715)
    -- current position -> Emerald Dreamway (map 715 35.33,53.15) via spell
    {
        toPointID = 700230,
        toMap = 715,
        toX = 0.3533,
        toY = 0.5315,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "currentMap",
                            value = 715,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 193753,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 193753,
                },
            },
        },
        spellID = 193753,
    },

    -- Zone: Hall of the Guardian (map 734)
    -- current position -> Hall of the Guardian (map 734 57.63,86.13) via spell
    {
        toPointID = 700257,
        toMap = 734,
        toX = 0.5763,
        toY = 0.8613,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 193759,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 193759,
                },
            },
        },
        spellID = 193759,
    },

    -- Zone: Highmountain (map 650)
    -- current position -> Highmountain (map 650 49.56,68.66) via spell
    {
        toPointID = 700131,
        toMap = 650,
        toX = 0.4956,
        toY = 0.6866,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 205379,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 205379,
                },
            },
        },
        spellID = 205379,
    },

    -- Zone: Hillsbrad Foothills (map 25)
    -- current position -> Hillsbrad Foothills (map 25 30.81,36.47) via spell
    {
        toPointID = 200103,
        toMap = 25,
        toX = 0.3081,
        toY = 0.3647,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 120145,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 120145,
                },
            },
        },
        spellID = 120145,
    },

    -- Zone: Ironforge (map 87)
    -- current position -> Ironforge (map 87 25.51,8.43) via spell
    {
        toPointID = 200324,
        toMap = 87,
        toX = 0.2551,
        toY = 0.0843,
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

    -- Zone: Kun-Lai Summit (map 379)
    -- current position -> Kun-Lai Summit (map 379 48.64,42.94) via spell
    {
        toPointID = 500056,
        toMap = 379,
        toX = 0.4864,
        toY = 0.4294,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 40236,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 126892,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 126892,
                },
            },
        },
        spellID = 126892,
    },

    -- Zone: Moonglade (map 80)
    -- current position -> Moonglade (map 80 56.30,32.40) via spell
    {
        toPointID = 100236,
        toMap = 80,
        toX = 0.563,
        toY = 0.324,
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

    -- Zone: Nazmir (map 863)
    -- current position -> Nazmir (map 863 51.38,64.83) via spell
    {
        toPointID = 900045,
        toMap = 863,
        toX = 0.5138,
        toY = 0.6483,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 272269,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 272269,
                },
            },
        },
        spellID = 272269,
    },

    -- Zone: Orgrimmar (map 85)
    -- current position -> Orgrimmar (map 85 57.10,89.81) via spell
    {
        toPointID = 100278,
        toMap = 85,
        toX = 0.571,
        toY = 0.8981,
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

    -- Zone: Oribos (map 1670)
    -- current position -> Oribos (map 1670 20.37,50.32) via spell
    {
        toPointID = 1000166,
        toMap = 1670,
        toX = 0.2037,
        toY = 0.5032,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 344587,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 344587,
                },
            },
        },
        spellID = 344587,
    },

    -- Zone: Shattrath City (map 111)
    -- current position -> Shattrath City (map 111 54.97,40.23) via spell
    {
        toPointID = 300104,
        toMap = 111,
        toX = 0.5497,
        toY = 0.4023,
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
                    value = 33690,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 33690,
                },
            },
        },
        spellID = 33690,
    },
    -- current position -> Shattrath City (map 111 53.00,49.20) via spell
    {
        toPointID = 300102,
        toMap = 111,
        toX = 0.53,
        toY = 0.492,
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
                    value = 35715,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 35715,
                },
            },
        },
        spellID = 35715,
    },

    -- Zone: Silvermoon City (map 110)
    -- current position -> Silvermoon City (map 110 58.30,19.20) via spell
    {
        toPointID = 200342,
        toMap = 110,
        toX = 0.583,
        toY = 0.192,
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
                    value = 32272,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 32272,
                },
            },
        },
        spellID = 32272,
    },

    -- Zone: Silvermoon City (map 2393)
    -- current position -> Silvermoon City M (map 2393 52.85,65.51) via spell
    {
        toPointID = 200667,
        toMap = 2393,
        toX = 0.5285,
        toY = 0.6551,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 1259190,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1259190,
                },
            },
        },
        spellID = 1259190,
    },

    -- Zone: Stormshield (map 622)
    -- current position -> Stormshield (map 622 62.67,35.78) via spell
    {
        toPointID = 600137,
        toMap = 622,
        toX = 0.6267,
        toY = 0.3578,
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
                    value = 176248,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 176248,
                },
            },
        },
        spellID = 176248,
    },

    -- Zone: Stormwind City (map 84)
    -- current position -> Stormwind City (map 84 49.59,86.53) via spell
    {
        toPointID = 200303,
        toMap = 84,
        toX = 0.4959,
        toY = 0.8653,
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

    -- Zone: Swamp of Sorrows (map 51)
    -- current position -> Swamp of Sorrows (map 51 49.80,55.80) via spell
    {
        toPointID = 200234,
        toMap = 51,
        toX = 0.498,
        toY = 0.558,
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
                    value = 49358,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 49358,
                },
            },
        },
        spellID = 49358,
    },

    -- Zone: The Exodar (map 103)
    -- current position -> The Exodar (map 103 47.62,59.82) via spell
    {
        toPointID = 100312,
        toMap = 103,
        toX = 0.4762,
        toY = 0.5982,
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
                    value = 32271,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 32271,
                },
            },
        },
        spellID = 32271,
    },

    -- Zone: The Wandering Isle (map 709)
    -- current position -> The Wandering Isle L (map 709 51.46,48.65) via spell
    {
        toPointID = 700220,
        toMap = 709,
        toX = 0.5146,
        toY = 0.4865,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "currentMap",
                            value = 709,
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 40236,
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 126892,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 126892,
                },
            },
        },
        spellID = 126892,
    },

    -- Zone: Thunder Bluff (map 88)
    -- current position -> Thunder Bluff (map 88 22.20,16.90) via spell
    {
        toPointID = 100294,
        toMap = 88,
        toX = 0.222,
        toY = 0.169,
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

    -- Zone: Tiragarde Sound (map 895)
    -- current position -> Tiragarde Sound (map 895 84.45,78.88) via spell
    {
        toPointID = 800014,
        toMap = 895,
        toX = 0.8445,
        toY = 0.7888,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 257701,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 257701,
                },
            },
        },
        spellID = 257701,
    },

    -- Zone: Tol Barad Peninsula (map 245)
    -- current position -> Tol Barad Peninsula (map 245 73.67,60.92) via spell
    {
        toPointID = 200470,
        toMap = 245,
        toX = 0.7367,
        toY = 0.6092,
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
                    value = 88342,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 88342,
                },
            },
        },
        spellID = 88342,
    },
    -- current position -> Tol Barad Peninsula (map 245 55.80,80.10) via spell
    {
        toPointID = 200467,
        toMap = 245,
        toX = 0.558,
        toY = 0.801,
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
                    value = 88344,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 88344,
                },
            },
        },
        spellID = 88344,
    },

    -- Zone: Uldum (map 1527)
    -- current position -> Uldum New (map 1527 76.84,84.61) via spell
    {
        toPointID = 100474,
        toMap = 1527,
        toX = 0.7684,
        toY = 0.8461,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 88775,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 88775,
                },
            },
        },
        spellID = 88775,
    },

    -- Zone: Uldum (map 249)
    -- current position -> Uldum (map 249 76.81,84.55) via spell
    {
        toPointID = 100374,
        toMap = 249,
        toX = 0.7681,
        toY = 0.8455,
        type = "spell",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 88775,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 88775,
                },
            },
        },
        spellID = 88775,
    },

    -- Zone: Undercity (map 90)
    -- current position -> Undercity (map 90 84.58,16.33) via spell
    {
        toPointID = 200331,
        toMap = 90,
        toX = 0.8458,
        toY = 0.1633,
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

    -- Zone: Valdrakken (map 2112)
    -- current position -> Valdrakken (map 2112 57.13,42.33) via spell
    {
        toPointID = 1100112,
        toMap = 2112,
        toX = 0.5713,
        toY = 0.4233,
        type = "spell",
        travelDuration = 35,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 395277,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 395277,
                },
            },
        },
        spellID = 395277,
    },

    -- Zone: Vale of Eternal Blossoms (map 1530)
    -- current position -> Vale of Eternal Blossoms New (map 1530 86.85,59.09) via spell
    {
        toPointID = 500295,
        toMap = 1530,
        toX = 0.8685,
        toY = 0.5909,
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
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Vale",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 132621,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 132621,
                },
            },
        },
        spellID = 132621,
    },
    -- current position -> Vale of Eternal Blossoms New (map 1530 62.68,19.30) via spell
    {
        toPointID = 500288,
        toMap = 1530,
        toX = 0.6268,
        toY = 0.193,
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
                    operation = "not",
                    children = {
                        {
                            operation = "check",
                            kind = "phase",
                            value = "Old Vale",
                        },
                    },
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 132627,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 132627,
                },
            },
        },
        spellID = 132627,
    },

    -- Zone: Vale of Eternal Blossoms (map 390)
    -- current position -> Vale of Eternal Blossoms (map 390 86.30,61.05) via spell
    {
        toPointID = 500117,
        toMap = 390,
        toX = 0.863,
        toY = 0.6105,
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
                    kind = "phase",
                    value = "Old Vale",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 132621,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 132621,
                },
            },
        },
        spellID = 132621,
    },
    -- current position -> Vale of Eternal Blossoms (map 390 62.21,21.54) via spell
    {
        toPointID = 500112,
        toMap = 390,
        toX = 0.6221,
        toY = 0.2154,
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
                    kind = "phase",
                    value = "Old Vale",
                },
                {
                    operation = "check",
                    kind = "spell",
                    value = 132627,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 132627,
                },
            },
        },
        spellID = 132627,
    },

    -- Zone: Warspear (map 624)
    -- current position -> Warspear (map 624 58.80,51.40) via spell
    {
        toPointID = 600141,
        toMap = 624,
        toX = 0.588,
        toY = 0.514,
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
                    value = 176242,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 176242,
                },
            },
        },
        spellID = 176242,
    },
}

Navigation:RegisterPathData("spell", SPELL)
