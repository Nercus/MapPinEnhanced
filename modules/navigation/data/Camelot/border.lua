---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local BORDER = {

    -- Zone: Alterac Mountains (map 1416)
    -- Alterac Mountains (map 1416 79.91,42.63) -> Western Plaguelands (map 1422 44.04,86.38) via border
    {
        fromPointID = 200003,
        fromMap = 1416,
        fromX = 0.7991,
        fromY = 0.4263,
        toPointID = 200032,
        toMap = 1422,
        toX = 0.4404,
        toY = 0.8638,
        type = "border",
    },

    -- Zone: Arathi Highlands (map 1417)
    -- Arathi Highlands (map 1417 20.36,29.78) -> Hillsbrad Foothills (map 1424 82.16,57.08) via border
    {
        fromPointID = 200005,
        fromMap = 1417,
        fromX = 0.2036,
        fromY = 0.2978,
        toPointID = 200047,
        toMap = 1424,
        toX = 0.8216,
        toY = 0.5708,
        type = "border",
    },
    -- Arathi Highlands (map 1417 45.46,89.18) -> Wetlands (map 1437 51.08,11.70) via border
    {
        fromPointID = 200006,
        fromMap = 1417,
        fromX = 0.4546,
        fromY = 0.8918,
        toPointID = 200095,
        toMap = 1437,
        toX = 0.5108,
        toY = 0.117,
        type = "border",
    },

    -- Zone: Ashenvale (map 1440)
    -- Ashenvale (map 1440 19.02,18.30) -> Darkshore (map 1439 37.55,96.26) via border
    {
        fromPointID = 100034,
        fromMap = 1440,
        fromX = 0.1902,
        fromY = 0.183,
        toPointID = 100032,
        toMap = 1439,
        toX = 0.3755,
        toY = 0.9626,
        type = "border",
    },
    -- Ashenvale (map 1440 29.19,15.00) -> Darkshore (map 1439 43.12,93.63) via border
    {
        fromPointID = 100035,
        fromMap = 1440,
        fromX = 0.2919,
        fromY = 0.15,
        toPointID = 100033,
        toMap = 1439,
        toX = 0.4312,
        toY = 0.9363,
        type = "border",
    },
    -- Ashenvale (map 1440 42.29,71.06) -> Stonetalon Mountains (map 1442 78.23,42.70) via border
    {
        fromPointID = 100036,
        fromMap = 1440,
        fromX = 0.4229,
        fromY = 0.7106,
        toPointID = 100049,
        toMap = 1442,
        toX = 0.7823,
        toY = 0.427,
        type = "border",
    },
    -- Ashenvale (map 1440 55.75,29.28) -> Felwood (map 1448 54.82,91.17) via border
    {
        fromPointID = 100037,
        fromMap = 1440,
        fromX = 0.5575,
        fromY = 0.2928,
        toPointID = 100074,
        toMap = 1448,
        toX = 0.5482,
        toY = 0.9117,
        type = "border",
    },
    -- Ashenvale (map 1440 68.62,86.48) -> The Barrens (map 1413 48.16,4.32) via border
    {
        fromPointID = 100038,
        fromMap = 1440,
        fromX = 0.6862,
        fromY = 0.8648,
        toPointID = 100017,
        toMap = 1413,
        toX = 0.4816,
        toY = 0.0432,
        type = "border",
    },
    -- Ashenvale (map 1440 94.74,47.77) -> Azshara (map 1447 10.56,75.09) via border
    {
        fromPointID = 100040,
        fromMap = 1440,
        fromX = 0.9474,
        fromY = 0.4777,
        toPointID = 100067,
        toMap = 1447,
        toX = 0.1056,
        toY = 0.7509,
        type = "border",
    },

    -- Zone: Azshara (map 1447)
    -- Azshara (map 1447 10.56,75.09) -> Ashenvale (map 1440 94.74,47.77) via border
    {
        fromPointID = 100067,
        fromMap = 1447,
        fromX = 0.1056,
        fromY = 0.7509,
        toPointID = 100040,
        toMap = 1440,
        toX = 0.9474,
        toY = 0.4777,
        type = "border",
    },

    -- Zone: Badlands (map 1418)
    -- Badlands (map 1418 4.18,61.56) -> Searing Gorge (map 1427 69.54,54.29) via border
    {
        fromPointID = 200009,
        fromMap = 1418,
        fromX = 0.0418,
        fromY = 0.6156,
        toPointID = 200057,
        toMap = 1427,
        toX = 0.6954,
        toY = 0.5429,
        type = "border",
    },
    -- Badlands (map 1418 49.25,7.42) -> Loch Modan (map 1432 46.83,77.75) via border
    {
        fromPointID = 200016,
        fromMap = 1418,
        fromX = 0.4925,
        fromY = 0.0742,
        toPointID = 200075,
        toMap = 1432,
        toX = 0.4683,
        toY = 0.7775,
        type = "border",
    },

    -- Zone: Blasted Lands (map 1419)
    -- Blasted Lands (map 1419 52.01,7.81) -> Swamp of Sorrows (map 1435 35.64,62.07) via border
    {
        fromPointID = 200017,
        fromMap = 1419,
        fromX = 0.5201,
        fromY = 0.0781,
        toPointID = 200088,
        toMap = 1435,
        toX = 0.3564,
        toY = 0.6207,
        type = "border",
    },

    -- Zone: Burning Steppes (map 1428)
    -- Burning Steppes (map 1428 78.31,77.57) -> Redridge Mountains (map 1433 47.04,24.72) via border
    {
        fromPointID = 200060,
        fromMap = 1428,
        fromX = 0.7831,
        fromY = 0.7757,
        toPointID = 200079,
        toMap = 1433,
        toX = 0.4704,
        toY = 0.2472,
        type = "border",
    },

    -- Zone: Darkshore (map 1439)
    -- Darkshore (map 1439 37.55,96.26) -> Ashenvale (map 1440 19.02,18.30) via border
    {
        fromPointID = 100032,
        fromMap = 1439,
        fromX = 0.3755,
        fromY = 0.9626,
        toPointID = 100034,
        toMap = 1440,
        toX = 0.1902,
        toY = 0.183,
        type = "border",
    },
    -- Darkshore (map 1439 43.12,93.63) -> Ashenvale (map 1440 29.19,15.00) via border
    {
        fromPointID = 100033,
        fromMap = 1439,
        fromX = 0.4312,
        fromY = 0.9363,
        toPointID = 100035,
        toMap = 1440,
        toX = 0.2919,
        toY = 0.15,
        type = "border",
    },

    -- Zone: Darnassus (map 1457)
    -- Darnassus (map 1457 86.26,35.56) -> Teldrassil (map 1438 36.16,54.39) via border
    {
        fromPointID = 100104,
        fromMap = 1457,
        fromX = 0.8626,
        fromY = 0.3556,
        toPointID = 100024,
        toMap = 1438,
        toX = 0.3616,
        toY = 0.5439,
        type = "border",
    },

    -- Zone: Deadwind Pass (map 1430)
    -- Deadwind Pass (map 1430 35.65,35.60) -> Duskwood (map 1431 88.61,41.02) via border
    {
        fromPointID = 200065,
        fromMap = 1430,
        fromX = 0.3565,
        fromY = 0.356,
        toPointID = 200069,
        toMap = 1431,
        toX = 0.8861,
        toY = 0.4102,
        type = "border",
    },
    -- Deadwind Pass (map 1430 59.11,41.16) -> Swamp of Sorrows (map 1435 10.37,50.22) via border
    {
        fromPointID = 200067,
        fromMap = 1430,
        fromX = 0.5911,
        fromY = 0.4116,
        toPointID = 200087,
        toMap = 1435,
        toX = 0.1037,
        toY = 0.5022,
        type = "border",
    },

    -- Zone: Desolace (map 1443)
    -- Desolace (map 1443 40.93,90.68) -> Feralas (map 1444 45.55,3.09) via border
    {
        fromPointID = 100052,
        fromMap = 1443,
        fromX = 0.4093,
        fromY = 0.9068,
        toPointID = 100056,
        toMap = 1444,
        toX = 0.4555,
        toY = 0.0309,
        type = "border",
    },
    -- Desolace (map 1443 53.38,5.68) -> Stonetalon Mountains (map 1442 30.18,75.95) via border
    {
        fromPointID = 100053,
        fromMap = 1443,
        fromX = 0.5338,
        fromY = 0.0568,
        toPointID = 100045,
        toMap = 1442,
        toX = 0.3018,
        toY = 0.7595,
        type = "border",
    },

    -- Zone: Dun Morogh (map 1426)
    -- Dun Morogh (map 1426 53.40,35.00) -> Ironforge (map 1455 16.16,84.58) via border
    {
        fromPointID = 200052,
        fromMap = 1426,
        fromX = 0.534,
        fromY = 0.35,
        toPointID = 200102,
        toMap = 1455,
        toX = 0.1616,
        toY = 0.8458,
        type = "border",
    },
    -- Dun Morogh (map 1426 80.15,52.59) -> Loch Modan (map 1432 22.34,70.01) via border
    {
        fromPointID = 200053,
        fromMap = 1426,
        fromX = 0.8015,
        fromY = 0.5259,
        toPointID = 200072,
        toMap = 1432,
        toX = 0.2234,
        toY = 0.7001,
        type = "border",
    },
    -- Dun Morogh (map 1426 84.38,31.04) -> Loch Modan (map 1432 19.14,17.29) via border
    {
        fromPointID = 200054,
        fromMap = 1426,
        fromX = 0.8438,
        fromY = 0.3104,
        toPointID = 200071,
        toMap = 1432,
        toX = 0.1914,
        toY = 0.1729,
        type = "border",
    },

    -- Zone: Durotar (map 1411)
    -- Durotar (map 1411 45.53,12.12) -> Orgrimmar (map 1454 52.52,84.77) via border
    {
        fromPointID = 100003,
        fromMap = 1411,
        fromX = 0.4553,
        fromY = 0.1212,
        toPointID = 100098,
        toMap = 1454,
        toX = 0.5252,
        toY = 0.8477,
        type = "border",
    },

    -- Zone: Duskwood (map 1431)
    -- Duskwood (map 1431 44.91,79.81) -> Stranglethorn Vale (map 1434 39.30,5.62) via border
    {
        fromPointID = 200068,
        fromMap = 1431,
        fromX = 0.4491,
        fromY = 0.7981,
        toPointID = 200086,
        toMap = 1434,
        toX = 0.393,
        toY = 0.0562,
        type = "border",
    },
    -- Duskwood (map 1431 88.61,41.02) -> Deadwind Pass (map 1430 35.65,35.60) via border
    {
        fromPointID = 200069,
        fromMap = 1431,
        fromX = 0.8861,
        fromY = 0.4102,
        toPointID = 200065,
        toMap = 1430,
        toX = 0.3565,
        toY = 0.356,
        type = "border",
    },
    -- Duskwood (map 1431 93.78,11.37) -> Redridge Mountains (map 1433 7.01,89.62) via border
    {
        fromPointID = 200070,
        fromMap = 1431,
        fromX = 0.9378,
        fromY = 0.1137,
        toPointID = 200076,
        toMap = 1433,
        toX = 0.0701,
        toY = 0.8962,
        type = "border",
    },

    -- Zone: Dustwallow Marsh (map 1445)
    -- Dustwallow Marsh (map 1445 28.80,47.15) -> The Barrens (map 1413 49.63,78.41) via border
    {
        fromPointID = 100059,
        fromMap = 1445,
        fromX = 0.288,
        fromY = 0.4715,
        toPointID = 100019,
        toMap = 1413,
        toX = 0.4963,
        toY = 0.7841,
        type = "border",
    },

    -- Zone: Elwynn Forest (map 1429)
    -- Elwynn Forest (map 1429 32.42,50.02) -> Stormwind City (map 1453 69.30,85.44) via border
    {
        fromPointID = 200062,
        fromMap = 1429,
        fromX = 0.3242,
        fromY = 0.5002,
        toPointID = 200100,
        toMap = 1453,
        toX = 0.693,
        toY = 0.8544,
        type = "border",
    },
    -- Elwynn Forest (map 1429 91.26,73.48) -> Redridge Mountains (map 1433 10.70,71.99) via border
    {
        fromPointID = 200063,
        fromMap = 1429,
        fromX = 0.9126,
        fromY = 0.7348,
        toPointID = 200077,
        toMap = 1433,
        toX = 0.107,
        toY = 0.7199,
        type = "border",
    },

    -- Zone: Felwood (map 1448)
    -- Felwood (map 1448 54.82,91.17) -> Ashenvale (map 1440 55.75,29.28) via border
    {
        fromPointID = 100074,
        fromMap = 1448,
        fromX = 0.5482,
        fromY = 0.9117,
        toPointID = 100037,
        toMap = 1440,
        toX = 0.5575,
        toY = 0.2928,
        type = "border",
    },
    -- Felwood (map 1448 65.11,8.03) -> Felwood (map 1448 65.40,7.02) via border
    {
        fromPointID = 100075,
        fromMap = 1448,
        fromX = 0.6511,
        fromY = 0.0803,
        toPointID = 100076,
        toMap = 1448,
        toX = 0.654,
        toY = 0.0702,
        type = "border",
    },
    -- Felwood (map 1448 65.40,7.02) -> Felwood (map 1448 65.11,8.03) via border
    {
        fromPointID = 100076,
        fromMap = 1448,
        fromX = 0.654,
        fromY = 0.0702,
        toPointID = 100075,
        toMap = 1448,
        toX = 0.6511,
        toY = 0.0803,
        type = "border",
    },
    -- Felwood (map 1448 67.94,5.15) -> Winterspring (map 1452 27.91,34.45) via border
    {
        fromPointID = 100077,
        fromMap = 1448,
        fromX = 0.6794,
        fromY = 0.0515,
        toPointID = 100093,
        toMap = 1452,
        toX = 0.2791,
        toY = 0.3445,
        type = "border",
    },

    -- Zone: Feralas (map 1444)
    -- Feralas (map 1444 45.55,3.09) -> Desolace (map 1443 40.93,90.68) via border
    {
        fromPointID = 100056,
        fromMap = 1444,
        fromX = 0.4555,
        fromY = 0.0309,
        toPointID = 100052,
        toMap = 1443,
        toX = 0.4093,
        toY = 0.9068,
        type = "border",
    },

    -- Zone: Hillsbrad Foothills (map 1424)
    -- Hillsbrad Foothills (map 1424 14.13,46.20) -> Silverpine Forest (map 1421 65.80,79.45) via border
    {
        fromPointID = 200044,
        fromMap = 1424,
        fromX = 0.1413,
        fromY = 0.462,
        toPointID = 200028,
        toMap = 1421,
        toX = 0.658,
        toY = 0.7945,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 82.16,57.08) -> Arathi Highlands (map 1417 20.36,29.78) via border
    {
        fromPointID = 200047,
        fromMap = 1424,
        fromX = 0.8216,
        fromY = 0.5708,
        toPointID = 200005,
        toMap = 1417,
        toX = 0.2036,
        toY = 0.2978,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 84.39,32.27) -> The Hinterlands (map 1425 11.22,51.19) via border
    {
        fromPointID = 200048,
        fromMap = 1424,
        fromX = 0.8439,
        fromY = 0.3227,
        toPointID = 200049,
        toMap = 1425,
        toX = 0.1122,
        toY = 0.5119,
        type = "border",
    },

    -- Zone: Ironforge (map 1455)
    -- Ironforge (map 1455 16.16,84.58) -> Dun Morogh (map 1426 53.40,35.00) via border
    {
        fromPointID = 200102,
        fromMap = 1455,
        fromX = 0.1616,
        fromY = 0.8458,
        toPointID = 200052,
        toMap = 1426,
        toX = 0.534,
        toY = 0.35,
        type = "border",
    },

    -- Zone: Loch Modan (map 1432)
    -- Loch Modan (map 1432 19.14,17.29) -> Dun Morogh (map 1426 84.38,31.04) via border
    {
        fromPointID = 200071,
        fromMap = 1432,
        fromX = 0.1914,
        fromY = 0.1729,
        toPointID = 200054,
        toMap = 1426,
        toX = 0.8438,
        toY = 0.3104,
        type = "border",
    },
    -- Loch Modan (map 1432 22.34,70.01) -> Dun Morogh (map 1426 80.15,52.59) via border
    {
        fromPointID = 200072,
        fromMap = 1432,
        fromX = 0.2234,
        fromY = 0.7001,
        toPointID = 200053,
        toMap = 1426,
        toX = 0.8015,
        toY = 0.5259,
        type = "border",
    },
    -- Loch Modan (map 1432 25.57,10.29) -> Wetlands (map 1437 53.88,70.33) via border
    {
        fromPointID = 200073,
        fromMap = 1432,
        fromX = 0.2557,
        fromY = 0.1029,
        toPointID = 200096,
        toMap = 1437,
        toX = 0.5388,
        toY = 0.7033,
        type = "border",
    },
    -- Loch Modan (map 1432 46.83,77.75) -> Badlands (map 1418 49.25,7.42) via border
    {
        fromPointID = 200075,
        fromMap = 1432,
        fromX = 0.4683,
        fromY = 0.7775,
        toPointID = 200016,
        toMap = 1418,
        toX = 0.4925,
        toY = 0.0742,
        type = "border",
    },

    -- Zone: Moonglade (map 1450)
    -- Moonglade (map 1450 35.45,74.24) -> Moonglade (map 1450 35.73,72.46) via border
    {
        fromPointID = 100082,
        fromMap = 1450,
        fromX = 0.3545,
        fromY = 0.7424,
        toPointID = 100083,
        toMap = 1450,
        toX = 0.3573,
        toY = 0.7246,
        type = "border",
    },
    -- Moonglade (map 1450 35.73,72.46) -> Moonglade (map 1450 35.45,74.24) via border
    {
        fromPointID = 100083,
        fromMap = 1450,
        fromX = 0.3573,
        fromY = 0.7246,
        toPointID = 100082,
        toMap = 1450,
        toX = 0.3545,
        toY = 0.7424,
        type = "border",
    },

    -- Zone: Mulgore (map 1412)
    -- Mulgore (map 1412 69.05,60.47) -> The Barrens (map 1413 41.40,58.57) via border
    {
        fromPointID = 100006,
        fromMap = 1412,
        fromX = 0.6905,
        fromY = 0.6047,
        toPointID = 100008,
        toMap = 1413,
        toX = 0.414,
        toY = 0.5857,
        type = "border",
    },

    -- Zone: Orgrimmar (map 1454)
    -- Orgrimmar (map 1454 52.52,84.77) -> Durotar (map 1411 45.53,12.12) via border
    {
        fromPointID = 100098,
        fromMap = 1454,
        fromX = 0.5252,
        fromY = 0.8477,
        toPointID = 100003,
        toMap = 1411,
        toX = 0.4553,
        toY = 0.1212,
        type = "border",
    },

    -- Zone: Redridge Mountains (map 1433)
    -- Redridge Mountains (map 1433 7.01,89.62) -> Duskwood (map 1431 93.78,11.37) via border
    {
        fromPointID = 200076,
        fromMap = 1433,
        fromX = 0.0701,
        fromY = 0.8962,
        toPointID = 200070,
        toMap = 1431,
        toX = 0.9378,
        toY = 0.1137,
        type = "border",
    },
    -- Redridge Mountains (map 1433 10.70,71.99) -> Elwynn Forest (map 1429 91.26,73.48) via border
    {
        fromPointID = 200077,
        fromMap = 1433,
        fromX = 0.107,
        fromY = 0.7199,
        toPointID = 200063,
        toMap = 1429,
        toX = 0.9126,
        toY = 0.7348,
        type = "border",
    },
    -- Redridge Mountains (map 1433 47.04,24.72) -> Burning Steppes (map 1428 78.31,77.57) via border
    {
        fromPointID = 200079,
        fromMap = 1433,
        fromX = 0.4704,
        fromY = 0.2472,
        toPointID = 200060,
        toMap = 1428,
        toX = 0.7831,
        toY = 0.7757,
        type = "border",
    },

    -- Zone: Searing Gorge (map 1427)
    -- Searing Gorge (map 1427 69.54,54.29) -> Badlands (map 1418 4.18,61.56) via border
    {
        fromPointID = 200057,
        fromMap = 1427,
        fromX = 0.6954,
        fromY = 0.5429,
        toPointID = 200009,
        toMap = 1418,
        toX = 0.0418,
        toY = 0.6156,
        type = "border",
    },

    -- Zone: Silithus (map 1451)
    -- Silithus (map 1451 84.04,13.93) -> Un'Goro Crater (map 1449 29.31,22.36) via border
    {
        fromPointID = 100092,
        fromMap = 1451,
        fromX = 0.8404,
        fromY = 0.1393,
        toPointID = 100078,
        toMap = 1449,
        toX = 0.2931,
        toY = 0.2236,
        type = "border",
    },

    -- Zone: Silverpine Forest (map 1421)
    -- Silverpine Forest (map 1421 65.80,79.45) -> Hillsbrad Foothills (map 1424 14.13,46.20) via border
    {
        fromPointID = 200028,
        fromMap = 1421,
        fromX = 0.658,
        fromY = 0.7945,
        toPointID = 200044,
        toMap = 1424,
        toX = 0.1413,
        toY = 0.462,
        type = "border",
    },
    -- Silverpine Forest (map 1421 66.03,7.65) -> Tirisfal Glades (map 1420 54.88,72.60) via border
    {
        fromPointID = 200029,
        fromMap = 1421,
        fromX = 0.6603,
        fromY = 0.0765,
        toPointID = 200019,
        toMap = 1420,
        toX = 0.5488,
        toY = 0.726,
        type = "border",
    },

    -- Zone: Stonetalon Mountains (map 1442)
    -- Stonetalon Mountains (map 1442 30.18,75.95) -> Desolace (map 1443 53.38,5.68) via border
    {
        fromPointID = 100045,
        fromMap = 1442,
        fromX = 0.3018,
        fromY = 0.7595,
        toPointID = 100053,
        toMap = 1443,
        toX = 0.5338,
        toY = 0.0568,
        type = "border",
    },
    -- Stonetalon Mountains (map 1442 78.23,42.70) -> Ashenvale (map 1440 42.29,71.06) via border
    {
        fromPointID = 100049,
        fromMap = 1442,
        fromX = 0.7823,
        fromY = 0.427,
        toPointID = 100036,
        toMap = 1440,
        toX = 0.4229,
        toY = 0.7106,
        type = "border",
    },
    -- Stonetalon Mountains (map 1442 83.38,97.72) -> The Barrens (map 1413 35.72,27.50) via border
    {
        fromPointID = 100050,
        fromMap = 1442,
        fromX = 0.8338,
        fromY = 0.9772,
        toPointID = 100007,
        toMap = 1413,
        toX = 0.3572,
        toY = 0.275,
        type = "border",
    },

    -- Zone: Stormwind City (map 1453)
    -- Stormwind City (map 1453 69.30,85.44) -> Elwynn Forest (map 1429 32.42,50.02) via border
    {
        fromPointID = 200100,
        fromMap = 1453,
        fromX = 0.693,
        fromY = 0.8544,
        toPointID = 200062,
        toMap = 1429,
        toX = 0.3242,
        toY = 0.5002,
        type = "border",
    },

    -- Zone: Stranglethorn Vale (map 1434)
    -- Stranglethorn Vale (map 1434 39.30,5.62) -> Duskwood (map 1431 44.91,79.81) via border
    {
        fromPointID = 200086,
        fromMap = 1434,
        fromX = 0.393,
        fromY = 0.0562,
        toPointID = 200068,
        toMap = 1431,
        toX = 0.4491,
        toY = 0.7981,
        type = "border",
    },

    -- Zone: Swamp of Sorrows (map 1435)
    -- Swamp of Sorrows (map 1435 10.37,50.22) -> Deadwind Pass (map 1430 59.11,41.16) via border
    {
        fromPointID = 200087,
        fromMap = 1435,
        fromX = 0.1037,
        fromY = 0.5022,
        toPointID = 200067,
        toMap = 1430,
        toX = 0.5911,
        toY = 0.4116,
        type = "border",
    },
    -- Swamp of Sorrows (map 1435 35.64,62.07) -> Blasted Lands (map 1419 52.01,7.81) via border
    {
        fromPointID = 200088,
        fromMap = 1435,
        fromX = 0.3564,
        fromY = 0.6207,
        toPointID = 200017,
        toMap = 1419,
        toX = 0.5201,
        toY = 0.0781,
        type = "border",
    },

    -- Zone: Tanaris (map 1446)
    -- Tanaris (map 1446 27.05,56.84) -> Un'Goro Crater (map 1449 71.61,77.44) via border
    {
        fromPointID = 100063,
        fromMap = 1446,
        fromX = 0.2705,
        fromY = 0.5684,
        toPointID = 100080,
        toMap = 1449,
        toX = 0.7161,
        toY = 0.7744,
        type = "border",
    },
    -- Tanaris (map 1446 50.75,24.13) -> Thousand Needles (map 1441 74.19,93.34) via border
    {
        fromPointID = 100064,
        fromMap = 1446,
        fromX = 0.5075,
        fromY = 0.2413,
        toPointID = 100044,
        toMap = 1441,
        toX = 0.7419,
        toY = 0.9334,
        type = "border",
    },

    -- Zone: Teldrassil (map 1438)
    -- Teldrassil (map 1438 36.16,54.39) -> Darnassus (map 1457 86.26,35.56) via border
    {
        fromPointID = 100024,
        fromMap = 1438,
        fromX = 0.3616,
        fromY = 0.5439,
        toPointID = 100104,
        toMap = 1457,
        toX = 0.8626,
        toY = 0.3556,
        type = "border",
    },

    -- Zone: The Barrens (map 1413)
    -- The Barrens (map 1413 35.72,27.50) -> Stonetalon Mountains (map 1442 83.38,97.72) via border
    {
        fromPointID = 100007,
        fromMap = 1413,
        fromX = 0.3572,
        fromY = 0.275,
        toPointID = 100050,
        toMap = 1442,
        toX = 0.8338,
        toY = 0.9772,
        type = "border",
    },
    -- The Barrens (map 1413 41.40,58.57) -> Mulgore (map 1412 69.05,60.47) via border
    {
        fromPointID = 100008,
        fromMap = 1413,
        fromX = 0.414,
        fromY = 0.5857,
        toPointID = 100006,
        toMap = 1412,
        toX = 0.6905,
        toY = 0.6047,
        type = "border",
    },

    -- The Barrens (map 1413 48.16,4.32) -> Ashenvale (map 1440 68.62,86.48) via border
    {
        fromPointID = 100017,
        fromMap = 1413,
        fromX = 0.4816,
        fromY = 0.0432,
        toPointID = 100038,
        toMap = 1440,
        toX = 0.6862,
        toY = 0.8648,
        type = "border",
    },
    -- The Barrens (map 1413 49.63,78.41) -> Dustwallow Marsh (map 1445 28.80,47.15) via border
    {
        fromPointID = 100019,
        fromMap = 1413,
        fromX = 0.4963,
        fromY = 0.7841,
        toPointID = 100059,
        toMap = 1445,
        toX = 0.288,
        toY = 0.4715,
        type = "border",
    },

    -- Zone: The Hinterlands (map 1425)
    -- The Hinterlands (map 1425 11.22,51.19) -> Hillsbrad Foothills (map 1424 84.39,32.27) via border
    {
        fromPointID = 200049,
        fromMap = 1425,
        fromX = 0.1122,
        fromY = 0.5119,
        toPointID = 200048,
        toMap = 1424,
        toX = 0.8439,
        toY = 0.3227,
        type = "border",
    },
    -- The Hinterlands (map 1425 20.72,47.95) -> Western Plaguelands (map 1422 65.28,86.79) via border
    {
        fromPointID = 200050,
        fromMap = 1425,
        fromX = 0.2072,
        fromY = 0.4795,
        toPointID = 200033,
        toMap = 1422,
        toX = 0.6528,
        toY = 0.8679,
        type = "border",
    },

    -- Zone: Thousand Needles (map 1441)

    -- Thousand Needles (map 1441 74.19,93.34) -> Tanaris (map 1446 50.75,24.13) via border
    {
        fromPointID = 100044,
        fromMap = 1441,
        fromX = 0.7419,
        fromY = 0.9334,
        toPointID = 100064,
        toMap = 1446,
        toX = 0.5075,
        toY = 0.2413,
        type = "border",
    },

    -- Zone: Tirisfal Glades (map 1420)
    -- Tirisfal Glades (map 1420 15.28,30.86) -> Undercity (map 1458 14.81,35.28) via border
    {
        fromPointID = 200018,
        fromMap = 1420,
        fromX = 0.1528,
        fromY = 0.3086,
        toPointID = 200106,
        toMap = 1458,
        toX = 0.1481,
        toY = 0.3528,
        type = "border",
    },
    -- Tirisfal Glades (map 1420 54.88,72.60) -> Silverpine Forest (map 1421 66.03,7.65) via border
    {
        fromPointID = 200019,
        fromMap = 1420,
        fromX = 0.5488,
        fromY = 0.726,
        toPointID = 200029,
        toMap = 1421,
        toX = 0.6603,
        toY = 0.0765,
        type = "border",
    },
    -- Tirisfal Glades (map 1420 61.87,65.01) -> Undercity (map 1458 66.22,1.89) via border
    {
        fromPointID = 200021,
        fromMap = 1420,
        fromX = 0.6187,
        fromY = 0.6501,
        toPointID = 200108,
        toMap = 1458,
        toX = 0.6622,
        toY = 0.0189,
        type = "border",
    },
    -- Tirisfal Glades (map 1420 84.50,70.39) -> Western Plaguelands (map 1422 28.99,57.48) via border
    {
        fromPointID = 200023,
        fromMap = 1420,
        fromX = 0.845,
        fromY = 0.7039,
        toPointID = 200030,
        toMap = 1422,
        toX = 0.2899,
        toY = 0.5748,
        type = "border",
    },

    -- Zone: Un'Goro Crater (map 1449)
    -- Un'Goro Crater (map 1449 29.31,22.36) -> Silithus (map 1451 84.04,13.93) via border
    {
        fromPointID = 100078,
        fromMap = 1449,
        fromX = 0.2931,
        fromY = 0.2236,
        toPointID = 100092,
        toMap = 1451,
        toX = 0.8404,
        toY = 0.1393,
        type = "border",
    },
    -- Un'Goro Crater (map 1449 71.61,77.44) -> Tanaris (map 1446 27.05,56.84) via border
    {
        fromPointID = 100080,
        fromMap = 1449,
        fromX = 0.7161,
        fromY = 0.7744,
        toPointID = 100063,
        toMap = 1446,
        toX = 0.2705,
        toY = 0.5684,
        type = "border",
    },

    -- Zone: Undercity (map 1458)
    -- Undercity (map 1458 14.81,35.28) -> Tirisfal Glades (map 1420 15.28,30.86) via border
    {
        fromPointID = 200106,
        fromMap = 1458,
        fromX = 0.1481,
        fromY = 0.3528,
        toPointID = 200018,
        toMap = 1420,
        toX = 0.1528,
        toY = 0.3086,
        type = "border",
    },
    -- Undercity (map 1458 66.22,1.89) -> Tirisfal Glades (map 1420 61.87,65.01) via border
    {
        fromPointID = 200108,
        fromMap = 1458,
        fromX = 0.6622,
        fromY = 0.0189,
        toPointID = 200021,
        toMap = 1420,
        toX = 0.6187,
        toY = 0.6501,
        type = "border",
    },

    -- Zone: Western Plaguelands (map 1422)
    -- Western Plaguelands (map 1422 28.99,57.48) -> Tirisfal Glades (map 1420 84.50,70.39) via border
    {
        fromPointID = 200030,
        fromMap = 1422,
        fromX = 0.2899,
        fromY = 0.5748,
        toPointID = 200023,
        toMap = 1420,
        toX = 0.845,
        toY = 0.7039,
        type = "border",
    },
    -- Western Plaguelands (map 1422 44.04,86.38) -> Alterac Mountains (map 1416 79.91,42.63) via border
    {
        fromPointID = 200032,
        fromMap = 1422,
        fromX = 0.4404,
        fromY = 0.8638,
        toPointID = 200003,
        toMap = 1416,
        toX = 0.7991,
        toY = 0.4263,
        type = "border",
    },
    -- Western Plaguelands (map 1422 65.28,86.79) -> The Hinterlands (map 1425 20.72,47.95) via border
    {
        fromPointID = 200033,
        fromMap = 1422,
        fromX = 0.6528,
        fromY = 0.8679,
        toPointID = 200050,
        toMap = 1425,
        toX = 0.2072,
        toY = 0.4795,
        type = "border",
    },

    -- Zone: Wetlands (map 1437)
    -- Wetlands (map 1437 51.08,11.70) -> Arathi Highlands (map 1417 45.46,89.18) via border
    {
        fromPointID = 200095,
        fromMap = 1437,
        fromX = 0.5108,
        fromY = 0.117,
        toPointID = 200006,
        toMap = 1417,
        toX = 0.4546,
        toY = 0.8918,
        type = "border",
    },
    -- Wetlands (map 1437 53.88,70.33) -> Loch Modan (map 1432 25.57,10.29) via border
    {
        fromPointID = 200096,
        fromMap = 1437,
        fromX = 0.5388,
        fromY = 0.7033,
        toPointID = 200073,
        toMap = 1432,
        toX = 0.2557,
        toY = 0.1029,
        type = "border",
    },

    -- Zone: Winterspring (map 1452)
    -- Winterspring (map 1452 27.91,34.45) -> Felwood (map 1448 67.94,5.15) via border
    {
        fromPointID = 100093,
        fromMap = 1452,
        fromX = 0.2791,
        fromY = 0.3445,
        toPointID = 100077,
        toMap = 1448,
        toX = 0.6794,
        toY = 0.0515,
        type = "border",
    },

    -- Durotar (map 1411 34.14,42.27) -> The Barrens (map 1413 63.06,19.16) via border
    {
        fromPointID = 1300014,
        fromMap = 1411,
        fromX = 0.3414,
        fromY = 0.4227,
        toPointID = 1300015,
        toMap = 1413,
        toX = 0.6306,
        toY = 0.1916,
        type = "border",
    },
    -- The Barrens (map 1413 63.06,19.16) -> Durotar (map 1411 34.14,42.27) via border
    {
        fromPointID = 1300015,
        fromMap = 1413,
        fromX = 0.6306,
        fromY = 0.1916,
        toPointID = 1300014,
        toMap = 1411,
        toX = 0.3414,
        toY = 0.4227,
        type = "border",
    },
    -- Mulgore (map 1412 41.33,13.01) -> Stonetalon Mountains (map 1442 67.78,97.77) via border
    {
        fromPointID = 1300016,
        fromMap = 1412,
        fromX = 0.4133,
        fromY = 0.1301,
        toPointID = 1300017,
        toMap = 1442,
        toX = 0.6778,
        toY = 0.9777,
        type = "border",
    },
    -- Stonetalon Mountains (map 1442 67.78,97.77) -> Mulgore (map 1412 41.33,13.01) via border
    {
        fromPointID = 1300017,
        fromMap = 1442,
        fromX = 0.6778,
        fromY = 0.9777,
        toPointID = 1300016,
        toMap = 1412,
        toX = 0.4133,
        toY = 0.1301,
        type = "border",
    },
    -- Mulgore (map 1412 39.08,13.00) -> Stonetalon Mountains (map 1442 64.95,97.76) via border
    {
        fromPointID = 1300018,
        fromMap = 1412,
        fromX = 0.3908,
        fromY = 0.13,
        toPointID = 1300019,
        toMap = 1442,
        toX = 0.6495,
        toY = 0.9776,
        type = "border",
    },
    -- Stonetalon Mountains (map 1442 64.95,97.76) -> Mulgore (map 1412 39.08,13.00) via border
    {
        fromPointID = 1300019,
        fromMap = 1442,
        fromX = 0.6495,
        fromY = 0.9776,
        toPointID = 1300018,
        toMap = 1412,
        toX = 0.3908,
        toY = 0.13,
        type = "border",
    },
    -- Mulgore (map 1412 31.09,22.81) -> Desolace (map 1443 81.57,37.40) via border
    {
        fromPointID = 1300020,
        fromMap = 1412,
        fromX = 0.3109,
        fromY = 0.2281,
        toPointID = 1300021,
        toMap = 1443,
        toX = 0.8157,
        toY = 0.374,
        type = "border",
    },
    -- Desolace (map 1443 81.57,37.40) -> Mulgore (map 1412 31.09,22.81) via border
    {
        fromPointID = 1300021,
        fromMap = 1443,
        fromX = 0.8157,
        fromY = 0.374,
        toPointID = 1300020,
        toMap = 1412,
        toX = 0.3109,
        toY = 0.2281,
        type = "border",
    },




    -- The Barrens (map 1413 63.12,59.35) -> Dustwallow Marsh (map 1445 53.30,10.40) via border
    {
        fromPointID = 1300026,
        fromMap = 1413,
        fromX = 0.6312,
        fromY = 0.5935,
        toPointID = 1300027,
        toMap = 1445,
        toX = 0.533,
        toY = 0.104,
        type = "border",
    },
    -- Dustwallow Marsh (map 1445 53.30,10.40) -> The Barrens (map 1413 63.12,59.35) via border
    {
        fromPointID = 1300027,
        fromMap = 1445,
        fromX = 0.533,
        fromY = 0.104,
        toPointID = 1300026,
        toMap = 1413,
        toX = 0.6312,
        toY = 0.5935,
        type = "border",
    },
    -- The Barrens (map 1413 64.42,0.00) -> Orgrimmar (map 1454 15.98,61.38) via border
    {
        fromPointID = 1300028,
        fromMap = 1413,
        fromX = 0.6442,
        fromY = 0,
        toPointID = 1300029,
        toMap = 1454,
        toX = 0.1598,
        toY = 0.6138,
        type = "border",
    },
    -- Orgrimmar (map 1454 15.98,61.38) -> The Barrens (map 1413 64.42,0.00) via border
    {
        fromPointID = 1300029,
        fromMap = 1454,
        fromX = 0.1598,
        fromY = 0.6138,
        toPointID = 1300028,
        toMap = 1413,
        toX = 0.6442,
        toY = 0,
        type = "border",
    },
    -- Alterac Mountains (map 1416 28.73,3.60) -> Tirisfal Glades (map 1420 67.59,79.82) via border
    {
        fromPointID = 1300030,
        fromMap = 1416,
        fromX = 0.2873,
        fromY = 0.036,
        toPointID = 1300031,
        toMap = 1420,
        toX = 0.6759,
        toY = 0.7982,
        type = "border",
    },
    -- Tirisfal Glades (map 1420 67.59,79.82) -> Alterac Mountains (map 1416 28.73,3.60) via border
    {
        fromPointID = 1300031,
        fromMap = 1420,
        fromX = 0.6759,
        fromY = 0.7982,
        toPointID = 1300030,
        toMap = 1416,
        toX = 0.2873,
        toY = 0.036,
        type = "border",
    },
    -- Alterac Mountains (map 1416 8.97,85.86) -> Silverpine Forest (map 1421 69.47,63.19) via border
    {
        fromPointID = 1300032,
        fromMap = 1416,
        fromX = 0.0897,
        fromY = 0.8586,
        toPointID = 1300033,
        toMap = 1421,
        toX = 0.6947,
        toY = 0.6319,
        type = "border",
    },
    -- Silverpine Forest (map 1421 69.47,63.19) -> Alterac Mountains (map 1416 8.97,85.86) via border
    {
        fromPointID = 1300033,
        fromMap = 1421,
        fromX = 0.6947,
        fromY = 0.6319,
        toPointID = 1300032,
        toMap = 1416,
        toX = 0.0897,
        toY = 0.8586,
        type = "border",
    },
    -- Alterac Mountains (map 1416 24.09,89.36) -> Hillsbrad Foothills (map 1424 29.93,26.63) via border
    {
        fromPointID = 1300034,
        fromMap = 1416,
        fromX = 0.2409,
        fromY = 0.8936,
        toPointID = 1300035,
        toMap = 1424,
        toX = 0.2993,
        toY = 0.2663,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 29.93,26.63) -> Alterac Mountains (map 1416 24.09,89.36) via border
    {
        fromPointID = 1300035,
        fromMap = 1424,
        fromX = 0.2993,
        fromY = 0.2663,
        toPointID = 1300034,
        toMap = 1416,
        toX = 0.2409,
        toY = 0.8936,
        type = "border",
    },
    -- Alterac Mountains (map 1416 52.19,69.66) -> Hillsbrad Foothills (map 1424 54.52,9.39) via border
    {
        fromPointID = 1300036,
        fromMap = 1416,
        fromX = 0.5219,
        fromY = 0.6966,
        toPointID = 1300037,
        toMap = 1424,
        toX = 0.5452,
        toY = 0.0939,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 54.52,9.39) -> Alterac Mountains (map 1416 52.19,69.66) via border
    {
        fromPointID = 1300037,
        fromMap = 1424,
        fromX = 0.5452,
        fromY = 0.0939,
        toPointID = 1300036,
        toMap = 1416,
        toX = 0.5219,
        toY = 0.6966,
        type = "border",
    },
    -- Alterac Mountains (map 1416 39.50,96.40) -> Hillsbrad Foothills (map 1424 43.42,32.79) via border
    {
        fromPointID = 1300038,
        fromMap = 1416,
        fromX = 0.395,
        fromY = 0.964,
        toPointID = 1300039,
        toMap = 1424,
        toX = 0.4342,
        toY = 0.3279,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 43.42,32.79) -> Alterac Mountains (map 1416 39.50,96.40) via border
    {
        fromPointID = 1300039,
        fromMap = 1424,
        fromX = 0.4342,
        fromY = 0.3279,
        toPointID = 1300038,
        toMap = 1416,
        toX = 0.395,
        toY = 0.964,
        type = "border",
    },
    -- Alterac Mountains (map 1416 79.18,77.90) -> Hillsbrad Foothills (map 1424 78.14,16.60) via border
    {
        fromPointID = 1300040,
        fromMap = 1416,
        fromX = 0.7918,
        fromY = 0.779,
        toPointID = 1300041,
        toMap = 1424,
        toX = 0.7814,
        toY = 0.166,
        type = "border",
    },
    -- Hillsbrad Foothills (map 1424 78.14,16.60) -> Alterac Mountains (map 1416 79.18,77.90) via border
    {
        fromPointID = 1300041,
        fromMap = 1424,
        fromX = 0.7814,
        fromY = 0.166,
        toPointID = 1300040,
        toMap = 1416,
        toX = 0.7918,
        toY = 0.779,
        type = "border",
    },
    -- Badlands (map 1418 55.08,93.09) -> Riverglades (map 2548 32.12,29.90) via border
    {
        fromPointID = 1300042,
        fromMap = 1418,
        fromX = 0.5508,
        fromY = 0.9309,
        toPointID = 1300043,
        toMap = 2548,
        toX = 0.3212,
        toY = 0.299,
        type = "border",
    },
    -- Riverglades (map 2548 32.12,29.90) -> Badlands (map 1418 55.08,93.09) via border
    {
        fromPointID = 1300043,
        fromMap = 2548,
        fromX = 0.3212,
        fromY = 0.299,
        toPointID = 1300042,
        toMap = 1418,
        toX = 0.5508,
        toY = 0.9309,
        type = "border",
    },
    -- Western Plaguelands (map 1422 70.15,50.22) -> Eastern Plaguelands (map 1423 7.99,61.56) via border
    {
        fromPointID = 1300044,
        fromMap = 1422,
        fromX = 0.7015,
        fromY = 0.5022,
        toPointID = 1300045,
        toMap = 1423,
        toX = 0.0799,
        toY = 0.6156,
        type = "border",
    },
    -- Eastern Plaguelands (map 1423 7.99,61.56) -> Western Plaguelands (map 1422 70.15,50.22) via border
    {
        fromPointID = 1300045,
        fromMap = 1423,
        fromX = 0.0799,
        fromY = 0.6156,
        toPointID = 1300044,
        toMap = 1422,
        toX = 0.7015,
        toY = 0.5022,
        type = "border",
    },
    -- Western Plaguelands (map 1422 64.76,19.06) -> Eastern Plaguelands (map 1423 2.60,30.40) via border
    {
        fromPointID = 1300046,
        fromMap = 1422,
        fromX = 0.6476,
        fromY = 0.1906,
        toPointID = 1300047,
        toMap = 1423,
        toX = 0.026,
        toY = 0.304,
        type = "border",
    },
    -- Eastern Plaguelands (map 1423 2.60,30.40) -> Western Plaguelands (map 1422 64.76,19.06) via border
    {
        fromPointID = 1300047,
        fromMap = 1423,
        fromX = 0.026,
        fromY = 0.304,
        toPointID = 1300046,
        toMap = 1422,
        toX = 0.6476,
        toY = 0.1906,
        type = "border",
    },
    -- Searing Gorge (map 1427 34.98,87.43) -> Burning Steppes (map 1428 28.57,18.92) via border
    {
        fromPointID = 1300048,
        fromMap = 1427,
        fromX = 0.3498,
        fromY = 0.8743,
        toPointID = 1300049,
        toMap = 1428,
        toX = 0.2857,
        toY = 0.1892,
        type = "border",
    },
    -- Burning Steppes (map 1428 28.57,18.92) -> Searing Gorge (map 1427 34.98,87.43) via border
    {
        fromPointID = 1300049,
        fromMap = 1428,
        fromX = 0.2857,
        fromY = 0.1892,
        toPointID = 1300048,
        toMap = 1427,
        toX = 0.3498,
        toY = 0.8743,
        type = "border",
    },
    -- Elwynn Forest (map 1429 20.27,80.48) -> Westfall (map 1436 62.43,17.24) via border
    {
        fromPointID = 1300050,
        fromMap = 1429,
        fromX = 0.2027,
        fromY = 0.8048,
        toPointID = 1300051,
        toMap = 1436,
        toX = 0.6243,
        toY = 0.1724,
        type = "border",
    },
    -- Westfall (map 1436 62.43,17.24) -> Elwynn Forest (map 1429 20.27,80.48) via border
    {
        fromPointID = 1300051,
        fromMap = 1436,
        fromX = 0.6243,
        fromY = 0.1724,
        toPointID = 1300050,
        toMap = 1429,
        toX = 0.2027,
        toY = 0.8048,
        type = "border",
    },
    -- Duskwood (map 1431 7.42,63.93) -> Westfall (map 1436 68.11,62.89) via border
    {
        fromPointID = 1300052,
        fromMap = 1431,
        fromX = 0.0742,
        fromY = 0.6393,
        toPointID = 1300053,
        toMap = 1436,
        toX = 0.6811,
        toY = 0.6289,
        type = "border",
    },
    -- Westfall (map 1436 68.11,62.89) -> Duskwood (map 1431 7.42,63.93) via border
    {
        fromPointID = 1300053,
        fromMap = 1436,
        fromX = 0.6811,
        fromY = 0.6289,
        toPointID = 1300052,
        toMap = 1431,
        toX = 0.0742,
        toY = 0.6393,
        type = "border",
    },
    -- Redridge Mountains (map 1433 96.21,70.74) -> Swamp of Sorrows (map 1435 67.44,0.00) via border
    {
        fromPointID = 1300054,
        fromMap = 1433,
        fromX = 0.9621,
        fromY = 0.7074,
        toPointID = 1300055,
        toMap = 1435,
        toX = 0.6744,
        toY = 0,
        type = "border",
    },
    -- Swamp of Sorrows (map 1435 67.44,0.00) -> Redridge Mountains (map 1433 96.21,70.74) via border
    {
        fromPointID = 1300055,
        fromMap = 1435,
        fromX = 0.6744,
        fromY = 0,
        toPointID = 1300054,
        toMap = 1433,
        toX = 0.9621,
        toY = 0.7074,
        type = "border",
    },
    -- Redridge Mountains (map 1433 45.40,7.34) -> Riverglades (map 2548 15.98,68.49) via border
    {
        fromPointID = 1300056,
        fromMap = 1433,
        fromX = 0.454,
        fromY = 0.0734,
        toPointID = 1300057,
        toMap = 2548,
        toX = 0.1598,
        toY = 0.6849,
        type = "border",
    },
    -- Riverglades (map 2548 15.98,68.49) -> Redridge Mountains (map 1433 45.40,7.34) via border
    {
        fromPointID = 1300057,
        fromMap = 2548,
        fromX = 0.1598,
        fromY = 0.6849,
        toPointID = 1300056,
        toMap = 1433,
        toX = 0.454,
        toY = 0.0734,
        type = "border",
    },
    -- Redridge Mountains (map 1433 66.85,17.84) -> Riverglades (map 2548 25.58,73.19) via border
    {
        fromPointID = 1300058,
        fromMap = 1433,
        fromX = 0.6685,
        fromY = 0.1784,
        toPointID = 1300059,
        toMap = 2548,
        toX = 0.2558,
        toY = 0.7319,
        type = "border",
    },
    -- Riverglades (map 2548 25.58,73.19) -> Redridge Mountains (map 1433 66.85,17.84) via border
    {
        fromPointID = 1300059,
        fromMap = 2548,
        fromX = 0.2558,
        fromY = 0.7319,
        toPointID = 1300058,
        toMap = 1433,
        toX = 0.6685,
        toY = 0.1784,
        type = "border",
    },
    -- Thousand Needles (map 1441 7.59,10.54) -> Feralas (map 1444 89.34,41.21) via border
    {
        fromPointID = 1300060,
        fromMap = 1441,
        fromX = 0.0759,
        fromY = 0.1054,
        toPointID = 1300061,
        toMap = 1444,
        toX = 0.8934,
        toY = 0.4121,
        type = "border",
    },
    -- Feralas (map 1444 89.34,41.21) -> Thousand Needles (map 1441 7.59,10.54) via border
    {
        fromPointID = 1300061,
        fromMap = 1444,
        fromX = 0.8934,
        fromY = 0.4121,
        toPointID = 1300060,
        toMap = 1441,
        toX = 0.0759,
        toY = 0.1054,
        type = "border",
    },
    -- Desolace (map 1443 58.55,88.09) -> Shen'dralas (map 2652 20.69,21.14) via border
    {
        fromPointID = 1300062,
        fromMap = 1443,
        fromX = 0.5855,
        fromY = 0.8809,
        toPointID = 1300063,
        toMap = 2652,
        toX = 0.2069,
        toY = 0.2114,
        type = "border",
    },
    -- Shen'dralas (map 2652 20.69,21.14) -> Desolace (map 1443 58.55,88.09) via border
    {
        fromPointID = 1300063,
        fromMap = 2652,
        fromX = 0.2069,
        fromY = 0.2114,
        toPointID = 1300062,
        toMap = 1443,
        toX = 0.5855,
        toY = 0.8809,
        type = "border",
    },
    -- Desolace (map 1443 64.31,80.66) -> Shen'dralas (map 2652 33.31,4.83) via border
    {
        fromPointID = 1300064,
        fromMap = 1443,
        fromX = 0.6431,
        fromY = 0.8066,
        toPointID = 1300065,
        toMap = 2652,
        toX = 0.3331,
        toY = 0.0483,
        type = "border",
    },
    -- Shen'dralas (map 2652 33.31,4.83) -> Desolace (map 1443 64.31,80.66) via border
    {
        fromPointID = 1300065,
        fromMap = 2652,
        fromX = 0.3331,
        fromY = 0.0483,
        toPointID = 1300064,
        toMap = 1443,
        toX = 0.6431,
        toY = 0.8066,
        type = "border",
    },
    -- Desolace (map 1443 76.75,82.92) -> Shen'dralas (map 2652 60.60,9.80) via border
    {
        fromPointID = 1300066,
        fromMap = 1443,
        fromX = 0.7675,
        fromY = 0.8292,
        toPointID = 1300067,
        toMap = 2652,
        toX = 0.606,
        toY = 0.098,
        type = "border",
    },
    -- Shen'dralas (map 2652 60.60,9.80) -> Desolace (map 1443 76.75,82.92) via border
    {
        fromPointID = 1300067,
        fromMap = 2652,
        fromX = 0.606,
        fromY = 0.098,
        toPointID = 1300066,
        toMap = 1443,
        toX = 0.7675,
        toY = 0.8292,
        type = "border",
    },
    -- Felwood (map 1448 65.60,7.10) -> Moonglade (map 1450 36.70,92.50) via border
    {
        fromPointID = 1300068,
        fromMap = 1448,
        fromX = 0.656,
        fromY = 0.071,
        toPointID = 1300069,
        toMap = 1450,
        toX = 0.367,
        toY = 0.925,
        type = "border",
    },
    -- Moonglade (map 1450 36.70,92.50) -> Felwood (map 1448 65.60,7.10) via border
    {
        fromPointID = 1300069,
        fromMap = 1450,
        fromX = 0.367,
        fromY = 0.925,
        toPointID = 1300068,
        toMap = 1448,
        toX = 0.656,
        toY = 0.071,
        type = "border",
    },
    -- Moonglade (map 1450 37.03,91.27) -> Winterspring (map 1452 27.03,30.57) via border
    {
        fromPointID = 1300070,
        fromMap = 1450,
        fromX = 0.3703,
        fromY = 0.9127,
        toPointID = 1300071,
        toMap = 1452,
        toX = 0.2703,
        toY = 0.3057,
        type = "border",
    },
    -- Winterspring (map 1452 27.03,30.57) -> Moonglade (map 1450 37.03,91.27) via border
    {
        fromPointID = 1300071,
        fromMap = 1452,
        fromX = 0.2703,
        fromY = 0.3057,
        toPointID = 1300070,
        toMap = 1450,
        toX = 0.3703,
        toY = 0.9127,
        type = "border",
    },
}

Navigation:RegisterPathData("border", BORDER)
