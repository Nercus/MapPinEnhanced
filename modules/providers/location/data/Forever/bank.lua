-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 30, types = { "banker" },
        faction = "Neutral", map = 1413, x = 0.6263, y = 0.3742,
        name = { enUS = "Fuzruckle", deDE = "Fuzruckle", esES = "Fuzruckle", esMX = "Fuzruckle", frFR = "Fuzruckle", koKR = "퍼즈럭클", ptBR = "Bancarroto", ruRU = "Складкофуз", zhCN = "法兹拉克", zhTW = "法茲拉克" },
    },
    {
        id = 31, types = { "banker" },
        faction = "Neutral", map = 1413, x = 0.6267, y = 0.3740,
        name = { enUS = "Zikkel", deDE = "Zikkel", esES = "Zikkel", esMX = "Zikkel", frFR = "Zikkel", koKR = "직켈", ptBR = "Zikkal", ruRU = "Зиккель", zhCN = "兹科尔", zhTW = "茲科爾" },
    },
    {
        id = 32, types = { "banker" },
        map = 1416, x = 0.1068, y = 0.6870,
        name = { enUS = "Paymaster Chang", deDE = "Paymaster Chang", esES = "Paymaster Chang", esMX = "Paymaster Chang", frFR = "Paymaster Chang", koKR = "Paymaster Chang", ptBR = "Paymaster Chang", ruRU = "Paymaster Chang", zhCN = "Paymaster Chang", zhTW = "Paymaster Chang" },
    },
    {
        id = 33, types = { "banker" },
        map = 1416, x = 0.1117, y = 0.6871,
        name = { enUS = "Teller Almeida", deDE = "Teller Almeida", esES = "Teller Almeida", esMX = "Teller Almeida", frFR = "Teller Almeida", koKR = "Teller Almeida", ptBR = "Teller Almeida", ruRU = "Teller Almeida", zhCN = "Teller Almeida", zhTW = "Teller Almeida" },
    },
    {
        id = 34, types = { "banker" },
        map = 1416, x = 0.2220, y = 0.6540,
        name = { enUS = "Teller Althiellis", deDE = "Teller Althiellis", esES = "Teller Althiellis", esMX = "Teller Althiellis", frFR = "Teller Althiellis", koKR = "Teller Althiellis", ptBR = "Teller Althiellis", ruRU = "Teller Althiellis", zhCN = "Teller Althiellis", zhTW = "Teller Althiellis" },
    },
    {
        id = 35, types = { "banker" },
        map = 1416, x = 0.2240, y = 0.6560,
        name = { enUS = "Teller Althiellis", deDE = "Teller Althiellis", esES = "Teller Althiellis", esMX = "Teller Althiellis", frFR = "Teller Althiellis", koKR = "Teller Althiellis", ptBR = "Teller Althiellis", ruRU = "Teller Althiellis", zhCN = "Teller Althiellis", zhTW = "Teller Althiellis" },
    },
    {
        id = 36, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.1040, y = 0.6852,
        name = { enUS = "Teller Gee", deDE = "Teller Gee", esES = "Teller Gee", esMX = "Teller Gee", frFR = "Teller Gee", koKR = "Teller Gee", ptBR = "Teller Gee", ruRU = "Teller Gee", zhCN = "Teller Gee", zhTW = "Teller Gee" },
    },
    {
        id = 37, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.1040, y = 0.6861,
        name = { enUS = "Teller Gee", deDE = "Teller Gee", esES = "Teller Gee", esMX = "Teller Gee", frFR = "Teller Gee", koKR = "Teller Gee", ptBR = "Teller Gee", ruRU = "Teller Gee", zhCN = "Teller Gee", zhTW = "Teller Gee" },
    },
    {
        id = 38, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.1043, y = 0.6844,
        name = { enUS = "Teller Gee", deDE = "Teller Gee", esES = "Teller Gee", esMX = "Teller Gee", frFR = "Teller Gee", koKR = "Teller Gee", ptBR = "Teller Gee", ruRU = "Teller Gee", zhCN = "Teller Gee", zhTW = "Teller Gee" },
    },
    {
        id = 39, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2297, y = 0.6512,
        name = { enUS = "Teller Hanners", deDE = "Teller Hanners", esES = "Teller Hanners", esMX = "Teller Hanners", frFR = "Teller Hanners", koKR = "Teller Hanners", ptBR = "Teller Hanners", ruRU = "Teller Hanners", zhCN = "Teller Hanners", zhTW = "Teller Hanners" },
    },
    {
        id = 40, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2302, y = 0.6511,
        name = { enUS = "Teller Hanners", deDE = "Teller Hanners", esES = "Teller Hanners", esMX = "Teller Hanners", frFR = "Teller Hanners", koKR = "Teller Hanners", ptBR = "Teller Hanners", ruRU = "Teller Hanners", zhCN = "Teller Hanners", zhTW = "Teller Hanners" },
    },
    {
        id = 41, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2311, y = 0.6510,
        name = { enUS = "Teller Hanners", deDE = "Teller Hanners", esES = "Teller Hanners", esMX = "Teller Hanners", frFR = "Teller Hanners", koKR = "Teller Hanners", ptBR = "Teller Hanners", ruRU = "Teller Hanners", zhCN = "Teller Hanners", zhTW = "Teller Hanners" },
    },
    {
        id = 42, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2312, y = 0.6501,
        name = { enUS = "Teller Hanners", deDE = "Teller Hanners", esES = "Teller Hanners", esMX = "Teller Hanners", frFR = "Teller Hanners", koKR = "Teller Hanners", ptBR = "Teller Hanners", ruRU = "Teller Hanners", zhCN = "Teller Hanners", zhTW = "Teller Hanners" },
    },
    {
        id = 43, types = { "banker" },
        map = 1416, x = 0.1040, y = 0.6900,
        name = { enUS = "Teller Plushner", deDE = "Teller Plushner", esES = "Teller Plushner", esMX = "Teller Plushner", frFR = "Teller Plushner", koKR = "Teller Plushner", ptBR = "Teller Plushner", ruRU = "Teller Plushner", zhCN = "Teller Plushner", zhTW = "Teller Plushner" },
    },
    {
        id = 44, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2287, y = 0.6447,
        name = { enUS = "Teller Rames", deDE = "Teller Rames", esES = "Teller Rames", esMX = "Teller Rames", frFR = "Teller Rames", koKR = "Teller Rames", ptBR = "Teller Rames", ruRU = "Teller Rames", zhCN = "Teller Rames", zhTW = "Teller Rames" },
    },
    {
        id = 45, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2293, y = 0.6438,
        name = { enUS = "Teller Rames", deDE = "Teller Rames", esES = "Teller Rames", esMX = "Teller Rames", frFR = "Teller Rames", koKR = "Teller Rames", ptBR = "Teller Rames", ruRU = "Teller Rames", zhCN = "Teller Rames", zhTW = "Teller Rames" },
    },
    {
        id = 46, types = { "banker" },
        faction = "Alliance", map = 1416, x = 0.2294, y = 0.6446,
        name = { enUS = "Teller Rames", deDE = "Teller Rames", esES = "Teller Rames", esMX = "Teller Rames", frFR = "Teller Rames", koKR = "Teller Rames", ptBR = "Teller Rames", ruRU = "Teller Rames", zhCN = "Teller Rames", zhTW = "Teller Rames" },
    },
    {
        id = 47, types = { "banker" },
        faction = "Horde", map = 1420, x = 0.6191, y = 0.7441,
        name = { enUS = "Mortimer Montague", deDE = "Mortimer Montague", esES = "Mortimer Montague", esMX = "Mortimer Montesco", frFR = "Mortimer Montague", koKR = "모르티머 몬테그", ptBR = "Atílio Mourão", ruRU = "Мортимер Монтегю", zhCN = "摩塔莫尔·蒙泰古", zhTW = "摩塔莫爾·蒙泰古" },
    },
    {
        id = 48, types = { "banker" },
        faction = "Horde", map = 1420, x = 0.6173, y = 0.7441,
        name = { enUS = "Ophelia Montague", deDE = "Ophelia Montague", esES = "Ofelia Montague", esMX = "Ofelia Montesco", frFR = "Ophelia Montague", koKR = "오펠리아 몬테그", ptBR = "Ofélia Mourão", ruRU = "Офелия Монтэгю", zhCN = "奥芬利亚·蒙泰古", zhTW = "奧芬利亞·蒙泰古" },
    },
    {
        id = 49, types = { "banker" },
        faction = "Horde", map = 1420, x = 0.6182, y = 0.7427,
        name = { enUS = "Randolph Montague", deDE = "Randolph Montague", esES = "Randolph Montague", esMX = "Randolph Montesco", frFR = "Randolph Montague", koKR = "란돌프 몬테그", ptBR = "Rodolfo Mourão", ruRU = "Рэндолф Монтегю", zhCN = "伦道夫·蒙泰古", zhTW = "藍道夫·蒙泰古" },
    },
    {
        id = 50, types = { "banker" },
        faction = "Horde", map = 1420, x = 0.6182, y = 0.7454,
        name = { enUS = "William Montague", deDE = "William Montague", esES = "William Montague", esMX = "William Montesco", frFR = "William Montague", koKR = "윌리엄 몬테그", ptBR = "Guilherme Mourão", ruRU = "Вильям Монтегю", zhCN = "威廉·蒙泰古", zhTW = "威廉·蒙泰古" },
    },
    {
        id = 51, types = { "banker" },
        faction = "Alliance", map = 1426, x = 0.5684, y = 0.3075,
        name = { enUS = "Bailey Stonemantle", deDE = "Bailey Stonemantle", esES = "Bailey Mantopétreo", esMX = "Bailey Mantopétreo", frFR = "Bailey Stonemantle", koKR = "바일리 스톤맨틀", ptBR = "Bailey Itamanto", ruRU = "Бейл Каменная Мантия", zhCN = "拜雷·石衣", zhTW = "拜雷·石衣" },
    },
    {
        id = 52, types = { "banker" },
        faction = "Alliance", map = 1426, x = 0.5671, y = 0.3046,
        name = { enUS = "Barnum Stonemantle", deDE = "Barnum Stonemantle", esES = "Barnum Mantopétreo", esMX = "Barnum Mantopétreo", frFR = "Barnum Stonemantle", koKR = "바르눔 스톤맨틀", ptBR = "Barnum Itamanto", ruRU = "Барнум Каменная Мантия", zhCN = "巴纳姆·石衣", zhTW = "巴納姆·石衣" },
    },
    {
        id = 53, types = { "banker" },
        faction = "Alliance", map = 1426, x = 0.5698, y = 0.3103,
        name = { enUS = "Soleil Stonemantle", deDE = "Soleil Stonemantle", esES = "Soleil Mantopétreo", esMX = "Soleil Mantopétreo", frFR = "Soleil Stonemantle", koKR = "솔레일 스톤맨틀", ptBR = "Sol Itamanto", ruRU = "Солейла Камнегривая", zhCN = "索雷尔·石衣", zhTW = "索雷爾·石衣" },
    },
    {
        id = 54, types = { "banker" },
        faction = "Neutral", map = 1434, x = 0.2651, y = 0.7646,
        name = { enUS = "Rickle Goldgrubber", deDE = "Rickle Goldgrubber", esES = "Rickle Limpiaoro", esMX = "Rickle Limpiaoro", frFR = "Rickle Goldgrubber", koKR = "릭클 골드그러버", ptBR = "Rickle Farejouro", ruRU = "Рикль Златочах", zhCN = "掘金者里克", zhTW = "掘金者里克" },
    },
    {
        id = 55, types = { "banker" },
        faction = "Neutral", map = 1434, x = 0.2655, y = 0.7658,
        name = { enUS = "Viznik Goldgrubber", deDE = "Viznik Goldgrubber", esES = "Viznik Limpiaoro", esMX = "Viznik Limpiaoro", frFR = "Viznik Goldgrubber", koKR = "비즈닉 골드그러버", ptBR = "Viznik Farejouro", ruRU = "Визник Златочах", zhCN = "掘金者维兹尼克", zhTW = "掘金者維茲尼克" },
    },
    {
        id = 56, types = { "banker" },
        faction = "Neutral", map = 1446, x = 0.5229, y = 0.2892,
        name = { enUS = "Gimblethorn", deDE = "Gimblethorn", esES = "Gimblespina", esMX = "Gimblespina", frFR = "Gimblethorn", koKR = "김블쏜", ptBR = "Cardo Cárdan", ruRU = "Гироскоппер", zhCN = "吉布索恩", zhTW = "吉布索恩" },
    },
    {
        id = 57, types = { "banker" },
        faction = "Neutral", map = 1446, x = 0.5237, y = 0.2895,
        name = { enUS = "Qizzik", deDE = "Qizzik", esES = "Qizzik", esMX = "Qizzik", frFR = "Qizzik", koKR = "퀴직크", ptBR = "Qizzik", ruRU = "Квиззик", zhCN = "奇兹克", zhTW = "奇茲克" },
    },
    {
        id = 58, types = { "banker" },
        faction = "Neutral", map = 1452, x = 0.6146, y = 0.3699,
        name = { enUS = "Izzy Coppergrab", deDE = "Izzy Kupferzock", esES = "Izzy Damecobre", esMX = "Izzy Damecobre", frFR = "Izzy Coppergrab", koKR = "이찌 코퍼그랩", ptBR = "Cupertino Peguifaço", ruRU = "Иззи Медноцап", zhCN = "伊兹·考伯加布", zhTW = "伊茲·考伯加布" },
    },
    {
        id = 59, types = { "banker" },
        faction = "Alliance", map = 1453, x = 0.6348, y = 0.8140,
        name = { enUS = "John Burnside", deDE = "John Burnside", esES = "John Ladoquemao", esMX = "John Ladoquemao", frFR = "John Burnside", koKR = "존 번사이드", ptBR = "Zaca Ardelado", ruRU = "Джон Бернсайд", zhCN = "约翰·伯恩赛德", zhTW = "約翰·伯恩賽德" },
    },
    {
        id = 60, types = { "banker" },
        faction = "Alliance", map = 1453, x = 0.6386, y = 0.8105,
        name = { enUS = "Newton Burnside", deDE = "Newton Burnside", esES = "Newton Ladoquemao", esMX = "Newton Ladoquemao", frFR = "Newton Burnside", koKR = "뉴튼 번사이드", ptBR = "Mumu Ardelado", ruRU = "Ньютон Бернсайд", zhCN = "牛顿·伯恩赛德", zhTW = "牛頓·伯恩賽德" },
    },
    {
        id = 61, types = { "banker" },
        faction = "Alliance", map = 1453, x = 0.6432, y = 0.8070,
        name = { enUS = "Olivia Burnside", deDE = "Olivia Burnside", esES = "Olivia Ladoquemao", esMX = "Olivia Ladoquemao", frFR = "Olivia Burnside", koKR = "올리비아 번사이드", ptBR = "Didi Ardelado", ruRU = "Оливия Бернсайд", zhCN = "奥利维亚·伯恩赛德", zhTW = "奧利維亞·伯恩賽德" },
    },
    {
        id = 62, types = { "banker" },
        faction = "Horde", map = 1454, x = 0.4958, y = 0.6905,
        name = { enUS = "Karus", deDE = "Karus", esES = "Karus", esMX = "Karus", frFR = "Karus", koKR = "카루스", ptBR = "Karus", ruRU = "Карус", zhCN = "卡鲁斯", zhTW = "卡魯斯" },
    },
    {
        id = 63, types = { "banker" },
        faction = "Horde", map = 1454, x = 0.4996, y = 0.6862,
        name = { enUS = "Koma", deDE = "Koma", esES = "Koma", esMX = "Koma", frFR = "Koma", koKR = "코마", ptBR = "Krona", ruRU = "Кома", zhCN = "库玛", zhTW = "寇瑪" },
    },
    {
        id = 64, types = { "banker" },
        faction = "Horde", map = 1454, x = 0.4910, y = 0.6962,
        name = { enUS = "Soran", deDE = "Soran", esES = "Soran", esMX = "Soran", frFR = "Soran", koKR = "소란", ptBR = "Soran", ruRU = "Соран", zhCN = "索兰", zhTW = "索蘭" },
    },
    {
        id = 65, types = { "banker" },
        faction = "Horde", map = 1456, x = 0.4720, y = 0.5931,
        name = { enUS = "Atepa", deDE = "Atepa", esES = "Atepa", esMX = "Atepa", frFR = "Atepa", koKR = "아테파", ptBR = "Atepa", ruRU = "Атепа", zhCN = "阿特帕", zhTW = "阿特帕" },
    },
    {
        id = 66, types = { "banker" },
        faction = "Horde", map = 1456, x = 0.4707, y = 0.5796,
        name = { enUS = "Chesmu", deDE = "Chesmu", esES = "Chesmu", esMX = "Chesmu", frFR = "Chesmu", koKR = "체스무", ptBR = "Chesmu", ruRU = "Чесму", zhCN = "彻斯姆", zhTW = "徹斯姆" },
    },
    {
        id = 67, types = { "banker" },
        faction = "Horde", map = 1456, x = 0.4758, y = 0.5854,
        name = { enUS = "Torn", deDE = "Torn", esES = "Rotín", esMX = "Rotín", frFR = "Torn", koKR = "토른", ptBR = "Torn", ruRU = "Торн", zhCN = "托恩", zhTW = "托恩" },
    },
    {
        id = 68, types = { "banker" },
        faction = "Alliance", map = 1457, x = 0.3966, y = 0.4189,
        name = { enUS = "Garryeth", deDE = "Garryeth", esES = "Garryeth", esMX = "Garryeth", frFR = "Garryeth", koKR = "가리예스", ptBR = "Garryeth", ruRU = "Гарриет", zhCN = "加瑞斯", zhTW = "加瑞斯" },
    },
    {
        id = 69, types = { "banker" },
        faction = "Alliance", map = 1457, x = 0.3940, y = 0.4246,
        name = { enUS = "Idriana", deDE = "Idriana", esES = "Idriana", esMX = "Idriana", frFR = "Idriana", koKR = "이드리아나", ptBR = "Idriana", ruRU = "Идриана", zhCN = "伊迪瑞娜", zhTW = "伊迪瑞娜" },
    },
    {
        id = 70, types = { "banker" },
        faction = "Alliance", map = 1457, x = 0.3966, y = 0.4151,
        name = { enUS = "Lairn", deDE = "Lairn", esES = "Lairn", esMX = "Lairn", frFR = "Lairn", koKR = "라이른", ptBR = "Lairn", ruRU = "Лайрн", zhCN = "莱恩", zhTW = "萊恩" },
    },
    {
        id = 71, types = { "banker" },
        faction = "Neutral", map = 2521, x = 0.5763, y = 0.7717,
        name = { enUS = "Baelann Favorbreeze", deDE = "Baelann Favorbreeze", esES = "Baelann Favorbreeze", esMX = "Baelann Favorbreeze", frFR = "Baelann Favorbreeze", koKR = "Baelann Favorbreeze", ptBR = "Baelann Favorbreeze", ruRU = "Baelann Favorbreeze", zhCN = "Baelann Favorbreeze", zhTW = "Baelann Favorbreeze" },
    },
    {
        id = 72, types = { "banker" },
        map = 2548, x = 0.7675, y = 0.5431,
        name = { enUS = "Brakkit", deDE = "Brakkit", esES = "Brakkit", esMX = "Brakkit", frFR = "Brakkit", koKR = "Brakkit", ptBR = "Brakkit", ruRU = "Brakkit", zhCN = "Brakkit", zhTW = "Brakkit" },
    },
    {
        id = 73, types = { "banker" },
        map = 2548, x = 0.7680, y = 0.5440,
        name = { enUS = "Lizi Pinchwhistle", deDE = "Lizi Pinchwhistle", esES = "Lizi Pinchwhistle", esMX = "Lizi Pinchwhistle", frFR = "Lizi Pinchwhistle", koKR = "Lizi Pinchwhistle", ptBR = "Lizi Pinchwhistle", ruRU = "Lizi Pinchwhistle", zhCN = "Lizi Pinchwhistle", zhTW = "Lizi Pinchwhistle" },
    },
    {
        id = 74, types = { "banker" },
        map = 2548, x = 0.7662, y = 0.5413,
        name = { enUS = "Mizzy", deDE = "Mizzy", esES = "Mizzy", esMX = "Mizzy", frFR = "Mizzy", koKR = "Mizzy", ptBR = "Mizzy", ruRU = "Mizzy", zhCN = "Mizzy", zhTW = "Mizzy" },
    },
})
