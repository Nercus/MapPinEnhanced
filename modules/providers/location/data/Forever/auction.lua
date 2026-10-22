-- User-supplied forever catalog, imported 2026-10-22. See ../../README.md.
-- Source IDs, native UIMapIDs, normalized coordinates and known translations are retained.
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Providers = MapPinEnhanced:GetModule("Providers")

Providers:RegisterLocationCatalog({
    {
        id = 1, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6217, y = 0.7268,
        name = { enUS = "Auctioneer Cain", deDE = "Auktionator Cain", esES = "Subastador Cain", esMX = "Subastador Cain", frFR = "Commissaire-priseur Cain", koKR = "경매인 케인", ptBR = "Leiloeiro Cain", ruRU = "Аукционер Кейн", zhCN = "拍卖师凯恩", zhTW = "拍賣師凱恩" },
    },
    {
        id = 2, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6149, y = 0.7618,
        name = { enUS = "Auctioneer Epitwee", deDE = "Auktionator Epitwee", esES = "Subastador Epitwee", esMX = "Subastadora Epitwee", frFR = "Commissaire-priseur Epitwee", koKR = "경매인 에피튀", ptBR = "Leiloeira Epifânia", ruRU = "Аукционер Эпитви", zhCN = "拍卖师埃比图", zhTW = "拍賣師埃比圖" },
    },
    {
        id = 3, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6214, y = 0.7618,
        name = { enUS = "Auctioneer Leeka", deDE = "Auktionator Leeka", esES = "Subastadora Leeka", esMX = "Subastadora Leeka", frFR = "Commissaire-priseur Leeka", koKR = "경매인 리카", ptBR = "Leiloeira Leeka", ruRU = "Аукционер Лика", zhCN = "拍卖师里卡", zhTW = "拍賣師里卡" },
    },
    {
        id = 4, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6146, y = 0.7264,
        name = { enUS = "Auctioneer Naxxremis", deDE = "Auktionator Naxxremis", esES = "Subastador Naxxremis", esMX = "Subastadora Naxxremis", frFR = "Commissaire-priseur Naxxremis", koKR = "경매인 낙스레미스", ptBR = "Leiloeira Naxxremis", ruRU = "Аукционер Наксремис", zhCN = "拍卖师纳克雷米斯", zhTW = "拍賣師納克雷米斯" },
    },
    {
        id = 5, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6064, y = 0.7494,
        name = { enUS = "Auctioneer Rhyker", deDE = "Auktionator Rhyker", esES = "Subastador Rhyker", esMX = "Subastadora Rhyker", frFR = "Commissaire-priseur Rhyker", koKR = "경매인 라이커", ptBR = "Leiloeira Rhyker", ruRU = "Аукционер Корт", zhCN = "拍卖师雷克尔", zhTW = "拍賣師雷克爾" },
    },
    {
        id = 6, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6297, y = 0.7498,
        name = { enUS = "Auctioneer Stockton", deDE = "Auktionator Stockton", esES = "Subastador Stockton", esMX = "Subastador Stockton", frFR = "Commissaire-priseur Stockton", koKR = "경매인 스톡튼", ptBR = "Leiloeiro Benevides", ruRU = "Аукционер Складник", zhCN = "拍卖师斯托克顿", zhTW = "拍賣師斯托克頓" },
    },
    {
        id = 7, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6064, y = 0.7392,
        name = { enUS = "Auctioneer Tricket", deDE = "Auktionator Tricket", esES = "Subastador Tricket", esMX = "Subastadora Tricket", frFR = "Commissaire-priseur Tricket", koKR = "경매인 트릭켓", ptBR = "Leiloeira Drica", ruRU = "Аукционер Трикет", zhCN = "拍卖师特里特", zhTW = "拍賣師特里特" },
    },
    {
        id = 8, types = { "auctioneer" },
        faction = "Horde", map = 1420, x = 0.6300, y = 0.7396,
        name = { enUS = "Auctioneer Yarly", deDE = "Auktionator Yarly", esES = "Subastador Yarly", esMX = "Subastador Yarly", frFR = "Commissaire-priseur Yarly", koKR = "경매인 얄리", ptBR = "Leiloeiro Marcelo", ruRU = "Аукционер Нуда", zhCN = "拍卖师亚尔利", zhTW = "拍賣師亞爾利" },
    },
    {
        id = 9, types = { "auctioneer" },
        faction = "Alliance", map = 1426, x = 0.5489, y = 0.3262,
        name = { enUS = "Auctioneer Buckler", deDE = "Auktionator Buckler", esES = "Subastador Buckler", esMX = "Subastador Buckler", frFR = "Commissaire-priseur Buckler", koKR = "경매인 버클러", ptBR = "Leiloeiro Broquel", ruRU = "Аукционер Щитос", zhCN = "拍卖师巴克尔", zhTW = "拍賣師巴克爾" },
    },
    {
        id = 10, types = { "auctioneer" },
        faction = "Alliance", map = 1426, x = 0.5522, y = 0.3323,
        name = { enUS = "Auctioneer Lympkin", deDE = "Auktionatorin Lympkin", esES = "Subastador Lympkin", esMX = "Subastadora Lympkin", frFR = "Commissaire-priseur Lympkin", koKR = "경매인 림프킨", ptBR = "Leiloeira Lympkin", ruRU = "Аукционер Лимпкин", zhCN = "拍卖师林姆克", zhTW = "拍賣師林姆克" },
    },
    {
        id = 11, types = { "auctioneer" },
        faction = "Alliance", map = 1426, x = 0.5495, y = 0.3306,
        name = { enUS = "Auctioneer Redmuse", deDE = "Auktionatorin Redmuse", esES = "Subastador Redmuse", esMX = "Subastadora Musarroja", frFR = "Commissaire-priseur Redmuse", koKR = "경매인 레드뮤즈", ptBR = "Leiloeira Belarruiva", ruRU = "Аукционер Краснушка", zhCN = "拍卖师雷姆斯", zhTW = "拍賣師雷姆斯" },
    },
    {
        id = 12, types = { "auctioneer" },
        faction = "Neutral", map = 1434, x = 0.2843, y = 0.7592,
        name = { enUS = "Auctioneer Graves", deDE = "Auktionator Graves", esES = "Subastador Graves", esMX = "Subastador Graves", frFR = "Commissaire-priseur Graves", koKR = "경매인 그레이브즈", ptBR = "Leiloeiro Graves", ruRU = "Аукционер Леонус", zhCN = "拍卖师格拉维斯", zhTW = "拍賣師格拉維斯" },
    },
    {
        id = 13, types = { "auctioneer" },
        faction = "Neutral", map = 1434, x = 0.2778, y = 0.7705,
        name = { enUS = "Auctioneer Kresky", deDE = "Auktionator Kresky", esES = "Subastador Kresky", esMX = "Subastador Kresky", frFR = "Commissaire-priseur Kresky", koKR = "경매인 크레스키", ptBR = "Leiloeiro Kresky", ruRU = "Аукционер Крески", zhCN = "拍卖师克雷斯克", zhTW = "拍賣師克雷斯克" },
    },
    {
        id = 14, types = { "auctioneer" },
        faction = "Neutral", map = 1434, x = 0.2659, y = 0.7636,
        name = { enUS = "Auctioneer O'reely", deDE = "Auktionator O'reely", esES = "Subastador O'reely", esMX = "Subastador O'reely", frFR = "Commissaire-priseur O'reely", koKR = "경매인 오릴리", ptBR = "Leiloeiro Essério", ruRU = "Аукционер Дану", zhCN = "拍卖师奥利雷", zhTW = "拍賣師奧利雷" },
    },
    {
        id = 15, types = { "auctioneer" },
        faction = "Neutral", map = 1446, x = 0.5196, y = 0.2964,
        name = { enUS = "Auctioneer Beardo", deDE = "Auktionator Beardo", esES = "Subastador Beardo", esMX = "Subastador Beardo", frFR = "Commissaire-priseur Beardo", koKR = "경매인 비어도", ptBR = "Leiloeiro Barbo", ruRU = "Аукционер Вихлюн", zhCN = "拍卖师比尔杜", zhTW = "拍賣師比爾杜" },
    },
    {
        id = 16, types = { "auctioneer" },
        faction = "Neutral", map = 1452, x = 0.6146, y = 0.3721,
        name = { enUS = "Auctioneer Grizzlin", deDE = "Auktionatorin Grizzlin", esES = "Subastadora Grizzlin", esMX = "Subastadora Grizzlin", frFR = "Commissaire-priseur Grizzlin", koKR = "경매인 그리즐린", ptBR = "Leiloeira Grizzlin", ruRU = "Аукционер Шумейкус", zhCN = "拍卖师格里兹林", zhTW = "拍賣師格里茲林" },
    },
    {
        id = 17, types = { "auctioneer" },
        faction = "Alliance", map = 1453, x = 0.6087, y = 0.7150,
        name = { enUS = "Auctioneer Chilton", deDE = "Auktionator Chilton", esES = "Subastador Chilton", esMX = "Subastador Chilton", frFR = "Commissaire-priseur Chilton", koKR = "경매인 칠톤", ptBR = "Leiloeiro Chilton", ruRU = "Аукционер Чилтон", zhCN = "拍卖师希尔顿", zhTW = "拍賣師希爾頓" },
    },
    {
        id = 18, types = { "auctioneer" },
        faction = "Alliance", map = 1453, x = 0.6118, y = 0.7127,
        name = { enUS = "Auctioneer Fitch", deDE = "Auktionator Fitch", esES = "Subastador Fitch", esMX = "Subastador Fitch", frFR = "Commissaire-priseur Fitch", koKR = "경매인 피치", ptBR = "Leiloeiro Fitch", ruRU = "Аукционер Фитч", zhCN = "拍卖师费奇", zhTW = "拍賣師費奇" },
    },
    {
        id = 19, types = { "auctioneer" },
        faction = "Alliance", map = 1453, x = 0.6118, y = 0.7069,
        name = { enUS = "Auctioneer Jaxon", deDE = "Auktionator Jaxon", esES = "Subastadora Jaxon", esMX = "Subastadora Jaxon", frFR = "Commissaire-priseur Jaxon", koKR = "경매인 잭손", ptBR = "Leiloeira Jasona", ruRU = "Аукционер Джаксон", zhCN = "拍卖师亚克森", zhTW = "拍賣師亞克森" },
    },
    {
        id = 20, types = { "auctioneer" },
        faction = "Horde", map = 1454, x = 0.5528, y = 0.6178,
        name = { enUS = "Auctioneer Grimful", deDE = "Auktionator Grimful", esES = "Subastador Grimful", esMX = "Subastador Grimful", frFR = "Commissaire-priseur Grimful", koKR = "경매인 그림풀", ptBR = "Leiloeiro Terripilante", ruRU = "Аукционер Мрачнус", zhCN = "拍卖师格里夫", zhTW = "拍賣師格里夫" },
    },
    {
        id = 21, types = { "auctioneer" },
        faction = "Horde", map = 1454, x = 0.5595, y = 0.6278,
        name = { enUS = "Auctioneer Thathung", deDE = "Auktionator Thathung", esES = "Subastador Thathung", esMX = "Subastador Thathung", frFR = "Commissaire-priseur Thathung", koKR = "경매인 타퉁", ptBR = "Leiloeiro Bendotado", ruRU = "Аукционер Скаботун", zhCN = "拍卖师萨苏恩", zhTW = "拍賣師薩蘇恩" },
    },
    {
        id = 22, types = { "auctioneer" },
        faction = "Horde", map = 1454, x = 0.5585, y = 0.6477,
        name = { enUS = "Auctioneer Wabang", deDE = "Auktionator Wabang", esES = "Subastador Wabang", esMX = "Subastador Wabang", frFR = "Commissaire-priseur Wabang", koKR = "경매인 와방", ptBR = "Leiloeiro Wabang", ruRU = "Аукционер Вабанг", zhCN = "拍卖师瓦巴恩", zhTW = "拍賣師瓦巴恩" },
    },
    {
        id = 23, types = { "auctioneer" },
        faction = "Horde", map = 1456, x = 0.3890, y = 0.5011,
        name = { enUS = "Auctioneer Gullem", deDE = "Auktionator Gullem", esES = "Subastador Gullem", esMX = "Subastador Gullem", frFR = "Commissaire-priseur Gullem", koKR = "경매인 굴렘", ptBR = "Leiloeiro Gullem", ruRU = "Аукционер Гуллем", zhCN = "拍卖师古雷姆", zhTW = "拍賣師古雷姆" },
    },
    {
        id = 24, types = { "auctioneer" },
        faction = "Horde", map = 1456, x = 0.4043, y = 0.5183,
        name = { enUS = "Auctioneer Stampi", deDE = "Auktionator Rikno Noragg", esES = "Subastador Stampi", esMX = "Subastador Stampi", frFR = "Commissaire-priseur Stampi", koKR = "경매인 샴피", ptBR = "Leiloeiro Stampi", ruRU = "Аукционер Штампи", zhCN = "拍卖师斯塔比", zhTW = "拍賣師斯塔比" },
    },
    {
        id = 25, types = { "auctioneer" },
        faction = "Alliance", map = 1457, x = 0.5553, y = 0.5247,
        name = { enUS = "Auctioneer Cazarez", deDE = "Auktionator Cazarez", esES = "Subastador Cazarez", esMX = "Subastador Cazarez", frFR = "Commissaire-priseur Cazarez", koKR = "경매인 카자레즈", ptBR = "Leiloeiro Castro", ruRU = "Аукционер Казарез", zhCN = "拍卖师卡扎雷兹", zhTW = "拍賣師卡札雷茲" },
    },
    {
        id = 26, types = { "auctioneer" },
        faction = "Alliance", map = 1457, x = 0.5629, y = 0.5398,
        name = { enUS = "Auctioneer Golothas", deDE = "Auktionator Golothas", esES = "Subastador Golothas", esMX = "Subastador Golothas", frFR = "Commissaire-priseur Golothas", koKR = "경매인 골로서스", ptBR = "Leiloeiro Golothas", ruRU = "Аукционер Голотас", zhCN = "拍卖师戈洛萨斯", zhTW = "拍賣師戈洛薩斯" },
    },
    {
        id = 27, types = { "auctioneer" },
        faction = "Alliance", map = 1457, x = 0.5729, y = 0.5361,
        name = { enUS = "Auctioneer Silva'las", deDE = "Auktionator Silva'las", esES = "Subastador Silva'las", esMX = "Subastador Silva'las", frFR = "Commissaire-priseur Silva'las", koKR = "경매인 실바라스", ptBR = "Leiloeiro Silva'las", ruRU = "Аукционер Сильва'лас", zhCN = "拍卖师塞尔瓦拉斯", zhTW = "拍賣師塞爾瓦拉斯" },
    },
    {
        id = 28, types = { "auctioneer" },
        faction = "Alliance", map = 1457, x = 0.5641, y = 0.5191,
        name = { enUS = "Auctioneer Tolon", deDE = "Auktionator Tolon", esES = "Subastador Tolon", esMX = "Subastador Tolon", frFR = "Commissaire-priseur Tolon", koKR = "경매인 톨론", ptBR = "Leiloeiro Dolon", ruRU = "Аукционер Толон", zhCN = "拍卖师图尔伦", zhTW = "拍賣師圖爾倫" },
    },
    {
        id = 29, types = { "auctioneer" },
        faction = "Neutral", map = 2521, x = 0.5791, y = 0.7712,
        name = { enUS = "Zelena Favorbreeze", deDE = "Zelena Favorbreeze", esES = "Zelena Favorbreeze", esMX = "Zelena Favorbreeze", frFR = "Zelena Favorbreeze", koKR = "Zelena Favorbreeze", ptBR = "Zelena Favorbreeze", ruRU = "Zelena Favorbreeze", zhCN = "Zelena Favorbreeze", zhTW = "Zelena Favorbreeze" },
    },
})
