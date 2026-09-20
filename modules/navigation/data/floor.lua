---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local FLOOR = {

    -- Zone: Aberrus, the Shadowed Crucible (map 2166)
    -- Aberrus, the Shadowed Crucible (map 2166 32.81,18.47) -> Aberrus, the Shadowed Crucible (map 2167 55.16,16.39) via floor
    {
        fromPointID = 1100168,
        fromMap = 2166,
        fromX = 0.3281,
        fromY = 0.1847,
        toPointID = 1100171,
        toMap = 2167,
        toX = 0.5516,
        toY = 0.1639,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2167)
    -- Aberrus, the Shadowed Crucible (map 2167 48.71,73.17) -> Aberrus, the Shadowed Crucible (map 2168 45.58,68.61) via floor
    {
        fromPointID = 1100170,
        fromMap = 2167,
        fromX = 0.4871,
        fromY = 0.7317,
        toPointID = 1100172,
        toMap = 2168,
        toX = 0.4558,
        toY = 0.6861,
        type = "floor",
    },
    -- Aberrus, the Shadowed Crucible (map 2167 55.16,16.39) -> Aberrus, the Shadowed Crucible (map 2166 32.81,18.47) via floor
    {
        fromPointID = 1100171,
        fromMap = 2167,
        fromX = 0.5516,
        fromY = 0.1639,
        toPointID = 1100168,
        toMap = 2166,
        toX = 0.3281,
        toY = 0.1847,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2168)
    -- Aberrus, the Shadowed Crucible (map 2168 45.58,68.61) -> Aberrus, the Shadowed Crucible (map 2167 48.71,73.17) via floor
    {
        fromPointID = 1100172,
        fromMap = 2168,
        fromX = 0.4558,
        fromY = 0.6861,
        toPointID = 1100170,
        toMap = 2167,
        toX = 0.4871,
        toY = 0.7317,
        type = "floor",
    },
    -- Aberrus, the Shadowed Crucible (map 2168 55.52,89.13) -> Aberrus, the Shadowed Crucible (map 2169 50.74,90.64) via floor
    {
        fromPointID = 1100173,
        fromMap = 2168,
        fromX = 0.5552,
        fromY = 0.8913,
        toPointID = 1100174,
        toMap = 2169,
        toX = 0.5074,
        toY = 0.9064,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2169)
    -- Aberrus, the Shadowed Crucible (map 2169 50.74,90.64) -> Aberrus, the Shadowed Crucible (map 2168 55.52,89.13) via floor
    {
        fromPointID = 1100174,
        fromMap = 2169,
        fromX = 0.5074,
        fromY = 0.9064,
        toPointID = 1100173,
        toMap = 2168,
        toX = 0.5552,
        toY = 0.8913,
        type = "floor",
    },
    -- Aberrus, the Shadowed Crucible (map 2169 50.98,13.52) -> Aberrus, the Shadowed Crucible (map 2170 48.95,10.04) via floor
    {
        fromPointID = 1100175,
        fromMap = 2169,
        fromX = 0.5098,
        fromY = 0.1352,
        toPointID = 1100176,
        toMap = 2170,
        toX = 0.4895,
        toY = 0.1004,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2170)
    -- Aberrus, the Shadowed Crucible (map 2170 48.95,10.04) -> Aberrus, the Shadowed Crucible (map 2169 50.98,13.52) via floor
    {
        fromPointID = 1100176,
        fromMap = 2170,
        fromX = 0.4895,
        fromY = 0.1004,
        toPointID = 1100175,
        toMap = 2169,
        toX = 0.5098,
        toY = 0.1352,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2171)
    -- Aberrus, the Shadowed Crucible (map 2171 33.54,44.55) -> Aberrus, the Shadowed Crucible (map 2172 57.03,61.35) via floor
    {
        fromPointID = 1100177,
        fromMap = 2171,
        fromX = 0.3354,
        fromY = 0.4455,
        toPointID = 1100178,
        toMap = 2172,
        toX = 0.5703,
        toY = 0.6135,
        type = "floor",
    },

    -- Zone: Aberrus, the Shadowed Crucible (map 2172)
    -- Aberrus, the Shadowed Crucible (map 2172 57.03,61.35) -> Aberrus, the Shadowed Crucible (map 2171 33.54,44.55) via floor
    {
        fromPointID = 1100178,
        fromMap = 2172,
        fromX = 0.5703,
        fromY = 0.6135,
        toPointID = 1100177,
        toMap = 2171,
        toX = 0.3354,
        toY = 0.4455,
        type = "floor",
    },

    -- Zone: Abundant Grotto (map 2522)
    -- Floaret Grotto (map 2522 31.91,85.85) -> Harandar (map 2413 66.17,61.69) via floor
    {
        fromPointID = 200810,
        fromMap = 2522,
        fromX = 0.3191,
        fromY = 0.8585,
        toPointID = 200704,
        toMap = 2413,
        toX = 0.6617,
        toY = 0.6169,
        type = "floor",
    },
    -- Floaret Grotto (map 2522 43.60,66.14) -> Floaret Grotto (map 2523 37.73,57.44) via floor
    {
        fromPointID = 200811,
        fromMap = 2522,
        fromX = 0.436,
        fromY = 0.6614,
        toPointID = 200812,
        toMap = 2523,
        toX = 0.3773,
        toY = 0.5744,
        type = "floor",
    },

    -- Zone: Abundant Grotto (map 2523)
    -- Floaret Grotto (map 2523 37.73,57.44) -> Floaret Grotto (map 2522 43.60,66.14) via floor
    {
        fromPointID = 200812,
        fromMap = 2523,
        fromX = 0.3773,
        fromY = 0.5744,
        toPointID = 200811,
        toMap = 2522,
        toX = 0.436,
        toY = 0.6614,
        type = "floor",
    },

    -- Zone: Ahn'Qiraj (map 319)
    -- Ahn'Qiraj (map 319 33.00,52.40) -> Ahn'Qiraj (map 321 50.50,73.00) via floor
    {
        fromPointID = 100395,
        fromMap = 319,
        fromX = 0.33,
        fromY = 0.524,
        toPointID = 100400,
        toMap = 321,
        toX = 0.505,
        toY = 0.73,
        type = "floor",
    },
    -- Ahn'Qiraj (map 319 34.60,45.00) -> Ahn'Qiraj (map 321 66.40,46.30) via floor
    {
        fromPointID = 100396,
        fromMap = 319,
        fromX = 0.346,
        fromY = 0.45,
        toPointID = 100401,
        toMap = 321,
        toX = 0.664,
        toY = 0.463,
        type = "floor",
    },

    -- Zone: Ahn'Qiraj (map 320)
    -- Ahn'Qiraj (map 320 49.20,63.30) -> Ahn'Qiraj (map 321 47.50,29.30) via floor
    {
        fromPointID = 100397,
        fromMap = 320,
        fromX = 0.492,
        fromY = 0.633,
        toPointID = 100399,
        toMap = 321,
        toX = 0.475,
        toY = 0.293,
        type = "floor",
    },

    -- Zone: Ahn'Qiraj (map 321)
    -- Ahn'Qiraj (map 321 47.50,29.30) -> Ahn'Qiraj (map 320 49.20,63.30) via floor
    {
        fromPointID = 100399,
        fromMap = 321,
        fromX = 0.475,
        fromY = 0.293,
        toPointID = 100397,
        toMap = 320,
        toX = 0.492,
        toY = 0.633,
        type = "floor",
    },
    -- Ahn'Qiraj (map 321 50.50,73.00) -> Ahn'Qiraj (map 319 33.00,52.40) via floor
    {
        fromPointID = 100400,
        fromMap = 321,
        fromX = 0.505,
        fromY = 0.73,
        toPointID = 100395,
        toMap = 319,
        toX = 0.33,
        toY = 0.524,
        type = "floor",
    },
    -- Ahn'Qiraj (map 321 66.40,46.30) -> Ahn'Qiraj (map 319 34.60,45.00) via floor
    {
        fromPointID = 100401,
        fromMap = 321,
        fromX = 0.664,
        fromY = 0.463,
        toPointID = 100396,
        toMap = 319,
        toX = 0.346,
        toY = 0.45,
        type = "floor",
    },

    -- Zone: Algeth'ar Academy (map 2097)
    -- Algeth'ar Academy (map 2097 16.11,24.29) -> Algeth'ar Academy (map 2099 57.02,72.26) via floor
    {
        fromPointID = 1100098,
        fromMap = 2097,
        fromX = 0.1611,
        fromY = 0.2429,
        toPointID = 1100102,
        toMap = 2099,
        toX = 0.5702,
        toY = 0.7226,
        type = "floor",
    },

    -- Zone: Algeth'ar Academy (map 2098)
    -- Algeth'ar Academy (map 2098 54.09,84.28) -> Algeth'ar Academy (map 2099 42.81,7.49) via floor
    {
        fromPointID = 1100099,
        fromMap = 2098,
        fromX = 0.5409,
        fromY = 0.8428,
        toPointID = 1100101,
        toMap = 2099,
        toX = 0.4281,
        toY = 0.0749,
        type = "floor",
    },
    -- Algeth'ar Academy (map 2098 54.09,84.28) -> Algeth'ar Academy (map 2099 60.02,28.46) via floor
    {
        fromPointID = 1100099,
        fromMap = 2098,
        fromX = 0.5409,
        fromY = 0.8428,
        toPointID = 1100103,
        toMap = 2099,
        toX = 0.6002,
        toY = 0.2846,
        type = "floor",
    },

    -- Zone: Algeth'ar Academy (map 2099)
    -- Algeth'ar Academy (map 2099 42.81,7.49) -> Algeth'ar Academy (map 2098 54.09,84.28) via floor
    {
        fromPointID = 1100101,
        fromMap = 2099,
        fromX = 0.4281,
        fromY = 0.0749,
        toPointID = 1100099,
        toMap = 2098,
        toX = 0.5409,
        toY = 0.8428,
        type = "floor",
    },
    -- Algeth'ar Academy (map 2099 57.02,72.26) -> Algeth'ar Academy (map 2097 16.11,24.29) via floor
    {
        fromPointID = 1100102,
        fromMap = 2099,
        fromX = 0.5702,
        fromY = 0.7226,
        toPointID = 1100098,
        toMap = 2097,
        toX = 0.1611,
        toY = 0.2429,
        type = "floor",
    },
    -- Algeth'ar Academy (map 2099 60.02,28.46) -> Algeth'ar Academy (map 2098 54.09,84.28) via floor
    {
        fromPointID = 1100103,
        fromMap = 2099,
        fromX = 0.6002,
        fromY = 0.2846,
        toPointID = 1100099,
        toMap = 2098,
        toX = 0.5409,
        toY = 0.8428,
        type = "floor",
    },

    -- Zone: Altar of Domination (map 1823)
    -- Altar of Domination (map 1823 89.73,34.52) -> The Maw (map 1543 23.01,68.40) via floor
    {
        fromPointID = 1000305,
        fromMap = 1823,
        fromX = 0.8973,
        fromY = 0.3452,
        toPointID = 1000090,
        toMap = 1543,
        toX = 0.2301,
        toY = 0.684,
        type = "floor",
    },

    -- Zone: Altar of Fangs (map 2588)
    -- Altar of Fangs (map 2588 49.07,90.03) -> Altar of Fangs (map 2589 43.69,12.27) via floor
    {
        fromPointID = 200860,
        fromMap = 2588,
        fromX = 0.4907,
        fromY = 0.9003,
        toPointID = 200861,
        toMap = 2589,
        toX = 0.4369,
        toY = 0.1227,
        type = "floor",
    },

    -- Zone: Altar of Fangs (map 2589)
    -- Altar of Fangs (map 2589 43.69,12.27) -> Altar of Fangs (map 2588 49.07,90.03) via floor
    {
        fromPointID = 200861,
        fromMap = 2589,
        fromX = 0.4369,
        fromY = 0.1227,
        toPointID = 200860,
        toMap = 2588,
        toX = 0.4907,
        toY = 0.9003,
        type = "floor",
    },
    -- Altar of Fangs (map 2589 67.72,62.84) -> Altar of Fangs (map 2590 62.94,62.59) via floor
    {
        fromPointID = 200862,
        fromMap = 2589,
        fromX = 0.6772,
        fromY = 0.6284,
        toPointID = 200863,
        toMap = 2590,
        toX = 0.6294,
        toY = 0.6259,
        type = "floor",
    },

    -- Zone: Altar of Fangs (map 2590)
    -- Altar of Fangs (map 2590 62.94,62.59) -> Altar of Fangs (map 2589 67.72,62.84) via floor
    {
        fromPointID = 200863,
        fromMap = 2590,
        fromX = 0.6294,
        fromY = 0.6259,
        toPointID = 200862,
        toMap = 2589,
        toX = 0.6772,
        toY = 0.6284,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2232)
    -- Amirdrassil, The Dream's Hope (map 2232 29.22,21.52) -> Amirdrassil, The Dream's Hope (map 2232 41.06,29.12) via floor
    {
        fromPointID = 1100206,
        fromMap = 2232,
        fromX = 0.2922,
        fromY = 0.2152,
        toPointID = 1100207,
        toMap = 2232,
        toX = 0.4106,
        toY = 0.2912,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2232 41.06,29.12) -> Amirdrassil, The Dream's Hope (map 2232 29.22,21.52) via floor
    {
        fromPointID = 1100207,
        fromMap = 2232,
        fromX = 0.4106,
        fromY = 0.2912,
        toPointID = 1100206,
        toMap = 2232,
        toX = 0.2922,
        toY = 0.2152,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2232 42.97,20.16) -> Amirdrassil, The Dream's Hope (map 2244 77.88,89.13) via floor
    {
        fromPointID = 1100208,
        fromMap = 2232,
        fromX = 0.4297,
        fromY = 0.2016,
        toPointID = 1100233,
        toMap = 2244,
        toX = 0.7788,
        toY = 0.8913,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2232 50.86,13.16) -> Amirdrassil, The Dream's Hope (map 2233 49.90,96.13) via floor
    {
        fromPointID = 1100209,
        fromMap = 2232,
        fromX = 0.5086,
        fromY = 0.1316,
        toPointID = 1100213,
        toMap = 2233,
        toX = 0.499,
        toY = 0.9613,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2232 58.39,20.16) -> Amirdrassil, The Dream's Hope (map 2240 17.38,95.59) via floor
    {
        fromPointID = 1100210,
        fromMap = 2232,
        fromX = 0.5839,
        fromY = 0.2016,
        toPointID = 1100231,
        toMap = 2240,
        toX = 0.1738,
        toY = 0.9559,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2232 60.07,29.30) -> Amirdrassil, The Dream's Hope (map 2240 67.48,22.42) via floor
    {
        fromPointID = 1100211,
        fromMap = 2232,
        fromX = 0.6007,
        fromY = 0.293,
        toPointID = 1100232,
        toMap = 2240,
        toX = 0.6748,
        toY = 0.2242,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2233)
    -- Amirdrassil, The Dream's Hope (map 2233 46.68,33.00) -> Amirdrassil, The Dream's Hope (map 2234 36.70,87.83) via floor
    {
        fromPointID = 1100212,
        fromMap = 2233,
        fromX = 0.4668,
        fromY = 0.33,
        toPointID = 1100214,
        toMap = 2234,
        toX = 0.367,
        toY = 0.8783,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2233 49.90,96.13) -> Amirdrassil, The Dream's Hope (map 2232 50.86,13.16) via floor
    {
        fromPointID = 1100213,
        fromMap = 2233,
        fromX = 0.499,
        fromY = 0.9613,
        toPointID = 1100209,
        toMap = 2232,
        toX = 0.5086,
        toY = 0.1316,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2234)
    -- Amirdrassil, The Dream's Hope (map 2234 36.70,87.83) -> Amirdrassil, The Dream's Hope (map 2233 46.68,33.00) via floor
    {
        fromPointID = 1100214,
        fromMap = 2234,
        fromX = 0.367,
        fromY = 0.8783,
        toPointID = 1100212,
        toMap = 2233,
        toX = 0.4668,
        toY = 0.33,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2234 38.06,88.32) -> Amirdrassil, The Dream's Hope (map 2237 28.62,38.92) via floor
    {
        fromPointID = 1100215,
        fromMap = 2234,
        fromX = 0.3806,
        fromY = 0.8832,
        toPointID = 1100221,
        toMap = 2237,
        toX = 0.2862,
        toY = 0.3892,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2234 47.27,43.47) -> Amirdrassil, The Dream's Hope (map 2235 34.12,32.46) via floor
    {
        fromPointID = 1100216,
        fromMap = 2234,
        fromX = 0.4727,
        fromY = 0.4347,
        toPointID = 1100219,
        toMap = 2235,
        toX = 0.3412,
        toY = 0.3246,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2234 61.46,64.47) -> Amirdrassil, The Dream's Hope (map 2238 67.12,89.67) via floor
    {
        fromPointID = 1100217,
        fromMap = 2234,
        fromX = 0.6146,
        fromY = 0.6447,
        toPointID = 1100222,
        toMap = 2238,
        toX = 0.6712,
        toY = 0.8967,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2234 62.10,64.81) -> Amirdrassil, The Dream's Hope (map 2236 29.70,50.93) via floor
    {
        fromPointID = 1100218,
        fromMap = 2234,
        fromX = 0.621,
        fromY = 0.6481,
        toPointID = 1100220,
        toMap = 2236,
        toX = 0.297,
        toY = 0.5093,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2238)
    -- Amirdrassil, The Dream's Hope (map 2238 67.12,89.67) -> Amirdrassil, The Dream's Hope (map 2234 61.46,64.47) via floor
    {
        fromPointID = 1100222,
        fromMap = 2238,
        fromX = 0.6712,
        fromY = 0.8967,
        toPointID = 1100217,
        toMap = 2234,
        toX = 0.6146,
        toY = 0.6447,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2238 67.12,89.67) -> Amirdrassil, The Dream's Hope (map 2236 29.70,50.93) via floor
    {
        fromPointID = 1100222,
        fromMap = 2238,
        fromX = 0.6712,
        fromY = 0.8967,
        toPointID = 1100220,
        toMap = 2236,
        toX = 0.297,
        toY = 0.5093,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2240)
    -- Amirdrassil, The Dream's Hope (map 2240 17.38,95.59) -> Amirdrassil, The Dream's Hope (map 2232 58.39,20.16) via floor
    {
        fromPointID = 1100231,
        fromMap = 2240,
        fromX = 0.1738,
        fromY = 0.9559,
        toPointID = 1100210,
        toMap = 2232,
        toX = 0.5839,
        toY = 0.2016,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2240 67.48,22.42) -> Amirdrassil, The Dream's Hope (map 2232 60.07,29.30) via floor
    {
        fromPointID = 1100232,
        fromMap = 2240,
        fromX = 0.6748,
        fromY = 0.2242,
        toPointID = 1100211,
        toMap = 2232,
        toX = 0.6007,
        toY = 0.293,
        type = "floor",
    },

    -- Zone: Amirdrassil (map 2244)
    -- Amirdrassil, The Dream's Hope (map 2244 77.88,89.13) -> Amirdrassil, The Dream's Hope (map 2232 42.97,20.16) via floor
    {
        fromPointID = 1100233,
        fromMap = 2244,
        fromX = 0.7788,
        fromY = 0.8913,
        toPointID = 1100208,
        toMap = 2232,
        toX = 0.4297,
        toY = 0.2016,
        type = "floor",
    },

    -- Zone: Archival Assault (map 2452)
    -- Archival Assault (map 2452 52.38,59.72) -> Archival Assault (map 2454 45.60,53.42) via floor
    {
        fromPointID = 1200198,
        fromMap = 2452,
        fromX = 0.5238,
        fromY = 0.5972,
        toPointID = 1200201,
        toMap = 2454,
        toX = 0.456,
        toY = 0.5342,
        type = "floor",
    },
    -- Archival Assault (map 2452 61.50,21.23) -> Archival Assault (map 2453 54.09,31.03) via floor
    {
        fromPointID = 1200199,
        fromMap = 2452,
        fromX = 0.615,
        fromY = 0.2123,
        toPointID = 1200200,
        toMap = 2453,
        toX = 0.5409,
        toY = 0.3103,
        type = "floor",
    },

    -- Zone: Archival Assault (map 2453)
    -- Archival Assault (map 2453 54.09,31.03) -> Archival Assault (map 2452 61.50,21.23) via floor
    {
        fromPointID = 1200200,
        fromMap = 2453,
        fromX = 0.5409,
        fromY = 0.3103,
        toPointID = 1200199,
        toMap = 2452,
        toX = 0.615,
        toY = 0.2123,
        type = "floor",
    },

    -- Zone: Archival Assault (map 2454)
    -- Archival Assault (map 2454 45.60,53.42) -> Archival Assault (map 2452 52.38,59.72) via floor
    {
        fromPointID = 1200201,
        fromMap = 2454,
        fromX = 0.456,
        fromY = 0.5342,
        toPointID = 1200198,
        toMap = 2452,
        toX = 0.5238,
        toY = 0.5972,
        type = "floor",
    },
    -- Archival Assault (map 2454 49.34,54.84) -> Archival Assault (map 2455 41.94,50.37) via floor
    {
        fromPointID = 1200202,
        fromMap = 2454,
        fromX = 0.4934,
        fromY = 0.5484,
        toPointID = 1200203,
        toMap = 2455,
        toX = 0.4194,
        toY = 0.5037,
        type = "floor",
    },

    -- Zone: Archival Assault (map 2455)
    -- Archival Assault (map 2455 41.94,50.37) -> Archival Assault (map 2454 49.34,54.84) via floor
    {
        fromPointID = 1200203,
        fromMap = 2455,
        fromX = 0.4194,
        fromY = 0.5037,
        toPointID = 1200202,
        toMap = 2454,
        toX = 0.4934,
        toY = 0.5484,
        type = "floor",
    },
    -- Archival Assault (map 2455 45.00,50.19) -> Archival Assault (map 2476 51.84,51.84) via floor
    {
        fromPointID = 1200204,
        fromMap = 2455,
        fromX = 0.45,
        fromY = 0.5019,
        toPointID = 1200237,
        toMap = 2476,
        toX = 0.5184,
        toY = 0.5184,
        type = "floor",
    },

    -- Zone: Archival Assault (map 2476)
    -- Archival Assault (map 2476 51.84,51.84) -> Archival Assault (map 2455 45.00,50.19) via floor
    {
        fromPointID = 1200237,
        fromMap = 2476,
        fromX = 0.5184,
        fromY = 0.5184,
        toPointID = 1200204,
        toMap = 2455,
        toX = 0.45,
        toY = 0.5019,
        type = "floor",
    },

    -- Zone: Auchenai Crypts (map 256)
    -- Auchenai Crypts (map 256 44.67,17.68) -> Auchenai Crypts (map 257 22.77,12.22) via floor
    {
        fromPointID = 300112,
        fromMap = 256,
        fromX = 0.4467,
        fromY = 0.1768,
        toPointID = 300113,
        toMap = 257,
        toX = 0.2277,
        toY = 0.1222,
        type = "floor",
    },

    -- Zone: Auchenai Crypts (map 257)
    -- Auchenai Crypts (map 257 22.77,12.22) -> Auchenai Crypts (map 256 44.67,17.68) via floor
    {
        fromPointID = 300113,
        fromMap = 257,
        fromX = 0.2277,
        fromY = 0.1222,
        toPointID = 300112,
        toMap = 256,
        toX = 0.4467,
        toY = 0.1768,
        type = "floor",
    },

    -- Zone: Augurs' Terrace (map 2434)
    -- Murder Row (map 2434 30.18,53.26) -> Murder Row (map 2435 46.56,82.21) via floor
    {
        fromPointID = 200717,
        fromMap = 2434,
        fromX = 0.3018,
        fromY = 0.5326,
        toPointID = 200718,
        toMap = 2435,
        toX = 0.4656,
        toY = 0.8221,
        type = "floor",
    },

    -- Zone: Azj-Kahet - Lower (map 2256)
    -- Azj-Kahet (map 2256 61.42,75.73) -> Azj-Kahet (map 2255 64.22,75.90) via floor
    {
        fromPointID = 1200076,
        fromMap = 2256,
        fromX = 0.6142,
        fromY = 0.7573,
        toPointID = 1200069,
        toMap = 2255,
        toX = 0.6422,
        toY = 0.759,
        type = "floor",
        travelDuration = 0,
    },

    -- Zone: Azj-Kahet (map 2255)
    -- Azj-Kahet (map 2255 64.22,75.90) -> Azj-Kahet (map 2256 61.42,75.73) via floor
    {
        fromPointID = 1200069,
        fromMap = 2255,
        fromX = 0.6422,
        fromY = 0.759,
        toPointID = 1200076,
        toMap = 2256,
        toX = 0.6142,
        toY = 0.7573,
        type = "floor",
        travelDuration = 0,
    },

    -- Zone: Azjol-Nerub (map 158)
    -- Azjol-Nerub (map 158 41.00,37.30) -> Azjol-Nerub (map 159 70.60,31.60) via floor
    {
        fromPointID = 400184,
        fromMap = 158,
        fromX = 0.41,
        fromY = 0.373,
        toPointID = 400187,
        toMap = 159,
        toX = 0.706,
        toY = 0.316,
        type = "floor",
    },
    -- Azjol-Nerub (map 158 50.30,60.40) -> Azjol-Nerub (map 157 22.00,50.70) via floor
    {
        fromPointID = 400185,
        fromMap = 158,
        fromX = 0.503,
        fromY = 0.604,
        toPointID = 400182,
        toMap = 157,
        toX = 0.22,
        toY = 0.507,
        type = "floor",
    },

    -- Zone: Azjol-Nerub (map 159)
    -- Azjol-Nerub (map 159 70.60,31.60) -> Azjol-Nerub (map 158 41.00,37.30) via floor
    {
        fromPointID = 400187,
        fromMap = 159,
        fromX = 0.706,
        fromY = 0.316,
        toPointID = 400184,
        toMap = 158,
        toX = 0.41,
        toY = 0.373,
        type = "floor",
    },

    -- Zone: Azuremyst Isle (map 97)
    -- Azuremyst Isle (map 97 27.01,76.61) -> Azuremyst Isle (map 98 58.76,85.37) via floor
    {
        fromPointID = 100305,
        fromMap = 97,
        fromX = 0.2701,
        fromY = 0.7661,
        toPointID = 100310,
        toMap = 98,
        toX = 0.5876,
        toY = 0.8537,
        type = "floor",
    },
    -- Azuremyst Isle (map 97 45.34,19.54) -> Azuremyst Isle (map 99 21.11,91.45) via floor
    {
        fromPointID = 100308,
        fromMap = 97,
        fromX = 0.4534,
        fromY = 0.1954,
        toPointID = 100311,
        toMap = 99,
        toX = 0.2111,
        toY = 0.9145,
        type = "floor",
    },

    -- Zone: Badlands (map 15)
    -- Badlands (map 15 41.60,11.60) -> Badlands (map 16 75.60,36.50) via floor
    {
        fromPointID = 200018,
        fromMap = 15,
        fromX = 0.416,
        fromY = 0.116,
        toPointID = 200033,
        toMap = 16,
        toX = 0.756,
        toY = 0.365,
        type = "floor",
    },

    -- Zone: Ban'ethil Barrow Den (map 60)
    -- Teldrassil (map 60 24.60,86.00) -> Teldrassil (map 60 38.80,56.80) via floor
    {
        fromPointID = 100075,
        fromMap = 60,
        fromX = 0.246,
        fromY = 0.86,
        toPointID = 100077,
        toMap = 60,
        toX = 0.388,
        toY = 0.568,
        type = "floor",
    },
    -- Teldrassil (map 60 24.60,86.00) -> Teldrassil (map 60 52.60,15.50) via floor
    {
        fromPointID = 100075,
        fromMap = 60,
        fromX = 0.246,
        fromY = 0.86,
        toPointID = 100078,
        toMap = 60,
        toX = 0.526,
        toY = 0.155,
        type = "floor",
    },
    -- Teldrassil (map 60 24.60,86.00) -> Teldrassil (map 60 54.20,36.50) via floor
    {
        fromPointID = 100075,
        fromMap = 60,
        fromX = 0.246,
        fromY = 0.86,
        toPointID = 100079,
        toMap = 60,
        toX = 0.542,
        toY = 0.365,
        type = "floor",
    },
    -- Teldrassil (map 60 24.60,86.00) -> Teldrassil (map 61 29.90,76.40) via floor
    {
        fromPointID = 100075,
        fromMap = 60,
        fromX = 0.246,
        fromY = 0.86,
        toPointID = 100080,
        toMap = 61,
        toX = 0.299,
        toY = 0.764,
        type = "floor",
    },
    -- Teldrassil (map 60 25.90,34.20) -> Teldrassil (map 60 38.80,56.80) via floor
    {
        fromPointID = 100076,
        fromMap = 60,
        fromX = 0.259,
        fromY = 0.342,
        toPointID = 100077,
        toMap = 60,
        toX = 0.388,
        toY = 0.568,
        type = "floor",
    },
    -- Teldrassil (map 60 25.90,34.20) -> Teldrassil (map 60 52.60,15.50) via floor
    {
        fromPointID = 100076,
        fromMap = 60,
        fromX = 0.259,
        fromY = 0.342,
        toPointID = 100078,
        toMap = 60,
        toX = 0.526,
        toY = 0.155,
        type = "floor",
    },
    -- Teldrassil (map 60 38.80,56.80) -> Teldrassil (map 60 24.60,86.00) via floor
    {
        fromPointID = 100077,
        fromMap = 60,
        fromX = 0.388,
        fromY = 0.568,
        toPointID = 100075,
        toMap = 60,
        toX = 0.246,
        toY = 0.86,
        type = "floor",
    },
    -- Teldrassil (map 60 38.80,56.80) -> Teldrassil (map 60 25.90,34.20) via floor
    {
        fromPointID = 100077,
        fromMap = 60,
        fromX = 0.388,
        fromY = 0.568,
        toPointID = 100076,
        toMap = 60,
        toX = 0.259,
        toY = 0.342,
        type = "floor",
    },
    -- Teldrassil (map 60 38.80,56.80) -> Teldrassil (map 60 54.20,36.50) via floor
    {
        fromPointID = 100077,
        fromMap = 60,
        fromX = 0.388,
        fromY = 0.568,
        toPointID = 100079,
        toMap = 60,
        toX = 0.542,
        toY = 0.365,
        type = "floor",
    },
    -- Teldrassil (map 60 52.60,15.50) -> Teldrassil (map 57 45.60,50.60) via floor
    {
        fromPointID = 100078,
        fromMap = 60,
        fromX = 0.526,
        fromY = 0.155,
        toPointID = 100066,
        toMap = 57,
        toX = 0.456,
        toY = 0.506,
        type = "floor",
    },
    -- Teldrassil (map 60 52.60,15.50) -> Teldrassil (map 60 24.60,86.00) via floor
    {
        fromPointID = 100078,
        fromMap = 60,
        fromX = 0.526,
        fromY = 0.155,
        toPointID = 100075,
        toMap = 60,
        toX = 0.246,
        toY = 0.86,
        type = "floor",
    },
    -- Teldrassil (map 60 52.60,15.50) -> Teldrassil (map 60 25.90,34.20) via floor
    {
        fromPointID = 100078,
        fromMap = 60,
        fromX = 0.526,
        fromY = 0.155,
        toPointID = 100076,
        toMap = 60,
        toX = 0.259,
        toY = 0.342,
        type = "floor",
    },
    -- Teldrassil (map 60 52.60,15.50) -> Teldrassil (map 60 54.20,36.50) via floor
    {
        fromPointID = 100078,
        fromMap = 60,
        fromX = 0.526,
        fromY = 0.155,
        toPointID = 100079,
        toMap = 60,
        toX = 0.542,
        toY = 0.365,
        type = "floor",
    },
    -- Teldrassil (map 60 54.20,36.50) -> Teldrassil (map 60 24.60,86.00) via floor
    {
        fromPointID = 100079,
        fromMap = 60,
        fromX = 0.542,
        fromY = 0.365,
        toPointID = 100075,
        toMap = 60,
        toX = 0.246,
        toY = 0.86,
        type = "floor",
    },
    -- Teldrassil (map 60 54.20,36.50) -> Teldrassil (map 60 38.80,56.80) via floor
    {
        fromPointID = 100079,
        fromMap = 60,
        fromX = 0.542,
        fromY = 0.365,
        toPointID = 100077,
        toMap = 60,
        toX = 0.388,
        toY = 0.568,
        type = "floor",
    },
    -- Teldrassil (map 60 54.20,36.50) -> Teldrassil (map 60 52.60,15.50) via floor
    {
        fromPointID = 100079,
        fromMap = 60,
        fromX = 0.542,
        fromY = 0.365,
        toPointID = 100078,
        toMap = 60,
        toX = 0.526,
        toY = 0.155,
        type = "floor",
    },
    -- Teldrassil (map 60 54.20,36.50) -> Teldrassil (map 61 46.70,39.70) via floor
    {
        fromPointID = 100079,
        fromMap = 60,
        fromX = 0.542,
        fromY = 0.365,
        toPointID = 100081,
        toMap = 61,
        toX = 0.467,
        toY = 0.397,
        type = "floor",
    },

    -- Zone: Ban'ethil Barrow Den (map 61)
    -- Teldrassil (map 61 29.90,76.40) -> Teldrassil (map 60 24.60,86.00) via floor
    {
        fromPointID = 100080,
        fromMap = 61,
        fromX = 0.299,
        fromY = 0.764,
        toPointID = 100075,
        toMap = 60,
        toX = 0.246,
        toY = 0.86,
        type = "floor",
    },
    -- Teldrassil (map 61 46.70,39.70) -> Teldrassil (map 60 54.20,36.50) via floor
    {
        fromPointID = 100081,
        fromMap = 61,
        fromX = 0.467,
        fromY = 0.397,
        toPointID = 100079,
        toMap = 60,
        toX = 0.542,
        toY = 0.365,
        type = "floor",
    },

    -- Zone: Barrows of Reverie (map 2254)
    -- Barrows of Reverie (map 2254 67.41,21.23) -> The Emerald Dream (map 2200 63.47,71.71) via floor
    {
        fromPointID = 1100235,
        fromMap = 2254,
        fromX = 0.6741,
        fromY = 0.2123,
        toPointID = 1100202,
        toMap = 2200,
        toX = 0.6347,
        toY = 0.7171,
        type = "floor",
    },

    -- Zone: Bastion (map 1533)
    -- Bastion (map 1533 43.52,38.60) -> Third Chamber of Kalliope (map 1714 25.68,88.78) via floor
    {
        fromPointID = 1000037,
        fromMap = 1533,
        fromX = 0.4352,
        fromY = 0.386,
        toPointID = 1000275,
        toMap = 1714,
        toX = 0.2568,
        toY = 0.8878,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57875,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57914,
                },
            },
        },
    },
    -- Bastion (map 1533 44.03,24.70) -> Path of Wisdom (map 1713 48.04,90.71) via floor
    {
        fromPointID = 1000038,
        fromMap = 1533,
        fromX = 0.4403,
        fromY = 0.247,
        toPointID = 1000274,
        toMap = 1713,
        toX = 0.4804,
        toY = 0.9071,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1352)
    -- Battle of Dazar'alor (map 1352 49.09,11.84) -> Battle of Dazar'alor (map 1353 42.14,86.65) via floor
    {
        fromPointID = 900100,
        fromMap = 1352,
        fromX = 0.4909,
        fromY = 0.1184,
        toPointID = 900103,
        toMap = 1353,
        toX = 0.4214,
        toY = 0.8665,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1353)
    -- Battle of Dazar'alor (map 1353 33.37,8.70) -> Battle of Dazar'alor (map 1354 47.44,15.53) via floor
    {
        fromPointID = 900102,
        fromMap = 1353,
        fromX = 0.3337,
        fromY = 0.087,
        toPointID = 900104,
        toMap = 1354,
        toX = 0.4744,
        toY = 0.1553,
        type = "floor",
    },
    -- Battle of Dazar'alor (map 1353 42.14,86.65) -> Battle of Dazar'alor (map 1352 49.09,11.84) via floor
    {
        fromPointID = 900103,
        fromMap = 1353,
        fromX = 0.4214,
        fromY = 0.8665,
        toPointID = 900100,
        toMap = 1352,
        toX = 0.4909,
        toY = 0.1184,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1354)
    -- Battle of Dazar'alor (map 1354 47.44,15.53) -> Battle of Dazar'alor (map 1353 33.37,8.70) via floor
    {
        fromPointID = 900104,
        fromMap = 1354,
        fromX = 0.4744,
        fromY = 0.1553,
        toPointID = 900102,
        toMap = 1353,
        toX = 0.3337,
        toY = 0.087,
        type = "floor",
    },
    -- Battle of Dazar'alor (map 1354 64.19,80.61) -> Battle of Dazar'alor (map 1356 64.82,70.72) via floor
    {
        fromPointID = 900105,
        fromMap = 1354,
        fromX = 0.6419,
        fromY = 0.8061,
        toPointID = 900107,
        toMap = 1356,
        toX = 0.6482,
        toY = 0.7072,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1356)
    -- Battle of Dazar'alor (map 1356 36.14,58.85) -> Battle of Dazar'alor (map 1357 47.44,42.53) via floor
    {
        fromPointID = 900106,
        fromMap = 1356,
        fromX = 0.3614,
        fromY = 0.5885,
        toPointID = 900109,
        toMap = 1357,
        toX = 0.4744,
        toY = 0.4253,
        type = "floor",
    },
    -- Battle of Dazar'alor (map 1356 64.82,70.72) -> Battle of Dazar'alor (map 1354 64.19,80.61) via floor
    {
        fromPointID = 900107,
        fromMap = 1356,
        fromX = 0.6482,
        fromY = 0.7072,
        toPointID = 900105,
        toMap = 1354,
        toX = 0.6419,
        toY = 0.8061,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1357)
    -- Battle of Dazar'alor (map 1357 47.38,16.42) -> Battle of Dazar'alor (map 1358 48.93,75.17) via floor
    {
        fromPointID = 900108,
        fromMap = 1357,
        fromX = 0.4738,
        fromY = 0.1642,
        toPointID = 900110,
        toMap = 1358,
        toX = 0.4893,
        toY = 0.7517,
        type = "floor",
    },
    -- Battle of Dazar'alor (map 1357 47.44,42.53) -> Battle of Dazar'alor (map 1356 36.14,58.85) via floor
    {
        fromPointID = 900109,
        fromMap = 1357,
        fromX = 0.4744,
        fromY = 0.4253,
        toPointID = 900106,
        toMap = 1356,
        toX = 0.3614,
        toY = 0.5885,
        type = "floor",
    },

    -- Zone: Battle of Dazar'alor (map 1358)
    -- Battle of Dazar'alor (map 1358 48.93,75.17) -> Battle of Dazar'alor (map 1357 47.38,16.42) via floor
    {
        fromPointID = 900110,
        fromMap = 1358,
        fromX = 0.4893,
        fromY = 0.7517,
        toPointID = 900108,
        toMap = 1357,
        toX = 0.4738,
        toY = 0.1642,
        type = "floor",
    },

    -- Zone: Black Temple (map 339)
    -- Black Temple (map 339 28.02,74.29) -> Black Temple (map 340 29.58,19.61) via floor
    {
        fromPointID = 300147,
        fromMap = 339,
        fromX = 0.2802,
        fromY = 0.7429,
        toPointID = 300150,
        toMap = 340,
        toX = 0.2958,
        toY = 0.1961,
        type = "floor",
    },
    -- Black Temple (map 339 63.09,45.70) -> Black Temple (map 341 24.31,50.07) via floor
    {
        fromPointID = 300148,
        fromMap = 339,
        fromX = 0.6309,
        fromY = 0.457,
        toPointID = 300151,
        toMap = 341,
        toX = 0.2431,
        toY = 0.5007,
        type = "floor",
    },

    -- Zone: Black Temple (map 340)
    -- Black Temple (map 340 29.58,19.61) -> Black Temple (map 339 28.02,74.29) via floor
    {
        fromPointID = 300150,
        fromMap = 340,
        fromX = 0.2958,
        fromY = 0.1961,
        toPointID = 300147,
        toMap = 339,
        toX = 0.2802,
        toY = 0.7429,
        type = "floor",
    },

    -- Zone: Black Temple (map 341)
    -- Black Temple (map 341 24.31,50.07) -> Black Temple (map 339 63.09,45.70) via floor
    {
        fromPointID = 300151,
        fromMap = 341,
        fromX = 0.2431,
        fromY = 0.5007,
        toPointID = 300148,
        toMap = 339,
        toX = 0.6309,
        toY = 0.457,
        type = "floor",
    },
    -- Black Temple (map 341 26.28,21.71) -> Black Temple (map 344 8.40,59.62) via floor
    {
        fromPointID = 300152,
        fromMap = 341,
        fromX = 0.2628,
        fromY = 0.2171,
        toPointID = 300157,
        toMap = 344,
        toX = 0.084,
        toY = 0.5962,
        type = "floor",
    },
    -- Black Temple (map 341 58.48,91.11) -> Black Temple (map 343 66.89,68.26) via floor
    {
        fromPointID = 300153,
        fromMap = 341,
        fromX = 0.5848,
        fromY = 0.9111,
        toPointID = 300156,
        toMap = 343,
        toX = 0.6689,
        toY = 0.6826,
        type = "floor",
    },
    -- Black Temple (map 341 61.32,34.65) -> Black Temple (map 342 64.35,39.46) via floor
    {
        fromPointID = 300154,
        fromMap = 341,
        fromX = 0.6132,
        fromY = 0.3465,
        toPointID = 300155,
        toMap = 342,
        toX = 0.6435,
        toY = 0.3946,
        type = "floor",
    },

    -- Zone: Black Temple (map 342)
    -- Black Temple (map 342 64.35,39.46) -> Black Temple (map 341 61.32,34.65) via floor
    {
        fromPointID = 300155,
        fromMap = 342,
        fromX = 0.6435,
        fromY = 0.3946,
        toPointID = 300154,
        toMap = 341,
        toX = 0.6132,
        toY = 0.3465,
        type = "floor",
    },

    -- Zone: Black Temple (map 343)
    -- Black Temple (map 343 66.89,68.26) -> Black Temple (map 341 58.48,91.11) via floor
    {
        fromPointID = 300156,
        fromMap = 343,
        fromX = 0.6689,
        fromY = 0.6826,
        toPointID = 300153,
        toMap = 341,
        toX = 0.5848,
        toY = 0.9111,
        type = "floor",
    },

    -- Zone: Black Temple (map 344)
    -- Black Temple (map 344 8.40,59.62) -> Black Temple (map 341 26.28,21.71) via floor
    {
        fromPointID = 300157,
        fromMap = 344,
        fromX = 0.084,
        fromY = 0.5962,
        toPointID = 300152,
        toMap = 341,
        toX = 0.2628,
        toY = 0.2171,
        type = "floor",
    },
    -- Black Temple (map 344 67.17,51.10) -> Black Temple (map 345 69.01,16.15) via floor
    {
        fromPointID = 300158,
        fromMap = 344,
        fromX = 0.6717,
        fromY = 0.511,
        toPointID = 300160,
        toMap = 345,
        toX = 0.6901,
        toY = 0.1615,
        type = "floor",
    },

    -- Zone: Black Temple (map 345)
    -- Black Temple (map 345 46.72,35.00) -> Black Temple (map 346 52.69,20.84) via floor
    {
        fromPointID = 300159,
        fromMap = 345,
        fromX = 0.4672,
        fromY = 0.35,
        toPointID = 300161,
        toMap = 346,
        toX = 0.5269,
        toY = 0.2084,
        type = "floor",
    },
    -- Black Temple (map 345 69.01,16.15) -> Black Temple (map 344 67.17,51.10) via floor
    {
        fromPointID = 300160,
        fromMap = 345,
        fromX = 0.6901,
        fromY = 0.1615,
        toPointID = 300158,
        toMap = 344,
        toX = 0.6717,
        toY = 0.511,
        type = "floor",
    },

    -- Zone: Black Temple (map 346)
    -- Black Temple (map 346 52.69,20.84) -> Black Temple (map 345 46.72,35.00) via floor
    {
        fromPointID = 300161,
        fromMap = 346,
        fromX = 0.5269,
        fromY = 0.2084,
        toPointID = 300159,
        toMap = 345,
        toX = 0.4672,
        toY = 0.35,
        type = "floor",
    },

    -- Zone: Blackfathom Deeps (map 221)
    -- Blackfathom Deeps (map 221 61.51,71.88) -> Blackfathom Deeps (map 222 39.21,31.65) via floor
    {
        fromPointID = 100345,
        fromMap = 221,
        fromX = 0.6151,
        fromY = 0.7188,
        toPointID = 100346,
        toMap = 222,
        toX = 0.3921,
        toY = 0.3165,
        type = "floor",
    },

    -- Zone: Blackfathom Deeps (map 222)
    -- Blackfathom Deeps (map 222 39.21,31.65) -> Blackfathom Deeps (map 221 61.51,71.88) via floor
    {
        fromPointID = 100346,
        fromMap = 222,
        fromX = 0.3921,
        fromY = 0.3165,
        toPointID = 100345,
        toMap = 221,
        toX = 0.6151,
        toY = 0.7188,
        type = "floor",
    },
    -- Blackfathom Deeps (map 222 47.24,79.12) -> Blackfathom Deeps (map 223 43.60,61.06) via floor
    {
        fromPointID = 100347,
        fromMap = 222,
        fromX = 0.4724,
        fromY = 0.7912,
        toPointID = 100348,
        toMap = 223,
        toX = 0.436,
        toY = 0.6106,
        type = "floor",
    },

    -- Zone: Blackfathom Deeps (map 223)
    -- Blackfathom Deeps (map 223 43.60,61.06) -> Blackfathom Deeps (map 222 47.24,79.12) via floor
    {
        fromPointID = 100348,
        fromMap = 223,
        fromX = 0.436,
        fromY = 0.6106,
        toPointID = 100347,
        toMap = 222,
        toX = 0.4724,
        toY = 0.7912,
        type = "floor",
    },

    -- Zone: Blackrock Caverns (map 283)
    -- Blackrock Caverns (map 283 49.93,12.98) -> Blackrock Caverns (map 284 29.37,13.13) via floor
    {
        fromPointID = 200497,
        fromMap = 283,
        fromX = 0.4993,
        fromY = 0.1298,
        toPointID = 200499,
        toMap = 284,
        toX = 0.2937,
        toY = 0.1313,
        type = "floor",
    },
    -- Blackrock Caverns (map 283 52.05,20.12) -> Blackrock Caverns (map 284 29.97,17.32) via floor
    {
        fromPointID = 200498,
        fromMap = 283,
        fromX = 0.5205,
        fromY = 0.2012,
        toPointID = 200500,
        toMap = 284,
        toX = 0.2997,
        toY = 0.1732,
        type = "floor",
    },

    -- Zone: Blackrock Caverns (map 284)
    -- Blackrock Caverns (map 284 29.37,13.13) -> Blackrock Caverns (map 283 49.93,12.98) via floor
    {
        fromPointID = 200499,
        fromMap = 284,
        fromX = 0.2937,
        fromY = 0.1313,
        toPointID = 200497,
        toMap = 283,
        toX = 0.4993,
        toY = 0.1298,
        type = "floor",
    },

    -- Zone: Blackrock Depths (map 242)
    -- Blackrock Depths (map 242 40.70,67.10) -> Blackrock Depths (map 243 41.80,92.40) via floor
    {
        fromPointID = 200432,
        fromMap = 242,
        fromX = 0.407,
        fromY = 0.671,
        toPointID = 200448,
        toMap = 243,
        toX = 0.418,
        toY = 0.924,
        type = "floor",
    },
    -- Blackrock Depths (map 242 41.60,39.10) -> Blackrock Depths (map 243 41.40,68.10) via floor
    {
        fromPointID = 200433,
        fromMap = 242,
        fromX = 0.416,
        fromY = 0.391,
        toPointID = 200447,
        toMap = 243,
        toX = 0.414,
        toY = 0.681,
        type = "floor",
    },
    -- Blackrock Depths (map 242 42.50,46.30) -> Blackrock Depths (map 243 42.30,73.60) via floor
    {
        fromPointID = 200434,
        fromMap = 242,
        fromX = 0.425,
        fromY = 0.463,
        toPointID = 200449,
        toMap = 243,
        toX = 0.423,
        toY = 0.736,
        type = "floor",
    },
    -- Blackrock Depths (map 242 45.00,64.30) -> Blackrock Depths (map 243 44.50,91.10) via floor
    {
        fromPointID = 200435,
        fromMap = 242,
        fromX = 0.45,
        fromY = 0.643,
        toPointID = 200450,
        toMap = 243,
        toX = 0.445,
        toY = 0.911,
        type = "floor",
    },
    -- Blackrock Depths (map 242 45.40,63.10) -> Blackrock Depths (map 243 44.60,90.00) via floor
    {
        fromPointID = 200436,
        fromMap = 242,
        fromX = 0.454,
        fromY = 0.631,
        toPointID = 200451,
        toMap = 243,
        toX = 0.446,
        toY = 0.9,
        type = "floor",
    },
    -- Blackrock Depths (map 242 46.60,52.50) -> Blackrock Depths (map 243 47.50,81.10) via floor
    {
        fromPointID = 200437,
        fromMap = 242,
        fromX = 0.466,
        fromY = 0.525,
        toPointID = 200453,
        toMap = 243,
        toX = 0.475,
        toY = 0.811,
        type = "floor",
    },
    -- Blackrock Depths (map 242 53.00,31.80) -> Blackrock Depths (map 243 53.00,61.50) via floor
    {
        fromPointID = 200438,
        fromMap = 242,
        fromX = 0.53,
        fromY = 0.318,
        toPointID = 200454,
        toMap = 243,
        toX = 0.53,
        toY = 0.615,
        type = "floor",
    },
    -- Blackrock Depths (map 242 54.00,27.00) -> Blackrock Depths (map 243 53.20,55.60) via floor
    {
        fromPointID = 200439,
        fromMap = 242,
        fromX = 0.54,
        fromY = 0.27,
        toPointID = 200455,
        toMap = 243,
        toX = 0.532,
        toY = 0.556,
        type = "floor",
    },
    -- Blackrock Depths (map 242 54.80,62.90) -> Blackrock Depths (map 243 55.20,89.90) via floor
    {
        fromPointID = 200440,
        fromMap = 242,
        fromX = 0.548,
        fromY = 0.629,
        toPointID = 200457,
        toMap = 243,
        toX = 0.552,
        toY = 0.899,
        type = "floor",
    },
    -- Blackrock Depths (map 242 55.00,35.60) -> Blackrock Depths (map 243 54.20,65.60) via floor
    {
        fromPointID = 200441,
        fromMap = 242,
        fromX = 0.55,
        fromY = 0.356,
        toPointID = 200456,
        toMap = 243,
        toX = 0.542,
        toY = 0.656,
        type = "floor",
    },
    -- Blackrock Depths (map 242 56.90,51.30) -> Blackrock Depths (map 243 56.40,77.50) via floor
    {
        fromPointID = 200442,
        fromMap = 242,
        fromX = 0.569,
        fromY = 0.513,
        toPointID = 200458,
        toMap = 243,
        toX = 0.564,
        toY = 0.775,
        type = "floor",
    },
    -- Blackrock Depths (map 242 57.30,57.10) -> Blackrock Depths (map 243 56.90,85.70) via floor
    {
        fromPointID = 200443,
        fromMap = 242,
        fromX = 0.573,
        fromY = 0.571,
        toPointID = 200459,
        toMap = 243,
        toX = 0.569,
        toY = 0.857,
        type = "floor",
    },
    -- Blackrock Depths (map 242 58.70,34.40) -> Blackrock Depths (map 243 58.90,64.70) via floor
    {
        fromPointID = 200444,
        fromMap = 242,
        fromX = 0.587,
        fromY = 0.344,
        toPointID = 200460,
        toMap = 243,
        toX = 0.589,
        toY = 0.647,
        type = "floor",
    },
    -- Blackrock Depths (map 242 59.80,30.90) -> Blackrock Depths (map 243 59.90,60.10) via floor
    {
        fromPointID = 200445,
        fromMap = 242,
        fromX = 0.598,
        fromY = 0.309,
        toPointID = 200461,
        toMap = 243,
        toX = 0.599,
        toY = 0.601,
        type = "floor",
    },
    -- Blackrock Depths (map 242 67.00,26.30) -> Blackrock Depths (map 243 64.90,57.10) via floor
    {
        fromPointID = 200446,
        fromMap = 242,
        fromX = 0.67,
        fromY = 0.263,
        toPointID = 200462,
        toMap = 243,
        toX = 0.649,
        toY = 0.571,
        type = "floor",
    },

    -- Zone: Blackrock Depths (map 243)
    -- Blackrock Depths (map 243 41.40,68.10) -> Blackrock Depths (map 242 41.60,39.10) via floor
    {
        fromPointID = 200447,
        fromMap = 243,
        fromX = 0.414,
        fromY = 0.681,
        toPointID = 200433,
        toMap = 242,
        toX = 0.416,
        toY = 0.391,
        type = "floor",
    },
    -- Blackrock Depths (map 243 41.80,92.40) -> Blackrock Depths (map 242 40.70,67.10) via floor
    {
        fromPointID = 200448,
        fromMap = 243,
        fromX = 0.418,
        fromY = 0.924,
        toPointID = 200432,
        toMap = 242,
        toX = 0.407,
        toY = 0.671,
        type = "floor",
    },
    -- Blackrock Depths (map 243 42.30,73.60) -> Blackrock Depths (map 242 42.50,46.30) via floor
    {
        fromPointID = 200449,
        fromMap = 243,
        fromX = 0.423,
        fromY = 0.736,
        toPointID = 200434,
        toMap = 242,
        toX = 0.425,
        toY = 0.463,
        type = "floor",
    },
    -- Blackrock Depths (map 243 44.50,91.10) -> Blackrock Depths (map 242 45.00,64.30) via floor
    {
        fromPointID = 200450,
        fromMap = 243,
        fromX = 0.445,
        fromY = 0.911,
        toPointID = 200435,
        toMap = 242,
        toX = 0.45,
        toY = 0.643,
        type = "floor",
    },
    -- Blackrock Depths (map 243 44.60,90.00) -> Blackrock Depths (map 242 45.40,63.10) via floor
    {
        fromPointID = 200451,
        fromMap = 243,
        fromX = 0.446,
        fromY = 0.9,
        toPointID = 200436,
        toMap = 242,
        toX = 0.454,
        toY = 0.631,
        type = "floor",
    },
    -- Blackrock Depths (map 243 47.50,81.10) -> Blackrock Depths (map 242 46.60,52.50) via floor
    {
        fromPointID = 200453,
        fromMap = 243,
        fromX = 0.475,
        fromY = 0.811,
        toPointID = 200437,
        toMap = 242,
        toX = 0.466,
        toY = 0.525,
        type = "floor",
    },
    -- Blackrock Depths (map 243 53.00,61.50) -> Blackrock Depths (map 242 53.00,31.80) via floor
    {
        fromPointID = 200454,
        fromMap = 243,
        fromX = 0.53,
        fromY = 0.615,
        toPointID = 200438,
        toMap = 242,
        toX = 0.53,
        toY = 0.318,
        type = "floor",
    },
    -- Blackrock Depths (map 243 53.20,55.60) -> Blackrock Depths (map 242 54.00,27.00) via floor
    {
        fromPointID = 200455,
        fromMap = 243,
        fromX = 0.532,
        fromY = 0.556,
        toPointID = 200439,
        toMap = 242,
        toX = 0.54,
        toY = 0.27,
        type = "floor",
    },
    -- Blackrock Depths (map 243 54.20,65.60) -> Blackrock Depths (map 242 55.00,35.60) via floor
    {
        fromPointID = 200456,
        fromMap = 243,
        fromX = 0.542,
        fromY = 0.656,
        toPointID = 200441,
        toMap = 242,
        toX = 0.55,
        toY = 0.356,
        type = "floor",
    },
    -- Blackrock Depths (map 243 55.20,89.90) -> Blackrock Depths (map 242 54.80,62.90) via floor
    {
        fromPointID = 200457,
        fromMap = 243,
        fromX = 0.552,
        fromY = 0.899,
        toPointID = 200440,
        toMap = 242,
        toX = 0.548,
        toY = 0.629,
        type = "floor",
    },
    -- Blackrock Depths (map 243 56.40,77.50) -> Blackrock Depths (map 242 56.90,51.30) via floor
    {
        fromPointID = 200458,
        fromMap = 243,
        fromX = 0.564,
        fromY = 0.775,
        toPointID = 200442,
        toMap = 242,
        toX = 0.569,
        toY = 0.513,
        type = "floor",
    },
    -- Blackrock Depths (map 243 56.90,85.70) -> Blackrock Depths (map 242 57.30,57.10) via floor
    {
        fromPointID = 200459,
        fromMap = 243,
        fromX = 0.569,
        fromY = 0.857,
        toPointID = 200443,
        toMap = 242,
        toX = 0.573,
        toY = 0.571,
        type = "floor",
    },
    -- Blackrock Depths (map 243 58.90,64.70) -> Blackrock Depths (map 242 58.70,34.40) via floor
    {
        fromPointID = 200460,
        fromMap = 243,
        fromX = 0.589,
        fromY = 0.647,
        toPointID = 200444,
        toMap = 242,
        toX = 0.587,
        toY = 0.344,
        type = "floor",
    },
    -- Blackrock Depths (map 243 59.90,60.10) -> Blackrock Depths (map 242 59.80,30.90) via floor
    {
        fromPointID = 200461,
        fromMap = 243,
        fromX = 0.599,
        fromY = 0.601,
        toPointID = 200445,
        toMap = 242,
        toX = 0.598,
        toY = 0.309,
        type = "floor",
    },
    -- Blackrock Depths (map 243 64.90,57.10) -> Blackrock Depths (map 242 67.00,26.30) via floor
    {
        fromPointID = 200462,
        fromMap = 243,
        fromX = 0.649,
        fromY = 0.571,
        toPointID = 200446,
        toMap = 242,
        toX = 0.67,
        toY = 0.263,
        type = "floor",
    },

    -- Zone: Blackrock Mountain (map 33)
    -- Burning Steppes (map 33 46.80,50.80) -> Burning Steppes (map 35 58.20,88.50) via floor
    {
        fromPointID = 200146,
        fromMap = 33,
        fromX = 0.468,
        fromY = 0.508,
        toPointID = 200162,
        toMap = 35,
        toX = 0.582,
        toY = 0.885,
        type = "floor",
    },
    -- Burning Steppes (map 33 49.50,88.66) -> Burning Steppes (map 36 21.00,38.00) via floor
    {
        fromPointID = 200147,
        fromMap = 33,
        fromX = 0.495,
        fromY = 0.8866,
        toPointID = 200165,
        toMap = 36,
        toX = 0.21,
        toY = 0.38,
        type = "floor",
    },
    -- Burning Steppes (map 33 66.80,60.70) -> Burning Steppes (map 34 41.70,79.60) via floor
    {
        fromPointID = 200150,
        fromMap = 33,
        fromX = 0.668,
        fromY = 0.607,
        toPointID = 200155,
        toMap = 34,
        toX = 0.417,
        toY = 0.796,
        type = "floor",
    },
    -- Burning Steppes (map 33 72.00,43.20) -> Burning Steppes (map 34 60.50,27.80) via floor
    {
        fromPointID = 200151,
        fromMap = 33,
        fromX = 0.72,
        fromY = 0.432,
        toPointID = 200156,
        toMap = 34,
        toX = 0.605,
        toY = 0.278,
        type = "floor",
    },

    -- Zone: Blackrock Mountain (map 34)
    -- Burning Steppes (map 34 41.70,79.60) -> Burning Steppes (map 33 66.80,60.70) via floor
    {
        fromPointID = 200155,
        fromMap = 34,
        fromX = 0.417,
        fromY = 0.796,
        toPointID = 200150,
        toMap = 33,
        toX = 0.668,
        toY = 0.607,
        type = "floor",
    },
    -- Burning Steppes (map 34 60.50,27.80) -> Burning Steppes (map 33 72.00,43.20) via floor
    {
        fromPointID = 200156,
        fromMap = 34,
        fromX = 0.605,
        fromY = 0.278,
        toPointID = 200151,
        toMap = 33,
        toX = 0.72,
        toY = 0.432,
        type = "floor",
    },

    -- Zone: Blackrock Mountain (map 35)
    -- Burning Steppes (map 35 58.20,88.50) -> Burning Steppes (map 33 46.80,50.80) via floor
    {
        fromPointID = 200162,
        fromMap = 35,
        fromX = 0.582,
        fromY = 0.885,
        toPointID = 200146,
        toMap = 33,
        toX = 0.468,
        toY = 0.508,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 250)
    -- Blackrock Spire (map 250 56.70,48.30) -> Blackrock Spire (map 252 58.40,47.70) via floor
    {
        fromPointID = 200474,
        fromMap = 250,
        fromX = 0.567,
        fromY = 0.483,
        toPointID = 200486,
        toMap = 252,
        toX = 0.584,
        toY = 0.477,
        type = "floor",
    },
    -- Blackrock Spire (map 250 59.40,63.90) -> Blackrock Spire (map 251 59.50,59.30) via floor
    {
        fromPointID = 200475,
        fromMap = 250,
        fromX = 0.594,
        fromY = 0.639,
        toPointID = 200480,
        toMap = 251,
        toX = 0.595,
        toY = 0.593,
        type = "floor",
    },
    -- Blackrock Spire (map 250 59.80,70.20) -> Blackrock Spire (map 251 64.80,70.90) via floor
    {
        fromPointID = 200476,
        fromMap = 250,
        fromX = 0.598,
        fromY = 0.702,
        toPointID = 200481,
        toMap = 251,
        toX = 0.648,
        toY = 0.709,
        type = "floor",
    },
    -- Blackrock Spire (map 250 66.10,51.10) -> Blackrock Spire (map 252 66.00,49.20) via floor
    {
        fromPointID = 200477,
        fromMap = 250,
        fromX = 0.661,
        fromY = 0.511,
        toPointID = 200487,
        toMap = 252,
        toX = 0.66,
        toY = 0.492,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 251)
    -- Blackrock Spire (map 251 51.10,74.20) -> Blackrock Spire (map 252 49.90,74.10) via floor
    {
        fromPointID = 200478,
        fromMap = 251,
        fromX = 0.511,
        fromY = 0.742,
        toPointID = 200483,
        toMap = 252,
        toX = 0.499,
        toY = 0.741,
        type = "floor",
    },
    -- Blackrock Spire (map 251 53.20,52.80) -> Blackrock Spire (map 252 57.00,51.20) via floor
    {
        fromPointID = 200479,
        fromMap = 251,
        fromX = 0.532,
        fromY = 0.528,
        toPointID = 200485,
        toMap = 252,
        toX = 0.57,
        toY = 0.512,
        type = "floor",
    },
    -- Blackrock Spire (map 251 59.50,59.30) -> Blackrock Spire (map 250 59.40,63.90) via floor
    {
        fromPointID = 200480,
        fromMap = 251,
        fromX = 0.595,
        fromY = 0.593,
        toPointID = 200475,
        toMap = 250,
        toX = 0.594,
        toY = 0.639,
        type = "floor",
    },
    -- Blackrock Spire (map 251 64.80,70.90) -> Blackrock Spire (map 250 59.80,70.20) via floor
    {
        fromPointID = 200481,
        fromMap = 251,
        fromX = 0.648,
        fromY = 0.709,
        toPointID = 200476,
        toMap = 250,
        toX = 0.598,
        toY = 0.702,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 252)
    -- Blackrock Spire (map 252 46.50,65.80) -> Blackrock Spire (map 253 45.10,59.50) via floor
    {
        fromPointID = 200482,
        fromMap = 252,
        fromX = 0.465,
        fromY = 0.658,
        toPointID = 200490,
        toMap = 253,
        toX = 0.451,
        toY = 0.595,
        type = "floor",
    },
    -- Blackrock Spire (map 252 49.90,74.10) -> Blackrock Spire (map 251 51.10,74.20) via floor
    {
        fromPointID = 200483,
        fromMap = 252,
        fromX = 0.499,
        fromY = 0.741,
        toPointID = 200478,
        toMap = 251,
        toX = 0.511,
        toY = 0.742,
        type = "floor",
    },
    -- Blackrock Spire (map 252 55.10,37.60) -> Blackrock Spire (map 253 47.20,42.70) via floor
    {
        fromPointID = 200484,
        fromMap = 252,
        fromX = 0.551,
        fromY = 0.376,
        toPointID = 200491,
        toMap = 253,
        toX = 0.472,
        toY = 0.427,
        type = "floor",
    },
    -- Blackrock Spire (map 252 57.00,51.20) -> Blackrock Spire (map 251 53.20,52.80) via floor
    {
        fromPointID = 200485,
        fromMap = 252,
        fromX = 0.57,
        fromY = 0.512,
        toPointID = 200479,
        toMap = 251,
        toX = 0.532,
        toY = 0.528,
        type = "floor",
    },
    -- Blackrock Spire (map 252 58.40,47.70) -> Blackrock Spire (map 250 56.70,48.30) via floor
    {
        fromPointID = 200486,
        fromMap = 252,
        fromX = 0.584,
        fromY = 0.477,
        toPointID = 200474,
        toMap = 250,
        toX = 0.567,
        toY = 0.483,
        type = "floor",
    },
    -- Blackrock Spire (map 252 66.00,49.20) -> Blackrock Spire (map 250 66.10,51.10) via floor
    {
        fromPointID = 200487,
        fromMap = 252,
        fromX = 0.66,
        fromY = 0.492,
        toPointID = 200477,
        toMap = 250,
        toX = 0.661,
        toY = 0.511,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 253)
    -- Blackrock Spire (map 253 37.20,34.20) -> Blackrock Spire (map 254 37.10,32.10) via floor
    {
        fromPointID = 200488,
        fromMap = 253,
        fromX = 0.372,
        fromY = 0.342,
        toPointID = 200493,
        toMap = 254,
        toX = 0.371,
        toY = 0.321,
        type = "floor",
    },
    -- Blackrock Spire (map 253 45.10,59.50) -> Blackrock Spire (map 252 46.50,65.80) via floor
    {
        fromPointID = 200490,
        fromMap = 253,
        fromX = 0.451,
        fromY = 0.595,
        toPointID = 200482,
        toMap = 252,
        toX = 0.465,
        toY = 0.658,
        type = "floor",
    },
    -- Blackrock Spire (map 253 47.20,42.70) -> Blackrock Spire (map 252 55.10,37.60) via floor
    {
        fromPointID = 200491,
        fromMap = 253,
        fromX = 0.472,
        fromY = 0.427,
        toPointID = 200484,
        toMap = 252,
        toX = 0.551,
        toY = 0.376,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 254)
    -- Blackrock Spire (map 254 33.30,13.30) -> Blackrock Spire (map 255 30.40,18.70) via floor
    {
        fromPointID = 200492,
        fromMap = 254,
        fromX = 0.333,
        fromY = 0.133,
        toPointID = 200494,
        toMap = 255,
        toX = 0.304,
        toY = 0.187,
        type = "floor",
    },
    -- Blackrock Spire (map 254 37.10,32.10) -> Blackrock Spire (map 253 37.20,34.20) via floor
    {
        fromPointID = 200493,
        fromMap = 254,
        fromX = 0.371,
        fromY = 0.321,
        toPointID = 200488,
        toMap = 253,
        toX = 0.372,
        toY = 0.342,
        type = "floor",
    },

    -- Zone: Blackrock Spire (map 255)
    -- Blackrock Spire (map 255 30.40,18.70) -> Blackrock Spire (map 254 33.30,13.30) via floor
    {
        fromPointID = 200494,
        fromMap = 255,
        fromX = 0.304,
        fromY = 0.187,
        toPointID = 200492,
        toMap = 254,
        toX = 0.333,
        toY = 0.133,
        type = "floor",
    },

    -- Zone: Blackwing Descent (map 285)
    -- Blackwing Descent (map 285 46.90,42.10) -> Blackwing Descent (map 286 47.40,89.80) via floor
    {
        fromPointID = 200502,
        fromMap = 285,
        fromX = 0.469,
        fromY = 0.421,
        toPointID = 200503,
        toMap = 286,
        toX = 0.474,
        toY = 0.898,
        type = "floor",
    },

    -- Zone: Blackwing Descent (map 286)
    -- Blackwing Descent (map 286 47.40,89.80) -> Blackwing Descent (map 285 46.90,42.10) via floor
    {
        fromPointID = 200503,
        fromMap = 286,
        fromX = 0.474,
        fromY = 0.898,
        toPointID = 200502,
        toMap = 285,
        toX = 0.469,
        toY = 0.421,
        type = "floor",
    },

    -- Zone: Blackwing Lair (map 287)
    -- Blackwing Lair (map 287 37.60,11.20) -> Blackwing Lair (map 288 44.00,22.90) via floor
    {
        fromPointID = 200504,
        fromMap = 287,
        fromX = 0.376,
        fromY = 0.112,
        toPointID = 200507,
        toMap = 288,
        toX = 0.44,
        toY = 0.229,
        type = "floor",
    },
    -- Blackwing Lair (map 287 45.40,27.70) -> Blackwing Lair (map 288 49.70,36.00) via floor
    {
        fromPointID = 200505,
        fromMap = 287,
        fromX = 0.454,
        fromY = 0.277,
        toPointID = 200509,
        toMap = 288,
        toX = 0.497,
        toY = 0.36,
        type = "floor",
    },

    -- Zone: Blackwing Lair (map 288)
    -- Blackwing Lair (map 288 44.00,22.90) -> Blackwing Lair (map 287 37.60,11.20) via floor
    {
        fromPointID = 200507,
        fromMap = 288,
        fromX = 0.44,
        fromY = 0.229,
        toPointID = 200504,
        toMap = 287,
        toX = 0.376,
        toY = 0.112,
        type = "floor",
    },
    -- Blackwing Lair (map 288 49.40,80.30) -> Blackwing Lair (map 289 57.00,87.20) via floor
    {
        fromPointID = 200508,
        fromMap = 288,
        fromX = 0.494,
        fromY = 0.803,
        toPointID = 200511,
        toMap = 289,
        toX = 0.57,
        toY = 0.872,
        type = "floor",
    },
    -- Blackwing Lair (map 288 49.70,36.00) -> Blackwing Lair (map 287 45.40,27.70) via floor
    {
        fromPointID = 200509,
        fromMap = 288,
        fromX = 0.497,
        fromY = 0.36,
        toPointID = 200505,
        toMap = 287,
        toX = 0.454,
        toY = 0.277,
        type = "floor",
    },

    -- Zone: Blackwing Lair (map 289)
    -- Blackwing Lair (map 289 31.00,37.50) -> Blackwing Lair (map 290 22.00,60.90) via floor
    {
        fromPointID = 200510,
        fromMap = 289,
        fromX = 0.31,
        fromY = 0.375,
        toPointID = 200512,
        toMap = 290,
        toX = 0.22,
        toY = 0.609,
        type = "floor",
    },
    -- Blackwing Lair (map 289 57.00,87.20) -> Blackwing Lair (map 288 49.40,80.30) via floor
    {
        fromPointID = 200511,
        fromMap = 289,
        fromX = 0.57,
        fromY = 0.872,
        toPointID = 200508,
        toMap = 288,
        toX = 0.494,
        toY = 0.803,
        type = "floor",
    },

    -- Zone: Blackwing Lair (map 290)
    -- Blackwing Lair (map 290 22.00,60.90) -> Blackwing Lair (map 289 31.00,37.50) via floor
    {
        fromPointID = 200512,
        fromMap = 290,
        fromX = 0.22,
        fromY = 0.609,
        toPointID = 200510,
        toMap = 289,
        toX = 0.31,
        toY = 0.375,
        type = "floor",
    },

    -- Zone: Blooming Foundry (map 2027)
    -- Blooming Foundry (map 2027 28.07,11.88) -> Zereth Mortis (map 1970 63.67,73.70) via floor
    {
        fromPointID = 1000360,
        fromMap = 2027,
        fromX = 0.2807,
        fromY = 0.1188,
        toPointID = 1000328,
        toMap = 1970,
        toX = 0.6367,
        toY = 0.737,
        type = "floor",
    },

    -- Zone: Brackenhide Hollow (map 2096)
    -- Brackenhide Hollow (map 2096 71.73,49.43) -> Brackenhide Hollow (map 2106 25.16,54.77) via floor
    {
        fromPointID = 1100096,
        fromMap = 2096,
        fromX = 0.7173,
        fromY = 0.4943,
        toPointID = 1100107,
        toMap = 2106,
        toX = 0.2516,
        toY = 0.5477,
        type = "floor",
    },
    -- Brackenhide Hollow (map 2096 74.24,58.14) -> Brackenhide Hollow (map 2106 25.16,54.77) via floor
    {
        fromPointID = 1100097,
        fromMap = 2096,
        fromX = 0.7424,
        fromY = 0.5814,
        toPointID = 1100107,
        toMap = 2106,
        toX = 0.2516,
        toY = 0.5477,
        type = "floor",
    },

    -- Zone: Brackenhide Hollow (map 2106)
    -- Brackenhide Hollow (map 2106 25.16,54.77) -> Brackenhide Hollow (map 2096 71.73,49.43) via floor
    {
        fromPointID = 1100107,
        fromMap = 2106,
        fromX = 0.2516,
        fromY = 0.5477,
        toPointID = 1100096,
        toMap = 2096,
        toX = 0.7173,
        toY = 0.4943,
        type = "floor",
    },
    -- Brackenhide Hollow (map 2106 25.16,54.77) -> Brackenhide Hollow (map 2096 74.24,58.14) via floor
    {
        fromPointID = 1100107,
        fromMap = 2106,
        fromX = 0.2516,
        fromY = 0.5477,
        toPointID = 1100097,
        toMap = 2096,
        toX = 0.7424,
        toY = 0.5814,
        type = "floor",
    },

    -- Zone: Burning Blade Coven (map 2)
    -- Durotar (map 2 72.48,89.43) -> Durotar (map 1 45.40,56.21) via floor
    {
        fromPointID = 100021,
        fromMap = 2,
        fromX = 0.7248,
        fromY = 0.8943,
        toPointID = 100010,
        toMap = 1,
        toX = 0.454,
        toY = 0.5621,
        type = "floor",
    },

    -- Zone: Burning Steppes (map 36)
    -- Burning Steppes (map 36 21.00,38.00) -> Burning Steppes (map 33 49.50,88.66) via floor
    {
        fromPointID = 200165,
        fromMap = 36,
        fromX = 0.21,
        fromY = 0.38,
        toPointID = 200147,
        toMap = 33,
        toX = 0.495,
        toY = 0.8866,
        type = "floor",
    },

    -- Zone: Castle Nathria (map 1735)
    -- Castle Nathria (map 1735 31.73,41.43) -> Castle Nathria (map 1744 46.68,53.34) via floor
    {
        fromPointID = 1000277,
        fromMap = 1735,
        fromX = 0.3173,
        fromY = 0.4143,
        toPointID = 1000280,
        toMap = 1744,
        toX = 0.4668,
        toY = 0.5334,
        type = "floor",
    },
    -- Castle Nathria (map 1735 51.82,53.44) -> Castle Nathria (map 1750 31.37,16.93) via floor
    {
        fromPointID = 1000278,
        fromMap = 1735,
        fromX = 0.5182,
        fromY = 0.5344,
        toPointID = 1000284,
        toMap = 1750,
        toX = 0.3137,
        toY = 0.1693,
        type = "floor",
    },
    -- Castle Nathria (map 1735 58.87,90.57) -> Castle Nathria (map 1745 20.13,38.63) via floor
    {
        fromPointID = 1000279,
        fromMap = 1735,
        fromX = 0.5887,
        fromY = 0.9057,
        toPointID = 1000281,
        toMap = 1745,
        toX = 0.2013,
        toY = 0.3863,
        type = "floor",
    },

    -- Zone: Castle Nathria (map 1744)
    -- Castle Nathria (map 1744 46.68,53.34) -> Castle Nathria (map 1735 31.73,41.43) via floor
    {
        fromPointID = 1000280,
        fromMap = 1744,
        fromX = 0.4668,
        fromY = 0.5334,
        toPointID = 1000277,
        toMap = 1735,
        toX = 0.3173,
        toY = 0.4143,
        type = "floor",
    },

    -- Zone: Castle Nathria (map 1745)
    -- Castle Nathria (map 1745 20.13,38.63) -> Castle Nathria (map 1735 58.87,90.57) via floor
    {
        fromPointID = 1000281,
        fromMap = 1745,
        fromX = 0.2013,
        fromY = 0.3863,
        toPointID = 1000279,
        toMap = 1735,
        toX = 0.5887,
        toY = 0.9057,
        type = "floor",
    },
    -- Castle Nathria (map 1745 52.53,91.10) -> Castle Nathria (map 1746 15.23,38.09) via floor
    {
        fromPointID = 1000282,
        fromMap = 1745,
        fromX = 0.5253,
        fromY = 0.911,
        toPointID = 1000283,
        toMap = 1746,
        toX = 0.1523,
        toY = 0.3809,
        type = "floor",
    },

    -- Zone: Castle Nathria (map 1746)
    -- Castle Nathria (map 1746 15.23,38.09) -> Castle Nathria (map 1745 52.53,91.10) via floor
    {
        fromPointID = 1000283,
        fromMap = 1746,
        fromX = 0.1523,
        fromY = 0.3809,
        toPointID = 1000282,
        toMap = 1745,
        toX = 0.5253,
        toY = 0.911,
        type = "floor",
    },

    -- Zone: Castle Nathria (map 1750)
    -- Castle Nathria (map 1750 31.37,16.93) -> Castle Nathria (map 1735 51.82,53.44) via floor
    {
        fromPointID = 1000284,
        fromMap = 1750,
        fromX = 0.3137,
        fromY = 0.1693,
        toPointID = 1000278,
        toMap = 1735,
        toX = 0.5182,
        toY = 0.5344,
        type = "floor",
    },

    -- Zone: Catalyst Wards (map 2066)
    -- Catalyst Wards (map 2066 23.06,12.02) -> Zereth Mortis (map 1970 49.57,77.80) via floor
    {
        fromPointID = 1000378,
        fromMap = 2066,
        fromX = 0.2306,
        fromY = 0.1202,
        toPointID = 1000324,
        toMap = 1970,
        toX = 0.4957,
        toY = 0.778,
        type = "floor",
    },

    -- Zone: Cavern of Contemplation (map 2006)
    -- Caverns of Contemplation (map 2006 42.59,88.16) -> Korthia (map 1961 60.15,31.97) via floor
    {
        fromPointID = 1000357,
        fromMap = 2006,
        fromX = 0.4259,
        fromY = 0.8816,
        toPointID = 1000317,
        toMap = 1961,
        toX = 0.6015,
        toY = 0.3197,
        type = "floor",
    },

    -- Zone: Cavern of Lost Spirits (map 555)
    -- Timeless Isle (map 555 44.40,81.00) -> Timeless Isle (map 554 43.30,40.80) via floor
    {
        fromPointID = 500263,
        fromMap = 555,
        fromX = 0.444,
        fromY = 0.81,
        toPointID = 500262,
        toMap = 554,
        toX = 0.433,
        toY = 0.408,
        type = "floor",
    },

    -- Zone: Caverns of Time (map 74)
    -- Tanaris (map 74 36.80,75.00) -> Tanaris (map 75 61.80,52.40) via floor
    {
        fromPointID = 100201,
        fromMap = 74,
        fromX = 0.368,
        fromY = 0.75,
        toPointID = 100211,
        toMap = 75,
        toX = 0.618,
        toY = 0.524,
        type = "floor",
    },
    -- Tanaris (map 74 53.30,29.40) -> Tanaris (map 71 64.90,50.00) via floor
    {
        fromPointID = 100202,
        fromMap = 74,
        fromX = 0.533,
        fromY = 0.294,
        toPointID = 100195,
        toMap = 71,
        toX = 0.649,
        toY = 0.5,
        type = "floor",
    },

    -- Zone: Caverns of Time (map 75)
    -- Tanaris (map 75 61.80,52.40) -> Tanaris (map 74 36.80,75.00) via floor
    {
        fromPointID = 100211,
        fromMap = 75,
        fromX = 0.618,
        fromY = 0.524,
        toPointID = 100201,
        toMap = 74,
        toX = 0.368,
        toY = 0.75,
        type = "floor",
    },

    -- Zone: City of Echoes (map 2357)
    -- City of Echoes (map 2357 10.69,62.66) -> City of Echoes (map 2358 71.54,23.85) via floor
    {
        fromPointID = 1200151,
        fromMap = 2357,
        fromX = 0.1069,
        fromY = 0.6266,
        toPointID = 1200153,
        toMap = 2358,
        toX = 0.7154,
        toY = 0.2385,
        type = "floor",
    },

    -- Zone: City of Echoes (map 2358)
    -- City of Echoes (map 2358 71.54,23.85) -> City of Echoes (map 2357 10.69,62.66) via floor
    {
        fromPointID = 1200153,
        fromMap = 2358,
        fromX = 0.7154,
        fromY = 0.2385,
        toPointID = 1200151,
        toMap = 2357,
        toX = 0.1069,
        toY = 0.6266,
        type = "floor",
    },

    -- Zone: City of Threads (map 2343)
    -- City of Threads (map 2343 62.11,65.80) -> City of Threads (map 2344 49.78,13.63) via floor
    {
        fromPointID = 1200137,
        fromMap = 2343,
        fromX = 0.6211,
        fromY = 0.658,
        toPointID = 1200138,
        toMap = 2344,
        toX = 0.4978,
        toY = 0.1363,
        type = "floor",
    },

    -- Zone: City of Threads (map 2344)
    -- City of Threads (map 2344 49.78,13.63) -> City of Threads (map 2343 62.11,65.80) via floor
    {
        fromPointID = 1200138,
        fromMap = 2344,
        fromX = 0.4978,
        fromY = 0.1363,
        toPointID = 1200137,
        toMap = 2343,
        toX = 0.6211,
        toY = 0.658,
        type = "floor",
    },

    -- Zone: Coldridge Pass (map 28)
    -- Dun Morogh (map 28 38.00,91.10) -> Dun Morogh (map 27 41.10,70.00) via floor
    {
        fromPointID = 200132,
        fromMap = 28,
        fromX = 0.38,
        fromY = 0.911,
        toPointID = 200122,
        toMap = 27,
        toX = 0.411,
        toY = 0.7,
        type = "floor",
    },
    -- Dun Morogh (map 28 60.60,11.00) -> Dun Morogh (map 27 42.70,64.10) via floor
    {
        fromPointID = 200133,
        fromMap = 28,
        fromX = 0.606,
        fromY = 0.11,
        toPointID = 200123,
        toMap = 27,
        toX = 0.427,
        toY = 0.641,
        type = "floor",
    },

    -- Zone: Coldridge Valley (map 427)
    -- Coldridge Valley (map 427 51.30,82.50) -> Coldridge Valley (map 428 14.40,50.10) via floor
    {
        fromPointID = 200599,
        fromMap = 427,
        fromX = 0.513,
        fromY = 0.825,
        toPointID = 200602,
        toMap = 428,
        toX = 0.144,
        toY = 0.501,
        type = "floor",
    },

    -- Zone: Collegiate Calamity (map 2577)
    -- Collegiate Calamity (map 2577 35.48,32.68) -> Collegiate Calamity (map 2578 50.43,26.14) via floor
    {
        fromPointID = 200847,
        fromMap = 2577,
        fromX = 0.3548,
        fromY = 0.3268,
        toPointID = 200849,
        toMap = 2578,
        toX = 0.5043,
        toY = 0.2614,
        type = "floor",
    },

    -- Zone: Collegiate Calamity (map 2578)
    -- Collegiate Calamity (map 2578 50.43,26.14) -> Collegiate Calamity (map 2577 35.48,32.68) via floor
    {
        fromPointID = 200849,
        fromMap = 2578,
        fromX = 0.5043,
        fromY = 0.2614,
        toPointID = 200847,
        toMap = 2577,
        toX = 0.3548,
        toY = 0.3268,
        type = "floor",
    },

    -- Zone: Court of Stars (map 761)
    -- Court of Stars (map 761 63.36,65.91) -> Court of Stars (map 762 38.42,40.67) via floor
    {
        fromPointID = 700275,
        fromMap = 761,
        fromX = 0.6336,
        fromY = 0.6591,
        toPointID = 700276,
        toMap = 762,
        toX = 0.3842,
        toY = 0.4067,
        type = "floor",
    },

    -- Zone: Court of Stars (map 762)
    -- Court of Stars (map 762 38.42,40.67) -> Court of Stars (map 761 63.36,65.91) via floor
    {
        fromPointID = 700276,
        fromMap = 762,
        fromX = 0.3842,
        fromY = 0.4067,
        toPointID = 700275,
        toMap = 761,
        toX = 0.6336,
        toY = 0.6591,
        type = "floor",
    },
    -- Court of Stars (map 762 47.80,39.54) -> Court of Stars (map 763 54.76,53.74) via floor
    {
        fromPointID = 700277,
        fromMap = 762,
        fromX = 0.478,
        fromY = 0.3954,
        toPointID = 700278,
        toMap = 763,
        toX = 0.5476,
        toY = 0.5374,
        type = "floor",
    },

    -- Zone: Court of Stars (map 763)
    -- Court of Stars (map 763 54.76,53.74) -> Court of Stars (map 762 47.80,39.54) via floor
    {
        fromPointID = 700278,
        fromMap = 763,
        fromX = 0.5476,
        fromY = 0.5374,
        toPointID = 700277,
        toMap = 762,
        toX = 0.478,
        toY = 0.3954,
        type = "floor",
    },

    -- Zone: Crossroads of Fate (map 2194)
    -- Dawn of the Infinite (map 2194 32.09,13.27) -> Dawn of the Infinite (map 2193 79.08,56.38) via floor
    {
        fromPointID = 1100188,
        fromMap = 2194,
        fromX = 0.3209,
        fromY = 0.1327,
        toPointID = 1100187,
        toMap = 2193,
        toX = 0.7908,
        toY = 0.5638,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2194 56.48,55.77) -> Dawn of the Infinite (map 2195 59.35,77.91) via floor
    {
        fromPointID = 1100189,
        fromMap = 2194,
        fromX = 0.5648,
        fromY = 0.5577,
        toPointID = 1100191,
        toMap = 2195,
        toX = 0.5935,
        toY = 0.7791,
        type = "floor",
    },

    -- Zone: Crypt of the Denied (map 2639)
    -- Crypt of the Denied (map 2639 69.16,18.00) -> The Coiled Isle (map 2512 45.48,75.78) via floor
    {
        fromPointID = 200895,
        fromMap = 2639,
        fromX = 0.6916,
        fromY = 0.18,
        toPointID = 200787,
        toMap = 2512,
        toX = 0.4548,
        toY = 0.7578,
        type = "floor",
    },

    -- Zone: Crypt of the Disgraced (map 2644)
    -- Crypt of the Disgraced (map 2644 66.44,17.99) -> The Coiled Isle (map 2512 74.71,62.70) via floor
    {
        fromPointID = 200901,
        fromMap = 2644,
        fromX = 0.6644,
        fromY = 0.1799,
        toPointID = 200796,
        toMap = 2512,
        toX = 0.7471,
        toY = 0.627,
        type = "floor",
    },

    -- Zone: Crypt of the Lost Mason (map 2643)
    -- Crypt of the Lost Mason (map 2643 45.44,11.99) -> The Coiled Isle (map 2512 49.46,38.54) via floor
    {
        fromPointID = 200900,
        fromMap = 2643,
        fromX = 0.4544,
        fromY = 0.1199,
        toPointID = 200788,
        toMap = 2512,
        toX = 0.4946,
        toY = 0.3854,
        type = "floor",
    },

    -- Zone: Crypt of the Lost Warrior (map 2641)
    -- Crypt of the Lost Warrior (map 2641 7.64,59.34) -> The Coiled Isle (map 2512 52.95,32.23) via floor
    {
        fromPointID = 200897,
        fromMap = 2641,
        fromX = 0.0764,
        fromY = 0.5934,
        toPointID = 200791,
        toMap = 2512,
        toX = 0.5295,
        toY = 0.3223,
        type = "floor",
    },
    -- Crypt of the Lost Warrior (map 2641 89.42,82.69) -> The Coiled Isle (map 2512 57.09,33.45) via floor
    {
        fromPointID = 200898,
        fromMap = 2641,
        fromX = 0.8942,
        fromY = 0.8269,
        toPointID = 200792,
        toMap = 2512,
        toX = 0.5709,
        toY = 0.3345,
        type = "floor",
    },

    -- Zone: Crypts of the Eternal (map 2031)
    -- Crypts of the Eternal (map 2031 31.18,86.86) -> Zereth Mortis (map 1970 65.90,20.94) via floor
    {
        fromPointID = 1000364,
        fromMap = 2031,
        fromX = 0.3118,
        fromY = 0.8686,
        toPointID = 1000329,
        toMap = 1970,
        toX = 0.659,
        toY = 0.2094,
        type = "floor",
    },

    -- Zone: Dagger in the Dark (map 488)
    -- Dagger in the Dark (map 488 31.10,1.10) -> Dagger in the Dark (map 489 25.90,13.80) via floor
    {
        fromPointID = 500199,
        fromMap = 488,
        fromX = 0.311,
        fromY = 0.011,
        toPointID = 500202,
        toMap = 489,
        toX = 0.259,
        toY = 0.138,
        type = "floor",
    },
    -- Dagger in the Dark (map 488 50.30,39.50) -> Dagger in the Dark (map 489 61.30,82.90) via floor
    {
        fromPointID = 500200,
        fromMap = 488,
        fromX = 0.503,
        fromY = 0.395,
        toPointID = 500203,
        toMap = 489,
        toX = 0.613,
        toY = 0.829,
        type = "floor",
    },
    -- Dagger in the Dark (map 488 57.90,13.20) -> Dagger in the Dark (map 489 77.00,37.90) via floor
    {
        fromPointID = 500201,
        fromMap = 488,
        fromX = 0.579,
        fromY = 0.132,
        toPointID = 500204,
        toMap = 489,
        toX = 0.77,
        toY = 0.379,
        type = "floor",
    },

    -- Zone: Dagger in the Dark (map 489)
    -- Dagger in the Dark (map 489 25.90,13.80) -> Dagger in the Dark (map 488 31.10,1.10) via floor
    {
        fromPointID = 500202,
        fromMap = 489,
        fromX = 0.259,
        fromY = 0.138,
        toPointID = 500199,
        toMap = 488,
        toX = 0.311,
        toY = 0.011,
        type = "floor",
    },
    -- Dagger in the Dark (map 489 61.30,82.90) -> Dagger in the Dark (map 488 50.30,39.50) via floor
    {
        fromPointID = 500203,
        fromMap = 489,
        fromX = 0.613,
        fromY = 0.829,
        toPointID = 500200,
        toMap = 488,
        toX = 0.503,
        toY = 0.395,
        type = "floor",
    },
    -- Dagger in the Dark (map 489 77.00,37.90) -> Dagger in the Dark (map 488 57.90,13.20) via floor
    {
        fromPointID = 500204,
        fromMap = 489,
        fromX = 0.77,
        fromY = 0.379,
        toPointID = 500201,
        toMap = 488,
        toX = 0.579,
        toY = 0.132,
        type = "floor",
    },

    -- Zone: Dalaran (map 125)
    -- Dalaran (map 125 35.00,45.30) -> Dalaran (map 126 34.40,43.40) via floor
    {
        fromPointID = 400114,
        fromMap = 125,
        fromX = 0.35,
        fromY = 0.453,
        toPointID = 400125,
        toMap = 126,
        toX = 0.344,
        toY = 0.434,
        type = "floor",
    },
    -- Dalaran (map 125 38.80,45.10) -> Dalaran (map 126 34.30,43.30) via floor
    {
        fromPointID = 400115,
        fromMap = 125,
        fromX = 0.388,
        fromY = 0.451,
        toPointID = 400124,
        toMap = 126,
        toX = 0.343,
        toY = 0.433,
        type = "floor",
    },
    -- Dalaran (map 125 38.80,45.10) -> Dalaran (map 126 34.40,43.40) via floor
    {
        fromPointID = 400115,
        fromMap = 125,
        fromX = 0.388,
        fromY = 0.451,
        toPointID = 400125,
        toMap = 126,
        toX = 0.344,
        toY = 0.434,
        type = "floor",
    },
    -- Dalaran (map 125 38.80,45.10) -> Dalaran (map 126 64.30,48.60) via floor
    {
        fromPointID = 400115,
        fromMap = 125,
        fromX = 0.388,
        fromY = 0.451,
        toPointID = 400127,
        toMap = 126,
        toX = 0.643,
        toY = 0.486,
        type = "floor",
    },
    -- Dalaran (map 125 38.80,45.10) -> Dalaran (map 126 64.40,48.60) via floor
    {
        fromPointID = 400115,
        fromMap = 125,
        fromX = 0.388,
        fromY = 0.451,
        toPointID = 400128,
        toMap = 126,
        toX = 0.644,
        toY = 0.486,
        type = "floor",
    },
    -- Dalaran (map 125 48.10,32.70) -> Dalaran (map 126 44.30,25.20) via floor
    {
        fromPointID = 400117,
        fromMap = 125,
        fromX = 0.481,
        fromY = 0.327,
        toPointID = 400126,
        toMap = 126,
        toX = 0.443,
        toY = 0.252,
        type = "floor",
        travelDuration = 8,
    },
    -- Dalaran (map 125 60.20,47.70) -> Dalaran (map 126 64.30,48.60) via floor
    {
        fromPointID = 400122,
        fromMap = 125,
        fromX = 0.602,
        fromY = 0.477,
        toPointID = 400127,
        toMap = 126,
        toX = 0.643,
        toY = 0.486,
        type = "floor",
        travelDuration = 4,
    },

    -- Zone: Dalaran (map 126)
    -- Dalaran (map 126 34.30,43.30) -> Dalaran (map 125 38.80,45.10) via floor
    {
        fromPointID = 400124,
        fromMap = 126,
        fromX = 0.343,
        fromY = 0.433,
        toPointID = 400115,
        toMap = 125,
        toX = 0.388,
        toY = 0.451,
        type = "floor",
    },
    -- Dalaran (map 126 34.40,43.40) -> Dalaran (map 125 35.00,45.30) via floor
    {
        fromPointID = 400125,
        fromMap = 126,
        fromX = 0.344,
        fromY = 0.434,
        toPointID = 400114,
        toMap = 125,
        toX = 0.35,
        toY = 0.453,
        type = "floor",
    },
    -- Dalaran (map 126 34.40,43.40) -> Dalaran (map 125 38.80,45.10) via floor
    {
        fromPointID = 400125,
        fromMap = 126,
        fromX = 0.344,
        fromY = 0.434,
        toPointID = 400115,
        toMap = 125,
        toX = 0.388,
        toY = 0.451,
        type = "floor",
    },
    -- Dalaran (map 126 64.30,48.60) -> Dalaran (map 125 38.80,45.10) via floor
    {
        fromPointID = 400127,
        fromMap = 126,
        fromX = 0.643,
        fromY = 0.486,
        toPointID = 400115,
        toMap = 125,
        toX = 0.388,
        toY = 0.451,
        type = "floor",
    },
    -- Dalaran (map 126 64.30,48.60) -> Dalaran (map 125 60.20,47.70) via floor
    {
        fromPointID = 400127,
        fromMap = 126,
        fromX = 0.643,
        fromY = 0.486,
        toPointID = 400122,
        toMap = 125,
        toX = 0.602,
        toY = 0.477,
        type = "floor",
        travelDuration = 4,
    },
    -- Dalaran (map 126 64.40,48.60) -> Dalaran (map 125 38.80,45.10) via floor
    {
        fromPointID = 400128,
        fromMap = 126,
        fromX = 0.644,
        fromY = 0.486,
        toPointID = 400115,
        toMap = 125,
        toX = 0.388,
        toY = 0.451,
        type = "floor",
    },

    -- Zone: Dalaran (map 2305)
    -- Dalaran TWW (map 2305 38.91,37.40) -> Dalaran TWW (map 2307 15.11,69.11) via floor
    {
        fromPointID = 1300074,
        fromMap = 2305,
        fromX = 0.3891,
        fromY = 0.374,
        toPointID = 1300077,
        toMap = 2307,
        toX = 0.1511,
        toY = 0.6911,
        type = "floor",
    },
    -- Dalaran TWW (map 2305 41.21,59.40) -> Dalaran TWW (map 2306 29.10,54.75) via floor
    {
        fromPointID = 1300075,
        fromMap = 2305,
        fromX = 0.4121,
        fromY = 0.594,
        toPointID = 1300076,
        toMap = 2306,
        toX = 0.291,
        toY = 0.5475,
        type = "floor",
    },

    -- Zone: Dalaran (map 2306)
    -- Dalaran TWW (map 2306 29.10,54.75) -> Dalaran TWW (map 2305 41.21,59.40) via floor
    {
        fromPointID = 1300076,
        fromMap = 2306,
        fromX = 0.291,
        fromY = 0.5475,
        toPointID = 1300075,
        toMap = 2305,
        toX = 0.4121,
        toY = 0.594,
        type = "floor",
    },

    -- Zone: Dalaran (map 2307)
    -- Dalaran TWW (map 2307 15.11,69.11) -> Dalaran TWW (map 2305 38.91,37.40) via floor
    {
        fromPointID = 1300077,
        fromMap = 2307,
        fromX = 0.1511,
        fromY = 0.6911,
        toPointID = 1300074,
        toMap = 2305,
        toX = 0.3891,
        toY = 0.374,
        type = "floor",
    },

    -- Zone: Dalaran (map 626)
    -- Dalaran L (map 626 87.05,76.65) -> Dalaran L (map 627 52.83,70.29) via floor
    {
        fromPointID = 700003,
        fromMap = 626,
        fromX = 0.8705,
        fromY = 0.7665,
        toPointID = 700014,
        toMap = 627,
        toX = 0.5283,
        toY = 0.7029,
        type = "floor",
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
    -- Dalaran L (map 627 34.33,45.60) -> Dalaran L (map 628 19.18,57.14) via floor
    {
        fromPointID = 700006,
        fromMap = 627,
        fromX = 0.3433,
        fromY = 0.456,
        toPointID = 700035,
        toMap = 628,
        toX = 0.1918,
        toY = 0.5714,
        type = "floor",
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
    -- Dalaran L (map 627 52.83,70.29) -> Dalaran L (map 626 87.05,76.65) via floor
    {
        fromPointID = 700014,
        fromMap = 627,
        fromX = 0.5283,
        fromY = 0.7029,
        toPointID = 700003,
        toMap = 626,
        toX = 0.8705,
        toY = 0.7665,
        type = "floor",
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
    -- Dalaran L (map 627 59.85,47.89) -> Dalaran L (map 628 76.26,68.47) via floor
    {
        fromPointID = 700018,
        fromMap = 627,
        fromX = 0.5985,
        fromY = 0.4789,
        toPointID = 700038,
        toMap = 628,
        toX = 0.7626,
        toY = 0.6847,
        type = "floor",
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

    -- Zone: Dalaran (map 628)
    -- Dalaran L (map 628 19.18,57.14) -> Dalaran L (map 627 34.33,45.60) via floor
    {
        fromPointID = 700035,
        fromMap = 628,
        fromX = 0.1918,
        fromY = 0.5714,
        toPointID = 700006,
        toMap = 627,
        toX = 0.3433,
        toY = 0.456,
        type = "floor",
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
    -- Dalaran L (map 628 76.26,68.47) -> Dalaran L (map 627 59.85,47.89) via floor
    {
        fromPointID = 700038,
        fromMap = 628,
        fromX = 0.7626,
        fromY = 0.6847,
        toPointID = 700018,
        toMap = 627,
        toX = 0.5985,
        toY = 0.4789,
        type = "floor",
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

    -- Zone: De Other Side (map 1677)
    -- De Other Side (map 1677 9.49,58.64) -> De Other Side (map 1680 72.98,58.00) via floor
    {
        fromPointID = 1000201,
        fromMap = 1677,
        fromX = 0.0949,
        fromY = 0.5864,
        toPointID = 1000207,
        toMap = 1680,
        toX = 0.7298,
        toY = 0.58,
        type = "floor",
    },

    -- Zone: De Other Side (map 1678)
    -- De Other Side (map 1678 49.19,24.75) -> De Other Side (map 1680 50.59,88.22) via floor
    {
        fromPointID = 1000202,
        fromMap = 1678,
        fromX = 0.4919,
        fromY = 0.2475,
        toPointID = 1000206,
        toMap = 1680,
        toX = 0.5059,
        toY = 0.8822,
        type = "floor",
    },

    -- Zone: De Other Side (map 1679)
    -- De Other Side (map 1679 82.19,48.24) -> De Other Side (map 1680 27.79,58.18) via floor
    {
        fromPointID = 1000203,
        fromMap = 1679,
        fromX = 0.8219,
        fromY = 0.4824,
        toPointID = 1000205,
        toMap = 1680,
        toX = 0.2779,
        toY = 0.5818,
        type = "floor",
    },

    -- Zone: De Other Side (map 1680)
    -- De Other Side (map 1680 27.79,58.18) -> De Other Side (map 1679 82.19,48.24) via floor
    {
        fromPointID = 1000205,
        fromMap = 1680,
        fromX = 0.2779,
        fromY = 0.5818,
        toPointID = 1000203,
        toMap = 1679,
        toX = 0.8219,
        toY = 0.4824,
        type = "floor",
    },
    -- De Other Side (map 1680 50.59,88.22) -> De Other Side (map 1678 49.19,24.75) via floor
    {
        fromPointID = 1000206,
        fromMap = 1680,
        fromX = 0.5059,
        fromY = 0.8822,
        toPointID = 1000202,
        toMap = 1678,
        toX = 0.4919,
        toY = 0.2475,
        type = "floor",
    },
    -- De Other Side (map 1680 72.98,58.00) -> De Other Side (map 1677 9.49,58.64) via floor
    {
        fromPointID = 1000207,
        fromMap = 1680,
        fromX = 0.7298,
        fromY = 0.58,
        toPointID = 1000201,
        toMap = 1677,
        toX = 0.0949,
        toY = 0.5864,
        type = "floor",
    },

    -- Zone: Deathknell (map 465)
    -- Deathknell (map 465 29.70,30.70) -> Deathknell (map 466 87.30,52.00) via floor
    {
        fromPointID = 200606,
        fromMap = 465,
        fromX = 0.297,
        fromY = 0.307,
        toPointID = 200609,
        toMap = 466,
        toX = 0.873,
        toY = 0.52,
        type = "floor",
    },
    -- Deathknell (map 465 44.56,82.68) -> Tirisfal Glades (map 18 30.33,72.86) via floor
    {
        fromPointID = 200607,
        fromMap = 465,
        fromX = 0.4456,
        fromY = 0.8268,
        toPointID = 200040,
        toMap = 18,
        toX = 0.3033,
        toY = 0.7286,
        type = "floor",
    },

    -- Zone: Deepholm (map 207)
    -- Deepholm (map 207 62.60,78.56) -> Deepholm (map 208 37.42,23.93) via floor
    {
        fromPointID = 1300017,
        fromMap = 207,
        fromX = 0.626,
        fromY = 0.7856,
        toPointID = 1300018,
        toMap = 208,
        toX = 0.3742,
        toY = 0.2393,
        type = "floor",
    },

    -- Zone: Deeprun Tram (map 499)
    -- Deeprun Tram (map 499 52.24,46.90) -> Deeprun Tram (map 500 72.30,16.20) via floor
    {
        fromPointID = 200625,
        fromMap = 499,
        fromX = 0.5224,
        fromY = 0.469,
        toPointID = 200626,
        toMap = 500,
        toX = 0.723,
        toY = 0.162,
        type = "floor",
    },

    -- Zone: Deeprun Tram (map 500)
    -- Deeprun Tram (map 500 72.30,16.20) -> Deeprun Tram (map 499 52.24,46.90) via floor
    {
        fromPointID = 200626,
        fromMap = 500,
        fromX = 0.723,
        fromY = 0.162,
        toPointID = 200625,
        toMap = 499,
        toX = 0.5224,
        toY = 0.469,
        type = "floor",
    },

    -- Zone: Den of Nalorakk (map 2513)
    -- Den of Nalorakk (map 2513 52.18,88.13) -> Den of Nalorakk (map 2564 49.31,20.27) via floor
    {
        fromPointID = 200797,
        fromMap = 2513,
        fromX = 0.5218,
        fromY = 0.8813,
        toPointID = 200834,
        toMap = 2564,
        toX = 0.4931,
        toY = 0.2027,
        type = "floor",
    },

    -- Zone: Den of Nalorakk (map 2514)
    -- Den of Nalorakk (map 2514 19.54,55.31) -> Den of Nalorakk (map 2564 50.84,34.71) via floor
    {
        fromPointID = 200798,
        fromMap = 2514,
        fromX = 0.1954,
        fromY = 0.5531,
        toPointID = 200835,
        toMap = 2564,
        toX = 0.5084,
        toY = 0.3471,
        type = "floor",
    },
    -- Den of Nalorakk (map 2514 39.98,24.10) -> Den of Nalorakk (map 2564 50.84,34.71) via floor
    {
        fromPointID = 200799,
        fromMap = 2514,
        fromX = 0.3998,
        fromY = 0.241,
        toPointID = 200835,
        toMap = 2564,
        toX = 0.5084,
        toY = 0.3471,
        type = "floor",
    },

    -- Zone: Den of Nalorakk (map 2564)
    -- Den of Nalorakk (map 2564 49.31,20.27) -> Den of Nalorakk (map 2513 52.18,88.13) via floor
    {
        fromPointID = 200834,
        fromMap = 2564,
        fromX = 0.4931,
        fromY = 0.2027,
        toPointID = 200797,
        toMap = 2513,
        toX = 0.5218,
        toY = 0.8813,
        type = "floor",
    },
    -- Den of Nalorakk (map 2564 50.84,34.71) -> Den of Nalorakk (map 2514 19.54,55.31) via floor
    {
        fromPointID = 200835,
        fromMap = 2564,
        fromX = 0.5084,
        fromY = 0.3471,
        toPointID = 200798,
        toMap = 2514,
        toX = 0.1954,
        toY = 0.5531,
        type = "floor",
    },
    -- Den of Nalorakk (map 2564 50.84,34.71) -> Den of Nalorakk (map 2514 39.98,24.10) via floor
    {
        fromPointID = 200835,
        fromMap = 2564,
        fromX = 0.5084,
        fromY = 0.3471,
        toPointID = 200799,
        toMap = 2514,
        toX = 0.3998,
        toY = 0.241,
        type = "floor",
    },

    -- Zone: Desolace (map 66)
    -- Desolace (map 66 29.09,62.55) -> Desolace (map 67 22.85,43.46) via floor
    {
        fromPointID = 100132,
        fromMap = 66,
        fromX = 0.2909,
        fromY = 0.6255,
        toPointID = 100142,
        toMap = 67,
        toX = 0.2285,
        toY = 0.4346,
        type = "floor",
    },

    -- Zone: Dire Maul (map 236)
    -- Dire Maul (map 236 20.79,19.09) -> Dire Maul (map 237 44.12,13.38) via floor
    {
        fromPointID = 100350,
        fromMap = 236,
        fromX = 0.2079,
        fromY = 0.1909,
        toPointID = 100356,
        toMap = 237,
        toX = 0.4412,
        toY = 0.1338,
        type = "floor",
    },
    -- Dire Maul (map 236 29.47,42.67) -> Dire Maul (map 238 75.94,39.95) via floor
    {
        fromPointID = 100351,
        fromMap = 236,
        fromX = 0.2947,
        fromY = 0.4267,
        toPointID = 100359,
        toMap = 238,
        toX = 0.7594,
        toY = 0.3995,
        type = "floor",
    },
    -- Dire Maul (map 236 31.69,72.04) -> Dire Maul (map 237 48.30,74.24) via floor
    {
        fromPointID = 100352,
        fromMap = 236,
        fromX = 0.3169,
        fromY = 0.7204,
        toPointID = 100357,
        toMap = 237,
        toX = 0.483,
        toY = 0.7424,
        type = "floor",
    },
    -- Dire Maul (map 236 39.22,34.98) -> Dire Maul (map 237 56.27,24.42) via floor
    {
        fromPointID = 100353,
        fromMap = 236,
        fromX = 0.3922,
        fromY = 0.3498,
        toPointID = 100358,
        toMap = 237,
        toX = 0.5627,
        toY = 0.2442,
        type = "floor",
    },

    -- Zone: Dire Maul (map 237)
    -- Dire Maul (map 237 44.12,13.38) -> Dire Maul (map 236 20.79,19.09) via floor
    {
        fromPointID = 100356,
        fromMap = 237,
        fromX = 0.4412,
        fromY = 0.1338,
        toPointID = 100350,
        toMap = 236,
        toX = 0.2079,
        toY = 0.1909,
        type = "floor",
    },
    -- Dire Maul (map 237 48.30,74.24) -> Dire Maul (map 236 31.69,72.04) via floor
    {
        fromPointID = 100357,
        fromMap = 237,
        fromX = 0.483,
        fromY = 0.7424,
        toPointID = 100352,
        toMap = 236,
        toX = 0.3169,
        toY = 0.7204,
        type = "floor",
    },
    -- Dire Maul (map 237 56.27,24.42) -> Dire Maul (map 236 39.22,34.98) via floor
    {
        fromPointID = 100358,
        fromMap = 237,
        fromX = 0.5627,
        fromY = 0.2442,
        toPointID = 100353,
        toMap = 236,
        toX = 0.3922,
        toY = 0.3498,
        type = "floor",
    },

    -- Zone: Dire Maul (map 238)
    -- Dire Maul (map 238 75.94,39.95) -> Dire Maul (map 236 29.47,42.67) via floor
    {
        fromPointID = 100359,
        fromMap = 238,
        fromX = 0.7594,
        fromY = 0.3995,
        toPointID = 100351,
        toMap = 236,
        toX = 0.2947,
        toY = 0.4267,
        type = "floor",
    },

    -- Zone: Dire Maul (map 239)
    -- Dire Maul (map 239 46.43,63.58) -> Dire Maul (map 240 61.27,82.67) via floor
    {
        fromPointID = 100362,
        fromMap = 239,
        fromX = 0.4643,
        fromY = 0.6358,
        toPointID = 100365,
        toMap = 240,
        toX = 0.6127,
        toY = 0.8267,
        type = "floor",
    },

    -- Zone: Dire Maul (map 240)
    -- Dire Maul (map 240 61.27,82.67) -> Dire Maul (map 239 46.43,63.58) via floor
    {
        fromPointID = 100365,
        fromMap = 240,
        fromX = 0.6127,
        fromY = 0.8267,
        toPointID = 100362,
        toMap = 239,
        toX = 0.4643,
        toY = 0.6358,
        type = "floor",
    },

    -- Zone: Dragonskull Island (map 2150)
    -- Dragonskull Island (map 2150 11.14,68.72) -> The Forbidden Reach (map 2151 74.46,36.07) via floor
    {
        fromPointID = 1100159,
        fromMap = 2150,
        fromX = 0.1114,
        fromY = 0.6872,
        toPointID = 1100165,
        toMap = 2151,
        toX = 0.7446,
        toY = 0.3607,
        type = "floor",
    },
    -- Dragonskull Island (map 2150 32.01,92.66) -> The Forbidden Reach (map 2151 76.67,37.79) via floor
    {
        fromPointID = 1100160,
        fromMap = 2150,
        fromX = 0.3201,
        fromY = 0.9266,
        toPointID = 1100166,
        toMap = 2151,
        toX = 0.7667,
        toY = 0.3779,
        type = "floor",
    },

    -- Zone: Drak'Tharon Keep (map 160)
    -- Drak'Tharon Keep (map 160 64.40,71.60) -> Drak'Tharon Keep (map 161 50.50,71.50) via floor
    {
        fromPointID = 400189,
        fromMap = 160,
        fromX = 0.644,
        fromY = 0.716,
        toPointID = 400190,
        toMap = 161,
        toX = 0.505,
        toY = 0.715,
        type = "floor",
    },

    -- Zone: Drak'Tharon Keep (map 161)
    -- Drak'Tharon Keep (map 161 50.50,71.50) -> Drak'Tharon Keep (map 160 64.40,71.60) via floor
    {
        fromPointID = 400190,
        fromMap = 161,
        fromX = 0.505,
        fromY = 0.715,
        toPointID = 400189,
        toMap = 160,
        toX = 0.644,
        toY = 0.716,
        type = "floor",
    },

    -- Zone: Dun Morogh (map 27)
    -- Dun Morogh (map 27 41.10,70.00) -> Dun Morogh (map 28 38.00,91.10) via floor
    {
        fromPointID = 200122,
        fromMap = 27,
        fromX = 0.411,
        fromY = 0.7,
        toPointID = 200132,
        toMap = 28,
        toX = 0.38,
        toY = 0.911,
        type = "floor",
    },
    -- Dun Morogh (map 27 42.70,64.10) -> Dun Morogh (map 28 60.60,11.00) via floor
    {
        fromPointID = 200123,
        fromMap = 27,
        fromX = 0.427,
        fromY = 0.641,
        toPointID = 200133,
        toMap = 28,
        toX = 0.606,
        toY = 0.11,
        type = "floor",
    },
    -- Dun Morogh (map 27 48.90,52.60) -> Dun Morogh (map 29 60.40,77.00) via floor
    {
        fromPointID = 200124,
        fromMap = 27,
        fromX = 0.489,
        fromY = 0.526,
        toPointID = 200134,
        toMap = 29,
        toX = 0.604,
        toY = 0.77,
        type = "floor",
    },
    -- Dun Morogh (map 27 77.80,55.10) -> Dun Morogh (map 31 39.60,84.20) via floor
    {
        fromPointID = 200128,
        fromMap = 27,
        fromX = 0.778,
        fromY = 0.551,
        toPointID = 200138,
        toMap = 31,
        toX = 0.396,
        toY = 0.842,
        type = "floor",
    },

    -- Zone: Durotar (map 1)
    -- Durotar (map 1 45.35,56.32) -> Valley of Trials (map 461 52.87,21.89) via floor
    {
        fromPointID = 100009,
        fromMap = 1,
        fromX = 0.4535,
        fromY = 0.5632,
        toPointID = 100439,
        toMap = 461,
        toX = 0.5287,
        toY = 0.2189,
        type = "floor",
    },
    -- Durotar (map 1 45.40,56.21) -> Durotar (map 2 72.48,89.43) via floor
    {
        fromPointID = 100010,
        fromMap = 1,
        fromX = 0.454,
        fromY = 0.5621,
        toPointID = 100021,
        toMap = 2,
        toX = 0.7248,
        toY = 0.8943,
        type = "floor",
    },
    -- Durotar (map 1 52.83,28.69) -> Durotar (map 6 49.95,91.36) via floor
    {
        fromPointID = 100013,
        fromMap = 1,
        fromX = 0.5283,
        fromY = 0.2869,
        toPointID = 100029,
        toMap = 6,
        toX = 0.4995,
        toY = 0.9136,
        type = "floor",
    },
    -- Durotar (map 1 54.99,9.67) -> Durotar (map 5 84.13,53.61) via floor
    {
        fromPointID = 100015,
        fromMap = 1,
        fromX = 0.5499,
        fromY = 0.0967,
        toPointID = 100028,
        toMap = 5,
        toX = 0.8413,
        toY = 0.5361,
        type = "floor",
    },
    -- Durotar (map 1 58.94,58.31) -> Durotar (map 3 34.55,52.42) via floor
    {
        fromPointID = 100017,
        fromMap = 1,
        fromX = 0.5894,
        fromY = 0.5831,
        toPointID = 100022,
        toMap = 3,
        toX = 0.3455,
        toY = 0.5242,
        type = "floor",
    },
    -- Durotar (map 1 59.65,57.68) -> Durotar (map 4 58.23,21.18) via floor
    {
        fromPointID = 100018,
        fromMap = 1,
        fromX = 0.5965,
        fromY = 0.5768,
        toPointID = 100026,
        toMap = 4,
        toX = 0.5823,
        toY = 0.2118,
        type = "floor",
    },

    -- Zone: Dustwind Cave (map 6)
    -- Durotar (map 6 49.95,91.36) -> Durotar (map 1 52.83,28.69) via floor
    {
        fromPointID = 100029,
        fromMap = 6,
        fromX = 0.4995,
        fromY = 0.9136,
        toPointID = 100013,
        toMap = 1,
        toX = 0.5283,
        toY = 0.2869,
        type = "floor",
    },

    -- Zone: Eastern Plaguelands (map 23)
    -- Eastern Plaguelands (map 23 75.37,52.73) -> Eastern Plaguelands (map 24 40.60,91.63) via floor
    {
        fromPointID = 200097,
        fromMap = 23,
        fromX = 0.7537,
        fromY = 0.5273,
        toPointID = 200101,
        toMap = 24,
        toX = 0.406,
        toY = 0.9163,
        type = "floor",
    },

    -- Zone: Echo Isles (map 463)
    -- Echo Isles (map 463 59.11,22.33) -> Echo Isles (map 464 54.16,80.12) via floor
    {
        fromPointID = 100444,
        fromMap = 463,
        fromX = 0.5911,
        fromY = 0.2233,
        toPointID = 100447,
        toMap = 464,
        toX = 0.5416,
        toY = 0.8012,
        type = "floor",
    },

    -- Zone: Elor'shan (map 686)
    -- Suramar (map 686 56.43,86.96) -> Suramar (map 680 65.95,42.06) via floor
    {
        fromPointID = 700211,
        fromMap = 686,
        fromX = 0.5643,
        fromY = 0.8696,
        toPointID = 700200,
        toMap = 680,
        toX = 0.6595,
        toY = 0.4206,
        type = "floor",
    },

    -- Zone: Elwynn Forest (map 37)
    -- Elwynn Forest (map 37 38.50,81.50) -> Elwynn Forest (map 39 35.20,68.40) via floor
    {
        fromPointID = 200176,
        fromMap = 37,
        fromX = 0.385,
        fromY = 0.815,
        toPointID = 200187,
        toMap = 39,
        toX = 0.352,
        toY = 0.684,
        type = "floor",
    },
    -- Elwynn Forest (map 37 38.90,82.30) -> Elwynn Forest (map 38 39.90,88.00) via floor
    {
        fromPointID = 200177,
        fromMap = 37,
        fromX = 0.389,
        fromY = 0.823,
        toPointID = 200185,
        toMap = 38,
        toX = 0.399,
        toY = 0.88,
        type = "floor",
    },
    -- Elwynn Forest (map 37 61.70,53.70) -> Elwynn Forest (map 40 48.90,90.10) via floor
    {
        fromPointID = 200182,
        fromMap = 37,
        fromX = 0.617,
        fromY = 0.537,
        toPointID = 200189,
        toMap = 40,
        toX = 0.489,
        toY = 0.901,
        type = "floor",
    },

    -- Zone: Elysian Hold (map 1707)
    -- Elysian Hold (map 1707 50.86,49.18) -> Elysian Hold (map 1707 53.12,45.76) via floor
    {
        fromPointID = 1000268,
        fromMap = 1707,
        fromX = 0.5086,
        fromY = 0.4918,
        toPointID = 1000269,
        toMap = 1707,
        toX = 0.5312,
        toY = 0.4576,
        type = "floor",
    },
    -- Elysian Hold (map 1707 53.12,45.76) -> Elysian Hold (map 1707 50.86,49.18) via floor
    {
        fromPointID = 1000269,
        fromMap = 1707,
        fromX = 0.5312,
        fromY = 0.4576,
        toPointID = 1000268,
        toMap = 1707,
        toX = 0.5086,
        toY = 0.4918,
        type = "floor",
    },
    -- Elysian Hold (map 1707 53.12,45.76) -> Elysian Hold (map 1708 55.68,42.09) via floor
    {
        fromPointID = 1000269,
        fromMap = 1707,
        fromX = 0.5312,
        fromY = 0.4576,
        toPointID = 1000271,
        toMap = 1708,
        toX = 0.5568,
        toY = 0.4209,
        type = "floor",
    },

    -- Zone: Elysian Hold (map 1708)
    -- Elysian Hold (map 1708 55.68,42.09) -> Elysian Hold (map 1707 53.12,45.76) via floor
    {
        fromPointID = 1000271,
        fromMap = 1708,
        fromX = 0.5568,
        fromY = 0.4209,
        toPointID = 1000269,
        toMap = 1707,
        toX = 0.5312,
        toY = 0.4576,
        type = "floor",
    },

    -- Zone: Emberstone Mine (map 180)
    -- Gilneas (map 180 28.91,67.78) -> Gilneas (map 179 76.44,31.19) via floor
    {
        fromPointID = 200351,
        fromMap = 180,
        fromX = 0.2891,
        fromY = 0.6778,
        toPointID = 200350,
        toMap = 179,
        toX = 0.7644,
        toY = 0.3119,
        type = "floor",
    },

    -- Zone: Emerald Dream (map 2200)
    -- The Emerald Dream (map 2200 51.09,42.75) -> Sor'theril Barrow Den (map 2253 71.46,88.04) via floor
    {
        fromPointID = 1100200,
        fromMap = 2200,
        fromX = 0.5109,
        fromY = 0.4275,
        toPointID = 1100234,
        toMap = 2253,
        toX = 0.7146,
        toY = 0.8804,
        type = "floor",
    },
    -- The Emerald Dream (map 2200 63.47,71.71) -> Barrows of Reverie (map 2254 67.41,21.23) via floor
    {
        fromPointID = 1100202,
        fromMap = 2200,
        fromX = 0.6347,
        fromY = 0.7171,
        toPointID = 1100235,
        toMap = 2254,
        toX = 0.6741,
        toY = 0.2123,
        type = "floor",
    },

    -- Zone: Etheric Vault (map 1649)
    -- Etheric Vault (map 1649 62.64,69.18) -> Maldraxxus (map 1536 24.45,31.55) via floor
    {
        fromPointID = 1000150,
        fromMap = 1649,
        fromX = 0.6264,
        fromY = 0.6918,
        toPointID = 1000062,
        toMap = 1536,
        toX = 0.2445,
        toY = 0.3155,
        type = "floor",
    },

    -- Zone: Eversong Woods (map 2395)
    -- Eversong Woods M (map 2395 56.76,65.79) -> Wartha'nan Crypts (map 2579 88.60,34.75) via floor
    {
        fromPointID = 200677,
        fromMap = 2395,
        fromX = 0.5676,
        fromY = 0.6579,
        toPointID = 200850,
        toMap = 2579,
        toX = 0.886,
        toY = 0.3475,
        type = "floor",
    },

    -- Zone: Extractor's Sanatorium (map 1822)
    -- Extractor's Sanatorium (map 1822 19.94,73.08) -> The Maw (map 1543 27.87,20.52) via floor
    {
        fromPointID = 1000304,
        fromMap = 1822,
        fromX = 0.1994,
        fromY = 0.7308,
        toPointID = 1000094,
        toMap = 1543,
        toX = 0.2787,
        toY = 0.2052,
        type = "floor",
    },

    -- Zone: Fargodeep Mine (map 38)
    -- Elwynn Forest (map 38 39.90,88.00) -> Elwynn Forest (map 37 38.90,82.30) via floor
    {
        fromPointID = 200185,
        fromMap = 38,
        fromX = 0.399,
        fromY = 0.88,
        toPointID = 200177,
        toMap = 37,
        toX = 0.389,
        toY = 0.823,
        type = "floor",
    },
    -- Elwynn Forest (map 38 55.40,36.30) -> Elwynn Forest (map 39 56.30,26.00) via floor
    {
        fromPointID = 200186,
        fromMap = 38,
        fromX = 0.554,
        fromY = 0.363,
        toPointID = 200188,
        toMap = 39,
        toX = 0.563,
        toY = 0.26,
        type = "floor",
    },

    -- Zone: Fargodeep Mine (map 39)
    -- Elwynn Forest (map 39 35.20,68.40) -> Elwynn Forest (map 37 38.50,81.50) via floor
    {
        fromPointID = 200187,
        fromMap = 39,
        fromX = 0.352,
        fromY = 0.684,
        toPointID = 200176,
        toMap = 37,
        toX = 0.385,
        toY = 0.815,
        type = "floor",
    },
    -- Elwynn Forest (map 39 56.30,26.00) -> Elwynn Forest (map 38 55.40,36.30) via floor
    {
        fromPointID = 200188,
        fromMap = 39,
        fromX = 0.563,
        fromY = 0.26,
        toPointID = 200186,
        toMap = 38,
        toX = 0.554,
        toY = 0.363,
        type = "floor",
    },

    -- Zone: Fel Rock (map 59)
    -- Teldrassil (map 59 77.60,81.70) -> Teldrassil (map 57 54.50,46.30) via floor
    {
        fromPointID = 100074,
        fromMap = 59,
        fromX = 0.776,
        fromY = 0.817,
        toPointID = 100069,
        toMap = 57,
        toX = 0.545,
        toY = 0.463,
        type = "floor",
    },

    -- Zone: Firelands (map 368)
    -- Firelands (map 368 49.70,1.00) -> Firelands (map 369 52.30,81.90) via floor
    {
        fromPointID = 100412,
        fromMap = 368,
        fromX = 0.497,
        fromY = 0.01,
        toPointID = 100413,
        toMap = 369,
        toX = 0.523,
        toY = 0.819,
        type = "floor",
    },

    -- Zone: Firelands (map 369)
    -- Firelands (map 369 52.30,81.90) -> Firelands (map 368 49.70,1.00) via floor
    {
        fromPointID = 100413,
        fromMap = 369,
        fromX = 0.523,
        fromY = 0.819,
        toPointID = 100412,
        toMap = 368,
        toX = 0.497,
        toY = 0.01,
        type = "floor",
    },

    -- Zone: Forgotten Depths (map 2620)
    -- Forgotten Depths (map 2620 32.43,37.45) -> Forgotten Depths (map 2621 27.23,56.12) via floor
    {
        fromPointID = 200886,
        fromMap = 2620,
        fromX = 0.3243,
        fromY = 0.3745,
        toPointID = 200887,
        toMap = 2621,
        toX = 0.2723,
        toY = 0.5612,
        type = "floor",
    },

    -- Zone: Forgotten Depths (map 2621)
    -- Forgotten Depths (map 2621 27.23,56.12) -> Forgotten Depths (map 2620 32.43,37.45) via floor
    {
        fromPointID = 200887,
        fromMap = 2621,
        fromX = 0.2723,
        fromY = 0.5612,
        toPointID = 200886,
        toMap = 2620,
        toX = 0.3243,
        toY = 0.3745,
        type = "floor",
    },

    -- Zone: Frostmane Hold (map 470)
    -- New Tinkertown (map 470 94.60,58.10) -> New Tinkertown (map 469 33.30,66.40) via floor
    {
        fromPointID = 200615,
        fromMap = 470,
        fromX = 0.946,
        fromY = 0.581,
        toPointID = 200612,
        toMap = 469,
        toX = 0.333,
        toY = 0.664,
        type = "floor",
    },

    -- Zone: Frostmane Hovel (map 428)
    -- Coldridge Valley (map 428 14.40,50.10) -> Coldridge Valley (map 427 51.30,82.50) via floor
    {
        fromPointID = 200602,
        fromMap = 428,
        fromX = 0.144,
        fromY = 0.501,
        toPointID = 200599,
        toMap = 427,
        toX = 0.513,
        toY = 0.825,
        type = "floor",
    },

    -- Zone: Froststone Vault (map 2154)
    -- Froststone Vault (map 2154 26.80,83.77) -> The Forbidden Reach (map 2151 60.68,37.91) via floor
    {
        fromPointID = 1100167,
        fromMap = 2154,
        fromX = 0.268,
        fromY = 0.8377,
        toPointID = 1100163,
        toMap = 2151,
        toX = 0.6068,
        toY = 0.3791,
        type = "floor",
    },

    -- Zone: Gate of the Setting Sun (map 437)
    -- Gate of the Setting Sun (map 437 46.30,33.10) -> Gate of the Setting Sun (map 438 50.00,50.80) via floor
    {
        fromPointID = 500159,
        fromMap = 437,
        fromX = 0.463,
        fromY = 0.331,
        toPointID = 500161,
        toMap = 438,
        toX = 0.5,
        toY = 0.508,
        type = "floor",
    },

    -- Zone: Gate of the Setting Sun (map 438)
    -- Gate of the Setting Sun (map 438 50.00,50.80) -> Gate of the Setting Sun (map 437 46.30,33.10) via floor
    {
        fromPointID = 500161,
        fromMap = 438,
        fromX = 0.5,
        fromY = 0.508,
        toPointID = 500159,
        toMap = 437,
        toX = 0.463,
        toY = 0.331,
        type = "floor",
    },

    -- Zone: Gilneas (map 179)
    -- Gilneas (map 179 29.03,51.66) -> Gilneas (map 181 66.89,58.26) via floor
    {
        fromPointID = 200349,
        fromMap = 179,
        fromX = 0.2903,
        fromY = 0.5166,
        toPointID = 200353,
        toMap = 181,
        toX = 0.6689,
        toY = 0.5826,
        type = "floor",
    },
    -- Gilneas (map 179 76.44,31.19) -> Gilneas (map 180 28.91,67.78) via floor
    {
        fromPointID = 200350,
        fromMap = 179,
        fromX = 0.7644,
        fromY = 0.3119,
        toPointID = 200351,
        toMap = 180,
        toX = 0.2891,
        toY = 0.6778,
        type = "floor",
    },

    -- Zone: Gnomeregan (map 226)
    -- Gnomeregan (map 226 34.33,61.78) -> Gnomeregan (map 227 61.73,61.55) via floor
    {
        fromPointID = 200394,
        fromMap = 226,
        fromX = 0.3433,
        fromY = 0.6178,
        toPointID = 200398,
        toMap = 227,
        toX = 0.6173,
        toY = 0.6155,
        type = "floor",
    },
    -- Gnomeregan (map 226 47.05,86.94) -> Gnomeregan (map 227 75.38,74.06) via floor
    {
        fromPointID = 200395,
        fromMap = 226,
        fromX = 0.4705,
        fromY = 0.8694,
        toPointID = 200399,
        toMap = 227,
        toX = 0.7538,
        toY = 0.7406,
        type = "floor",
    },
    -- Gnomeregan (map 226 57.67,50.98) -> Gnomeregan (map 227 81.36,46.02) via floor
    {
        fromPointID = 200396,
        fromMap = 226,
        fromX = 0.5767,
        fromY = 0.5098,
        toPointID = 200400,
        toMap = 227,
        toX = 0.8136,
        toY = 0.4602,
        type = "floor",
    },

    -- Zone: Gnomeregan (map 227)
    -- Gnomeregan (map 227 35.21,88.08) -> Gnomeregan (map 228 38.60,50.33) via floor
    {
        fromPointID = 200397,
        fromMap = 227,
        fromX = 0.3521,
        fromY = 0.8808,
        toPointID = 200401,
        toMap = 228,
        toX = 0.386,
        toY = 0.5033,
        type = "floor",
    },
    -- Gnomeregan (map 227 61.73,61.55) -> Gnomeregan (map 226 34.33,61.78) via floor
    {
        fromPointID = 200398,
        fromMap = 227,
        fromX = 0.6173,
        fromY = 0.6155,
        toPointID = 200394,
        toMap = 226,
        toX = 0.3433,
        toY = 0.6178,
        type = "floor",
    },
    -- Gnomeregan (map 227 75.38,74.06) -> Gnomeregan (map 226 47.05,86.94) via floor
    {
        fromPointID = 200399,
        fromMap = 227,
        fromX = 0.7538,
        fromY = 0.7406,
        toPointID = 200395,
        toMap = 226,
        toX = 0.4705,
        toY = 0.8694,
        type = "floor",
    },

    -- Zone: Gnomeregan (map 228)
    -- Gnomeregan (map 228 38.60,50.33) -> Gnomeregan (map 227 35.21,88.08) via floor
    {
        fromPointID = 200401,
        fromMap = 228,
        fromX = 0.386,
        fromY = 0.5033,
        toPointID = 200397,
        toMap = 227,
        toX = 0.3521,
        toY = 0.8808,
        type = "floor",
    },
    -- Gnomeregan (map 228 48.26,71.95) -> Gnomeregan (map 229 71.25,77.54) via floor
    {
        fromPointID = 200402,
        fromMap = 228,
        fromX = 0.4826,
        fromY = 0.7195,
        toPointID = 200404,
        toMap = 229,
        toX = 0.7125,
        toY = 0.7754,
        type = "floor",
    },

    -- Zone: Gnomeregan (map 229)
    -- Gnomeregan (map 229 71.25,77.54) -> Gnomeregan (map 228 48.26,71.95) via floor
    {
        fromPointID = 200404,
        fromMap = 229,
        fromX = 0.7125,
        fromY = 0.7754,
        toPointID = 200402,
        toMap = 228,
        toX = 0.4826,
        toY = 0.7195,
        type = "floor",
    },

    -- Zone: Gol Thovas (map 1171)
    -- Tiragarde Sound (map 1171 44.28,88.13) -> Tiragarde Sound (map 895 62.88,27.37) via floor
    {
        fromPointID = 800095,
        fromMap = 1171,
        fromX = 0.4428,
        fromY = 0.8813,
        toPointID = 800003,
        toMap = 895,
        toX = 0.6288,
        toY = 0.2737,
        type = "floor",
    },
    -- Tiragarde Sound (map 1171 50.95,47.91) -> Tiragarde Sound (map 1172 36.75,55.63) via floor
    {
        fromPointID = 800096,
        fromMap = 1171,
        fromX = 0.5095,
        fromY = 0.4791,
        toPointID = 800097,
        toMap = 1172,
        toX = 0.3675,
        toY = 0.5563,
        type = "floor",
    },

    -- Zone: Gol Thovas (map 1172)
    -- Tiragarde Sound (map 1172 36.75,55.63) -> Tiragarde Sound (map 1171 50.95,47.91) via floor
    {
        fromPointID = 800097,
        fromMap = 1172,
        fromX = 0.3675,
        fromY = 0.5563,
        toPointID = 800096,
        toMap = 1171,
        toX = 0.5095,
        toY = 0.4791,
        type = "floor",
    },

    -- Zone: Gol'Bolar Quarry (map 31)
    -- Dun Morogh (map 31 39.60,84.20) -> Dun Morogh (map 27 77.80,55.10) via floor
    {
        fromPointID = 200138,
        fromMap = 31,
        fromX = 0.396,
        fromY = 0.842,
        toPointID = 200128,
        toMap = 27,
        toX = 0.778,
        toY = 0.551,
        type = "floor",
    },

    -- Zone: Gravid Repose (map 2029)
    -- Gravid Repose (map 2029 69.62,9.03) -> Zereth Mortis (map 1970 50.57,32.08) via floor
    {
        fromPointID = 1000362,
        fromMap = 2029,
        fromX = 0.6962,
        fromY = 0.0903,
        toPointID = 1000325,
        toMap = 1970,
        toX = 0.5057,
        toY = 0.3208,
        type = "floor",
    },

    -- Zone: Greymane Manor (map 181)
    -- Gilneas (map 181 61.00,47.50) -> Gilneas (map 182 56.70,47.50) via floor
    {
        fromPointID = 200352,
        fromMap = 181,
        fromX = 0.61,
        fromY = 0.475,
        toPointID = 200354,
        toMap = 182,
        toX = 0.567,
        toY = 0.475,
        type = "floor",
    },
    -- Gilneas (map 181 66.89,58.26) -> Gilneas (map 179 29.03,51.66) via floor
    {
        fromPointID = 200353,
        fromMap = 181,
        fromX = 0.6689,
        fromY = 0.5826,
        toPointID = 200349,
        toMap = 179,
        toX = 0.2903,
        toY = 0.5166,
        type = "floor",
    },

    -- Zone: Greymane Manor (map 182)
    -- Gilneas (map 182 56.70,47.50) -> Gilneas (map 181 61.00,47.50) via floor
    {
        fromPointID = 200354,
        fromMap = 182,
        fromX = 0.567,
        fromY = 0.475,
        toPointID = 200352,
        toMap = 181,
        toX = 0.61,
        toY = 0.475,
        type = "floor",
    },

    -- Zone: Gromit Hollow (map 2007)
    -- Gromit Hollow (map 2007 65.79,35.02) -> Korthia (map 1961 30.15,55.13) via floor
    {
        fromPointID = 1000358,
        fromMap = 2007,
        fromX = 0.6579,
        fromY = 0.3502,
        toPointID = 1000312,
        toMap = 1961,
        toX = 0.3015,
        toY = 0.5513,
        type = "floor",
    },

    -- Zone: Gulf of Memory (map 2505)
    -- Gulf Of Memory (map 2505 44.40,77.65) -> Gulf Of Memory (map 2575 51.22,60.15) via floor
    {
        fromPointID = 200754,
        fromMap = 2505,
        fromX = 0.444,
        fromY = 0.7765,
        toPointID = 200845,
        toMap = 2575,
        toX = 0.5122,
        toY = 0.6015,
        type = "floor",
    },

    -- Zone: Gulf of Memory (map 2575)
    -- Gulf Of Memory (map 2575 51.22,60.15) -> Gulf Of Memory (map 2505 44.40,77.65) via floor
    {
        fromPointID = 200845,
        fromMap = 2575,
        fromX = 0.5122,
        fromY = 0.6015,
        toPointID = 200754,
        toMap = 2505,
        toX = 0.444,
        toY = 0.7765,
        type = "floor",
    },

    -- Zone: Guo-Lai Halls (map 395)
    -- Vale of Eternal Blossoms (map 395 54.00,88.20) -> Vale of Eternal Blossoms (map 390 22.20,26.30) via floor
    {
        fromPointID = 500120,
        fromMap = 395,
        fromX = 0.54,
        fromY = 0.882,
        toPointID = 500110,
        toMap = 390,
        toX = 0.222,
        toY = 0.263,
        type = "floor",
    },

    -- Zone: Hall of the Guardian (map 734)
    -- Hall of the Guardian (map 734 59.64,60.14) -> Hall of the Guardian (map 735 58.32,65.16) via floor
    {
        fromPointID = 700258,
        fromMap = 734,
        fromX = 0.5964,
        fromY = 0.6014,
        toPointID = 700262,
        toMap = 735,
        toX = 0.5832,
        toY = 0.6516,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41036,
                },
            },
        },
    },

    -- Zone: Hall of the Guardian (map 735)
    -- Hall of the Guardian (map 735 58.32,65.16) -> Hall of the Guardian (map 734 59.64,60.14) via floor
    {
        fromPointID = 700262,
        fromMap = 735,
        fromX = 0.5832,
        fromY = 0.6516,
        toPointID = 700258,
        toMap = 734,
        toX = 0.5964,
        toY = 0.6014,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 41036,
                },
            },
        },
    },

    -- Zone: Halls Of Infusion (map 2082)
    -- Halls of Infusion (map 2082 63.41,79.61) -> Halls of Infusion (map 2083 57.93,79.08) via floor
    {
        fromPointID = 1100089,
        fromMap = 2082,
        fromX = 0.6341,
        fromY = 0.7961,
        toPointID = 1100090,
        toMap = 2083,
        toX = 0.5793,
        toY = 0.7908,
        type = "floor",
    },

    -- Zone: Halls Of Infusion (map 2083)
    -- Halls of Infusion (map 2083 57.93,79.08) -> Halls of Infusion (map 2082 63.41,79.61) via floor
    {
        fromPointID = 1100090,
        fromMap = 2083,
        fromX = 0.5793,
        fromY = 0.7908,
        toPointID = 1100089,
        toMap = 2082,
        toX = 0.6341,
        toY = 0.7961,
        type = "floor",
    },

    -- Zone: Halls Of Valor (map 2230)
    -- Halls of Valor D (map 2230 47.72,71.74) -> Halls of Valor D (map 2231 51.35,6.34) via floor
    {
        fromPointID = 700350,
        fromMap = 2230,
        fromX = 0.4772,
        fromY = 0.7174,
        toPointID = 700351,
        toMap = 2231,
        toX = 0.5135,
        toY = 0.0634,
        type = "floor",
    },

    -- Zone: Halls Of Valor (map 2231)
    -- Halls of Valor D (map 2231 51.35,6.34) -> Halls of Valor D (map 2230 47.72,71.74) via floor
    {
        fromPointID = 700351,
        fromMap = 2231,
        fromX = 0.5135,
        fromY = 0.0634,
        toPointID = 700350,
        toMap = 2230,
        toX = 0.4772,
        toY = 0.7174,
        type = "floor",
    },

    -- Zone: Halls of Atonement (map 1663)
    -- Halls of Atonement (map 1663 23.06,53.91) -> Halls of Atonement (map 1664 83.98,50.22) via floor
    {
        fromPointID = 1000154,
        fromMap = 1663,
        fromX = 0.2306,
        fromY = 0.5391,
        toPointID = 1000156,
        toMap = 1664,
        toX = 0.8398,
        toY = 0.5022,
        type = "floor",
    },

    -- Zone: Halls of Atonement (map 1664)
    -- Halls of Atonement (map 1664 19.18,37.84) -> Halls of Atonement (map 1665 71.43,49.21) via floor
    {
        fromPointID = 1000155,
        fromMap = 1664,
        fromX = 0.1918,
        fromY = 0.3784,
        toPointID = 1000157,
        toMap = 1665,
        toX = 0.7143,
        toY = 0.4921,
        type = "floor",
    },
    -- Halls of Atonement (map 1664 83.98,50.22) -> Halls of Atonement (map 1663 23.06,53.91) via floor
    {
        fromPointID = 1000156,
        fromMap = 1664,
        fromX = 0.8398,
        fromY = 0.5022,
        toPointID = 1000154,
        toMap = 1663,
        toX = 0.2306,
        toY = 0.5391,
        type = "floor",
    },

    -- Zone: Halls of Atonement (map 1665)
    -- Halls of Atonement (map 1665 71.43,49.21) -> Halls of Atonement (map 1664 19.18,37.84) via floor
    {
        fromPointID = 1000157,
        fromMap = 1665,
        fromX = 0.7143,
        fromY = 0.4921,
        toPointID = 1000155,
        toMap = 1664,
        toX = 0.1918,
        toY = 0.3784,
        type = "floor",
    },

    -- Zone: Halls of Lightning (map 138)
    -- Halls of Lightning (map 138 89.00,53.80) -> Halls of Lightning (map 139 57.00,21.30) via floor
    {
        fromPointID = 400158,
        fromMap = 138,
        fromX = 0.89,
        fromY = 0.538,
        toPointID = 400159,
        toMap = 139,
        toX = 0.57,
        toY = 0.213,
        type = "floor",
    },

    -- Zone: Halls of Lightning (map 139)
    -- Halls of Lightning (map 139 57.00,21.30) -> Halls of Lightning (map 138 89.00,53.80) via floor
    {
        fromPointID = 400159,
        fromMap = 139,
        fromX = 0.57,
        fromY = 0.213,
        toPointID = 400158,
        toMap = 138,
        toX = 0.89,
        toY = 0.538,
        type = "floor",
    },

    -- Zone: Halls of Origination (map 1540)
    -- Halls of Origination S (map 1540 89.82,49.78) -> Halls of Origination S (map 1541 24.68,49.39) via floor
    {
        fromPointID = 100478,
        fromMap = 1540,
        fromX = 0.8982,
        fromY = 0.4978,
        toPointID = 100479,
        toMap = 1541,
        toX = 0.2468,
        toY = 0.4939,
        type = "floor",
    },

    -- Zone: Halls of Origination (map 1541)
    -- Halls of Origination S (map 1541 24.68,49.39) -> Halls of Origination S (map 1540 89.82,49.78) via floor
    {
        fromPointID = 100479,
        fromMap = 1541,
        fromX = 0.2468,
        fromY = 0.4939,
        toPointID = 100478,
        toMap = 1540,
        toX = 0.8982,
        toY = 0.4978,
        type = "floor",
    },

    -- Zone: Halls of Origination (map 297)
    -- Halls of Origination (map 297 66.50,48.30) -> Halls of Origination (map 299 45.90,47.60) via floor
    {
        fromPointID = 100386,
        fromMap = 297,
        fromX = 0.665,
        fromY = 0.483,
        toPointID = 100391,
        toMap = 299,
        toX = 0.459,
        toY = 0.476,
        type = "floor",
    },
    -- Halls of Origination (map 297 67.50,52.60) -> Halls of Origination (map 298 66.70,48.50) via floor
    {
        fromPointID = 100387,
        fromMap = 297,
        fromX = 0.675,
        fromY = 0.526,
        toPointID = 100390,
        toMap = 298,
        toX = 0.667,
        toY = 0.485,
        type = "floor",
    },
    -- Halls of Origination (map 297 89.70,49.80) -> Halls of Origination (map 298 24.90,49.40) via floor
    {
        fromPointID = 100388,
        fromMap = 297,
        fromX = 0.897,
        fromY = 0.498,
        toPointID = 100389,
        toMap = 298,
        toX = 0.249,
        toY = 0.494,
        type = "floor",
    },

    -- Zone: Halls of Origination (map 298)
    -- Halls of Origination (map 298 24.90,49.40) -> Halls of Origination (map 297 89.70,49.80) via floor
    {
        fromPointID = 100389,
        fromMap = 298,
        fromX = 0.249,
        fromY = 0.494,
        toPointID = 100388,
        toMap = 297,
        toX = 0.897,
        toY = 0.498,
        type = "floor",
    },
    -- Halls of Origination (map 298 66.70,48.50) -> Halls of Origination (map 297 67.50,52.60) via floor
    {
        fromPointID = 100390,
        fromMap = 298,
        fromX = 0.667,
        fromY = 0.485,
        toPointID = 100387,
        toMap = 297,
        toX = 0.675,
        toY = 0.526,
        type = "floor",
    },

    -- Zone: Halls of Origination (map 299)
    -- Halls of Origination (map 299 45.90,47.60) -> Halls of Origination (map 297 66.50,48.30) via floor
    {
        fromPointID = 100391,
        fromMap = 299,
        fromX = 0.459,
        fromY = 0.476,
        toPointID = 100386,
        toMap = 297,
        toX = 0.665,
        toY = 0.483,
        type = "floor",
    },

    -- Zone: Harandar (map 2413)
    -- Harandar (map 2413 66.17,61.69) -> Floaret Grotto (map 2522 31.91,85.85) via floor
    {
        fromPointID = 200704,
        fromMap = 2413,
        fromX = 0.6617,
        fromY = 0.6169,
        toPointID = 200810,
        toMap = 2522,
        toX = 0.3191,
        toY = 0.8585,
        type = "floor",
    },

    -- Zone: Heart of Fear (map 474)
    -- Heart of Fear (map 474 32.10,16.30) -> Heart of Fear (map 475 66.30,27.20) via floor
    {
        fromPointID = 500196,
        fromMap = 474,
        fromX = 0.321,
        fromY = 0.163,
        toPointID = 500198,
        toMap = 475,
        toX = 0.663,
        toY = 0.272,
        type = "floor",
    },

    -- Zone: Heart of Fear (map 475)
    -- Heart of Fear (map 475 66.30,27.20) -> Heart of Fear (map 474 32.10,16.30) via floor
    {
        fromPointID = 500198,
        fromMap = 475,
        fromX = 0.663,
        fromY = 0.272,
        toPointID = 500196,
        toMap = 474,
        toX = 0.321,
        toY = 0.163,
        type = "floor",
    },

    -- Zone: Heart of the Forest (map 1701)
    -- Heart of the Forest (map 1701 45.23,47.01) -> Heart of the Forest (map 1702 45.81,71.75) via floor
    {
        fromPointID = 1000251,
        fromMap = 1701,
        fromX = 0.4523,
        fromY = 0.4701,
        toPointID = 1000254,
        toMap = 1702,
        toX = 0.4581,
        toY = 0.7175,
        type = "floor",
    },

    -- Zone: Heart of the Forest (map 1702)
    -- Heart of the Forest (map 1702 45.81,71.75) -> Heart of the Forest (map 1701 45.23,47.01) via floor
    {
        fromPointID = 1000254,
        fromMap = 1702,
        fromX = 0.4581,
        fromY = 0.7175,
        toPointID = 1000251,
        toMap = 1701,
        toX = 0.4523,
        toY = 0.4701,
        type = "floor",
    },

    -- Zone: Highmountain (map 650)
    -- Highmountain (map 650 36.13,44.71) -> Trueshot Lodge (map 739 42.72,9.98) via floor
    {
        fromPointID = 700129,
        fromMap = 650,
        fromX = 0.3613,
        fromY = 0.4471,
        toPointID = 700264,
        toMap = 739,
        toX = 0.4272,
        toY = 0.0998,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "HUNTER",
                },
                {
                    operation = "check",
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },

    -- Zone: Highmountain (map 869)
    -- Highmountain Invasion (map 869 33.73,36.75) -> Highmountain Invasion (map 870 38.80,28.00) via floor
    {
        fromPointID = 700297,
        fromMap = 869,
        fromX = 0.3373,
        fromY = 0.3675,
        toPointID = 700298,
        toMap = 870,
        toX = 0.388,
        toY = 0.28,
        type = "floor",
    },

    -- Zone: Highmountain (map 870)
    -- Highmountain Invasion (map 870 38.80,28.00) -> Highmountain Invasion (map 869 33.73,36.75) via floor
    {
        fromPointID = 700298,
        fromMap = 870,
        fromX = 0.388,
        fromY = 0.28,
        toPointID = 700297,
        toMap = 869,
        toX = 0.3373,
        toY = 0.3675,
        type = "floor",
    },

    -- Zone: Hour of Twilight (map 399)
    -- Hour of Twilight (map 399 49.30,81.70) -> Hour of Twilight (map 400 49.30,83.00) via floor
    {
        fromPointID = 100416,
        fromMap = 399,
        fromX = 0.493,
        fromY = 0.817,
        toPointID = 100417,
        toMap = 400,
        toX = 0.493,
        toY = 0.83,
        type = "floor",
    },

    -- Zone: Hour of Twilight (map 400)
    -- Hour of Twilight (map 400 49.30,83.00) -> Hour of Twilight (map 399 49.30,81.70) via floor
    {
        fromPointID = 100417,
        fromMap = 400,
        fromX = 0.493,
        fromY = 0.83,
        toPointID = 100416,
        toMap = 399,
        toX = 0.493,
        toY = 0.817,
        type = "floor",
    },

    -- Zone: Howlingwind Cavern (map 380)
    -- Kun-Lai Summit (map 380 66.90,82.30) -> Kun-Lai Summit (map 379 59.10,52.50) via floor
    {
        fromPointID = 500076,
        fromMap = 380,
        fromX = 0.669,
        fromY = 0.823,
        toPointID = 500065,
        toMap = 379,
        toX = 0.591,
        toY = 0.525,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 186)
    -- Icecrown Citadel (map 186 39.07,85.75) -> Icecrown Citadel (map 187 45.60,84.81) via floor
    {
        fromPointID = 400218,
        fromMap = 186,
        fromX = 0.3907,
        fromY = 0.8575,
        toPointID = 400220,
        toMap = 187,
        toX = 0.456,
        toY = 0.8481,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 187)
    -- Icecrown Citadel (map 187 45.60,84.81) -> Icecrown Citadel (map 186 39.07,85.75) via floor
    {
        fromPointID = 400220,
        fromMap = 187,
        fromX = 0.456,
        fromY = 0.8481,
        toPointID = 400218,
        toMap = 186,
        toX = 0.3907,
        toY = 0.8575,
        type = "floor",
    },
    -- Icecrown Citadel (map 187 45.62,73.77) -> Icecrown Citadel (map 188 51.33,83.92) via floor
    {
        fromPointID = 400221,
        fromMap = 187,
        fromX = 0.4562,
        fromY = 0.7377,
        toPointID = 400222,
        toMap = 188,
        toX = 0.5133,
        toY = 0.8392,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 188)
    -- Icecrown Citadel (map 188 51.33,83.92) -> Icecrown Citadel (map 187 45.62,73.77) via floor
    {
        fromPointID = 400222,
        fromMap = 188,
        fromX = 0.5133,
        fromY = 0.8392,
        toPointID = 400221,
        toMap = 187,
        toX = 0.4562,
        toY = 0.7377,
        type = "floor",
    },
    -- Icecrown Citadel (map 188 51.85,19.20) -> Icecrown Citadel (map 190 51.85,83.82) via floor
    {
        fromPointID = 400224,
        fromMap = 188,
        fromX = 0.5185,
        fromY = 0.192,
        toPointID = 400230,
        toMap = 190,
        toX = 0.5185,
        toY = 0.8382,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 189)
    -- Icecrown Citadel (map 189 36.48,89.98) -> Icecrown Citadel (map 190 76.71,91.90) via floor
    {
        fromPointID = 400226,
        fromMap = 189,
        fromX = 0.3648,
        fromY = 0.8998,
        toPointID = 400234,
        toMap = 190,
        toX = 0.7671,
        toY = 0.919,
        type = "floor",
    },
    -- Icecrown Citadel (map 189 50.50,33.31) -> Icecrown Citadel (map 190 85.91,53.55) via floor
    {
        fromPointID = 400227,
        fromMap = 189,
        fromX = 0.505,
        fromY = 0.3331,
        toPointID = 400235,
        toMap = 190,
        toX = 0.8591,
        toY = 0.5355,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 190)
    -- Icecrown Citadel (map 190 43.44,16.66) -> Icecrown Citadel (map 191 23.19,30.52) via floor
    {
        fromPointID = 400228,
        fromMap = 190,
        fromX = 0.4344,
        fromY = 0.1666,
        toPointID = 400236,
        toMap = 191,
        toX = 0.2319,
        toY = 0.3052,
        type = "floor",
    },
    -- Icecrown Citadel (map 190 51.85,83.82) -> Icecrown Citadel (map 188 51.85,19.20) via floor
    {
        fromPointID = 400230,
        fromMap = 190,
        fromX = 0.5185,
        fromY = 0.8382,
        toPointID = 400224,
        toMap = 188,
        toX = 0.5185,
        toY = 0.192,
        type = "floor",
    },
    -- Icecrown Citadel (map 190 52.35,53.69) -> Icecrown Citadel (map 192 49.85,39.13) via floor
    {
        fromPointID = 400232,
        fromMap = 190,
        fromX = 0.5235,
        fromY = 0.5369,
        toPointID = 400239,
        toMap = 192,
        toX = 0.4985,
        toY = 0.3913,
        type = "floor",
    },
    -- Icecrown Citadel (map 190 60.68,17.31) -> Icecrown Citadel (map 191 78.82,31.45) via floor
    {
        fromPointID = 400233,
        fromMap = 190,
        fromX = 0.6068,
        fromY = 0.1731,
        toPointID = 400238,
        toMap = 191,
        toX = 0.7882,
        toY = 0.3145,
        type = "floor",
    },
    -- Icecrown Citadel (map 190 76.71,91.90) -> Icecrown Citadel (map 189 36.48,89.98) via floor
    {
        fromPointID = 400234,
        fromMap = 190,
        fromX = 0.7671,
        fromY = 0.919,
        toPointID = 400226,
        toMap = 189,
        toX = 0.3648,
        toY = 0.8998,
        type = "floor",
    },
    -- Icecrown Citadel (map 190 85.91,53.55) -> Icecrown Citadel (map 189 50.50,33.31) via floor
    {
        fromPointID = 400235,
        fromMap = 190,
        fromX = 0.8591,
        fromY = 0.5355,
        toPointID = 400227,
        toMap = 189,
        toX = 0.505,
        toY = 0.3331,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 191)
    -- Icecrown Citadel (map 191 23.19,30.52) -> Icecrown Citadel (map 190 43.44,16.66) via floor
    {
        fromPointID = 400236,
        fromMap = 191,
        fromX = 0.2319,
        fromY = 0.3052,
        toPointID = 400228,
        toMap = 190,
        toX = 0.4344,
        toY = 0.1666,
        type = "floor",
    },
    -- Icecrown Citadel (map 191 50.65,69.26) -> Icecrown Citadel (map 190 51.82,32.29) via floor
    {
        fromPointID = 400237,
        fromMap = 191,
        fromX = 0.5065,
        fromY = 0.6926,
        toPointID = 400229,
        toMap = 190,
        toX = 0.5182,
        toY = 0.3229,
        type = "floor",
    },
    -- Icecrown Citadel (map 191 78.82,31.45) -> Icecrown Citadel (map 190 60.68,17.31) via floor
    {
        fromPointID = 400238,
        fromMap = 191,
        fromX = 0.7882,
        fromY = 0.3145,
        toPointID = 400233,
        toMap = 190,
        toX = 0.6068,
        toY = 0.1731,
        type = "floor",
    },

    -- Zone: Icecrown Citadel (map 192)
    -- Icecrown Citadel (map 192 49.85,39.13) -> Icecrown Citadel (map 190 52.35,53.69) via floor
    {
        fromPointID = 400239,
        fromMap = 192,
        fromX = 0.4985,
        fromY = 0.3913,
        toPointID = 400232,
        toMap = 190,
        toX = 0.5235,
        toY = 0.5369,
        type = "floor",
    },

    -- Zone: Immemorial Battlefield (map 2197)
    -- Dawn of the Infinite (map 2197 67.12,89.67) -> Dawn of the Infinite (map 2196 37.59,86.44) via floor
    {
        fromPointID = 1100194,
        fromMap = 2197,
        fromX = 0.6712,
        fromY = 0.8967,
        toPointID = 1100192,
        toMap = 2196,
        toX = 0.3759,
        toY = 0.8644,
        type = "floor",
    },

    -- Zone: Infested Tomb (map 2640)
    -- Infested Tomb (map 2640 76.66,41.25) -> The Coiled Isle (map 2512 44.78,30.06) via floor
    {
        fromPointID = 200896,
        fromMap = 2640,
        fromX = 0.7666,
        fromY = 0.4125,
        toPointID = 200784,
        toMap = 2512,
        toX = 0.4478,
        toY = 0.3006,
        type = "floor",
    },

    -- Zone: Infinite Conflux (map 2195)
    -- Dawn of the Infinite (map 2195 50.86,21.59) -> Dawn of the Infinite (map 2196 59.95,20.80) via floor
    {
        fromPointID = 1100190,
        fromMap = 2195,
        fromX = 0.5086,
        fromY = 0.2159,
        toPointID = 1100193,
        toMap = 2196,
        toX = 0.5995,
        toY = 0.208,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2195 59.35,77.91) -> Dawn of the Infinite (map 2194 56.48,55.77) via floor
    {
        fromPointID = 1100191,
        fromMap = 2195,
        fromX = 0.5935,
        fromY = 0.7791,
        toPointID = 1100189,
        toMap = 2194,
        toX = 0.5648,
        toY = 0.5577,
        type = "floor",
    },

    -- Zone: Isle of Quel'Danas (map 2424)
    -- Isle of Quel Danas M (map 2424 64.01,29.12) -> The Lycaneum (map 2649 64.22,87.72) via floor
    {
        fromPointID = 200713,
        fromMap = 2424,
        fromX = 0.6401,
        fromY = 0.2912,
        toPointID = 200906,
        toMap = 2649,
        toX = 0.6422,
        toY = 0.8772,
        type = "floor",
    },

    -- Zone: Isle of Thunder (map 504)
    -- Isle of Thunder (map 504 49.20,32.20) -> Isle of Thunder (map 505 31.70,81.70) via floor
    {
        fromPointID = 500219,
        fromMap = 504,
        fromX = 0.492,
        fromY = 0.322,
        toPointID = 500228,
        toMap = 505,
        toX = 0.317,
        toY = 0.817,
        type = "floor",
    },
    -- Isle of Thunder (map 504 49.30,25.50) -> Isle of Thunder (map 505 38.80,27.10) via floor
    {
        fromPointID = 500220,
        fromMap = 504,
        fromX = 0.493,
        fromY = 0.255,
        toPointID = 500229,
        toMap = 505,
        toX = 0.388,
        toY = 0.271,
        type = "floor",
    },
    -- Isle of Thunder (map 504 54.60,29.10) -> Isle of Thunder (map 505 73.10,51.30) via floor
    {
        fromPointID = 500222,
        fromMap = 504,
        fromX = 0.546,
        fromY = 0.291,
        toPointID = 500230,
        toMap = 505,
        toX = 0.731,
        toY = 0.513,
        type = "floor",
    },
    -- Isle of Thunder (map 504 62.40,40.30) -> Isle of Thunder (map 506 66.10,77.90) via floor
    {
        fromPointID = 500223,
        fromMap = 504,
        fromX = 0.624,
        fromY = 0.403,
        toPointID = 500231,
        toMap = 506,
        toX = 0.661,
        toY = 0.779,
        type = "floor",
    },

    -- Zone: Isle of Thunder (map 516)
    -- Isle of Thunder Scenario (map 516 49.20,33.00) -> Isle of Thunder Scenario (map 517 31.50,82.00) via floor
    {
        fromPointID = 500247,
        fromMap = 516,
        fromX = 0.492,
        fromY = 0.33,
        toPointID = 500251,
        toMap = 517,
        toX = 0.315,
        toY = 0.82,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 516 49.27,25.52) -> Isle of Thunder Scenario (map 517 37.45,26.92) via floor
    {
        fromPointID = 500248,
        fromMap = 516,
        fromX = 0.4927,
        fromY = 0.2552,
        toPointID = 500252,
        toMap = 517,
        toX = 0.3745,
        toY = 0.2692,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 516 54.60,29.10) -> Isle of Thunder Scenario (map 517 73.10,51.30) via floor
    {
        fromPointID = 500249,
        fromMap = 516,
        fromX = 0.546,
        fromY = 0.291,
        toPointID = 500254,
        toMap = 517,
        toX = 0.731,
        toY = 0.513,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 516 62.40,40.30) -> Isle of Thunder Scenario (map 517 66.10,77.90) via floor
    {
        fromPointID = 500250,
        fromMap = 516,
        fromX = 0.624,
        fromY = 0.403,
        toPointID = 500253,
        toMap = 517,
        toX = 0.661,
        toY = 0.779,
        type = "floor",
    },

    -- Zone: Jangolode Mine (map 54)
    -- Westfall (map 54 41.10,94.10) -> Westfall (map 52 44.50,24.70) via floor
    {
        fromPointID = 200256,
        fromMap = 54,
        fromX = 0.411,
        fromY = 0.941,
        toPointID = 200252,
        toMap = 52,
        toX = 0.445,
        toY = 0.247,
        type = "floor",
    },

    -- Zone: Jasperlode Mine (map 40)
    -- Elwynn Forest (map 40 48.90,90.10) -> Elwynn Forest (map 37 61.70,53.70) via floor
    {
        fromPointID = 200189,
        fromMap = 40,
        fromX = 0.489,
        fromY = 0.901,
        toPointID = 200182,
        toMap = 37,
        toX = 0.617,
        toY = 0.537,
        type = "floor",
    },

    -- Zone: Kaja'mine (map 195)
    -- Kezan (map 195 41.00,75.50) -> Kezan (map 194 70.90,76.50) via floor
    {
        fromPointID = 1300008,
        fromMap = 195,
        fromX = 0.41,
        fromY = 0.755,
        toPointID = 1300006,
        toMap = 194,
        toX = 0.709,
        toY = 0.765,
        type = "floor",
    },

    -- Zone: Kaja'mine (map 196)
    -- Kezan (map 196 32.90,31.00) -> Kezan (map 194 74.30,83.30) via floor
    {
        fromPointID = 1300009,
        fromMap = 196,
        fromX = 0.329,
        fromY = 0.31,
        toPointID = 1300007,
        toMap = 194,
        toX = 0.743,
        toY = 0.833,
        type = "floor",
    },

    -- Zone: Kaja'mine (map 197)
    -- Kezan (map 197 64.00,19.60) -> Kezan (map 194 65.60,86.70) via floor
    {
        fromPointID = 1300010,
        fromMap = 197,
        fromX = 0.64,
        fromY = 0.196,
        toPointID = 1300005,
        toMap = 194,
        toX = 0.656,
        toY = 0.867,
        type = "floor",
    },

    -- Zone: Kaja'mite Cavern (map 175)
    -- The Lost Isles (map 175 48.10,90.00) -> The Lost Isles (map 174 31.20,78.60) via floor
    {
        fromPointID = 1300003,
        fromMap = 175,
        fromX = 0.481,
        fromY = 0.9,
        toPointID = 1300001,
        toMap = 174,
        toX = 0.312,
        toY = 0.786,
        type = "floor",
    },

    -- Zone: Karazhan (map 350)
    -- Karazhan (map 350 37.60,12.80) -> Karazhan (map 353 47.20,29.10) via floor
    {
        fromPointID = 200563,
        fromMap = 350,
        fromX = 0.376,
        fromY = 0.128,
        toPointID = 200573,
        toMap = 353,
        toX = 0.472,
        toY = 0.291,
        type = "floor",
    },
    -- Karazhan (map 350 38.30,78.60) -> Karazhan (map 351 29.10,80.80) via floor
    {
        fromPointID = 200564,
        fromMap = 350,
        fromX = 0.383,
        fromY = 0.786,
        toPointID = 200567,
        toMap = 351,
        toX = 0.291,
        toY = 0.808,
        type = "floor",
    },
    -- Karazhan (map 350 53.10,64.10) -> Karazhan (map 352 52.50,91.30) via floor
    {
        fromPointID = 200565,
        fromMap = 350,
        fromX = 0.531,
        fromY = 0.641,
        toPointID = 200570,
        toMap = 352,
        toX = 0.525,
        toY = 0.913,
        type = "floor",
    },

    -- Zone: Karazhan (map 351)
    -- Karazhan (map 351 29.10,80.80) -> Karazhan (map 350 38.30,78.60) via floor
    {
        fromPointID = 200567,
        fromMap = 351,
        fromX = 0.291,
        fromY = 0.808,
        toPointID = 200564,
        toMap = 350,
        toX = 0.383,
        toY = 0.786,
        type = "floor",
    },
    -- Karazhan (map 351 38.60,14.10) -> Karazhan (map 352 39.80,81.70) via floor
    {
        fromPointID = 200568,
        fromMap = 351,
        fromX = 0.386,
        fromY = 0.141,
        toPointID = 200569,
        toMap = 352,
        toX = 0.398,
        toY = 0.817,
        type = "floor",
    },

    -- Zone: Karazhan (map 352)
    -- Karazhan (map 352 39.80,81.70) -> Karazhan (map 351 38.60,14.10) via floor
    {
        fromPointID = 200569,
        fromMap = 352,
        fromX = 0.398,
        fromY = 0.817,
        toPointID = 200568,
        toMap = 351,
        toX = 0.386,
        toY = 0.141,
        type = "floor",
    },
    -- Karazhan (map 352 52.50,91.30) -> Karazhan (map 350 53.10,64.10) via floor
    {
        fromPointID = 200570,
        fromMap = 352,
        fromX = 0.525,
        fromY = 0.913,
        toPointID = 200565,
        toMap = 350,
        toX = 0.531,
        toY = 0.641,
        type = "floor",
    },
    -- Karazhan (map 352 67.00,42.40) -> Karazhan (map 353 67.90,42.90) via floor
    {
        fromPointID = 200571,
        fromMap = 352,
        fromX = 0.67,
        fromY = 0.424,
        toPointID = 200574,
        toMap = 353,
        toX = 0.679,
        toY = 0.429,
        type = "floor",
    },

    -- Zone: Karazhan (map 353)
    -- Karazhan (map 353 23.50,49.20) -> Karazhan (map 354 45.40,83.70) via floor
    {
        fromPointID = 200572,
        fromMap = 353,
        fromX = 0.235,
        fromY = 0.492,
        toPointID = 200575,
        toMap = 354,
        toX = 0.454,
        toY = 0.837,
        type = "floor",
    },
    -- Karazhan (map 353 47.20,29.10) -> Karazhan (map 350 37.60,12.80) via floor
    {
        fromPointID = 200573,
        fromMap = 353,
        fromX = 0.472,
        fromY = 0.291,
        toPointID = 200563,
        toMap = 350,
        toX = 0.376,
        toY = 0.128,
        type = "floor",
    },
    -- Karazhan (map 353 67.90,42.90) -> Karazhan (map 352 67.00,42.40) via floor
    {
        fromPointID = 200574,
        fromMap = 353,
        fromX = 0.679,
        fromY = 0.429,
        toPointID = 200571,
        toMap = 352,
        toX = 0.67,
        toY = 0.424,
        type = "floor",
    },

    -- Zone: Karazhan (map 354)
    -- Karazhan (map 354 45.40,83.70) -> Karazhan (map 353 23.50,49.20) via floor
    {
        fromPointID = 200575,
        fromMap = 354,
        fromX = 0.454,
        fromY = 0.837,
        toPointID = 200572,
        toMap = 353,
        toX = 0.235,
        toY = 0.492,
        type = "floor",
    },
    -- Karazhan (map 354 67.90,26.50) -> Karazhan (map 355 41.40,13.30) via floor
    {
        fromPointID = 200576,
        fromMap = 354,
        fromX = 0.679,
        fromY = 0.265,
        toPointID = 200577,
        toMap = 355,
        toX = 0.414,
        toY = 0.133,
        type = "floor",
    },

    -- Zone: Karazhan (map 355)
    -- Karazhan (map 355 41.40,13.30) -> Karazhan (map 354 67.90,26.50) via floor
    {
        fromPointID = 200577,
        fromMap = 355,
        fromX = 0.414,
        fromY = 0.133,
        toPointID = 200576,
        toMap = 354,
        toX = 0.679,
        toY = 0.265,
        type = "floor",
    },
    -- Karazhan (map 355 64.90,69.20) -> Karazhan (map 356 73.20,65.30) via floor
    {
        fromPointID = 200578,
        fromMap = 355,
        fromX = 0.649,
        fromY = 0.692,
        toPointID = 200579,
        toMap = 356,
        toX = 0.732,
        toY = 0.653,
        type = "floor",
    },

    -- Zone: Karazhan (map 356)
    -- Karazhan (map 356 73.20,65.30) -> Karazhan (map 355 64.90,69.20) via floor
    {
        fromPointID = 200579,
        fromMap = 356,
        fromX = 0.732,
        fromY = 0.653,
        toPointID = 200578,
        toMap = 355,
        toX = 0.649,
        toY = 0.692,
        type = "floor",
    },

    -- Zone: Karazhan (map 357)
    -- Karazhan (map 357 51.80,58.30) -> Karazhan (map 358 61.50,19.20) via floor
    {
        fromPointID = 200580,
        fromMap = 357,
        fromX = 0.518,
        fromY = 0.583,
        toPointID = 200582,
        toMap = 358,
        toX = 0.615,
        toY = 0.192,
        type = "floor",
    },

    -- Zone: Karazhan (map 358)
    -- Karazhan (map 358 31.00,66.30) -> Karazhan (map 359 30.90,59.90) via floor
    {
        fromPointID = 200581,
        fromMap = 358,
        fromX = 0.31,
        fromY = 0.663,
        toPointID = 200583,
        toMap = 359,
        toX = 0.309,
        toY = 0.599,
        type = "floor",
    },
    -- Karazhan (map 358 61.50,19.20) -> Karazhan (map 357 51.80,58.30) via floor
    {
        fromPointID = 200582,
        fromMap = 358,
        fromX = 0.615,
        fromY = 0.192,
        toPointID = 200580,
        toMap = 357,
        toX = 0.518,
        toY = 0.583,
        type = "floor",
    },

    -- Zone: Karazhan (map 359)
    -- Karazhan (map 359 30.90,59.90) -> Karazhan (map 358 31.00,66.30) via floor
    {
        fromPointID = 200583,
        fromMap = 359,
        fromX = 0.309,
        fromY = 0.599,
        toPointID = 200581,
        toMap = 358,
        toX = 0.31,
        toY = 0.663,
        type = "floor",
    },
    -- Karazhan (map 359 37.10,23.10) -> Karazhan (map 360 64.00,26.80) via floor
    {
        fromPointID = 200584,
        fromMap = 359,
        fromX = 0.371,
        fromY = 0.231,
        toPointID = 200586,
        toMap = 360,
        toX = 0.64,
        toY = 0.268,
        type = "floor",
    },
    -- Karazhan (map 359 58.80,56.00) -> Karazhan (map 361 47.00,56.00) via floor
    {
        fromPointID = 200585,
        fromMap = 359,
        fromX = 0.588,
        fromY = 0.56,
        toPointID = 200589,
        toMap = 361,
        toX = 0.47,
        toY = 0.56,
        type = "floor",
    },

    -- Zone: Karazhan (map 360)
    -- Karazhan (map 360 64.00,26.80) -> Karazhan (map 359 37.10,23.10) via floor
    {
        fromPointID = 200586,
        fromMap = 360,
        fromX = 0.64,
        fromY = 0.268,
        toPointID = 200584,
        toMap = 359,
        toX = 0.371,
        toY = 0.231,
        type = "floor",
    },

    -- Zone: Karazhan (map 361)
    -- Karazhan (map 361 25.90,61.30) -> Karazhan (map 362 53.80,78.50) via floor
    {
        fromPointID = 200587,
        fromMap = 361,
        fromX = 0.259,
        fromY = 0.613,
        toPointID = 200590,
        toMap = 362,
        toX = 0.538,
        toY = 0.785,
        type = "floor",
    },
    -- Karazhan (map 361 39.60,18.80) -> Karazhan (map 363 20.60,81.30) via floor
    {
        fromPointID = 200588,
        fromMap = 361,
        fromX = 0.396,
        fromY = 0.188,
        toPointID = 200591,
        toMap = 363,
        toX = 0.206,
        toY = 0.813,
        type = "floor",
    },
    -- Karazhan (map 361 47.00,56.00) -> Karazhan (map 359 58.80,56.00) via floor
    {
        fromPointID = 200589,
        fromMap = 361,
        fromX = 0.47,
        fromY = 0.56,
        toPointID = 200585,
        toMap = 359,
        toX = 0.588,
        toY = 0.56,
        type = "floor",
    },

    -- Zone: Karazhan (map 362)
    -- Karazhan (map 362 53.80,78.50) -> Karazhan (map 361 25.90,61.30) via floor
    {
        fromPointID = 200590,
        fromMap = 362,
        fromX = 0.538,
        fromY = 0.785,
        toPointID = 200587,
        toMap = 361,
        toX = 0.259,
        toY = 0.613,
        type = "floor",
    },

    -- Zone: Karazhan (map 363)
    -- Karazhan (map 363 20.60,81.30) -> Karazhan (map 361 39.60,18.80) via floor
    {
        fromPointID = 200591,
        fromMap = 363,
        fromX = 0.206,
        fromY = 0.813,
        toPointID = 200588,
        toMap = 361,
        toX = 0.396,
        toY = 0.188,
        type = "floor",
    },
    -- Karazhan (map 363 83.20,57.10) -> Karazhan (map 364 82.30,69.80) via floor
    {
        fromPointID = 200592,
        fromMap = 363,
        fromX = 0.832,
        fromY = 0.571,
        toPointID = 200593,
        toMap = 364,
        toX = 0.823,
        toY = 0.698,
        type = "floor",
    },

    -- Zone: Karazhan (map 364)
    -- Karazhan (map 364 82.30,69.80) -> Karazhan (map 363 83.20,57.10) via floor
    {
        fromPointID = 200593,
        fromMap = 364,
        fromX = 0.823,
        fromY = 0.698,
        toPointID = 200592,
        toMap = 363,
        toX = 0.832,
        toY = 0.571,
        type = "floor",
    },
    -- Karazhan (map 364 83.20,75.50) -> Karazhan (map 365 71.90,70.50) via floor
    {
        fromPointID = 200594,
        fromMap = 364,
        fromX = 0.832,
        fromY = 0.755,
        toPointID = 200596,
        toMap = 365,
        toX = 0.719,
        toY = 0.705,
        type = "floor",
    },

    -- Zone: Karazhan (map 365)
    -- Karazhan (map 365 66.20,79.30) -> Karazhan (map 366 50.90,91.10) via floor
    {
        fromPointID = 200595,
        fromMap = 365,
        fromX = 0.662,
        fromY = 0.793,
        toPointID = 200597,
        toMap = 366,
        toX = 0.509,
        toY = 0.911,
        type = "floor",
    },
    -- Karazhan (map 365 71.90,70.50) -> Karazhan (map 364 83.20,75.50) via floor
    {
        fromPointID = 200596,
        fromMap = 365,
        fromX = 0.719,
        fromY = 0.705,
        toPointID = 200594,
        toMap = 364,
        toX = 0.832,
        toY = 0.755,
        type = "floor",
    },

    -- Zone: Karazhan (map 366)
    -- Karazhan (map 366 50.90,91.10) -> Karazhan (map 365 66.20,79.30) via floor
    {
        fromPointID = 200597,
        fromMap = 366,
        fromX = 0.509,
        fromY = 0.911,
        toPointID = 200595,
        toMap = 365,
        toX = 0.662,
        toY = 0.793,
        type = "floor",
    },

    -- Zone: Kel'balor (map 687)
    -- Suramar (map 687 54.39,86.69) -> Suramar (map 680 59.36,43.03) via floor
    {
        fromPointID = 700212,
        fromMap = 687,
        fromX = 0.5439,
        fromY = 0.8669,
        toPointID = 700193,
        toMap = 680,
        toX = 0.5936,
        toY = 0.4303,
        type = "floor",
    },

    -- Zone: Kezan (map 194)
    -- Kezan (map 194 65.60,86.70) -> Kezan (map 197 64.00,19.60) via floor
    {
        fromPointID = 1300005,
        fromMap = 194,
        fromX = 0.656,
        fromY = 0.867,
        toPointID = 1300010,
        toMap = 197,
        toX = 0.64,
        toY = 0.196,
        type = "floor",
    },
    -- Kezan (map 194 70.90,76.50) -> Kezan (map 195 41.00,75.50) via floor
    {
        fromPointID = 1300006,
        fromMap = 194,
        fromX = 0.709,
        fromY = 0.765,
        toPointID = 1300008,
        toMap = 195,
        toX = 0.41,
        toY = 0.755,
        type = "floor",
    },
    -- Kezan (map 194 74.30,83.30) -> Kezan (map 196 32.90,31.00) via floor
    {
        fromPointID = 1300007,
        fromMap = 194,
        fromX = 0.743,
        fromY = 0.833,
        toPointID = 1300009,
        toMap = 196,
        toX = 0.329,
        toY = 0.31,
        type = "floor",
    },

    -- Zone: Kin's Rest (map 2645)
    -- Kin's Rest (map 2645 78.59,41.39) -> The Coiled Isle (map 2512 44.68,34.45) via floor
    {
        fromPointID = 200902,
        fromMap = 2645,
        fromX = 0.7859,
        fromY = 0.4139,
        toPointID = 200783,
        toMap = 2512,
        toX = 0.4468,
        toY = 0.3445,
        type = "floor",
    },

    -- Zone: Knucklethump Hole (map 382)
    -- Kun-Lai Summit (map 382 74.90,91.50) -> Kun-Lai Summit (map 379 50.30,61.70) via floor
    {
        fromPointID = 500078,
        fromMap = 382,
        fromX = 0.749,
        fromY = 0.915,
        toPointID = 500058,
        toMap = 379,
        toX = 0.503,
        toY = 0.617,
        type = "floor",
    },

    -- Zone: Korthia (map 1961)
    -- Korthia (map 1961 30.15,55.13) -> Gromit Hollow (map 2007 65.79,35.02) via floor
    {
        fromPointID = 1000312,
        fromMap = 1961,
        fromX = 0.3015,
        fromY = 0.5513,
        toPointID = 1000358,
        toMap = 2007,
        toX = 0.6579,
        toY = 0.3502,
        type = "floor",
    },
    -- Korthia (map 1961 40.04,25.94) -> The Maw (map 1543 51.53,90.46) via floor
    {
        fromPointID = 1000313,
        fromMap = 1961,
        fromX = 0.4004,
        fromY = 0.2594,
        toPointID = 1000118,
        toMap = 1543,
        toX = 0.5153,
        toY = 0.9046,
        type = "floor",
    },
    -- Korthia (map 1961 58.48,13.67) -> The Maw (map 1543 65.61,80.80) via floor
    {
        fromPointID = 1000316,
        fromMap = 1961,
        fromX = 0.5848,
        fromY = 0.1367,
        toPointID = 1000121,
        toMap = 1543,
        toX = 0.6561,
        toY = 0.808,
        type = "floor",
    },
    -- Korthia (map 1961 60.15,31.97) -> Caverns of Contemplation (map 2006 42.59,88.16) via floor
    {
        fromPointID = 1000317,
        fromMap = 1961,
        fromX = 0.6015,
        fromY = 0.3197,
        toPointID = 1000357,
        toMap = 2006,
        toX = 0.4259,
        toY = 0.8816,
        type = "floor",
    },

    -- Zone: Krasarang Wilds (map 418)
    -- Krasarang Wilds (map 418 80.30,17.71) -> Krasarang Wilds (map 419 33.37,22.27) via floor
    {
        fromPointID = 500128,
        fromMap = 418,
        fromX = 0.803,
        fromY = 0.1771,
        toPointID = 500129,
        toMap = 419,
        toX = 0.3337,
        toY = 0.2227,
        type = "floor",
    },

    -- Zone: Krokuun (map 830)
    -- Krokuun (map 830 50.22,17.12) -> Krokuun (map 833 66.91,86.27) via floor
    {
        fromPointID = 700284,
        fromMap = 830,
        fromX = 0.5022,
        fromY = 0.1712,
        toPointID = 700292,
        toMap = 833,
        toX = 0.6691,
        toY = 0.8627,
        type = "floor",
    },

    -- Zone: Kun-Lai Summit (map 379)
    -- Kun-Lai Summit (map 379 33.10,26.60) -> Kun-Lai Summit (map 386 52.20,11.60) via floor
    {
        fromPointID = 500045,
        fromMap = 379,
        fromX = 0.331,
        fromY = 0.266,
        toPointID = 500083,
        toMap = 386,
        toX = 0.522,
        toY = 0.116,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 50.30,61.70) -> Kun-Lai Summit (map 382 74.90,91.50) via floor
    {
        fromPointID = 500058,
        fromMap = 379,
        fromX = 0.503,
        fromY = 0.617,
        toPointID = 500078,
        toMap = 382,
        toX = 0.749,
        toY = 0.915,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 50.64,49.84) -> Kun-Lai Summit (map 385 59.39,86.63) via floor
    {
        fromPointID = 500059,
        fromMap = 379,
        fromX = 0.5064,
        fromY = 0.4984,
        toPointID = 500080,
        toMap = 385,
        toX = 0.5939,
        toY = 0.8663,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 52.90,71.30) -> Kun-Lai Summit (map 383 56.50,15.90) via floor
    {
        fromPointID = 500060,
        fromMap = 379,
        fromX = 0.529,
        fromY = 0.713,
        toPointID = 500079,
        toMap = 383,
        toX = 0.565,
        toY = 0.159,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 53.00,46.50) -> Kun-Lai Summit (map 385 88.30,54.80) via floor
    {
        fromPointID = 500061,
        fromMap = 379,
        fromX = 0.53,
        fromY = 0.465,
        toPointID = 500081,
        toMap = 385,
        toX = 0.883,
        toY = 0.548,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 59.10,52.50) -> Kun-Lai Summit (map 380 66.90,82.30) via floor
    {
        fromPointID = 500065,
        fromMap = 379,
        fromX = 0.591,
        fromY = 0.525,
        toPointID = 500076,
        toMap = 380,
        toX = 0.669,
        toY = 0.823,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 72.96,73.39) -> Kun-Lai Summit (map 381 16.69,34.49) via floor
    {
        fromPointID = 500072,
        fromMap = 379,
        fromX = 0.7296,
        fromY = 0.7339,
        toPointID = 500077,
        toMap = 381,
        toX = 0.1669,
        toY = 0.3449,
        type = "floor",
    },
    -- Kun-Lai Summit (map 379 73.20,94.60) -> The Veiled Stair (map 434 25.10,12.50) via floor
    {
        fromPointID = 500073,
        fromMap = 379,
        fromX = 0.732,
        fromY = 0.946,
        toPointID = 500156,
        toMap = 434,
        toX = 0.251,
        toY = 0.125,
        type = "floor",
    },

    -- Zone: Lair of Predaxas (map 2526)
    -- Lair of Predaxas (map 2526 60.00,17.51) -> Voidstorm (map 2405 48.14,78.63) via floor
    {
        fromPointID = 200814,
        fromMap = 2526,
        fromX = 0.6,
        fromY = 0.1751,
        toPointID = 200687,
        toMap = 2405,
        toX = 0.4814,
        toY = 0.7863,
        type = "floor",
    },
    -- Lair of Predaxas (map 2526 68.68,67.48) -> Lair of Predaxas (map 2527 73.53,43.29) via floor
    {
        fromPointID = 200815,
        fromMap = 2526,
        fromX = 0.6868,
        fromY = 0.6748,
        toPointID = 200816,
        toMap = 2527,
        toX = 0.7353,
        toY = 0.4329,
        type = "floor",
    },

    -- Zone: Lair of Predaxas (map 2527)
    -- Lair of Predaxas (map 2527 73.53,43.29) -> Lair of Predaxas (map 2526 68.68,67.48) via floor
    {
        fromPointID = 200816,
        fromMap = 2527,
        fromX = 0.7353,
        fromY = 0.4329,
        toPointID = 200815,
        toMap = 2526,
        toX = 0.6868,
        toY = 0.6748,
        type = "floor",
    },

    -- Zone: Light's Hope Chapel (map 24)
    -- Eastern Plaguelands (map 24 40.60,91.63) -> Eastern Plaguelands (map 23 75.37,52.73) via floor
    {
        fromPointID = 200101,
        fromMap = 24,
        fromX = 0.406,
        fromY = 0.9163,
        toPointID = 200097,
        toMap = 23,
        toX = 0.7537,
        toY = 0.5273,
        type = "floor",
    },

    -- Zone: Lightning Vein Mine (map 505)
    -- Isle of Thunder (map 505 31.70,81.70) -> Isle of Thunder (map 504 49.20,32.20) via floor
    {
        fromPointID = 500228,
        fromMap = 505,
        fromX = 0.317,
        fromY = 0.817,
        toPointID = 500219,
        toMap = 504,
        toX = 0.492,
        toY = 0.322,
        type = "floor",
    },
    -- Isle of Thunder (map 505 38.80,27.10) -> Isle of Thunder (map 504 49.30,25.50) via floor
    {
        fromPointID = 500229,
        fromMap = 505,
        fromX = 0.388,
        fromY = 0.271,
        toPointID = 500220,
        toMap = 504,
        toX = 0.493,
        toY = 0.255,
        type = "floor",
    },
    -- Isle of Thunder (map 505 73.10,51.30) -> Isle of Thunder (map 504 54.60,29.10) via floor
    {
        fromPointID = 500230,
        fromMap = 505,
        fromX = 0.731,
        fromY = 0.513,
        toPointID = 500222,
        toMap = 504,
        toX = 0.546,
        toY = 0.291,
        type = "floor",
    },

    -- Zone: Lightning Vein Mine (map 517)
    -- Isle of Thunder Scenario (map 517 31.50,82.00) -> Isle of Thunder Scenario (map 516 49.20,33.00) via floor
    {
        fromPointID = 500251,
        fromMap = 517,
        fromX = 0.315,
        fromY = 0.82,
        toPointID = 500247,
        toMap = 516,
        toX = 0.492,
        toY = 0.33,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 517 37.45,26.92) -> Isle of Thunder Scenario (map 516 49.27,25.52) via floor
    {
        fromPointID = 500252,
        fromMap = 517,
        fromX = 0.3745,
        fromY = 0.2692,
        toPointID = 500248,
        toMap = 516,
        toX = 0.4927,
        toY = 0.2552,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 517 66.10,77.90) -> Isle of Thunder Scenario (map 516 62.40,40.30) via floor
    {
        fromPointID = 500253,
        fromMap = 517,
        fromX = 0.661,
        fromY = 0.779,
        toPointID = 500250,
        toMap = 516,
        toX = 0.624,
        toY = 0.403,
        type = "floor",
    },
    -- Isle of Thunder Scenario (map 517 73.10,51.30) -> Isle of Thunder Scenario (map 516 54.60,29.10) via floor
    {
        fromPointID = 500254,
        fromMap = 517,
        fromX = 0.731,
        fromY = 0.513,
        toPointID = 500249,
        toMap = 516,
        toX = 0.546,
        toY = 0.291,
        type = "floor",
    },

    -- Zone: Loaknit Den (map 2580)
    -- Loaknit Den (map 2580 74.50,68.45) -> Zul Aman M (map 2437 31.60,26.11) via floor
    {
        fromPointID = 200851,
        fromMap = 2580,
        fromX = 0.745,
        fromY = 0.6845,
        toPointID = 200725,
        toMap = 2437,
        toX = 0.316,
        toY = 0.2611,
        type = "floor",
    },

    -- Zone: Locrian Esper (map 2028)
    -- Locrian Esper (map 2028 13.87,34.86) -> Zereth Mortis (map 1970 55.72,53.46) via floor
    {
        fromPointID = 1000361,
        fromMap = 2028,
        fromX = 0.1387,
        fromY = 0.3486,
        toPointID = 1000326,
        toMap = 1970,
        toX = 0.5572,
        toY = 0.5346,
        type = "floor",
    },

    -- Zone: Locus of Eternity (map 2192)
    -- Dawn of the Infinite (map 2192 33.17,50.04) -> Dawn of the Infinite (map 2191 76.92,62.30) via floor
    {
        fromPointID = 1100184,
        fromMap = 2192,
        fromX = 0.3317,
        fromY = 0.5004,
        toPointID = 1100183,
        toMap = 2191,
        toX = 0.7692,
        toY = 0.623,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2192 75.13,64.74) -> Dawn of the Infinite (map 2193 21.81,36.30) via floor
    {
        fromPointID = 1100185,
        fromMap = 2192,
        fromX = 0.7513,
        fromY = 0.6474,
        toPointID = 1100186,
        toMap = 2193,
        toX = 0.2181,
        toY = 0.363,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2515)
    -- Magisters Terrace M (map 2515 51.46,55.67) -> Magisters Terrace M (map 2511 77.52,66.97) via floor
    {
        fromPointID = 200801,
        fromMap = 2515,
        fromX = 0.5146,
        fromY = 0.5567,
        toPointID = 200772,
        toMap = 2511,
        toX = 0.7752,
        toY = 0.6697,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2516)
    -- Magisters Terrace M (map 2516 22.60,78.98) -> Magisters Terrace M (map 2511 56.24,38.38) via floor
    {
        fromPointID = 200802,
        fromMap = 2516,
        fromX = 0.226,
        fromY = 0.7898,
        toPointID = 200771,
        toMap = 2511,
        toX = 0.5624,
        toY = 0.3838,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2517)
    -- Magisters Terrace M (map 2517 32.57,44.83) -> Magisters Terrace M (map 2511 44.81,68.43) via floor
    {
        fromPointID = 200803,
        fromMap = 2517,
        fromX = 0.3257,
        fromY = 0.4483,
        toPointID = 200770,
        toMap = 2511,
        toX = 0.4481,
        toY = 0.6843,
        type = "floor",
    },
    -- Magisters Terrace M (map 2517 70.47,52.98) -> Magisters Terrace M (map 2518 45.96,19.19) via floor
    {
        fromPointID = 200804,
        fromMap = 2517,
        fromX = 0.7047,
        fromY = 0.5298,
        toPointID = 200806,
        toMap = 2518,
        toX = 0.4596,
        toY = 0.1919,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2518)
    -- Magisters Terrace M (map 2518 30.66,33.90) -> Magisters Terrace M (map 2519 44.29,38.63) via floor
    {
        fromPointID = 200805,
        fromMap = 2518,
        fromX = 0.3066,
        fromY = 0.339,
        toPointID = 200807,
        toMap = 2519,
        toX = 0.4429,
        toY = 0.3863,
        type = "floor",
    },
    -- Magisters Terrace M (map 2518 45.96,19.19) -> Magisters Terrace M (map 2517 70.47,52.98) via floor
    {
        fromPointID = 200806,
        fromMap = 2518,
        fromX = 0.4596,
        fromY = 0.1919,
        toPointID = 200804,
        toMap = 2517,
        toX = 0.7047,
        toY = 0.5298,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2519)
    -- Magisters Terrace M (map 2519 44.29,38.63) -> Magisters Terrace M (map 2518 30.66,33.90) via floor
    {
        fromPointID = 200807,
        fromMap = 2519,
        fromX = 0.4429,
        fromY = 0.3863,
        toPointID = 200805,
        toMap = 2518,
        toX = 0.3066,
        toY = 0.339,
        type = "floor",
    },
    -- Magisters Terrace M (map 2519 51.94,49.21) -> Magisters Terrace M (map 2520 62.22,22.78) via floor
    {
        fromPointID = 200808,
        fromMap = 2519,
        fromX = 0.5194,
        fromY = 0.4921,
        toPointID = 200809,
        toMap = 2520,
        toX = 0.6222,
        toY = 0.2278,
        type = "floor",
    },

    -- Zone: Magister's Terrace (map 2520)
    -- Magisters Terrace M (map 2520 62.22,22.78) -> Magisters Terrace M (map 2519 51.94,49.21) via floor
    {
        fromPointID = 200809,
        fromMap = 2520,
        fromX = 0.6222,
        fromY = 0.2278,
        toPointID = 200808,
        toMap = 2519,
        toX = 0.5194,
        toY = 0.4921,
        type = "floor",
    },

    -- Zone: Magisters' Terrace (map 2511)
    -- Magisters Terrace M (map 2511 44.81,68.43) -> Magisters Terrace M (map 2517 32.57,44.83) via floor
    {
        fromPointID = 200770,
        fromMap = 2511,
        fromX = 0.4481,
        fromY = 0.6843,
        toPointID = 200803,
        toMap = 2517,
        toX = 0.3257,
        toY = 0.4483,
        type = "floor",
    },
    -- Magisters Terrace M (map 2511 56.24,38.38) -> Magisters Terrace M (map 2516 22.60,78.98) via floor
    {
        fromPointID = 200771,
        fromMap = 2511,
        fromX = 0.5624,
        fromY = 0.3838,
        toPointID = 200802,
        toMap = 2516,
        toX = 0.226,
        toY = 0.7898,
        type = "floor",
    },
    -- Magisters Terrace M (map 2511 77.52,66.97) -> Magisters Terrace M (map 2515 51.46,55.67) via floor
    {
        fromPointID = 200772,
        fromMap = 2511,
        fromX = 0.7752,
        fromY = 0.6697,
        toPointID = 200801,
        toMap = 2515,
        toX = 0.5146,
        toY = 0.5567,
        type = "floor",
    },

    -- Zone: Magisters' Terrace (map 348)
    -- Magisters' Terrace (map 348 83.15,55.44) -> Magisters' Terrace (map 349 82.88,44.83) via floor
    {
        fromPointID = 200560,
        fromMap = 348,
        fromX = 0.8315,
        fromY = 0.5544,
        toPointID = 200562,
        toMap = 349,
        toX = 0.8288,
        toY = 0.4483,
        type = "floor",
    },

    -- Zone: Magisters' Terrace (map 349)
    -- Magisters' Terrace (map 349 82.88,44.83) -> Magisters' Terrace (map 348 83.15,55.44) via floor
    {
        fromPointID = 200562,
        fromMap = 349,
        fromX = 0.8288,
        fromY = 0.4483,
        toPointID = 200560,
        toMap = 348,
        toX = 0.8315,
        toY = 0.5544,
        type = "floor",
    },

    -- Zone: Maldraxxus (map 1536)
    -- Maldraxxus (map 1536 24.45,31.55) -> Etheric Vault (map 1649 62.64,69.18) via floor
    {
        fromPointID = 1000062,
        fromMap = 1536,
        fromX = 0.2445,
        fromY = 0.3155,
        toPointID = 1000150,
        toMap = 1649,
        toX = 0.6264,
        toY = 0.6918,
        type = "floor",
    },
    -- Maldraxxus (map 1536 50.39,68.04) -> Seat of the Primus (map 1698 49.68,13.66) via floor
    {
        fromPointID = 1000073,
        fromMap = 1536,
        fromX = 0.5039,
        fromY = 0.6804,
        toPointID = 1000225,
        toMap = 1698,
        toX = 0.4968,
        toY = 0.1366,
        type = "floor",
    },
    -- Maldraxxus (map 1536 54.08,12.25) -> Sightless Hold (map 1650 42.06,82.99) via floor
    {
        fromPointID = 1000080,
        fromMap = 1536,
        fromX = 0.5408,
        fromY = 0.1225,
        toPointID = 1000151,
        toMap = 1650,
        toX = 0.4206,
        toY = 0.8299,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2460)
    -- Manaforge Omega (map 2460 15.23,51.18) -> Manaforge Omega (map 2463 62.34,53.80) via floor
    {
        fromPointID = 1200205,
        fromMap = 2460,
        fromX = 0.1523,
        fromY = 0.5118,
        toPointID = 1200212,
        toMap = 2463,
        toX = 0.6234,
        toY = 0.538,
        type = "floor",
    },
    -- Manaforge Omega (map 2460 23.48,24.64) -> Manaforge Omega (map 2461 75.37,79.63) via floor
    {
        fromPointID = 1200206,
        fromMap = 2460,
        fromX = 0.2348,
        fromY = 0.2464,
        toPointID = 1200209,
        toMap = 2461,
        toX = 0.7537,
        toY = 0.7963,
        type = "floor",
    },
    -- Manaforge Omega (map 2460 23.48,77.91) -> Manaforge Omega (map 2462 34.24,20.62) via floor
    {
        fromPointID = 1200207,
        fromMap = 2460,
        fromX = 0.2348,
        fromY = 0.7791,
        toPointID = 1200210,
        toMap = 2462,
        toX = 0.3424,
        toY = 0.2062,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2461)
    -- Manaforge Omega (map 2461 75.37,79.63) -> Manaforge Omega (map 2460 23.48,24.64) via floor
    {
        fromPointID = 1200209,
        fromMap = 2461,
        fromX = 0.7537,
        fromY = 0.7963,
        toPointID = 1200206,
        toMap = 2460,
        toX = 0.2348,
        toY = 0.2464,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2462)
    -- Manaforge Omega (map 2462 34.24,20.62) -> Manaforge Omega (map 2460 23.48,77.91) via floor
    {
        fromPointID = 1200210,
        fromMap = 2462,
        fromX = 0.3424,
        fromY = 0.2062,
        toPointID = 1200207,
        toMap = 2460,
        toX = 0.2348,
        toY = 0.7791,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2463)
    -- Manaforge Omega (map 2463 30.89,68.69) -> Manaforge Omega (map 2464 44.88,65.35) via floor
    {
        fromPointID = 1200211,
        fromMap = 2463,
        fromX = 0.3089,
        fromY = 0.6869,
        toPointID = 1200214,
        toMap = 2464,
        toX = 0.4488,
        toY = 0.6535,
        type = "floor",
    },
    -- Manaforge Omega (map 2463 62.34,53.80) -> Manaforge Omega (map 2460 15.23,51.18) via floor
    {
        fromPointID = 1200212,
        fromMap = 2463,
        fromX = 0.6234,
        fromY = 0.538,
        toPointID = 1200205,
        toMap = 2460,
        toX = 0.1523,
        toY = 0.5118,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2464)
    -- Manaforge Omega (map 2464 24.57,48.85) -> Manaforge Omega (map 2465 66.28,57.75) via floor
    {
        fromPointID = 1200213,
        fromMap = 2464,
        fromX = 0.2457,
        fromY = 0.4885,
        toPointID = 1200216,
        toMap = 2465,
        toX = 0.6628,
        toY = 0.5775,
        type = "floor",
    },
    -- Manaforge Omega (map 2464 44.88,65.35) -> Manaforge Omega (map 2463 30.89,68.69) via floor
    {
        fromPointID = 1200214,
        fromMap = 2464,
        fromX = 0.4488,
        fromY = 0.6535,
        toPointID = 1200211,
        toMap = 2463,
        toX = 0.3089,
        toY = 0.6869,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2465)
    -- Manaforge Omega (map 2465 57.32,21.52) -> Manaforge Omega (map 2466 28.98,9.04) via floor
    {
        fromPointID = 1200215,
        fromMap = 2465,
        fromX = 0.5732,
        fromY = 0.2152,
        toPointID = 1200217,
        toMap = 2466,
        toX = 0.2898,
        toY = 0.0904,
        type = "floor",
    },
    -- Manaforge Omega (map 2465 66.28,57.75) -> Manaforge Omega (map 2464 24.57,48.85) via floor
    {
        fromPointID = 1200216,
        fromMap = 2465,
        fromX = 0.6628,
        fromY = 0.5775,
        toPointID = 1200213,
        toMap = 2464,
        toX = 0.2457,
        toY = 0.4885,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2466)
    -- Manaforge Omega (map 2466 28.98,9.04) -> Manaforge Omega (map 2465 57.32,21.52) via floor
    {
        fromPointID = 1200217,
        fromMap = 2466,
        fromX = 0.2898,
        fromY = 0.0904,
        toPointID = 1200215,
        toMap = 2465,
        toX = 0.5732,
        toY = 0.2152,
        type = "floor",
    },
    -- Manaforge Omega (map 2466 83.14,56.03) -> Manaforge Omega (map 2467 4.95,48.42) via floor
    {
        fromPointID = 1200218,
        fromMap = 2466,
        fromX = 0.8314,
        fromY = 0.5603,
        toPointID = 1200219,
        toMap = 2467,
        toX = 0.0495,
        toY = 0.4842,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2467)
    -- Manaforge Omega (map 2467 4.95,48.42) -> Manaforge Omega (map 2466 83.14,56.03) via floor
    {
        fromPointID = 1200219,
        fromMap = 2467,
        fromX = 0.0495,
        fromY = 0.4842,
        toPointID = 1200218,
        toMap = 2466,
        toX = 0.8314,
        toY = 0.5603,
        type = "floor",
    },
    -- Manaforge Omega (map 2467 75.61,49.14) -> Manaforge Omega (map 2471 65.57,69.05) via floor
    {
        fromPointID = 1200221,
        fromMap = 2467,
        fromX = 0.7561,
        fromY = 0.4914,
        toPointID = 1200228,
        toMap = 2471,
        toX = 0.6557,
        toY = 0.6905,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2468)
    -- Manaforge Omega (map 2468 61.26,55.85) -> Manaforge Omega (map 2471 36.15,52.01) via floor
    {
        fromPointID = 1200222,
        fromMap = 2468,
        fromX = 0.6126,
        fromY = 0.5585,
        toPointID = 1200226,
        toMap = 2471,
        toX = 0.3615,
        toY = 0.5201,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2469)
    -- Manaforge Omega (map 2469 37.11,51.36) -> Manaforge Omega (map 2471 85.77,45.37) via floor
    {
        fromPointID = 1200223,
        fromMap = 2469,
        fromX = 0.3711,
        fromY = 0.5136,
        toPointID = 1200229,
        toMap = 2471,
        toX = 0.8577,
        toY = 0.4537,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2470)
    -- Manaforge Omega (map 2470 56.00,68.76) -> Manaforge Omega (map 2467 72.14,48.78) via floor
    {
        fromPointID = 1200225,
        fromMap = 2470,
        fromX = 0.56,
        fromY = 0.6876,
        toPointID = 1200220,
        toMap = 2467,
        toX = 0.7214,
        toY = 0.4878,
        type = "floor",
    },

    -- Zone: Manaforge Omega (map 2471)
    -- Manaforge Omega (map 2471 36.15,52.01) -> Manaforge Omega (map 2468 61.26,55.85) via floor
    {
        fromPointID = 1200226,
        fromMap = 2471,
        fromX = 0.3615,
        fromY = 0.5201,
        toPointID = 1200222,
        toMap = 2468,
        toX = 0.6126,
        toY = 0.5585,
        type = "floor",
    },
    -- Manaforge Omega (map 2471 60.78,49.32) -> Manaforge Omega (map 2470 55.88,68.76) via floor
    {
        fromPointID = 1200227,
        fromMap = 2471,
        fromX = 0.6078,
        fromY = 0.4932,
        toPointID = 1200224,
        toMap = 2470,
        toX = 0.5588,
        toY = 0.6876,
        type = "floor",
    },
    -- Manaforge Omega (map 2471 85.77,45.37) -> Manaforge Omega (map 2469 37.11,51.36) via floor
    {
        fromPointID = 1200229,
        fromMap = 2471,
        fromX = 0.8577,
        fromY = 0.4537,
        toPointID = 1200223,
        toMap = 2469,
        toX = 0.3711,
        toY = 0.5136,
        type = "floor",
    },

    -- Zone: Maraudon (map 280)
    -- Maraudon (map 280 15.53,56.75) -> Maraudon (map 281 28.99,4.84) via floor
    {
        fromPointID = 100380,
        fromMap = 280,
        fromX = 0.1553,
        fromY = 0.5675,
        toPointID = 100384,
        toMap = 281,
        toX = 0.2899,
        toY = 0.0484,
        type = "floor",
    },

    -- Zone: Maraudon (map 281)
    -- Maraudon (map 281 28.99,4.84) -> Maraudon (map 280 15.53,56.75) via floor
    {
        fromPointID = 100384,
        fromMap = 281,
        fromX = 0.2899,
        fromY = 0.0484,
        toPointID = 100380,
        toMap = 280,
        toX = 0.1553,
        toY = 0.5675,
        type = "floor",
    },

    -- Zone: Maraudon (map 67)
    -- Desolace (map 67 22.85,43.46) -> Desolace (map 66 29.09,62.55) via floor
    {
        fromPointID = 100142,
        fromMap = 67,
        fromX = 0.2285,
        fromY = 0.4346,
        toPointID = 100132,
        toMap = 66,
        toX = 0.2909,
        toY = 0.6255,
        type = "floor",
    },
    -- Desolace (map 67 27.07,35.72) -> Desolace (map 68 46.12,77.70) via floor
    {
        fromPointID = 100143,
        fromMap = 67,
        fromX = 0.2707,
        fromY = 0.3572,
        toPointID = 100147,
        toMap = 68,
        toX = 0.4612,
        toY = 0.777,
        type = "floor",
    },
    -- Desolace (map 67 28.36,42.60) -> Desolace (map 68 48.27,88.67) via floor
    {
        fromPointID = 100144,
        fromMap = 67,
        fromX = 0.2836,
        fromY = 0.426,
        toPointID = 100148,
        toMap = 68,
        toX = 0.4827,
        toY = 0.8867,
        type = "floor",
    },

    -- Zone: Maraudon (map 68)
    -- Desolace (map 68 46.12,77.70) -> Desolace (map 67 27.07,35.72) via floor
    {
        fromPointID = 100147,
        fromMap = 68,
        fromX = 0.4612,
        fromY = 0.777,
        toPointID = 100143,
        toMap = 67,
        toX = 0.2707,
        toY = 0.3572,
        type = "floor",
    },
    -- Desolace (map 68 48.27,88.67) -> Desolace (map 67 28.36,42.60) via floor
    {
        fromPointID = 100148,
        fromMap = 68,
        fromX = 0.4827,
        fromY = 0.8867,
        toPointID = 100144,
        toMap = 67,
        toX = 0.2836,
        toY = 0.426,
        type = "floor",
    },

    -- Zone: March on Quel'Danas (map 2533)
    -- March on Quel Danas (map 2533 50.62,12.02) -> March on Quel Danas (map 2534 50.62,94.58) via floor
    {
        fromPointID = 200827,
        fromMap = 2533,
        fromX = 0.5062,
        fromY = 0.1202,
        toPointID = 200828,
        toMap = 2534,
        toX = 0.5062,
        toY = 0.9458,
        type = "floor",
    },

    -- Zone: March on Quel'Danas (map 2534)
    -- March on Quel Danas (map 2534 50.62,94.58) -> March on Quel Danas (map 2533 50.62,12.02) via floor
    {
        fromPointID = 200828,
        fromMap = 2534,
        fromX = 0.5062,
        fromY = 0.9458,
        toPointID = 200827,
        toMap = 2533,
        toX = 0.5062,
        toY = 0.1202,
        type = "floor",
    },

    -- Zone: Mardum, the Shattered Abyss (map 720)
    -- Mardum, the Shattered Abyss (map 720 68.66,67.24) -> Mardum, the Shattered Abyss (map 721 65.39,53.64) via floor
    {
        fromPointID = 700243,
        fromMap = 720,
        fromX = 0.6866,
        fromY = 0.6724,
        toPointID = 700244,
        toMap = 721,
        toX = 0.6539,
        toY = 0.5364,
        type = "floor",
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

    -- Zone: Mardum, the Shattered Abyss (map 721)
    -- Mardum, the Shattered Abyss (map 721 65.39,53.64) -> Mardum, the Shattered Abyss (map 720 68.66,67.24) via floor
    {
        fromPointID = 700244,
        fromMap = 721,
        fromX = 0.6539,
        fromY = 0.5364,
        toPointID = 700243,
        toMap = 720,
        toX = 0.6866,
        toY = 0.6724,
        type = "floor",
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
    -- Mechagon City (map 1573 62.37,78.95) -> Mechagon City (map 1574 20.46,17.96) via floor
    {
        fromPointID = 800114,
        fromMap = 1573,
        fromX = 0.6237,
        fromY = 0.7895,
        toPointID = 800115,
        toMap = 1574,
        toX = 0.2046,
        toY = 0.1796,
        type = "floor",
    },

    -- Zone: Mechagon City (map 1574)
    -- Mechagon City (map 1574 20.46,17.96) -> Mechagon City (map 1573 62.37,78.95) via floor
    {
        fromPointID = 800115,
        fromMap = 1574,
        fromX = 0.2046,
        fromY = 0.1796,
        toPointID = 800114,
        toMap = 1573,
        toX = 0.6237,
        toY = 0.7895,
        type = "floor",
    },

    -- Zone: Mechagon (map 1490)
    -- Mechagon (map 1490 52.08,63.70) -> Mechagon (map 1491 80.63,16.93) via floor
    {
        fromPointID = 800106,
        fromMap = 1490,
        fromX = 0.5208,
        fromY = 0.637,
        toPointID = 800108,
        toMap = 1491,
        toX = 0.8063,
        toY = 0.1693,
        type = "floor",
    },

    -- Zone: Mechagon (map 1491)
    -- Mechagon (map 1491 33.86,59.33) -> Mechagon (map 1494 55.09,80.49) via floor
    {
        fromPointID = 800107,
        fromMap = 1491,
        fromX = 0.3386,
        fromY = 0.5933,
        toPointID = 800110,
        toMap = 1494,
        toX = 0.5509,
        toY = 0.8049,
        type = "floor",
    },
    -- Mechagon (map 1491 80.63,16.93) -> Mechagon (map 1490 52.08,63.70) via floor
    {
        fromPointID = 800108,
        fromMap = 1491,
        fromX = 0.8063,
        fromY = 0.1693,
        toPointID = 800106,
        toMap = 1490,
        toX = 0.5208,
        toY = 0.637,
        type = "floor",
    },

    -- Zone: Mechagon (map 1494)
    -- Mechagon (map 1494 20.37,18.29) -> Mechagon (map 1497 60.98,77.62) via floor
    {
        fromPointID = 800109,
        fromMap = 1494,
        fromX = 0.2037,
        fromY = 0.1829,
        toPointID = 800111,
        toMap = 1497,
        toX = 0.6098,
        toY = 0.7762,
        type = "floor",
    },
    -- Mechagon (map 1494 55.09,80.49) -> Mechagon (map 1491 33.86,59.33) via floor
    {
        fromPointID = 800110,
        fromMap = 1494,
        fromX = 0.5509,
        fromY = 0.8049,
        toPointID = 800107,
        toMap = 1491,
        toX = 0.3386,
        toY = 0.5933,
        type = "floor",
    },

    -- Zone: Mechagon (map 1497)
    -- Mechagon (map 1497 60.98,77.62) -> Mechagon (map 1494 20.37,18.29) via floor
    {
        fromPointID = 800111,
        fromMap = 1497,
        fromX = 0.6098,
        fromY = 0.7762,
        toPointID = 800109,
        toMap = 1494,
        toX = 0.2037,
        toY = 0.1829,
        type = "floor",
    },

    -- Zone: Millennia's Threshold (map 2191)
    -- Dawn of the Infinite (map 2191 44.88,50.11) -> Dawn of the Infinite (map 2190 64.97,80.52) via floor
    {
        fromPointID = 1100182,
        fromMap = 2191,
        fromX = 0.4488,
        fromY = 0.5011,
        toPointID = 1100181,
        toMap = 2190,
        toX = 0.6497,
        toY = 0.8052,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2191 76.92,62.30) -> Dawn of the Infinite (map 2192 33.17,50.04) via floor
    {
        fromPointID = 1100183,
        fromMap = 2191,
        fromX = 0.7692,
        fromY = 0.623,
        toPointID = 1100184,
        toMap = 2192,
        toX = 0.3317,
        toY = 0.5004,
        type = "floor",
    },

    -- Zone: Mogu'shan Palace (map 1544)
    -- Mogu Palace New (map 1544 48.58,66.20) -> Mogu Palace New (map 1545 55.27,18.89) via floor
    {
        fromPointID = 500297,
        fromMap = 1544,
        fromX = 0.4858,
        fromY = 0.662,
        toPointID = 500298,
        toMap = 1545,
        toX = 0.5527,
        toY = 0.1889,
        type = "floor",
    },

    -- Zone: Mogu'shan Palace (map 1545)
    -- Mogu Palace New (map 1545 55.27,18.89) -> Mogu Palace New (map 1544 48.58,66.20) via floor
    {
        fromPointID = 500298,
        fromMap = 1545,
        fromX = 0.5527,
        fromY = 0.1889,
        toPointID = 500297,
        toMap = 1544,
        toX = 0.4858,
        toY = 0.662,
        type = "floor",
    },

    -- Zone: Mogu'shan Palace (map 453)
    -- Mogu'shan Palace (map 453 49.00,67.00) -> Mogu'shan Palace (map 454 55.80,18.90) via floor
    {
        fromPointID = 500181,
        fromMap = 453,
        fromX = 0.49,
        fromY = 0.67,
        toPointID = 500182,
        toMap = 454,
        toX = 0.558,
        toY = 0.189,
        type = "floor",
    },

    -- Zone: Mogu'shan Palace (map 454)
    -- Mogu'shan Palace (map 454 55.80,18.90) -> Mogu'shan Palace (map 453 49.00,67.00) via floor
    {
        fromPointID = 500182,
        fromMap = 454,
        fromX = 0.558,
        fromY = 0.189,
        toPointID = 500181,
        toMap = 453,
        toX = 0.49,
        toY = 0.67,
        type = "floor",
    },
    -- Mogu'shan Palace (map 454 71.50,76.20) -> Mogu'shan Palace (map 455 58.80,24.30) via floor
    {
        fromPointID = 500183,
        fromMap = 454,
        fromX = 0.715,
        fromY = 0.762,
        toPointID = 500184,
        toMap = 455,
        toX = 0.588,
        toY = 0.243,
        type = "floor",
    },

    -- Zone: Mogu'shan Palace (map 455)
    -- Mogu'shan Palace (map 455 58.80,24.30) -> Mogu'shan Palace (map 454 71.50,76.20) via floor
    {
        fromPointID = 500184,
        fromMap = 455,
        fromX = 0.588,
        fromY = 0.243,
        toPointID = 500183,
        toMap = 454,
        toX = 0.715,
        toY = 0.762,
        type = "floor",
    },

    -- Zone: Mogu'shan Vaults (map 1548)
    -- Mogu Vaults New (map 1548 26.85,51.80) -> Mogu Vaults New (map 1549 66.22,10.55) via floor
    {
        fromPointID = 500299,
        fromMap = 1548,
        fromX = 0.2685,
        fromY = 0.518,
        toPointID = 500300,
        toMap = 1549,
        toX = 0.6622,
        toY = 0.1055,
        type = "floor",
    },

    -- Zone: Mogu'shan Vaults (map 1549)
    -- Mogu Vaults New (map 1549 66.22,10.55) -> Mogu Vaults New (map 1548 26.85,51.80) via floor
    {
        fromPointID = 500300,
        fromMap = 1549,
        fromX = 0.6622,
        fromY = 0.1055,
        toPointID = 500299,
        toMap = 1548,
        toX = 0.2685,
        toY = 0.518,
        type = "floor",
    },

    -- Zone: Mogu'shan Vaults (map 471)
    -- Mogu'shan Vaults (map 471 32.20,13.50) -> Mogu'shan Vaults (map 472 77.80,81.10) via floor
    {
        fromPointID = 500191,
        fromMap = 471,
        fromX = 0.322,
        fromY = 0.135,
        toPointID = 500194,
        toMap = 472,
        toX = 0.778,
        toY = 0.811,
        type = "floor",
    },

    -- Zone: Mogu'shan Vaults (map 472)
    -- Mogu'shan Vaults (map 472 28.70,52.10) -> Mogu'shan Vaults (map 473 65.70,10.60) via floor
    {
        fromPointID = 500193,
        fromMap = 472,
        fromX = 0.287,
        fromY = 0.521,
        toPointID = 500195,
        toMap = 473,
        toX = 0.657,
        toY = 0.106,
        type = "floor",
    },
    -- Mogu'shan Vaults (map 472 77.80,81.10) -> Mogu'shan Vaults (map 471 32.20,13.50) via floor
    {
        fromPointID = 500194,
        fromMap = 472,
        fromX = 0.778,
        fromY = 0.811,
        toPointID = 500191,
        toMap = 471,
        toX = 0.322,
        toY = 0.135,
        type = "floor",
    },

    -- Zone: Mogu'shan Vaults (map 473)
    -- Mogu'shan Vaults (map 473 65.70,10.60) -> Mogu'shan Vaults (map 472 28.70,52.10) via floor
    {
        fromPointID = 500195,
        fromMap = 473,
        fromX = 0.657,
        fromY = 0.106,
        toPointID = 500193,
        toMap = 472,
        toX = 0.287,
        toY = 0.521,
        type = "floor",
    },

    -- Zone: Mulgore (map 7)
    -- Mulgore (map 7 35.00,61.35) -> Mulgore (map 8 74.75,55.62) via floor
    {
        fromPointID = 100031,
        fromMap = 7,
        fromX = 0.35,
        fromY = 0.6135,
        toPointID = 100043,
        toMap = 8,
        toX = 0.7475,
        toY = 0.5562,
        type = "floor",
    },
    -- Mulgore (map 7 59.19,36.39) -> Mulgore (map 9 29.55,13.58) via floor
    {
        fromPointID = 100037,
        fromMap = 7,
        fromX = 0.5919,
        fromY = 0.3639,
        toPointID = 100045,
        toMap = 9,
        toX = 0.2955,
        toY = 0.1358,
        type = "floor",
    },
    -- Mulgore (map 7 59.19,44.16) -> Mulgore (map 9 28.50,65.33) via floor
    {
        fromPointID = 100038,
        fromMap = 7,
        fromX = 0.5919,
        fromY = 0.4416,
        toPointID = 100044,
        toMap = 9,
        toX = 0.285,
        toY = 0.6533,
        type = "floor",
    },
    -- Mulgore (map 7 60.74,47.59) -> Mulgore (map 9 40.15,89.72) via floor
    {
        fromPointID = 100039,
        fromMap = 7,
        fromX = 0.6074,
        fromY = 0.4759,
        toPointID = 100046,
        toMap = 9,
        toX = 0.4015,
        toY = 0.8972,
        type = "floor",
    },

    -- Zone: Murder Row (map 2433)
    -- Murder Row (map 2433 45.18,15.29) -> Murder Row (map 2435 77.52,66.97) via floor
    {
        fromPointID = 200716,
        fromMap = 2433,
        fromX = 0.4518,
        fromY = 0.1529,
        toPointID = 200719,
        toMap = 2435,
        toX = 0.7752,
        toY = 0.6697,
        type = "floor",
    },

    -- Zone: Naigtal (map 2600)
    -- Naigtal (map 2600 28.10,50.66) -> Vilaldoun (map 2646 70.03,22.76) via floor
    {
        fromPointID = 200869,
        fromMap = 2600,
        fromX = 0.281,
        fromY = 0.5066,
        toPointID = 200903,
        toMap = 2646,
        toX = 0.7003,
        toY = 0.2276,
        type = "floor",
    },

    -- Zone: Nath'raxas Spire (map 833)
    -- Krokuun (map 833 66.91,86.27) -> Krokuun (map 830 50.22,17.12) via floor
    {
        fromPointID = 700292,
        fromMap = 833,
        fromX = 0.6691,
        fromY = 0.8627,
        toPointID = 700284,
        toMap = 830,
        toX = 0.5022,
        toY = 0.1712,
        type = "floor",
    },

    -- Zone: Naxxramas (map 162)
    -- Naxxramas (map 162 68.60,77.70) -> Naxxramas (map 166 51.60,47.10) via floor
    {
        fromPointID = 400191,
        fromMap = 162,
        fromX = 0.686,
        fromY = 0.777,
        toPointID = 400196,
        toMap = 166,
        toX = 0.516,
        toY = 0.471,
        type = "floor",
    },

    -- Zone: Naxxramas (map 163)
    -- Naxxramas (map 163 30.70,77.90) -> Naxxramas (map 166 55.00,47.10) via floor
    {
        fromPointID = 400192,
        fromMap = 163,
        fromX = 0.307,
        fromY = 0.779,
        toPointID = 400200,
        toMap = 166,
        toX = 0.55,
        toY = 0.471,
        type = "floor",
    },

    -- Zone: Naxxramas (map 164)
    -- Naxxramas (map 164 66.90,21.90) -> Naxxramas (map 166 51.70,52.20) via floor
    {
        fromPointID = 400193,
        fromMap = 164,
        fromX = 0.669,
        fromY = 0.219,
        toPointID = 400197,
        toMap = 166,
        toX = 0.517,
        toY = 0.522,
        type = "floor",
    },

    -- Zone: Naxxramas (map 165)
    -- Naxxramas (map 165 32.90,22.40) -> Naxxramas (map 166 55.20,52.50) via floor
    {
        fromPointID = 400194,
        fromMap = 165,
        fromX = 0.329,
        fromY = 0.224,
        toPointID = 400201,
        toMap = 166,
        toX = 0.552,
        toY = 0.525,
        type = "floor",
    },

    -- Zone: Naxxramas (map 166)
    -- Naxxramas (map 166 51.60,47.10) -> Naxxramas (map 162 68.60,77.70) via floor
    {
        fromPointID = 400196,
        fromMap = 166,
        fromX = 0.516,
        fromY = 0.471,
        toPointID = 400191,
        toMap = 162,
        toX = 0.686,
        toY = 0.777,
        type = "floor",
    },
    -- Naxxramas (map 166 51.70,52.20) -> Naxxramas (map 164 66.90,21.90) via floor
    {
        fromPointID = 400197,
        fromMap = 166,
        fromX = 0.517,
        fromY = 0.522,
        toPointID = 400193,
        toMap = 164,
        toX = 0.669,
        toY = 0.219,
        type = "floor",
    },
    -- Naxxramas (map 166 53.50,50.10) -> Naxxramas (map 167 73.60,72.80) via floor
    {
        fromPointID = 400198,
        fromMap = 166,
        fromX = 0.535,
        fromY = 0.501,
        toPointID = 400202,
        toMap = 167,
        toX = 0.736,
        toY = 0.728,
        type = "floor",
    },
    -- Naxxramas (map 166 55.00,47.10) -> Naxxramas (map 163 30.70,77.90) via floor
    {
        fromPointID = 400200,
        fromMap = 166,
        fromX = 0.55,
        fromY = 0.471,
        toPointID = 400192,
        toMap = 163,
        toX = 0.307,
        toY = 0.779,
        type = "floor",
    },
    -- Naxxramas (map 166 55.20,52.50) -> Naxxramas (map 165 32.90,22.40) via floor
    {
        fromPointID = 400201,
        fromMap = 166,
        fromX = 0.552,
        fromY = 0.525,
        toPointID = 400194,
        toMap = 165,
        toX = 0.329,
        toY = 0.224,
        type = "floor",
    },

    -- Zone: Naxxramas (map 167)
    -- Naxxramas (map 167 74.60,73.20) -> Naxxramas (map 166 51.30,49.70) via floor
    {
        fromPointID = 400203,
        fromMap = 167,
        fromX = 0.746,
        fromY = 0.732,
        toPointID = 400195,
        toMap = 166,
        toX = 0.513,
        toY = 0.497,
        type = "floor",
    },

    -- Zone: Neltharus (map 2080)
    -- Neltharus (map 2080 27.16,52.69) -> Neltharus (map 2081 33.31,37.52) via floor
    {
        fromPointID = 1100086,
        fromMap = 2080,
        fromX = 0.2716,
        fromY = 0.5269,
        toPointID = 1100087,
        toMap = 2081,
        toX = 0.3331,
        toY = 0.3752,
        type = "floor",
    },

    -- Zone: Neltharus (map 2081)
    -- Neltharus (map 2081 33.31,37.52) -> Neltharus (map 2080 27.16,52.69) via floor
    {
        fromPointID = 1100087,
        fromMap = 2081,
        fromX = 0.3331,
        fromY = 0.3752,
        toPointID = 1100086,
        toMap = 2080,
        toX = 0.2716,
        toY = 0.5269,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2291)
    -- Nerub'ar Palace (map 2291 39.05,72.41) -> Nerub'ar Palace (map 2293 27.31,48.96) via floor
    {
        fromPointID = 1200080,
        fromMap = 2291,
        fromX = 0.3905,
        fromY = 0.7241,
        toPointID = 1200085,
        toMap = 2293,
        toX = 0.2731,
        toY = 0.4896,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2291 44.05,27.62) -> Nerub'ar Palace (map 2292 50.62,43.11) via floor
    {
        fromPointID = 1200081,
        fromMap = 2291,
        fromX = 0.4405,
        fromY = 0.2762,
        toPointID = 1200083,
        toMap = 2292,
        toX = 0.5062,
        toY = 0.4311,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2292)
    -- Nerub'ar Palace (map 2292 25.54,80.66) -> Nerub'ar Palace (map 2294 63.56,18.61) via floor
    {
        fromPointID = 1200082,
        fromMap = 2292,
        fromX = 0.2554,
        fromY = 0.8066,
        toPointID = 1200087,
        toMap = 2294,
        toX = 0.6356,
        toY = 0.1861,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2292 50.62,43.11) -> Nerub'ar Palace (map 2291 44.05,27.62) via floor
    {
        fromPointID = 1200083,
        fromMap = 2292,
        fromX = 0.5062,
        fromY = 0.4311,
        toPointID = 1200081,
        toMap = 2291,
        toX = 0.4405,
        toY = 0.2762,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2293)
    -- Nerub'ar Palace (map 2293 27.31,48.96) -> Nerub'ar Palace (map 2291 39.05,72.41) via floor
    {
        fromPointID = 1200085,
        fromMap = 2293,
        fromX = 0.2731,
        fromY = 0.4896,
        toPointID = 1200080,
        toMap = 2291,
        toX = 0.3905,
        toY = 0.7241,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2294)
    -- Nerub'ar Palace (map 2294 39.09,55.82) -> Nerub'ar Palace (map 2295 71.54,18.47) via floor
    {
        fromPointID = 1200086,
        fromMap = 2294,
        fromX = 0.3909,
        fromY = 0.5582,
        toPointID = 1200090,
        toMap = 2295,
        toX = 0.7154,
        toY = 0.1847,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2294 63.56,18.61) -> Nerub'ar Palace (map 2292 25.54,80.66) via floor
    {
        fromPointID = 1200087,
        fromMap = 2294,
        fromX = 0.6356,
        fromY = 0.1861,
        toPointID = 1200082,
        toMap = 2292,
        toX = 0.2554,
        toY = 0.8066,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2295)
    -- Nerub'ar Palace (map 2295 45.25,68.04) -> Nerub'ar Palace (map 2296 50.50,47.53) via floor
    {
        fromPointID = 1200088,
        fromMap = 2295,
        fromX = 0.4525,
        fromY = 0.6804,
        toPointID = 1200091,
        toMap = 2296,
        toX = 0.505,
        toY = 0.4753,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2295 50.02,41.43) -> Nerub'ar Palace (map 2296 50.50,47.53) via floor
    {
        fromPointID = 1200089,
        fromMap = 2295,
        fromX = 0.5002,
        fromY = 0.4143,
        toPointID = 1200091,
        toMap = 2296,
        toX = 0.505,
        toY = 0.4753,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2295 71.54,18.47) -> Nerub'ar Palace (map 2294 39.09,55.82) via floor
    {
        fromPointID = 1200090,
        fromMap = 2295,
        fromX = 0.7154,
        fromY = 0.1847,
        toPointID = 1200086,
        toMap = 2294,
        toX = 0.3909,
        toY = 0.5582,
        type = "floor",
    },

    -- Zone: Nerub-ar Palace (map 2296)
    -- Nerub'ar Palace (map 2296 50.50,47.53) -> Nerub'ar Palace (map 2295 45.25,68.04) via floor
    {
        fromPointID = 1200091,
        fromMap = 2296,
        fromX = 0.505,
        fromY = 0.4753,
        toPointID = 1200088,
        toMap = 2295,
        toX = 0.4525,
        toY = 0.6804,
        type = "floor",
    },
    -- Nerub'ar Palace (map 2296 50.50,47.53) -> Nerub'ar Palace (map 2295 50.02,41.43) via floor
    {
        fromPointID = 1200091,
        fromMap = 2296,
        fromX = 0.505,
        fromY = 0.4753,
        toPointID = 1200089,
        toMap = 2295,
        toX = 0.5002,
        toY = 0.4143,
        type = "floor",
    },

    -- Zone: New Tinkertown (map 30)
    -- Dun Morogh (map 30 79.50,84.20) -> New Tinkertown (map 469 32.60,37.00) via floor
    {
        fromPointID = 200137,
        fromMap = 30,
        fromX = 0.795,
        fromY = 0.842,
        toPointID = 200611,
        toMap = 469,
        toX = 0.326,
        toY = 0.37,
        type = "floor",
    },

    -- Zone: New Tinkertown (map 469)
    -- New Tinkertown (map 469 32.60,37.00) -> Dun Morogh (map 30 79.50,84.20) via floor
    {
        fromPointID = 200611,
        fromMap = 469,
        fromX = 0.326,
        fromY = 0.37,
        toPointID = 200137,
        toMap = 30,
        toX = 0.795,
        toY = 0.842,
        type = "floor",
    },
    -- New Tinkertown (map 469 33.30,66.40) -> New Tinkertown (map 470 94.60,58.10) via floor
    {
        fromPointID = 200612,
        fromMap = 469,
        fromX = 0.333,
        fromY = 0.664,
        toPointID = 200615,
        toMap = 470,
        toX = 0.946,
        toY = 0.581,
        type = "floor",
    },

    -- Zone: Nexus of Actualization (map 2030)
    -- Nexus of Actualization (map 2030 31.16,61.21) -> Zereth Mortis (map 1970 58.10,44.33) via floor
    {
        fromPointID = 1000363,
        fromMap = 2030,
        fromX = 0.3116,
        fromY = 0.6121,
        toPointID = 1000327,
        toMap = 1970,
        toX = 0.581,
        toY = 0.4433,
        type = "floor",
    },

    -- Zone: Night Web's Hollow (map 466)
    -- Deathknell (map 466 87.30,52.00) -> Deathknell (map 465 29.70,30.70) via floor
    {
        fromPointID = 200609,
        fromMap = 466,
        fromX = 0.873,
        fromY = 0.52,
        toPointID = 200606,
        toMap = 465,
        toX = 0.297,
        toY = 0.307,
        type = "floor",
    },

    -- Zone: Niuzao Temple (map 389)
    -- Townlong Steppes (map 389 20.15,68.46) -> Townlong Steppes (map 388 33.02,61.24) via floor
    {
        fromPointID = 500105,
        fromMap = 389,
        fromX = 0.2015,
        fromY = 0.6846,
        toPointID = 500085,
        toMap = 388,
        toX = 0.3302,
        toY = 0.6124,
        type = "floor",
    },

    -- Zone: Northern Barrens (map 10)
    -- Northern Barrens (map 10 38.97,69.42) -> Northern Barrens (map 11 22.61,87.96) via floor
    {
        fromPointID = 100050,
        fromMap = 10,
        fromX = 0.3897,
        fromY = 0.6942,
        toPointID = 100054,
        toMap = 11,
        toX = 0.2261,
        toY = 0.8796,
        type = "floor",
    },

    -- Zone: Ny'alotha, the Waking City (map 2379)
    -- Lorewalking Ny'alotha (map 2379 51.02,12.68) -> Lorewalking Ny'alotha (map 2381 52.55,78.71) via floor
    {
        fromPointID = 1300078,
        fromMap = 2379,
        fromX = 0.5102,
        fromY = 0.1268,
        toPointID = 1300081,
        toMap = 2381,
        toX = 0.5255,
        toY = 0.7871,
        type = "floor",
    },

    -- Zone: Ny'alotha, the Waking City (map 2381)
    -- Lorewalking Ny'alotha (map 2381 45.39,43.48) -> Lorewalking Ny'alotha (map 2382 78.13,88.53) via floor
    {
        fromPointID = 1300079,
        fromMap = 2381,
        fromX = 0.4539,
        fromY = 0.4348,
        toPointID = 1300083,
        toMap = 2382,
        toX = 0.7813,
        toY = 0.8853,
        type = "floor",
    },
    -- Lorewalking Ny'alotha (map 2381 49.36,54.60) -> Lorewalking Ny'alotha (map 2384 57.72,23.29) via floor
    {
        fromPointID = 1300080,
        fromMap = 2381,
        fromX = 0.4936,
        fromY = 0.546,
        toPointID = 1300085,
        toMap = 2384,
        toX = 0.5772,
        toY = 0.2329,
        type = "floor",
    },
    -- Lorewalking Ny'alotha (map 2381 52.55,78.71) -> Lorewalking Ny'alotha (map 2379 51.02,12.68) via floor
    {
        fromPointID = 1300081,
        fromMap = 2381,
        fromX = 0.5255,
        fromY = 0.7871,
        toPointID = 1300078,
        toMap = 2379,
        toX = 0.5102,
        toY = 0.1268,
        type = "floor",
    },
    -- Lorewalking Ny'alotha (map 2381 60.16,53.47) -> Lorewalking Ny'alotha (map 2383 32.57,46.17) via floor
    {
        fromPointID = 1300082,
        fromMap = 2381,
        fromX = 0.6016,
        fromY = 0.5347,
        toPointID = 1300084,
        toMap = 2383,
        toX = 0.3257,
        toY = 0.4617,
        type = "floor",
    },

    -- Zone: Ny'alotha, the Waking City (map 2382)
    -- Lorewalking Ny'alotha (map 2382 78.13,88.53) -> Lorewalking Ny'alotha (map 2381 45.39,43.48) via floor
    {
        fromPointID = 1300083,
        fromMap = 2382,
        fromX = 0.7813,
        fromY = 0.8853,
        toPointID = 1300079,
        toMap = 2381,
        toX = 0.4539,
        toY = 0.4348,
        type = "floor",
    },

    -- Zone: Ny'alotha, the Waking City (map 2383)
    -- Lorewalking Ny'alotha (map 2383 32.57,46.17) -> Lorewalking Ny'alotha (map 2381 60.16,53.47) via floor
    {
        fromPointID = 1300084,
        fromMap = 2383,
        fromX = 0.3257,
        fromY = 0.4617,
        toPointID = 1300082,
        toMap = 2381,
        toX = 0.6016,
        toY = 0.5347,
        type = "floor",
    },

    -- Zone: Ny'alotha, the Waking City (map 2384)
    -- Lorewalking Ny'alotha (map 2384 57.72,23.29) -> Lorewalking Ny'alotha (map 2381 49.36,54.60) via floor
    {
        fromPointID = 1300085,
        fromMap = 2384,
        fromX = 0.5772,
        fromY = 0.2329,
        toPointID = 1300080,
        toMap = 2381,
        toX = 0.4936,
        toY = 0.546,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1580)
    -- Ny'alotha, the Waking City (map 1580 52.98,49.54) -> Ny'alotha, the Waking City (map 1581 51.07,82.36) via floor
    {
        fromPointID = 1300053,
        fromMap = 1580,
        fromX = 0.5298,
        fromY = 0.4954,
        toPointID = 1300054,
        toMap = 1581,
        toX = 0.5107,
        toY = 0.8236,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1581)
    -- Ny'alotha, the Waking City (map 1581 51.10,15.40) -> Ny'alotha, the Waking City (map 1582 52.20,79.44) via floor
    {
        fromPointID = 1300055,
        fromMap = 1581,
        fromX = 0.511,
        fromY = 0.154,
        toPointID = 1300058,
        toMap = 1582,
        toX = 0.522,
        toY = 0.7944,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1582)
    -- Ny'alotha, the Waking City (map 1582 44.51,42.24) -> Ny'alotha, the Waking City (map 1590 75.33,85.00) via floor
    {
        fromPointID = 1300056,
        fromMap = 1582,
        fromX = 0.4451,
        fromY = 0.4224,
        toPointID = 1300062,
        toMap = 1590,
        toX = 0.7533,
        toY = 0.85,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1582 48.74,53.15) -> Ny'alotha, the Waking City (map 1594 59.57,31.65) via floor
    {
        fromPointID = 1300057,
        fromMap = 1582,
        fromX = 0.4874,
        fromY = 0.5315,
        toPointID = 1300068,
        toMap = 1594,
        toX = 0.5957,
        toY = 0.3165,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1582 52.20,79.44) -> Ny'alotha, the Waking City (map 1581 51.10,15.40) via floor
    {
        fromPointID = 1300058,
        fromMap = 1582,
        fromX = 0.522,
        fromY = 0.7944,
        toPointID = 1300055,
        toMap = 1581,
        toX = 0.511,
        toY = 0.154,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1582 52.51,16.89) -> Ny'alotha, the Waking City (map 1597 48.90,81.33) via floor
    {
        fromPointID = 1300059,
        fromMap = 1582,
        fromX = 0.5251,
        fromY = 0.1689,
        toPointID = 1300072,
        toMap = 1597,
        toX = 0.489,
        toY = 0.8133,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1582 58.63,53.78) -> Ny'alotha, the Waking City (map 1592 12.64,51.73) via floor
    {
        fromPointID = 1300060,
        fromMap = 1582,
        fromX = 0.5863,
        fromY = 0.5378,
        toPointID = 1300064,
        toMap = 1592,
        toX = 0.1264,
        toY = 0.5173,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1590)
    -- Ny'alotha, the Waking City (map 1590 34.77,32.83) -> Ny'alotha, the Waking City (map 1591 37.44,32.43) via floor
    {
        fromPointID = 1300061,
        fromMap = 1590,
        fromX = 0.3477,
        fromY = 0.3283,
        toPointID = 1300063,
        toMap = 1591,
        toX = 0.3744,
        toY = 0.3243,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1590 75.33,85.00) -> Ny'alotha, the Waking City (map 1582 44.51,42.24) via floor
    {
        fromPointID = 1300062,
        fromMap = 1590,
        fromX = 0.7533,
        fromY = 0.85,
        toPointID = 1300056,
        toMap = 1582,
        toX = 0.4451,
        toY = 0.4224,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1591)
    -- Ny'alotha, the Waking City (map 1591 37.44,32.43) -> Ny'alotha, the Waking City (map 1590 34.77,32.83) via floor
    {
        fromPointID = 1300063,
        fromMap = 1591,
        fromX = 0.3744,
        fromY = 0.3243,
        toPointID = 1300061,
        toMap = 1590,
        toX = 0.3477,
        toY = 0.3283,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1592)
    -- Ny'alotha, the Waking City (map 1592 12.64,51.73) -> Ny'alotha, the Waking City (map 1582 58.63,53.78) via floor
    {
        fromPointID = 1300064,
        fromMap = 1592,
        fromX = 0.1264,
        fromY = 0.5173,
        toPointID = 1300060,
        toMap = 1582,
        toX = 0.5863,
        toY = 0.5378,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1592 74.96,43.73) -> Ny'alotha, the Waking City (map 1593 74.33,45.77) via floor
    {
        fromPointID = 1300065,
        fromMap = 1592,
        fromX = 0.7496,
        fromY = 0.4373,
        toPointID = 1300066,
        toMap = 1593,
        toX = 0.7433,
        toY = 0.4577,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1593)
    -- Ny'alotha, the Waking City (map 1593 74.33,45.77) -> Ny'alotha, the Waking City (map 1592 74.96,43.73) via floor
    {
        fromPointID = 1300066,
        fromMap = 1593,
        fromX = 0.7433,
        fromY = 0.4577,
        toPointID = 1300065,
        toMap = 1592,
        toX = 0.7496,
        toY = 0.4373,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1594)
    -- Ny'alotha, the Waking City (map 1594 56.12,20.82) -> Ny'alotha, the Waking City (map 1595 78.72,48.67) via floor
    {
        fromPointID = 1300067,
        fromMap = 1594,
        fromX = 0.5612,
        fromY = 0.2082,
        toPointID = 1300070,
        toMap = 1595,
        toX = 0.7872,
        toY = 0.4867,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1594 59.57,31.65) -> Ny'alotha, the Waking City (map 1582 48.74,53.15) via floor
    {
        fromPointID = 1300068,
        fromMap = 1594,
        fromX = 0.5957,
        fromY = 0.3165,
        toPointID = 1300057,
        toMap = 1582,
        toX = 0.4874,
        toY = 0.5315,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1595)
    -- Ny'alotha, the Waking City (map 1595 65.70,66.80) -> Ny'alotha, the Waking City (map 1596 49.21,84.67) via floor
    {
        fromPointID = 1300069,
        fromMap = 1595,
        fromX = 0.657,
        fromY = 0.668,
        toPointID = 1300071,
        toMap = 1596,
        toX = 0.4921,
        toY = 0.8467,
        type = "floor",
    },
    -- Ny'alotha, the Waking City (map 1595 78.72,48.67) -> Ny'alotha, the Waking City (map 1594 56.12,20.82) via floor
    {
        fromPointID = 1300070,
        fromMap = 1595,
        fromX = 0.7872,
        fromY = 0.4867,
        toPointID = 1300067,
        toMap = 1594,
        toX = 0.5612,
        toY = 0.2082,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1596)
    -- Ny'alotha, the Waking City (map 1596 49.21,84.67) -> Ny'alotha, the Waking City (map 1595 65.70,66.80) via floor
    {
        fromPointID = 1300071,
        fromMap = 1596,
        fromX = 0.4921,
        fromY = 0.8467,
        toPointID = 1300069,
        toMap = 1595,
        toX = 0.657,
        toY = 0.668,
        type = "floor",
    },

    -- Zone: Ny'alotha (map 1597)
    -- Ny'alotha, the Waking City (map 1597 48.90,81.33) -> Ny'alotha, the Waking City (map 1582 52.51,16.89) via floor
    {
        fromPointID = 1300072,
        fromMap = 1597,
        fromX = 0.489,
        fromY = 0.8133,
        toPointID = 1300059,
        toMap = 1582,
        toX = 0.5251,
        toY = 0.1689,
        type = "floor",
    },

    -- Zone: Operation: Floodgate (map 2387)
    -- Operation: Floodgate (map 2387 51.05,80.27) -> Operation: Floodgate (map 2388 42.13,16.32) via floor
    {
        fromPointID = 1200170,
        fromMap = 2387,
        fromX = 0.5105,
        fromY = 0.8027,
        toPointID = 1200171,
        toMap = 2388,
        toX = 0.4213,
        toY = 0.1632,
        type = "floor",
    },

    -- Zone: Operation: Floodgate (map 2388)
    -- Operation: Floodgate (map 2388 42.13,16.32) -> Operation: Floodgate (map 2387 51.05,80.27) via floor
    {
        fromPointID = 1200171,
        fromMap = 2388,
        fromX = 0.4213,
        fromY = 0.1632,
        toPointID = 1200170,
        toMap = 2387,
        toX = 0.5105,
        toY = 0.8027,
        type = "floor",
    },

    -- Zone: Orgrimmar (map 85)
    -- Orgrimmar (map 85 42.18,61.25) -> Orgrimmar (map 86 24.27,73.65) via floor
    {
        fromPointID = 100257,
        fromMap = 85,
        fromX = 0.4218,
        fromY = 0.6125,
        toPointID = 100290,
        toMap = 86,
        toX = 0.2427,
        toY = 0.7365,
        type = "floor",
    },
    -- Orgrimmar (map 85 55.98,51.39) -> Orgrimmar (map 86 77.67,15.09) via floor
    {
        fromPointID = 100274,
        fromMap = 85,
        fromX = 0.5598,
        fromY = 0.5139,
        toPointID = 100292,
        toMap = 86,
        toX = 0.7767,
        toY = 0.1509,
        type = "floor",
    },

    -- Zone: Orgrimmar (map 86)
    -- Orgrimmar (map 86 24.27,73.65) -> Orgrimmar (map 85 42.18,61.25) via floor
    {
        fromPointID = 100290,
        fromMap = 86,
        fromX = 0.2427,
        fromY = 0.7365,
        toPointID = 100257,
        toMap = 85,
        toX = 0.4218,
        toY = 0.6125,
        type = "floor",
    },
    -- Orgrimmar (map 86 77.67,15.09) -> Orgrimmar (map 85 55.98,51.39) via floor
    {
        fromPointID = 100292,
        fromMap = 86,
        fromX = 0.7767,
        fromY = 0.1509,
        toPointID = 100274,
        toMap = 85,
        toX = 0.5598,
        toY = 0.5139,
        type = "floor",
    },

    -- Zone: Oribos (map 1670)
    -- Oribos (map 1670 69.00,41.44) -> Oribos (map 1672 57.83,27.61) via floor
    {
        fromPointID = 1000177,
        fromMap = 1670,
        fromX = 0.69,
        fromY = 0.4144,
        toPointID = 1000195,
        toMap = 1672,
        toX = 0.5783,
        toY = 0.2761,
        type = "floor",
    },
    -- Oribos (map 1670 70.50,59.94) -> Oribos (map 1672 55.63,71.15) via floor
    {
        fromPointID = 1000178,
        fromMap = 1670,
        fromX = 0.705,
        fromY = 0.5994,
        toPointID = 1000194,
        toMap = 1672,
        toX = 0.5563,
        toY = 0.7115,
        type = "floor",
    },

    -- Zone: Oribos (map 1672)
    -- Oribos (map 1672 55.63,71.15) -> Oribos (map 1670 70.50,59.94) via floor
    {
        fromPointID = 1000194,
        fromMap = 1672,
        fromX = 0.5563,
        fromY = 0.7115,
        toPointID = 1000178,
        toMap = 1670,
        toX = 0.705,
        toY = 0.5994,
        type = "floor",
    },
    -- Oribos (map 1672 57.83,27.61) -> Oribos (map 1670 69.00,41.44) via floor
    {
        fromPointID = 1000195,
        fromMap = 1672,
        fromX = 0.5783,
        fromY = 0.2761,
        toPointID = 1000177,
        toMap = 1670,
        toX = 0.69,
        toY = 0.4144,
        type = "floor",
    },

    -- Zone: Palemane Rock (map 8)
    -- Mulgore (map 8 74.75,55.62) -> Mulgore (map 7 35.00,61.35) via floor
    {
        fromPointID = 100043,
        fromMap = 8,
        fromX = 0.7475,
        fromY = 0.5562,
        toPointID = 100031,
        toMap = 7,
        toX = 0.35,
        toY = 0.6135,
        type = "floor",
    },

    -- Zone: Path of Wisdom (map 1713)
    -- Path of Wisdom (map 1713 48.04,90.71) -> Bastion (map 1533 44.03,24.70) via floor
    {
        fromPointID = 1000274,
        fromMap = 1713,
        fromX = 0.4804,
        fromY = 0.9071,
        toPointID = 1000038,
        toMap = 1533,
        toX = 0.4403,
        toY = 0.247,
        type = "floor",
    },

    -- Zone: Pit of Anguish (map 1820)
    -- Pit of Anguish (map 1820 49.83,48.55) -> Pit of Anguish (map 1821 52.07,54.46) via floor
    {
        fromPointID = 1000298,
        fromMap = 1820,
        fromX = 0.4983,
        fromY = 0.4855,
        toPointID = 1000301,
        toMap = 1821,
        toX = 0.5207,
        toY = 0.5446,
        type = "floor",
    },
    -- Pit of Anguish (map 1820 51.81,27.65) -> Pit of Anguish (map 1821 52.09,26.31) via floor
    {
        fromPointID = 1000299,
        fromMap = 1820,
        fromX = 0.5181,
        fromY = 0.2765,
        toPointID = 1000302,
        toMap = 1821,
        toX = 0.5209,
        toY = 0.2631,
        type = "floor",
    },

    -- Zone: Pit of Anguish (map 1821)
    -- Pit of Anguish (map 1821 52.09,26.31) -> Pit of Anguish (map 1820 51.81,27.65) via floor
    {
        fromPointID = 1000302,
        fromMap = 1821,
        fromX = 0.5209,
        fromY = 0.2631,
        toPointID = 1000299,
        toMap = 1820,
        toX = 0.5181,
        toY = 0.2765,
        type = "floor",
    },
    -- Pit of Anguish (map 1821 60.47,54.08) -> Pit of Anguish (map 1820 60.66,51.99) via floor
    {
        fromPointID = 1000303,
        fromMap = 1821,
        fromX = 0.6047,
        fromY = 0.5408,
        toPointID = 1000300,
        toMap = 1820,
        toX = 0.6066,
        toY = 0.5199,
        type = "floor",
    },

    -- Zone: Plaguefall (map 1674)
    -- Plaguefall (map 1674 55.40,81.42) -> Plaguefall (map 1697 55.17,44.55) via floor
    {
        fromPointID = 1000197,
        fromMap = 1674,
        fromX = 0.554,
        fromY = 0.8142,
        toPointID = 1000224,
        toMap = 1697,
        toX = 0.5517,
        toY = 0.4455,
        type = "floor",
    },

    -- Zone: Plaguefall (map 1697)
    -- Plaguefall (map 1697 55.17,44.55) -> Plaguefall (map 1674 55.40,81.42) via floor
    {
        fromPointID = 1000224,
        fromMap = 1697,
        fromX = 0.5517,
        fromY = 0.4455,
        toPointID = 1000197,
        toMap = 1674,
        toX = 0.554,
        toY = 0.8142,
        type = "floor",
    },

    -- Zone: Pranksters' Hollow (map 381)
    -- Kun-Lai Summit (map 381 16.69,34.49) -> Kun-Lai Summit (map 379 72.96,73.39) via floor
    {
        fromPointID = 500077,
        fromMap = 381,
        fromX = 0.1669,
        fromY = 0.3449,
        toPointID = 500072,
        toMap = 379,
        toX = 0.7296,
        toY = 0.7339,
        type = "floor",
    },

    -- Zone: Priory of the Sacred Flame (map 2308)
    -- Priory of the Sacred Flame (map 2308 30.18,55.49) -> Priory of the Sacred Flame (map 2309 89.24,47.35) via floor
    {
        fromPointID = 1200096,
        fromMap = 2308,
        fromX = 0.3018,
        fromY = 0.5549,
        toPointID = 1200098,
        toMap = 2309,
        toX = 0.8924,
        toY = 0.4735,
        type = "floor",
    },

    -- Zone: Priory of the Sacred Flame (map 2309)
    -- Priory of the Sacred Flame (map 2309 89.24,47.35) -> Priory of the Sacred Flame (map 2308 30.18,55.49) via floor
    {
        fromPointID = 1200098,
        fromMap = 2309,
        fromX = 0.8924,
        fromY = 0.4735,
        toPointID = 1200096,
        toMap = 2308,
        toX = 0.3018,
        toY = 0.5549,
        type = "floor",
    },

    -- Zone: Profaned Mausoleum (map 2638)
    -- Profaned Mausoleum (map 2638 18.30,59.99) -> Vaults of Atal'Utek (map 2509 54.92,48.13) via floor
    {
        fromPointID = 200894,
        fromMap = 2638,
        fromX = 0.183,
        fromY = 0.5999,
        toPointID = 200766,
        toMap = 2509,
        toX = 0.5492,
        toY = 0.4813,
        type = "floor",
    },

    -- Zone: Revantusk Sedge (map 2584)
    -- Revantusk Sedge (map 2584 83.89,39.15) -> Zul Aman M (map 2437 22.02,63.42) via floor
    {
        fromPointID = 200858,
        fromMap = 2584,
        fromX = 0.8389,
        fromY = 0.3915,
        toPointID = 200720,
        toMap = 2437,
        toX = 0.2202,
        toY = 0.6342,
        type = "floor",
    },

    -- Zone: Ruby Life Pools (map 2094)
    -- Ruby Life Pools (map 2094 51.37,57.57) -> Ruby Life Pools (map 2095 64.57,43.07) via floor
    {
        fromPointID = 1100092,
        fromMap = 2094,
        fromX = 0.5137,
        fromY = 0.5757,
        toPointID = 1100094,
        toMap = 2095,
        toX = 0.6457,
        toY = 0.4307,
        type = "floor",
    },

    -- Zone: Ruby Life Pools (map 2095)
    -- Ruby Life Pools (map 2095 64.57,43.07) -> Ruby Life Pools (map 2094 51.37,57.57) via floor
    {
        fromPointID = 1100094,
        fromMap = 2095,
        fromX = 0.6457,
        fromY = 0.4307,
        toPointID = 1100092,
        toMap = 2094,
        toX = 0.5137,
        toY = 0.5757,
        type = "floor",
    },

    -- Zone: Ruins of Korune (map 386)
    -- Kun-Lai Summit (map 386 30.90,75.90) -> Kun-Lai Summit (map 387 34.30,76.10) via floor
    {
        fromPointID = 500082,
        fromMap = 386,
        fromX = 0.309,
        fromY = 0.759,
        toPointID = 500084,
        toMap = 387,
        toX = 0.343,
        toY = 0.761,
        type = "floor",
    },
    -- Kun-Lai Summit (map 386 52.20,11.60) -> Kun-Lai Summit (map 379 33.10,26.60) via floor
    {
        fromPointID = 500083,
        fromMap = 386,
        fromX = 0.522,
        fromY = 0.116,
        toPointID = 500045,
        toMap = 379,
        toX = 0.331,
        toY = 0.266,
        type = "floor",
    },

    -- Zone: Ruins of Korune (map 387)
    -- Kun-Lai Summit (map 387 34.30,76.10) -> Kun-Lai Summit (map 386 30.90,75.90) via floor
    {
        fromPointID = 500084,
        fromMap = 387,
        fromX = 0.343,
        fromY = 0.761,
        toPointID = 500082,
        toMap = 386,
        toX = 0.309,
        toY = 0.759,
        type = "floor",
    },

    -- Zone: Ruins of Ogudei (map 419)
    -- Krasarang Wilds (map 419 33.37,22.27) -> Krasarang Wilds (map 418 80.30,17.71) via floor
    {
        fromPointID = 500129,
        fromMap = 419,
        fromX = 0.3337,
        fromY = 0.2227,
        toPointID = 500128,
        toMap = 418,
        toX = 0.803,
        toY = 0.1771,
        type = "floor",
    },
    -- Krasarang Wilds (map 419 66.47,49.74) -> Krasarang Wilds (map 421 64.21,37.28) via floor
    {
        fromPointID = 500130,
        fromMap = 419,
        fromX = 0.6647,
        fromY = 0.4974,
        toPointID = 500132,
        toMap = 421,
        toX = 0.6421,
        toY = 0.3728,
        type = "floor",
    },

    -- Zone: Ruins of Ogudei (map 420)
    -- Krasarang Wilds (map 420 77.14,41.93) -> Krasarang Wilds (map 421 89.85,48.42) via floor
    {
        fromPointID = 500131,
        fromMap = 420,
        fromX = 0.7714,
        fromY = 0.4193,
        toPointID = 500133,
        toMap = 421,
        toX = 0.8985,
        toY = 0.4842,
        type = "floor",
    },

    -- Zone: Ruins of Ogudei (map 421)
    -- Krasarang Wilds (map 421 64.21,37.28) -> Krasarang Wilds (map 419 66.47,49.74) via floor
    {
        fromPointID = 500132,
        fromMap = 421,
        fromX = 0.6421,
        fromY = 0.3728,
        toPointID = 500130,
        toMap = 419,
        toX = 0.6647,
        toY = 0.4974,
        type = "floor",
    },
    -- Krasarang Wilds (map 421 89.85,48.42) -> Krasarang Wilds (map 420 77.14,41.93) via floor
    {
        fromPointID = 500133,
        fromMap = 421,
        fromX = 0.8985,
        fromY = 0.4842,
        toPointID = 500131,
        toMap = 420,
        toX = 0.7714,
        toY = 0.4193,
        type = "floor",
    },

    -- Zone: Ruuk'Jar's Clutch (map 2637)
    -- Ruuk'Jar's Clutch (map 2637 84.12,41.15) -> Vaults of Atal'Utek (map 2509 39.32,39.92) via floor
    {
        fromPointID = 200893,
        fromMap = 2637,
        fromX = 0.8412,
        fromY = 0.4115,
        toPointID = 200758,
        toMap = 2509,
        toX = 0.3932,
        toY = 0.3992,
        type = "floor",
    },

    -- Zone: Sanctum of Chronology (map 2190)
    -- Dawn of the Infinite (map 2190 64.97,80.52) -> Dawn of the Infinite (map 2191 44.88,50.11) via floor
    {
        fromPointID = 1100181,
        fromMap = 2190,
        fromX = 0.6497,
        fromY = 0.8052,
        toPointID = 1100182,
        toMap = 2191,
        toX = 0.4488,
        toY = 0.5011,
        type = "floor",
    },

    -- Zone: Sanctum of Domination (map 1998)
    -- Sanctum of Domination (map 1998 54.47,59.01) -> Sanctum of Domination (map 1999 24.19,86.12) via floor
    {
        fromPointID = 1000347,
        fromMap = 1998,
        fromX = 0.5447,
        fromY = 0.5901,
        toPointID = 1000348,
        toMap = 1999,
        toX = 0.2419,
        toY = 0.8612,
        type = "floor",
    },

    -- Zone: Sanctum of Domination (map 1999)
    -- Sanctum of Domination (map 1999 24.19,86.12) -> Sanctum of Domination (map 1998 54.47,59.01) via floor
    {
        fromPointID = 1000348,
        fromMap = 1999,
        fromX = 0.2419,
        fromY = 0.8612,
        toPointID = 1000347,
        toMap = 1998,
        toX = 0.5447,
        toY = 0.5901,
        type = "floor",
    },
    -- Sanctum of Domination (map 1999 37.48,12.19) -> Sanctum of Domination (map 2000 21.21,47.60) via floor
    {
        fromPointID = 1000349,
        fromMap = 1999,
        fromX = 0.3748,
        fromY = 0.1219,
        toPointID = 1000351,
        toMap = 2000,
        toX = 0.2121,
        toY = 0.476,
        type = "floor",
    },
    -- Sanctum of Domination (map 1999 46.58,12.60) -> Sanctum of Domination (map 2000 30.42,47.74) via floor
    {
        fromPointID = 1000350,
        fromMap = 1999,
        fromX = 0.4658,
        fromY = 0.126,
        toPointID = 1000352,
        toMap = 2000,
        toX = 0.3042,
        toY = 0.4774,
        type = "floor",
    },

    -- Zone: Sanctum of Domination (map 2000)
    -- Sanctum of Domination (map 2000 21.21,47.60) -> Sanctum of Domination (map 1999 37.48,12.19) via floor
    {
        fromPointID = 1000351,
        fromMap = 2000,
        fromX = 0.2121,
        fromY = 0.476,
        toPointID = 1000349,
        toMap = 1999,
        toX = 0.3748,
        toY = 0.1219,
        type = "floor",
    },
    -- Sanctum of Domination (map 2000 30.42,47.74) -> Sanctum of Domination (map 1999 46.58,12.60) via floor
    {
        fromPointID = 1000352,
        fromMap = 2000,
        fromX = 0.3042,
        fromY = 0.4774,
        toPointID = 1000350,
        toMap = 1999,
        toX = 0.4658,
        toY = 0.126,
        type = "floor",
    },
    -- Sanctum of Domination (map 2000 54.83,36.26) -> Sanctum of Domination (map 2001 63.12,52.01) via floor
    {
        fromPointID = 1000353,
        fromMap = 2000,
        fromX = 0.5483,
        fromY = 0.3626,
        toPointID = 1000355,
        toMap = 2001,
        toX = 0.6312,
        toY = 0.5201,
        type = "floor",
    },

    -- Zone: Sanctum of Domination (map 2001)
    -- Sanctum of Domination (map 2001 33.90,52.01) -> Sanctum of Domination (map 2002 43.52,42.48) via floor
    {
        fromPointID = 1000354,
        fromMap = 2001,
        fromX = 0.339,
        fromY = 0.5201,
        toPointID = 1000356,
        toMap = 2002,
        toX = 0.4352,
        toY = 0.4248,
        type = "floor",
    },
    -- Sanctum of Domination (map 2001 63.12,52.01) -> Sanctum of Domination (map 2000 54.83,36.26) via floor
    {
        fromPointID = 1000355,
        fromMap = 2001,
        fromX = 0.6312,
        fromY = 0.5201,
        toPointID = 1000353,
        toMap = 2000,
        toX = 0.5483,
        toY = 0.3626,
        type = "floor",
    },

    -- Zone: Sanctum of Domination (map 2002)
    -- Sanctum of Domination (map 2002 43.52,42.48) -> Sanctum of Domination (map 2001 33.90,52.01) via floor
    {
        fromPointID = 1000356,
        fromMap = 2002,
        fromX = 0.4352,
        fromY = 0.4248,
        toPointID = 1000354,
        toMap = 2001,
        toX = 0.339,
        toY = 0.5201,
        type = "floor",
    },

    -- Zone: Sanguine Depths (map 1675)
    -- Sanguine Depths (map 1675 40.60,89.49) -> Sanguine Depths (map 1676 50.86,77.79) via floor
    {
        fromPointID = 1000199,
        fromMap = 1675,
        fromX = 0.406,
        fromY = 0.8949,
        toPointID = 1000200,
        toMap = 1676,
        toX = 0.5086,
        toY = 0.7779,
        type = "floor",
    },

    -- Zone: Sanguine Depths (map 1676)
    -- Sanguine Depths (map 1676 50.86,77.79) -> Sanguine Depths (map 1675 40.60,89.49) via floor
    {
        fromPointID = 1000200,
        fromMap = 1676,
        fromX = 0.5086,
        fromY = 0.7779,
        toPointID = 1000199,
        toMap = 1675,
        toX = 0.406,
        toY = 0.8949,
        type = "floor",
    },

    -- Zone: Scarlet Halls (map 431)
    -- Scarlet Halls (map 431 55.50,13.80) -> Scarlet Halls (map 432 47.80,91.10) via floor
    {
        fromPointID = 200604,
        fromMap = 431,
        fromX = 0.555,
        fromY = 0.138,
        toPointID = 200605,
        toMap = 432,
        toX = 0.478,
        toY = 0.911,
        type = "floor",
    },

    -- Zone: Scarlet Halls (map 432)
    -- Scarlet Halls (map 432 47.80,91.10) -> Scarlet Halls (map 431 55.50,13.80) via floor
    {
        fromPointID = 200605,
        fromMap = 432,
        fromX = 0.478,
        fromY = 0.911,
        toPointID = 200604,
        toMap = 431,
        toX = 0.555,
        toY = 0.138,
        type = "floor",
    },

    -- Zone: Scarlet Monastery Entrance (map 19)
    -- Tirisfal Glades (map 19 14.50,73.10) -> Tirisfal Glades (map 18 82.30,32.60) via floor
    {
        fromPointID = 200057,
        fromMap = 19,
        fromX = 0.145,
        fromY = 0.731,
        toPointID = 200054,
        toMap = 18,
        toX = 0.823,
        toY = 0.326,
        type = "floor",
    },
    -- Tirisfal Glades (map 19 17.30,82.90) -> Tirisfal Glades (map 18 82.60,33.50) via floor
    {
        fromPointID = 200058,
        fromMap = 19,
        fromX = 0.173,
        fromY = 0.829,
        toPointID = 200055,
        toMap = 18,
        toX = 0.826,
        toY = 0.335,
        type = "floor",
    },

    -- Zone: Scarlet Monastery (map 302)
    -- Scarlet Monastery (map 302 48.40,88.50) -> Scarlet Monastery (map 303 49.10,11.20) via floor
    {
        fromPointID = 200523,
        fromMap = 302,
        fromX = 0.484,
        fromY = 0.885,
        toPointID = 200525,
        toMap = 303,
        toX = 0.491,
        toY = 0.112,
        type = "floor",
    },

    -- Zone: Scarlet Monastery (map 303)
    -- Scarlet Monastery (map 303 49.10,11.20) -> Scarlet Monastery (map 302 48.40,88.50) via floor
    {
        fromPointID = 200525,
        fromMap = 303,
        fromX = 0.491,
        fromY = 0.112,
        toPointID = 200523,
        toMap = 302,
        toX = 0.484,
        toY = 0.885,
        type = "floor",
    },

    -- Zone: Scholomance (map 476)
    -- Scholomance (map 476 81.80,23.90) -> Scholomance (map 477 76.00,26.50) via floor
    {
        fromPointID = 200617,
        fromMap = 476,
        fromX = 0.818,
        fromY = 0.239,
        toPointID = 200619,
        toMap = 477,
        toX = 0.76,
        toY = 0.265,
        type = "floor",
    },

    -- Zone: Scholomance (map 477)
    -- Scholomance (map 477 57.50,92.20) -> Scholomance (map 478 49.70,19.20) via floor
    {
        fromPointID = 200618,
        fromMap = 477,
        fromX = 0.575,
        fromY = 0.922,
        toPointID = 200620,
        toMap = 478,
        toX = 0.497,
        toY = 0.192,
        type = "floor",
    },
    -- Scholomance (map 477 76.00,26.50) -> Scholomance (map 476 81.80,23.90) via floor
    {
        fromPointID = 200619,
        fromMap = 477,
        fromX = 0.76,
        fromY = 0.265,
        toPointID = 200617,
        toMap = 476,
        toX = 0.818,
        toY = 0.239,
        type = "floor",
    },

    -- Zone: Scholomance (map 478)
    -- Scholomance (map 478 49.70,19.20) -> Scholomance (map 477 57.50,92.20) via floor
    {
        fromPointID = 200620,
        fromMap = 478,
        fromX = 0.497,
        fromY = 0.192,
        toPointID = 200618,
        toMap = 477,
        toX = 0.575,
        toY = 0.922,
        type = "floor",
    },
    -- Scholomance (map 478 49.80,24.00) -> Scholomance (map 479 49.60,28.20) via floor
    {
        fromPointID = 200621,
        fromMap = 478,
        fromX = 0.498,
        fromY = 0.24,
        toPointID = 200622,
        toMap = 479,
        toX = 0.496,
        toY = 0.282,
        type = "floor",
    },

    -- Zone: Scholomance (map 479)
    -- Scholomance (map 479 49.60,28.20) -> Scholomance (map 478 49.80,24.00) via floor
    {
        fromPointID = 200622,
        fromMap = 479,
        fromX = 0.496,
        fromY = 0.282,
        toPointID = 200621,
        toMap = 478,
        toX = 0.498,
        toY = 0.24,
        type = "floor",
    },

    -- Zone: Seat of the Primus (map 1698)
    -- Seat of the Primus (map 1698 49.68,13.66) -> Maldraxxus (map 1536 50.39,68.04) via floor
    {
        fromPointID = 1000225,
        fromMap = 1698,
        fromX = 0.4968,
        fromY = 0.1366,
        toPointID = 1000073,
        toMap = 1536,
        toX = 0.5039,
        toY = 0.6804,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2047)
    -- Sepulcher of the First Ones (map 2047 90.61,54.86) -> Sepulcher of the First Ones (map 2061 14.65,34.43) via floor
    {
        fromPointID = 1000366,
        fromMap = 2047,
        fromX = 0.9061,
        fromY = 0.5486,
        toPointID = 1000377,
        toMap = 2061,
        toX = 0.1465,
        toY = 0.3443,
        type = "floor",
    },
    -- Sepulcher of the First Ones (map 2047 90.72,49.67) -> Sepulcher of the First Ones (map 2048 66.96,21.00) via floor
    {
        fromPointID = 1000367,
        fromMap = 2047,
        fromX = 0.9072,
        fromY = 0.4967,
        toPointID = 1000369,
        toMap = 2048,
        toX = 0.6696,
        toY = 0.21,
        type = "floor",
    },
    -- Sepulcher of the First Ones (map 2047 92.52,51.98) -> Sepulcher of the First Ones (map 2050 10.94,52.02) via floor
    {
        fromPointID = 1000368,
        fromMap = 2047,
        fromX = 0.9252,
        fromY = 0.5198,
        toPointID = 1000372,
        toMap = 2050,
        toX = 0.1094,
        toY = 0.5202,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2048)
    -- Sepulcher of the First Ones (map 2048 66.96,21.00) -> Sepulcher of the First Ones (map 2047 90.72,49.67) via floor
    {
        fromPointID = 1000369,
        fromMap = 2048,
        fromX = 0.6696,
        fromY = 0.21,
        toPointID = 1000367,
        toMap = 2047,
        toX = 0.9072,
        toY = 0.4967,
        type = "floor",
    },
    -- Sepulcher of the First Ones (map 2048 67.00,20.97) -> Sepulcher of the First Ones (map 2049 24.27,82.35) via floor
    {
        fromPointID = 1000370,
        fromMap = 2048,
        fromX = 0.67,
        fromY = 0.2097,
        toPointID = 1000371,
        toMap = 2049,
        toX = 0.2427,
        toY = 0.8235,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2049)
    -- Sepulcher of the First Ones (map 2049 24.27,82.35) -> Sepulcher of the First Ones (map 2048 67.00,20.97) via floor
    {
        fromPointID = 1000371,
        fromMap = 2049,
        fromX = 0.2427,
        fromY = 0.8235,
        toPointID = 1000370,
        toMap = 2048,
        toX = 0.67,
        toY = 0.2097,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2050)
    -- Sepulcher of the First Ones (map 2050 10.94,52.02) -> Sepulcher of the First Ones (map 2047 92.52,51.98) via floor
    {
        fromPointID = 1000372,
        fromMap = 2050,
        fromX = 0.1094,
        fromY = 0.5202,
        toPointID = 1000368,
        toMap = 2047,
        toX = 0.9252,
        toY = 0.5198,
        type = "floor",
    },
    -- Sepulcher of the First Ones (map 2050 87.49,52.36) -> Sepulcher of the First Ones (map 2052 63.12,52.01) via floor
    {
        fromPointID = 1000373,
        fromMap = 2050,
        fromX = 0.8749,
        fromY = 0.5236,
        toPointID = 1000376,
        toMap = 2052,
        toX = 0.6312,
        toY = 0.5201,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2051)
    -- Sepulcher of the First Ones (map 2051 43.52,42.48) -> Sepulcher of the First Ones (map 2052 33.90,52.01) via floor
    {
        fromPointID = 1000374,
        fromMap = 2051,
        fromX = 0.4352,
        fromY = 0.4248,
        toPointID = 1000375,
        toMap = 2052,
        toX = 0.339,
        toY = 0.5201,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2052)
    -- Sepulcher of the First Ones (map 2052 33.90,52.01) -> Sepulcher of the First Ones (map 2051 43.52,42.48) via floor
    {
        fromPointID = 1000375,
        fromMap = 2052,
        fromX = 0.339,
        fromY = 0.5201,
        toPointID = 1000374,
        toMap = 2051,
        toX = 0.4352,
        toY = 0.4248,
        type = "floor",
    },
    -- Sepulcher of the First Ones (map 2052 63.12,52.01) -> Sepulcher of the First Ones (map 2050 87.49,52.36) via floor
    {
        fromPointID = 1000376,
        fromMap = 2052,
        fromX = 0.6312,
        fromY = 0.5201,
        toPointID = 1000373,
        toMap = 2050,
        toX = 0.8749,
        toY = 0.5236,
        type = "floor",
    },

    -- Zone: Sepulcher of the First Ones (map 2061)
    -- Sepulcher of the First Ones (map 2061 14.65,34.43) -> Sepulcher of the First Ones (map 2047 90.61,54.86) via floor
    {
        fromPointID = 1000377,
        fromMap = 2061,
        fromX = 0.1465,
        fromY = 0.3443,
        toPointID = 1000366,
        toMap = 2047,
        toX = 0.9061,
        toY = 0.5486,
        type = "floor",
    },

    -- Zone: Sethekk Halls (map 258)
    -- Sethekk Halls (map 258 48.71,95.13) -> Sethekk Halls (map 259 53.33,94.35) via floor
    {
        fromPointID = 300114,
        fromMap = 258,
        fromX = 0.4871,
        fromY = 0.9513,
        toPointID = 300118,
        toMap = 259,
        toX = 0.5333,
        toY = 0.9435,
        type = "floor",
    },

    -- Zone: Sethekk Halls (map 259)
    -- Sethekk Halls (map 259 44.61,27.42) -> Sethekk Halls (map 258 51.57,27.55) via floor
    {
        fromPointID = 300117,
        fromMap = 259,
        fromX = 0.4461,
        fromY = 0.2742,
        toPointID = 300115,
        toMap = 258,
        toX = 0.5157,
        toY = 0.2755,
        type = "floor",
    },
    -- Sethekk Halls (map 259 53.33,94.35) -> Sethekk Halls (map 258 48.71,95.13) via floor
    {
        fromPointID = 300118,
        fromMap = 259,
        fromX = 0.5333,
        fromY = 0.9435,
        toPointID = 300114,
        toMap = 258,
        toX = 0.4871,
        toY = 0.9513,
        type = "floor",
    },

    -- Zone: Shado-Pan Monastery (map 443)
    -- Shado-Pan Monastery (map 443 22.10,69.10) -> Shado-Pan Monastery (map 445 12.30,19.20) via floor
    {
        fromPointID = 500169,
        fromMap = 443,
        fromX = 0.221,
        fromY = 0.691,
        toPointID = 500176,
        toMap = 445,
        toX = 0.123,
        toY = 0.192,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 443 30.70,35.00) -> Shado-Pan Monastery (map 446 17.00,72.60) via floor
    {
        fromPointID = 500170,
        fromMap = 443,
        fromX = 0.307,
        fromY = 0.35,
        toPointID = 500178,
        toMap = 446,
        toX = 0.17,
        toY = 0.726,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 443 36.50,81.80) -> Shado-Pan Monastery (map 445 76.90,81.40) via floor
    {
        fromPointID = 500171,
        fromMap = 443,
        fromX = 0.365,
        fromY = 0.818,
        toPointID = 500177,
        toMap = 445,
        toX = 0.769,
        toY = 0.814,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 443 44.70,40.10) -> Shado-Pan Monastery (map 446 51.30,83.90) via floor
    {
        fromPointID = 500172,
        fromMap = 443,
        fromX = 0.447,
        fromY = 0.401,
        toPointID = 500179,
        toMap = 446,
        toX = 0.513,
        toY = 0.839,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 443 56.00,88.00) -> Shado-Pan Monastery (map 444 21.00,85.60) via floor
    {
        fromPointID = 500173,
        fromMap = 443,
        fromX = 0.56,
        fromY = 0.88,
        toPointID = 500175,
        toMap = 444,
        toX = 0.21,
        toY = 0.856,
        type = "floor",
    },

    -- Zone: Shado-Pan Monastery (map 444)
    -- Shado-Pan Monastery (map 444 21.00,85.60) -> Shado-Pan Monastery (map 443 56.00,88.00) via floor
    {
        fromPointID = 500175,
        fromMap = 444,
        fromX = 0.21,
        fromY = 0.856,
        toPointID = 500173,
        toMap = 443,
        toX = 0.56,
        toY = 0.88,
        type = "floor",
    },

    -- Zone: Shado-Pan Monastery (map 445)
    -- Shado-Pan Monastery (map 445 12.30,19.20) -> Shado-Pan Monastery (map 443 22.10,69.10) via floor
    {
        fromPointID = 500176,
        fromMap = 445,
        fromX = 0.123,
        fromY = 0.192,
        toPointID = 500169,
        toMap = 443,
        toX = 0.221,
        toY = 0.691,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 445 76.90,81.40) -> Shado-Pan Monastery (map 443 36.50,81.80) via floor
    {
        fromPointID = 500177,
        fromMap = 445,
        fromX = 0.769,
        fromY = 0.814,
        toPointID = 500171,
        toMap = 443,
        toX = 0.365,
        toY = 0.818,
        type = "floor",
    },

    -- Zone: Shado-Pan Monastery (map 446)
    -- Shado-Pan Monastery (map 446 17.00,72.60) -> Shado-Pan Monastery (map 443 30.70,35.00) via floor
    {
        fromPointID = 500178,
        fromMap = 446,
        fromX = 0.17,
        fromY = 0.726,
        toPointID = 500170,
        toMap = 443,
        toX = 0.307,
        toY = 0.35,
        type = "floor",
    },
    -- Shado-Pan Monastery (map 446 51.30,83.90) -> Shado-Pan Monastery (map 443 44.70,40.10) via floor
    {
        fromPointID = 500179,
        fromMap = 446,
        fromX = 0.513,
        fromY = 0.839,
        toPointID = 500172,
        toMap = 443,
        toX = 0.447,
        toY = 0.401,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 310)
    -- Shadowfang Keep (map 310 14.78,88.35) -> Shadowfang Keep (map 311 27.49,87.84) via floor
    {
        fromPointID = 200527,
        fromMap = 310,
        fromX = 0.1478,
        fromY = 0.8835,
        toPointID = 200530,
        toMap = 311,
        toX = 0.2749,
        toY = 0.8784,
        type = "floor",
    },
    -- Shadowfang Keep (map 310 34.01,70.58) -> Shadowfang Keep (map 316 23.69,75.12) via floor
    {
        fromPointID = 200528,
        fromMap = 310,
        fromX = 0.3401,
        fromY = 0.7058,
        toPointID = 200542,
        toMap = 316,
        toX = 0.2369,
        toY = 0.7512,
        type = "floor",
    },
    -- Shadowfang Keep (map 310 38.18,39.14) -> Shadowfang Keep (map 311 60.03,13.01) via floor
    {
        fromPointID = 200529,
        fromMap = 310,
        fromX = 0.3818,
        fromY = 0.3914,
        toPointID = 200531,
        toMap = 311,
        toX = 0.6003,
        toY = 0.1301,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 311)
    -- Shadowfang Keep (map 311 27.49,87.84) -> Shadowfang Keep (map 310 14.78,88.35) via floor
    {
        fromPointID = 200530,
        fromMap = 311,
        fromX = 0.2749,
        fromY = 0.8784,
        toPointID = 200527,
        toMap = 310,
        toX = 0.1478,
        toY = 0.8835,
        type = "floor",
    },
    -- Shadowfang Keep (map 311 60.03,13.01) -> Shadowfang Keep (map 310 38.18,39.14) via floor
    {
        fromPointID = 200531,
        fromMap = 311,
        fromX = 0.6003,
        fromY = 0.1301,
        toPointID = 200529,
        toMap = 310,
        toX = 0.3818,
        toY = 0.3914,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 312)
    -- Shadowfang Keep (map 312 45.86,92.67) -> Shadowfang Keep (map 313 48.93,77.89) via floor
    {
        fromPointID = 200533,
        fromMap = 312,
        fromX = 0.4586,
        fromY = 0.9267,
        toPointID = 200536,
        toMap = 313,
        toX = 0.4893,
        toY = 0.7789,
        type = "floor",
    },
    -- Shadowfang Keep (map 312 60.72,31.88) -> Shadowfang Keep (map 316 47.37,19.47) via floor
    {
        fromPointID = 200534,
        fromMap = 312,
        fromX = 0.6072,
        fromY = 0.3188,
        toPointID = 200544,
        toMap = 316,
        toX = 0.4737,
        toY = 0.1947,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 313)
    -- Shadowfang Keep (map 313 34.60,55.37) -> Shadowfang Keep (map 314 48.94,77.32) via floor
    {
        fromPointID = 200535,
        fromMap = 313,
        fromX = 0.346,
        fromY = 0.5537,
        toPointID = 200539,
        toMap = 314,
        toX = 0.4894,
        toY = 0.7732,
        type = "floor",
    },
    -- Shadowfang Keep (map 313 48.93,77.89) -> Shadowfang Keep (map 312 45.86,92.67) via floor
    {
        fromPointID = 200536,
        fromMap = 313,
        fromX = 0.4893,
        fromY = 0.7789,
        toPointID = 200533,
        toMap = 312,
        toX = 0.4586,
        toY = 0.9267,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 314)
    -- Shadowfang Keep (map 314 34.62,57.88) -> Shadowfang Keep (map 315 48.75,90.71) via floor
    {
        fromPointID = 200538,
        fromMap = 314,
        fromX = 0.3462,
        fromY = 0.5788,
        toPointID = 200541,
        toMap = 315,
        toX = 0.4875,
        toY = 0.9071,
        type = "floor",
    },
    -- Shadowfang Keep (map 314 48.94,77.32) -> Shadowfang Keep (map 313 34.60,55.37) via floor
    {
        fromPointID = 200539,
        fromMap = 314,
        fromX = 0.4894,
        fromY = 0.7732,
        toPointID = 200535,
        toMap = 313,
        toX = 0.346,
        toY = 0.5537,
        type = "floor",
    },
    -- Shadowfang Keep (map 314 56.86,44.93) -> Shadowfang Keep (map 313 54.68,54.74) via floor
    {
        fromPointID = 200540,
        fromMap = 314,
        fromX = 0.5686,
        fromY = 0.4493,
        toPointID = 200537,
        toMap = 313,
        toX = 0.5468,
        toY = 0.5474,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 315)
    -- Shadowfang Keep (map 315 48.75,90.71) -> Shadowfang Keep (map 314 34.62,57.88) via floor
    {
        fromPointID = 200541,
        fromMap = 315,
        fromX = 0.4875,
        fromY = 0.9071,
        toPointID = 200538,
        toMap = 314,
        toX = 0.3462,
        toY = 0.5788,
        type = "floor",
    },

    -- Zone: Shadowfang Keep (map 316)
    -- Shadowfang Keep (map 316 23.69,75.12) -> Shadowfang Keep (map 310 34.01,70.58) via floor
    {
        fromPointID = 200542,
        fromMap = 316,
        fromX = 0.2369,
        fromY = 0.7512,
        toPointID = 200528,
        toMap = 310,
        toX = 0.3401,
        toY = 0.7058,
        type = "floor",
    },
    -- Shadowfang Keep (map 316 45.49,25.23) -> Shadowfang Keep (map 312 44.44,61.70) via floor
    {
        fromPointID = 200543,
        fromMap = 316,
        fromX = 0.4549,
        fromY = 0.2523,
        toPointID = 200532,
        toMap = 312,
        toX = 0.4444,
        toY = 0.617,
        type = "floor",
    },

    -- Zone: Shadowglen (map 460)
    -- Shadowglen (map 460 39.30,30.40) -> Teldrassil (map 58 45.40,90.30) via floor
    {
        fromPointID = 100436,
        fromMap = 460,
        fromX = 0.393,
        fromY = 0.304,
        toPointID = 100073,
        toMap = 58,
        toX = 0.454,
        toY = 0.903,
        type = "floor",
    },

    -- Zone: Shadowthread Cave (map 58)
    -- Teldrassil (map 58 45.40,90.30) -> Shadowglen (map 460 39.30,30.40) via floor
    {
        fromPointID = 100073,
        fromMap = 58,
        fromX = 0.454,
        fromY = 0.903,
        toPointID = 100436,
        toMap = 460,
        toX = 0.393,
        toY = 0.304,
        type = "floor",
    },

    -- Zone: Sidestreet Sluice (map 2420)
    -- Sidestreet Sluice (map 2420 34.07,21.28) -> Sidestreet Sluice (map 2421 46.85,20.85) via floor
    {
        fromPointID = 1200184,
        fromMap = 2420,
        fromX = 0.3407,
        fromY = 0.2128,
        toPointID = 1200189,
        toMap = 2421,
        toX = 0.4685,
        toY = 0.2085,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2420 44.22,41.58) -> Sidestreet Sluice (map 2423 50.95,45.55) via floor
    {
        fromPointID = 1200185,
        fromMap = 2420,
        fromX = 0.4422,
        fromY = 0.4158,
        toPointID = 1200194,
        toMap = 2423,
        toX = 0.5095,
        toY = 0.4555,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2420 71.62,18.47) -> Sidestreet Sluice (map 2421 71.72,30.62) via floor
    {
        fromPointID = 1200187,
        fromMap = 2420,
        fromX = 0.7162,
        fromY = 0.1847,
        toPointID = 1200191,
        toMap = 2421,
        toX = 0.7172,
        toY = 0.3062,
        type = "floor",
    },

    -- Zone: Sidestreet Sluice (map 2421)
    -- Sidestreet Sluice (map 2421 38.90,70.51) -> Sidestreet Sluice (map 2422 27.91,70.05) via floor
    {
        fromPointID = 1200188,
        fromMap = 2421,
        fromX = 0.389,
        fromY = 0.7051,
        toPointID = 1200192,
        toMap = 2422,
        toX = 0.2791,
        toY = 0.7005,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2421 46.85,20.85) -> Sidestreet Sluice (map 2420 34.07,21.28) via floor
    {
        fromPointID = 1200189,
        fromMap = 2421,
        fromX = 0.4685,
        fromY = 0.2085,
        toPointID = 1200184,
        toMap = 2420,
        toX = 0.3407,
        toY = 0.2128,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2421 71.05,18.06) -> Sidestreet Sluice (map 2422 70.95,28.86) via floor
    {
        fromPointID = 1200190,
        fromMap = 2421,
        fromX = 0.7105,
        fromY = 0.1806,
        toPointID = 1200193,
        toMap = 2422,
        toX = 0.7095,
        toY = 0.2886,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2421 71.72,30.62) -> Sidestreet Sluice (map 2420 71.62,18.47) via floor
    {
        fromPointID = 1200191,
        fromMap = 2421,
        fromX = 0.7172,
        fromY = 0.3062,
        toPointID = 1200187,
        toMap = 2420,
        toX = 0.7162,
        toY = 0.1847,
        type = "floor",
    },

    -- Zone: Sidestreet Sluice (map 2422)
    -- Sidestreet Sluice (map 2422 27.91,70.05) -> Sidestreet Sluice (map 2421 38.90,70.51) via floor
    {
        fromPointID = 1200192,
        fromMap = 2422,
        fromX = 0.2791,
        fromY = 0.7005,
        toPointID = 1200188,
        toMap = 2421,
        toX = 0.389,
        toY = 0.7051,
        type = "floor",
    },
    -- Sidestreet Sluice (map 2422 70.95,28.86) -> Sidestreet Sluice (map 2421 71.05,18.06) via floor
    {
        fromPointID = 1200193,
        fromMap = 2422,
        fromX = 0.7095,
        fromY = 0.2886,
        toPointID = 1200190,
        toMap = 2421,
        toX = 0.7105,
        toY = 0.1806,
        type = "floor",
    },

    -- Zone: Sidestreet Sluice (map 2423)
    -- Sidestreet Sluice (map 2423 50.95,45.55) -> Sidestreet Sluice (map 2420 44.22,41.58) via floor
    {
        fromPointID = 1200194,
        fromMap = 2423,
        fromX = 0.5095,
        fromY = 0.4555,
        toPointID = 1200185,
        toMap = 2420,
        toX = 0.4422,
        toY = 0.4158,
        type = "floor",
    },

    -- Zone: Siege of Niuzao Temple (map 457)
    -- Siege of Niuzao Temple (map 457 50.30,73.90) -> Siege of Niuzao Temple (map 459 21.60,53.60) via floor
    {
        fromPointID = 500186,
        fromMap = 457,
        fromX = 0.503,
        fromY = 0.739,
        toPointID = 500189,
        toMap = 459,
        toX = 0.216,
        toY = 0.536,
        type = "floor",
    },

    -- Zone: Siege of Niuzao Temple (map 458)
    -- Siege of Niuzao Temple (map 458 53.20,81.90) -> Siege of Niuzao Temple (map 459 57.10,80.70) via floor
    {
        fromPointID = 500187,
        fromMap = 458,
        fromX = 0.532,
        fromY = 0.819,
        toPointID = 500190,
        toMap = 459,
        toX = 0.571,
        toY = 0.807,
        type = "floor",
    },

    -- Zone: Siege of Niuzao Temple (map 459)
    -- Siege of Niuzao Temple (map 459 21.60,53.60) -> Siege of Niuzao Temple (map 457 50.30,73.90) via floor
    {
        fromPointID = 500189,
        fromMap = 459,
        fromX = 0.216,
        fromY = 0.536,
        toPointID = 500186,
        toMap = 457,
        toX = 0.503,
        toY = 0.739,
        type = "floor",
    },
    -- Siege of Niuzao Temple (map 459 57.10,80.70) -> Siege of Niuzao Temple (map 458 53.20,81.90) via floor
    {
        fromPointID = 500190,
        fromMap = 459,
        fromX = 0.571,
        fromY = 0.807,
        toPointID = 500187,
        toMap = 458,
        toX = 0.532,
        toY = 0.819,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 557)
    -- Siege of Orgrimmar (map 557 26.40,9.80) -> Siege of Orgrimmar (map 558 11.70,71.90) via floor
    {
        fromPointID = 500265,
        fromMap = 557,
        fromX = 0.264,
        fromY = 0.098,
        toPointID = 500269,
        toMap = 558,
        toX = 0.117,
        toY = 0.719,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 557 28.50,9.70) -> Siege of Orgrimmar (map 558 11.70,71.80) via floor
    {
        fromPointID = 500266,
        fromMap = 557,
        fromX = 0.285,
        fromY = 0.097,
        toPointID = 500268,
        toMap = 558,
        toX = 0.117,
        toY = 0.718,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 557 44.70,69.20) -> Siege of Orgrimmar (map 559 64.60,12.70) via floor
    {
        fromPointID = 500267,
        fromMap = 557,
        fromX = 0.447,
        fromY = 0.692,
        toPointID = 500270,
        toMap = 559,
        toX = 0.646,
        toY = 0.127,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 558)
    -- Siege of Orgrimmar (map 558 11.70,71.80) -> Siege of Orgrimmar (map 557 28.50,9.70) via floor
    {
        fromPointID = 500268,
        fromMap = 558,
        fromX = 0.117,
        fromY = 0.718,
        toPointID = 500266,
        toMap = 557,
        toX = 0.285,
        toY = 0.097,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 558 11.70,71.90) -> Siege of Orgrimmar (map 557 26.40,9.80) via floor
    {
        fromPointID = 500269,
        fromMap = 558,
        fromX = 0.117,
        fromY = 0.719,
        toPointID = 500265,
        toMap = 557,
        toX = 0.264,
        toY = 0.098,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 559)
    -- Siege of Orgrimmar (map 559 64.60,12.70) -> Siege of Orgrimmar (map 557 44.70,69.20) via floor
    {
        fromPointID = 500270,
        fromMap = 559,
        fromX = 0.646,
        fromY = 0.127,
        toPointID = 500267,
        toMap = 557,
        toX = 0.447,
        toY = 0.692,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 560)
    -- Siege of Orgrimmar (map 560 34.80,21.60) -> Siege of Orgrimmar (map 561 51.70,76.90) via floor
    {
        fromPointID = 500271,
        fromMap = 560,
        fromX = 0.348,
        fromY = 0.216,
        toPointID = 500272,
        toMap = 561,
        toX = 0.517,
        toY = 0.769,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 561)
    -- Siege of Orgrimmar (map 561 51.70,76.90) -> Siege of Orgrimmar (map 560 34.80,21.60) via floor
    {
        fromPointID = 500272,
        fromMap = 561,
        fromX = 0.517,
        fromY = 0.769,
        toPointID = 500271,
        toMap = 560,
        toX = 0.348,
        toY = 0.216,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 561 56.30,29.10) -> Siege of Orgrimmar (map 562 80.70,16.30) via floor
    {
        fromPointID = 500273,
        fromMap = 561,
        fromX = 0.563,
        fromY = 0.291,
        toPointID = 500275,
        toMap = 562,
        toX = 0.807,
        toY = 0.163,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 562)
    -- Siege of Orgrimmar (map 562 67.90,50.10) -> Siege of Orgrimmar (map 563 31.10,20.30) via floor
    {
        fromPointID = 500274,
        fromMap = 562,
        fromX = 0.679,
        fromY = 0.501,
        toPointID = 500276,
        toMap = 563,
        toX = 0.311,
        toY = 0.203,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 562 80.70,16.30) -> Siege of Orgrimmar (map 561 56.30,29.10) via floor
    {
        fromPointID = 500275,
        fromMap = 562,
        fromX = 0.807,
        fromY = 0.163,
        toPointID = 500273,
        toMap = 561,
        toX = 0.563,
        toY = 0.291,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 563)
    -- Siege of Orgrimmar (map 563 31.10,20.30) -> Siege of Orgrimmar (map 562 67.90,50.10) via floor
    {
        fromPointID = 500276,
        fromMap = 563,
        fromX = 0.311,
        fromY = 0.203,
        toPointID = 500274,
        toMap = 562,
        toX = 0.679,
        toY = 0.501,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 564)
    -- Siege of Orgrimmar (map 564 78.60,73.60) -> Siege of Orgrimmar (map 565 64.00,17.80) via floor
    {
        fromPointID = 500277,
        fromMap = 564,
        fromX = 0.786,
        fromY = 0.736,
        toPointID = 500280,
        toMap = 565,
        toX = 0.64,
        toY = 0.178,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 564 87.70,76.40) -> Siege of Orgrimmar (map 567 32.00,14.80) via floor
    {
        fromPointID = 500278,
        fromMap = 564,
        fromX = 0.877,
        fromY = 0.764,
        toPointID = 500282,
        toMap = 567,
        toX = 0.32,
        toY = 0.148,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 564 89.40,62.30) -> Siege of Orgrimmar (map 566 23.70,82.30) via floor
    {
        fromPointID = 500279,
        fromMap = 564,
        fromX = 0.894,
        fromY = 0.623,
        toPointID = 500281,
        toMap = 566,
        toX = 0.237,
        toY = 0.823,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 565)
    -- Siege of Orgrimmar (map 565 64.00,17.80) -> Siege of Orgrimmar (map 564 78.60,73.60) via floor
    {
        fromPointID = 500280,
        fromMap = 565,
        fromX = 0.64,
        fromY = 0.178,
        toPointID = 500277,
        toMap = 564,
        toX = 0.786,
        toY = 0.736,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 566)
    -- Siege of Orgrimmar (map 566 23.70,82.30) -> Siege of Orgrimmar (map 564 89.40,62.30) via floor
    {
        fromPointID = 500281,
        fromMap = 566,
        fromX = 0.237,
        fromY = 0.823,
        toPointID = 500279,
        toMap = 564,
        toX = 0.894,
        toY = 0.623,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 567)
    -- Siege of Orgrimmar (map 567 32.00,14.80) -> Siege of Orgrimmar (map 564 87.70,76.40) via floor
    {
        fromPointID = 500282,
        fromMap = 567,
        fromX = 0.32,
        fromY = 0.148,
        toPointID = 500278,
        toMap = 564,
        toX = 0.877,
        toY = 0.764,
        type = "floor",
    },
    -- Siege of Orgrimmar (map 567 65.20,91.50) -> Siege of Orgrimmar (map 568 53.70,13.50) via floor
    {
        fromPointID = 500283,
        fromMap = 567,
        fromX = 0.652,
        fromY = 0.915,
        toPointID = 500284,
        toMap = 568,
        toX = 0.537,
        toY = 0.135,
        type = "floor",
    },

    -- Zone: Siege of Orgrimmar (map 568)
    -- Siege of Orgrimmar (map 568 53.70,13.50) -> Siege of Orgrimmar (map 567 65.20,91.50) via floor
    {
        fromPointID = 500284,
        fromMap = 568,
        fromX = 0.537,
        fromY = 0.135,
        toPointID = 500283,
        toMap = 567,
        toX = 0.652,
        toY = 0.915,
        type = "floor",
    },

    -- Zone: Sightless Hold (map 1650)
    -- Sightless Hold (map 1650 42.06,82.99) -> Maldraxxus (map 1536 54.08,12.25) via floor
    {
        fromPointID = 1000151,
        fromMap = 1650,
        fromX = 0.4206,
        fromY = 0.8299,
        toPointID = 1000080,
        toMap = 1536,
        toX = 0.5408,
        toY = 0.1225,
        type = "floor",
    },

    -- Zone: Silithus (map 81)
    -- Silithus (map 81 70.40,15.90) -> Silithus (map 82 15.10,70.00) via floor
    {
        fromPointID = 100245,
        fromMap = 81,
        fromX = 0.704,
        fromY = 0.159,
        toPointID = 100248,
        toMap = 82,
        toX = 0.151,
        toY = 0.7,
        type = "floor",
    },

    -- Zone: Skull Rock (map 5)
    -- Durotar (map 5 84.13,53.61) -> Durotar (map 1 54.99,9.67) via floor
    {
        fromPointID = 100028,
        fromMap = 5,
        fromX = 0.8413,
        fromY = 0.5361,
        toPointID = 100015,
        toMap = 1,
        toX = 0.5499,
        toY = 0.0967,
        type = "floor",
    },

    -- Zone: Sor'theril Barrow Den (map 2253)
    -- Sor'theril Barrow Den (map 2253 71.46,88.04) -> The Emerald Dream (map 2200 51.09,42.75) via floor
    {
        fromPointID = 1100234,
        fromMap = 2253,
        fromX = 0.7146,
        fromY = 0.8804,
        toPointID = 1100200,
        toMap = 2200,
        toX = 0.5109,
        toY = 0.4275,
        type = "floor",
    },

    -- Zone: Spires Of Ascension (map 1692)
    -- Spires of Ascension (map 1692 72.02,18.19) -> Spires of Ascension (map 1693 36.15,62.95) via floor
    {
        fromPointID = 1000217,
        fromMap = 1692,
        fromX = 0.7202,
        fromY = 0.1819,
        toPointID = 1000219,
        toMap = 1693,
        toX = 0.3615,
        toY = 0.6295,
        type = "floor",
    },

    -- Zone: Spires Of Ascension (map 1693)
    -- Spires of Ascension (map 1693 36.15,62.95) -> Spires of Ascension (map 1692 72.02,18.19) via floor
    {
        fromPointID = 1000219,
        fromMap = 1693,
        fromX = 0.3615,
        fromY = 0.6295,
        toPointID = 1000217,
        toMap = 1692,
        toX = 0.7202,
        toY = 0.1819,
        type = "floor",
    },
    -- Spires of Ascension (map 1693 69.27,41.25) -> Spires of Ascension (map 1694 37.59,80.06) via floor
    {
        fromPointID = 1000220,
        fromMap = 1693,
        fromX = 0.6927,
        fromY = 0.4125,
        toPointID = 1000221,
        toMap = 1694,
        toX = 0.3759,
        toY = 0.8006,
        type = "floor",
    },

    -- Zone: Spires Of Ascension (map 1694)
    -- Spires of Ascension (map 1694 37.59,80.06) -> Spires of Ascension (map 1693 69.27,41.25) via floor
    {
        fromPointID = 1000221,
        fromMap = 1694,
        fromX = 0.3759,
        fromY = 0.8006,
        toPointID = 1000220,
        toMap = 1693,
        toX = 0.6927,
        toY = 0.4125,
        type = "floor",
    },
    -- Spires of Ascension (map 1694 50.74,45.09) -> Spires of Ascension (map 1695 42.97,69.58) via floor
    {
        fromPointID = 1000222,
        fromMap = 1694,
        fromX = 0.5074,
        fromY = 0.4509,
        toPointID = 1000223,
        toMap = 1695,
        toX = 0.4297,
        toY = 0.6958,
        type = "floor",
    },

    -- Zone: Spires Of Ascension (map 1695)
    -- Spires of Ascension (map 1695 42.97,69.58) -> Spires of Ascension (map 1694 50.74,45.09) via floor
    {
        fromPointID = 1000223,
        fromMap = 1695,
        fromX = 0.4297,
        fromY = 0.6958,
        toPointID = 1000222,
        toMap = 1694,
        toX = 0.5074,
        toY = 0.4509,
        type = "floor",
    },

    -- Zone: Spitescale Cavern (map 464)
    -- Echo Isles (map 464 54.16,80.12) -> Echo Isles (map 463 59.11,22.33) via floor
    {
        fromPointID = 100447,
        fromMap = 464,
        fromX = 0.5416,
        fromY = 0.8012,
        toPointID = 100444,
        toMap = 463,
        toX = 0.5911,
        toY = 0.2233,
        type = "floor",
    },

    -- Zone: Spoke of Endless Winter (map 2193)
    -- Dawn of the Infinite (map 2193 21.81,36.30) -> Dawn of the Infinite (map 2192 75.13,64.74) via floor
    {
        fromPointID = 1100186,
        fromMap = 2193,
        fromX = 0.2181,
        fromY = 0.363,
        toPointID = 1100185,
        toMap = 2192,
        toX = 0.7513,
        toY = 0.6474,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2193 79.08,56.38) -> Dawn of the Infinite (map 2194 32.09,13.27) via floor
    {
        fromPointID = 1100187,
        fromMap = 2193,
        fromX = 0.7908,
        fromY = 0.5638,
        toPointID = 1100188,
        toMap = 2194,
        toX = 0.3209,
        toY = 0.1327,
        type = "floor",
    },

    -- Zone: Stillpine Hold (map 99)
    -- Azuremyst Isle (map 99 21.11,91.45) -> Azuremyst Isle (map 97 45.34,19.54) via floor
    {
        fromPointID = 100311,
        fromMap = 99,
        fromX = 0.2111,
        fromY = 0.9145,
        toPointID = 100308,
        toMap = 97,
        toX = 0.4534,
        toY = 0.1954,
        type = "floor",
    },

    -- Zone: Stormheim (map 634)
    -- Stormheim (map 634 62.82,68.11) -> Stormheim (map 640 26.43,51.00) via floor
    {
        fromPointID = 700077,
        fromMap = 634,
        fromX = 0.6282,
        fromY = 0.6811,
        toPointID = 700085,
        toMap = 640,
        toX = 0.2643,
        toY = 0.51,
        type = "floor",
    },

    -- Zone: Stormheim (map 865)
    -- Stormheim Invasion (map 865 40.73,43.58) -> Stormheim Invasion (map 866 44.02,34.65) via floor
    {
        fromPointID = 700295,
        fromMap = 865,
        fromX = 0.4073,
        fromY = 0.4358,
        toPointID = 700296,
        toMap = 866,
        toX = 0.4402,
        toY = 0.3465,
        type = "floor",
    },

    -- Zone: Stormheim (map 866)
    -- Stormheim Invasion (map 866 44.02,34.65) -> Stormheim Invasion (map 865 40.73,43.58) via floor
    {
        fromPointID = 700296,
        fromMap = 866,
        fromX = 0.4402,
        fromY = 0.3465,
        toPointID = 700295,
        toMap = 865,
        toX = 0.4073,
        toY = 0.4358,
        type = "floor",
    },

    -- Zone: Stormstout Brewery (map 439)
    -- Stormstout Brewery (map 439 28.10,61.10) -> Stormstout Brewery (map 440 32.80,59.20) via floor
    {
        fromPointID = 500162,
        fromMap = 439,
        fromX = 0.281,
        fromY = 0.611,
        toPointID = 500163,
        toMap = 440,
        toX = 0.328,
        toY = 0.592,
        type = "floor",
    },

    -- Zone: Stormstout Brewery (map 440)
    -- Stormstout Brewery (map 440 32.80,59.20) -> Stormstout Brewery (map 439 28.10,61.10) via floor
    {
        fromPointID = 500163,
        fromMap = 440,
        fromX = 0.328,
        fromY = 0.592,
        toPointID = 500162,
        toMap = 439,
        toX = 0.281,
        toY = 0.611,
        type = "floor",
    },
    -- Stormstout Brewery (map 440 81.50,58.50) -> Stormstout Brewery (map 441 33.80,77.90) via floor
    {
        fromPointID = 500164,
        fromMap = 440,
        fromX = 0.815,
        fromY = 0.585,
        toPointID = 500165,
        toMap = 441,
        toX = 0.338,
        toY = 0.779,
        type = "floor",
    },

    -- Zone: Stormstout Brewery (map 441)
    -- Stormstout Brewery (map 441 33.80,77.90) -> Stormstout Brewery (map 440 81.50,58.50) via floor
    {
        fromPointID = 500165,
        fromMap = 441,
        fromX = 0.338,
        fromY = 0.779,
        toPointID = 500164,
        toMap = 440,
        toX = 0.815,
        toY = 0.585,
        type = "floor",
    },
    -- Stormstout Brewery (map 441 75.50,33.50) -> Stormstout Brewery (map 442 57.60,31.10) via floor
    {
        fromPointID = 500166,
        fromMap = 441,
        fromX = 0.755,
        fromY = 0.335,
        toPointID = 500168,
        toMap = 442,
        toX = 0.576,
        toY = 0.311,
        type = "floor",
    },

    -- Zone: Stormstout Brewery (map 442)
    -- Stormstout Brewery (map 442 57.60,31.10) -> Stormstout Brewery (map 441 75.50,33.50) via floor
    {
        fromPointID = 500168,
        fromMap = 442,
        fromX = 0.576,
        fromY = 0.311,
        toPointID = 500166,
        toMap = 441,
        toX = 0.755,
        toY = 0.335,
        type = "floor",
    },

    -- Zone: Sunkiller Sanctum (map 2528)
    -- Sunkiller Sanctum (map 2528 39.50,47.06) -> Sunkiller Sanctum (map 2571 37.95,46.09) via floor
    {
        fromPointID = 200817,
        fromMap = 2528,
        fromX = 0.395,
        fromY = 0.4706,
        toPointID = 200836,
        toMap = 2571,
        toX = 0.3795,
        toY = 0.4609,
        type = "floor",
    },
    -- Sunkiller Sanctum (map 2528 43.69,18.54) -> Sunkiller Sanctum (map 2571 43.93,18.29) via floor
    {
        fromPointID = 200818,
        fromMap = 2528,
        fromX = 0.4369,
        fromY = 0.1854,
        toPointID = 200837,
        toMap = 2571,
        toX = 0.4393,
        toY = 0.1829,
        type = "floor",
    },

    -- Zone: Sunkiller Sanctum (map 2571)
    -- Sunkiller Sanctum (map 2571 37.95,46.09) -> Sunkiller Sanctum (map 2528 39.50,47.06) via floor
    {
        fromPointID = 200836,
        fromMap = 2571,
        fromX = 0.3795,
        fromY = 0.4609,
        toPointID = 200817,
        toMap = 2528,
        toX = 0.395,
        toY = 0.4706,
        type = "floor",
    },
    -- Sunkiller Sanctum (map 2571 43.93,18.29) -> Sunkiller Sanctum (map 2528 43.69,18.54) via floor
    {
        fromPointID = 200837,
        fromMap = 2571,
        fromX = 0.4393,
        fromY = 0.1829,
        toPointID = 200818,
        toMap = 2528,
        toX = 0.4369,
        toY = 0.1854,
        type = "floor",
    },

    -- Zone: Sunwell Plateau (map 335)
    -- Sunwell Plateau (map 335 67.20,27.30) -> Sunwell Plateau (map 336 52.70,14.10) via floor
    {
        fromPointID = 200556,
        fromMap = 335,
        fromX = 0.672,
        fromY = 0.273,
        toPointID = 200557,
        toMap = 336,
        toX = 0.527,
        toY = 0.141,
        type = "floor",
    },

    -- Zone: Sunwell Plateau (map 336)
    -- Sunwell Plateau (map 336 52.70,14.10) -> Sunwell Plateau (map 335 67.20,27.30) via floor
    {
        fromPointID = 200557,
        fromMap = 336,
        fromX = 0.527,
        fromY = 0.141,
        toPointID = 200556,
        toMap = 335,
        toX = 0.672,
        toY = 0.273,
        type = "floor",
    },

    -- Zone: Suramar (map 680)
    -- Suramar (map 680 54.63,46.35) -> Suramar (map 681 39.35,82.60) via floor
    {
        fromPointID = 700190,
        fromMap = 680,
        fromX = 0.5463,
        fromY = 0.4635,
        toPointID = 700206,
        toMap = 681,
        toX = 0.3935,
        toY = 0.826,
        type = "floor",
    },
    -- Suramar (map 680 59.36,43.03) -> Suramar (map 687 54.39,86.69) via floor
    {
        fromPointID = 700193,
        fromMap = 680,
        fromX = 0.5936,
        fromY = 0.4303,
        toPointID = 700212,
        toMap = 687,
        toX = 0.5439,
        toY = 0.8669,
        type = "floor",
    },
    -- Suramar (map 680 65.95,42.06) -> Suramar (map 686 56.43,86.96) via floor
    {
        fromPointID = 700200,
        fromMap = 680,
        fromX = 0.6595,
        fromY = 0.4206,
        toPointID = 700211,
        toMap = 686,
        toX = 0.5643,
        toY = 0.8696,
        type = "floor",
    },

    -- Zone: Tanaris (map 71)
    -- Tanaris (map 71 34.50,42.40) -> Tanaris (map 72 47.50,33.60) via floor
    {
        fromPointID = 100184,
        fromMap = 71,
        fromX = 0.345,
        fromY = 0.424,
        toPointID = 100196,
        toMap = 72,
        toX = 0.475,
        toY = 0.336,
        type = "floor",
    },
    -- Tanaris (map 71 34.80,41.60) -> Tanaris (map 72 50.40,25.10) via floor
    {
        fromPointID = 100185,
        fromMap = 71,
        fromX = 0.348,
        fromY = 0.416,
        toPointID = 100197,
        toMap = 72,
        toX = 0.504,
        toY = 0.251,
        type = "floor",
    },
    -- Tanaris (map 71 35.30,42.60) -> Tanaris (map 72 55.90,36.40) via floor
    {
        fromPointID = 100186,
        fromMap = 71,
        fromX = 0.353,
        fromY = 0.426,
        toPointID = 100198,
        toMap = 72,
        toX = 0.559,
        toY = 0.364,
        type = "floor",
    },
    -- Tanaris (map 71 54.50,69.80) -> Tanaris (map 73 42.20,39.40) via floor
    {
        fromPointID = 100192,
        fromMap = 71,
        fromX = 0.545,
        fromY = 0.698,
        toPointID = 100199,
        toMap = 73,
        toX = 0.422,
        toY = 0.394,
        type = "floor",
    },
    -- Tanaris (map 71 55.50,68.20) -> Tanaris (map 73 51.50,24.30) via floor
    {
        fromPointID = 100193,
        fromMap = 71,
        fromX = 0.555,
        fromY = 0.682,
        toPointID = 100200,
        toMap = 73,
        toX = 0.515,
        toY = 0.243,
        type = "floor",
    },
    -- Tanaris (map 71 64.90,50.00) -> Tanaris (map 74 53.30,29.40) via floor
    {
        fromPointID = 100195,
        fromMap = 71,
        fromX = 0.649,
        fromY = 0.5,
        toPointID = 100202,
        toMap = 74,
        toX = 0.533,
        toY = 0.294,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1989)
    -- Tazavesh, the Veiled Market (map 1989 31.43,54.11) -> Tazavesh, the Veiled Market (map 1995 22.88,79.99) via floor
    {
        fromPointID = 1000332,
        fromMap = 1989,
        fromX = 0.3143,
        fromY = 0.5411,
        toPointID = 1000340,
        toMap = 1995,
        toX = 0.2288,
        toY = 0.7999,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1989 40.11,43.01) -> Tazavesh, the Veiled Market (map 1991 78.12,63.74) via floor
    {
        fromPointID = 1000333,
        fromMap = 1989,
        fromX = 0.4011,
        fromY = 0.4301,
        toPointID = 1000337,
        toMap = 1991,
        toX = 0.7812,
        toY = 0.6374,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1989 41.46,28.01) -> Tazavesh, the Veiled Market (map 1992 62.29,85.27) via floor
    {
        fromPointID = 1000334,
        fromMap = 1989,
        fromX = 0.4146,
        fromY = 0.2801,
        toPointID = 1000338,
        toMap = 1992,
        toX = 0.6229,
        toY = 0.8527,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1989 43.66,63.09) -> Tazavesh, the Veiled Market (map 1990 36.61,18.28) via floor
    {
        fromPointID = 1000335,
        fromMap = 1989,
        fromX = 0.4366,
        fromY = 0.6309,
        toPointID = 1000336,
        toMap = 1990,
        toX = 0.3661,
        toY = 0.1828,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1990)
    -- Tazavesh, the Veiled Market (map 1990 36.61,18.28) -> Tazavesh, the Veiled Market (map 1989 43.66,63.09) via floor
    {
        fromPointID = 1000336,
        fromMap = 1990,
        fromX = 0.3661,
        fromY = 0.1828,
        toPointID = 1000335,
        toMap = 1989,
        toX = 0.4366,
        toY = 0.6309,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1991)
    -- Tazavesh, the Veiled Market (map 1991 78.12,63.74) -> Tazavesh, the Veiled Market (map 1989 40.11,43.01) via floor
    {
        fromPointID = 1000337,
        fromMap = 1991,
        fromX = 0.7812,
        fromY = 0.6374,
        toPointID = 1000333,
        toMap = 1989,
        toX = 0.4011,
        toY = 0.4301,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1992)
    -- Tazavesh, the Veiled Market (map 1992 62.29,85.27) -> Tazavesh, the Veiled Market (map 1989 41.46,28.01) via floor
    {
        fromPointID = 1000338,
        fromMap = 1992,
        fromX = 0.6229,
        fromY = 0.8527,
        toPointID = 1000334,
        toMap = 1989,
        toX = 0.4146,
        toY = 0.2801,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1993)
    -- Tazavesh, the Veiled Market (map 1993 81.11,53.08) -> Tazavesh, the Veiled Market (map 1996 42.95,61.66) via floor
    {
        fromPointID = 1000339,
        fromMap = 1993,
        fromX = 0.8111,
        fromY = 0.5308,
        toPointID = 1000342,
        toMap = 1996,
        toX = 0.4295,
        toY = 0.6166,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1995)
    -- Tazavesh, the Veiled Market (map 1995 22.88,79.99) -> Tazavesh, the Veiled Market (map 1989 31.43,54.11) via floor
    {
        fromPointID = 1000340,
        fromMap = 1995,
        fromX = 0.2288,
        fromY = 0.7999,
        toPointID = 1000332,
        toMap = 1989,
        toX = 0.3143,
        toY = 0.5411,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1995 62.86,52.15) -> Tazavesh, the Veiled Market (map 1997 19.07,26.04) via floor
    {
        fromPointID = 1000341,
        fromMap = 1995,
        fromX = 0.6286,
        fromY = 0.5215,
        toPointID = 1000344,
        toMap = 1997,
        toX = 0.1907,
        toY = 0.2604,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1996)
    -- Tazavesh, the Veiled Market (map 1996 42.95,61.66) -> Tazavesh, the Veiled Market (map 1993 81.11,53.08) via floor
    {
        fromPointID = 1000342,
        fromMap = 1996,
        fromX = 0.4295,
        fromY = 0.6166,
        toPointID = 1000339,
        toMap = 1993,
        toX = 0.8111,
        toY = 0.5308,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1996 75.50,37.73) -> Tazavesh, the Veiled Market (map 1997 62.48,53.78) via floor
    {
        fromPointID = 1000343,
        fromMap = 1996,
        fromX = 0.755,
        fromY = 0.3773,
        toPointID = 1000345,
        toMap = 1997,
        toX = 0.6248,
        toY = 0.5378,
        type = "floor",
    },

    -- Zone: Tazavesh, the Veiled Market (map 1997)
    -- Tazavesh, the Veiled Market (map 1997 19.07,26.04) -> Tazavesh, the Veiled Market (map 1995 62.86,52.15) via floor
    {
        fromPointID = 1000344,
        fromMap = 1997,
        fromX = 0.1907,
        fromY = 0.2604,
        toPointID = 1000341,
        toMap = 1995,
        toX = 0.6286,
        toY = 0.5215,
        type = "floor",
    },
    -- Tazavesh, the Veiled Market (map 1997 62.48,53.78) -> Tazavesh, the Veiled Market (map 1996 75.50,37.73) via floor
    {
        fromPointID = 1000345,
        fromMap = 1997,
        fromX = 0.6248,
        fromY = 0.5378,
        toPointID = 1000343,
        toMap = 1996,
        toX = 0.755,
        toY = 0.3773,
        type = "floor",
    },

    -- Zone: Teldrassil (map 57)
    -- Teldrassil (map 57 45.60,50.60) -> Teldrassil (map 60 52.60,15.50) via floor
    {
        fromPointID = 100066,
        fromMap = 57,
        fromX = 0.456,
        fromY = 0.506,
        toPointID = 100078,
        toMap = 60,
        toX = 0.526,
        toY = 0.155,
        type = "floor",
    },
    -- Teldrassil (map 57 54.50,46.30) -> Teldrassil (map 59 77.60,81.70) via floor
    {
        fromPointID = 100069,
        fromMap = 57,
        fromX = 0.545,
        fromY = 0.463,
        toPointID = 100074,
        toMap = 59,
        toX = 0.776,
        toY = 0.817,
        type = "floor",
    },

    -- Zone: Temple of the Jade Serpent (map 429)
    -- Temple of the Jade Serpent (map 429 27.00,68.70) -> Temple of the Jade Serpent (map 430 46.60,42.50) via floor
    {
        fromPointID = 500142,
        fromMap = 429,
        fromX = 0.27,
        fromY = 0.687,
        toPointID = 500146,
        toMap = 430,
        toX = 0.466,
        toY = 0.425,
        type = "floor",
    },
    -- Temple of the Jade Serpent (map 429 27.40,62.70) -> Temple of the Jade Serpent (map 430 39.00,22.00) via floor
    {
        fromPointID = 500143,
        fromMap = 429,
        fromX = 0.274,
        fromY = 0.627,
        toPointID = 500145,
        toMap = 430,
        toX = 0.39,
        toY = 0.22,
        type = "floor",
    },

    -- Zone: Temple of the Jade Serpent (map 430)
    -- Temple of the Jade Serpent (map 430 39.00,22.00) -> Temple of the Jade Serpent (map 429 27.40,62.70) via floor
    {
        fromPointID = 500145,
        fromMap = 430,
        fromX = 0.39,
        fromY = 0.22,
        toPointID = 500143,
        toMap = 429,
        toX = 0.274,
        toY = 0.627,
        type = "floor",
    },
    -- Temple of the Jade Serpent (map 430 46.60,42.50) -> Temple of the Jade Serpent (map 429 27.00,68.70) via floor
    {
        fromPointID = 500146,
        fromMap = 430,
        fromX = 0.466,
        fromY = 0.425,
        toPointID = 500142,
        toMap = 429,
        toX = 0.27,
        toY = 0.687,
        type = "floor",
    },

    -- Zone: The Ancient Passage (map 434)
    -- The Veiled Stair (map 434 25.10,12.50) -> Kun-Lai Summit (map 379 73.20,94.60) via floor
    {
        fromPointID = 500156,
        fromMap = 434,
        fromX = 0.251,
        fromY = 0.125,
        toPointID = 500073,
        toMap = 379,
        toX = 0.732,
        toY = 0.946,
        type = "floor",
    },
    -- The Veiled Stair (map 434 63.10,86.40) -> The Veiled Stair (map 433 50.60,40.40) via floor
    {
        fromPointID = 500157,
        fromMap = 434,
        fromX = 0.631,
        fromY = 0.864,
        toPointID = 500150,
        toMap = 433,
        toX = 0.506,
        toY = 0.404,
        type = "floor",
    },
    -- The Veiled Stair (map 434 77.60,36.70) -> The Veiled Stair (map 433 57.30,13.60) via floor
    {
        fromPointID = 500158,
        fromMap = 434,
        fromX = 0.776,
        fromY = 0.367,
        toPointID = 500154,
        toMap = 433,
        toX = 0.573,
        toY = 0.136,
        type = "floor",
    },

    -- Zone: The Arcatraz (map 269)
    -- The Arcatraz (map 269 65.11,35.34) -> The Arcatraz (map 270 89.26,43.76) via floor
    {
        fromPointID = 300138,
        fromMap = 269,
        fromX = 0.6511,
        fromY = 0.3534,
        toPointID = 300140,
        toMap = 270,
        toX = 0.8926,
        toY = 0.4376,
        type = "floor",
    },

    -- Zone: The Arcatraz (map 270)
    -- The Arcatraz (map 270 36.51,57.12) -> The Arcatraz (map 271 26.97,88.52) via floor
    {
        fromPointID = 300139,
        fromMap = 270,
        fromX = 0.3651,
        fromY = 0.5712,
        toPointID = 300141,
        toMap = 271,
        toX = 0.2697,
        toY = 0.8852,
        type = "floor",
    },
    -- The Arcatraz (map 270 89.26,43.76) -> The Arcatraz (map 269 65.11,35.34) via floor
    {
        fromPointID = 300140,
        fromMap = 270,
        fromX = 0.8926,
        fromY = 0.4376,
        toPointID = 300138,
        toMap = 269,
        toX = 0.6511,
        toY = 0.3534,
        type = "floor",
    },

    -- Zone: The Arcatraz (map 271)
    -- The Arcatraz (map 271 26.97,88.52) -> The Arcatraz (map 270 36.51,57.12) via floor
    {
        fromPointID = 300141,
        fromMap = 271,
        fromX = 0.2697,
        fromY = 0.8852,
        toPointID = 300139,
        toMap = 270,
        toX = 0.3651,
        toY = 0.5712,
        type = "floor",
    },

    -- Zone: The Arcway Vaults (map 681)
    -- Suramar (map 681 39.35,82.60) -> Suramar (map 680 54.63,46.35) via floor
    {
        fromPointID = 700206,
        fromMap = 681,
        fromX = 0.3935,
        fromY = 0.826,
        toPointID = 700190,
        toMap = 680,
        toX = 0.5463,
        toY = 0.4635,
        type = "floor",
    },

    -- Zone: The Azure Span (map 2024)
    -- The Azure Span (map 2024 34.03,30.81) -> The Azure Span (map 2132 35.06,90.20) via floor
    {
        fromPointID = 1100053,
        fromMap = 2024,
        fromX = 0.3403,
        fromY = 0.3081,
        toPointID = 1100136,
        toMap = 2132,
        toX = 0.3506,
        toY = 0.902,
        type = "floor",
    },
    -- The Azure Span (map 2024 34.96,30.01) -> The Azure Span (map 2132 53.14,82.77) via floor
    {
        fromPointID = 1100054,
        fromMap = 2024,
        fromX = 0.3496,
        fromY = 0.3001,
        toPointID = 1100137,
        toMap = 2132,
        toX = 0.5314,
        toY = 0.8277,
        type = "floor",
    },

    -- Zone: The Azure Span (map 2132)
    -- The Azure Span (map 2132 35.06,90.20) -> The Azure Span (map 2024 34.03,30.81) via floor
    {
        fromPointID = 1100136,
        fromMap = 2132,
        fromX = 0.3506,
        fromY = 0.902,
        toPointID = 1100053,
        toMap = 2024,
        toX = 0.3403,
        toY = 0.3081,
        type = "floor",
    },
    -- The Azure Span (map 2132 53.14,82.77) -> The Azure Span (map 2024 34.96,30.01) via floor
    {
        fromPointID = 1100137,
        fromMap = 2132,
        fromX = 0.5314,
        fromY = 0.8277,
        toPointID = 1100054,
        toMap = 2024,
        toX = 0.3496,
        toY = 0.3001,
        type = "floor",
    },

    -- Zone: The Azure Vault (map 2073)
    -- The Azure Vault (map 2073 45.46,41.90) -> The Azure Vault (map 2074 39.10,20.02) via floor
    {
        fromPointID = 1100077,
        fromMap = 2073,
        fromX = 0.4546,
        fromY = 0.419,
        toPointID = 1100078,
        toMap = 2074,
        toX = 0.391,
        toY = 0.2002,
        type = "floor",
    },

    -- Zone: The Azure Vault (map 2074)
    -- The Azure Vault (map 2074 39.10,20.02) -> The Azure Vault (map 2073 45.46,41.90) via floor
    {
        fromPointID = 1100078,
        fromMap = 2074,
        fromX = 0.391,
        fromY = 0.2002,
        toPointID = 1100077,
        toMap = 2073,
        toX = 0.4546,
        toY = 0.419,
        type = "floor",
    },
    -- The Azure Vault (map 2074 58.32,65.87) -> The Azure Vault (map 2075 27.10,55.38) via floor
    {
        fromPointID = 1100079,
        fromMap = 2074,
        fromX = 0.5832,
        fromY = 0.6587,
        toPointID = 1100080,
        toMap = 2075,
        toX = 0.271,
        toY = 0.5538,
        type = "floor",
    },

    -- Zone: The Azure Vault (map 2075)
    -- The Azure Vault (map 2075 27.10,55.38) -> The Azure Vault (map 2074 58.32,65.87) via floor
    {
        fromPointID = 1100080,
        fromMap = 2075,
        fromX = 0.271,
        fromY = 0.5538,
        toPointID = 1100079,
        toMap = 2074,
        toX = 0.5832,
        toY = 0.6587,
        type = "floor",
    },
    -- The Azure Vault (map 2075 84.25,34.93) -> The Azure Vault (map 2076 81.93,32.17) via floor
    {
        fromPointID = 1100081,
        fromMap = 2075,
        fromX = 0.8425,
        fromY = 0.3493,
        toPointID = 1100083,
        toMap = 2076,
        toX = 0.8193,
        toY = 0.3217,
        type = "floor",
    },

    -- Zone: The Azure Vault (map 2076)
    -- The Azure Vault (map 2076 36.51,43.08) -> The Azure Vault (map 2077 57.56,60.51) via floor
    {
        fromPointID = 1100082,
        fromMap = 2076,
        fromX = 0.3651,
        fromY = 0.4308,
        toPointID = 1100084,
        toMap = 2077,
        toX = 0.5756,
        toY = 0.6051,
        type = "floor",
    },
    -- The Azure Vault (map 2076 81.93,32.17) -> The Azure Vault (map 2075 84.25,34.93) via floor
    {
        fromPointID = 1100083,
        fromMap = 2076,
        fromX = 0.8193,
        fromY = 0.3217,
        toPointID = 1100081,
        toMap = 2075,
        toX = 0.8425,
        toY = 0.3493,
        type = "floor",
    },

    -- Zone: The Azure Vault (map 2077)
    -- The Azure Vault (map 2077 57.56,60.51) -> The Azure Vault (map 2076 36.51,43.08) via floor
    {
        fromPointID = 1100084,
        fromMap = 2077,
        fromX = 0.5756,
        fromY = 0.6051,
        toPointID = 1100082,
        toMap = 2076,
        toX = 0.3651,
        toY = 0.4308,
        type = "floor",
    },

    -- Zone: The Bastion of Twilight (map 294)
    -- The Bastion of Twilight (map 294 53.70,85.20) -> The Bastion of Twilight (map 295 55.10,5.50) via floor
    {
        fromPointID = 200519,
        fromMap = 294,
        fromX = 0.537,
        fromY = 0.852,
        toPointID = 200520,
        toMap = 295,
        toX = 0.551,
        toY = 0.055,
        type = "floor",
    },

    -- Zone: The Bastion of Twilight (map 295)
    -- The Bastion of Twilight (map 295 55.10,5.50) -> The Bastion of Twilight (map 294 53.70,85.20) via floor
    {
        fromPointID = 200520,
        fromMap = 295,
        fromX = 0.551,
        fromY = 0.055,
        toPointID = 200519,
        toMap = 294,
        toX = 0.537,
        toY = 0.852,
        type = "floor",
    },
    -- The Bastion of Twilight (map 295 69.80,74.80) -> The Bastion of Twilight (map 296 54.80,65.50) via floor
    {
        fromPointID = 200521,
        fromMap = 295,
        fromX = 0.698,
        fromY = 0.748,
        toPointID = 200522,
        toMap = 296,
        toX = 0.548,
        toY = 0.655,
        type = "floor",
    },

    -- Zone: The Coiled Isle (map 2512)
    -- The Coiled Isle (map 2512 44.68,34.45) -> Kin's Rest (map 2645 78.59,41.39) via floor
    {
        fromPointID = 200783,
        fromMap = 2512,
        fromX = 0.4468,
        fromY = 0.3445,
        toPointID = 200902,
        toMap = 2645,
        toX = 0.7859,
        toY = 0.4139,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 44.78,30.06) -> Infested Tomb (map 2640 76.66,41.25) via floor
    {
        fromPointID = 200784,
        fromMap = 2512,
        fromX = 0.4478,
        fromY = 0.3006,
        toPointID = 200896,
        toMap = 2640,
        toX = 0.7666,
        toY = 0.4125,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 45.37,64.93) -> Vaults of Atal'Utek (map 2509 51.29,82.10) via floor
    {
        fromPointID = 200786,
        fromMap = 2512,
        fromX = 0.4537,
        fromY = 0.6493,
        toPointID = 200765,
        toMap = 2509,
        toX = 0.5129,
        toY = 0.821,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 45.48,75.78) -> Crypt of the Denied (map 2639 69.16,18.00) via floor
    {
        fromPointID = 200787,
        fromMap = 2512,
        fromX = 0.4548,
        fromY = 0.7578,
        toPointID = 200895,
        toMap = 2639,
        toX = 0.6916,
        toY = 0.18,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 49.46,38.54) -> Crypt of the Lost Mason (map 2643 45.44,11.99) via floor
    {
        fromPointID = 200788,
        fromMap = 2512,
        fromX = 0.4946,
        fromY = 0.3854,
        toPointID = 200900,
        toMap = 2643,
        toX = 0.4544,
        toY = 0.1199,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 52.42,43.00) -> Tomb of the Lost Priest (map 2642 52.20,79.92) via floor
    {
        fromPointID = 200790,
        fromMap = 2512,
        fromX = 0.5242,
        fromY = 0.43,
        toPointID = 200899,
        toMap = 2642,
        toX = 0.522,
        toY = 0.7992,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 52.95,32.23) -> Crypt of the Lost Warrior (map 2641 7.64,59.34) via floor
    {
        fromPointID = 200791,
        fromMap = 2512,
        fromX = 0.5295,
        fromY = 0.3223,
        toPointID = 200897,
        toMap = 2641,
        toX = 0.0764,
        toY = 0.5934,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 57.09,33.45) -> Crypt of the Lost Warrior (map 2641 89.42,82.69) via floor
    {
        fromPointID = 200792,
        fromMap = 2512,
        fromX = 0.5709,
        fromY = 0.3345,
        toPointID = 200898,
        toMap = 2641,
        toX = 0.8942,
        toY = 0.8269,
        type = "floor",
    },
    -- The Coiled Isle (map 2512 74.71,62.70) -> Crypt of the Disgraced (map 2644 66.44,17.99) via floor
    {
        fromPointID = 200796,
        fromMap = 2512,
        fromX = 0.7471,
        fromY = 0.627,
        toPointID = 200901,
        toMap = 2644,
        toX = 0.6644,
        toY = 0.1799,
        type = "floor",
    },

    -- Zone: The Culling of Stratholme (map 130)
    -- The Culling of Stratholme (map 130 47.47,32.24) -> The Culling of Stratholme (map 131 50.63,92.88) via floor
    {
        fromPointID = 100318,
        fromMap = 130,
        fromX = 0.4747,
        fromY = 0.3224,
        toPointID = 100320,
        toMap = 131,
        toX = 0.5063,
        toY = 0.9288,
        type = "floor",
    },

    -- Zone: The Culling of Stratholme (map 131)
    -- The Culling of Stratholme (map 131 50.63,92.88) -> The Culling of Stratholme (map 130 47.47,32.24) via floor
    {
        fromPointID = 100320,
        fromMap = 131,
        fromX = 0.5063,
        fromY = 0.9288,
        toPointID = 100318,
        toMap = 130,
        toX = 0.4747,
        toY = 0.3224,
        type = "floor",
    },

    -- Zone: The Deadmines (map 291)
    -- The Deadmines (map 291 65.48,60.02) -> The Deadmines (map 292 16.97,88.45) via floor
    {
        fromPointID = 200514,
        fromMap = 291,
        fromX = 0.6548,
        fromY = 0.6002,
        toPointID = 200515,
        toMap = 292,
        toX = 0.1697,
        toY = 0.8845,
        type = "floor",
    },

    -- Zone: The Deadmines (map 292)
    -- The Deadmines (map 292 16.97,88.45) -> The Deadmines (map 291 65.48,60.02) via floor
    {
        fromPointID = 200515,
        fromMap = 292,
        fromX = 0.1697,
        fromY = 0.8845,
        toPointID = 200514,
        toMap = 291,
        toX = 0.6548,
        toY = 0.6002,
        type = "floor",
    },

    -- Zone: The Deadmines (map 55)
    -- Westfall (map 55 69.30,23.70) -> Westfall (map 52 42.50,71.80) via floor
    {
        fromPointID = 200259,
        fromMap = 55,
        fromX = 0.693,
        fromY = 0.237,
        toPointID = 200251,
        toMap = 52,
        toX = 0.425,
        toY = 0.718,
        type = "floor",
    },

    -- Zone: The Deeper (map 383)
    -- Kun-Lai Summit (map 383 56.50,15.90) -> Kun-Lai Summit (map 379 52.90,71.30) via floor
    {
        fromPointID = 500079,
        fromMap = 383,
        fromX = 0.565,
        fromY = 0.159,
        toPointID = 500060,
        toMap = 379,
        toX = 0.529,
        toY = 0.713,
        type = "floor",
    },

    -- Zone: The Dreamgrove (map 747)
    -- The Dreamgrove (map 747 44.82,32.76) -> Val'sharah (map 641 45.48,34.51) via floor
    {
        fromPointID = 700266,
        fromMap = 747,
        fromX = 0.4482,
        fromY = 0.3276,
        toPointID = 700091,
        toMap = 641,
        toX = 0.4548,
        toY = 0.3451,
        type = "floor",
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
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },

    -- Zone: The Dreamrift (map 2531)
    -- Dreamrift (map 2531 50.50,80.60) -> Dreamrift (map 2532 50.26,22.78) via floor
    {
        fromPointID = 200824,
        fromMap = 2531,
        fromX = 0.505,
        fromY = 0.806,
        toPointID = 200825,
        toMap = 2532,
        toX = 0.5026,
        toY = 0.2278,
        type = "floor",
    },

    -- Zone: The Dreamrift (map 2532)
    -- Dreamrift (map 2532 50.26,22.78) -> Dreamrift (map 2531 50.50,80.60) via floor
    {
        fromPointID = 200825,
        fromMap = 2532,
        fromX = 0.5026,
        fromY = 0.2278,
        toPointID = 200824,
        toMap = 2531,
        toX = 0.505,
        toY = 0.806,
        type = "floor",
    },

    -- Zone: The Eastern Boughs (map 2236)
    -- Amirdrassil, The Dream's Hope (map 2236 29.70,50.93) -> Amirdrassil, The Dream's Hope (map 2234 62.10,64.81) via floor
    {
        fromPointID = 1100220,
        fromMap = 2236,
        fromX = 0.297,
        fromY = 0.5093,
        toPointID = 1100218,
        toMap = 2234,
        toX = 0.621,
        toY = 0.6481,
        type = "floor",
    },
    -- Amirdrassil, The Dream's Hope (map 2236 29.70,50.93) -> Amirdrassil, The Dream's Hope (map 2238 67.12,89.67) via floor
    {
        fromPointID = 1100220,
        fromMap = 2236,
        fromX = 0.297,
        fromY = 0.5093,
        toPointID = 1100222,
        toMap = 2238,
        toX = 0.6712,
        toY = 0.8967,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1512)
    -- The Eternal Palace (map 1512 15.06,48.35) -> The Eternal Palace (map 1513 66.28,69.94) via floor
    {
        fromPointID = 1300035,
        fromMap = 1512,
        fromX = 0.1506,
        fromY = 0.4835,
        toPointID = 1300038,
        toMap = 1513,
        toX = 0.6628,
        toY = 0.6994,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1513)
    -- The Eternal Palace (map 1513 44.91,90.17) -> The Eternal Palace (map 1514 56.81,14.35) via floor
    {
        fromPointID = 1300036,
        fromMap = 1513,
        fromX = 0.4491,
        fromY = 0.9017,
        toPointID = 1300039,
        toMap = 1514,
        toX = 0.5681,
        toY = 0.1435,
        type = "floor",
    },
    -- The Eternal Palace (map 1513 47.49,68.79) -> The Eternal Palace (map 1516 42.47,52.30) via floor
    {
        fromPointID = 1300037,
        fromMap = 1513,
        fromX = 0.4749,
        fromY = 0.6879,
        toPointID = 1300040,
        toMap = 1516,
        toX = 0.4247,
        toY = 0.523,
        type = "floor",
    },
    -- The Eternal Palace (map 1513 66.28,69.94) -> The Eternal Palace (map 1512 15.06,48.35) via floor
    {
        fromPointID = 1300038,
        fromMap = 1513,
        fromX = 0.6628,
        fromY = 0.6994,
        toPointID = 1300035,
        toMap = 1512,
        toX = 0.1506,
        toY = 0.4835,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1514)
    -- The Eternal Palace (map 1514 56.81,14.35) -> The Eternal Palace (map 1513 44.91,90.17) via floor
    {
        fromPointID = 1300039,
        fromMap = 1514,
        fromX = 0.5681,
        fromY = 0.1435,
        toPointID = 1300036,
        toMap = 1513,
        toX = 0.4491,
        toY = 0.9017,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1516)
    -- The Eternal Palace (map 1516 42.47,52.30) -> The Eternal Palace (map 1513 47.49,68.79) via floor
    {
        fromPointID = 1300040,
        fromMap = 1516,
        fromX = 0.4247,
        fromY = 0.523,
        toPointID = 1300037,
        toMap = 1513,
        toX = 0.4749,
        toY = 0.6879,
        type = "floor",
    },
    -- The Eternal Palace (map 1516 49.78,71.88) -> The Eternal Palace (map 1517 85.22,36.73) via floor
    {
        fromPointID = 1300041,
        fromMap = 1516,
        fromX = 0.4978,
        fromY = 0.7188,
        toPointID = 1300043,
        toMap = 1517,
        toX = 0.8522,
        toY = 0.3673,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1517)
    -- The Eternal Palace (map 1517 10.47,62.12) -> The Eternal Palace (map 1518 67.86,49.07) via floor
    {
        fromPointID = 1300042,
        fromMap = 1517,
        fromX = 0.1047,
        fromY = 0.6212,
        toPointID = 1300045,
        toMap = 1518,
        toX = 0.6786,
        toY = 0.4907,
        type = "floor",
    },
    -- The Eternal Palace (map 1517 85.22,36.73) -> The Eternal Palace (map 1516 49.78,71.88) via floor
    {
        fromPointID = 1300043,
        fromMap = 1517,
        fromX = 0.8522,
        fromY = 0.3673,
        toPointID = 1300041,
        toMap = 1516,
        toX = 0.4978,
        toY = 0.7188,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1518)
    -- The Eternal Palace (map 1518 15.78,48.21) -> The Eternal Palace (map 1519 89.38,51.15) via floor
    {
        fromPointID = 1300044,
        fromMap = 1518,
        fromX = 0.1578,
        fromY = 0.4821,
        toPointID = 1300047,
        toMap = 1519,
        toX = 0.8938,
        toY = 0.5115,
        type = "floor",
    },
    -- The Eternal Palace (map 1518 67.86,49.07) -> The Eternal Palace (map 1517 10.47,62.12) via floor
    {
        fromPointID = 1300045,
        fromMap = 1518,
        fromX = 0.6786,
        fromY = 0.4907,
        toPointID = 1300042,
        toMap = 1517,
        toX = 0.1047,
        toY = 0.6212,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1519)
    -- The Eternal Palace (map 1519 11.33,46.20) -> The Eternal Palace (map 1520 67.14,52.51) via floor
    {
        fromPointID = 1300046,
        fromMap = 1519,
        fromX = 0.1133,
        fromY = 0.462,
        toPointID = 1300048,
        toMap = 1520,
        toX = 0.6714,
        toY = 0.5251,
        type = "floor",
    },
    -- The Eternal Palace (map 1519 89.38,51.15) -> The Eternal Palace (map 1518 15.78,48.21) via floor
    {
        fromPointID = 1300047,
        fromMap = 1519,
        fromX = 0.8938,
        fromY = 0.5115,
        toPointID = 1300044,
        toMap = 1518,
        toX = 0.1578,
        toY = 0.4821,
        type = "floor",
    },

    -- Zone: The Eternal Palace (map 1520)
    -- The Eternal Palace (map 1520 67.14,52.51) -> The Eternal Palace (map 1519 11.33,46.20) via floor
    {
        fromPointID = 1300048,
        fromMap = 1520,
        fromX = 0.6714,
        fromY = 0.5251,
        toPointID = 1300046,
        toMap = 1519,
        toX = 0.1133,
        toY = 0.462,
        type = "floor",
    },

    -- Zone: The Forbidden Reach (map 2151)
    -- The Forbidden Reach (map 2151 36.80,32.50) -> The Support Creche (map 2101 83.14,80.98) via floor
    {
        fromPointID = 1100161,
        fromMap = 2151,
        fromX = 0.368,
        fromY = 0.325,
        toPointID = 1100105,
        toMap = 2101,
        toX = 0.8314,
        toY = 0.8098,
        type = "floor",
    },
    -- The Forbidden Reach (map 2151 51.84,60.19) -> The War Creche (map 2102 67.49,4.60) via floor
    {
        fromPointID = 1100162,
        fromMap = 2151,
        fromX = 0.5184,
        fromY = 0.6019,
        toPointID = 1100106,
        toMap = 2102,
        toX = 0.6749,
        toY = 0.046,
        type = "floor",
    },
    -- The Forbidden Reach (map 2151 60.68,37.91) -> Froststone Vault (map 2154 26.80,83.77) via floor
    {
        fromPointID = 1100163,
        fromMap = 2151,
        fromX = 0.6068,
        fromY = 0.3791,
        toPointID = 1100167,
        toMap = 2154,
        toX = 0.268,
        toY = 0.8377,
        type = "floor",
    },
    -- The Forbidden Reach (map 2151 74.31,54.78) -> The Siege Creche (map 2100 22.03,77.49) via floor
    {
        fromPointID = 1100164,
        fromMap = 2151,
        fromX = 0.7431,
        fromY = 0.5478,
        toPointID = 1100104,
        toMap = 2100,
        toX = 0.2203,
        toY = 0.7749,
        type = "floor",
    },
    -- The Forbidden Reach (map 2151 74.46,36.07) -> Dragonskull Island (map 2150 11.14,68.72) via floor
    {
        fromPointID = 1100165,
        fromMap = 2151,
        fromX = 0.7446,
        fromY = 0.3607,
        toPointID = 1100159,
        toMap = 2150,
        toX = 0.1114,
        toY = 0.6872,
        type = "floor",
    },
    -- The Forbidden Reach (map 2151 76.67,37.79) -> Dragonskull Island (map 2150 32.01,92.66) via floor
    {
        fromPointID = 1100166,
        fromMap = 2151,
        fromX = 0.7667,
        fromY = 0.3779,
        toPointID = 1100160,
        toMap = 2150,
        toX = 0.3201,
        toY = 0.9266,
        type = "floor",
    },

    -- Zone: The Gaping Chasm (map 73)
    -- Tanaris (map 73 42.20,39.40) -> Tanaris (map 71 54.50,69.80) via floor
    {
        fromPointID = 100199,
        fromMap = 73,
        fromX = 0.422,
        fromY = 0.394,
        toPointID = 100192,
        toMap = 71,
        toX = 0.545,
        toY = 0.698,
        type = "floor",
    },
    -- Tanaris (map 73 51.50,24.30) -> Tanaris (map 71 55.50,68.20) via floor
    {
        fromPointID = 100200,
        fromMap = 73,
        fromX = 0.515,
        fromY = 0.243,
        toPointID = 100193,
        toMap = 71,
        toX = 0.555,
        toY = 0.682,
        type = "floor",
    },

    -- Zone: The Grizzled Den (map 29)
    -- Dun Morogh (map 29 60.40,77.00) -> Dun Morogh (map 27 48.90,52.60) via floor
    {
        fromPointID = 200134,
        fromMap = 29,
        fromX = 0.604,
        fromY = 0.77,
        toPointID = 200124,
        toMap = 27,
        toX = 0.489,
        toY = 0.526,
        type = "floor",
    },

    -- Zone: The Illicit Rain (map 2435)
    -- Murder Row (map 2435 46.56,82.21) -> Murder Row (map 2434 30.18,53.26) via floor
    {
        fromPointID = 200718,
        fromMap = 2435,
        fromX = 0.4656,
        fromY = 0.8221,
        toPointID = 200717,
        toMap = 2434,
        toX = 0.3018,
        toY = 0.5326,
        type = "floor",
    },
    -- Murder Row (map 2435 77.52,66.97) -> Murder Row (map 2433 45.18,15.29) via floor
    {
        fromPointID = 200719,
        fromMap = 2435,
        fromX = 0.7752,
        fromY = 0.6697,
        toPointID = 200716,
        toMap = 2433,
        toX = 0.4518,
        toY = 0.1529,
        type = "floor",
    },

    -- Zone: The Lost Isles (map 174)
    -- The Lost Isles (map 174 31.20,78.60) -> The Lost Isles (map 175 48.10,90.00) via floor
    {
        fromPointID = 1300001,
        fromMap = 174,
        fromX = 0.312,
        fromY = 0.786,
        toPointID = 1300003,
        toMap = 175,
        toX = 0.481,
        toY = 0.9,
        type = "floor",
    },
    -- The Lost Isles (map 174 70.00,48.00) -> The Lost Isles (map 176 50.00,10.80) via floor
    {
        fromPointID = 1300002,
        fromMap = 174,
        fromX = 0.7,
        fromY = 0.48,
        toPointID = 1300004,
        toMap = 176,
        toX = 0.5,
        toY = 0.108,
        type = "floor",
    },

    -- Zone: The Lycaneum (map 2649)
    -- The Lycaneum (map 2649 64.22,87.72) -> Isle of Quel Danas M (map 2424 64.01,29.12) via floor
    {
        fromPointID = 200906,
        fromMap = 2649,
        fromX = 0.6422,
        fromY = 0.8772,
        toPointID = 200713,
        toMap = 2424,
        toX = 0.6401,
        toY = 0.2912,
        type = "floor",
    },

    -- Zone: The Maw (map 1543)
    -- The Maw (map 1543 23.01,68.40) -> Altar of Domination (map 1823 89.73,34.52) via floor
    {
        fromPointID = 1000090,
        fromMap = 1543,
        fromX = 0.2301,
        fromY = 0.684,
        toPointID = 1000305,
        toMap = 1823,
        toX = 0.8973,
        toY = 0.3452,
        type = "floor",
    },
    -- The Maw (map 1543 27.87,20.52) -> Extractor's Sanatorium (map 1822 19.94,73.08) via floor
    {
        fromPointID = 1000094,
        fromMap = 1543,
        fromX = 0.2787,
        fromY = 0.2052,
        toPointID = 1000304,
        toMap = 1822,
        toX = 0.1994,
        toY = 0.7308,
        type = "floor",
    },
    -- The Maw (map 1543 51.53,90.46) -> Korthia (map 1961 40.04,25.94) via floor
    {
        fromPointID = 1000118,
        fromMap = 1543,
        fromX = 0.5153,
        fromY = 0.9046,
        toPointID = 1000313,
        toMap = 1961,
        toX = 0.4004,
        toY = 0.2594,
        type = "floor",
    },
    -- The Maw (map 1543 65.61,80.80) -> Korthia (map 1961 58.48,13.67) via floor
    {
        fromPointID = 1000121,
        fromMap = 1543,
        fromX = 0.6561,
        fromY = 0.808,
        toPointID = 1000316,
        toMap = 1961,
        toX = 0.5848,
        toY = 0.1367,
        type = "floor",
    },

    -- Zone: The Mechanar (map 267)
    -- The Mechanar (map 267 41.73,22.82) -> The Mechanar (map 268 41.77,31.54) via floor
    {
        fromPointID = 300133,
        fromMap = 267,
        fromX = 0.4173,
        fromY = 0.2282,
        toPointID = 300136,
        toMap = 268,
        toX = 0.4177,
        toY = 0.3154,
        type = "floor",
    },

    -- Zone: The Mechanar (map 268)
    -- The Mechanar (map 268 41.77,31.54) -> The Mechanar (map 267 41.73,22.82) via floor
    {
        fromPointID = 300136,
        fromMap = 268,
        fromX = 0.4177,
        fromY = 0.3154,
        toPointID = 300133,
        toMap = 267,
        toX = 0.4173,
        toY = 0.2282,
        type = "floor",
    },

    -- Zone: The Necrotic Wake (map 1666)
    -- The Necrotic Wake (map 1666 25.27,40.35) -> The Necrotic Wake (map 1667 51.10,83.75) via floor
    {
        fromPointID = 1000159,
        fromMap = 1666,
        fromX = 0.2527,
        fromY = 0.4035,
        toPointID = 1000161,
        toMap = 1667,
        toX = 0.511,
        toY = 0.8375,
        type = "floor",
    },

    -- Zone: The Necrotic Wake (map 1667)
    -- The Necrotic Wake (map 1667 50.74,56.31) -> The Necrotic Wake (map 1668 50.74,55.31) via floor
    {
        fromPointID = 1000160,
        fromMap = 1667,
        fromX = 0.5074,
        fromY = 0.5631,
        toPointID = 1000162,
        toMap = 1668,
        toX = 0.5074,
        toY = 0.5531,
        type = "floor",
    },
    -- The Necrotic Wake (map 1667 51.10,83.75) -> The Necrotic Wake (map 1666 25.27,40.35) via floor
    {
        fromPointID = 1000161,
        fromMap = 1667,
        fromX = 0.511,
        fromY = 0.8375,
        toPointID = 1000159,
        toMap = 1666,
        toX = 0.2527,
        toY = 0.4035,
        type = "floor",
    },

    -- Zone: The Necrotic Wake (map 1668)
    -- The Necrotic Wake (map 1668 50.74,55.31) -> The Necrotic Wake (map 1667 50.74,56.31) via floor
    {
        fromPointID = 1000162,
        fromMap = 1668,
        fromX = 0.5074,
        fromY = 0.5531,
        toPointID = 1000160,
        toMap = 1667,
        toX = 0.5074,
        toY = 0.5631,
        type = "floor",
    },

    -- Zone: The Nighthold (map 2220)
    -- The Nighthold T (map 2220 50.13,55.05) -> The Nighthold T (map 2221 54.99,63.81) via floor
    {
        fromPointID = 700348,
        fromMap = 2220,
        fromX = 0.5013,
        fromY = 0.5505,
        toPointID = 700349,
        toMap = 2221,
        toX = 0.5499,
        toY = 0.6381,
        type = "floor",
    },

    -- Zone: The Nighthold (map 2221)
    -- The Nighthold T (map 2221 54.99,63.81) -> The Nighthold T (map 2220 50.13,55.05) via floor
    {
        fromPointID = 700349,
        fromMap = 2221,
        fromX = 0.5499,
        fromY = 0.6381,
        toPointID = 700348,
        toMap = 2220,
        toX = 0.5013,
        toY = 0.5505,
        type = "floor",
    },

    -- Zone: The Northern Boughs (map 2235)
    -- Amirdrassil, The Dream's Hope (map 2235 34.12,32.46) -> Amirdrassil, The Dream's Hope (map 2234 47.27,43.47) via floor
    {
        fromPointID = 1100219,
        fromMap = 2235,
        fromX = 0.3412,
        fromY = 0.3246,
        toPointID = 1100216,
        toMap = 2234,
        toX = 0.4727,
        toY = 0.4347,
        type = "floor",
    },

    -- Zone: The Noxious Lair (map 72)
    -- Tanaris (map 72 47.50,33.60) -> Tanaris (map 71 34.50,42.40) via floor
    {
        fromPointID = 100196,
        fromMap = 72,
        fromX = 0.475,
        fromY = 0.336,
        toPointID = 100184,
        toMap = 71,
        toX = 0.345,
        toY = 0.424,
        type = "floor",
    },
    -- Tanaris (map 72 50.40,25.10) -> Tanaris (map 71 34.80,41.60) via floor
    {
        fromPointID = 100197,
        fromMap = 72,
        fromX = 0.504,
        fromY = 0.251,
        toPointID = 100185,
        toMap = 71,
        toX = 0.348,
        toY = 0.416,
        type = "floor",
    },
    -- Tanaris (map 72 55.90,36.40) -> Tanaris (map 71 35.30,42.60) via floor
    {
        fromPointID = 100198,
        fromMap = 72,
        fromX = 0.559,
        fromY = 0.364,
        toPointID = 100186,
        toMap = 71,
        toX = 0.353,
        toY = 0.426,
        type = "floor",
    },

    -- Zone: The Rookery (map 2315)
    -- The Rookery (map 2315 10.43,47.44) -> The Rookery (map 2316 71.07,50.65) via floor
    {
        fromPointID = 1200101,
        fromMap = 2315,
        fromX = 0.1043,
        fromY = 0.4744,
        toPointID = 1200105,
        toMap = 2316,
        toX = 0.7107,
        toY = 0.5065,
        type = "floor",
    },
    -- The Rookery (map 2315 18.58,47.35) -> The Rookery (map 2318 57.80,26.79) via floor
    {
        fromPointID = 1200102,
        fromMap = 2315,
        fromX = 0.1858,
        fromY = 0.4735,
        toPointID = 1200111,
        toMap = 2318,
        toX = 0.578,
        toY = 0.2679,
        type = "floor",
    },

    -- Zone: The Rookery (map 2316)
    -- The Rookery (map 2316 40.58,51.18) -> The Rookery (map 2317 50.98,26.72) via floor
    {
        fromPointID = 1200104,
        fromMap = 2316,
        fromX = 0.4058,
        fromY = 0.5118,
        toPointID = 1200107,
        toMap = 2317,
        toX = 0.5098,
        toY = 0.2672,
        type = "floor",
    },
    -- The Rookery (map 2316 71.07,50.65) -> The Rookery (map 2315 10.43,47.44) via floor
    {
        fromPointID = 1200105,
        fromMap = 2316,
        fromX = 0.7107,
        fromY = 0.5065,
        toPointID = 1200101,
        toMap = 2315,
        toX = 0.1043,
        toY = 0.4744,
        type = "floor",
    },

    -- Zone: The Rookery (map 2317)
    -- The Rookery (map 2317 49.78,62.41) -> The Rookery (map 2318 44.52,24.64) via floor
    {
        fromPointID = 1200106,
        fromMap = 2317,
        fromX = 0.4978,
        fromY = 0.6241,
        toPointID = 1200108,
        toMap = 2318,
        toX = 0.4452,
        toY = 0.2464,
        type = "floor",
    },
    -- The Rookery (map 2317 50.98,26.72) -> The Rookery (map 2316 40.58,51.18) via floor
    {
        fromPointID = 1200107,
        fromMap = 2317,
        fromX = 0.5098,
        fromY = 0.2672,
        toPointID = 1200104,
        toMap = 2316,
        toX = 0.4058,
        toY = 0.5118,
        type = "floor",
    },

    -- Zone: The Rookery (map 2318)
    -- The Rookery (map 2318 44.52,24.64) -> The Rookery (map 2317 49.78,62.41) via floor
    {
        fromPointID = 1200108,
        fromMap = 2318,
        fromX = 0.4452,
        fromY = 0.2464,
        toPointID = 1200106,
        toMap = 2317,
        toX = 0.4978,
        toY = 0.6241,
        type = "floor",
    },
    -- The Rookery (map 2318 47.03,58.54) -> The Rookery (map 2319 49.78,90.21) via floor
    {
        fromPointID = 1200109,
        fromMap = 2318,
        fromX = 0.4703,
        fromY = 0.5854,
        toPointID = 1200113,
        toMap = 2319,
        toX = 0.4978,
        toY = 0.9021,
        type = "floor",
    },
    -- The Rookery (map 2318 55.40,13.70) -> The Rookery (map 2319 61.86,45.19) via floor
    {
        fromPointID = 1200110,
        fromMap = 2318,
        fromX = 0.554,
        fromY = 0.137,
        toPointID = 1200114,
        toMap = 2319,
        toX = 0.6186,
        toY = 0.4519,
        type = "floor",
    },
    -- The Rookery (map 2318 57.80,26.79) -> The Rookery (map 2315 18.58,47.35) via floor
    {
        fromPointID = 1200111,
        fromMap = 2318,
        fromX = 0.578,
        fromY = 0.2679,
        toPointID = 1200102,
        toMap = 2315,
        toX = 0.1858,
        toY = 0.4735,
        type = "floor",
    },

    -- Zone: The Rookery (map 2319)
    -- The Rookery (map 2319 39.26,30.67) -> The Rookery (map 2320 46.32,36.12) via floor
    {
        fromPointID = 1200112,
        fromMap = 2319,
        fromX = 0.3926,
        fromY = 0.3067,
        toPointID = 1200115,
        toMap = 2320,
        toX = 0.4632,
        toY = 0.3612,
        type = "floor",
    },
    -- The Rookery (map 2319 49.78,90.21) -> The Rookery (map 2318 47.03,58.54) via floor
    {
        fromPointID = 1200113,
        fromMap = 2319,
        fromX = 0.4978,
        fromY = 0.9021,
        toPointID = 1200109,
        toMap = 2318,
        toX = 0.4703,
        toY = 0.5854,
        type = "floor",
    },
    -- The Rookery (map 2319 61.86,45.19) -> The Rookery (map 2318 55.40,13.70) via floor
    {
        fromPointID = 1200114,
        fromMap = 2319,
        fromX = 0.6186,
        fromY = 0.4519,
        toPointID = 1200110,
        toMap = 2318,
        toX = 0.554,
        toY = 0.137,
        type = "floor",
    },

    -- Zone: The Rookery (map 2320)
    -- The Rookery (map 2320 46.32,36.12) -> The Rookery (map 2319 39.26,30.67) via floor
    {
        fromPointID = 1200115,
        fromMap = 2320,
        fromX = 0.4632,
        fromY = 0.3612,
        toPointID = 1200112,
        toMap = 2319,
        toX = 0.3926,
        toY = 0.3067,
        type = "floor",
    },

    -- Zone: The Siege Creche (map 2100)
    -- The Siege Creche (map 2100 22.03,77.49) -> The Forbidden Reach (map 2151 74.31,54.78) via floor
    {
        fromPointID = 1100104,
        fromMap = 2100,
        fromX = 0.2203,
        fromY = 0.7749,
        toPointID = 1100164,
        toMap = 2151,
        toX = 0.7431,
        toY = 0.5478,
        type = "floor",
    },

    -- Zone: The Southern Boughs (map 2237)
    -- Amirdrassil, The Dream's Hope (map 2237 28.62,38.92) -> Amirdrassil, The Dream's Hope (map 2234 38.06,88.32) via floor
    {
        fromPointID = 1100221,
        fromMap = 2237,
        fromX = 0.2862,
        fromY = 0.3892,
        toPointID = 1100215,
        toMap = 2234,
        toX = 0.3806,
        toY = 0.8832,
        type = "floor",
    },

    -- Zone: The Steamvault (map 263)
    -- The Steamvault (map 263 36.64,73.70) -> The Steamvault (map 264 35.59,72.57) via floor
    {
        fromPointID = 300123,
        fromMap = 263,
        fromX = 0.3664,
        fromY = 0.737,
        toPointID = 300127,
        toMap = 264,
        toX = 0.3559,
        toY = 0.7257,
        type = "floor",
    },
    -- The Steamvault (map 263 48.01,77.81) -> The Steamvault (map 264 46.24,79.55) via floor
    {
        fromPointID = 300124,
        fromMap = 263,
        fromX = 0.4801,
        fromY = 0.7781,
        toPointID = 300128,
        toMap = 264,
        toX = 0.4624,
        toY = 0.7955,
        type = "floor",
    },
    -- The Steamvault (map 263 49.85,29.26) -> The Steamvault (map 264 51.23,28.93) via floor
    {
        fromPointID = 300125,
        fromMap = 263,
        fromX = 0.4985,
        fromY = 0.2926,
        toPointID = 300129,
        toMap = 264,
        toX = 0.5123,
        toY = 0.2893,
        type = "floor",
    },
    -- The Steamvault (map 263 51.38,27.47) -> The Steamvault (map 264 51.48,29.20) via floor
    {
        fromPointID = 300126,
        fromMap = 263,
        fromX = 0.5138,
        fromY = 0.2747,
        toPointID = 300130,
        toMap = 264,
        toX = 0.5148,
        toY = 0.292,
        type = "floor",
    },

    -- Zone: The Steamvault (map 264)
    -- The Steamvault (map 264 46.24,79.55) -> The Steamvault (map 263 48.01,77.81) via floor
    {
        fromPointID = 300128,
        fromMap = 264,
        fromX = 0.4624,
        fromY = 0.7955,
        toPointID = 300124,
        toMap = 263,
        toX = 0.4801,
        toY = 0.7781,
        type = "floor",
    },
    -- The Steamvault (map 264 51.23,28.93) -> The Steamvault (map 263 49.85,29.26) via floor
    {
        fromPointID = 300129,
        fromMap = 264,
        fromX = 0.5123,
        fromY = 0.2893,
        toPointID = 300125,
        toMap = 263,
        toX = 0.4985,
        toY = 0.2926,
        type = "floor",
    },

    -- Zone: The Support Creche (map 2101)
    -- The Support Creche (map 2101 83.14,80.98) -> The Forbidden Reach (map 2151 36.80,32.50) via floor
    {
        fromPointID = 1100105,
        fromMap = 2101,
        fromX = 0.8314,
        fromY = 0.8098,
        toPointID = 1100161,
        toMap = 2151,
        toX = 0.368,
        toY = 0.325,
        type = "floor",
    },

    -- Zone: The Swollen Vault (map 506)
    -- Isle of Thunder (map 506 66.10,77.90) -> Isle of Thunder (map 504 62.40,40.30) via floor
    {
        fromPointID = 500231,
        fromMap = 506,
        fromX = 0.661,
        fromY = 0.779,
        toPointID = 500223,
        toMap = 504,
        toX = 0.624,
        toY = 0.403,
        type = "floor",
    },

    -- Zone: The Underbelly (map 2613)
    -- Atal'Utek Underbelly (map 2613 52.43,87.13) -> Vaults of Atal'Utek (map 2509 47.23,7.28) via floor
    {
        fromPointID = 200881,
        fromMap = 2613,
        fromX = 0.5243,
        fromY = 0.8713,
        toPointID = 200761,
        toMap = 2509,
        toX = 0.4723,
        toY = 0.0728,
        type = "floor",
    },

    -- Zone: The Veiled Stair (map 433)
    -- The Veiled Stair (map 433 50.60,40.40) -> The Veiled Stair (map 434 63.10,86.40) via floor
    {
        fromPointID = 500150,
        fromMap = 433,
        fromX = 0.506,
        fromY = 0.404,
        toPointID = 500157,
        toMap = 434,
        toX = 0.631,
        toY = 0.864,
        type = "floor",
    },
    -- The Veiled Stair (map 433 57.30,13.60) -> The Veiled Stair (map 434 77.60,36.70) via floor
    {
        fromPointID = 500154,
        fromMap = 433,
        fromX = 0.573,
        fromY = 0.136,
        toPointID = 500158,
        toMap = 434,
        toX = 0.776,
        toY = 0.367,
        type = "floor",
    },

    -- Zone: The Venomous Abyss (map 2606)
    -- The Venomous Abyss (map 2606 50.00,14.50) -> The Venomous Abyss (map 2607 49.98,90.66) via floor
    {
        fromPointID = 200873,
        fromMap = 2606,
        fromX = 0.5,
        fromY = 0.145,
        toPointID = 200876,
        toMap = 2607,
        toX = 0.4998,
        toY = 0.9066,
        type = "floor",
    },

    -- Zone: The Venomous Abyss (map 2607)
    -- The Venomous Abyss (map 2607 42.32,63.59) -> The Venomous Abyss (map 2609 79.08,33.54) via floor
    {
        fromPointID = 200874,
        fromMap = 2607,
        fromX = 0.4232,
        fromY = 0.6359,
        toPointID = 200879,
        toMap = 2609,
        toX = 0.7908,
        toY = 0.3354,
        type = "floor",
    },
    -- The Venomous Abyss (map 2607 49.92,46.83) -> The Venomous Abyss (map 2610 49.55,93.08) via floor
    {
        fromPointID = 200875,
        fromMap = 2607,
        fromX = 0.4992,
        fromY = 0.4683,
        toPointID = 200880,
        toMap = 2610,
        toX = 0.4955,
        toY = 0.9308,
        type = "floor",
    },
    -- The Venomous Abyss (map 2607 49.98,90.66) -> The Venomous Abyss (map 2606 50.00,14.50) via floor
    {
        fromPointID = 200876,
        fromMap = 2607,
        fromX = 0.4998,
        fromY = 0.9066,
        toPointID = 200873,
        toMap = 2606,
        toX = 0.5,
        toY = 0.145,
        type = "floor",
    },
    -- The Venomous Abyss (map 2607 57.63,63.76) -> The Venomous Abyss (map 2608 27.19,32.64) via floor
    {
        fromPointID = 200877,
        fromMap = 2607,
        fromX = 0.5763,
        fromY = 0.6376,
        toPointID = 200878,
        toMap = 2608,
        toX = 0.2719,
        toY = 0.3264,
        type = "floor",
    },

    -- Zone: The Venomous Abyss (map 2608)
    -- The Venomous Abyss (map 2608 27.19,32.64) -> The Venomous Abyss (map 2607 57.63,63.76) via floor
    {
        fromPointID = 200878,
        fromMap = 2608,
        fromX = 0.2719,
        fromY = 0.3264,
        toPointID = 200877,
        toMap = 2607,
        toX = 0.5763,
        toY = 0.6376,
        type = "floor",
    },

    -- Zone: The Venomous Abyss (map 2609)
    -- The Venomous Abyss (map 2609 79.08,33.54) -> The Venomous Abyss (map 2607 42.32,63.59) via floor
    {
        fromPointID = 200879,
        fromMap = 2609,
        fromX = 0.7908,
        fromY = 0.3354,
        toPointID = 200874,
        toMap = 2607,
        toX = 0.4232,
        toY = 0.6359,
        type = "floor",
    },

    -- Zone: The Venomous Abyss (map 2610)
    -- The Venomous Abyss (map 2610 49.55,93.08) -> The Venomous Abyss (map 2607 49.92,46.83) via floor
    {
        fromPointID = 200880,
        fromMap = 2610,
        fromX = 0.4955,
        fromY = 0.9308,
        toPointID = 200875,
        toMap = 2607,
        toX = 0.4992,
        toY = 0.4683,
        type = "floor",
    },

    -- Zone: The Venture Co. Mine (map 9)
    -- Mulgore (map 9 28.50,65.33) -> Mulgore (map 7 59.19,44.16) via floor
    {
        fromPointID = 100044,
        fromMap = 9,
        fromX = 0.285,
        fromY = 0.6533,
        toPointID = 100038,
        toMap = 7,
        toX = 0.5919,
        toY = 0.4416,
        type = "floor",
    },
    -- Mulgore (map 9 29.55,13.58) -> Mulgore (map 7 59.19,36.39) via floor
    {
        fromPointID = 100045,
        fromMap = 9,
        fromX = 0.2955,
        fromY = 0.1358,
        toPointID = 100037,
        toMap = 7,
        toX = 0.5919,
        toY = 0.3639,
        type = "floor",
    },
    -- Mulgore (map 9 40.15,89.72) -> Mulgore (map 7 60.74,47.59) via floor
    {
        fromPointID = 100046,
        fromMap = 9,
        fromX = 0.4015,
        fromY = 0.8972,
        toPointID = 100039,
        toMap = 7,
        toX = 0.6074,
        toY = 0.4759,
        type = "floor",
    },

    -- Zone: The Voidspire (map 2529)
    -- The Voidspire (map 2529 66.76,29.41) -> The Voidspire (map 2530 47.15,51.00) via floor
    {
        fromPointID = 200821,
        fromMap = 2529,
        fromX = 0.6676,
        fromY = 0.2941,
        toPointID = 200822,
        toMap = 2530,
        toX = 0.4715,
        toY = 0.51,
        type = "floor",
    },

    -- Zone: The Voidspire (map 2530)
    -- The Voidspire (map 2530 47.15,51.00) -> The Voidspire (map 2529 66.76,29.41) via floor
    {
        fromPointID = 200822,
        fromMap = 2530,
        fromX = 0.4715,
        fromY = 0.51,
        toPointID = 200821,
        toMap = 2529,
        toX = 0.6676,
        toY = 0.2941,
        type = "floor",
    },

    -- Zone: The War Creche (map 2102)
    -- The War Creche (map 2102 67.49,4.60) -> The Forbidden Reach (map 2151 51.84,60.19) via floor
    {
        fromPointID = 1100106,
        fromMap = 2102,
        fromX = 0.6749,
        fromY = 0.046,
        toPointID = 1100162,
        toMap = 2151,
        toX = 0.5184,
        toY = 0.6019,
        type = "floor",
    },

    -- Zone: Theater of Pain (map 1683)
    -- Theater of Pain (map 1683 50.74,47.35) -> Theater of Pain (map 1684 31.97,34.33) via floor
    {
        fromPointID = 1000209,
        fromMap = 1683,
        fromX = 0.5074,
        fromY = 0.4735,
        toPointID = 1000211,
        toMap = 1684,
        toX = 0.3197,
        toY = 0.3433,
        type = "floor",
    },

    -- Zone: Theater of Pain (map 1684)
    -- Theater of Pain (map 1684 22.05,28.87) -> Theater of Pain (map 1686 81.47,69.58) via floor
    {
        fromPointID = 1000210,
        fromMap = 1684,
        fromX = 0.2205,
        fromY = 0.2887,
        toPointID = 1000215,
        toMap = 1686,
        toX = 0.8147,
        toY = 0.6958,
        type = "floor",
    },
    -- Theater of Pain (map 1684 31.97,34.33) -> Theater of Pain (map 1683 50.74,47.35) via floor
    {
        fromPointID = 1000211,
        fromMap = 1684,
        fromX = 0.3197,
        fromY = 0.3433,
        toPointID = 1000209,
        toMap = 1683,
        toX = 0.5074,
        toY = 0.4735,
        type = "floor",
    },
    -- Theater of Pain (map 1684 32.21,16.39) -> Theater of Pain (map 1685 71.07,90.39) via floor
    {
        fromPointID = 1000212,
        fromMap = 1684,
        fromX = 0.3221,
        fromY = 0.1639,
        toPointID = 1000213,
        toMap = 1685,
        toX = 0.7107,
        toY = 0.9039,
        type = "floor",
    },

    -- Zone: Theater of Pain (map 1685)
    -- Theater of Pain (map 1685 71.07,90.39) -> Theater of Pain (map 1684 32.21,16.39) via floor
    {
        fromPointID = 1000213,
        fromMap = 1685,
        fromX = 0.7107,
        fromY = 0.9039,
        toPointID = 1000212,
        toMap = 1684,
        toX = 0.3221,
        toY = 0.1639,
        type = "floor",
    },

    -- Zone: Theater of Pain (map 1686)
    -- Theater of Pain (map 1686 25.39,22.24) -> Theater of Pain (map 1687 24.92,23.74) via floor
    {
        fromPointID = 1000214,
        fromMap = 1686,
        fromX = 0.2539,
        fromY = 0.2224,
        toPointID = 1000216,
        toMap = 1687,
        toX = 0.2492,
        toY = 0.2374,
        type = "floor",
    },
    -- Theater of Pain (map 1686 81.47,69.58) -> Theater of Pain (map 1684 22.05,28.87) via floor
    {
        fromPointID = 1000215,
        fromMap = 1686,
        fromX = 0.8147,
        fromY = 0.6958,
        toPointID = 1000210,
        toMap = 1684,
        toX = 0.2205,
        toY = 0.2887,
        type = "floor",
    },

    -- Zone: Theater of Pain (map 1687)
    -- Theater of Pain (map 1687 24.92,23.74) -> Theater of Pain (map 1686 25.39,22.24) via floor
    {
        fromPointID = 1000216,
        fromMap = 1687,
        fromX = 0.2492,
        fromY = 0.2374,
        toPointID = 1000214,
        toMap = 1686,
        toX = 0.2539,
        toY = 0.2224,
        type = "floor",
    },

    -- Zone: Third Chamber of Kalliope (map 1714)
    -- Third Chamber of Kalliope (map 1714 25.68,88.78) -> Bastion (map 1533 43.52,38.60) via floor
    {
        fromPointID = 1000275,
        fromMap = 1714,
        fromX = 0.2568,
        fromY = 0.8878,
        toPointID = 1000037,
        toMap = 1533,
        toX = 0.4352,
        toY = 0.386,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57875,
                },
                {
                    operation = "check",
                    kind = "questCompleted",
                    value = 57914,
                },
            },
        },
    },

    -- Zone: Throne of Thunder (map 508)
    -- Throne of Thunder (map 508 83.40,79.60) -> Throne of Thunder (map 509 14.80,78.90) via floor
    {
        fromPointID = 500235,
        fromMap = 508,
        fromX = 0.834,
        fromY = 0.796,
        toPointID = 500236,
        toMap = 509,
        toX = 0.148,
        toY = 0.789,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 509)
    -- Throne of Thunder (map 509 14.80,78.90) -> Throne of Thunder (map 508 83.40,79.60) via floor
    {
        fromPointID = 500236,
        fromMap = 509,
        fromX = 0.148,
        fromY = 0.789,
        toPointID = 500235,
        toMap = 508,
        toX = 0.834,
        toY = 0.796,
        type = "floor",
    },
    -- Throne of Thunder (map 509 72.90,20.01) -> Throne of Thunder (map 510 20.70,82.15) via floor
    {
        fromPointID = 500237,
        fromMap = 509,
        fromX = 0.729,
        fromY = 0.2001,
        toPointID = 500238,
        toMap = 510,
        toX = 0.207,
        toY = 0.8215,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 510)
    -- Throne of Thunder (map 510 20.70,82.15) -> Throne of Thunder (map 509 72.90,20.01) via floor
    {
        fromPointID = 500238,
        fromMap = 510,
        fromX = 0.207,
        fromY = 0.8215,
        toPointID = 500237,
        toMap = 509,
        toX = 0.729,
        toY = 0.2001,
        type = "floor",
    },
    -- Throne of Thunder (map 510 73.10,53.20) -> Throne of Thunder (map 511 21.90,21.10) via floor
    {
        fromPointID = 500239,
        fromMap = 510,
        fromX = 0.731,
        fromY = 0.532,
        toPointID = 500240,
        toMap = 511,
        toX = 0.219,
        toY = 0.211,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 511)
    -- Throne of Thunder (map 511 21.90,21.10) -> Throne of Thunder (map 510 73.10,53.20) via floor
    {
        fromPointID = 500240,
        fromMap = 511,
        fromX = 0.219,
        fromY = 0.211,
        toPointID = 500239,
        toMap = 510,
        toX = 0.731,
        toY = 0.532,
        type = "floor",
    },
    -- Throne of Thunder (map 511 34.00,59.00) -> Throne of Thunder (map 512 80.20,7.80) via floor
    {
        fromPointID = 500241,
        fromMap = 511,
        fromX = 0.34,
        fromY = 0.59,
        toPointID = 500243,
        toMap = 512,
        toX = 0.802,
        toY = 0.078,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 512)
    -- Throne of Thunder (map 512 46.64,22.87) -> Throne of Thunder (map 513 20.44,64.75) via floor
    {
        fromPointID = 500242,
        fromMap = 512,
        fromX = 0.4664,
        fromY = 0.2287,
        toPointID = 500244,
        toMap = 513,
        toX = 0.2044,
        toY = 0.6475,
        type = "floor",
    },
    -- Throne of Thunder (map 512 80.20,7.80) -> Throne of Thunder (map 511 34.00,59.00) via floor
    {
        fromPointID = 500243,
        fromMap = 512,
        fromX = 0.802,
        fromY = 0.078,
        toPointID = 500241,
        toMap = 511,
        toX = 0.34,
        toY = 0.59,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 513)
    -- Throne of Thunder (map 513 20.44,64.75) -> Throne of Thunder (map 512 46.64,22.87) via floor
    {
        fromPointID = 500244,
        fromMap = 513,
        fromX = 0.2044,
        fromY = 0.6475,
        toPointID = 500242,
        toMap = 512,
        toX = 0.4664,
        toY = 0.2287,
        type = "floor",
    },
    -- Throne of Thunder (map 513 88.13,74.91) -> Throne of Thunder (map 514 45.97,10.54) via floor
    {
        fromPointID = 500245,
        fromMap = 513,
        fromX = 0.8813,
        fromY = 0.7491,
        toPointID = 500246,
        toMap = 514,
        toX = 0.4597,
        toY = 0.1054,
        type = "floor",
    },

    -- Zone: Throne of Thunder (map 514)
    -- Throne of Thunder (map 514 45.97,10.54) -> Throne of Thunder (map 513 88.13,74.91) via floor
    {
        fromPointID = 500246,
        fromMap = 514,
        fromX = 0.4597,
        fromY = 0.1054,
        toPointID = 500245,
        toMap = 513,
        toX = 0.8813,
        toY = 0.7491,
        type = "floor",
    },

    -- Zone: Throne of the Tides (map 322)
    -- Throne of the Tides (map 322 48.90,82.10) -> Throne of the Tides (map 323 51.00,53.00) via floor
    {
        fromPointID = 200549,
        fromMap = 322,
        fromX = 0.489,
        fromY = 0.821,
        toPointID = 200553,
        toMap = 323,
        toX = 0.51,
        toY = 0.53,
        type = "floor",
    },
    -- Throne of the Tides (map 322 50.00,39.70) -> Throne of the Tides (map 323 50.00,90.10) via floor
    {
        fromPointID = 200551,
        fromMap = 322,
        fromX = 0.5,
        fromY = 0.397,
        toPointID = 200552,
        toMap = 323,
        toX = 0.5,
        toY = 0.901,
        type = "floor",
    },

    -- Zone: Throne of the Tides (map 323)
    -- Throne of the Tides (map 323 50.00,90.10) -> Throne of the Tides (map 322 50.00,39.70) via floor
    {
        fromPointID = 200552,
        fromMap = 323,
        fromX = 0.5,
        fromY = 0.901,
        toPointID = 200551,
        toMap = 322,
        toX = 0.5,
        toY = 0.397,
        type = "floor",
    },
    -- Throne of the Tides (map 323 51.00,53.00) -> Throne of the Tides (map 322 48.90,82.10) via floor
    {
        fromPointID = 200553,
        fromMap = 323,
        fromX = 0.51,
        fromY = 0.53,
        toPointID = 200549,
        toMap = 322,
        toX = 0.489,
        toY = 0.821,
        type = "floor",
    },

    -- Zone: Tides' Hollow (map 98)
    -- Azuremyst Isle (map 98 58.76,85.37) -> Azuremyst Isle (map 97 27.01,76.61) via floor
    {
        fromPointID = 100310,
        fromMap = 98,
        fromX = 0.5876,
        fromY = 0.8537,
        toPointID = 100305,
        toMap = 97,
        toX = 0.2701,
        toY = 0.7661,
        type = "floor",
    },

    -- Zone: Timeless Isle (map 554)
    -- Timeless Isle (map 554 43.30,40.80) -> Timeless Isle (map 555 44.40,81.00) via floor
    {
        fromPointID = 500262,
        fromMap = 554,
        fromX = 0.433,
        fromY = 0.408,
        toPointID = 500263,
        toMap = 555,
        toX = 0.444,
        toY = 0.81,
        type = "floor",
    },

    -- Zone: Tiragarde Keep (map 3)
    -- Durotar (map 3 34.55,52.42) -> Durotar (map 1 58.94,58.31) via floor
    {
        fromPointID = 100022,
        fromMap = 3,
        fromX = 0.3455,
        fromY = 0.5242,
        toPointID = 100017,
        toMap = 1,
        toX = 0.5894,
        toY = 0.5831,
        type = "floor",
    },
    -- Durotar (map 3 42.89,29.82) -> Durotar (map 4 33.16,37.87) via floor
    {
        fromPointID = 100023,
        fromMap = 3,
        fromX = 0.4289,
        fromY = 0.2982,
        toPointID = 100025,
        toMap = 4,
        toX = 0.3316,
        toY = 0.3787,
        type = "floor",
    },
    -- Durotar (map 3 56.68,19.13) -> Durotar (map 4 64.23,26.68) via floor
    {
        fromPointID = 100024,
        fromMap = 3,
        fromX = 0.5668,
        fromY = 0.1913,
        toPointID = 100027,
        toMap = 4,
        toX = 0.6423,
        toY = 0.2668,
        type = "floor",
    },

    -- Zone: Tiragarde Keep (map 4)
    -- Durotar (map 4 33.16,37.87) -> Durotar (map 3 42.89,29.82) via floor
    {
        fromPointID = 100025,
        fromMap = 4,
        fromX = 0.3316,
        fromY = 0.3787,
        toPointID = 100023,
        toMap = 3,
        toX = 0.4289,
        toY = 0.2982,
        type = "floor",
    },
    -- Durotar (map 4 58.23,21.18) -> Durotar (map 1 59.65,57.68) via floor
    {
        fromPointID = 100026,
        fromMap = 4,
        fromX = 0.5823,
        fromY = 0.2118,
        toPointID = 100018,
        toMap = 1,
        toX = 0.5965,
        toY = 0.5768,
        type = "floor",
    },
    -- Durotar (map 4 64.23,26.68) -> Durotar (map 3 56.68,19.13) via floor
    {
        fromPointID = 100027,
        fromMap = 4,
        fromX = 0.6423,
        fromY = 0.2668,
        toPointID = 100024,
        toMap = 3,
        toX = 0.5668,
        toY = 0.1913,
        type = "floor",
    },

    -- Zone: Tiragarde Sound (map 895)
    -- Tiragarde Sound (map 895 62.88,27.37) -> Tiragarde Sound (map 1171 44.28,88.13) via floor
    {
        fromPointID = 800003,
        fromMap = 895,
        fromX = 0.6288,
        fromY = 0.2737,
        toPointID = 800095,
        toMap = 1171,
        toX = 0.4428,
        toY = 0.8813,
        type = "floor",
    },
    -- Tiragarde Sound (map 895 78.77,53.26) -> Tiragarde Sound (map 1184 39.98,34.23) via floor
    {
        fromPointID = 800013,
        fromMap = 895,
        fromX = 0.7877,
        fromY = 0.5326,
        toPointID = 800098,
        toMap = 1184,
        toX = 0.3998,
        toY = 0.3423,
        type = "floor",
    },

    -- Zone: Tirisfal Glades (map 18)
    -- Tirisfal Glades (map 18 30.33,72.86) -> Deathknell (map 465 44.56,82.68) via floor
    {
        fromPointID = 200040,
        fromMap = 18,
        fromX = 0.3033,
        fromY = 0.7286,
        toPointID = 200607,
        toMap = 465,
        toX = 0.4456,
        toY = 0.8268,
        type = "floor",
    },
    -- Tirisfal Glades (map 18 82.30,32.60) -> Tirisfal Glades (map 19 14.50,73.10) via floor
    {
        fromPointID = 200054,
        fromMap = 18,
        fromX = 0.823,
        fromY = 0.326,
        toPointID = 200057,
        toMap = 19,
        toX = 0.145,
        toY = 0.731,
        type = "floor",
    },
    -- Tirisfal Glades (map 18 82.60,33.50) -> Tirisfal Glades (map 19 17.30,82.90) via floor
    {
        fromPointID = 200055,
        fromMap = 18,
        fromX = 0.826,
        fromY = 0.335,
        toPointID = 200058,
        toMap = 19,
        toX = 0.173,
        toY = 0.829,
        type = "floor",
    },

    -- Zone: Tomb of Conquerors (map 385)
    -- Kun-Lai Summit (map 385 59.39,86.63) -> Kun-Lai Summit (map 379 50.64,49.84) via floor
    {
        fromPointID = 500080,
        fromMap = 385,
        fromX = 0.5939,
        fromY = 0.8663,
        toPointID = 500059,
        toMap = 379,
        toX = 0.5064,
        toY = 0.4984,
        type = "floor",
    },
    -- Kun-Lai Summit (map 385 88.30,54.80) -> Kun-Lai Summit (map 379 53.00,46.50) via floor
    {
        fromPointID = 500081,
        fromMap = 385,
        fromX = 0.883,
        fromY = 0.548,
        toPointID = 500061,
        toMap = 379,
        toX = 0.53,
        toY = 0.465,
        type = "floor",
    },

    -- Zone: Tomb of the Lost Priest (map 2642)
    -- Tomb of the Lost Priest (map 2642 52.20,79.92) -> The Coiled Isle (map 2512 52.42,43.00) via floor
    {
        fromPointID = 200899,
        fromMap = 2642,
        fromX = 0.522,
        fromY = 0.7992,
        toPointID = 200790,
        toMap = 2512,
        toX = 0.5242,
        toY = 0.43,
        type = "floor",
    },

    -- Zone: Townlong Steppes (map 388)
    -- Townlong Steppes (map 388 33.02,61.24) -> Townlong Steppes (map 389 20.15,68.46) via floor
    {
        fromPointID = 500085,
        fromMap = 388,
        fromX = 0.3302,
        fromY = 0.6124,
        toPointID = 500105,
        toMap = 389,
        toX = 0.2015,
        toY = 0.6846,
        type = "floor",
    },

    -- Zone: Trial of the Crusader (map 172)
    -- Trial of the Crusader (map 172 51.40,52.40) -> Trial of the Crusader (map 173 52.50,73.50) via floor
    {
        fromPointID = 400208,
        fromMap = 172,
        fromX = 0.514,
        fromY = 0.524,
        toPointID = 400210,
        toMap = 173,
        toX = 0.525,
        toY = 0.735,
        type = "floor",
    },

    -- Zone: Trueshot Lodge (map 739)
    -- Trueshot Lodge (map 739 42.72,9.98) -> Highmountain (map 650 36.13,44.71) via floor
    {
        fromPointID = 700264,
        fromMap = 739,
        fromX = 0.4272,
        fromY = 0.0998,
        toPointID = 700129,
        toMap = 650,
        toX = 0.3613,
        toY = 0.4471,
        type = "floor",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "class",
                    value = "HUNTER",
                },
                {
                    operation = "check",
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },

    -- Zone: Twilight Crypts (map 2503)
    -- Twilight Crypts (map 2503 49.16,89.38) -> Twilight Crypts (map 2504 74.99,41.51) via floor
    {
        fromPointID = 200752,
        fromMap = 2503,
        fromX = 0.4916,
        fromY = 0.8938,
        toPointID = 200753,
        toMap = 2504,
        toX = 0.7499,
        toY = 0.4151,
        type = "floor",
    },

    -- Zone: Twilight Crypts (map 2504)
    -- Twilight Crypts (map 2504 74.99,41.51) -> Twilight Crypts (map 2503 49.16,89.38) via floor
    {
        fromPointID = 200753,
        fromMap = 2504,
        fromX = 0.7499,
        fromY = 0.4151,
        toPointID = 200752,
        toMap = 2503,
        toX = 0.4916,
        toY = 0.8938,
        type = "floor",
    },

    -- Zone: Twilight Depths (map 208)
    -- Deepholm (map 208 37.42,23.93) -> Deepholm (map 207 62.60,78.56) via floor
    {
        fromPointID = 1300018,
        fromMap = 208,
        fromX = 0.3742,
        fromY = 0.2393,
        toPointID = 1300017,
        toMap = 207,
        toX = 0.626,
        toY = 0.7856,
        type = "floor",
    },

    -- Zone: Twilight's Run (map 82)
    -- Silithus (map 82 15.10,70.00) -> Silithus (map 81 70.40,15.90) via floor
    {
        fromPointID = 100248,
        fromMap = 82,
        fromX = 0.151,
        fromY = 0.7,
        toPointID = 100245,
        toMap = 81,
        toX = 0.704,
        toY = 0.159,
        type = "floor",
    },

    -- Zone: Twisting Approach (map 2196)
    -- Dawn of the Infinite (map 2196 37.59,86.44) -> Dawn of the Infinite (map 2197 67.12,89.67) via floor
    {
        fromPointID = 1100192,
        fromMap = 2196,
        fromX = 0.3759,
        fromY = 0.8644,
        toPointID = 1100194,
        toMap = 2197,
        toX = 0.6712,
        toY = 0.8967,
        type = "floor",
    },
    -- Dawn of the Infinite (map 2196 59.95,20.80) -> Dawn of the Infinite (map 2195 50.86,21.59) via floor
    {
        fromPointID = 1100193,
        fromMap = 2196,
        fromX = 0.5995,
        fromY = 0.208,
        toPointID = 1100190,
        toMap = 2195,
        toX = 0.5086,
        toY = 0.2159,
        type = "floor",
    },

    -- Zone: Uldaman (map 16)
    -- Badlands (map 16 75.60,36.50) -> Badlands (map 15 41.60,11.60) via floor
    {
        fromPointID = 200033,
        fromMap = 16,
        fromX = 0.756,
        fromY = 0.365,
        toPointID = 200018,
        toMap = 15,
        toX = 0.416,
        toY = 0.116,
        type = "floor",
    },

    -- Zone: Uldaman (map 230)
    -- Uldaman (map 230 46.08,9.57) -> Uldaman (map 231 64.77,43.35) via floor
    {
        fromPointID = 200405,
        fromMap = 230,
        fromX = 0.4608,
        fromY = 0.0957,
        toPointID = 200407,
        toMap = 231,
        toX = 0.6477,
        toY = 0.4335,
        type = "floor",
    },

    -- Zone: Uldaman (map 231)
    -- Uldaman (map 231 64.77,43.35) -> Uldaman (map 230 46.08,9.57) via floor
    {
        fromPointID = 200407,
        fromMap = 231,
        fromX = 0.6477,
        fromY = 0.4335,
        toPointID = 200405,
        toMap = 230,
        toX = 0.4608,
        toY = 0.0957,
        type = "floor",
    },

    -- Zone: Uldaman: Legacy of Tyr (map 2071)
    -- Uldaman Legacy of Tyr (map 2071 28.70,14.35) -> Uldaman Legacy of Tyr (map 2072 45.41,81.22) via floor
    {
        fromPointID = 200641,
        fromMap = 2071,
        fromX = 0.287,
        fromY = 0.1435,
        toPointID = 200642,
        toMap = 2072,
        toX = 0.4541,
        toY = 0.8122,
        type = "floor",
    },

    -- Zone: Uldaman: Legacy of Tyr (map 2072)
    -- Uldaman Legacy of Tyr (map 2072 45.41,81.22) -> Uldaman Legacy of Tyr (map 2071 28.70,14.35) via floor
    {
        fromPointID = 200642,
        fromMap = 2072,
        fromX = 0.4541,
        fromY = 0.8122,
        toPointID = 200641,
        toMap = 2071,
        toX = 0.287,
        toY = 0.1435,
        type = "floor",
    },

    -- Zone: Ulduar (map 148)
    -- Ulduar (map 148 36.72,0.61) -> Ulduar (map 149 48.21,77.34) via floor
    {
        fromPointID = 400169,
        fromMap = 148,
        fromX = 0.3672,
        fromY = 0.0061,
        toPointID = 400174,
        toMap = 149,
        toX = 0.4821,
        toY = 0.7734,
        type = "floor",
    },
    -- Ulduar (map 148 37.24,1.35) -> Ulduar (map 149 54.09,78.14) via floor
    {
        fromPointID = 400171,
        fromMap = 148,
        fromX = 0.3724,
        fromY = 0.0135,
        toPointID = 400176,
        toMap = 149,
        toX = 0.5409,
        toY = 0.7814,
        type = "floor",
    },

    -- Zone: Ulduar (map 149)
    -- Ulduar (map 149 30.33,74.84) -> Ulduar (map 150 35.36,52.21) via floor
    {
        fromPointID = 400173,
        fromMap = 149,
        fromX = 0.3033,
        fromY = 0.7484,
        toPointID = 400177,
        toMap = 150,
        toX = 0.3536,
        toY = 0.5221,
        type = "floor",
    },
    -- Ulduar (map 149 48.21,77.34) -> Ulduar (map 148 36.72,0.61) via floor
    {
        fromPointID = 400174,
        fromMap = 149,
        fromX = 0.4821,
        fromY = 0.7734,
        toPointID = 400169,
        toMap = 148,
        toX = 0.3672,
        toY = 0.0061,
        type = "floor",
    },
    -- Ulduar (map 149 54.09,78.14) -> Ulduar (map 148 37.24,1.35) via floor
    {
        fromPointID = 400176,
        fromMap = 149,
        fromX = 0.5409,
        fromY = 0.7814,
        toPointID = 400171,
        toMap = 148,
        toX = 0.3724,
        toY = 0.0135,
        type = "floor",
    },

    -- Zone: Ulduar (map 150)
    -- Ulduar (map 150 35.36,52.21) -> Ulduar (map 149 30.33,74.84) via floor
    {
        fromPointID = 400177,
        fromMap = 150,
        fromX = 0.3536,
        fromY = 0.5221,
        toPointID = 400173,
        toMap = 149,
        toX = 0.3033,
        toY = 0.7484,
        type = "floor",
    },

    -- Zone: Undermine (map 2406)
    -- Liberation of Undermine (map 2406 50.62,43.11) -> Liberation of Undermine (map 2428 44.05,27.62) via floor
    {
        fromPointID = 1200175,
        fromMap = 2406,
        fromX = 0.5062,
        fromY = 0.4311,
        toPointID = 1200195,
        toMap = 2428,
        toX = 0.4405,
        toY = 0.2762,
        type = "floor",
    },
    -- Liberation of Undermine (map 2406 66.92,44.80) -> Liberation of Undermine (map 2407 16.55,53.52) via floor
    {
        fromPointID = 1200176,
        fromMap = 2406,
        fromX = 0.6692,
        fromY = 0.448,
        toPointID = 1200177,
        toMap = 2407,
        toX = 0.1655,
        toY = 0.5352,
        type = "floor",
    },

    -- Zone: Undermine (map 2407)
    -- Liberation of Undermine (map 2407 16.55,53.52) -> Liberation of Undermine (map 2406 66.92,44.80) via floor
    {
        fromPointID = 1200177,
        fromMap = 2407,
        fromX = 0.1655,
        fromY = 0.5352,
        toPointID = 1200176,
        toMap = 2406,
        toX = 0.6692,
        toY = 0.448,
        type = "floor",
    },
    -- Liberation of Undermine (map 2407 87.57,54.59) -> Liberation of Undermine (map 2408 10.45,48.60) via floor
    {
        fromPointID = 1200178,
        fromMap = 2407,
        fromX = 0.8757,
        fromY = 0.5459,
        toPointID = 1200179,
        toMap = 2408,
        toX = 0.1045,
        toY = 0.486,
        type = "floor",
    },

    -- Zone: Undermine (map 2408)
    -- Liberation of Undermine (map 2408 10.45,48.60) -> Liberation of Undermine (map 2407 87.57,54.59) via floor
    {
        fromPointID = 1200179,
        fromMap = 2408,
        fromX = 0.1045,
        fromY = 0.486,
        toPointID = 1200178,
        toMap = 2407,
        toX = 0.8757,
        toY = 0.5459,
        type = "floor",
    },
    -- Liberation of Undermine (map 2408 86.49,40.89) -> Liberation of Undermine (map 2411 50.86,13.70) via floor
    {
        fromPointID = 1200180,
        fromMap = 2408,
        fromX = 0.8649,
        fromY = 0.4089,
        toPointID = 1200183,
        toMap = 2411,
        toX = 0.5086,
        toY = 0.137,
        type = "floor",
    },

    -- Zone: Undermine (map 2409)
    -- Liberation of Undermine (map 2409 53.13,6.28) -> Liberation of Undermine (map 2411 50.77,87.61) via floor
    {
        fromPointID = 1200181,
        fromMap = 2409,
        fromX = 0.5313,
        fromY = 0.0628,
        toPointID = 1200182,
        toMap = 2411,
        toX = 0.5077,
        toY = 0.8761,
        type = "floor",
    },

    -- Zone: Undermine (map 2411)
    -- Liberation of Undermine (map 2411 50.77,87.61) -> Liberation of Undermine (map 2409 53.13,6.28) via floor
    {
        fromPointID = 1200182,
        fromMap = 2411,
        fromX = 0.5077,
        fromY = 0.8761,
        toPointID = 1200181,
        toMap = 2409,
        toX = 0.5313,
        toY = 0.0628,
        type = "floor",
    },
    -- Liberation of Undermine (map 2411 50.86,13.70) -> Liberation of Undermine (map 2408 86.49,40.89) via floor
    {
        fromPointID = 1200183,
        fromMap = 2411,
        fromX = 0.5086,
        fromY = 0.137,
        toPointID = 1200180,
        toMap = 2408,
        toX = 0.8649,
        toY = 0.4089,
        type = "floor",
    },

    -- Zone: Undermine (map 2428)
    -- Liberation of Undermine (map 2428 44.05,27.62) -> Liberation of Undermine (map 2406 50.62,43.11) via floor
    {
        fromPointID = 1200195,
        fromMap = 2428,
        fromX = 0.4405,
        fromY = 0.2762,
        toPointID = 1200175,
        toMap = 2406,
        toX = 0.5062,
        toY = 0.4311,
        type = "floor",
    },

    -- Zone: Utgarde Keep (map 133)
    -- Utgarde Keep (map 133 48.50,84.70) -> Utgarde Keep (map 134 34.80,64.50) via floor
    {
        fromPointID = 400146,
        fromMap = 133,
        fromX = 0.485,
        fromY = 0.847,
        toPointID = 400147,
        toMap = 134,
        toX = 0.348,
        toY = 0.645,
        type = "floor",
    },

    -- Zone: Utgarde Keep (map 134)
    -- Utgarde Keep (map 134 34.80,64.50) -> Utgarde Keep (map 133 48.50,84.70) via floor
    {
        fromPointID = 400147,
        fromMap = 134,
        fromX = 0.348,
        fromY = 0.645,
        toPointID = 400146,
        toMap = 133,
        toX = 0.485,
        toY = 0.847,
        type = "floor",
    },
    -- Utgarde Keep (map 134 53.50,25.30) -> Utgarde Keep (map 135 33.10,40.70) via floor
    {
        fromPointID = 400148,
        fromMap = 134,
        fromX = 0.535,
        fromY = 0.253,
        toPointID = 400149,
        toMap = 135,
        toX = 0.331,
        toY = 0.407,
        type = "floor",
    },

    -- Zone: Utgarde Keep (map 135)
    -- Utgarde Keep (map 135 33.10,40.70) -> Utgarde Keep (map 134 53.50,25.30) via floor
    {
        fromPointID = 400149,
        fromMap = 135,
        fromX = 0.331,
        fromY = 0.407,
        toPointID = 400148,
        toMap = 134,
        toX = 0.535,
        toY = 0.253,
        type = "floor",
    },

    -- Zone: Utgarde Pinnacle (map 136)
    -- Utgarde Pinnacle (map 136 31.10,75.00) -> Utgarde Pinnacle (map 137 42.30,76.60) via floor
    {
        fromPointID = 400150,
        fromMap = 136,
        fromX = 0.311,
        fromY = 0.75,
        toPointID = 400153,
        toMap = 137,
        toX = 0.423,
        toY = 0.766,
        type = "floor",
    },
    -- Utgarde Pinnacle (map 136 45.90,82.60) -> Utgarde Pinnacle (map 137 54.20,79.10) via floor
    {
        fromPointID = 400151,
        fromMap = 136,
        fromX = 0.459,
        fromY = 0.826,
        toPointID = 400155,
        toMap = 137,
        toX = 0.542,
        toY = 0.791,
        type = "floor",
    },
    -- Utgarde Pinnacle (map 136 54.70,18.00) -> Utgarde Pinnacle (map 137 59.60,34.10) via floor
    {
        fromPointID = 400152,
        fromMap = 136,
        fromX = 0.547,
        fromY = 0.18,
        toPointID = 400156,
        toMap = 137,
        toX = 0.596,
        toY = 0.341,
        type = "floor",
    },

    -- Zone: Utgarde Pinnacle (map 137)
    -- Utgarde Pinnacle (map 137 42.30,76.60) -> Utgarde Pinnacle (map 136 31.10,75.00) via floor
    {
        fromPointID = 400153,
        fromMap = 137,
        fromX = 0.423,
        fromY = 0.766,
        toPointID = 400150,
        toMap = 136,
        toX = 0.311,
        toY = 0.75,
        type = "floor",
    },
    -- Utgarde Pinnacle (map 137 54.20,79.10) -> Utgarde Pinnacle (map 136 45.90,82.60) via floor
    {
        fromPointID = 400155,
        fromMap = 137,
        fromX = 0.542,
        fromY = 0.791,
        toPointID = 400151,
        toMap = 136,
        toX = 0.459,
        toY = 0.826,
        type = "floor",
    },
    -- Utgarde Pinnacle (map 137 59.60,34.10) -> Utgarde Pinnacle (map 136 54.70,18.00) via floor
    {
        fromPointID = 400156,
        fromMap = 137,
        fromX = 0.596,
        fromY = 0.341,
        toPointID = 400152,
        toMap = 136,
        toX = 0.547,
        toY = 0.18,
        type = "floor",
    },

    -- Zone: Val'sharah (map 641)
    -- Val'sharah (map 641 45.48,34.51) -> The Dreamgrove (map 747 44.82,32.76) via floor
    {
        fromPointID = 700091,
        fromMap = 641,
        fromX = 0.4548,
        fromY = 0.3451,
        toPointID = 700266,
        toMap = 747,
        toX = 0.4482,
        toY = 0.3276,
        type = "floor",
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
                    kind = "flag",
                    value = "legionOn",
                },
            },
        },
    },

    -- Zone: Vale of Eternal Blossoms (map 390)
    -- Vale of Eternal Blossoms (map 390 22.20,26.30) -> Vale of Eternal Blossoms (map 395 54.00,88.20) via floor
    {
        fromPointID = 500110,
        fromMap = 390,
        fromX = 0.222,
        fromY = 0.263,
        toPointID = 500120,
        toMap = 395,
        toX = 0.54,
        toY = 0.882,
        type = "floor",
    },

    -- Zone: Vale of Eternal Blossoms (map 520)
    -- Dark Heart of Pandaria (map 520 43.60,70.60) -> Dark Heart of Pandaria (map 521 74.40,14.00) via floor
    {
        fromPointID = 500255,
        fromMap = 520,
        fromX = 0.436,
        fromY = 0.706,
        toPointID = 500256,
        toMap = 521,
        toX = 0.744,
        toY = 0.14,
        type = "floor",
    },

    -- Zone: Vale of Eternal Blossoms (map 521)
    -- Dark Heart of Pandaria (map 521 74.40,14.00) -> Dark Heart of Pandaria (map 520 43.60,70.60) via floor
    {
        fromPointID = 500256,
        fromMap = 521,
        fromX = 0.744,
        fromY = 0.14,
        toPointID = 500255,
        toMap = 520,
        toX = 0.436,
        toY = 0.706,
        type = "floor",
    },

    -- Zone: Valley of Trials (map 461)
    -- Valley of Trials (map 461 52.87,21.89) -> Durotar (map 1 45.35,56.32) via floor
    {
        fromPointID = 100439,
        fromMap = 461,
        fromX = 0.5287,
        fromY = 0.2189,
        toPointID = 100009,
        toMap = 1,
        toX = 0.4535,
        toY = 0.5632,
        type = "floor",
    },

    -- Zone: Vault of Eyir (map 640)
    -- Stormheim (map 640 26.43,51.00) -> Stormheim (map 634 62.82,68.11) via floor
    {
        fromPointID = 700085,
        fromMap = 640,
        fromX = 0.2643,
        fromY = 0.51,
        toPointID = 700077,
        toMap = 634,
        toX = 0.6282,
        toY = 0.6811,
        type = "floor",
    },

    -- Zone: Vault of Restless Bones (map 2636)
    -- Vault of Restless Bones (map 2636 78.95,42.07) -> Vaults of Atal'Utek (map 2509 39.47,48.22) via floor
    {
        fromPointID = 200892,
        fromMap = 2636,
        fromX = 0.7895,
        fromY = 0.4207,
        toPointID = 200759,
        toMap = 2509,
        toX = 0.3947,
        toY = 0.4822,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2119)
    -- Vault of the Incarnates (map 2119 54.34,13.61) -> Vault of the Incarnates (map 2120 86.13,33.61) via floor
    {
        fromPointID = 1100116,
        fromMap = 2119,
        fromX = 0.5434,
        fromY = 0.1361,
        toPointID = 1100120,
        toMap = 2120,
        toX = 0.8613,
        toY = 0.3361,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2119 56.97,12.52) -> Vault of the Incarnates (map 2122 73.94,94.58) via floor
    {
        fromPointID = 1100117,
        fromMap = 2119,
        fromX = 0.5697,
        fromY = 0.1252,
        toPointID = 1100127,
        toMap = 2122,
        toX = 0.7394,
        toY = 0.9458,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2119 59.87,13.44) -> Vault of the Incarnates (map 2122 82.66,90.64) via floor
    {
        fromPointID = 1100118,
        fromMap = 2119,
        fromX = 0.5987,
        fromY = 0.1344,
        toPointID = 1100129,
        toMap = 2122,
        toX = 0.8266,
        toY = 0.9064,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2120)
    -- Vault of the Incarnates (map 2120 77.52,53.16) -> Vault of the Incarnates (map 2121 30.89,55.95) via floor
    {
        fromPointID = 1100119,
        fromMap = 2120,
        fromX = 0.7752,
        fromY = 0.5316,
        toPointID = 1100121,
        toMap = 2121,
        toX = 0.3089,
        toY = 0.5595,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2120 86.13,33.61) -> Vault of the Incarnates (map 2119 54.34,13.61) via floor
    {
        fromPointID = 1100120,
        fromMap = 2120,
        fromX = 0.8613,
        fromY = 0.3361,
        toPointID = 1100116,
        toMap = 2119,
        toX = 0.5434,
        toY = 0.1361,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2121)
    -- Vault of the Incarnates (map 2121 30.89,55.95) -> Vault of the Incarnates (map 2120 77.52,53.16) via floor
    {
        fromPointID = 1100121,
        fromMap = 2121,
        fromX = 0.3089,
        fromY = 0.5595,
        toPointID = 1100119,
        toMap = 2120,
        toX = 0.7752,
        toY = 0.5316,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2122)
    -- Vault of the Incarnates (map 2122 0.00,0.00) -> Vault of the Incarnates (map 2125 0.00,0.00) via floor
    {
        fromPointID = 1100122,
        fromMap = 2122,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100134,
        toMap = 2125,
        toX = 0.0,
        toY = 0.0,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 31.25,20.80) -> Vault of the Incarnates (map 2123 58.15,24.64) via floor
    {
        fromPointID = 1100123,
        fromMap = 2122,
        fromX = 0.3125,
        fromY = 0.208,
        toPointID = 1100130,
        toMap = 2123,
        toX = 0.5815,
        toY = 0.2464,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 49.90,35.58) -> Vault of the Incarnates (map 2124 24.20,51.65) via floor
    {
        fromPointID = 1100124,
        fromMap = 2122,
        fromX = 0.499,
        fromY = 0.3558,
        toPointID = 1100131,
        toMap = 2124,
        toX = 0.242,
        toY = 0.5165,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 56.48,53.69) -> Vault of the Incarnates (map 2124 36.04,85.19) via floor
    {
        fromPointID = 1100125,
        fromMap = 2122,
        fromX = 0.5648,
        fromY = 0.5369,
        toPointID = 1100132,
        toMap = 2124,
        toX = 0.3604,
        toY = 0.8519,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 70.69,53.37) -> Vault of the Incarnates (map 2124 64.25,84.65) via floor
    {
        fromPointID = 1100126,
        fromMap = 2122,
        fromX = 0.7069,
        fromY = 0.5337,
        toPointID = 1100133,
        toMap = 2124,
        toX = 0.6425,
        toY = 0.8465,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 73.94,94.58) -> Vault of the Incarnates (map 2119 56.97,12.52) via floor
    {
        fromPointID = 1100127,
        fromMap = 2122,
        fromX = 0.7394,
        fromY = 0.9458,
        toPointID = 1100117,
        toMap = 2119,
        toX = 0.5697,
        toY = 0.1252,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 74.18,47.60) -> Vault of the Incarnates (map 2126 73.34,91.82) via floor
    {
        fromPointID = 1100128,
        fromMap = 2122,
        fromX = 0.7418,
        fromY = 0.476,
        toPointID = 1100135,
        toMap = 2126,
        toX = 0.7334,
        toY = 0.9182,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2122 82.66,90.64) -> Vault of the Incarnates (map 2119 59.87,13.44) via floor
    {
        fromPointID = 1100129,
        fromMap = 2122,
        fromX = 0.8266,
        fromY = 0.9064,
        toPointID = 1100118,
        toMap = 2119,
        toX = 0.5987,
        toY = 0.1344,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2123)
    -- Vault of the Incarnates (map 2123 58.15,24.64) -> Vault of the Incarnates (map 2122 31.25,20.80) via floor
    {
        fromPointID = 1100130,
        fromMap = 2123,
        fromX = 0.5815,
        fromY = 0.2464,
        toPointID = 1100123,
        toMap = 2122,
        toX = 0.3125,
        toY = 0.208,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2124)
    -- Vault of the Incarnates (map 2124 24.20,51.65) -> Vault of the Incarnates (map 2122 49.90,35.58) via floor
    {
        fromPointID = 1100131,
        fromMap = 2124,
        fromX = 0.242,
        fromY = 0.5165,
        toPointID = 1100124,
        toMap = 2122,
        toX = 0.499,
        toY = 0.3558,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2124 36.04,85.19) -> Vault of the Incarnates (map 2122 56.48,53.69) via floor
    {
        fromPointID = 1100132,
        fromMap = 2124,
        fromX = 0.3604,
        fromY = 0.8519,
        toPointID = 1100125,
        toMap = 2122,
        toX = 0.5648,
        toY = 0.5369,
        type = "floor",
    },
    -- Vault of the Incarnates (map 2124 64.25,84.65) -> Vault of the Incarnates (map 2122 70.69,53.37) via floor
    {
        fromPointID = 1100133,
        fromMap = 2124,
        fromX = 0.6425,
        fromY = 0.8465,
        toPointID = 1100126,
        toMap = 2122,
        toX = 0.7069,
        toY = 0.5337,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2125)
    -- Vault of the Incarnates (map 2125 0.00,0.00) -> Vault of the Incarnates (map 2122 0.00,0.00) via floor
    {
        fromPointID = 1100134,
        fromMap = 2125,
        fromX = 0.0,
        fromY = 0.0,
        toPointID = 1100122,
        toMap = 2122,
        toX = 0.0,
        toY = 0.0,
        type = "floor",
    },

    -- Zone: Vault of the Incarnates (map 2126)
    -- Vault of the Incarnates (map 2126 73.34,91.82) -> Vault of the Incarnates (map 2122 74.18,47.60) via floor
    {
        fromPointID = 1100135,
        fromMap = 2126,
        fromX = 0.7334,
        fromY = 0.9182,
        toPointID = 1100128,
        toMap = 2122,
        toX = 0.7418,
        toY = 0.476,
        type = "floor",
    },

    -- Zone: Vaults of Atal'Utek (map 2509)
    -- Vaults of Atal'Utek (map 2509 39.32,39.92) -> Ruuk'Jar's Clutch (map 2637 84.12,41.15) via floor
    {
        fromPointID = 200758,
        fromMap = 2509,
        fromX = 0.3932,
        fromY = 0.3992,
        toPointID = 200893,
        toMap = 2637,
        toX = 0.8412,
        toY = 0.4115,
        type = "floor",
    },
    -- Vaults of Atal'Utek (map 2509 39.47,48.22) -> Vault of Restless Bones (map 2636 78.95,42.07) via floor
    {
        fromPointID = 200759,
        fromMap = 2509,
        fromX = 0.3947,
        fromY = 0.4822,
        toPointID = 200892,
        toMap = 2636,
        toX = 0.7895,
        toY = 0.4207,
        type = "floor",
    },
    -- Vaults of Atal'Utek (map 2509 47.23,7.28) -> Atal'Utek Underbelly (map 2613 52.43,87.13) via floor
    {
        fromPointID = 200761,
        fromMap = 2509,
        fromX = 0.4723,
        fromY = 0.0728,
        toPointID = 200881,
        toMap = 2613,
        toX = 0.5243,
        toY = 0.8713,
        type = "floor",
    },
    -- Vaults of Atal'Utek (map 2509 51.29,82.10) -> The Coiled Isle (map 2512 45.37,64.93) via floor
    {
        fromPointID = 200765,
        fromMap = 2509,
        fromX = 0.5129,
        fromY = 0.821,
        toPointID = 200786,
        toMap = 2512,
        toX = 0.4537,
        toY = 0.6493,
        type = "floor",
    },
    -- Vaults of Atal'Utek (map 2509 54.92,48.13) -> Profaned Mausoleum (map 2638 18.30,59.99) via floor
    {
        fromPointID = 200766,
        fromMap = 2509,
        fromX = 0.5492,
        fromY = 0.4813,
        toPointID = 200894,
        toMap = 2638,
        toX = 0.183,
        toY = 0.5999,
        type = "floor",
    },

    -- Zone: Vilaldoun (map 2646)
    -- Vilaldoun (map 2646 70.03,22.76) -> Naigtal (map 2600 28.10,50.66) via floor
    {
        fromPointID = 200903,
        fromMap = 2646,
        fromX = 0.7003,
        fromY = 0.2276,
        toPointID = 200869,
        toMap = 2600,
        toX = 0.281,
        toY = 0.5066,
        type = "floor",
    },

    -- Zone: Void Acropolis (map 2617)
    -- Void Acropolis (map 2617 86.36,75.06) -> Void Acropolis (map 2618 75.15,71.39) via floor
    {
        fromPointID = 200882,
        fromMap = 2617,
        fromX = 0.8636,
        fromY = 0.7506,
        toPointID = 200884,
        toMap = 2618,
        toX = 0.7515,
        toY = 0.7139,
        type = "floor",
    },

    -- Zone: Void Acropolis (map 2618)
    -- Void Acropolis (map 2618 75.15,71.39) -> Void Acropolis (map 2617 86.36,75.06) via floor
    {
        fromPointID = 200884,
        fromMap = 2618,
        fromX = 0.7515,
        fromY = 0.7139,
        toPointID = 200882,
        toMap = 2617,
        toX = 0.8636,
        toY = 0.7506,
        type = "floor",
    },

    -- Zone: Voidburrow (map 2581)
    -- Voidburrow (map 2581 30.87,29.57) -> Voidburrow (map 2582 29.55,18.35) via floor
    {
        fromPointID = 200852,
        fromMap = 2581,
        fromX = 0.3087,
        fromY = 0.2957,
        toPointID = 200854,
        toMap = 2582,
        toX = 0.2955,
        toY = 0.1835,
        type = "floor",
    },
    -- Voidburrow (map 2581 54.54,21.62) -> Voidburrow (map 2582 42.98,16.41) via floor
    {
        fromPointID = 200853,
        fromMap = 2581,
        fromX = 0.5454,
        fromY = 0.2162,
        toPointID = 200856,
        toMap = 2582,
        toX = 0.4298,
        toY = 0.1641,
        type = "floor",
    },

    -- Zone: Voidburrow (map 2582)
    -- Voidburrow (map 2582 29.55,18.35) -> Voidburrow (map 2581 30.87,29.57) via floor
    {
        fromPointID = 200854,
        fromMap = 2582,
        fromX = 0.2955,
        fromY = 0.1835,
        toPointID = 200852,
        toMap = 2581,
        toX = 0.3087,
        toY = 0.2957,
        type = "floor",
    },
    -- Voidburrow (map 2582 42.39,23.20) -> Voidstorm (map 2405 39.06,53.36) via floor
    {
        fromPointID = 200855,
        fromMap = 2582,
        fromX = 0.4239,
        fromY = 0.232,
        toPointID = 200684,
        toMap = 2405,
        toX = 0.3906,
        toY = 0.5336,
        type = "floor",
    },
    -- Voidburrow (map 2582 42.98,16.41) -> Voidburrow (map 2581 54.54,21.62) via floor
    {
        fromPointID = 200856,
        fromMap = 2582,
        fromX = 0.4298,
        fromY = 0.1641,
        toPointID = 200853,
        toMap = 2581,
        toX = 0.5454,
        toY = 0.2162,
        type = "floor",
    },

    -- Zone: Voidscar Arena (map 2572)
    -- Voidscar Arena (map 2572 41.30,41.97) -> Voidscar Arena (map 2574 39.02,30.38) via floor
    {
        fromPointID = 200838,
        fromMap = 2572,
        fromX = 0.413,
        fromY = 0.4197,
        toPointID = 200843,
        toMap = 2574,
        toX = 0.3902,
        toY = 0.3038,
        type = "floor",
    },
    -- Voidscar Arena (map 2572 48.83,29.41) -> Voidscar Arena (map 2573 47.99,97.05) via floor
    {
        fromPointID = 200839,
        fromMap = 2572,
        fromX = 0.4883,
        fromY = 0.2941,
        toPointID = 200841,
        toMap = 2573,
        toX = 0.4799,
        toY = 0.9705,
        type = "floor",
    },
    -- Voidscar Arena (map 2572 55.76,41.79) -> Voidscar Arena (map 2574 59.23,30.56) via floor
    {
        fromPointID = 200840,
        fromMap = 2572,
        fromX = 0.5576,
        fromY = 0.4179,
        toPointID = 200844,
        toMap = 2574,
        toX = 0.5923,
        toY = 0.3056,
        type = "floor",
    },

    -- Zone: Voidscar Arena (map 2573)
    -- Voidscar Arena (map 2573 47.99,97.05) -> Voidscar Arena (map 2572 48.83,29.41) via floor
    {
        fromPointID = 200841,
        fromMap = 2573,
        fromX = 0.4799,
        fromY = 0.9705,
        toPointID = 200839,
        toMap = 2572,
        toX = 0.4883,
        toY = 0.2941,
        type = "floor",
    },

    -- Zone: Voidscar Arena (map 2574)
    -- Voidscar Arena (map 2574 39.02,30.38) -> Voidscar Arena (map 2572 41.30,41.97) via floor
    {
        fromPointID = 200843,
        fromMap = 2574,
        fromX = 0.3902,
        fromY = 0.3038,
        toPointID = 200838,
        toMap = 2572,
        toX = 0.413,
        toY = 0.4197,
        type = "floor",
    },
    -- Voidscar Arena (map 2574 59.23,30.56) -> Voidscar Arena (map 2572 55.76,41.79) via floor
    {
        fromPointID = 200844,
        fromMap = 2574,
        fromX = 0.5923,
        fromY = 0.3056,
        toPointID = 200840,
        toMap = 2572,
        toX = 0.5576,
        toY = 0.4179,
        type = "floor",
    },

    -- Zone: Voidstorm (map 2405)
    -- Voidstorm (map 2405 39.06,53.36) -> Voidburrow (map 2582 42.39,23.20) via floor
    {
        fromPointID = 200684,
        fromMap = 2405,
        fromX = 0.3906,
        fromY = 0.5336,
        toPointID = 200855,
        toMap = 2582,
        toX = 0.4239,
        toY = 0.232,
        type = "floor",
    },
    -- Voidstorm (map 2405 48.14,78.63) -> Lair of Predaxas (map 2526 60.00,17.51) via floor
    {
        fromPointID = 200687,
        fromMap = 2405,
        fromX = 0.4814,
        fromY = 0.7863,
        toPointID = 200814,
        toMap = 2526,
        toX = 0.6,
        toY = 0.1751,
        type = "floor",
    },

    -- Zone: Volcanoth's Lair (map 176)
    -- The Lost Isles (map 176 50.00,10.80) -> The Lost Isles (map 174 70.00,48.00) via floor
    {
        fromPointID = 1300004,
        fromMap = 176,
        fromX = 0.5,
        fromY = 0.108,
        toPointID = 1300002,
        toMap = 174,
        toX = 0.7,
        toY = 0.48,
        type = "floor",
    },

    -- Zone: Wailing Caverns (map 11)
    -- Northern Barrens (map 11 22.61,87.96) -> Northern Barrens (map 10 38.97,69.42) via floor
    {
        fromPointID = 100054,
        fromMap = 11,
        fromX = 0.2261,
        fromY = 0.8796,
        toPointID = 100050,
        toMap = 10,
        toX = 0.3897,
        toY = 0.6942,
        type = "floor",
    },

    -- Zone: Wartha'nan Crypts (map 2579)
    -- Wartha'nan Crypts (map 2579 88.60,34.75) -> Eversong Woods M (map 2395 56.76,65.79) via floor
    {
        fromPointID = 200850,
        fromMap = 2579,
        fromX = 0.886,
        fromY = 0.3475,
        toPointID = 200677,
        toMap = 2395,
        toX = 0.5676,
        toY = 0.6579,
        type = "floor",
    },

    -- Zone: Westfall (map 52)
    -- Westfall (map 52 42.50,71.80) -> Westfall (map 55 69.30,23.70) via floor
    {
        fromPointID = 200251,
        fromMap = 52,
        fromX = 0.425,
        fromY = 0.718,
        toPointID = 200259,
        toMap = 55,
        toX = 0.693,
        toY = 0.237,
        type = "floor",
    },
    -- Westfall (map 52 44.50,24.70) -> Westfall (map 54 41.10,94.10) via floor
    {
        fromPointID = 200252,
        fromMap = 52,
        fromX = 0.445,
        fromY = 0.247,
        toPointID = 200256,
        toMap = 54,
        toX = 0.411,
        toY = 0.941,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2492)
    -- Windrunner Spire (map 2492 58.51,20.98) -> Windrunner Spire (map 2493 36.27,33.25) via floor
    {
        fromPointID = 200732,
        fromMap = 2492,
        fromX = 0.5851,
        fromY = 0.2098,
        toPointID = 200734,
        toMap = 2493,
        toX = 0.3627,
        toY = 0.3325,
        type = "floor",
    },
    -- Windrunner Spire (map 2492 58.51,20.98) -> Windrunner Spire (map 2494 84.70,42.14) via floor
    {
        fromPointID = 200732,
        fromMap = 2492,
        fromX = 0.5851,
        fromY = 0.2098,
        toPointID = 200738,
        toMap = 2494,
        toX = 0.847,
        toY = 0.4214,
        type = "floor",
    },
    -- Windrunner Spire (map 2492 59.47,86.62) -> Windrunner Spire (map 2496 36.99,71.74) via floor
    {
        fromPointID = 200733,
        fromMap = 2492,
        fromX = 0.5947,
        fromY = 0.8662,
        toPointID = 200739,
        toMap = 2496,
        toX = 0.3699,
        toY = 0.7174,
        type = "floor",
    },
    -- Windrunner Spire (map 2492 59.47,86.62) -> Windrunner Spire (map 2497 46.08,87.41) via floor
    {
        fromPointID = 200733,
        fromMap = 2492,
        fromX = 0.5947,
        fromY = 0.8662,
        toPointID = 200742,
        toMap = 2497,
        toX = 0.4608,
        toY = 0.8741,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2493)
    -- Windrunner Spire (map 2493 36.27,33.25) -> Windrunner Spire (map 2492 58.51,20.98) via floor
    {
        fromPointID = 200734,
        fromMap = 2493,
        fromX = 0.3627,
        fromY = 0.3325,
        toPointID = 200732,
        toMap = 2492,
        toX = 0.5851,
        toY = 0.2098,
        type = "floor",
    },
    -- Windrunner Spire (map 2493 48.47,82.39) -> Windrunner Spire (map 2494 42.49,85.72) via floor
    {
        fromPointID = 200735,
        fromMap = 2493,
        fromX = 0.4847,
        fromY = 0.8239,
        toPointID = 200737,
        toMap = 2494,
        toX = 0.4249,
        toY = 0.8572,
        type = "floor",
    },
    -- Windrunner Spire (map 2493 50.05,86.26) -> Windrunner Spire (map 2498 73.34,22.13) via floor
    {
        fromPointID = 200736,
        fromMap = 2493,
        fromX = 0.5005,
        fromY = 0.8626,
        toPointID = 200745,
        toMap = 2498,
        toX = 0.7334,
        toY = 0.2213,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2494)
    -- Windrunner Spire (map 2494 42.49,85.72) -> Windrunner Spire (map 2493 48.47,82.39) via floor
    {
        fromPointID = 200737,
        fromMap = 2494,
        fromX = 0.4249,
        fromY = 0.8572,
        toPointID = 200735,
        toMap = 2493,
        toX = 0.4847,
        toY = 0.8239,
        type = "floor",
    },
    -- Windrunner Spire (map 2494 84.70,42.14) -> Windrunner Spire (map 2492 58.51,20.98) via floor
    {
        fromPointID = 200738,
        fromMap = 2494,
        fromX = 0.847,
        fromY = 0.4214,
        toPointID = 200732,
        toMap = 2492,
        toX = 0.5851,
        toY = 0.2098,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2496)
    -- Windrunner Spire (map 2496 36.99,71.74) -> Windrunner Spire (map 2492 59.47,86.62) via floor
    {
        fromPointID = 200739,
        fromMap = 2496,
        fromX = 0.3699,
        fromY = 0.7174,
        toPointID = 200733,
        toMap = 2492,
        toX = 0.5947,
        toY = 0.8662,
        type = "floor",
    },
    -- Windrunner Spire (map 2496 49.19,24.03) -> Windrunner Spire (map 2497 51.94,24.46) via floor
    {
        fromPointID = 200740,
        fromMap = 2496,
        fromX = 0.4919,
        fromY = 0.2403,
        toPointID = 200743,
        toMap = 2497,
        toX = 0.5194,
        toY = 0.2446,
        type = "floor",
    },
    -- Windrunner Spire (map 2496 51.10,17.93) -> Windrunner Spire (map 2498 73.82,81.31) via floor
    {
        fromPointID = 200741,
        fromMap = 2496,
        fromX = 0.511,
        fromY = 0.1793,
        toPointID = 200746,
        toMap = 2498,
        toX = 0.7382,
        toY = 0.8131,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2497)
    -- Windrunner Spire (map 2497 46.08,87.41) -> Windrunner Spire (map 2492 59.47,86.62) via floor
    {
        fromPointID = 200742,
        fromMap = 2497,
        fromX = 0.4608,
        fromY = 0.8741,
        toPointID = 200733,
        toMap = 2492,
        toX = 0.5947,
        toY = 0.8662,
        type = "floor",
    },
    -- Windrunner Spire (map 2497 51.94,24.46) -> Windrunner Spire (map 2496 49.19,24.03) via floor
    {
        fromPointID = 200743,
        fromMap = 2497,
        fromX = 0.5194,
        fromY = 0.2446,
        toPointID = 200740,
        toMap = 2496,
        toX = 0.4919,
        toY = 0.2403,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2498)
    -- Windrunner Spire (map 2498 72.98,56.85) -> Windrunner Spire (map 2499 65.81,35.94) via floor
    {
        fromPointID = 200744,
        fromMap = 2498,
        fromX = 0.7298,
        fromY = 0.5685,
        toPointID = 200747,
        toMap = 2499,
        toX = 0.6581,
        toY = 0.3594,
        type = "floor",
    },
    -- Windrunner Spire (map 2498 73.34,22.13) -> Windrunner Spire (map 2493 50.05,86.26) via floor
    {
        fromPointID = 200745,
        fromMap = 2498,
        fromX = 0.7334,
        fromY = 0.2213,
        toPointID = 200736,
        toMap = 2493,
        toX = 0.5005,
        toY = 0.8626,
        type = "floor",
    },
    -- Windrunner Spire (map 2498 73.82,81.31) -> Windrunner Spire (map 2496 51.10,17.93) via floor
    {
        fromPointID = 200746,
        fromMap = 2498,
        fromX = 0.7382,
        fromY = 0.8131,
        toPointID = 200741,
        toMap = 2496,
        toX = 0.511,
        toY = 0.1793,
        type = "floor",
    },

    -- Zone: Windrunner Spire (map 2499)
    -- Windrunner Spire (map 2499 65.81,35.94) -> Windrunner Spire (map 2498 72.98,56.85) via floor
    {
        fromPointID = 200747,
        fromMap = 2499,
        fromX = 0.6581,
        fromY = 0.3594,
        toPointID = 200744,
        toMap = 2498,
        toX = 0.7298,
        toY = 0.5685,
        type = "floor",
    },

    -- Zone: Winterchill Mine (map 1184)
    -- Tiragarde Sound (map 1184 39.98,34.23) -> Tiragarde Sound (map 895 78.77,53.26) via floor
    {
        fromPointID = 800098,
        fromMap = 1184,
        fromX = 0.3998,
        fromY = 0.3423,
        toPointID = 800013,
        toMap = 895,
        toX = 0.7877,
        toY = 0.5326,
        type = "floor",
    },
    -- Tiragarde Sound (map 1184 47.06,61.74) -> Tiragarde Sound (map 1185 55.34,30.26) via floor
    {
        fromPointID = 800099,
        fromMap = 1184,
        fromX = 0.4706,
        fromY = 0.6174,
        toPointID = 800100,
        toMap = 1185,
        toX = 0.5534,
        toY = 0.3026,
        type = "floor",
    },

    -- Zone: Winterchill Mine (map 1185)
    -- Tiragarde Sound (map 1185 55.34,30.26) -> Tiragarde Sound (map 1184 47.06,61.74) via floor
    {
        fromPointID = 800100,
        fromMap = 1185,
        fromX = 0.5534,
        fromY = 0.3026,
        toPointID = 800099,
        toMap = 1184,
        toX = 0.4706,
        toY = 0.6174,
        type = "floor",
    },

    -- Zone: Wit'Kalar Crypt (map 2583)
    -- Wit'Kalar Crypt (map 2583 73.70,78.49) -> Zul Aman M (map 2437 39.74,23.18) via floor
    {
        fromPointID = 200857,
        fromMap = 2583,
        fromX = 0.737,
        fromY = 0.7849,
        toPointID = 200726,
        toMap = 2437,
        toX = 0.3974,
        toY = 0.2318,
        type = "floor",
    },

    -- Zone: Zaralek Cavern (map 2133)
    -- Zaralek Cavern (map 2133 60.36,37.23) -> Deepflayer Nest (map 2184 11.43,50.25) via floor
    {
        fromPointID = 1100153,
        fromMap = 2133,
        fromX = 0.6036,
        fromY = 0.3723,
        toPointID = 1100179,
        toMap = 2184,
        toX = 0.1143,
        toY = 0.5025,
        type = "floor",
    },

    -- Zone: Zaralek Cavern (map 2184)
    -- Deepflayer Nest (map 2184 11.43,50.25) -> Zaralek Cavern (map 2133 60.36,37.23) via floor
    {
        fromPointID = 1100179,
        fromMap = 2184,
        fromX = 0.1143,
        fromY = 0.5025,
        toPointID = 1100153,
        toMap = 2133,
        toX = 0.6036,
        toY = 0.3723,
        type = "floor",
    },

    -- Zone: Zereth Mortis (map 1970)
    -- Zereth Mortis (map 1970 49.57,77.80) -> Catalyst Wards (map 2066 23.06,12.02) via floor
    {
        fromPointID = 1000324,
        fromMap = 1970,
        fromX = 0.4957,
        fromY = 0.778,
        toPointID = 1000378,
        toMap = 2066,
        toX = 0.2306,
        toY = 0.1202,
        type = "floor",
    },
    -- Zereth Mortis (map 1970 50.57,32.08) -> Gravid Repose (map 2029 69.62,9.03) via floor
    {
        fromPointID = 1000325,
        fromMap = 1970,
        fromX = 0.5057,
        fromY = 0.3208,
        toPointID = 1000362,
        toMap = 2029,
        toX = 0.6962,
        toY = 0.0903,
        type = "floor",
    },
    -- Zereth Mortis (map 1970 55.72,53.46) -> Locrian Esper (map 2028 13.87,34.86) via floor
    {
        fromPointID = 1000326,
        fromMap = 1970,
        fromX = 0.5572,
        fromY = 0.5346,
        toPointID = 1000361,
        toMap = 2028,
        toX = 0.1387,
        toY = 0.3486,
        type = "floor",
    },
    -- Zereth Mortis (map 1970 58.10,44.33) -> Nexus of Actualization (map 2030 31.16,61.21) via floor
    {
        fromPointID = 1000327,
        fromMap = 1970,
        fromX = 0.581,
        fromY = 0.4433,
        toPointID = 1000363,
        toMap = 2030,
        toX = 0.3116,
        toY = 0.6121,
        type = "floor",
    },
    -- Zereth Mortis (map 1970 63.67,73.70) -> Blooming Foundry (map 2027 28.07,11.88) via floor
    {
        fromPointID = 1000328,
        fromMap = 1970,
        fromX = 0.6367,
        fromY = 0.737,
        toPointID = 1000360,
        toMap = 2027,
        toX = 0.2807,
        toY = 0.1188,
        type = "floor",
    },
    -- Zereth Mortis (map 1970 65.90,20.94) -> Crypts of the Eternal (map 2031 31.18,86.86) via floor
    {
        fromPointID = 1000329,
        fromMap = 1970,
        fromX = 0.659,
        fromY = 0.2094,
        toPointID = 1000364,
        toMap = 2031,
        toX = 0.3118,
        toY = 0.8686,
        type = "floor",
    },

    -- Zone: Zul'Aman (map 2437)
    -- Zul Aman M (map 2437 22.02,63.42) -> Revantusk Sedge (map 2584 83.89,39.15) via floor
    {
        fromPointID = 200720,
        fromMap = 2437,
        fromX = 0.2202,
        fromY = 0.6342,
        toPointID = 200858,
        toMap = 2584,
        toX = 0.8389,
        toY = 0.3915,
        type = "floor",
    },
    -- Zul Aman M (map 2437 31.60,26.11) -> Loaknit Den (map 2580 74.50,68.45) via floor
    {
        fromPointID = 200725,
        fromMap = 2437,
        fromX = 0.316,
        fromY = 0.2611,
        toPointID = 200851,
        toMap = 2580,
        toX = 0.745,
        toY = 0.6845,
        type = "floor",
    },
    -- Zul Aman M (map 2437 39.74,23.18) -> Wit'Kalar Crypt (map 2583 73.70,78.49) via floor
    {
        fromPointID = 200726,
        fromMap = 2437,
        fromX = 0.3974,
        fromY = 0.2318,
        toPointID = 200857,
        toMap = 2583,
        toX = 0.737,
        toY = 0.7849,
        type = "floor",
    },
}

Navigation:RegisterPathData("floor", FLOOR)
