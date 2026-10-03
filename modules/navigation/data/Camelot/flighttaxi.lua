---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Reconciled with VSS_Skeleton_Camelot.lua (2026-09-28); existing point IDs retained.
local FLIGHTTAXI = {

    -- Original source zone: Alterac Mountains (map 1416)
    -- Hillsbrad Foothills (map 1424 60.21,18.75) -> Silverpine Forest (map 1421 45.56,42.42) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1424,
        fromX = 0.6021,
        fromY = 0.1875,
        toPointID = 200025,
        toMap = 1421,
        toX = 0.455574,
        toY = 0.424217,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 13,
        toTaxiNodeID = 10,
        taxiPathIDs = {
            441,
        },
        travelDuration = 93,
    },
    -- Hillsbrad Foothills (map 1424 60.21,18.75) -> Undercity (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1424,
        fromX = 0.6021,
        fromY = 0.1875,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 13,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            24,
        },
        travelDuration = 130,
    },
    -- Hillsbrad Foothills (map 1424 60.21,18.75) -> Arathi Highlands (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1424,
        fromX = 0.6021,
        fromY = 0.1875,
        toPointID = 200008,
        toMap = 1417,
        toX = 0.730618,
        toY = 0.326232,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 13,
        toTaxiNodeID = 17,
        taxiPathIDs = {
            322,
        },
        travelDuration = 110,
    },
    -- Hillsbrad Foothills (map 1424 60.21,18.75) -> The Hinterlands (map 1425 81.70,81.89) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1424,
        fromX = 0.6021,
        fromY = 0.1875,
        toPointID = 200051,
        toMap = 1425,
        toX = 0.817013,
        toY = 0.818932,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 13,
        toTaxiNodeID = 76,
        taxiPathIDs = {
            413,
        },
        travelDuration = 182,
    },
    -- Western Plaguelands (map 1422 42.95,84.95) -> Hillsbrad Foothills (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1422,
        fromX = 0.4295,
        fromY = 0.8495,
        toPointID = 200045,
        toMap = 1424,
        toX = 0.494421,
        toY = 0.521006,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 66,
        toTaxiNodeID = 14,
        taxiPathIDs = {
            346,
        },
        travelDuration = 80,
    },
    -- Western Plaguelands (map 1422 42.95,84.95) -> The Hinterlands (map 1425 11.11,46.09) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1422,
        fromX = 0.4295,
        fromY = 0.8495,
        toPointID = 200004,
        toMap = 1425,
        toX = 0.1111,
        toY = 0.4609,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 66,
        toTaxiNodeID = 43,
        taxiPathIDs = {
            476,
        },
        travelDuration = 61,
    },
    -- Western Plaguelands (map 1422 42.95,84.95) -> Eastern Plaguelands (map 1423 71.70,49.55) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1422,
        fromX = 0.4295,
        fromY = 0.8495,
        toPointID = 200043,
        toMap = 1423,
        toX = 0.71699,
        toY = 0.49555,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 66,
        toTaxiNodeID = 67,
        taxiPathIDs = {
            431,
        },
        travelDuration = 137,
    },
    -- Western Plaguelands (map 1422 42.95,84.95) -> Ironforge (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1422,
        fromX = 0.4295,
        fromY = 0.8495,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 66,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            429,
        },
        travelDuration = 243,
    },
    -- The Hinterlands (map 1425 11.11,46.09) -> Hillsbrad Foothills (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1425,
        fromX = 0.1111,
        fromY = 0.4609,
        toPointID = 200045,
        toMap = 1424,
        toX = 0.494421,
        toY = 0.521006,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 43,
        toTaxiNodeID = 14,
        taxiPathIDs = {
            229,
        },
        travelDuration = 64,
    },
    -- The Hinterlands (map 1425 11.11,46.09) -> Arathi Highlands (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1425,
        fromX = 0.1111,
        fromY = 0.4609,
        toPointID = 200007,
        toMap = 1417,
        toX = 0.457901,
        toY = 0.461332,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 43,
        toTaxiNodeID = 16,
        taxiPathIDs = {
            276,
        },
        travelDuration = 71,
    },
    -- The Hinterlands (map 1425 11.11,46.09) -> Western Plaguelands (map 1422 42.95,84.95) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1425,
        fromX = 0.1111,
        fromY = 0.4609,
        toPointID = 200002,
        toMap = 1422,
        toX = 0.4295,
        toY = 0.8495,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 43,
        toTaxiNodeID = 66,
        taxiPathIDs = {
            475,
        },
        travelDuration = 50,
    },
    -- The Hinterlands (map 1425 11.11,46.09) -> Eastern Plaguelands (map 1423 71.70,49.55) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1425,
        fromX = 0.1111,
        fromY = 0.4609,
        toPointID = 200043,
        toMap = 1423,
        toX = 0.71699,
        toY = 0.49555,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 43,
        toTaxiNodeID = 67,
        taxiPathIDs = {
            349,
        },
        travelDuration = 154,
    },
    -- The Hinterlands (map 1425 11.11,46.09) -> Ironforge (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1425,
        fromX = 0.1111,
        fromY = 0.4609,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 43,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            264,
        },
        travelDuration = 239,
    },

    -- Original source zone: Alterac Valley (map 1459)
    -- Dun Baldar, Alterac Valley (map 1459 43.14,18.10) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 1300001,
        fromMap = 1459,
        fromX = 0.431363,
        fromY = 0.180958,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 59,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 59,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            312,
        },
    },
    -- Frostwolf Keep, Alterac Valley (map 1459 49.58,85.69) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 1300002,
        fromMap = 1459,
        fromX = 0.495797,
        fromY = 0.85694,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 60,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 60,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            313,
        },
    },

    -- Original source zone: Arathi Highlands (map 1417)
    -- Refuge Pointe, Arathi (map 1417 45.79,46.13) -> Southshore, Hillsbrad (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200045,
        toMap = 1424,
        toX = 0.494421,
        toY = 0.521006,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 16,
        toTaxiNodeID = 14,
        taxiPathIDs = {
            273,
        },
        travelDuration = 81,
    },
    -- Arathi Highlands (map 1417 45.79,46.13) -> The Hinterlands (map 1425 11.11,46.09) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200004,
        toMap = 1425,
        toX = 0.1111,
        toY = 0.4609,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 16,
        toTaxiNodeID = 43,
        taxiPathIDs = {
            275,
        },
        travelDuration = 67,
    },
    -- Refuge Pointe, Arathi (map 1417 45.79,46.13) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 16,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            30,
        },
        travelDuration = 253,
    },
    -- Refuge Pointe, Arathi (map 1417 45.79,46.13) -> Menethil Harbor, Wetlands (map 1437 9.52,59.66) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200094,
        toMap = 1437,
        toX = 0.095204,
        toY = 0.596587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 16,
        toTaxiNodeID = 7,
        taxiPathIDs = {
            270,
        },
        travelDuration = 118,
    },
    -- Refuge Pointe, Arathi (map 1417 45.79,46.13) -> Thelsamar, Loch Modan (map 1432 33.94,50.79) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200074,
        toMap = 1432,
        toX = 0.33943,
        toY = 0.507947,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 16,
        toTaxiNodeID = 8,
        taxiPathIDs = {
            268,
        },
        travelDuration = 160,
    },
    -- Hammerfall, Arathi (map 1417 73.06,32.62) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 17,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            32,
        },
        travelDuration = 243,
    },
    -- Arathi Highlands (map 1417 73.06,32.62) -> Hillsbrad Foothills (map 1424 60.21,18.75) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200001,
        toMap = 1424,
        toX = 0.6021,
        toY = 0.1875,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 17,
        toTaxiNodeID = 13,
        taxiPathIDs = {
            321,
        },
        travelDuration = 109,
    },
    -- Arathi Highlands (map 1417 73.06,32.62) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 17,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            320,
        },
        travelDuration = 243,
    },
    -- Hammerfall, Arathi (map 1417 73.06,32.62) -> Rog'mar, Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200110,
        toMap = 2548,
        toX = 0.596143,
        toY = 0.450641,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 17,
        toTaxiNodeID = 3203,
        taxiPathIDs = {
            11581,
        },
        travelDuration = 305,
    },
    -- Hammerfall, Arathi (map 1417 73.06,32.62) -> Revantusk Village, The Hinterlands (map 1425 81.70,81.89) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200051,
        toMap = 1425,
        toX = 0.817013,
        toY = 0.818932,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 17,
        toTaxiNodeID = 76,
        taxiPathIDs = {
            484,
        },
        travelDuration = 85,
    },

    -- Original source zone: Ashenvale (map 1440)
    -- Splintertree Post, Ashenvale (map 1440 73.26,61.67) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 61,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            327,
        },
        travelDuration = 90,
    },
    -- Ashenvale (map 1440 73.26,61.67) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 61,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            333,
        },
        travelDuration = 150,
    },
    -- Splintertree Post, Ashenvale (map 1440 73.26,61.67) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 61,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            481,
        },
        travelDuration = 90,
    },
    -- Ashenvale (map 1440 73.26,61.67) -> Ashenvale (map 1440 12.19,33.77) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100071,
        toMap = 1440,
        toX = 0.1219,
        toY = 0.3377,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 58,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 61,
        toTaxiNodeID = 58,
        taxiPathIDs = {
            351,
        },
        travelDuration = 156,
    },

    -- Original source zone: Azshara (map 1447)
    -- Azshara (map 1447 11.90,77.48) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            329,
        },
        travelDuration = 282,
    },
    -- Azshara (map 1447 11.90,77.48) -> Ashenvale (map 1440 34.50,48.01) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100048,
        toMap = 1440,
        toX = 0.345,
        toY = 0.4801,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 28,
        taxiPathIDs = {
            468,
        },
        travelDuration = 143,
    },
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            446,
        },
        travelDuration = 226,
    },
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Everlook, Winterspring (map 1452 62.33,36.64) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100095,
        toMap = 1452,
        toX = 0.623348,
        toY = 0.366358,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 52,
        taxiPathIDs = {
            447,
        },
        travelDuration = 167,
    },
    -- Azshara (map 1447 11.90,77.48) -> Felwood (map 1448 62.46,24.19) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100105,
        toMap = 1448,
        toX = 0.6246,
        toY = 0.2419,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 65,
        taxiPathIDs = {
            332,
        },
        travelDuration = 266,
    },
    -- Azshara (map 1447 11.90,77.48) -> The Barrens (map 1413 63.12,37.11) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100002,
        toMap = 1413,
        toX = 0.6312,
        toY = 0.3711,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 64,
        toTaxiNodeID = 80,
        taxiPathIDs = {
            465,
        },
        travelDuration = 127,
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            291,
        },
        travelDuration = 241,
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            242,
        },
        travelDuration = 113,
    },
    -- Azshara (map 1447 21.95,49.69) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            284,
        },
        travelDuration = 161,
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Bloodvenom Post, Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100073,
        toMap = 1448,
        toX = 0.344154,
        toY = 0.538678,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 48,
        taxiPathIDs = {
            400,
        },
        travelDuration = 217,
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Everlook, Winterspring (map 1452 60.49,36.34) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100094,
        toMap = 1452,
        toX = 0.604853,
        toY = 0.363438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 53,
        taxiPathIDs = {
            500,
        },
        travelDuration = 122,
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Splintertree Post, Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100039,
        toMap = 1440,
        toX = 0.732581,
        toY = 0.616722,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 44,
        toTaxiNodeID = 61,
        taxiPathIDs = {
            482,
        },
        travelDuration = 87,
    },

    -- Original source zone: Burning Steppes (map 1428)
    -- Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 71,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            425,
        },
        travelDuration = 141,
    },
    -- Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) -> Farholde Keep, Riverglades (map 2548 60.59,81.57) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200111,
        toMap = 2548,
        toX = 0.605939,
        toY = 0.815701,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 71,
        toTaxiNodeID = 3276,
        taxiPathIDs = {
            11587,
        },
        travelDuration = 123,
    },
    -- Burning Steppes (map 1428 84.38,68.30) -> Blasted Lands (map 1419 65.49,24.43) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200090,
        toMap = 1419,
        toX = 0.6549,
        toY = 0.2443,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 71,
        toTaxiNodeID = 45,
        taxiPathIDs = {
            381,
        },
        travelDuration = 196,
    },
    -- Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) -> Lakeshire, Redridge (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200078,
        toMap = 1433,
        toX = 0.253428,
        toY = 0.589882,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 71,
        toTaxiNodeID = 5,
        taxiPathIDs = {
            470,
        },
        travelDuration = 59,
    },
    -- Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) -> Thorium Point, Searing Gorge (map 1427 37.89,30.43) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200056,
        toMap = 1427,
        toX = 0.37887,
        toY = 0.304262,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 74,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 71,
        toTaxiNodeID = 74,
        taxiPathIDs = {
            410,
        },
        travelDuration = 97,
    },

    -- Original source zone: Deadwind Pass (map 1430)
    -- Duskwood (map 1431 77.59,44.38) -> Stranglethorn Vale (map 1434 27.53,77.67) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1431,
        fromX = 0.7759,
        fromY = 0.4438,
        toPointID = 200082,
        toMap = 1434,
        toX = 0.275288,
        toY = 0.776721,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 12,
        toTaxiNodeID = 19,
        taxiPathIDs = {
            259,
        },
        travelDuration = 160,
    },
    -- Duskwood (map 1431 77.59,44.38) -> Stormwind City (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1431,
        fromX = 0.7759,
        fromY = 0.4438,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 12,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            22,
        },
        travelDuration = 82,
    },
    -- Duskwood (map 1431 77.59,44.38) -> Blasted Lands (map 1419 65.49,24.43) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1431,
        fromX = 0.7759,
        fromY = 0.4438,
        toPointID = 200090,
        toMap = 1419,
        toX = 0.6549,
        toY = 0.2443,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 12,
        toTaxiNodeID = 45,
        taxiPathIDs = {
            261,
        },
        travelDuration = 91,
    },
    -- Duskwood (map 1431 77.59,44.38) -> Westfall (map 1436 56.57,52.67) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1431,
        fromX = 0.7759,
        fromY = 0.4438,
        toPointID = 200091,
        toMap = 1436,
        toX = 0.56571,
        toY = 0.526667,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 12,
        toTaxiNodeID = 4,
        taxiPathIDs = {
            252,
        },
        travelDuration = 87,
    },
    -- Duskwood (map 1431 77.59,44.38) -> Redridge Mountains (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1431,
        fromX = 0.7759,
        fromY = 0.4438,
        toPointID = 200078,
        toMap = 1433,
        toX = 0.253428,
        toY = 0.589882,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 12,
        toTaxiNodeID = 5,
        taxiPathIDs = {
            258,
        },
        travelDuration = 56,
    },

    -- Original source zone: Desolace (map 1443)
    -- Shadowprey Village, Desolace (map 1443 21.56,74.04) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100051,
        fromMap = 1443,
        fromX = 0.215631,
        fromY = 0.740422,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 38,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            161,
        },
        travelDuration = 167,
    },
    -- Shadowprey Village, Desolace (map 1443 21.56,74.04) -> Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) via flighttaxi
    {
        fromPointID = 100051,
        fromMap = 1443,
        fromX = 0.215631,
        fromY = 0.740422,
        toPointID = 100047,
        toMap = 1442,
        toX = 0.451641,
        toY = 0.598878,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 38,
        toTaxiNodeID = 29,
        taxiPathIDs = {
            356,
        },
        travelDuration = 186,
    },
    -- Shadowprey Village, Desolace (map 1443 21.56,74.04) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100051,
        fromMap = 1443,
        fromX = 0.215631,
        fromY = 0.740422,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 38,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            376,
        },
        travelDuration = 184,
    },
    -- Desolace (map 1443 64.67,10.44) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100054,
        fromMap = 1443,
        fromX = 0.646713,
        fromY = 0.104354,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 37,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            384,
        },
        travelDuration = 264,
    },
    -- Nijel's Point, Desolace (map 1443 64.67,10.44) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100054,
        fromMap = 1443,
        fromX = 0.646713,
        fromY = 0.104354,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 37,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            141,
        },
        travelDuration = 288,
    },
    -- Nijel's Point, Desolace (map 1443 64.67,10.44) -> Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) via flighttaxi
    {
        fromPointID = 100054,
        fromMap = 1443,
        fromX = 0.646713,
        fromY = 0.104354,
        toPointID = 100046,
        toMap = 1442,
        toX = 0.365356,
        toY = 0.072334,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 37,
        toTaxiNodeID = 33,
        taxiPathIDs = {
            477,
        },
        travelDuration = 112,
    },
    -- Nijel's Point, Desolace (map 1443 64.67,10.44) -> Feathermoon, Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100054,
        fromMap = 1443,
        fromX = 0.646713,
        fromY = 0.104354,
        toPointID = 100055,
        toMap = 1444,
        toX = 0.302592,
        toY = 0.433194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 37,
        toTaxiNodeID = 41,
        taxiPathIDs = {
            373,
        },
        travelDuration = 217,
    },

    -- Original source zone: Durotar (map 1411)
    -- The Barrens (map 1413 51.50,30.41) -> Thunder Bluff (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            44,
        },
        travelDuration = 171,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Orgrimmar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            45,
        },
        travelDuration = 133,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Stonetalon Mountains (map 1442 45.16,59.89) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100047,
        toMap = 1442,
        toX = 0.451641,
        toY = 0.598878,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 29,
        taxiPathIDs = {
            279,
        },
        travelDuration = 140,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100043,
        toMap = 1441,
        toX = 0.45022,
        toY = 0.491265,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 30,
        taxiPathIDs = {
            281,
        },
        travelDuration = 173,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            393,
        },
        travelDuration = 284,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            355,
        },
        travelDuration = 236,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            283,
        },
        travelDuration = 158,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100073,
        toMap = 1448,
        toX = 0.344154,
        toY = 0.538678,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 48,
        taxiPathIDs = {
            287,
        },
        travelDuration = 238,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Dustwallow Marsh (map 1445 35.57,31.83) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100060,
        toMap = 1445,
        toX = 0.355653,
        toY = 0.318302,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 55,
        taxiPathIDs = {
            360,
        },
        travelDuration = 152,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Ashenvale (map 1440 12.19,33.77) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100071,
        toMap = 1440,
        toX = 0.1219,
        toY = 0.3377,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 58,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 58,
        taxiPathIDs = {
            354,
        },
        travelDuration = 216,
    },
    -- The Barrens (map 1413 51.50,30.41) -> Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100039,
        toMap = 1440,
        toX = 0.732581,
        toY = 0.616722,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 61,
        taxiPathIDs = {
            334,
        },
        travelDuration = 152,
    },
    -- The Barrens (map 1413 51.50,30.41) -> The Barrens (map 1413 44.46,59.10) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100058,
        toMap = 1413,
        toX = 0.4446,
        toY = 0.591,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 77,
        taxiPathIDs = {
            417,
        },
        travelDuration = 85,
    },
    -- The Barrens (map 1413 51.50,30.41) -> The Barrens (map 1413 63.12,37.11) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1413,
        fromX = 0.515,
        fromY = 0.3041,
        toPointID = 100002,
        toMap = 1413,
        toX = 0.6312,
        toY = 0.3711,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 25,
        toTaxiNodeID = 80,
        taxiPathIDs = {
            462,
        },
        travelDuration = 48,
    },
    -- The Barrens (map 1413 63.12,37.11) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1413,
        fromX = 0.6312,
        fromY = 0.3711,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 80,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            461,
        },
        travelDuration = 64,
    },
    -- The Barrens (map 1413 63.12,37.11) -> Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1413,
        fromX = 0.6312,
        fromY = 0.3711,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 80,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            460,
        },
        travelDuration = 98,
    },
    -- The Barrens (map 1413 63.12,37.11) -> Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1413,
        fromX = 0.6312,
        fromY = 0.3711,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 80,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            466,
        },
        travelDuration = 124,
    },

    -- Original source zone: Dustwallow Marsh (map 1445)
    -- The Barrens (map 1413 44.46,59.10) -> Thunder Bluff (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1413,
        fromX = 0.4446,
        fromY = 0.591,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 77,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            420,
        },
        travelDuration = 107,
    },
    -- The Barrens (map 1413 44.46,59.10) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1413,
        fromX = 0.4446,
        fromY = 0.591,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 77,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            416,
        },
        travelDuration = 74,
    },
    -- The Barrens (map 1413 44.46,59.10) -> Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1413,
        fromX = 0.4446,
        fromY = 0.591,
        toPointID = 100043,
        toMap = 1441,
        toX = 0.45022,
        toY = 0.491265,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 77,
        toTaxiNodeID = 30,
        taxiPathIDs = {
            421,
        },
        travelDuration = 117,
    },
    -- Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.355653,
        fromY = 0.318302,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 55,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            348,
        },
        travelDuration = 210,
    },
    -- Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.355653,
        fromY = 0.318302,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 55,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            336,
        },
        travelDuration = 203,
    },
    -- Dustwallow Marsh (map 1445 35.57,31.83) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.355653,
        fromY = 0.318302,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 55,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            304,
        },
        travelDuration = 151,
    },
    -- Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.355653,
        fromY = 0.318302,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 55,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            390,
        },
        travelDuration = 208,
    },
    -- Dustwallow Marsh (map 1445 67.46,51.20) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            182,
        },
        travelDuration = 582,
    },
    -- Dustwallow Marsh (map 1445 67.46,51.20) -> Feralas (map 1444 89.46,45.87) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100041,
        toMap = 1444,
        toX = 0.8946,
        toY = 0.4587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 31,
        taxiPathIDs = {
            56,
        },
        travelDuration = 153,
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Nijel's Point, Desolace (map 1443 64.67,10.44) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100054,
        toMap = 1443,
        toX = 0.646713,
        toY = 0.104354,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 37,
        taxiPathIDs = {
            163,
        },
        travelDuration = 313,
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Gadgetzan, Tanaris (map 1446 50.95,29.33) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100065,
        toMap = 1446,
        toX = 0.509542,
        toY = 0.293254,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 39,
        taxiPathIDs = {
            222,
        },
        travelDuration = 147,
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            445,
        },
        travelDuration = 220,
    },
    -- Dustwallow Marsh (map 1445 67.46,51.20) -> The Barrens (map 1413 63.12,37.11) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100002,
        toMap = 1413,
        toX = 0.6312,
        toY = 0.3711,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 80,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 32,
        toTaxiNodeID = 80,
        taxiPathIDs = {
            464,
        },
        travelDuration = 108,
    },

    -- Original source zone: Eastern Plaguelands (map 1423)
    -- Light's Hope Chapel, Eastern Plaguelands (map 1423 70.45,47.59) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200042,
        fromMap = 1423,
        fromX = 0.704459,
        fromY = 0.475904,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 68,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 68,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            359,
        },
        travelDuration = 245,
    },
    -- Light's Hope Chapel, Eastern Plaguelands (map 1423 70.45,47.59) -> Revantusk Village, The Hinterlands (map 1425 81.70,81.89) via flighttaxi
    {
        fromPointID = 200042,
        fromMap = 1423,
        fromX = 0.704459,
        fromY = 0.475904,
        toPointID = 200051,
        toMap = 1425,
        toX = 0.817013,
        toY = 0.818932,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 68,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 68,
        toTaxiNodeID = 76,
        taxiPathIDs = {
            474,
        },
        travelDuration = 132,
    },
    -- Eastern Plaguelands (map 1423 71.70,49.55) -> The Hinterlands (map 1425 11.11,46.09) via flighttaxi
    {
        fromPointID = 200043,
        fromMap = 1423,
        fromX = 0.71699,
        fromY = 0.49555,
        toPointID = 200004,
        toMap = 1425,
        toX = 0.1111,
        toY = 0.4609,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 67,
        toTaxiNodeID = 43,
        taxiPathIDs = {
            352,
        },
        travelDuration = 152,
    },
    -- Eastern Plaguelands (map 1423 71.70,49.55) -> Western Plaguelands (map 1422 42.95,84.95) via flighttaxi
    {
        fromPointID = 200043,
        fromMap = 1423,
        fromX = 0.71699,
        fromY = 0.49555,
        toPointID = 200002,
        toMap = 1422,
        toX = 0.4295,
        toY = 0.8495,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 67,
        toTaxiNodeID = 66,
        taxiPathIDs = {
            432,
        },
        travelDuration = 140,
    },
    -- Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200043,
        fromMap = 1423,
        fromX = 0.71699,
        fromY = 0.49555,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 67,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            437,
        },
        travelDuration = 345,
    },

    -- Original source zone: Felwood (map 1448)
    -- Ashenvale (map 1440 12.19,33.77) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100071,
        fromMap = 1440,
        fromX = 0.1219,
        fromY = 0.3377,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 58,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 58,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            305,
        },
        travelDuration = 213,
    },
    -- Ashenvale (map 1440 12.19,33.77) -> Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100071,
        fromMap = 1440,
        fromX = 0.1219,
        fromY = 0.3377,
        toPointID = 100039,
        toMap = 1440,
        toX = 0.732581,
        toY = 0.616722,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 58,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 58,
        toTaxiNodeID = 61,
        taxiPathIDs = {
            350,
        },
        travelDuration = 157,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Teldrassil (map 1438 58.40,93.93) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100028,
        toMap = 1438,
        toX = 0.584,
        toY = 0.939274,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 27,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 27,
        taxiPathIDs = {
            101,
        },
        travelDuration = 79,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Ashenvale (map 1440 34.50,48.01) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100048,
        toMap = 1440,
        toX = 0.345,
        toY = 0.4801,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 28,
        taxiPathIDs = {
            51,
        },
        travelDuration = 165,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            181,
        },
        travelDuration = 632,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Stonetalon Mountains (map 1442 36.54,7.23) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100046,
        toMap = 1442,
        toX = 0.365356,
        toY = 0.072334,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 33,
        taxiPathIDs = {
            59,
        },
        travelDuration = 170,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Desolace (map 1443 64.67,10.44) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100054,
        toMap = 1443,
        toX = 0.646713,
        toY = 0.104354,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 37,
        taxiPathIDs = {
            385,
        },
        travelDuration = 273,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100055,
        toMap = 1444,
        toX = 0.302592,
        toY = 0.433194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 41,
        taxiPathIDs = {
            226,
        },
        travelDuration = 443,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Moonglade (map 1450 47.91,67.11) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100088,
        toMap = 1450,
        toX = 0.479116,
        toY = 0.671101,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 49,
        taxiPathIDs = {
            289,
        },
        travelDuration = 141,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            330,
        },
        travelDuration = 281,
    },
    -- Darkshore (map 1439 36.40,45.62) -> Felwood (map 1448 62.46,24.19) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1439,
        fromX = 0.364,
        fromY = 0.4562,
        toPointID = 100105,
        toMap = 1448,
        toX = 0.6246,
        toY = 0.2419,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 26,
        toTaxiNodeID = 65,
        taxiPathIDs = {
            386,
        },
        travelDuration = 178,
    },
    -- Bloodvenom Post, Felwood (map 1448 34.42,53.87) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 48,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            341,
        },
        travelDuration = 242,
    },
    -- Felwood (map 1448 34.42,53.87) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 48,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            286,
        },
        travelDuration = 226,
    },
    -- Bloodvenom Post, Felwood (map 1448 34.42,53.87) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 48,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            401,
        },
        travelDuration = 226,
    },
    -- Bloodvenom Post, Felwood (map 1448 34.42,53.87) -> Everlook, Winterspring (map 1452 60.49,36.34) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100094,
        toMap = 1452,
        toX = 0.604853,
        toY = 0.363438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 48,
        toTaxiNodeID = 53,
        taxiPathIDs = {
            307,
        },
        travelDuration = 178,
    },
    -- Bloodvenom Post, Felwood (map 1448 34.42,53.87) -> Moonglade (map 1450 32.15,66.33) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100081,
        toMap = 1450,
        toX = 0.3215,
        toY = 0.663346,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 69,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 48,
        toTaxiNodeID = 69,
        taxiPathIDs = {
            365,
        },
        travelDuration = 155,
    },

    -- Original source zone: Feralas (map 1444)
    -- Feralas (map 1444 30.26,43.32) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 41,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            225,
        },
        travelDuration = 438,
    },
    -- Feralas (map 1444 30.26,43.32) -> Feralas (map 1444 89.46,45.87) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100041,
        toMap = 1444,
        toX = 0.8946,
        toY = 0.4587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 41,
        toTaxiNodeID = 31,
        taxiPathIDs = {
            326,
        },
        travelDuration = 145,
    },
    -- Feathermoon, Feralas (map 1444 30.26,43.32) -> Nijel's Point, Desolace (map 1443 64.67,10.44) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100054,
        toMap = 1443,
        toX = 0.646713,
        toY = 0.104354,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 41,
        toTaxiNodeID = 37,
        taxiPathIDs = {
            374,
        },
        travelDuration = 212,
    },
    -- Feathermoon, Feralas (map 1444 30.26,43.32) -> Cenarion Hold, Silithus (map 1451 50.68,34.59) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100091,
        toMap = 1451,
        toX = 0.506833,
        toY = 0.3459,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 41,
        toTaxiNodeID = 73,
        taxiPathIDs = {
            471,
        },
        travelDuration = 149,
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            227,
        },
        travelDuration = 243,
    },
    -- Feralas (map 1444 75.43,44.31) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            353,
        },
        travelDuration = 247,
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Freewind Post, Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100043,
        toMap = 1441,
        toX = 0.45022,
        toY = 0.491265,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 30,
        taxiPathIDs = {
            486,
        },
        travelDuration = 100,
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Shadowprey Village, Desolace (map 1443 21.56,74.04) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100051,
        toMap = 1443,
        toX = 0.215631,
        toY = 0.740422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 38,
        taxiPathIDs = {
            375,
        },
        travelDuration = 188,
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            391,
        },
        travelDuration = 188,
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Cenarion Hold, Silithus (map 1451 48.83,36.72) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100090,
        toMap = 1451,
        toX = 0.488256,
        toY = 0.367235,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 42,
        toTaxiNodeID = 72,
        taxiPathIDs = {
            450,
        },
        travelDuration = 122,
    },

    -- Original source zone: Hillsbrad Foothills (map 1424)
    -- Southshore, Hillsbrad (map 1424 49.44,52.10) -> Refuge Pointe, Arathi (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200007,
        toMap = 1417,
        toX = 0.457901,
        toY = 0.461332,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 14,
        toTaxiNodeID = 16,
        taxiPathIDs = {
            274,
        },
        travelDuration = 69,
    },
    -- Hillsbrad Foothills (map 1424 49.44,52.10) -> The Hinterlands (map 1425 11.11,46.09) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200004,
        toMap = 1425,
        toX = 0.1111,
        toY = 0.4609,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 14,
        toTaxiNodeID = 43,
        taxiPathIDs = {
            230,
        },
        travelDuration = 67,
    },
    -- Hillsbrad Foothills (map 1424 49.44,52.10) -> Western Plaguelands (map 1422 42.95,84.95) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200002,
        toMap = 1422,
        toX = 0.4295,
        toY = 0.8495,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 14,
        toTaxiNodeID = 66,
        taxiPathIDs = {
            347,
        },
        travelDuration = 76,
    },
    -- Southshore, Hillsbrad (map 1424 49.44,52.10) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 14,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            26,
        },
        travelDuration = 193,
    },
    -- Southshore, Hillsbrad (map 1424 49.44,52.10) -> Menethil Harbor, Wetlands (map 1437 9.52,59.66) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200094,
        toMap = 1437,
        toX = 0.095204,
        toY = 0.596587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 14,
        toTaxiNodeID = 7,
        taxiPathIDs = {
            272,
        },
        travelDuration = 103,
    },

    -- Original source zone: Ironforge (map 1455)
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Southshore, Hillsbrad (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200045,
        toMap = 1424,
        toX = 0.494421,
        toY = 0.521006,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 14,
        taxiPathIDs = {
            27,
        },
        travelDuration = 248,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Refuge Pointe, Arathi (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200007,
        toMap = 1417,
        toX = 0.457901,
        toY = 0.461332,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 16,
        taxiPathIDs = {
            31,
        },
        travelDuration = 237,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            12,
        },
        travelDuration = 197,
    },
    -- Ironforge (map 1455 55.89,47.87) -> The Hinterlands (map 1425 11.11,46.09) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200004,
        toMap = 1425,
        toX = 0.1111,
        toY = 0.4609,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 43,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 43,
        taxiPathIDs = {
            263,
        },
        travelDuration = 279,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Dun Baldar, Alterac Valley (map 1459 43.14,18.10) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 1300001,
        toMap = 1459,
        toX = 0.431363,
        toY = 0.180958,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 59,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 59,
        taxiPathIDs = {
            314,
        },
    },
    -- Ironforge (map 1455 55.89,47.87) -> Western Plaguelands (map 1422 42.95,84.95) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200002,
        toMap = 1422,
        toX = 0.4295,
        toY = 0.8495,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 66,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 66,
        taxiPathIDs = {
            428,
        },
        travelDuration = 276,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200043,
        toMap = 1423,
        toX = 0.71699,
        toY = 0.49555,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 67,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 67,
        taxiPathIDs = {
            438,
        },
        travelDuration = 326,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Thorium Point, Searing Gorge (map 1427 37.89,30.43) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200056,
        toMap = 1427,
        toX = 0.37887,
        toY = 0.304262,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 74,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 74,
        taxiPathIDs = {
            404,
        },
        travelDuration = 81,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Menethil Harbor, Wetlands (map 1437 9.52,59.66) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200094,
        toMap = 1437,
        toX = 0.095204,
        toY = 0.596587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 7,
        taxiPathIDs = {
            18,
        },
        travelDuration = 121,
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Thelsamar, Loch Modan (map 1432 33.94,50.79) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200074,
        toMap = 1432,
        toX = 0.33943,
        toY = 0.507947,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 6,
        toTaxiNodeID = 8,
        taxiPathIDs = {
            16,
        },
        travelDuration = 95,
    },

    -- Original source zone: Loch Modan (map 1432)
    -- Thelsamar, Loch Modan (map 1432 33.94,50.79) -> Refuge Pointe, Arathi (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200074,
        fromMap = 1432,
        fromX = 0.33943,
        fromY = 0.507947,
        toPointID = 200007,
        toMap = 1417,
        toX = 0.457901,
        toY = 0.461332,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 8,
        toTaxiNodeID = 16,
        taxiPathIDs = {
            267,
        },
        travelDuration = 153,
    },
    -- Thelsamar, Loch Modan (map 1432 33.94,50.79) -> Farholde Keep, Riverglades (map 2548 60.59,81.57) via flighttaxi
    {
        fromPointID = 200074,
        fromMap = 1432,
        fromX = 0.33943,
        fromY = 0.507947,
        toPointID = 200111,
        toMap = 2548,
        toX = 0.605939,
        toY = 0.815701,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 8,
        toTaxiNodeID = 3276,
        taxiPathIDs = {
            11589,
        },
        travelDuration = 173,
    },
    -- Thelsamar, Loch Modan (map 1432 33.94,50.79) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200074,
        fromMap = 1432,
        fromX = 0.33943,
        fromY = 0.507947,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 8,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            15,
        },
        travelDuration = 102,
    },
    -- Thelsamar, Loch Modan (map 1432 33.94,50.79) -> Menethil Harbor, Wetlands (map 1437 9.52,59.66) via flighttaxi
    {
        fromPointID = 200074,
        fromMap = 1432,
        fromX = 0.33943,
        fromY = 0.507947,
        toPointID = 200094,
        toMap = 1437,
        toX = 0.095204,
        toY = 0.596587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 8,
        toTaxiNodeID = 7,
        taxiPathIDs = {
            265,
        },
        travelDuration = 143,
    },

    -- Original source zone: Moonglade (map 1450)
    -- Moonglade (map 1450 32.15,66.33) -> Bloodvenom Post, Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100081,
        fromMap = 1450,
        fromX = 0.3215,
        fromY = 0.663346,
        toPointID = 100073,
        toMap = 1448,
        toX = 0.344154,
        toY = 0.538678,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 69,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 69,
        toTaxiNodeID = 48,
        taxiPathIDs = {
            364,
        },
        travelDuration = 147,
    },
    -- Moonglade (map 1450 32.15,66.33) -> Everlook, Winterspring (map 1452 60.49,36.34) via flighttaxi
    {
        fromPointID = 100081,
        fromMap = 1450,
        fromX = 0.3215,
        fromY = 0.663346,
        toPointID = 100094,
        toMap = 1452,
        toX = 0.604853,
        toY = 0.363438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 69,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 69,
        toTaxiNodeID = 53,
        taxiPathIDs = {
            366,
        },
        travelDuration = 133,
    },
    -- Moonglade (map 1450 44.19,45.33) -> Teldrassil (map 1438 58.33,93.86) via flighttaxi
    {
        fromPointID = 100084,
        fromMap = 1450,
        fromX = 0.4419,
        fromY = 0.4533,
        toPointID = 100027,
        toMap = 1438,
        toX = 0.5833,
        toY = 0.9386,
        type = "flighttaxi",
        travelDuration = 145,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "DRUID",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        toRegion = "ruttheran",
    },
    -- Moonglade (map 1450 44.27,45.77) -> Thunder Bluff (map 1456 46.70,49.92) via flighttaxi
    {
        fromPointID = 100085,
        fromMap = 1450,
        fromX = 0.4427,
        fromY = 0.4577,
        toPointID = 100101,
        toMap = 1456,
        toX = 0.467,
        toY = 0.4992,
        type = "flighttaxi",
        travelDuration = 515,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "DRUID",
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
    },
    -- Nighthaven, Moonglade (map 1450 44.28,45.34) -> Rut'theran Village, Teldrassil (map 1438 58.40,93.93) via flighttaxi
    {
        fromPointID = 100086,
        fromMap = 1450,
        fromX = 0.442839,
        fromY = 0.453406,
        toPointID = 100028,
        toMap = 1438,
        toX = 0.584,
        toY = 0.939274,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 62,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 27,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 62,
        toTaxiNodeID = 27,
        taxiPathIDs = {
            315,
        },
        travelDuration = 142,
    },
    -- Nighthaven, Moonglade (map 1450 44.31,45.72) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100087,
        fromMap = 1450,
        fromX = 0.443112,
        fromY = 0.457231,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 63,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 63,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            316,
        },
        travelDuration = 510,
    },
    -- Moonglade (map 1450 47.91,67.11) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100088,
        fromMap = 1450,
        fromX = 0.479116,
        fromY = 0.671101,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 49,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            368,
        },
        travelDuration = 133,
    },
    -- Moonglade (map 1450 47.91,67.11) -> Everlook, Winterspring (map 1452 62.33,36.64) via flighttaxi
    {
        fromPointID = 100088,
        fromMap = 1450,
        fromX = 0.479116,
        fromY = 0.671101,
        toPointID = 100095,
        toMap = 1452,
        toX = 0.623348,
        toY = 0.366358,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 49,
        toTaxiNodeID = 52,
        taxiPathIDs = {
            367,
        },
        travelDuration = 122,
    },
    -- Moonglade (map 1450 47.91,67.11) -> Felwood (map 1448 62.46,24.19) via flighttaxi
    {
        fromPointID = 100088,
        fromMap = 1450,
        fromX = 0.479116,
        fromY = 0.671101,
        toPointID = 100105,
        toMap = 1448,
        toX = 0.6246,
        toY = 0.2419,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 49,
        toTaxiNodeID = 65,
        taxiPathIDs = {
            479,
        },
        travelDuration = 57,
    },

    -- Original source zone: Mount Hyjal (map 2482)
    -- Felwood (map 1448 62.46,24.19) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 1448,
        fromX = 0.6246,
        fromY = 0.2419,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 65,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            369,
        },
        travelDuration = 176,
    },
    -- Felwood (map 1448 62.46,24.19) -> Moonglade (map 1450 47.91,67.11) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 1448,
        fromX = 0.6246,
        fromY = 0.2419,
        toPointID = 100088,
        toMap = 1450,
        toX = 0.479116,
        toY = 0.671101,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 65,
        toTaxiNodeID = 49,
        taxiPathIDs = {
            480,
        },
        travelDuration = 63,
    },
    -- Felwood (map 1448 62.46,24.19) -> Winterspring (map 1452 62.33,36.64) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 1448,
        fromX = 0.6246,
        fromY = 0.2419,
        toPointID = 100095,
        toMap = 1452,
        toX = 0.623348,
        toY = 0.366358,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 65,
        toTaxiNodeID = 52,
        taxiPathIDs = {
            371,
        },
        travelDuration = 113,
    },
    -- Felwood (map 1448 62.46,24.19) -> Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 1448,
        fromX = 0.6246,
        fromY = 0.2419,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 65,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            372,
        },
        travelDuration = 265,
    },
    -- Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) -> Everlook, Winterspring (map 1452 62.33,36.64) via flighttaxi
    {
        fromPointID = 100106,
        fromMap = 2482,
        fromX = 0.550959,
        fromY = 0.825482,
        toPointID = 100095,
        toMap = 1452,
        toX = 0.623348,
        toY = 0.366358,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3242,
        toTaxiNodeID = 52,
        taxiPathIDs = {
            11529,
        },
        travelDuration = 117,
    },
    -- Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) -> Everlook, Winterspring (map 1452 60.49,36.34) via flighttaxi
    {
        fromPointID = 100106,
        fromMap = 2482,
        fromX = 0.550959,
        fromY = 0.825482,
        toPointID = 100094,
        toMap = 1452,
        toX = 0.604853,
        toY = 0.363438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 3242,
        toTaxiNodeID = 53,
        taxiPathIDs = {
            11526,
        },
        travelDuration = 124,
    },
    -- Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) -> Summit of Eternity, Mount Hyjal (map 2482 68.64,44.11) via flighttaxi
    {
        fromPointID = 100106,
        fromMap = 2482,
        fromX = 0.550959,
        fromY = 0.825482,
        toPointID = 100107,
        toMap = 2482,
        toX = 0.686392,
        toY = 0.441106,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 559,
                },
            },
        },
        fromTaxiNodeID = 3242,
        toTaxiNodeID = 559,
        taxiPathIDs = {
            11528,
        },
        travelDuration = 58,
    },
    -- Summit of Eternity, Mount Hyjal (map 2482 68.64,44.11) -> Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) via flighttaxi
    {
        fromPointID = 100107,
        fromMap = 2482,
        fromX = 0.686392,
        fromY = 0.441106,
        toPointID = 100106,
        toMap = 2482,
        toX = 0.550959,
        toY = 0.825482,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 559,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
            },
        },
        fromTaxiNodeID = 559,
        toTaxiNodeID = 3242,
        taxiPathIDs = {
            11524,
        },
        travelDuration = 58,
    },

    -- Original source zone: Orgrimmar (map 1454)
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            42,
        },
        travelDuration = 211,
    },
    -- Orgrimmar (map 1454 45.28,63.75) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            47,
        },
        travelDuration = 103,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            224,
        },
        travelDuration = 391,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            243,
        },
        travelDuration = 93,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Bloodvenom Post, Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100073,
        toMap = 1448,
        toX = 0.344154,
        toY = 0.538678,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 48,
        taxiPathIDs = {
            338,
        },
        travelDuration = 236,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Everlook, Winterspring (map 1452 60.49,36.34) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100094,
        toMap = 1452,
        toX = 0.604853,
        toY = 0.363438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 53,
        taxiPathIDs = {
            399,
        },
        travelDuration = 299,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100060,
        toMap = 1445,
        toX = 0.355653,
        toY = 0.318302,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 55,
        taxiPathIDs = {
            335,
        },
        travelDuration = 214,
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Splintertree Post, Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100039,
        toMap = 1440,
        toX = 0.732581,
        toY = 0.616722,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 61,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 23,
        toTaxiNodeID = 61,
        taxiPathIDs = {
            328,
        },
        travelDuration = 84,
    },

    -- Original source zone: Redridge Mountains (map 1433)
    -- Redridge Mountains (map 1433 25.34,58.99) -> Duskwood (map 1431 77.59,44.38) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200064,
        toMap = 1431,
        toX = 0.7759,
        toY = 0.4438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 5,
        toTaxiNodeID = 12,
        taxiPathIDs = {
            257,
        },
        travelDuration = 57,
    },
    -- Lakeshire, Redridge (map 1433 25.34,58.99) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 5,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            8,
        },
        travelDuration = 105,
    },
    -- Lakeshire, Redridge (map 1433 25.34,58.99) -> Farholde Keep, Riverglades (map 2548 60.59,81.57) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200111,
        toMap = 2548,
        toX = 0.605939,
        toY = 0.815701,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 5,
        toTaxiNodeID = 3276,
        taxiPathIDs = {
            11585,
        },
        travelDuration = 124,
    },
    -- Lakeshire, Redridge (map 1433 25.34,58.99) -> Sentinel Hill, Westfall (map 1436 56.57,52.67) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200091,
        toMap = 1436,
        toX = 0.56571,
        toY = 0.526667,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 5,
        toTaxiNodeID = 4,
        taxiPathIDs = {
            254,
        },
        travelDuration = 125,
    },
    -- Lakeshire, Redridge (map 1433 25.34,58.99) -> Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200061,
        toMap = 1428,
        toX = 0.843818,
        toY = 0.683045,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 5,
        toTaxiNodeID = 71,
        taxiPathIDs = {
            469,
        },
        travelDuration = 57,
    },

    -- Original source zone: Riverglades (map 2548)
    -- Rog'mar, Riverglades (map 2548 59.61,45.06) -> Hammerfall, Arathi (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200008,
        toMap = 1417,
        toX = 0.730618,
        toY = 0.326232,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 3203,
        toTaxiNodeID = 17,
        taxiPathIDs = {
            11580,
        },
        travelDuration = 308,
    },
    -- Riverglades (map 2548 59.61,45.06) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 3203,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            11576,
        },
        travelDuration = 113,
    },
    -- Rog'mar, Riverglades (map 2548 59.61,45.06) -> Stonard, Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200089,
        toMap = 1435,
        toX = 0.460527,
        toY = 0.546792,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 3203,
        toTaxiNodeID = 56,
        taxiPathIDs = {
            11574,
        },
        travelDuration = 144,
    },
    -- Riverglades (map 2548 59.61,45.06) -> Burning Steppes (map 1428 65.58,24.22) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200059,
        toMap = 1428,
        toX = 0.6558,
        toY = 0.2422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 3203,
        toTaxiNodeID = 70,
        taxiPathIDs = {
            11578,
        },
        travelDuration = 125,
    },
    -- Farholde Keep, Riverglades (map 2548 60.59,81.57) -> Lakeshire, Redridge (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200111,
        fromMap = 2548,
        fromX = 0.605939,
        fromY = 0.815701,
        toPointID = 200078,
        toMap = 1433,
        toX = 0.253428,
        toY = 0.589882,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3276,
        toTaxiNodeID = 5,
        taxiPathIDs = {
            11584,
        },
        travelDuration = 122,
    },
    -- Farholde Keep, Riverglades (map 2548 60.59,81.57) -> Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200111,
        fromMap = 2548,
        fromX = 0.605939,
        fromY = 0.815701,
        toPointID = 200061,
        toMap = 1428,
        toX = 0.843818,
        toY = 0.683045,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3276,
        toTaxiNodeID = 71,
        taxiPathIDs = {
            11586,
        },
        travelDuration = 115,
    },
    -- Farholde Keep, Riverglades (map 2548 60.59,81.57) -> Thelsamar, Loch Modan (map 1432 33.94,50.79) via flighttaxi
    {
        fromPointID = 200111,
        fromMap = 2548,
        fromX = 0.605939,
        fromY = 0.815701,
        toPointID = 200074,
        toMap = 1432,
        toX = 0.33943,
        toY = 0.507947,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3276,
        toTaxiNodeID = 8,
        taxiPathIDs = {
            11588,
        },
        travelDuration = 162,
    },

    -- Original source zone: Searing Gorge (map 1427)
    -- Searing Gorge (map 1427 34.83,30.58) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200055,
        fromMap = 1427,
        fromX = 0.348295,
        fromY = 0.305836,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 75,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 75,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            407,
        },
        travelDuration = 65,
    },
    -- Searing Gorge (map 1427 34.83,30.58) -> Burning Steppes (map 1428 65.58,24.22) via flighttaxi
    {
        fromPointID = 200055,
        fromMap = 1427,
        fromX = 0.348295,
        fromY = 0.305836,
        toPointID = 200059,
        toMap = 1428,
        toX = 0.6558,
        toY = 0.2422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 75,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 75,
        toTaxiNodeID = 70,
        taxiPathIDs = {
            409,
        },
        travelDuration = 72,
    },
    -- Thorium Point, Searing Gorge (map 1427 37.89,30.43) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200056,
        fromMap = 1427,
        fromX = 0.37887,
        fromY = 0.304262,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 74,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 74,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            402,
        },
        travelDuration = 88,
    },
    -- Thorium Point, Searing Gorge (map 1427 37.89,30.43) -> Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200056,
        fromMap = 1427,
        fromX = 0.37887,
        fromY = 0.304262,
        toPointID = 200061,
        toMap = 1428,
        toX = 0.843818,
        toY = 0.683045,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 74,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 74,
        toTaxiNodeID = 71,
        taxiPathIDs = {
            411,
        },
        travelDuration = 90,
    },
    -- Badlands (map 1418 4.06,44.89) -> Undercity (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            38,
        },
        travelDuration = 466,
    },
    -- Badlands (map 1418 4.06,44.89) -> Arathi Highlands (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200008,
        toMap = 1417,
        toX = 0.730618,
        toY = 0.326232,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 17,
        taxiPathIDs = {
            319,
        },
        travelDuration = 246,
    },
    -- Badlands (map 1418 4.06,44.89) -> Stranglethorn Vale (map 1434 26.82,77.00) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200081,
        toMap = 1434,
        toX = 0.268163,
        toY = 0.769961,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 18,
        taxiPathIDs = {
            37,
        },
        travelDuration = 390,
    },
    -- Badlands (map 1418 4.06,44.89) -> Stranglethorn Vale (map 1434 32.51,29.28) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200085,
        toMap = 1434,
        toX = 0.3251,
        toY = 0.292755,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 20,
        taxiPathIDs = {
            362,
        },
        travelDuration = 293,
    },
    -- Badlands (map 1418 4.06,44.89) -> Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200110,
        toMap = 2548,
        toX = 0.596143,
        toY = 0.450641,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 3203,
        taxiPathIDs = {
            11577,
        },
        travelDuration = 119,
    },
    -- Badlands (map 1418 4.06,44.89) -> Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200089,
        toMap = 1435,
        toX = 0.460527,
        toY = 0.546792,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 56,
        taxiPathIDs = {
            317,
        },
        travelDuration = 263,
    },
    -- Badlands (map 1418 4.06,44.89) -> Burning Steppes (map 1428 65.58,24.22) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200059,
        toMap = 1428,
        toX = 0.6558,
        toY = 0.2422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 70,
        taxiPathIDs = {
            378,
        },
        travelDuration = 81,
    },
    -- Badlands (map 1418 4.06,44.89) -> Searing Gorge (map 1427 34.83,30.58) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1418,
        fromX = 0.0406,
        fromY = 0.4489,
        toPointID = 200055,
        toMap = 1427,
        toX = 0.348295,
        toY = 0.305836,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 75,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 21,
        toTaxiNodeID = 75,
        taxiPathIDs = {
            406,
        },
        travelDuration = 53,
    },
    -- Burning Steppes (map 1428 65.58,24.22) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1428,
        fromX = 0.6558,
        fromY = 0.2422,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 70,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            377,
        },
        travelDuration = 94,
    },
    -- Burning Steppes (map 1428 65.58,24.22) -> Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1428,
        fromX = 0.6558,
        fromY = 0.2422,
        toPointID = 200110,
        toMap = 2548,
        toX = 0.596143,
        toY = 0.450641,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 70,
        toTaxiNodeID = 3203,
        taxiPathIDs = {
            11579,
        },
        travelDuration = 129,
    },
    -- Burning Steppes (map 1428 65.58,24.22) -> Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1428,
        fromX = 0.6558,
        fromY = 0.2422,
        toPointID = 200089,
        toMap = 1435,
        toX = 0.460527,
        toY = 0.546792,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 70,
        toTaxiNodeID = 56,
        taxiPathIDs = {
            379,
        },
        travelDuration = 199,
    },
    -- Burning Steppes (map 1428 65.58,24.22) -> Searing Gorge (map 1427 34.83,30.58) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1428,
        fromX = 0.6558,
        fromY = 0.2422,
        toPointID = 200055,
        toMap = 1427,
        toX = 0.348295,
        toY = 0.305836,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 75,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 70,
        toTaxiNodeID = 75,
        taxiPathIDs = {
            408,
        },
        travelDuration = 67,
    },

    -- Original source zone: Silithus (map 1451)
    -- Cenarion Hold, Silithus (map 1451 48.83,36.72) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100090,
        fromMap = 1451,
        fromX = 0.488256,
        fromY = 0.367235,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 72,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            423,
        },
        travelDuration = 226,
    },
    -- Cenarion Hold, Silithus (map 1451 48.83,36.72) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100090,
        fromMap = 1451,
        fromX = 0.488256,
        fromY = 0.367235,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 72,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            449,
        },
        travelDuration = 122,
    },
    -- Cenarion Hold, Silithus (map 1451 48.83,36.72) -> Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) via flighttaxi
    {
        fromPointID = 100090,
        fromMap = 1451,
        fromX = 0.488256,
        fromY = 0.367235,
        toPointID = 100079,
        toMap = 1449,
        toX = 0.452982,
        toY = 0.059657,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 72,
        toTaxiNodeID = 79,
        taxiPathIDs = {
            456,
        },
        travelDuration = 91,
    },
    -- Cenarion Hold, Silithus (map 1451 50.68,34.59) -> Gadgetzan, Tanaris (map 1446 50.95,29.33) via flighttaxi
    {
        fromPointID = 100091,
        fromMap = 1451,
        fromX = 0.506833,
        fromY = 0.3459,
        toPointID = 100065,
        toMap = 1446,
        toX = 0.509542,
        toY = 0.293254,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 73,
        toTaxiNodeID = 39,
        taxiPathIDs = {
            424,
        },
        travelDuration = 177,
    },
    -- Cenarion Hold, Silithus (map 1451 50.68,34.59) -> Feathermoon, Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100091,
        fromMap = 1451,
        fromX = 0.506833,
        fromY = 0.3459,
        toPointID = 100055,
        toMap = 1444,
        toX = 0.302592,
        toY = 0.433194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 73,
        toTaxiNodeID = 41,
        taxiPathIDs = {
            451,
        },
        travelDuration = 164,
    },
    -- Cenarion Hold, Silithus (map 1451 50.68,34.59) -> Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) via flighttaxi
    {
        fromPointID = 100091,
        fromMap = 1451,
        fromX = 0.506833,
        fromY = 0.3459,
        toPointID = 100079,
        toMap = 1449,
        toX = 0.452982,
        toY = 0.059657,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 73,
        toTaxiNodeID = 79,
        taxiPathIDs = {
            457,
        },
        travelDuration = 86,
    },

    -- Original source zone: Silverpine Forest (map 1421)
    -- The Sepulcher, Silverpine Forest (map 1421 45.56,42.42) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200025,
        fromMap = 1421,
        fromX = 0.455574,
        fromY = 0.424217,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 10,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            21,
        },
        travelDuration = 105,
    },
    -- Silverpine Forest (map 1421 45.56,42.42) -> Hillsbrad Foothills (map 1424 60.21,18.75) via flighttaxi
    {
        fromPointID = 200025,
        fromMap = 1421,
        fromX = 0.455574,
        fromY = 0.424217,
        toPointID = 200001,
        toMap = 1424,
        toX = 0.6021,
        toY = 0.1875,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 10,
        toTaxiNodeID = 13,
        taxiPathIDs = {
            440,
        },
        travelDuration = 90,
    },

    -- Original source zone: Stonetalon Mountains (map 1442)
    -- Stonetalon Mountains (map 1442 36.54,7.23) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100046,
        fromMap = 1442,
        fromX = 0.365356,
        fromY = 0.072334,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 33,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            58,
        },
        travelDuration = 166,
    },
    -- Stonetalon Mountains (map 1442 36.54,7.23) -> Ashenvale (map 1440 34.50,48.01) via flighttaxi
    {
        fromPointID = 100046,
        fromMap = 1442,
        fromX = 0.365356,
        fromY = 0.072334,
        toPointID = 100048,
        toMap = 1440,
        toX = 0.345,
        toY = 0.4801,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 33,
        toTaxiNodeID = 28,
        taxiPathIDs = {
            444,
        },
        travelDuration = 144,
    },
    -- Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) -> Nijel's Point, Desolace (map 1443 64.67,10.44) via flighttaxi
    {
        fromPointID = 100046,
        fromMap = 1442,
        fromX = 0.365356,
        fromY = 0.072334,
        toPointID = 100054,
        toMap = 1443,
        toX = 0.646713,
        toY = 0.104354,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 37,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 33,
        toTaxiNodeID = 37,
        taxiPathIDs = {
            478,
        },
        travelDuration = 119,
    },
    -- Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100047,
        fromMap = 1442,
        fromX = 0.451641,
        fromY = 0.598878,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 29,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            52,
        },
        travelDuration = 163,
    },
    -- Stonetalon Mountains (map 1442 45.16,59.89) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100047,
        fromMap = 1442,
        fromX = 0.451641,
        fromY = 0.598878,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 29,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            280,
        },
        travelDuration = 140,
    },
    -- Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) -> Shadowprey Village, Desolace (map 1443 21.56,74.04) via flighttaxi
    {
        fromPointID = 100047,
        fromMap = 1442,
        fromX = 0.451641,
        fromY = 0.598878,
        toPointID = 100051,
        toMap = 1443,
        toX = 0.215631,
        toY = 0.740422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 29,
        toTaxiNodeID = 38,
        taxiPathIDs = {
            358,
        },
        travelDuration = 134,
    },
    -- Ashenvale (map 1440 34.50,48.01) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1440,
        fromX = 0.345,
        fromY = 0.4801,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 28,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            50,
        },
        travelDuration = 138,
    },
    -- Ashenvale (map 1440 34.50,48.01) -> Stonetalon Mountains (map 1442 36.54,7.23) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1440,
        fromX = 0.345,
        fromY = 0.4801,
        toPointID = 100046,
        toMap = 1442,
        toX = 0.365356,
        toY = 0.072334,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 33,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 28,
        toTaxiNodeID = 33,
        taxiPathIDs = {
            443,
        },
        travelDuration = 144,
    },
    -- Ashenvale (map 1440 34.50,48.01) -> Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1440,
        fromX = 0.345,
        fromY = 0.4801,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 28,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 28,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            467,
        },
        travelDuration = 138,
    },

    -- Original source zone: Stormwind City (map 1453)
    -- Stormwind City (map 1453 70.98,72.93) -> Duskwood (map 1431 77.59,44.38) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200064,
        toMap = 1431,
        toX = 0.7759,
        toY = 0.4438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 12,
        taxiPathIDs = {
            23,
        },
        travelDuration = 108,
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Booty Bay, Stranglethorn (map 1434 27.53,77.67) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200082,
        toMap = 1434,
        toX = 0.275288,
        toY = 0.776721,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 19,
        taxiPathIDs = {
            40,
        },
        travelDuration = 229,
    },
    -- Stormwind City (map 1453 70.98,72.93) -> Blasted Lands (map 1419 65.49,24.43) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200090,
        toMap = 1419,
        toX = 0.6549,
        toY = 0.2443,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 45,
        taxiPathIDs = {
            245,
        },
        travelDuration = 165,
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Sentinel Hill, Westfall (map 1436 56.57,52.67) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200091,
        toMap = 1436,
        toX = 0.56571,
        toY = 0.526667,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 4,
        taxiPathIDs = {
            6,
        },
        travelDuration = 72,
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Lakeshire, Redridge (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200078,
        toMap = 1433,
        toX = 0.253428,
        toY = 0.589882,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 5,
        taxiPathIDs = {
            9,
        },
        travelDuration = 105,
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            13,
        },
        travelDuration = 242,
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200061,
        toMap = 1428,
        toX = 0.843818,
        toY = 0.683045,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 2,
        toTaxiNodeID = 71,
        taxiPathIDs = {
            427,
        },
        travelDuration = 147,
    },

    -- Original source zone: Stranglethorn Vale (map 1434)
    -- Booty Bay, Stranglethorn (map 1434 26.82,77.00) -> Grom'gol, Stranglethorn (map 1434 32.51,29.28) via flighttaxi
    {
        fromPointID = 200081,
        fromMap = 1434,
        fromX = 0.268163,
        fromY = 0.769961,
        toPointID = 200085,
        toMap = 1434,
        toX = 0.3251,
        toY = 0.292755,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 18,
        toTaxiNodeID = 20,
        taxiPathIDs = {
            35,
        },
        travelDuration = 95,
    },
    -- Stranglethorn Vale (map 1434 26.82,77.00) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200081,
        fromMap = 1434,
        fromX = 0.268163,
        fromY = 0.769961,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 18,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            36,
        },
        travelDuration = 381,
    },
    -- Booty Bay, Stranglethorn (map 1434 26.82,77.00) -> Stonard, Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200081,
        fromMap = 1434,
        fromX = 0.268163,
        fromY = 0.769961,
        toPointID = 200089,
        toMap = 1435,
        toX = 0.460527,
        toY = 0.546792,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 18,
        toTaxiNodeID = 56,
        taxiPathIDs = {
            82,
        },
        travelDuration = 250,
    },
    -- Stranglethorn Vale (map 1434 27.53,77.67) -> Duskwood (map 1431 77.59,44.38) via flighttaxi
    {
        fromPointID = 200082,
        fromMap = 1434,
        fromX = 0.275288,
        fromY = 0.776721,
        toPointID = 200064,
        toMap = 1431,
        toX = 0.7759,
        toY = 0.4438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 19,
        toTaxiNodeID = 12,
        taxiPathIDs = {
            260,
        },
        travelDuration = 164,
    },
    -- Booty Bay, Stranglethorn (map 1434 27.53,77.67) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200082,
        fromMap = 1434,
        fromX = 0.275288,
        fromY = 0.776721,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 19,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            41,
        },
        travelDuration = 206,
    },
    -- Booty Bay, Stranglethorn (map 1434 27.53,77.67) -> Sentinel Hill, Westfall (map 1436 56.57,52.67) via flighttaxi
    {
        fromPointID = 200082,
        fromMap = 1434,
        fromX = 0.275288,
        fromY = 0.776721,
        toPointID = 200091,
        toMap = 1436,
        toX = 0.56571,
        toY = 0.526667,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 19,
        toTaxiNodeID = 4,
        taxiPathIDs = {
            256,
        },
        travelDuration = 170,
    },
    -- Grom'gol, Stranglethorn (map 1434 32.51,29.28) -> Booty Bay, Stranglethorn (map 1434 26.82,77.00) via flighttaxi
    {
        fromPointID = 200085,
        fromMap = 1434,
        fromX = 0.3251,
        fromY = 0.292755,
        toPointID = 200081,
        toMap = 1434,
        toX = 0.268163,
        toY = 0.769961,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 20,
        toTaxiNodeID = 18,
        taxiPathIDs = {
            34,
        },
        travelDuration = 76,
    },
    -- Stranglethorn Vale (map 1434 32.51,29.28) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200085,
        fromMap = 1434,
        fromX = 0.3251,
        fromY = 0.292755,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 20,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            361,
        },
        travelDuration = 306,
    },
    -- Grom'gol, Stranglethorn (map 1434 32.51,29.28) -> Stonard, Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200085,
        fromMap = 1434,
        fromX = 0.3251,
        fromY = 0.292755,
        toPointID = 200089,
        toMap = 1435,
        toX = 0.460527,
        toY = 0.546792,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 20,
        toTaxiNodeID = 56,
        taxiPathIDs = {
            344,
        },
        travelDuration = 192,
    },

    -- Original source zone: Swamp of Sorrows (map 1435)
    -- Stonard, Swamp of Sorrows (map 1435 46.05,54.68) -> Booty Bay, Stranglethorn (map 1434 26.82,77.00) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200081,
        toMap = 1434,
        toX = 0.268163,
        toY = 0.769961,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 18,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 56,
        toTaxiNodeID = 18,
        taxiPathIDs = {
            121,
        },
        travelDuration = 244,
    },
    -- Stonard, Swamp of Sorrows (map 1435 46.05,54.68) -> Grom'gol, Stranglethorn (map 1434 32.51,29.28) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200085,
        toMap = 1434,
        toX = 0.3251,
        toY = 0.292755,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 20,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 56,
        toTaxiNodeID = 20,
        taxiPathIDs = {
            343,
        },
        travelDuration = 176,
    },
    -- Swamp of Sorrows (map 1435 46.05,54.68) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 56,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            318,
        },
        travelDuration = 267,
    },
    -- Stonard, Swamp of Sorrows (map 1435 46.05,54.68) -> Rog'mar, Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200110,
        toMap = 2548,
        toX = 0.596143,
        toY = 0.450641,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3203,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 56,
        toTaxiNodeID = 3203,
        taxiPathIDs = {
            11575,
        },
        travelDuration = 159,
    },
    -- Swamp of Sorrows (map 1435 46.05,54.68) -> Burning Steppes (map 1428 65.58,24.22) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200059,
        toMap = 1428,
        toX = 0.6558,
        toY = 0.2422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 56,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 70,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 56,
        toTaxiNodeID = 70,
        taxiPathIDs = {
            380,
        },
        travelDuration = 185,
    },
    -- Blasted Lands (map 1419 65.49,24.43) -> Duskwood (map 1431 77.59,44.38) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1419,
        fromX = 0.6549,
        fromY = 0.2443,
        toPointID = 200064,
        toMap = 1431,
        toX = 0.7759,
        toY = 0.4438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 45,
        toTaxiNodeID = 12,
        taxiPathIDs = {
            262,
        },
        travelDuration = 86,
    },
    -- Blasted Lands (map 1419 65.49,24.43) -> Stormwind City (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1419,
        fromX = 0.6549,
        fromY = 0.2443,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 45,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            244,
        },
        travelDuration = 177,
    },
    -- Blasted Lands (map 1419 65.49,24.43) -> Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1419,
        fromX = 0.6549,
        fromY = 0.2443,
        toPointID = 200061,
        toMap = 1428,
        toX = 0.843818,
        toY = 0.683045,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 45,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 71,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 45,
        toTaxiNodeID = 71,
        taxiPathIDs = {
            382,
        },
        travelDuration = 195,
    },

    -- Original source zone: Tanaris (map 1446)
    -- Tanaris (map 1446 50.95,29.33) -> Feralas (map 1444 89.46,45.87) via flighttaxi
    {
        fromPointID = 100065,
        fromMap = 1446,
        fromX = 0.509542,
        fromY = 0.293254,
        toPointID = 100041,
        toMap = 1444,
        toX = 0.8946,
        toY = 0.4587,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 39,
        toTaxiNodeID = 31,
        taxiPathIDs = {
            323,
        },
        travelDuration = 166,
    },
    -- Gadgetzan, Tanaris (map 1446 50.95,29.33) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100065,
        fromMap = 1446,
        fromX = 0.509542,
        fromY = 0.293254,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 39,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            201,
        },
        travelDuration = 144,
    },
    -- Gadgetzan, Tanaris (map 1446 50.95,29.33) -> Cenarion Hold, Silithus (map 1451 50.68,34.59) via flighttaxi
    {
        fromPointID = 100065,
        fromMap = 1446,
        fromX = 0.509542,
        fromY = 0.293254,
        toPointID = 100091,
        toMap = 1451,
        toX = 0.506833,
        toY = 0.3459,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 39,
        toTaxiNodeID = 73,
        taxiPathIDs = {
            394,
        },
        travelDuration = 185,
    },
    -- Gadgetzan, Tanaris (map 1446 50.95,29.33) -> Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) via flighttaxi
    {
        fromPointID = 100065,
        fromMap = 1446,
        fromX = 0.509542,
        fromY = 0.293254,
        toPointID = 100079,
        toMap = 1449,
        toX = 0.452982,
        toY = 0.059657,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 39,
        toTaxiNodeID = 79,
        taxiPathIDs = {
            458,
        },
        travelDuration = 97,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            311,
        },
        travelDuration = 285,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            223,
        },
        travelDuration = 328,
    },
    -- Tanaris (map 1446 51.62,25.52) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            392,
        },
        travelDuration = 282,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Freewind Post, Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100043,
        toMap = 1441,
        toX = 0.45022,
        toY = 0.491265,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 30,
        taxiPathIDs = {
            310,
        },
        travelDuration = 81,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            389,
        },
        travelDuration = 187,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100060,
        toMap = 1445,
        toX = 0.355653,
        toY = 0.318302,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 55,
        taxiPathIDs = {
            388,
        },
        travelDuration = 208,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Cenarion Hold, Silithus (map 1451 48.83,36.72) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100090,
        toMap = 1451,
        toX = 0.488256,
        toY = 0.367235,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 72,
        taxiPathIDs = {
            395,
        },
        travelDuration = 218,
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100079,
        toMap = 1449,
        toX = 0.452982,
        toY = 0.059657,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 40,
        toTaxiNodeID = 79,
        taxiPathIDs = {
            459,
        },
        travelDuration = 101,
    },

    -- Original source zone: Teldrassil (map 1438)
    -- Teldrassil (map 1438 58.40,93.93) -> Darkshore (map 1439 36.40,45.62) via flighttaxi
    {
        fromPointID = 100028,
        fromMap = 1438,
        fromX = 0.584,
        fromY = 0.939274,
        toPointID = 100072,
        toMap = 1439,
        toX = 0.364,
        toY = 0.4562,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 27,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 26,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 27,
        toTaxiNodeID = 26,
        taxiPathIDs = {
            102,
        },
        travelDuration = 80,
    },

    -- Original source zone: The Hinterlands (map 1425)
    -- Revantusk Village, The Hinterlands (map 1425 81.70,81.89) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200051,
        fromMap = 1425,
        fromX = 0.817013,
        fromY = 0.818932,
        toPointID = 200107,
        toMap = 1458,
        toX = 0.630851,
        toY = 0.483242,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 76,
        toTaxiNodeID = 11,
        taxiPathIDs = {
            415,
        },
        travelDuration = 267,
    },
    -- The Hinterlands (map 1425 81.70,81.89) -> Hillsbrad Foothills (map 1424 60.21,18.75) via flighttaxi
    {
        fromPointID = 200051,
        fromMap = 1425,
        fromX = 0.817013,
        fromY = 0.818932,
        toPointID = 200001,
        toMap = 1424,
        toX = 0.6021,
        toY = 0.1875,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 76,
        toTaxiNodeID = 13,
        taxiPathIDs = {
            412,
        },
        travelDuration = 149,
    },
    -- Revantusk Village, The Hinterlands (map 1425 81.70,81.89) -> Hammerfall, Arathi (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200051,
        fromMap = 1425,
        fromX = 0.817013,
        fromY = 0.818932,
        toPointID = 200008,
        toMap = 1417,
        toX = 0.730618,
        toY = 0.326232,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 76,
        toTaxiNodeID = 17,
        taxiPathIDs = {
            485,
        },
        travelDuration = 87,
    },
    -- Revantusk Village, The Hinterlands (map 1425 81.70,81.89) -> Light's Hope Chapel, Eastern Plaguelands (map 1423 70.45,47.59) via flighttaxi
    {
        fromPointID = 200051,
        fromMap = 1425,
        fromX = 0.817013,
        fromY = 0.818932,
        toPointID = 200042,
        toMap = 1423,
        toX = 0.704459,
        toY = 0.475904,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 68,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 76,
        toTaxiNodeID = 68,
        taxiPathIDs = {
            473,
        },
        travelDuration = 130,
    },

    -- Original source zone: Thousand Needles (map 1441)
    -- Feralas (map 1444 89.46,45.87) -> Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1444,
        fromX = 0.8946,
        fromY = 0.4587,
        toPointID = 100061,
        toMap = 1445,
        toX = 0.674587,
        toY = 0.512011,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 32,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 31,
        toTaxiNodeID = 32,
        taxiPathIDs = {
            57,
        },
        travelDuration = 149,
    },
    -- Feralas (map 1444 89.46,45.87) -> Tanaris (map 1446 50.95,29.33) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1444,
        fromX = 0.8946,
        fromY = 0.4587,
        toPointID = 100065,
        toMap = 1446,
        toX = 0.509542,
        toY = 0.293254,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 31,
        toTaxiNodeID = 39,
        taxiPathIDs = {
            324,
        },
        travelDuration = 160,
    },
    -- Feralas (map 1444 89.46,45.87) -> Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1444,
        fromX = 0.8946,
        fromY = 0.4587,
        toPointID = 100055,
        toMap = 1444,
        toX = 0.302592,
        toY = 0.433194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 31,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 41,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 31,
        toTaxiNodeID = 41,
        taxiPathIDs = {
            325,
        },
        travelDuration = 167,
    },
    -- Freewind Post, Thousand Needles (map 1441 45.02,49.13) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100100,
        toMap = 1456,
        toX = 0.466545,
        toY = 0.498984,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 30,
        toTaxiNodeID = 22,
        taxiPathIDs = {
            54,
        },
        travelDuration = 211,
    },
    -- Thousand Needles (map 1441 45.02,49.13) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 30,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            282,
        },
        travelDuration = 182,
    },
    -- Freewind Post, Thousand Needles (map 1441 45.02,49.13) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 30,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            308,
        },
        travelDuration = 87,
    },
    -- Freewind Post, Thousand Needles (map 1441 45.02,49.13) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 30,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            487,
        },
        travelDuration = 115,
    },
    -- Thousand Needles (map 1441 45.02,49.13) -> The Barrens (map 1413 44.46,59.10) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100058,
        toMap = 1413,
        toX = 0.4446,
        toY = 0.591,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 30,
        toTaxiNodeID = 77,
        taxiPathIDs = {
            422,
        },
        travelDuration = 128,
    },

    -- Original source zone: Thunder Bluff (map 1456)
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            387,
        },
        travelDuration = 194,
    },
    -- Thunder Bluff (map 1456 46.65,49.90) -> The Barrens (map 1413 51.50,30.41) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100001,
        toMap = 1413,
        toX = 0.515,
        toY = 0.3041,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 25,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 25,
        taxiPathIDs = {
            46,
        },
        travelDuration = 149,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100047,
        toMap = 1442,
        toX = 0.451641,
        toY = 0.598878,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 29,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 29,
        taxiPathIDs = {
            53,
        },
        travelDuration = 170,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Freewind Post, Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100043,
        toMap = 1441,
        toX = 0.45022,
        toY = 0.491265,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 30,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 30,
        taxiPathIDs = {
            55,
        },
        travelDuration = 191,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Shadowprey Village, Desolace (map 1443 21.56,74.04) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100051,
        toMap = 1443,
        toX = 0.215631,
        toY = 0.740422,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 38,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 38,
        taxiPathIDs = {
            162,
        },
        travelDuration = 148,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            309,
        },
        travelDuration = 272,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100057,
        toMap = 1444,
        toX = 0.754296,
        toY = 0.443135,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 42,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 42,
        taxiPathIDs = {
            228,
        },
        travelDuration = 236,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            290,
        },
        travelDuration = 252,
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100060,
        toMap = 1445,
        toX = 0.355653,
        toY = 0.318302,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 55,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 55,
        taxiPathIDs = {
            345,
        },
        travelDuration = 223,
    },
    -- Thunder Bluff (map 1456 46.65,49.90) -> The Barrens (map 1413 44.46,59.10) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100058,
        toMap = 1413,
        toX = 0.4446,
        toY = 0.591,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 22,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 77,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 22,
        toTaxiNodeID = 77,
        taxiPathIDs = {
            419,
        },
        travelDuration = 81,
    },

    -- Original source zone: Un'Goro Crater (map 1449)
    -- Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) -> Gadgetzan, Tanaris (map 1446 50.95,29.33) via flighttaxi
    {
        fromPointID = 100079,
        fromMap = 1449,
        fromX = 0.452982,
        fromY = 0.059657,
        toPointID = 100065,
        toMap = 1446,
        toX = 0.509542,
        toY = 0.293254,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 39,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 79,
        toTaxiNodeID = 39,
        taxiPathIDs = {
            452,
        },
        travelDuration = 97,
    },
    -- Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100079,
        fromMap = 1449,
        fromX = 0.452982,
        fromY = 0.059657,
        toPointID = 100066,
        toMap = 1446,
        toX = 0.516175,
        toY = 0.255194,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 40,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 79,
        toTaxiNodeID = 40,
        taxiPathIDs = {
            453,
        },
        travelDuration = 106,
    },
    -- Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) -> Cenarion Hold, Silithus (map 1451 48.83,36.72) via flighttaxi
    {
        fromPointID = 100079,
        fromMap = 1449,
        fromX = 0.452982,
        fromY = 0.059657,
        toPointID = 100090,
        toMap = 1451,
        toX = 0.488256,
        toY = 0.367235,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 72,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 79,
        toTaxiNodeID = 72,
        taxiPathIDs = {
            454,
        },
        travelDuration = 94,
    },
    -- Marshal's Refuge, Un'Goro Crater (map 1449 45.30,5.97) -> Cenarion Hold, Silithus (map 1451 50.68,34.59) via flighttaxi
    {
        fromPointID = 100079,
        fromMap = 1449,
        fromX = 0.452982,
        fromY = 0.059657,
        toPointID = 100091,
        toMap = 1451,
        toX = 0.506833,
        toY = 0.3459,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 79,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 73,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 79,
        toTaxiNodeID = 73,
        taxiPathIDs = {
            455,
        },
        travelDuration = 88,
    },

    -- Original source zone: Undercity (map 1458)
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> The Sepulcher, Silverpine Forest (map 1421 45.56,42.42) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200025,
        toMap = 1421,
        toX = 0.455574,
        toY = 0.424217,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 10,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 10,
        taxiPathIDs = {
            20,
        },
        travelDuration = 99,
    },
    -- Undercity (map 1458 63.09,48.32) -> Hillsbrad Foothills (map 1424 60.21,18.75) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200001,
        toMap = 1424,
        toX = 0.6021,
        toY = 0.1875,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 13,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 13,
        taxiPathIDs = {
            25,
        },
        travelDuration = 132,
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Hammerfall, Arathi (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200008,
        toMap = 1417,
        toX = 0.730618,
        toY = 0.326232,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 17,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 17,
        taxiPathIDs = {
            33,
        },
        travelDuration = 282,
    },
    -- Undercity (map 1458 63.09,48.32) -> Badlands (map 1418 4.06,44.89) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200058,
        toMap = 1418,
        toX = 0.0406,
        toY = 0.4489,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 21,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 21,
        taxiPathIDs = {
            39,
        },
        travelDuration = 470,
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Frostwolf Keep, Alterac Valley (map 1459 49.58,85.69) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 1300002,
        toMap = 1459,
        toX = 0.495797,
        toY = 0.85694,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 60,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 60,
        taxiPathIDs = {
            383,
        },
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Light's Hope Chapel, Eastern Plaguelands (map 1423 70.45,47.59) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200042,
        toMap = 1423,
        toX = 0.704459,
        toY = 0.475904,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 68,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 68,
        taxiPathIDs = {
            357,
        },
        travelDuration = 245,
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Revantusk Village, The Hinterlands (map 1425 81.70,81.89) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200051,
        toMap = 1425,
        toX = 0.817013,
        toY = 0.818932,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 11,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 76,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 11,
        toTaxiNodeID = 76,
        taxiPathIDs = {
            414,
        },
        travelDuration = 267,
    },

    -- Original source zone: Western Plaguelands (map 1422)
    -- Eastern Plaguelands (map 1423 18.45,24.17) -> Eastern Plaguelands (map 1423 47.16,20.31) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1423,
        fromX = 0.1845,
        fromY = 0.2417,
        toPointID = 200040,
        toMap = 1423,
        toX = 0.471604,
        toY = 0.203148,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 84,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 85,
                },
            },
        },
        fromTaxiNodeID = 84,
        toTaxiNodeID = 85,
        taxiPathIDs = {
            494,
            10552,
        },
        travelDuration = 46,
    },
    -- Eastern Plaguelands (map 1423 18.45,24.17) -> Eastern Plaguelands (map 1423 57.80,41.60) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1423,
        fromX = 0.1845,
        fromY = 0.2417,
        toPointID = 200041,
        toMap = 1423,
        toX = 0.577999,
        toY = 0.415966,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 84,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 86,
                },
            },
        },
        fromTaxiNodeID = 84,
        toTaxiNodeID = 86,
        taxiPathIDs = {
            495,
        },
        travelDuration = 59,
    },
    -- Eastern Plaguelands (map 1423 18.45,24.17) -> Eastern Plaguelands (map 1423 32.59,63.98) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1423,
        fromX = 0.1845,
        fromY = 0.2417,
        toPointID = 200037,
        toMap = 1423,
        toX = 0.3259,
        toY = 0.6398,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 84,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 87,
                },
            },
        },
        fromTaxiNodeID = 84,
        toTaxiNodeID = 87,
        taxiPathIDs = {
            496,
        },
        travelDuration = 48,
    },

    -- Original source zone: Westfall (map 1436)
    -- Westfall (map 1436 56.57,52.67) -> Duskwood (map 1431 77.59,44.38) via flighttaxi
    {
        fromPointID = 200091,
        fromMap = 1436,
        fromX = 0.56571,
        fromY = 0.526667,
        toPointID = 200064,
        toMap = 1431,
        toX = 0.7759,
        toY = 0.4438,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 12,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 4,
        toTaxiNodeID = 12,
        taxiPathIDs = {
            250,
        },
        travelDuration = 91,
    },
    -- Sentinel Hill, Westfall (map 1436 56.57,52.67) -> Booty Bay, Stranglethorn (map 1434 27.53,77.67) via flighttaxi
    {
        fromPointID = 200091,
        fromMap = 1436,
        fromX = 0.56571,
        fromY = 0.526667,
        toPointID = 200082,
        toMap = 1434,
        toX = 0.275288,
        toY = 0.776721,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 19,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 4,
        toTaxiNodeID = 19,
        taxiPathIDs = {
            255,
        },
        travelDuration = 174,
    },
    -- Sentinel Hill, Westfall (map 1436 56.57,52.67) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200091,
        fromMap = 1436,
        fromX = 0.56571,
        fromY = 0.526667,
        toPointID = 200101,
        toMap = 1453,
        toX = 0.709765,
        toY = 0.729259,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 2,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 4,
        toTaxiNodeID = 2,
        taxiPathIDs = {
            7,
        },
        travelDuration = 76,
    },
    -- Sentinel Hill, Westfall (map 1436 56.57,52.67) -> Lakeshire, Redridge (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200091,
        fromMap = 1436,
        fromX = 0.56571,
        fromY = 0.526667,
        toPointID = 200078,
        toMap = 1433,
        toX = 0.253428,
        toY = 0.589882,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 4,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 5,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 4,
        toTaxiNodeID = 5,
        taxiPathIDs = {
            249,
        },
        travelDuration = 122,
    },

    -- Original source zone: Wetlands (map 1437)
    -- Menethil Harbor, Wetlands (map 1437 9.52,59.66) -> Southshore, Hillsbrad (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200094,
        fromMap = 1437,
        fromX = 0.095204,
        fromY = 0.596587,
        toPointID = 200045,
        toMap = 1424,
        toX = 0.494421,
        toY = 0.521006,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 14,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 7,
        toTaxiNodeID = 14,
        taxiPathIDs = {
            271,
        },
        travelDuration = 100,
    },
    -- Menethil Harbor, Wetlands (map 1437 9.52,59.66) -> Refuge Pointe, Arathi (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200094,
        fromMap = 1437,
        fromX = 0.095204,
        fromY = 0.596587,
        toPointID = 200007,
        toMap = 1417,
        toX = 0.457901,
        toY = 0.461332,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 16,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 7,
        toTaxiNodeID = 16,
        taxiPathIDs = {
            269,
        },
        travelDuration = 106,
    },
    -- Menethil Harbor, Wetlands (map 1437 9.52,59.66) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200094,
        fromMap = 1437,
        fromX = 0.095204,
        fromY = 0.596587,
        toPointID = 200104,
        toMap = 1455,
        toX = 0.55886,
        toY = 0.478651,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 6,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 7,
        toTaxiNodeID = 6,
        taxiPathIDs = {
            17,
        },
        travelDuration = 83,
    },
    -- Menethil Harbor, Wetlands (map 1437 9.52,59.66) -> Thelsamar, Loch Modan (map 1432 33.94,50.79) via flighttaxi
    {
        fromPointID = 200094,
        fromMap = 1437,
        fromX = 0.095204,
        fromY = 0.596587,
        toPointID = 200074,
        toMap = 1432,
        toX = 0.33943,
        toY = 0.507947,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 7,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 8,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 7,
        toTaxiNodeID = 8,
        taxiPathIDs = {
            266,
        },
        travelDuration = 152,
    },

    -- Original source zone: Winterspring (map 1452)
    -- Everlook, Winterspring (map 1452 60.49,36.34) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100094,
        fromMap = 1452,
        fromX = 0.604853,
        fromY = 0.363438,
        toPointID = 100097,
        toMap = 1454,
        toX = 0.452807,
        toY = 0.637456,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 23,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 53,
        toTaxiNodeID = 23,
        taxiPathIDs = {
            398,
        },
        travelDuration = 285,
    },
    -- Everlook, Winterspring (map 1452 60.49,36.34) -> Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) via flighttaxi
    {
        fromPointID = 100094,
        fromMap = 1452,
        fromX = 0.604853,
        fromY = 0.363438,
        toPointID = 100106,
        toMap = 2482,
        toX = 0.550959,
        toY = 0.825482,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 53,
        toTaxiNodeID = 3242,
        taxiPathIDs = {
            11525,
        },
        travelDuration = 127,
    },
    -- Everlook, Winterspring (map 1452 60.49,36.34) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100094,
        fromMap = 1452,
        fromX = 0.604853,
        fromY = 0.363438,
        toPointID = 100069,
        toMap = 1447,
        toX = 0.219549,
        toY = 0.496901,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 44,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 53,
        toTaxiNodeID = 44,
        taxiPathIDs = {
            499,
        },
        travelDuration = 127,
    },
    -- Everlook, Winterspring (map 1452 60.49,36.34) -> Bloodvenom Post, Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100094,
        fromMap = 1452,
        fromX = 0.604853,
        fromY = 0.363438,
        toPointID = 100073,
        toMap = 1448,
        toX = 0.344154,
        toY = 0.538678,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 48,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 53,
        toTaxiNodeID = 48,
        taxiPathIDs = {
            306,
        },
        travelDuration = 183,
    },
    -- Everlook, Winterspring (map 1452 60.49,36.34) -> Moonglade (map 1450 32.15,66.33) via flighttaxi
    {
        fromPointID = 100094,
        fromMap = 1452,
        fromX = 0.604853,
        fromY = 0.363438,
        toPointID = 100081,
        toMap = 1450,
        toX = 0.3215,
        toY = 0.663346,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 53,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 69,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Horde",
                },
            },
        },
        fromTaxiNodeID = 53,
        toTaxiNodeID = 69,
        taxiPathIDs = {
            363,
        },
        travelDuration = 125,
    },
    -- Everlook, Winterspring (map 1452 62.33,36.64) -> Tainted Foothills, Mount Hyjal (map 2482 55.10,82.55) via flighttaxi
    {
        fromPointID = 100095,
        fromMap = 1452,
        fromX = 0.623348,
        fromY = 0.366358,
        toPointID = 100106,
        toMap = 2482,
        toX = 0.550959,
        toY = 0.825482,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3242,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 52,
        toTaxiNodeID = 3242,
        taxiPathIDs = {
            11530,
        },
        travelDuration = 127,
    },
    -- Everlook, Winterspring (map 1452 62.33,36.64) -> Moonglade (map 1450 47.91,67.11) via flighttaxi
    {
        fromPointID = 100095,
        fromMap = 1452,
        fromX = 0.623348,
        fromY = 0.366358,
        toPointID = 100088,
        toMap = 1450,
        toX = 0.479116,
        toY = 0.671101,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 49,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 52,
        toTaxiNodeID = 49,
        taxiPathIDs = {
            298,
        },
        travelDuration = 114,
    },
    -- Everlook, Winterspring (map 1452 62.33,36.64) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100095,
        fromMap = 1452,
        fromX = 0.623348,
        fromY = 0.366358,
        toPointID = 100068,
        toMap = 1447,
        toX = 0.119025,
        toY = 0.774766,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 64,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 52,
        toTaxiNodeID = 64,
        taxiPathIDs = {
            448,
        },
        travelDuration = 165,
    },
    -- Winterspring (map 1452 62.33,36.64) -> Felwood (map 1448 62.46,24.19) via flighttaxi
    {
        fromPointID = 100095,
        fromMap = 1452,
        fromX = 0.623348,
        fromY = 0.366358,
        toPointID = 100105,
        toMap = 1448,
        toX = 0.6246,
        toY = 0.2419,
        type = "flighttaxi",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 52,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 65,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 52,
        toTaxiNodeID = 65,
        taxiPathIDs = {
            339,
        },
        travelDuration = 115,
    },

    -- Additions from VSS_Skeleton_Camelot.lua (2026-09-28).
    -- Riverglades (map 2548 76.80,52.99) -> Riverglades (map 2548 60.59,81.57) via flighttaxi
    {
        fromPointID = 1300003,
        fromMap = 2548,
        fromX = 0.768,
        fromY = 0.5299,
        toPointID = 200111,
        toMap = 2548,
        toX = 0.605939,
        toY = 0.815701,
        type = "flighttaxi",
        travelDuration = 51,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3275,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3275,
        toTaxiNodeID = 3276,
    },
    -- Riverglades (map 2548 60.59,81.57) -> Riverglades (map 2548 76.80,52.99) via flighttaxi
    {
        fromPointID = 200111,
        fromMap = 2548,
        fromX = 0.605939,
        fromY = 0.815701,
        toPointID = 1300003,
        toMap = 2548,
        toX = 0.768,
        toY = 0.5299,
        type = "flighttaxi",
        travelDuration = 63,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3276,
                },
                {
                    operation = "check",
                    kind = "taxiNodeKnown",
                    value = 3275,
                },
                {
                    operation = "check",
                    kind = "faction",
                    value = "Alliance",
                },
            },
        },
        fromTaxiNodeID = 3276,
        toTaxiNodeID = 3275,
    },
}

Navigation:RegisterPathData("flighttaxi", FLIGHTTAXI)
