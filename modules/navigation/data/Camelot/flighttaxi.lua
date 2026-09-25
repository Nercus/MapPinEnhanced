---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local FLIGHTTAXI = {

    -- Zone: Alterac Mountains (map 1416)
    -- Tarren Mill, Hillsbrad (map 1416 58.69,80.36) -> The Sepulcher, Silverpine Forest (map 1421 45.56,42.42) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1416,
        fromX = 0.586873,
        fromY = 0.803604,
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
    },
    -- Tarren Mill, Hillsbrad (map 1416 58.69,80.36) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1416,
        fromX = 0.586873,
        fromY = 0.803604,
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
    },
    -- Tarren Mill, Hillsbrad (map 1416 58.69,80.36) -> Hammerfall, Arathi (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1416,
        fromX = 0.586873,
        fromY = 0.803604,
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
    },
    -- Tarren Mill, Hillsbrad (map 1416 58.69,80.36) -> Revantusk Village, The Hinterlands (map 1425 81.70,81.89) via flighttaxi
    {
        fromPointID = 200001,
        fromMap = 1416,
        fromX = 0.586873,
        fromY = 0.803604,
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
    },
    -- Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) -> Southshore, Hillsbrad (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1416,
        fromX = 0.790515,
        fromY = 0.30465,
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
    },
    -- Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) -> Aerie Peak, The Hinterlands (map 1416 99.50,65.16) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1416,
        fromX = 0.790515,
        fromY = 0.30465,
        toPointID = 200004,
        toMap = 1416,
        toX = 0.995033,
        toY = 0.651568,
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
    },
    -- Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) -> Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1416,
        fromX = 0.790515,
        fromY = 0.30465,
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
    },
    -- Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200002,
        fromMap = 1416,
        fromX = 0.790515,
        fromY = 0.30465,
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
    },
    -- Aerie Peak, The Hinterlands (map 1416 99.50,65.16) -> Southshore, Hillsbrad (map 1424 49.44,52.10) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1416,
        fromX = 0.995033,
        fromY = 0.651568,
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
    },
    -- Aerie Peak, The Hinterlands (map 1416 99.50,65.16) -> Refuge Pointe, Arathi (map 1417 45.79,46.13) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1416,
        fromX = 0.995033,
        fromY = 0.651568,
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
    },
    -- Aerie Peak, The Hinterlands (map 1416 99.50,65.16) -> Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1416,
        fromX = 0.995033,
        fromY = 0.651568,
        toPointID = 200002,
        toMap = 1416,
        toX = 0.790515,
        toY = 0.30465,
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
    },
    -- Aerie Peak, The Hinterlands (map 1416 99.50,65.16) -> Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1416,
        fromX = 0.995033,
        fromY = 0.651568,
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
    },
    -- Aerie Peak, The Hinterlands (map 1416 99.50,65.16) -> Ironforge, Dun Morogh (map 1455 55.89,47.87) via flighttaxi
    {
        fromPointID = 200004,
        fromMap = 1416,
        fromX = 0.995033,
        fromY = 0.651568,
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
    },

    -- Zone: Alterac Valley (map 1459)
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

    -- Zone: Arathi Highlands (map 1417)
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
    },
    -- Refuge Pointe, Arathi (map 1417 45.79,46.13) -> Aerie Peak, The Hinterlands (map 1416 99.50,65.16) via flighttaxi
    {
        fromPointID = 200007,
        fromMap = 1417,
        fromX = 0.457901,
        fromY = 0.461332,
        toPointID = 200004,
        toMap = 1416,
        toX = 0.995033,
        toY = 0.651568,
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
    },
    -- Hammerfall, Arathi (map 1417 73.06,32.62) -> Tarren Mill, Hillsbrad (map 1416 58.69,80.36) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200001,
        toMap = 1416,
        toX = 0.586873,
        toY = 0.803604,
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
    },
    -- Hammerfall, Arathi (map 1417 73.06,32.62) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200008,
        fromMap = 1417,
        fromX = 0.730618,
        fromY = 0.326232,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },

    -- Zone: Ashenvale (map 1440)
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
    },
    -- Splintertree Post, Ashenvale (map 1440 73.26,61.67) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Splintertree Post, Ashenvale (map 1440 73.26,61.67) -> Zoram'gar Outpost, Ashenvale (map 1448 11.21,98.05) via flighttaxi
    {
        fromPointID = 100039,
        fromMap = 1440,
        fromX = 0.732581,
        fromY = 0.616722,
        toPointID = 100071,
        toMap = 1448,
        toX = 0.112121,
        toY = 0.98051,
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
    },

    -- Zone: Azshara (map 1447)
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Astranaar, Ashenvale (map 1442 72.39,2.74) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100048,
        toMap = 1442,
        toX = 0.723906,
        toY = 0.027432,
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
    },
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Talonbranch Glade, Felwood (map 2482 29.56,4.25) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100105,
        toMap = 2482,
        toX = 0.295634,
        toY = 0.042464,
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
    },
    -- Talrendis Point, Azshara (map 1447 11.90,77.48) -> Ratchet, The Barrens (map 1411 34.24,76.68) via flighttaxi
    {
        fromPointID = 100068,
        fromMap = 1447,
        fromX = 0.119025,
        fromY = 0.774766,
        toPointID = 100002,
        toMap = 1411,
        toX = 0.342413,
        toY = 0.766787,
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
    },
    -- Valormok, Azshara (map 1447 21.95,49.69) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100069,
        fromMap = 1447,
        fromX = 0.219549,
        fromY = 0.496901,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },

    -- Zone: Burning Steppes (map 1428)
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
    },
    -- Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) -> Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) via flighttaxi
    {
        fromPointID = 200061,
        fromMap = 1428,
        fromX = 0.843818,
        fromY = 0.683045,
        toPointID = 200090,
        toMap = 1435,
        toX = 0.528751,
        toY = 0.975313,
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
    },

    -- Zone: Deadwind Pass (map 1430)
    -- Darkshire, Duskwood (map 1430 17.13,38.93) -> Booty Bay, Stranglethorn (map 1434 27.53,77.67) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1430,
        fromX = 0.171327,
        fromY = 0.389276,
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
    },
    -- Darkshire, Duskwood (map 1430 17.13,38.93) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1430,
        fromX = 0.171327,
        fromY = 0.389276,
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
    },
    -- Darkshire, Duskwood (map 1430 17.13,38.93) -> Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1430,
        fromX = 0.171327,
        fromY = 0.389276,
        toPointID = 200090,
        toMap = 1435,
        toX = 0.528751,
        toY = 0.975313,
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
    },
    -- Darkshire, Duskwood (map 1430 17.13,38.93) -> Sentinel Hill, Westfall (map 1436 56.57,52.67) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1430,
        fromX = 0.171327,
        fromY = 0.389276,
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
    },
    -- Darkshire, Duskwood (map 1430 17.13,38.93) -> Lakeshire, Redridge (map 1433 25.34,58.99) via flighttaxi
    {
        fromPointID = 200064,
        fromMap = 1430,
        fromX = 0.171327,
        fromY = 0.389276,
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
    },

    -- Zone: Desolace (map 1443)
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
    },
    -- Nijel's Point, Desolace (map 1443 64.67,10.44) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100054,
        fromMap = 1443,
        fromX = 0.646713,
        fromY = 0.104354,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },

    -- Zone: Durotar (map 1411)
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Orgrimmar, Durotar (map 1454 45.28,63.75) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Freewind Post, Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Gadgetzan, Tanaris (map 1446 51.62,25.52) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Camp Mojache, Feralas (map 1444 75.43,44.31) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Valormok, Azshara (map 1447 21.95,49.69) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Bloodvenom Post, Felwood (map 1448 34.42,53.87) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Zoram'gar Outpost, Ashenvale (map 1448 11.21,98.05) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
        toPointID = 100071,
        toMap = 1448,
        toX = 0.112121,
        toY = 0.98051,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Splintertree Post, Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Camp Taurajo, The Barrens (map 1445 17.29,9.92) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
        toPointID = 100058,
        toMap = 1445,
        toX = 0.17289,
        toY = 0.099239,
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
    },
    -- Crossroads, The Barrens (map 1411 11.98,63.83) -> Ratchet, The Barrens (map 1411 34.24,76.68) via flighttaxi
    {
        fromPointID = 100001,
        fromMap = 1411,
        fromX = 0.119826,
        fromY = 0.638336,
        toPointID = 100002,
        toMap = 1411,
        toX = 0.342413,
        toY = 0.766787,
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
    },
    -- Ratchet, The Barrens (map 1411 34.24,76.68) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1411,
        fromX = 0.342413,
        fromY = 0.766787,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Ratchet, The Barrens (map 1411 34.24,76.68) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1411,
        fromX = 0.342413,
        fromY = 0.766787,
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
    },
    -- Ratchet, The Barrens (map 1411 34.24,76.68) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100002,
        fromMap = 1411,
        fromX = 0.342413,
        fromY = 0.766787,
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
    },

    -- Zone: Dustwallow Marsh (map 1445)
    -- Camp Taurajo, The Barrens (map 1445 17.29,9.92) -> Thunder Bluff, Mulgore (map 1456 46.65,49.90) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1445,
        fromX = 0.17289,
        fromY = 0.099239,
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
    },
    -- Camp Taurajo, The Barrens (map 1445 17.29,9.92) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1445,
        fromX = 0.17289,
        fromY = 0.099239,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Camp Taurajo, The Barrens (map 1445 17.29,9.92) -> Freewind Post, Thousand Needles (map 1441 45.02,49.13) via flighttaxi
    {
        fromPointID = 100058,
        fromMap = 1445,
        fromX = 0.17289,
        fromY = 0.099239,
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
    },
    -- Brackenwall Village, Dustwallow Marsh (map 1445 35.57,31.83) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100060,
        fromMap = 1445,
        fromX = 0.355653,
        fromY = 0.318302,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Thalanaar, Feralas (map 1441 7.79,17.90) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100041,
        toMap = 1441,
        toX = 0.077854,
        toY = 0.17905,
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
    },
    -- Theramore, Dustwallow Marsh (map 1445 67.46,51.20) -> Ratchet, The Barrens (map 1411 34.24,76.68) via flighttaxi
    {
        fromPointID = 100061,
        fromMap = 1445,
        fromX = 0.674587,
        fromY = 0.512011,
        toPointID = 100002,
        toMap = 1411,
        toX = 0.342413,
        toY = 0.766787,
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
    },

    -- Zone: Eastern Plaguelands (map 1423)
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
    },
    -- Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) -> Aerie Peak, The Hinterlands (map 1416 99.50,65.16) via flighttaxi
    {
        fromPointID = 200043,
        fromMap = 1423,
        fromX = 0.71699,
        fromY = 0.49555,
        toPointID = 200004,
        toMap = 1416,
        toX = 0.995033,
        toY = 0.651568,
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
    },
    -- Light's Hope Chapel, Eastern Plaguelands (map 1423 71.70,49.55) -> Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) via flighttaxi
    {
        fromPointID = 200043,
        fromMap = 1423,
        fromX = 0.71699,
        fromY = 0.49555,
        toPointID = 200002,
        toMap = 1416,
        toX = 0.790515,
        toY = 0.30465,
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
    },

    -- Zone: Felwood (map 1448)
    -- Zoram'gar Outpost, Ashenvale (map 1448 11.21,98.05) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100071,
        fromMap = 1448,
        fromX = 0.112121,
        fromY = 0.98051,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Zoram'gar Outpost, Ashenvale (map 1448 11.21,98.05) -> Splintertree Post, Ashenvale (map 1440 73.26,61.67) via flighttaxi
    {
        fromPointID = 100071,
        fromMap = 1448,
        fromX = 0.112121,
        fromY = 0.98051,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Rut'theran Village, Teldrassil (map 1438 58.40,93.93) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Astranaar, Ashenvale (map 1442 72.39,2.74) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
        toPointID = 100048,
        toMap = 1442,
        toX = 0.723906,
        toY = 0.027432,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Nijel's Point, Desolace (map 1443 64.67,10.44) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Feathermoon, Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Moonglade (map 1450 47.91,67.11) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
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
    },
    -- Auberdine, Darkshore (map 1448 18.85,20.66) -> Talonbranch Glade, Felwood (map 2482 29.56,4.25) via flighttaxi
    {
        fromPointID = 100072,
        fromMap = 1448,
        fromX = 0.188519,
        fromY = 0.206596,
        toPointID = 100105,
        toMap = 2482,
        toX = 0.295634,
        toY = 0.042464,
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
    },
    -- Bloodvenom Post, Felwood (map 1448 34.42,53.87) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100073,
        fromMap = 1448,
        fromX = 0.344154,
        fromY = 0.538678,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },

    -- Zone: Feralas (map 1444)
    -- Feathermoon, Feralas (map 1444 30.26,43.32) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Feathermoon, Feralas (map 1444 30.26,43.32) -> Thalanaar, Feralas (map 1441 7.79,17.90) via flighttaxi
    {
        fromPointID = 100055,
        fromMap = 1444,
        fromX = 0.302592,
        fromY = 0.433194,
        toPointID = 100041,
        toMap = 1441,
        toX = 0.077854,
        toY = 0.17905,
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
    },
    -- Camp Mojache, Feralas (map 1444 75.43,44.31) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100057,
        fromMap = 1444,
        fromX = 0.754296,
        fromY = 0.443135,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },

    -- Zone: Hillsbrad Foothills (map 1424)
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
    },
    -- Southshore, Hillsbrad (map 1424 49.44,52.10) -> Aerie Peak, The Hinterlands (map 1416 99.50,65.16) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200004,
        toMap = 1416,
        toX = 0.995033,
        toY = 0.651568,
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
    },
    -- Southshore, Hillsbrad (map 1424 49.44,52.10) -> Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) via flighttaxi
    {
        fromPointID = 200045,
        fromMap = 1424,
        fromX = 0.494421,
        fromY = 0.521006,
        toPointID = 200002,
        toMap = 1416,
        toX = 0.790515,
        toY = 0.30465,
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
    },

    -- Zone: Ironforge (map 1455)
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
    },
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Aerie Peak, The Hinterlands (map 1416 99.50,65.16) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200004,
        toMap = 1416,
        toX = 0.995033,
        toY = 0.651568,
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
    -- Ironforge, Dun Morogh (map 1455 55.89,47.87) -> Chillwind Camp, Western Plaguelands (map 1416 79.05,30.46) via flighttaxi
    {
        fromPointID = 200104,
        fromMap = 1455,
        fromX = 0.55886,
        fromY = 0.478651,
        toPointID = 200002,
        toMap = 1416,
        toX = 0.790515,
        toY = 0.30465,
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
    },

    -- Zone: Loch Modan (map 1432)
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
    },

    -- Zone: Moonglade (map 1450)
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
    },
    -- Moonglade (map 1450 47.91,67.11) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100088,
        fromMap = 1450,
        fromX = 0.479116,
        fromY = 0.671101,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Moonglade (map 1450 47.91,67.11) -> Talonbranch Glade, Felwood (map 2482 29.56,4.25) via flighttaxi
    {
        fromPointID = 100088,
        fromMap = 1450,
        fromX = 0.479116,
        fromY = 0.671101,
        toPointID = 100105,
        toMap = 2482,
        toX = 0.295634,
        toY = 0.042464,
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
    },

    -- Zone: Mount Hyjal (map 2482)
    -- Talonbranch Glade, Felwood (map 2482 29.56,4.25) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 2482,
        fromX = 0.295634,
        fromY = 0.042464,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Talonbranch Glade, Felwood (map 2482 29.56,4.25) -> Moonglade (map 1450 47.91,67.11) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 2482,
        fromX = 0.295634,
        fromY = 0.042464,
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
    },
    -- Talonbranch Glade, Felwood (map 2482 29.56,4.25) -> Everlook, Winterspring (map 1452 62.33,36.64) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 2482,
        fromX = 0.295634,
        fromY = 0.042464,
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
    },
    -- Talonbranch Glade, Felwood (map 2482 29.56,4.25) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100105,
        fromMap = 2482,
        fromX = 0.295634,
        fromY = 0.042464,
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
    },

    -- Zone: Orgrimmar (map 1454)
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
    },
    -- Orgrimmar, Durotar (map 1454 45.28,63.75) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100097,
        fromMap = 1454,
        fromX = 0.452807,
        fromY = 0.637456,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },

    -- Zone: Redridge Mountains (map 1433)
    -- Lakeshire, Redridge (map 1433 25.34,58.99) -> Darkshire, Duskwood (map 1430 17.13,38.93) via flighttaxi
    {
        fromPointID = 200078,
        fromMap = 1433,
        fromX = 0.253428,
        fromY = 0.589882,
        toPointID = 200064,
        toMap = 1430,
        toX = 0.171327,
        toY = 0.389276,
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
    },

    -- Zone: Riverglades (map 2548)
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
    },
    -- Rog'mar, Riverglades (map 2548 59.61,45.06) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },
    -- Rog'mar, Riverglades (map 2548 59.61,45.06) -> Flame Crest, Burning Steppes (map 1427 83.57,94.39) via flighttaxi
    {
        fromPointID = 200110,
        fromMap = 2548,
        fromX = 0.596143,
        fromY = 0.450641,
        toPointID = 200059,
        toMap = 1427,
        toX = 0.835686,
        toY = 0.943886,
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
    },

    -- Zone: Searing Gorge (map 1427)
    -- Thorium Point, Searing Gorge (map 1427 34.83,30.58) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200055,
        fromMap = 1427,
        fromX = 0.348295,
        fromY = 0.305836,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },
    -- Thorium Point, Searing Gorge (map 1427 34.83,30.58) -> Flame Crest, Burning Steppes (map 1427 83.57,94.39) via flighttaxi
    {
        fromPointID = 200055,
        fromMap = 1427,
        fromX = 0.348295,
        fromY = 0.305836,
        toPointID = 200059,
        toMap = 1427,
        toX = 0.835686,
        toY = 0.943886,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Undercity, Tirisfal (map 1458 63.09,48.32) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Hammerfall, Arathi (map 1417 73.06,32.62) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Booty Bay, Stranglethorn (map 1434 26.82,77.00) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Grom'gol, Stranglethorn (map 1434 32.51,29.28) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Rog'mar, Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Stonard, Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Flame Crest, Burning Steppes (map 1427 83.57,94.39) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
        toPointID = 200059,
        toMap = 1427,
        toX = 0.835686,
        toY = 0.943886,
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
    },
    -- Kargath, Badlands (map 1427 83.23,35.90) -> Thorium Point, Searing Gorge (map 1427 34.83,30.58) via flighttaxi
    {
        fromPointID = 200058,
        fromMap = 1427,
        fromX = 0.832329,
        fromY = 0.358985,
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
    },
    -- Flame Crest, Burning Steppes (map 1427 83.57,94.39) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1427,
        fromX = 0.835686,
        fromY = 0.943886,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },
    -- Flame Crest, Burning Steppes (map 1427 83.57,94.39) -> Rog'mar, Riverglades (map 2548 59.61,45.06) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1427,
        fromX = 0.835686,
        fromY = 0.943886,
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
    },
    -- Flame Crest, Burning Steppes (map 1427 83.57,94.39) -> Stonard, Swamp of Sorrows (map 1435 46.05,54.68) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1427,
        fromX = 0.835686,
        fromY = 0.943886,
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
    },
    -- Flame Crest, Burning Steppes (map 1427 83.57,94.39) -> Thorium Point, Searing Gorge (map 1427 34.83,30.58) via flighttaxi
    {
        fromPointID = 200059,
        fromMap = 1427,
        fromX = 0.835686,
        fromY = 0.943886,
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
    },

    -- Zone: Silithus (map 1451)
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
    },

    -- Zone: Silverpine Forest (map 1421)
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
    },
    -- The Sepulcher, Silverpine Forest (map 1421 45.56,42.42) -> Tarren Mill, Hillsbrad (map 1416 58.69,80.36) via flighttaxi
    {
        fromPointID = 200025,
        fromMap = 1421,
        fromX = 0.455574,
        fromY = 0.424217,
        toPointID = 200001,
        toMap = 1416,
        toX = 0.586873,
        toY = 0.803604,
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
    },

    -- Zone: Stonetalon Mountains (map 1442)
    -- Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100046,
        fromMap = 1442,
        fromX = 0.365356,
        fromY = 0.072334,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) -> Astranaar, Ashenvale (map 1442 72.39,2.74) via flighttaxi
    {
        fromPointID = 100046,
        fromMap = 1442,
        fromX = 0.365356,
        fromY = 0.072334,
        toPointID = 100048,
        toMap = 1442,
        toX = 0.723906,
        toY = 0.027432,
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
    },
    -- Sun Rock Retreat, Stonetalon Mountains (map 1442 45.16,59.89) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100047,
        fromMap = 1442,
        fromX = 0.451641,
        fromY = 0.598878,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Astranaar, Ashenvale (map 1442 72.39,2.74) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1442,
        fromX = 0.723906,
        fromY = 0.027432,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },
    -- Astranaar, Ashenvale (map 1442 72.39,2.74) -> Stonetalon Peak, Stonetalon Mountains (map 1442 36.54,7.23) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1442,
        fromX = 0.723906,
        fromY = 0.027432,
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
    },
    -- Astranaar, Ashenvale (map 1442 72.39,2.74) -> Talrendis Point, Azshara (map 1447 11.90,77.48) via flighttaxi
    {
        fromPointID = 100048,
        fromMap = 1442,
        fromX = 0.723906,
        fromY = 0.027432,
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
    },

    -- Zone: Stormwind City (map 1453)
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Darkshire, Duskwood (map 1430 17.13,38.93) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200064,
        toMap = 1430,
        toX = 0.171327,
        toY = 0.389276,
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
    },
    -- Stormwind, Elwynn (map 1453 70.98,72.93) -> Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) via flighttaxi
    {
        fromPointID = 200101,
        fromMap = 1453,
        fromX = 0.709765,
        fromY = 0.729259,
        toPointID = 200090,
        toMap = 1435,
        toX = 0.528751,
        toY = 0.975313,
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
    },

    -- Zone: Stranglethorn Vale (map 1434)
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
    },
    -- Booty Bay, Stranglethorn (map 1434 26.82,77.00) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200081,
        fromMap = 1434,
        fromX = 0.268163,
        fromY = 0.769961,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },
    -- Booty Bay, Stranglethorn (map 1434 27.53,77.67) -> Darkshire, Duskwood (map 1430 17.13,38.93) via flighttaxi
    {
        fromPointID = 200082,
        fromMap = 1434,
        fromX = 0.275288,
        fromY = 0.776721,
        toPointID = 200064,
        toMap = 1430,
        toX = 0.171327,
        toY = 0.389276,
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
    },
    -- Grom'gol, Stranglethorn (map 1434 32.51,29.28) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200085,
        fromMap = 1434,
        fromX = 0.3251,
        fromY = 0.292755,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },

    -- Zone: Swamp of Sorrows (map 1435)
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
    },
    -- Stonard, Swamp of Sorrows (map 1435 46.05,54.68) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },
    -- Stonard, Swamp of Sorrows (map 1435 46.05,54.68) -> Flame Crest, Burning Steppes (map 1427 83.57,94.39) via flighttaxi
    {
        fromPointID = 200089,
        fromMap = 1435,
        fromX = 0.460527,
        fromY = 0.546792,
        toPointID = 200059,
        toMap = 1427,
        toX = 0.835686,
        toY = 0.943886,
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
    },
    -- Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) -> Darkshire, Duskwood (map 1430 17.13,38.93) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1435,
        fromX = 0.528751,
        fromY = 0.975313,
        toPointID = 200064,
        toMap = 1430,
        toX = 0.171327,
        toY = 0.389276,
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
    },
    -- Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) -> Stormwind, Elwynn (map 1453 70.98,72.93) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1435,
        fromX = 0.528751,
        fromY = 0.975313,
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
    },
    -- Nethergarde Keep, Blasted Lands (map 1435 52.88,97.53) -> Morgan's Vigil, Burning Steppes (map 1428 84.38,68.30) via flighttaxi
    {
        fromPointID = 200090,
        fromMap = 1435,
        fromX = 0.528751,
        fromY = 0.975313,
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
    },

    -- Zone: Tanaris (map 1446)
    -- Gadgetzan, Tanaris (map 1446 50.95,29.33) -> Thalanaar, Feralas (map 1441 7.79,17.90) via flighttaxi
    {
        fromPointID = 100065,
        fromMap = 1446,
        fromX = 0.509542,
        fromY = 0.293254,
        toPointID = 100041,
        toMap = 1441,
        toX = 0.077854,
        toY = 0.17905,
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
    },
    -- Gadgetzan, Tanaris (map 1446 51.62,25.52) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100066,
        fromMap = 1446,
        fromX = 0.516175,
        fromY = 0.255194,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },

    -- Zone: Teldrassil (map 1438)
    -- Rut'theran Village, Teldrassil (map 1438 58.40,93.93) -> Auberdine, Darkshore (map 1448 18.85,20.66) via flighttaxi
    {
        fromPointID = 100028,
        fromMap = 1438,
        fromX = 0.584,
        fromY = 0.939274,
        toPointID = 100072,
        toMap = 1448,
        toX = 0.188519,
        toY = 0.206596,
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
    },

    -- Zone: The Hinterlands (map 1425)
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
    },
    -- Revantusk Village, The Hinterlands (map 1425 81.70,81.89) -> Tarren Mill, Hillsbrad (map 1416 58.69,80.36) via flighttaxi
    {
        fromPointID = 200051,
        fromMap = 1425,
        fromX = 0.817013,
        fromY = 0.818932,
        toPointID = 200001,
        toMap = 1416,
        toX = 0.586873,
        toY = 0.803604,
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
    },

    -- Zone: Thousand Needles (map 1441)
    -- Thalanaar, Feralas (map 1441 7.79,17.90) -> Theramore, Dustwallow Marsh (map 1445 67.46,51.20) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1441,
        fromX = 0.077854,
        fromY = 0.17905,
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
    },
    -- Thalanaar, Feralas (map 1441 7.79,17.90) -> Gadgetzan, Tanaris (map 1446 50.95,29.33) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1441,
        fromX = 0.077854,
        fromY = 0.17905,
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
    },
    -- Thalanaar, Feralas (map 1441 7.79,17.90) -> Feathermoon, Feralas (map 1444 30.26,43.32) via flighttaxi
    {
        fromPointID = 100041,
        fromMap = 1441,
        fromX = 0.077854,
        fromY = 0.17905,
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
    },
    -- Freewind Post, Thousand Needles (map 1441 45.02,49.13) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Freewind Post, Thousand Needles (map 1441 45.02,49.13) -> Camp Taurajo, The Barrens (map 1445 17.29,9.92) via flighttaxi
    {
        fromPointID = 100043,
        fromMap = 1441,
        fromX = 0.45022,
        fromY = 0.491265,
        toPointID = 100058,
        toMap = 1445,
        toX = 0.17289,
        toY = 0.099239,
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
    },

    -- Zone: Thunder Bluff (map 1456)
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
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Crossroads, The Barrens (map 1411 11.98,63.83) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100001,
        toMap = 1411,
        toX = 0.119826,
        toY = 0.638336,
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
    },
    -- Thunder Bluff, Mulgore (map 1456 46.65,49.90) -> Camp Taurajo, The Barrens (map 1445 17.29,9.92) via flighttaxi
    {
        fromPointID = 100100,
        fromMap = 1456,
        fromX = 0.466545,
        fromY = 0.498984,
        toPointID = 100058,
        toMap = 1445,
        toX = 0.17289,
        toY = 0.099239,
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
    },

    -- Zone: Un'Goro Crater (map 1449)
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
    },

    -- Zone: Undercity (map 1458)
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
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Tarren Mill, Hillsbrad (map 1416 58.69,80.36) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200001,
        toMap = 1416,
        toX = 0.586873,
        toY = 0.803604,
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
    },
    -- Undercity, Tirisfal (map 1458 63.09,48.32) -> Kargath, Badlands (map 1427 83.23,35.90) via flighttaxi
    {
        fromPointID = 200107,
        fromMap = 1458,
        fromX = 0.630851,
        fromY = 0.483242,
        toPointID = 200058,
        toMap = 1427,
        toX = 0.832329,
        toY = 0.358985,
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
    },

    -- Zone: Western Plaguelands (map 1422)
    -- Plaguewood Tower, Eastern Plaguelands (map 1422 80.62,12.84) -> Northpass Tower, Eastern Plaguelands (map 1423 47.16,20.31) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1422,
        fromX = 0.806225,
        fromY = 0.128357,
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
    },
    -- Plaguewood Tower, Eastern Plaguelands (map 1422 80.62,12.84) -> Eastwall Tower, Eastern Plaguelands (map 1423 57.80,41.60) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1422,
        fromX = 0.806225,
        fromY = 0.128357,
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
    },
    -- Plaguewood Tower, Eastern Plaguelands (map 1422 80.62,12.84) -> Crown Guard Tower, Eastern Plaguelands (map 1422 94.77,52.64) via flighttaxi
    {
        fromPointID = 200036,
        fromMap = 1422,
        fromX = 0.806225,
        fromY = 0.128357,
        toPointID = 200037,
        toMap = 1422,
        toX = 0.947706,
        toY = 0.526433,
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
    },

    -- Zone: Westfall (map 1436)
    -- Sentinel Hill, Westfall (map 1436 56.57,52.67) -> Darkshire, Duskwood (map 1430 17.13,38.93) via flighttaxi
    {
        fromPointID = 200091,
        fromMap = 1436,
        fromX = 0.56571,
        fromY = 0.526667,
        toPointID = 200064,
        toMap = 1430,
        toX = 0.171327,
        toY = 0.389276,
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
    },

    -- Zone: Wetlands (map 1437)
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
    },

    -- Zone: Winterspring (map 1452)
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
    },
    -- Everlook, Winterspring (map 1452 62.33,36.64) -> Talonbranch Glade, Felwood (map 2482 29.56,4.25) via flighttaxi
    {
        fromPointID = 100095,
        fromMap = 1452,
        fromX = 0.623348,
        fromY = 0.366358,
        toPointID = 100105,
        toMap = 2482,
        toX = 0.295634,
        toY = 0.042464,
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
    },
}

Navigation:RegisterPathData("flighttaxi", FLIGHTTAXI)
