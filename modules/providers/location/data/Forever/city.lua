-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 75,
        types = { "city" },
        faction = "Horde",
        map = 1411,
        x = 0.4554,
        y = 0.1211,
        name = { enUS = "Orgrimmar", deDE = "Orgrimmar", esES = "Orgrimmar", esMX = "Orgrimmar", frFR = "Orgrimmar", koKR = "Orgrimmar", ptBR = "Orgrimmar", ruRU = "Orgrimmar", zhCN = "Orgrimmar", zhTW = "Orgrimmar" },
    },
    {
        id = 76,
        types = { "city" },
        faction = "Horde",
        map = 1420,
        x = 0.6191,
        y = 0.6600,
        name = { enUS = "The Undercity", deDE = "The Undercity", esES = "The Undercity", esMX = "The Undercity", frFR = "The Undercity", koKR = "The Undercity", ptBR = "The Undercity", ruRU = "The Undercity", zhCN = "The Undercity", zhTW = "The Undercity" },
    },
    {
        id = 77,
        types = { "city" },
        faction = "Alliance",
        map = 1426,
        x = 0.5354,
        y = 0.3485,
        name = { enUS = "Ironforge", deDE = "Ironforge", esES = "Ironforge", esMX = "Ironforge", frFR = "Ironforge", koKR = "Ironforge", ptBR = "Ironforge", ruRU = "Ironforge", zhCN = "Ironforge", zhTW = "Ironforge" },
    },
    {
        id = 78,
        types = { "city" },
        faction = "Alliance",
        map = 1453,
        x = 0.6310,
        y = 0.7190,
        name = { enUS = "Stormwind", deDE = "Stormwind", esES = "Stormwind", esMX = "Stormwind", frFR = "Stormwind", koKR = "Stormwind", ptBR = "Stormwind", ruRU = "Stormwind", zhCN = "Stormwind", zhTW = "Stormwind" },
    },
    {
        id = 79,
        types = { "city" },
        faction = "Horde",
        map = 1456,
        x = 0.4669,
        y = 0.5107,
        name = { enUS = "Thunder Bluff", deDE = "Thunder Bluff", esES = "Thunder Bluff", esMX = "Thunder Bluff", frFR = "Thunder Bluff", koKR = "Thunder Bluff", ptBR = "Thunder Bluff", ruRU = "Thunder Bluff", zhCN = "Thunder Bluff", zhTW = "Thunder Bluff" },
    },
    {
        id = 80,
        types = { "city" },
        faction = "Alliance",
        map = 1457,
        x = 0.6460,
        y = 0.4057,
        name = { enUS = "Darnassus", deDE = "Darnassus", esES = "Darnassus", esMX = "Darnassus", frFR = "Darnassus", koKR = "Darnassus", ptBR = "Darnassus", ruRU = "Darnassus", zhCN = "Darnassus", zhTW = "Darnassus" },
    },
})
