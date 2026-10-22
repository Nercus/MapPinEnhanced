-- User-supplied retail catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 201,
        types = { "great-vault" },
        map = 1670,
        x = 0.6518,
        y = 0.3048,
        name = { enUS = "Great Vault", deDE = "Die Große Schatzkammer", esES = "Gran cámara", esMX = "Gran bóveda", frFR = "Grande chambre forte", itIT = "Gran Banca", koKR = "위대한 금고", ptBR = "Grande Cofre", ruRU = "Великое хранилище", zhCN = "宏伟宝库", zhTW = "寶庫" },
        areaPoiID = 6979,
        areaPoiIDs = { 6979, 6987, 7035 },
    },
    {
        id = 202,
        types = { "great-vault" },
        map = 2112,
        x = 0.5885,
        y = 0.5792,
        name = { enUS = "Great Vault", deDE = "Große Schatzkammer", esES = "Gran cámara", esMX = "Gran bóveda", frFR = "Grande chambre forte", itIT = "Gran Banca", koKR = "위대한 금고", ptBR = "Grande Cofre", ruRU = "Великое хранилище", zhCN = "宏伟宝库", zhTW = "寶庫" },
        areaPoiID = 7296,
        areaPoiIDs = { 7296, 7297, 7455, 7552, 7739 },
    },
    {
        id = 203,
        types = { "great-vault" },
        map = 2339,
        x = 0.5471,
        y = 0.4214,
        name = { enUS = "Great Vault", deDE = "Große Schatzkammer", esES = "Gran cámara", esMX = "Gran bóveda", frFR = "La grande chambre forte", itIT = "Gran Banca", koKR = "위대한 금고", ptBR = "Grande Cofre", ruRU = "Великое хранилище", zhCN = "宏伟宝库", zhTW = "寶庫" },
        areaPoiID = 7831,
        areaPoiIDs = { 7831, 7958, 8245, 8370 },
    },
    {
        id = 204,
        types = { "great-vault" },
        map = 2393,
        x = 0.5033,
        y = 0.6515,
        name = { enUS = "Great Vault", deDE = "Große Schatzkammer", esES = "Gran cámara", esMX = "Gran bóveda", frFR = "Grande chambre forte", itIT = "Gran Banca", koKR = "위대한 금고", ptBR = "Grande Cofre", ruRU = "Великое хранилище", zhCN = "宏伟宝库", zhTW = "寶庫" },
        areaPoiID = 8521,
        areaPoiIDs = { 8521, 8522, 8818 },
    },
})
