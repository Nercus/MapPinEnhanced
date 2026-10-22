-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 433, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1411, x = 0.5150, y = 0.4162,
        name = { enUS = "Innkeeper Grosk", deDE = "Gastwirt Grosk", esES = "Tabernero Grosk", esMX = "Tabernero Grosk", frFR = "Grosk l'aubergiste", koKR = "여관주인 그로스크", ptBR = "Estalajadeiro Grosk", ruRU = "Хозяин таверны Гроск", zhCN = "旅店老板格罗斯克", zhTW = "旅店老闆格羅斯克" },
    },
    {
        id = 434, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1412, x = 0.4590, y = 0.6420,
        name = { enUS = "Innkeeper Kauth", deDE = "Gastwirt Kauth", esES = "Tabernero Kauth", esMX = "Tabernero Kauth", frFR = "Kauth l'aubergiste", koKR = "여관주인 카우스", ptBR = "Estalajadeiro Kauth", ruRU = "Хозяин таверны Каут", zhCN = "旅店老板考乌斯", zhTW = "旅店老闆考烏斯" },
    },
    {
        id = 435, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1413, x = 0.5200, y = 0.2991,
        name = { enUS = "Innkeeper Boorand Plainswind", deDE = "Gastwirt Boorand Plainswind", esES = "Tabernero Boorand Ventollano", esMX = "Tabernero Boorand Ventollano", frFR = "Boorand Plainswind l'aubergiste", koKR = "여관주인 부어란드 플레인즈윈드", ptBR = "Estalajadeiro Boorand Vento das Planícies", ruRU = "Хозяин таверны Буранд Ветродуй", zhCN = "旅店老板伯兰德·草风", zhTW = "旅店老闆伯蘭德·草風" },
    },
    {
        id = 436, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1413, x = 0.4559, y = 0.5899,
        name = { enUS = "Innkeeper Byula", deDE = "Gastwirt Byula", esES = "Tabernera Byula", esMX = "Tabernero Byula", frFR = "Aubergiste Byula", koKR = "여관주인 비울라", ptBR = "Estalajadeira Byula", ruRU = "Хозяин таверны Быкко", zhCN = "旅店老板比鲁拉", zhTW = "旅店老闆比魯拉" },
    },
    {
        id = 437, types = { "innkeeper", "vendor-food" },
        faction = "Neutral", map = 1413, x = 0.6200, y = 0.3940,
        name = { enUS = "Innkeeper Wiley", deDE = "Gastwirt Wiley", esES = "Tabernero Wiley", esMX = "Tabernero Wiley", frFR = "Wiley l'aubergiste", koKR = "여관주인 윌리", ptBR = "Estalajadeiro Wiley", ruRU = "Хозяин таверны Вихлюн", zhCN = "旅店老板维尔雷", zhTW = "旅店老闆維爾雷" },
    },
    {
        id = 438, types = { "innkeeper" },
        faction = "Alliance", map = 1416, x = 0.1824, y = 0.6646,
        name = { enUS = "Amisi Azuregaze", deDE = "Amisi Azuregaze", esES = "Amisi Azuregaze", esMX = "Amisi Azuregaze", frFR = "Amisi Azuregaze", koKR = "Amisi Azuregaze", ptBR = "Amisi Azuregaze", ruRU = "Amisi Azuregaze", zhCN = "Amisi Azuregaze", zhTW = "Amisi Azuregaze" },
    },
    {
        id = 439, types = { "innkeeper" },
        faction = "Alliance", map = 1416, x = 0.1824, y = 0.6654,
        name = { enUS = "Amisi Azuregaze", deDE = "Amisi Azuregaze", esES = "Amisi Azuregaze", esMX = "Amisi Azuregaze", frFR = "Amisi Azuregaze", koKR = "Amisi Azuregaze", ptBR = "Amisi Azuregaze", ruRU = "Amisi Azuregaze", zhCN = "Amisi Azuregaze", zhTW = "Amisi Azuregaze" },
    },
    {
        id = 440, types = { "innkeeper" },
        faction = "Alliance", map = 1416, x = 0.1831, y = 0.6658,
        name = { enUS = "Amisi Azuregaze", deDE = "Amisi Azuregaze", esES = "Amisi Azuregaze", esMX = "Amisi Azuregaze", frFR = "Amisi Azuregaze", koKR = "Amisi Azuregaze", ptBR = "Amisi Azuregaze", ruRU = "Amisi Azuregaze", zhCN = "Amisi Azuregaze", zhTW = "Amisi Azuregaze" },
    },
    {
        id = 441, types = { "innkeeper" },
        faction = "Alliance", map = 1416, x = 0.1835, y = 0.6651,
        name = { enUS = "Amisi Azuregaze", deDE = "Amisi Azuregaze", esES = "Amisi Azuregaze", esMX = "Amisi Azuregaze", frFR = "Amisi Azuregaze", koKR = "Amisi Azuregaze", ptBR = "Amisi Azuregaze", ruRU = "Amisi Azuregaze", zhCN = "Amisi Azuregaze", zhTW = "Amisi Azuregaze" },
    },
    {
        id = 442, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1216, y = 0.6635,
        name = { enUS = "Isirami Fairwind", deDE = "Isirami Fairwind", esES = "Isirami Fairwind", esMX = "Isirami Fairwind", frFR = "Isirami Fairwind", koKR = "Isirami Fairwind", ptBR = "Isirami Fairwind", ruRU = "Isirami Fairwind", zhCN = "Isirami Fairwind", zhTW = "Isirami Fairwind" },
    },
    {
        id = 443, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1417, x = 0.7381, y = 0.3250,
        name = { enUS = "Innkeeper Adegwa", deDE = "Gastwirt Adegwa", esES = "Tabernero Abegwa", esMX = "Tabernero Adegwa", frFR = "Aubergiste Adegwa", koKR = "여관주인 아데그와", ptBR = "Estalajadeiro Adegra", ruRU = "Хозяин таверны Адегва", zhCN = "旅店老板埃德瓦", zhTW = "旅店老闆埃德瓦" },
    },
    {
        id = 444, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1418, x = 0.0282, y = 0.4589,
        name = { enUS = "Innkeeper Shul'kar", deDE = "Gastwirt Shul'kar", esES = "Tabernero Shul'kar", esMX = "Tabernero Shul'kar", frFR = "Aubergiste Shul'kar", koKR = "여관주인 술카르", ptBR = "Estalajadeiro Shul'kar", ruRU = "Хозяин таверны Шул'кар", zhCN = "旅店老板舒尔卡", zhTW = "旅店老闆舒爾卡" },
    },
    {
        id = 445, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1420, x = 0.6217, y = 0.7308,
        name = { enUS = "Innkeeper Norman", deDE = "Gastwirt Norman", esES = "Tabernero Norman", esMX = "Tabernero Norman", frFR = "Norman l'aubergiste", koKR = "여관주인 노먼", ptBR = "Estalajadeiro Ronan", ruRU = "Хозяин таверны Норман", zhCN = "旅店老板诺曼", zhTW = "旅店老闆諾曼" },
    },
    {
        id = 446, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1420, x = 0.6170, y = 0.5201,
        name = { enUS = "Innkeeper Renee", deDE = "Gastwirtin Renee", esES = "Tabernero Renee", esMX = "Tabernera Renee", frFR = "Renée l'aubergiste", koKR = "여관주인 리니", ptBR = "Estalajadeira Geni", ruRU = "Хозяйка таверны Ренни", zhCN = "旅店老板瑞尼", zhTW = "旅店老闆芮妮" },
    },
    {
        id = 447, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1421, x = 0.4319, y = 0.4129,
        name = { enUS = "Innkeeper Bates", deDE = "Gastwirt Bates", esES = "Tabernero Bates", esMX = "Tabernero Bates", frFR = "Aubergiste Bates", koKR = "여관주인 베이츠", ptBR = "Estalajadeiro Bates", ruRU = "Хозяин таверны Бейтс", zhCN = "旅店老板拜特斯", zhTW = "旅店老闆拜特斯" },
    },
    {
        id = 448, types = { "innkeeper", "vendor-food" },
        faction = "Neutral", map = 1423, x = 0.7180, y = 0.4850,
        name = { enUS = "Jessica Chambers", deDE = "Jessica Chambers", esES = "Jessica Chambers", esMX = "Jessica Cuevas", frFR = "Jessica Chambers", koKR = "제시카 챔버스", ptBR = "Jessica Dávila", ruRU = "Джессика Чамберс", zhCN = "杰希卡·查伯斯", zhTW = "潔希卡·錢柏" },
    },
    {
        id = 449, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1424, x = 0.5121, y = 0.5888,
        name = { enUS = "Innkeeper Anderson", deDE = "Gastwirt Anderson", esES = "Tabernero Anderson", esMX = "Tabernero Anderson", frFR = "Anderson l'aubergiste", koKR = "여관주인 앤더슨", ptBR = "Estalajadeiro Anderson", ruRU = "Хозяин таверны Андерсон", zhCN = "旅店老板安德森", zhTW = "旅店老闆安德森" },
    },
    {
        id = 450, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1424, x = 0.6279, y = 0.1900,
        name = { enUS = "Innkeeper Shay", deDE = "Gastwirt Shay", esES = "Tabernero Shay", esMX = "Tabernero Shay", frFR = "Shay l'aubergiste", koKR = "여관주인 셰이", ptBR = "Estalajadeiro Chê", ruRU = "Хозяин таверны Шай", zhCN = "旅店老板沙恩", zhTW = "旅店老闆沙恩" },
    },
    {
        id = 451, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1425, x = 0.1360, y = 0.4182,
        name = { enUS = "Innkeeper Thulfram", deDE = "Gastwirt Thulfram", esES = "Tabernero Thulfram", esMX = "Tabernero Thulfram", frFR = "Aubergiste Thulfram", koKR = "여관주인 툴프람", ptBR = "Estalajadeiro Thulfram", ruRU = "Хозяин таверны Тулфрам", zhCN = "旅店老板苏弗拉姆", zhTW = "旅店老闆蘇弗拉姆" },
    },
    {
        id = 452, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1425, x = 0.7809, y = 0.8140,
        name = { enUS = "Lard", deDE = "Lard", esES = "Lard", esMX = "Lard", frFR = "Lard", koKR = "라드", ptBR = "Banha", ruRU = "Лярд", zhCN = "拉尔德", zhTW = "拉爾德" },
    },
    {
        id = 453, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.4739, y = 0.5252,
        name = { enUS = "Innkeeper Belm", deDE = "Gastwirt Belm", esES = "Tabernero Belm", esMX = "Tabernero Belm", frFR = "Belm l'aubergiste", koKR = "여관주인 벨름", ptBR = "Estalajadeiro Belm", ruRU = "Хозяин таверны Белм", zhCN = "旅店老板贝尔姆", zhTW = "旅店老闆貝爾姆" },
    },
    {
        id = 454, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5400, y = 0.2933,
        name = { enUS = "Innkeeper Firebrew", deDE = "Gastwirt Firebrew", esES = "Tabernero Brebefuego", esMX = "Tabernero Brebefuego", frFR = "Firebrew l'aubergiste", koKR = "여관주인 파이어브루", ptBR = "Estalajadeiro Aguardente", ruRU = "Хозяин таверны Огневар", zhCN = "旅店老板洛雷·火酒", zhTW = "旅店老闆洛雷·火酒" },
    },
    {
        id = 455, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4382, y = 0.6580,
        name = { enUS = "Innkeeper Farley", deDE = "Gastwirt Farley", esES = "Tabernero Farley", esMX = "Tabernero Farley", frFR = "Aubergiste Farley", koKR = "여관주인 팔레이", ptBR = "Estalajadeiro Fábio", ruRU = "Хозяин таверны Фарли", zhCN = "旅店老板法雷", zhTW = "旅店老闆法雷" },
    },
    {
        id = 456, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1431, x = 0.7398, y = 0.4448,
        name = { enUS = "Innkeeper Trelayne", deDE = "Gastwirtin Trelayne", esES = "Tabernera Trelayne", esMX = "Tabernera Trelayne", frFR = "Trelayne l'aubergiste", koKR = "여관주인 트렐라니", ptBR = "Estalajadeira Brunê", ruRU = "Хозяйка таверны Трилана", zhCN = "旅店老板崔莱尼", zhTW = "旅店老闆崔萊尼" },
    },
    {
        id = 457, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1432, x = 0.3551, y = 0.4837,
        name = { enUS = "Innkeeper Hearthstove", deDE = "Gastwirt Hearthstove", esES = "Tabernero Hogartufa", esMX = "Tabernero Hogartufa", frFR = "Hearthstove l'aubergiste", koKR = "여관주인 하트스토브", ptBR = "Estalajadeiro Fornalenha", ruRU = "Хозяин таверны Жаркий Очаг", zhCN = "旅店老板纳克罗·壁炉", zhTW = "旅店老闆納克羅·壁爐" },
    },
    {
        id = 458, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.2187, y = 0.4482,
        name = { enUS = "Innkeeper Brianna", deDE = "Gastwirtin Brianna", esES = "Tabernero Brianna", esMX = "Tabernero Brianna", frFR = "Brianna l'aubergiste", koKR = "여관주인 브리아나", ptBR = "Estalajadeira Briana", ruRU = "Хозяйка таверны Брианна", zhCN = "旅店老板布瑞安娜", zhTW = "旅店老闆布里安娜" },
    },
    {
        id = 459, types = { "innkeeper", "vendor-food" },
        faction = "Neutral", map = 1434, x = 0.2701, y = 0.7730,
        name = { enUS = "Innkeeper Skindle", deDE = "Gastwirt Skindle", esES = "Tabernero Skindle", esMX = "Tabernero Skindle", frFR = "Skindle l'aubergiste", koKR = "여관주인 스킨들", ptBR = "Estalajadeiro Skindle", ruRU = "Хозяин таверны Втридорог", zhCN = "旅店老板斯金德", zhTW = "旅店老闆斯金德" },
    },
    {
        id = 460, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1434, x = 0.3150, y = 0.2979,
        name = { enUS = "Innkeeper Thulbek", deDE = "Gastwirt Thulbek", esES = "Tabernero Thulbek", esMX = "Tabernero Thulbek", frFR = "Aubergiste Thulbek", koKR = "여관주인 툴벡", ptBR = "Estalajadeiro Thulbek", ruRU = "Хозяин таверны Тулбек", zhCN = "旅店老板苏贝克", zhTW = "旅店老闆蘇爾貝克" },
    },
    {
        id = 461, types = { "innkeeper" },
        faction = "Horde", map = 1435, x = 0.4521, y = 0.5671,
        name = { enUS = "Innkeeper Karakul", deDE = "Gastwirt Karakul", esES = "Tabernero Karkul", esMX = "Tabernero Karkul", frFR = "Karakul l'aubergiste", koKR = "여관주인 카라쿨", ptBR = "Estalajadeiro Karakal", ruRU = "Хозяин таверны Каракуль", zhCN = "旅店老板卡拉库尔", zhTW = "旅店老闆卡拉庫爾" },
    },
    {
        id = 462, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1436, x = 0.5290, y = 0.5371,
        name = { enUS = "Innkeeper Heather", deDE = "Gastwirtin Heather", esES = "Tabernera Heather", esMX = "Tabernera Heather", frFR = "Aubergiste Heather", koKR = "여관주인 헤더", ptBR = "Estalajadeira Érica", ruRU = "Хозяйка таверны Хизер", zhCN = "旅店老板希瑟尔", zhTW = "旅店老闆希瑟爾" },
    },
    {
        id = 463, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1437, x = 0.1070, y = 0.6100,
        name = { enUS = "Innkeeper Helbrek", deDE = "Gastwirt Helbrek", esES = "Tabernero Helbrek", esMX = "Tabernero Helbrek", frFR = "Helbrek l'aubergiste", koKR = "여관주인 헬브렉", ptBR = "Estalajadeiro Inféretro", ruRU = "Хозяин таверны Хелбрек", zhCN = "旅店老板赫布瑞克", zhTW = "旅店老闆赫布瑞克" },
    },
    {
        id = 464, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1438, x = 0.5559, y = 0.5981,
        name = { enUS = "Innkeeper Keldamyr", deDE = "Gastwirt Keldamyr", esES = "Tabernero Keldamyr", esMX = "Tabernero Keldamyr", frFR = "Keldamyr l'aubergiste", koKR = "여관주인 켈다미르", ptBR = "Estalajadeiro Keldamyr", ruRU = "Хозяин таверны Кельдамир", zhCN = "旅店老板凯达米尔", zhTW = "旅店老闆凱達米爾" },
    },
    {
        id = 465, types = { "innkeeper" },
        faction = "Alliance", map = 1439, x = 0.3699, y = 0.4409,
        name = { enUS = "Innkeeper Shaussiy", deDE = "Gastwirtin Shaussiy", esES = "Tabernero Shaussiy", esMX = "Tabernera Shaussiy", frFR = "Shaussiy l'aubergiste", koKR = "여관주인 샤우시", ptBR = "Estalajadeira Shaussiy", ruRU = "Хозяйка таверны Шосси", zhCN = "旅店老板莎希因", zhTW = "旅店老闆莎希因" },
    },
    {
        id = 466, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1440, x = 0.7399, y = 0.6059,
        name = { enUS = "Innkeeper Kaylisk", deDE = "Gastwirtin Kaylisk", esES = "Tabernero Kaylisk", esMX = "Tabernera Kaylisk", frFR = "Aubergiste Kaylisk", koKR = "여관주인 카일리스크", ptBR = "Estalajadeira Kailisk", ruRU = "Хозяйка таверны Кайлиска", zhCN = "旅店老板凯利斯克", zhTW = "旅店老闆凱利斯克" },
    },
    {
        id = 467, types = { "innkeeper" },
        faction = "Alliance", map = 1440, x = 0.3699, y = 0.4921,
        name = { enUS = "Innkeeper Kimlya", deDE = "Gastwirtin Kimlya", esES = "Tabernero Kimlya", esMX = "Tabernera Kimlya", frFR = "Kimlya l'aubergiste", koKR = "여관주인 킴리아", ptBR = "Estalajadeira Kimlya", ruRU = "Хозяйка таверны Кимлия", zhCN = "旅店老板基姆利雅", zhTW = "旅店老闆基姆利雅" },
    },
    {
        id = 468, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1441, x = 0.4609, y = 0.5150,
        name = { enUS = "Innkeeper Abeqwa", deDE = "Gastwirt Abeqwa", esES = "Tabernero Abeqwa", esMX = "Tabernero Abeqwa", frFR = "Aubergiste Abeqwa", koKR = "여관주인 아베크와", ptBR = "Estalajadeiro Abeqwa", ruRU = "Хозяин таверны Абеква", zhCN = "旅店老板埃比克瓦", zhTW = "旅店老闆埃比克瓦" },
    },
    {
        id = 469, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1442, x = 0.3581, y = 0.0571,
        name = { enUS = "Innkeeper Faralia", deDE = "Gastwirtin Faralia", esES = "Tabernero Faralia", esMX = "Tabernero Faralia", frFR = "Aubergiste Faralia", koKR = "여관주인 파랄리아", ptBR = "Estalajadeira Faralia", ruRU = "Хозяйка таверны Фаралия", zhCN = "旅店老板法拉莉亚", zhTW = "旅店老闆法拉莉雅" },
    },
    {
        id = 470, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1442, x = 0.4749, y = 0.6210,
        name = { enUS = "Innkeeper Jayka", deDE = "Gastwirt Jayka", esES = "Tabernero Jayka", esMX = "Tabernera Jayka", frFR = "Aubergiste Jayka", koKR = "여관주인 자이카", ptBR = "Estalajadeira Jayka", ruRU = "Хозяйка таверны Джайка", zhCN = "旅店老板杰卡", zhTW = "旅店老闆傑卡" },
    },
    {
        id = 471, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1443, x = 0.6631, y = 0.0659,
        name = { enUS = "Innkeeper Lyshaerya", deDE = "Gastwirtin Lyshaerya", esES = "Tabernero Lyshaerya", esMX = "Tabernero Lyshaerya", frFR = "Aubergiste Lyshaerya", koKR = "여관주인 리쉐랴", ptBR = "Estalajadeira Lyshaerya", ruRU = "Хозяйка таверны Лиссерея", zhCN = "旅店老板利莎瑞亚", zhTW = "旅店老闆利莎瑞亞" },
    },
    {
        id = 472, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1443, x = 0.2411, y = 0.6818,
        name = { enUS = "Innkeeper Sikewa", deDE = "Gastwirtin Sikewa", esES = "Tabernero Sikewa", esMX = "Tabernera Sikewa", frFR = "Aubergiste Sikewa", koKR = "여관주인 시케와", ptBR = "Estalajadeira Sikewa", ruRU = "Хозяйка таверны Сикоя", zhCN = "旅店老板希科瓦", zhTW = "旅店老闆希科瓦" },
    },
    {
        id = 473, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1444, x = 0.7481, y = 0.4521,
        name = { enUS = "Innkeeper Greul", deDE = "Gastwirtin Greul", esES = "Tabernera Greul", esMX = "Tabernera Greul", frFR = "Aubergiste Greul", koKR = "여관주인 그룰", ptBR = "Estalajadeiro Greul", ruRU = "Хозяйка таверны Греула", zhCN = "旅店老板格鲁尔", zhTW = "旅店老闆格盧爾" },
    },
    {
        id = 474, types = { "innkeeper" },
        faction = "Alliance", map = 1444, x = 0.3101, y = 0.4351,
        name = { enUS = "Innkeeper Shyria", deDE = "Gastwirtin Shyria", esES = "Tabernero Shyria", esMX = "Tabernero Shyria", frFR = "Aubergiste Shyria", koKR = "여관주인 쉬리아", ptBR = "Estalajadeira Shyria", ruRU = "Хозяйка таверны Шария", zhCN = "旅店老板希瑞亚", zhTW = "旅店老闆希瑞亞" },
    },
    {
        id = 475, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1445, x = 0.6661, y = 0.4518,
        name = { enUS = "Innkeeper Janene", deDE = "Gastwirtin Janene", esES = "Tabernero Janene", esMX = "Tabernera Janene", frFR = "Janene l'aubergiste", koKR = "여관주인 지나인", ptBR = "Estalajadeira Janine", ruRU = "Хозяйка таверны Джанин", zhCN = "旅店老板詹妮", zhTW = "旅店老闆詹妮" },
    },
    {
        id = 476, types = { "innkeeper", "vendor-food" },
        faction = "Neutral", map = 1446, x = 0.5250, y = 0.2791,
        name = { enUS = "Innkeeper Fizzgrimble", deDE = "Gastwirt Fizzgrimble", esES = "Tabernero Fizzgrimble", esMX = "Tabernero Fizzgrimble", frFR = "Aubergiste Fizzgrimble", koKR = "여관주인 피즈그림블", ptBR = "Estalajadeiro Gabor Bulho", ruRU = "Хозяин таверны Ворчунелло", zhCN = "旅店老板菲兹格瑞博", zhTW = "旅店老闆菲茲格瑞博" },
    },
    {
        id = 477, types = { "innkeeper" },
        map = 1447, x = 0.1260, y = 0.7732,
        name = { enUS = "Berdun Cliffbrew", deDE = "Berdun Cliffbrew", esES = "Berdun Cliffbrew", esMX = "Berdun Cliffbrew", frFR = "Berdun Cliffbrew", koKR = "Berdun Cliffbrew", ptBR = "Berdun Cliffbrew", ruRU = "Berdun Cliffbrew", zhCN = "Berdun Cliffbrew", zhTW = "Berdun Cliffbrew" },
    },
    {
        id = 478, types = { "innkeeper", "vendor-ammo" },
        faction = "Neutral", map = 1451, x = 0.5191, y = 0.3922,
        name = { enUS = "Calandrath", deDE = "Calandrath", esES = "Calandrath", esMX = "Calandrath", frFR = "Calandrath", koKR = "캘랜드라스", ptBR = "Calandrath", ruRU = "Каландрата", zhCN = "卡兰德拉斯", zhTW = "卡蘭德拉斯" },
    },
    {
        id = 479, types = { "innkeeper", "vendor-food" },
        faction = "Neutral", map = 1452, x = 0.6140, y = 0.3879,
        name = { enUS = "Innkeeper Vizzie", deDE = "Gastwirt Vizzie", esES = "Tabernera Vizzie", esMX = "Tabernera Vizzie", frFR = "Aubergiste Vizzie", koKR = "여관주인 비지", ptBR = "Estalajadeira Vizzi", ruRU = "Хозяйка таверны Виззи", zhCN = "旅店老板维兹奇", zhTW = "旅店老闆維茲奇" },
    },
    {
        id = 480, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6041, y = 0.7529,
        name = { enUS = "Innkeeper Allison", deDE = "Gastwirtin Allison", esES = "Tabernera Allison", esMX = "Tabernera Allison", frFR = "Aubergiste Allison", koKR = "여관주인 앨리슨", ptBR = "Estalajadeira Cristine", ruRU = "Хозяйка таверны Аллисон", zhCN = "旅店老板奥里森", zhTW = "旅店老闆奧里森" },
    },
    {
        id = 481, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1454, x = 0.5414, y = 0.6833,
        name = { enUS = "Innkeeper Gryshka", deDE = "Gastwirtin Gryshka", esES = "Tabernero Gryshka", esMX = "Tabernera Gryshka", frFR = "Gryshka l'aubergiste", koKR = "여관주인 그리쉬카", ptBR = "Estalajadeira Gryshka", ruRU = "Хозяйка таверны Гришка", zhCN = "旅店老板格雷什卡", zhTW = "旅店老闆格雷什卡" },
    },
    {
        id = 482, types = { "innkeeper", "vendor-food" },
        faction = "Horde", map = 1456, x = 0.4580, y = 0.6467,
        name = { enUS = "Innkeeper Pala", deDE = "Gastwirtin Pala", esES = "Tabernera Pala", esMX = "Tabernera Pala", frFR = "Pala l'aubergiste", koKR = "여관주인 팔라", ptBR = "Estalajadeira Pala", ruRU = "Хозяйка таверны Пала", zhCN = "旅店老板帕拉", zhTW = "旅店老闆帕拉" },
    },
    {
        id = 483, types = { "innkeeper", "vendor-food" },
        faction = "Alliance", map = 1457, x = 0.6737, y = 0.1563,
        name = { enUS = "Innkeeper Saelienne", deDE = "Gastwirtin Saelienne", esES = "Tabernero Saelienne", esMX = "Tabernera Saelienne", frFR = "Saelienne l'aubergiste", koKR = "여관주인 셀리에네", ptBR = "Estalajadeira Saliennte", ruRU = "Хозяйка таверны Салиенна", zhCN = "旅店老板塞琳尼", zhTW = "旅店老闆塞琳尼" },
    },
    {
        id = 484, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        faction = "Alliance", map = 2482, x = 0.1560, y = 0.5040,
        name = { enUS = "Caitir Flinthew", deDE = "Caitir Flinthew", esES = "Caitir Flinthew", esMX = "Caitir Flinthew", frFR = "Caitir Flinthew", koKR = "Caitir Flinthew", ptBR = "Caitir Flinthew", ruRU = "Caitir Flinthew", zhCN = "Caitir Flinthew", zhTW = "Caitir Flinthew" },
    },
    {
        id = 485, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2482, x = 0.1280, y = 0.5240,
        name = { enUS = "Ortak Lomgok", deDE = "Ortak Lomgok", esES = "Ortak Lomgok", esMX = "Ortak Lomgok", frFR = "Ortak Lomgok", koKR = "Ortak Lomgok", ptBR = "Ortak Lomgok", ruRU = "Ortak Lomgok", zhCN = "Ortak Lomgok", zhTW = "Ortak Lomgok" },
    },
    {
        id = 486, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2482, x = 0.1300, y = 0.5280,
        name = { enUS = "Ortak Lomgok", deDE = "Ortak Lomgok", esES = "Ortak Lomgok", esMX = "Ortak Lomgok", frFR = "Ortak Lomgok", koKR = "Ortak Lomgok", ptBR = "Ortak Lomgok", ruRU = "Ortak Lomgok", zhCN = "Ortak Lomgok", zhTW = "Ortak Lomgok" },
    },
    {
        id = 487, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        faction = "Alliance", map = 2482, x = 0.7083, y = 0.5150,
        name = { enUS = "Sebelia", deDE = "Sebelia", esES = "Sebelia", esMX = "Sebelia", frFR = "Sebelia", koKR = "Sebelia", ptBR = "Sebelia", ruRU = "Sebelia", zhCN = "Sebelia", zhTW = "Sebelia" },
    },
    {
        id = 488, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        faction = "Neutral", map = 2521, x = 0.4301, y = 0.4323,
        name = { enUS = "Coriella Calmbreeze", deDE = "Coriella Calmbreeze", esES = "Coriella Calmbreeze", esMX = "Coriella Calmbreeze", frFR = "Coriella Calmbreeze", koKR = "Coriella Calmbreeze", ptBR = "Coriella Calmbreeze", ruRU = "Coriella Calmbreeze", zhCN = "Coriella Calmbreeze", zhTW = "Coriella Calmbreeze" },
    },
    {
        id = 489, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        faction = "Neutral", map = 2521, x = 0.6219, y = 0.7261,
        name = { enUS = "Donaal Downbreeze", deDE = "Donaal Downbreeze", esES = "Donaal Downbreeze", esMX = "Donaal Downbreeze", frFR = "Donaal Downbreeze", koKR = "Donaal Downbreeze", ptBR = "Donaal Downbreeze", ruRU = "Donaal Downbreeze", zhCN = "Donaal Downbreeze", zhTW = "Donaal Downbreeze" },
    },
    {
        id = 490, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.6464, y = 0.8419,
        name = { enUS = "Barracks Master Harlan", deDE = "Barracks Master Harlan", esES = "Barracks Master Harlan", esMX = "Barracks Master Harlan", frFR = "Barracks Master Harlan", koKR = "Barracks Master Harlan", ptBR = "Barracks Master Harlan", ruRU = "Barracks Master Harlan", zhCN = "Barracks Master Harlan", zhTW = "Barracks Master Harlan" },
    },
    {
        id = 491, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.6466, y = 0.8425,
        name = { enUS = "Barracks Master Harlan", deDE = "Barracks Master Harlan", esES = "Barracks Master Harlan", esMX = "Barracks Master Harlan", frFR = "Barracks Master Harlan", koKR = "Barracks Master Harlan", ptBR = "Barracks Master Harlan", ruRU = "Barracks Master Harlan", zhCN = "Barracks Master Harlan", zhTW = "Barracks Master Harlan" },
    },
    {
        id = 492, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.5804, y = 0.4512,
        name = { enUS = "Innkeeper Toka", deDE = "Innkeeper Toka", esES = "Innkeeper Toka", esMX = "Innkeeper Toka", frFR = "Innkeeper Toka", koKR = "Innkeeper Toka", ptBR = "Innkeeper Toka", ruRU = "Innkeeper Toka", zhCN = "Innkeeper Toka", zhTW = "Innkeeper Toka" },
    },
    {
        id = 493, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.7869, y = 0.5396,
        name = { enUS = "Innkeeper Zizplink", deDE = "Innkeeper Zizplink", esES = "Innkeeper Zizplink", esMX = "Innkeeper Zizplink", frFR = "Innkeeper Zizplink", koKR = "Innkeeper Zizplink", ptBR = "Innkeeper Zizplink", ruRU = "Innkeeper Zizplink", zhCN = "Innkeeper Zizplink", zhTW = "Innkeeper Zizplink" },
    },
    {
        id = 494, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.7875, y = 0.5403,
        name = { enUS = "Innkeeper Zizplink", deDE = "Innkeeper Zizplink", esES = "Innkeeper Zizplink", esMX = "Innkeeper Zizplink", frFR = "Innkeeper Zizplink", koKR = "Innkeeper Zizplink", ptBR = "Innkeeper Zizplink", ruRU = "Innkeeper Zizplink", zhCN = "Innkeeper Zizplink", zhTW = "Innkeeper Zizplink" },
    },
    {
        id = 495, types = { "innkeeper", "vendor-ammo", "vendor-food" },
        map = 2548, x = 0.7878, y = 0.5411,
        name = { enUS = "Innkeeper Zizplink", deDE = "Innkeeper Zizplink", esES = "Innkeeper Zizplink", esMX = "Innkeeper Zizplink", frFR = "Innkeeper Zizplink", koKR = "Innkeeper Zizplink", ptBR = "Innkeeper Zizplink", ruRU = "Innkeeper Zizplink", zhCN = "Innkeeper Zizplink", zhTW = "Innkeeper Zizplink" },
    },
    {
        id = 496, types = { "innkeeper" },
        map = 2652, x = 0.4279, y = 0.7048,
        name = { enUS = "Adarien", deDE = "Adarien", esES = "Adarien", esMX = "Adarien", frFR = "Adarien", koKR = "Adarien", ptBR = "Adarien", ruRU = "Adarien", zhCN = "Adarien", zhTW = "Adarien" },
    },
    {
        id = 497, types = { "innkeeper" },
        map = 2652, x = 0.4400, y = 0.7236,
        name = { enUS = "Adarien", deDE = "Adarien", esES = "Adarien", esMX = "Adarien", frFR = "Adarien", koKR = "Adarien", ptBR = "Adarien", ruRU = "Adarien", zhCN = "Adarien", zhTW = "Adarien" },
    },
})
