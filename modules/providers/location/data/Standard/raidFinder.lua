-- User-supplied retail catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 205, types = { "lfr-npc" },
        faction = "Neutral", map = 75, x = 0.6312, y = 0.2722,
        name = { enUS = "Auridormi", deDE = "Auridormi", esES = "Auridormi", esMX = "Auridormi", frFR = "Auridormi", itIT = "Auridormi", koKR = "아우리도르미", ptBR = "Auridormi", ruRU = "Ауридорми", zhCN = "奥里多米", zhTW = "奧莉多米" },
    },
    {
        id = 206, types = { "lfr-npc" },
        faction = "Neutral", map = 390, x = 0.8315, y = 0.3063,
        name = { enUS = "Lorewalker Han", deDE = "Lorewalker Han", esES = "Lorewalker Han", esMX = "Lorewalker Han", frFR = "Lorewalker Han", itIT = "Lorewalker Han", koKR = "Lorewalker Han", ptBR = "Lorewalker Han", ruRU = "Lorewalker Han", zhCN = "Lorewalker Han", zhTW = "Lorewalker Han" },
    },
    {
        id = 207, types = { "lfr-npc" },
        faction = "Alliance", map = 582, x = 0.3317, y = 0.3703,
        name = { enUS = "Seer Kazal", deDE = "Kazal der Seher", esES = "Vidente Kazal", esMX = "Vidente Kazal", frFR = "Voyant Kazal", itIT = "Veggente Kazal", koKR = "선견자 카잘", ptBR = "Vidente Kazal", ruRU = "Провидец Казал", zhCN = "先知卡扎尔", zhTW = "先知卡札爾" },
    },
    {
        id = 208, types = { "lfr-npc" },
        faction = "Horde", map = 590, x = 0.4136, y = 0.4698,
        name = { enUS = "Seer Kazal", deDE = "Kazal der Seher", esES = "Vidente Kazal", esMX = "Vidente Kazal", frFR = "Voyant Kazal", itIT = "Veggente Kazal", koKR = "선견자 카잘", ptBR = "Vidente Kazal", ruRU = "Провидец Казал", zhCN = "先知卡扎尔", zhTW = "先知卡札爾" },
    },
    {
        id = 209, types = { "lfr-npc" },
        faction = "Neutral", map = 627, x = 0.6353, y = 0.5488,
        name = { enUS = "Archmage Timear", deDE = "Archmage Timear", esES = "Archmage Timear", esMX = "Archmage Timear", frFR = "Archmage Timear", itIT = "Archmage Timear", koKR = "Archmage Timear", ptBR = "Archmage Timear", ruRU = "Archmage Timear", zhCN = "Archmage Timear", zhTW = "Archmage Timear" },
    },
    {
        id = 210, types = { "lfr-npc" },
        faction = "Alliance", map = 1161, x = 0.7419, y = 0.1352,
        name = { enUS = "Kiku", deDE = "Kiku", esES = "Kiku", esMX = "Kiku", frFR = "Kiko", itIT = "Kiku", koKR = "키쿠", ptBR = "Kiki", ruRU = "Кику", zhCN = "基库", zhTW = "奇庫" },
    },
    {
        id = 211, types = { "lfr-npc" },
        faction = "Horde", map = 1164, x = 0.6858, y = 0.3002,
        name = { enUS = "Eppu", deDE = "Eppu", esES = "Eppu", esMX = "Eppu", frFR = "Eppu", itIT = "Eppu", koKR = "에푸", ptBR = "Eppu", ruRU = "Эппу", zhCN = "埃浦", zhTW = "艾普" },
    },
    {
        id = 212, types = { "lfr-npc" },
        faction = "Neutral", map = 1530, x = 0.8371, y = 0.2804,
        name = { enUS = "Lorewalker Han", deDE = "Lorewalker Han", esES = "Lorewalker Han", esMX = "Lorewalker Han", frFR = "Lorewalker Han", itIT = "Lorewalker Han", koKR = "Lorewalker Han", ptBR = "Lorewalker Han", ruRU = "Lorewalker Han", zhCN = "Lorewalker Han", zhTW = "Lorewalker Han" },
    },
    {
        id = 213, types = { "lfr-npc" },
        faction = "Neutral", map = 1670, x = 0.4137, y = 0.7150,
        name = { enUS = "Ta'elfar", deDE = "Ta'elfar", esES = "Ta'elfar", esMX = "Ta'elfar", frFR = "Ta'elfar", itIT = "Ta'elfar", koKR = "Ta'elfar", ptBR = "Ta'elfar", ruRU = "Ta'elfar", zhCN = "Ta'elfar", zhTW = "Ta'elfar" },
    },
    {
        id = 214, types = { "lfr-npc" },
        faction = "Neutral", map = 2112, x = 0.5838, y = 0.3548,
        name = { enUS = "Luka Ferad", deDE = "Luka Ferad", esES = "Luka Ferad", esMX = "Luka Ferad", frFR = "Luka Ferad", itIT = "Luka Ferad", koKR = "Luka Ferad", ptBR = "Luka Ferad", ruRU = "Luka Ferad", zhCN = "Luka Ferad", zhTW = "Luka Ferad" },
    },
})
