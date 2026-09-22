---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local DUNGEONTELEPORT = {

    -- Zone: Abyssal Depths (map 204)
    -- current position -> Throne of the Tides (map 204 70.00,30.00) via dungeonteleport
    {
        toPointID = 200367,
        toMap = 204,
        toX = 0.7,
        toY = 0.3,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424142,
                },
            },
        },
        spellID = 424142,
        cooldown = 28800,
    },

    -- Zone: Ardenweald (map 1565)
    -- current position -> Ardenweald (map 1565 35.41,54.11) via dungeonteleport
    {
        toPointID = 1000132,
        toMap = 1565,
        toX = 0.3541,
        toY = 0.5411,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354464,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354464,
                },
            },
        },
        spellID = 354464,
        cooldown = 28800,
    },
    -- current position -> Ardenweald (map 1565 68.66,66.71) via dungeonteleport
    {
        toPointID = 1000146,
        toMap = 1565,
        toX = 0.6866,
        toY = 0.6671,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354468,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354468,
                },
            },
        },
        spellID = 354468,
        cooldown = 28800,
    },

    -- Zone: Azj-Kahet (map 2255)
    -- current position -> City of Threads (map 2255 47.00,69.00) via dungeonteleport
    {
        toPointID = 1200062,
        toMap = 2255,
        toX = 0.47,
        toY = 0.69,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445416,
                },
            },
        },
        spellID = 445416,
        cooldown = 28800,
    },
    -- current position -> Ara-Kara, City of Echoes (map 2255 49.00,81.00) via dungeonteleport
    {
        toPointID = 1200063,
        toMap = 2255,
        toX = 0.49,
        toY = 0.81,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445417,
                },
            },
        },
        spellID = 445417,
        cooldown = 28800,
    },

    -- Zone: Badlands (map 15)
    -- current position -> Uldaman: Legacy of Tyr (map 15 41.00,10.00) via dungeonteleport
    {
        toPointID = 200017,
        toMap = 15,
        toX = 0.41,
        toY = 0.1,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393222,
                },
            },
        },
        spellID = 393222,
        cooldown = 28800,
    },

    -- Zone: Bastion (map 1533)
    -- current position -> Bastion (map 1533 40.13,55.20) via dungeonteleport
    {
        toPointID = 1000032,
        toMap = 1533,
        toX = 0.4013,
        toY = 0.552,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354462,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354462,
                },
            },
        },
        spellID = 354462,
        cooldown = 28800,
    },
    -- current position -> Bastion (map 1533 58.60,28.52) via dungeonteleport
    {
        toPointID = 1000058,
        toMap = 1533,
        toX = 0.586,
        toY = 0.2852,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354466,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354466,
                },
            },
        },
        spellID = 354466,
        cooldown = 28800,
    },

    -- Zone: Blackrock Mountain (map 33)
    -- current position -> Upper Blackrock Spire (map 33 78.97,33.73) via dungeonteleport
    {
        toPointID = 200153,
        toMap = 33,
        toX = 0.7897,
        toY = 0.3373,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159902,
                },
            },
        },
        spellID = 159902,
        cooldown = 28800,
    },

    -- Zone: Deadwind Pass (map 42)
    -- current position -> Deadwind Pass (map 42 46.72,70.20) via dungeonteleport
    {
        toPointID = 200192,
        toMap = 42,
        toX = 0.4672,
        toY = 0.702,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 373262,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 373262,
                },
            },
        },
        spellID = 373262,
        cooldown = 28800,
    },

    -- Zone: Dornogal (map 2339)
    -- current position -> The Rookery (map 2339 31.70,35.80) via dungeonteleport
    {
        toPointID = 1200119,
        toMap = 2339,
        toX = 0.317,
        toY = 0.358,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445443,
                },
            },
        },
        spellID = 445443,
        cooldown = 28800,
    },

    -- Zone: Drustvar (map 896)
    -- current position -> Waycrest Manor (map 896 34.00,13.00) via dungeonteleport
    {
        toPointID = 800028,
        toMap = 896,
        toX = 0.34,
        toY = 0.13,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424167,
                },
            },
        },
        spellID = 424167,
        cooldown = 28800,
    },

    -- Zone: Emerald Dream (map 2200)
    -- current position -> Amirdrassil, the Dream's Hope (map 2200 28.00,31.00) via dungeonteleport
    {
        toPointID = 1100196,
        toMap = 2200,
        toX = 0.28,
        toY = 0.31,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 432258,
                },
            },
        },
        spellID = 432258,
        cooldown = 28800,
    },

    -- Zone: Eredath (map 882)
    -- current position -> Seat of the Triumvirate (map 882 21.00,57.00) via dungeonteleport
    {
        toPointID = 700300,
        toMap = 882,
        toX = 0.21,
        toY = 0.57,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254551,
                },
            },
        },
        spellID = 1254551,
        cooldown = 28800,
    },

    -- Zone: Eversong Woods (map 2395)
    -- current position -> Windrunner Spire (map 2395 35.48,78.83) via dungeonteleport
    {
        toPointID = 200673,
        toMap = 2395,
        toX = 0.3548,
        toY = 0.7883,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254400,
                },
            },
        },
        spellID = 1254400,
        cooldown = 28800,
    },

    -- Zone: Frostfire Ridge (map 525)
    -- current position -> Bloodmaul Slag Mines (map 525 49.00,25.00) via dungeonteleport
    {
        toPointID = 600009,
        toMap = 525,
        toX = 0.49,
        toY = 0.25,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159895,
                },
            },
        },
        spellID = 159895,
        cooldown = 28800,
    },

    -- Zone: Gorgrond (map 543)
    -- current position -> Gorgrond (map 543 45.42,13.51) via dungeonteleport
    {
        toPointID = 600093,
        toMap = 543,
        toX = 0.4542,
        toY = 0.1351,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 159896,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159896,
                },
            },
        },
        spellID = 159896,
        cooldown = 28800,
    },
    -- current position -> Gorgrond (map 543 55.01,31.30) via dungeonteleport
    {
        toPointID = 600099,
        toMap = 543,
        toX = 0.5501,
        toY = 0.313,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 159900,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159900,
                },
            },
        },
        spellID = 159900,
        cooldown = 28800,
    },
    -- current position -> The Everbloom (map 543 59.00,45.00) via dungeonteleport
    {
        toPointID = 600101,
        toMap = 543,
        toX = 0.59,
        toY = 0.45,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159901,
                },
            },
        },
        spellID = 159901,
        cooldown = 28800,
    },

    -- Zone: Hallowfall (map 2215)
    -- current position -> The Dawnbreaker (map 2215 54.70,62.90) via dungeonteleport
    {
        toPointID = 1200033,
        toMap = 2215,
        toX = 0.547,
        toY = 0.629,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445414,
                },
            },
        },
        spellID = 445414,
        cooldown = 28800,
    },
    -- current position -> Priory of the Sacred Flame (map 2215 41.20,49.60) via dungeonteleport
    {
        toPointID = 1200027,
        toMap = 2215,
        toX = 0.412,
        toY = 0.496,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445444,
                },
            },
        },
        spellID = 445444,
        cooldown = 28800,
    },

    -- Zone: Highmountain (map 650)
    -- current position -> Neltharion's Lair (map 650 50.00,68.00) via dungeonteleport
    {
        toPointID = 700132,
        toMap = 650,
        toX = 0.5,
        toY = 0.68,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 410078,
                },
            },
        },
        spellID = 410078,
        cooldown = 28800,
    },

    -- Zone: Icecrown (map 118)
    -- current position -> Pit of Saron (map 118 52.00,89.00) via dungeonteleport
    {
        toPointID = 400069,
        toMap = 118,
        toX = 0.52,
        toY = 0.89,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254555,
                },
            },
        },
        spellID = 1254555,
        cooldown = 28800,
    },

    -- Zone: Isle of Dorn (map 2248)
    -- current position -> The Stonevault (map 2248 42.00,9.00) via dungeonteleport
    {
        toPointID = 1200046,
        toMap = 2248,
        toX = 0.42,
        toY = 0.09,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445269,
                },
            },
        },
        spellID = 445269,
        cooldown = 28800,
    },
    -- current position -> Cinderbrew Meadery (map 2248 76.00,45.00) via dungeonteleport
    {
        toPointID = 1200052,
        toMap = 2248,
        toX = 0.76,
        toY = 0.45,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445440,
                },
            },
        },
        spellID = 445440,
        cooldown = 28800,
    },
    -- current position -> Cinderbrew Meadery (map 2248 76.00,45.00) via dungeonteleport
    {
        toPointID = 1200052,
        toMap = 2248,
        toX = 0.76,
        toY = 0.45,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 467546,
                },
            },
        },
        spellID = 467546,
        cooldown = 28800,
    },

    -- Zone: Isle of Quel'Danas (map 2424)
    -- current position -> Magisters' Terrace (map 2424 63.18,15.78) via dungeonteleport
    {
        toPointID = 200711,
        toMap = 2424,
        toX = 0.6318,
        toY = 0.1578,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254572,
                },
            },
        },
        spellID = 1254572,
        cooldown = 28800,
    },

    -- Zone: Kun-Lai Summit (map 379)
    -- current position -> Shado-Pan Monastery (map 379 37.00,48.00) via dungeonteleport
    {
        toPointID = 500047,
        toMap = 379,
        toX = 0.37,
        toY = 0.48,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131206,
                },
            },
        },
        spellID = 131206,
        cooldown = 28800,
    },

    -- Zone: Maldraxxus (map 1536)
    -- current position -> Maldraxxus (map 1536 59.60,65.31) via dungeonteleport
    {
        toPointID = 1000082,
        toMap = 1536,
        toX = 0.596,
        toY = 0.6531,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354463,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354463,
                },
            },
        },
        spellID = 354463,
        cooldown = 28800,
    },
    -- current position -> Maldraxxus (map 1536 53.09,52.87) via dungeonteleport
    {
        toPointID = 1000078,
        toMap = 1536,
        toX = 0.5309,
        toY = 0.5287,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354467,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354467,
                },
            },
        },
        spellID = 354467,
        cooldown = 28800,
    },

    -- Zone: Mechagon Island (map 1462)
    -- current position -> Mechagon Island (map 1462 73.01,36.46) via dungeonteleport
    {
        toPointID = 800101,
        toMap = 1462,
        toX = 0.7301,
        toY = 0.3646,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 373274,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 373274,
                },
            },
        },
        spellID = 373274,
        cooldown = 28800,
    },

    -- Zone: Nazmir (map 863)
    -- current position -> The Underrot (map 863 52.00,66.00) via dungeonteleport
    {
        toPointID = 900046,
        toMap = 863,
        toX = 0.52,
        toY = 0.66,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 410074,
                },
            },
        },
        spellID = 410074,
        cooldown = 28800,
    },

    -- Zone: Ohn'ahran Plains (map 2023)
    -- current position -> The Nokhud Offensive (map 2023 61.00,39.00) via dungeonteleport
    {
        toPointID = 1100030,
        toMap = 2023,
        toX = 0.61,
        toY = 0.39,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393262,
                },
            },
        },
        spellID = 393262,
        cooldown = 28800,
    },

    -- Zone: Revendreth (map 1525)
    -- current position -> Revendreth (map 1525 78.58,49.22) via dungeonteleport
    {
        toPointID = 1000029,
        toMap = 1525,
        toX = 0.7858,
        toY = 0.4922,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354465,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354465,
                },
            },
        },
        spellID = 354465,
        cooldown = 28800,
    },
    -- current position -> Revendreth (map 1525 51.07,30.22) via dungeonteleport
    {
        toPointID = 1000014,
        toMap = 1525,
        toX = 0.5107,
        toY = 0.3022,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 354469,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 354469,
                },
            },
        },
        spellID = 354469,
        cooldown = 28800,
    },
    -- current position -> Revendreth (map 1525 46.37,41.50) via dungeonteleport
    {
        toPointID = 1000012,
        toMap = 1525,
        toX = 0.4637,
        toY = 0.415,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 373190,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 373190,
                },
            },
        },
        spellID = 373190,
        cooldown = 28800,
    },

    -- Zone: Shadowmoon Valley (map 539)
    -- current position -> Shadowmoon Burial Grounds (map 539 32.00,42.00) via dungeonteleport
    {
        toPointID = 600063,
        toMap = 539,
        toX = 0.32,
        toY = 0.42,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159899,
                },
            },
        },
        spellID = 159899,
        cooldown = 28800,
    },

    -- Zone: Silvermoon City (map 2393)
    -- current position -> Murder Row (map 2393 57.02,61.08) via dungeonteleport
    {
        toPointID = 200670,
        toMap = 2393,
        toX = 0.5702,
        toY = 0.6108,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1286809,
                },
            },
        },
        spellID = 1286809,
        cooldown = 28800,
    },

    -- Zone: Spires of Arak (map 542)
    -- current position -> Skyreach (map 542 35.00,33.00) via dungeonteleport
    {
        toPointID = 600073,
        toMap = 542,
        toX = 0.35,
        toY = 0.33,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254557,
                },
            },
        },
        spellID = 1254557,
        cooldown = 28800,
    },
    -- current position -> Skyreach (map 542 35.00,33.00) via dungeonteleport
    {
        toPointID = 600073,
        toMap = 542,
        toX = 0.35,
        toY = 0.33,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159898,
                },
            },
        },
        spellID = 159898,
        cooldown = 28800,
    },

    -- Zone: Stormheim (map 634)
    -- current position -> Halls of Valor (map 634 68.00,66.00) via dungeonteleport
    {
        toPointID = 700078,
        toMap = 634,
        toX = 0.68,
        toY = 0.66,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393764,
                },
            },
        },
        spellID = 393764,
        cooldown = 28800,
    },

    -- Zone: Suramar (map 680)
    -- current position -> Court of Stars (map 680 51.00,65.00) via dungeonteleport
    {
        toPointID = 700183,
        toMap = 680,
        toX = 0.51,
        toY = 0.65,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393766,
                },
            },
        },
        spellID = 393766,
        cooldown = 28800,
    },

    -- Zone: Talador (map 535)
    -- current position -> Auchindoun (map 535 46.00,74.00) via dungeonteleport
    {
        toPointID = 600041,
        toMap = 535,
        toX = 0.46,
        toY = 0.74,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 159897,
                },
            },
        },
        spellID = 159897,
        cooldown = 28800,
    },

    -- Zone: Tazavesh, the Veiled Market (map 2016)
    -- current position -> The Gilded Landing (map 2016 88.85,43.95) via dungeonteleport
    {
        toPointID = 1000359,
        toMap = 2016,
        toX = 0.8885,
        toY = 0.4395,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 367416,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 367416,
                },
            },
        },
        spellID = 367416,
        cooldown = 28800,
    },

    -- Zone: Tazavesh (map 2472)
    -- current position -> Eco-Dome Al'dani (map 2472 43.80,4.47) via dungeonteleport
    {
        toPointID = 1200233,
        toMap = 2472,
        toX = 0.438,
        toY = 0.0447,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1237215,
                },
            },
        },
        spellID = 1237215,
        cooldown = 28800,
    },
    -- current position -> Manaforge Omega (map 2472 41.00,21.00) via dungeonteleport
    {
        toPointID = 1200232,
        toMap = 2472,
        toX = 0.41,
        toY = 0.21,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1239155,
                },
            },
        },
        spellID = 1239155,
        cooldown = 28800,
    },

    -- Zone: Thaldraszus (map 2025)
    -- current position -> Algeth'ar Academy (map 2025 58.00,42.00) via dungeonteleport
    {
        toPointID = 1100066,
        toMap = 2025,
        toX = 0.58,
        toY = 0.42,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393273,
                },
            },
        },
        spellID = 393273,
        cooldown = 28800,
    },
    -- current position -> Halls of Infusion (map 2025 59.00,60.00) via dungeonteleport
    {
        toPointID = 1100068,
        toMap = 2025,
        toX = 0.59,
        toY = 0.6,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393283,
                },
            },
        },
        spellID = 393283,
        cooldown = 28800,
    },
    -- current position -> Dawn of the Infinites (map 2025 61.00,84.00) via dungeonteleport
    {
        toPointID = 1100071,
        toMap = 2025,
        toX = 0.61,
        toY = 0.84,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424197,
                },
            },
        },
        spellID = 424197,
        cooldown = 28800,
    },
    -- current position -> Vault of the Incarnates (map 2025 73.00,55.00) via dungeonteleport
    {
        toPointID = 1100074,
        toMap = 2025,
        toX = 0.73,
        toY = 0.55,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 432254,
                },
            },
        },
        spellID = 432254,
        cooldown = 28800,
    },

    -- Zone: The Azure Span (map 2024)
    -- current position -> Brackenhide Hollow (map 2024 11.00,48.00) via dungeonteleport
    {
        toPointID = 1100045,
        toMap = 2024,
        toX = 0.11,
        toY = 0.48,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393267,
                },
            },
        },
        spellID = 393267,
        cooldown = 28800,
    },
    -- current position -> The Azure Vault (map 2024 38.00,64.00) via dungeonteleport
    {
        toPointID = 1100056,
        toMap = 2024,
        toX = 0.38,
        toY = 0.64,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393279,
                },
            },
        },
        spellID = 393279,
        cooldown = 28800,
    },

    -- Zone: The Jade Forest (map 371)
    -- current position -> Temple of the Jade Serpent (map 371 56.00,58.00) via dungeonteleport
    {
        toPointID = 500022,
        toMap = 371,
        toX = 0.56,
        toY = 0.58,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131204,
                },
            },
        },
        spellID = 131204,
        cooldown = 28800,
    },

    -- Zone: The Maw (map 1543)
    -- current position -> The Maw (map 1543 69.79,31.89) via dungeonteleport
    {
        toPointID = 1000124,
        toMap = 1543,
        toX = 0.6979,
        toY = 0.3189,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 373191,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 373191,
                },
            },
        },
        spellID = 373191,
        cooldown = 28800,
    },

    -- Zone: The Ringing Deeps (map 2214)
    -- current position -> Operation: Floodgate (map 2214 42.09,39.48) via dungeonteleport
    {
        toPointID = 1200012,
        toMap = 2214,
        toX = 0.4209,
        toY = 0.3948,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1216786,
                },
            },
        },
        spellID = 1216786,
        cooldown = 28800,
    },
    -- current position -> Darkflame Cleft (map 2214 56.00,21.00) via dungeonteleport
    {
        toPointID = 1200018,
        toMap = 2214,
        toX = 0.56,
        toY = 0.21,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445441,
                },
            },
        },
        spellID = 445441,
        cooldown = 28800,
    },

    -- Zone: The Waking Shores (map 2022)
    -- current position -> Ruby Life Pools (map 2022 60.00,75.00) via dungeonteleport
    {
        toPointID = 1100006,
        toMap = 2022,
        toX = 0.6,
        toY = 0.75,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393256,
                },
            },
        },
        spellID = 393256,
        cooldown = 28800,
    },
    -- current position -> Neltharus (map 2022 25.00,56.00) via dungeonteleport
    {
        toPointID = 1100001,
        toMap = 2022,
        toX = 0.25,
        toY = 0.56,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 393276,
                },
            },
        },
        spellID = 393276,
        cooldown = 28800,
    },

    -- Zone: Tiragarde Sound (map 895)
    -- current position -> Siege of Boralus (map 895 72.00,23.00) via dungeonteleport
    {
        toPointID = 800007,
        toMap = 895,
        toX = 0.72,
        toY = 0.23,
        type = "dungeonteleport",
        travelDuration = 10,
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
                    kind = "spellKnown",
                    value = 445418,
                },
            },
        },
        spellID = 445418,
        cooldown = 28800,
    },
    -- current position -> Siege of Boralus (map 895 88.00,51.00) via dungeonteleport
    {
        toPointID = 800018,
        toMap = 895,
        toX = 0.88,
        toY = 0.51,
        type = "dungeonteleport",
        travelDuration = 10,
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
                    kind = "spellKnown",
                    value = 464256,
                },
            },
        },
        spellID = 464256,
        cooldown = 28800,
    },
    -- current position -> Freehold (map 895 85.00,79.00) via dungeonteleport
    {
        toPointID = 800015,
        toMap = 895,
        toX = 0.85,
        toY = 0.79,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 410071,
                },
            },
        },
        spellID = 410071,
        cooldown = 28800,
    },

    -- Zone: Tirisfal Glades (map 18)
    -- current position -> Scarlet Monastery (map 18 82.00,33.00) via dungeonteleport
    {
        toPointID = 200053,
        toMap = 18,
        toX = 0.82,
        toY = 0.33,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131229,
                },
            },
        },
        spellID = 131229,
        cooldown = 28800,
    },
    -- current position -> Scarlet Halls (map 18 82.00,33.00) via dungeonteleport
    {
        toPointID = 200053,
        toMap = 18,
        toX = 0.82,
        toY = 0.33,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131231,
                },
            },
        },
        spellID = 131231,
        cooldown = 28800,
    },

    -- Zone: Townlong Steppes (map 388)
    -- current position -> Siege of Niuzao Temple (map 388 35.00,82.00) via dungeonteleport
    {
        toPointID = 500087,
        toMap = 388,
        toX = 0.35,
        toY = 0.82,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131228,
                },
            },
        },
        spellID = 131228,
        cooldown = 28800,
    },

    -- Zone: Twilight Highlands (map 241)
    -- current position -> Grim Batol (map 241 19.00,54.00) via dungeonteleport
    {
        toPointID = 200410,
        toMap = 241,
        toX = 0.19,
        toY = 0.54,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 445424,
                },
            },
        },
        spellID = 445424,
        cooldown = 28800,
    },

    -- Zone: Uldum (map 249)
    -- current position -> The Vortex Pinnacle (map 249 76.00,83.00) via dungeonteleport
    {
        toPointID = 100373,
        toMap = 249,
        toX = 0.76,
        toY = 0.83,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 410080,
                },
            },
        },
        spellID = 410080,
        cooldown = 28800,
    },

    -- Zone: Undermine (map 2346)
    -- current position -> Liberation of Undermine (map 2346 42.00,49.00) via dungeonteleport
    {
        toPointID = 1200144,
        toMap = 2346,
        toX = 0.42,
        toY = 0.49,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1226482,
                },
            },
        },
        spellID = 1226482,
        cooldown = 28800,
    },

    -- Zone: Val'sharah (map 641)
    -- current position -> Black Rook Hold (map 641 39.00,53.00) via dungeonteleport
    {
        toPointID = 700088,
        toMap = 641,
        toX = 0.39,
        toY = 0.53,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424153,
                },
            },
        },
        spellID = 424153,
        cooldown = 28800,
    },
    -- current position -> Darkheart Thicket (map 641 59.00,31.00) via dungeonteleport
    {
        toPointID = 700103,
        toMap = 641,
        toX = 0.59,
        toY = 0.31,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424163,
                },
            },
        },
        spellID = 424163,
        cooldown = 28800,
    },

    -- Zone: Vale of Eternal Blossoms (map 390)
    -- current position -> Mogu'shan Palace (map 390 79.00,34.00) via dungeonteleport
    {
        toPointID = 500114,
        toMap = 390,
        toX = 0.79,
        toY = 0.34,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131222,
                },
            },
        },
        spellID = 131222,
        cooldown = 28800,
    },
    -- current position -> Gate of the Setting Sun (map 390 16.00,74.00) via dungeonteleport
    {
        toPointID = 500109,
        toMap = 390,
        toX = 0.16,
        toY = 0.74,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131225,
                },
            },
        },
        spellID = 131225,
        cooldown = 28800,
    },

    -- Zone: Valley of the Four Winds (map 376)
    -- current position -> Stormstout Brewery (map 376 36.00,69.00) via dungeonteleport
    {
        toPointID = 500032,
        toMap = 376,
        toX = 0.36,
        toY = 0.69,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131205,
                },
            },
        },
        spellID = 131205,
        cooldown = 28800,
    },

    -- Zone: Vol'dun (map 864)
    -- current position -> Temple of Sethraliss (map 864 52.00,25.00) via dungeonteleport
    {
        toPointID = 900061,
        toMap = 864,
        toX = 0.52,
        toY = 0.25,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1286828,
                },
            },
        },
        spellID = 1286828,
        cooldown = 28800,
    },

    -- Zone: Western Plaguelands (map 22)
    -- current position -> Scholomance (map 22 69.00,73.00) via dungeonteleport
    {
        toPointID = 200081,
        toMap = 22,
        toX = 0.69,
        toY = 0.73,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 131232,
                },
            },
        },
        spellID = 131232,
        cooldown = 28800,
    },

    -- Zone: Zaralek Cavern (map 2133)
    -- current position -> Aberrus, the Shadowed Crucible (map 2133 48.00,11.00) via dungeonteleport
    {
        toPointID = 1100149,
        toMap = 2133,
        toX = 0.48,
        toY = 0.11,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 432257,
                },
            },
        },
        spellID = 432257,
        cooldown = 28800,
    },

    -- Zone: Zereth Mortis (map 1970)
    -- current position -> Zereth Mortis (map 1970 81.02,53.40) via dungeonteleport
    {
        toPointID = 1000330,
        toMap = 1970,
        toX = 0.8102,
        toY = 0.534,
        type = "dungeonteleport",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spell",
                    value = 373192,
                },
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 373192,
                },
            },
        },
        spellID = 373192,
        cooldown = 28800,
    },

    -- Zone: Zul'Aman (map 2437)
    -- current position -> Maisara Caverns (map 2437 43.85,39.53) via dungeonteleport
    {
        toPointID = 200728,
        toMap = 2437,
        toX = 0.4385,
        toY = 0.3953,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1254559,
                },
            },
        },
        spellID = 1254559,
        cooldown = 28800,
    },
    -- current position -> Den of Nalorakk (map 2437 29.87,84.49) via dungeonteleport
    {
        toPointID = 200723,
        toMap = 2437,
        toX = 0.2987,
        toY = 0.8449,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1286807,
                },
            },
        },
        spellID = 1286807,
        cooldown = 28800,
    },

    -- Zone: Zuldazar (map 862)
    -- current position -> The MOTHERLODE!! (map 862 40.00,72.00) via dungeonteleport
    {
        toPointID = 900005,
        toMap = 862,
        toX = 0.4,
        toY = 0.72,
        type = "dungeonteleport",
        travelDuration = 10,
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
                    kind = "spellKnown",
                    value = 467553,
                },
            },
        },
        spellID = 467553,
        cooldown = 28800,
    },
    -- current position -> The MOTHERLODE!! (map 862 56.00,60.00) via dungeonteleport
    {
        toPointID = 900019,
        toMap = 862,
        toX = 0.56,
        toY = 0.6,
        type = "dungeonteleport",
        travelDuration = 10,
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
                    kind = "spellKnown",
                    value = 467555,
                },
            },
        },
        spellID = 467555,
        cooldown = 28800,
    },
    -- current position -> Kings' Rest (map 862 38.00,39.00) via dungeonteleport
    {
        toPointID = 900003,
        toMap = 862,
        toX = 0.38,
        toY = 0.39,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 1286831,
                },
            },
        },
        spellID = 1286831,
        cooldown = 28800,
    },
    -- current position -> Atal'Dazar (map 862 44.00,39.00) via dungeonteleport
    {
        toPointID = 900012,
        toMap = 862,
        toX = 0.44,
        toY = 0.39,
        type = "dungeonteleport",
        travelDuration = 10,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "spellKnown",
                    value = 424187,
                },
            },
        },
        spellID = 424187,
        cooldown = 28800,
    },
}

Navigation:RegisterPathData("dungeonteleport", DUNGEONTELEPORT)
