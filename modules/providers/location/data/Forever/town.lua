-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 901, types = { "town" },
        faction = "Horde", map = 1413, x = 0.4484, y = 0.5870,
        name = { enUS = "Camp Taurajo", deDE = "Camp Taurajo", esES = "Camp Taurajo", esMX = "Camp Taurajo", frFR = "Camp Taurajo", koKR = "Camp Taurajo", ptBR = "Camp Taurajo", ruRU = "Camp Taurajo", zhCN = "Camp Taurajo", zhTW = "Camp Taurajo" },
    },
    {
        id = 902, types = { "town" },
        faction = "Neutral", map = 1413, x = 0.6220, y = 0.3796,
        name = { enUS = "Ratchet", deDE = "Ratchet", esES = "Ratchet", esMX = "Ratchet", frFR = "Ratchet", koKR = "Ratchet", ptBR = "Ratchet", ruRU = "Ratchet", zhCN = "Ratchet", zhTW = "Ratchet" },
    },
    {
        id = 903, types = { "town" },
        faction = "Horde", map = 1413, x = 0.5206, y = 0.3062,
        name = { enUS = "The Crossroads", deDE = "The Crossroads", esES = "The Crossroads", esMX = "The Crossroads", frFR = "The Crossroads", koKR = "The Crossroads", ptBR = "The Crossroads", ruRU = "The Crossroads", zhCN = "The Crossroads", zhTW = "The Crossroads" },
    },
    {
        id = 904, types = { "town" },
        faction = "Horde", map = 1417, x = 0.7393, y = 0.3578,
        name = { enUS = "Hammerfall", deDE = "Hammerfall", esES = "Hammerfall", esMX = "Hammerfall", frFR = "Hammerfall", koKR = "Hammerfall", ptBR = "Hammerfall", ruRU = "Hammerfall", zhCN = "Hammerfall", zhTW = "Hammerfall" },
    },
    {
        id = 905, types = { "town" },
        faction = "Horde", map = 1418, x = 0.0432, y = 0.4742,
        name = { enUS = "Kargath", deDE = "Kargath", esES = "Kargath", esMX = "Kargath", frFR = "Kargath", koKR = "Kargath", ptBR = "Kargath", ruRU = "Kargath", zhCN = "Kargath", zhTW = "Kargath" },
    },
    {
        id = 906, types = { "town" },
        faction = "Horde", map = 1421, x = 0.4360, y = 0.4138,
        name = { enUS = "The Sepulcher", deDE = "The Sepulcher", esES = "The Sepulcher", esMX = "The Sepulcher", frFR = "The Sepulcher", koKR = "The Sepulcher", ptBR = "The Sepulcher", ruRU = "The Sepulcher", zhCN = "The Sepulcher", zhTW = "The Sepulcher" },
    },
    {
        id = 907, types = { "town" },
        faction = "Alliance", map = 1424, x = 0.4996, y = 0.5638,
        name = { enUS = "Southshore", deDE = "Southshore", esES = "Southshore", esMX = "Southshore", frFR = "Southshore", koKR = "Southshore", ptBR = "Southshore", ruRU = "Southshore", zhCN = "Southshore", zhTW = "Southshore" },
    },
    {
        id = 908, types = { "town" },
        faction = "Horde", map = 1424, x = 0.6146, y = 0.2000,
        name = { enUS = "Tarren Mill", deDE = "Tarren Mill", esES = "Tarren Mill", esMX = "Tarren Mill", frFR = "Tarren Mill", koKR = "Tarren Mill", ptBR = "Tarren Mill", ruRU = "Tarren Mill", zhCN = "Tarren Mill", zhTW = "Tarren Mill" },
    },
    {
        id = 909, types = { "town" },
        faction = "Alliance", map = 1425, x = 0.1436, y = 0.4800,
        name = { enUS = "Aerie Peak", deDE = "Aerie Peak", esES = "Aerie Peak", esMX = "Aerie Peak", frFR = "Aerie Peak", koKR = "Aerie Peak", ptBR = "Aerie Peak", ruRU = "Aerie Peak", zhCN = "Aerie Peak", zhTW = "Aerie Peak" },
    },
    {
        id = 910, types = { "town" },
        faction = "Horde", map = 1425, x = 0.7833, y = 0.7948,
        name = { enUS = "Revantusk Village", deDE = "Revantusk Village", esES = "Revantusk Village", esMX = "Revantusk Village", frFR = "Revantusk Village", koKR = "Revantusk Village", ptBR = "Revantusk Village", ruRU = "Revantusk Village", zhCN = "Revantusk Village", zhTW = "Revantusk Village" },
    },
    {
        id = 911, types = { "town" },
        faction = "Alliance", map = 1431, x = 0.7422, y = 0.4715,
        name = { enUS = "Darkshire", deDE = "Darkshire", esES = "Darkshire", esMX = "Darkshire", frFR = "Darkshire", koKR = "Darkshire", ptBR = "Darkshire", ruRU = "Darkshire", zhCN = "Darkshire", zhTW = "Darkshire" },
    },
    {
        id = 912, types = { "town" },
        faction = "Alliance", map = 1432, x = 0.3503, y = 0.4685,
        name = { enUS = "Thelsamar", deDE = "Thelsamar", esES = "Thelsamar", esMX = "Thelsamar", frFR = "Thelsamar", koKR = "Thelsamar", ptBR = "Thelsamar", ruRU = "Thelsamar", zhCN = "Thelsamar", zhTW = "Thelsamar" },
    },
    {
        id = 913, types = { "town" },
        faction = "Alliance", map = 1433, x = 0.2396, y = 0.4510,
        name = { enUS = "Lakeshire", deDE = "Lakeshire", esES = "Lakeshire", esMX = "Lakeshire", frFR = "Lakeshire", koKR = "Lakeshire", ptBR = "Lakeshire", ruRU = "Lakeshire", zhCN = "Lakeshire", zhTW = "Lakeshire" },
    },
    {
        id = 914, types = { "town" },
        faction = "Neutral", map = 1434, x = 0.2718, y = 0.7555,
        name = { enUS = "Booty Bay", deDE = "Booty Bay", esES = "Booty Bay", esMX = "Booty Bay", frFR = "Booty Bay", koKR = "Booty Bay", ptBR = "Booty Bay", ruRU = "Booty Bay", zhCN = "Booty Bay", zhTW = "Booty Bay" },
    },
    {
        id = 915, types = { "town" },
        faction = "Horde", map = 1434, x = 0.3190, y = 0.2844,
        name = { enUS = "Grom'gol Base Camp", deDE = "Grom'gol Base Camp", esES = "Grom'gol Base Camp", esMX = "Grom'gol Base Camp", frFR = "Grom'gol Base Camp", koKR = "Grom'gol Base Camp", ptBR = "Grom'gol Base Camp", ruRU = "Grom'gol Base Camp", zhCN = "Grom'gol Base Camp", zhTW = "Grom'gol Base Camp" },
    },
    {
        id = 916, types = { "town" },
        faction = "Horde", map = 1435, x = 0.4597, y = 0.5383,
        name = { enUS = "Stonard", deDE = "Stonard", esES = "Stonard", esMX = "Stonard", frFR = "Stonard", koKR = "Stonard", ptBR = "Stonard", ruRU = "Stonard", zhCN = "Stonard", zhTW = "Stonard" },
    },
    {
        id = 917, types = { "town" },
        faction = "Alliance", map = 1436, x = 0.5682, y = 0.4731,
        name = { enUS = "Sentinel Hill", deDE = "Sentinel Hill", esES = "Sentinel Hill", esMX = "Sentinel Hill", frFR = "Sentinel Hill", koKR = "Sentinel Hill", ptBR = "Sentinel Hill", ruRU = "Sentinel Hill", zhCN = "Sentinel Hill", zhTW = "Sentinel Hill" },
    },
    {
        id = 918, types = { "town" },
        faction = "Alliance", map = 1437, x = 0.1060, y = 0.5534,
        name = { enUS = "Menethil Harbor", deDE = "Menethil Harbor", esES = "Menethil Harbor", esMX = "Menethil Harbor", frFR = "Menethil Harbor", koKR = "Menethil Harbor", ptBR = "Menethil Harbor", ruRU = "Menethil Harbor", zhCN = "Menethil Harbor", zhTW = "Menethil Harbor" },
    },
    {
        id = 919, types = { "town" },
        faction = "Alliance", map = 1438, x = 0.5908, y = 0.4033,
        name = { enUS = "Aldrassil", deDE = "Aldrassil", esES = "Aldrassil", esMX = "Aldrassil", frFR = "Aldrassil", koKR = "Aldrassil", ptBR = "Aldrassil", ruRU = "Aldrassil", zhCN = "Aldrassil", zhTW = "Aldrassil" },
    },
    {
        id = 920, types = { "town" },
        faction = "Alliance", map = 1438, x = 0.5627, y = 0.6021,
        name = { enUS = "Dolanaar", deDE = "Dolanaar", esES = "Dolanaar", esMX = "Dolanaar", frFR = "Dolanaar", koKR = "Dolanaar", ptBR = "Dolanaar", ruRU = "Dolanaar", zhCN = "Dolanaar", zhTW = "Dolanaar" },
    },
    {
        id = 921, types = { "town" },
        faction = "Alliance", map = 1439, x = 0.3862, y = 0.4339,
        name = { enUS = "Auberdine", deDE = "Auberdine", esES = "Auberdine", esMX = "Auberdine", frFR = "Auberdine", koKR = "Auberdine", ptBR = "Auberdine", ruRU = "Auberdine", zhCN = "Auberdine", zhTW = "Auberdine" },
    },
    {
        id = 922, types = { "town" },
        faction = "Alliance", map = 1440, x = 0.3612, y = 0.5081,
        name = { enUS = "Astranaar", deDE = "Astranaar", esES = "Astranaar", esMX = "Astranaar", frFR = "Astranaar", koKR = "Astranaar", ptBR = "Astranaar", ruRU = "Astranaar", zhCN = "Astranaar", zhTW = "Astranaar" },
    },
    {
        id = 923, types = { "town" },
        faction = "Horde", map = 1440, x = 0.7397, y = 0.6208,
        name = { enUS = "Splintertree Post", deDE = "Splintertree Post", esES = "Splintertree Post", esMX = "Splintertree Post", frFR = "Splintertree Post", koKR = "Splintertree Post", ptBR = "Splintertree Post", ruRU = "Splintertree Post", zhCN = "Splintertree Post", zhTW = "Splintertree Post" },
    },
    {
        id = 924, types = { "town" },
        faction = "Horde", map = 1441, x = 0.4573, y = 0.5073,
        name = { enUS = "Freewind Post", deDE = "Freewind Post", esES = "Freewind Post", esMX = "Freewind Post", frFR = "Freewind Post", koKR = "Freewind Post", ptBR = "Freewind Post", ruRU = "Freewind Post", zhCN = "Freewind Post", zhTW = "Freewind Post" },
    },
    {
        id = 925, types = { "town" },
        faction = "Alliance", map = 1442, x = 0.3679, y = 0.0792,
        name = { enUS = "Stonetalon Peak", deDE = "Stonetalon Peak", esES = "Stonetalon Peak", esMX = "Stonetalon Peak", frFR = "Stonetalon Peak", koKR = "Stonetalon Peak", ptBR = "Stonetalon Peak", ruRU = "Stonetalon Peak", zhCN = "Stonetalon Peak", zhTW = "Stonetalon Peak" },
    },
    {
        id = 926, types = { "town" },
        faction = "Horde", map = 1442, x = 0.4782, y = 0.6083,
        name = { enUS = "Sun Rock Retreat", deDE = "Sun Rock Retreat", esES = "Sun Rock Retreat", esMX = "Sun Rock Retreat", frFR = "Sun Rock Retreat", koKR = "Sun Rock Retreat", ptBR = "Sun Rock Retreat", ruRU = "Sun Rock Retreat", zhCN = "Sun Rock Retreat", zhTW = "Sun Rock Retreat" },
    },
    {
        id = 927, types = { "town" },
        faction = "Alliance", map = 1443, x = 0.6507, y = 0.0832,
        name = { enUS = "Nijel's Point", deDE = "Nijel's Point", esES = "Nijel's Point", esMX = "Nijel's Point", frFR = "Nijel's Point", koKR = "Nijel's Point", ptBR = "Nijel's Point", ruRU = "Nijel's Point", zhCN = "Nijel's Point", zhTW = "Nijel's Point" },
    },
    {
        id = 928, types = { "town" },
        faction = "Horde", map = 1443, x = 0.2527, y = 0.7036,
        name = { enUS = "Shadowprey Village", deDE = "Shadowprey Village", esES = "Shadowprey Village", esMX = "Shadowprey Village", frFR = "Shadowprey Village", koKR = "Shadowprey Village", ptBR = "Shadowprey Village", ruRU = "Shadowprey Village", zhCN = "Shadowprey Village", zhTW = "Shadowprey Village" },
    },
    {
        id = 929, types = { "town" },
        faction = "Horde", map = 1444, x = 0.7519, y = 0.4377,
        name = { enUS = "Camp Mojache", deDE = "Camp Mojache", esES = "Camp Mojache", esMX = "Camp Mojache", frFR = "Camp Mojache", koKR = "Camp Mojache", ptBR = "Camp Mojache", ruRU = "Camp Mojache", zhCN = "Camp Mojache", zhTW = "Camp Mojache" },
    },
    {
        id = 930, types = { "town" },
        faction = "Alliance", map = 1444, x = 0.3114, y = 0.4463,
        name = { enUS = "Feathermoon Stronghold", deDE = "Feathermoon Stronghold", esES = "Feathermoon Stronghold", esMX = "Feathermoon Stronghold", frFR = "Feathermoon Stronghold", koKR = "Feathermoon Stronghold", ptBR = "Feathermoon Stronghold", ruRU = "Feathermoon Stronghold", zhCN = "Feathermoon Stronghold", zhTW = "Feathermoon Stronghold" },
    },
    {
        id = 931, types = { "town" },
        faction = "Alliance", map = 1444, x = 0.8952, y = 0.4624,
        name = { enUS = "Thalanaar", deDE = "Thalanaar", esES = "Thalanaar", esMX = "Thalanaar", frFR = "Thalanaar", koKR = "Thalanaar", ptBR = "Thalanaar", ruRU = "Thalanaar", zhCN = "Thalanaar", zhTW = "Thalanaar" },
    },
    {
        id = 932, types = { "town" },
        faction = "Alliance", map = 1445, x = 0.6501, y = 0.4705,
        name = { enUS = "Theramore Isle", deDE = "Theramore Isle", esES = "Theramore Isle", esMX = "Theramore Isle", frFR = "Theramore Isle", koKR = "Theramore Isle", ptBR = "Theramore Isle", ruRU = "Theramore Isle", zhCN = "Theramore Isle", zhTW = "Theramore Isle" },
    },
    {
        id = 933, types = { "town" },
        faction = "Neutral", map = 1446, x = 0.5121, y = 0.2747,
        name = { enUS = "Gadgetzan", deDE = "Gadgetzan", esES = "Gadgetzan", esMX = "Gadgetzan", frFR = "Gadgetzan", koKR = "Gadgetzan", ptBR = "Gadgetzan", ruRU = "Gadgetzan", zhCN = "Gadgetzan", zhTW = "Gadgetzan" },
    },
    {
        id = 934, types = { "town" },
        faction = "Neutral", map = 1451, x = 0.5222, y = 0.3996,
        name = { enUS = "Cenarion Hold", deDE = "Cenarion Hold", esES = "Cenarion Hold", esMX = "Cenarion Hold", frFR = "Cenarion Hold", koKR = "Cenarion Hold", ptBR = "Cenarion Hold", ruRU = "Cenarion Hold", zhCN = "Cenarion Hold", zhTW = "Cenarion Hold" },
    },
    {
        id = 935, types = { "town" },
        faction = "Neutral", map = 1452, x = 0.6121, y = 0.3823,
        name = { enUS = "Everlook", deDE = "Everlook", esES = "Everlook", esMX = "Everlook", frFR = "Everlook", koKR = "Everlook", ptBR = "Everlook", ruRU = "Everlook", zhCN = "Everlook", zhTW = "Everlook" },
    },
})
