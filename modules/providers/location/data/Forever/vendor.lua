-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 989, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1411, x = 0.4259, y = 0.6730,
        name = { enUS = "Duokna", deDE = "Duokna", esES = "Duokna", esMX = "Duokna", frFR = "Duokna", koKR = "두오크나", ptBR = "Duokna", ruRU = "Дуокна", zhCN = "多克纳", zhTW = "多克納" },
    },
    {
        id = 990, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1411, x = 0.5301, y = 0.4101,
        name = { enUS = "Ghrawt", deDE = "Ghrawt", esES = "Ghrawt", esMX = "Ghrawt", frFR = "Ghrawt", koKR = "그와트", ptBR = "Ghrawt", ruRU = "Грахт", zhCN = "格劳特", zhTW = "格勞特" },
    },
    {
        id = 991, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1411, x = 0.5440, y = 0.4218,
        name = { enUS = "Jark", deDE = "Jark", esES = "Jark", esMX = "Jark", frFR = "Jark", koKR = "자르크", ptBR = "Jark", ruRU = "Джарк", zhCN = "加尔克", zhTW = "加爾克" },
    },
    {
        id = 992, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1411, x = 0.5631, y = 0.7339,
        name = { enUS = "K'waii", deDE = "K'waii", esES = "K'waii", esMX = "K'waii", frFR = "K'waii", koKR = "크와이", ptBR = "K'waii", ruRU = "К'вайа", zhCN = "克瓦埃", zhTW = "克瓦埃" },
    },
    {
        id = 993, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1411, x = 0.5649, y = 0.7309,
        name = { enUS = "Trayexir", deDE = "Trayexir", esES = "Trayexir", esMX = "Trayexir", frFR = "Trayexir", koKR = "트라예시르", ptBR = "Trayexir", ruRU = "Трайексир", zhCN = "特莱耶克", zhTW = "特萊耶克" },
    },
    {
        id = 994, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1412, x = 0.4479, y = 0.7700,
        name = { enUS = "Kawnie Softbreeze", deDE = "Kawnie Softbreeze", esES = "Kawnie Brisaleve", esMX = "Kawnie Brisaleve", frFR = "Kawnie Softbreeze", koKR = "카우니 소프트브리즈", ptBR = "Kaunie Brisa Suave", ruRU = "Кауни Нежный Ветерок", zhCN = "卡文尼·柔风", zhTW = "卡文尼·柔風" },
    },
    {
        id = 995, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1412, x = 0.4501, y = 0.6198,
        name = { enUS = "Kennah Hawkseye", deDE = "Kennah Hawkseye", esES = "Kennah Ojalcón", esMX = "Kennah Ojalcón", frFR = "Kennah Hawkseye", koKR = "케나 호크스아이", ptBR = "Kenna Olho de Falcão", ruRU = "Кеннах Соколиный Глаз", zhCN = "肯纳·鹰眼", zhTW = "肯納·鷹眼" },
    },
    {
        id = 996, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1412, x = 0.4531, y = 0.6130,
        name = { enUS = "Moorat Longstride", deDE = "Moorat Longstride", esES = "Moorat Zancada Larga", esMX = "Moorat Zancada Larga", frFR = "Moorat Longstride", koKR = "무라트 롱스트라이드", ptBR = "Moorat Passo Longo", ruRU = "Морат Дальний Путь", zhCN = "姆拉特·远行", zhTW = "姆拉特·遠行" },
    },
    {
        id = 997, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3399, y = 0.2203,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 998, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3403, y = 0.2280,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 999, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3406, y = 0.2331,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1000, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3428, y = 0.2203,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1001, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3431, y = 0.2252,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1002, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3433, y = 0.2259,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1003, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3451, y = 0.2295,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1004, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3456, y = 0.2357,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1005, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3459, y = 0.2284,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1006, types = { "vendor-ammo" },
        faction = "Horde", map = 1412, x = 0.3469, y = 0.2249,
        name = { enUS = "Sutara Plainstalker", deDE = "Sutara Plainstalker", esES = "Sutara Plainstalker", esMX = "Sutara Plainstalker", frFR = "Sutara Plainstalker", koKR = "Sutara Plainstalker", ptBR = "Sutara Plainstalker", ruRU = "Sutara Plainstalker", zhCN = "Sutara Plainstalker", zhTW = "Sutara Plainstalker" },
    },
    {
        id = 1007, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1413, x = 0.5170, y = 0.2991,
        name = { enUS = "Barg", deDE = "Barg", esES = "Barg", esMX = "Barg", frFR = "Barg", koKR = "바르그", ptBR = "Barg", ruRU = "Барг", zhCN = "巴尔格", zhTW = "巴爾格" },
    },
    {
        id = 1008, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 1413, x = 0.6190, y = 0.3881,
        name = { enUS = "Jazzik", deDE = "Jazzik", esES = "Jazzik", esMX = "Jazzik", frFR = "Jazzik", koKR = "재지크", ptBR = "Bossanovik", ruRU = "Джаззик", zhCN = "加吉克", zhTW = "加吉克" },
    },
    {
        id = 1009, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1413, x = 0.5109, y = 0.2910,
        name = { enUS = "Uthrok", deDE = "Uthrok", esES = "Uthrok", esMX = "Uthrok", frFR = "Uthrok", koKR = "우스로크", ptBR = "Uthrok", ruRU = "Утрок", zhCN = "阿瑟罗克", zhTW = "亞瑟羅克" },
    },
    {
        id = 1010, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1550, y = 0.7025,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1011, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1659, y = 0.7012,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1012, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1720, y = 0.7147,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1013, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1722, y = 0.7139,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1014, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1724, y = 0.7118,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1015, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1740, y = 0.7109,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1016, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1416, x = 0.1742, y = 0.7134,
        name = { enUS = "Aemara", deDE = "Aemara", esES = "Aemara", esMX = "Aemara", frFR = "Aemara", koKR = "Aemara", ptBR = "Aemara", ruRU = "Aemara", zhCN = "Aemara", zhTW = "Aemara" },
    },
    {
        id = 1017, types = { "vendor-ammo" },
        faction = "Alliance", map = 1416, x = 0.1392, y = 0.6330,
        name = { enUS = "Archmage Alvareaux", deDE = "Archmage Alvareaux", esES = "Archmage Alvareaux", esMX = "Archmage Alvareaux", frFR = "Archmage Alvareaux", koKR = "Archmage Alvareaux", ptBR = "Archmage Alvareaux", ruRU = "Archmage Alvareaux", zhCN = "Archmage Alvareaux", zhTW = "Archmage Alvareaux" },
    },
    {
        id = 1018, types = { "vendor-ammo", "vendor-repair" },
        faction = "Horde", map = 1416, x = 0.6279, y = 0.5929,
        name = { enUS = "Jekyll Flandring", deDE = "Jekyll Flandring", esES = "Jekyll Flandring", esMX = "Jekyll Flandring", frFR = "Jekyll Flandring", koKR = "제킬 플랜드링", ptBR = "Jekyll Fâmulo", ruRU = "Джекилл Флендринг", zhCN = "耶克里·弗兰迪", zhTW = "耶克里·弗蘭迪" },
    },
    {
        id = 1019, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1416, x = 0.3940, y = 0.8171,
        name = { enUS = "Thanthaldis Snowgleam", deDE = "Thanthaldis Snowgleam", esES = "Thanthaldis Brillaneve", esMX = "Thanthaldis Brillaneve", frFR = "Thanthaldis Snowgleam", koKR = "산살디스 스노우글림", ptBR = "Tantaldis Cintilaneve", ruRU = "Тантальдис Снегоблеск", zhCN = "塔萨迪斯·雪光", zhTW = "塔薩迪斯·雪光" },
    },
    {
        id = 1020, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1417, x = 0.7411, y = 0.3239,
        name = { enUS = "Graud", deDE = "Graud", esES = "Graud", esMX = "Graud", frFR = "Graud", koKR = "그라우드", ptBR = "Graud", ruRU = "Грауд", zhCN = "格劳德", zhTW = "格勞德" },
    },
    {
        id = 1021, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1417, x = 0.7248, y = 0.3339,
        name = { enUS = "Mu'uta", deDE = "Mu'uta", esES = "Mu'uta", esMX = "Mu'uta", frFR = "Mu'uta", koKR = "무우타", ptBR = "Mu'uta", ruRU = "Му'ута", zhCN = "穆塔", zhTW = "穆塔" },
    },
    {
        id = 1022, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1417, x = 0.4641, y = 0.4761,
        name = { enUS = "Vikki Lonsav", deDE = "Vikki Lonsav", esES = "Vikki Lonsav", esMX = "Vikki Lonsav", frFR = "Vikki Lonsav", koKR = "비키 론사브", ptBR = "Vikki Lonsav", ruRU = "Викки Лонсав", zhCN = "维基·隆萨夫", zhTW = "維琪·隆薩夫" },
    },
    {
        id = 1023, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1418, x = 0.0309, y = 0.4589,
        name = { enUS = "Grawl", deDE = "Grawl", esES = "Graul", esMX = "Graul", frFR = "Grawl", koKR = "그롤", ptBR = "Rosnado", ruRU = "Граул", zhCN = "格劳尔", zhTW = "格勞爾" },
    },
    {
        id = 1024, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.5943, y = 0.7330,
        name = { enUS = "Abigail Sawyer", deDE = "Abigail Sawyer", esES = "Abigail Sierra", esMX = "Abigail Sierra", frFR = "Abigail Sawyer", koKR = "아비게일 소우어", ptBR = "Abigail Arqueda", ruRU = "Эбигейл Сойер", zhCN = "阿比盖恩·萨叶尔", zhTW = "阿比蓋爾·薩葉爾" },
    },
    {
        id = 1025, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6028, y = 0.7202,
        name = { enUS = "Benijah Fenner", deDE = "Benijah Fenner", esES = "Benijah Fenner", esMX = "Benijah Fenner", frFR = "Benijah Fenner", koKR = "베니자 페너", ptBR = "Breno Pugna", ruRU = "Бенидж Феннер", zhCN = "本尼亚·芬奈尔", zhTW = "本尼亞·芬奈爾" },
    },
    {
        id = 1026, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1420, x = 0.6250, y = 0.7542,
        name = { enUS = "Eleanor Rusk", deDE = "Eleanor Rusk", esES = "Eleanor Rusk", esMX = "Eleanor Rusk", frFR = "Eleanor Rusk", koKR = "엘리노르 러스크", ptBR = "Eleanor Rusga", ruRU = "Элинор Руск", zhCN = "艾林诺尔·拉斯克", zhTW = "伊林諾爾·拉斯克" },
    },
    {
        id = 1027, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1420, x = 0.3231, y = 0.6542,
        name = { enUS = "Joshua Kien", deDE = "Joshua Kien", esES = "Joshua Kien", esMX = "Joshua Kien", frFR = "Joshua Kien", koKR = "조슈아 키엔", ptBR = "Josué Fontenelle", ruRU = "Джошуа Кин", zhCN = "乔舒·基恩", zhTW = "喬舒·基恩" },
    },
    {
        id = 1028, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1420, x = 0.6111, y = 0.5259,
        name = { enUS = "Mrs. Winters", deDE = "Mrs. Winters", esES = "Sra. Invernis", esMX = "Sra. Winters", frFR = "Mme Winters", koKR = "미시즈 윈터스", ptBR = "Sra. Hibérnias", ruRU = "Миссис Винтерс", zhCN = "温特斯夫人", zhTW = "溫特斯夫人" },
    },
    {
        id = 1029, types = { "vendor-ammo", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6111, y = 0.7073,
        name = { enUS = "Nicholas Atwood", deDE = "Nicholas Atwood", esES = "Nicholas Emadera", esMX = "Nicholas Emadera", frFR = "Nicholas Atwood", koKR = "니콜라스 애드우드", ptBR = "Nicolau Madeira", ruRU = "Николас Этвуд", zhCN = "尼古拉斯·阿特伍德", zhTW = "尼古拉斯·阿特伍德" },
    },
    {
        id = 1030, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1421, x = 0.4402, y = 0.3990,
        name = { enUS = "Edwin Harly", deDE = "Edwin Harly", esES = "Edwin Harly", esMX = "Edwin Harly", frFR = "Edwin Harly", koKR = "에드윈 할리", ptBR = "Eduíno Harly", ruRU = "Эдвин Харли", zhCN = "艾德温·哈里", zhTW = "艾德溫·哈里" },
    },
    {
        id = 1031, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1421, x = 0.4500, y = 0.3929,
        name = { enUS = "Nadia Vernon", deDE = "Nadia Vernon", esES = "Nadia Vernon", esMX = "Nadia Vernon", frFR = "Nadia Vernon", koKR = "나디아 베르논", ptBR = "Nádia Vernon", ruRU = "Надя Вернон", zhCN = "纳迪亚·沃农", zhTW = "納迪亞·沃農" },
    },
    {
        id = 1032, types = { "vendor-ammo" },
        faction = "Neutral", map = 1423, x = 0.6991, y = 0.5371,
        name = { enUS = "Caretaker Alen", deDE = "Verwalter Alen", esES = "Custodio Alen", esMX = "Custodio Alen", frFR = "Conservateur Alen", koKR = "관리인 알렌", ptBR = "Zelador Alen", ruRU = "Управляющий Ален", zhCN = "护理者奥林", zhTW = "護理者奧林" },
    },
    {
        id = 1033, types = { "vendor-ammo" },
        faction = "Neutral", map = 1423, x = 0.7179, y = 0.5025,
        name = { enUS = "Quartermaster Miranda Breechlock", deDE = "Rüstmeisterin Miranda Breechlock", esES = "Intendente Cerrobrecha", esMX = "Intendente Miranda Cerrobrecha", frFR = "Intendante Miranda Breechlock", koKR = "병참장교 미란다 브리치락", ptBR = "Intendente Miranda Cerraculatra", ruRU = "Интендант Миранда Бричлок", zhCN = "军需官米兰达·布利洛克", zhTW = "軍需官米蘭達·布利洛克" },
    },
    {
        id = 1034, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1424, x = 0.6258, y = 0.1988,
        name = { enUS = "Kayren Soothallow", deDE = "Kayren Soothallow", esES = "Kayren Sombrollín", esMX = "Kayren Sombrollín", frFR = "Kayren Soothallow", koKR = "케이렌 수트할로우", ptBR = "Keila Fuligissacra", ruRU = "Кайрен Священный Прах", zhCN = "凯伦·苏萨隆", zhTW = "凱倫·蘇薩隆" },
    },
    {
        id = 1035, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1424, x = 0.4908, y = 0.5513,
        name = { enUS = "Sarah Raycroft", deDE = "Sarah Raycroft", esES = "Sarah Raycroft", esMX = "Sarah Raycroft", frFR = "Sarah Raycroft", koKR = "사라 레이크로프트", ptBR = "Sara Croft", ruRU = "Сара Рэйкрофт", zhCN = "莎拉·雷克劳夫特", zhTW = "薩拉·雷克勞夫特" },
    },
    {
        id = 1036, types = { "vendor-ammo" },
        faction = "Horde", map = 1425, x = 0.7691, y = 0.8140,
        name = { enUS = "Renn'az", deDE = "Renn'az", esES = "Renn'az", esMX = "Renn'az", frFR = "Renn'az", koKR = "레나즈", ptBR = "Renn'az", ruRU = "Ренн'аз", zhCN = "雷艾", zhTW = "瑞安茲" },
    },
    {
        id = 1037, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1426, x = 0.3009, y = 0.7160,
        name = { enUS = "Adlin Pridedrift", deDE = "Adlin Pridedrift", esES = "Adlin Rumborgullo", esMX = "Adlin Rumborgullo", frFR = "Adlin Pridedrift", koKR = "아들린 프라이드드리프트", ptBR = "Adlin Altanário", ruRU = "Одлин Гордоступ", zhCN = "艾德林·怒流", zhTW = "艾德林·怒流" },
    },
    {
        id = 1038, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.6266, y = 0.3156,
        name = { enUS = "Bretta Goldfury", deDE = "Bretta Goldfury", esES = "Bretta Furiadorada", esMX = "Bretta Furiadorada", frFR = "Bretta Goldfury", koKR = "브레타 골드퓨리", ptBR = "Bretta Furiouro", ruRU = "Бретта Златопуля", zhCN = "布雷塔·金怒", zhTW = "布雷塔·金怒" },
    },
    {
        id = 1039, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1426, x = 0.5738, y = 0.3306,
        name = { enUS = "Bryllia Ironbrand", deDE = "Bryllia Ironbrand", esES = "Bryllia Ferracha", esMX = "Bryllia Ferracha", frFR = "Bryllia Ironbrand", koKR = "브릴리아 아이언브랜드", ptBR = "Bryllia Marcaferro", ruRU = "Бриллия Железное Клеймо", zhCN = "布莱利亚·铁印", zhTW = "布萊利亞·鐵印" },
    },
    {
        id = 1040, types = { "vendor-ammo", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.4071, y = 0.6510,
        name = { enUS = "Hegnar Rumbleshot", deDE = "Hegnar Rumbleshot", esES = "Hegnar Estruendo", esMX = "Hegnar Estruendo", frFR = "Hegnar Rumbleshot", koKR = "헤그너 럼블샷", ptBR = "Hegnar Estremetiro", ruRU = "Хегнар Громострел", zhCN = "海格纳·重枪", zhTW = "海格納·重槍" },
    },
    {
        id = 1041, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1426, x = 0.4720, y = 0.5239,
        name = { enUS = "Kreg Bilmn", deDE = "Kreg Bilmn", esES = "Kreg Bilmn", esMX = "Kreg Bilmn", frFR = "Kreg Bilmn", koKR = "크레그 빌름", ptBR = "Kreg Bilmn", ruRU = "Крег Бильмн", zhCN = "克雷格·比尔姆", zhTW = "克雷格·比爾姆" },
    },
    {
        id = 1042, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6261, y = 0.3180,
        name = { enUS = "Skolmin Goldfury", deDE = "Skolmin Goldfury", esES = "Skolmin Furiadorada", esMX = "Skolmin Furiadorada", frFR = "Skolmin Goldfury", koKR = "스콜민 골드퓨리", ptBR = "Skolmin Furiouro", ruRU = "Сколомин Златопуля", zhCN = "斯克米·金怒", zhTW = "斯克米·金怒" },
    },
    {
        id = 1043, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6096, y = 0.3546,
        name = { enUS = "Thalgus Thunderfist", deDE = "Thalgus Thunderfist", esES = "Thalgus Tronapuño", esMX = "Thalgus Tronapuño", frFR = "Thalgus Thunderfist", koKR = "탈구스 썬더피스트", ptBR = "Thalgus Punhostrondo", ruRU = "Талгус Громодлань", zhCN = "萨古斯·雷拳", zhTW = "薩古斯·雷拳" },
    },
    {
        id = 1044, types = { "vendor-ammo", "vendor-repair" },
        faction = "Neutral", map = 1427, x = 0.3877, y = 0.2850,
        name = { enUS = "Master Smith Burninate", deDE = "Meisterschmied Burninate", esES = "Maestro herrero Cremación", esMX = "Herrero maestro Burninate", frFR = "Maître forgeron Burninate", koKR = "수석대장장이 버니네이트", ptBR = "Mestre Ferreiro Queimatar", ruRU = "Мастер-кузнец Гориврат", zhCN = "大铁匠博恩奈特", zhTW = "大鐵匠博恩奈特" },
    },
    {
        id = 1045, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1429, x = 0.4401, y = 0.6592,
        name = { enUS = "Brog Hamfist", deDE = "Brog Hamfist", esES = "Brog Patosar", esMX = "Brog Patosar", frFR = "Brog Hamfist", koKR = "브로그 햄피스트", ptBR = "Brog Atolão", ruRU = "Брог Мясорук", zhCN = "布洛葛·哈姆菲斯特", zhTW = "布洛葛·哈姆菲斯特" },
    },
    {
        id = 1046, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1429, x = 0.4750, y = 0.4161,
        name = { enUS = "Brother Danil", deDE = "Bruder Danil", esES = "Hermano Danil", esMX = "Hermano Danil", frFR = "Frère Danil", koKR = "수사 다닐", ptBR = "Irmão Dânio", ruRU = "Брат Даниль", zhCN = "丹尼尔修士", zhTW = "丹尼爾修士" },
    },
    {
        id = 1047, types = { "vendor-ammo", "vendor-trade" },
        faction = "Alliance", map = 1429, x = 0.8331, y = 0.6673,
        name = { enUS = "Drake Lindgren", deDE = "Drake Lindgren", esES = "Draco Lindgren", esMX = "Draco Lindgren", frFR = "Drake Lindgren", koKR = "드레이크 린드그렌", ptBR = "Draco Lindgren", ruRU = "Дрейк Линдгрен", zhCN = "德拉克·林格雷", zhTW = "崔克·林格雷" },
    },
    {
        id = 1048, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1429, x = 0.8331, y = 0.6609,
        name = { enUS = "Rallic Finn", deDE = "Rallic Finn", esES = "Rallic Finn", esMX = "Rallic Finn", frFR = "Rallic Finn", koKR = "랠릭 핀", ptBR = "Ricardo Fino", ruRU = "Раллик Финн", zhCN = "拉里克·费恩", zhTW = "拉里克·費恩" },
    },
    {
        id = 1049, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1431, x = 0.7299, y = 0.4441,
        name = { enUS = "Avette Fellwood", deDE = "Avette Felwood", esES = "Avette Bosquevil", esMX = "Avette Bosquevil", frFR = "Avette Fellwood", koKR = "아베트 펠우드", ptBR = "Avette Cortalenha", ruRU = "Аветта Хвористинка", zhCN = "艾瓦特·菲尔伍德", zhTW = "艾瓦特·菲爾伍德" },
    },
    {
        id = 1050, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1431, x = 0.7412, y = 0.4493,
        name = { enUS = "Mabel Solaj", deDE = "Mabel Solaj", esES = "Mabel Solaj", esMX = "Mabel Solaj", frFR = "Mabel Solaj", koKR = "마벨 솔라야", ptBR = "Mabel Solaj", ruRU = "Мейбл Солаж", zhCN = "玛贝尔·索拉什", zhTW = "瑪貝爾·索拉什" },
    },
    {
        id = 1051, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1432, x = 0.8298, y = 0.6301,
        name = { enUS = "Cliff Hadin", deDE = "Cliff Hadin", esES = "Jadín del risco", esMX = "Jadín del risco", frFR = "Cliff Hadin", koKR = "클리프 하딘", ptBR = "Cliff Filoneiro", ruRU = "Клифф Кадин", zhCN = "克里夫·哈丁", zhTW = "克里夫·哈丁" },
    },
    {
        id = 1052, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1432, x = 0.8322, y = 0.6337,
        name = { enUS = "Irene Sureshot", deDE = "Irene Sureshot", esES = "Irene Tiroseguro", esMX = "Irene Tiroseguro", frFR = "Irene Sureshot", koKR = "아레네 슈어샷", ptBR = "Irene Tirocerto", ruRU = "Ирен Меткострел", zhCN = "埃伦", zhTW = "艾琳·穩擊" },
    },
    {
        id = 1053, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1432, x = 0.3580, y = 0.4352,
        name = { enUS = "Vrok Blunderblast", deDE = "Vrok Blunderblast", esES = "Vrok Rayobestial", esMX = "Vrok Rayobestial", frFR = "Vrok Blunderblast", koKR = "브록 블런더블라스트", ptBR = "Vrok Soltagafe", ruRU = "Врок Мимострел", zhCN = "维罗克·乱枪", zhTW = "維羅克·亂槍" },
    },
    {
        id = 1054, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1432, x = 0.8250, y = 0.6337,
        name = { enUS = "Xandar Goodbeard", deDE = "Xandar Goodbeard", esES = "Xandar Bonbarba", esMX = "Xandar Bonbarba", frFR = "Xandar Goodbeard", koKR = "샨다르 굿비어드", ptBR = "Xandar Boabarba", ruRU = "Ксаварик", zhCN = "山达·细须", zhTW = "山達·細鬚" },
    },
    {
        id = 1055, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1432, x = 0.3479, y = 0.4859,
        name = { enUS = "Yanni Stoutheart", deDE = "Yanni Stoutheart", esES = "Yanni Cuoreforte", esMX = "Yanni Cuoreforte", frFR = "Yanni Stoutheart", koKR = "야니 스타우트하트", ptBR = "Yanni Cuoreforte", ruRU = "Янни Твердое Сердце", zhCN = "雅尼·铁心", zhTW = "雅尼·鐵心" },
    },
    {
        id = 1056, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1433, x = 0.1880, y = 0.4132,
        name = { enUS = "Henry Chapal", deDE = "Henry Chapal", esES = "Henry Chapal", esMX = "Henry Chapal", frFR = "Henry Chapal", koKR = "헨리 체이펄", ptBR = "Henry Chapal", ruRU = "Генри Чапал", zhCN = "亨利·查培尔", zhTW = "亨利·查培爾" },
    },
    {
        id = 1057, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1433, x = 0.2199, y = 0.4547,
        name = { enUS = "Kimberly Hiett", deDE = "Kimberly Hiett", esES = "Kimberly Hiett", esMX = "Kimberly Hiett", frFR = "Kimberly Hiett", koKR = "킴벌리 하이에트", ptBR = "Kimberly Hiett", ruRU = "Кимберли Хайетт", zhCN = "金伯利·海特", zhTW = "金伯利·海特" },
    },
    {
        id = 1058, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1433, x = 0.2371, y = 0.4731,
        name = { enUS = "Lindsay Ashlock", deDE = "Lindsay Ashlock", esES = "Lindsay Cierreniza", esMX = "Lindsay Cierreniza", frFR = "Lindsay Ashlock", koKR = "린제이 애쉬록", ptBR = "Lindsay Ashlock", ruRU = "Линдски Ашлок", zhCN = "林塞·阿什洛克", zhTW = "林塞·阿什洛克" },
    },
    {
        id = 1059, types = { "vendor-ammo" },
        faction = "Alliance", map = 1434, x = 0.3800, y = 0.0299,
        name = { enUS = "Corporal Bluth", deDE = "Corporal Bluth", esES = "Cabo Bluth", esMX = "Cabo Bluth", frFR = "Caporal Bluth", koKR = "하사관 블루스", ptBR = "Cabo Bluth", ruRU = "Капрал Блуф", zhCN = "布鲁斯下士", zhTW = "布魯斯下士" },
    },
    {
        id = 1060, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1434, x = 0.2830, y = 0.7461,
        name = { enUS = "Haren Kanmae", deDE = "Haren Kanmae", esES = "Haren Kanmae", esMX = "Haren Kanmae", frFR = "Haren Kanmae", koKR = "하렌 칸메", ptBR = "Haren Kanmae", ruRU = "Харен Канмай", zhCN = "哈伦·坎麦尔", zhTW = "哈倫·坎麥爾" },
    },
    {
        id = 1061, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1434, x = 0.3161, y = 0.2800,
        name = { enUS = "Uthok", deDE = "Uthok", esES = "Uthok", esMX = "Uthok", frFR = "Uthok", koKR = "우톡", ptBR = "Uthok", ruRU = "Утхок", zhCN = "尤索克", zhTW = "尤索克" },
    },
    {
        id = 1062, types = { "vendor-ammo" },
        faction = "Alliance", map = 1436, x = 0.5701, y = 0.4720,
        name = { enUS = "Quartermaster Lewis", deDE = "Rüstmeister Lewis", esES = "Intendente Lewis", esMX = "Intendente Lewis", frFR = "Intendant Lewis", koKR = "병참장교 루이스", ptBR = "Intendente Ludovico", ruRU = "Интендант Льюис", zhCN = "军需官刘易斯", zhTW = "軍需官路易斯" },
    },
    {
        id = 1063, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1436, x = 0.5770, y = 0.5389,
        name = { enUS = "William MacGregor", deDE = "William MacGregor", esES = "William MacGregor", esMX = "William MacGregor", frFR = "William MacGregor", koKR = "윌리엄 맥그레거", ptBR = "Guilherme Gregorsohn", ruRU = "Вильям Макгрегор", zhCN = "威廉·马克葛瑞格", zhTW = "威廉·馬克葛瑞格" },
    },
    {
        id = 1064, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1437, x = 0.1109, y = 0.5829,
        name = { enUS = "Edwina Monzor", deDE = "Edwina Monzor", esES = "Edwina Monzor", esMX = "Edwina Monzor", frFR = "Edwina Monzor", koKR = "에드위나 몬조르", ptBR = "Eduína Monzor", ruRU = "Эдвина Монзор", zhCN = "艾德温娜·蒙佐尔", zhTW = "艾德溫娜·蒙佐爾" },
    },
    {
        id = 1065, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1437, x = 0.1208, y = 0.5800,
        name = { enUS = "Gruham Rumdnul", deDE = "Gruham Rumdnul", esES = "Gruham Rumdnul", esMX = "Gruham Rumdnul", frFR = "Gruham Rumdnul", koKR = "그루함 럼드널", ptBR = "Gruham Patego", ruRU = "Грухам Румднул", zhCN = "格鲁哈姆·拉姆杜恩", zhTW = "格魯哈姆·拉姆杜恩" },
    },
    {
        id = 1066, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1437, x = 0.1131, y = 0.5960,
        name = { enUS = "Murndan Derth", deDE = "Murndan Derth", esES = "Murndan Carestía", esMX = "Murndan Carestía", frFR = "Murndan Derth", koKR = "먼단 더스", ptBR = "Murndan Derth", ruRU = "Мурден Дерт", zhCN = "穆恩达·德斯", zhTW = "穆恩達·德斯" },
    },
    {
        id = 1067, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1437, x = 0.1131, y = 0.5839,
        name = { enUS = "Naela Trance", deDE = "Naela Trance", esES = "Naela Trance", esMX = "Naela Trance", frFR = "Naela Trance", koKR = "나일라 트랜스", ptBR = "Naela Trance", ruRU = "Наела Транс", zhCN = "奈拉·特兰斯", zhTW = "奈拉·特蘭斯" },
    },
    {
        id = 1068, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1437, x = 0.1070, y = 0.5680,
        name = { enUS = "Neal Allen", deDE = "Neal Allen", esES = "Neal Allen", esMX = "Neal Allen", frFR = "Neal Allen", koKR = "닐 알렌", ptBR = "Nélio Allen", ruRU = "Нил Аллен", zhCN = "尼尔·奥雷", zhTW = "尼爾·奧雷" },
    },
    {
        id = 1069, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1438, x = 0.5549, y = 0.5710,
        name = { enUS = "Aldia", deDE = "Aldia", esES = "Aldia", esMX = "Aldia", frFR = "Aldia", koKR = "알디아", ptBR = "Áldia", ruRU = "Альдия", zhCN = "奥蒂亚", zhTW = "奧蒂亞" },
    },
    {
        id = 1070, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1438, x = 0.5591, y = 0.5918,
        name = { enUS = "Jeena Featherbow", deDE = "Jeena Featherbow", esES = "Jeena Plumarco", esMX = "Jeena Plumarco", frFR = "Jeena Featherbow", koKR = "지나 피더보우", ptBR = "Jiyna Penarco", ruRU = "Джиена Оперенная Стрела", zhCN = "吉娜·羽弓", zhTW = "吉娜·羽弓" },
    },
    {
        id = 1071, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1438, x = 0.5931, y = 0.4111,
        name = { enUS = "Keina", deDE = "Keina", esES = "Keina", esMX = "Keina", frFR = "Keina", koKR = "케이나", ptBR = "Keina", ruRU = "Кейна", zhCN = "奇娜", zhTW = "奇娜" },
    },
    {
        id = 1072, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1438, x = 0.5949, y = 0.4092,
        name = { enUS = "Lyrai", deDE = "Lyrai", esES = "Lyrai", esMX = "Lyrai", frFR = "Lyrai", koKR = "리라이", ptBR = "Lyrai", ruRU = "Лирай", zhCN = "琳莱尔", zhTW = "琳賴爾" },
    },
    {
        id = 1073, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1439, x = 0.3740, y = 0.4049,
        name = { enUS = "Dalmond", deDE = "Dalmond", esES = "Dalmond", esMX = "Dalmond", frFR = "Dalmond", koKR = "달몬드", ptBR = "Dalmond", ruRU = "Дальмонд", zhCN = "达蒙德", zhTW = "達蒙德" },
    },
    {
        id = 1074, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1440, x = 0.5029, y = 0.6728,
        name = { enUS = "Bhaldaran Ravenshade", deDE = "Bhaldaran Ravenshade", esES = "Bhaldaran Sombracuervo", esMX = "Bhaldaran Sombracuervo", frFR = "Bhaldaran Ravenshade", koKR = "발다란 레이븐섀이드", ptBR = "Bhaldaran Corvulto", ruRU = "Балдаран Тень Ворона", zhCN = "巴尔达兰·鸦影", zhTW = "巴爾達蘭·鴉影" },
    },
    {
        id = 1075, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1440, x = 0.3480, y = 0.5091,
        name = { enUS = "Haljan Oakheart", deDE = "Haljan Oakheart", esES = "Haljan Roblezón", esMX = "Haljan Roblezón", frFR = "Haljan Oakheart", koKR = "할잔 오크하트", ptBR = "Haljan Ruboralma", ruRU = "Хальян Сердце Дуба", zhCN = "哈尔詹·橡木之心", zhTW = "哈爾詹·橡木之心" },
    },
    {
        id = 1076, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1441, x = 0.4591, y = 0.5150,
        name = { enUS = "Jawn Highmesa", deDE = "Jawn Highmesa", esES = "Jawn Mesalta", esMX = "Jawn Mesalta", frFR = "Jawn Highmesa", koKR = "조운 하이메사", ptBR = "Jawn Chapadalta", ruRU = "Джаун Высокий Холм", zhCN = "加恩·高塔", zhTW = "加恩·高塔" },
    },
    {
        id = 1077, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1441, x = 0.4491, y = 0.5068,
        name = { enUS = "Starn", deDE = "Starn", esES = "Starn", esMX = "Starn", frFR = "Starn", koKR = "스타른", ptBR = "Starn", ruRU = "Старн", zhCN = "斯塔恩", zhTW = "斯塔恩" },
    },
    {
        id = 1078, types = { "vendor-ammo", "vendor-repair" },
        faction = "Neutral", map = 1441, x = 0.8039, y = 0.7700,
        name = { enUS = "Synge", deDE = "Synge", esES = "Synge", esMX = "Synge", frFR = "Synge", koKR = "신게", ptBR = "Synge", ruRU = "Синг", zhCN = "赛恩格", zhTW = "賽恩格" },
    },
    {
        id = 1079, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1442, x = 0.4539, y = 0.5911,
        name = { enUS = "Borand", deDE = "Borand", esES = "Borand", esMX = "Borand", frFR = "Borand", koKR = "보른다", ptBR = "Borand", ruRU = "Боранд", zhCN = "波兰德", zhTW = "波蘭德" },
    },
    {
        id = 1080, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1442, x = 0.3551, y = 0.0620,
        name = { enUS = "Chylina", deDE = "Chylina", esES = "Chylina", esMX = "Chylina", frFR = "Chylina", koKR = "킬리나", ptBR = "Chylina", ruRU = "Чилина", zhCN = "莎琳娜", zhTW = "莎琳娜" },
    },
    {
        id = 1081, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1442, x = 0.4591, y = 0.5870,
        name = { enUS = "Grawnal", deDE = "Grawnal", esES = "Grawnal", esMX = "Grawnal", frFR = "Grawnal", koKR = "그라우날", ptBR = "Grawnal", ruRU = "Граунал", zhCN = "格劳纳尔", zhTW = "格勞納爾" },
    },
    {
        id = 1082, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1443, x = 0.6661, y = 0.0699,
        name = { enUS = "Christi Galvanis", deDE = "Christi Galvanis", esES = "Christi Galvanis", esMX = "Christi Galvanis", frFR = "Christi Galvanis", koKR = "크리스티 갈바니스", ptBR = "Christi Galvanis", ruRU = "Кристи Гальванис", zhCN = "克里斯蒂·加瓦尼斯", zhTW = "克利斯蒂·加瓦尼斯" },
    },
    {
        id = 1083, types = { "vendor-ammo" },
        faction = "Neutral", map = 1443, x = 0.4051, y = 0.7930,
        name = { enUS = "Super-Seller 680", deDE = "Superverkaufomat 680", esES = "Supervendedor 680", esMX = "Supervendedor 680", frFR = "Super-Vendeur 680", koKR = "슈퍼 판매기 680", ptBR = "Super-Loja 680", ruRU = "Робо-торговец 680", zhCN = "超级商人680型", zhTW = "超級商人680型" },
    },
    {
        id = 1084, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1443, x = 0.2491, y = 0.7179,
        name = { enUS = "Tukk", deDE = "Tukk", esES = "Tukk", esMX = "Tukk", frFR = "Tukk", koKR = "투크", ptBR = "Tukkão", ruRU = "Тукк", zhCN = "图克", zhTW = "圖克" },
    },
    {
        id = 1085, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1444, x = 0.7490, y = 0.4570,
        name = { enUS = "Cawind Trueaim", deDE = "Cawind Trueaim", esES = "Cawind Tirojusto", esMX = "Cawind Tirojusto", frFR = "Cawind Trueaim", koKR = "카윈드 트루에임", ptBR = "Cavento Mira Certa", ruRU = "Кавинд Верный Прицел", zhCN = "卡温德", zhTW = "卡溫德" },
    },
    {
        id = 1086, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1444, x = 0.3060, y = 0.4340,
        name = { enUS = "Faralorn", deDE = "Faralorn", esES = "Faralorn", esMX = "Faralorn", frFR = "Faralorn", koKR = "파라론", ptBR = "Faralorn", ruRU = "Фаралорн", zhCN = "法拉罗恩", zhTW = "法拉羅恩" },
    },
    {
        id = 1087, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1445, x = 0.6750, y = 0.5170,
        name = { enUS = "Charity Mipsy", deDE = "Charity Mipsy", esES = "Caridad Mipsy", esMX = "Caridad Mipsy", frFR = "Charity Mipsy", koKR = "자선단 밉시", ptBR = "Caritas Lindin", ruRU = "Милла Сердия", zhCN = "查瑞迪·米普斯", zhTW = "查瑞迪·米普斯" },
    },
    {
        id = 1088, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1445, x = 0.6790, y = 0.4990,
        name = { enUS = "Jensen Farran", deDE = "Jensen Farran", esES = "Jensen Farran", esMX = "Jensen Farran", frFR = "Jensen Farran", koKR = "젠센 파렌", ptBR = "Jesse Fanfarrão", ruRU = "Дженсен Фарран", zhCN = "杰森·法兰", zhTW = "傑森·法蘭" },
    },
    {
        id = 1089, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1445, x = 0.6750, y = 0.4800,
        name = { enUS = "Torq Ironblast", deDE = "Torq Ironblast", esES = "Torq Balacero", esMX = "Torq Balacero", frFR = "Torq Ironblast", koKR = "톨크 아이언블래스트", ptBR = "Torq Estouraferro", ruRU = "Торк Стальное Зарево", zhCN = "托克·铁火", zhTW = "托克·鐵火" },
    },
    {
        id = 1090, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1445, x = 0.3550, y = 0.3010,
        name = { enUS = "Zanara", deDE = "Zanara", esES = "Zanara", esMX = "Zanara", frFR = "Zanara", koKR = "자나라", ptBR = "Zanara", ruRU = "Занара", zhCN = "萨纳拉", zhTW = "薩納拉" },
    },
    {
        id = 1091, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1446, x = 0.5070, y = 0.2750,
        name = { enUS = "Blizrik Buckshot", deDE = "Blizrik Buckshot", esES = "Blizrik Machobala", esMX = "Blizrik Machobala", frFR = "Blizrik Buckshot", koKR = "브리즈릭 벅샷", ptBR = "Blizricco Sciumbigno", ruRU = "Близрик Шрапнельс", zhCN = "布雷兹里克·巴克舒特", zhTW = "布雷茲里克·巴克舒特" },
    },
    {
        id = 1092, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 1446, x = 0.6699, y = 0.2199,
        name = { enUS = "Jabbey", deDE = "Jabbey", esES = "Jabbey", esMX = "Jabbey", frFR = "Jabbey", koKR = "재비", ptBR = "Jebbs", ruRU = "Джабби", zhCN = "加贝", zhTW = "加貝" },
    },
    {
        id = 1093, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1447, x = 0.1200, y = 0.7840,
        name = { enUS = "Brinna Valanaar", deDE = "Brinna Valanaar", esES = "Brinna Valanaar", esMX = "Brinna Valanaar", frFR = "Brinna Valanaar", koKR = "브리나 발라나르", ptBR = "Brinna Valanaar", ruRU = "Бринна Валанаар", zhCN = "布琳娜·瓦兰达尔", zhTW = "布琳娜·瓦蘭達爾" },
    },
    {
        id = 1094, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1448, x = 0.3479, y = 0.5322,
        name = { enUS = "Bale", deDE = "Bale", esES = "Bale", esMX = "Fardo", frFR = "Bale", koKR = "베일", ptBR = "Fardo", ruRU = "Тюкн", zhCN = "拜尔", zhTW = "拜爾" },
    },
    {
        id = 1095, types = { "vendor-ammo" },
        map = 1448, x = 0.6519, y = 0.0271,
        name = { enUS = "Gorn One Eye", deDE = "Gorn Einauge", esES = "Monóculo de Gorn", esMX = "Monóculo de Gorn", frFR = "Gorn le Borgne", koKR = "외눈 고른", ptBR = "Gorn Caolho", ruRU = "Горн Одноглаз", zhCN = "独眼高恩", zhTW = "獨眼高恩" },
    },
    {
        id = 1096, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1448, x = 0.6229, y = 0.2560,
        name = { enUS = "Malygen", deDE = "Malygen", esES = "Malygen", esMX = "Malygen", frFR = "Malygen", koKR = "말리젠", ptBR = "Malygen", ruRU = "Малиген", zhCN = "玛里甘", zhTW = "瑪里甘" },
    },
    {
        id = 1097, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 1449, x = 0.4332, y = 0.0768,
        name = { enUS = "Nergal", deDE = "Nergal", esES = "Nergal", esMX = "Nergal", frFR = "Nergal", koKR = "네르갈", ptBR = "Nergal", ruRU = "Нергал", zhCN = "奈尔加", zhTW = "奈爾加" },
    },
    {
        id = 1098, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 1450, x = 0.4517, y = 0.3471,
        name = { enUS = "Daeolyn Summerleaf", deDE = "Daeolyn Summerleaf", esES = "Daeolun Hojestival", esMX = "Daeolun Hojestival", frFR = "Daeolyn Summerleaf", koKR = "대올린 서머리프", ptBR = "Daeolyn Foliéstia", ruRU = "Даолин Летний Лист", zhCN = "黛欧琳·夏叶", zhTW = "黛歐琳·夏葉" },
    },
    {
        id = 1099, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1450, x = 0.5332, y = 0.4267,
        name = { enUS = "Narianna", deDE = "Narianna", esES = "Narianna", esMX = "Narianna", frFR = "Narianna", koKR = "나리안나", ptBR = "Narianna", ruRU = "Нарианна", zhCN = "娜利安", zhTW = "娜利安" },
    },
    {
        id = 1100, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1452, x = 0.5150, y = 0.3079,
        name = { enUS = "Natheril Raincaller", deDE = "Natheril Raincaller", esES = "Natheril Clamalluvias", esMX = "Natheril Clamalluvias", frFR = "Natheril Raincaller", koKR = "내더릴 레인콜러", ptBR = "Natheril Clamachuva", ruRU = "Натериль Заклинатель Дождя", zhCN = "纳瑟瑞尔·祈雨", zhTW = "納瑟瑞爾·祈雨者" },
    },
    {
        id = 1101, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1452, x = 0.6170, y = 0.3800,
        name = { enUS = "Wixxrak", deDE = "Wixxrak", esES = "Wixxrak", esMX = "Wixxrak", frFR = "Wixxrak", koKR = "윅스락", ptBR = "Wixxrak", ruRU = "Виззрак", zhCN = "维撒克", zhTW = "維撒克" },
    },
    {
        id = 1102, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5834, y = 0.6896,
        name = { enUS = "Frederick Stover", deDE = "Frederick Stover", esES = "Frederick Stover", esMX = "Frederick Stover", frFR = "Frederick Stover", koKR = "프레드릭 스토버", ptBR = "Frederico Fornalha", ruRU = "Фредерик Стовер", zhCN = "弗德瑞克·斯图瓦", zhTW = "弗德瑞克·斯圖瓦" },
    },
    {
        id = 1103, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1453, x = 0.6421, y = 0.6860,
        name = { enUS = "Gunther Weller", deDE = "Gunther Weller", esES = "Gunther Pozador", esMX = "Gunther Pozador", frFR = "Gunther Weller", koKR = "군터 웰러", ptBR = "Gunther Weller", ruRU = "Гунтер Веллер", zhCN = "冈瑟尔·维勒", zhTW = "岡瑟爾·維勒" },
    },
    {
        id = 1104, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5872, y = 0.6873,
        name = { enUS = "Lina Stover", deDE = "Lina Stover", esES = "Lina Paladare", esMX = "Lina Paladare", frFR = "Lina Stover", koKR = "리나 스토버", ptBR = "Lina Fornalha", ruRU = "Лина Стовер", zhCN = "黎娜·斯图瓦", zhTW = "黎娜·斯圖瓦" },
    },
    {
        id = 1105, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1453, x = 0.6401, y = 0.6873,
        name = { enUS = "Marda Weller", deDE = "Marda Weller", esES = "Marda Weller", esMX = "Marda Weller", frFR = "Marda Weller", koKR = "마르다 웰러", ptBR = "Marcia Weller", ruRU = "Марда Веллер", zhCN = "玛尔达·维勒", zhTW = "瑪爾達·維勒" },
    },
    {
        id = 1106, types = { "vendor-ammo", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6187, y = 0.3662,
        name = { enUS = "Thulman Flintcrag", deDE = "Thulman Flintcrag", esES = "Thulman Riscosílex", esMX = "Thulman Riscosílex", frFR = "Thulman Flintcrag", koKR = "툴만 플린트크래그", ptBR = "Thulman Rochassílex", ruRU = "Тулман Кремневый Утес", zhCN = "苏尔曼·火崖", zhTW = "蘇爾曼·火崖" },
    },
    {
        id = 1107, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1453, x = 0.6478, y = 0.7219,
        name = { enUS = "Thurman Mullby", deDE = "Thurman Mullby", esES = "Thurman Mullby", esMX = "Thurman Mullby", frFR = "Thurman Mullby", koKR = "투르만 멀비", ptBR = "Túlio Malheiros", ruRU = "Турман Милби", zhCN = "萨尔曼·穆比", zhTW = "薩爾曼·穆比" },
    },
    {
        id = 1108, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1454, x = 0.4606, y = 0.4097,
        name = { enUS = "Asoran", deDE = "Asoran", esES = "Asoran", esMX = "Asoran", frFR = "Asoran", koKR = "아스란", ptBR = "Asoran", ruRU = "Азоран", zhCN = "阿索兰", zhTW = "阿索蘭" },
    },
    {
        id = 1109, types = { "vendor-ammo", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.7810, y = 0.3854,
        name = { enUS = "Jin'sora", deDE = "Jin'sora", esES = "Jin'sora", esMX = "Jin'sora", frFR = "Jin'sora", koKR = "진소라", ptBR = "Jin'sora", ruRU = "Джин'сора", zhCN = "金索拉", zhTW = "金索拉" },
    },
    {
        id = 1110, types = { "vendor-ammo", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.5215, y = 0.6206,
        name = { enUS = "Kaja", deDE = "Kaja", esES = "Kaja", esMX = "Kaja", frFR = "Kaja", koKR = "카자", ptBR = "Jaka", ruRU = "Каджа", zhCN = "卡加", zhTW = "卡加" },
    },
    {
        id = 1111, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1454, x = 0.4806, y = 0.8045,
        name = { enUS = "Trak'gen", deDE = "Trak'gen", esES = "Trak'gen", esMX = "Trak'gen", frFR = "Trak'gen", koKR = "트락겐", ptBR = "Trak'gen", ruRU = "Трак'ген", zhCN = "特拉克根", zhTW = "特拉克根" },
    },
    {
        id = 1112, types = { "vendor-ammo", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.8123, y = 0.1873,
        name = { enUS = "Zendo'jian", deDE = "Zendo'jian", esES = "Zendo'jian", esMX = "Zendo'jian", frFR = "Zendo'jian", koKR = "젠도젠", ptBR = "Zendo'jian", ruRU = "Зендо'джиан", zhCN = "森度吉安", zhTW = "森度吉安" },
    },
    {
        id = 1113, types = { "vendor-ammo", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.5550, y = 0.5701,
        name = { enUS = "Hogor Thunderhoof", deDE = "Hogor Thunderhoof", esES = "Hogor Pezuñatrueno", esMX = "Hogor Pezuñatrueno", frFR = "Hogor Thunderhoof", koKR = "호거 썬더후프", ptBR = "Hogor Casco de Trovão", ruRU = "Хогор Громовое Копыто", zhCN = "霍高尔·雷角", zhTW = "霍高爾·雷角" },
    },
    {
        id = 1114, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.4145, y = 0.6237,
        name = { enUS = "Jyn Stonehoof", deDE = "Jyn Stonehoof", esES = "Jyn Pezuñapétrea", esMX = "Jyn Pezuña Pétrea", frFR = "Jyn Stonehoof", koKR = "진 스톤후프", ptBR = "Jyn Casco de Pedra", ruRU = "Джин Каменное Копыто", zhCN = "吉恩·石蹄", zhTW = "吉恩·石蹄" },
    },
    {
        id = 1115, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.4695, y = 0.4570,
        name = { enUS = "Kuna Thunderhorn", deDE = "Kuna Thunderhorn", esES = "Kuna Tronacuerno", esMX = "Kuna Tronacuerno", frFR = "Kuna Thunderhorn", koKR = "쿠나 썬더혼", ptBR = "Kina Chifre Troante", ruRU = "Куна Громовой Рог", zhCN = "库纳·雷角", zhTW = "庫納·雷角" },
    },
    {
        id = 1116, types = { "vendor-ammo", "vendor-general" },
        faction = "Horde", map = 1456, x = 0.3890, y = 0.6467,
        name = { enUS = "Kuruk", deDE = "Kuruk", esES = "Kuruk", esMX = "Kuruk", frFR = "Kuruk", koKR = "쿠루크", ptBR = "Kuruk", ruRU = "Курук", zhCN = "库鲁克", zhTW = "庫魯克" },
    },
    {
        id = 1117, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.5881, y = 0.4454,
        name = { enUS = "Ariyell Skyshadow", deDE = "Ariyell Skyshadow", esES = "Ariyell Cielosombra", esMX = "Ariyell Cielosombra", frFR = "Ariyell Skyshadow", koKR = "아리옐 스카이섀도", ptBR = "Ariyell Caelumbra", ruRU = "Ариэль Тень Небес", zhCN = "阿瑞耶尔·天影", zhTW = "阿瑞耶爾·天影" },
    },
    {
        id = 1118, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1457, x = 0.6473, y = 0.5304,
        name = { enUS = "Ellandrieth", deDE = "Ellandrieth", esES = "Ellandrieth", esMX = "Ellandrieth", frFR = "Ellandrieth", koKR = "엘란드리어스", ptBR = "Ellandrieth", ruRU = "Элландриет", zhCN = "艾兰蒂斯", zhTW = "艾蘭蒂斯" },
    },
    {
        id = 1119, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6334, y = 0.6626,
        name = { enUS = "Landria", deDE = "Landria", esES = "Landria", esMX = "Landria", frFR = "Landria", koKR = "란드리아", ptBR = "Landria", ruRU = "Ландрия", zhCN = "兰德瑞亚", zhTW = "蘭德瑞亞" },
    },
    {
        id = 1120, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 1457, x = 0.7065, y = 0.4548,
        name = { enUS = "Mydrannul", deDE = "Mydrannul", esES = "Mydrannul", esMX = "Mydrannul", frFR = "Mydrannul", koKR = "미드란눌", ptBR = "Mydrannul", ruRU = "Мидраннул", zhCN = "迈德兰努尔", zhTW = "邁德蘭努爾" },
    },
    {
        id = 1121, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 2482, x = 0.7085, y = 0.5079,
        name = { enUS = "Lenedil Moonwing", deDE = "Lenedil Moonwing", esES = "Lenedil Moonwing", esMX = "Lenedil Moonwing", frFR = "Lenedil Moonwing", koKR = "Lenedil Moonwing", ptBR = "Lenedil Moonwing", ruRU = "Lenedil Moonwing", zhCN = "Lenedil Moonwing", zhTW = "Lenedil Moonwing" },
    },
    {
        id = 1122, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 2521, x = 0.6302, y = 0.7781,
        name = { enUS = "Antelariaa Cloudgaze", deDE = "Antelariaa Cloudgaze", esES = "Antelariaa Cloudgaze", esMX = "Antelariaa Cloudgaze", frFR = "Antelariaa Cloudgaze", koKR = "Antelariaa Cloudgaze", ptBR = "Antelariaa Cloudgaze", ruRU = "Antelariaa Cloudgaze", zhCN = "Antelariaa Cloudgaze", zhTW = "Antelariaa Cloudgaze" },
    },
    {
        id = 1123, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2521, x = 0.4343, y = 0.2350,
        name = { enUS = "Destin Thriceforged", deDE = "Destin Thriceforged", esES = "Destin Thriceforged", esMX = "Destin Thriceforged", frFR = "Destin Thriceforged", koKR = "Destin Thriceforged", ptBR = "Destin Thriceforged", ruRU = "Destin Thriceforged", zhCN = "Destin Thriceforged", zhTW = "Destin Thriceforged" },
    },
    {
        id = 1124, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2521, x = 0.5898, y = 0.7546,
        name = { enUS = "Railee Thriceforged", deDE = "Railee Thriceforged", esES = "Railee Thriceforged", esMX = "Railee Thriceforged", frFR = "Railee Thriceforged", koKR = "Railee Thriceforged", ptBR = "Railee Thriceforged", ruRU = "Railee Thriceforged", zhCN = "Railee Thriceforged", zhTW = "Railee Thriceforged" },
    },
    {
        id = 1125, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2521, x = 0.4479, y = 0.4417,
        name = { enUS = "Tephri Thriceforged", deDE = "Tephri Thriceforged", esES = "Tephri Thriceforged", esMX = "Tephri Thriceforged", frFR = "Tephri Thriceforged", koKR = "Tephri Thriceforged", ptBR = "Tephri Thriceforged", ruRU = "Tephri Thriceforged", zhCN = "Tephri Thriceforged", zhTW = "Tephri Thriceforged" },
    },
    {
        id = 1126, types = { "vendor-ammo", "vendor-general", "vendor-repair" },
        faction = "Neutral", map = 2521, x = 0.4275, y = 0.2449,
        name = { enUS = "Uualia Suncrest", deDE = "Uualia Suncrest", esES = "Uualia Suncrest", esMX = "Uualia Suncrest", frFR = "Uualia Suncrest", koKR = "Uualia Suncrest", ptBR = "Uualia Suncrest", ruRU = "Uualia Suncrest", zhCN = "Uualia Suncrest", zhTW = "Uualia Suncrest" },
    },
    {
        id = 1127, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 2521, x = 0.4471, y = 0.4548,
        name = { enUS = "Veena Vericloud", deDE = "Veena Vericloud", esES = "Veena Vericloud", esMX = "Veena Vericloud", frFR = "Veena Vericloud", koKR = "Veena Vericloud", ptBR = "Veena Vericloud", ruRU = "Veena Vericloud", zhCN = "Veena Vericloud", zhTW = "Veena Vericloud" },
    },
    {
        id = 1128, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7850, y = 0.5389,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1129, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7856, y = 0.5377,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1130, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7859, y = 0.5351,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1131, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7860, y = 0.5365,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1132, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7861, y = 0.5373,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1133, types = { "vendor-ammo", "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2548, x = 0.7867, y = 0.5344,
        name = { enUS = "Fizzix Boomshot", deDE = "Fizzix Boomshot", esES = "Fizzix Boomshot", esMX = "Fizzix Boomshot", frFR = "Fizzix Boomshot", koKR = "Fizzix Boomshot", ptBR = "Fizzix Boomshot", ruRU = "Fizzix Boomshot", zhCN = "Fizzix Boomshot", zhTW = "Fizzix Boomshot" },
    },
    {
        id = 1134, types = { "vendor-ammo", "vendor-general" },
        faction = "Neutral", map = 2548, x = 0.7666, y = 0.5317,
        name = { enUS = "Grizzek", deDE = "Grizzek", esES = "Grizzek", esMX = "Grizzek", frFR = "Grizzek", koKR = "Grizzek", ptBR = "Grizzek", ruRU = "Grizzek", zhCN = "Grizzek", zhTW = "Grizzek" },
    },
    {
        id = 1135, types = { "vendor-ammo", "vendor-general" },
        map = 2548, x = 0.5820, y = 0.4580,
        name = { enUS = "Maka", deDE = "Maka", esES = "Maka", esMX = "Maka", frFR = "Maka", koKR = "Maka", ptBR = "Maka", ruRU = "Maka", zhCN = "Maka", zhTW = "Maka" },
    },
    {
        id = 1136, types = { "vendor-ammo", "vendor-general" },
        faction = "Alliance", map = 2548, x = 0.6419, y = 0.8419,
        name = { enUS = "Martha Wellsworth", deDE = "Martha Wellsworth", esES = "Martha Wellsworth", esMX = "Martha Wellsworth", frFR = "Martha Wellsworth", koKR = "Martha Wellsworth", ptBR = "Martha Wellsworth", ruRU = "Martha Wellsworth", zhCN = "Martha Wellsworth", zhTW = "Martha Wellsworth" },
    },
    {
        id = 1137, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1411, x = 0.5311, y = 0.4090,
        name = { enUS = "Cutac", deDE = "Cutac", esES = "Cutac", esMX = "Cutac", frFR = "Cutac", koKR = "쿠탁", ptBR = "Cutac", ruRU = "Кутак", zhCN = "卡塔克", zhTW = "卡塔克" },
    },
    {
        id = 1138, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1411, x = 0.4060, y = 0.6779,
        name = { enUS = "Huklah", deDE = "Huklah", esES = "Huklah", esMX = "Huklah", frFR = "Huklah", koKR = "허클라", ptBR = "Huklah", ruRU = "Хукла", zhCN = "哈克拉恩", zhTW = "哈克拉恩" },
    },
    {
        id = 1139, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1411, x = 0.4050, y = 0.6779,
        name = { enUS = "Rarc", deDE = "Rarc", esES = "Rarc", esMX = "Rarc", frFR = "Rarc", koKR = "라르크", ptBR = "Rarc", ruRU = "Рарк", zhCN = "拉克", zhTW = "拉克" },
    },
    {
        id = 1140, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1411, x = 0.5190, y = 0.4109,
        name = { enUS = "Wuark", deDE = "Wuark", esES = "Wuark", esMX = "Wuark", frFR = "Wuark", koKR = "우아크", ptBR = "Wuark", ruRU = "Вьярк", zhCN = "沃克", zhTW = "沃克" },
    },
    {
        id = 1141, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1412, x = 0.4390, y = 0.7791,
        name = { enUS = "Bronk Steelrage", deDE = "Bronk Steelrage", esES = "Bronk Iracerada", esMX = "Bronk Iracerada", frFR = "Bronk Steelrage", koKR = "브롱크 스틸레이지", ptBR = "Bronk Fúria de Aço", ruRU = "Бронк Ярость Стали", zhCN = "布隆克·钢怒", zhTW = "布隆克·鋼怒" },
    },
    {
        id = 1142, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1412, x = 0.4532, y = 0.6219,
        name = { enUS = "Harant Ironbrace", deDE = "Harant Ironbrace", esES = "Harant Ferropulso", esMX = "Harant Ferropulso", frFR = "Harant Ironbrace", koKR = "하란트 아이언브레이스", ptBR = "Harant Braço de Ferro", ruRU = "Харант Железная Сбруя", zhCN = "哈兰特·铁枝", zhTW = "哈蘭特·鐵枝" },
    },
    {
        id = 1143, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1412, x = 0.4531, y = 0.6221,
        name = { enUS = "Varg Windwhisper", deDE = "Varg Windwhisper", esES = "Varg Vientosusurro", esMX = "Varg Vientosusurro", frFR = "Varg Windwhisper", koKR = "바르그 윈드위스퍼", ptBR = "Varg Vento Sussurrante", ruRU = "Варг Шепот Ветра", zhCN = "瓦尔格·风语", zhTW = "瓦爾格·風語" },
    },
    {
        id = 1144, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1412, x = 0.4390, y = 0.7768,
        name = { enUS = "Varia Hardhide", deDE = "Varia Hardhide", esES = "Varia Pieldura", esMX = "Varia Pieldura", frFR = "Varia Hardhide", koKR = "바리아 하드하이드", ptBR = "Varia Couro Duro", ruRU = "Вария Прочная Шкура", zhCN = "瓦利亚·韧皮", zhTW = "瓦利亞·韌皮" },
    },
    {
        id = 1145, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1413, x = 0.6220, y = 0.3839,
        name = { enUS = "Grazlix", deDE = "Grazlix", esES = "Grazlix", esMX = "Grazlix", frFR = "Grazlix", koKR = "그라즐릭스", ptBR = "Xaveco", ruRU = "Гразликс", zhCN = "格拉利克斯", zhTW = "格拉利克斯" },
    },
    {
        id = 1146, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1413, x = 0.5231, y = 0.3190,
        name = { enUS = "Halija Whitestrider", deDE = "Halija Whitestrider", esES = "Halija Zancablanca", esMX = "Halija Zancablanca", frFR = "Halija Whitestrider", koKR = "할리자 화이트스트라이더", ptBR = "Halija Casco Branco", ruRU = "Халья Белоброд", zhCN = "哈里沙·白蹄", zhTW = "哈里沙·白蹄" },
    },
    {
        id = 1147, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1413, x = 0.5120, y = 0.2900,
        name = { enUS = "Jahan Hawkwing", deDE = "Jahan Hawkwing", esES = "Jahan Ala Halcón", esMX = "Jahan Ala Halcón", frFR = "Jahan Hawkwing", koKR = "자안 호크윙", ptBR = "Jahan Asa de Falcão", ruRU = "Джахан Соколиное Крыло", zhCN = "加翰·鹰翼", zhTW = "加翰·鷹翼" },
    },
    {
        id = 1148, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1413, x = 0.4181, y = 0.3871,
        name = { enUS = "Kiknikle", deDE = "Kiknikle", esES = "Kiknikle", esMX = "Kiknikle", frFR = "Kiknikle", koKR = "킥니클", ptBR = "Jirimum", ruRU = "Пниподзад", zhCN = "吉克尼库", zhTW = "吉克尼庫" },
    },
    {
        id = 1149, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1413, x = 0.4181, y = 0.3861,
        name = { enUS = "Pizznukle", deDE = "Pizznukle", esES = "Pizdillo", esMX = "Pizdillo", frFR = "Pizznukle", koKR = "피즈너클", ptBR = "Gagago", ruRU = "Пьянюкл", zhCN = "宾兹纳库", zhTW = "賓茲納庫" },
    },
    {
        id = 1150, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1413, x = 0.4509, y = 0.5899,
        name = { enUS = "Sanuye Runetotem", deDE = "Sanuye Runetotem", esES = "Sanuye Runatótem", esMX = "Sanuye Tótem de Runa", frFR = "Sanuye Runetotem", koKR = "사누예 룬토템", ptBR = "Sanuye Runa Totem", ruRU = "Шанью Рунический Тотем", zhCN = "萨努耶·符文图腾", zhTW = "薩努耶·符文圖騰" },
    },
    {
        id = 1151, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1413, x = 0.6220, y = 0.3849,
        name = { enUS = "Vexspindle", deDE = "Vexspindle", esES = "Vexeje", esMX = "Vexeje", frFR = "Vexspindle", koKR = "벡스스핀들", ptBR = "Irriteixon", ruRU = "Веретеныш", zhCN = "维克斯宾德", zhTW = "維克斯賓德" },
    },
    {
        id = 1152, types = { "vendor-armor" },
        faction = "Alliance", map = 1416, x = 0.1596, y = 0.6546,
        name = { enUS = "Karandonna", deDE = "Karandonna", esES = "Karandonna", esMX = "Karandonna", frFR = "Karandonna", koKR = "Karandonna", ptBR = "Karandonna", ruRU = "Karandonna", zhCN = "Karandonna", zhTW = "Karandonna" },
    },
    {
        id = 1153, types = { "vendor-armor" },
        faction = "Alliance", map = 1416, x = 0.1600, y = 0.6541,
        name = { enUS = "Karandonna", deDE = "Karandonna", esES = "Karandonna", esMX = "Karandonna", frFR = "Karandonna", koKR = "Karandonna", ptBR = "Karandonna", ruRU = "Karandonna", zhCN = "Karandonna", zhTW = "Karandonna" },
    },
    {
        id = 1154, types = { "vendor-armor" },
        faction = "Alliance", map = 1416, x = 0.1585, y = 0.6525,
        name = { enUS = "Rueben Lauren", deDE = "Rueben Lauren", esES = "Rueben Lauren", esMX = "Rueben Lauren", frFR = "Rueben Lauren", koKR = "Rueben Lauren", ptBR = "Rueben Lauren", ruRU = "Rueben Lauren", zhCN = "Rueben Lauren", zhTW = "Rueben Lauren" },
    },
    {
        id = 1155, types = { "vendor-armor" },
        faction = "Alliance", map = 1416, x = 0.1589, y = 0.6529,
        name = { enUS = "Rueben Lauren", deDE = "Rueben Lauren", esES = "Rueben Lauren", esMX = "Rueben Lauren", frFR = "Rueben Lauren", koKR = "Rueben Lauren", ptBR = "Rueben Lauren", ruRU = "Rueben Lauren", zhCN = "Rueben Lauren", zhTW = "Rueben Lauren" },
    },
    {
        id = 1156, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1416, x = 0.1266, y = 0.7091,
        name = { enUS = "Valerie Langrom", deDE = "Valerie Langrom", esES = "Valerie Langrom", esMX = "Valerie Langrom", frFR = "Valerie Langrom", koKR = "Valerie Langrom", ptBR = "Valerie Langrom", ruRU = "Valerie Langrom", zhCN = "Valerie Langrom", zhTW = "Valerie Langrom" },
    },
    {
        id = 1157, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6019, y = 0.5312,
        name = { enUS = "Abe Winters", deDE = "Abe Winters", esES = "Abe Winters", esMX = "Abe Winters", frFR = "Abe Winters", koKR = "아베 윈터스", ptBR = "Abel Hibérnias", ruRU = "Эйб Винтерс", zhCN = "亚伯·温特斯", zhTW = "亞伯·溫特斯" },
    },
    {
        id = 1158, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.3240, y = 0.6569,
        name = { enUS = "Archibald Kava", deDE = "Archibald Kava", esES = "Archibald Kava", esMX = "Archibald Kava", frFR = "Archibald Kava", koKR = "아키볼드 카바", ptBR = "Arquibaldo Kava", ruRU = "Арчибальд Кава", zhCN = "阿基班德·卡瓦", zhTW = "阿基班德·卡瓦" },
    },
    {
        id = 1159, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.3240, y = 0.6622,
        name = { enUS = "Blacksmith Rand", deDE = "Schmied Rand", esES = "Herrero Rand", esMX = "Herrero Rand", frFR = "Forgeron Rand", koKR = "대장장이 란드", ptBR = "Ferreiro Ranieri", ruRU = "Кузнец Ранд", zhCN = "铁匠兰德", zhTW = "鐵匠蘭德" },
    },
    {
        id = 1160, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.5261, y = 0.5582,
        name = { enUS = "Constance Brisboise", deDE = "Constance Brisboise", esES = "Constanza Brisboise", esMX = "Constanza Brisboise", frFR = "Constance Brisboise", koKR = "콘스턴스 브리스부아즈", ptBR = "Constância Brígida", ruRU = "Констанция Брибуа", zhCN = "康斯坦茨·布里斯博埃斯", zhTW = "康斯坦茨·布里斯博埃斯" },
    },
    {
        id = 1161, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6031, y = 0.5281,
        name = { enUS = "Eliza Callen", deDE = "Eliza Callen", esES = "Eliza Callen", esMX = "Eliza Callen", frFR = "Eliza Callen", koKR = "엘리자 칼렌", ptBR = "Elisa Callen", ruRU = "Элиза Каллен", zhCN = "伊莉莎·考伦", zhTW = "伊莉莎·考倫" },
    },
    {
        id = 1162, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6273, y = 0.7742,
        name = { enUS = "Gillian Moore", deDE = "Gillian Moore", esES = "Gillian Moore", esMX = "Gillian Moore", frFR = "Gillian Moore", koKR = "길리안 무어", ptBR = "Giulia Moura", ruRU = "Джиллиан Мур", zhCN = "基里安·摩尔", zhTW = "基里安·摩爾" },
    },
    {
        id = 1163, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6134, y = 0.7312,
        name = { enUS = "Lauren Newcomb", deDE = "Lauren Newcomb", esES = "Lauren Newcomb", esMX = "Lauren Newcomb", frFR = "Lauren Newcomb", koKR = "라우렌 뉴콤브", ptBR = "Lauren Pentenovo", ruRU = "Лорен Ньюкомб", zhCN = "劳伦·纽科布", zhTW = "勞倫·紐科布" },
    },
    {
        id = 1164, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6291, y = 0.7135,
        name = { enUS = "Lucille Castleton", deDE = "Lucille Castleton", esES = "Lucille Castleton", esMX = "Lucille Castleton", frFR = "Lucille Castleton", koKR = "루킬리 캐슬턴", ptBR = "Olívia Azambuja", ruRU = "Люсиль Кэслтон", zhCN = "露西尔·卡斯尔顿", zhTW = "露西爾·卡斯爾頓" },
    },
    {
        id = 1165, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6087, y = 0.7118,
        name = { enUS = "Mirelle Tremayne", deDE = "Mirelle Tremayne", esES = "Mirelle Tremayne", esMX = "Mirelle Tremayne", frFR = "Mirelle Tremayne", koKR = "마릴레 트레메인", ptBR = "Mirela Trescudo", ruRU = "Мирель Тремейн", zhCN = "米尔雷·特雷曼恩", zhTW = "米爾雷·特雷曼恩" },
    },
    {
        id = 1166, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6276, y = 0.7118,
        name = { enUS = "Sheldon Von Croy", deDE = "Sheldon Von Croy", esES = "Sheldon Von Croy", esMX = "Sheldon Von Croy", frFR = "Sheldon Von Croy", koKR = "셸돈 본 크로이", ptBR = "Aurélio Paredes", ruRU = "Шелдон фон Круа", zhCN = "舍尔顿·冯·克罗伊", zhTW = "舍爾頓·馮·克羅伊" },
    },
    {
        id = 1167, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6111, y = 0.7348,
        name = { enUS = "Timothy Weldon", deDE = "Timothy Weldon", esES = "Timoteo Meldon", esMX = "Timoteo Meldon", frFR = "Timothy Weldon", koKR = "티모티 웰던", ptBR = "Timóteo Grevas", ruRU = "Тимоти Уэлдон", zhCN = "提莫斯·威尔顿", zhTW = "提莫斯·威爾頓" },
    },
    {
        id = 1168, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6102, y = 0.7326,
        name = { enUS = "Walter Ellingson", deDE = "Walter Ellingson", esES = "Walter Ellingson", esMX = "Walter Ellingson", frFR = "Walter Ellingson", koKR = "월터 엘링슨", ptBR = "Walter Ellias", ruRU = "Уолтер Эллингсон", zhCN = "瓦尔特·艾林松", zhTW = "華特·伊林森" },
    },
    {
        id = 1169, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1421, x = 0.4459, y = 0.3910,
        name = { enUS = "Alexandre Lefevre", deDE = "Alexandre Lefevre", esES = "Alexandre Lefevre", esMX = "Alexandre Lefevre", frFR = "Alexandra Lefevre", koKR = "알렉상드르 레페브르", ptBR = "Alexandra Lefevre", ruRU = "Александра Лефевр", zhCN = "亚历山德勒·雷夫瑞", zhTW = "亞曆山德勒·雷夫瑞" },
    },
    {
        id = 1170, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1421, x = 0.4481, y = 0.3919,
        name = { enUS = "Andrea Boynton", deDE = "Andrea Boynton", esES = "Andrea Boynton", esMX = "Andrea Boynton", frFR = "Andrea Boynton", koKR = "안드리아 보인톤", ptBR = "Andrea Boynton", ruRU = "Андреа Бойнтон", zhCN = "安德利亚·波恩顿", zhTW = "安德利亞·波恩頓" },
    },
    {
        id = 1171, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1421, x = 0.4329, y = 0.4129,
        name = { enUS = "Sebastian Meloche", deDE = "Sebastian Meloche", esES = "Sebastián Meloche", esMX = "Sebastián Meloche", frFR = "Sebastian Meloche", koKR = "세바스티안 멜로체", ptBR = "Sebastian Meloche", ruRU = "Себастиан Мелош", zhCN = "塞巴斯蒂安·米洛奇", zhTW = "塞巴斯蒂安·米洛奇" },
    },
    {
        id = 1172, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.4520, y = 0.5178,
        name = { enUS = "Boran Ironclink", deDE = "Boran Ironclink", esES = "Boran Tintiyerro", esMX = "Boran Tintiyerro", frFR = "Boran Ironclink", koKR = "보란 아이언클링크", ptBR = "Boran Tilintaço", ruRU = "Боран Железный Звон", zhCN = "伯兰·铁栏", zhTW = "伯蘭·鐵欄" },
    },
    {
        id = 1173, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5616, y = 0.3046,
        name = { enUS = "Bromiir Ormsen", deDE = "Bromiir Ormsen", esES = "Bromiir Ormsen", esMX = "Bromiir Ormsen", frFR = "Bromiir Ormsen", koKR = "브로미르 오름센", ptBR = "Bromiir Canhostrondo", ruRU = "Бромиир Ормсен", zhCN = "波洛米尔·奥姆森", zhTW = "波洛米爾·歐姆森" },
    },
    {
        id = 1174, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.3009, y = 0.4529,
        name = { enUS = "Burdrak Harglhelm", deDE = "Brudrak Harglhelm", esES = "Burdrak Soplayelmo", esMX = "Burdrak Soplayelmo", frFR = "Burdrak Harglhelm", koKR = "부르드락 하글헬름", ptBR = "Burdrak Harglhelm", ruRU = "Бурдрак Кожаный Шлем", zhCN = "伯德拉克·哈根海姆", zhTW = "伯德拉克·哈根海姆" },
    },
    {
        id = 1175, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5974, y = 0.3522,
        name = { enUS = "Dolkin Craghelm", deDE = "Dolkin Craghelm", esES = "Dolkin Yelmorisco", esMX = "Dolkin Yelmorisco", frFR = "Dolkin Craghelm", koKR = "돌킨 크래그헬름", ptBR = "Dolkin Elmorrocha", ruRU = "Долкин Крепкошлем", zhCN = "杜尔金·石盔", zhTW = "杜爾金·石盔" },
    },
    {
        id = 1176, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.2879, y = 0.6640,
        name = { enUS = "Durnan Furcutter", deDE = "Durnan Furcutter", esES = "Durnan Cortapieles", esMX = "Durnan Cortapieles", frFR = "Durnan Furcutter", koKR = "두르난 퍼커터", ptBR = "Durnan Cortapelo", ruRU = "Дарнан Мехорез", zhCN = "德南·弗卡特", zhTW = "德南·弗卡特" },
    },
    {
        id = 1177, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.4520, y = 0.5191,
        name = { enUS = "Gamili Frosthide", deDE = "Gamili Frosthide", esES = "Gamili Escardida", esMX = "Gamili Escardida", frFR = "Gamili Frosthide", koKR = "가밀리 프로스트하이드", ptBR = "Gamili Courogelo", ruRU = "Гамли Ледошкур", zhCN = "迦米利·霜甲", zhTW = "迦米利·霜甲" },
    },
    {
        id = 1178, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.2879, y = 0.6778,
        name = { enUS = "Grundel Harkin", deDE = "Grundel Harkin", esES = "Grundel Harkin", esMX = "Grundel Harkin", frFR = "Grundel Harkin", koKR = "그룬델 하킨", ptBR = "Grundel Harkin", ruRU = "Грюндель Харкин", zhCN = "格伦德尔·哈金", zhTW = "葛蘭德爾·哈金" },
    },
    {
        id = 1179, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5722, y = 0.2194,
        name = { enUS = "Ingrys Stonebrow", deDE = "Ingrys Stonebrow", esES = "Ingrys Petrocejas", esMX = "Ingrys Petrocejas", frFR = "Ingrys Stonebrow", koKR = "잉그리스 스톤브로우", ptBR = "Ingrys Pedracenho", ruRU = "Ингриса Камнелоб", zhCN = "因格瑞斯·石眉", zhTW = "因格瑞斯·石眉" },
    },
    {
        id = 1180, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5987, y = 0.3522,
        name = { enUS = "Lissyphus Finespindle", deDE = "Lissyphus Finespindle", esES = "Lissyphus Bueneje", esMX = "Lissyphus Bueneje", frFR = "Lissyphus Finespindle", koKR = "리시푸스 파인스핀들", ptBR = "Lissyphus Fusofino", ruRU = "Лиссифа Остроигл", zhCN = "利塞弗斯·钢轴", zhTW = "利塞弗斯·鋼軸" },
    },
    {
        id = 1181, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5622, y = 0.3038,
        name = { enUS = "Mangorn Flinthammer", deDE = "Mangorn Flinthammer", esES = "Mangorn Hachílex", esMX = "Mangorn Hachílex", frFR = "Mangorn Flinthammer", koKR = "맨고른 플린트해머", ptBR = "Mangorn Pederterlo", ruRU = "Нак", zhCN = "曼高恩·火锤", zhTW = "曼高恩·火錘" },
    },
    {
        id = 1182, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5990, y = 0.3513,
        name = { enUS = "Olthran Craghelm", deDE = "Olthran Craghelm", esES = "Olthran Yelmorisco", esMX = "Olthran Yelmorisco", frFR = "Olthran Craghelm", koKR = "올스란 크래그헬름", ptBR = "Olthran Elmorrocha", ruRU = "Ольтран Крепкошлем", zhCN = "奥斯兰·石盔", zhTW = "奧斯蘭·石盔" },
    },
    {
        id = 1183, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5633, y = 0.3030,
        name = { enUS = "Raena Flinthammer", deDE = "Raena Flinthammer", esES = "Raena Hachílex", esMX = "Raena Hachílex", frFR = "Raena Flinthammer", koKR = "레나 플린트해머", ptBR = "Raena Pedertelo", ruRU = "Раена Кремнемолот", zhCN = "莱纳·火锤", zhTW = "萊納·火錘" },
    },
    {
        id = 1184, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1427, x = 0.4152, y = 0.7503,
        name = { enUS = "Graw Cornerstone", deDE = "Graw Cornerstone", esES = "Grau Piedresquina", esMX = "Grau Piedresquina", frFR = "Graw Cornerstone", koKR = "그로 코너스톤", ptBR = "Graw Petrângul", ruRU = "Гроу Краеугол", zhCN = "格劳恩·角石", zhTW = "格勞恩·角石" },
    },
    {
        id = 1185, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.4170, y = 0.6580,
        name = { enUS = "Andrew Krighton", deDE = "Andrew Krighton", esES = "Andrew Krighton", esMX = "Andrew Krighton", frFR = "Andrew Krighton", koKR = "앤드류 크라이튼", ptBR = "André Cravo", ruRU = "Эндрю Крайтон", zhCN = "安德温·克里顿", zhTW = "安德溫·克里頓" },
    },
    {
        id = 1186, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.4762, y = 0.4138,
        name = { enUS = "Dermot Johns", deDE = "Dermot Johns", esES = "Dermot Johns", esMX = "Dermot Johns", frFR = "Dermot Johns", koKR = "더모트 존스", ptBR = "Dálvaro João", ruRU = "Дермот Джонс", zhCN = "德尔莫特·约翰斯", zhTW = "德爾莫特·約翰斯" },
    },
    {
        id = 1187, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.4770, y = 0.4138,
        name = { enUS = "Godric Rothgar", deDE = "Godric Rothgar", esES = "Godric Rothgar", esMX = "Godric Rothgar", frFR = "Godric Rothgar", koKR = "고드릭 로스거", ptBR = "Godrico Rothgar", ruRU = "Годрик Ротгер", zhCN = "高德瑞克·洛斯迦", zhTW = "高德瑞克·洛斯迦" },
    },
    {
        id = 1188, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.4139, y = 0.6557,
        name = { enUS = "Kurran Steele", deDE = "Kurran Steele", esES = "Kurran Aceralia", esMX = "Kurran Aceralia", frFR = "Kurran Steele", koKR = "쿠란 스틸", ptBR = "Torren Ácero", ruRU = "Курран Сталль", zhCN = "库兰·斯蒂利", zhTW = "庫蘭·斯蒂利" },
    },
    {
        id = 1189, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.6471, y = 0.6949,
        name = { enUS = "Morley Eberlein", deDE = "Morley Eberlein", esES = "Morley Eberlein", esMX = "Morley Eberlein", frFR = "Morley Eberlein", koKR = "몰리 이버레인", ptBR = "Jaques Ecler", ruRU = "Морли Эберлейн", zhCN = "莫雷·艾伯雷恩", zhTW = "莫雷·艾伯雷恩" },
    },
    {
        id = 1190, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.2518, y = 0.7410,
        name = { enUS = "Quartermaster Hudson", deDE = "Rüstmeister Hudson", esES = "Intendente Hudson", esMX = "Intendente Hudson", frFR = "Intendant Hudson", koKR = "병참장교 허드슨", ptBR = "Intendente Uchoa", ruRU = "Интендант Хадсон", zhCN = "军需官哈德森", zhTW = "軍需官哈德森" },
    },
    {
        id = 1191, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1429, x = 0.2518, y = 0.7393,
        name = { enUS = "Veldan Lightfoot", deDE = "Veldan Lightfoot", esES = "Veldan Pieligero", esMX = "Veldan Pieligero", frFR = "Veldan Lightfoot", koKR = "벨단 라이트푸트", ptBR = "Veldan Pisaleve", ruRU = "Вельдан Легконог", zhCN = "维尔丹·莱弗特", zhTW = "維爾丹·萊弗特" },
    },
    {
        id = 1192, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1431, x = 0.7388, y = 0.4878,
        name = { enUS = "Morg Gnarltree", deDE = "Morg Gnarltree", esES = "Morg Tuerzarbol", esMX = "Morg Tuerzarbol", frFR = "Morg Gnarltree", koKR = "모그 나알트리", ptBR = "Morg Roecasca", ruRU = "Морг Гнутодрев", zhCN = "莫格·纳尔特里", zhTW = "莫格·納爾特里" },
    },
    {
        id = 1193, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1432, x = 0.6481, y = 0.6598,
        name = { enUS = "Aldren Cordon", deDE = "Aldren Cordon", esES = "Aldren Córdono", esMX = "Aldren Córdono", frFR = "Aldren Cordon", koKR = "알드렌 코든", ptBR = "Aldren Cordame", ruRU = "Альдрен Кордон", zhCN = "奥德伦·科尔东", zhTW = "奧德倫·科爾東" },
    },
    {
        id = 1194, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1432, x = 0.2411, y = 0.1822,
        name = { enUS = "Gothor Brumn", deDE = "Gothor Brumn", esES = "Gothor Brumn", esMX = "Gothor Brumn", frFR = "Gothor Brumn", koKR = "고더 브럼", ptBR = "Gothor Brumn", ruRU = "Готор Брюм", zhCN = "高索·布鲁姆", zhTW = "高索·布魯姆" },
    },
    {
        id = 1195, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1432, x = 0.8269, y = 0.6410,
        name = { enUS = "Kat Sampson", deDE = "Kat Sampson", esES = "Kat Sampson", esMX = "Kat Sampson", frFR = "Kat Sampson", koKR = "카트 샘프슨", ptBR = "Tata Sansão", ruRU = "Кэт Сэмпсон", zhCN = "凯特·桑普森", zhTW = "凱特·薩普森" },
    },
    {
        id = 1196, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1433, x = 0.8323, y = 0.7098,
        name = { enUS = "Bernard Brubaker", deDE = "Bernard Brubaker", esES = "Bernard Brubaker", esMX = "Bernard Brubaker", frFR = "Bernard Brubaker", koKR = "버나드 브루베이커", ptBR = "Bernardo Bardini", ruRU = "Бернард Сухопек", zhCN = "伯纳德·布鲁贝克", zhTW = "伯納德·布魯貝克" },
    },
    {
        id = 1197, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1433, x = 0.2580, y = 0.4639,
        name = { enUS = "Dorin Songblade", deDE = "Dorin Songblade", esES = "Dorin Filosón", esMX = "Dorin Filosón", frFR = "Dorin Songblade", koKR = "도린 송블레이드", ptBR = "Dorin Espada-cantante", ruRU = "Дорин Поющий Клинок", zhCN = "多林·桑布雷德", zhTW = "多林·桑布雷德" },
    },
    {
        id = 1198, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2899, y = 0.7501,
        name = { enUS = "Fargon Mortalak", deDE = "Fargon Mortalak", esES = "Fargon Mortalak", esMX = "Fargon Mortalak", frFR = "Fargon Mortalak", koKR = "파르곤 모르탈락", ptBR = "Fargon Mortalak", ruRU = "Фаргон Морталак", zhCN = "法尔贡·莫塔拉克", zhTW = "法爾貢·莫塔拉克" },
    },
    {
        id = 1199, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1434, x = 0.3161, y = 0.2919,
        name = { enUS = "Hragran", deDE = "Hragran", esES = "Hragran", esMX = "Hragran", frFR = "Hragran", koKR = "라그란", ptBR = "Hragran", ruRU = "Храгран", zhCN = "哈格兰", zhTW = "哈格蘭" },
    },
    {
        id = 1200, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1434, x = 0.3261, y = 0.2791,
        name = { enUS = "Krakk", deDE = "Krakk", esES = "Krakk", esMX = "Krakk", frFR = "Krakk", koKR = "크래크", ptBR = "Krakk", ruRU = "Кракк", zhCN = "克拉克", zhTW = "克拉克" },
    },
    {
        id = 1201, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1435, x = 0.4510, y = 0.5139,
        name = { enUS = "Thralosh", deDE = "Thralosh", esES = "Thralosh", esMX = "Thralosh", frFR = "Thralosh", koKR = "스럴로쉬", ptBR = "Thralosh", ruRU = "Тралош", zhCN = "萨罗斯", zhTW = "薩羅斯" },
    },
    {
        id = 1202, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1437, x = 0.1150, y = 0.5989,
        name = { enUS = "Brahnmar", deDE = "Brahnmar", esES = "Brahnmar", esMX = "Brahnmar", frFR = "Brahnmar", koKR = "브란마르", ptBR = "Brahnmar", ruRU = "Бранмар", zhCN = "布兰玛尔", zhTW = "布蘭瑪爾" },
    },
    {
        id = 1203, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1438, x = 0.5871, y = 0.3982,
        name = { enUS = "Andiss", deDE = "Andiss", esES = "Andiss", esMX = "Andiss", frFR = "Andiss", koKR = "안디스", ptBR = "Andiss", ruRU = "Андисс", zhCN = "安迪斯", zhTW = "安迪斯" },
    },
    {
        id = 1204, types = { "vendor-armor" },
        faction = "Alliance", map = 1438, x = 0.5609, y = 0.6028,
        name = { enUS = "Brannol Eaglemoon", deDE = "Brannol Eaglemoon", esES = "Brannol Lunáguila", esMX = "Brannol Lunáguila", frFR = "Brannol Eaglemoon", koKR = "브란놀 이글문", ptBR = "Brannol Lunáguia", ruRU = "Браннол Лунный Орел", zhCN = "布兰诺尔·鹰月", zhTW = "布蘭諾爾·鷹月" },
    },
    {
        id = 1205, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1438, x = 0.5900, y = 0.3962,
        name = { enUS = "Freja Nightwing", deDE = "Freja Nightwing", esES = "Freja Alanoche", esMX = "Freja Alanoche", frFR = "Freja Nightwing", koKR = "프레자 나이트윙", ptBR = "Freja Noturnala", ruRU = "Фрейя Крыло Ночи", zhCN = "弗蕾亚·夜翼", zhTW = "弗蕾亞·夜翼" },
    },
    {
        id = 1206, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1438, x = 0.5949, y = 0.4111,
        name = { enUS = "Janna Brightmoon", deDE = "Janna Brightmoon", esES = "Janna Brillaluna", esMX = "Janna Brillaluna", frFR = "Janna Brightmoon", koKR = "잔나 프라이트문", ptBR = "Janna Lunaclara", ruRU = "Джанна Ясная Луна", zhCN = "简娜·明月", zhTW = "簡娜·明月" },
    },
    {
        id = 1207, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1438, x = 0.5630, y = 0.5938,
        name = { enUS = "Meri Ironweave", deDE = "Meri Ironweave", esES = "Meri Hilacero", esMX = "Meri Hilacero", frFR = "Meri Ironweave", koKR = "메리 아이언위브", ptBR = "Meri Teceferro", ruRU = "Мери Железоплет", zhCN = "梅里·织铁", zhTW = "梅里·織鐵" },
    },
    {
        id = 1208, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1438, x = 0.5630, y = 0.5962,
        name = { enUS = "Sinda", deDE = "Sinda", esES = "Sinda", esMX = "Sinda", frFR = "Sinda", koKR = "신다", ptBR = "Sinda", ruRU = "Синда", zhCN = "辛达", zhTW = "辛達" },
    },
    {
        id = 1209, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1439, x = 0.3699, y = 0.4131,
        name = { enUS = "Harlon Thornguard", deDE = "Harlon Thornguard", esES = "Harlon Guardaspina", esMX = "Harlon Guardaspina", frFR = "Harlon Thornguard", koKR = "하론 쏜가드", ptBR = "Harlon Guardespin", ruRU = "Харлон Терновый Страж", zhCN = "哈隆·棘甲", zhTW = "哈隆·棘甲" },
    },
    {
        id = 1210, types = { "vendor-armor" },
        faction = "Alliance", map = 1439, x = 0.3819, y = 0.4040,
        name = { enUS = "Shaldyn", deDE = "Shaldyn", esES = "Shaldyn", esMX = "Shaldyn", frFR = "Shaldyn", koKR = "샬딘", ptBR = "Shaldyn", ruRU = "Шальдин", zhCN = "沙尔迪恩", zhTW = "沙爾迪恩" },
    },
    {
        id = 1211, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1440, x = 0.3450, y = 0.4949,
        name = { enUS = "Aeolynn", deDE = "Aeolynn", esES = "Aeolynn", esMX = "Aeolynn", frFR = "Aeolynn", koKR = "애올린", ptBR = "Aeolynn", ruRU = "Эолин", zhCN = "艾欧琳", zhTW = "艾歐琳" },
    },
    {
        id = 1212, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1440, x = 0.7350, y = 0.6031,
        name = { enUS = "Burkrum", deDE = "Burkrum", esES = "Burkrum", esMX = "Burkrum", frFR = "Burkrum", koKR = "벌크럼", ptBR = "Burkrum", ruRU = "Буркрум", zhCN = "布克拉姆", zhTW = "布克拉姆" },
    },
    {
        id = 1213, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1440, x = 0.3450, y = 0.4991,
        name = { enUS = "Tandaan Lightmane", deDE = "Tandaan Lightmane", esES = "Tandaan Luzmelena", esMX = "Tandaan Luzmelena", frFR = "Tandaan Lightmane", koKR = "탄단 라이트메인", ptBR = "Tandaan Grenhaluz", ruRU = "Тандаан Светлогрив", zhCN = "塔丹恩·飘发", zhTW = "塔丹恩·飄發" },
    },
    {
        id = 1214, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1442, x = 0.3540, y = 0.0698,
        name = { enUS = "Illyanie", deDE = "Illyanie", esES = "Illyanie", esMX = "Illyanie", frFR = "Illyanie", koKR = "일랴니", ptBR = "Illyanie", ruRU = "Иллианиа", zhCN = "伊林安尼", zhTW = "伊林安尼" },
    },
    {
        id = 1215, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1443, x = 0.6791, y = 0.0832,
        name = { enUS = "Maxton Strang", deDE = "Maxton Strang", esES = "Maxton Strang", esMX = "Maxton Strang", frFR = "Maxton Strang", koKR = "맥스턴 스트랑", ptBR = "Ibson Norde", ruRU = "Макстон Штранг", zhCN = "玛克斯顿·斯坦恩", zhTW = "瑪克斯頓·斯坦恩" },
    },
    {
        id = 1216, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1444, x = 0.3080, y = 0.4311,
        name = { enUS = "Dulciea Frostmoon", deDE = "Dulciea Frostmoon", esES = "Dulcinea Lunelada", esMX = "Dulcinea Lunelada", frFR = "Dulciea Frostmoon", koKR = "둘시아 프로스트문", ptBR = "Dulcinea Lunálgida", ruRU = "Дульсия Холодная Луна", zhCN = "杜希雅·霜月", zhTW = "杜希雅·霜月" },
    },
    {
        id = 1217, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1444, x = 0.8931, y = 0.4590,
        name = { enUS = "Rendow", deDE = "Rendow", esES = "Rendow", esMX = "Rendow", frFR = "Rendow", koKR = "렌도우", ptBR = "Rendow", ruRU = "Рендо", zhCN = "瑞恩多尔", zhTW = "瑞恩多爾" },
    },
    {
        id = 1218, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1444, x = 0.7469, y = 0.4259,
        name = { enUS = "Worb Strongstitch", deDE = "Worb Strongstitch", esES = "Worb Puntofuerte", esMX = "Worb Puntofuerte", frFR = "Worb Strongstitch", koKR = "워브 스트롱스티치", ptBR = "Worb Ponto Forte", ruRU = "Ворб Крепкий Шов", zhCN = "沃尔布", zhTW = "沃爾布" },
    },
    {
        id = 1219, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1445, x = 0.6460, y = 0.5040,
        name = { enUS = "Hans Weston", deDE = "Hans Weston", esES = "Hans Weston", esMX = "Hans Weston", frFR = "Hans Weston", koKR = "한스 웨스턴", ptBR = "Hans Weston", ruRU = "Ханс Вестон", zhCN = "汉斯·温斯顿", zhTW = "漢斯·溫斯頓" },
    },
    {
        id = 1220, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1445, x = 0.3639, y = 0.3078,
        name = { enUS = "Krak", deDE = "Krak", esES = "Krak", esMX = "Krak", frFR = "Krak", koKR = "크라크", ptBR = "Krak", ruRU = "Крак", zhCN = "克伦卡", zhTW = "克倫卡" },
    },
    {
        id = 1221, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1450, x = 0.5661, y = 0.2994,
        name = { enUS = "Kharedon", deDE = "Kharedon", esES = "Kharedon", esMX = "Kharedon", frFR = "Kharedon", koKR = "카레돈", ptBR = "Kharedon", ruRU = "Харедон", zhCN = "卡雷东", zhTW = "卡雷東" },
    },
    {
        id = 1222, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1452, x = 0.6170, y = 0.3780,
        name = { enUS = "Blixxrak", deDE = "Blixxrak", esES = "Blixxrak", esMX = "Blixxrak", frFR = "Blixxrak", koKR = "블릭스락", ptBR = "Blixxrak", ruRU = "Близзрак", zhCN = "布利科撒克", zhTW = "布利科撒克" },
    },
    {
        id = 1223, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 1452, x = 0.6161, y = 0.3789,
        name = { enUS = "Nixxrak", deDE = "Nixxrak", esES = "Nixxrak", esMX = "Nixxrak", frFR = "Nixxrak", koKR = "닉스락", ptBR = "Nixxrak", ruRU = "Низзрак", zhCN = "尼克撒克", zhTW = "尼克撒克" },
    },
    {
        id = 1224, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5350, y = 0.5757,
        name = { enUS = "Agustus Moulaine", deDE = "Agustus Moulaine", esES = "Agustus Moulaine", esMX = "Agustus Moulaine", frFR = "Agustus Moulaine", koKR = "아구스투스 물레인", ptBR = "Augusto Moulaine", ruRU = "Август Мюлейн", zhCN = "阿古塔斯·莫莱恩", zhTW = "阿古塔斯·莫萊恩" },
    },
    {
        id = 1225, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6187, y = 0.6724,
        name = { enUS = "Aldric Moore", deDE = "Aldric Moore", esES = "Aldric Moore", esMX = "Aldric Moore", frFR = "Aldric Moore", koKR = "알드릭 무어", ptBR = "Freitas Mourão", ruRU = "Альдрик Мур", zhCN = "奥德瑞克·摩尔", zhTW = "奧德瑞克·摩爾" },
    },
    {
        id = 1226, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6202, y = 0.6781,
        name = { enUS = "Carla Granger", deDE = "Carla Granger", esES = "Carla Granger", esMX = "Carla Granger", frFR = "Carla Granger", koKR = "칼라 그랑거", ptBR = "Carla Granger", ruRU = "Карла Гренжер", zhCN = "卡拉·格兰治", zhTW = "卡拉·格蘭治" },
    },
    {
        id = 1227, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5319, y = 0.8197,
        name = { enUS = "Duncan Cullen", deDE = "Duncan Cullen", esES = "Duncan Cullen", esMX = "Duncan Cullen", frFR = "Duncan Cullen", koKR = "던컨 쿨렌", ptBR = "Cassiano Duncan", ruRU = "Дункан Куллен", zhCN = "邓肯·库仑", zhTW = "鄧肯·庫侖" },
    },
    {
        id = 1228, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6202, y = 0.6747,
        name = { enUS = "Lara Moore", deDE = "Lara Moore", esES = "Lara Moore", esMX = "Lara Moore", frFR = "Lara Moore", koKR = "라라 무어", ptBR = "Lara Mourão", ruRU = "Лара Мур", zhCN = "劳拉·摩尔", zhTW = "蘿拉·摩爾" },
    },
    {
        id = 1229, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5834, y = 0.6724,
        name = { enUS = "Lisbeth Schneider", deDE = "Lisbeth Schneider", esES = "Lisbeth Schneider", esMX = "Lisbeth Schneider", frFR = "Lisbeth Schneider", koKR = "리즈베스 슈나이더", ptBR = "Elizabete Armarinho", ruRU = "Лизбет Шнайдер", zhCN = "利斯贝·斯涅德", zhTW = "利斯貝·斯涅德" },
    },
    {
        id = 1230, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.7721, y = 0.6102,
        name = { enUS = "Osric Strang", deDE = "Osric Strang", esES = "Osric Strang", esMX = "Osric Strang", frFR = "Osric Strang", koKR = "오스릭 스트랑", ptBR = "Larso Norde", ruRU = "Озрик Штранг", zhCN = "奥斯瑞克·斯图恩", zhTW = "奧斯瑞克·斯圖恩" },
    },
    {
        id = 1231, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.7192, y = 0.6206,
        name = { enUS = "Seoman Griffith", deDE = "Seoman Griffith", esES = "Seoman Griffith", esMX = "Seoman Griffith", frFR = "Seoman Griffith", koKR = "서먼 그리피스", ptBR = "Renan Bardello", ruRU = "Шеман Гриффит", zhCN = "希欧曼·格瑞菲斯", zhTW = "希歐曼·格瑞菲斯" },
    },
    {
        id = 1232, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5319, y = 0.5791,
        name = { enUS = "Theresa Moulaine", deDE = "Theresa Moulaine", esES = "Theresa Moulaine", esMX = "Theresa Moulaine", frFR = "Theresa Moulaine", koKR = "테레사 마울레인", ptBR = "Theresa Moulaine", ruRU = "Тереза Мюлейн", zhCN = "瑟里莎·莫莱恩", zhTW = "泰瑞莎·莫萊恩" },
    },
    {
        id = 1233, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.7752, y = 0.6125,
        name = { enUS = "Wilhelm Strang", deDE = "Wilhelm Strang", esES = "Wilhelm Strang", esMX = "Wilhelm Strang", frFR = "Wilhelm Strang", koKR = "빌헬름 스트랑", ptBR = "Ingmaro Norde", ruRU = "Вильгельм Штранг", zhCN = "维尔海姆·斯图恩", zhTW = "維爾海姆·斯圖恩" },
    },
    {
        id = 1234, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.6289, y = 0.4467,
        name = { enUS = "Handor", deDE = "Handor", esES = "Handor", esMX = "Handor", frFR = "Handor", koKR = "한도르", ptBR = "Handor", ruRU = "Хандор", zhCN = "罕杜尔", zhTW = "罕杜爾" },
    },
    {
        id = 1235, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.5623, y = 0.7318,
        name = { enUS = "Morgum", deDE = "Morgum", esES = "Morgum", esMX = "Morgum", frFR = "Morgum", koKR = "모르굼", ptBR = "Morgum", ruRU = "Моргум", zhCN = "摩古姆", zhTW = "摩古姆" },
    },
    {
        id = 1236, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.5652, y = 0.7375,
        name = { enUS = "Ollanus", deDE = "Ollanus", esES = "Ollanus", esMX = "Ollanus", frFR = "Ollanus", koKR = "올라누스", ptBR = "Ollanor", ruRU = "Олланус", zhCN = "奥兰努斯", zhTW = "奧蘭努斯" },
    },
    {
        id = 1237, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.5604, y = 0.7275,
        name = { enUS = "Sana", deDE = "Sana", esES = "Sana", esMX = "Sana", frFR = "Sana", koKR = "사나", ptBR = "Sana", ruRU = "Сана", zhCN = "萨纳", zhTW = "薩納" },
    },
    {
        id = 1238, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.6279, y = 0.5037,
        name = { enUS = "Tor'phan", deDE = "Tor'phan", esES = "Tor'phan", esMX = "Tor'phan", frFR = "Tor'phan", koKR = "토르판", ptBR = "Tor'phan", ruRU = "Тор'фан", zhCN = "托尔凡", zhTW = "托爾凡" },
    },
    {
        id = 1239, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.8257, y = 0.2358,
        name = { enUS = "Tumi", deDE = "Tumi", esES = "Tumi", esMX = "Tumi", frFR = "Tumi", koKR = "투미", ptBR = "Tumi", ruRU = "Туми", zhCN = "图米", zhTW = "圖米" },
    },
    {
        id = 1240, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4580, y = 0.5586,
        name = { enUS = "Ahanu", deDE = "Ahanu", esES = "Ahanu", esMX = "Ahanu", frFR = "Ahanu", koKR = "아하누", ptBR = "Ahanu", ruRU = "Ахану", zhCN = "安哈努", zhTW = "安哈努" },
    },
    {
        id = 1241, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4503, y = 0.5662,
        name = { enUS = "Elki", deDE = "Elki", esES = "Elki", esMX = "Elki", frFR = "Elki", koKR = "엘키", ptBR = "Elki", ruRU = "Элки", zhCN = "艾尔基", zhTW = "艾爾基" },
    },
    {
        id = 1242, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4286, y = 0.4474,
        name = { enUS = "Fela", deDE = "Fela", esES = "Feela", esMX = "Feela", frFR = "Fela", koKR = "펠라", ptBR = "Fela", ruRU = "Фела", zhCN = "菲尔拉", zhTW = "菲爾拉" },
    },
    {
        id = 1243, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4273, y = 0.4359,
        name = { enUS = "Grod", deDE = "Grod", esES = "Grod", esMX = "Grod", frFR = "Grod", koKR = "그로드", ptBR = "Grod", ruRU = "Грод", zhCN = "格洛德", zhTW = "格洛德" },
    },
    {
        id = 1244, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4554, y = 0.5662,
        name = { enUS = "Hewa", deDE = "Hewa", esES = "Hewa", esMX = "Hewa", frFR = "Hewa", koKR = "헤와", ptBR = "Hewa", ruRU = "Хева", zhCN = "海瓦", zhTW = "海瓦" },
    },
    {
        id = 1245, types = { "vendor-armor", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.4337, y = 0.4436,
        name = { enUS = "Tagain", deDE = "Tagain", esES = "Tagain", esMX = "Tagain", frFR = "Tagain", koKR = "타게인", ptBR = "Tagain", ruRU = "Тагайна", zhCN = "塔盖恩", zhTW = "塔蓋恩" },
    },
    {
        id = 1246, types = { "vendor-armor" },
        faction = "Alliance", map = 1457, x = 0.5566, y = 0.9007,
        name = { enUS = "Anadyia", deDE = "Anadyia", esES = "Anadyia", esMX = "Anadyia", frFR = "Anadyia", koKR = "아나디야", ptBR = "Anadyia", ruRU = "Анадия", zhCN = "安达迪雅", zhTW = "安達迪雅" },
    },
    {
        id = 1247, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1457, x = 0.5918, y = 0.4643,
        name = { enUS = "Cylania", deDE = "Cylania", esES = "Cilania", esMX = "Cilania", frFR = "Cylania", koKR = "키라니아", ptBR = "Cylania", ruRU = "Силания", zhCN = "塞兰妮亚", zhTW = "塞蘭妮亞" },
    },
    {
        id = 1248, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1457, x = 0.5288, y = 0.8043,
        name = { enUS = "Cyridan", deDE = "Cyridan", esES = "Ciridan", esMX = "Ciridan", frFR = "Cyridan", koKR = "키리단", ptBR = "Cyridan", ruRU = "Киридиан", zhCN = "塞瑞丹", zhTW = "塞瑞丹" },
    },
    {
        id = 1249, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1457, x = 0.5704, y = 0.7703,
        name = { enUS = "Melea", deDE = "Melea", esES = "Melea", esMX = "Melea", frFR = "Melea", koKR = "멜레아", ptBR = "Melía", ruRU = "Мелея", zhCN = "梅尔利恩", zhTW = "梅爾利恩" },
    },
    {
        id = 1250, types = { "vendor-armor", "vendor-repair" },
        faction = "Alliance", map = 1457, x = 0.6070, y = 0.7250,
        name = { enUS = "Vinasia", deDE = "Vinasia", esES = "Vinasia", esMX = "Vinasia", frFR = "Vinasia", koKR = "비나시아", ptBR = "Vinasia", ruRU = "Винаша", zhCN = "温娜希雅", zhTW = "溫娜希雅" },
    },
    {
        id = 1251, types = { "vendor-armor", "vendor-repair" },
        faction = "Neutral", map = 2521, x = 0.4337, y = 0.2344,
        name = { enUS = "Fevrath Skyhammer", deDE = "Fevrath Skyhammer", esES = "Fevrath Skyhammer", esMX = "Fevrath Skyhammer", frFR = "Fevrath Skyhammer", koKR = "Fevrath Skyhammer", ptBR = "Fevrath Skyhammer", ruRU = "Fevrath Skyhammer", zhCN = "Fevrath Skyhammer", zhTW = "Fevrath Skyhammer" },
    },
    {
        id = 1252, types = { "vendor-bags" },
        faction = "Horde", map = 1420, x = 0.6250, y = 0.7804,
        name = { enUS = "Jonathan Chambers", deDE = "Jonathan Chambers", esES = "Jonathan Chambers", esMX = "Jonathan Chambers", frFR = "Jonathan Chambers", koKR = "조나단 챔버스", ptBR = "Jonathan Câmara", ruRU = "Джонатан Чамберс", zhCN = "乔纳森·查博斯", zhTW = "喬納森·查博斯" },
    },
    {
        id = 1253, types = { "vendor-bags" },
        faction = "Alliance", map = 1426, x = 0.5719, y = 0.3310,
        name = { enUS = "Pithwick", deDE = "Pithwick", esES = "Pithwick", esMX = "Pithwick", frFR = "Pithwick", koKR = "피스윅", ptBR = "Paviocurto", ruRU = "Питвик", zhCN = "皮斯维克", zhTW = "皮斯維克" },
    },
    {
        id = 1254, types = { "vendor-bags" },
        faction = "Alliance", map = 1453, x = 0.7169, y = 0.6217,
        name = { enUS = "Alyssa Griffith", deDE = "Alyssa Griffith", esES = "Alyssa Griffith", esMX = "Alyssa Griffith", frFR = "Alyssa Griffith", koKR = "알리사 그리피스", ptBR = "Alícia Bardello", ruRU = "Алисса Гриффит", zhCN = "奥琳萨·格瑞菲斯", zhTW = "艾莉莎·格瑞菲斯" },
    },
    {
        id = 1255, types = { "vendor-bags" },
        faction = "Horde", map = 1454, x = 0.5880, y = 0.5266,
        name = { enUS = "Gotri", deDE = "Gotri", esES = "Gotri", esMX = "Gotri", frFR = "Gotri", koKR = "고트리", ptBR = "Gotri", ruRU = "Готри", zhCN = "高特雷", zhTW = "高特雷" },
    },
    {
        id = 1256, types = { "vendor-bags" },
        faction = "Horde", map = 1456, x = 0.3928, y = 0.6429,
        name = { enUS = "Pakwa", deDE = "Pakwa", esES = "Pakwa", esMX = "Pakwa", frFR = "Pakwa", koKR = "파크와", ptBR = "Pakwa", ruRU = "Паква", zhCN = "帕克瓦", zhTW = "派克瓦" },
    },
    {
        id = 1257, types = { "vendor-fishing" },
        faction = "Horde", map = 1411, x = 0.5611, y = 0.7339,
        name = { enUS = "Zansoa", deDE = "Zansoa", esES = "Zansoa", esMX = "Zansoa", frFR = "Zansoa", koKR = "잔소아", ptBR = "Zansoa", ruRU = "Зансоа", zhCN = "詹苏尔", zhTW = "詹蘇爾" },
    },
    {
        id = 1258, types = { "vendor-fishing" },
        faction = "Horde", map = 1412, x = 0.4670, y = 0.5909,
        name = { enUS = "Harn Longcast", deDE = "Harn Longcast", esES = "Harn Tiralejo", esMX = "Harn Tiralejo", frFR = "Harn Longcast", koKR = "한 롱캐스트", ptBR = "Harn Lança Longe", ruRU = "Харн Далекий Заброс", zhCN = "哈恩·长线", zhTW = "哈恩·長線" },
    },
    {
        id = 1259, types = { "vendor-fishing" },
        faction = "Neutral", map = 1413, x = 0.6281, y = 0.3819,
        name = { enUS = "Kilxx", deDE = "Kilxx", esES = "Kilxx", esMX = "Kilxx", frFR = "Kilxx", koKR = "킬륵스", ptBR = "Kilxx", ruRU = "Кликс", zhCN = "基尔克斯", zhTW = "基爾克斯" },
    },
    {
        id = 1260, types = { "vendor-fishing" },
        faction = "Neutral", map = 1413, x = 0.6200, y = 0.3910,
        name = { enUS = "Zizzek", deDE = "Zizzek", esES = "Zizzek", esMX = "Zizzek", frFR = "Zizzek", koKR = "지제크", ptBR = "Zizzek", ruRU = "Зиззек", zhCN = "吉塞克", zhTW = "吉塞克" },
    },
    {
        id = 1261, types = { "vendor-fishing" },
        faction = "Horde", map = 1420, x = 0.6500, y = 0.7157,
        name = { enUS = "Lizbeth Cromwell", deDE = "Lizbeth Cromwell", esES = "Lizbeth Cromaljibe", esMX = "Lizbeth Cromaljibe", frFR = "Lizbeth Cromwell", koKR = "리즈베스 크롬웰", ptBR = "Elisabete Tarrafa", ruRU = "Лизбет Кромвель", zhCN = "莉兹白·克伦威尔", zhTW = "莉茲白·克倫威爾" },
    },
    {
        id = 1262, types = { "vendor-fishing" },
        faction = "Horde", map = 1420, x = 0.6589, y = 0.5958,
        name = { enUS = "Martine Tramblay", deDE = "Martine Tramblay", esES = "Martine Tramblay", esMX = "Martine Tramblay", frFR = "Martine Tramblay", koKR = "마틴 트램블레이", ptBR = "Martine Turbay", ruRU = "Мартин Трамбле", zhCN = "马丁·塔布雷", zhTW = "馬丁·塔布雷" },
    },
    {
        id = 1263, types = { "vendor-fishing" },
        faction = "Horde", map = 1421, x = 0.3300, y = 0.1781,
        name = { enUS = "Killian Sanatha", deDE = "Killian Sanatha", esES = "Killian Sanatha", esMX = "Killian Sanatha", frFR = "Killian Sanatha", koKR = "킬리안 사나타", ptBR = "Quim Sanatha", ruRU = "Киллиан Саната", zhCN = "基利恩·萨纳森", zhTW = "基利恩·薩納森" },
    },
    {
        id = 1264, types = { "vendor-fishing" },
        faction = "Alliance", map = 1426, x = 0.3150, y = 0.4472,
        name = { enUS = "Gretta Ganter", deDE = "Gretta Ganter", esES = "Gretta Ganter", esMX = "Gretta Ganter", frFR = "Gretta Ganter", koKR = "그레타 간터", ptBR = "Gretta Ganter", ruRU = "Гретта Гантер", zhCN = "格雷塔·甘特", zhTW = "格雷塔·甘特" },
    },
    {
        id = 1265, types = { "vendor-fishing" },
        faction = "Alliance", map = 1426, x = 0.5882, y = 0.2214,
        name = { enUS = "Tansy Puddlefizz", deDE = "Tansy Puddlefizz", esES = "Tansy Burbajea", esMX = "Tansy Burbajea", frFR = "Tansy Puddlefizz", koKR = "탄지 퍼들피즈", ptBR = "Tansy Sibilama", ruRU = "Танси Грязебульк", zhCN = "坦斯·泥泡", zhTW = "坦斯·泥泡" },
    },
    {
        id = 1266, types = { "vendor-fishing" },
        faction = "Alliance", map = 1432, x = 0.4030, y = 0.3931,
        name = { enUS = "Khara Deepwater", deDE = "Khara Deepwater", esES = "Khara Aguahonda", esMX = "Khara Aguahonda", frFR = "Khara Deepwater", koKR = "카라 딥워터", ptBR = "Khara Aguafunda", ruRU = "Хара Рыбовод", zhCN = "卡拉·深水", zhTW = "卡拉·深水" },
    },
    {
        id = 1267, types = { "vendor-fishing" },
        faction = "Neutral", map = 1434, x = 0.2741, y = 0.7721,
        name = { enUS = "Old Man Heming", deDE = "Old Man Heming", esES = "Viejo Heming", esMX = "Viejo Heming", frFR = "Vieil Heming", koKR = "노인 헤밍", ptBR = "Velho Heming", ruRU = "Старик Хеминг", zhCN = "老人海明威", zhTW = "老人海明威" },
    },
    {
        id = 1268, types = { "vendor-fishing", "vendor-food" },
        faction = "Neutral", map = 1434, x = 0.2799, y = 0.7699,
        name = { enUS = "Wigcik", deDE = "Wigcik", esES = "Wigcik", esMX = "Wigcik", frFR = "Wigcik", koKR = "위그치크", ptBR = "Wigcik", ruRU = "Виггик", zhCN = "维格希克", zhTW = "維格希克" },
    },
    {
        id = 1269, types = { "vendor-fishing", "vendor-food" },
        faction = "Alliance", map = 1436, x = 0.3621, y = 0.9017,
        name = { enUS = "Kriggon Talsone", deDE = "Kriggon Talsone", esES = "Kriggon Talsone", esMX = "Kriggon Talsone", frFR = "Kriggon Talsone", koKR = "크리곤 탈손", ptBR = "Kriggon Talsone", ruRU = "Криггон Талсон", zhCN = "克雷贡·塔尔松", zhTW = "克雷貢·塔爾松" },
    },
    {
        id = 1270, types = { "vendor-fishing" },
        faction = "Alliance", map = 1437, x = 0.0799, y = 0.5829,
        name = { enUS = "Stuart Fleming", deDE = "Stuart Fleming", esES = "Stuart Fleming", esMX = "Stuart Fleming", frFR = "Stuart Fleming", koKR = "스튜어트 플레밍", ptBR = "Stuart Fleming", ruRU = "Стюарт Флеминг", zhCN = "斯图亚特·弗雷明", zhTW = "斯圖亞特·弗雷明" },
    },
    {
        id = 1271, types = { "vendor-fishing" },
        faction = "Alliance", map = 1438, x = 0.5630, y = 0.9238,
        name = { enUS = "Nessa Shadowsong", deDE = "Nessa Shadowsong", esES = "Nessa Cantosombrío", esMX = "Nessa Cantosombrío", frFR = "Nessa Shadowsong", koKR = "네사 섀도송", ptBR = "Nessa Cantonegro", ruRU = "Несса Песня Теней", zhCN = "尼莎·影歌", zhTW = "奈莎·影歌" },
    },
    {
        id = 1272, types = { "vendor-fishing", "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.3699, y = 0.5640,
        name = { enUS = "Heldan Galesong", deDE = "Heldan Galesong", esES = "Heldan Vendasón", esMX = "Heldan Vendasón", frFR = "Heldan Galesong", koKR = "헬단 게일송", ptBR = "Heldan Cantovento", ruRU = "Хельдан Рокот Прибоя", zhCN = "海尔丹·风歌", zhTW = "海爾丹·風歌" },
    },
    {
        id = 1273, types = { "vendor-fishing" },
        faction = "Horde", map = 1443, x = 0.2260, y = 0.7201,
        name = { enUS = "Mai'Lahii", deDE = "Mail'Lahii", esES = "Mai'Lahii", esMX = "Mai'Lahii", frFR = "Mai'Lahii", koKR = "마이라힐", ptBR = "Mai'Lahii", ruRU = "Май'Лахия", zhCN = "麦拉斯", zhTW = "麥拉斯" },
    },
    {
        id = 1274, types = { "vendor-fishing" },
        faction = "Alliance", map = 1444, x = 0.3110, y = 0.4610,
        name = { enUS = "Savanne", deDE = "Savanne", esES = "Savanne", esMX = "Savanne", frFR = "Savanne", koKR = "사반느", ptBR = "Savanne", ruRU = "Саванне", zhCN = "萨瓦尼", zhTW = "薩瓦尼" },
    },
    {
        id = 1275, types = { "vendor-fishing", "vendor-food" },
        faction = "Neutral", map = 1446, x = 0.6661, y = 0.2211,
        name = { enUS = "Gikkix", deDE = "Gikkix", esES = "Gikkix", esMX = "Gikkix", frFR = "Gikkix", koKR = "긱킥스", ptBR = "Gikkix", ruRU = "Гиккикс", zhCN = "吉科希斯", zhTW = "吉科希斯" },
    },
    {
        id = 1276, types = { "vendor-fishing" },
        faction = "Alliance", map = 1453, x = 0.5511, y = 0.6977,
        name = { enUS = "Catherine Leland", deDE = "Catherine Leland", esES = "Catherine Leland", esMX = "Catherine Leland", frFR = "Catherine Leland", koKR = "캐서린 리랜드", ptBR = "Catarina Gurjão", ruRU = "Катрин Лиланд", zhCN = "凯瑟琳·利兰", zhTW = "凱薩琳·利蘭" },
    },
    {
        id = 1277, types = { "vendor-fishing" },
        faction = "Horde", map = 1454, x = 0.7002, y = 0.2985,
        name = { enUS = "Shankys", deDE = "Shankys", esES = "Shankys", esMX = "Shankys", frFR = "Shankys", koKR = "샨키스", ptBR = "Shankys", ruRU = "Шанкис", zhCN = "山吉斯", zhTW = "山吉斯" },
    },
    {
        id = 1278, types = { "vendor-fishing" },
        faction = "Horde", map = 1456, x = 0.5576, y = 0.4704,
        name = { enUS = "Sewa Mistrunner", deDE = "Sewa Mistrunner", esES = "Seua Correbruma", esMX = "Seua Correbruma", frFR = "Sewa Mistrunner", koKR = "세와 미스트러너", ptBR = "Sewa Corre com a Névoa", ruRU = "Сива Вестница Туманов", zhCN = "苏瓦·迷雾行者", zhTW = "蘇瓦·迷霧行者" },
    },
    {
        id = 1279, types = { "vendor-fishing" },
        faction = "Alliance", map = 1457, x = 0.4684, y = 0.5701,
        name = { enUS = "Voloren", deDE = "Voloren", esES = "Voloren", esMX = "Voloren", frFR = "Voloren", koKR = "볼로렌", ptBR = "Voloren", ruRU = "Волорен", zhCN = "沃洛伦", zhTW = "沃洛倫" },
    },
    {
        id = 1280, types = { "vendor-fishing", "vendor-food" },
        faction = "Neutral", map = 2548, x = 0.7838, y = 0.5496,
        name = { enUS = "Gritta Chumwater", deDE = "Gritta Chumwater", esES = "Gritta Chumwater", esMX = "Gritta Chumwater", frFR = "Gritta Chumwater", koKR = "Gritta Chumwater", ptBR = "Gritta Chumwater", ruRU = "Gritta Chumwater", zhCN = "Gritta Chumwater", zhTW = "Gritta Chumwater" },
    },
    {
        id = 1281, types = { "vendor-fishing", "vendor-food" },
        faction = "Neutral", map = 2548, x = 0.7843, y = 0.5506,
        name = { enUS = "Gritta Chumwater", deDE = "Gritta Chumwater", esES = "Gritta Chumwater", esMX = "Gritta Chumwater", frFR = "Gritta Chumwater", koKR = "Gritta Chumwater", ptBR = "Gritta Chumwater", ruRU = "Gritta Chumwater", zhCN = "Gritta Chumwater", zhTW = "Gritta Chumwater" },
    },
    {
        id = 1282, types = { "vendor-food" },
        faction = "Horde", map = 1411, x = 0.5109, y = 0.4260,
        name = { enUS = "Grimtak", deDE = "Grimtak", esES = "Grimtak", esMX = "Grimtak", frFR = "Grimtak", koKR = "그림탁", ptBR = "Grimtak", ruRU = "Гримтак", zhCN = "格瑞姆塔克", zhTW = "格瑞姆塔克" },
    },
    {
        id = 1283, types = { "vendor-food" },
        faction = "Horde", map = 1411, x = 0.5561, y = 0.7362,
        name = { enUS = "Hai'zan", deDE = "Hai'zan", esES = "Hai'zan", esMX = "Hai'zan", frFR = "Hai'zan", koKR = "하이잔", ptBR = "Hai'zan", ruRU = "Хай'зан", zhCN = "海赞", zhTW = "海贊" },
    },
    {
        id = 1284, types = { "vendor-food" },
        faction = "Horde", map = 1411, x = 0.4259, y = 0.6719,
        name = { enUS = "Zlagk", deDE = "Zlagk", esES = "Zlagk", esMX = "Zlagk", frFR = "Zlagk", koKR = "즐락크", ptBR = "Zlagk", ruRU = "Зляк", zhCN = "兹拉克", zhTW = "茲拉克" },
    },
    {
        id = 1285, types = { "vendor-food" },
        faction = "Horde", map = 1412, x = 0.4681, y = 0.6449,
        name = { enUS = "Jhawna Oatwind", deDE = "Jhawna Oatwind", esES = "Jhawna Viento de Avena", esMX = "Jhawna Viento de Avena", frFR = "Jhawna Oatwind", koKR = "쟈우나 오트윈드", ptBR = "Jhauna Ventos d'Aveia", ruRU = "Джауна Свирель Ветра", zhCN = "加纳·麦风", zhTW = "加納·麥風" },
    },
    {
        id = 1286, types = { "vendor-food" },
        faction = "Horde", map = 1412, x = 0.4429, y = 0.7820,
        name = { enUS = "Moodan Sungrain", deDE = "Moodan Sungrain", esES = "Moodan Granosol", esMX = "Moodan Granosol", frFR = "Moodan Sungrain", koKR = "무단 선그레인", ptBR = "Moodan Grão Solar", ruRU = "Модан Солнечный Колос", zhCN = "穆恩丹·秋谷", zhTW = "穆恩丹·秋谷" },
    },
    {
        id = 1287, types = { "vendor-food" },
        faction = "Neutral", map = 1412, x = 0.3760, y = 0.4512,
        name = { enUS = "Sylannia", deDE = "Sylannia", esES = "Sylannia", esMX = "Sylannia", frFR = "Sylannia", koKR = "실라니아", ptBR = "Sylannia", ruRU = "Силанния", zhCN = "塞兰妮亚", zhTW = "希拉妮雅" },
    },
    {
        id = 1288, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.4954, y = 0.2929,
        name = { enUS = "Aza'bek", deDE = "Aza'bek", esES = "Aza'bek", esMX = "Aza'bek", frFR = "Aza'bek", koKR = "Aza'bek", ptBR = "Aza'bek", ruRU = "Aza'bek", zhCN = "Aza'bek", zhTW = "Aza'bek" },
    },
    {
        id = 1289, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.4974, y = 0.2936,
        name = { enUS = "Aza'bek", deDE = "Aza'bek", esES = "Aza'bek", esMX = "Aza'bek", frFR = "Aza'bek", koKR = "Aza'bek", ptBR = "Aza'bek", ruRU = "Aza'bek", zhCN = "Aza'bek", zhTW = "Aza'bek" },
    },
    {
        id = 1290, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.4979, y = 0.2904,
        name = { enUS = "Aza'bek", deDE = "Aza'bek", esES = "Aza'bek", esMX = "Aza'bek", frFR = "Aza'bek", koKR = "Aza'bek", ptBR = "Aza'bek", ruRU = "Aza'bek", zhCN = "Aza'bek", zhTW = "Aza'bek" },
    },
    {
        id = 1291, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.4470, y = 0.5941,
        name = { enUS = "Gahroot", deDE = "Gahroot", esES = "Garraíz", esMX = "Garraíz", frFR = "Gahroot", koKR = "가루트", ptBR = "Gahroot", ruRU = "Гахрут", zhCN = "加鲁特", zhTW = "加魯特" },
    },
    {
        id = 1292, types = { "vendor-food" },
        faction = "Neutral", map = 1413, x = 0.4670, y = 0.0830,
        name = { enUS = "Hecht Copperpinch", deDE = "Hecht Copperpinch", esES = "Hecht Cobrellizco", esMX = "Hecht Cobrellizco", frFR = "Hecht Copperpinch", koKR = "헥트 코퍼핀치", ptBR = "Mesblo Pechisbeque", ruRU = "Кляйн Меднокноп", zhCN = "赫克·科宾其", zhTW = "赫克·考伯賓奇" },
    },
    {
        id = 1293, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.5200, y = 0.2971,
        name = { enUS = "Larhka", deDE = "Larhka", esES = "Larhka", esMX = "Larhka", frFR = "Larhka", koKR = "라르카", ptBR = "Larhka", ruRU = "Ларка", zhCN = "拉卡", zhTW = "拉哈卡" },
    },
    {
        id = 1294, types = { "vendor-food" },
        faction = "Alliance", map = 1413, x = 0.4959, y = 0.8429,
        name = { enUS = "Malgin Barleybrew", deDE = "Malgin Gerstenbräu", esES = "Malgin Cebadiz", esMX = "Malgin Cebadiz", frFR = "Malgin Barleybrew", koKR = "말긴 발리브루", ptBR = "Malgin Cervevada", ruRU = "Малгин Ячменовар", zhCN = "玛尔金·麦酒", zhTW = "瑪爾金·麥酒" },
    },
    {
        id = 1295, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.5240, y = 0.3050,
        name = { enUS = "Moorane Hearthgrain", deDE = "Moorane Hearthgrain", esES = "Moorane Granogar", esMX = "Moorane Granogar", frFR = "Moorane Hearthgrain", koKR = "무레인 하트그레인", ptBR = "Moorane Grão do Fogo", ruRU = "Мурана Домашний Очаг", zhCN = "穆拉恩·熟麦", zhTW = "穆拉恩·熟麥" },
    },
    {
        id = 1296, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.5520, y = 0.3210,
        name = { enUS = "Tarban Hearthgrain", deDE = "Tarban Hearthgrain", esES = "Tarban Granogar", esMX = "Tarban Granogar", frFR = "Tarban Hearthgrain", koKR = "타반 하트그레인", ptBR = "Tarban Grão do Fogo", ruRU = "Тарбан Домашний Очаг", zhCN = "塔班·熟麦", zhTW = "塔班·熟麥" },
    },
    {
        id = 1297, types = { "vendor-food" },
        faction = "Horde", map = 1413, x = 0.5259, y = 0.2981,
        name = { enUS = "Zargh", deDE = "Zargh", esES = "Zargh", esMX = "Zargh", frFR = "Zargh", koKR = "자르그", ptBR = "Zargh", ruRU = "Заргх", zhCN = "扎尔夫", zhTW = "札爾夫" },
    },
    {
        id = 1298, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1436, y = 0.6460,
        name = { enUS = "Ajay Green", deDE = "Ajay Green", esES = "Ajay Green", esMX = "Ajay Green", frFR = "Ajay Green", koKR = "Ajay Green", ptBR = "Ajay Green", ruRU = "Ajay Green", zhCN = "Ajay Green", zhTW = "Ajay Green" },
    },
    {
        id = 1299, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1438, y = 0.6472,
        name = { enUS = "Ajay Green", deDE = "Ajay Green", esES = "Ajay Green", esMX = "Ajay Green", frFR = "Ajay Green", koKR = "Ajay Green", ptBR = "Ajay Green", ruRU = "Ajay Green", zhCN = "Ajay Green", zhTW = "Ajay Green" },
    },
    {
        id = 1300, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1453, y = 0.6460,
        name = { enUS = "Ajay Green", deDE = "Ajay Green", esES = "Ajay Green", esMX = "Ajay Green", frFR = "Ajay Green", koKR = "Ajay Green", ptBR = "Ajay Green", ruRU = "Ajay Green", zhCN = "Ajay Green", zhTW = "Ajay Green" },
    },
    {
        id = 1301, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1430, y = 0.6585,
        name = { enUS = "Applebough", deDE = "Applebough", esES = "Applebough", esMX = "Applebough", frFR = "Applebough", koKR = "Applebough", ptBR = "Applebough", ruRU = "Applebough", zhCN = "Applebough", zhTW = "Applebough" },
    },
    {
        id = 1302, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1435, y = 0.6613,
        name = { enUS = "Applebough", deDE = "Applebough", esES = "Applebough", esMX = "Applebough", frFR = "Applebough", koKR = "Applebough", ptBR = "Applebough", ruRU = "Applebough", zhCN = "Applebough", zhTW = "Applebough" },
    },
    {
        id = 1303, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1459, y = 0.6827,
        name = { enUS = "Applebough", deDE = "Applebough", esES = "Applebough", esMX = "Applebough", frFR = "Applebough", koKR = "Applebough", ptBR = "Applebough", ruRU = "Applebough", zhCN = "Applebough", zhTW = "Applebough" },
    },
    {
        id = 1304, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1462, y = 0.6646,
        name = { enUS = "Applebough", deDE = "Applebough", esES = "Applebough", esMX = "Applebough", frFR = "Applebough", koKR = "Applebough", ptBR = "Applebough", ruRU = "Applebough", zhCN = "Applebough", zhTW = "Applebough" },
    },
    {
        id = 1305, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1833, y = 0.6558,
        name = { enUS = "Arille Azuregaze", deDE = "Arille Azuregaze", esES = "Arille Azuregaze", esMX = "Arille Azuregaze", frFR = "Arille Azuregaze", koKR = "Arille Azuregaze", ptBR = "Arille Azuregaze", ruRU = "Arille Azuregaze", zhCN = "Arille Azuregaze", zhTW = "Arille Azuregaze" },
    },
    {
        id = 1306, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1835, y = 0.6571,
        name = { enUS = "Arille Azuregaze", deDE = "Arille Azuregaze", esES = "Arille Azuregaze", esMX = "Arille Azuregaze", frFR = "Arille Azuregaze", koKR = "Arille Azuregaze", ptBR = "Arille Azuregaze", ruRU = "Arille Azuregaze", zhCN = "Arille Azuregaze", zhTW = "Arille Azuregaze" },
    },
    {
        id = 1307, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1840, y = 0.6588,
        name = { enUS = "Arille Azuregaze", deDE = "Arille Azuregaze", esES = "Arille Azuregaze", esMX = "Arille Azuregaze", frFR = "Arille Azuregaze", koKR = "Arille Azuregaze", ptBR = "Arille Azuregaze", ruRU = "Arille Azuregaze", zhCN = "Arille Azuregaze", zhTW = "Arille Azuregaze" },
    },
    {
        id = 1308, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1843, y = 0.6582,
        name = { enUS = "Arille Azuregaze", deDE = "Arille Azuregaze", esES = "Arille Azuregaze", esMX = "Arille Azuregaze", frFR = "Arille Azuregaze", koKR = "Arille Azuregaze", ptBR = "Arille Azuregaze", ruRU = "Arille Azuregaze", zhCN = "Arille Azuregaze", zhTW = "Arille Azuregaze" },
    },
    {
        id = 1309, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1846, y = 0.6596,
        name = { enUS = "Arille Azuregaze", deDE = "Arille Azuregaze", esES = "Arille Azuregaze", esMX = "Arille Azuregaze", frFR = "Arille Azuregaze", koKR = "Arille Azuregaze", ptBR = "Arille Azuregaze", ruRU = "Arille Azuregaze", zhCN = "Arille Azuregaze", zhTW = "Arille Azuregaze" },
    },
    {
        id = 1310, types = { "vendor-food" },
        map = 1416, x = 0.1915, y = 0.6692,
        name = { enUS = "Christi Stockton", deDE = "Christi Stockton", esES = "Christi Stockton", esMX = "Christi Stockton", frFR = "Christi Stockton", koKR = "Christi Stockton", ptBR = "Christi Stockton", ruRU = "Christi Stockton", zhCN = "Christi Stockton", zhTW = "Christi Stockton" },
    },
    {
        id = 1311, types = { "vendor-food" },
        map = 1416, x = 0.2006, y = 0.6730,
        name = { enUS = "Christi Stockton", deDE = "Christi Stockton", esES = "Christi Stockton", esMX = "Christi Stockton", frFR = "Christi Stockton", koKR = "Christi Stockton", ptBR = "Christi Stockton", ruRU = "Christi Stockton", zhCN = "Christi Stockton", zhTW = "Christi Stockton" },
    },
    {
        id = 1312, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2172, y = 0.7434,
        name = { enUS = "Cody", deDE = "Cody", esES = "Cody", esMX = "Cody", frFR = "Cody", koKR = "Cody", ptBR = "Cody", ruRU = "Cody", zhCN = "Cody", zhTW = "Cody" },
    },
    {
        id = 1313, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2180, y = 0.7431,
        name = { enUS = "Cody", deDE = "Cody", esES = "Cody", esMX = "Cody", frFR = "Cody", koKR = "Cody", ptBR = "Cody", ruRU = "Cody", zhCN = "Cody", zhTW = "Cody" },
    },
    {
        id = 1314, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2190, y = 0.7307,
        name = { enUS = "Cody", deDE = "Cody", esES = "Cody", esMX = "Cody", frFR = "Cody", koKR = "Cody", ptBR = "Cody", ruRU = "Cody", zhCN = "Cody", zhTW = "Cody" },
    },
    {
        id = 1315, types = { "vendor-food" },
        faction = "Neutral", map = 1416, x = 0.6198, y = 0.5857,
        name = { enUS = "Dillord Copperpinch", deDE = "Dillord Copperpinch", esES = "Dillord Cobrellizco", esMX = "Dillord Cobrellizco", frFR = "Dillord Copperpinch", koKR = "딜로드 코퍼핀치", ptBR = "Saraivo Pechisbeque", ruRU = "Кинзо Меднокноп", zhCN = "迪洛德·科宾其", zhTW = "迪洛德·考伯賓奇" },
    },
    {
        id = 1316, types = { "vendor-food" },
        faction = "Neutral", map = 1416, x = 0.4012, y = 0.8021,
        name = { enUS = "Mirvyna Jinglepocket", deDE = "Mirvyna Jinglepocket", esES = "Mirvyna Calderilla", esMX = "Mirvyna Calderilla", frFR = "Mirvyna Jinglepocket", koKR = "미르비나 징글포켓", ptBR = "Mirvina \"Dindim\" Goubel", ruRU = "Шонель Деньгозвон", zhCN = "米维纳·吉波克", zhTW = "米維納·響囊" },
    },
    {
        id = 1317, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2084, y = 0.7471,
        name = { enUS = "Paige", deDE = "Paige", esES = "Paige", esMX = "Paige", frFR = "Paige", koKR = "Paige", ptBR = "Paige", ruRU = "Paige", zhCN = "Paige", zhTW = "Paige" },
    },
    {
        id = 1318, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2086, y = 0.7460,
        name = { enUS = "Paige", deDE = "Paige", esES = "Paige", esMX = "Paige", frFR = "Paige", koKR = "Paige", ptBR = "Paige", ruRU = "Paige", zhCN = "Paige", zhTW = "Paige" },
    },
    {
        id = 1319, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2092, y = 0.7458,
        name = { enUS = "Paige", deDE = "Paige", esES = "Paige", esMX = "Paige", frFR = "Paige", koKR = "Paige", ptBR = "Paige", ruRU = "Paige", zhCN = "Paige", zhTW = "Paige" },
    },
    {
        id = 1320, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2095, y = 0.7463,
        name = { enUS = "Paige", deDE = "Paige", esES = "Paige", esMX = "Paige", frFR = "Paige", koKR = "Paige", ptBR = "Paige", ruRU = "Paige", zhCN = "Paige", zhTW = "Paige" },
    },
    {
        id = 1321, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.2183, y = 0.7481,
        name = { enUS = "Paige", deDE = "Paige", esES = "Paige", esMX = "Paige", frFR = "Paige", koKR = "Paige", ptBR = "Paige", ruRU = "Paige", zhCN = "Paige", zhTW = "Paige" },
    },
    {
        id = 1322, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1799, y = 0.6539,
        name = { enUS = "Sandra Bartan", deDE = "Sandra Bartan", esES = "Sandra Bartan", esMX = "Sandra Bartan", frFR = "Sandra Bartan", koKR = "Sandra Bartan", ptBR = "Sandra Bartan", ruRU = "Sandra Bartan", zhCN = "Sandra Bartan", zhTW = "Sandra Bartan" },
    },
    {
        id = 1323, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1844, y = 0.6614,
        name = { enUS = "Sandra Bartan", deDE = "Sandra Bartan", esES = "Sandra Bartan", esMX = "Sandra Bartan", frFR = "Sandra Bartan", koKR = "Sandra Bartan", ptBR = "Sandra Bartan", ruRU = "Sandra Bartan", zhCN = "Sandra Bartan", zhTW = "Sandra Bartan" },
    },
    {
        id = 1324, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1282, y = 0.6664,
        name = { enUS = "Stefan Cotter", deDE = "Stefan Cotter", esES = "Stefan Cotter", esMX = "Stefan Cotter", frFR = "Stefan Cotter", koKR = "Stefan Cotter", ptBR = "Stefan Cotter", ruRU = "Stefan Cotter", zhCN = "Stefan Cotter", zhTW = "Stefan Cotter" },
    },
    {
        id = 1325, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1288, y = 0.6684,
        name = { enUS = "Stefan Cotter", deDE = "Stefan Cotter", esES = "Stefan Cotter", esMX = "Stefan Cotter", frFR = "Stefan Cotter", koKR = "Stefan Cotter", ptBR = "Stefan Cotter", ruRU = "Stefan Cotter", zhCN = "Stefan Cotter", zhTW = "Stefan Cotter" },
    },
    {
        id = 1326, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1291, y = 0.6668,
        name = { enUS = "Stefan Cotter", deDE = "Stefan Cotter", esES = "Stefan Cotter", esMX = "Stefan Cotter", frFR = "Stefan Cotter", koKR = "Stefan Cotter", ptBR = "Stefan Cotter", ruRU = "Stefan Cotter", zhCN = "Stefan Cotter", zhTW = "Stefan Cotter" },
    },
    {
        id = 1327, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1291, y = 0.6676,
        name = { enUS = "Stefan Cotter", deDE = "Stefan Cotter", esES = "Stefan Cotter", esMX = "Stefan Cotter", frFR = "Stefan Cotter", koKR = "Stefan Cotter", ptBR = "Stefan Cotter", ruRU = "Stefan Cotter", zhCN = "Stefan Cotter", zhTW = "Stefan Cotter" },
    },
    {
        id = 1328, types = { "vendor-food" },
        faction = "Alliance", map = 1416, x = 0.1423, y = 0.6721,
        name = { enUS = "Stefan Cotter", deDE = "Stefan Cotter", esES = "Stefan Cotter", esMX = "Stefan Cotter", frFR = "Stefan Cotter", koKR = "Stefan Cotter", ptBR = "Stefan Cotter", ruRU = "Stefan Cotter", zhCN = "Stefan Cotter", zhTW = "Stefan Cotter" },
    },
    {
        id = 1329, types = { "vendor-food" },
        faction = "Neutral", map = 1417, x = 0.7419, y = 0.2928,
        name = { enUS = "Kosco Copperpinch", deDE = "Kosco Copperpinch", esES = "Kosco Cobrellizco", esMX = "Kosco Cobrellizco", frFR = "Kosco Copperpinch", koKR = "디마트 코퍼핀치", ptBR = "Lídeu Pechisbeque", ruRU = "Ричи Меднокноп", zhCN = "克斯·考伯宾奇", zhTW = "克斯可·考伯賓奇" },
    },
    {
        id = 1330, types = { "vendor-food" },
        faction = "Alliance", map = 1417, x = 0.4548, y = 0.4761,
        name = { enUS = "Narj Deepslice", deDE = "Narj Deepslice", esES = "Narj Tajofondo", esMX = "Narj Tajofondo", frFR = "Narj Deepslice", koKR = "나르 딥슬라이스", ptBR = "Narj Cortafundo", ruRU = "Нардж Ломтерез", zhCN = "纳尔基·长刀", zhTW = "納爾基·長刀" },
    },
    {
        id = 1331, types = { "vendor-food" },
        faction = "Neutral", map = 1417, x = 0.4648, y = 0.4528,
        name = { enUS = "Targot Jinglepocket", deDE = "Targot Jinglepocket", esES = "Targot Calderilla", esMX = "Targot Calderilla", frFR = "Targot Jinglepocket", koKR = "까르포 징글포켓", ptBR = "Targot \"Dindin\" Goubel", ruRU = "Версач Деньгозвон", zhCN = "塔戈特·吉波克", zhTW = "塔戈特·響囊" },
    },
    {
        id = 1332, types = { "vendor-food" },
        faction = "Horde", map = 1417, x = 0.7419, y = 0.3400,
        name = { enUS = "Uttnar", deDE = "Uttnar", esES = "Uttnar", esMX = "Uttnar", frFR = "Uttnar", koKR = "우트나르", ptBR = "Uttnar", ruRU = "Уттнар", zhCN = "尤特纳", zhTW = "尤特納" },
    },
    {
        id = 1333, types = { "vendor-food" },
        faction = "Alliance", map = 1419, x = 0.6351, y = 0.1701,
        name = { enUS = "Bernie Heisten", deDE = "Bernie Heisten", esES = "Bernie Heisten", esMX = "Bernie Heisten", frFR = "Bernie Heisten", koKR = "베르니 하이스텐", ptBR = "Bernie Heisten", ruRU = "Берни Хайнштейн", zhCN = "波尼·海斯坦", zhTW = "波尼·海斯坦" },
    },
    {
        id = 1334, types = { "vendor-food" },
        faction = "Horde", map = 1420, x = 0.5831, y = 0.5068,
        name = { enUS = "Hamlin Atkins", deDE = "Hamlin Atkins", esES = "Hamlin Atkins", esMX = "Hamlin Atkins", frFR = "Hamlin Atkins", koKR = "함린 아트킨스", ptBR = "Humberto Atreu", ruRU = "Хамлин Аткинс", zhCN = "哈姆林·埃金斯", zhTW = "哈姆林·埃金斯" },
    },
    {
        id = 1335, types = { "vendor-food" },
        faction = "Neutral", map = 1420, x = 0.6226, y = 0.7326,
        name = { enUS = "Jaycrue Copperpinch", deDE = "Jaycrue Copperpinch", esES = "Jaycrue Cobrellizco", esMX = "Jaycrue Cobrellizco", frFR = "Jaycrue Copperpinch", koKR = "제이크루 코퍼핀치", ptBR = "Ricardelette Pechisbeque", ruRU = "Габана Меднокноп", zhCN = "加克鲁·卡布彬", zhTW = "加克魯·考伯賓奇" },
    },
    {
        id = 1336, types = { "vendor-food" },
        faction = "Horde", map = 1420, x = 0.5904, y = 0.7250,
        name = { enUS = "Joanna Whitehall", deDE = "Joanna Whitehall", esES = "Joanna Salablanca", esMX = "Joanna Salablanca", frFR = "Joanna Whitehall", koKR = "조안나 화이트홀", ptBR = "Joana Castelo Branco", ruRU = "Джоанна Вайтхолл", zhCN = "乔安娜·怀特豪尔", zhTW = "瓊安娜·懷特豪爾" },
    },
    {
        id = 1337, types = { "vendor-food" },
        faction = "Horde", map = 1420, x = 0.6421, y = 0.6896,
        name = { enUS = "Morley Bates", deDE = "Morley Bates", esES = "Morley Bates", esMX = "Morley Bates", frFR = "Morley Bates", koKR = "몰리 베이츠", ptBR = "Mauro Pilates", ruRU = "Морли Бейтс", zhCN = "莫雷·巴特斯", zhTW = "莫雷·巴特斯" },
    },
    {
        id = 1338, types = { "vendor-food" },
        faction = "Horde", map = 1420, x = 0.6129, y = 0.7352,
        name = { enUS = "Tawny Grisette", deDE = "Tawny Grisette", esES = "Tawny Grisette", esMX = "Tawny Grisette", frFR = "Tawny Grisette", koKR = "타우니 그리제트", ptBR = "Clorinda Grisette", ruRU = "Шатенн Гризетт", zhCN = "塔文·格瑞斯特", zhTW = "塔文·格瑞斯特" },
    },
    {
        id = 1339, types = { "vendor-food" },
        faction = "Neutral", map = 1421, x = 0.6259, y = 0.6510,
        name = { enUS = "Dalaran Brewmaster", deDE = "Braumeister von Dalaran", esES = "Cebador Dalaran", esMX = "Maestro cervecero de Dalaran", frFR = "Brasseur de Dalaran", koKR = "달라란 양조장이", ptBR = "Mestre Cervejeiro de Dalaran", ruRU = "Даларанский пивовар", zhCN = "达拉然酿酒师", zhTW = "達拉然釀酒師" },
    },
    {
        id = 1340, types = { "vendor-food" },
        faction = "Horde", map = 1421, x = 0.4402, y = 0.3981,
        name = { enUS = "Gwyn Farrow", deDE = "Gwyn Farrow", esES = "Gwyn Paritera", esMX = "Gwyn Paritera", frFR = "Gwyn Farrow", koKR = "쥔 패로우", ptBR = "Guida Farrow", ruRU = "Гвин Фэрроу", zhCN = "格乌恩·法隆", zhTW = "格烏恩·法隆" },
    },
    {
        id = 1341, types = { "vendor-food" },
        faction = "Neutral", map = 1422, x = 0.6950, y = 0.7958,
        name = { enUS = "Baker Masterson", deDE = "Bäcker Masterson", esES = "Panadero Hijomaestro", esMX = "Panadero Hijomaestro", frFR = "Boulanger Masterson", koKR = "제빵사 마스터슨", ptBR = "Padeiro Manoel", ruRU = "Пекарь Мастерсон", zhCN = "面包师玛斯特森", zhTW = "麵包師瑪斯特森" },
    },
    {
        id = 1342, types = { "vendor-food" },
        faction = "Neutral", map = 1423, x = 0.1140, y = 0.2641,
        name = { enUS = "Augustus the Touched", deDE = "Augustus der Meschuggene", esES = "Augustus el Agraciado", esMX = "Augustus el Agraciado", frFR = "Augustus le Touché", koKR = "정신나간 아우구스투스", ptBR = "Augustus, o Pirado", ruRU = "Август Помешанный", zhCN = "被感动的奥古斯图斯", zhTW = "精神失常的奧古斯圖斯" },
    },
    {
        id = 1343, types = { "vendor-food" },
        faction = "Alliance", map = 1424, x = 0.5158, y = 0.5863,
        name = { enUS = "Barkeep Kelly", deDE = "Barkeeper Kelly", esES = "Posadero Kelly", esMX = "Posadero Kelly", frFR = "Kelly le serveur", koKR = "바텐더 켈리", ptBR = "Taberneiro Kelly", ruRU = "Кабатчик Келли", zhCN = "酒吧老板凯利", zhTW = "酒吧老闆凱利" },
    },
    {
        id = 1344, types = { "vendor-food" },
        faction = "Alliance", map = 1424, x = 0.4871, y = 0.5719,
        name = { enUS = "Bront Coldcleave", deDE = "Bront Coldcleave", esES = "Bront Friagrieta", esMX = "Bront Friagrieta", frFR = "Bront Coldcleave", koKR = "브론트 콜드클리브", ptBR = "Beto Cutilafrio", ruRU = "Бронт Ледоруб", zhCN = "布隆特·寇德克利夫", zhTW = "布隆特·寒斬" },
    },
    {
        id = 1345, types = { "vendor-food" },
        faction = "Horde", map = 1424, x = 0.6309, y = 0.1941,
        name = { enUS = "Derak Nightfall", deDE = "Derak Nightfall", esES = "Derak Ocaso", esMX = "Derak Ocaso", frFR = "Derak Nightfall", koKR = "데락 나이트폴", ptBR = "Derak Vindanoite", ruRU = "Дерек Сумерек", zhCN = "德拉克·奈特弗", zhTW = "德拉克·奈特弗" },
    },
    {
        id = 1346, types = { "vendor-food" },
        faction = "Alliance", map = 1424, x = 0.4992, y = 0.6238,
        name = { enUS = "Hal McAllister", deDE = "Hal McAllister", esES = "Hal McAllister", esMX = "Hal McAllister", frFR = "Hal McAllister", koKR = "할 맥알리스터", ptBR = "Hal McAllister", ruRU = "Хал Макаллистер", zhCN = "哈尔·马克奥里斯特", zhTW = "哈爾·馬克奧里斯特" },
    },
    {
        id = 1347, types = { "vendor-food" },
        faction = "Horde", map = 1424, x = 0.6050, y = 0.1950,
        name = { enUS = "Jason Lemieux", deDE = "Jason Lemieux", esES = "Jason Lemieux", esMX = "Jason Lemieux", frFR = "Jason Lemieux", koKR = "제이슨 레미욱스", ptBR = "Pierre Lemieux", ruRU = "Жасон Лемье", zhCN = "贾森·雷缪克斯", zhTW = "傑生·雷繆克斯" },
    },
    {
        id = 1348, types = { "vendor-food" },
        faction = "Alliance", map = 1424, x = 0.5108, y = 0.5919,
        name = { enUS = "Neema", deDE = "Neema", esES = "Neema", esMX = "Neema", frFR = "Neema", koKR = "니마", ptBR = "Nima", ruRU = "Нимей", zhCN = "尼玛", zhTW = "尼瑪" },
    },
    {
        id = 1349, types = { "vendor-food" },
        faction = "Alliance", map = 1425, x = 0.1440, y = 0.4229,
        name = { enUS = "Truk Wildbeard", deDE = "Truk Wildbeard", esES = "Truk Semperámbar", esMX = "Truk Semperámbar", frFR = "Truk Wildbeard", koKR = "트루크 와일드비어드", ptBR = "Truk Barbalouca", ruRU = "Трук Косматая Борода", zhCN = "特鲁克·蛮鬃", zhTW = "特魯克·蠻鬃" },
    },
    {
        id = 1350, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5500, y = 0.2531,
        name = { enUS = "Bimble Longberry", deDE = "Bimble Longberry", esES = "Bimble Longamora", esMX = "Bimble Longamora", frFR = "Bimble Longberry", koKR = "빔블 롱베리", ptBR = "Bimbo Longafruta", ruRU = "Бимбл Ежевичка", zhCN = "比布尔", zhTW = "比布林" },
    },
    {
        id = 1351, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.6272, y = 0.3343,
        name = { enUS = "Bruuk Barleybeard", deDE = "Bruuk Barleybeard", esES = "Bruuk Barbacebada", esMX = "Bruuk Barbacebada", frFR = "Bruuk Barleybeard", koKR = "브루크 발리비어드", ptBR = "Bruuk Cevabarba", ruRU = "Бруук Ячменобород", zhCN = "布鲁克·麦须", zhTW = "布魯克·麥鬚" },
    },
    {
        id = 1352, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.6269, y = 0.3327,
        name = { enUS = "Edris Barleybeard", deDE = "Edris Barleybeard", esES = "Edris Barbacebada", esMX = "Edris Barbacebada", frFR = "Edris Barleybeard", koKR = "에드리스 발리비어드", ptBR = "Edris Cevabarba", ruRU = "Элдрис Ячменобород", zhCN = "埃德瑞斯·麦须", zhTW = "埃德瑞斯·麥鬚" },
    },
    {
        id = 1353, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5405, y = 0.2941,
        name = { enUS = "Gwenna Firebrew", deDE = "Gwenna Firebrew", esES = "Gwenna Brebefuego", esMX = "Gwenna Brebefuego", frFR = "Gwenna Firebrew", koKR = "그웨나 파이어브루", ptBR = "Gwenna Aguardente", ruRU = "Гвенна Огневар", zhCN = "吉温娜·火酒", zhTW = "吉溫娜·火酒" },
    },
    {
        id = 1354, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5654, y = 0.3172,
        name = { enUS = "Katrina Shimmerstar", deDE = "Katrina Shimmerstar", esES = "Katrina Resplandestelar", esMX = "Katrina Resplandestelar", frFR = "Katrina Shimmerstar", koKR = "카트리나 쉼머스타", ptBR = "Katrina Brilhestrela", ruRU = "Катрина Мерцанна", zhCN = "卡提娜·闪星", zhTW = "卡翠娜·閃星" },
    },
    {
        id = 1355, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.6859, y = 0.5459,
        name = { enUS = "Kazan Mogosh", deDE = "Kazan Mogosh", esES = "Kazan Mogosh", esMX = "Kazan Mogosh", frFR = "Kazan Mogosh", koKR = "카잔 모고쉬", ptBR = "Kazan Mogosh", ruRU = "Казан Могош", zhCN = "卡杉·莫格什", zhTW = "卡杉·莫格什" },
    },
    {
        id = 1356, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.3050, y = 0.4602,
        name = { enUS = "Keeg Gibn", deDE = "Keeg Gibn", esES = "Keeg Gibn", esMX = "Keeg Gibn", frFR = "Keeg Gibn", koKR = "키그 기븐", ptBR = "Jado Cerver", ruRU = "Бочко Клинн", zhCN = "基格·吉布恩", zhTW = "基格·吉布恩" },
    },
    {
        id = 1357, types = { "vendor-food" },
        faction = "Neutral", map = 1426, x = 0.5646, y = 0.3197,
        name = { enUS = "Macey Jinglepocket", deDE = "Macey Jinglepocket", esES = "Macey Calderilla", esMX = "Macey Calderilla", frFR = "Macey Jinglepocket", koKR = "메이시 징글포켓", ptBR = "Renna \"Dindim\" Goubel", ruRU = "Дольча Деньгозвон", zhCN = "麦希", zhTW = "麥希" },
    },
    {
        id = 1358, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5584, y = 0.3193,
        name = { enUS = "Myra Tyrngaarde", deDE = "Myra Tyrngaarde", esES = "Myra Tyrngaarde", esMX = "Myra Tyrngaarde", frFR = "Myra Tyrngaarde", koKR = "마이라 티른가르데", ptBR = "Mira Tingaarde", ruRU = "Мира Тирнгаарде", zhCN = "米拉·泰恩加德", zhTW = "米拉·泰恩加德" },
    },
    {
        id = 1359, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.6033, y = 0.3375,
        name = { enUS = "Sognar Cliffbeard", deDE = "Sognar Cliffbeard", esES = "Sognar Barbarrisco", esMX = "Sognar Barbarrisco", frFR = "Sognar Cliffbeard", koKR = "소그나르 클리프비어드", ptBR = "Sognar Barbapenha", ruRU = "Согнар Скалобород", zhCN = "索戈纳尔·硬须", zhTW = "索戈納爾·硬鬚" },
    },
    {
        id = 1360, types = { "vendor-food" },
        faction = "Alliance", map = 1426, x = 0.5901, y = 0.2608,
        name = { enUS = "Sraaz", deDE = "Sraaz", esES = "Sraaz", esMX = "Sraaz", frFR = "Sraaz", koKR = "스라즈", ptBR = "Siraaz", ruRU = "Шрааз", zhCN = "斯拉兹", zhTW = "斯拉茲" },
    },
    {
        id = 1361, types = { "vendor-food" },
        faction = "Alliance", map = 1428, x = 0.8421, y = 0.6780,
        name = { enUS = "Gabrielle Chase", deDE = "Gabrielle Chase", esES = "Gabrielle Persequín", esMX = "Gabrielle Persequín", frFR = "Gabrielle Chase", koKR = "가브리엘 체이스", ptBR = "Gabriela Caniço", ruRU = "Габриэлла Чейз", zhCN = "加布雷·凯斯", zhTW = "加布雷·凱斯" },
    },
    {
        id = 1362, types = { "vendor-food" },
        faction = "Horde", map = 1428, x = 0.6568, y = 0.2388,
        name = { enUS = "Gruna", deDE = "Gruna", esES = "Gruna", esMX = "Gruna", frFR = "Gruna", koKR = "그루나", ptBR = "Gruna", ruRU = "Груна", zhCN = "格鲁纳", zhTW = "格魯納" },
    },
    {
        id = 1363, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4401, y = 0.6569,
        name = { enUS = "Barkeep Dobbins", deDE = "Barkeeper Dobbins", esES = "Posadero Dobbins", esMX = "Posadero Dobbins", frFR = "Dobbins le tavernier", koKR = "바텐더 도빈스", ptBR = "Taberneiro Dúbius", ruRU = "Кабатчик Доббинз", zhCN = "酒吧老板杜宾斯", zhTW = "酒吧老闆杜賓斯" },
    },
    {
        id = 1364, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.3371, y = 0.8291,
        name = { enUS = "Homer Stonefield", deDE = "Homer Stonefield", esES = "Homer Pedregosa", esMX = "Homer Pedregosa", frFR = "Homer Stonefield", koKR = "호머 스톤필드", ptBR = "Homer Campedra", ruRU = "Хомер Стоунфилд", zhCN = "霍莫尔·斯通菲尔德", zhTW = "霍莫爾·斯通菲爾德" },
    },
    {
        id = 1365, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4239, y = 0.8942,
        name = { enUS = "Joshua Maclure", deDE = "Joshua Maclure", esES = "Joshua Maclure", esMX = "Joshua Maclure", frFR = "Joshua Maclure", koKR = "조슈아 맥클루어", ptBR = "Josué Madruga", ruRU = "Джошуа Маклюр", zhCN = "乔舒·马科伦", zhTW = "喬舒·馬科倫" },
    },
    {
        id = 1366, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4246, y = 0.6605,
        name = { enUS = "Kira Songshine", deDE = "Kira Songshine", esES = "Kira Cántico", esMX = "Kira Cántico", frFR = "Kira Songshine", koKR = "키라 송샤인", ptBR = "Kira Brilhavoz", ruRU = "Кира Солнцепесня", zhCN = "基拉·桑塞恩", zhTW = "基拉·桑塞恩" },
    },
    {
        id = 1367, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4508, y = 0.6897,
        name = { enUS = "Kira Songshine", deDE = "Kira Songshine", esES = "Kira Cántico", esMX = "Kira Cántico", frFR = "Kira Songshine", koKR = "키라 송샤인", ptBR = "Kira Brilhavoz", ruRU = "Кира Солнцепесня", zhCN = "基拉·桑塞恩", zhTW = "基拉·桑塞恩" },
    },
    {
        id = 1368, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.2411, y = 0.7318,
        name = { enUS = "Sergeant De Vries", deDE = "Sergeant De Vries", esES = "Sargento De Vries", esMX = "Sargento De Vries", frFR = "Sergent De Vries", koKR = "하사관 드 브라이스", ptBR = "Sargento De Vries", ruRU = "Сержант де Врайс", zhCN = "德·维里斯中士", zhTW = "德·維里斯中士" },
    },
    {
        id = 1369, types = { "vendor-food" },
        faction = "Neutral", map = 1429, x = 0.4220, y = 0.7018,
        name = { enUS = "Stamp Thunderhorn", deDE = "Stamp Thunderhorn", esES = "Stamp Tronacuerno", esMX = "Stamp Tronacuerno", frFR = "Stamp Thunderhorn", koKR = "스탬프 썬더혼", ptBR = "Pisão Chifre Troante", ruRU = "Стомп Громовой Рог", zhCN = "斯塔姆·雷角", zhTW = "史丹普·雷角" },
    },
    {
        id = 1370, types = { "vendor-food" },
        faction = "Neutral", map = 1429, x = 0.4220, y = 0.7012,
        name = { enUS = "Sylannia", deDE = "Sylannia", esES = "Sylannia", esMX = "Sylannia", frFR = "Sylannia", koKR = "실라니아", ptBR = "Sylannia", ruRU = "Силанния", zhCN = "塞兰妮亚", zhTW = "希拉妮雅" },
    },
    {
        id = 1371, types = { "vendor-food" },
        faction = "Alliance", map = 1429, x = 0.4420, y = 0.6598,
        name = { enUS = "Toddrick", deDE = "Toddrick", esES = "Toddrick", esMX = "Toddrick", frFR = "Toddrick", koKR = "토드릭", ptBR = "Toddrick", ruRU = "Тоддрик", zhCN = "托德瑞克", zhTW = "陶德瑞克" },
    },
    {
        id = 1372, types = { "vendor-food" },
        faction = "Alliance", map = 1431, x = 0.7368, y = 0.4396,
        name = { enUS = "Barkeep Hann", deDE = "Barkeeper Hann", esES = "Posadero Hann", esMX = "Posadero Hann", frFR = "Hann le tavernier", koKR = "바텐더 한", ptBR = "Taberneiro Ramos", ruRU = "Кабатчик Ханн", zhCN = "酒吧老板汉恩", zhTW = "酒吧老闆漢恩" },
    },
    {
        id = 1373, types = { "vendor-food" },
        faction = "Alliance", map = 1431, x = 0.7580, y = 0.4870,
        name = { enUS = "Scott Carevin", deDE = "Scott Carevin", esES = "Scott Carevin", esMX = "Scott Carevin", frFR = "Scott Carevin", koKR = "스코트 카레빈", ptBR = "Sandro Carevino", ruRU = "Скотт Карвин", zhCN = "斯考特·卡尔文", zhTW = "斯考特·卡爾文" },
    },
    {
        id = 1374, types = { "vendor-food" },
        faction = "Alliance", map = 1432, x = 0.2555, y = 0.1183,
        name = { enUS = "Greishan Ironstove", deDE = "Greishan Ironstove", esES = "Greishan Calefacero", esMX = "Greishan Calefacero", frFR = "Greishan Ironstove", koKR = "그레이샨 아이언스토브", ptBR = "Greishan Fornoferro", ruRU = "Грейшан Железная Печь", zhCN = "格雷珊·铁炉", zhTW = "格雷珊·鐵爐" },
    },
    {
        id = 1375, types = { "vendor-food" },
        faction = "Alliance", map = 1432, x = 0.3431, y = 0.4743,
        name = { enUS = "Greishan Ironstove", deDE = "Greishan Ironstove", esES = "Greishan Calefacero", esMX = "Greishan Calefacero", frFR = "Greishan Ironstove", koKR = "그레이샨 아이언스토브", ptBR = "Greishan Fornoferro", ruRU = "Грейшан Железная Печь", zhCN = "格雷珊·铁炉", zhTW = "格雷珊·鐵爐" },
    },
    {
        id = 1376, types = { "vendor-food" },
        faction = "Alliance", map = 1432, x = 0.3532, y = 0.4968,
        name = { enUS = "Honni Goldenoat", deDE = "Honni Goldenoat", esES = "Honni Avenaurea", esMX = "Honni Avenaurea", frFR = "Honni Goldenoat", koKR = "호니 골든오트", ptBR = "Honni Douravena", ruRU = "Хонни Златозерная", zhCN = "霍尼·金麦", zhTW = "霍尼·金麥" },
    },
    {
        id = 1377, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.2162, y = 0.4390,
        name = { enUS = "Bartender Wental", deDE = "Schankkellner Wental", esES = "Posadero Wental", esMX = "Posadero Wental", frFR = "Wental le tavernier", koKR = "바텐더 웬탈", ptBR = "Garçom Wental", ruRU = "Бармен Вентель", zhCN = "调酒师温塔尔", zhTW = "調酒師溫塔爾" },
    },
    {
        id = 1378, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1782, y = 0.4427,
        name = { enUS = "Gretchen Vogel", deDE = "Gretchen Vogel", esES = "Gretchen Vogel", esMX = "Gretchen Vogel", frFR = "Gretchen Vogel", koKR = "그레첸 보겔", ptBR = "Gretchen Vogel", ruRU = "Гретхен Фогель", zhCN = "格雷彻·沃格尔", zhTW = "格雷徹·沃格爾" },
    },
    {
        id = 1379, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.0911, y = 0.6941,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1380, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1036, y = 0.7380,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1381, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1044, y = 0.7300,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1382, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1048, y = 0.7180,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1383, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1059, y = 0.7222,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1384, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1060, y = 0.7149,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1385, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1069, y = 0.7253,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1386, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1074, y = 0.7256,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1387, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1077, y = 0.7270,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1388, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1081, y = 0.7246,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1389, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1110, y = 0.7292,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1390, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1118, y = 0.7298,
        name = { enUS = "Kalsey Sanden", deDE = "Kalsey Sanden", esES = "Kalsey Sanden", esMX = "Kalsey Sanden", frFR = "Kalsey Sanden", koKR = "Kalsey Sanden", ptBR = "Kalsey Sanden", ruRU = "Kalsey Sanden", zhCN = "Kalsey Sanden", zhTW = "Kalsey Sanden" },
    },
    {
        id = 1391, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.1597, y = 0.4620,
        name = { enUS = "Lamar Veisilli", deDE = "Lamar Veisilli", esES = "Lamar Veisilli", esMX = "Lamar Veisilli", frFR = "Lamar Veisilli", koKR = "라마 베이질리", ptBR = "Lamar Veisilli", ruRU = "Ламар Вейсилли", zhCN = "拉玛尔·维斯利", zhTW = "拉瑪爾·維斯利" },
    },
    {
        id = 1392, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.2162, y = 0.4317,
        name = { enUS = "Sherman Femmel", deDE = "Sherman Femmel", esES = "Sherman Femmel", esMX = "Sherman Femmel", frFR = "Sherman Femmel", koKR = "셔먼 펌멜", ptBR = "Sherman Femmel", ruRU = "Шерман Даммель", zhCN = "谢尔曼·菲米尔", zhTW = "謝爾曼·菲米爾" },
    },
    {
        id = 1393, types = { "vendor-food" },
        faction = "Alliance", map = 1433, x = 0.2242, y = 0.4777,
        name = { enUS = "Vernon Hale", deDE = "Vernon Hale", esES = "Vernon Sano", esMX = "Vernon Sano", frFR = "Vernon Hale", koKR = "버논 헤일", ptBR = "Vernon Hale", ruRU = "Вернон Здоровяк", zhCN = "沃农·黑尔", zhTW = "沃農·黑爾" },
    },
    {
        id = 1394, types = { "vendor-food" },
        faction = "Neutral", map = 1434, x = 0.2823, y = 0.7434,
        name = { enUS = "Kelsey Yance", deDE = "Kelsey Yance", esES = "Kelsey Yance", esMX = "Kelsey Yance", frFR = "Kelsey Yance", koKR = "켈시 얀스", ptBR = "Kelsey Yance", ruRU = "Келси Янс", zhCN = "凯尔希·杨斯", zhTW = "凱爾希·楊斯" },
    },
    {
        id = 1395, types = { "vendor-food" },
        faction = "Horde", map = 1434, x = 0.3219, y = 0.2929,
        name = { enUS = "Nargatt", deDE = "Nargatt", esES = "Nargatt", esMX = "Nargatt", frFR = "Nargatt", koKR = "나르가트", ptBR = "Nargatt", ruRU = "Наргатт", zhCN = "纳加特", zhTW = "納加特" },
    },
    {
        id = 1396, types = { "vendor-food" },
        faction = "Neutral", map = 1434, x = 0.2701, y = 0.7721,
        name = { enUS = "Nixxrax Fillamug", deDE = "Nixxrax Fillamug", esES = "Nixxrax Vasolleno", esMX = "Nixxrax Vasolleno", frFR = "Nixxrax Fillamug", koKR = "닉스락스 필라머그", ptBR = "Nixxrax Enchecopo", ruRU = "Никсраз Наливайка", zhCN = "尼克拉克斯·菲拉莫格", zhTW = "尼克拉克斯·菲拉莫格" },
    },
    {
        id = 1397, types = { "vendor-food" },
        faction = "Horde", map = 1435, x = 0.4649, y = 0.5427,
        name = { enUS = "Thultash", deDE = "Thultash", esES = "Thultash", esMX = "Thultash", frFR = "Thultash", koKR = "툴타쉬", ptBR = "Thultash", ruRU = "Тулташ", zhCN = "索尔塔什", zhTW = "索爾塔什" },
    },
    {
        id = 1398, types = { "vendor-food" },
        faction = "Alliance", map = 1436, x = 0.5602, y = 0.3120,
        name = { enUS = "Farmer Saldean", deDE = "Bauer Saldean", esES = "Granjero Saldean", esMX = "Granjero Saldean", frFR = "Saldean le fermier", koKR = "농부 살딘", ptBR = "Fazendeiro Saldanha", ruRU = "Фермер Сальден", zhCN = "农夫萨丁", zhTW = "農夫薩丁" },
    },
    {
        id = 1399, types = { "vendor-food" },
        faction = "Alliance", map = 1436, x = 0.5781, y = 0.5371,
        name = { enUS = "Mike Miller", deDE = "Mike Miller", esES = "Mike Molina", esMX = "Mike Molina", frFR = "Mike Miller", koKR = "마이크 밀러", ptBR = "Mike Miller", ruRU = "Майк Миллер", zhCN = "迈克·米勒", zhTW = "邁克·米勒" },
    },
    {
        id = 1400, types = { "vendor-food" },
        map = 1437, x = 0.5272, y = 0.7948,
        name = { enUS = "Aurian Highgrove", deDE = "Aurian Highgrove", esES = "Aurian Highgrove", esMX = "Aurian Highgrove", frFR = "Aurian Highgrove", koKR = "Aurian Highgrove", ptBR = "Aurian Highgrove", ruRU = "Aurian Highgrove", zhCN = "Aurian Highgrove", zhTW = "Aurian Highgrove" },
    },
    {
        id = 1401, types = { "vendor-food" },
        map = 1437, x = 0.5273, y = 0.8034,
        name = { enUS = "Aurian Highgrove", deDE = "Aurian Highgrove", esES = "Aurian Highgrove", esMX = "Aurian Highgrove", frFR = "Aurian Highgrove", koKR = "Aurian Highgrove", ptBR = "Aurian Highgrove", ruRU = "Aurian Highgrove", zhCN = "Aurian Highgrove", zhTW = "Aurian Highgrove" },
    },
    {
        id = 1402, types = { "vendor-food" },
        map = 1437, x = 0.5225, y = 0.7862,
        name = { enUS = "Bhalir Firebrew", deDE = "Bhalir Firebrew", esES = "Bhalir Firebrew", esMX = "Bhalir Firebrew", frFR = "Bhalir Firebrew", koKR = "Bhalir Firebrew", ptBR = "Bhalir Firebrew", ruRU = "Bhalir Firebrew", zhCN = "Bhalir Firebrew", zhTW = "Bhalir Firebrew" },
    },
    {
        id = 1403, types = { "vendor-food" },
        map = 1437, x = 0.5283, y = 0.8017,
        name = { enUS = "Bhalir Firebrew", deDE = "Bhalir Firebrew", esES = "Bhalir Firebrew", esMX = "Bhalir Firebrew", frFR = "Bhalir Firebrew", koKR = "Bhalir Firebrew", ptBR = "Bhalir Firebrew", ruRU = "Bhalir Firebrew", zhCN = "Bhalir Firebrew", zhTW = "Bhalir Firebrew" },
    },
    {
        id = 1404, types = { "vendor-food" },
        map = 1437, x = 0.5292, y = 0.8016,
        name = { enUS = "Bhalir Firebrew", deDE = "Bhalir Firebrew", esES = "Bhalir Firebrew", esMX = "Bhalir Firebrew", frFR = "Bhalir Firebrew", koKR = "Bhalir Firebrew", ptBR = "Bhalir Firebrew", ruRU = "Bhalir Firebrew", zhCN = "Bhalir Firebrew", zhTW = "Bhalir Firebrew" },
    },
    {
        id = 1405, types = { "vendor-food" },
        map = 1437, x = 0.5293, y = 0.8006,
        name = { enUS = "Bhalir Firebrew", deDE = "Bhalir Firebrew", esES = "Bhalir Firebrew", esMX = "Bhalir Firebrew", frFR = "Bhalir Firebrew", koKR = "Bhalir Firebrew", ptBR = "Bhalir Firebrew", ruRU = "Bhalir Firebrew", zhCN = "Bhalir Firebrew", zhTW = "Bhalir Firebrew" },
    },
    {
        id = 1406, types = { "vendor-food" },
        map = 1437, x = 0.5312, y = 0.8024,
        name = { enUS = "Bhalir Firebrew", deDE = "Bhalir Firebrew", esES = "Bhalir Firebrew", esMX = "Bhalir Firebrew", frFR = "Bhalir Firebrew", koKR = "Bhalir Firebrew", ptBR = "Bhalir Firebrew", ruRU = "Bhalir Firebrew", zhCN = "Bhalir Firebrew", zhTW = "Bhalir Firebrew" },
    },
    {
        id = 1407, types = { "vendor-food" },
        faction = "Alliance", map = 1437, x = 0.1060, y = 0.6077,
        name = { enUS = "Mikhail", deDE = "Mikhail", esES = "Mikhail", esMX = "Mikhail", frFR = "Mikhail", koKR = "미크헤일", ptBR = "Mikhail", ruRU = "Михаил", zhCN = "米克哈尔", zhTW = "米克哈爾" },
    },
    {
        id = 1408, types = { "vendor-food" },
        faction = "Alliance", map = 1438, x = 0.5541, y = 0.5718,
        name = { enUS = "Danlyia", deDE = "Danlyia", esES = "Danlyia", esMX = "Danlyia", frFR = "Danlyia", koKR = "단리아", ptBR = "Danlyia", ruRU = "Данлия", zhCN = "丹利亚", zhTW = "丹利亞" },
    },
    {
        id = 1409, types = { "vendor-food" },
        faction = "Alliance", map = 1438, x = 0.5960, y = 0.4072,
        name = { enUS = "Dellylah", deDE = "Dellylah", esES = "Dellylah", esMX = "Dellylah", frFR = "Dellylah", koKR = "델리라", ptBR = "Delailah", ruRU = "Деллия", zhCN = "德林拉尔", zhTW = "德林拉爾" },
    },
    {
        id = 1410, types = { "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.3709, y = 0.4360,
        name = { enUS = "Allyndia", deDE = "Allyndia", esES = "Allyndia", esMX = "Allyndia", frFR = "Allyndia", koKR = "알린디아", ptBR = "Allyndia", ruRU = "Аллиндия", zhCN = "奥林迪雅", zhTW = "奧林迪雅" },
    },
    {
        id = 1411, types = { "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.3689, y = 0.4461,
        name = { enUS = "Kyndri", deDE = "Kyndri", esES = "Kyndri", esMX = "Kyndri", frFR = "Kyndri", koKR = "킨드리", ptBR = "Kyndri", ruRU = "Киндри", zhCN = "凯恩迪", zhTW = "凱恩迪" },
    },
    {
        id = 1412, types = { "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.3681, y = 0.4431,
        name = { enUS = "Laird", deDE = "Laird", esES = "Laird", esMX = "Laird", frFR = "Laird", koKR = "레어드", ptBR = "Laird", ruRU = "Лайрд", zhCN = "莱尔德", zhTW = "賴爾德" },
    },
    {
        id = 1413, types = { "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.3681, y = 0.4391,
        name = { enUS = "Taldan", deDE = "Taldan", esES = "Taldan", esMX = "Taldan", frFR = "Taldan", koKR = "탈단", ptBR = "Taldan", ruRU = "Тальдан", zhCN = "塔尔丹", zhTW = "塔爾丹" },
    },
    {
        id = 1414, types = { "vendor-food" },
        faction = "Alliance", map = 1439, x = 0.4371, y = 0.7661,
        name = { enUS = "Tiyani", deDE = "Tiyani", esES = "Tiyani", esMX = "Tiyani", frFR = "Tiyani", koKR = "티야니", ptBR = "Tiyani", ruRU = "Тиани", zhCN = "提亚尼", zhTW = "提亞尼" },
    },
    {
        id = 1415, types = { "vendor-food" },
        faction = "Neutral", map = 1440, x = 0.6210, y = 0.8279,
        name = { enUS = "Gapp Jinglepocket", deDE = "Gapp Jinglepocket", esES = "Gapp Calderilla", esMX = "Gapp Calderilla", frFR = "Gapp Jinglepocket", koKR = "개프 징글포켓", ptBR = "Gapp \"Dindim\" Goubel", ruRU = "Хьюг Деньгозвон", zhCN = "加普·吉波克", zhTW = "加普·響囊" },
    },
    {
        id = 1416, types = { "vendor-food" },
        faction = "Alliance", map = 1440, x = 0.3660, y = 0.5001,
        name = { enUS = "Maliynn", deDE = "Maliynn", esES = "Maliynn", esMX = "Maliynn", frFR = "Maliynn", koKR = "말리인", ptBR = "Maliynn", ruRU = "Майлинн", zhCN = "玛琳", zhTW = "瑪琳" },
    },
    {
        id = 1417, types = { "vendor-food" },
        faction = "Alliance", map = 1440, x = 0.3711, y = 0.4991,
        name = { enUS = "Nantar", deDE = "Nantar", esES = "Nantar", esMX = "Nantar", frFR = "Nantar", koKR = "라르단", ptBR = "Nantar", ruRU = "Нантар", zhCN = "娜塔", zhTW = "娜塔" },
    },
    {
        id = 1418, types = { "vendor-food" },
        faction = "Alliance", map = 1440, x = 0.4999, y = 0.6659,
        name = { enUS = "Ulthaan", deDE = "Ulthaan", esES = "Ulthaan", esMX = "Ulthaan", frFR = "Ulthaan", koKR = "울샨", ptBR = "Ulthaan", ruRU = "Ультаан", zhCN = "尤萨恩", zhTW = "尤薩恩" },
    },
    {
        id = 1419, types = { "vendor-food" },
        faction = "Neutral", map = 1441, x = 0.7730, y = 0.7700,
        name = { enUS = "Brivelthwerp", deDE = "Brivelthwerp", esES = "Bridatuer", esMX = "Bridatuer", frFR = "Brivelthwerp", koKR = "브리벨스웰프", ptBR = "Pena Tabwa", ruRU = "Бривельверп", zhCN = "布里维普", zhTW = "布里維普" },
    },
    {
        id = 1420, types = { "vendor-food" },
        faction = "Horde", map = 1441, x = 0.2109, y = 0.3191,
        name = { enUS = "Laer Stepperunner", deDE = "Laer Stepperunner", esES = "Laer Pasorredor", esMX = "Laer Pasorredor", frFR = "Laer Stepperunner", koKR = "래어 스태퍼러너", ptBR = "Laer Corre Estepes", ruRU = "Лаэр Степной Гонец", zhCN = "莱尔·台地行者", zhTW = "賴爾·臺地行者" },
    },
    {
        id = 1421, types = { "vendor-food" },
        faction = "Neutral", map = 1441, x = 0.8000, y = 0.7618,
        name = { enUS = "Riznek", deDE = "Riznek", esES = "Riznek", esMX = "Riznek", frFR = "Riznek", koKR = "리즈넥", ptBR = "Riznek", ruRU = "Ризнек", zhCN = "瑞兹尼克", zhTW = "瑞茲尼克" },
    },
    {
        id = 1422, types = { "vendor-food" },
        faction = "Horde", map = 1441, x = 0.4539, y = 0.5118,
        name = { enUS = "Turhaw", deDE = "Turhaw", esES = "Turhaw", esMX = "Turhaw", frFR = "Turhaw", koKR = "투르하우", ptBR = "Turhaw", ruRU = "Турхо", zhCN = "图尔赫", zhTW = "圖爾赫" },
    },
    {
        id = 1423, types = { "vendor-food" },
        faction = "Horde", map = 1442, x = 0.7359, y = 0.9539,
        name = { enUS = "Denni'ka", deDE = "Denni'ka", esES = "Denni'ka", esMX = "Denni'ka", frFR = "Denni'ka", koKR = "덴니카", ptBR = "Denni'ka", ruRU = "Денни'ка", zhCN = "德尼卡", zhTW = "德尼卡" },
    },
    {
        id = 1424, types = { "vendor-food" },
        faction = "Horde", map = 1442, x = 0.4621, y = 0.5841,
        name = { enUS = "Krond", deDE = "Krond", esES = "Krond", esMX = "Krond", frFR = "Krond", koKR = "크론드", ptBR = "Krond", ruRU = "Кронд", zhCN = "克隆德", zhTW = "克隆德" },
    },
    {
        id = 1425, types = { "vendor-food" },
        faction = "Horde", map = 1443, x = 0.5119, y = 0.5328,
        name = { enUS = "Harnor", deDE = "Harnor", esES = "Harnor", esMX = "Harnor", frFR = "Harnor", koKR = "하노르", ptBR = "Harnor", ruRU = "Харнор", zhCN = "哈诺尔", zhTW = "哈諾爾" },
    },
    {
        id = 1426, types = { "vendor-food" },
        faction = "Alliance", map = 1443, x = 0.6619, y = 0.0659,
        name = { enUS = "Janet Hommers", deDE = "Janet Hommers", esES = "Janet Hommers", esMX = "Janet Hommers", frFR = "Janet Hommers", koKR = "자넷 호머스", ptBR = "Janete Horto", ruRU = "Джанет Хоммерс", zhCN = "詹奈特·霍莫斯", zhTW = "詹奈特·霍莫斯" },
    },
    {
        id = 1427, types = { "vendor-food" },
        faction = "Alliance", map = 1444, x = 0.3101, y = 0.4630,
        name = { enUS = "Harklane", deDE = "Harklane", esES = "Harklane", esMX = "Harklane", frFR = "Harklane", koKR = "할크라네", ptBR = "Harklane", ruRU = "Харклан", zhCN = "哈克莱恩", zhTW = "哈克萊恩" },
    },
    {
        id = 1428, types = { "vendor-food" },
        faction = "Horde", map = 1444, x = 0.7550, y = 0.4391,
        name = { enUS = "Loorana", deDE = "Loorana", esES = "Loorana", esMX = "Loorana", frFR = "Loorana", koKR = "루라나", ptBR = "Luurana", ruRU = "Лурана", zhCN = "罗拉娜", zhTW = "羅拉娜" },
    },
    {
        id = 1429, types = { "vendor-food" },
        faction = "Alliance", map = 1444, x = 0.3101, y = 0.4311,
        name = { enUS = "Mardrack Greenwell", deDE = "Mardrack Greenwell", esES = "Mardrack Fonverde", esMX = "Mardrack Fonverde", frFR = "Mardrack Greenwell", koKR = "말드랙 그린웰", ptBR = "Mardrack Fonteverde", ruRU = "Мардрак Зеленый Источник", zhCN = "玛德拉克·绿井", zhTW = "瑪德拉克·綠井" },
    },
    {
        id = 1430, types = { "vendor-food" },
        faction = "Alliance", map = 1445, x = 0.6671, y = 0.4518,
        name = { enUS = "Bartender Lillian", deDE = "Schankkellnerin Lillian", esES = "Posadero Lillian", esMX = "Posadero Lillian", frFR = "Tavernière Lillian", koKR = "바텐더 릴리안", ptBR = "Taberneira Lillian", ruRU = "Барменша Лилиан", zhCN = "调酒师莉莉安", zhTW = "調酒師莉莉安" },
    },
    {
        id = 1431, types = { "vendor-food" },
        faction = "Alliance", map = 1445, x = 0.6689, y = 0.4530,
        name = { enUS = "Craig Nollward", deDE = "Craig Nollward", esES = "Craig Guardanol", esMX = "Craig Guardanol", frFR = "Craig Nollward", koKR = "크레이크 놀워드", ptBR = "Carlos Noronha", ruRU = "Крейг Ноллавард", zhCN = "克莱格·诺瓦德", zhTW = "克萊格·諾瓦德" },
    },
    {
        id = 1432, types = { "vendor-food" },
        faction = "Alliance", map = 1445, x = 0.6821, y = 0.4731,
        name = { enUS = "Dwane Wertle", deDE = "Dwane Wertle", esES = "Dwane Wertle", esMX = "Dwane Wertle", frFR = "Dwane Wertle", koKR = "드웨인 워틀", ptBR = "Danielle Lopez", ruRU = "Двейн Вертль", zhCN = "瓦恩·沃特尔", zhTW = "瓦恩·沃特爾" },
    },
    {
        id = 1433, types = { "vendor-food" },
        faction = "Horde", map = 1445, x = 0.3669, y = 0.3101,
        name = { enUS = "Ogg'marr", deDE = "Ogg'marr", esES = "Ogg'marr", esMX = "Ogg'marr", frFR = "Ogg'marr", koKR = "오그마르", ptBR = "Ogg'marr", ruRU = "Огг'марр", zhCN = "奥克玛尔", zhTW = "奧克瑪爾" },
    },
    {
        id = 1434, types = { "vendor-food" },
        faction = "Neutral", map = 1446, x = 0.5260, y = 0.2811,
        name = { enUS = "Dirge Quikcleave", deDE = "Dirge Quikcleave", esES = "Dirge Hojágil", esMX = "Dirge Hojágil", frFR = "Dirge Quikcleave", koKR = "더지 퀵클레이브", ptBR = "Funesto Marrão", ruRU = "Могиль Быстроруб", zhCN = "迪尔格·奎克里弗", zhTW = "戴格·迅斬" },
    },
    {
        id = 1435, types = { "vendor-food" },
        faction = "Horde", map = 1447, x = 0.2180, y = 0.5210,
        name = { enUS = "Kurll", deDE = "Kurll", esES = "Kurll", esMX = "Kurll", frFR = "Kurll", koKR = "쿠를", ptBR = "Korll", ruRU = "Курлл", zhCN = "库尔", zhTW = "克爾" },
    },
    {
        id = 1436, types = { "vendor-food" },
        faction = "Neutral", map = 1450, x = 0.4893, y = 0.3921,
        name = { enUS = "Dargon", deDE = "Dargon", esES = "Dargon", esMX = "Dargon", frFR = "Dargon", koKR = "다르곤", ptBR = "Dargon", ruRU = "Даргон", zhCN = "达尔贡", zhTW = "達爾貢" },
    },
    {
        id = 1437, types = { "vendor-food" },
        faction = "Neutral", map = 1450, x = 0.4448, y = 0.3393,
        name = { enUS = "My'lanna", deDE = "My'lanna", esES = "My'lanna", esMX = "My'lanna", frFR = "My'lanna", koKR = "밀란나", ptBR = "My'lanna", ruRU = "Ми'ланна", zhCN = "麦兰娜", zhTW = "麥蘭娜" },
    },
    {
        id = 1438, types = { "vendor-food" },
        faction = "Neutral", map = 1451, x = 0.5248, y = 0.3859,
        name = { enUS = "Garon Hutchins", deDE = "Garon Hutchins", esES = "Garon Hutchins", esMX = "Garon Hutchins", frFR = "Garon Hutchins", koKR = "가론 허친스", ptBR = "Garon Hutchins", ruRU = "Гарон Хатчинс", zhCN = "加隆·哈金斯", zhTW = "卡隆·海金斯" },
    },
    {
        id = 1439, types = { "vendor-food" },
        faction = "Neutral", map = 1452, x = 0.6131, y = 0.3921,
        name = { enUS = "Himmik", deDE = "Himmik", esES = "Himmik", esMX = "Himmik", frFR = "Himmik", koKR = "힘믹", ptBR = "Himmik", ruRU = "Химмик", zhCN = "西米克", zhTW = "西米克" },
    },
    {
        id = 1440, types = { "vendor-food" },
        faction = "Alliance", map = 1452, x = 0.5199, y = 0.2930,
        name = { enUS = "Lyranne Feathersong", deDE = "Lyranne Feathersong", esES = "Lyranne Melopluma", esMX = "Lyranne Melopluma", frFR = "Lyranne Feathersong", koKR = "라이란 페더송", ptBR = "Lyranne Plumacanto", ruRU = "Лиренна Песнь Пера", zhCN = "琳妮·梅", zhTW = "琳妮·羽歌" },
    },
    {
        id = 1441, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6639, y = 0.7345,
        name = { enUS = "Ben Trias", deDE = "Ben Trias", esES = "Ben Trias", esMX = "Ben Trias", frFR = "Ben Trias", koKR = "벤 트리아스", ptBR = "Ben Trias", ruRU = "Бен Триас", zhCN = "本·提亚斯", zhTW = "本·提亞斯" },
    },
    {
        id = 1442, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6662, y = 0.7345,
        name = { enUS = "Elaine Trias", deDE = "Elaine Trias", esES = "Elaine Trias", esMX = "Elaine Trias", frFR = "Elaine Trias", koKR = "일레인 트리아스", ptBR = "Elaine Trias", ruRU = "Илана Триас", zhCN = "伊莱恩·提亚斯", zhTW = "伊萊恩·提亞斯" },
    },
    {
        id = 1443, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.7652, y = 0.5435,
        name = { enUS = "Elly Langston", deDE = "Elly Langston", esES = "Elly Langston", esMX = "Elly Langston", frFR = "Elly Langston", koKR = "엘리 랭스턴", ptBR = "Eliane Lamego", ruRU = "Элли Лангстон", zhCN = "艾丽·朗斯顿", zhTW = "艾麗·朗斯頓" },
    },
    {
        id = 1444, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6133, y = 0.7495,
        name = { enUS = "Emmithue Smails", deDE = "Emmithue Smails", esES = "Emmitue Sonriasu", esMX = "Emmitue Sonriasu", frFR = "Emmithue Smails", koKR = "에미수 스메일스", ptBR = "Emmithue Smails", ruRU = "Эммет Хохм", zhCN = "艾米苏·斯麦尔", zhTW = "艾米蘇·斯麥爾" },
    },
    {
        id = 1445, types = { "vendor-food" },
        faction = "Neutral", map = 1453, x = 0.6240, y = 0.7011,
        name = { enUS = "Guchie Jinglepocket", deDE = "Guchie Jinglepocket", esES = "Guchie Calderilla", esMX = "Guchie Calderilla", frFR = "Guchie Jinglepocket", koKR = "구키 징글포켓", ptBR = "Guccie \"Dindim\" Goubel", ruRU = "Гуча Деньгозвон", zhCN = "古奇", zhTW = "古奇" },
    },
    {
        id = 1446, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.4199, y = 0.8266,
        name = { enUS = "Jarel Moor", deDE = "Jarel Moor", esES = "Jarel Moor", esMX = "Jarel Moor", frFR = "Jarel Moor", koKR = "야렐 무어", ptBR = "Jardel Outeiros", ruRU = "Джарел Мур", zhCN = "扎雷·穆尔", zhTW = "札雷·莫爾" },
    },
    {
        id = 1447, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.5143, y = 0.9406,
        name = { enUS = "Joachim Brenlow", deDE = "Joachim Brenlow", esES = "Joachim Brenlow", esMX = "Joachim Brenlow", frFR = "Joachim Brenlow", koKR = "요아킴 브렌로우", ptBR = "Joaquim Breno", ruRU = "Иохим Бренлоу", zhCN = "扎希姆·布伦罗", zhTW = "札希姆·布倫羅" },
    },
    {
        id = 1448, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.5987, y = 0.7771,
        name = { enUS = "Julia Gallina", deDE = "Julia Gallina", esES = "Julia Gallina", esMX = "Julia Gallina", frFR = "Julia Gallina", koKR = "줄리아 갈리나", ptBR = "Julia Callina", ruRU = "Джулия Галлина", zhCN = "朱莉安·加林纳", zhTW = "朱莉安·加林納" },
    },
    {
        id = 1449, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.3719, y = 0.7426,
        name = { enUS = "Liv Bradford", deDE = "Liv Bradford", esES = "Liv Bradford", esMX = "Liv Bradford", frFR = "Liv Bradford", koKR = "Liv Bradford", ptBR = "Liv Bradford", ruRU = "Liv Bradford", zhCN = "Liv Bradford", zhTW = "Liv Bradford" },
    },
    {
        id = 1450, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.5626, y = 0.5400,
        name = { enUS = "Orphan Matron Nightingale", deDE = "Waisenmatrone Nightingale", esES = "Supervisora de huérfanos Ruiseñor", esMX = "Supervisora de huérfanos Ruiseñor", frFR = "Directrice de l'orphelinat Nightingale", koKR = "보육원 원장님 나이팅게일", ptBR = "Matriarca Ananéri", ruRU = "Попечительница сирот Найтингейл", zhCN = "孤儿监护员奈丁加尔", zhTW = "孤兒監護員南丁格爾" },
    },
    {
        id = 1451, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6002, y = 0.7691,
        name = { enUS = "Roberto Pupellyverbos", deDE = "Roberto Pupellyverbos", esES = "Roberto Pupellyverbos", esMX = "Roberto Pupellyverbos", frFR = "Roberto Pupellyverbos", koKR = "로베르토 푸펠리베르보스", ptBR = "Roberto Pupellyverbos", ruRU = "Роберто Пупллечерпос", zhCN = "罗伯特·奥布斯", zhTW = "羅伯特·奧布斯" },
    },
    {
        id = 1452, types = { "vendor-food" },
        faction = "Alliance", map = 1453, x = 0.6793, y = 0.7219,
        name = { enUS = "Thomas Miller", deDE = "Thomas Miller", esES = "Thomas Molina", esMX = "Thomas Molina", frFR = "Thomas Miller", koKR = "토마스 밀러", ptBR = "Tomás Miller", ruRU = "Томас Миллер", zhCN = "托马斯·米勒", zhTW = "湯瑪斯·米勒" },
    },
    {
        id = 1453, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.5224, y = 0.6905,
        name = { enUS = "Alowicious Czervik", deDE = "Alowicious Czervik", esES = "Alowicious Czervik", esMX = "Alowicious Czervik", frFR = "Alowicious Czervik", koKR = "알로위셔스 체르빅", ptBR = "Aluísio Czervik", ruRU = "Аловициус Червик", zhCN = "阿罗希奥斯·瑟维克", zhTW = "阿羅希奧斯·瑟維克" },
    },
    {
        id = 1454, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.5462, y = 0.6776,
        name = { enUS = "Barkeep Morag", deDE = "Barkeeper Morag", esES = "Posadero Morag", esMX = "Posadero Morag", frFR = "Morag le tavernier", koKR = "바텐더 모라그", ptBR = "Taberneiro Morag", ruRU = "Кабатчик Мораг", zhCN = "酒吧老板莫拉格", zhTW = "酒吧老闆莫拉格" },
    },
    {
        id = 1455, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.5718, y = 0.5337,
        name = { enUS = "Borstan", deDE = "Borstan", esES = "Borstan", esMX = "Borstan", frFR = "Borstan", koKR = "보르스탄", ptBR = "Borsgan", ruRU = "Борстан", zhCN = "博斯坦", zhTW = "博斯坦" },
    },
    {
        id = 1456, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.7962, y = 0.2899,
        name = { enUS = "Deze Snowbane", deDE = "Deze Snowbane", esES = "Deze Delirioníveo", esMX = "Deze Delirioníveo", frFR = "Deze Snowbane", koKR = "데제 스노우베인", ptBR = "Deze Mataneves", ruRU = "Дези Холодная", zhCN = "迪兹·斯诺班", zhTW = "迪茲·斯諾班" },
    },
    {
        id = 1457, types = { "vendor-food" },
        faction = "Neutral", map = 1454, x = 0.5329, y = 0.6648,
        name = { enUS = "Kaymard Copperpinch", deDE = "Kaymard Copperpinch", esES = "Kaymard Cobrellizco", esMX = "Kaymard Cobrellizco", frFR = "Kaymard Copperpinch", koKR = "케이말드 코퍼핀치", ptBR = "Polyxopo Pechisbeque", ruRU = "Каймард Меднокноп", zhCN = "凯玛德·考伯宾奇", zhTW = "凱瑪德·考伯賓奇" },
    },
    {
        id = 1458, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.4901, y = 0.5422,
        name = { enUS = "Kor'jus", deDE = "Kor'jus", esES = "Kor'jus", esMX = "Kor'jus", frFR = "Kor'jus", koKR = "코르주스", ptBR = "Kor'jus", ruRU = "Кор'хус", zhCN = "考苏斯", zhTW = "考蘇斯" },
    },
    {
        id = 1459, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.4473, y = 0.7004,
        name = { enUS = "Olvia", deDE = "Olvia", esES = "Olvia", esMX = "Olvia", frFR = "Olvia", koKR = "올비아", ptBR = "Olvia", ruRU = "Олвия", zhCN = "奥维亚", zhTW = "奧維亞" },
    },
    {
        id = 1460, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.5357, y = 0.6591,
        name = { enUS = "Rachelle Gothena", deDE = "Rachelle Gothena", esES = "Rachelle Gothena", esMX = "Rachelle Gothena", frFR = "Rachelle Gothena", koKR = "레이첼 가디나", ptBR = "Rachelle Gothena", ruRU = "Рашель Готена", zhCN = "拉切雷·格瑟纳", zhTW = "拉切雷·格瑟納" },
    },
    {
        id = 1461, types = { "vendor-food" },
        faction = "Horde", map = 1454, x = 0.3741, y = 0.5237,
        name = { enUS = "Shan'ti", deDE = "Shan'ti", esES = "Shan'ti", esMX = "Shan'ti", frFR = "Shan'ti", koKR = "샨티", ptBR = "Shan'ti", ruRU = "Шан'ти", zhCN = "珊迪", zhTW = "珊迪" },
    },
    {
        id = 1462, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.5580, y = 0.3559,
        name = { enUS = "Sraaz", deDE = "Sraaz", esES = "Sraaz", esMX = "Sraaz", frFR = "Sraaz", koKR = "스라즈", ptBR = "Siraaz", ruRU = "Шрааз", zhCN = "斯拉兹", zhTW = "斯拉茲" },
    },
    {
        id = 1463, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3240, y = 0.6740,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1464, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3300, y = 0.6860,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1465, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3340, y = 0.6540,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1466, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3340, y = 0.6640,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1467, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3340, y = 0.6700,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1468, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3340, y = 0.6760,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1469, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3360, y = 0.6600,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1470, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3360, y = 0.6680,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1471, types = { "vendor-food" },
        faction = "Alliance", map = 1455, x = 0.3360, y = 0.6780,
        name = { enUS = "Wulmort Jinglepocket", deDE = "Wulmort Jinglepocket", esES = "Wulmort Jinglepocket", esMX = "Wulmort Jinglepocket", frFR = "Wulmort Jinglepocket", koKR = "Wulmort Jinglepocket", ptBR = "Wulmort Jinglepocket", ruRU = "Wulmort Jinglepocket", zhCN = "Wulmort Jinglepocket", zhTW = "Wulmort Jinglepocket" },
    },
    {
        id = 1472, types = { "vendor-food" },
        faction = "Horde", map = 1456, x = 0.4145, y = 0.5317,
        name = { enUS = "Fyr Mistrunner", deDE = "Fyr Mistrunner", esES = "Fyr Correbruma", esMX = "Fyr Correbruma", frFR = "Fyr Mistrunner", koKR = "피르 미스트러너", ptBR = "Fyr Corre com a Névoa", ruRU = "Фира Вестница Туманов", zhCN = "法尔·迷雾行者", zhTW = "法爾·迷霧行者" },
    },
    {
        id = 1473, types = { "vendor-food" },
        faction = "Horde", map = 1456, x = 0.5231, y = 0.4781,
        name = { enUS = "Kaga Mistrunner", deDE = "Kaga Mistrunner", esES = "Kaga Correbruma", esMX = "Kaga Correbruma", frFR = "Kaga Mistrunner", koKR = "카가 미스트러너", ptBR = "Kara Corre com a Névoa", ruRU = "Кага Вестница Туманов", zhCN = "卡加·迷雾行者", zhTW = "卡加·迷霧行者" },
    },
    {
        id = 1474, types = { "vendor-food" },
        faction = "Horde", map = 1456, x = 0.4733, y = 0.4244,
        name = { enUS = "Nan Mistrunner", deDE = "Nan Mistrunner", esES = "Nan Correbruma", esMX = "Nan Correbruma", frFR = "Nan Mistrunner", koKR = "난 미스트러너", ptBR = "Nan Corre com a Névoa", ruRU = "Нан Вестница Туманов", zhCN = "纳恩·迷雾行者", zhTW = "納恩·迷霧行者" },
    },
    {
        id = 1475, types = { "vendor-food" },
        faction = "Neutral", map = 1456, x = 0.3904, y = 0.6107,
        name = { enUS = "Seersa Copperpinch", deDE = "Seersa Copperpinch", esES = "Seersa Cobrellizco", esMX = "Seersa Cobrellizco", frFR = "Seersa Copperpinch", koKR = "시르사 코퍼핀치", ptBR = "Amerijanas Pechisbeque", ruRU = "Лигерфа Меднокноп", zhCN = "希尔萨", zhTW = "希爾薩·考伯賓奇" },
    },
    {
        id = 1476, types = { "vendor-food" },
        faction = "Horde", map = 1456, x = 0.4246, y = 0.5528,
        name = { enUS = "Whulwert Copperpinch", deDE = "Whulwert Copperpinch", esES = "Whulwert Cobrellizco", esMX = "Whulwert Cobrellizco", frFR = "Whulwert Copperpinch", koKR = "훌워트 코퍼핀치", ptBR = "Ualmarto Pechisbeque", ruRU = "Живан Меднокноп", zhCN = "乌尔维特", zhTW = "烏爾維特·考伯賓奇" },
    },
    {
        id = 1477, types = { "vendor-food" },
        faction = "Horde", map = 1456, x = 0.4375, y = 0.5873,
        name = { enUS = "Whulwert Copperpinch", deDE = "Whulwert Copperpinch", esES = "Whulwert Cobrellizco", esMX = "Whulwert Cobrellizco", frFR = "Whulwert Copperpinch", koKR = "훌워트 코퍼핀치", ptBR = "Ualmarto Pechisbeque", ruRU = "Живан Меднокноп", zhCN = "乌尔维特", zhTW = "烏爾維特·考伯賓奇" },
    },
    {
        id = 1478, types = { "vendor-food" },
        faction = "Alliance", map = 1457, x = 0.3361, y = 0.1582,
        name = { enUS = "Dendrythis", deDE = "Dendrythis", esES = "Dendrythis", esMX = "Dendrythis", frFR = "Dendrythis", koKR = "덴드리시스", ptBR = "Dendrythis", ruRU = "Дендритис", zhCN = "德蒂希斯", zhTW = "德蒂希斯" },
    },
    {
        id = 1479, types = { "vendor-food" },
        faction = "Alliance", map = 1457, x = 0.6939, y = 0.4492,
        name = { enUS = "Fyrenna", deDE = "Fyrenna", esES = "Fyrenna", esMX = "Fyrenna", frFR = "Fyrenna", koKR = "피렌나", ptBR = "Fyrenna", ruRU = "Фиренна", zhCN = "菲琳娜", zhTW = "菲琳娜" },
    },
    {
        id = 1480, types = { "vendor-food" },
        faction = "Alliance", map = 1457, x = 0.6448, y = 0.7174,
        name = { enUS = "Jaeana", deDE = "Jaeana", esES = "Jaeana", esMX = "Jaeana", frFR = "Jaeana", koKR = "제아나", ptBR = "Jaeana", ruRU = "Джаена", zhCN = "加伊娜", zhTW = "加伊娜" },
    },
    {
        id = 1481, types = { "vendor-food" },
        faction = "Alliance", map = 1457, x = 0.4747, y = 0.5739,
        name = { enUS = "Talaelar", deDE = "Talaelar", esES = "Talaelar", esMX = "Talaelar", frFR = "Talaelar", koKR = "탈렐라르", ptBR = "Talaelar", ruRU = "Талаэлар", zhCN = "塔莱拉尔", zhTW = "塔萊拉爾" },
    },
    {
        id = 1482, types = { "vendor-food" },
        faction = "Horde", map = 1458, x = 0.7293, y = 0.2673,
        name = { enUS = "Morley Bates", deDE = "Morley Bates", esES = "Morley Bates", esMX = "Morley Bates", frFR = "Morley Bates", koKR = "몰리 베이츠", ptBR = "Mauro Pilates", ruRU = "Морли Бейтс", zhCN = "莫雷·巴特斯", zhTW = "莫雷·巴特斯" },
    },
    {
        id = 1483, types = { "vendor-food" },
        faction = "Horde", map = 1458, x = 0.6519, y = 0.4984,
        name = { enUS = "Tawny Grisette", deDE = "Tawny Grisette", esES = "Tawny Grisette", esMX = "Tawny Grisette", frFR = "Tawny Grisette", koKR = "타우니 그리제트", ptBR = "Clorinda Grisette", ruRU = "Шатенн Гризетт", zhCN = "塔文·格瑞斯特", zhTW = "塔文·格瑞斯特" },
    },
    {
        id = 1484, types = { "vendor-food" },
        faction = "Alliance", map = 2548, x = 0.6458, y = 0.8422,
        name = { enUS = "Burt Lazlo", deDE = "Burt Lazlo", esES = "Burt Lazlo", esMX = "Burt Lazlo", frFR = "Burt Lazlo", koKR = "Burt Lazlo", ptBR = "Burt Lazlo", ruRU = "Burt Lazlo", zhCN = "Burt Lazlo", zhTW = "Burt Lazlo" },
    },
    {
        id = 1485, types = { "vendor-food" },
        faction = "Alliance", map = 2548, x = 0.6460, y = 0.8281,
        name = { enUS = "Cassandra Wheeler", deDE = "Cassandra Wheeler", esES = "Cassandra Wheeler", esMX = "Cassandra Wheeler", frFR = "Cassandra Wheeler", koKR = "Cassandra Wheeler", ptBR = "Cassandra Wheeler", ruRU = "Cassandra Wheeler", zhCN = "Cassandra Wheeler", zhTW = "Cassandra Wheeler" },
    },
    {
        id = 1486, types = { "vendor-food" },
        faction = "Alliance", map = 2548, x = 0.6472, y = 0.8425,
        name = { enUS = "Christina Von Stavern", deDE = "Christina Von Stavern", esES = "Christina Von Stavern", esMX = "Christina Von Stavern", frFR = "Christina Von Stavern", koKR = "Christina Von Stavern", ptBR = "Christina Von Stavern", ruRU = "Christina Von Stavern", zhCN = "Christina Von Stavern", zhTW = "Christina Von Stavern" },
    },
    {
        id = 1487, types = { "vendor-food" },
        map = 2548, x = 0.5800, y = 0.4580,
        name = { enUS = "Naluk", deDE = "Naluk", esES = "Naluk", esMX = "Naluk", frFR = "Naluk", koKR = "Naluk", ptBR = "Naluk", ruRU = "Naluk", zhCN = "Naluk", zhTW = "Naluk" },
    },
    {
        id = 1488, types = { "vendor-food" },
        faction = "Alliance", map = 2548, x = 0.6203, y = 0.8111,
        name = { enUS = "Penny Pinderton", deDE = "Penny Pinderton", esES = "Penny Pinderton", esMX = "Penny Pinderton", frFR = "Penny Pinderton", koKR = "Penny Pinderton", ptBR = "Penny Pinderton", ruRU = "Penny Pinderton", zhCN = "Penny Pinderton", zhTW = "Penny Pinderton" },
    },
    {
        id = 1489, types = { "vendor-food" },
        faction = "Alliance", map = 2548, x = 0.6209, y = 0.8121,
        name = { enUS = "Penny Pinderton", deDE = "Penny Pinderton", esES = "Penny Pinderton", esMX = "Penny Pinderton", frFR = "Penny Pinderton", koKR = "Penny Pinderton", ptBR = "Penny Pinderton", ruRU = "Penny Pinderton", zhCN = "Penny Pinderton", zhTW = "Penny Pinderton" },
    },
    {
        id = 1490, types = { "vendor-poisons" },
        faction = "Neutral", map = 1416, x = 0.8612, y = 0.7957,
        name = { enUS = "Smudge Thunderwood", deDE = "Smudge Thunderwood", esES = "Smudge Truenedera", esMX = "Smudge Truenedera", frFR = "Smudge Thunderwood", koKR = "스머지 썬더우드", ptBR = "Mancho Tonitrobosque", ruRU = "Клякс Громодрев", zhCN = "斯穆德·雷木", zhTW = "斯穆德·雷木" },
    },
    {
        id = 1491, types = { "vendor-poisons" },
        faction = "Horde", map = 1420, x = 0.6376, y = 0.7591,
        name = { enUS = "Ezekiel Graves", deDE = "Ezekiel Graves", esES = "Ezekiel Tumbas", esMX = "Ezekiel Tumbas", frFR = "Ezekiel Graves", koKR = "에제키엘 그레이브", ptBR = "Ezequiel Potio", ruRU = "Иезекииль Могиллан", zhCN = "艾泽基尔·格瑞乌斯", zhTW = "艾澤基爾·格瑞烏斯" },
    },
    {
        id = 1492, types = { "vendor-poisons" },
        faction = "Horde", map = 1421, x = 0.4290, y = 0.4181,
        name = { enUS = "Patrice Dwyer", deDE = "Patrice Dwyer", esES = "Patrice Dwyer", esMX = "Patrice Dwyer", frFR = "Patricia Dwyer", koKR = "패트라이스 드위어", ptBR = "Patrícia Dwyer", ruRU = "Пэтрис Дуайер", zhCN = "帕崔斯·杜耶尔", zhTW = "帕崔斯·杜耶爾" },
    },
    {
        id = 1493, types = { "vendor-poisons", "vendor-reagents" },
        faction = "Alliance", map = 1424, x = 0.5079, y = 0.5900,
        name = { enUS = "Jaysin Lanyda", deDE = "Jaysin Lanyda", esES = "Jaysin Lanyda", esMX = "Jaysin Lanyda", frFR = "Jaysin Lanyda", koKR = "제이신 라니다", ptBR = "Jacinto Lânido", ruRU = "Джейсин Ланида", zhCN = "杰森·兰达", zhTW = "傑森·蘭達" },
    },
    {
        id = 1494, types = { "vendor-poisons" },
        faction = "Alliance", map = 1431, x = 0.7941, y = 0.4433,
        name = { enUS = "Malissa", deDE = "Malissa", esES = "Malissa", esMX = "Malissa", frFR = "Malissa", koKR = "말리사", ptBR = "Malissa", ruRU = "Малисса", zhCN = "玛丽萨", zhTW = "瑪麗薩" },
    },
    {
        id = 1495, types = { "vendor-poisons" },
        faction = "Alliance", map = 1433, x = 0.2003, y = 0.4114,
        name = { enUS = "Gerald Crawley", deDE = "Gerald Crawley", esES = "Gerald Gateato", esMX = "Gerald Gateato", frFR = "Gerald Crawley", koKR = "제랄드 크롤리", ptBR = "Geraldo Civinski", ruRU = "Джеральд Кроули", zhCN = "格拉德·克劳雷", zhTW = "格拉德·克勞雷" },
    },
    {
        id = 1496, types = { "vendor-poisons" },
        faction = "Alliance", map = 1453, x = 0.7859, y = 0.7092,
        name = { enUS = "Sloan McCoy", deDE = "Sloan McCoy", esES = "Sloan McCoy", esMX = "Sloan McCoy", frFR = "Sloan McCoy", koKR = "슬로언 맥코이", ptBR = "Sophia Mesquita", ruRU = "Слоан Маккой", zhCN = "斯洛安·麦考伊", zhTW = "斯洛安·麥考伊" },
    },
    {
        id = 1497, types = { "vendor-poisons" },
        faction = "Horde", map = 1454, x = 0.4207, y = 0.4952,
        name = { enUS = "Rekkul", deDE = "Rekkul", esES = "Rekkul", esMX = "Rekkul", frFR = "Rekkul", koKR = "렉쿨", ptBR = "Rekkol", ruRU = "Реккул", zhCN = "雷库尔", zhTW = "雷庫爾" },
    },
    {
        id = 1498, types = { "vendor-poisons" },
        faction = "Alliance", map = 1457, x = 0.3248, y = 0.1979,
        name = { enUS = "Kyrai", deDE = "Kyrai", esES = "Kyrai", esMX = "Kyrai", frFR = "Kyrai", koKR = "키라이", ptBR = "Kyrai", ruRU = "Кирая", zhCN = "凯尔莱", zhTW = "凱爾萊" },
    },
    {
        id = 1499, types = { "vendor-poisons" },
        faction = "Neutral", map = 2548, x = 0.7681, y = 0.5114,
        name = { enUS = "Krikshank", deDE = "Krikshank", esES = "Krikshank", esMX = "Krikshank", frFR = "Krikshank", koKR = "Krikshank", ptBR = "Krikshank", ruRU = "Krikshank", zhCN = "Krikshank", zhTW = "Krikshank" },
    },
    {
        id = 1500, types = { "vendor-poisons" },
        faction = "Neutral", map = 2548, x = 0.7682, y = 0.5123,
        name = { enUS = "Krikshank", deDE = "Krikshank", esES = "Krikshank", esMX = "Krikshank", frFR = "Krikshank", koKR = "Krikshank", ptBR = "Krikshank", ruRU = "Krikshank", zhCN = "Krikshank", zhTW = "Krikshank" },
    },
    {
        id = 1501, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1413, x = 0.4590, y = 0.3571,
        name = { enUS = "Kalldan Felmoon", deDE = "Kalldan Felmoon", esES = "Kalldan Lunavil", esMX = "Kalldan Lunavil", frFR = "Kalldan Felmoon", koKR = "칼단 펠문", ptBR = "Kalldan Luavil", ruRU = "Калидан Лунный Серп", zhCN = "卡尔丹·暗月", zhTW = "卡爾丹·暗月" },
    },
    {
        id = 1502, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1413, x = 0.5220, y = 0.3170,
        name = { enUS = "Wrahk", deDE = "Wrahk", esES = "Wrahk", esMX = "Wrahk", frFR = "Wrahk", koKR = "레이크", ptBR = "Wrahk", ruRU = "Ракх", zhCN = "瓦尔克", zhTW = "瓦爾克" },
    },
    {
        id = 1503, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1413, x = 0.4500, y = 0.5929,
        name = { enUS = "Yonada", deDE = "Yonada", esES = "Ionada", esMX = "Ionada", frFR = "Yonada", koKR = "요나다", ptBR = "Yonada", ruRU = "Йонада", zhCN = "犹纳达", zhTW = "猶納達" },
    },
    {
        id = 1504, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1416, x = 0.3821, y = 0.3893,
        name = { enUS = "Bro'kin", deDE = "Bro'kin", esES = "Bro'kin", esMX = "Bro'kin", frFR = "Bro'kin", koKR = "브로킨", ptBR = "Ke'bradas", ruRU = "Бро'кин", zhCN = "布洛金", zhTW = "布洛金" },
    },
    {
        id = 1505, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1416, x = 0.1760, y = 0.6019,
        name = { enUS = "Dominique Stefano", deDE = "Dominique Stefano", esES = "Dominique Stefano", esMX = "Dominique Stefano", frFR = "Dominique Stefano", koKR = "Dominique Stefano", ptBR = "Dominique Stefano", ruRU = "Dominique Stefano", zhCN = "Dominique Stefano", zhTW = "Dominique Stefano" },
    },
    {
        id = 1506, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1416, x = 0.4731, y = 0.3521,
        name = { enUS = "Rizz Loosebolt", deDE = "Rizz Loosebolt", esES = "Rizz Tornillosuelto", esMX = "Rizz Tornillosuelto", frFR = "Rizz Loosebolt", koKR = "리즈 루즈볼트", ptBR = "Renão Batibem", ruRU = "Ризз Болтень", zhCN = "里兹·飞矢", zhTW = "里茲·飛矢" },
    },
    {
        id = 1507, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1417, x = 0.4511, y = 0.4678,
        name = { enUS = "Androd Fadran", deDE = "Androd Fadran", esES = "Androd Fadran", esMX = "Androd Fadran", frFR = "Androd Fadran", koKR = "안드로드 패드랜", ptBR = "Androd Fadran", ruRU = "Андрод Фадран", zhCN = "安多德·法德兰", zhTW = "安多德·法德蘭" },
    },
    {
        id = 1508, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1417, x = 0.4630, y = 0.4700,
        name = { enUS = "Drovnar Strongbrew", deDE = "Drovnar Strongbrew", esES = "Drovanar Brevaforte", esMX = "Drovanar Brevaforte", frFR = "Drovnar Strongbrew", koKR = "드로브나르 스트롱브루", ptBR = "Drovnar Cervafirme", ruRU = "Дровнар Густовар", zhCN = "德鲁纳·烈酒", zhTW = "德魯納·烈酒" },
    },
    {
        id = 1509, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1417, x = 0.7270, y = 0.3650,
        name = { enUS = "Jun'ha", deDE = "Jun'ha", esES = "Jun'ha", esMX = "Jun'ha", frFR = "Jun'ha", koKR = "준하", ptBR = "Jun'ha", ruRU = "Джун'ха", zhCN = "祖恩哈", zhTW = "祖恩哈" },
    },
    {
        id = 1510, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1417, x = 0.7481, y = 0.3461,
        name = { enUS = "Tunkk", deDE = "Tunkk", esES = "Tunkk", esMX = "Tunkk", frFR = "Tunkk", koKR = "텅크", ptBR = "Tunkk", ruRU = "Тункк", zhCN = "吞克", zhTW = "吞克" },
    },
    {
        id = 1511, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Neutral", map = 1418, x = 0.4249, y = 0.5249,
        name = { enUS = "Jazzrik", deDE = "Jazzrik", esES = "Jazzrik", esMX = "Jazzrik", frFR = "Jazzrik", koKR = "자즈릭", ptBR = "Jazzrik", ruRU = "Джаззрик", zhCN = "加兹里克", zhTW = "加茲里克" },
    },
    {
        id = 1512, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1419, x = 0.6690, y = 0.1821,
        name = { enUS = "Nina Lightbrew", deDE = "Nina Lightbrew", esES = "Nina Burbuluz", esMX = "Nina Burbuluz", frFR = "Nina Lightbrew", koKR = "니나 라이트브루", ptBR = "Nina Cervaleve", ruRU = "Ниней Легковар", zhCN = "妮娜·莱特布鲁", zhTW = "妮娜·萊特布魯" },
    },
    {
        id = 1513, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.5878, y = 0.8091,
        name = { enUS = "Algernon", deDE = "Algernon", esES = "Algernon", esMX = "Algernon", frFR = "Algernon", koKR = "알게르논", ptBR = "Algernon", ruRU = "Алжернон", zhCN = "奥格诺恩", zhTW = "奧格諾恩" },
    },
    {
        id = 1514, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.6267, y = 0.7746,
        name = { enUS = "Joseph Moore", deDE = "Joseph Moore", esES = "Joseph Moore", esMX = "Joseph Moore", frFR = "Joseph Moore", koKR = "조셉 무어", ptBR = "Josefo Mourão", ruRU = "Джозеф Мур", zhCN = "约瑟夫·摩尔", zhTW = "約瑟夫·摩爾" },
    },
    {
        id = 1515, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.5943, y = 0.7542,
        name = { enUS = "Katrina Alliestar", deDE = "Katrina Alliestar", esES = "Katrina Estrellaliada", esMX = "Katrina Estrellaliada", frFR = "Katrina Alliestar", koKR = "카트리나 알리스타", ptBR = "Catarina Basílico", ruRU = "Катрина Альестар", zhCN = "卡崔娜·奥列斯塔", zhTW = "卡崔娜·奧列斯塔" },
    },
    {
        id = 1516, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.6279, y = 0.7144,
        name = { enUS = "Millie Gregorian", deDE = "Millie Gregorian", esES = "Millie Gregorian", esMX = "Millie Gregorian", frFR = "Millie Gregorian", koKR = "밀리 그레고리안", ptBR = "Berta Gregório", ruRU = "Милли Грегориан", zhCN = "米利尔·格里高利", zhTW = "米利爾·格里高利" },
    },
    {
        id = 1517, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.6102, y = 0.7419,
        name = { enUS = "Ronald Burch", deDE = "Ronald Burch", esES = "Ronald Burch", esMX = "Ronald Burch", frFR = "Ronald Burch", koKR = "로널드 버치", ptBR = "Ronaldo Amora", ruRU = "Рональд Берч", zhCN = "罗纳德·伯奇", zhTW = "羅奈爾得·伯奇" },
    },
    {
        id = 1518, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.5984, y = 0.7290,
        name = { enUS = "Sarah Killian", deDE = "Sarah Killian", esES = "Sarah Killian", esMX = "Sarah Killian", frFR = "Sarah Killian", koKR = "사라 킬리안", ptBR = "Cilene Rocha", ruRU = "Сара Килиан", zhCN = "莎拉·基里安", zhTW = "薩拉·基里安" },
    },
    {
        id = 1519, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.6105, y = 0.7799,
        name = { enUS = "Thaddeus Webb", deDE = "Thaddeus Webb", esES = "Thaddeus Webb", esMX = "Thaddeus Webb", frFR = "Thaddeus Webb", koKR = "타데우스 웨브", ptBR = "Tadeu Uchoa", ruRU = "Таддеус Уэбб", zhCN = "萨德乌斯·韦伯", zhTW = "薩德烏斯·韋伯" },
    },
    {
        id = 1520, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1420, x = 0.8330, y = 0.6972,
        name = { enUS = "Werg Thickblade", deDE = "Werg Thickblade", esES = "Werg Filo Grueso", esMX = "Werg Filo Grueso", frFR = "Werg Thickblade", koKR = "웨르그 틱블레이드", ptBR = "Werg Gumegrosso", ruRU = "Верг Крепкий Клинок", zhCN = "维尔格·厚刃", zhTW = "維爾格·厚刃" },
    },
    {
        id = 1521, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1421, x = 0.5389, y = 0.8219,
        name = { enUS = "Leo Sarn", deDE = "Leo Sarn", esES = "Leo Sarn", esMX = "Leo Sarn", frFR = "Leo Sarn", koKR = "레오 사른", ptBR = "Leopoldo Sarin", ruRU = "Лео Сарн", zhCN = "雷欧·萨恩", zhTW = "雷歐·薩恩" },
    },
    {
        id = 1522, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1421, x = 0.4300, y = 0.5081,
        name = { enUS = "Lilly", deDE = "Lilly", esES = "Lilly", esMX = "Lilly", frFR = "Lilly", koKR = "Lilly", ptBR = "Lilly", ruRU = "Lilly", zhCN = "Lilly", zhTW = "Lilly" },
    },
    {
        id = 1523, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1422, x = 0.4309, y = 0.8428,
        name = { enUS = "Leonard Porter", deDE = "Leonard Porter", esES = "Leonard Porter", esMX = "Leonard Porter", frFR = "Leonard Porter", koKR = "레오나드 포터", ptBR = "Leontino Marques", ruRU = "Леонард Портер", zhCN = "莱纳德·波特", zhTW = "萊納德·波特" },
    },
    {
        id = 1524, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1424, x = 0.9200, y = 0.3819,
        name = { enUS = "George Candarte", deDE = "George Candarte", esES = "George Candarte", esMX = "George Candarte", frFR = "George Candarte", koKR = "조지 칸다테", ptBR = "Jorge Candango", ruRU = "Джорлж Кандарте", zhCN = "乔治·坎达特", zhTW = "喬治·坎達特" },
    },
    {
        id = 1525, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1424, x = 0.6192, y = 0.2100,
        name = { enUS = "Mallen Swain", deDE = "Mallen Swain", esES = "Mallen Swain", esMX = "Mallen Swain", frFR = "Mallen Swain", koKR = "말렌 스웨인", ptBR = "Mário Pretendente", ruRU = "Маллен Свейн", zhCN = "玛林·斯万", zhTW = "瑪林·斯萬" },
    },
    {
        id = 1526, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1424, x = 0.5092, y = 0.5713,
        name = { enUS = "Nandar Branson", deDE = "Nandar Branson", esES = "Nandar Branson", esMX = "Nandar Branson", frFR = "Nandar Branson", koKR = "난다르 브랜슨", ptBR = "Nando Branson", ruRU = "Нандар Брансон", zhCN = "南达·布拉森", zhTW = "南達·布拉森" },
    },
    {
        id = 1527, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1425, x = 0.1339, y = 0.4410,
        name = { enUS = "Harggan", deDE = "Harggan", esES = "Harggan", esMX = "Harggan", frFR = "Harggan", koKR = "하르간", ptBR = "Harggan", ruRU = "Харгган", zhCN = "哈尔甘", zhTW = "哈爾甘" },
    },
    {
        id = 1528, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1425, x = 0.1329, y = 0.4338,
        name = { enUS = "Nioma", deDE = "Nioma", esES = "Nioma", esMX = "Nioma", frFR = "Nioma", koKR = "니오마", ptBR = "Nioma", ruRU = "Ниома", zhCN = "尼奥玛", zhTW = "尼奧瑪" },
    },
    {
        id = 1529, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1425, x = 0.7940, y = 0.7912,
        name = { enUS = "Otho Moji'ko", deDE = "Otho Moji'ko", esES = "Otho Moji'ko", esMX = "Otho Moji'ko", frFR = "Otho Moji'ko", koKR = "오토 모지코", ptBR = "Joho'sér Mujik'ka", ruRU = "Отхо Можи'ко", zhCN = "奥索·莫吉克", zhTW = "奧索·莫吉克" },
    },
    {
        id = 1530, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1425, x = 0.3431, y = 0.3782,
        name = { enUS = "Ruppo Zipcoil", deDE = "Ruppo Zipcoil", esES = "Rupo Brirrollo", esMX = "Rupo Brirrollo", frFR = "Ruppo Zipcoil", koKR = "루포 집코일", ptBR = "Ruppo Zippespira", ruRU = "Руппо Свистопулькин", zhCN = "鲁普·火油", zhTW = "魯普·火油" },
    },
    {
        id = 1531, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Horde", map = 1425, x = 0.7750, y = 0.8042,
        name = { enUS = "Smith Slagtree", deDE = "Schmied Slagtree", esES = "Herrero Esco", esMX = "Herrero Arbolescoria", frFR = "Forgeron Slagtree", koKR = "대장장이 슬래그트리", ptBR = "Ferreiro Escoriárvore", ruRU = "Кузнец Углежог", zhCN = "铁匠斯拉提", zhTW = "鐵匠斯拉提" },
    },
    {
        id = 1532, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5744, y = 0.2661,
        name = { enUS = "Bombus Finespindle", deDE = "Bombus Finespindle", esES = "Bombus Bueneje", esMX = "Bombus Bueneje", frFR = "Bombus Finespindle", koKR = "봄부스 파인스핀들", ptBR = "Bombus Fusofino", ruRU = "Бомбус Остроигл", zhCN = "伯布斯·钢轴", zhTW = "伯布斯·鋼軸" },
    },
    {
        id = 1533, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.6069, y = 0.2709,
        name = { enUS = "Emrul Riknussun", deDE = "Emrul Riknussun", esES = "Emrul Riknussun", esMX = "Emrul Riknussun", frFR = "Emrul Riknussun", koKR = "엠룰 리크너선", ptBR = "Emrul Ricinum", ruRU = "Эмруль Рикнуссен", zhCN = "埃姆鲁尔·里克努斯", zhTW = "埃姆盧爾·里克努斯" },
    },
    {
        id = 1534, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.6196, y = 0.2791,
        name = { enUS = "Gearcutter Cogspinner", deDE = "Gearcutter Cogspinner", esES = "Cortallave Volopiñón", esMX = "Cortallave Volopiñón", frFR = "Gearcutter Cogspinner", koKR = "기어커터 코그스피너", ptBR = "Cortarroda Rodagiros", ruRU = "Зуборез Шестеренок", zhCN = "考格斯宾", zhTW = "考格斯賓" },
    },
    {
        id = 1535, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5936, y = 0.2531,
        name = { enUS = "Golnir Bouldertoe", deDE = "Golnir Bouldertoe", esES = "Golnir Dedorroca", esMX = "Golnir Dedorroca", frFR = "Golnir Bouldertoe", koKR = "골니르 보울더토", ptBR = "Golnir Topadão", ruRU = "Голнир Твердопал", zhCN = "高尼尔·石趾", zhTW = "高尼爾·石趾" },
    },
    {
        id = 1536, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5993, y = 0.3063,
        name = { enUS = "Gwina Stonebranch", deDE = "Gwina Stonebranch", esES = "Gwina Ramapiedra", esMX = "Gwina Ramapiedra", frFR = "Gwina Stonebranch", koKR = "그위나 스톤브랜치", ptBR = "Guina Galhopétreo", ruRU = "Гвина Каменная Ветвь", zhCN = "戈维纳·石枝", zhTW = "戈維納·石枝" },
    },
    {
        id = 1537, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5010, y = 0.4939,
        name = { enUS = "Loslor Rudge", deDE = "Loslor Rudge", esES = "Loslor Rudge", esMX = "Loslor Rudge", frFR = "Loslor Rudge", koKR = "로슬로 러지", ptBR = "Loslor Rudge", ruRU = "Лослор Рудж", zhCN = "罗斯洛·鲁治", zhTW = "羅斯洛·魯治" },
    },
    {
        id = 1538, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.2189, y = 0.3189,
        name = { enUS = "Namdo Bizzfizzle", deDE = "Namdo Bizzfizzle", esES = "Namdo Silvabín", esMX = "Namdo Silvabín", frFR = "Namdo Bizzfizzle", koKR = "남도 비즈피즐", ptBR = "Nando Deuxabu", ruRU = "Намдо Вклвыкл", zhCN = "纳姆杜", zhTW = "納姆杜" },
    },
    {
        id = 1539, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5806, y = 0.2579,
        name = { enUS = "Outfitter Eric", deDE = "Ausstatter Eric", esES = "Confecciones Eric", esMX = "Confecciones Eric", frFR = "Eric le tailleur", koKR = "재단사 에릭", ptBR = "Provedor Eric", ruRU = "Галантерейщик Эрик", zhCN = "埃瑞克", zhTW = "埃瑞克" },
    },
    {
        id = 1540, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.5798, y = 0.2563,
        name = { enUS = "Poranna Snowbraid", deDE = "Poranna Snowbraid", esES = "Poranna Trenzanubes", esMX = "Poranna Trenzanubes", frFR = "Poranna Snowbraid", koKR = "포라나 스노우브레이드", ptBR = "Porenna Trançaneve", ruRU = "Поранна Снежная Коса", zhCN = "博兰纳·雪衣", zhTW = "博蘭納·雪衣" },
    },
    {
        id = 1541, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.6171, y = 0.2986,
        name = { enUS = "Soolie Berryfizz", deDE = "Soolie Berryfizz", esES = "Soolie Burbubaya", esMX = "Soolie Burbubaya", frFR = "Soolie Berryfizz", koKR = "술리 베리피즈", ptBR = "Soolie Frisamora", ruRU = "Сули Гонобобельзз", zhCN = "苏雷·浆泡", zhTW = "蘇雷·漿泡" },
    },
    {
        id = 1542, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.4531, y = 0.5150,
        name = { enUS = "Thrawn Boltar", deDE = "Thrawn Boltar", esES = "Thrawn Boltar", esMX = "Thrawn Boltar", frFR = "Thrawn Boltar", koKR = "스론 볼타", ptBR = "Thrawn Boltar", ruRU = "Траун Болтарь", zhCN = "索拉恩·波塔尔", zhTW = "索拉恩·波塔爾" },
    },
    {
        id = 1543, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5939, y = 0.2795,
        name = { enUS = "Thurgrum Deepforge", deDE = "Thurgrum Deepforge", esES = "Thurgrum Forjahonda", esMX = "Thurgrum Forjahonda", frFR = "Thurgrum Deepforge", koKR = "투그룸 딥포지", ptBR = "Thurgrum Baixaforja", ruRU = "Тургрум Подземная Кузня", zhCN = "索格拉姆·深炉", zhTW = "索格拉姆·深爐" },
    },
    {
        id = 1544, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1426, x = 0.6087, y = 0.2815,
        name = { enUS = "Tilli Thistlefuzz", deDE = "Tilli Thistlefuzz", esES = "Tilli Cardopelusa", esMX = "Tilli Cardopelusa", frFR = "Tilli Thistlefuzz", koKR = "틸리 시슬퍼즈", ptBR = "Tilli Cardunça", ruRU = "Тилли Чертополуш", zhCN = "提尔利·草须", zhTW = "提爾利·草鬚" },
    },
    {
        id = 1545, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1431, x = 0.1802, y = 0.5441,
        name = { enUS = "Bliztik", deDE = "Bliztik", esES = "Bliztik", esMX = "Bliztik", frFR = "Bliztik", koKR = "블리즈틱", ptBR = "Bliztik", ruRU = "Близтик", zhCN = "布里兹提克", zhTW = "布里茲提克" },
    },
    {
        id = 1546, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1431, x = 0.7590, y = 0.4559,
        name = { enUS = "Danielle Zipstitch", deDE = "Danielle Zipstitch", esES = "Danielle Puntillas", esMX = "Danielle Puntillas", frFR = "Danielle Zipstitch", koKR = "다니엘 집스티치", ptBR = "Danielle Coseziper", ruRU = "Даниэлла Рваношов", zhCN = "丹尼勒·希普斯迪", zhTW = "丹尼勒·希普斯迪" },
    },
    {
        id = 1547, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1431, x = 0.7570, y = 0.4463,
        name = { enUS = "Lohgan Eva", deDE = "Lohgan Eva", esES = "Lohgan Eva", esMX = "Lohgan Eva", frFR = "Lohgan Eva", koKR = "로한 에바", ptBR = "Lório Veloso", ruRU = "Логан Эва", zhCN = "洛尔甘·伊瓦", zhTW = "洛爾甘·伊瓦" },
    },
    {
        id = 1548, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1431, x = 0.7570, y = 0.4559,
        name = { enUS = "Sheri Zipstitch", deDE = "Sheri Zipstitch", esES = "Sheri Puntillas", esMX = "Sheri Puntillas", frFR = "Sheri Zipstitch", koKR = "셰리 집스티치", ptBR = "Sheri Coseziper", ruRU = "Шери Рваношов", zhCN = "舍瑞·希普斯迪", zhTW = "舍瑞·希普斯迪" },
    },
    {
        id = 1549, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1432, x = 0.3590, y = 0.4591,
        name = { enUS = "Rann Flamespinner", deDE = "Rann Flamespinner", esES = "Rann Flamejes", esMX = "Rann Flamejes", frFR = "Rann Flamespinner", koKR = "랜 플레임스피너", ptBR = "Rann Rodachama", ruRU = "Ранн Пламепряд", zhCN = "拉恩·火翼", zhTW = "拉恩·火翼" },
    },
    {
        id = 1550, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1433, x = 0.6941, y = 0.7954,
        name = { enUS = "Captured Servant of Azora", deDE = "Gefangener Diener von Azora", esES = "Sirviente de Azora capturado", esMX = "Sirviente de Azora capturado", frFR = "Serviteur d’Azora capturé", koKR = "사로잡힌 아조라의 하인", ptBR = "Serviçal de Azora Capturado", ruRU = "Пленный слуга Азоры", zhCN = "阿祖拉的仆从", zhTW = "被俘虜的阿祖拉的僕從" },
    },
    {
        id = 1551, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1433, x = 0.8390, y = 0.7088,
        name = { enUS = "Clyde Ranthal", deDE = "Clyde Ranthal", esES = "Clyde Ranthal", esMX = "Clyde Ranthal", frFR = "Clyde Ranthal", koKR = "클라이드 랜덜", ptBR = "Anacleto Ramires", ruRU = "Клайд Рантал", zhCN = "克莱德·兰萨尔", zhTW = "克萊德·蘭薩爾" },
    },
    {
        id = 1552, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1433, x = 0.2212, y = 0.4547,
        name = { enUS = "Franklin Hamar", deDE = "Franklin Hamar", esES = "Franklin Hamar", esMX = "Franklin Hamar", frFR = "Franklin Hamar", koKR = "프랭클린 하머", ptBR = "Franklin Hamar", ruRU = "Франклин Хамар", zhCN = "富兰克林·哈玛", zhTW = "佛蘭克林·哈瑪" },
    },
    {
        id = 1553, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2820, y = 0.7749,
        name = { enUS = "Blixrez Goodstitch", deDE = "Blixrez Goodstitch", esES = "Blixrez Cortefino", esMX = "Blixrez Cortefino", frFR = "Blixrez Goodstitch", koKR = "블릭스레즈 굿스티치", ptBR = "Blixrez Pontobom", ruRU = "Бликрез Ладноскрой", zhCN = "布里克雷兹·古斯提", zhTW = "布里克雷茲·古斯提" },
    },
    {
        id = 1554, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2701, y = 0.8251,
        name = { enUS = "Cowardly Crosby", deDE = "Feiger Crosby", esES = "Blandengue Crosby", esMX = "Blandengue Crosby", frFR = "Crosby la Trouille", koKR = "겁쟁이 크로스비", ptBR = "Crosby Covardão", ruRU = "Трусишка Кросби", zhCN = "怯懦的克罗斯比", zhTW = "怯懦的克羅斯比" },
    },
    {
        id = 1555, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2810, y = 0.7809,
        name = { enUS = "Glyx Brewright", deDE = "Glyx Brewright", esES = "Glyx Buenamezcla", esMX = "Glyx Buenamezcla", frFR = "Glyx Brewright", koKR = "글릭스 브루라이트", ptBR = "Glyx Certisana", ruRU = "Гликс Пивоправ", zhCN = "格里克斯·布鲁维特", zhTW = "格里克斯·布魯維特" },
    },
    {
        id = 1556, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.5100, y = 0.3521,
        name = { enUS = "Gnaz Blunderflame", deDE = "Gnaz Blunderflame", esES = "Gnaz Flamerrada", esMX = "Gnaz Flamerrada", frFR = "Gnaz Blunderflame", koKR = "그나즈 블런더플레임", ptBR = "Gnaz Flamasneira", ruRU = "Гназ Огнепых", zhCN = "格纳兹·枪焰", zhTW = "格納茲·槍焰" },
    },
    {
        id = 1557, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2899, y = 0.7511,
        name = { enUS = "Hurklor", deDE = "Hurklor", esES = "Hurklor", esMX = "Hurklor", frFR = "Hurklor", koKR = "허크로", ptBR = "Hurklor", ruRU = "Хуклор", zhCN = "霍克罗尔", zhTW = "霍克羅爾" },
    },
    {
        id = 1558, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2910, y = 0.7548,
        name = { enUS = "Jansen Underwood", deDE = "Jansen Underwood", esES = "Jansen Bajoleño", esMX = "Jansen Bajoleño", frFR = "Jansen Underwood", koKR = "얀센 언더우드", ptBR = "Jansen Subráxilos", ruRU = "Янсен Подлесный", zhCN = "贾森·安德伍德", zhTW = "傑生·安德伍德" },
    },
    {
        id = 1559, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.5110, y = 0.3521,
        name = { enUS = "Knaz Blunderflame", deDE = "Knaz Blunderflame", esES = "Knaz Flamerrada", esMX = "Knaz Flamerrada", frFR = "Knaz Blunderflame", koKR = "크나즈 블런더플레임", ptBR = "Knaz Flamasneira", ruRU = "Наз Огнепых", zhCN = "克纳兹·枪焰", zhTW = "克納茲·槍焰" },
    },
    {
        id = 1560, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2849, y = 0.7511,
        name = { enUS = "Mazk Snipeshot", deDE = "Mazk Snipeshot", esES = "Mazk Tirocertero", esMX = "Mazk Tirocertero", frFR = "Tireur d’élite Mazk", koKR = "마즈크 스나이프샷", ptBR = "Mazk Tirolongo", ruRU = "Мазк Карабинс", zhCN = "玛兹克·斯奈普沙特", zhTW = "瑪茲克·斯奈普沙特" },
    },
    {
        id = 1561, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2849, y = 0.7599,
        name = { enUS = "Rikqiz", deDE = "Rikqiz", esES = "Rikqiz", esMX = "Rikqiz", frFR = "Rikqiz", koKR = "릭키즈", ptBR = "Riknik", ruRU = "Риккиз", zhCN = "雷克奇兹", zhTW = "雷克奇茲" },
    },
    {
        id = 1562, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1434, x = 0.2870, y = 0.7690,
        name = { enUS = "Xizk Goodstitch", deDE = "Xizk Goodstitch", esES = "Xizk Cortefino", esMX = "Xizk Cortefino", frFR = "Xizk Goodstitch", koKR = "시즈크 굿스티치", ptBR = "Xizk Pontobom", ruRU = "Зиск Ладноскрой", zhCN = "希兹克·古斯提", zhTW = "希茲克·古斯提" },
    },
    {
        id = 1563, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Horde", map = 1435, x = 0.4550, y = 0.5139,
        name = { enUS = "Gharash", deDE = "Gharash", esES = "Gharash", esMX = "Gharash", frFR = "Gharash", koKR = "가라쉬", ptBR = "Gharash", ruRU = "Гхарраш", zhCN = "卡尔拉什", zhTW = "卡爾拉什" },
    },
    {
        id = 1564, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1435, x = 0.4539, y = 0.5688,
        name = { enUS = "Rartar", deDE = "Rartar", esES = "Rartar", esMX = "Rartar", frFR = "Rartar", koKR = "라르타르", ptBR = "Rartar", ruRU = "Рартар", zhCN = "拉尔塔", zhTW = "拉爾塔" },
    },
    {
        id = 1565, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1437, x = 0.0799, y = 0.5631,
        name = { enUS = "Dewin Shimmerdawn", deDE = "Dewin Shimmerdawn", esES = "Dewin Brillalba", esMX = "Dewin Brillalba", frFR = "Dewin Shimmerdawn", koKR = "데윈 심머던", ptBR = "Devin Tremulaurora", ruRU = "Девин Мерцающий Рассвет", zhCN = "德温·晨光", zhTW = "德溫·晨光" },
    },
    {
        id = 1566, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1437, x = 0.2640, y = 0.2579,
        name = { enUS = "Fradd Swiftgear", deDE = "Fradd Swiftgear", esES = "Fradd Cambioveloz", esMX = "Fradd Cambioveloz", frFR = "Fradd Swiftgear", koKR = "프래드 스위프트기어", ptBR = "Fradd Entrós", ruRU = "Фрадд Бынструмент", zhCN = "弗拉德", zhTW = "弗拉德" },
    },
    {
        id = 1567, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1437, x = 0.0809, y = 0.5578,
        name = { enUS = "Jennabink Powerseam", deDE = "Jennabink Powerseam", esES = "Jennabink Powerseam", esMX = "Jennabink Powerseam", frFR = "Jennabink Powerseam", koKR = "제나빙크 파워심", ptBR = "Jennabink Coseajato", ruRU = "Дженнабик Мелкостёжка", zhCN = "吉娜比克·铁线", zhTW = "吉娜比克·鐵線" },
    },
    {
        id = 1568, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1439, x = 0.3809, y = 0.4110,
        name = { enUS = "Elisa Steelhand", deDE = "Elisa Steelhand", esES = "Elisa Mano de Acero", esMX = "Elisa Mano de Acero", frFR = "Elisa Steelhand", koKR = "엘리사 스틸핸드", ptBR = "Elisa Manácero", ruRU = "Элиза Сталерукая", zhCN = "艾丽萨·钢拳", zhTW = "艾麗薩·鋼拳" },
    },
    {
        id = 1569, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1439, x = 0.3699, y = 0.4119,
        name = { enUS = "Mavralyn", deDE = "Mavralyn", esES = "Mavralyn", esMX = "Mavralyn", frFR = "Mavralyn", koKR = "마브라린", ptBR = "Mavralyn", ruRU = "Мавралинн", zhCN = "马弗拉林", zhTW = "馬弗拉林" },
    },
    {
        id = 1570, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1439, x = 0.3819, y = 0.4119,
        name = { enUS = "Thelgrum Stonehammer", deDE = "Thelgrum Stonehammer", esES = "Thelgrum Rocamartillo", esMX = "Thelgrum Rocamartillo", frFR = "Thelgrum Stonehammer", koKR = "텔그럼 스톤해머", ptBR = "Thelgrum Rochamalho", ruRU = "Тельгрум Камнемолот", zhCN = "瑟尔格拉姆·石锤", zhTW = "瑟爾格拉姆·石錘" },
    },
    {
        id = 1571, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1439, x = 0.3819, y = 0.4061,
        name = { enUS = "Valdaron", deDE = "Valdaron", esES = "Valdaron", esMX = "Valdaron", frFR = "Valdaron", koKR = "발다론", ptBR = "Valdaron", ruRU = "Вальдарон", zhCN = "瓦尔达隆", zhTW = "瓦爾達隆" },
    },
    {
        id = 1572, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1440, x = 0.5080, y = 0.6701,
        name = { enUS = "Harklan Moongrove", deDE = "Harklan Moongrove", esES = "Harklan Arboluna", esMX = "Harklan Arboluna", frFR = "Harklan Moongrove", koKR = "하클란 문그로브", ptBR = "Harklan Bosqueluna", ruRU = "Харклан Лунная Роща", zhCN = "哈克兰·月林", zhTW = "哈克蘭·月林" },
    },
    {
        id = 1573, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1440, x = 0.1820, y = 0.6000,
        name = { enUS = "Harlown Darkweave", deDE = "Harlown Darkweave", esES = "Harlown Tejeoscuro", esMX = "Harlown Tejeoscuro", frFR = "Harlown Darkweave", koKR = "하론 다크위브", ptBR = "Harlown Tecetreva", ruRU = "Харлон Темный Узор", zhCN = "哈鲁恩·暗纹", zhTW = "哈魯恩·暗紋" },
    },
    {
        id = 1574, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1440, x = 0.3480, y = 0.4980,
        name = { enUS = "Lardan", deDE = "Lardan", esES = "Lardan", esMX = "Lardan", frFR = "Lardan", koKR = "라드란", ptBR = "Lardan", ruRU = "Лардан", zhCN = "拉尔丹", zhTW = "拉爾丹" },
    },
    {
        id = 1575, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1441, x = 0.7770, y = 0.7791,
        name = { enUS = "Jinky Twizzlefixxit", deDE = "Jinky Twizzlefixxit", esES = "Jinky Arreglatodo", esMX = "Jinky Arreglatodo", frFR = "Jinky Twizzlefixxit", koKR = "진키 트위즐픽시트", ptBR = "Jinqui Peguestiquepuxa", ruRU = "Джинки Дзыньбламбум", zhCN = "金克·铁钩", zhTW = "金克·鐵鉤" },
    },
    {
        id = 1576, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1444, x = 0.8900, y = 0.4599,
        name = { enUS = "Brienna Starglow", deDE = "Brienna Starglow", esES = "Brienna Brillastrella", esMX = "Brienna Brillastrella", frFR = "Brienna Starglow", koKR = "브리에나 스타글로", ptBR = "Brienna Cintiluna", ruRU = "Бриенна Мерцание Звезд", zhCN = "布琳娜·星光", zhTW = "布琳娜·星光" },
    },
    {
        id = 1577, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1444, x = 0.7609, y = 0.4331,
        name = { enUS = "Bronk", deDE = "Bronk", esES = "Bronk", esMX = "Bronk", frFR = "Bronk", koKR = "브론크", ptBR = "Bronk", ruRU = "Бронк", zhCN = "布隆克", zhTW = "布隆克" },
    },
    {
        id = 1578, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1444, x = 0.7440, y = 0.4291,
        name = { enUS = "Jangdor Swiftstrider", deDE = "Jangdor Swiftstrider", esES = "Jangdor Zanco Veloz", esMX = "Jangdor Zanco Veloz", frFR = "Jangdor Swiftstrider", koKR = "장도르 스위프트스트라이더", ptBR = "Jangdor Passo Veloz", ruRU = "Джангор Быстрый Странник", zhCN = "杉多尔·迅蹄", zhTW = "杉多爾·迅蹄" },
    },
    {
        id = 1579, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1444, x = 0.3270, y = 0.4400,
        name = { enUS = "Logannas", deDE = "Logannas", esES = "Logannas", esMX = "Logannas", frFR = "Logannas", koKR = "로간나스", ptBR = "Logannas", ruRU = "Логаннас", zhCN = "洛加纳斯", zhTW = "洛加納斯" },
    },
    {
        id = 1580, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1444, x = 0.3060, y = 0.4271,
        name = { enUS = "Pratt McGrubben", deDE = "Pratt McGrubben", esES = "Pratt McGrubben", esMX = "Pratt McGrubben", frFR = "Pratt McGrubben", koKR = "프랫 맥그루벤", ptBR = "Pradal McGrubben", ruRU = "Пратт Макгруббен", zhCN = "普拉特·马克格鲁比", zhTW = "普拉特·馬克格魯比" },
    },
    {
        id = 1581, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1445, x = 0.3509, y = 0.3078,
        name = { enUS = "Ghok'kah", deDE = "Ghok'kah", esES = "Ghok'kah", esMX = "Ghok'kah", frFR = "Ghok'kah", koKR = "그호카", ptBR = "Ghok'kah", ruRU = "Гхок'ка", zhCN = "格鲁克卡恩", zhTW = "格魯克卡恩" },
    },
    {
        id = 1582, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1445, x = 0.6410, y = 0.4770,
        name = { enUS = "Uma Bartulm", deDE = "Uma Bartulm", esES = "Uma Bartulm", esMX = "Uma Bartulm", frFR = "Uma Bartulm", koKR = "우마 발툼", ptBR = "Uma Bartulm", ruRU = "Ума Бартулм", zhCN = "乌玛·巴图姆", zhTW = "烏瑪·巴圖姆" },
    },
    {
        id = 1583, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1446, x = 0.5090, y = 0.2701,
        name = { enUS = "Alchemist Pestlezugg", deDE = "Alchimist Pestlezugg", esES = "Alquimista Morterozugg", esMX = "Alquimista Morterozugg", frFR = "Alchimiste Pestlezugg", koKR = "연금술사 페슬저그", ptBR = "Alquimista Almofarrista", ruRU = "Алхимик Пестычинс", zhCN = "炼金师匹斯特苏格", zhTW = "鍊金師匹斯特蘇格" },
    },
    {
        id = 1584, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Neutral", map = 1446, x = 0.5150, y = 0.2880,
        name = { enUS = "Krinkle Goodsteel", deDE = "Krinkle Goodsteel", esES = "Krinkle Buenacero", esMX = "Krinkle Buenacero", frFR = "Krinkle Goodsteel", koKR = "크린클 굿스틸", ptBR = "Rugov A. Massoaço", ruRU = "Кринкель Сталлер", zhCN = "克林科·古德斯迪尔", zhTW = "克林科·古德斯迪爾" },
    },
    {
        id = 1585, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1446, x = 0.5099, y = 0.2741,
        name = { enUS = "Vizzklick", deDE = "Vizzklick", esES = "Vizzklick", esMX = "Vizzklick", frFR = "Vizzklick", koKR = "비즈클릭", ptBR = "Linhagulha", ruRU = "Визглик", zhCN = "维兹格里克", zhTW = "維茲格里克" },
    },
    {
        id = 1586, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1450, x = 0.5153, y = 0.3332,
        name = { enUS = "Darnall", deDE = "Darnall", esES = "Darnall", esMX = "Darnall", frFR = "Darnall", koKR = "다르날", ptBR = "Darnall", ruRU = "Дарналл", zhCN = "旅店老板达纳尔", zhTW = "旅店老闆達納爾" },
    },
    {
        id = 1587, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1451, x = 0.8200, y = 0.1769,
        name = { enUS = "Zannok Hidepiercer", deDE = "Zannok Hidepiercer", esES = "Zannok Perforapieles", esMX = "Zannok Perforapieles", frFR = "Zannok Hidepiercer", koKR = "잔노크 하이드피어서", ptBR = "Zannok Furacouro", ruRU = "Заннок Проткни-Шкуру", zhCN = "扎诺克", zhTW = "札諾克" },
    },
    {
        id = 1588, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1452, x = 0.6080, y = 0.3780,
        name = { enUS = "Evie Whirlbrew", deDE = "Evie Whirlbrew", esES = "Evie Brebegira", esMX = "Evie Brebegira", frFR = "Evie Whirlbrew", koKR = "에비 휠브루", ptBR = "Evie Rodacerva", ruRU = "Иви Бурноварка", zhCN = "埃文·维布鲁", zhTW = "埃文·維布魯" },
    },
    {
        id = 1589, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 1452, x = 0.6080, y = 0.3859,
        name = { enUS = "Xizzer Fizzbolt", deDE = "Xizzer Fizzbolt", esES = "Xizzer Raybuja", esMX = "Xizzer Raybuja", frFR = "Xizzer Fizzbolt", koKR = "시저 피즈볼트", ptBR = "Xizto Frisarraio", ruRU = "Ксиззер Шумоболт", zhCN = "希兹尔·菲兹波特", zhTW = "希茲爾·菲茲波特" },
    },
    {
        id = 1590, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.5312, y = 0.8186,
        name = { enUS = "Alexandra Bolero", deDE = "Alexandra Bolero", esES = "Alexandra Bolero", esMX = "Alexandra Bolero", frFR = "Alexandra Bolero", koKR = "알렉산드라 볼레로", ptBR = "Alexandra Bolero", ruRU = "Александра Болеро", zhCN = "亚历山德拉·波利罗", zhTW = "亞歷山卓·波利羅" },
    },
    {
        id = 1591, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.5918, y = 0.3754,
        name = { enUS = "Brooke Stonebraid", deDE = "Brooke Stonebraid", esES = "Brooke Petratrenza", esMX = "Brooke Petratrenza", frFR = "Brooke Stonebraid", koKR = "브루크 스톤브레이드", ptBR = "Brooke Petranças", ruRU = "Бруки Каменная Коса", zhCN = "布鲁克·石衣", zhTW = "布魯克·石衣" },
    },
    {
        id = 1592, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.5580, y = 0.8531,
        name = { enUS = "Eldraeith", deDE = "Eldraeith", esES = "Eldraeith", esMX = "Eldraeith", frFR = "Eldraeith", koKR = "엘드라이스", ptBR = "Eldraeith", ruRU = "Элдрейт", zhCN = "艾达伊斯", zhTW = "艾達伊斯" },
    },
    {
        id = 1593, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.7852, y = 0.5285,
        name = { enUS = "Erika Tate", deDE = "Erika Tate", esES = "Erika Tate", esMX = "Erika Tate", frFR = "Erika Tate", koKR = "에리카 테이트", ptBR = "Erika Tate", ruRU = "Эрика Тейт", zhCN = "艾瑞卡·塔特", zhTW = "艾瑞卡·塔特" },
    },
    {
        id = 1594, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.6931, y = 0.7127,
        name = { enUS = "Felicia Gump", deDE = "Felicia Gump", esES = "Felicia Gump", esMX = "Felicia Gump", frFR = "Felicia Gump", koKR = "펠리시아 검프", ptBR = "Felicia Gump", ruRU = "Фелисия Гамп", zhCN = "菲利希亚·加姆", zhTW = "菲利希亞·加姆" },
    },
    {
        id = 1595, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.5281, y = 0.7426,
        name = { enUS = "Jessara Cordell", deDE = "Jessara Cordell", esES = "Jessara Cordell", esMX = "Jessara Cordell", frFR = "Jessara Cordell", koKR = "예사라 코르델", ptBR = "Jussara Cordel", ruRU = "Джессара Корделл", zhCN = "杰萨拉·考迪尔", zhTW = "傑薩拉·考迪爾" },
    },
    {
        id = 1596, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.7161, y = 0.6275,
        name = { enUS = "Jillian Tanner", deDE = "Jillian Tanner", esES = "Jillian Peletero", esMX = "Jillian Peletero", frFR = "Jillian Tanner", koKR = "질리안 터너", ptBR = "Nara Correia", ruRU = "Джиллиан Дубильщица", zhCN = "基利安·坦纳尔", zhTW = "基利安·坦納爾" },
    },
    {
        id = 1597, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6332, y = 0.3765,
        name = { enUS = "Kaita Deepforge", deDE = "Kaita Deepforge", esES = "Kaita Forjahonda", esMX = "Kaita Forjahonda", frFR = "Kaita Deepforge", koKR = "카이타 딥포지", ptBR = "Kaita Baixaforja", ruRU = "Кайта Подземная Кузня", zhCN = "凯塔·深炉", zhTW = "凱塔·深爐" },
    },
    {
        id = 1598, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1453, x = 0.5588, y = 0.8565,
        name = { enUS = "Maria Lumere", deDE = "Maria Lumere", esES = "Maria Lumere", esMX = "Maria Lumere", frFR = "Maria Lumere", koKR = "마리아 루메르", ptBR = "Maria Lumere", ruRU = "Мария Лумере", zhCN = "玛丽亚·卢米尔", zhTW = "瑪麗亞·盧米爾" },
    },
    {
        id = 1599, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.6308, y = 0.5137,
        name = { enUS = "Borya", deDE = "Borya", esES = "Borya", esMX = "Borya", frFR = "Borya", koKR = "보르야", ptBR = "Borya", ruRU = "Боря", zhCN = "博亚", zhTW = "博亞" },
    },
    {
        id = 1600, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.7334, y = 0.2657,
        name = { enUS = "Gorina", deDE = "Gorina", esES = "Gorina", esMX = "Gorina", frFR = "Gorina", koKR = "고리나", ptBR = "Gorina", ruRU = "Горина", zhCN = "高里纳", zhTW = "高里納" },
    },
    {
        id = 1601, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.5386, y = 0.3797,
        name = { enUS = "Kithas", deDE = "Kithas", esES = "Kithas", esMX = "Kithas", frFR = "Kithas", koKR = "키타스", ptBR = "Kithas", ruRU = "Китхас", zhCN = "基萨斯", zhTW = "基薩斯" },
    },
    {
        id = 1602, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.5614, y = 0.3412,
        name = { enUS = "Kor'geld", deDE = "Kor'geld", esES = "Kor'geld", esMX = "Kor'geld", frFR = "Kor'geld", koKR = "코르겔드", ptBR = "Kor'geld", ruRU = "Кор'гельд", zhCN = "考吉尔德", zhTW = "考吉爾德" },
    },
    {
        id = 1603, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.7553, y = 0.2543,
        name = { enUS = "Sovik", deDE = "Sovik", esES = "Sovik", esMX = "Sovik", frFR = "Sovik", koKR = "소빅", ptBR = "Sovik", ruRU = "Совик", zhCN = "索维克", zhTW = "索維克" },
    },
    {
        id = 1604, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.6298, y = 0.4553,
        name = { enUS = "Tamar", deDE = "Tamar", esES = "Tamar", esMX = "Tamar", frFR = "Tamar", koKR = "타마르", ptBR = "Tamar", ruRU = "Тамар", zhCN = "达玛尔", zhTW = "達瑪爾" },
    },
    {
        id = 1605, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.5756, y = 0.5294,
        name = { enUS = "Xen'to", deDE = "Xen'to", esES = "Xen'to", esMX = "Xen'to", frFR = "Xen'to", koKR = "센토", ptBR = "Xen'to", ruRU = "Ксен'то", zhCN = "克森图", zhTW = "克森圖" },
    },
    {
        id = 1606, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1454, x = 0.5500, y = 0.3940,
        name = { enUS = "Zeal'aya", deDE = "Zeal'aya", esES = "Zeal'aya", esMX = "Zeal'aya", frFR = "Zeal'aya", koKR = "질아야", ptBR = "Zeal'aya", ruRU = "Зил'айя", zhCN = "希尔拉亚", zhTW = "希爾拉亞" },
    },
    {
        id = 1607, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.3430, y = 0.5662,
        name = { enUS = "Kurm Stonehoof", deDE = "Krum Stonehoof", esES = "Kurm Pezuñapétrea", esMX = "Kurm Pezuña Pétrea", frFR = "Kurm Stonehoof", koKR = "쿠름 스톤후프", ptBR = "Kirm Casco de Pedra", ruRU = "Курм Каменное Копыто", zhCN = "卡姆·石蹄", zhTW = "卡姆·石蹄" },
    },
    {
        id = 1608, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.4375, y = 0.4513,
        name = { enUS = "Mahu", deDE = "Mahu", esES = "Mahu", esMX = "Mahu", frFR = "Mahu", koKR = "마후", ptBR = "Mahu", ruRU = "Маху", zhCN = "曼胡", zhTW = "曼胡" },
    },
    {
        id = 1609, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.4746, y = 0.3363,
        name = { enUS = "Mani Winterhoof", deDE = "Mani Winterhoof", esES = "Mani Pezuña Invernal", esMX = "Mani Pezuña Invernal", frFR = "Mani Winterhoof", koKR = "마니 윈터후프", ptBR = "Mani Casco Invernal", ruRU = "Мани Заиндевевшее Копыто", zhCN = "曼尼·冰蹄", zhTW = "曼尼·冰蹄" },
    },
    {
        id = 1610, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.5103, y = 0.5241,
        name = { enUS = "Naal Mistrunner", deDE = "Naal Mistrunner", esES = "Naal Correbruma", esMX = "Naal Correbruma", frFR = "Naal Mistrunner", koKR = "나알 미스트러너", ptBR = "Naal Corre com a Névoa", ruRU = "Наал Вестник Туманов", zhCN = "纳尔·迷雾行者", zhTW = "納爾·迷霧行者" },
    },
    {
        id = 1611, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.4503, y = 0.3880,
        name = { enUS = "Nata Dawnstrider", deDE = "Nata Dawnstrider", esES = "Nata Caminalba", esMX = "Nata Caminalba", frFR = "Nata Dawnstrider", koKR = "나타 던스트라이더", ptBR = "Nata Andarilho da Aurora", ruRU = "Ната Рассветная Странница", zhCN = "纳塔·黎明行者", zhTW = "納塔·晨行者" },
    },
    {
        id = 1612, types = { "vendor-profsupplies" },
        faction = "Horde", map = 1456, x = 0.4963, y = 0.3957,
        name = { enUS = "Nida Winterhoof", deDE = "Nida Winterhoof", esES = "Nida Pezuña Invernal", esMX = "Nida Pezuña Invernal", frFR = "Nida Winterhoof", koKR = "니다 윈터후프", ptBR = "Nida Casco Invernal", ruRU = "Нида Заиндевевшее Копыто", zhCN = "尼达·冰蹄", zhTW = "尼達·冰蹄" },
    },
    {
        id = 1613, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.3979, y = 0.5566,
        name = { enUS = "Taur Stonehoof", deDE = "Taur Stonehoof", esES = "Taur Pezuñapétrea", esMX = "Taur Pezuña Pétrea", frFR = "Taur Stonehoof", koKR = "타우르 스톤후프", ptBR = "Taur Casco de Pedra", ruRU = "Тавр Каменное Копыто", zhCN = "陶尔·石蹄", zhTW = "陶爾·石蹄" },
    },
    {
        id = 1614, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.4848, y = 0.6891,
        name = { enUS = "Chardryn", deDE = "Chardryn", esES = "Chardryn", esMX = "Chardryn", frFR = "Chardryn", koKR = "차르드린", ptBR = "Chardryn", ruRU = "Шардрин", zhCN = "查德瑞恩", zhTW = "查德瑞恩" },
    },
    {
        id = 1615, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.6460, y = 0.2168,
        name = { enUS = "Elynna", deDE = "Elynna", esES = "Elynna", esMX = "Elynna", frFR = "Elynna", koKR = "엘리나", ptBR = "Elynna", ruRU = "Элинна", zhCN = "艾琳娜", zhTW = "愛琳娜" },
    },
    {
        id = 1616, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.4848, y = 0.2168,
        name = { enUS = "Fyldan", deDE = "Fyldan", esES = "Fyldan", esMX = "Fyldan", frFR = "Fyldan", koKR = "필단", ptBR = "Fyldan", ruRU = "Филдан", zhCN = "菲尔丹", zhTW = "菲爾丹" },
    },
    {
        id = 1617, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.6372, y = 0.2224,
        name = { enUS = "Saenorion", deDE = "Saenorion", esES = "Saenorion", esMX = "Saenorion", frFR = "Saenorion", koKR = "새노리온", ptBR = "Saenorion", ruRU = "Санарион", zhCN = "塞诺里奥", zhTW = "塞諾里奧" },
    },
    {
        id = 1618, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.5578, y = 0.2451,
        name = { enUS = "Ulthir", deDE = "Ulthir", esES = "Ulthir", esMX = "Ulthir", frFR = "Ulthir", koKR = "울시르", ptBR = "Ulthir", ruRU = "Ультир", zhCN = "尤希尔", zhTW = "尤希爾" },
    },
    {
        id = 1619, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 1457, x = 0.5855, y = 0.1469,
        name = { enUS = "Vaean", deDE = "Vaean", esES = "Vaean", esMX = "Vaean", frFR = "Vaean", koKR = "바이안", ptBR = "Vaean", ruRU = "Ваеан", zhCN = "维安", zhTW = "維安" },
    },
    {
        id = 1620, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 2482, x = 0.6900, y = 0.4736,
        name = { enUS = "Toron Rockhoof", deDE = "Toron Rockhoof", esES = "Toron Rockhoof", esMX = "Toron Rockhoof", frFR = "Toron Rockhoof", koKR = "Toron Rockhoof", ptBR = "Toron Rockhoof", ruRU = "Toron Rockhoof", zhCN = "Toron Rockhoof", zhTW = "Toron Rockhoof" },
    },
    {
        id = 1621, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 2548, x = 0.7763, y = 0.5090,
        name = { enUS = "Kor'gar", deDE = "Kor'gar", esES = "Kor'gar", esMX = "Kor'gar", frFR = "Kor'gar", koKR = "Kor'gar", ptBR = "Kor'gar", ruRU = "Kor'gar", zhCN = "Kor'gar", zhTW = "Kor'gar" },
    },
    {
        id = 1622, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 2548, x = 0.7763, y = 0.5098,
        name = { enUS = "Kor'gar", deDE = "Kor'gar", esES = "Kor'gar", esMX = "Kor'gar", frFR = "Kor'gar", koKR = "Kor'gar", ptBR = "Kor'gar", ruRU = "Kor'gar", zhCN = "Kor'gar", zhTW = "Kor'gar" },
    },
    {
        id = 1623, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 2548, x = 0.7775, y = 0.5090,
        name = { enUS = "Kor'gar", deDE = "Kor'gar", esES = "Kor'gar", esMX = "Kor'gar", frFR = "Kor'gar", koKR = "Kor'gar", ptBR = "Kor'gar", ruRU = "Kor'gar", zhCN = "Kor'gar", zhTW = "Kor'gar" },
    },
    {
        id = 1624, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 2548, x = 0.7771, y = 0.5200,
        name = { enUS = "Mika Darby", deDE = "Mika Darby", esES = "Mika Darby", esMX = "Mika Darby", frFR = "Mika Darby", koKR = "Mika Darby", ptBR = "Mika Darby", ruRU = "Mika Darby", zhCN = "Mika Darby", zhTW = "Mika Darby" },
    },
    {
        id = 1625, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 2548, x = 0.7778, y = 0.5202,
        name = { enUS = "Mika Darby", deDE = "Mika Darby", esES = "Mika Darby", esMX = "Mika Darby", frFR = "Mika Darby", koKR = "Mika Darby", ptBR = "Mika Darby", ruRU = "Mika Darby", zhCN = "Mika Darby", zhTW = "Mika Darby" },
    },
    {
        id = 1626, types = { "vendor-profsupplies", "vendor-repair" },
        faction = "Alliance", map = 2548, x = 0.7780, y = 0.5211,
        name = { enUS = "Mika Darby", deDE = "Mika Darby", esES = "Mika Darby", esMX = "Mika Darby", frFR = "Mika Darby", koKR = "Mika Darby", ptBR = "Mika Darby", ruRU = "Mika Darby", zhCN = "Mika Darby", zhTW = "Mika Darby" },
    },
    {
        id = 1627, types = { "vendor-profsupplies" },
        faction = "Alliance", map = 2548, x = 0.6348, y = 0.8244,
        name = { enUS = "Miranda Turner", deDE = "Miranda Turner", esES = "Miranda Turner", esMX = "Miranda Turner", frFR = "Miranda Turner", koKR = "Miranda Turner", ptBR = "Miranda Turner", ruRU = "Miranda Turner", zhCN = "Miranda Turner", zhTW = "Miranda Turner" },
    },
    {
        id = 1628, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 2548, x = 0.7725, y = 0.5142,
        name = { enUS = "Stitch Pinwizzle", deDE = "Stitch Pinwizzle", esES = "Stitch Pinwizzle", esMX = "Stitch Pinwizzle", frFR = "Stitch Pinwizzle", koKR = "Stitch Pinwizzle", ptBR = "Stitch Pinwizzle", ruRU = "Stitch Pinwizzle", zhCN = "Stitch Pinwizzle", zhTW = "Stitch Pinwizzle" },
    },
    {
        id = 1629, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 2548, x = 0.7726, y = 0.5187,
        name = { enUS = "Stitch Pinwizzle", deDE = "Stitch Pinwizzle", esES = "Stitch Pinwizzle", esMX = "Stitch Pinwizzle", frFR = "Stitch Pinwizzle", koKR = "Stitch Pinwizzle", ptBR = "Stitch Pinwizzle", ruRU = "Stitch Pinwizzle", zhCN = "Stitch Pinwizzle", zhTW = "Stitch Pinwizzle" },
    },
    {
        id = 1630, types = { "vendor-profsupplies" },
        faction = "Neutral", map = 2548, x = 0.7735, y = 0.5141,
        name = { enUS = "Stitch Pinwizzle", deDE = "Stitch Pinwizzle", esES = "Stitch Pinwizzle", esMX = "Stitch Pinwizzle", frFR = "Stitch Pinwizzle", koKR = "Stitch Pinwizzle", ptBR = "Stitch Pinwizzle", ruRU = "Stitch Pinwizzle", zhCN = "Stitch Pinwizzle", zhTW = "Stitch Pinwizzle" },
    },
    {
        id = 1631, types = { "vendor-reagents" },
        faction = "Horde", map = 1413, x = 0.5140, y = 0.3020,
        name = { enUS = "Hula'mahi", deDE = "Hula'mahi", esES = "Hula'mahi", esMX = "Hula'mahi", frFR = "Hula'mahi", koKR = "훌라마히", ptBR = "Hula'mahi", ruRU = "Хула'махи", zhCN = "哈拉玛", zhTW = "哈拉瑪" },
    },
    {
        id = 1632, types = { "vendor-reagents" },
        faction = "Alliance", map = 1417, x = 0.2700, y = 0.5878,
        name = { enUS = "Deneb Walker", deDE = "Deneb Walker", esES = "Deneb Camino", esMX = "Deneb Camino", frFR = "Deneb Walker", koKR = "데네브 워커", ptBR = "Deneb Walker", ruRU = "Денеб Уокер", zhCN = "德尼布·沃克", zhTW = "德尼布·沃克" },
    },
    {
        id = 1633, types = { "vendor-reagents" },
        faction = "Horde", map = 1420, x = 0.6539, y = 0.6839,
        name = { enUS = "Hannah Akeley", deDE = "Hannah Akeley", esES = "Hannah Akeley", esMX = "Hannah Akeley", frFR = "Hannah Akeley", koKR = "하나 아켈리", ptBR = "Júlia Alvarenga", ruRU = "Ханна Экли", zhCN = "汉娜·阿克雷", zhTW = "漢娜·阿克雷" },
    },
    {
        id = 1634, types = { "vendor-reagents" },
        faction = "Horde", map = 1420, x = 0.6261, y = 0.7334,
        name = { enUS = "Thomas Mordan", deDE = "Thomas Mordan", esES = "Thomas Mordan", esMX = "Thomas Mordan", frFR = "Thomas Mordan", koKR = "토마스 모던", ptBR = "Thomas Mordan", ruRU = "Томас Морден", zhCN = "托马斯·莫丹", zhTW = "湯瑪斯·莫丹" },
    },
    {
        id = 1635, types = { "vendor-reagents" },
        faction = "Horde", map = 1425, x = 0.7881, y = 0.7818,
        name = { enUS = "Mystic Yayo'jin", deDE = "Mystikerin Yayo'jin", esES = "Místico Yayo'jin", esMX = "Mística Yayo'jin", frFR = "Yayo'jin la Mystique", koKR = "비술사 야요진", ptBR = "Mística Yayo'jin", ruRU = "Мистик Яо'джин", zhCN = "秘法师雅尔金", zhTW = "秘法師雅爾金" },
    },
    {
        id = 1636, types = { "vendor-reagents" },
        faction = "Alliance", map = 1426, x = 0.5416, y = 0.3010,
        name = { enUS = "Barim Jurgenstaad", deDE = "Barim Jurgenstaad", esES = "Barim Jurgenstaad", esMX = "Barim Jurgenstaad", frFR = "Barim Jurgenstaad", koKR = "바림 유르겐슈타드", ptBR = "Barim Jurgenstaad", ruRU = "Барим Юргенштад", zhCN = "巴瑞姆·贾根斯塔德", zhTW = "巴瑞姆·賈根斯塔德" },
    },
    {
        id = 1637, types = { "vendor-reagents" },
        faction = "Alliance", map = 1426, x = 0.5611, y = 0.2555,
        name = { enUS = "Ginny Longberry", deDE = "Ginny Longberry", esES = "Ginny Longamora", esMX = "Ginny Longamora", frFR = "Ginny Longberry", koKR = "지니 롱베리", ptBR = "Ginny Longafruta", ruRU = "Гинни Ежевичка", zhCN = "吉恩", zhTW = "金妮·長莓" },
    },
    {
        id = 1638, types = { "vendor-reagents" },
        faction = "Alliance", map = 1429, x = 0.6491, y = 0.6920,
        name = { enUS = "Dawn Brightstar", deDE = "Dawn Brightstar", esES = "Estrella brillante del alba", esMX = "Estrella brillante del alba", frFR = "Dawn Brightstar", koKR = "던 브라이트스타", ptBR = "Estela Dalva", ruRU = "Дон Брайтстар", zhCN = "当恩·布赖特斯塔", zhTW = "當恩·布賴特斯塔" },
    },
    {
        id = 1639, types = { "vendor-reagents" },
        faction = "Alliance", map = 1431, x = 0.7600, y = 0.4530,
        name = { enUS = "Alyssa Eva", deDE = "Alyssa Eva", esES = "Alyssa Eva", esMX = "Alyssa Eva", frFR = "Alyssa Eva", koKR = "알리사 에바", ptBR = "Alice Veloso", ruRU = "Алисса Ева", zhCN = "奥利萨·伊瓦", zhTW = "艾莉莎·伊瓦" },
    },
    {
        id = 1640, types = { "vendor-reagents" },
        faction = "Horde", map = 1435, x = 0.4579, y = 0.5278,
        name = { enUS = "Thultazor", deDE = "Thultazor", esES = "Thultazor", esMX = "Thultazor", frFR = "Thultazor", koKR = "툴타조르", ptBR = "Thultazor", ruRU = "Тултазор", zhCN = "苏塔佐尔", zhTW = "蘇塔佐爾" },
    },
    {
        id = 1641, types = { "vendor-reagents" },
        faction = "Alliance", map = 1437, x = 0.0831, y = 0.5650,
        name = { enUS = "Falkan Armonis", deDE = "Falkan Armonis", esES = "Falkan Armonis", esMX = "Falkan Armonis", frFR = "Falkan Armonis", koKR = "팔칸 아르모니스", ptBR = "Falcan Armonis", ruRU = "Фолькан Армонис", zhCN = "法尔坎·阿莫尼斯", zhTW = "法爾坎·阿莫尼斯" },
    },
    {
        id = 1642, types = { "vendor-reagents" },
        faction = "Alliance", map = 1440, x = 0.3501, y = 0.4848,
        name = { enUS = "Llana", deDE = "Llana", esES = "Llana", esMX = "Llana", frFR = "Llana", koKR = "라나", ptBR = "Llana", ruRU = "Ллана", zhCN = "蓝纳", zhTW = "藍納" },
    },
    {
        id = 1643, types = { "vendor-reagents" },
        faction = "Horde", map = 1441, x = 0.4509, y = 0.5082,
        name = { enUS = "Montarr", deDE = "Montarr", esES = "Montarr", esMX = "Montarr", frFR = "Montarr", koKR = "몬타르", ptBR = "Montarr", ruRU = "Монтарр", zhCN = "莫塔尔", zhTW = "莫塔爾" },
    },
    {
        id = 1644, types = { "vendor-reagents" },
        faction = "Horde", map = 1442, x = 0.4760, y = 0.6160,
        name = { enUS = "Jeeda", deDE = "Jeeda", esES = "Jeeda", esMX = "Jeeda", frFR = "Jeeda", koKR = "지다", ptBR = "Jeeda", ruRU = "Джиида", zhCN = "基达", zhTW = "基達" },
    },
    {
        id = 1645, types = { "vendor-reagents" },
        faction = "Alliance", map = 1444, x = 0.3089, y = 0.4210,
        name = { enUS = "Jadenvis Seawatcher", deDE = "Jadenvis Seawatcher", esES = "Jadenvis Guardamar", esMX = "Jadenvis Guardamar", frFR = "Jadenvis Seawatcher", koKR = "자덴비스 시와처", ptBR = "Jadenvis Marvigia", ruRU = "Джаденвис Страж Морей", zhCN = "亚德维斯·观海者", zhTW = "亞德維斯·觀海者" },
    },
    {
        id = 1646, types = { "vendor-reagents" },
        faction = "Horde", map = 1444, x = 0.7459, y = 0.4489,
        name = { enUS = "Tarhus", deDE = "Tarhus", esES = "Tarhus", esMX = "Tarhus", frFR = "Tarhus", koKR = "탈후스", ptBR = "Tarhus", ruRU = "Тархус", zhCN = "塔霍斯", zhTW = "塔霍斯" },
    },
    {
        id = 1647, types = { "vendor-reagents" },
        faction = "Horde", map = 1445, x = 0.3649, y = 0.3040,
        name = { enUS = "Balai Lok'Wein", deDE = "Balai Lok'Wein", esES = "Balai Lok'Wein", esMX = "Balai Lok'Wein", frFR = "Balai Lok'Wein", koKR = "발라이 로크웨인", ptBR = "Balai Lok'Wein", ruRU = "Бала Лок'Вен", zhCN = "巴莱·洛克维", zhTW = "巴萊·洛克維" },
    },
    {
        id = 1648, types = { "vendor-reagents" },
        faction = "Neutral", map = 1451, x = 0.4869, y = 0.3698,
        name = { enUS = "Khur Hornstriker", deDE = "Khur Hornstriker", esES = "Khur Golpicórneo", esMX = "Khur Cornada", frFR = "Khur Hornstriker", koKR = "쿠르 혼스트라이커", ptBR = "Khiran Chifre Curto", ruRU = "Кхур Острый Рог", zhCN = "库尔·锐角", zhTW = "庫爾·銳角" },
    },
    {
        id = 1649, types = { "vendor-reagents" },
        faction = "Neutral", map = 1452, x = 0.5890, y = 0.7839,
        name = { enUS = "Vi'el", deDE = "Vi'el", esES = "Vi'el", esMX = "Vi'el", frFR = "Vi'el", koKR = "비엘", ptBR = "Vi'el", ruRU = "Ви'ел", zhCN = "维尔", zhTW = "維爾" },
    },
    {
        id = 1650, types = { "vendor-reagents" },
        faction = "Alliance", map = 1453, x = 0.5327, y = 0.4525,
        name = { enUS = "Brother Cassius", deDE = "Bruder Cassius", esES = "Hermano Cassius", esMX = "Hermano Cassius", frFR = "Frère Cassius", koKR = "수사 카시우스", ptBR = "Irmão Cassius", ruRU = "Брат Кассий", zhCN = "卡苏斯修士", zhTW = "卡蘇斯修士" },
    },
    {
        id = 1651, types = { "vendor-reagents" },
        faction = "Alliance", map = 1453, x = 0.4460, y = 0.8623,
        name = { enUS = "Charys Yserian", deDE = "Charys Yserian", esES = "Charys Yserian", esMX = "Charys Yserian", frFR = "Charys Yserian", koKR = "차리스 이세리안", ptBR = "Andréa Iserian", ruRU = "Чариса Изериан", zhCN = "查瑞斯·伊瑟里安", zhTW = "查瑞斯·伊瑟里安" },
    },
    {
        id = 1652, types = { "vendor-reagents" },
        faction = "Alliance", map = 1453, x = 0.6279, y = 0.7495,
        name = { enUS = "Keldric Boucher", deDE = "Keldric Boucher", esES = "Keldric Señalo", esMX = "Keldric Señalo", frFR = "Keldric Boucher", koKR = "켈드릭 바우처", ptBR = "Orlande Bórgia", ruRU = "Келдрик Буше", zhCN = "凯德雷克·布舍尔", zhTW = "凱德雷克·布舍爾" },
    },
    {
        id = 1653, types = { "vendor-reagents" },
        faction = "Alliance", map = 1453, x = 0.6309, y = 0.7495,
        name = { enUS = "Kyra Boucher", deDE = "Kyra Boucher", esES = "Kyra Señalo", esMX = "Kyra Señalo", frFR = "Kyra Boucher", koKR = "키라 바우처", ptBR = "Kavia Bórgia", ruRU = "Кайра Буше", zhCN = "凯拉·布舍尔", zhTW = "凱拉·布舍爾" },
    },
    {
        id = 1654, types = { "vendor-reagents" },
        faction = "Alliance", map = 1453, x = 0.4736, y = 0.8255,
        name = { enUS = "Owen Vaughn", deDE = "Owen Vaughn", esES = "Owen Vaughn", esMX = "Owen Vaughn", frFR = "Owen Vaughn", koKR = "오웬 바우그", ptBR = "Anísio Nonato", ruRU = "Оуэн Вон", zhCN = "欧文·沃弗恩", zhTW = "歐文·沃弗恩" },
    },
    {
        id = 1655, types = { "vendor-reagents" },
        faction = "Horde", map = 1454, x = 0.4597, y = 0.4567,
        name = { enUS = "Hagrus", deDE = "Hagrus", esES = "Hagrus", esMX = "Hagrus", frFR = "Hagrus", koKR = "하그루스", ptBR = "Hagrus", ruRU = "Хагрус", zhCN = "哈格鲁斯", zhTW = "哈格魯斯" },
    },
    {
        id = 1656, types = { "vendor-reagents" },
        faction = "Horde", map = 1454, x = 0.4540, y = 0.5650,
        name = { enUS = "Horthus", deDE = "Horthus", esES = "Horthus", esMX = "Horthus", frFR = "Horthus", koKR = "호르투스", ptBR = "Horthus", ruRU = "Хортус", zhCN = "霍苏斯", zhTW = "霍蘇斯" },
    },
    {
        id = 1657, types = { "vendor-reagents" },
        faction = "Horde", map = 1454, x = 0.4568, y = 0.4097,
        name = { enUS = "Magenius", deDE = "Magenius", esES = "Magenius", esMX = "Magenius", frFR = "Magenius", koKR = "마게니우스", ptBR = "Magenius", ruRU = "Магениус", zhCN = "玛基努斯", zhTW = "瑪基努斯" },
    },
    {
        id = 1658, types = { "vendor-reagents" },
        faction = "Horde", map = 1456, x = 0.3634, y = 0.5490,
        name = { enUS = "Chepi", deDE = "Chepi", esES = "Chepi", esMX = "Chepi", frFR = "Chepi", koKR = "체피", ptBR = "Chepi", ruRU = "Чепи", zhCN = "切比", zhTW = "切比" },
    },
    {
        id = 1659, types = { "vendor-reagents" },
        faction = "Alliance", map = 1457, x = 0.2983, y = 0.6985,
        name = { enUS = "Alaindia", deDE = "Alaindia", esES = "Alaindia", esMX = "Alaindia", frFR = "Alaindia", koKR = "알라인디아", ptBR = "Alaindia", ruRU = "Алианда", zhCN = "奥兰蒂亚", zhTW = "奧蘭蒂亞" },
    },
    {
        id = 1660, types = { "vendor-reagents" },
        faction = "Alliance", map = 1457, x = 0.3899, y = 0.7425,
        name = { enUS = "Alaindia", deDE = "Alaindia", esES = "Alaindia", esMX = "Alaindia", frFR = "Alaindia", koKR = "알라인디아", ptBR = "Alaindia", ruRU = "Алианда", zhCN = "奥兰蒂亚", zhTW = "奧蘭蒂亞" },
    },
    {
        id = 1661, types = { "vendor-reagents" },
        faction = "Alliance", map = 1457, x = 0.3386, y = 0.0959,
        name = { enUS = "Cyroen", deDE = "Cyroen", esES = "Ciroen", esMX = "Ciroen", frFR = "Cyroen", koKR = "키로엔", ptBR = "Cyroen", ruRU = "Кироен", zhCN = "塞罗恩", zhTW = "塞羅恩" },
    },
    {
        id = 1662, types = { "vendor-reagents" },
        faction = "Alliance", map = 2548, x = 0.6224, y = 0.8595,
        name = { enUS = "Marla Bell", deDE = "Marla Bell", esES = "Marla Bell", esMX = "Marla Bell", frFR = "Marla Bell", koKR = "Marla Bell", ptBR = "Marla Bell", ruRU = "Marla Bell", zhCN = "Marla Bell", zhTW = "Marla Bell" },
    },
    {
        id = 1663, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1411, x = 0.4050, y = 0.6798,
        name = { enUS = "Kzan Thornslash", deDE = "Kzan Thornslash", esES = "Kzan Trallafusta", esMX = "Kzan Trallafusta", frFR = "Kzan Thornslash", koKR = "크잔 손슬래시", ptBR = "Kzan Cortarrasga", ruRU = "Кзан Шипоруб", zhCN = "克赞·荆条", zhTW = "克贊·荊條" },
    },
    {
        id = 1664, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1411, x = 0.5200, y = 0.4048,
        name = { enUS = "Uhgar", deDE = "Uhgar", esES = "Uhgar", esMX = "Uhgar", frFR = "Uhgar", koKR = "우가르", ptBR = "Uhgar", ruRU = "Ухгар", zhCN = "尤加尔", zhTW = "尤加爾" },
    },
    {
        id = 1665, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1412, x = 0.4509, y = 0.6211,
        name = { enUS = "Mahnott Roughwound", deDE = "Mahnott Roughwound", esES = "Mahnott Heriondo", esMX = "Mahnott Heriondo", frFR = "Mahnott Roughwound", koKR = "마흐노트 러프운드", ptBR = "Mahnott Ferida Aberta", ruRU = "Махнотт Рваная Рана", zhCN = "玛诺特·深痕", zhTW = "瑪諾特·深痕" },
    },
    {
        id = 1666, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1412, x = 0.4379, y = 0.7781,
        name = { enUS = "Marjak Keenblade", deDE = "Marjak Keenblade", esES = "Marjak Buenfilo", esMX = "Marjak Buenfilo", frFR = "Marjak Keenblade", koKR = "마르작 킨블레이드", ptBR = "Marjak Lâmina Mordaz", ruRU = "Марджак Острый Клинок", zhCN = "马沙克·利刃", zhTW = "馬沙克·利刃" },
    },
    {
        id = 1667, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1413, x = 0.6345, y = 0.5874,
        name = { enUS = "Bryanna Embreeze", deDE = "Bryanna Embreeze", esES = "Bryanna Embreeze", esMX = "Bryanna Embreeze", frFR = "Bryanna Embreeze", koKR = "Bryanna Embreeze", ptBR = "Bryanna Embreeze", ruRU = "Bryanna Embreeze", zhCN = "Bryanna Embreeze", zhTW = "Bryanna Embreeze" },
    },
    {
        id = 1668, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1413, x = 0.6410, y = 0.5877,
        name = { enUS = "Bryanna Embreeze", deDE = "Bryanna Embreeze", esES = "Bryanna Embreeze", esMX = "Bryanna Embreeze", frFR = "Bryanna Embreeze", koKR = "Bryanna Embreeze", ptBR = "Bryanna Embreeze", ruRU = "Bryanna Embreeze", zhCN = "Bryanna Embreeze", zhTW = "Bryanna Embreeze" },
    },
    {
        id = 1669, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.6469, y = 0.3424,
        name = { enUS = "Creeg Bothunk", deDE = "Creeg Bothunk", esES = "Creeg Bothunk", esMX = "Creeg Bothunk", frFR = "Creeg Bothunk", koKR = "Creeg Bothunk", ptBR = "Creeg Bothunk", ruRU = "Creeg Bothunk", zhCN = "Creeg Bothunk", zhTW = "Creeg Bothunk" },
    },
    {
        id = 1670, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.6494, y = 0.3489,
        name = { enUS = "Creeg Bothunk", deDE = "Creeg Bothunk", esES = "Creeg Bothunk", esMX = "Creeg Bothunk", frFR = "Creeg Bothunk", koKR = "Creeg Bothunk", ptBR = "Creeg Bothunk", ruRU = "Creeg Bothunk", zhCN = "Creeg Bothunk", zhTW = "Creeg Bothunk" },
    },
    {
        id = 1671, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.6501, y = 0.3461,
        name = { enUS = "Creeg Bothunk", deDE = "Creeg Bothunk", esES = "Creeg Bothunk", esMX = "Creeg Bothunk", frFR = "Creeg Bothunk", koKR = "Creeg Bothunk", ptBR = "Creeg Bothunk", ruRU = "Creeg Bothunk", zhCN = "Creeg Bothunk", zhTW = "Creeg Bothunk" },
    },
    {
        id = 1672, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.4972, y = 0.2962,
        name = { enUS = "Gor'mak", deDE = "Gor'mak", esES = "Gor'mak", esMX = "Gor'mak", frFR = "Gor'mak", koKR = "Gor'mak", ptBR = "Gor'mak", ruRU = "Gor'mak", zhCN = "Gor'mak", zhTW = "Gor'mak" },
    },
    {
        id = 1673, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.4982, y = 0.2967,
        name = { enUS = "Gor'mak", deDE = "Gor'mak", esES = "Gor'mak", esMX = "Gor'mak", frFR = "Gor'mak", koKR = "Gor'mak", ptBR = "Gor'mak", ruRU = "Gor'mak", zhCN = "Gor'mak", zhTW = "Gor'mak" },
    },
    {
        id = 1674, types = { "vendor-repair", "vendor" },
        faction = "Horde", map = 1413, x = 0.4989, y = 0.2983,
        name = { enUS = "Gor'mak", deDE = "Gor'mak", esES = "Gor'mak", esMX = "Gor'mak", frFR = "Gor'mak", koKR = "Gor'mak", ptBR = "Gor'mak", ruRU = "Gor'mak", zhCN = "Gor'mak", zhTW = "Gor'mak" },
    },
    {
        id = 1675, types = { "vendor-repair" },
        faction = "Horde", map = 1413, x = 0.5109, y = 0.2900,
        name = { enUS = "Hraq", deDE = "Hraq", esES = "Hraq", esMX = "Hraq", frFR = "Hraq", koKR = "흐라크", ptBR = "Hraq", ruRU = "Храк", zhCN = "赫拉克", zhTW = "赫拉克" },
    },
    {
        id = 1676, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1413, x = 0.6220, y = 0.3750,
        name = { enUS = "Ironzar", deDE = "Ironzar", esES = "Hierrozar", esMX = "Hierrozar", frFR = "Ironzar", koKR = "아이언자르", ptBR = "Ferrozar", ruRU = "Чернозлат", zhCN = "艾隆萨尔", zhTW = "艾隆薩爾" },
    },
    {
        id = 1677, types = { "vendor-repair" },
        faction = "Horde", map = 1413, x = 0.4670, y = 0.0839,
        name = { enUS = "Kelm Hargunth", deDE = "Kelm Hargunth", esES = "Kelm Hargunth", esMX = "Kelm Hargunth", frFR = "Kelm Hargunth", koKR = "켈름 하건스", ptBR = "Kelm Hargunth", ruRU = "Кельм Харгюнт", zhCN = "凯尔姆·哈古斯", zhTW = "戰歌補給員哈古斯" },
    },
    {
        id = 1678, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1413, x = 0.6181, y = 0.3829,
        name = { enUS = "Lizzarik", deDE = "Lizzarik", esES = "Lizzarik", esMX = "Lizzarik", frFR = "Lizzarik", koKR = "리자리크", ptBR = "Lizzarik", ruRU = "Лиззарик", zhCN = "里扎雷克斯", zhTW = "里札雷克斯" },
    },
    {
        id = 1679, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1413, x = 0.5120, y = 0.2920,
        name = { enUS = "Nargal Deatheye", deDE = "Nargal Deatheye", esES = "Nargal Ojo de la Muerte", esMX = "Nargal Ojo de la Muerte", frFR = "Nargal Deatheye", koKR = "나르갈 데스아이", ptBR = "Nargal Olho da Morte", ruRU = "Наргал Мертвый Глаз", zhCN = "纳加尔·死眼", zhTW = "納加爾·死眼" },
    },
    {
        id = 1680, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1413, x = 0.4381, y = 0.1220,
        name = { enUS = "Vrang Wildgore", deDE = "Vrang Wildgore", esES = "Vrang Wildgore", esMX = "Vrang Wildgore", frFR = "Vrang Wildgore", koKR = "Vrang Wildgore", ptBR = "Vrang Wildgore", ruRU = "Vrang Wildgore", zhCN = "Vrang Wildgore", zhTW = "Vrang Wildgore" },
    },
    {
        id = 1681, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1416, x = 0.1325, y = 0.6955,
        name = { enUS = "Abra Cadabra", deDE = "Abra Cadabra", esES = "Abra Cadabra", esMX = "Abra Cadabra", frFR = "Abra Cadabra", koKR = "Abra Cadabra", ptBR = "Abra Cadabra", ruRU = "Abra Cadabra", zhCN = "Abra Cadabra", zhTW = "Abra Cadabra" },
    },
    {
        id = 1682, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1416, x = 0.2015, y = 0.6377,
        name = { enUS = "Anthony Durain", deDE = "Anthony Durain", esES = "Anthony Durain", esMX = "Anthony Durain", frFR = "Anthony Durain", koKR = "Anthony Durain", ptBR = "Anthony Durain", ruRU = "Anthony Durain", zhCN = "Anthony Durain", zhTW = "Anthony Durain" },
    },
    {
        id = 1683, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1469, y = 0.7117,
        name = { enUS = "Bartram Haller", deDE = "Bartram Haller", esES = "Bartram Haller", esMX = "Bartram Haller", frFR = "Bartram Haller", koKR = "Bartram Haller", ptBR = "Bartram Haller", ruRU = "Bartram Haller", zhCN = "Bartram Haller", zhTW = "Bartram Haller" },
    },
    {
        id = 1684, types = { "vendor-repair" },
        map = 1416, x = 0.1291, y = 0.7040,
        name = { enUS = "Bragund Brightlink", deDE = "Bragund Brightlink", esES = "Bragund Brightlink", esMX = "Bragund Brightlink", frFR = "Bragund Brightlink", koKR = "Bragund Brightlink", ptBR = "Bragund Brightlink", ruRU = "Bragund Brightlink", zhCN = "Bragund Brightlink", zhTW = "Bragund Brightlink" },
    },
    {
        id = 1685, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1479, y = 0.7085,
        name = { enUS = "Kerta the Bold", deDE = "Kerta the Bold", esES = "Kerta the Bold", esMX = "Kerta the Bold", frFR = "Kerta the Bold", koKR = "Kerta the Bold", ptBR = "Kerta the Bold", ruRU = "Kerta the Bold", zhCN = "Kerta the Bold", zhTW = "Kerta the Bold" },
    },
    {
        id = 1686, types = { "vendor-repair" },
        map = 1416, x = 0.1266, y = 0.7091,
        name = { enUS = "Rafael Langrom", deDE = "Rafael Langrom", esES = "Rafael Langrom", esMX = "Rafael Langrom", frFR = "Rafael Langrom", koKR = "Rafael Langrom", ptBR = "Rafael Langrom", ruRU = "Rafael Langrom", zhCN = "Rafael Langrom", zhTW = "Rafael Langrom" },
    },
    {
        id = 1687, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1469, y = 0.7117,
        name = { enUS = "Valaden Silverblade", deDE = "Valaden Silverblade", esES = "Valaden Silverblade", esMX = "Valaden Silverblade", frFR = "Valaden Silverblade", koKR = "Valaden Silverblade", ptBR = "Valaden Silverblade", ruRU = "Valaden Silverblade", zhCN = "Valaden Silverblade", zhTW = "Valaden Silverblade" },
    },
    {
        id = 1688, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1440, y = 0.7140,
        name = { enUS = "Walther Whiteford", deDE = "Walther Whiteford", esES = "Walther Whiteford", esMX = "Walther Whiteford", frFR = "Walther Whiteford", koKR = "Walther Whiteford", ptBR = "Walther Whiteford", ruRU = "Walther Whiteford", zhCN = "Walther Whiteford", zhTW = "Walther Whiteford" },
    },
    {
        id = 1689, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1440, y = 0.7160,
        name = { enUS = "Walther Whiteford", deDE = "Walther Whiteford", esES = "Walther Whiteford", esMX = "Walther Whiteford", frFR = "Walther Whiteford", koKR = "Walther Whiteford", ptBR = "Walther Whiteford", ruRU = "Walther Whiteford", zhCN = "Walther Whiteford", zhTW = "Walther Whiteford" },
    },
    {
        id = 1690, types = { "vendor-repair", "vendor" },
        map = 1416, x = 0.1460, y = 0.7120,
        name = { enUS = "Walther Whiteford", deDE = "Walther Whiteford", esES = "Walther Whiteford", esMX = "Walther Whiteford", frFR = "Walther Whiteford", koKR = "Walther Whiteford", ptBR = "Walther Whiteford", ruRU = "Walther Whiteford", zhCN = "Walther Whiteford", zhTW = "Walther Whiteford" },
    },
    {
        id = 1691, types = { "vendor-repair" },
        faction = "Alliance", map = 1417, x = 0.4600, y = 0.4772,
        name = { enUS = "Jannos Ironwill", deDE = "Jannos Ironwill", esES = "Jannos Dolocerado", esMX = "Jannos Dolocerado", frFR = "Jannos Ironwill", koKR = "야노스 아이언윌", ptBR = "Jannos Menteférrea", ruRU = "Джаннос Неуступ", zhCN = "加诺斯·铁心", zhTW = "加諾斯·鐵心" },
    },
    {
        id = 1692, types = { "vendor-repair" },
        faction = "Horde", map = 1417, x = 0.7341, y = 0.2972,
        name = { enUS = "Rutherford Twing", deDE = "Rutherford Twing", esES = "Rutherford Twing", esMX = "Rutherford Twing", frFR = "Rutherford Twing", koKR = "러더퍼드 트윙", ptBR = "Rutherford Twing", ruRU = "Резерфорд Оттяжка", zhCN = "卢瑟弗·图恩", zhTW = "盧瑟弗·圖恩" },
    },
    {
        id = 1693, types = { "vendor-repair" },
        faction = "Alliance", map = 1417, x = 0.4600, y = 0.4522,
        name = { enUS = "Samuel Hawke", deDE = "Samuel Hawke", esES = "Samuel Halcón", esMX = "Samuel Halcón", frFR = "Samuel Hawke", koKR = "사무엘 호키", ptBR = "Samuel Hawke", ruRU = "Самуэль Хок", zhCN = "萨缪尔·霍克", zhTW = "山繆·霍克" },
    },
    {
        id = 1694, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1418, x = 0.0287, y = 0.4718,
        name = { enUS = "Sranda", deDE = "Sranda", esES = "Sranda", esMX = "Sranda", frFR = "Sranda", koKR = "스란다", ptBR = "Sranda", ruRU = "Шранда", zhCN = "斯兰达", zhTW = "斯蘭達" },
    },
    {
        id = 1695, types = { "vendor-repair" },
        faction = "Alliance", map = 1419, x = 0.6610, y = 0.1719,
        name = { enUS = "Strumner Flintheel", deDE = "Strumner Flintheel", esES = "Strumner Talonsílex", esMX = "Strumner Talonsílex", frFR = "Strumner Flintheel", koKR = "스트럼너 플린트힐", ptBR = "Strumner Calcanhaço", ruRU = "Штрумнер Кремнепят", zhCN = "斯塔诺尔·火踵", zhTW = "斯塔諾爾·火踵" },
    },
    {
        id = 1696, types = { "vendor-repair" },
        faction = "Neutral", map = 1420, x = 0.8330, y = 0.6812,
        name = { enUS = "Argent Quartermaster Hasana", deDE = "Argentumrüstmeister Hasana", esES = "Intendente Argenta Hasana", esMX = "Intendente Argenta Hasana", frFR = "Intendante de l'Aube d'argent Hasana", koKR = "은빛병참장교 하사나", ptBR = "Intendente Argêntea Hasana", ruRU = "Интендант Хасна из ордена Серебряного Рассвета", zhCN = "银色黎明军需官哈萨娜", zhTW = "銀色黎明軍需官哈薩娜" },
    },
    {
        id = 1697, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6418, y = 0.7556,
        name = { enUS = "Charles Seaton", deDE = "Charles Seaton", esES = "Charles Seaton", esMX = "Charles Seaton", frFR = "Charles Seaton", koKR = "탈리스 시톤", ptBR = "Atanagildo Marinho", ruRU = "Чарльз Ситон", zhCN = "查尔斯·希顿", zhTW = "查理斯·希頓" },
    },
    {
        id = 1698, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6034, y = 0.7197,
        name = { enUS = "Francis Eliot", deDE = "Francis Eliot", esES = "Francis Eliot", esMX = "Francis Eliot", frFR = "Francis Eliot", koKR = "프란시스 엘리엇", ptBR = "Francis Pilus", ruRU = "Фрэнсис Элиот", zhCN = "弗兰克西斯·埃洛特", zhTW = "弗蘭克西斯·埃洛特" },
    },
    {
        id = 1699, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6025, y = 0.7206,
        name = { enUS = "Geoffrey Hartwell", deDE = "Geoffrey Hartwell", esES = "Geoffrey Pozovenado", esMX = "Geoffrey Pozovenado", frFR = "Geoffrey Hartwell", koKR = "지오프리 하트웰", ptBR = "Gumercindo Cordato", ruRU = "Джеффри Хартвелл", zhCN = "吉奥芬·哈特威尔", zhTW = "吉奧芬·哈特威爾" },
    },
    {
        id = 1700, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6087, y = 0.7392,
        name = { enUS = "Gordon Wendham", deDE = "Gordon Wendham", esES = "Gordon Wendham", esMX = "Gordon Wendham", frFR = "Gordon Wendham", koKR = "고든 웬드헴", ptBR = "Antônio Nunes", ruRU = "Гордон Уиндем", zhCN = "高顿·温德哈姆", zhTW = "高頓·溫德哈姆" },
    },
    {
        id = 1701, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.3240, y = 0.6640,
        name = { enUS = "Harold Raims", deDE = "Harold Raims", esES = "Harold Raims", esMX = "Harold Raims", frFR = "Harold Raims", koKR = "해럴드 라임즈", ptBR = "Haroldo Renano", ruRU = "Гарольд Раймз", zhCN = "哈洛德·莱姆斯", zhTW = "哈洛德·萊姆斯" },
    },
    {
        id = 1702, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6078, y = 0.7374,
        name = { enUS = "Louis Warren", deDE = "Louis Warren", esES = "Louis Warren", esMX = "Louis Warren", frFR = "Louis Warren", koKR = "루이 워렌", ptBR = "Luis Baracho", ruRU = "Луис Уоррен", zhCN = "刘易斯·瓦伦", zhTW = "路易斯·瓦倫" },
    },
    {
        id = 1703, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6427, y = 0.7560,
        name = { enUS = "Nathaniel Steenwick", deDE = "Nathaniel Steenwick", esES = "Nathaniel Mechostín", esMX = "Nathaniel Mechostín", frFR = "Nathaniel Steenwick", koKR = "너대니얼 스틴윅", ptBR = "Natanael Hermógenes", ruRU = "Натаниэль Стинвик", zhCN = "纳撒尼尔·斯蒂恩维克", zhTW = "納旦尼爾·斯蒂恩維克" },
    },
    {
        id = 1704, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6011, y = 0.5338,
        name = { enUS = "Oliver Dwor", deDE = "Oliver Dwor", esES = "Oliver Dwor", esMX = "Oliver Dwor", frFR = "Oliver Dwor", koKR = "올리버 드워", ptBR = "Olivier Ewor", ruRU = "Оливье Дворр", zhCN = "奥利弗·德沃尔", zhTW = "奧利弗·德沃爾" },
    },
    {
        id = 1705, types = { "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6084, y = 0.7144,
        name = { enUS = "Samuel Van Brunt", deDE = "Samuel Van Brunt", esES = "Samuel Van Brunt", esMX = "Samuel Van Brunt", frFR = "Samuel Van Brunt", koKR = "사무엘 반 브런트", ptBR = "Samuel Espanca", ruRU = "Самуэль ван Брюнт", zhCN = "萨缪尔·范·布朗特", zhTW = "薩繆爾·範·布朗特" },
    },
    {
        id = 1706, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1420, x = 0.6255, y = 0.7087,
        name = { enUS = "Sydney Upton", deDE = "Sydney Upton", esES = "Sydney Upton", esMX = "Sydney Upton", frFR = "Sydney Upton", koKR = "시드니 업톤", ptBR = "Simone Bordano", ruRU = "Сидни Аптон", zhCN = "悉尼·厄普顿", zhTW = "悉尼·厄普頓" },
    },
    {
        id = 1707, types = { "vendor-repair" },
        faction = "Horde", map = 1420, x = 0.6258, y = 0.7078,
        name = { enUS = "Zane Bradford", deDE = "Zane Bradford", esES = "Zane Bradford", esMX = "Zane Bradford", frFR = "Zane Bradford", koKR = "잔 브래드포드", ptBR = "Zeno Valforte", ruRU = "Зевракс", zhCN = "赞恩·布拉德弗", zhTW = "贊恩·布拉德弗" },
    },
    {
        id = 1708, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1421, x = 0.4640, y = 0.7188,
        name = { enUS = "Pyrewood Armorer", deDE = "Pyrewood-Rüstungsschmied", esES = "Blindado Piroleño", esMX = "Blindado Piroleña", frFR = "Armurier de Bois-du-Bûcher", koKR = "장작나무 마을 무기 제작자", ptBR = "Armoreiro de Lenhardente", ruRU = "Бронница из деревни Погребальных Костров", zhCN = "焚木村盔甲师", zhTW = "焚木村盔甲師" },
    },
    {
        id = 1709, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1421, x = 0.4395, y = 0.7410,
        name = { enUS = "Pyrewood Leatherworker", deDE = "Pyrewood-Lederer", esES = "Peletero Piroleño", esMX = "Peletero Piroleña", frFR = "Artisan du cuir de Bois-du-Bûcher", koKR = "장작나무 마을 가죽세공업자", ptBR = "Coureira de Lenhardente", ruRU = "Кожевник из деревни Погребальных Костров", zhCN = "焚木村制皮工", zhTW = "焚木村製皮工" },
    },
    {
        id = 1710, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1421, x = 0.4649, y = 0.8648,
        name = { enUS = "Wallace the Blind", deDE = "Wallace der Blinde", esES = "Wallace el Ciego", esMX = "Wallace el Ciego", frFR = "Wallace l’aveugle", koKR = "장님 왈레스", ptBR = "Wallace, o Cego", ruRU = "Уоллес Слепой", zhCN = "盲眼瓦拉斯", zhTW = "盲眼瓦拉斯" },
    },
    {
        id = 1711, types = { "vendor-repair" },
        faction = "Neutral", map = 1422, x = 0.4281, y = 0.8372,
        name = { enUS = "Argent Quartermaster Lightspark", deDE = "Argentumrüstmeister Lightspark", esES = "Intendente Argenta Chispillo", esMX = "Intendente Argenta Chispillo", frFR = "Intendant de l'Aube d'argent Lightspark", koKR = "은빛병참장교 라이트스파크", ptBR = "Intendente Argênteo Centelhuz", ruRU = "Интендант Искромет из ордена Серебряного Рассвета", zhCN = "银色黎明军需官莱斯巴克", zhTW = "銀色黎明軍需官萊斯巴克" },
    },
    {
        id = 1712, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 1422, x = 0.6812, y = 0.7757,
        name = { enUS = "Magnus Frostwake", deDE = "Magnus Frostwake", esES = "Magnus Vespescarcha", esMX = "Magnus Vespescarcha", frFR = "Magnus Frostwake", koKR = "마그누스 프로스트웨이크", ptBR = "Magnus Rastrogélido", ruRU = "Магнус Хладоступ", zhCN = "玛格努斯·霜鸣", zhTW = "瑪格努斯·霜鳴" },
    },
    {
        id = 1713, types = { "vendor-repair" },
        faction = "Neutral", map = 1423, x = 0.7122, y = 0.4990,
        name = { enUS = "Craftsman Wilhelm", deDE = "Handwerker Wilhelm", esES = "Artesano Fijalontad", esMX = "Artesano Wilhelm", frFR = "Artisan Wilhelm", koKR = "기능공 빌헬름", ptBR = "Artesão Wilhelm", ruRU = "Ремесленник Вильгельм", zhCN = "工匠威尔海姆", zhTW = "工匠維爾海姆" },
    },
    {
        id = 1714, types = { "vendor-repair" },
        faction = "Alliance", map = 1424, x = 0.3208, y = 0.4438,
        name = { enUS = "Blacksmith Verringtan", deDE = "Schmied Verringtan", esES = "Herrero Verrintan", esMX = "Herrero Verrintan", frFR = "Forgeron Verringtan", koKR = "대장장이 베링턴", ptBR = "Ferreiro Verrintão", ruRU = "Кузнец Верринтан", zhCN = "铁匠维林坦", zhTW = "鐵匠維林坦" },
    },
    {
        id = 1715, types = { "vendor-repair" },
        faction = "Alliance", map = 1424, x = 0.3221, y = 0.4569,
        name = { enUS = "Blacksmith Verringtan", deDE = "Schmied Verringtan", esES = "Herrero Verrintan", esMX = "Herrero Verrintan", frFR = "Forgeron Verringtan", koKR = "대장장이 베링턴", ptBR = "Ferreiro Verrintão", ruRU = "Кузнец Верринтан", zhCN = "铁匠维林坦", zhTW = "鐵匠維林坦" },
    },
    {
        id = 1716, types = { "vendor-repair" },
        faction = "Alliance", map = 1424, x = 0.3258, y = 0.4588,
        name = { enUS = "Blacksmith Verringtan", deDE = "Schmied Verringtan", esES = "Herrero Verrintan", esMX = "Herrero Verrintan", frFR = "Forgeron Verringtan", koKR = "대장장이 베링턴", ptBR = "Ferreiro Verrintão", ruRU = "Кузнец Верринтан", zhCN = "铁匠维林坦", zhTW = "鐵匠維林坦" },
    },
    {
        id = 1717, types = { "vendor-repair" },
        faction = "Neutral", map = 1424, x = 0.8008, y = 0.3888,
        name = { enUS = "Kris Legace", deDE = "Kris Legace", esES = "Kris Legace", esMX = "Kris Legace", frFR = "Kris Legace", koKR = "크리스 리게이스", ptBR = "Cris Legace", ruRU = "Крис Легас", zhCN = "克瑞斯·李盖斯", zhTW = "克瑞斯·李蓋斯" },
    },
    {
        id = 1718, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1424, x = 0.6042, y = 0.2619,
        name = { enUS = "Ott", deDE = "Ott", esES = "Ott", esMX = "Ott", frFR = "Ott", koKR = "Ott", ptBR = "Ott", ruRU = "Ott", zhCN = "Ott", zhTW = "Ott" },
    },
    {
        id = 1719, types = { "vendor-repair" },
        faction = "Alliance", map = 1424, x = 0.5121, y = 0.5700,
        name = { enUS = "Robert Aebischer", deDE = "Robert Aebischer", esES = "Robert Aebischer", esMX = "Robert Aebischer", frFR = "Robert Aebischer", koKR = "로버트 에비스처", ptBR = "Roberto Aebischer", ruRU = "Роберт Эбишер", zhCN = "罗伯特·埃比斯彻尔", zhTW = "羅伯特·埃比斯徹爾" },
    },
    {
        id = 1720, types = { "vendor-repair" },
        faction = "Neutral", map = 1424, x = 0.5571, y = 0.3481,
        name = { enUS = "Zixil", deDE = "Zixil", esES = "Zixil", esMX = "Zixil", frFR = "Zixil", koKR = "직실", ptBR = "Zixil", ruRU = "Зиксель", zhCN = "吉克希尔", zhTW = "吉克希爾" },
    },
    {
        id = 1721, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.5473, y = 0.2364,
        name = { enUS = "Bingus", deDE = "Bingus", esES = "Bingus", esMX = "Bingus", frFR = "Bingus", koKR = "빙구스", ptBR = "Bingos", ruRU = "Заточинс", zhCN = "宾古斯", zhTW = "賓古斯" },
    },
    {
        id = 1722, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6109, y = 0.3534,
        name = { enUS = "Brenwyn Wintersteel", deDE = "Brenwyn Wintersteel", esES = "Brenwyn Ventacerado", esMX = "Brenwyn Ventacerado", frFR = "Brenwyn Wintersteel", koKR = "브렌윈 윈터스틸", ptBR = "Brenwyn Invernácero", ruRU = "Бренвин Зимняя Сталь", zhCN = "布雷文·寒钢", zhTW = "布雷文·寒鋼" },
    },
    {
        id = 1723, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.5681, y = 0.3164,
        name = { enUS = "Dolman Steelfury", deDE = "Dolman Steelfury", esES = "Dolman Furiacerada", esMX = "Dolman Furiacerada", frFR = "Dolman Steelfury", koKR = "돌만 스틸퓨리", ptBR = "Dolman Furiácero", ruRU = "Дольман Холодная Ярость", zhCN = "杜尔曼·钢怒", zhTW = "杜爾曼·鋼怒" },
    },
    {
        id = 1724, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6889, y = 0.5601,
        name = { enUS = "Frast Dokner", deDE = "Frast Dokner", esES = "Frast Dokner", esMX = "Frast Dokner", frFR = "Frast Dokner", koKR = "프라스트 도크너", ptBR = "Frast Dokner", ruRU = "Фраст Докнер", zhCN = "弗拉斯特·多克南", zhTW = "弗拉斯特·多克南" },
    },
    {
        id = 1725, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.4531, y = 0.5219,
        name = { enUS = "Grawn Thromwyn", deDE = "Grawn Thromwyn", esES = "Graun Thromwyn", esMX = "Graun Thromwyn", frFR = "Grawn Thromwyn", koKR = "그론 스롬윈", ptBR = "Grawn Thromwyn", ruRU = "Гримлок", zhCN = "格劳恩·索姆温", zhTW = "格勞恩·索姆溫" },
    },
    {
        id = 1726, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.5687, y = 0.3160,
        name = { enUS = "Grenil Steelfury", deDE = "Grenil Steelfury", esES = "Grenil Furiacerada", esMX = "Grenil Furiacerada", frFR = "Grenil Steelfury", koKR = "그레닐 스틸퓨리", ptBR = "Grenil Furiácero", ruRU = "Гренил Холодная Ярость", zhCN = "格雷尼尔·钢怒", zhTW = "格雷尼爾·鋼怒" },
    },
    {
        id = 1727, types = { "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5478, y = 0.2364,
        name = { enUS = "Harick Boulderdrum", deDE = "Harick Boulderdrum", esES = "Harick Tamborroca", esMX = "Harick Tamborroca", frFR = "Harick Boulderdrum", koKR = "하릭 보울더드럼", ptBR = "Harick Batesseixo", ruRU = "Харик Камнепад", zhCN = "哈瑞克·石鼓", zhTW = "哈瑞克·石鼓" },
    },
    {
        id = 1728, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6106, y = 0.3526,
        name = { enUS = "Hegnar Swiftaxe", deDE = "Hegnar Swiftaxe", esES = "Hegnar Hacharrápida", esMX = "Hegnar Hacharrápida", frFR = "Hegnar Swiftaxe", koKR = "헤그나르 스위프트액스", ptBR = "Hegnar Celeraxa", ruRU = "Хегнар Быстрый Топор", zhCN = "海格纳·快斧", zhTW = "海格納·快斧" },
    },
    {
        id = 1729, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.5830, y = 0.2218,
        name = { enUS = "Hjoldir Stoneblade", deDE = "Hjoldir Stoneblade", esES = "Hjoldir Hojapiedra", esMX = "Hjoldir Hojapiedra", frFR = "Hjoldir Stoneblade", koKR = "흐욜디르 스톤블레이드", ptBR = "Hjoldir Gumepedra", ruRU = "Хольдир Каменный Клинок", zhCN = "霍迪尔·石刃", zhTW = "霍迪爾·石刃" },
    },
    {
        id = 1730, types = { "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.6112, y = 0.3534,
        name = { enUS = "Kelomir Ironhand", deDE = "Kelomir Ironhand", esES = "Kelomir Manoyerro", esMX = "Kelomir Manoyerro", frFR = "Kelomir Ironhand", koKR = "켈로미르 아이언핸드", ptBR = "Kelomir Maniferro", ruRU = "Келомир Железная Рука", zhCN = "凯洛米尔·铁手", zhTW = "凱洛米爾·鐵手" },
    },
    {
        id = 1731, types = { "vendor-repair" },
        faction = "Alliance", map = 1426, x = 0.5730, y = 0.2206,
        name = { enUS = "Maeva Snowbraid", deDE = "Maeva Snowbraid", esES = "Maeva Trenzanubes", esMX = "Maeva Trenzanubes", frFR = "Maeva Snowbraid", koKR = "마에바 스노우브레이드", ptBR = "Maeva Trançaneve", ruRU = "Майева Снежная Коса", zhCN = "麦瓦·雪衣", zhTW = "麥瓦·雪衣" },
    },
    {
        id = 1732, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.2871, y = 0.6770,
        name = { enUS = "Rybrad Coldbank", deDE = "Rybrad Coldbank", esES = "Rybrad Riberahiel", esMX = "Rybrad Riberahiel", frFR = "Rybrad Coldbank", koKR = "라이브라트 콜드뱅크", ptBR = "Rybrad Friamargem", ruRU = "Райбрад Холодный Берег", zhCN = "雷布莱德·寒椅", zhTW = "雷布萊德·寒椅" },
    },
    {
        id = 1733, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1426, x = 0.6291, y = 0.4992,
        name = { enUS = "Turuk Amberstill", deDE = "Turuk Amberstill", esES = "Turuk Semperámbar", esMX = "Turuk Semperámbar", frFR = "Turuk Amberstill", koKR = "투룩 앰버스틸", ptBR = "Turuk Ambarmanso", ruRU = "Турук Янтарлен", zhCN = "图鲁克·冻石", zhTW = "圖魯克·凍石" },
    },
    {
        id = 1734, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1428, x = 0.8521, y = 0.6841,
        name = { enUS = "Felder Stover", deDE = "Felder Stover", esES = "Felder Hornillos", esMX = "Felder Hornillos", frFR = "Felder Stover", koKR = "펠더 스토버", ptBR = "Felder Fornalha", ruRU = "Фелдер Стовер", zhCN = "菲德尔·斯托弗", zhTW = "菲德爾·斯托弗" },
    },
    {
        id = 1735, types = { "vendor-repair" },
        faction = "Neutral", map = 1428, x = 0.6609, y = 0.2203,
        name = { enUS = "Yuka Screwspigot", deDE = "Yuka Screwspigot", esES = "Yuka Llavenrosca", esMX = "Yuka Llavenrosca", frFR = "Yuka Screwspigot", koKR = "유카 스크류스피곳", ptBR = "Yuka Parafuseta", ruRU = "Юка Крутипроб", zhCN = "尤卡·斯库比格特", zhTW = "尤卡·斯庫比格特" },
    },
    {
        id = 1736, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1429, x = 0.4151, y = 0.6592,
        name = { enUS = "Corina Steele", deDE = "Corina Steele", esES = "Corina Aceralia", esMX = "Corina Aceralia", frFR = "Corina Steele", koKR = "코리나 스틸", ptBR = "Corina Ácero", ruRU = "Корина Сталль", zhCN = "科瑞娜·斯蒂利", zhTW = "科瑞娜·斯蒂利" },
    },
    {
        id = 1737, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1429, x = 0.4720, y = 0.4190,
        name = { enUS = "Janos Hammerknuckle", deDE = "Janos Hammerknuckle", esES = "Janos Nudillomartillo", esMX = "Janos Nudillomartillo", frFR = "Janos Hammerknuckle", koKR = "야노스 해머너클", ptBR = "Janos Punhoforte", ruRU = "Янош Камнекост", zhCN = "亚努斯·哈默纳克", zhTW = "亞努斯·哈默納克" },
    },
    {
        id = 1738, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4125, y = 0.6674,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1739, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4141, y = 0.6632,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1740, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4177, y = 0.6644,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1741, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4188, y = 0.6655,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1742, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4191, y = 0.6665,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1743, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4199, y = 0.6677,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1744, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4208, y = 0.6681,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1745, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4210, y = 0.6654,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1746, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4211, y = 0.6828,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1747, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4212, y = 0.6627,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1748, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4219, y = 0.6611,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1749, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4219, y = 0.6678,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1750, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4221, y = 0.6583,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1751, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4238, y = 0.6616,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1752, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4243, y = 0.6549,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1753, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4251, y = 0.6602,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1754, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4261, y = 0.6607,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1755, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1429, x = 0.4415, y = 0.6842,
        name = { enUS = "Nordun Steadysight", deDE = "Nordun Steadysight", esES = "Nordun Steadysight", esMX = "Nordun Steadysight", frFR = "Nordun Steadysight", koKR = "Nordun Steadysight", ptBR = "Nordun Steadysight", ruRU = "Nordun Steadysight", zhCN = "Nordun Steadysight", zhTW = "Nordun Steadysight" },
    },
    {
        id = 1756, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1429, x = 0.2541, y = 0.7398,
        name = { enUS = "Quartermaster Hicks", deDE = "Rüstmeister Hicks", esES = "Intendente Hicks", esMX = "Intendente Hicks", frFR = "Intendant Hicks", koKR = "병참장교 힉스", ptBR = "Intendente C. Lúcio", ruRU = "Интендант Хикс", zhCN = "军需官希克斯", zhTW = "軍需官希克斯" },
    },
    {
        id = 1757, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1431, x = 0.7358, y = 0.4996,
        name = { enUS = "Gavin Gnarltree", deDE = "Gavin Gnarltree", esES = "Gavin Nudárbol", esMX = "Gavin Nudárbol", frFR = "Gavin Gnarltree", koKR = "가빈 나알트리", ptBR = "Gavin Roecasca", ruRU = "Гавин Гнутодрев", zhCN = "加文·纳尔特里", zhTW = "加文·納爾特里" },
    },
    {
        id = 1758, types = { "vendor-repair" },
        faction = "Alliance", map = 1432, x = 0.3402, y = 0.4649,
        name = { enUS = "Morhan Coppertongue", deDE = "Morhan Coppertongue", esES = "Morhan Cobrilengua", esMX = "Morhan Cobrilengua", frFR = "Morhan Coppertongue", koKR = "모한 카퍼텅", ptBR = "Morthan Linguacupra", ruRU = "Моран Медношпунт", zhCN = "摩汉·铜喉", zhTW = "摩漢·銅喉" },
    },
    {
        id = 1759, types = { "vendor-repair" },
        faction = "Alliance", map = 1432, x = 0.4291, y = 0.0988,
        name = { enUS = "Nillen Andemar", deDE = "Nillen Andemar", esES = "Nillen Andemar", esMX = "Nillen Andemar", frFR = "Nillen Andemar", koKR = "닐렌 앤드마르", ptBR = "Nillen Andemar", ruRU = "Нилиен Аденмар", zhCN = "尼尔伦·安德玛", zhTW = "尼爾倫·安德瑪" },
    },
    {
        id = 1760, types = { "vendor-repair" },
        faction = "Alliance", map = 1433, x = 0.2549, y = 0.4648,
        name = { enUS = "Kara Adams", deDE = "Kara Adams", esES = "Kara Adams", esMX = "Kara Adams", frFR = "Kara Adams", koKR = "카라 아담스", ptBR = "Kara Carneiro", ruRU = "Кара Адамс", zhCN = "卡拉·亚当斯", zhTW = "卡拉·亞當斯" },
    },
    {
        id = 1761, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.0801, y = 0.7481,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1762, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1032, y = 0.7449,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1763, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1032, y = 0.7492,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1764, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1035, y = 0.7499,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1765, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1036, y = 0.7469,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1766, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1038, y = 0.7385,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1767, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1044, y = 0.7481,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1768, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1045, y = 0.7456,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1769, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1047, y = 0.7227,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1770, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1047, y = 0.7462,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1771, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1048, y = 0.7497,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1772, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 1433, x = 0.1049, y = 0.7295,
        name = { enUS = "Stondry Darkhammer", deDE = "Stondry Darkhammer", esES = "Stondry Darkhammer", esMX = "Stondry Darkhammer", frFR = "Stondry Darkhammer", koKR = "Stondry Darkhammer", ptBR = "Stondry Darkhammer", ruRU = "Stondry Darkhammer", zhCN = "Stondry Darkhammer", zhTW = "Stondry Darkhammer" },
    },
    {
        id = 1773, types = { "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.3581, y = 0.1070,
        name = { enUS = "Jaquilina Dramet", deDE = "Jaquilina Dramet", esES = "Jaquilina Dramet", esMX = "Jaquilina Dramet", frFR = "Jaquilina Dramet", koKR = "자킬리나 드라메트", ptBR = "Jaquilina Dramet", ruRU = "Жаклина Драмет", zhCN = "加奎琳娜·德拉米特", zhTW = "加奎琳娜·德拉米特" },
    },
    {
        id = 1774, types = { "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2751, y = 0.7749,
        name = { enUS = "Jutak", deDE = "Jutak", esES = "Jutak", esMX = "Jutak", frFR = "Jutak", koKR = "주타크", ptBR = "Jutak", ruRU = "Ютак", zhCN = "祖塔克", zhTW = "祖塔克" },
    },
    {
        id = 1775, types = { "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2830, y = 0.7520,
        name = { enUS = "Kizz Bluntstrike", deDE = "Kizz Bluntstrike", esES = "Kizz Golpeseco", esMX = "Kizz Golpeseco", frFR = "Kizz Bluntstrike", koKR = "키즈 블런트스트라이크", ptBR = "Kizz Rijogolpe", ruRU = "Кизз Оглушанец", zhCN = "基兹·布伦斯泰克", zhTW = "基茲·布倫斯泰克" },
    },
    {
        id = 1776, types = { "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.2810, y = 0.7758,
        name = { enUS = "Qixdi Goodstitch", deDE = "Qixdi Goodstitch", esES = "Qixdi Cortefino", esMX = "Qixdi Cortefino", frFR = "Qixdi Goodstitch", koKR = "킥스디 굿스티치", ptBR = "Qixdi Pontobom", ruRU = "Квиксиди Ладноскрой", zhCN = "奇克斯迪·古斯提", zhTW = "奇克斯迪·古斯提" },
    },
    {
        id = 1777, types = { "vendor-repair" },
        faction = "Neutral", map = 1434, x = 0.1510, y = 0.1600,
        name = { enUS = "Rin'wosho the Trader", deDE = "Rin'wosho der Händler", esES = "Rin'wosho el Mercader", esMX = "Rin'wosho el Comerciante", frFR = "Rin'wosho le marchand", koKR = "상인 린워쇼", ptBR = "Rin'wosho, o Comerciante", ruRU = "Рин'вошо Торговец", zhCN = "商人林沃斯", zhTW = "商人林沃斯" },
    },
    {
        id = 1778, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1434, x = 0.3240, y = 0.2800,
        name = { enUS = "Vharr", deDE = "Vharr", esES = "Vharr", esMX = "Vharr", frFR = "Vharr", koKR = "바르", ptBR = "Vharr", ruRU = "Вхарр", zhCN = "维哈尔", zhTW = "維哈爾" },
    },
    {
        id = 1779, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1434, x = 0.2830, y = 0.7548,
        name = { enUS = "Zarena Cromwind", deDE = "Zarena Cromwind", esES = "Zarena Cromvento", esMX = "Zarena Cromvento", frFR = "Zarena Cromwind", koKR = "자레나 크롬윈드", ptBR = "Zarena Bravais", ruRU = "Зарена Кромвинд", zhCN = "萨瑞娜·克罗姆温德", zhTW = "薩瑞娜·克羅姆溫德" },
    },
    {
        id = 1780, types = { "vendor-repair" },
        faction = "Horde", map = 1435, x = 0.4510, y = 0.5043,
        name = { enUS = "Grimnal", deDE = "Grimnal", esES = "Grimnal", esMX = "Grimnal", frFR = "Grimnal", koKR = "그림날", ptBR = "Grimnal", ruRU = "Угрюмм", zhCN = "格瑞穆纳尔", zhTW = "格瑞穆納爾" },
    },
    {
        id = 1781, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1435, x = 0.4568, y = 0.5087,
        name = { enUS = "Hartash", deDE = "Hartash", esES = "Hartash", esMX = "Hartash", frFR = "Hartash", koKR = "하타쉬", ptBR = "Hartash", ruRU = "Харташ", zhCN = "哈塔什", zhTW = "哈塔什" },
    },
    {
        id = 1782, types = { "vendor-repair" },
        faction = "Neutral", map = 1436, x = 0.4349, y = 0.6680,
        name = { enUS = "Defias Profiteer", deDE = "Schieber der Defias", esES = "Especulador Defias", esMX = "Especulador Defias", frFR = "Profiteur défias", koKR = "데피아즈단 악덕업자", ptBR = "Aproveitador Défias", ruRU = "Спекулянт из Братства Справедливости", zhCN = "迪菲亚奸商", zhTW = "迪菲亞奸商" },
    },
    {
        id = 1783, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1437, x = 0.1150, y = 0.5960,
        name = { enUS = "Brak Durnad", deDE = "Brak Durnad", esES = "Brak Durnad", esMX = "Brak Durnad", frFR = "Brak Durnad", koKR = "브라크 더나드", ptBR = "Brak Durnad", ruRU = "Брак Дарнад", zhCN = "布拉克·唐纳德", zhTW = "布拉克·唐納德" },
    },
    {
        id = 1784, types = { "vendor-repair" },
        faction = "Alliance", map = 1437, x = 0.2559, y = 0.2579,
        name = { enUS = "Wenna Silkbeard", deDE = "Wenna Silkbeard", esES = "Wenna Barbasedosa", esMX = "Wenna Barbasedosa", frFR = "Wenna Silkbeard", koKR = "웨나 실크비어드", ptBR = "Wenna Barbasseda", ruRU = "Венна Шелкобород", zhCN = "温纳·银须", zhTW = "溫納·銀鬚" },
    },
    {
        id = 1785, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1438, x = 0.5871, y = 0.3970,
        name = { enUS = "Khardan Proudblade", deDE = "Khardan Proudblade", esES = "Khardan Filorgullo", esMX = "Khardan Filorgullo", frFR = "Khardan Proudblade", koKR = "카르단 프라우드블레이드", ptBR = "Khardan Laminaltiva", ruRU = "Хардан Гордый Клинок", zhCN = "卡尔丹·傲刃", zhTW = "卡爾丹·傲刃" },
    },
    {
        id = 1786, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1438, x = 0.5630, y = 0.5950,
        name = { enUS = "Shalomon", deDE = "Shalomon", esES = "Shalomon", esMX = "Shalomon", frFR = "Shalomon", koKR = "샬로몬", ptBR = "Shalomon", ruRU = "Шаломон", zhCN = "沙洛蒙", zhTW = "沙洛蒙" },
    },
    {
        id = 1787, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1439, x = 0.3760, y = 0.4031,
        name = { enUS = "Naram Longclaw", deDE = "Naram Longclaw", esES = "Naram Garralarga", esMX = "Naram Garralarga", frFR = "Naram Longclaw", koKR = "나람 롱클로", ptBR = "Naram Garralonga", ruRU = "Нарам Длинный Коготь", zhCN = "纳拉姆·长爪", zhTW = "納拉姆·長爪" },
    },
    {
        id = 1788, types = { "vendor-repair" },
        faction = "Alliance", map = 1440, x = 0.6150, y = 0.8390,
        name = { enUS = "Illiyana Moonblaze", deDE = "Illiyana Moonblaze", esES = "Illiyana Lunardiente", esMX = "Illiyana Lunardiente", frFR = "Illiyana Moonblaze", koKR = "일리야나 문블레이즈", ptBR = "Iliana Fulgiluna", ruRU = "Иллиана Лунное Сияние", zhCN = "艾蒂尔·月火", zhTW = "銀翼補給員艾蒂爾·月火" },
    },
    {
        id = 1789, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 1440, x = 0.8940, y = 0.4040,
        name = { enUS = "Quartermaster Kyleen", deDE = "Quartermaster Kyleen", esES = "Quartermaster Kyleen", esMX = "Quartermaster Kyleen", frFR = "Quartermaster Kyleen", koKR = "Quartermaster Kyleen", ptBR = "Quartermaster Kyleen", ruRU = "Quartermaster Kyleen", zhCN = "Quartermaster Kyleen", zhTW = "Quartermaster Kyleen" },
    },
    {
        id = 1790, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 1440, x = 0.8940, y = 0.4060,
        name = { enUS = "Quartermaster Kyleen", deDE = "Quartermaster Kyleen", esES = "Quartermaster Kyleen", esMX = "Quartermaster Kyleen", frFR = "Quartermaster Kyleen", koKR = "Quartermaster Kyleen", ptBR = "Quartermaster Kyleen", ruRU = "Quartermaster Kyleen", zhCN = "Quartermaster Kyleen", zhTW = "Quartermaster Kyleen" },
    },
    {
        id = 1791, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 1440, x = 0.8960, y = 0.4040,
        name = { enUS = "Quartermaster Kyleen", deDE = "Quartermaster Kyleen", esES = "Quartermaster Kyleen", esMX = "Quartermaster Kyleen", frFR = "Quartermaster Kyleen", koKR = "Quartermaster Kyleen", ptBR = "Quartermaster Kyleen", ruRU = "Quartermaster Kyleen", zhCN = "Quartermaster Kyleen", zhTW = "Quartermaster Kyleen" },
    },
    {
        id = 1792, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 1440, x = 0.8960, y = 0.4060,
        name = { enUS = "Quartermaster Kyleen", deDE = "Quartermaster Kyleen", esES = "Quartermaster Kyleen", esMX = "Quartermaster Kyleen", frFR = "Quartermaster Kyleen", koKR = "Quartermaster Kyleen", ptBR = "Quartermaster Kyleen", ruRU = "Quartermaster Kyleen", zhCN = "Quartermaster Kyleen", zhTW = "Quartermaster Kyleen" },
    },
    {
        id = 1793, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1440, x = 0.3579, y = 0.5199,
        name = { enUS = "Xai'ander", deDE = "Xai'ander", esES = "Xai'ander", esMX = "Xai'ander", frFR = "Xai'ander", koKR = "사이안데르", ptBR = "Xai'ander", ruRU = "Зандивиус", zhCN = "塞安德尔", zhTW = "塞安得爾" },
    },
    {
        id = 1794, types = { "vendor-repair" },
        faction = "Neutral", map = 1442, x = 0.6270, y = 0.4019,
        name = { enUS = "Nizzik", deDE = "Nizzik", esES = "Nizzik", esMX = "Nizzik", frFR = "Nizzik", koKR = "니지크", ptBR = "Nizzik", ruRU = "Низзик", zhCN = "尼兹克", zhTW = "尼茲克" },
    },
    {
        id = 1795, types = { "vendor-repair" },
        faction = "Neutral", map = 1442, x = 0.5819, y = 0.5170,
        name = { enUS = "Veenix", deDE = "Veenix", esES = "Veenix", esMX = "Veenix", frFR = "Veenix", koKR = "비닉스", ptBR = "Veenix", ruRU = "Виеникс", zhCN = "维尼克斯", zhTW = "維尼克斯" },
    },
    {
        id = 1796, types = { "vendor-repair" },
        faction = "Horde", map = 1443, x = 0.2580, y = 0.7099,
        name = { enUS = "Hae'Wilani", deDE = "Hae'Wilani", esES = "Hae'Wilani", esMX = "Hae'Wilani", frFR = "Hae'Wilani", koKR = "해윌라니", ptBR = "Hae'Wilani", ruRU = "Ха'Вилани", zhCN = "海维拉尼", zhTW = "海維拉尼" },
    },
    {
        id = 1797, types = { "vendor-repair" },
        faction = "Horde", map = 1443, x = 0.5561, y = 0.5649,
        name = { enUS = "Muuran", deDE = "Muuran", esES = "Muuran", esMX = "Muuran", frFR = "Muuran", koKR = "무란", ptBR = "Muuran", ruRU = "Мууран", zhCN = "穆尔兰", zhTW = "莫爾蘭" },
    },
    {
        id = 1798, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1445, x = 0.6460, y = 0.5010,
        name = { enUS = "Marie Holdston", deDE = "Marie Holdston", esES = "Marie Holdston", esMX = "Marie Holdston", frFR = "Marie Holdston", koKR = "마리 홀드스턴", ptBR = "Marie Eulália", ruRU = "Мария Хольдстон", zhCN = "玛蕾·霍斯顿", zhTW = "瑪蕾·霍斯頓" },
    },
    {
        id = 1799, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1445, x = 0.6740, y = 0.4789,
        name = { enUS = "Piter Verance", deDE = "Piter Verance", esES = "Piter Verance", esMX = "Piter Verance", frFR = "Piter Verance", koKR = "피터 베랑스", ptBR = "Piter Verance", ruRU = "Питер Веренс", zhCN = "皮特·沃兰斯", zhTW = "皮特·沃蘭斯" },
    },
    {
        id = 1800, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1445, x = 0.3621, y = 0.3181,
        name = { enUS = "Zulrg", deDE = "Zulrg", esES = "Zulrg", esMX = "Zulrg", frFR = "Zulrg", koKR = "줄르그", ptBR = "Zulrg", ruRU = "Злург", zhCN = "祖尔格", zhTW = "祖爾格" },
    },
    {
        id = 1801, types = { "vendor-repair" },
        faction = "Neutral", map = 1446, x = 0.5080, y = 0.2770,
        name = { enUS = "Wrinkle Goodsteel", deDE = "Wrinkle Goodsteel", esES = "Wrinkle Buenacero", esMX = "Wrinkle Buenacero", frFR = "Wrinkle Goodsteel", koKR = "링클 굿스틸", ptBR = "Dobrov A. Massoaço", ruRU = "Ринкль Сталлер", zhCN = "乌林克·古德斯迪尔", zhTW = "烏林克·精鐵" },
    },
    {
        id = 1802, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1447, x = 0.2220, y = 0.5112,
        name = { enUS = "Gruul Darkblade", deDE = "Gruul Darkblade", esES = "Gruul Filoscuro", esMX = "Gruul Filoscuro", frFR = "Gruul Darkblade", koKR = "그룰 다크블레이드", ptBR = "Gruul Laminegra", ruRU = "Груул Черный Клинок", zhCN = "格鲁尔·黑刃", zhTW = "戈魯爾·黑刃" },
    },
    {
        id = 1803, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1448, x = 0.3479, y = 0.5322,
        name = { enUS = "Altsoba Ragetotem", deDE = "Altsoba Ragetotem", esES = "Altsoba Furiatótem", esMX = "Altsoba Tótem de Ira", frFR = "Altsoba Ragetotem", koKR = "알트소바 레이지토템", ptBR = "Altsoba Totem da Fúria", ruRU = "Альтсоба Тотем Гнева", zhCN = "奥索巴·狂怒图腾", zhTW = "奧索巴·狂暴圖騰" },
    },
    {
        id = 1804, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1448, x = 0.6241, y = 0.2581,
        name = { enUS = "Mylini Frostmoon", deDE = "Mylini Frostmoon", esES = "Mylini Luna Helada", esMX = "Mylini Luna Helada", frFR = "Mylini Frostmoon", koKR = "말리니 프로스트문", ptBR = "Mylini Lunálgida", ruRU = "Майлина Холодная Луна", zhCN = "麦琳妮·霜月", zhTW = "麥琳妮·霜月" },
    },
    {
        id = 1805, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1449, x = 0.4411, y = 0.0719,
        name = { enUS = "Gibbert", deDE = "Gibbert", esES = "Gibbert", esMX = "Gibbert", frFR = "Gibbert", koKR = "기버트", ptBR = "Goberto", ruRU = "Таратор", zhCN = "吉波尔特", zhTW = "吉波爾特" },
    },
    {
        id = 1806, types = { "vendor-repair" },
        faction = "Neutral", map = 1450, x = 0.5199, y = 0.3289,
        name = { enUS = "Geenia Sunshadow", deDE = "Geenia Sunshadow", esES = "Geenia Sombrasol", esMX = "Geenia Sombrasol", frFR = "Geenia Sunshadow", koKR = "지니아 선섀도", ptBR = "Geenia Solumbra", ruRU = "Гиния Солнечная Тень", zhCN = "基妮亚·日影", zhTW = "基妮亞·日影" },
    },
    {
        id = 1807, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 1450, x = 0.5118, y = 0.4233,
        name = { enUS = "Meliri", deDE = "Meliri", esES = "Meliri", esMX = "Meliri", frFR = "Meliri", koKR = "멜리리", ptBR = "Meliri", ruRU = "Мелири", zhCN = "梅里", zhTW = "梅里" },
    },
    {
        id = 1808, types = { "vendor-repair" },
        faction = "Neutral", map = 1451, x = 0.5118, y = 0.3887,
        name = { enUS = "Vargus", deDE = "Vargus", esES = "Vargus", esMX = "Vargus", frFR = "Vargus", koKR = "바르구스", ptBR = "Vargus", ruRU = "Варгус", zhCN = "瓦古斯", zhTW = "瓦古斯" },
    },
    {
        id = 1809, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5296, y = 0.7495,
        name = { enUS = "Allan Hafgan", deDE = "Allan Hafgan", esES = "Allan Hafgan", esMX = "Allan Hafgan", frFR = "Allan Hafgan", koKR = "앨런 하프간", ptBR = "Alan Montezzi", ruRU = "Аллан Хафган", zhCN = "艾伦·哈弗甘", zhTW = "艾倫·哈弗甘" },
    },
    {
        id = 1810, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5289, y = 0.7483,
        name = { enUS = "Ardwyn Cailen", deDE = "Ardwyn Cailen", esES = "Ardwyn Cailen", esMX = "Ardwyn Cailen", frFR = "Ardwyn Cailen", koKR = "애드윈 케일렌", ptBR = "Adriana Cailen", ruRU = "Ардвина Кайлен", zhCN = "阿德温·凯伦", zhTW = "阿德溫·凱倫" },
    },
    {
        id = 1811, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.6923, y = 0.5757,
        name = { enUS = "Bryan Cross", deDE = "Bryan Cross", esES = "Bryan Cruz", esMX = "Bryan Cruz", frFR = "Bryan Cross", koKR = "브라이언 크로스", ptBR = "Marques Martinho", ruRU = "Брайан Кросс", zhCN = "布赖恩·克罗斯", zhTW = "布賴恩·克羅斯" },
    },
    {
        id = 1812, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5273, y = 0.8370,
        name = { enUS = "Evan Larson", deDE = "Evan Larson", esES = "Evan Larson", esMX = "Evan Larson", frFR = "Evan Larson", koKR = "이반 라슨", ptBR = "Érico Galante", ruRU = "Эван Ларсон", zhCN = "伊万·拉尔森", zhTW = "伊萬·拉爾森" },
    },
    {
        id = 1813, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1453, x = 0.7299, y = 0.5745,
        name = { enUS = "Gerik Koen", deDE = "Gerik Koen", esES = "Gerik Koen", esMX = "Gerik Koen", frFR = "Gerik Koen", koKR = "게릭 코엔", ptBR = "Xavier Gomes", ruRU = "Герик Коэн", zhCN = "格瑞克·考恩", zhTW = "格瑞克·考恩" },
    },
    {
        id = 1814, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.4813, y = 0.5515,
        name = { enUS = "Gregory Ardus", deDE = "Gregory Ardus", esES = "Gregory Ardus", esMX = "Gregory Ardus", frFR = "Gregory Ardus", koKR = "그레고리 아더스", ptBR = "Gregório Ardus", ruRU = "Грегори Ардус", zhCN = "格雷戈里·阿杜斯", zhTW = "葛列格里·阿杜斯" },
    },
    {
        id = 1815, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1453, x = 0.7721, y = 0.5745,
        name = { enUS = "Heinrich Stone", deDE = "Heinrich Stone", esES = "Heinrich Roca", esMX = "Heinrich Roca", frFR = "Heinrich Stone", koKR = "하인리히 스톤", ptBR = "Heleno Rocha", ruRU = "Генрих Стоун", zhCN = "亨里克·斯通", zhTW = "亨里克·斯通" },
    },
    {
        id = 1816, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1453, x = 0.5933, y = 0.3386,
        name = { enUS = "Kathrum Axehand", deDE = "Kathrum Axehand", esES = "Kathrum Manacha", esMX = "Kathrum Manacha", frFR = "Kathrum Axehand", koKR = "카스룸 액스핸드", ptBR = "Kathrum Mão de Acha", ruRU = "Катрум Топорище", zhCN = "卡斯鲁姆·斧拳", zhTW = "卡斯魯姆·斧拳" },
    },
    {
        id = 1817, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.7169, y = 0.5814,
        name = { enUS = "Mayda Thane", deDE = "Mayda Thane", esES = "Mayda Thane", esMX = "Mayda Thane", frFR = "Mayda Thane", koKR = "마이다 테인", ptBR = "Maíra Thane", ruRU = "Майда Тейн", zhCN = "梅达·希恩", zhTW = "梅達·希恩" },
    },
    {
        id = 1818, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.7683, y = 0.6586,
        name = { enUS = "Officer Areyn", deDE = "Offizier Areyn", esES = "Oficial Areyn", esMX = "Oficial Areyn", frFR = "Officier Areyn", koKR = "장교 아레인", ptBR = "Oficial Areyn", ruRU = "Офицер Арейн", zhCN = "埃雷恩", zhTW = "埃雷恩" },
    },
    {
        id = 1819, types = { "vendor-repair" },
        faction = "Alliance", map = 1453, x = 0.5181, y = 0.8347,
        name = { enUS = "Wynne Larson", deDE = "Wynne Larson", esES = "Wynne Larson", esMX = "Wynne Larson", frFR = "Wynne Larson", koKR = "위니 라슨", ptBR = "Manoela Galante", ruRU = "Уинн Ларсон", zhCN = "维恩·拉尔森", zhTW = "威恩·拉爾森" },
    },
    {
        id = 1820, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.8228, y = 0.1887,
        name = { enUS = "Galthuk", deDE = "Galthuk", esES = "Galthuk", esMX = "Galthuk", frFR = "Galthuk", koKR = "갈투크", ptBR = "Galthuk", ruRU = "Галтук", zhCN = "加尔萨克", zhTW = "加爾薩克" },
    },
    {
        id = 1821, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.4568, y = 0.5593,
        name = { enUS = "Kareth", deDE = "Kareth", esES = "Kareth", esMX = "Kareth", frFR = "Kareth", koKR = "카레스", ptBR = "Kareth", ruRU = "Карехт", zhCN = "卡雷斯", zhTW = "卡雷斯" },
    },
    {
        id = 1822, types = { "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.4416, y = 0.4838,
        name = { enUS = "Katis", deDE = "Katis", esES = "Katis", esMX = "Katis", frFR = "Katis", koKR = "카티스", ptBR = "Katis", ruRU = "Катис", zhCN = "卡提斯", zhTW = "卡提斯" },
    },
    {
        id = 1823, types = { "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.7334, y = 0.4225,
        name = { enUS = "Kiro", deDE = "Kiro", esES = "Kiro", esMX = "Kiro", frFR = "Kiro", koKR = "카로", ptBR = "Kira", ruRU = "Киро", zhCN = "基罗", zhTW = "基羅" },
    },
    {
        id = 1824, types = { "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.8152, y = 0.1873,
        name = { enUS = "Koru", deDE = "Koru", esES = "Koru", esMX = "Koru", frFR = "Koru", koKR = "코루", ptBR = "Koru", ruRU = "Кору", zhCN = "考鲁", zhTW = "考魯" },
    },
    {
        id = 1825, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.4426, y = 0.4809,
        name = { enUS = "Muragus", deDE = "Muragus", esES = "Muragus", esMX = "Muragus", frFR = "Muragus", koKR = "무라구스", ptBR = "Muragus", ruRU = "Мурагус", zhCN = "穆拉古斯", zhTW = "穆拉古斯" },
    },
    {
        id = 1826, types = { "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.4150, y = 0.6862,
        name = { enUS = "Sergeant Ba'sha", deDE = "Sergeant Ba'sha", esES = "Sargento Ba'sha", esMX = "Sargento Ba'sha", frFR = "Sergent Ba'sha", koKR = "병장 바샤", ptBR = "Sargento Ba'sha", ruRU = "Сержант Ба'ша", zhCN = "巴沙", zhTW = "巴沙" },
    },
    {
        id = 1827, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.8161, y = 0.1887,
        name = { enUS = "Shoma", deDE = "Shoma", esES = "Shoma", esMX = "Shoma", frFR = "Shoma", koKR = "쇼마", ptBR = "Shoma", ruRU = "Шома", zhCN = "索玛", zhTW = "索瑪" },
    },
    {
        id = 1828, types = { "vendor-repair" },
        faction = "Horde", map = 1454, x = 0.8257, y = 0.2400,
        name = { enUS = "Sumi", deDE = "Sumi", esES = "Sumi", esMX = "Sumi", frFR = "Sumi", koKR = "수미", ptBR = "Sumi", ruRU = "Суми", zhCN = "苏米", zhTW = "蘇米" },
    },
    {
        id = 1829, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.2971, y = 0.7418,
        name = { enUS = "Ukra'nor", deDE = "Ukra'nor", esES = "Ukra'nor", esMX = "Ukra'nor", frFR = "Ukra'nor", koKR = "우크라노르", ptBR = "Ukra'nor", ruRU = "Укра'нор", zhCN = "尤克拉诺", zhTW = "尤克拉諾" },
    },
    {
        id = 1830, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1454, x = 0.4758, y = 0.6833,
        name = { enUS = "Urtharo", deDE = "Urtharo", esES = "Urtharo", esMX = "Urtharo", frFR = "Urtharo", koKR = "울타로", ptBR = "Urtharo", ruRU = "Уртаро", zhCN = "乌萨罗", zhTW = "烏薩羅" },
    },
    {
        id = 1831, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.5410, y = 0.5720,
        name = { enUS = "Delgo Ragetotem", deDE = "Delgo Ragetotem", esES = "Delgo Furiatótem", esMX = "Delgo Tótem de Ira", frFR = "Delgo Ragetotem", koKR = "델고 레이지토템", ptBR = "Delgo Totem da Fúria", ruRU = "Дельго Тотем Гнева", zhCN = "德尔贡·狂暴图腾", zhTW = "德爾貢·狂暴圖騰" },
    },
    {
        id = 1832, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.5321, y = 0.5835,
        name = { enUS = "Etu Ragetotem", deDE = "Etu Ragetotem", esES = "Etu Furiatótem", esMX = "Etu Tótem de Ira", frFR = "Etu Ragetotem", koKR = "에투 레이지토템", ptBR = "Etu Totem da Fúria", ruRU = "Эту Тотем Гнева", zhCN = "伊图·狂暴图腾", zhTW = "伊圖·狂暴圖騰" },
    },
    {
        id = 1833, types = { "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.5295, y = 0.5662,
        name = { enUS = "Kard Ragetotem", deDE = "Kard Ragetotem", esES = "Kard Furiatótem", esMX = "Kard Tótem de Ira", frFR = "Kard Ragetotem", koKR = "카드 레이지토템", ptBR = "Kard Totem da Fúria", ruRU = "Кард Тотем Гнева", zhCN = "卡德·狂暴图腾", zhTW = "卡德·狂暴圖騰" },
    },
    {
        id = 1834, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.5295, y = 0.5758,
        name = { enUS = "Ohanko", deDE = "Ohanko", esES = "Ohanko", esMX = "Ohanko", frFR = "Ohanko", koKR = "오한코", ptBR = "Ohanko", ruRU = "Оханко", zhCN = "奥汉克", zhTW = "奧漢克" },
    },
    {
        id = 1835, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 1456, x = 0.4963, y = 0.4877,
        name = { enUS = "Sunn Ragetotem", deDE = "Sunn Ragetotem", esES = "Sunn Furiatótem", esMX = "Sunn Tótem de Ira", frFR = "Sunn Ragetotem", koKR = "순 레이지토템", ptBR = "Sunn Totem da Fúria", ruRU = "Сунна Тотем Гнева", zhCN = "苏恩·狂暴图腾", zhTW = "蘇恩·狂暴圖騰" },
    },
    {
        id = 1836, types = { "vendor-repair" },
        faction = "Horde", map = 1456, x = 0.5154, y = 0.5509,
        name = { enUS = "Sura Wildmane", deDE = "Sura Wildmane", esES = "Sura Bravacrín", esMX = "Sura Ferocrín", frFR = "Sura Wildmane", koKR = "수라 와일드메인", ptBR = "Sura Juba Agreste", ruRU = "Сура Буйногривая", zhCN = "苏拉·蛮鬃", zhTW = "蘇拉·蠻鬃" },
    },
    {
        id = 1837, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.5616, y = 0.8894,
        name = { enUS = "Andrus", deDE = "Andrus", esES = "Andrus", esMX = "Andrus", frFR = "Andrus", koKR = "안드루스", ptBR = "Andrus", ruRU = "Андрус", zhCN = "安德鲁斯", zhTW = "安德魯斯" },
    },
    {
        id = 1838, types = { "vendor-repair" },
        faction = "Alliance", map = 1457, x = 0.5692, y = 0.7628,
        name = { enUS = "Caynrus", deDE = "Caynrus", esES = "Caynrus", esMX = "Caynrus", frFR = "Caynrus", koKR = "케인루스", ptBR = "Caynrus", ruRU = "Кайнрас", zhCN = "坎因鲁斯", zhTW = "坎因魯斯" },
    },
    {
        id = 1839, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6057, y = 0.7212,
        name = { enUS = "Ealyshia Dewwhisper", deDE = "Ealyshia Dewwhisper", esES = "Ealyshia Susurrocío", esMX = "Ealyshia Susurrocío", frFR = "Ealyshia Dewwhisper", koKR = "이알리샤 듀위스퍼", ptBR = "Ealyshia Murmorvalho", ruRU = "Илишия Шепот Росы", zhCN = "伊林希亚·露珠", zhTW = "伊林希亞·露珠" },
    },
    {
        id = 1840, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6422, y = 0.5909,
        name = { enUS = "Glorandiir", deDE = "Glorandiir", esES = "Glorandiir", esMX = "Glorandiir", frFR = "Glorandiir", koKR = "글로란디르", ptBR = "Glorandiir", ruRU = "Глорандир", zhCN = "格罗拉迪尔", zhTW = "格羅拉迪爾" },
    },
    {
        id = 1841, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6498, y = 0.6022,
        name = { enUS = "Kieran", deDE = "Kieran", esES = "Kieran", esMX = "Kieran", frFR = "Kieran", koKR = "키에란", ptBR = "Kieran", ruRU = "Киеран", zhCN = "基尔兰", zhTW = "基爾蘭" },
    },
    {
        id = 1842, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6536, y = 0.5965,
        name = { enUS = "Merelyssa", deDE = "Merelyssa", esES = "Merelyssa", esMX = "Merelyssa", frFR = "Merelyssa", koKR = "메렐릿사", ptBR = "Merelyssa", ruRU = "Мерелисса", zhCN = "米利希亚", zhTW = "米利希亞" },
    },
    {
        id = 1843, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6523, y = 0.6079,
        name = { enUS = "Mythidan", deDE = "Mythidan", esES = "Mythidan", esMX = "Mythidan", frFR = "Mythidan", koKR = "미시단", ptBR = "Mythidan", ruRU = "Митидан", zhCN = "迈希迪安", zhTW = "邁希迪安" },
    },
    {
        id = 1844, types = { "vendor-repair", "vendor" },
        faction = "Alliance", map = 2482, x = 0.7109, y = 0.5132,
        name = { enUS = "Aisarra Nightmeadow", deDE = "Aisarra Nightmeadow", esES = "Aisarra Nightmeadow", esMX = "Aisarra Nightmeadow", frFR = "Aisarra Nightmeadow", koKR = "Aisarra Nightmeadow", ptBR = "Aisarra Nightmeadow", ruRU = "Aisarra Nightmeadow", zhCN = "Aisarra Nightmeadow", zhTW = "Aisarra Nightmeadow" },
    },
    {
        id = 1845, types = { "vendor-repair" },
        map = 2482, x = 0.1340, y = 0.5240,
        name = { enUS = "Chagrak Hammerstrike", deDE = "Chagrak Hammerstrike", esES = "Chagrak Hammerstrike", esMX = "Chagrak Hammerstrike", frFR = "Chagrak Hammerstrike", koKR = "Chagrak Hammerstrike", ptBR = "Chagrak Hammerstrike", ruRU = "Chagrak Hammerstrike", zhCN = "Chagrak Hammerstrike", zhTW = "Chagrak Hammerstrike" },
    },
    {
        id = 1846, types = { "vendor-repair" },
        map = 2482, x = 0.1360, y = 0.5240,
        name = { enUS = "Chagrak Hammerstrike", deDE = "Chagrak Hammerstrike", esES = "Chagrak Hammerstrike", esMX = "Chagrak Hammerstrike", frFR = "Chagrak Hammerstrike", koKR = "Chagrak Hammerstrike", ptBR = "Chagrak Hammerstrike", ruRU = "Chagrak Hammerstrike", zhCN = "Chagrak Hammerstrike", zhTW = "Chagrak Hammerstrike" },
    },
    {
        id = 1847, types = { "vendor-repair" },
        map = 2482, x = 0.1360, y = 0.5260,
        name = { enUS = "Chagrak Hammerstrike", deDE = "Chagrak Hammerstrike", esES = "Chagrak Hammerstrike", esMX = "Chagrak Hammerstrike", frFR = "Chagrak Hammerstrike", koKR = "Chagrak Hammerstrike", ptBR = "Chagrak Hammerstrike", ruRU = "Chagrak Hammerstrike", zhCN = "Chagrak Hammerstrike", zhTW = "Chagrak Hammerstrike" },
    },
    {
        id = 1848, types = { "vendor-repair" },
        faction = "Alliance", map = 2482, x = 0.1560, y = 0.5060,
        name = { enUS = "Trigg Ironhand", deDE = "Trigg Ironhand", esES = "Trigg Ironhand", esMX = "Trigg Ironhand", frFR = "Trigg Ironhand", koKR = "Trigg Ironhand", ptBR = "Trigg Ironhand", ruRU = "Trigg Ironhand", zhCN = "Trigg Ironhand", zhTW = "Trigg Ironhand" },
    },
    {
        id = 1849, types = { "vendor-repair", "vendor-weapons" },
        faction = "Neutral", map = 2521, x = 0.6289, y = 0.7744,
        name = { enUS = "Belann Windwood", deDE = "Belann Windwood", esES = "Belann Windwood", esMX = "Belann Windwood", frFR = "Belann Windwood", koKR = "Belann Windwood", ptBR = "Belann Windwood", ruRU = "Belann Windwood", zhCN = "Belann Windwood", zhTW = "Belann Windwood" },
    },
    {
        id = 1850, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 2521, x = 0.5954, y = 0.7614,
        name = { enUS = "Elaria Anvilwind", deDE = "Elaria Anvilwind", esES = "Elaria Anvilwind", esMX = "Elaria Anvilwind", frFR = "Elaria Anvilwind", koKR = "Elaria Anvilwind", ptBR = "Elaria Anvilwind", ruRU = "Elaria Anvilwind", zhCN = "Elaria Anvilwind", zhTW = "Elaria Anvilwind" },
    },
    {
        id = 1851, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 2521, x = 0.5972, y = 0.7595,
        name = { enUS = "Ergaan Eastwind", deDE = "Ergaan Eastwind", esES = "Ergaan Eastwind", esMX = "Ergaan Eastwind", frFR = "Ergaan Eastwind", koKR = "Ergaan Eastwind", ptBR = "Ergaan Eastwind", ruRU = "Ergaan Eastwind", zhCN = "Ergaan Eastwind", zhTW = "Ergaan Eastwind" },
    },
    {
        id = 1852, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 2521, x = 0.5940, y = 0.7573,
        name = { enUS = "Falfaan Halfwind", deDE = "Falfaan Halfwind", esES = "Falfaan Halfwind", esMX = "Falfaan Halfwind", frFR = "Falfaan Halfwind", koKR = "Falfaan Halfwind", ptBR = "Falfaan Halfwind", ruRU = "Falfaan Halfwind", zhCN = "Falfaan Halfwind", zhTW = "Falfaan Halfwind" },
    },
    {
        id = 1853, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 2521, x = 0.4352, y = 0.2360,
        name = { enUS = "Jolee Brightmeadows", deDE = "Jolee Brightmeadows", esES = "Jolee Brightmeadows", esMX = "Jolee Brightmeadows", frFR = "Jolee Brightmeadows", koKR = "Jolee Brightmeadows", ptBR = "Jolee Brightmeadows", ruRU = "Jolee Brightmeadows", zhCN = "Jolee Brightmeadows", zhTW = "Jolee Brightmeadows" },
    },
    {
        id = 1854, types = { "vendor-repair", "vendor" },
        faction = "Neutral", map = 2521, x = 0.5933, y = 0.7624,
        name = { enUS = "Taliaa Brightsky", deDE = "Taliaa Brightsky", esES = "Taliaa Brightsky", esMX = "Taliaa Brightsky", frFR = "Taliaa Brightsky", koKR = "Taliaa Brightsky", ptBR = "Taliaa Brightsky", ruRU = "Taliaa Brightsky", zhCN = "Taliaa Brightsky", zhTW = "Taliaa Brightsky" },
    },
    {
        id = 1855, types = { "vendor-repair", "vendor-weapons" },
        faction = "Horde", map = 2548, x = 0.5983, y = 0.4597,
        name = { enUS = "Kreza Darkthorn", deDE = "Kreza Darkthorn", esES = "Kreza Darkthorn", esMX = "Kreza Darkthorn", frFR = "Kreza Darkthorn", koKR = "Kreza Darkthorn", ptBR = "Kreza Darkthorn", ruRU = "Kreza Darkthorn", zhCN = "Kreza Darkthorn", zhTW = "Kreza Darkthorn" },
    },
    {
        id = 1856, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 2548, x = 0.6433, y = 0.8202,
        name = { enUS = "Paige Armstrong", deDE = "Paige Armstrong", esES = "Paige Armstrong", esMX = "Paige Armstrong", frFR = "Paige Armstrong", koKR = "Paige Armstrong", ptBR = "Paige Armstrong", ruRU = "Paige Armstrong", zhCN = "Paige Armstrong", zhTW = "Paige Armstrong" },
    },
    {
        id = 1857, types = { "vendor-repair", "vendor-weapons" },
        faction = "Alliance", map = 2548, x = 0.6441, y = 0.8202,
        name = { enUS = "Paige Armstrong", deDE = "Paige Armstrong", esES = "Paige Armstrong", esMX = "Paige Armstrong", frFR = "Paige Armstrong", koKR = "Paige Armstrong", ptBR = "Paige Armstrong", ruRU = "Paige Armstrong", zhCN = "Paige Armstrong", zhTW = "Paige Armstrong" },
    },
    {
        id = 1858, types = { "vendor-trade" },
        faction = "Horde", map = 1411, x = 0.5301, y = 0.4200,
        name = { enUS = "Flakk", deDE = "Flakk", esES = "Flakk", esMX = "Flakk", frFR = "Flakk", koKR = "플라크", ptBR = "Flakk", ruRU = "Флакк", zhCN = "弗拉克", zhTW = "弗拉克" },
    },
    {
        id = 1859, types = { "vendor-trade" },
        faction = "Horde", map = 1411, x = 0.5639, y = 0.7381,
        name = { enUS = "Tai'tasi", deDE = "Tai'tasi", esES = "Tai'tasi", esMX = "Tai'tasi", frFR = "Tai'tasi", koKR = "타이타시", ptBR = "Tai'tasi", ruRU = "Тай'таси", zhCN = "泰塔希", zhTW = "泰塔希" },
    },
    {
        id = 1860, types = { "vendor-trade" },
        faction = "Horde", map = 1412, x = 0.4559, y = 0.6169,
        name = { enUS = "Wunna Darkmane", deDE = "Wunna Darkmane", esES = "Wunna Crinoscura", esMX = "Wunna Crinoscura", frFR = "Wunna Darkmane", koKR = "우나 다크메인", ptBR = "Vunna Crina Negra", ruRU = "Вунна Темная Грива", zhCN = "温纳·黑鬃", zhTW = "溫納·黑鬃" },
    },
    {
        id = 1861, types = { "vendor-trade" },
        faction = "Neutral", map = 1413, x = 0.6190, y = 0.3871,
        name = { enUS = "Ranik", deDE = "Ranik", esES = "Ranik", esMX = "Ranik", frFR = "Ranik", koKR = "래니크", ptBR = "Ranik", ruRU = "Раник", zhCN = "拉尼克", zhTW = "拉尼克" },
    },
    {
        id = 1862, types = { "vendor-trade" },
        faction = "Horde", map = 1413, x = 0.5170, y = 0.3000,
        name = { enUS = "Tari'qa", deDE = "Tari'qa", esES = "Tari'qa", esMX = "Tari'qa", frFR = "Tari'qa", koKR = "타리카", ptBR = "Tari'qa", ruRU = "Тарик'ка", zhCN = "塔里查", zhTW = "塔里查" },
    },
    {
        id = 1863, types = { "vendor-trade" },
        faction = "Alliance", map = 1416, x = 0.1318, y = 0.7156,
        name = { enUS = "Jack Findle", deDE = "Jack Findle", esES = "Jack Findle", esMX = "Jack Findle", frFR = "Jack Findle", koKR = "Jack Findle", ptBR = "Jack Findle", ruRU = "Jack Findle", zhCN = "Jack Findle", zhTW = "Jack Findle" },
    },
    {
        id = 1864, types = { "vendor-trade" },
        faction = "Alliance", map = 1416, x = 0.1321, y = 0.7125,
        name = { enUS = "Jack Findle", deDE = "Jack Findle", esES = "Jack Findle", esMX = "Jack Findle", frFR = "Jack Findle", koKR = "Jack Findle", ptBR = "Jack Findle", ruRU = "Jack Findle", zhCN = "Jack Findle", zhTW = "Jack Findle" },
    },
    {
        id = 1865, types = { "vendor-trade" },
        faction = "Alliance", map = 1417, x = 0.4648, y = 0.4739,
        name = { enUS = "Hammon Karwn", deDE = "Hammon Karwn", esES = "Hammon Karwn", esMX = "Hammon Karwn", frFR = "Hammon Karwn", koKR = "하몬 카른", ptBR = "Hammon Karwn", ruRU = "Хаммон Карун", zhCN = "哈蒙·卡文", zhTW = "哈蒙·卡文" },
    },
    {
        id = 1866, types = { "vendor-trade" },
        faction = "Horde", map = 1417, x = 0.7411, y = 0.3272,
        name = { enUS = "Keena", deDE = "Keena", esES = "Keena", esMX = "Keena", frFR = "Keena", koKR = "키나", ptBR = "Keena", ruRU = "Кеена", zhCN = "基纳", zhTW = "基納" },
    },
    {
        id = 1867, types = { "vendor-trade" },
        faction = "Horde", map = 1420, x = 0.6099, y = 0.5241,
        name = { enUS = "Abigail Shiel", deDE = "Abigail Shiel", esES = "Abigail Shiel", esMX = "Abigail Shiel", frFR = "Abigail Shiel", koKR = "애비게일 시엘", ptBR = "Sheila Abigail", ruRU = "Эбигейл Шиль", zhCN = "阿比盖尔·沙伊尔", zhTW = "阿比蓋爾·沙伊爾" },
    },
    {
        id = 1868, types = { "vendor-trade" },
        faction = "Horde", map = 1420, x = 0.6140, y = 0.7299,
        name = { enUS = "Daniel Bartlett", deDE = "Daniel Bartlett", esES = "Daniel Bartlett", esMX = "Daniel Bartlett", frFR = "Daniel Bartlett", koKR = "다니엘 바틀렛", ptBR = "Daniel Bartolotto", ruRU = "Даниэль Бартлетт", zhCN = "丹尼尔·巴特莱特", zhTW = "丹尼爾·巴特萊特" },
    },
    {
        id = 1869, types = { "vendor-trade" },
        faction = "Horde", map = 1420, x = 0.6140, y = 0.7578,
        name = { enUS = "Felicia Doan", deDE = "Felicia Doan", esES = "Felicia Doan", esMX = "Felicia Doan", frFR = "Felicia Doan", koKR = "펠리시아 도안", ptBR = "Felícia Doan", ruRU = "Фелиция Доан", zhCN = "菲利希亚·杜安", zhTW = "菲利希亞·杜安" },
    },
    {
        id = 1870, types = { "vendor-trade" },
        faction = "Horde", map = 1421, x = 0.4319, y = 0.4071,
        name = { enUS = "Andrew Hilbert", deDE = "Andrew Hilbert", esES = "Andrew Hilbert", esMX = "Andrew Hilbert", frFR = "Andrew Hilbert", koKR = "앤드류 힐버트", ptBR = "André Hilberto", ruRU = "Эндрю Гилберт", zhCN = "安德鲁·希尔伯特", zhTW = "安德魯·希爾伯特" },
    },
    {
        id = 1871, types = { "vendor-trade" },
        faction = "Neutral", map = 1423, x = 0.7091, y = 0.4808,
        name = { enUS = "Jase Farlane", deDE = "Jase Farlane", esES = "Jase Farlane", esMX = "Jase Farlane", frFR = "Jase Farlane", koKR = "제이스 파레인", ptBR = "Jessé Viálgures", ruRU = "Джез Фарлен", zhCN = "贾斯·法拉恩", zhTW = "賈斯·法拉恩" },
    },
    {
        id = 1872, types = { "vendor-trade" },
        faction = "Horde", map = 1424, x = 0.6229, y = 0.1900,
        name = { enUS = "Christoph Jeffcoat", deDE = "Christoph Jeffcoat", esES = "Christoph Jeffcoat", esMX = "Christoph Jeffcoat", frFR = "Christoph Jeffcoat", koKR = "크리스토프 제프코트", ptBR = "Cristóvão Casaqueiro", ruRU = "Кристоф Френч", zhCN = "克里斯托弗·杰弗寇特", zhTW = "克里斯多夫·傑弗寇特" },
    },
    {
        id = 1873, types = { "vendor-trade" },
        faction = "Alliance", map = 1424, x = 0.4892, y = 0.5500,
        name = { enUS = "Micha Yance", deDE = "Micha Yance", esES = "Micha Yance", esMX = "Micha Yance", frFR = "Micha Yance", koKR = "미카 얀스", ptBR = "Micha Yance", ruRU = "Мика Янс", zhCN = "米莎·杨斯", zhTW = "米莎·楊斯" },
    },
    {
        id = 1874, types = { "vendor-trade" },
        faction = "Neutral", map = 1425, x = 0.3448, y = 0.3860,
        name = { enUS = "Gigget Zipcoil", deDE = "Gigget Zipcoil", esES = "Gigget Retramuelle", esMX = "Gigget Retramuelle", frFR = "Gigget Zipcoil", koKR = "기젯 집코일", ptBR = "Giguê Zippespira", ruRU = "Гиджет Свистопулька", zhCN = "吉盖特·火油", zhTW = "吉蓋特·火油" },
    },
    {
        id = 1875, types = { "vendor-trade" },
        faction = "Alliance", map = 1426, x = 0.5852, y = 0.2539,
        name = { enUS = "Burbik Gearspanner", deDE = "Burbik Gearspanner", esES = "Burbik Trazagranaje", esMX = "Burbik Trazagranaje", frFR = "Burbik Gearspanner", koKR = "부르빅 기어스패너", ptBR = "Burbik Chavefenda", ruRU = "Бурбик Гайковерт", zhCN = "巴比克·齿轮", zhTW = "巴比克·齒輪" },
    },
    {
        id = 1876, types = { "vendor-trade" },
        faction = "Alliance", map = 1426, x = 0.5719, y = 0.3294,
        name = { enUS = "Fillius Fizzlespinner", deDE = "Fillius Fizzlespinner", esES = "Fillius Maleje", esMX = "Fillius Maleje", frFR = "Fillius Fizzlespinner", koKR = "필리우스 피즐스피너", ptBR = "Fillius Crisparroda", ruRU = "Филиус Свистопрях", zhCN = "菲留斯·旋翼", zhTW = "菲留斯·旋翼" },
    },
    {
        id = 1877, types = { "vendor-trade" },
        faction = "Alliance", map = 1426, x = 0.4680, y = 0.5369,
        name = { enUS = "Golorn Frostbeard", deDE = "Golorn Frostbeard", esES = "Golorn Barbagélida", esMX = "Golorn Barbagélida", frFR = "Golorn Frostbeard", koKR = "골론 프로스트비어드", ptBR = "Golorn Gelabarba", ruRU = "Голорн Ледобород", zhCN = "戈隆·霜须", zhTW = "戈隆·霜鬚" },
    },
    {
        id = 1878, types = { "vendor-trade" },
        faction = "Alliance", map = 1429, x = 0.4182, y = 0.6719,
        name = { enUS = "Tharynn Bouden", deDE = "Tharynn Bouden", esES = "Tharynn Bouden", esMX = "Tharynn Bouden", frFR = "Tharynn Bouden", koKR = "타린 바우던", ptBR = "Tirso Boal", ruRU = "Таринн Боуден", zhCN = "萨瑞恩·博丁", zhTW = "薩瑞恩·博丁" },
    },
    {
        id = 1879, types = { "vendor-trade" },
        faction = "Alliance", map = 1431, x = 0.7378, y = 0.4507,
        name = { enUS = "Gunder Thornbush", deDE = "Gunder Thornbush", esES = "Gunder Arbuspina", esMX = "Gunder Arbuspina", frFR = "Gunder Thornbush", koKR = "건더 손부시", ptBR = "Gunder Rasgarbusto", ruRU = "Гундер Боярышникс", zhCN = "冈德尔·索恩布什", zhTW = "岡德爾·索恩布希" },
    },
    {
        id = 1880, types = { "vendor-trade" },
        faction = "Alliance", map = 1432, x = 0.3561, y = 0.4917,
        name = { enUS = "Drac Roughcut", deDE = "Drac Roughcut", esES = "Drac Corteseco", esMX = "Drac Corteseco", frFR = "Drac Roughcut", koKR = "드락 러프컷", ptBR = "Drac Cortesseco", ruRU = "Драк Грубиян", zhCN = "德拉克·卷刃", zhTW = "德拉克·卷刃" },
    },
    {
        id = 1881, types = { "vendor-trade" },
        faction = "Horde", map = 1434, x = 0.3269, y = 0.2919,
        name = { enUS = "Nerrist", deDE = "Nerrist", esES = "Nerrist", esMX = "Nerrist", frFR = "Nerrist", koKR = "네리스트", ptBR = "Nerrist", ruRU = "Неррист", zhCN = "耐里斯特", zhTW = "耐里斯特" },
    },
    {
        id = 1882, types = { "vendor-trade" },
        faction = "Horde", map = 1435, x = 0.4481, y = 0.5662,
        name = { enUS = "Banalash", deDE = "Banalash", esES = "Banalash", esMX = "Banalash", frFR = "Banalash", koKR = "바나래쉬", ptBR = "Banalash", ruRU = "Баналаш", zhCN = "巴纳拉什", zhTW = "巴納拉許" },
    },
    {
        id = 1883, types = { "vendor-trade" },
        faction = "Alliance", map = 1436, x = 0.5221, y = 0.5280,
        name = { enUS = "Christopher Hewen", deDE = "Christopher Hewen", esES = "Christopher Hewen", esMX = "Christopher Hewen", frFR = "Christopher Hewen", koKR = "크리스토퍼 히웬", ptBR = "Cristóvão Cavo", ruRU = "Кристофер Хьюэн", zhCN = "克里斯托弗·赫温", zhTW = "克里斯多夫·赫溫" },
    },
    {
        id = 1884, types = { "vendor-trade" },
        faction = "Alliance", map = 1436, x = 0.5762, y = 0.5411,
        name = { enUS = "Gina MacGregor", deDE = "Gina MacGregor", esES = "Gina MacGregor", esMX = "Gina MacGregor", frFR = "Gina MacGregor", koKR = "지나 맥그레거", ptBR = "Regina Gregorsohn", ruRU = "Джина Макгрегор", zhCN = "吉娜·马克葛瑞格", zhTW = "吉娜·馬克葛瑞格" },
    },
    {
        id = 1885, types = { "vendor-trade" },
        faction = "Alliance", map = 1437, x = 0.1041, y = 0.6062,
        name = { enUS = "Kersok Prond", deDE = "Kersok Prond", esES = "Kersok Prond", esMX = "Kersok Prond", frFR = "Kersok Prond", koKR = "케르속 프론드", ptBR = "Kersok Prond", ruRU = "Керсок Пронд", zhCN = "科尔索克·普隆德", zhTW = "科爾索克·普隆德" },
    },
    {
        id = 1886, types = { "vendor-trade" },
        faction = "Alliance", map = 1438, x = 0.5530, y = 0.5718,
        name = { enUS = "Narret Shadowgrove", deDE = "Narret Shadowgrove", esES = "Narret Sombrarboleda", esMX = "Narret Sombrarboleda", frFR = "Narret Shadowgrove", koKR = "나렛 섀도그로브", ptBR = "Narret Brenhumbra", ruRU = "Наррет Тенистая Роща", zhCN = "纳瑞特·影林", zhTW = "納瑞特·影林" },
    },
    {
        id = 1887, types = { "vendor-trade" },
        faction = "Alliance", map = 1439, x = 0.3809, y = 0.4119,
        name = { enUS = "Gorbold Steelhand", deDE = "Gorbold Steelhand", esES = "Gorbold Mano de Acero", esMX = "Gorbold Mano de Acero", frFR = "Gorbold Steelhand", koKR = "골볼트 스틸핸드", ptBR = "Gorbold Manácero", ruRU = "Горбольд Сталерук", zhCN = "高尔博德·钢手", zhTW = "高爾博多·鋼手" },
    },
    {
        id = 1888, types = { "vendor-trade" },
        faction = "Alliance", map = 1439, x = 0.4379, y = 0.7640,
        name = { enUS = "Ullanna", deDE = "Ullanna", esES = "Ullanna", esMX = "Ullanna", frFR = "Ullanna", koKR = "울란나", ptBR = "Ullanna", ruRU = "Улланна", zhCN = "奥兰纳", zhTW = "奧蘭納" },
    },
    {
        id = 1889, types = { "vendor-trade" },
        faction = "Alliance", map = 1440, x = 0.3510, y = 0.5209,
        name = { enUS = "Dalria", deDE = "Dalria", esES = "Dalria", esMX = "Dalria", frFR = "Dalria", koKR = "달리아", ptBR = "Dalria", ruRU = "Дальрия", zhCN = "达利亚", zhTW = "達利亞" },
    },
    {
        id = 1890, types = { "vendor-trade" },
        faction = "Alliance", map = 1440, x = 0.4950, y = 0.6711,
        name = { enUS = "Shandrina", deDE = "Shandrina", esES = "Shandrina", esMX = "Shandrina", frFR = "Shandrina", koKR = "샨드리나", ptBR = "Shandrina", ruRU = "Шандрина", zhCN = "珊蒂瑞亚", zhTW = "珊蒂瑞亞" },
    },
    {
        id = 1891, types = { "vendor-trade" },
        faction = "Horde", map = 1441, x = 0.4621, y = 0.5150,
        name = { enUS = "Jandia", deDE = "Jandia", esES = "Jandia", esMX = "Jandia", frFR = "Jandia", koKR = "잔디아", ptBR = "Jandia", ruRU = "Джандия", zhCN = "詹迪亚", zhTW = "詹迪亞" },
    },
    {
        id = 1892, types = { "vendor-trade" },
        faction = "Horde", map = 1442, x = 0.4539, y = 0.5931,
        name = { enUS = "Kulwia", deDE = "Kulwia", esES = "Kulwia", esMX = "Kulwia", frFR = "Kulwia", koKR = "쿨위아", ptBR = "Kalwia", ruRU = "Кульвия", zhCN = "库尔维亚", zhTW = "庫爾維亞" },
    },
    {
        id = 1893, types = { "vendor-trade" },
        faction = "Horde", map = 1443, x = 0.5101, y = 0.5360,
        name = { enUS = "Kireena", deDE = "Kireena", esES = "Kireena", esMX = "Kireena", frFR = "Kireena", koKR = "키리나", ptBR = "Kireena", ruRU = "Киреена", zhCN = "基瑞娜", zhTW = "基瑞娜" },
    },
    {
        id = 1894, types = { "vendor-trade" },
        faction = "Horde", map = 1443, x = 0.2310, y = 0.7161,
        name = { enUS = "Lah'Mawhani", deDE = "Lah'Mawhani", esES = "Lah'Mawhani", esMX = "Lah'Mawhani", frFR = "Lah'Mawhani", koKR = "라마화니", ptBR = "Lah'Mawhani", ruRU = "Лах'Махвани", zhCN = "拉玛维", zhTW = "拉瑪維" },
    },
    {
        id = 1895, types = { "vendor-trade" },
        faction = "Horde", map = 1444, x = 0.7450, y = 0.4271,
        name = { enUS = "Sheendra Tallgrass", deDE = "Sheendra Tallgrass", esES = "Sheendra Pastoalto", esMX = "Sheendra Pastoalto", frFR = "Sheendra Tallgrass", koKR = "신드라 톨그래스", ptBR = "Shindra Grama Alta", ruRU = "Шиендра Высокая Трава", zhCN = "希恩德拉·深草", zhTW = "希恩德拉·深草" },
    },
    {
        id = 1896, types = { "vendor-trade" },
        faction = "Alliance", map = 1444, x = 0.3129, y = 0.4351,
        name = { enUS = "Vivianna", deDE = "Vivianna", esES = "Vivianna", esMX = "Vivianna", frFR = "Vivianna", koKR = "비비안나", ptBR = "Vivianna", ruRU = "Вивианна", zhCN = "薇薇安娜", zhTW = "薇薇安娜" },
    },
    {
        id = 1897, types = { "vendor-trade" },
        faction = "Alliance", map = 1445, x = 0.6641, y = 0.5150,
        name = { enUS = "Helenia Olden", deDE = "Helenia Olden", esES = "Helenia Olden", esMX = "Helenia Olden", frFR = "Helenia Olden", koKR = "헬레니아 올든", ptBR = "Heleninha Roydman", ruRU = "Еления Ольден", zhCN = "海伦妮亚·奥德恩", zhTW = "海倫妮亞·奧德恩" },
    },
    {
        id = 1898, types = { "vendor-trade" },
        faction = "Neutral", map = 1447, x = 0.4520, y = 0.9078,
        name = { enUS = "Blimo Gadgetspring", deDE = "Blimo Gadgetspring", esES = "Blimo Cacharretio", esMX = "Blimo Cacharretio", frFR = "Blimo Gadgetspring", koKR = "블리모 가젯스프링", ptBR = "Blimo Apertaporca", ruRU = "Блимо Прибамбас", zhCN = "布里莫", zhTW = "布里莫" },
    },
    {
        id = 1899, types = { "vendor-trade" },
        faction = "Neutral", map = 1450, x = 0.4818, y = 0.4008,
        name = { enUS = "Lorelae Wintersong", deDE = "Lorelae Wintersong", esES = "Lorelae Cantinvernal", esMX = "Lorelae Cantinvernal", frFR = "Lorelae Wintersong", koKR = "로렐라이 윈터송", ptBR = "Lorelae Invercanto", ruRU = "Лорелея Песнь Зимы", zhCN = "罗莱尔·冬歌", zhTW = "羅賴爾·冬歌" },
    },
    {
        id = 1900, types = { "vendor-trade" },
        faction = "Neutral", map = 1451, x = 0.4992, y = 0.3629,
        name = { enUS = "Mishta", deDE = "Mishta", esES = "Mishta", esMX = "Mishta", frFR = "Mishta", koKR = "미쉬타", ptBR = "Mishta", ruRU = "Мишта", zhCN = "米什塔", zhTW = "米希塔" },
    },
    {
        id = 1901, types = { "vendor-trade" },
        faction = "Neutral", map = 1452, x = 0.6119, y = 0.3721,
        name = { enUS = "Qia", deDE = "Qia", esES = "Qia", esMX = "Qia", frFR = "Qia", koKR = "퀴아", ptBR = "Qia", ruRU = "Кийя", zhCN = "琦亚", zhTW = "琪亞" },
    },
    {
        id = 1902, types = { "vendor-trade" },
        faction = "Alliance", map = 1452, x = 0.5160, y = 0.2980,
        name = { enUS = "Syurana", deDE = "Syurana", esES = "Syurana", esMX = "Syurana", frFR = "Syurana", koKR = "슈라나", ptBR = "Syurana", ruRU = "Сиурана", zhCN = "赛娜拉", zhTW = "賽娜拉" },
    },
    {
        id = 1903, types = { "vendor-trade" },
        faction = "Alliance", map = 1453, x = 0.6471, y = 0.7127,
        name = { enUS = "Edna Mullby", deDE = "Edna Mullby", esES = "Edna Mullby", esMX = "Edna Mullby", frFR = "Edna Mullby", koKR = "에드나 멀비", ptBR = "Edna Malheiros", ruRU = "Эдна Милби", zhCN = "艾德娜·穆比", zhTW = "艾德娜·穆比" },
    },
    {
        id = 1904, types = { "vendor-trade" },
        faction = "Horde", map = 1454, x = 0.6061, y = 0.4895,
        name = { enUS = "Felika", deDE = "Felika", esES = "Felika", esMX = "Felika", frFR = "Felika", koKR = "펠리카", ptBR = "Felika", ruRU = "Фелика", zhCN = "菲利卡", zhTW = "菲利卡" },
    },
    {
        id = 1905, types = { "vendor-trade" },
        faction = "Horde", map = 1454, x = 0.4787, y = 0.8031,
        name = { enUS = "Shimra", deDE = "Shimra", esES = "Shimra", esMX = "Shimra", frFR = "Shimra", koKR = "쉼라", ptBR = "Shimra", ruRU = "Шимра", zhCN = "史穆拉", zhTW = "史穆拉" },
    },
    {
        id = 1906, types = { "vendor-trade" },
        faction = "Horde", map = 1456, x = 0.4056, y = 0.6390,
        name = { enUS = "Shadi Mistrunner", deDE = "Shadi Mistrunner", esES = "Shadi Correbruma", esMX = "Shadi Correbruma", frFR = "Shadi Mistrunner", koKR = "샤디 미스트러너", ptBR = "Shadi Corre com a Névoa", ruRU = "Шади Вестница Туманов", zhCN = "沙迪·迷雾行者", zhTW = "沙迪·迷霧行者" },
    },
    {
        id = 1907, types = { "vendor-trade" },
        faction = "Alliance", map = 1457, x = 0.6095, y = 0.1771,
        name = { enUS = "Mythrin'dir", deDE = "Mythrin'dir", esES = "Mythrin'dir", esMX = "Mythrin'dir", frFR = "Mythrin'dir", koKR = "미스린디르", ptBR = "Mythrin'dir", ruRU = "Митрин'дир", zhCN = "迈斯林迪尔", zhTW = "邁斯林迪爾" },
    },
    {
        id = 1908, types = { "vendor-trade" },
        faction = "Neutral", map = 2521, x = 0.4477, y = 0.4505,
        name = { enUS = "Belandiel Farflight", deDE = "Belandiel Farflight", esES = "Belandiel Farflight", esMX = "Belandiel Farflight", frFR = "Belandiel Farflight", koKR = "Belandiel Farflight", ptBR = "Belandiel Farflight", ruRU = "Belandiel Farflight", zhCN = "Belandiel Farflight", zhTW = "Belandiel Farflight" },
    },
    {
        id = 1909, types = { "vendor-trade" },
        faction = "Neutral", map = 2521, x = 0.5896, y = 0.7555,
        name = { enUS = "Iallion Featherfall", deDE = "Iallion Featherfall", esES = "Iallion Featherfall", esMX = "Iallion Featherfall", frFR = "Iallion Featherfall", koKR = "Iallion Featherfall", ptBR = "Iallion Featherfall", ruRU = "Iallion Featherfall", zhCN = "Iallion Featherfall", zhTW = "Iallion Featherfall" },
    },
    {
        id = 1910, types = { "vendor-trade" },
        faction = "Alliance", map = 2548, x = 0.7928, y = 0.5472,
        name = { enUS = "Gilliwigs", deDE = "Gilliwigs", esES = "Gilliwigs", esMX = "Gilliwigs", frFR = "Gilliwigs", koKR = "Gilliwigs", ptBR = "Gilliwigs", ruRU = "Gilliwigs", zhCN = "Gilliwigs", zhTW = "Gilliwigs" },
    },
    {
        id = 1911, types = { "vendor-trade" },
        faction = "Alliance", map = 2548, x = 0.7932, y = 0.5463,
        name = { enUS = "Gilliwigs", deDE = "Gilliwigs", esES = "Gilliwigs", esMX = "Gilliwigs", frFR = "Gilliwigs", koKR = "Gilliwigs", ptBR = "Gilliwigs", ruRU = "Gilliwigs", zhCN = "Gilliwigs", zhTW = "Gilliwigs" },
    },
    {
        id = 1912, types = { "vendor-trade" },
        faction = "Alliance", map = 2548, x = 0.7974, y = 0.5404,
        name = { enUS = "Gilliwigs", deDE = "Gilliwigs", esES = "Gilliwigs", esMX = "Gilliwigs", frFR = "Gilliwigs", koKR = "Gilliwigs", ptBR = "Gilliwigs", ruRU = "Gilliwigs", zhCN = "Gilliwigs", zhTW = "Gilliwigs" },
    },
    {
        id = 1913, types = { "vendor-weapons" },
        faction = "Alliance", map = 1457, x = 0.6271, y = 0.6551,
        name = { enUS = "Turian", deDE = "Turian", esES = "Turian", esMX = "Turian", frFR = "Turian", koKR = "투리안", ptBR = "Turian", ruRU = "Туриан", zhCN = "图里安", zhTW = "圖里安" },
    },
    {
        id = 1914, types = { "vendor" },
        faction = "Horde", map = 1411, x = 0.4056, y = 0.6844,
        name = { enUS = "Hraug", deDE = "Hraug", esES = "Hraug", esMX = "Hraug", frFR = "Hraug", koKR = "흐라우그", ptBR = "Hraug", ruRU = "Хрог", zhCN = "赫劳格", zhTW = "赫勞格" },
    },
    {
        id = 1915, types = { "vendor" },
        faction = "Horde", map = 1411, x = 0.4610, y = 0.1377,
        name = { enUS = "Javnir Nashak", deDE = "Javnir Nashak", esES = "Javnir Nashak", esMX = "Javnir Nashak", frFR = "Javnir Nashak", koKR = "야브니르 나샤크", ptBR = "Javnir Nashak", ruRU = "Явнир Нашак", zhCN = "亚尼·纳沙克", zhTW = "亞尼·納沙克" },
    },
    {
        id = 1916, types = { "vendor" },
        faction = "Horde", map = 1411, x = 0.5471, y = 0.4150,
        name = { enUS = "Kitha", deDE = "Kitha", esES = "Kitha", esMX = "Kitha", frFR = "Kitha", koKR = "키타", ptBR = "Kitha", ruRU = "Китха", zhCN = "基萨", zhTW = "基薩" },
    },
    {
        id = 1917, types = { "vendor" },
        faction = "Neutral", map = 1411, x = 0.5211, y = 0.4731,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1918, types = { "vendor" },
        faction = "Neutral", map = 1411, x = 0.5214, y = 0.4743,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1919, types = { "vendor" },
        faction = "Neutral", map = 1411, x = 0.5239, y = 0.4064,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1920, types = { "vendor" },
        faction = "Horde", map = 1411, x = 0.4280, y = 0.6800,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 1921, types = { "vendor" },
        faction = "Horde", map = 1411, x = 0.5523, y = 0.7565,
        name = { enUS = "Zjolnir", deDE = "Zjolnir", esES = "Zjolnir", esMX = "Zjolnir", frFR = "Zjolnir", koKR = "졸니르", ptBR = "Zjolnir", ruRU = "Зьольнир", zhCN = "祖尼尔", zhTW = "祖尼爾" },
    },
    {
        id = 1922, types = { "vendor" },
        faction = "Neutral", map = 1412, x = 0.3751, y = 0.4412,
        name = { enUS = "Flik", deDE = "Flik", esES = "Flik", esMX = "Flik", frFR = "Flik", koKR = "플릭", ptBR = "Flik", ruRU = "Флик", zhCN = "弗里克", zhTW = "弗里克" },
    },
    {
        id = 1923, types = { "vendor" },
        faction = "Horde", map = 1412, x = 0.4665, y = 0.6208,
        name = { enUS = "Harb Clawhoof", deDE = "Harb Clawhoof", esES = "Harb Garrapezuña", esMX = "Harb Garrapezuña", frFR = "Harb Clawhoof", koKR = "할브 클로후프", ptBR = "Harb Casco Afiado", ruRU = "Харб Острое Копыто", zhCN = "哈布·爪蹄", zhTW = "哈布·爪蹄" },
    },
    {
        id = 1924, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4984, y = 0.2943,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1925, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4986, y = 0.2930,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1926, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4989, y = 0.2944,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1927, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4991, y = 0.2954,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1928, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4992, y = 0.2934,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1929, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4995, y = 0.2964,
        name = { enUS = "Apothecary Durelle", deDE = "Apothecary Durelle", esES = "Apothecary Durelle", esMX = "Apothecary Durelle", frFR = "Apothecary Durelle", koKR = "Apothecary Durelle", ptBR = "Apothecary Durelle", ruRU = "Apothecary Durelle", zhCN = "Apothecary Durelle", zhTW = "Apothecary Durelle" },
    },
    {
        id = 1930, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4948, y = 0.3079,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1931, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4965, y = 0.2959,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1932, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4966, y = 0.2986,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1933, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4969, y = 0.2951,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1934, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4970, y = 0.2975,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1935, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4983, y = 0.2960,
        name = { enUS = "Beneris", deDE = "Beneris", esES = "Beneris", esMX = "Beneris", frFR = "Beneris", koKR = "Beneris", ptBR = "Beneris", ruRU = "Beneris", zhCN = "Beneris", zhTW = "Beneris" },
    },
    {
        id = 1936, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4980, y = 0.2969,
        name = { enUS = "Fizzlefuse", deDE = "Fizzlefuse", esES = "Fizzlefuse", esMX = "Fizzlefuse", frFR = "Fizzlefuse", koKR = "Fizzlefuse", ptBR = "Fizzlefuse", ruRU = "Fizzlefuse", zhCN = "Fizzlefuse", zhTW = "Fizzlefuse" },
    },
    {
        id = 1937, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6264, y = 0.3627,
        name = { enUS = "Gagsprocket", deDE = "Gagsprocket", esES = "Dentolio", esMX = "Dentolio", frFR = "Gagsprocket", koKR = "객스프로켓", ptBR = "Grampola", ruRU = "Заглушестер", zhCN = "加格斯普吉特", zhTW = "加格斯普吉特" },
    },
    {
        id = 1938, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4863, y = 0.2962,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 1939, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4871, y = 0.2937,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 1940, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4905, y = 0.2885,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 1941, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4938, y = 0.2942,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 1942, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5531, y = 0.3179,
        name = { enUS = "Grub", deDE = "Grub", esES = "Larva", esMX = "Larva", frFR = "Boustiff'", koKR = "그럽", ptBR = "Grude", ruRU = "Грязнуля", zhCN = "格拉布", zhTW = "格拉布" },
    },
    {
        id = 1943, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4671, y = 0.0868,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 1944, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4960, y = 0.2946,
        name = { enUS = "Jim'bek", deDE = "Jim'bek", esES = "Jim'bek", esMX = "Jim'bek", frFR = "Jim'bek", koKR = "Jim'bek", ptBR = "Jim'bek", ruRU = "Jim'bek", zhCN = "Jim'bek", zhTW = "Jim'bek" },
    },
    {
        id = 1945, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4962, y = 0.2960,
        name = { enUS = "Jim'bek", deDE = "Jim'bek", esES = "Jim'bek", esMX = "Jim'bek", frFR = "Jim'bek", koKR = "Jim'bek", ptBR = "Jim'bek", ruRU = "Jim'bek", zhCN = "Jim'bek", zhTW = "Jim'bek" },
    },
    {
        id = 1946, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4984, y = 0.2928,
        name = { enUS = "Jim'bek", deDE = "Jim'bek", esES = "Jim'bek", esMX = "Jim'bek", frFR = "Jim'bek", koKR = "Jim'bek", ptBR = "Jim'bek", ruRU = "Jim'bek", zhCN = "Jim'bek", zhTW = "Jim'bek" },
    },
    {
        id = 1947, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5226, y = 0.3202,
        name = { enUS = "Kalyimah Stormcloud", deDE = "Kalyimah Stormcloud", esES = "Kalyimah Nubormenta", esMX = "Kalyimah Nubormenta", frFR = "Kalyimah Stormcloud", koKR = "칼리이마 스톰클라우드", ptBR = "Kalyimah Turvanuvem", ruRU = "Калимах Грозовая Туча", zhCN = "卡里玛·雷云", zhTW = "卡里瑪·雷雲" },
    },
    {
        id = 1948, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4945, y = 0.3090,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1949, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4963, y = 0.3037,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1950, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4973, y = 0.3041,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1951, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4974, y = 0.2976,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1952, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4975, y = 0.2996,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1953, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4982, y = 0.3011,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1954, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4986, y = 0.2949,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1955, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4996, y = 0.3055,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1956, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5072, y = 0.3059,
        name = { enUS = "Kurvelk Shadowhoof", deDE = "Kurvelk Shadowhoof", esES = "Kurvelk Shadowhoof", esMX = "Kurvelk Shadowhoof", frFR = "Kurvelk Shadowhoof", koKR = "Kurvelk Shadowhoof", ptBR = "Kurvelk Shadowhoof", ruRU = "Kurvelk Shadowhoof", zhCN = "Kurvelk Shadowhoof", zhTW = "Kurvelk Shadowhoof" },
    },
    {
        id = 1957, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4874, y = 0.2972,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1958, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4908, y = 0.2870,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1959, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4914, y = 0.2820,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1960, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4927, y = 0.2875,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1961, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4933, y = 0.2878,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1962, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4964, y = 0.2873,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1963, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4967, y = 0.2884,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1964, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4970, y = 0.2904,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1965, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4981, y = 0.2892,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1966, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4990, y = 0.2894,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1967, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5002, y = 0.2894,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1968, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5024, y = 0.2902,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1969, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.5043, y = 0.2903,
        name = { enUS = "Okamache", deDE = "Okamache", esES = "Okamache", esMX = "Okamache", frFR = "Okamache", koKR = "Okamache", ptBR = "Okamache", ruRU = "Okamache", zhCN = "Okamache", zhTW = "Okamache" },
    },
    {
        id = 1970, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4961, y = 0.2966,
        name = { enUS = "Pawani", deDE = "Pawani", esES = "Pawani", esMX = "Pawani", frFR = "Pawani", koKR = "Pawani", ptBR = "Pawani", ruRU = "Pawani", zhCN = "Pawani", zhTW = "Pawani" },
    },
    {
        id = 1971, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4971, y = 0.2932,
        name = { enUS = "Pawani", deDE = "Pawani", esES = "Pawani", esMX = "Pawani", frFR = "Pawani", koKR = "Pawani", ptBR = "Pawani", ruRU = "Pawani", zhCN = "Pawani", zhTW = "Pawani" },
    },
    {
        id = 1972, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4972, y = 0.2939,
        name = { enUS = "Pawani", deDE = "Pawani", esES = "Pawani", esMX = "Pawani", frFR = "Pawani", koKR = "Pawani", ptBR = "Pawani", ruRU = "Pawani", zhCN = "Pawani", zhTW = "Pawani" },
    },
    {
        id = 1973, types = { "vendor" },
        faction = "Horde", map = 1413, x = 0.4977, y = 0.2960,
        name = { enUS = "Pawani", deDE = "Pawani", esES = "Pawani", esMX = "Pawani", frFR = "Pawani", koKR = "Pawani", ptBR = "Pawani", ruRU = "Pawani", zhCN = "Pawani", zhTW = "Pawani" },
    },
    {
        id = 1974, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.5202, y = 0.3120,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1975, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.5209, y = 0.3142,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1976, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6261, y = 0.3805,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 1977, types = { "vendor" },
        map = 1413, x = 0.4693, y = 0.3589,
        name = { enUS = "Repair Bot", deDE = "Repair Bot", esES = "Repair Bot", esMX = "Repair Bot", frFR = "Repair Bot", koKR = "Repair Bot", ptBR = "Repair Bot", ruRU = "Repair Bot", zhCN = "Repair Bot", zhTW = "Repair Bot" },
    },
    {
        id = 1978, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6219, y = 0.3797,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1979, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6225, y = 0.3802,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1980, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6229, y = 0.3774,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1981, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6238, y = 0.3770,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1982, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6256, y = 0.3758,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1983, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6267, y = 0.3763,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1984, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6274, y = 0.3746,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1985, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6279, y = 0.3750,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1986, types = { "vendor" },
        faction = "Neutral", map = 1413, x = 0.6289, y = 0.3794,
        name = { enUS = "Winklespark", deDE = "Winklespark", esES = "Winklespark", esMX = "Winklespark", frFR = "Winklespark", koKR = "Winklespark", ptBR = "Winklespark", ruRU = "Winklespark", zhCN = "Winklespark", zhTW = "Winklespark" },
    },
    {
        id = 1987, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1513, y = 0.5714,
        name = { enUS = "Alfred Copperworth", deDE = "Alfred Copperworth", esES = "Alfred Copperworth", esMX = "Alfred Copperworth", frFR = "Alfred Copperworth", koKR = "Alfred Copperworth", ptBR = "Alfred Copperworth", ruRU = "Alfred Copperworth", zhCN = "Alfred Copperworth", zhTW = "Alfred Copperworth" },
    },
    {
        id = 1988, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1526, y = 0.5654,
        name = { enUS = "Alfred Copperworth", deDE = "Alfred Copperworth", esES = "Alfred Copperworth", esMX = "Alfred Copperworth", frFR = "Alfred Copperworth", koKR = "Alfred Copperworth", ptBR = "Alfred Copperworth", ruRU = "Alfred Copperworth", zhCN = "Alfred Copperworth", zhTW = "Alfred Copperworth" },
    },
    {
        id = 1989, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1537, y = 0.5641,
        name = { enUS = "Alfred Copperworth", deDE = "Alfred Copperworth", esES = "Alfred Copperworth", esMX = "Alfred Copperworth", frFR = "Alfred Copperworth", koKR = "Alfred Copperworth", ptBR = "Alfred Copperworth", ruRU = "Alfred Copperworth", zhCN = "Alfred Copperworth", zhTW = "Alfred Copperworth" },
    },
    {
        id = 1990, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1539, y = 0.5648,
        name = { enUS = "Alfred Copperworth", deDE = "Alfred Copperworth", esES = "Alfred Copperworth", esMX = "Alfred Copperworth", frFR = "Alfred Copperworth", koKR = "Alfred Copperworth", ptBR = "Alfred Copperworth", ruRU = "Alfred Copperworth", zhCN = "Alfred Copperworth", zhTW = "Alfred Copperworth" },
    },
    {
        id = 1991, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1561, y = 0.5712,
        name = { enUS = "Alfred Copperworth", deDE = "Alfred Copperworth", esES = "Alfred Copperworth", esMX = "Alfred Copperworth", frFR = "Alfred Copperworth", koKR = "Alfred Copperworth", ptBR = "Alfred Copperworth", ruRU = "Alfred Copperworth", zhCN = "Alfred Copperworth", zhTW = "Alfred Copperworth" },
    },
    {
        id = 1992, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.3929, y = 0.8233,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 1993, types = { "vendor" },
        map = 1416, x = 0.1587, y = 0.6875,
        name = { enUS = "Brammold Deepmine", deDE = "Brammold Deepmine", esES = "Brammold Deepmine", esMX = "Brammold Deepmine", frFR = "Brammold Deepmine", koKR = "Brammold Deepmine", ptBR = "Brammold Deepmine", ruRU = "Brammold Deepmine", zhCN = "Brammold Deepmine", zhTW = "Brammold Deepmine" },
    },
    {
        id = 1994, types = { "vendor" },
        map = 1416, x = 0.1020, y = 0.6560,
        name = { enUS = "Coira Longrifle", deDE = "Coira Longrifle", esES = "Coira Longrifle", esMX = "Coira Longrifle", frFR = "Coira Longrifle", koKR = "Coira Longrifle", ptBR = "Coira Longrifle", ruRU = "Coira Longrifle", zhCN = "Coira Longrifle", zhTW = "Coira Longrifle" },
    },
    {
        id = 1995, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.2165, y = 0.6904,
        name = { enUS = "Darahir", deDE = "Darahir", esES = "Darahir", esMX = "Darahir", frFR = "Darahir", koKR = "Darahir", ptBR = "Darahir", ruRU = "Darahir", zhCN = "Darahir", zhTW = "Darahir" },
    },
    {
        id = 1996, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.2168, y = 0.6911,
        name = { enUS = "Darahir", deDE = "Darahir", esES = "Darahir", esMX = "Darahir", frFR = "Darahir", koKR = "Darahir", ptBR = "Darahir", ruRU = "Darahir", zhCN = "Darahir", zhTW = "Darahir" },
    },
    {
        id = 1997, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.2170, y = 0.6889,
        name = { enUS = "Darahir", deDE = "Darahir", esES = "Darahir", esMX = "Darahir", frFR = "Darahir", koKR = "Darahir", ptBR = "Darahir", ruRU = "Darahir", zhCN = "Darahir", zhTW = "Darahir" },
    },
    {
        id = 1998, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1536, y = 0.6827,
        name = { enUS = "Debbi Moore", deDE = "Debbi Moore", esES = "Debbi Moore", esMX = "Debbi Moore", frFR = "Debbi Moore", koKR = "Debbi Moore", ptBR = "Debbi Moore", ruRU = "Debbi Moore", zhCN = "Debbi Moore", zhTW = "Debbi Moore" },
    },
    {
        id = 1999, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1540, y = 0.6836,
        name = { enUS = "Debbi Moore", deDE = "Debbi Moore", esES = "Debbi Moore", esMX = "Debbi Moore", frFR = "Debbi Moore", koKR = "Debbi Moore", ptBR = "Debbi Moore", ruRU = "Debbi Moore", zhCN = "Debbi Moore", zhTW = "Debbi Moore" },
    },
    {
        id = 2000, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1247, y = 0.6592,
        name = { enUS = "Derek Odds", deDE = "Derek Odds", esES = "Derek Odds", esMX = "Derek Odds", frFR = "Derek Odds", koKR = "Derek Odds", ptBR = "Derek Odds", ruRU = "Derek Odds", zhCN = "Derek Odds", zhTW = "Derek Odds" },
    },
    {
        id = 2001, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1252, y = 0.6596,
        name = { enUS = "Derek Odds", deDE = "Derek Odds", esES = "Derek Odds", esMX = "Derek Odds", frFR = "Derek Odds", koKR = "Derek Odds", ptBR = "Derek Odds", ruRU = "Derek Odds", zhCN = "Derek Odds", zhTW = "Derek Odds" },
    },
    {
        id = 2002, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1488, y = 0.6549,
        name = { enUS = "Derek Odds", deDE = "Derek Odds", esES = "Derek Odds", esMX = "Derek Odds", frFR = "Derek Odds", koKR = "Derek Odds", ptBR = "Derek Odds", ruRU = "Derek Odds", zhCN = "Derek Odds", zhTW = "Derek Odds" },
    },
    {
        id = 2003, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1582, y = 0.6906,
        name = { enUS = "Elizabeth Ross", deDE = "Elizabeth Ross", esES = "Elizabeth Ross", esMX = "Elizabeth Ross", frFR = "Elizabeth Ross", koKR = "Elizabeth Ross", ptBR = "Elizabeth Ross", ruRU = "Elizabeth Ross", zhCN = "Elizabeth Ross", zhTW = "Elizabeth Ross" },
    },
    {
        id = 2004, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1583, y = 0.6900,
        name = { enUS = "Elizabeth Ross", deDE = "Elizabeth Ross", esES = "Elizabeth Ross", esMX = "Elizabeth Ross", frFR = "Elizabeth Ross", koKR = "Elizabeth Ross", ptBR = "Elizabeth Ross", ruRU = "Elizabeth Ross", zhCN = "Elizabeth Ross", zhTW = "Elizabeth Ross" },
    },
    {
        id = 2005, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1402, y = 0.6349,
        name = { enUS = "Hagatha Moorehead", deDE = "Hagatha Moorehead", esES = "Hagatha Moorehead", esMX = "Hagatha Moorehead", frFR = "Hagatha Moorehead", koKR = "Hagatha Moorehead", ptBR = "Hagatha Moorehead", ruRU = "Hagatha Moorehead", zhCN = "Hagatha Moorehead", zhTW = "Hagatha Moorehead" },
    },
    {
        id = 2006, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1809, y = 0.6201,
        name = { enUS = "Harold Winston", deDE = "Harold Winston", esES = "Harold Winston", esMX = "Harold Winston", frFR = "Harold Winston", koKR = "Harold Winston", ptBR = "Harold Winston", ruRU = "Harold Winston", zhCN = "Harold Winston", zhTW = "Harold Winston" },
    },
    {
        id = 2007, types = { "vendor" },
        faction = "Horde", map = 1416, x = 0.6309, y = 0.5987,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2008, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.0999, y = 0.6662,
        name = { enUS = "Laire Brewgold", deDE = "Laire Brewgold", esES = "Laire Brewgold", esMX = "Laire Brewgold", frFR = "Laire Brewgold", koKR = "Laire Brewgold", ptBR = "Laire Brewgold", ruRU = "Laire Brewgold", zhCN = "Laire Brewgold", zhTW = "Laire Brewgold" },
    },
    {
        id = 2009, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1052, y = 0.6612,
        name = { enUS = "Laire Brewgold", deDE = "Laire Brewgold", esES = "Laire Brewgold", esMX = "Laire Brewgold", frFR = "Laire Brewgold", koKR = "Laire Brewgold", ptBR = "Laire Brewgold", ruRU = "Laire Brewgold", zhCN = "Laire Brewgold", zhTW = "Laire Brewgold" },
    },
    {
        id = 2010, types = { "vendor" },
        map = 1416, x = 0.2029, y = 0.6748,
        name = { enUS = "Lucian Trias", deDE = "Lucian Trias", esES = "Lucian Trias", esMX = "Lucian Trias", frFR = "Lucian Trias", koKR = "Lucian Trias", ptBR = "Lucian Trias", ruRU = "Lucian Trias", zhCN = "Lucian Trias", zhTW = "Lucian Trias" },
    },
    {
        id = 2011, types = { "vendor" },
        map = 1416, x = 0.2034, y = 0.6758,
        name = { enUS = "Lucian Trias", deDE = "Lucian Trias", esES = "Lucian Trias", esMX = "Lucian Trias", frFR = "Lucian Trias", koKR = "Lucian Trias", ptBR = "Lucian Trias", ruRU = "Lucian Trias", zhCN = "Lucian Trias", zhTW = "Lucian Trias" },
    },
    {
        id = 2012, types = { "vendor" },
        map = 1416, x = 0.2035, y = 0.6752,
        name = { enUS = "Lucian Trias", deDE = "Lucian Trias", esES = "Lucian Trias", esMX = "Lucian Trias", frFR = "Lucian Trias", koKR = "Lucian Trias", ptBR = "Lucian Trias", ruRU = "Lucian Trias", zhCN = "Lucian Trias", zhTW = "Lucian Trias" },
    },
    {
        id = 2013, types = { "vendor" },
        map = 1416, x = 0.1597, y = 0.6551,
        name = { enUS = "Norvin Alderman", deDE = "Norvin Alderman", esES = "Norvin Alderman", esMX = "Norvin Alderman", frFR = "Norvin Alderman", koKR = "Norvin Alderman", ptBR = "Norvin Alderman", ruRU = "Norvin Alderman", zhCN = "Norvin Alderman", zhTW = "Norvin Alderman" },
    },
    {
        id = 2014, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1647, y = 0.6547,
        name = { enUS = "Sheddle Glossgleam", deDE = "Sheddle Glossgleam", esES = "Sheddle Glossgleam", esMX = "Sheddle Glossgleam", frFR = "Sheddle Glossgleam", koKR = "Sheddle Glossgleam", ptBR = "Sheddle Glossgleam", ruRU = "Sheddle Glossgleam", zhCN = "Sheddle Glossgleam", zhTW = "Sheddle Glossgleam" },
    },
    {
        id = 2015, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1802, y = 0.6209,
        name = { enUS = "Tiffany Cartier", deDE = "Tiffany Cartier", esES = "Tiffany Cartier", esMX = "Tiffany Cartier", frFR = "Tiffany Cartier", koKR = "Tiffany Cartier", ptBR = "Tiffany Cartier", ruRU = "Tiffany Cartier", zhCN = "Tiffany Cartier", zhTW = "Tiffany Cartier" },
    },
    {
        id = 2016, types = { "vendor" },
        faction = "Alliance", map = 1416, x = 0.1448, y = 0.6700,
        name = { enUS = "Windle Sparkshine", deDE = "Windle Sparkshine", esES = "Windle Sparkshine", esMX = "Windle Sparkshine", frFR = "Windle Sparkshine", koKR = "Windle Sparkshine", ptBR = "Windle Sparkshine", ruRU = "Windle Sparkshine", zhCN = "Windle Sparkshine", zhTW = "Windle Sparkshine" },
    },
    {
        id = 2017, types = { "vendor" },
        faction = "Neutral", map = 1416, x = 0.8595, y = 0.7996,
        name = { enUS = "Zan Shivsproket", deDE = "Zan Shivsproket", esES = "Zan Sivadento", esMX = "Zan Sivadento", frFR = "Zan Shivsproket", koKR = "잰 쉬브스프로켓", ptBR = "Zan Estoquesseta", ruRU = "Зан Кругореззик", zhCN = "萨恩·刀链", zhTW = "薩恩·刀鏈" },
    },
    {
        id = 2018, types = { "vendor" },
        faction = "Alliance", map = 1417, x = 0.4565, y = 0.4575,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 2019, types = { "vendor" },
        faction = "Horde", map = 1417, x = 0.7350, y = 0.2913,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2020, types = { "vendor" },
        faction = "Alliance", map = 1418, x = 0.5342, y = 0.4339,
        name = { enUS = "Prospector Ryedol", deDE = "Ausgrabungsleiter Ryedol", esES = "Prospector Ryedol", esMX = "Prospector Ryedol", frFR = "Prospecteur Ryedol", koKR = "발굴조사단장 라이돌", ptBR = "Prospector Ryedol", ruRU = "Геолог Ржанец", zhCN = "勘察员雷杜尔", zhTW = "勘察員雷杜爾" },
    },
    {
        id = 2021, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.8328, y = 0.6923,
        name = { enUS = "Apothecary Dithers", deDE = "Apotheker Dithers", esES = "Boticario Dithers", esMX = "Boticario Dithers", frFR = "Apothicaire Dithers", koKR = "연금술사 디더스", ptBR = "Boticário Trépido", ruRU = "Аптекарь Дитерс", zhCN = "药剂师迪瑟斯", zhTW = "藥劑師迪瑟斯" },
    },
    {
        id = 2022, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.5557, y = 0.6990,
        name = { enUS = "Darkcaller Yanka", deDE = "Ruferin der Dunkelheit Yanka", esES = "Llamasombra Yanka", esMX = "Clamasombras Yanka", frFR = "Sombre imploratrice Yanka", koKR = "암흑의 소환사 얀카", ptBR = "Invoca-trevas Yanka", ruRU = "Янка Зовущая Тьму", zhCN = "黑暗召唤者雅恩卡", zhTW = "黑暗召喚者雅恩卡" },
    },
    {
        id = 2023, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.6155, y = 0.5261,
        name = { enUS = "Gina Lang", deDE = "Gina Lang", esES = "Gina Lang", esMX = "Gina Lang", frFR = "Gina Lang", koKR = "지나 랭", ptBR = "Gina Lang", ruRU = "Джина Ланг", zhCN = "吉娜·朗恩", zhTW = "吉娜·朗恩" },
    },
    {
        id = 2024, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.3081, y = 0.6641,
        name = { enUS = "Kayla Smithe", deDE = "Kayla Smithe", esES = "Kayla Herrera", esMX = "Kayla Herrera", frFR = "Kayla Smithe", koKR = "케일라 스미스", ptBR = "Queila Ferraz", ruRU = "Кайла Смит", zhCN = "凯拉·斯密瑟", zhTW = "凱拉·斯密瑟" },
    },
    {
        id = 2025, types = { "vendor" },
        faction = "Neutral", map = 1420, x = 0.6076, y = 0.5251,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2026, types = { "vendor" },
        faction = "Neutral", map = 1420, x = 0.6183, y = 0.6456,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2027, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.3140, y = 0.6640,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2028, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.3140, y = 0.6660,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2029, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.6176, y = 0.5003,
        name = { enUS = "Selina Weston", deDE = "Selina Weston", esES = "Selina Weston", esMX = "Selina Weston", frFR = "Selina Weston", koKR = "셀리나 웨스톤", ptBR = "Selina Weston", ruRU = "Селина Уэстман", zhCN = "塞琳娜·温斯顿", zhTW = "塞琳娜·溫斯頓" },
    },
    {
        id = 2030, types = { "vendor" },
        faction = "Horde", map = 1420, x = 0.5987, y = 0.5268,
        name = { enUS = "Zachariah Post", deDE = "Zachariah Post", esES = "Zacarías Posta", esMX = "Zacarías Posta", frFR = "Zachariah Post", koKR = "자카리아 포스트", ptBR = "Zacarias Pústulo", ruRU = "Захария Пост", zhCN = "撒迦利亚·普斯特", zhTW = "撒迦利亞·普斯特" },
    },
    {
        id = 2031, types = { "vendor" },
        faction = "Neutral", map = 1421, x = 0.6252, y = 0.6265,
        name = { enUS = "Dalaran Miner", deDE = "Minenarbeiter von Dalaran", esES = "Minero Dalaran", esMX = "Minero de Dalaran", frFR = "Mineur de Dalaran", koKR = "달라란 광부", ptBR = "Minerador de Dalaran", ruRU = "Даларанский шахтер", zhCN = "达拉然矿工", zhTW = "達拉然礦工" },
    },
    {
        id = 2032, types = { "vendor" },
        faction = "Neutral", map = 1421, x = 0.4351, y = 0.4104,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2033, types = { "vendor" },
        faction = "Neutral", map = 1421, x = 0.4366, y = 0.4118,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2034, types = { "vendor" },
        faction = "Neutral", map = 1421, x = 0.4414, y = 0.4187,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2035, types = { "vendor" },
        faction = "Neutral", map = 1421, x = 0.4419, y = 0.4189,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2036, types = { "vendor" },
        faction = "Alliance", map = 1422, x = 0.4266, y = 0.8377,
        name = { enUS = "Alchemist Arbington", deDE = "Alchimist Arbington", esES = "Alquimista Arbington", esMX = "Alquimista Arbington", frFR = "Alchimiste Arbington", koKR = "연금술사 알빙턴", ptBR = "Alquimista Arvignon", ruRU = "Алхимик Арбингтон", zhCN = "化学家阿尔比顿", zhTW = "鍊金師阿爾比頓" },
    },
    {
        id = 2037, types = { "vendor" },
        faction = "Neutral", map = 1422, x = 0.3946, y = 0.6676,
        name = { enUS = "Chromie", deDE = "Chromie", esES = "Cromi", esMX = "Cromi", frFR = "Chromie", koKR = "크로미", ptBR = "Crona", ruRU = "Хроми", zhCN = "克罗米", zhTW = "克羅米" },
    },
    {
        id = 2038, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3115, y = 0.4672,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2039, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3117, y = 0.4390,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2040, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3161, y = 0.4448,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2041, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3189, y = 0.4672,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2042, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3196, y = 0.4583,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2043, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.3262, y = 0.4514,
        name = { enUS = "Hillsbrad Apprentice Blacksmith", deDE = "Schmiedelehrling von Hillsbrad", esES = "Herrero aprendiz de Trabalomas", esMX = "Herrero aprendiz de Trabalomas", frFR = "Apprenti forgeron d'Hillsbrad", koKR = "힐스브래드 수습대장장이", ptBR = "Ferreiro Aprendiz de Eira dos Montes", ruRU = "Хилбрадский ученик кузнеца", zhCN = "希尔斯布莱德见习铁匠", zhTW = "希爾斯布萊德見習鐵匠" },
    },
    {
        id = 2044, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.5063, y = 0.6095,
        name = { enUS = "Lindea Rabonne", deDE = "Lindea Rabonne", esES = "Lindea Rabonne", esMX = "Lindea Rabonne", frFR = "Lindea Rabonne", koKR = "린디아 라본느", ptBR = "Lindeia Espinha-de-peixe", ruRU = "Линди Рабонн", zhCN = "林迪·拉波尼", zhTW = "林迪·拉波尼" },
    },
    {
        id = 2045, types = { "vendor" },
        faction = "Alliance", map = 1424, x = 0.5219, y = 0.5548,
        name = { enUS = "Merideth Carlson", deDE = "Merideth Carlson", esES = "Merideth Carlson", esMX = "Merideth Carlson", frFR = "Merideth Carlson", koKR = "메리데스 칼슨", ptBR = "Judite Castanheira", ruRU = "Меридет Карлсон", zhCN = "梅丽德丝·卡尔森", zhTW = "梅麗德絲·卡爾森" },
    },
    {
        id = 2046, types = { "vendor" },
        faction = "Horde", map = 1425, x = 0.5033, y = 0.8957,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2047, types = { "vendor" },
        map = 1425, x = 0.7780, y = 0.7800,
        name = { enUS = "Qujo", deDE = "Qujo", esES = "Qujo", esMX = "Qujo", frFR = "Qujo", koKR = "Qujo", ptBR = "Qujo", ruRU = "Qujo", zhCN = "Qujo", zhTW = "Qujo" },
    },
    {
        id = 2048, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.4728, y = 0.5367,
        name = { enUS = "Dannie Fizzwizzle", deDE = "Dannie Fizzwizzle", esES = "Dannie Chispana", esMX = "Dannie Chispana", frFR = "Dannie Fizzwizzle", koKR = "대니 피즈위즐", ptBR = "Dannie Silvombida", ruRU = "Данни Шиппельплюйер", zhCN = "丹尼·血泡", zhTW = "丹尼·血泡" },
    },
    {
        id = 2049, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.4913, y = 0.4795,
        name = { enUS = "Milli Featherwhistle", deDE = "Milli Featherwhistle", esES = "Milli Plumasilba", esMX = "Milli Plumasilba", frFR = "Milli Featherwhistle", koKR = "밀리 페더휘슬", ptBR = "Milli Penapita", ruRU = "Милли Перосвист", zhCN = "米利·羽哨", zhTW = "米利·羽哨" },
    },
    {
        id = 2050, types = { "vendor" },
        faction = "Neutral", map = 1426, x = 0.4661, y = 0.5389,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2051, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.2940, y = 0.7200,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2052, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.2960, y = 0.7200,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2053, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.6347, y = 0.5056,
        name = { enUS = "Veron Amberstill", deDE = "Veron Amberstill", esES = "Veron Calmámbar", esMX = "Veron Semperámbar", frFR = "Veron Amberstill", koKR = "베론 앰버스틸", ptBR = "Veron Ambarmanso", ruRU = "Верон Янтарлен", zhCN = "维隆·冻石", zhTW = "維隆·凍石" },
    },
    {
        id = 2054, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.5260, y = 0.3603,
        name = { enUS = "Wagner Hammerstrike", deDE = "Wagner Hammerstrike", esES = "Wagner Mazas", esMX = "Wagner Mazas", frFR = "Wagner Hammerstrike", koKR = "와그너 해머스트라이크", ptBR = "Wagner Golparrão", ruRU = "Вагнер Молотобоец", zhCN = "瓦格纳·巨锤", zhTW = "瓦格納·巨錘" },
    },
    {
        id = 2055, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.2880, y = 0.6616,
        name = { enUS = "Wren Darkspring", deDE = "Wren Darkspring", esES = "Wren Fonteoscura", esMX = "Wren Fonteoscura", frFR = "Wren Darkspring", koKR = "렌 다크스프링", ptBR = "Wren Molapreta", ruRU = "Врена Темнопружник", zhCN = "伍伦·黑泉", zhTW = "伍倫·黑泉" },
    },
    {
        id = 2056, types = { "vendor" },
        faction = "Alliance", map = 1426, x = 0.6312, y = 0.5088,
        name = { enUS = "Yarlyn Amberstill", deDE = "Yarlyn Amberstill", esES = "Yarlyn Calmámbar", esMX = "Yarlyn Semperámbar", frFR = "Yarlyn Amberstill", koKR = "얄린 앰버스틸", ptBR = "Yarlyn Ambarmanso", ruRU = "Ярлин Янтарлен", zhCN = "亚尔林·冻石", zhTW = "亞爾林·凍石" },
    },
    {
        id = 2057, types = { "vendor" },
        faction = "Neutral", map = 1428, x = 0.1244, y = 0.3163,
        name = { enUS = "Gorzeeki Wildeyes", deDE = "Gorzeeki Wildeyes", esES = "Gorzeeki Ojosalvajes", esMX = "Gorzeeki Ojosalvajes", frFR = "Gorzeeki Wildeyes", koKR = "고르지키 와일드아이즈", ptBR = "Gorzeeki Olholouco", ruRU = "Горзиеки Дикоглаз", zhCN = "戈瑟奇·邪眼", zhTW = "戈瑟奇·邪眼" },
    },
    {
        id = 2058, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.7812, y = 0.7296,
        name = { enUS = "Antonio Perelli", deDE = "Antonio Perelli", esES = "Antonio Perelli", esMX = "Antonio Perelli", frFR = "Antonio Perelli", koKR = "안토니오 페렐리", ptBR = "Antônio Perelli", ruRU = "Антонио Перелли", zhCN = "安东尼奥·皮雷利", zhTW = "安東尼奧·皮雷利" },
    },
    {
        id = 2059, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.4440, y = 0.6599,
        name = { enUS = "Cylina Darkheart", deDE = "Cylina Darkheart", esES = "Cilina Negrozón", esMX = "Cilina Negrozón", frFR = "Cylina Darkheart", koKR = "실리나 다크하트", ptBR = "Cylina Corenero", ruRU = "Силина Чёрносердая", zhCN = "塞琳娜·达克哈特", zhTW = "塞琳娜·達克哈特" },
    },
    {
        id = 2060, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.5005, y = 0.4269,
        name = { enUS = "Dane Winslow", deDE = "Dane Winslow", esES = "Dane Suaven", esMX = "Dane Suaven", frFR = "Dane Winslow", koKR = "데인 윈슬로", ptBR = "Dimas Victório", ruRU = "Дейн Винслоу", zhCN = "丹恩·温斯洛", zhTW = "丹恩·溫斯洛" },
    },
    {
        id = 2061, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.4422, y = 0.5344,
        name = { enUS = "Donni Anthania", deDE = "Donni Anthania", esES = "Donni Anthania", esMX = "Donni Anthania", frFR = "Donni Anthania", koKR = "도니 앤서니아", ptBR = "Cristiana Justa", ruRU = "Донни Антания", zhCN = "冬妮·安萨妮娅", zhTW = "冬妮·安薩妮婭" },
    },
    {
        id = 2062, types = { "vendor" },
        faction = "Neutral", map = 1429, x = 0.4176, y = 0.6810,
        name = { enUS = "Flik", deDE = "Flik", esES = "Flik", esMX = "Flik", frFR = "Flik", koKR = "플릭", ptBR = "Flik", ruRU = "Флик", zhCN = "弗里克", zhTW = "弗里克" },
    },
    {
        id = 2063, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.8415, y = 0.6549,
        name = { enUS = "Katie Hunter", deDE = "Katie Hunter", esES = "Katie Hunter", esMX = "Katie Hunter", frFR = "Katie Hunter", koKR = "케이티 헌터", ptBR = "Carina Caçador", ruRU = "Кати Охотница", zhCN = "凯蒂·亨特", zhTW = "凱蒂·亨特" },
    },
    {
        id = 2064, types = { "vendor" },
        faction = "Neutral", map = 1429, x = 0.4222, y = 0.6596,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2065, types = { "vendor" },
        faction = "Neutral", map = 1429, x = 0.4259, y = 0.6608,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2066, types = { "vendor" },
        faction = "Neutral", map = 1429, x = 0.4499, y = 0.6329,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2067, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.4800, y = 0.4140,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2068, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.4820, y = 0.4160,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2069, types = { "vendor" },
        faction = "Alliance", map = 1429, x = 0.8295, y = 0.6331,
        name = { enUS = "Terry Palin", deDE = "Terry Palin", esES = "Terry Palin", esMX = "Terry Palin", frFR = "Terry Palin", koKR = "테리 팔린", ptBR = "Terry Palin", ruRU = "Терри Палин", zhCN = "泰瑞·帕林", zhTW = "泰瑞·帕林" },
    },
    {
        id = 2070, types = { "vendor" },
        faction = "Alliance", map = 1431, x = 0.7799, y = 0.4833,
        name = { enUS = "Herble Baubbletump", deDE = "Herble Baubbletump", esES = "Herble Montepompa", esMX = "Herble Montepompa", frFR = "Herble Baubbletump", koKR = "허블 버블텀프", ptBR = "Herb Bibelocai", ruRU = "Гербель Бульхольм", zhCN = "赫尔伯", zhTW = "赫爾伯" },
    },
    {
        id = 2071, types = { "vendor" },
        faction = "Neutral", map = 1431, x = 0.8182, y = 0.1977,
        name = { enUS = "Kzixx", deDE = "Kzixx", esES = "Kzixx", esMX = "Kzixx", frFR = "Kzixx", koKR = "크직스", ptBR = "Kzixx", ruRU = "Кзикс", zhCN = "卡兹克斯", zhTW = "卡茲克斯" },
    },
    {
        id = 2072, types = { "vendor" },
        faction = "Neutral", map = 1431, x = 0.7360, y = 0.4703,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2073, types = { "vendor" },
        faction = "Neutral", map = 1431, x = 0.7368, y = 0.4709,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2074, types = { "vendor" },
        map = 1431, x = 0.7492, y = 0.4668,
        name = { enUS = "Repair Bot", deDE = "Repair Bot", esES = "Repair Bot", esMX = "Repair Bot", frFR = "Repair Bot", koKR = "Repair Bot", ptBR = "Repair Bot", ruRU = "Repair Bot", zhCN = "Repair Bot", zhTW = "Repair Bot" },
    },
    {
        id = 2075, types = { "vendor" },
        map = 1431, x = 0.7677, y = 0.4654,
        name = { enUS = "Repair Bot", deDE = "Repair Bot", esES = "Repair Bot", esMX = "Repair Bot", frFR = "Repair Bot", koKR = "Repair Bot", ptBR = "Repair Bot", ruRU = "Repair Bot", zhCN = "Repair Bot", zhTW = "Repair Bot" },
    },
    {
        id = 2076, types = { "vendor" },
        faction = "Alliance", map = 1432, x = 0.3713, y = 0.4716,
        name = { enUS = "Karm Ironquill", deDE = "Karm Ironquill", esES = "Karm Yerropluma", esMX = "Karm Yerropluma", frFR = "Karm Ironquill", koKR = "카름 러닝 베어", ptBR = "Karm Penaferro", ruRU = "Карм Железное Перо", zhCN = "卡姆·铁翎", zhTW = "卡姆·鐵翎" },
    },
    {
        id = 2077, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.2673, y = 0.4805,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2078, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3250, y = 0.5001,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2079, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3259, y = 0.5368,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2080, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3298, y = 0.5046,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2081, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3305, y = 0.5019,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2082, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3474, y = 0.4714,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2083, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3499, y = 0.4695,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2084, types = { "vendor" },
        faction = "Neutral", map = 1432, x = 0.3548, y = 0.4685,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2085, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1057, y = 0.7176,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2086, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1065, y = 0.7177,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2087, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1069, y = 0.7189,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2088, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1077, y = 0.7130,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2089, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1083, y = 0.7206,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2090, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1098, y = 0.7161,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2091, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1106, y = 0.7151,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2092, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1108, y = 0.7163,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2093, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1113, y = 0.7170,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2094, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1120, y = 0.7149,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2095, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1144, y = 0.7141,
        name = { enUS = "Alynsia", deDE = "Alynsia", esES = "Alynsia", esMX = "Alynsia", frFR = "Alynsia", koKR = "Alynsia", ptBR = "Alynsia", ruRU = "Alynsia", zhCN = "Alynsia", zhTW = "Alynsia" },
    },
    {
        id = 2096, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.2404, y = 0.4732,
        name = { enUS = "Amy Davenport", deDE = "Amy Davenport", esES = "Amy Davenport", esMX = "Amy Davenport", frFR = "Amy Davenport", koKR = "에이미 데이븐포트", ptBR = "Amélia Dalmora", ruRU = "Ами Девенпорт", zhCN = "艾米·达文波特", zhTW = "艾米·達文波特" },
    },
    {
        id = 2097, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0975, y = 0.7223,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2098, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0983, y = 0.7245,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2099, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0984, y = 0.7259,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2100, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0987, y = 0.7229,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2101, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0989, y = 0.7268,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2102, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0993, y = 0.7207,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2103, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1002, y = 0.7283,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2104, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1005, y = 0.7267,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2105, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1007, y = 0.7156,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2106, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1013, y = 0.7295,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2107, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1019, y = 0.7313,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2108, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1029, y = 0.7240,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2109, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1194, y = 0.6912,
        name = { enUS = "Daniel Stitchsong", deDE = "Daniel Stitchsong", esES = "Daniel Stitchsong", esMX = "Daniel Stitchsong", frFR = "Daniel Stitchsong", koKR = "Daniel Stitchsong", ptBR = "Daniel Stitchsong", ruRU = "Daniel Stitchsong", zhCN = "Daniel Stitchsong", zhTW = "Daniel Stitchsong" },
    },
    {
        id = 2110, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1027, y = 0.7375,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2111, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1034, y = 0.7450,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2112, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1035, y = 0.7303,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2113, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1035, y = 0.7434,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2114, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1038, y = 0.7411,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2115, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1042, y = 0.7456,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2116, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1044, y = 0.7429,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2117, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1047, y = 0.7462,
        name = { enUS = "Fritz Fizzle", deDE = "Fritz Fizzle", esES = "Fritz Fizzle", esMX = "Fritz Fizzle", frFR = "Fritz Fizzle", koKR = "Fritz Fizzle", ptBR = "Fritz Fizzle", ruRU = "Fritz Fizzle", zhCN = "Fritz Fizzle", zhTW = "Fritz Fizzle" },
    },
    {
        id = 2118, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.2155, y = 0.4348,
        name = { enUS = "Gloria Femmel", deDE = "Gloria Femmel", esES = "Gloria Femmel", esMX = "Gloria Femmel", frFR = "Gloria Femmel", koKR = "글로리아 펌멜", ptBR = "Glória Femmel", ruRU = "Глория Даммель", zhCN = "格劳瑞亚·菲米尔", zhTW = "格勞瑞亞·菲米爾" },
    },
    {
        id = 2119, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0786, y = 0.7142,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2120, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0806, y = 0.7180,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2121, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0837, y = 0.7209,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2122, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0842, y = 0.7203,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2123, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0845, y = 0.7226,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2124, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0852, y = 0.7198,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2125, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0853, y = 0.7213,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2126, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0870, y = 0.7172,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2127, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0871, y = 0.7183,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2128, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0875, y = 0.7167,
        name = { enUS = "Huey Sunnydale", deDE = "Huey Sunnydale", esES = "Huey Sunnydale", esMX = "Huey Sunnydale", frFR = "Huey Sunnydale", koKR = "Huey Sunnydale", ptBR = "Huey Sunnydale", ruRU = "Huey Sunnydale", zhCN = "Huey Sunnydale", zhTW = "Huey Sunnydale" },
    },
    {
        id = 2129, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.2481, y = 0.4736,
        name = { enUS = "Karen Taylor", deDE = "Karen Taylor", esES = "Karen Taylor", esMX = "Karen Taylor", frFR = "Karen Taylor", koKR = "카렌 테일러", ptBR = "Karen Tristão", ruRU = "Карен Тейлор", zhCN = "卡伦·泰勒", zhTW = "卡倫·泰勒" },
    },
    {
        id = 2130, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0927, y = 0.7145,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2131, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0968, y = 0.7212,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2132, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0989, y = 0.7269,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2133, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0993, y = 0.7207,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2134, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0993, y = 0.7298,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2135, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0995, y = 0.7246,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2136, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0997, y = 0.7293,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2137, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1000, y = 0.7241,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2138, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1004, y = 0.7266,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2139, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1006, y = 0.7287,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2140, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1008, y = 0.7262,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2141, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1025, y = 0.7334,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2142, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1042, y = 0.7202,
        name = { enUS = "Mivin Shadowweave", deDE = "Mivin Shadowweave", esES = "Mivin Shadowweave", esMX = "Mivin Shadowweave", frFR = "Mivin Shadowweave", koKR = "Mivin Shadowweave", ptBR = "Mivin Shadowweave", ruRU = "Mivin Shadowweave", zhCN = "Mivin Shadowweave", zhTW = "Mivin Shadowweave" },
    },
    {
        id = 2143, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0997, y = 0.7264,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2144, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1065, y = 0.7252,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2145, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1075, y = 0.7231,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2146, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1076, y = 0.7276,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2147, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1081, y = 0.7251,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2148, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1084, y = 0.7231,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2149, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1087, y = 0.7222,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2150, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1089, y = 0.7257,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2151, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1096, y = 0.7222,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2152, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1097, y = 0.7206,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2153, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1097, y = 0.7255,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2154, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1103, y = 0.7234,
        name = { enUS = "Nina Surefire", deDE = "Nina Surefire", esES = "Nina Surefire", esMX = "Nina Surefire", frFR = "Nina Surefire", koKR = "Nina Surefire", ptBR = "Nina Surefire", ruRU = "Nina Surefire", zhCN = "Nina Surefire", zhTW = "Nina Surefire" },
    },
    {
        id = 2155, types = { "vendor" },
        faction = "Neutral", map = 1433, x = 0.2354, y = 0.4772,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2156, types = { "vendor" },
        faction = "Neutral", map = 1433, x = 0.2361, y = 0.4778,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2157, types = { "vendor" },
        faction = "Neutral", map = 1433, x = 0.2615, y = 0.5914,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2158, types = { "vendor" },
        faction = "Neutral", map = 1433, x = 0.2656, y = 0.5861,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2159, types = { "vendor" },
        faction = "Neutral", map = 1433, x = 0.2673, y = 0.5907,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2160, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.0918, y = 0.7081,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2161, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1019, y = 0.7153,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2162, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1028, y = 0.7135,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2163, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1047, y = 0.7118,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2164, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1049, y = 0.7166,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2165, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1054, y = 0.7122,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2166, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1061, y = 0.7119,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2167, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1061, y = 0.7157,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2168, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1065, y = 0.7133,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2169, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1072, y = 0.7099,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2170, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1080, y = 0.7147,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2171, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1082, y = 0.7109,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2172, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1088, y = 0.7105,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2173, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1096, y = 0.7125,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2174, types = { "vendor" },
        faction = "Alliance", map = 1433, x = 0.1135, y = 0.7039,
        name = { enUS = "Tamelyn Aldridge", deDE = "Tamelyn Aldridge", esES = "Tamelyn Aldridge", esMX = "Tamelyn Aldridge", frFR = "Tamelyn Aldridge", koKR = "Tamelyn Aldridge", ptBR = "Tamelyn Aldridge", ruRU = "Tamelyn Aldridge", zhCN = "Tamelyn Aldridge", zhTW = "Tamelyn Aldridge" },
    },
    {
        id = 2175, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.2836, y = 0.7666,
        name = { enUS = "Crazk Sparks", deDE = "Crazk Sparks", esES = "Craz Chispaz", esMX = "Craz Chispaz", frFR = "Crazk Sparks", koKR = "크라즈크 스팍스", ptBR = "Crazk Chispas", ruRU = "Кразк Искрец", zhCN = "克拉赛·斯巴克斯", zhTW = "克拉賽·斯巴克斯" },
    },
    {
        id = 2176, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.2833, y = 0.7482,
        name = { enUS = "Gezzy Gunkgear", deDE = "Gezzy Gunkgear", esES = "Gezzy Gunkgear", esMX = "Gezzy Gunkgear", frFR = "Gezzy Gunkgear", koKR = "Gezzy Gunkgear", ptBR = "Gezzy Gunkgear", ruRU = "Gezzy Gunkgear", zhCN = "Gezzy Gunkgear", zhTW = "Gezzy Gunkgear" },
    },
    {
        id = 2177, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.2839, y = 0.7499,
        name = { enUS = "Gezzy Gunkgear", deDE = "Gezzy Gunkgear", esES = "Gezzy Gunkgear", esMX = "Gezzy Gunkgear", frFR = "Gezzy Gunkgear", koKR = "Gezzy Gunkgear", ptBR = "Gezzy Gunkgear", ruRU = "Gezzy Gunkgear", zhCN = "Gezzy Gunkgear", zhTW = "Gezzy Gunkgear" },
    },
    {
        id = 2178, types = { "vendor" },
        map = 1434, x = 0.2773, y = 0.7716,
        name = { enUS = "Jenna", deDE = "Jenna", esES = "Jenna", esMX = "Jenna", frFR = "Jenna", koKR = "Jenna", ptBR = "Jenna", ruRU = "Jenna", zhCN = "Jenna", zhTW = "Jenna" },
    },
    {
        id = 2179, types = { "vendor" },
        map = 1434, x = 0.2779, y = 0.7712,
        name = { enUS = "Jenna", deDE = "Jenna", esES = "Jenna", esMX = "Jenna", frFR = "Jenna", koKR = "Jenna", ptBR = "Jenna", ruRU = "Jenna", zhCN = "Jenna", zhTW = "Jenna" },
    },
    {
        id = 2180, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.3120, y = 0.4840,
        name = { enUS = "Mai'zin", deDE = "Mai'zin", esES = "Mai'zin", esMX = "Mai'zin", frFR = "Mai'zin", koKR = "Mai'zin", ptBR = "Mai'zin", ruRU = "Mai'zin", zhCN = "Mai'zin", zhTW = "Mai'zin" },
    },
    {
        id = 2181, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.3120, y = 0.4860,
        name = { enUS = "Mai'zin", deDE = "Mai'zin", esES = "Mai'zin", esMX = "Mai'zin", frFR = "Mai'zin", koKR = "Mai'zin", ptBR = "Mai'zin", ruRU = "Mai'zin", zhCN = "Mai'zin", zhTW = "Mai'zin" },
    },
    {
        id = 2182, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.2813, y = 0.7442,
        name = { enUS = "Narkk", deDE = "Narkk", esES = "Narkk", esMX = "Narkk", frFR = "Narkk", koKR = "나르크", ptBR = "Narkk", ruRU = "Наркк", zhCN = "纳尔克", zhTW = "納爾克" },
    },
    {
        id = 2183, types = { "vendor" },
        map = 1434, x = 0.2850, y = 0.7581,
        name = { enUS = "Pix Xizzix", deDE = "Pix Xizzix", esES = "Pix Xizzix", esMX = "Pix Xizzix", frFR = "Pix Xizzix", koKR = "Pix Xizzix", ptBR = "Pix Xizzix", ruRU = "Pix Xizzix", zhCN = "Pix Xizzix", zhTW = "Pix Xizzix" },
    },
    {
        id = 2184, types = { "vendor" },
        map = 1434, x = 0.2851, y = 0.7577,
        name = { enUS = "Rix Xizzix", deDE = "Rix Xizzix", esES = "Rix Xizzix", esMX = "Rix Xizzix", frFR = "Rix Xizzix", koKR = "Rix Xizzix", ptBR = "Rix Xizzix", ruRU = "Rix Xizzix", zhCN = "Rix Xizzix", zhTW = "Rix Xizzix" },
    },
    {
        id = 2185, types = { "vendor" },
        faction = "Neutral", map = 1434, x = 0.2841, y = 0.7683,
        name = { enUS = "Sly Garrett", deDE = "Sly Garrett", esES = "Astuto Garrett", esMX = "Astuto Garrett", frFR = "Garrett le Matois", koKR = "슬라이 가레트", ptBR = "Sly Garreta", ruRU = "Ловкач Гарретт", zhCN = "斯莱·加瑞特", zhTW = "斯萊·加勒特" },
    },
    {
        id = 2186, types = { "vendor" },
        faction = "Neutral", map = 1435, x = 0.2499, y = 0.5411,
        name = { enUS = "Amaryllis Webb", deDE = "Amaryllis Webb", esES = "Amaryllis Webb", esMX = "Amaryllis Webb", frFR = "Amaryllis Webb", koKR = "Amaryllis Webb", ptBR = "Amaryllis Webb", ruRU = "Amaryllis Webb", zhCN = "Amaryllis Webb", zhTW = "Amaryllis Webb" },
    },
    {
        id = 2187, types = { "vendor" },
        faction = "Neutral", map = 1435, x = 0.2505, y = 0.5428,
        name = { enUS = "Amaryllis Webb", deDE = "Amaryllis Webb", esES = "Amaryllis Webb", esMX = "Amaryllis Webb", frFR = "Amaryllis Webb", koKR = "Amaryllis Webb", ptBR = "Amaryllis Webb", ruRU = "Amaryllis Webb", zhCN = "Amaryllis Webb", zhTW = "Amaryllis Webb" },
    },
    {
        id = 2188, types = { "vendor" },
        faction = "Neutral", map = 1435, x = 0.2517, y = 0.5417,
        name = { enUS = "Amaryllis Webb", deDE = "Amaryllis Webb", esES = "Amaryllis Webb", esMX = "Amaryllis Webb", frFR = "Amaryllis Webb", koKR = "Amaryllis Webb", ptBR = "Amaryllis Webb", ruRU = "Amaryllis Webb", zhCN = "Amaryllis Webb", zhTW = "Amaryllis Webb" },
    },
    {
        id = 2189, types = { "vendor" },
        faction = "Neutral", map = 1435, x = 0.2530, y = 0.5439,
        name = { enUS = "Amaryllis Webb", deDE = "Amaryllis Webb", esES = "Amaryllis Webb", esMX = "Amaryllis Webb", frFR = "Amaryllis Webb", koKR = "Amaryllis Webb", ptBR = "Amaryllis Webb", ruRU = "Amaryllis Webb", zhCN = "Amaryllis Webb", zhTW = "Amaryllis Webb" },
    },
    {
        id = 2190, types = { "vendor" },
        faction = "Horde", map = 1435, x = 0.4858, y = 0.5527,
        name = { enUS = "Greshka", deDE = "Greshka", esES = "Greshka", esMX = "Greshka", frFR = "Greshka", koKR = "그레쉬카", ptBR = "Greshka", ruRU = "Грешка", zhCN = "格雷沙卡", zhTW = "格雷沙卡" },
    },
    {
        id = 2191, types = { "vendor" },
        faction = "Neutral", map = 1435, x = 0.2646, y = 0.3147,
        name = { enUS = "Masat T'andr", deDE = "Masat T'andr", esES = "Masat T'andr", esMX = "Masat T'andr", frFR = "Masat T'andr", koKR = "마사트 탄드르", ptBR = "Masat T'andr", ruRU = "Масат Т'андр", zhCN = "马萨特·坦德", zhTW = "馬薩特·坦德" },
    },
    {
        id = 2192, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.4226, y = 0.7130,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2193, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.4233, y = 0.7128,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2194, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.5526, y = 0.5239,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2195, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.5535, y = 0.5228,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2196, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.5538, y = 0.5233,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2197, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.5602, y = 0.5267,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2198, types = { "vendor" },
        faction = "Neutral", map = 1436, x = 0.5626, y = 0.5306,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2199, types = { "vendor" },
        faction = "Neutral", map = 1437, x = 0.4655, y = 0.1837,
        name = { enUS = "Dark Iron Entrepreneur", deDE = "Unternehmer der Dunkeleisenzwerge", esES = "Emprendedor Hierro Negro", esMX = "Emprendedor Hierro Negro", frFR = "Entrepreneur Sombrefer", koKR = "검은무쇠단 중개업자", ptBR = "Empresário Ferro Negro", ruRU = "Подрядчик из клана Черного Железа", zhCN = "黑铁企业家", zhTW = "黑鐵企業家" },
    },
    {
        id = 2200, types = { "vendor" },
        faction = "Neutral", map = 1437, x = 0.5020, y = 0.3774,
        name = { enUS = "Kixxle", deDE = "Kixxle", esES = "Kixxle", esMX = "Kixxle", frFR = "Kixxle", koKR = "킥슬", ptBR = "Kixxel", ruRU = "Киккль", zhCN = "吉克斯勒", zhTW = "吉克斯勒" },
    },
    {
        id = 2201, types = { "vendor" },
        faction = "Neutral", map = 1437, x = 0.2868, y = 0.2432,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2202, types = { "vendor" },
        faction = "Alliance", map = 1437, x = 0.1050, y = 0.6020,
        name = { enUS = "Samor Festivus", deDE = "Samor Festivus", esES = "Samor Festivus", esMX = "Samor Festivus", frFR = "Samor Festivus", koKR = "사모르 페스티부스", ptBR = "Samor Festivus", ruRU = "Самор Фестивалус", zhCN = "萨莫尔·菲斯蒂沃斯", zhTW = "薩莫爾·菲斯蒂沃斯" },
    },
    {
        id = 2203, types = { "vendor" },
        faction = "Alliance", map = 1437, x = 0.0857, y = 0.5434,
        name = { enUS = "Unger Statforth", deDE = "Unger Statforth", esES = "Unger Statforth", esMX = "Unger Statforth", frFR = "Unger Statforth", koKR = "웅거 스타트포스", ptBR = "Ungro Persevero", ruRU = "Унгер Уппперт", zhCN = "安格尔·斯塔特弗斯", zhTW = "安格爾·斯塔特弗斯" },
    },
    {
        id = 2204, types = { "vendor" },
        faction = "Alliance", map = 1438, x = 0.5719, y = 0.6126,
        name = { enUS = "Nyoma", deDE = "Nyoma", esES = "Nyoma", esMX = "Nyoma", frFR = "Nyoma", koKR = "니오마", ptBR = "Nyoma", ruRU = "Ньома", zhCN = "奈欧玛", zhTW = "奈歐瑪" },
    },
    {
        id = 2205, types = { "vendor" },
        faction = "Neutral", map = 1438, x = 0.4878, y = 0.5557,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2206, types = { "vendor" },
        faction = "Alliance", map = 1438, x = 0.5880, y = 0.4380,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2207, types = { "vendor" },
        faction = "Alliance", map = 1439, x = 0.3610, y = 0.4493,
        name = { enUS = "Gubber Blump", deDE = "Gubber Blump", esES = "Gubber Blump", esMX = "Gubber Blump", frFR = "Gubber Blump", koKR = "구버 블럼프", ptBR = "Gubber Blump", ruRU = "Груббер Блумп", zhCN = "古博·布拉普", zhTW = "古博·布拉普" },
    },
    {
        id = 2208, types = { "vendor" },
        faction = "Neutral", map = 1439, x = 0.3083, y = 0.4094,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2209, types = { "vendor" },
        faction = "Neutral", map = 1439, x = 0.3243, y = 0.4362,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2210, types = { "vendor" },
        faction = "Alliance", map = 1440, x = 0.6194, y = 0.8383,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 2211, types = { "vendor" },
        faction = "Alliance", map = 1440, x = 0.3649, y = 0.4946,
        name = { enUS = "Fahran Silentblade", deDE = "Fahran Silentblade", esES = "Fahran Filencioso", esMX = "Fahran Filencioso", frFR = "Fahran Silentblade", koKR = "파란 사일런트블레이드", ptBR = "Fahran Calmádaga", ruRU = "Фаран Бесшумный Клинок", zhCN = "法兰·沉默之刃", zhTW = "法蘭·沉默之刃" },
    },
    {
        id = 2212, types = { "vendor" },
        faction = "Horde", map = 1440, x = 0.1171, y = 0.3410,
        name = { enUS = "Wik'Tar", deDE = "Wik'Tar", esES = "Wik'Tar", esMX = "Wik'Tar", frFR = "Wik'Tar", koKR = "위크타르", ptBR = "Wik'Tar", ruRU = "Вик'Тар", zhCN = "维克塔", zhTW = "維克塔" },
    },
    {
        id = 2213, types = { "vendor" },
        faction = "Neutral", map = 1441, x = 0.7829, y = 0.7570,
        name = { enUS = "Magus Tirth", deDE = "Magus Tirth", esES = "Magus Tirth", esMX = "Magus Tirth", frFR = "Magus Tirth", koKR = "학자 틸스", ptBR = "Tirth, o Mago", ruRU = "Волхв Тирт", zhCN = "大法师提尔斯", zhTW = "魔導師提爾斯" },
    },
    {
        id = 2214, types = { "vendor" },
        faction = "Neutral", map = 1441, x = 0.7814, y = 0.7712,
        name = { enUS = "Wizzle Brassbolts", deDE = "Wizzle Brassbolts", esES = "Wizzle Pernolatón", esMX = "Wizzle Pernolatón", frFR = "Wizzle Brassbolts", koKR = "위즐 브라스볼츠", ptBR = "Capu Latafuso", ruRU = "Виззл Медноштиф", zhCN = "维兹尔·铜栓", zhTW = "維茲爾·銅栓" },
    },
    {
        id = 2215, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7110, y = 0.9877,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2216, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7113, y = 0.9863,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2217, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7131, y = 0.9901,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2218, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7137, y = 0.9913,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2219, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7152, y = 0.9947,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2220, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7153, y = 0.9980,
        name = { enUS = "Tuu'li", deDE = "Tuu'li", esES = "Tuu'li", esMX = "Tuu'li", frFR = "Tuu'li", koKR = "Tuu'li", ptBR = "Tuu'li", ruRU = "Tuu'li", zhCN = "Tuu'li", zhTW = "Tuu'li" },
    },
    {
        id = 2221, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7065, y = 0.9856,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2222, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7132, y = 0.9946,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2223, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7140, y = 0.9946,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2224, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7145, y = 0.9955,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2225, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7169, y = 0.9892,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2226, types = { "vendor" },
        faction = "Horde", map = 1442, x = 0.7187, y = 0.9902,
        name = { enUS = "Xaphod Bizznox", deDE = "Xaphod Bizznox", esES = "Xaphod Bizznox", esMX = "Xaphod Bizznox", frFR = "Xaphod Bizznox", koKR = "Xaphod Bizznox", ptBR = "Xaphod Bizznox", ruRU = "Xaphod Bizznox", zhCN = "Xaphod Bizznox", zhTW = "Xaphod Bizznox" },
    },
    {
        id = 2227, types = { "vendor" },
        map = 1443, x = 0.6621, y = 0.7936,
        name = { enUS = "Gorhak", deDE = "Gorhak", esES = "Gorhak", esMX = "Gorhak", frFR = "Gorhak", koKR = "Gorhak", ptBR = "Gorhak", ruRU = "Gorhak", zhCN = "Gorhak", zhTW = "Gorhak" },
    },
    {
        id = 2228, types = { "vendor" },
        faction = "Neutral", map = 1443, x = 0.6033, y = 0.3812,
        name = { enUS = "Vendor-Tron 1000", deDE = "Kaufotron 1000", esES = "Vende-Tron 1000", esMX = "Vende-Tron 1000", frFR = "Vendeur-Tron 1000", koKR = "자동 판매기 1000", ptBR = "Vende-Tron 1000", ruRU = "Торготрон 1000", zhCN = "贸易机器人1000型", zhTW = "貿易機器人1000型" },
    },
    {
        id = 2229, types = { "vendor" },
        faction = "Horde", map = 1443, x = 0.2617, y = 0.6965,
        name = { enUS = "Wulan", deDE = "Wulan", esES = "Wulan", esMX = "Wulan", frFR = "Wulan", koKR = "울란", ptBR = "Wulan", ruRU = "Вулан", zhCN = "乌兰", zhTW = "烏蘭" },
    },
    {
        id = 2230, types = { "vendor" },
        faction = "Neutral", map = 1444, x = 0.4512, y = 0.2557,
        name = { enUS = "Gregan Brewspewer", deDE = "Gregan Brewspewer", esES = "Gregan Vomitabrebaje", esMX = "Gregan Tirabirras", frFR = "Gregan Brewspewer", koKR = "그레간 브루스퓨", ptBR = "Gregan Cospechope", ruRU = "Греган Пивоплюй", zhCN = "格雷甘·山酒", zhTW = "格雷甘·山酒" },
    },
    {
        id = 2231, types = { "vendor" },
        faction = "Neutral", map = 1444, x = 0.4946, y = 0.1983,
        name = { enUS = "Kalin Windflight", deDE = "Kalin Windflight", esES = "Kalin Vuelavento", esMX = "Kalin Vuelavento", frFR = "Kalin Windflight", koKR = "칼린 윈드플라이트", ptBR = "Kalin Volaventos", ruRU = "Калин Полет Ветра", zhCN = "卡林·风程", zhTW = "卡林·風程" },
    },
    {
        id = 2232, types = { "vendor" },
        faction = "Alliance", map = 1444, x = 0.3245, y = 0.4379,
        name = { enUS = "Quintis Jonespyre", deDE = "Quintis Jonespyre", esES = "Quintis Jonguja", esMX = "Quintis Jonguja", frFR = "Quintis Jonespyre", koKR = "쿠인티스 존스피레", ptBR = "Quintis Jonespyre", ruRU = "Квинтис Ночной Костер", zhCN = "奎恩提斯", zhTW = "奎恩提斯" },
    },
    {
        id = 2233, types = { "vendor" },
        faction = "Neutral", map = 1444, x = 0.4481, y = 0.4342,
        name = { enUS = "Zorbin Fandazzle", deDE = "Zorbin Fandazzle", esES = "Zorbin Ventipnotizador", esMX = "Zorbin Hipnoviento", frFR = "Zorbin Fandazzle", koKR = "조브린 팬대즐", ptBR = "Zorbin Cegasvista", ruRU = "Зорбин Дребезгун", zhCN = "索尔宾·范达瑟", zhTW = "索爾賓·范達瑟" },
    },
    {
        id = 2234, types = { "vendor" },
        faction = "Alliance", map = 1445, x = 0.6519, y = 0.5150,
        name = { enUS = "Gregor MacVince", deDE = "Gregor MacVince", esES = "Gregor MacVince", esMX = "Gregor MacVince", frFR = "Gregor MacVince", koKR = "그레고르 맥빈스", ptBR = "Gregor MacVince", ruRU = "Грегор Маквинс", zhCN = "格瑞戈·玛克温斯", zhTW = "格瑞戈·瑪克溫斯" },
    },
    {
        id = 2235, types = { "vendor" },
        faction = "Neutral", map = 1445, x = 0.5861, y = 0.6006,
        name = { enUS = "Nat Pagle", deDE = "Nat Pagle", esES = "Nat Pagle", esMX = "Nat Pagle", frFR = "Nat Pagle", koKR = "내트 페이글", ptBR = "Nat Pagle", ruRU = "Нат Пэгл", zhCN = "纳特·帕格", zhTW = "納特·帕格" },
    },
    {
        id = 2236, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.6656, y = 0.2227,
        name = { enUS = "Haughty Modiste", deDE = "Eingebildete Modeschöpferin", esES = "Modista Jonti", esMX = "Modista Jactancia", frFR = "Modiste arrogante", koKR = "거만한 의류상", ptBR = "Sissi Ashando", ruRU = "Отти Кутюри", zhCN = "傲慢的店主", zhTW = "傲慢的店主" },
    },
    {
        id = 2237, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.5181, y = 0.2866,
        name = { enUS = "Marin Noggenfogger", deDE = "Marin Noggenfogger", esES = "Marin Tragonublo", esMX = "Marin Tragonublo", frFR = "Marin Noggenfogger", koKR = "마린 노겐포저", ptBR = "Marin Nublacuca", ruRU = "Синь Гогельмогель", zhCN = "马林·诺格弗格", zhTW = "馬林·諾格弗格" },
    },
    {
        id = 2238, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.6757, y = 0.2202,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2239, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.6758, y = 0.2197,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2240, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.5127, y = 0.2749,
        name = { enUS = "Rettrick", deDE = "Rettrick", esES = "Rettrick", esMX = "Rettrick", frFR = "Rettrick", koKR = "Rettrick", ptBR = "Rettrick", ruRU = "Rettrick", zhCN = "Rettrick", zhTW = "Rettrick" },
    },
    {
        id = 2241, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.5163, y = 0.2833,
        name = { enUS = "Rettrick", deDE = "Rettrick", esES = "Rettrick", esMX = "Rettrick", frFR = "Rettrick", koKR = "Rettrick", ptBR = "Rettrick", ruRU = "Rettrick", zhCN = "Rettrick", zhTW = "Rettrick" },
    },
    {
        id = 2242, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.5166, y = 0.2877,
        name = { enUS = "Rettrick", deDE = "Rettrick", esES = "Rettrick", esMX = "Rettrick", frFR = "Rettrick", koKR = "Rettrick", ptBR = "Rettrick", ruRU = "Rettrick", zhCN = "Rettrick", zhTW = "Rettrick" },
    },
    {
        id = 2243, types = { "vendor" },
        faction = "Neutral", map = 1446, x = 0.5170, y = 0.2869,
        name = { enUS = "Rettrick", deDE = "Rettrick", esES = "Rettrick", esMX = "Rettrick", frFR = "Rettrick", koKR = "Rettrick", ptBR = "Rettrick", ruRU = "Rettrick", zhCN = "Rettrick", zhTW = "Rettrick" },
    },
    {
        id = 2244, types = { "vendor" },
        faction = "Neutral", map = 1447, x = 0.4528, y = 0.9095,
        name = { enUS = "Jubie Gadgetspring", deDE = "Jubie Gadgetspring", esES = "Jubie Cacharretio", esMX = "Jubie Cacharretio", frFR = "Jubie Gadgetspring", koKR = "주비 가젯스프링", ptBR = "Jubi Apertaporca", ruRU = "Джуби Прибамбас", zhCN = "朱比", zhTW = "朱比" },
    },
    {
        id = 2245, types = { "vendor" },
        map = 1448, x = 0.3618, y = 0.4446,
        name = { enUS = "Ur'dan", deDE = "Ur'dan", esES = "Ur'dan", esMX = "Ur'dan", frFR = "Ur'dan", koKR = "우르단", ptBR = "Ur'dan", ruRU = "Ур'дан", zhCN = "乌尔丹", zhTW = "烏爾丹" },
    },
    {
        id = 2246, types = { "vendor" },
        faction = "Neutral", map = 1450, x = 0.5379, y = 0.3532,
        name = { enUS = "Fariel Starsong", deDE = "Fariel Starsong", esES = "Fariel Cantostelar", esMX = "Fariel Cantostelar", frFR = "Fariel Starsong", koKR = "파리엘 스타송", ptBR = "Fariel Stelacanto", ruRU = "Фариэль Песнь Звезд", zhCN = "法蕾尔·星歌", zhTW = "法莉爾·星歌" },
    },
    {
        id = 2247, types = { "vendor" },
        faction = "Neutral", map = 1450, x = 0.3630, y = 0.5853,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2248, types = { "vendor" },
        faction = "Neutral", map = 1450, x = 0.3658, y = 0.5810,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2249, types = { "vendor" },
        faction = "Neutral", map = 1450, x = 0.5365, y = 0.3526,
        name = { enUS = "Valadar Starsong", deDE = "Valadar Starsong", esES = "Valadar Cantoestelar", esMX = "Valadar Cantoestelar", frFR = "Valadar Starsong", koKR = "발라다르 스타송", ptBR = "Valadar Stelacanto", ruRU = "Валадар Звездная Песня", zhCN = "瓦拉达尔·星歌", zhTW = "瓦拉達爾·星歌" },
    },
    {
        id = 2250, types = { "vendor" },
        faction = "Neutral", map = 1451, x = 0.6257, y = 0.4979,
        name = { enUS = "Aendel Windspear", deDE = "Aendel Windspear", esES = "Aendel Lanzavento", esMX = "Aendel Lanzavento", frFR = "Aendel Windspear", koKR = "앤델 윈드스피어", ptBR = "Aendel Lancéola", ruRU = "Эндель Копье Ветра", zhCN = "安迪尔·风矛", zhTW = "安迪爾·風矛" },
    },
    {
        id = 2251, types = { "vendor" },
        faction = "Neutral", map = 1451, x = 0.5197, y = 0.3970,
        name = { enUS = "Kania", deDE = "Kania", esES = "Kania", esMX = "Kania", frFR = "Kania", koKR = "케니아", ptBR = "Kania", ruRU = "Кания", zhCN = "卡妮亚", zhTW = "卡妮亞" },
    },
    {
        id = 2252, types = { "vendor" },
        faction = "Neutral", map = 1452, x = 0.6179, y = 0.3859,
        name = { enUS = "Lunnix Sprocketslip", deDE = "Lunnix Sprocketslip", esES = "Lunnix Dentabaja", esMX = "Lunnix Dentabaja", frFR = "Lunnix Sprocketslip", koKR = "루닉스 스프로켓슬립", ptBR = "Lunnix Falharroda", ruRU = "Лунникса Буксуй", zhCN = "鲁尼克斯", zhTW = "魯尼克斯" },
    },
    {
        id = 2253, types = { "vendor" },
        faction = "Alliance", map = 1452, x = 0.4994, y = 0.0984,
        name = { enUS = "Rivern Frostwind", deDE = "Rivern Frostwind", esES = "Rivern Ventogélido", esMX = "Rivern Ventogélido", frFR = "Rivern Frostwind", koKR = "리베른 프로스트윈드", ptBR = "Ripárion Glaciares", ruRU = "Риверн Холодный Ветер", zhCN = "雷沃·霜翼", zhTW = "雷沃·霜風" },
    },
    {
        id = 2254, types = { "vendor" },
        map = 1452, x = 0.6147, y = 0.3860,
        name = { enUS = "Zippie Fizzbolt", deDE = "Zippie Fizzbolt", esES = "Zippie Fizzbolt", esMX = "Zippie Fizzbolt", frFR = "Zippie Fizzbolt", koKR = "Zippie Fizzbolt", ptBR = "Zippie Fizzbolt", ruRU = "Zippie Fizzbolt", zhCN = "Zippie Fizzbolt", zhTW = "Zippie Fizzbolt" },
    },
    {
        id = 2255, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5183, y = 0.7508,
        name = { enUS = "Adair Gilroy", deDE = "Adair Gilroy", esES = "Adair Gilroy", esMX = "Adair Gilroy", frFR = "Adair Gilroy", koKR = "어데어 길로이", ptBR = "Adair Gilroy", ruRU = "Адайр Гилрой", zhCN = "艾代尔·吉尔罗", zhTW = "艾代爾·吉爾羅" },
    },
    {
        id = 2256, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.8123, y = 0.3849,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 2257, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5335, y = 0.8168,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2258, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5335, y = 0.8187,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2259, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5335, y = 0.8199,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2260, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5350, y = 0.8185,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2261, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5364, y = 0.8198,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2262, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5371, y = 0.8186,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2263, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.5376, y = 0.8177,
        name = { enUS = "Antonio Bolero", deDE = "Antonio Bolero", esES = "Antonio Bolero", esMX = "Antonio Bolero", frFR = "Antonio Bolero", koKR = "Antonio Bolero", ptBR = "Antonio Bolero", ruRU = "Antonio Bolero", zhCN = "Antonio Bolero", zhTW = "Antonio Bolero" },
    },
    {
        id = 2264, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.6924, y = 0.7184,
        name = { enUS = "Bernard Gump", deDE = "Bernard Gump", esES = "Bernard Gump", esMX = "Bernard Gump", frFR = "Bernard Gump", koKR = "버나드 검프", ptBR = "Bernardo Gump", ruRU = "Бернард Гамп", zhCN = "伯纳德·加姆", zhTW = "伯納德·加姆" },
    },
    {
        id = 2265, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.6243, y = 0.2990,
        name = { enUS = "Billibub Cogspinner", deDE = "Billibub Cogspinner", esES = "Billibub Velopiñon", esMX = "Billibub Velopiñon", frFR = "Billibub Cogspinner", koKR = "빌리버브 코그스피너", ptBR = "Billibub Rodagiros", ruRU = "Билибуб Шестеренок", zhCN = "比利巴布·旋轮", zhTW = "比利巴布·考格斯賓" },
    },
    {
        id = 2266, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.4244, y = 0.7692,
        name = { enUS = "Darian Singh", deDE = "Darian Singh", esES = "Darian Singh", esMX = "Darian Singh", frFR = "Darian Singh", koKR = "다리안 싱그", ptBR = "Dácio Leão", ruRU = "Дариан Сингх", zhCN = "达利安·辛格", zhTW = "達利安·辛格" },
    },
    {
        id = 2267, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.8028, y = 0.7007,
        name = { enUS = "Jasper Fel", deDE = "Jasper Fel", esES = "Jasper Fel", esMX = "Jasper Vil", frFR = "Jasper Fel", koKR = "야스퍼 펠", ptBR = "Jasper Fel", ruRU = "Джаспер Скверн", zhCN = "贾斯伯·菲尔", zhTW = "賈斯伯·菲爾" },
    },
    {
        id = 2268, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.7747, y = 0.5269,
        name = { enUS = "Kendor Kabonka", deDE = "Kendor Kabonka", esES = "Kendor Kabonka", esMX = "Kendor Kabonka", frFR = "Kendor Kabonka", koKR = "켄로드 카본카", ptBR = "Kendor Kabonka", ruRU = "Кендор Кабонка", zhCN = "肯多尔·卡邦卡", zhTW = "肯多爾·卡邦卡" },
    },
    {
        id = 2269, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.4665, y = 0.5573,
        name = { enUS = "Lil Timmy", deDE = "Lil Timmy", esES = "Lil Timmy", esMX = "Lil Timmy", frFR = "Jeune Timmy", koKR = "릴 티미", ptBR = "Toninho", ruRU = "Малыш Тимми", zhCN = "利尔·迪米", zhTW = "利爾·迪米" },
    },
    {
        id = 2270, types = { "vendor" },
        faction = "Neutral", map = 1453, x = 0.3730, y = 0.6405,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2271, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.7707, y = 0.3021,
        name = { enUS = "Milton Sheaf", deDE = "Milton Sheaf", esES = "Milton Gavilla", esMX = "Milton Gavilla", frFR = "Milton Sheaf", koKR = "밀턴 시프", ptBR = "Milton Resma", ruRU = "Милтон Сноп", zhCN = "米尔顿·西弗", zhTW = "密爾頓·西弗" },
    },
    {
        id = 2272, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.6398, y = 0.7750,
        name = { enUS = "Rebecca Laughlin", deDE = "Rebecca Laughlin", esES = "Rebecca Laughlin", esMX = "Rebecca Laughlin", frFR = "Rebecca Laughlin", koKR = "레베카 래플린", ptBR = "Marilde Beltron", ruRU = "Ребекка Лафлин", zhCN = "瑞贝卡·拉弗林", zhTW = "瑞貝卡·拉弗林" },
    },
    {
        id = 2273, types = { "vendor" },
        faction = "Alliance", map = 1453, x = 0.3953, y = 0.8453,
        name = { enUS = "Spackle Thornberry", deDE = "Spackle Thornberry", esES = "Spackle Espinamora", esMX = "Spackle Zarzamora", frFR = "Spackle Thornberry", koKR = "스파클 손베리", ptBR = "Spackle Cardopomo", ruRU = "Шпакл Шиповникс", zhCN = "斯巴克尔", zhTW = "斯巴克爾" },
    },
    {
        id = 2274, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6292, y = 0.5081,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2275, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6340, y = 0.5052,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2276, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6341, y = 0.5030,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2277, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6344, y = 0.5075,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2278, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6347, y = 0.5008,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2279, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6347, y = 0.5061,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2280, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6351, y = 0.5067,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2281, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6352, y = 0.5046,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2282, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6354, y = 0.5019,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2283, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6356, y = 0.5035,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2284, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6359, y = 0.5058,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2285, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6361, y = 0.5072,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2286, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6362, y = 0.5020,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2287, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6363, y = 0.5064,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2288, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6364, y = 0.5052,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2289, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6365, y = 0.5037,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2290, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6372, y = 0.5064,
        name = { enUS = "Darah", deDE = "Darah", esES = "Darah", esMX = "Darah", frFR = "Darah", koKR = "Darah", ptBR = "Darah", ruRU = "Darah", zhCN = "Darah", zhTW = "Darah" },
    },
    {
        id = 2291, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4377, y = 0.7425,
        name = { enUS = "Garyl", deDE = "Garyl", esES = "Garyl", esMX = "Garyl", frFR = "Garyl", koKR = "가릴", ptBR = "Garyl", ruRU = "Гарил", zhCN = "伽雷尔", zhTW = "伽雷爾" },
    },
    {
        id = 2292, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.8068, y = 0.3051,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2293, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5140, y = 0.6380,
        name = { enUS = "Jornah", deDE = "Jornah", esES = "Jornah", esMX = "Jornah", frFR = "Jornah", koKR = "Jornah", ptBR = "Jornah", ruRU = "Jornah", zhCN = "Jornah", zhTW = "Jornah" },
    },
    {
        id = 2294, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5140, y = 0.6460,
        name = { enUS = "Jornah", deDE = "Jornah", esES = "Jornah", esMX = "Jornah", frFR = "Jornah", koKR = "Jornah", ptBR = "Jornah", ruRU = "Jornah", zhCN = "Jornah", zhTW = "Jornah" },
    },
    {
        id = 2295, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5160, y = 0.6380,
        name = { enUS = "Jornah", deDE = "Jornah", esES = "Jornah", esMX = "Jornah", frFR = "Jornah", koKR = "Jornah", ptBR = "Jornah", ruRU = "Jornah", zhCN = "Jornah", zhTW = "Jornah" },
    },
    {
        id = 2296, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5160, y = 0.6460,
        name = { enUS = "Jornah", deDE = "Jornah", esES = "Jornah", esMX = "Jornah", frFR = "Jornah", koKR = "Jornah", ptBR = "Jornah", ruRU = "Jornah", zhCN = "Jornah", zhTW = "Jornah" },
    },
    {
        id = 2297, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4752, y = 0.4672,
        name = { enUS = "Kurgul", deDE = "Kurgul", esES = "Kurgul", esMX = "Kurgul", frFR = "Kurgul", koKR = "쿠르굴", ptBR = "Kurgul", ruRU = "Кургул", zhCN = "库古尔", zhTW = "庫古爾" },
    },
    {
        id = 2298, types = { "vendor" },
        faction = "Neutral", map = 1454, x = 0.4127, y = 0.3236,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2299, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4310, y = 0.3480,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2300, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4312, y = 0.3513,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2301, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4453, y = 0.3615,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2302, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5438, y = 0.3605,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2303, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5707, y = 0.3765,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2304, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5798, y = 0.3829,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2305, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5830, y = 0.3828,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2306, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.5966, y = 0.3934,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2307, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6047, y = 0.4074,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2308, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6053, y = 0.4076,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2309, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6061, y = 0.4077,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2310, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6146, y = 0.4026,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2311, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6265, y = 0.3897,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2312, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6268, y = 0.3906,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2313, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6285, y = 0.3853,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2314, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6300, y = 0.3883,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2315, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6312, y = 0.3848,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2316, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6317, y = 0.3880,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2317, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6330, y = 0.3853,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2318, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6355, y = 0.3831,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2319, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6375, y = 0.3818,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2320, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6402, y = 0.3797,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2321, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6409, y = 0.3803,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2322, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6423, y = 0.3778,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2323, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6515, y = 0.3940,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2324, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6521, y = 0.3952,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2325, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6542, y = 0.3946,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2326, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6543, y = 0.3955,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2327, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6547, y = 0.3935,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2328, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6553, y = 0.3948,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2329, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6565, y = 0.3964,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2330, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6588, y = 0.4011,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2331, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6589, y = 0.4002,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2332, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6600, y = 0.4011,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2333, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6661, y = 0.3997,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2334, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6676, y = 0.3966,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2335, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6695, y = 0.3982,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2336, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6704, y = 0.3973,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2337, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6712, y = 0.3951,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2338, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6720, y = 0.3928,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2339, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6722, y = 0.3941,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2340, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6730, y = 0.3918,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2341, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6732, y = 0.3928,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2342, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6768, y = 0.3914,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2343, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6782, y = 0.3901,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2344, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6804, y = 0.3851,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2345, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6809, y = 0.3904,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2346, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6821, y = 0.3894,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2347, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6870, y = 0.1460,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2348, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6886, y = 0.3783,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2349, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6897, y = 0.3723,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2350, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6996, y = 0.3641,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2351, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7004, y = 0.3631,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2352, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7010, y = 0.3609,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2353, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7017, y = 0.3598,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2354, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7050, y = 0.1863,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2355, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7116, y = 0.2671,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2356, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.7201, y = 0.1963,
        name = { enUS = "Mayhoa Skyhoof", deDE = "Mayhoa Skyhoof", esES = "Mayhoa Skyhoof", esMX = "Mayhoa Skyhoof", frFR = "Mayhoa Skyhoof", koKR = "Mayhoa Skyhoof", ptBR = "Mayhoa Skyhoof", ruRU = "Mayhoa Skyhoof", zhCN = "Mayhoa Skyhoof", zhTW = "Mayhoa Skyhoof" },
    },
    {
        id = 2357, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3344, y = 0.3749,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2358, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3364, y = 0.3781,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2359, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3476, y = 0.3832,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2360, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3480, y = 0.3812,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2361, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3484, y = 0.3769,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2362, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3486, y = 0.3810,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2363, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3490, y = 0.3777,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2364, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3498, y = 0.3793,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2365, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3515, y = 0.3735,
        name = { enUS = "Mokvar", deDE = "Mokvar", esES = "Mokvar", esMX = "Mokvar", frFR = "Mokvar", koKR = "Mokvar", ptBR = "Mokvar", ruRU = "Mokvar", zhCN = "Mokvar", zhTW = "Mokvar" },
    },
    {
        id = 2366, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.6938, y = 0.1224,
        name = { enUS = "Ogunaro Wolfrunner", deDE = "Ogunaro Wolfrunner", esES = "Ogunaro Correlobo", esMX = "Ogunaro Correlobo", frFR = "Ogunaro Wolfrunner", koKR = "오구나로 울프러너", ptBR = "Ogunaro Correlobos", ruRU = "Огунаро Волкопас", zhCN = "奥古纳罗", zhTW = "奧古納羅" },
    },
    {
        id = 2367, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3082, y = 0.7367,
        name = { enUS = "Orgrimmar Commendation Officer", deDE = "Belobigungsoffizier von Orgrimmar", esES = "Oficial de Honor de Orgrimmar", esMX = "Oficial de Honor de Orgrimmar", frFR = "Officier du mérite d'Orgrimmar", koKR = "오그리마 인사장교", ptBR = "Oficial de Comendas de Orgrimmar", ruRU = "Сборщик похвальных значков из Оргриммара", zhCN = "奥格瑞玛嘉奖官", zhTW = "奧格瑪表揚官" },
    },
    {
        id = 2368, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4920, y = 0.4680,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2369, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4940, y = 0.4620,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2370, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.4960, y = 0.4620,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2371, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3382, y = 0.7984,
        name = { enUS = "Xan'tish", deDE = "Xan'tish", esES = "Xan'tish", esMX = "Xan'tish", frFR = "Xan'tish", koKR = "산티쉬", ptBR = "Xan'tish", ruRU = "Ксан'Тиш", zhCN = "克萨迪斯", zhTW = "克薩迪斯" },
    },
    {
        id = 2372, types = { "vendor" },
        faction = "Horde", map = 1454, x = 0.3893, y = 0.3840,
        name = { enUS = "Zor Lonetree", deDE = "Zor Lonetree", esES = "Zor Árbol Solitario", esMX = "Zor Árbol Solitario", frFR = "Zor Lonetree", koKR = "조르 론트리", ptBR = "Zor Solárbol", ruRU = "Зор Одинокое Дерево", zhCN = "佐尔·孤树", zhTW = "佐爾·孤樹" },
    },
    {
        id = 2373, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.7041, y = 0.9112,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 2374, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4107, y = 0.5414,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2375, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4281, y = 0.5248,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2376, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4287, y = 0.5221,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2377, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4289, y = 0.5269,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2378, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4295, y = 0.5272,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2379, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4307, y = 0.5268,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2380, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4309, y = 0.5261,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2381, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4313, y = 0.5226,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2382, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4317, y = 0.5202,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2383, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4340, y = 0.5229,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2384, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4352, y = 0.5157,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2385, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4361, y = 0.5205,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2386, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4366, y = 0.5232,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2387, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4368, y = 0.5200,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2388, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4372, y = 0.5110,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2389, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4378, y = 0.5184,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2390, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4392, y = 0.5188,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2391, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4394, y = 0.5204,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2392, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4395, y = 0.5227,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2393, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4414, y = 0.5241,
        name = { enUS = "Deliana", deDE = "Deliana", esES = "Deliana", esMX = "Deliana", frFR = "Deliana", koKR = "Deliana", ptBR = "Deliana", ruRU = "Deliana", zhCN = "Deliana", zhTW = "Deliana" },
    },
    {
        id = 2394, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4332, y = 0.2759,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2395, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4343, y = 0.2771,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2396, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4344, y = 0.2789,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2397, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4349, y = 0.2808,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2398, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4350, y = 0.2817,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2399, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4352, y = 0.2764,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2400, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4355, y = 0.2780,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2401, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4356, y = 0.2795,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2402, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4358, y = 0.2788,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2403, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4360, y = 0.2756,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2404, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4360, y = 0.2803,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2405, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4362, y = 0.2769,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2406, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4362, y = 0.2821,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2407, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4363, y = 0.2798,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2408, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4364, y = 0.2790,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2409, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4366, y = 0.2815,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2410, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4374, y = 0.2782,
        name = { enUS = "Ellie Stonebrow", deDE = "Ellie Stonebrow", esES = "Ellie Stonebrow", esMX = "Ellie Stonebrow", frFR = "Ellie Stonebrow", koKR = "Ellie Stonebrow", ptBR = "Ellie Stonebrow", ruRU = "Ellie Stonebrow", zhCN = "Ellie Stonebrow", zhTW = "Ellie Stonebrow" },
    },
    {
        id = 2411, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.7356, y = 0.5338,
        name = { enUS = "Fizzlebang Booms", deDE = "Fizzlebang Booms", esES = "Fizzlebang Explot", esMX = "Fizzlebang Explot", frFR = "Fizzlebang Booms", koKR = "피즐뱅 붐즈", ptBR = "Chiabangue Buum", ruRU = "Физзблям Бум", zhCN = "菲斯巴恩", zhTW = "菲斯巴恩" },
    },
    {
        id = 2412, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.7357, y = 0.5335,
        name = { enUS = "Fizzlebang Booms", deDE = "Fizzlebang Booms", esES = "Fizzlebang Explot", esMX = "Fizzlebang Explot", frFR = "Fizzlebang Booms", koKR = "피즐뱅 붐즈", ptBR = "Chiabangue Buum", ruRU = "Физзблям Бум", zhCN = "菲斯巴恩", zhTW = "菲斯巴恩" },
    },
    {
        id = 2413, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3900, y = 0.3320,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2414, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3902, y = 0.3313,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2415, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3902, y = 0.3382,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2416, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3908, y = 0.3304,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2417, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3908, y = 0.3356,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2418, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3914, y = 0.3318,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2419, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3915, y = 0.3344,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2420, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3917, y = 0.3330,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2421, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3917, y = 0.3387,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2422, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3918, y = 0.3325,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2423, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3919, y = 0.3336,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2424, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3919, y = 0.3373,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2425, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3924, y = 0.3405,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2426, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3925, y = 0.3360,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2427, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3927, y = 0.3344,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2428, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3930, y = 0.3403,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2429, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3932, y = 0.3269,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2430, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3933, y = 0.3336,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2431, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3943, y = 0.3374,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2432, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3943, y = 0.3425,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2433, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3949, y = 0.3342,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2434, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3952, y = 0.3325,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2435, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3956, y = 0.3374,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2436, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3963, y = 0.3330,
        name = { enUS = "Granny Finespindle", deDE = "Granny Finespindle", esES = "Granny Finespindle", esMX = "Granny Finespindle", frFR = "Granny Finespindle", koKR = "Granny Finespindle", ptBR = "Granny Finespindle", ruRU = "Granny Finespindle", zhCN = "Granny Finespindle", zhTW = "Granny Finespindle" },
    },
    {
        id = 2437, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.6111, y = 0.7697,
        name = { enUS = "Ironforge Commendation Officer", deDE = "Belobigungsoffizier von Ironforge", esES = "Oficial de Honor de Forjaz", esMX = "Oficial de Honor de Forjaz", frFR = "Officier du mérite d'Ironforge", koKR = "아이언포지 인사장교", ptBR = "Oficial de Comendas de Altaforja", ruRU = "Сборщик похвальных значков из Стальгорна", zhCN = "铁炉堡嘉奖官", zhTW = "鐵爐堡表揚官" },
    },
    {
        id = 2438, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4240, y = 0.5380,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2439, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4320, y = 0.5240,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2440, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4320, y = 0.5260,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2441, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4340, y = 0.5120,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2442, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4360, y = 0.5120,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2443, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.4360, y = 0.5220,
        name = { enUS = "Ironforge Guard", deDE = "Ironforge Guard", esES = "Ironforge Guard", esMX = "Ironforge Guard", frFR = "Ironforge Guard", koKR = "Ironforge Guard", ptBR = "Ironforge Guard", ruRU = "Ironforge Guard", zhCN = "Ironforge Guard", zhTW = "Ironforge Guard" },
    },
    {
        id = 2444, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5270, y = 0.0608,
        name = { enUS = "Jubahl Corpseseeker", deDE = "Jubaal Corpseseeker", esES = "Jubahl Buscadáver", esMX = "Jubahl Buscador de cadáveres", frFR = "Jubahl Cherche-corps", koKR = "주발 콥스시커", ptBR = "Jubahl Catadefunto", ruRU = "Жубал Труполов", zhCN = "寻尸者祖贝尔", zhTW = "尋屍者祖貝爾" },
    },
    {
        id = 2445, types = { "vendor" },
        faction = "Neutral", map = 1455, x = 0.2992, y = 0.1421,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2446, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.3631, y = 0.8547,
        name = { enUS = "Lyesa Steelbrow", deDE = "Lyesa Steelbrow", esES = "Lyesa Frenteacerada", esMX = "Lyesa Frenteacerada", frFR = "Lyesa Steelbrow", koKR = "리사 스틸브로우", ptBR = "Liesa Testaço", ruRU = "Лиеса Стальной Лоб", zhCN = "利莎·钢眉", zhTW = "利莎·鋼眉" },
    },
    {
        id = 2447, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5300, y = 0.1320,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2448, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5360, y = 0.1220,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2449, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5380, y = 0.1320,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2450, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5380, y = 0.1360,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2451, types = { "vendor" },
        faction = "Alliance", map = 1455, x = 0.5295, y = 0.1371,
        name = { enUS = "Tynnus Venomsprout", deDE = "Tynnus Venomsprout", esES = "Tynnus Lanzaveneno", esMX = "Tynnus Lanzaveneno", frFR = "Tynnus Venomsprout", koKR = "타이너스 베놈스프라우트", ptBR = "Tino Venebroto", ruRU = "Тиннус Ядоплющ", zhCN = "泰努斯·毒芽", zhTW = "泰努斯·毒芽" },
    },
    {
        id = 2452, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.7106, y = 0.3419,
        name = { enUS = "Bashana Runetotem", deDE = "Bashana Runetotem", esES = "Bashana Runatótem", esMX = "Bashana Tótem de Runa", frFR = "Bashana Runetotem", koKR = "바샤나 룬토템", ptBR = "Bashana Runa Totem", ruRU = "Башана Рунический Тотем", zhCN = "巴珊娜·符文图腾", zhTW = "巴珊娜·符文圖騰" },
    },
    {
        id = 2453, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4374, y = 0.4484,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2454, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4376, y = 0.4460,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2455, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4379, y = 0.4447,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2456, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4380, y = 0.4488,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2457, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4385, y = 0.4470,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2458, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4392, y = 0.4484,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2459, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4392, y = 0.4493,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2460, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4393, y = 0.4457,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2461, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4397, y = 0.4497,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2462, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4399, y = 0.4472,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2463, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4406, y = 0.4480,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2464, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4406, y = 0.4502,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2465, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4411, y = 0.4441,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2466, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4412, y = 0.4456,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2467, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4415, y = 0.4492,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2468, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4419, y = 0.4517,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2469, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4421, y = 0.4509,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2470, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4424, y = 0.4515,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2471, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4433, y = 0.4531,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2472, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4435, y = 0.4525,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2473, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4443, y = 0.4497,
        name = { enUS = "Boramu", deDE = "Boramu", esES = "Boramu", esMX = "Boramu", frFR = "Boramu", koKR = "Boramu", ptBR = "Boramu", ruRU = "Boramu", zhCN = "Boramu", zhTW = "Boramu" },
    },
    {
        id = 2474, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.6198, y = 0.5837,
        name = { enUS = "Halpa", deDE = "Halpa", esES = "Halpa", esMX = "Halpa", frFR = "Halpa", koKR = "할파", ptBR = "Halpa", ruRU = "Хальпа", zhCN = "哈尔帕", zhTW = "哈爾帕" },
    },
    {
        id = 2475, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.5780, y = 0.7640,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2476, types = { "vendor" },
        faction = "Neutral", map = 1456, x = 0.7056, y = 0.2783,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2477, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.2260, y = 0.1280,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2478, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.2280, y = 0.1380,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2479, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.4905, y = 0.3424,
        name = { enUS = "Tand", deDE = "Tand", esES = "Tand", esMX = "Tand", frFR = "Tand", koKR = "탄드", ptBR = "Tand", ruRU = "Танд", zhCN = "坦德", zhTW = "坦德" },
    },
    {
        id = 2480, types = { "vendor" },
        faction = "Horde", map = 1456, x = 0.3767, y = 0.6326,
        name = { enUS = "Thrumn", deDE = "Thrumn", esES = "Thrumn", esMX = "Thrumn", frFR = "Thrumn", koKR = "트룸", ptBR = "Thrumn", ruRU = "Трюмн", zhCN = "瑟拉姆", zhTW = "瑟拉姆" },
    },
    {
        id = 2481, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.5802, y = 0.3452,
        name = { enUS = "Alliance Brigadier General", deDE = "Brigadegeneral der Allianz", esES = "Brigadier general de la Alianza", esMX = "General de brigada de la Alianza", frFR = "Général de brigade de l'Alliance", koKR = "얼라이언스 준장", ptBR = "General de Brigada da Aliança", ruRU = "Бригадный генерал Альянса", zhCN = "联盟准将", zhTW = "聯盟准將" },
    },
    {
        id = 2482, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6354, y = 0.2141,
        name = { enUS = "Dani'ill", deDE = "Dani'ill", esES = "Dani'ill", esMX = "Dani'ill", frFR = "Dani'ill", koKR = "Dani'ill", ptBR = "Dani'ill", ruRU = "Dani'ill", zhCN = "Dani'ill", zhTW = "Dani'ill" },
    },
    {
        id = 2483, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6370, y = 0.2125,
        name = { enUS = "Dani'ill", deDE = "Dani'ill", esES = "Dani'ill", esMX = "Dani'ill", frFR = "Dani'ill", koKR = "Dani'ill", ptBR = "Dani'ill", ruRU = "Dani'ill", zhCN = "Dani'ill", zhTW = "Dani'ill" },
    },
    {
        id = 2484, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6376, y = 0.2117,
        name = { enUS = "Dani'ill", deDE = "Dani'ill", esES = "Dani'ill", esMX = "Dani'ill", frFR = "Dani'ill", koKR = "Dani'ill", ptBR = "Dani'ill", ruRU = "Dani'ill", zhCN = "Dani'ill", zhTW = "Dani'ill" },
    },
    {
        id = 2485, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6376, y = 0.2156,
        name = { enUS = "Dani'ill", deDE = "Dani'ill", esES = "Dani'ill", esMX = "Dani'ill", frFR = "Dani'ill", koKR = "Dani'ill", ptBR = "Dani'ill", ruRU = "Dani'ill", zhCN = "Dani'ill", zhTW = "Dani'ill" },
    },
    {
        id = 2486, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6381, y = 0.2127,
        name = { enUS = "Dani'ill", deDE = "Dani'ill", esES = "Dani'ill", esMX = "Dani'ill", frFR = "Dani'ill", koKR = "Dani'ill", ptBR = "Dani'ill", ruRU = "Dani'ill", zhCN = "Dani'ill", zhTW = "Dani'ill" },
    },
    {
        id = 2487, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.3828, y = 0.1536,
        name = { enUS = "Lelanai", deDE = "Lelanai", esES = "Lelanai", esMX = "Lelanai", frFR = "Lelanai", koKR = "렐라나이", ptBR = "Lelanai", ruRU = "Леланай", zhCN = "莱兰奈", zhTW = "萊蘭奈" },
    },
    {
        id = 2488, types = { "vendor" },
        faction = "Neutral", map = 1457, x = 0.3156, y = 0.1369,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2489, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.5920, y = 0.5660,
        name = { enUS = "Marcy Baker", deDE = "Marcy Baker", esES = "Marcy Baker", esMX = "Marcy Baker", frFR = "Marcy Baker", koKR = "Marcy Baker", ptBR = "Marcy Baker", ruRU = "Marcy Baker", zhCN = "Marcy Baker", zhTW = "Marcy Baker" },
    },
    {
        id = 2490, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.5940, y = 0.5600,
        name = { enUS = "Marcy Baker", deDE = "Marcy Baker", esES = "Marcy Baker", esMX = "Marcy Baker", frFR = "Marcy Baker", koKR = "Marcy Baker", ptBR = "Marcy Baker", ruRU = "Marcy Baker", zhCN = "Marcy Baker", zhTW = "Marcy Baker" },
    },
    {
        id = 2491, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.5980, y = 0.5640,
        name = { enUS = "Marcy Baker", deDE = "Marcy Baker", esES = "Marcy Baker", esMX = "Marcy Baker", frFR = "Marcy Baker", koKR = "Marcy Baker", ptBR = "Marcy Baker", ruRU = "Marcy Baker", zhCN = "Marcy Baker", zhTW = "Marcy Baker" },
    },
    {
        id = 2492, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.5980, y = 0.5660,
        name = { enUS = "Marcy Baker", deDE = "Marcy Baker", esES = "Marcy Baker", esMX = "Marcy Baker", frFR = "Marcy Baker", koKR = "Marcy Baker", ptBR = "Marcy Baker", ruRU = "Marcy Baker", zhCN = "Marcy Baker", zhTW = "Marcy Baker" },
    },
    {
        id = 2493, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.2840, y = 0.3900,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2494, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.2860, y = 0.3900,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2495, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.2900, y = 0.3840,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2496, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.7040, y = 0.2340,
        name = { enUS = "Shalumon", deDE = "Shalumon", esES = "Shalumon", esMX = "Shalumon", frFR = "Shalumon", koKR = "샬루몬", ptBR = "Shalumon", ruRU = "Шалумон", zhCN = "沙鲁蒙", zhTW = "沙魯蒙" },
    },
    {
        id = 2497, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6964, y = 0.4590,
        name = { enUS = "Shylenai", deDE = "Shylenai", esES = "Shylenai", esMX = "Shylenai", frFR = "Shylenai", koKR = "샤이레나이", ptBR = "Shylenai", ruRU = "Шиленаи", zhCN = "夏琳奈尔", zhTW = "夏琳奈爾" },
    },
    {
        id = 2498, types = { "vendor" },
        faction = "Alliance", map = 1457, x = 0.6527, y = 0.5303,
        name = { enUS = "Yldan", deDE = "Yldan", esES = "Yldan", esMX = "Yldan", frFR = "Yldan", koKR = "일단", ptBR = "Yldan", ruRU = "Ильдан", zhCN = "伊尔丹", zhTW = "伊爾丹" },
    },
    {
        id = 2499, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.5861, y = 0.5468,
        name = { enUS = "Alessandro Luca", deDE = "Alessandro Luca", esES = "Alessandro Luca", esMX = "Alessandro Luca", frFR = "Alessandro Luca", koKR = "알렉산드로 루카", ptBR = "Alessandro Luca", ruRU = "Алессандро Лука", zhCN = "奥雷萨多·卢卡", zhTW = "奧雷薩多·盧卡" },
    },
    {
        id = 2500, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7019, y = 0.2990,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2501, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7027, y = 0.3009,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2502, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7027, y = 0.3020,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2503, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7029, y = 0.2984,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2504, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7029, y = 0.3000,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2505, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7036, y = 0.3020,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2506, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7038, y = 0.2987,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2507, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7039, y = 0.2954,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2508, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7039, y = 0.2975,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2509, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7041, y = 0.2965,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2510, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7041, y = 0.3041,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2511, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7045, y = 0.2941,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2512, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7046, y = 0.3022,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2513, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7050, y = 0.2980,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2514, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7051, y = 0.3017,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2515, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7052, y = 0.2932,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2516, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7055, y = 0.2951,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2517, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7055, y = 0.3010,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2518, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7056, y = 0.2945,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2519, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7061, y = 0.2975,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2520, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7064, y = 0.2952,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2521, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7065, y = 0.2940,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2522, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7065, y = 0.2992,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2523, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7067, y = 0.2969,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2524, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7078, y = 0.2994,
        name = { enUS = "Angela Ward", deDE = "Angela Ward", esES = "Angela Ward", esMX = "Angela Ward", frFR = "Angela Ward", koKR = "Angela Ward", ptBR = "Angela Ward", ruRU = "Angela Ward", zhCN = "Angela Ward", zhTW = "Angela Ward" },
    },
    {
        id = 2525, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.5550, y = 0.6410,
        name = { enUS = "Boyle", deDE = "Boyle", esES = "Boyle", esMX = "Boyle", frFR = "Boyle", koKR = "보일", ptBR = "Brandão", ruRU = "Бойл", zhCN = "波伊尔", zhTW = "波伊爾" },
    },
    {
        id = 2526, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6981, y = 0.4428,
        name = { enUS = "Edward Remington", deDE = "Edward Remington", esES = "Edward Remington", esMX = "Edward Remington", frFR = "Edward Remington", koKR = "에드워드 레밍턴", ptBR = "Eduardo Capistrano", ruRU = "Эдвард Ремингтон", zhCN = "爱德华·雷明顿", zhTW = "愛德華·雷明頓" },
    },
    {
        id = 2527, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7548, y = 0.7434,
        name = { enUS = "Elizabeth Van Talen", deDE = "Elizabeth Van Talen", esES = "Elizabeth Van Talen", esMX = "Elizabeth Van Talen", frFR = "Elizabeth Van Talen", koKR = "엘리자베스 반 탈렌", ptBR = "Elizabeth Henriques", ruRU = "Элизабет ван Тален", zhCN = "伊丽莎白·范·塔伦", zhTW = "伊莉莎白·範·塔倫" },
    },
    {
        id = 2528, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6440, y = 0.3840,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2529, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6440, y = 0.3860,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2530, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6460, y = 0.3860,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2531, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6480, y = 0.3820,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2532, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6560, y = 0.3840,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2533, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6560, y = 0.3860,
        name = { enUS = "Gishah", deDE = "Gishah", esES = "Gishah", esMX = "Gishah", frFR = "Gishah", koKR = "Gishah", ptBR = "Gishah", ruRU = "Gishah", zhCN = "Gishah", zhTW = "Gishah" },
    },
    {
        id = 2534, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.5827, y = 0.9790,
        name = { enUS = "Horde Warbringer", deDE = "Kriegshetzer der Horde", esES = "Belisario de la Horda", esMX = "Belisario de la Horda", frFR = "Porteguerre de la Horde", koKR = "호드 돌격대장", ptBR = "Armipotente da Horda", ruRU = "Ордынский вестник войны", zhCN = "部落战争使者", zhTW = "部落戰爭使者" },
    },
    {
        id = 2535, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6760, y = 0.4416,
        name = { enUS = "Jeremiah Payson", deDE = "Jeremiah Payson", esES = "Jeremiah Payson", esMX = "Jeremiah Payson", frFR = "Jeremiah Payson", koKR = "제레미어 페이슨", ptBR = "Jeremias Mascotte", ruRU = "Иеремия Пэйсон", zhCN = "杰雷米亚·派森", zhTW = "傑雷米亞·派森" },
    },
    {
        id = 2536, types = { "vendor" },
        faction = "Neutral", map = 1458, x = 0.6645, y = 0.3602,
        name = { enUS = "Lunar Festival Vendor", deDE = "Verkäufer des Mondfests", esES = "Mercader del Festival Lunar", esMX = "Mercader del Festival Lunar", frFR = "Marchand de la fête lunaire", koKR = "달의 축제 상인", ptBR = "Comerciante do Festival da Lua", ruRU = "Торговец Лунного фестиваля", zhCN = "春节商人", zhTW = "新年商人" },
    },
    {
        id = 2537, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.8570, y = 0.1608,
        name = { enUS = "Martha Strain", deDE = "Martha Strain", esES = "Martha Forza", esMX = "Martha Forza", frFR = "Martha Strain", koKR = "탈타 스트레인", ptBR = "Marta Seixas", ruRU = "Марта Стрейн", zhCN = "马尔萨·斯坦恩", zhTW = "馬爾薩·斯坦恩" },
    },
    {
        id = 2538, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.6933, y = 0.4482,
        name = { enUS = "Merill Pleasance", deDE = "Merill Pleasance", esES = "Merill Agradablia", esMX = "Merill Agradablia", frFR = "Merill Pleasance", koKR = "메릴 플레전스", ptBR = "Merila Aparício", ruRU = "Мериль Плезир", zhCN = "迈瑞尔·普莱森斯", zhTW = "邁瑞爾·普萊森斯" },
    },
    {
        id = 2539, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7920, y = 0.1940,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2540, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7940, y = 0.1980,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2541, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7960, y = 0.1940,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2542, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7960, y = 0.2000,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2543, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7980, y = 0.2060,
        name = { enUS = "Rune Broker", deDE = "Rune Broker", esES = "Rune Broker", esMX = "Rune Broker", frFR = "Rune Broker", koKR = "Rune Broker", ptBR = "Rune Broker", ruRU = "Rune Broker", zhCN = "Rune Broker", zhTW = "Rune Broker" },
    },
    {
        id = 2544, types = { "vendor" },
        faction = "Horde", map = 1458, x = 0.7742, y = 0.3926,
        name = { enUS = "Salazar Bloch", deDE = "Salazar Bloch", esES = "Salazar Bloch", esMX = "Salazar Bloch", frFR = "Salazar Bloch", koKR = "살라자르 블로치", ptBR = "Salazar Bloch", ruRU = "Салазар Блох", zhCN = "萨拉扎尔·布洛什", zhTW = "薩拉札爾·布洛什" },
    },
    {
        id = 2545, types = { "vendor" },
        map = 2482, x = 0.5880, y = 0.4180,
        name = { enUS = "Pexmit", deDE = "Pexmit", esES = "Pexmit", esMX = "Pexmit", frFR = "Pexmit", koKR = "Pexmit", ptBR = "Pexmit", ruRU = "Pexmit", zhCN = "Pexmit", zhTW = "Pexmit" },
    },
    {
        id = 2546, types = { "vendor" },
        map = 2482, x = 0.5960, y = 0.4920,
        name = { enUS = "Pexmit", deDE = "Pexmit", esES = "Pexmit", esMX = "Pexmit", frFR = "Pexmit", koKR = "Pexmit", ptBR = "Pexmit", ruRU = "Pexmit", zhCN = "Pexmit", zhTW = "Pexmit" },
    },
    {
        id = 2547, types = { "vendor" },
        faction = "Alliance", map = 2482, x = 0.7067, y = 0.5134,
        name = { enUS = "Rhylin Stonethorn", deDE = "Rhylin Stonethorn", esES = "Rhylin Stonethorn", esMX = "Rhylin Stonethorn", frFR = "Rhylin Stonethorn", koKR = "Rhylin Stonethorn", ptBR = "Rhylin Stonethorn", ruRU = "Rhylin Stonethorn", zhCN = "Rhylin Stonethorn", zhTW = "Rhylin Stonethorn" },
    },
    {
        id = 2548, types = { "vendor" },
        faction = "Alliance", map = 2482, x = 0.7073, y = 0.5126,
        name = { enUS = "Rhylin Stonethorn", deDE = "Rhylin Stonethorn", esES = "Rhylin Stonethorn", esMX = "Rhylin Stonethorn", frFR = "Rhylin Stonethorn", koKR = "Rhylin Stonethorn", ptBR = "Rhylin Stonethorn", ruRU = "Rhylin Stonethorn", zhCN = "Rhylin Stonethorn", zhTW = "Rhylin Stonethorn" },
    },
    {
        id = 2549, types = { "vendor" },
        faction = "Neutral", map = 2521, x = 0.5778, y = 0.5197,
        name = { enUS = "Brother Zendraas", deDE = "Brother Zendraas", esES = "Brother Zendraas", esMX = "Brother Zendraas", frFR = "Brother Zendraas", koKR = "Brother Zendraas", ptBR = "Brother Zendraas", ruRU = "Brother Zendraas", zhCN = "Brother Zendraas", zhTW = "Brother Zendraas" },
    },
    {
        id = 2550, types = { "vendor" },
        faction = "Neutral", map = 2521, x = 0.5848, y = 0.5029,
        name = { enUS = "Brother Zendraas", deDE = "Brother Zendraas", esES = "Brother Zendraas", esMX = "Brother Zendraas", frFR = "Brother Zendraas", koKR = "Brother Zendraas", ptBR = "Brother Zendraas", ruRU = "Brother Zendraas", zhCN = "Brother Zendraas", zhTW = "Brother Zendraas" },
    },
    {
        id = 2551, types = { "vendor" },
        faction = "Neutral", map = 2521, x = 0.5877, y = 0.4958,
        name = { enUS = "Brother Zendraas", deDE = "Brother Zendraas", esES = "Brother Zendraas", esMX = "Brother Zendraas", frFR = "Brother Zendraas", koKR = "Brother Zendraas", ptBR = "Brother Zendraas", ruRU = "Brother Zendraas", zhCN = "Brother Zendraas", zhTW = "Brother Zendraas" },
    },
    {
        id = 2552, types = { "vendor" },
        faction = "Neutral", map = 2521, x = 0.5787, y = 0.7682,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2553, types = { "vendor" },
        faction = "Neutral", map = 2521, x = 0.5868, y = 0.7391,
        name = { enUS = "Reagent Bot", deDE = "Reagent Bot", esES = "Reagent Bot", esMX = "Reagent Bot", frFR = "Reagent Bot", koKR = "Reagent Bot", ptBR = "Reagent Bot", ruRU = "Reagent Bot", zhCN = "Reagent Bot", zhTW = "Reagent Bot" },
    },
    {
        id = 2554, types = { "vendor" },
        map = 2548, x = 0.6374, y = 0.1702,
        name = { enUS = "Dorb", deDE = "Dorb", esES = "Dorb", esMX = "Dorb", frFR = "Dorb", koKR = "Dorb", ptBR = "Dorb", ruRU = "Dorb", zhCN = "Dorb", zhTW = "Dorb" },
    },
    {
        id = 2555, types = { "vendor" },
        map = 2548, x = 0.7895, y = 0.5422,
        name = { enUS = "Fimbo Greasemitz", deDE = "Fimbo Greasemitz", esES = "Fimbo Greasemitz", esMX = "Fimbo Greasemitz", frFR = "Fimbo Greasemitz", koKR = "Fimbo Greasemitz", ptBR = "Fimbo Greasemitz", ruRU = "Fimbo Greasemitz", zhCN = "Fimbo Greasemitz", zhTW = "Fimbo Greasemitz" },
    },
    {
        id = 2556, types = { "vendor" },
        map = 2548, x = 0.7897, y = 0.5431,
        name = { enUS = "Fimbo Greasemitz", deDE = "Fimbo Greasemitz", esES = "Fimbo Greasemitz", esMX = "Fimbo Greasemitz", frFR = "Fimbo Greasemitz", koKR = "Fimbo Greasemitz", ptBR = "Fimbo Greasemitz", ruRU = "Fimbo Greasemitz", zhCN = "Fimbo Greasemitz", zhTW = "Fimbo Greasemitz" },
    },
    {
        id = 2557, types = { "vendor" },
        map = 2548, x = 0.7900, y = 0.5409,
        name = { enUS = "Fimbo Greasemitz", deDE = "Fimbo Greasemitz", esES = "Fimbo Greasemitz", esMX = "Fimbo Greasemitz", frFR = "Fimbo Greasemitz", koKR = "Fimbo Greasemitz", ptBR = "Fimbo Greasemitz", ruRU = "Fimbo Greasemitz", zhCN = "Fimbo Greasemitz", zhTW = "Fimbo Greasemitz" },
    },
    {
        id = 2558, types = { "vendor" },
        map = 2548, x = 0.7905, y = 0.5413,
        name = { enUS = "Fimbo Greasemitz", deDE = "Fimbo Greasemitz", esES = "Fimbo Greasemitz", esMX = "Fimbo Greasemitz", frFR = "Fimbo Greasemitz", koKR = "Fimbo Greasemitz", ptBR = "Fimbo Greasemitz", ruRU = "Fimbo Greasemitz", zhCN = "Fimbo Greasemitz", zhTW = "Fimbo Greasemitz" },
    },
    {
        id = 2559, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7698, y = 0.5310,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2560, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7701, y = 0.5291,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2561, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7711, y = 0.5277,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2562, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7712, y = 0.5297,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2563, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7713, y = 0.5289,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2564, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7723, y = 0.5290,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2565, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7754, y = 0.5296,
        name = { enUS = "Friz Frazzlespark", deDE = "Friz Frazzlespark", esES = "Friz Frazzlespark", esMX = "Friz Frazzlespark", frFR = "Friz Frazzlespark", koKR = "Friz Frazzlespark", ptBR = "Friz Frazzlespark", ruRU = "Friz Frazzlespark", zhCN = "Friz Frazzlespark", zhTW = "Friz Frazzlespark" },
    },
    {
        id = 2566, types = { "vendor" },
        map = 2548, x = 0.6720, y = 0.1940,
        name = { enUS = "Glop", deDE = "Glop", esES = "Glop", esMX = "Glop", frFR = "Glop", koKR = "Glop", ptBR = "Glop", ruRU = "Glop", zhCN = "Glop", zhTW = "Glop" },
    },
    {
        id = 2567, types = { "vendor" },
        faction = "Alliance", map = 2548, x = 0.6542, y = 0.9000,
        name = { enUS = "Kenneth \"Kirby\" Millstead", deDE = "Kenneth \"Kirby\" Millstead", esES = "Kenneth \"Kirby\" Millstead", esMX = "Kenneth \"Kirby\" Millstead", frFR = "Kenneth \"Kirby\" Millstead", koKR = "Kenneth \"Kirby\" Millstead", ptBR = "Kenneth \"Kirby\" Millstead", ruRU = "Kenneth \"Kirby\" Millstead", zhCN = "Kenneth \"Kirby\" Millstead", zhTW = "Kenneth \"Kirby\" Millstead" },
    },
    {
        id = 2568, types = { "vendor" },
        faction = "Alliance", map = 2548, x = 0.6544, y = 0.9005,
        name = { enUS = "Kenneth \"Kirby\" Millstead", deDE = "Kenneth \"Kirby\" Millstead", esES = "Kenneth \"Kirby\" Millstead", esMX = "Kenneth \"Kirby\" Millstead", frFR = "Kenneth \"Kirby\" Millstead", koKR = "Kenneth \"Kirby\" Millstead", ptBR = "Kenneth \"Kirby\" Millstead", ruRU = "Kenneth \"Kirby\" Millstead", zhCN = "Kenneth \"Kirby\" Millstead", zhTW = "Kenneth \"Kirby\" Millstead" },
    },
    {
        id = 2569, types = { "vendor" },
        faction = "Alliance", map = 2548, x = 0.6552, y = 0.8921,
        name = { enUS = "Kenneth \"Kirby\" Millstead", deDE = "Kenneth \"Kirby\" Millstead", esES = "Kenneth \"Kirby\" Millstead", esMX = "Kenneth \"Kirby\" Millstead", frFR = "Kenneth \"Kirby\" Millstead", koKR = "Kenneth \"Kirby\" Millstead", ptBR = "Kenneth \"Kirby\" Millstead", ruRU = "Kenneth \"Kirby\" Millstead", zhCN = "Kenneth \"Kirby\" Millstead", zhTW = "Kenneth \"Kirby\" Millstead" },
    },
    {
        id = 2570, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7821, y = 0.5193,
        name = { enUS = "Mister Graphed", deDE = "Mister Graphed", esES = "Mister Graphed", esMX = "Mister Graphed", frFR = "Mister Graphed", koKR = "Mister Graphed", ptBR = "Mister Graphed", ruRU = "Mister Graphed", zhCN = "Mister Graphed", zhTW = "Mister Graphed" },
    },
    {
        id = 2571, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7827, y = 0.5201,
        name = { enUS = "Mister Graphed", deDE = "Mister Graphed", esES = "Mister Graphed", esMX = "Mister Graphed", frFR = "Mister Graphed", koKR = "Mister Graphed", ptBR = "Mister Graphed", ruRU = "Mister Graphed", zhCN = "Mister Graphed", zhTW = "Mister Graphed" },
    },
    {
        id = 2572, types = { "vendor" },
        faction = "Neutral", map = 2548, x = 0.7835, y = 0.5229,
        name = { enUS = "Mister Graphed", deDE = "Mister Graphed", esES = "Mister Graphed", esMX = "Mister Graphed", frFR = "Mister Graphed", koKR = "Mister Graphed", ptBR = "Mister Graphed", ruRU = "Mister Graphed", zhCN = "Mister Graphed", zhTW = "Mister Graphed" },
    },
})
