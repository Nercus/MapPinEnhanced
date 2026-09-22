---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

---@type table<number, NavigationMountInfo>
local mountData = {
    [1] = { fly = true, ground = true },    -- Durotar
    [2] = { fly = false, ground = false },  -- Burning Blade Coven
    [3] = { fly = false, ground = false },  -- Tiragarde Keep
    [4] = { fly = false, ground = false },  -- Tiragarde Keep
    [5] = { fly = false, ground = false },  -- Skull Rock
    [6] = { fly = false, ground = false },  -- Dustwind Cave
    [7] = { fly = true, ground = true },    -- Mulgore
    [8] = { fly = false, ground = false },  -- Palemane Rock
    [9] = { fly = false, ground = false },  -- The Venture Co. Mine
    [10] = { fly = true, ground = true },   -- Northern Barrens
    [11] = { fly = false, ground = false }, -- Wailing Caverns
    [12] = { fly = false, ground = false }, -- Kalimdor
    [13] = { fly = false, ground = false }, -- Eastern Kingdoms
    [14] = { fly = true, ground = true },   -- Arathi Highlands
    [15] = { fly = true, ground = true },   -- Badlands
    [16] = { fly = false, ground = false }, -- Uldaman
    [17] = { fly = true, ground = true },   -- Blasted Lands
    [18] = { fly = true, ground = true },   -- Tirisfal Glades
    [19] = { fly = false, ground = false }, -- Scarlet Monastery Entrance
    [20] = { fly = false, ground = false }, -- Keeper's Rest
    [21] = { fly = true, ground = true },   -- Silverpine Forest
    [22] = { fly = true, ground = true },   -- Western Plaguelands
    [23] = { fly = true, ground = true },   -- Eastern Plaguelands
    [24] = { fly = false, ground = false }, -- Light's Hope Chapel
    [25] = { fly = true, ground = true },   -- Hillsbrad Foothills
    [26] = { fly = true, ground = true },   -- The Hinterlands
    [27] = { fly = true, ground = true },   -- Dun Morogh
    [28] = { fly = false, ground = false }, -- Coldridge Pass
    [29] = { fly = false, ground = false }, -- The Grizzled Den
    [30] = { fly = false, ground = false }, -- New Tinkertown
    [31] = { fly = false, ground = false }, -- Gol'Bolar Quarry
    [32] = { fly = true, ground = true },   -- Searing Gorge
    [33] = { fly = false, ground = false }, -- Blackrock Mountain
    [34] = { fly = false, ground = false }, -- Blackrock Mountain
    [35] = { fly = false, ground = false }, -- Blackrock Mountain
    [36] = { fly = true, ground = true },   -- Burning Steppes
    [37] = { fly = true, ground = true },   -- Elwynn Forest
    [38] = { fly = false, ground = false }, -- Fargodeep Mine
    [39] = { fly = false, ground = false }, -- Fargodeep Mine
    [40] = { fly = false, ground = false }, -- Jasperlode Mine
    [41] = { fly = false, ground = false }, -- Dalaran
    [42] = { fly = true, ground = true },   -- Deadwind Pass
    [43] = { fly = false, ground = false }, -- The Master's Cellar
    [44] = { fly = false, ground = false }, -- The Master's Cellar
    [45] = { fly = false, ground = false }, -- The Master's Cellar
    [46] = { fly = false, ground = false }, -- Karazhan Catacombs
    [47] = { fly = true, ground = true },   -- Duskwood
    [48] = { fly = true, ground = true },   -- Loch Modan
    [49] = { fly = true, ground = true },   -- Redridge Mountains
    [50] = { fly = true, ground = true },   -- Northern Stranglethorn
    [51] = { fly = true, ground = true },   -- Swamp of Sorrows
    [52] = { fly = true, ground = true },   -- Westfall
    [53] = { fly = false, ground = false }, -- Gold Coast Quarry
    [54] = { fly = false, ground = false }, -- Jangolode Mine
    [55] = { fly = false, ground = false }, -- The Deadmines
    [56] = { fly = true, ground = true },   -- Wetlands
    [57] = { fly = true, ground = true },   -- Teldrassil
    [58] = { fly = false, ground = false }, -- Shadowthread Cave
    [59] = { fly = false, ground = false }, -- Fel Rock
    [60] = { fly = false, ground = false }, -- Ban'ethil Barrow Den
    [61] = { fly = false, ground = false }, -- Ban'ethil Barrow Den
    [62] = { fly = true, ground = true },   -- Darkshore
    [63] = { fly = true, ground = true },   -- Ashenvale
    [64] = { fly = true, ground = true },   -- Thousand Needles
    [65] = { fly = true, ground = true },   -- Stonetalon Mountains
    [66] = { fly = true, ground = true },   -- Desolace
    [67] = { fly = false, ground = false }, -- Maraudon
    [68] = { fly = false, ground = false }, -- Maraudon
    [69] = { fly = true, ground = true },   -- Feralas
    [70] = { fly = true, ground = true },   -- Dustwallow Marsh
    [71] = { fly = true, ground = true },   -- Tanaris
    [72] = { fly = false, ground = false }, -- The Noxious Lair
    [73] = { fly = false, ground = false }, -- The Gaping Chasm
    [74] = { fly = false, ground = false }, -- Caverns of Time
    [75] = { fly = false, ground = false }, -- Caverns of Time
    [76] = { fly = true, ground = true },   -- Azshara
    [77] = { fly = true, ground = true },   -- Felwood
    [78] = { fly = true, ground = true },   -- Un'Goro Crater
    [79] = { fly = false, ground = false }, -- The Slithering Scar
    [80] = { fly = true, ground = true },   -- Moonglade
    [81] = { fly = true, ground = true },   -- Silithus
    [82] = { fly = false, ground = false }, -- Twilight's Run
    [83] = { fly = true, ground = true },   -- Winterspring
    [84] = { fly = true, ground = true },   -- Stormwind City
    [85] = { fly = true, ground = true },   -- Orgrimmar
    [86] = { fly = true, ground = true },   -- Orgrimmar
    [87] = { fly = true, ground = true },   -- Ironforge
    [88] = { fly = true, ground = true },   -- Thunder Bluff
    [89] = { fly = true, ground = true },   -- Darnassus
    [90] = { fly = true, ground = true },   -- Undercity
    [91] = { fly = false, ground = true },  -- Alterac Valley
    [92] = { fly = false, ground = true },  -- Warsong Gulch
    [93] = { fly = false, ground = true },  -- Arathi Basin
    [94] = { fly = false, ground = true },  -- Eversong Woods
    [95] = { fly = false, ground = true },  -- Ghostlands
    [96] = { fly = false, ground = false }, -- Amani Catacombs
    [97] = { fly = false, ground = true },  -- Azuremyst Isle
    [98] = { fly = false, ground = false }, -- Tides' Hollow
    [99] = { fly = false, ground = false }, -- Stillpine Hold
    [100] = { fly = true, ground = true },  -- Hellfire Peninsula
    [101] = { fly = false, ground = false }, -- Outland
    [102] = { fly = true, ground = true },  -- Zangarmarsh
    [103] = { fly = false, ground = true }, -- The Exodar
    [104] = { fly = true, ground = true },  -- Shadowmoon Valley
    [105] = { fly = true, ground = true },  -- Blade's Edge Mountains
    [106] = { fly = false, ground = true }, -- Bloodmyst Isle
    [107] = { fly = true, ground = true },  -- Nagrand
    [108] = { fly = true, ground = true },  -- Terokkar Forest
    [109] = { fly = true, ground = true },  -- Netherstorm
    [110] = { fly = false, ground = true }, -- Silvermoon City
    [111] = { fly = true, ground = true },  -- Shattrath City
    [112] = { fly = false, ground = true }, -- Eye of the Storm
    [113] = { fly = false, ground = false }, -- Northrend
    [114] = { fly = true, ground = true },  -- Borean Tundra
    [115] = { fly = true, ground = true },  -- Dragonblight
    [116] = { fly = true, ground = true },  -- Grizzly Hills
    [117] = { fly = true, ground = true },  -- Howling Fjord
    [118] = { fly = true, ground = true },  -- Icecrown
    [119] = { fly = true, ground = true },  -- Sholazar Basin
    [120] = { fly = true, ground = true },  -- The Storm Peaks
    [121] = { fly = true, ground = true },  -- Zul'Drak
    [122] = { fly = false, ground = true }, -- Isle of Quel'Danas
    [123] = { fly = false, ground = true }, -- Wintergrasp
    [124] = { fly = false, ground = true }, -- Plaguelands: The Scarlet Enclave
    [125] = { fly = false, ground = false }, -- Dalaran
    [126] = { fly = false, ground = false }, -- Dalaran
    [127] = { fly = true, ground = true },  -- Crystalsong Forest
    [128] = { fly = false, ground = true }, -- Strand of the Ancients
    [129] = { fly = false, ground = false }, -- The Nexus
    [130] = { fly = false, ground = true }, -- The Culling of Stratholme
    [131] = { fly = false, ground = false }, -- The Culling of Stratholme
    [132] = { fly = false, ground = false }, -- Ahn'kahet: The Old Kingdom
    [133] = { fly = false, ground = false }, -- Utgarde Keep
    [134] = { fly = false, ground = false }, -- Utgarde Keep
    [135] = { fly = false, ground = false }, -- Utgarde Keep
    [136] = { fly = false, ground = false }, -- Utgarde Pinnacle
    [137] = { fly = false, ground = false }, -- Utgarde Pinnacle
    [138] = { fly = false, ground = false }, -- Halls of Lightning
    [139] = { fly = false, ground = false }, -- Halls of Lightning
    [140] = { fly = false, ground = false }, -- Halls of Stone
    [141] = { fly = false, ground = false }, -- The Eye of Eternity
    [142] = { fly = false, ground = true }, -- The Oculus
    [143] = { fly = false, ground = false }, -- The Oculus
    [144] = { fly = false, ground = false }, -- The Oculus
    [145] = { fly = false, ground = false }, -- The Oculus
    [146] = { fly = false, ground = false }, -- The Oculus
    [147] = { fly = false, ground = true }, -- Ulduar
    [148] = { fly = false, ground = false }, -- Ulduar
    [149] = { fly = false, ground = false }, -- Ulduar
    [150] = { fly = false, ground = false }, -- Ulduar
    [151] = { fly = false, ground = false }, -- Ulduar
    [152] = { fly = false, ground = false }, -- Ulduar
    [153] = { fly = false, ground = true }, -- Gundrak
    [154] = { fly = false, ground = false }, -- Gundrak
    [155] = { fly = false, ground = true }, -- The Obsidian Sanctum
    [156] = { fly = false, ground = false }, -- Vault of Archavon
    [157] = { fly = false, ground = false }, -- Azjol-Nerub
    [158] = { fly = false, ground = false }, -- Azjol-Nerub
    [159] = { fly = false, ground = false }, -- Azjol-Nerub
    [160] = { fly = false, ground = false }, -- Drak'Tharon Keep
    [161] = { fly = false, ground = false }, -- Drak'Tharon Keep
    [162] = { fly = false, ground = false }, -- Naxxramas
    [163] = { fly = false, ground = false }, -- Naxxramas
    [164] = { fly = false, ground = false }, -- Naxxramas
    [165] = { fly = false, ground = false }, -- Naxxramas
    [166] = { fly = false, ground = false }, -- Naxxramas
    [167] = { fly = false, ground = false }, -- Naxxramas
    [168] = { fly = false, ground = false }, -- The Violet Hold
    [169] = { fly = false, ground = true }, -- Isle of Conquest
    [170] = { fly = true, ground = true },  -- Hrothgar's Landing
    [171] = { fly = false, ground = false }, -- Trial of the Champion
    [172] = { fly = false, ground = false }, -- Trial of the Crusader
    [173] = { fly = false, ground = false }, -- Trial of the Crusader
    [174] = { fly = false, ground = true }, -- The Lost Isles
    [175] = { fly = false, ground = false }, -- Kaja'mite Cavern
    [176] = { fly = false, ground = false }, -- Volcanoth's Lair
    [177] = { fly = false, ground = false }, -- Gallywix Labor Mine
    [178] = { fly = false, ground = false }, -- Gallywix Labor Mine
    [179] = { fly = false, ground = true }, -- Gilneas
    [180] = { fly = false, ground = false }, -- Emberstone Mine
    [181] = { fly = false, ground = false }, -- Greymane Manor
    [182] = { fly = false, ground = false }, -- Greymane Manor
    [183] = { fly = false, ground = false }, -- The Forge of Souls
    [184] = { fly = false, ground = true }, -- Pit of Saron
    [185] = { fly = false, ground = false }, -- Halls of Reflection
    [186] = { fly = false, ground = false }, -- Icecrown Citadel
    [187] = { fly = false, ground = false }, -- Icecrown Citadel
    [188] = { fly = false, ground = false }, -- Icecrown Citadel
    [189] = { fly = false, ground = false }, -- Icecrown Citadel
    [190] = { fly = false, ground = false }, -- Icecrown Citadel
    [191] = { fly = false, ground = false }, -- Icecrown Citadel
    [192] = { fly = false, ground = false }, -- Icecrown Citadel
    [193] = { fly = false, ground = false }, -- Icecrown Citadel
    [194] = { fly = false, ground = true }, -- Kezan
    [195] = { fly = false, ground = false }, -- Kaja'mine
    [196] = { fly = false, ground = false }, -- Kaja'mine
    [197] = { fly = false, ground = false }, -- Kaja'mine
    [198] = { fly = true, ground = true },  -- Mount Hyjal
    [199] = { fly = true, ground = true },  -- Southern Barrens
    [200] = { fly = false, ground = true }, -- The Ruby Sanctum
    [201] = { fly = true, ground = true },  -- Kelp'thar Forest
    [202] = { fly = false, ground = true }, -- Gilneas City
    [203] = { fly = true, ground = true },  -- Vashj'ir
    [204] = { fly = true, ground = true },  -- Abyssal Depths
    [205] = { fly = true, ground = true },  -- Shimmering Expanse
    [206] = { fly = false, ground = true }, -- Twin Peaks
    [207] = { fly = true, ground = true },  -- Deepholm
    [208] = { fly = false, ground = false }, -- Twilight Depths
    [209] = { fly = false, ground = false }, -- Twilight Depths
    [210] = { fly = true, ground = true },  -- The Cape of Stranglethorn
    [213] = { fly = false, ground = false }, -- Ragefire Chasm
    [217] = { fly = true, ground = true },  -- Ruins of Gilneas
    [218] = { fly = true, ground = true },  -- Ruins of Gilneas City
    [219] = { fly = false, ground = true }, -- Zul'Farrak
    [220] = { fly = false, ground = false }, -- The Temple of Atal'Hakkar
    [221] = { fly = false, ground = false }, -- Blackfathom Deeps
    [222] = { fly = false, ground = false }, -- Blackfathom Deeps
    [223] = { fly = false, ground = false }, -- Blackfathom Deeps
    [224] = { fly = false, ground = true }, -- Stranglethorn Vale
    [225] = { fly = false, ground = false }, -- The Stockade
    [226] = { fly = false, ground = false }, -- Gnomeregan
    [227] = { fly = false, ground = false }, -- Gnomeregan
    [228] = { fly = false, ground = false }, -- Gnomeregan
    [229] = { fly = false, ground = false }, -- Gnomeregan
    [230] = { fly = false, ground = false }, -- Uldaman
    [231] = { fly = false, ground = false }, -- Uldaman
    [232] = { fly = false, ground = false }, -- Molten Core
    [233] = { fly = false, ground = true }, -- Zul'Gurub
    [234] = { fly = true, ground = true },  -- Dire Maul
    [235] = { fly = false, ground = false }, -- Dire Maul
    [236] = { fly = false, ground = false }, -- Dire Maul
    [237] = { fly = false, ground = false }, -- Dire Maul
    [238] = { fly = false, ground = false }, -- Dire Maul
    [239] = { fly = false, ground = false }, -- Dire Maul
    [240] = { fly = false, ground = false }, -- Dire Maul
    [241] = { fly = true, ground = true },  -- Twilight Highlands
    [242] = { fly = false, ground = false }, -- Blackrock Depths
    [243] = { fly = false, ground = false }, -- Blackrock Depths
    [244] = { fly = false, ground = true }, -- Tol Barad
    [245] = { fly = false, ground = true }, -- Tol Barad Peninsula
    [246] = { fly = false, ground = false }, -- The Shattered Halls
    [247] = { fly = false, ground = true }, -- Ruins of Ahn'Qiraj
    [248] = { fly = false, ground = false }, -- Onyxia's Lair
    [249] = { fly = true, ground = true },  -- Uldum
    [250] = { fly = false, ground = false }, -- Blackrock Spire
    [251] = { fly = false, ground = false }, -- Blackrock Spire
    [252] = { fly = false, ground = false }, -- Blackrock Spire
    [253] = { fly = false, ground = false }, -- Blackrock Spire
    [254] = { fly = false, ground = false }, -- Blackrock Spire
    [255] = { fly = false, ground = false }, -- Blackrock Spire
    [256] = { fly = false, ground = false }, -- Auchenai Crypts
    [257] = { fly = false, ground = false }, -- Auchenai Crypts
    [258] = { fly = false, ground = false }, -- Sethekk Halls
    [259] = { fly = false, ground = false }, -- Sethekk Halls
    [260] = { fly = false, ground = false }, -- Shadow Labyrinth
    [261] = { fly = false, ground = false }, -- The Blood Furnace
    [262] = { fly = false, ground = false }, -- The Underbog
    [263] = { fly = false, ground = false }, -- The Steamvault
    [264] = { fly = false, ground = false }, -- The Steamvault
    [265] = { fly = false, ground = false }, -- The Slave Pens
    [266] = { fly = false, ground = false }, -- The Botanica
    [267] = { fly = false, ground = false }, -- The Mechanar
    [268] = { fly = false, ground = false }, -- The Mechanar
    [269] = { fly = false, ground = false }, -- The Arcatraz
    [270] = { fly = false, ground = false }, -- The Arcatraz
    [271] = { fly = false, ground = false }, -- The Arcatraz
    [272] = { fly = false, ground = false }, -- Mana-Tombs
    [273] = { fly = false, ground = true }, -- The Black Morass
    [274] = { fly = false, ground = true }, -- Old Hillsbrad Foothills
    [275] = { fly = false, ground = true }, -- The Battle for Gilneas
    [276] = { fly = false, ground = false }, -- The Maelstrom
    [277] = { fly = false, ground = true }, -- Lost City of the Tol'vir
    [279] = { fly = false, ground = false }, -- Wailing Caverns
    [280] = { fly = false, ground = false }, -- Maraudon
    [281] = { fly = false, ground = false }, -- Maraudon
    [282] = { fly = false, ground = false }, -- Baradin Hold
    [283] = { fly = false, ground = false }, -- Blackrock Caverns
    [284] = { fly = false, ground = false }, -- Blackrock Caverns
    [285] = { fly = false, ground = false }, -- Blackwing Descent
    [286] = { fly = false, ground = false }, -- Blackwing Descent
    [287] = { fly = false, ground = false }, -- Blackwing Lair
    [288] = { fly = false, ground = false }, -- Blackwing Lair
    [289] = { fly = false, ground = false }, -- Blackwing Lair
    [290] = { fly = false, ground = false }, -- Blackwing Lair
    [291] = { fly = false, ground = false }, -- The Deadmines
    [292] = { fly = false, ground = false }, -- The Deadmines
    [293] = { fly = false, ground = false }, -- Grim Batol
    [294] = { fly = false, ground = false }, -- The Bastion of Twilight
    [295] = { fly = false, ground = false }, -- The Bastion of Twilight
    [296] = { fly = false, ground = false }, -- The Bastion of Twilight
    [297] = { fly = false, ground = false }, -- Halls of Origination
    [298] = { fly = false, ground = false }, -- Halls of Origination
    [299] = { fly = false, ground = false }, -- Halls of Origination
    [300] = { fly = false, ground = false }, -- Razorfen Downs
    [301] = { fly = false, ground = false }, -- Razorfen Kraul
    [302] = { fly = false, ground = false }, -- Scarlet Monastery
    [303] = { fly = false, ground = false }, -- Scarlet Monastery
    [304] = { fly = false, ground = false }, -- Scarlet Monastery
    [305] = { fly = false, ground = false }, -- Scarlet Monastery
    [306] = { fly = false, ground = false }, -- Legacy of Scholomance
    [307] = { fly = false, ground = false }, -- Legacy of Scholomance
    [308] = { fly = false, ground = false }, -- Legacy of Scholomance
    [309] = { fly = false, ground = false }, -- Legacy of Scholomance
    [310] = { fly = false, ground = false }, -- Shadowfang Keep
    [311] = { fly = false, ground = false }, -- Shadowfang Keep
    [312] = { fly = false, ground = false }, -- Shadowfang Keep
    [313] = { fly = false, ground = false }, -- Shadowfang Keep
    [314] = { fly = false, ground = false }, -- Shadowfang Keep
    [315] = { fly = false, ground = false }, -- Shadowfang Keep
    [316] = { fly = false, ground = false }, -- Shadowfang Keep
    [317] = { fly = false, ground = false }, -- Stratholme
    [318] = { fly = false, ground = false }, -- Stratholme
    [319] = { fly = false, ground = false }, -- Ahn'Qiraj
    [320] = { fly = false, ground = false }, -- Ahn'Qiraj
    [321] = { fly = false, ground = false }, -- Ahn'Qiraj
    [322] = { fly = false, ground = false }, -- Throne of the Tides
    [323] = { fly = false, ground = false }, -- Throne of the Tides
    [324] = { fly = false, ground = false }, -- The Stonecore
    [325] = { fly = false, ground = false }, -- The Vortex Pinnacle
    [327] = { fly = true, ground = true },  -- Ahn'Qiraj: The Fallen Kingdom
    [328] = { fly = false, ground = false }, -- Throne of the Four Winds
    [329] = { fly = false, ground = true }, -- Hyjal Summit
    [330] = { fly = false, ground = false }, -- Gruul's Lair
    [331] = { fly = false, ground = false }, -- Magtheridon's Lair
    [332] = { fly = false, ground = false }, -- Serpentshrine Cavern
    [333] = { fly = false, ground = true }, -- Zul'Aman
    [334] = { fly = false, ground = false }, -- Tempest Keep
    [335] = { fly = false, ground = true }, -- Sunwell Plateau
    [336] = { fly = false, ground = false }, -- Sunwell Plateau
    [337] = { fly = false, ground = true }, -- Zul'Gurub
    [338] = { fly = false, ground = true }, -- Molten Front
    [339] = { fly = false, ground = true }, -- Black Temple
    [340] = { fly = false, ground = false }, -- Black Temple
    [341] = { fly = false, ground = false }, -- Black Temple
    [342] = { fly = false, ground = false }, -- Black Temple
    [343] = { fly = false, ground = false }, -- Black Temple
    [344] = { fly = false, ground = false }, -- Black Temple
    [345] = { fly = false, ground = false }, -- Black Temple
    [346] = { fly = false, ground = false }, -- Black Temple
    [347] = { fly = false, ground = false }, -- Hellfire Ramparts
    [348] = { fly = false, ground = false }, -- Magisters' Terrace
    [349] = { fly = false, ground = false }, -- Magisters' Terrace
    [350] = { fly = false, ground = false }, -- Karazhan
    [351] = { fly = false, ground = false }, -- Karazhan
    [352] = { fly = false, ground = false }, -- Karazhan
    [353] = { fly = false, ground = false }, -- Karazhan
    [354] = { fly = false, ground = false }, -- Karazhan
    [355] = { fly = false, ground = false }, -- Karazhan
    [356] = { fly = false, ground = false }, -- Karazhan
    [357] = { fly = false, ground = false }, -- Karazhan
    [358] = { fly = false, ground = false }, -- Karazhan
    [359] = { fly = false, ground = false }, -- Karazhan
    [360] = { fly = false, ground = false }, -- Karazhan
    [361] = { fly = false, ground = false }, -- Karazhan
    [362] = { fly = false, ground = false }, -- Karazhan
    [363] = { fly = false, ground = false }, -- Karazhan
    [364] = { fly = false, ground = false }, -- Karazhan
    [365] = { fly = false, ground = false }, -- Karazhan
    [366] = { fly = false, ground = false }, -- Karazhan
    [367] = { fly = false, ground = true }, -- Firelands
    [368] = { fly = false, ground = false }, -- Firelands
    [369] = { fly = false, ground = false }, -- Firelands
    [370] = { fly = false, ground = false }, -- The Nexus
    [371] = { fly = true, ground = true },  -- The Jade Forest
    [372] = { fly = false, ground = false }, -- Greenstone Quarry
    [373] = { fly = false, ground = false }, -- Greenstone Quarry
    [374] = { fly = false, ground = false }, -- The Widow's Wail
    [375] = { fly = false, ground = false }, -- Oona Kagu
    [376] = { fly = false, ground = true }, -- Valley of the Four Winds
    [377] = { fly = false, ground = false }, -- Cavern of Endless Echoes
    [378] = { fly = true, ground = true },  -- The Wandering Isle
    [379] = { fly = true, ground = true },  -- Kun-Lai Summit
    [380] = { fly = false, ground = false }, -- Howlingwind Cavern
    [381] = { fly = false, ground = false }, -- Pranksters' Hollow
    [382] = { fly = false, ground = false }, -- Knucklethump Hole
    [383] = { fly = false, ground = false }, -- The Deeper
    [384] = { fly = false, ground = false }, -- The Deeper
    [385] = { fly = false, ground = false }, -- Tomb of Conquerors
    [386] = { fly = false, ground = false }, -- Ruins of Korune
    [387] = { fly = false, ground = false }, -- Ruins of Korune
    [388] = { fly = true, ground = true },  -- Townlong Steppes
    [389] = { fly = false, ground = false }, -- Niuzao Temple
    [390] = { fly = true, ground = true },  -- Vale of Eternal Blossoms
    [391] = { fly = false, ground = false }, -- Shrine of Two Moons
    [392] = { fly = false, ground = false }, -- Shrine of Two Moons
    [393] = { fly = false, ground = false }, -- Shrine of Seven Stars
    [394] = { fly = false, ground = false }, -- Shrine of Seven Stars
    [395] = { fly = false, ground = false }, -- Guo-Lai Halls
    [396] = { fly = false, ground = false }, -- Guo-Lai Halls
    [397] = { fly = false, ground = true }, -- Eye of the Storm
    [398] = { fly = false, ground = true }, -- Well of Eternity
    [399] = { fly = false, ground = true }, -- Hour of Twilight
    [400] = { fly = false, ground = false }, -- Hour of Twilight
    [401] = { fly = false, ground = true }, -- End Time
    [402] = { fly = false, ground = false }, -- End Time
    [403] = { fly = false, ground = false }, -- End Time
    [404] = { fly = false, ground = false }, -- End Time
    [405] = { fly = false, ground = false }, -- End Time
    [406] = { fly = false, ground = false }, -- End Time
    [407] = { fly = false, ground = true }, -- Darkmoon Island
    [408] = { fly = false, ground = false }, -- Darkmoon Island
    [409] = { fly = false, ground = true }, -- Dragon Soul
    [410] = { fly = false, ground = false }, -- Dragon Soul
    [411] = { fly = false, ground = false }, -- Dragon Soul
    [412] = { fly = false, ground = false }, -- Dragon Soul
    [413] = { fly = false, ground = false }, -- Dragon Soul
    [414] = { fly = false, ground = false }, -- Dragon Soul
    [415] = { fly = false, ground = false }, -- Dragon Soul
    [416] = { fly = false, ground = true }, -- Dustwallow Marsh
    [417] = { fly = false, ground = true }, -- Temple of Kotmogu
    [418] = { fly = true, ground = true },  -- Krasarang Wilds
    [419] = { fly = false, ground = false }, -- Ruins of Ogudei
    [420] = { fly = false, ground = false }, -- Ruins of Ogudei
    [421] = { fly = false, ground = false }, -- Ruins of Ogudei
    [422] = { fly = true, ground = true },  -- Dread Wastes
    [423] = { fly = false, ground = false }, -- Silvershard Mines
    [424] = { fly = false, ground = false }, -- Pandaria
    [425] = { fly = true, ground = true },  -- Northshire
    [426] = { fly = false, ground = false }, -- Echo Ridge Mine
    [427] = { fly = true, ground = true },  -- Coldridge Valley
    [428] = { fly = false, ground = false }, -- Frostmane Hovel
    [429] = { fly = false, ground = false }, -- Temple of the Jade Serpent
    [430] = { fly = false, ground = false }, -- Temple of the Jade Serpent
    [431] = { fly = false, ground = false }, -- Scarlet Halls
    [432] = { fly = false, ground = false }, -- Scarlet Halls
    [433] = { fly = true, ground = true },  -- The Veiled Stair
    [434] = { fly = false, ground = false }, -- The Ancient Passage
    [435] = { fly = false, ground = false }, -- Scarlet Monastery
    [436] = { fly = false, ground = false }, -- Scarlet Monastery
    [437] = { fly = false, ground = false }, -- Gate of the Setting Sun
    [438] = { fly = false, ground = false }, -- Gate of the Setting Sun
    [439] = { fly = false, ground = false }, -- Stormstout Brewery
    [440] = { fly = false, ground = false }, -- Stormstout Brewery
    [441] = { fly = false, ground = false }, -- Stormstout Brewery
    [442] = { fly = false, ground = false }, -- Stormstout Brewery
    [443] = { fly = false, ground = true }, -- Shado-Pan Monastery
    [444] = { fly = false, ground = false }, -- Shado-Pan Monastery
    [445] = { fly = false, ground = false }, -- Shado-Pan Monastery
    [446] = { fly = false, ground = false }, -- Shado-Pan Monastery
    [447] = { fly = false, ground = true }, -- A Brewing Storm
    [448] = { fly = false, ground = true }, -- The Jade Forest
    [449] = { fly = false, ground = true }, -- Temple of Kotmogu
    [450] = { fly = false, ground = true }, -- Unga Ingoo
    [451] = { fly = false, ground = true }, -- Assault on Zan'vess
    [452] = { fly = false, ground = true }, -- Brewmoon Festival
    [453] = { fly = false, ground = false }, -- Mogu'shan Palace
    [454] = { fly = false, ground = false }, -- Mogu'shan Palace
    [455] = { fly = false, ground = false }, -- Mogu'shan Palace
    [456] = { fly = false, ground = true }, -- Terrace of Endless Spring
    [457] = { fly = false, ground = true }, -- Siege of Niuzao Temple
    [458] = { fly = false, ground = false }, -- Siege of Niuzao Temple
    [459] = { fly = false, ground = false }, -- Siege of Niuzao Temple
    [460] = { fly = true, ground = true },  -- Shadowglen
    [461] = { fly = true, ground = true },  -- Valley of Trials
    [462] = { fly = true, ground = true },  -- Camp Narache
    [463] = { fly = true, ground = true },  -- Echo Isles
    [464] = { fly = false, ground = false }, -- Spitescale Cavern
    [465] = { fly = true, ground = true },  -- Deathknell
    [466] = { fly = false, ground = false }, -- Night Web's Hollow
    [467] = { fly = true, ground = true },  -- Sunstrider Isle
    [468] = { fly = true, ground = true },  -- Ammen Vale
    [469] = { fly = true, ground = true },  -- New Tinkertown
    [470] = { fly = false, ground = false }, -- Frostmane Hold
    [471] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [472] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [473] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [474] = { fly = false, ground = false }, -- Heart of Fear
    [475] = { fly = false, ground = false }, -- Heart of Fear
    [476] = { fly = false, ground = false }, -- Scholomance
    [477] = { fly = false, ground = false }, -- Scholomance
    [478] = { fly = false, ground = false }, -- Scholomance
    [479] = { fly = false, ground = false }, -- Scholomance
    [480] = { fly = false, ground = false }, -- Proving Grounds
    [481] = { fly = false, ground = false }, -- Crypt of Forgotten Kings
    [482] = { fly = false, ground = false }, -- Crypt of Forgotten Kings
    [483] = { fly = false, ground = true }, -- Dustwallow Marsh
    [486] = { fly = false, ground = true }, -- Krasarang Wilds
    [487] = { fly = false, ground = true }, -- A Little Patience
    [488] = { fly = false, ground = true }, -- Dagger in the Dark
    [489] = { fly = false, ground = false }, -- Dagger in the Dark
    [490] = { fly = false, ground = true }, -- Black Temple
    [491] = { fly = false, ground = false }, -- Black Temple
    [492] = { fly = false, ground = false }, -- Black Temple
    [493] = { fly = false, ground = false }, -- Black Temple
    [494] = { fly = false, ground = false }, -- Black Temple
    [495] = { fly = false, ground = false }, -- Black Temple
    [496] = { fly = false, ground = false }, -- Black Temple
    [497] = { fly = false, ground = false }, -- Black Temple
    [498] = { fly = false, ground = true }, -- Krasarang Wilds
    [499] = { fly = false, ground = false }, -- Deeprun Tram
    [500] = { fly = false, ground = false }, -- Deeprun Tram
    [501] = { fly = false, ground = false }, -- Dalaran
    [502] = { fly = false, ground = false }, -- Dalaran
    [503] = { fly = false, ground = false }, -- Brawl'gar Arena
    [504] = { fly = false, ground = true }, -- Isle of Thunder
    [505] = { fly = false, ground = false }, -- Lightning Vein Mine
    [506] = { fly = false, ground = false }, -- The Swollen Vault
    [507] = { fly = false, ground = true }, -- Isle of Giants
    [508] = { fly = false, ground = false }, -- Throne of Thunder
    [509] = { fly = false, ground = false }, -- Throne of Thunder
    [510] = { fly = false, ground = false }, -- Throne of Thunder
    [511] = { fly = false, ground = false }, -- Throne of Thunder
    [512] = { fly = false, ground = false }, -- Throne of Thunder
    [513] = { fly = false, ground = false }, -- Throne of Thunder
    [514] = { fly = false, ground = false }, -- Throne of Thunder
    [515] = { fly = false, ground = false }, -- Throne of Thunder
    [516] = { fly = false, ground = true }, -- Isle of Thunder
    [517] = { fly = false, ground = false }, -- Lightning Vein Mine
    [518] = { fly = false, ground = false }, -- Thunder King's Citadel
    [519] = { fly = false, ground = true }, -- Deepwind Gorge
    [520] = { fly = false, ground = true }, -- Vale of Eternal Blossoms
    [521] = { fly = false, ground = false }, -- Vale of Eternal Blossoms
    [522] = { fly = false, ground = false }, -- The Secrets of Ragefire
    [523] = { fly = false, ground = true }, -- Dun Morogh
    [524] = { fly = false, ground = false }, -- Battle on the High Seas
    [525] = { fly = true, ground = true },  -- Frostfire Ridge
    [526] = { fly = false, ground = false }, -- Turgall's Den
    [527] = { fly = false, ground = false }, -- Turgall's Den
    [528] = { fly = false, ground = false }, -- Turgall's Den
    [529] = { fly = false, ground = false }, -- Turgall's Den
    [530] = { fly = false, ground = false }, -- Grom'gar
    [531] = { fly = false, ground = false }, -- Grulloc's Grotto
    [532] = { fly = false, ground = false }, -- Grulloc's Grotto
    [533] = { fly = false, ground = false }, -- Snowfall Alcove
    [534] = { fly = true, ground = true },  -- Tanaan Jungle
    [535] = { fly = true, ground = true },  -- Talador
    [536] = { fly = false, ground = false }, -- Tomb of Lights
    [537] = { fly = false, ground = false }, -- Tomb of Souls
    [538] = { fly = false, ground = false }, -- The Breached Ossuary
    [539] = { fly = true, ground = true },  -- Shadowmoon Valley
    [540] = { fly = false, ground = false }, -- Bloodthorn Cave
    [541] = { fly = false, ground = false }, -- Den of Secrets
    [542] = { fly = true, ground = true },  -- Spires of Arak
    [543] = { fly = true, ground = true },  -- Gorgrond
    [544] = { fly = false, ground = false }, -- Moira's Reach
    [545] = { fly = false, ground = false }, -- Moira's Reach
    [546] = { fly = false, ground = false }, -- Fissure of Fury
    [547] = { fly = false, ground = false }, -- Fissure of Fury
    [548] = { fly = false, ground = false }, -- Cragplume Cauldron
    [549] = { fly = false, ground = false }, -- Cragplume Cauldron
    [550] = { fly = true, ground = true },  -- Nagrand
    [551] = { fly = false, ground = false }, -- The Masters' Cavern
    [552] = { fly = false, ground = false }, -- Stonecrag Gorge
    [553] = { fly = false, ground = false }, -- Oshu'gun
    [554] = { fly = false, ground = true }, -- Timeless Isle
    [555] = { fly = false, ground = false }, -- Cavern of Lost Spirits
    [556] = { fly = false, ground = true }, -- Siege of Orgrimmar
    [557] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [558] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [559] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [560] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [561] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [562] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [563] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [564] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [565] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [566] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [567] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [568] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [569] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [570] = { fly = false, ground = false }, -- Siege of Orgrimmar
    [571] = { fly = false, ground = true }, -- Celestial Tournament
    [572] = { fly = false, ground = false }, -- Draenor
    [573] = { fly = false, ground = false }, -- Bloodmaul Slag Mines
    [574] = { fly = false, ground = false }, -- Shadowmoon Burial Grounds
    [575] = { fly = false, ground = false }, -- Shadowmoon Burial Grounds
    [576] = { fly = false, ground = false }, -- Shadowmoon Burial Grounds
    [577] = { fly = false, ground = true }, -- Tanaan Jungle
    [578] = { fly = false, ground = false }, -- Umbral Halls
    [579] = { fly = false, ground = false }, -- Lunarfall Excavation
    [580] = { fly = false, ground = false }, -- Lunarfall Excavation
    [581] = { fly = false, ground = false }, -- Lunarfall Excavation
    [582] = { fly = true, ground = true },  -- Lunarfall
    [585] = { fly = false, ground = false }, -- Frostwall Mine
    [586] = { fly = false, ground = false }, -- Frostwall Mine
    [587] = { fly = false, ground = false }, -- Frostwall Mine
    [588] = { fly = true, ground = true },  -- Ashran
    [589] = { fly = false, ground = false }, -- Ashran Mine
    [590] = { fly = true, ground = true },  -- Frostwall
    [593] = { fly = false, ground = false }, -- Auchindoun
    [594] = { fly = false, ground = true }, -- Shattrath City
    [595] = { fly = false, ground = false }, -- Iron Docks
    [596] = { fly = false, ground = false }, -- Blackrock Foundry
    [597] = { fly = false, ground = false }, -- Blackrock Foundry
    [598] = { fly = false, ground = false }, -- Blackrock Foundry
    [599] = { fly = false, ground = false }, -- Blackrock Foundry
    [600] = { fly = false, ground = false }, -- Blackrock Foundry
    [601] = { fly = false, ground = false }, -- Skyreach
    [602] = { fly = false, ground = false }, -- Skyreach
    [606] = { fly = false, ground = false }, -- Grimrail Depot
    [607] = { fly = false, ground = false }, -- Grimrail Depot
    [608] = { fly = false, ground = false }, -- Grimrail Depot
    [609] = { fly = false, ground = false }, -- Grimrail Depot
    [610] = { fly = false, ground = true }, -- Highmaul
    [611] = { fly = false, ground = false }, -- Highmaul
    [612] = { fly = false, ground = false }, -- Highmaul
    [613] = { fly = false, ground = false }, -- Highmaul
    [614] = { fly = false, ground = false }, -- Highmaul
    [615] = { fly = false, ground = false }, -- Highmaul
    [616] = { fly = false, ground = false }, -- Upper Blackrock Spire
    [617] = { fly = false, ground = false }, -- Upper Blackrock Spire
    [618] = { fly = false, ground = false }, -- Upper Blackrock Spire
    [619] = { fly = false, ground = false }, -- Broken Isles
    [620] = { fly = false, ground = true }, -- The Everbloom
    [621] = { fly = false, ground = false }, -- The Everbloom
    [622] = { fly = true, ground = true },  -- Stormshield
    [623] = { fly = false, ground = true }, -- Hillsbrad Foothills (Southshore vs. Tarren Mill)
    [624] = { fly = true, ground = true },  -- Warspear
    [626] = { fly = false, ground = false }, -- Dalaran
    [627] = { fly = false, ground = false }, -- Dalaran
    [628] = { fly = false, ground = false }, -- Dalaran
    [629] = { fly = false, ground = false }, -- Dalaran
    [630] = { fly = true, ground = true },  -- Azsuna
    [631] = { fly = false, ground = false }, -- Nar'thalas Academy
    [632] = { fly = false, ground = false }, -- Oceanus Cove
    [633] = { fly = false, ground = false }, -- Temple of a Thousand Lights
    [634] = { fly = true, ground = true },  -- Stormheim
    [635] = { fly = false, ground = false }, -- Shield's Rest
    [636] = { fly = false, ground = false }, -- Stormscale Cavern
    [637] = { fly = false, ground = false }, -- Thorignir Refuge
    [638] = { fly = false, ground = false }, -- Thorignir Refuge
    [639] = { fly = false, ground = false }, -- Aggramar's Vault
    [640] = { fly = false, ground = false }, -- Vault of Eyir
    [641] = { fly = true, ground = true },  -- Val'sharah
    [642] = { fly = false, ground = false }, -- Darkpens
    [643] = { fly = false, ground = false }, -- Sleeper's Barrow
    [644] = { fly = false, ground = false }, -- Sleeper's Barrow
    [645] = { fly = false, ground = false }, -- Twisting Nether
    [646] = { fly = true, ground = true },  -- Broken Shore
    [647] = { fly = false, ground = false }, -- Acherus: The Ebon Hold
    [648] = { fly = false, ground = false }, -- Acherus: The Ebon Hold
    [649] = { fly = true, ground = true },  -- Helheim
    [650] = { fly = true, ground = true },  -- Highmountain
    [651] = { fly = false, ground = false }, -- Bitestone Enclave
    [652] = { fly = false, ground = false }, -- Thunder Totem
    [653] = { fly = false, ground = false }, -- Cave of the Blood Trial
    [654] = { fly = false, ground = false }, -- Mucksnout Den
    [655] = { fly = false, ground = false }, -- Lifespring Cavern
    [656] = { fly = false, ground = false }, -- Lifespring Cavern
    [657] = { fly = false, ground = false }, -- Path of Huln
    [658] = { fly = false, ground = false }, -- Path of Huln
    [659] = { fly = false, ground = false }, -- Stonedark Grotto
    [660] = { fly = false, ground = false }, -- Feltotem Caverns
    [661] = { fly = false, ground = true }, -- Hellfire Citadel
    [662] = { fly = false, ground = false }, -- Hellfire Citadel
    [663] = { fly = false, ground = false }, -- Hellfire Citadel
    [664] = { fly = false, ground = false }, -- Hellfire Citadel
    [665] = { fly = false, ground = false }, -- Hellfire Citadel
    [666] = { fly = false, ground = false }, -- Hellfire Citadel
    [667] = { fly = false, ground = false }, -- Hellfire Citadel
    [668] = { fly = false, ground = false }, -- Hellfire Citadel
    [669] = { fly = false, ground = false }, -- Hellfire Citadel
    [670] = { fly = false, ground = false }, -- Hellfire Citadel
    [671] = { fly = true, ground = true },  -- The Cove of Nashal
    [672] = { fly = false, ground = true }, -- Mardum, the Shattered Abyss
    [673] = { fly = false, ground = false }, -- Cryptic Hollow
    [674] = { fly = false, ground = false }, -- Soul Engine
    [675] = { fly = false, ground = false }, -- Soul Engine
    [676] = { fly = true, ground = true },  -- Broken Shore
    [677] = { fly = false, ground = false }, -- Vault of the Wardens
    [678] = { fly = false, ground = false }, -- Vault of the Wardens
    [679] = { fly = false, ground = false }, -- Vault of the Wardens
    [680] = { fly = true, ground = true },  -- Suramar
    [681] = { fly = false, ground = false }, -- The Arcway Vaults
    [682] = { fly = false, ground = false }, -- Felsoul Hold
    [683] = { fly = false, ground = false }, -- The Arcway Vaults
    [684] = { fly = false, ground = false }, -- Shattered Locus
    [685] = { fly = false, ground = false }, -- Shattered Locus
    [686] = { fly = false, ground = false }, -- Elor'shan
    [687] = { fly = false, ground = false }, -- Kel'balor
    [688] = { fly = false, ground = false }, -- Ley Station Anora
    [689] = { fly = false, ground = false }, -- Ley Station Moonfall
    [690] = { fly = false, ground = false }, -- Ley Station Aethenar
    [691] = { fly = false, ground = false }, -- Nyell's Workshop
    [692] = { fly = false, ground = false }, -- Falanaar Arcway
    [693] = { fly = false, ground = false }, -- Falanaar Arcway
    [694] = { fly = false, ground = true }, -- Helmouth Shallows
    [695] = { fly = false, ground = false }, -- Skyhold
    [696] = { fly = true, ground = true },  -- Stormheim
    [697] = { fly = false, ground = true }, -- Azshara
    [698] = { fly = false, ground = false }, -- Icecrown Citadel
    [699] = { fly = false, ground = false }, -- Icecrown Citadel
    [700] = { fly = false, ground = false }, -- Icecrown Citadel
    [701] = { fly = false, ground = false }, -- Icecrown Citadel
    [702] = { fly = false, ground = false }, -- Netherlight Temple
    [703] = { fly = false, ground = false }, -- Halls of Valor
    [704] = { fly = false, ground = false }, -- Halls of Valor
    [705] = { fly = false, ground = false }, -- Halls of Valor
    [706] = { fly = false, ground = true }, -- Helmouth Cliffs
    [707] = { fly = false, ground = false }, -- Helmouth Cliffs
    [708] = { fly = false, ground = false }, -- Helmouth Cliffs
    [709] = { fly = true, ground = true },  -- The Wandering Isle
    [710] = { fly = false, ground = false }, -- Vault of the Wardens
    [711] = { fly = false, ground = false }, -- Vault of the Wardens
    [712] = { fly = false, ground = false }, -- Vault of the Wardens
    [713] = { fly = false, ground = true }, -- Eye of Azshara
    [714] = { fly = false, ground = true }, -- Niskara
    [715] = { fly = false, ground = true }, -- Emerald Dreamway
    [716] = { fly = false, ground = false }, -- Skywall
    [717] = { fly = true, ground = true },  -- Dreadscar Rift
    [718] = { fly = false, ground = false }, -- Dreadscar Rift
    [719] = { fly = true, ground = true },  -- Mardum, the Shattered Abyss
    [720] = { fly = false, ground = false }, -- Mardum, the Shattered Abyss
    [721] = { fly = false, ground = false }, -- Mardum, the Shattered Abyss
    [723] = { fly = false, ground = false }, -- The Violet Hold
    [725] = { fly = false, ground = true }, -- The Maelstrom
    [726] = { fly = true, ground = true },  -- The Maelstrom
    [728] = { fly = false, ground = false }, -- Terrace of Endless Spring
    [729] = { fly = false, ground = false }, -- Crumbling Depths
    [731] = { fly = false, ground = true }, -- Neltharion's Lair
    [732] = { fly = false, ground = false }, -- Violet Hold
    [733] = { fly = false, ground = true }, -- Darkheart Thicket
    [734] = { fly = false, ground = false }, -- Hall of the Guardian
    [735] = { fly = false, ground = false }, -- Hall of the Guardian
    [736] = { fly = false, ground = false }, -- The Beyond
    [737] = { fly = false, ground = false }, -- The Vortex Pinnacle
    [738] = { fly = true, ground = true },  -- Firelands
    [739] = { fly = true, ground = true },  -- Trueshot Lodge
    [740] = { fly = false, ground = false }, -- Shadowgore Citadel
    [741] = { fly = false, ground = false }, -- Shadowgore Citadel
    [742] = { fly = false, ground = false }, -- Abyssal Maw
    [743] = { fly = false, ground = false }, -- Abyssal Maw
    [744] = { fly = false, ground = false }, -- Ulduar
    [745] = { fly = false, ground = false }, -- Ulduar
    [746] = { fly = false, ground = false }, -- Ulduar
    [747] = { fly = true, ground = true },  -- The Dreamgrove
    [748] = { fly = true, ground = true },  -- Niskara
    [749] = { fly = false, ground = false }, -- The Arcway
    [750] = { fly = true, ground = true },  -- Thunder Totem
    [751] = { fly = false, ground = false }, -- Black Rook Hold
    [752] = { fly = false, ground = false }, -- Black Rook Hold
    [753] = { fly = false, ground = false }, -- Black Rook Hold
    [754] = { fly = false, ground = false }, -- Black Rook Hold
    [755] = { fly = false, ground = false }, -- Black Rook Hold
    [756] = { fly = false, ground = false }, -- Black Rook Hold
    [757] = { fly = false, ground = true }, -- Ursoc's Lair
    [758] = { fly = true, ground = true },  -- Gloaming Reef
    [759] = { fly = false, ground = false }, -- Black Temple
    [760] = { fly = true, ground = true },  -- Malorne's Nightmare
    [761] = { fly = false, ground = true }, -- Court of Stars
    [762] = { fly = false, ground = false }, -- Court of Stars
    [763] = { fly = false, ground = false }, -- Court of Stars
    [764] = { fly = false, ground = false }, -- The Nighthold
    [765] = { fly = false, ground = false }, -- The Nighthold
    [766] = { fly = false, ground = false }, -- The Nighthold
    [767] = { fly = false, ground = false }, -- The Nighthold
    [768] = { fly = false, ground = false }, -- The Nighthold
    [769] = { fly = false, ground = false }, -- The Nighthold
    [770] = { fly = false, ground = false }, -- The Nighthold
    [771] = { fly = false, ground = false }, -- The Nighthold
    [772] = { fly = false, ground = false }, -- The Nighthold
    [773] = { fly = false, ground = true }, -- Tol Barad
    [774] = { fly = false, ground = false }, -- Tol Barad
    [775] = { fly = false, ground = true }, -- The Exodar
    [776] = { fly = false, ground = true }, -- Azuremyst Isle
    [777] = { fly = false, ground = false }, -- The Emerald Nightmare
    [778] = { fly = false, ground = false }, -- The Emerald Nightmare
    [779] = { fly = false, ground = false }, -- The Emerald Nightmare
    [780] = { fly = false, ground = false }, -- The Emerald Nightmare
    [781] = { fly = false, ground = false }, -- The Emerald Nightmare
    [782] = { fly = false, ground = false }, -- The Emerald Nightmare
    [783] = { fly = false, ground = false }, -- The Emerald Nightmare
    [784] = { fly = false, ground = false }, -- The Emerald Nightmare
    [785] = { fly = false, ground = false }, -- The Emerald Nightmare
    [786] = { fly = false, ground = false }, -- The Emerald Nightmare
    [787] = { fly = false, ground = false }, -- The Emerald Nightmare
    [788] = { fly = false, ground = false }, -- The Emerald Nightmare
    [789] = { fly = false, ground = false }, -- The Emerald Nightmare
    [790] = { fly = true, ground = true },  -- Eye of Azshara
    [791] = { fly = false, ground = false }, -- Temple of the Jade Serpent
    [792] = { fly = false, ground = false }, -- Temple of the Jade Serpent
    [793] = { fly = false, ground = true }, -- Black Rook Hold
    [794] = { fly = false, ground = false }, -- Karazhan
    [795] = { fly = false, ground = false }, -- Karazhan
    [796] = { fly = false, ground = false }, -- Karazhan
    [797] = { fly = false, ground = false }, -- Karazhan
    [798] = { fly = false, ground = false }, -- The Arcway
    [799] = { fly = false, ground = true }, -- The Oculus
    [800] = { fly = false, ground = false }, -- The Oculus
    [801] = { fly = false, ground = false }, -- The Oculus
    [802] = { fly = false, ground = false }, -- The Oculus
    [803] = { fly = false, ground = false }, -- The Oculus
    [804] = { fly = false, ground = false }, -- Scarlet Monastery
    [805] = { fly = false, ground = false }, -- Scarlet Monastery
    [806] = { fly = false, ground = true }, -- Trial of Valor
    [807] = { fly = false, ground = false }, -- Trial of Valor
    [808] = { fly = false, ground = false }, -- Trial of Valor
    [809] = { fly = false, ground = false }, -- Karazhan
    [810] = { fly = false, ground = false }, -- Karazhan
    [811] = { fly = false, ground = false }, -- Karazhan
    [812] = { fly = false, ground = false }, -- Karazhan
    [813] = { fly = false, ground = false }, -- Karazhan
    [814] = { fly = false, ground = false }, -- Karazhan
    [815] = { fly = false, ground = false }, -- Karazhan
    [816] = { fly = false, ground = false }, -- Karazhan
    [817] = { fly = false, ground = false }, -- Karazhan
    [818] = { fly = false, ground = false }, -- Karazhan
    [819] = { fly = false, ground = false }, -- Karazhan
    [820] = { fly = false, ground = false }, -- Karazhan
    [821] = { fly = false, ground = false }, -- Karazhan
    [822] = { fly = false, ground = false }, -- Karazhan
    [823] = { fly = false, ground = true }, -- Pit of Saron
    [824] = { fly = true, ground = true },  -- Islands
    [825] = { fly = false, ground = false }, -- Wailing Caverns
    [826] = { fly = false, ground = false }, -- Cave of the Bloodtotem
    [827] = { fly = false, ground = false }, -- Stratholme
    [828] = { fly = false, ground = false }, -- The Eye of Eternity
    [829] = { fly = false, ground = false }, -- Halls of Valor
    [830] = { fly = false, ground = false }, -- Krokuun
    [831] = { fly = false, ground = false }, -- The Vindicaar
    [832] = { fly = false, ground = false }, -- The Vindicaar
    [833] = { fly = false, ground = false }, -- Nath'raxas Spire
    [834] = { fly = true, ground = true },  -- Coldridge Valley
    [835] = { fly = false, ground = false }, -- The Deadmines
    [836] = { fly = false, ground = false }, -- The Deadmines
    [837] = { fly = false, ground = true }, -- Arathi Basin
    [838] = { fly = false, ground = false }, -- Battle for Blackrock Mountain
    [839] = { fly = false, ground = false }, -- The Maelstrom
    [840] = { fly = false, ground = false }, -- Gnomeregan
    [841] = { fly = false, ground = false }, -- Gnomeregan
    [842] = { fly = false, ground = false }, -- Gnomeregan
    [843] = { fly = false, ground = true }, -- Shado-Pan Showdown
    [844] = { fly = false, ground = true }, -- Arathi Basin
    [845] = { fly = false, ground = false }, -- Cathedral of Eternal Night
    [846] = { fly = false, ground = false }, -- Cathedral of Eternal Night
    [847] = { fly = false, ground = false }, -- Cathedral of Eternal Night
    [848] = { fly = false, ground = false }, -- Cathedral of Eternal Night
    [849] = { fly = false, ground = false }, -- Cathedral of Eternal Night
    [850] = { fly = false, ground = false }, -- Tomb of Sargeras
    [851] = { fly = false, ground = false }, -- Tomb of Sargeras
    [852] = { fly = false, ground = false }, -- Tomb of Sargeras
    [853] = { fly = false, ground = false }, -- Tomb of Sargeras
    [854] = { fly = false, ground = false }, -- Tomb of Sargeras
    [855] = { fly = false, ground = false }, -- Tomb of Sargeras
    [856] = { fly = false, ground = false }, -- Tomb of Sargeras
    [857] = { fly = false, ground = false }, -- Throne of the Four Winds
    [858] = { fly = false, ground = true }, -- Assault on Broken Shore
    [859] = { fly = false, ground = true }, -- Warsong Gulch
    [860] = { fly = false, ground = true }, -- The Ruby Sanctum
    [861] = { fly = false, ground = true }, -- Mardum, the Shattered Abyss
    [862] = { fly = true, ground = true },  -- Zuldazar
    [863] = { fly = true, ground = true },  -- Nazmir
    [864] = { fly = true, ground = true },  -- Vol'dun
    [865] = { fly = false, ground = false }, -- Stormheim
    [866] = { fly = false, ground = false }, -- Stormheim
    [867] = { fly = false, ground = false }, -- Azsuna
    [868] = { fly = false, ground = false }, -- Val'sharah
    [869] = { fly = false, ground = false }, -- Highmountain
    [870] = { fly = false, ground = false }, -- Highmountain
    [871] = { fly = false, ground = false }, -- The Lost Glacier
    [872] = { fly = false, ground = false }, -- Stormstout Brewery
    [873] = { fly = false, ground = false }, -- Stormstout Brewery
    [874] = { fly = false, ground = false }, -- Stormstout Brewery
    [875] = { fly = false, ground = false }, -- Zandalar
    [876] = { fly = false, ground = false }, -- Kul Tiras
    [877] = { fly = false, ground = true }, -- Fields of the Eternal Hunt
    [879] = { fly = false, ground = false }, -- Mardum, the Shattered Abyss
    [880] = { fly = false, ground = false }, -- Mardum, the Shattered Abyss
    [881] = { fly = false, ground = false }, -- The Eye of Eternity
    [882] = { fly = false, ground = false }, -- Eredath
    [883] = { fly = false, ground = false }, -- The Vindicaar
    [884] = { fly = false, ground = false }, -- The Vindicaar
    [885] = { fly = false, ground = false }, -- Antoran Wastes
    [886] = { fly = false, ground = false }, -- The Vindicaar
    [887] = { fly = false, ground = false }, -- The Vindicaar
    [888] = { fly = false, ground = false }, -- Hall of Communion
    [889] = { fly = false, ground = false }, -- Arcatraz
    [890] = { fly = false, ground = false }, -- Arcatraz
    [891] = { fly = true, ground = true },  -- Azuremyst Isle
    [892] = { fly = false, ground = false }, -- Azuremyst Isle
    [893] = { fly = false, ground = false }, -- Azuremyst Isle
    [894] = { fly = false, ground = false }, -- Azuremyst Isle
    [895] = { fly = true, ground = true },  -- Tiragarde Sound
    [896] = { fly = true, ground = true },  -- Drustvar
    [897] = { fly = true, ground = true },  -- The Deaths of Chromie
    [898] = { fly = false, ground = false }, -- The Deaths of Chromie
    [899] = { fly = false, ground = false }, -- The Deaths of Chromie
    [900] = { fly = false, ground = false }, -- The Deaths of Chromie
    [901] = { fly = false, ground = false }, -- The Deaths of Chromie
    [902] = { fly = false, ground = false }, -- The Deaths of Chromie
    [903] = { fly = false, ground = true }, -- The Seat of the Triumvirate
    [904] = { fly = false, ground = true }, -- Silithus Brawl
    [906] = { fly = false, ground = true }, -- Arathi Highlands
    [907] = { fly = false, ground = true }, -- Seething Shore
    [908] = { fly = true, ground = true },  -- Ruins of Lordaeron
    [909] = { fly = false, ground = true }, -- Antorus, the Burning Throne
    [910] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [911] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [912] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [913] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [914] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [915] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [916] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [917] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [918] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [919] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [920] = { fly = false, ground = false }, -- Antorus, the Burning Throne
    [921] = { fly = false, ground = true }, -- Invasion Point: Aurinor
    [922] = { fly = false, ground = true }, -- Invasion Point: Bonich
    [923] = { fly = false, ground = true }, -- Invasion Point: Cen'gar
    [924] = { fly = false, ground = true }, -- Invasion Point: Naigtal
    [925] = { fly = false, ground = true }, -- Invasion Point: Sangua
    [926] = { fly = false, ground = true }, -- Invasion Point: Val
    [927] = { fly = false, ground = true }, -- Greater Invasion Point: Pit Lord Vilemus
    [928] = { fly = false, ground = true }, -- Greater Invasion Point: Mistress Alluradel
    [929] = { fly = true, ground = true },  -- Greater Invasion Point: Matron Folnuna
    [930] = { fly = false, ground = true }, -- Greater Invasion Point: Inquisitor Meto
    [931] = { fly = false, ground = true }, -- Greater Invasion Point: Sotanathor
    [932] = { fly = false, ground = true }, -- Greater Invasion Point: Occularus
    [933] = { fly = false, ground = false }, -- Forge of Aeons
    [934] = { fly = false, ground = false }, -- Atal'Dazar
    [935] = { fly = false, ground = false }, -- Atal'Dazar
    [936] = { fly = false, ground = true }, -- Freehold
    [938] = { fly = true, ground = true },  -- Gilneas Island
    [939] = { fly = true, ground = true },  -- Tropical Isle 8.0
    [940] = { fly = false, ground = false }, -- The Vindicaar
    [941] = { fly = false, ground = false }, -- The Vindicaar
    [942] = { fly = true, ground = true },  -- Stormsong Valley
    [943] = { fly = false, ground = false }, -- Arathi Highlands
    [947] = { fly = false, ground = false }, -- Azeroth
    [971] = { fly = false, ground = true }, -- Telogrus Rift
    [972] = { fly = true, ground = true },  -- Telogrus Rift
    [973] = { fly = false, ground = false }, -- The Sunwell
    [974] = { fly = false, ground = true }, -- Tol Dagor
    [975] = { fly = false, ground = false }, -- Tol Dagor
    [976] = { fly = false, ground = false }, -- Tol Dagor
    [977] = { fly = false, ground = false }, -- Tol Dagor
    [978] = { fly = false, ground = false }, -- Tol Dagor
    [979] = { fly = false, ground = false }, -- Tol Dagor
    [980] = { fly = false, ground = false }, -- Tol Dagor
    [981] = { fly = true, ground = true },  -- Un'gol Ruins
    [985] = { fly = false, ground = false }, -- Eastern Kingdoms
    [986] = { fly = false, ground = false }, -- Kalimdor
    [987] = { fly = false, ground = false }, -- Outland
    [988] = { fly = false, ground = false }, -- Northrend
    [989] = { fly = false, ground = false }, -- Pandaria
    [990] = { fly = false, ground = false }, -- Draenor
    [991] = { fly = false, ground = false }, -- Zandalar
    [992] = { fly = false, ground = false }, -- Kul Tiras
    [993] = { fly = false, ground = false }, -- Broken Isles
    [994] = { fly = false, ground = false }, -- Argus
    [998] = { fly = false, ground = false }, -- Undercity
    [1004] = { fly = false, ground = false }, -- Kings' Rest
    [1009] = { fly = false, ground = false }, -- Atul'Aman
    [1010] = { fly = false, ground = true }, -- The MOTHERLODE!!
    [1011] = { fly = false, ground = false }, -- Zandalar
    [1012] = { fly = false, ground = false }, -- Stormwind City
    [1013] = { fly = false, ground = false }, -- The Stockade
    [1014] = { fly = false, ground = false }, -- Kul Tiras
    [1015] = { fly = false, ground = false }, -- Waycrest Manor
    [1016] = { fly = false, ground = false }, -- Waycrest Manor
    [1017] = { fly = false, ground = false }, -- Waycrest Manor
    [1018] = { fly = false, ground = false }, -- Waycrest Manor
    [1021] = { fly = false, ground = false }, -- Chamber of Heart
    [1022] = { fly = false, ground = true }, -- Uncharted Island
    [1029] = { fly = false, ground = false }, -- Waycrest Manor
    [1030] = { fly = false, ground = false }, -- Greymane Manor
    [1031] = { fly = false, ground = false }, -- Greymane Manor
    [1032] = { fly = true, ground = true }, -- Skittering Hollow
    [1033] = { fly = true, ground = true }, -- The Rotting Mire
    [1034] = { fly = true, ground = true }, -- Verdant Wilds
    [1035] = { fly = true, ground = true }, -- Molten Cay
    [1036] = { fly = true, ground = true }, -- The Dread Chain
    [1037] = { fly = true, ground = true }, -- Whispering Reef
    [1038] = { fly = false, ground = false }, -- Temple of Sethraliss
    [1039] = { fly = false, ground = true }, -- Shrine of the Storm
    [1040] = { fly = false, ground = false }, -- Shrine of the Storm
    [1041] = { fly = false, ground = true }, -- The Underrot
    [1042] = { fly = false, ground = false }, -- The Underrot
    [1043] = { fly = false, ground = false }, -- Temple of Sethraliss
    [1044] = { fly = false, ground = false }, -- Arathi Highlands
    [1045] = { fly = false, ground = false }, -- Thros, The Blighted Lands
    [1148] = { fly = false, ground = false }, -- Uldir
    [1149] = { fly = false, ground = false }, -- Uldir
    [1150] = { fly = false, ground = false }, -- Uldir
    [1151] = { fly = false, ground = false }, -- Uldir
    [1152] = { fly = false, ground = false }, -- Uldir
    [1153] = { fly = false, ground = false }, -- Uldir
    [1154] = { fly = false, ground = false }, -- Uldir
    [1155] = { fly = false, ground = false }, -- Uldir
    [1156] = { fly = false, ground = true }, -- The Great Sea
    [1157] = { fly = false, ground = true }, -- The Great Sea
    [1159] = { fly = false, ground = false }, -- Blackrock Depths
    [1160] = { fly = false, ground = false }, -- Blackrock Depths
    [1161] = { fly = true, ground = true }, -- Boralus
    [1162] = { fly = false, ground = true }, -- Siege of Boralus
    [1163] = { fly = false, ground = false }, -- Dazar'alor
    [1164] = { fly = false, ground = false }, -- Dazar'alor
    [1165] = { fly = true, ground = true }, -- Dazar'alor
    [1166] = { fly = false, ground = false }, -- Zanchul
    [1167] = { fly = false, ground = false }, -- Zanchul
    [1169] = { fly = true, ground = true }, -- Tol Dagor
    [1170] = { fly = false, ground = false }, -- Gorgrond - Mag'har Scenario
    [1171] = { fly = false, ground = false }, -- Gol Thovas
    [1172] = { fly = false, ground = false }, -- Gol Thovas
    [1173] = { fly = false, ground = false }, -- Rastakhan's Might
    [1174] = { fly = false, ground = false }, -- Rastakhan's Might
    [1176] = { fly = false, ground = false }, -- Breath Of Pa'ku
    [1177] = { fly = false, ground = false }, -- Breath Of Pa'ku
    [1179] = { fly = false, ground = false }, -- Abyssal Melody
    [1180] = { fly = false, ground = false }, -- Abyssal Melody
    [1181] = { fly = true, ground = true }, -- Zuldazar
    [1182] = { fly = false, ground = false }, -- Saltstone Mine
    [1183] = { fly = false, ground = false }, -- Thornheart
    [1184] = { fly = false, ground = false }, -- Winterchill Mine
    [1185] = { fly = false, ground = false }, -- Winterchill Mine
    [1186] = { fly = false, ground = false }, -- Blackrock Depths
    [1187] = { fly = true, ground = true }, -- Azsuna
    [1188] = { fly = true, ground = true }, -- Val'sharah
    [1189] = { fly = true, ground = true }, -- Highmountain
    [1190] = { fly = true, ground = true }, -- Stormheim
    [1191] = { fly = true, ground = true }, -- Suramar
    [1192] = { fly = true, ground = true }, -- Broken Shore
    [1193] = { fly = true, ground = true }, -- Zuldazar
    [1194] = { fly = true, ground = true }, -- Nazmir
    [1195] = { fly = true, ground = true }, -- Vol'dun
    [1196] = { fly = true, ground = true }, -- Tiragarde Sound
    [1197] = { fly = true, ground = true }, -- Drustvar
    [1198] = { fly = true, ground = true }, -- Stormsong Valley
    [1203] = { fly = false, ground = true }, -- Darkshore
    [1208] = { fly = false, ground = false }, -- Eastern Kingdoms
    [1209] = { fly = false, ground = false }, -- Kalimdor
    [1244] = { fly = true, ground = true }, -- Arathi Highlands
    [1245] = { fly = true, ground = true }, -- Badlands
    [1246] = { fly = true, ground = true }, -- Blasted Lands
    [1247] = { fly = true, ground = true }, -- Tirisfal Glades
    [1248] = { fly = true, ground = true }, -- Silverpine Forest
    [1249] = { fly = true, ground = true }, -- Western Plaguelands
    [1250] = { fly = true, ground = true }, -- Eastern Plaguelands
    [1251] = { fly = true, ground = true }, -- Hillsbrad Foothills
    [1252] = { fly = true, ground = true }, -- The Hinterlands
    [1253] = { fly = true, ground = true }, -- Dun Morogh
    [1254] = { fly = true, ground = true }, -- Searing Gorge
    [1255] = { fly = true, ground = true }, -- Burning Steppes
    [1256] = { fly = true, ground = true }, -- Elwynn Forest
    [1257] = { fly = true, ground = true }, -- Deadwind Pass
    [1258] = { fly = true, ground = true }, -- Duskwood
    [1259] = { fly = true, ground = true }, -- Loch Modan
    [1260] = { fly = true, ground = true }, -- Redridge Mountains
    [1261] = { fly = true, ground = true }, -- Swamp of Sorrows
    [1262] = { fly = true, ground = true }, -- Westfall
    [1263] = { fly = true, ground = true }, -- Wetlands
    [1264] = { fly = true, ground = true }, -- Stormwind City
    [1265] = { fly = true, ground = true }, -- Ironforge
    [1266] = { fly = true, ground = true }, -- Undercity
    [1267] = { fly = false, ground = true }, -- Eversong Woods
    [1268] = { fly = false, ground = true }, -- Ghostlands
    [1269] = { fly = false, ground = true }, -- Silvermoon City
    [1270] = { fly = false, ground = true }, -- Isle of Quel'Danas
    [1271] = { fly = false, ground = true }, -- Gilneas
    [1272] = { fly = true, ground = true }, -- Vashj'ir
    [1273] = { fly = true, ground = true }, -- Ruins of Gilneas
    [1274] = { fly = false, ground = true }, -- Stranglethorn Vale
    [1275] = { fly = true, ground = true }, -- Twilight Highlands
    [1276] = { fly = false, ground = true }, -- Tol Barad
    [1277] = { fly = false, ground = true }, -- Tol Barad Peninsula
    [1305] = { fly = true, ground = true }, -- Durotar
    [1306] = { fly = true, ground = true }, -- Mulgore
    [1307] = { fly = true, ground = true }, -- Northern Barrens
    [1308] = { fly = true, ground = true }, -- Teldrassil
    [1309] = { fly = true, ground = true }, -- Darkshore
    [1310] = { fly = true, ground = true }, -- Ashenvale
    [1311] = { fly = true, ground = true }, -- Thousand Needles
    [1312] = { fly = true, ground = true }, -- Stonetalon Mountains
    [1313] = { fly = true, ground = true }, -- Desolace
    [1314] = { fly = true, ground = true }, -- Feralas
    [1315] = { fly = true, ground = true }, -- Dustwallow Marsh
    [1316] = { fly = true, ground = true }, -- Tanaris
    [1317] = { fly = true, ground = true }, -- Azshara
    [1318] = { fly = true, ground = true }, -- Felwood
    [1319] = { fly = true, ground = true }, -- Un'Goro Crater
    [1320] = { fly = true, ground = true }, -- Moonglade
    [1321] = { fly = true, ground = true }, -- Silithus
    [1322] = { fly = true, ground = true }, -- Winterspring
    [1323] = { fly = true, ground = true }, -- Thunder Bluff
    [1324] = { fly = true, ground = true }, -- Darnassus
    [1325] = { fly = false, ground = true }, -- Azuremyst Isle
    [1326] = { fly = false, ground = true }, -- The Exodar
    [1327] = { fly = false, ground = true }, -- Bloodmyst Isle
    [1328] = { fly = true, ground = true }, -- Mount Hyjal
    [1329] = { fly = true, ground = true }, -- Southern Barrens
    [1330] = { fly = true, ground = true }, -- Uldum
    [1331] = { fly = false, ground = true }, -- The Exodar
    [1332] = { fly = false, ground = true }, -- Darkshore
    [1333] = { fly = false, ground = true }, -- Darkshore
    [1334] = { fly = false, ground = true }, -- Wintergrasp
    [1335] = { fly = false, ground = false }, -- Cooking: Impossible
    [1336] = { fly = true, ground = true }, -- Havenswood
    [1337] = { fly = true, ground = true }, -- Jorundall
    [1338] = { fly = false, ground = true }, -- Darkshore
    [1339] = { fly = false, ground = true }, -- Warsong Gulch
    [1345] = { fly = false, ground = false }, -- Crucible of Storms
    [1346] = { fly = false, ground = false }, -- Crucible of Storms
    [1347] = { fly = false, ground = false }, -- Zandalari Treasury
    [1348] = { fly = false, ground = false }, -- Zandalari Treasury
    [1349] = { fly = false, ground = true }, -- Tol Dagor
    [1350] = { fly = false, ground = false }, -- Tol Dagor
    [1351] = { fly = false, ground = false }, -- Tol Dagor
    [1352] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1353] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1354] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1355] = { fly = true, ground = true }, -- Nazjatar
    [1356] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1357] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1358] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1359] = { fly = false, ground = false }, -- Icecrown Citadel
    [1360] = { fly = false, ground = false }, -- Icecrown Citadel
    [1361] = { fly = false, ground = false }, -- OldIronforge
    [1362] = { fly = true, ground = true }, -- Shrine of the Storm
    [1363] = { fly = false, ground = false }, -- Crucible of Storms
    [1364] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1366] = { fly = false, ground = true }, -- Arathi Basin
    [1367] = { fly = false, ground = false }, -- Battle of Dazar'alor
    [1371] = { fly = false, ground = false }, -- GnomereganA
    [1372] = { fly = false, ground = false }, -- GnomereganB
    [1374] = { fly = false, ground = false }, -- GnomereganD
    [1375] = { fly = false, ground = false }, -- Halls of Stone
    [1379] = { fly = false, ground = true }, -- 8.3 Visions of N'Zoth - Prototype
    [1380] = { fly = false, ground = false }, -- GnomereganC
    [1381] = { fly = false, ground = false }, -- Uldir
    [1382] = { fly = false, ground = false }, -- Uldir
    [1383] = { fly = false, ground = true }, -- Arathi Basin
    [1384] = { fly = false, ground = false }, -- Northrend
    [1396] = { fly = true, ground = true }, -- Borean Tundra
    [1397] = { fly = true, ground = true }, -- Dragonblight
    [1398] = { fly = true, ground = true }, -- Grizzly Hills
    [1399] = { fly = true, ground = true }, -- Howling Fjord
    [1400] = { fly = true, ground = true }, -- Icecrown
    [1401] = { fly = true, ground = true }, -- Sholazar Basin
    [1402] = { fly = true, ground = true }, -- The Storm Peaks
    [1403] = { fly = true, ground = true }, -- Zul'Drak
    [1404] = { fly = false, ground = true }, -- Wintergrasp
    [1405] = { fly = true, ground = true }, -- Crystalsong Forest
    [1406] = { fly = true, ground = true }, -- Hrothgar's Landing
    [1407] = { fly = false, ground = false }, -- Prison of Ink
    [1408] = { fly = false, ground = false }, -- Ashran
    [1409] = { fly = false, ground = false }, -- Exile's Reach
    [1462] = { fly = true, ground = true }, -- Mechagon Island
    [1465] = { fly = false, ground = false }, -- Scarlet Halls
    [1467] = { fly = false, ground = false }, -- Outland
    [1468] = { fly = true, ground = true }, -- The Dreamgrove
    [1469] = { fly = false, ground = true }, -- Vision of Orgrimmar
    [1470] = { fly = false, ground = true }, -- Vision of Stormwind
    [1471] = { fly = false, ground = true }, -- Emerald Dreamway
    [1472] = { fly = false, ground = false }, -- The Dragon's Spine
    [1473] = { fly = false, ground = false }, -- Chamber of Heart
    [1474] = { fly = false, ground = false }, -- The Maelstrom - Heart of Azeroth
    [1475] = { fly = false, ground = true }, -- The Emerald Dream
    [1476] = { fly = false, ground = true }, -- Twilight Highlands
    [1478] = { fly = false, ground = true }, -- Ashran
    [1479] = { fly = false, ground = false }, -- Baine Rescue
    [1490] = { fly = false, ground = true }, -- Mechagon
    [1491] = { fly = false, ground = false }, -- Mechagon
    [1493] = { fly = false, ground = false }, -- Mechagon
    [1494] = { fly = false, ground = false }, -- Mechagon
    [1497] = { fly = false, ground = false }, -- Mechagon
    [1499] = { fly = false, ground = false }, -- Zin-Azshari
    [1500] = { fly = false, ground = false }, -- Unnamed map 1500
    [1501] = { fly = true, ground = true }, -- Crestfall
    [1502] = { fly = true, ground = true }, -- Snowblossom Village
    [1504] = { fly = true, ground = true }, -- Nazjatar
    [1505] = { fly = false, ground = false }, -- Stratholme
    [1512] = { fly = false, ground = false }, -- The Eternal Palace
    [1513] = { fly = false, ground = false }, -- The Eternal Palace
    [1514] = { fly = false, ground = false }, -- The Eternal Palace
    [1515] = { fly = false, ground = true }, -- The Eternal Palace
    [1516] = { fly = false, ground = false }, -- The Eternal Palace
    [1517] = { fly = false, ground = false }, -- The Eternal Palace
    [1518] = { fly = false, ground = false }, -- The Eternal Palace
    [1519] = { fly = false, ground = false }, -- The Eternal Palace
    [1520] = { fly = false, ground = false }, -- The Eternal Palace
    [1521] = { fly = false, ground = false }, -- Karazhan Catacombs
    [1522] = { fly = false, ground = false }, -- Crumbling Cavern
    [1524] = { fly = false, ground = false }, -- Unnamed map 1524
    [1525] = { fly = true, ground = true }, -- Revendreth
    [1527] = { fly = true, ground = true }, -- Uldum
    [1528] = { fly = true, ground = true }, -- Nazjatar
    [1530] = { fly = true, ground = true }, -- Vale of Eternal Blossoms
    [1531] = { fly = false, ground = false }, -- Crapopolis
    [1532] = { fly = false, ground = true }, -- Crapopolis
    [1533] = { fly = true, ground = true }, -- Bastion
    [1534] = { fly = true, ground = true }, -- Orgrimmar
    [1535] = { fly = true, ground = true }, -- Durotar
    [1536] = { fly = true, ground = true }, -- Maldraxxus
    [1537] = { fly = false, ground = true }, -- Alterac Valley
    [1538] = { fly = false, ground = false }, -- Blackwing Descent
    [1539] = { fly = false, ground = false }, -- Blackwing Descent
    [1540] = { fly = false, ground = false }, -- Halls of Origination
    [1541] = { fly = false, ground = false }, -- Halls of Origination
    [1542] = { fly = false, ground = false }, -- Halls of Origination
    [1543] = { fly = false, ground = true }, -- The Maw
    [1544] = { fly = false, ground = false }, -- Mogu'shan Palace
    [1545] = { fly = false, ground = false }, -- Mogu'shan Palace
    [1546] = { fly = false, ground = false }, -- Mogu'shan Palace
    [1547] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [1548] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [1549] = { fly = false, ground = false }, -- Mogu'shan Vaults
    [1550] = { fly = false, ground = false }, -- The Shadowlands
    [1552] = { fly = false, ground = false }, -- Caverns of Time
    [1553] = { fly = false, ground = false }, -- Caverns of Time
    [1554] = { fly = false, ground = false }, -- Serpentshrine Cavern
    [1555] = { fly = false, ground = false }, -- Tempest Keep
    [1556] = { fly = false, ground = false }, -- Hyjal Summit
    [1557] = { fly = false, ground = false }, -- Naxxramas
    [1558] = { fly = false, ground = false }, -- Icecrown Citadel
    [1559] = { fly = false, ground = false }, -- The Bastion of Twilight
    [1560] = { fly = false, ground = false }, -- Blackwing Lair
    [1561] = { fly = false, ground = false }, -- Firelands
    [1563] = { fly = false, ground = false }, -- Trial of the Crusader
    [1565] = { fly = true, ground = true }, -- Ardenweald
    [1569] = { fly = true, ground = true }, -- Bastion
    [1570] = { fly = true, ground = true }, -- Vale of Eternal Blossoms
    [1571] = { fly = true, ground = true }, -- Uldum
    [1573] = { fly = false, ground = false }, -- Mechagon City
    [1574] = { fly = false, ground = false }, -- Mechagon City
    [1576] = { fly = false, ground = false }, -- Deepwind Gorge
    [1577] = { fly = false, ground = true }, -- Gilneas City
    [1578] = { fly = false, ground = false }, -- Blackrock Depths
    [1579] = { fly = false, ground = false }, -- Pools Of Power
    [1580] = { fly = false, ground = false }, -- Ny'alotha
    [1581] = { fly = false, ground = false }, -- Ny'alotha
    [1582] = { fly = false, ground = true }, -- Ny'alotha
    [1590] = { fly = false, ground = false }, -- Ny'alotha
    [1591] = { fly = false, ground = false }, -- Ny'alotha
    [1592] = { fly = false, ground = false }, -- Ny'alotha
    [1593] = { fly = false, ground = false }, -- Ny'alotha
    [1594] = { fly = false, ground = false }, -- Ny'alotha
    [1595] = { fly = false, ground = false }, -- Ny'alotha
    [1596] = { fly = false, ground = false }, -- Ny'alotha
    [1597] = { fly = false, ground = false }, -- Ny'alotha
    [1600] = { fly = false, ground = false }, -- Vault of Y'Shaarj
    [1602] = { fly = false, ground = false }, -- Icecrown Citadel
    [1603] = { fly = true, ground = true }, -- Ardenweald
    [1604] = { fly = false, ground = false }, -- Chamber Of Heart
    [1609] = { fly = false, ground = false }, -- Darkmaul Citadel
    [1610] = { fly = false, ground = false }, -- Darkmaul Citadel
    [1611] = { fly = false, ground = false }, -- Dark Citadel
    [1614] = { fly = false, ground = false }, -- JT_New_A
    [1615] = { fly = false, ground = false }, -- TG10_Floor [Deprecated]
    [1616] = { fly = false, ground = false }, -- TG11_Floor [Deprecated]
    [1617] = { fly = false, ground = false }, -- TG12_Floor [Deprecated]
    [1618] = { fly = false, ground = false }, -- Torghast
    [1619] = { fly = false, ground = false }, -- Torghast
    [1620] = { fly = false, ground = false }, -- Torghast
    [1621] = { fly = false, ground = false }, -- Torghast
    [1623] = { fly = false, ground = false }, -- Torghast
    [1624] = { fly = false, ground = false }, -- Torghast
    [1627] = { fly = false, ground = false }, -- Torghast
    [1628] = { fly = false, ground = false }, -- Torghast
    [1629] = { fly = false, ground = false }, -- Torghast
    [1630] = { fly = false, ground = false }, -- Torghast
    [1631] = { fly = false, ground = false }, -- Torghast
    [1632] = { fly = false, ground = false }, -- Torghast
    [1635] = { fly = false, ground = false }, -- Torghast
    [1636] = { fly = false, ground = false }, -- Torghast
    [1641] = { fly = false, ground = false }, -- Torghast
    [1642] = { fly = true, ground = true }, -- Val'sharah
    [1643] = { fly = true, ground = true }, -- Ardenweald
    [1644] = { fly = false, ground = true }, -- Ember Court
    [1645] = { fly = false, ground = false }, -- Torghast
    [1647] = { fly = false, ground = false }, -- The Shadowlands
    [1648] = { fly = false, ground = false }, -- The Maw
    [1649] = { fly = false, ground = false }, -- Etheric Vault
    [1650] = { fly = false, ground = false }, -- Sightless Hold
    [1651] = { fly = false, ground = false }, -- Molten Forge
    [1652] = { fly = false, ground = false }, -- Vault of Souls
    [1656] = { fly = false, ground = false }, -- Torghast - Map Floor 10 [Deprecated]
    [1658] = { fly = false, ground = false }, -- Alpha_TG_R02
    [1659] = { fly = false, ground = false }, -- Alpha_TG_R03
    [1661] = { fly = false, ground = false }, -- Alpha_TG_R05
    [1662] = { fly = true, ground = true }, -- Queen's Conservatory
    [1663] = { fly = false, ground = true }, -- Halls of Atonement
    [1664] = { fly = false, ground = false }, -- Halls of Atonement
    [1665] = { fly = false, ground = false }, -- Halls of Atonement
    [1666] = { fly = false, ground = true }, -- The Necrotic Wake
    [1667] = { fly = false, ground = false }, -- The Necrotic Wake
    [1668] = { fly = false, ground = false }, -- The Necrotic Wake
    [1669] = { fly = false, ground = true }, -- Mists of Tirna Scithe
    [1670] = { fly = false, ground = false }, -- Oribos
    [1671] = { fly = false, ground = false }, -- Oribos
    [1672] = { fly = false, ground = false }, -- Oribos
    [1673] = { fly = false, ground = false }, -- Oribos
    [1674] = { fly = false, ground = true }, -- Plaguefall
    [1675] = { fly = false, ground = false }, -- Sanguine Depths
    [1676] = { fly = false, ground = false }, -- Sanguine Depths
    [1677] = { fly = false, ground = false }, -- De Other Side
    [1678] = { fly = false, ground = false }, -- De Other Side
    [1679] = { fly = false, ground = false }, -- De Other Side
    [1680] = { fly = false, ground = false }, -- De Other Side
    [1681] = { fly = false, ground = false }, -- Icecrown Citadel
    [1682] = { fly = false, ground = false }, -- Icecrown Citadel
    [1683] = { fly = false, ground = true }, -- Theater of Pain
    [1684] = { fly = false, ground = false }, -- Theater of Pain
    [1685] = { fly = false, ground = false }, -- Theater of Pain
    [1686] = { fly = false, ground = false }, -- Theater of Pain
    [1687] = { fly = false, ground = false }, -- Theater of Pain
    [1688] = { fly = false, ground = false }, -- Revendreth
    [1689] = { fly = true, ground = true }, -- Maldraxxus
    [1690] = { fly = false, ground = false }, -- Aspirant's Quarters
    [1691] = { fly = false, ground = true }, -- Shattered Grove
    [1692] = { fly = false, ground = false }, -- Spires Of Ascension
    [1693] = { fly = false, ground = false }, -- Spires Of Ascension
    [1694] = { fly = false, ground = false }, -- Spires Of Ascension
    [1695] = { fly = false, ground = false }, -- Spires Of Ascension
    [1697] = { fly = false, ground = false }, -- Plaguefall
    [1698] = { fly = false, ground = false }, -- Seat of the Primus
    [1699] = { fly = false, ground = false }, -- Sinfall
    [1700] = { fly = false, ground = false }, -- Sinfall
    [1701] = { fly = false, ground = false }, -- Heart of the Forest
    [1702] = { fly = false, ground = false }, -- Heart of the Forest
    [1703] = { fly = false, ground = false }, -- Heart of the Forest
    [1705] = { fly = false, ground = false }, -- Torghast - Entrance
    [1707] = { fly = false, ground = false }, -- Elysian Hold
    [1708] = { fly = false, ground = false }, -- Elysian Hold
    [1709] = { fly = false, ground = true }, -- Ardenweald
    [1711] = { fly = false, ground = false }, -- Ascension Coliseum
    [1712] = { fly = false, ground = false }, -- Torghast
    [1713] = { fly = false, ground = false }, -- Path of Wisdom
    [1714] = { fly = false, ground = false }, -- Third Chamber of Kalliope
    [1715] = { fly = false, ground = false }, -- Vestibule Of Eternity
    [1716] = { fly = false, ground = false }, -- Torghast - Map Floor 22
    [1717] = { fly = false, ground = true }, -- Chill's Reach
    [1720] = { fly = false, ground = false }, -- Covenant_Ard_Torghast
    [1721] = { fly = false, ground = false }, -- Torghast
    [1724] = { fly = false, ground = false }, -- Vortrexxis
    [1726] = { fly = false, ground = false }, -- The North Sea
    [1727] = { fly = false, ground = false }, -- The North Sea
    [1728] = { fly = false, ground = false }, -- The Runecarver
    [1734] = { fly = true, ground = true }, -- Revendreth
    [1735] = { fly = false, ground = false }, -- Castle Nathria
    [1736] = { fly = false, ground = false }, -- Torghast
    [1738] = { fly = true, ground = true }, -- Revendreth
    [1739] = { fly = true, ground = true }, -- Ardenweald
    [1740] = { fly = true, ground = true }, -- Ardenweald
    [1741] = { fly = true, ground = true }, -- Maldraxxus
    [1742] = { fly = true, ground = true }, -- Revendreth
    [1744] = { fly = false, ground = false }, -- Castle Nathria
    [1745] = { fly = false, ground = false }, -- Castle Nathria
    [1746] = { fly = false, ground = false }, -- Castle Nathria
    [1747] = { fly = false, ground = false }, -- Castle Nathria
    [1748] = { fly = false, ground = false }, -- Castle Nathria
    [1749] = { fly = false, ground = false }, -- Torghast
    [1750] = { fly = false, ground = false }, -- Castle Nathria
    [1751] = { fly = false, ground = false }, -- Torghast
    [1752] = { fly = false, ground = false }, -- Torghast
    [1753] = { fly = false, ground = false }, -- Torghast
    [1754] = { fly = false, ground = false }, -- Torghast
    [1755] = { fly = false, ground = false }, -- Castle Nathria
    [1756] = { fly = false, ground = false }, -- Torghast
    [1757] = { fly = false, ground = false }, -- Torghast
    [1758] = { fly = false, ground = false }, -- Torghast
    [1759] = { fly = false, ground = false }, -- Torghast
    [1760] = { fly = false, ground = false }, -- Torghast
    [1761] = { fly = false, ground = false }, -- Torghast
    [1762] = { fly = false, ground = false }, -- Torghast, Tower of the Damned
    [1763] = { fly = false, ground = false }, -- Torghast
    [1764] = { fly = false, ground = false }, -- Torghast
    [1765] = { fly = false, ground = false }, -- Torghast
    [1766] = { fly = false, ground = false }, -- Torghast
    [1767] = { fly = false, ground = false }, -- Torghast
    [1768] = { fly = false, ground = false }, -- Torghast
    [1769] = { fly = false, ground = false }, -- Torghast
    [1770] = { fly = false, ground = false }, -- Torghast
    [1771] = { fly = false, ground = false }, -- Torghast
    [1772] = { fly = false, ground = false }, -- Torghast
    [1773] = { fly = false, ground = false }, -- Torghast
    [1774] = { fly = false, ground = false }, -- Torghast
    [1776] = { fly = false, ground = false }, -- Torghast
    [1777] = { fly = false, ground = false }, -- Torghast
    [1778] = { fly = false, ground = false }, -- Torghast
    [1779] = { fly = false, ground = false }, -- Torghast
    [1780] = { fly = false, ground = false }, -- Torghast
    [1781] = { fly = false, ground = false }, -- Torghast
    [1782] = { fly = false, ground = false }, -- Torghast
    [1783] = { fly = false, ground = false }, -- Torghast
    [1784] = { fly = false, ground = false }, -- Torghast
    [1785] = { fly = false, ground = false }, -- Torghast
    [1786] = { fly = false, ground = false }, -- Torghast
    [1787] = { fly = false, ground = false }, -- Torghast
    [1788] = { fly = false, ground = false }, -- Torghast
    [1789] = { fly = false, ground = false }, -- Torghast
    [1791] = { fly = false, ground = false }, -- Torghast
    [1792] = { fly = false, ground = false }, -- Torghast
    [1793] = { fly = false, ground = false }, -- Torghast
    [1794] = { fly = false, ground = false }, -- Torghast
    [1795] = { fly = false, ground = false }, -- Torghast
    [1796] = { fly = false, ground = false }, -- Torghast
    [1797] = { fly = false, ground = false }, -- Torghast
    [1798] = { fly = false, ground = false }, -- Torghast
    [1799] = { fly = false, ground = false }, -- Torghast
    [1800] = { fly = false, ground = false }, -- Torghast
    [1801] = { fly = false, ground = false }, -- Torghast
    [1802] = { fly = false, ground = false }, -- Torghast
    [1803] = { fly = false, ground = false }, -- Torghast
    [1804] = { fly = false, ground = false }, -- Torghast
    [1805] = { fly = false, ground = false }, -- Torghast
    [1806] = { fly = false, ground = false }, -- Torghast
    [1807] = { fly = false, ground = false }, -- Torghast
    [1808] = { fly = false, ground = false }, -- Torghast
    [1809] = { fly = false, ground = false }, -- Torghast
    [1810] = { fly = false, ground = false }, -- Torghast
    [1811] = { fly = false, ground = false }, -- Torghast
    [1812] = { fly = false, ground = false }, -- Torghast
    [1813] = { fly = true, ground = true }, -- Bastion
    [1814] = { fly = true, ground = true }, -- Maldraxxus
    [1816] = { fly = false, ground = false }, -- Claw's Edge
    [1818] = { fly = false, ground = false }, -- Tirna Vaal
    [1819] = { fly = false, ground = false }, -- Fungal Terminus
    [1820] = { fly = false, ground = false }, -- Pit of Anguish
    [1821] = { fly = false, ground = false }, -- Pit of Anguish
    [1822] = { fly = false, ground = false }, -- Extractor's Sanatorium
    [1823] = { fly = false, ground = false }, -- Altar of Domination
    [1824] = { fly = false, ground = false }, -- Matriarch's Den
    [1825] = { fly = false, ground = false }, -- The Root Cellar
    [1826] = { fly = false, ground = false }, -- The Root Cellar
    [1827] = { fly = false, ground = false }, -- The Root Cellar
    [1829] = { fly = false, ground = false }, -- Unnamed map 1829
    [1833] = { fly = false, ground = false }, -- Torghast
    [1834] = { fly = false, ground = false }, -- Torghast - Map Floor 24
    [1835] = { fly = false, ground = false }, -- Torghast - Map Floor 25
    [1836] = { fly = false, ground = false }, -- Torghast - Map Floor 26
    [1837] = { fly = false, ground = false }, -- Torghast - Map Floor 27
    [1838] = { fly = false, ground = false }, -- Torghast - Map Floor 41
    [1839] = { fly = false, ground = false }, -- Torghast - Map Floor 28
    [1840] = { fly = false, ground = false }, -- Torghast - Map Floor 40
    [1841] = { fly = false, ground = false }, -- Torghast - Map Floor 39
    [1842] = { fly = false, ground = false }, -- Torghast - Map Floor 29
    [1843] = { fly = false, ground = false }, -- Torghast - Map Floor 38
    [1844] = { fly = false, ground = false }, -- Torghast - Map Floor 32
    [1845] = { fly = false, ground = false }, -- Torghast - Map Floor 31
    [1846] = { fly = false, ground = false }, -- Torghast - Map Floor 33
    [1847] = { fly = false, ground = false }, -- Torghast - Map Floor 34
    [1848] = { fly = false, ground = false }, -- Torghast - Map Floor 14
    [1849] = { fly = false, ground = false }, -- Torghast - Map Floor 16
    [1850] = { fly = false, ground = false }, -- Torghast - Map Floor 18
    [1851] = { fly = false, ground = false }, -- Torghast - Map Floor 42
    [1852] = { fly = false, ground = false }, -- Torghast - Map Floor 44
    [1853] = { fly = false, ground = false }, -- Torghast - Map Floor 46
    [1854] = { fly = false, ground = false }, -- Torghast - Map Floor 48
    [1855] = { fly = false, ground = false }, -- Torghast - Map Floor 49
    [1856] = { fly = false, ground = false }, -- Torghast - Map Floor 50
    [1857] = { fly = false, ground = false }, -- Torghast - Map Floor 51
    [1858] = { fly = false, ground = false }, -- Torghast - Map Floor 52
    [1859] = { fly = false, ground = false }, -- Torghast - Map Floor 53
    [1860] = { fly = false, ground = false }, -- Torghast - Map Floor 54
    [1861] = { fly = false, ground = false }, -- Torghast - Map Floor 57
    [1862] = { fly = false, ground = false }, -- Torghast - Map Floor 59
    [1863] = { fly = false, ground = false }, -- Torghast - Map Floor 61
    [1864] = { fly = false, ground = false }, -- Torghast - Map Floor 63
    [1865] = { fly = false, ground = false }, -- Torghast - Map Floor 64
    [1867] = { fly = false, ground = false }, -- Torghast - Map Floor 66
    [1868] = { fly = false, ground = false }, -- Torghast - Map Floor 67
    [1869] = { fly = false, ground = false }, -- Torghast - Map Floor 68
    [1870] = { fly = false, ground = false }, -- Torghast - Map Floor 69
    [1871] = { fly = false, ground = false }, -- Torghast - Map Floor 70
    [1872] = { fly = false, ground = false }, -- Torghast - Map Floor 71
    [1873] = { fly = false, ground = false }, -- Torghast - Map Floor 74
    [1874] = { fly = false, ground = false }, -- Torghast - Map Floor 75
    [1875] = { fly = false, ground = false }, -- Torghast - Map Floor 76
    [1876] = { fly = false, ground = false }, -- Torghast - Map Floor 77
    [1877] = { fly = false, ground = false }, -- Torghast - Map Floor 78
    [1878] = { fly = false, ground = false }, -- Torghast - Map Floor 80
    [1879] = { fly = false, ground = false }, -- Torghast - Map Floor 81
    [1880] = { fly = false, ground = false }, -- Torghast - Map Floor 83
    [1881] = { fly = false, ground = false }, -- Torghast - Map Floor 84
    [1882] = { fly = false, ground = false }, -- Torghast - Map Floor 86
    [1883] = { fly = false, ground = false }, -- Torghast - Map Floor 87
    [1884] = { fly = false, ground = false }, -- Torghast - Map Floor 88
    [1885] = { fly = false, ground = false }, -- Torghast - Map Floor 89
    [1886] = { fly = false, ground = false }, -- Torghast - Map Floor 92
    [1887] = { fly = false, ground = false }, -- Torghast - Map Floor 93
    [1888] = { fly = false, ground = false }, -- Torghast - Map Floor 94
    [1889] = { fly = false, ground = false }, -- Torghast - Map Floor 95
    [1890] = { fly = false, ground = false }, -- Torghast - Map Floor 97
    [1891] = { fly = false, ground = false }, -- Torghast - Map Floor 98
    [1892] = { fly = false, ground = false }, -- Torghast - Map Floor 99
    [1893] = { fly = false, ground = false }, -- Torghast - Map Floor 100
    [1894] = { fly = false, ground = false }, -- Torghast - Map Floor 23
    [1895] = { fly = false, ground = false }, -- Torghast - Map Floor 35
    [1896] = { fly = false, ground = false }, -- Torghast - Map Floor 56
    [1897] = { fly = false, ground = false }, -- Torghast - Map Floor 62
    [1898] = { fly = false, ground = false }, -- Torghast - Map Floor 82
    [1899] = { fly = false, ground = false }, -- Torghast - Map Floor 101
    [1900] = { fly = false, ground = false }, -- Torghast - Map Floor 58
    [1901] = { fly = false, ground = false }, -- Torghast - Map Floor 73
    [1902] = { fly = false, ground = false }, -- Torghast - Map Floor 79
    [1903] = { fly = false, ground = false }, -- Torghast - Map Floor 85
    [1904] = { fly = false, ground = false }, -- Torghast - Map Floor 90
    [1905] = { fly = false, ground = false }, -- Torghast - Map Floor 96
    [1907] = { fly = false, ground = false }, -- Torghast - Map Floor 102
    [1908] = { fly = false, ground = false }, -- Torghast - Map Floor 60
    [1909] = { fly = false, ground = false }, -- Torghast - Map Floor 21
    [1910] = { fly = false, ground = false }, -- Torghast - Map Floor 91
    [1911] = { fly = false, ground = false }, -- Torghast - Entrance
    [1912] = { fly = false, ground = false }, -- The Runecarver's Oubliette
    [1913] = { fly = false, ground = false }, -- Torghast
    [1914] = { fly = false, ground = false }, -- Torghast
    [1917] = { fly = false, ground = false }, -- De Other Side
    [1920] = { fly = false, ground = false }, -- Torghast
    [1921] = { fly = false, ground = false }, -- Torghast
    [1922] = { fly = false, ground = false }, -- Draenor
    [1923] = { fly = false, ground = false }, -- Pandaria
    [1958] = { fly = false, ground = true }, -- Firelands
    [1959] = { fly = false, ground = false }, -- Firelands
    [1960] = { fly = false, ground = true }, -- The Maw
    [1961] = { fly = false, ground = true }, -- Korthia
    [1962] = { fly = false, ground = false }, -- Torghast
    [1963] = { fly = false, ground = false }, -- Torghast
    [1964] = { fly = false, ground = false }, -- Torghast
    [1965] = { fly = false, ground = false }, -- Torghast
    [1966] = { fly = false, ground = false }, -- Torghast
    [1967] = { fly = false, ground = false }, -- Torghast
    [1968] = { fly = false, ground = false }, -- Torghast
    [1969] = { fly = false, ground = false }, -- Torghast
    [1970] = { fly = true, ground = true }, -- Zereth Mortis
    [1971] = { fly = false, ground = false }, -- Skyhold
    [1974] = { fly = false, ground = false }, -- Torghast
    [1975] = { fly = false, ground = false }, -- Torghast
    [1976] = { fly = false, ground = false }, -- Torghast
    [1977] = { fly = false, ground = false }, -- Torghast
    [1978] = { fly = false, ground = false }, -- Dragon Isles
    [1979] = { fly = false, ground = false }, -- Torghast
    [1980] = { fly = false, ground = false }, -- Torghast
    [1981] = { fly = false, ground = false }, -- Torghast
    [1982] = { fly = false, ground = false }, -- Torghast
    [1983] = { fly = false, ground = false }, -- Torghast
    [1984] = { fly = false, ground = false }, -- Torghast
    [1985] = { fly = false, ground = false }, -- Torghast
    [1986] = { fly = false, ground = false }, -- Torghast
    [1987] = { fly = false, ground = false }, -- Torghast
    [1988] = { fly = false, ground = false }, -- Torghast
    [1989] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1990] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1991] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1992] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1993] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1995] = { fly = false, ground = true }, -- Tazavesh, the Veiled Market
    [1996] = { fly = false, ground = true }, -- Tazavesh, the Veiled Market
    [1997] = { fly = false, ground = false }, -- Tazavesh, the Veiled Market
    [1998] = { fly = false, ground = false }, -- Sanctum of Domination
    [1999] = { fly = false, ground = false }, -- Sanctum of Domination
    [2000] = { fly = false, ground = false }, -- Sanctum of Domination
    [2001] = { fly = false, ground = false }, -- Sanctum of Domination
    [2002] = { fly = false, ground = false }, -- Sanctum of Domination
    [2003] = { fly = false, ground = false }, -- Sanctum of Domination
    [2004] = { fly = false, ground = false }, -- Sanctum of Domination
    [2005] = { fly = true, ground = true }, -- Ardenweald
    [2006] = { fly = false, ground = false }, -- Cavern of Contemplation
    [2007] = { fly = false, ground = false }, -- Gromit Hollow
    [2008] = { fly = false, ground = false }, -- Chamber of the Sigil
    [2009] = { fly = false, ground = false }, -- TG106_Floor_MM
    [2010] = { fly = false, ground = false }, -- Torghast
    [2011] = { fly = false, ground = false }, -- Torghast
    [2012] = { fly = false, ground = false }, -- Torghast
    [2016] = { fly = false, ground = true }, -- Tazavesh, the Veiled Market
    [2017] = { fly = false, ground = false }, -- Spires of Ascension
    [2018] = { fly = false, ground = false }, -- Spires of Ascension
    [2019] = { fly = false, ground = false }, -- Torghast
    [2022] = { fly = true, ground = true }, -- The Waking Shores
    [2023] = { fly = true, ground = true }, -- Ohn'ahran Plains
    [2024] = { fly = true, ground = true }, -- The Azure Span
    [2025] = { fly = true, ground = true }, -- Thaldraszus
    [2027] = { fly = false, ground = false }, -- Blooming Foundry
    [2028] = { fly = false, ground = false }, -- Locrian Esper
    [2029] = { fly = false, ground = false }, -- Gravid Repose
    [2030] = { fly = false, ground = false }, -- Nexus of Actualization
    [2031] = { fly = false, ground = false }, -- Crypts of the Eternal
    [2042] = { fly = false, ground = false }, -- The Crucible
    [2046] = { fly = true, ground = true }, -- Zereth Mortis
    [2047] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2048] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2049] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2050] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2051] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2052] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2055] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2057] = { fly = false, ground = false }, -- Dragon Isles
    [2059] = { fly = true, ground = true }, -- Resonant Peaks
    [2061] = { fly = false, ground = false }, -- Sepulcher of the First Ones
    [2063] = { fly = true, ground = true }, -- Dragon Isles
    [2066] = { fly = false, ground = false }, -- Catalyst Wards
    [2070] = { fly = true, ground = true }, -- Tirisfal Glades
    [2071] = { fly = false, ground = false }, -- Uldaman: Legacy of Tyr
    [2072] = { fly = false, ground = false }, -- Uldaman: Legacy of Tyr
    [2073] = { fly = false, ground = false }, -- The Azure Vault
    [2074] = { fly = false, ground = false }, -- The Azure Vault
    [2075] = { fly = false, ground = false }, -- The Azure Vault
    [2076] = { fly = false, ground = false }, -- The Azure Vault
    [2077] = { fly = false, ground = false }, -- The Azure Vault
    [2080] = { fly = false, ground = false }, -- Neltharus
    [2081] = { fly = false, ground = false }, -- Neltharus
    [2082] = { fly = false, ground = false }, -- Halls Of Infusion
    [2083] = { fly = false, ground = false }, -- Halls Of Infusion
    [2084] = { fly = false, ground = false }, -- The Emerald Dreamway
    [2085] = { fly = true, ground = true }, -- The Primalist Future
    [2088] = { fly = false, ground = true }, -- Pandaren Revolution
    [2089] = { fly = false, ground = true }, -- The Black Empire
    [2090] = { fly = false, ground = true }, -- The Gnoll War
    [2091] = { fly = false, ground = true }, -- War of the Shifting Sands
    [2092] = { fly = false, ground = true }, -- Azmerloth
    [2093] = { fly = true, ground = true }, -- The Nokhud Offensive
    [2094] = { fly = true, ground = true }, -- Ruby Life Pools
    [2095] = { fly = false, ground = false }, -- Ruby Life Pools
    [2096] = { fly = false, ground = true }, -- Brackenhide Hollow
    [2097] = { fly = false, ground = true }, -- Algeth'ar Academy
    [2098] = { fly = false, ground = true }, -- Algeth'ar Academy
    [2099] = { fly = false, ground = false }, -- Algeth'ar Academy
    [2100] = { fly = false, ground = false }, -- The Siege Creche
    [2101] = { fly = false, ground = false }, -- The Support Creche
    [2102] = { fly = false, ground = false }, -- The War Creche
    [2106] = { fly = false, ground = false }, -- Brackenhide Hollow
    [2109] = { fly = false, ground = false }, -- The War Creche
    [2110] = { fly = false, ground = false }, -- The Support Creche
    [2111] = { fly = false, ground = false }, -- The Siege Creche
    [2112] = { fly = true, ground = true }, -- Valdrakken
    [2118] = { fly = true, ground = true }, -- The Forbidden Reach
    [2119] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2120] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2121] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2122] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2123] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2124] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2125] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2126] = { fly = false, ground = false }, -- Vault of the Incarnates
    [2127] = { fly = true, ground = true }, -- The Waking Shores
    [2128] = { fly = true, ground = true }, -- The Azure Span
    [2129] = { fly = true, ground = true }, -- Ohn'ahran Plains
    [2130] = { fly = true, ground = true }, -- Thaldraszus
    [2131] = { fly = true, ground = true }, -- The Forbidden Reach
    [2132] = { fly = false, ground = false }, -- The Azure Span
    [2133] = { fly = true, ground = true }, -- Zaralek Cavern
    [2134] = { fly = true, ground = true }, -- Valdrakken
    [2135] = { fly = false, ground = false }, -- Valdrakken
    [2146] = { fly = false, ground = true }, -- The Eastern Glades
    [2147] = { fly = true, ground = true }, -- Azeroth
    [2149] = { fly = true, ground = true }, -- Ohn'ahran Plains
    [2150] = { fly = false, ground = false }, -- Dragonskull Island
    [2151] = { fly = true, ground = true }, -- The Forbidden Reach
    [2154] = { fly = false, ground = false }, -- Froststone Vault
    [2162] = { fly = false, ground = true }, -- Alterac Valley
    [2165] = { fly = true, ground = true }, -- The Throughway
    [2166] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2167] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2168] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2169] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2170] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2171] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2172] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2173] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2174] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2175] = { fly = true, ground = true }, -- Zaralek Cavern
    [2176] = { fly = false, ground = false }, -- The Maelstrom
    [2183] = { fly = false, ground = false }, -- The Azure Vault
    [2184] = { fly = false, ground = false }, -- Zaralek Cavern
    [2190] = { fly = false, ground = false }, -- Sanctum of Chronology
    [2191] = { fly = false, ground = false }, -- Millennia's Threshold
    [2192] = { fly = false, ground = false }, -- Locus of Eternity
    [2193] = { fly = false, ground = false }, -- Spoke of Endless Winter
    [2194] = { fly = true, ground = true }, -- Crossroads of Fate
    [2195] = { fly = false, ground = false }, -- Infinite Conflux
    [2196] = { fly = false, ground = false }, -- Twisting Approach
    [2197] = { fly = false, ground = false }, -- Immemorial Battlefield
    [2198] = { fly = false, ground = false }, -- Dawn of the Infinite
    [2199] = { fly = true, ground = true }, -- Tyrhold Reservoir
    [2200] = { fly = false, ground = false }, -- Emerald Dream
    [2201] = { fly = false, ground = false }, -- Azq'roth
    [2202] = { fly = false, ground = false }, -- Azewrath
    [2203] = { fly = false, ground = false }, -- Azmourne
    [2204] = { fly = false, ground = false }, -- Azmerloth
    [2205] = { fly = false, ground = false }, -- Ulderoth
    [2206] = { fly = false, ground = false }, -- A.Z.E.R.O.T.H.
    [2207] = { fly = false, ground = false }, -- The Warlands
    [2211] = { fly = false, ground = false }, -- Aberrus, the Shadowed Crucible
    [2213] = { fly = true, ground = true }, -- City of Threads
    [2214] = { fly = true, ground = true }, -- The Ringing Deeps
    [2215] = { fly = true, ground = true }, -- Hallowfall
    [2216] = { fly = true, ground = true }, -- City of Threads - Lower
    [2220] = { fly = false, ground = false }, -- The Nighthold
    [2221] = { fly = false, ground = false }, -- The Nighthold
    [2228] = { fly = false, ground = false }, -- The Black Empire
    [2230] = { fly = false, ground = false }, -- Halls Of Valor
    [2231] = { fly = false, ground = false }, -- Halls Of Valor
    [2232] = { fly = false, ground = false }, -- Amirdrassil
    [2233] = { fly = false, ground = false }, -- Amirdrassil
    [2234] = { fly = false, ground = false }, -- Amirdrassil
    [2235] = { fly = false, ground = false }, -- The Northern Boughs
    [2236] = { fly = false, ground = false }, -- The Eastern Boughs
    [2237] = { fly = false, ground = false }, -- The Southern Boughs
    [2238] = { fly = false, ground = false }, -- Amirdrassil
    [2239] = { fly = true, ground = true }, -- Amirdrassil
    [2240] = { fly = false, ground = false }, -- Amirdrassil
    [2241] = { fly = false, ground = false }, -- Emerald Dream
    [2244] = { fly = false, ground = false }, -- Amirdrassil
    [2248] = { fly = false, ground = false }, -- Isle of Dorn
    [2249] = { fly = false, ground = false }, -- Fungal Folly
    [2250] = { fly = false, ground = false }, -- Kriegval's Rest
    [2251] = { fly = false, ground = false }, -- The Waterworks
    [2253] = { fly = false, ground = false }, -- Sor'theril Barrow Den
    [2254] = { fly = false, ground = false }, -- Barrows of Reverie
    [2255] = { fly = true, ground = true }, -- Azj-Kahet
    [2256] = { fly = true, ground = true }, -- Azj-Kahet - Lower
    [2257] = { fly = true, ground = true }, -- Arathi Highlands
    [2259] = { fly = false, ground = false }, -- Tak-Rethan Abyss
    [2262] = { fly = true, ground = true }, -- Traitor's Rest
    [2266] = { fly = false, ground = false }, -- Millenia's Threshold
    [2268] = { fly = true, ground = true }, -- Amirdrassil
    [2269] = { fly = false, ground = false }, -- Earthcrawl Mines
    [2270] = { fly = true, ground = true }, -- Azj' Kahet
    [2271] = { fly = true, ground = true }, -- Isle of Dorn
    [2272] = { fly = true, ground = true }, -- The Ringing Deeps
    [2273] = { fly = true, ground = true }, -- Hallowfall
    [2274] = { fly = false, ground = false }, -- Khaz Algar
    [2276] = { fly = false, ground = false }, -- Khaz Algar
    [2277] = { fly = false, ground = false }, -- Nightfall Sanctum
    [2291] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2292] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2293] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2294] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2295] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2296] = { fly = false, ground = false }, -- Nerub-ar Palace
    [2298] = { fly = false, ground = true }, -- Nerub-ar Palace
    [2299] = { fly = false, ground = false }, -- The Underkeep
    [2300] = { fly = false, ground = false }, -- The Sinkhole
    [2301] = { fly = false, ground = false }, -- The Sinkhole
    [2302] = { fly = false, ground = false }, -- The Dread Pit
    [2303] = { fly = false, ground = false }, -- Darkflame Cleft
    [2304] = { fly = false, ground = false }, -- DarkFlame Cleft
    [2305] = { fly = false, ground = false }, -- Dalaran
    [2306] = { fly = false, ground = false }, -- Dalaran
    [2307] = { fly = false, ground = false }, -- Dalaran
    [2308] = { fly = false, ground = true }, -- Priory of the Sacred Flame
    [2309] = { fly = false, ground = false }, -- Priory of the Sacred Flame
    [2310] = { fly = false, ground = false }, -- Skittering Breach
    [2311] = { fly = false, ground = false }, -- 11.0 -  Hallowfall - [Spreading the Light]- Disabled
    [2312] = { fly = false, ground = false }, -- Mycomancer Cavern
    [2313] = { fly = false, ground = false }, -- The Spiral Weave
    [2314] = { fly = false, ground = false }, -- Tak-Rethan Abyss
    [2315] = { fly = false, ground = false }, -- The Rookery
    [2316] = { fly = false, ground = false }, -- The Rookery
    [2317] = { fly = false, ground = false }, -- The Rookery
    [2318] = { fly = false, ground = false }, -- The Rookery
    [2319] = { fly = false, ground = false }, -- The Rookery
    [2320] = { fly = false, ground = false }, -- The Rookery
    [2321] = { fly = false, ground = false }, -- Chamber of Heart
    [2322] = { fly = false, ground = false }, -- Hall of Awakening
    [2328] = { fly = true, ground = true }, -- The Proscenium
    [2330] = { fly = true, ground = true }, -- Priory of the Sacred Flame
    [2335] = { fly = false, ground = false }, -- Cinderbrew Meadery
    [2339] = { fly = true, ground = true }, -- Dornogal
    [2341] = { fly = false, ground = false }, -- The Stonevault
    [2343] = { fly = false, ground = true }, -- City of Threads
    [2344] = { fly = false, ground = false }, -- City of Threads
    [2345] = { fly = false, ground = true }, -- Deephaul Ravine
    [2346] = { fly = false, ground = true }, -- Undermine
    [2347] = { fly = false, ground = false }, -- The Spiral Weave
    [2348] = { fly = false, ground = false }, -- Zekvir's Lair
    [2351] = { fly = true, ground = true }, -- Razorwind Shores
    [2352] = { fly = true, ground = true }, -- Founder's Point
    [2354] = { fly = true, ground = true }, -- Silithus
    [2357] = { fly = false, ground = false }, -- City of Echoes
    [2358] = { fly = false, ground = false }, -- City of Echoes
    [2359] = { fly = true, ground = true }, -- The Dawnbreaker
    [2362] = { fly = false, ground = false }, -- Blackrock Depths
    [2363] = { fly = false, ground = false }, -- Blackrock Depths
    [2366] = { fly = true, ground = true }, -- The Wandering Isle
    [2367] = { fly = false, ground = false }, -- Vault of Memory
    [2368] = { fly = false, ground = false }, -- Hall of Awakening
    [2369] = { fly = true, ground = true }, -- Siren Isle
    [2371] = { fly = true, ground = true }, -- K'aresh
    [2372] = { fly = false, ground = false }, -- Arathi Highlands
    [2373] = { fly = false, ground = false }, -- The War Creche
    [2374] = { fly = false, ground = false }, -- Undermine
    [2375] = { fly = false, ground = false }, -- The Forgotten Vault
    [2379] = { fly = false, ground = false }, -- Ny'alotha, the Waking City
    [2381] = { fly = false, ground = false }, -- Ny'alotha, the Waking City
    [2382] = { fly = false, ground = false }, -- Ny'alotha, the Waking City
    [2383] = { fly = false, ground = false }, -- Ny'alotha, the Waking City
    [2384] = { fly = false, ground = false }, -- Ny'alotha, the Waking City
    [2387] = { fly = false, ground = true }, -- Operation: Floodgate
    [2388] = { fly = false, ground = false }, -- Operation: Floodgate
    [2393] = { fly = true, ground = true }, -- Silvermoon City
    [2394] = { fly = true, ground = true }, -- Labyrinth
    [2395] = { fly = true, ground = true }, -- Eversong Woods
    [2396] = { fly = false, ground = false }, -- Excavation Site 9
    [2397] = { fly = false, ground = false }, -- Slayer's Rise
    [2398] = { fly = true, ground = true }, -- K'aresh
    [2401] = { fly = true, ground = true }, -- Alliance Housing District
    [2402] = { fly = true, ground = true }, -- Horde Housing District
    [2403] = { fly = false, ground = true }, -- Vision of Orgrimmar
    [2404] = { fly = false, ground = true }, -- Vision of Stormwind
    [2405] = { fly = true, ground = true }, -- Voidstorm
    [2406] = { fly = false, ground = false }, -- Undermine
    [2407] = { fly = false, ground = false }, -- Undermine
    [2408] = { fly = false, ground = false }, -- Undermine
    [2409] = { fly = false, ground = false }, -- Undermine
    [2411] = { fly = false, ground = false }, -- Undermine
    [2413] = { fly = true, ground = true }, -- Harandar
    [2418] = { fly = false, ground = false }, -- Scarlet Halls
    [2420] = { fly = false, ground = false }, -- Sidestreet Sluice
    [2421] = { fly = false, ground = false }, -- Sidestreet Sluice
    [2422] = { fly = false, ground = false }, -- Sidestreet Sluice
    [2423] = { fly = false, ground = false }, -- Sidestreet Sluice
    [2424] = { fly = true, ground = true }, -- Isle of Quel'Danas
    [2425] = { fly = false, ground = false }, -- Demolition Dome
    [2426] = { fly = false, ground = false }, -- Demolition Dome
    [2427] = { fly = false, ground = false }, -- Sporefall
    [2428] = { fly = false, ground = false }, -- Undermine
    [2431] = { fly = false, ground = false }, -- Minimap_RingingDeeps_Coreway
    [2432] = { fly = false, ground = true }, -- Isle of Quel'Danas
    [2433] = { fly = false, ground = false }, -- Murder Row
    [2434] = { fly = false, ground = true }, -- Augurs' Terrace
    [2435] = { fly = false, ground = false }, -- The Illicit Rain
    [2437] = { fly = true, ground = true }, -- Zul'Aman
    [2438] = { fly = false, ground = false }, -- Scarlet Halls
    [2443] = { fly = false, ground = false }, -- Silvermoon City
    [2444] = { fly = true, ground = true }, -- Slayer's Rise
    [2447] = { fly = false, ground = false }, -- Dastardly Dome
    [2449] = { fly = false, ground = true }, -- Eco-Dome Al'dani
    [2451] = { fly = true, ground = true }, -- Arathi Highlands
    [2452] = { fly = false, ground = false }, -- Archival Assault
    [2453] = { fly = false, ground = false }, -- Archival Assault
    [2454] = { fly = false, ground = false }, -- Archival Assault
    [2455] = { fly = false, ground = false }, -- Archival Assault
    [2460] = { fly = false, ground = false }, -- Manaforge Omega
    [2461] = { fly = false, ground = false }, -- Manaforge Omega
    [2462] = { fly = false, ground = false }, -- Manaforge Omega
    [2463] = { fly = false, ground = false }, -- Manaforge Omega
    [2464] = { fly = false, ground = false }, -- Manaforge Omega
    [2465] = { fly = false, ground = true }, -- Manaforge Omega
    [2466] = { fly = false, ground = false }, -- Manaforge Omega
    [2467] = { fly = false, ground = false }, -- Manaforge Omega
    [2468] = { fly = false, ground = false }, -- Manaforge Omega
    [2469] = { fly = false, ground = false }, -- Manaforge Omega
    [2470] = { fly = false, ground = false }, -- Manaforge Omega
    [2471] = { fly = false, ground = false }, -- Manaforge Omega
    [2472] = { fly = true, ground = true }, -- Tazavesh
    [2476] = { fly = false, ground = false }, -- Archival Assault
    [2477] = { fly = false, ground = false }, -- Voidscar Cavern
    [2479] = { fly = true, ground = true }, -- Voidstorm
    [2480] = { fly = true, ground = true }, -- Harandar
    [2481] = { fly = false, ground = false }, -- Eastern Kingdoms
    [2484] = { fly = false, ground = false }, -- Voidrazor Sanctuary
    [2492] = { fly = false, ground = false }, -- Windrunner Spire
    [2493] = { fly = false, ground = false }, -- Windrunner Spire
    [2494] = { fly = false, ground = false }, -- Windrunner Spire
    [2496] = { fly = false, ground = false }, -- Windrunner Spire
    [2497] = { fly = false, ground = false }, -- Windrunner Spire
    [2498] = { fly = false, ground = false }, -- Windrunner Spire
    [2499] = { fly = false, ground = false }, -- Windrunner Spire
    [2500] = { fly = false, ground = true }, -- The Blinding Vale
    [2501] = { fly = false, ground = true }, -- Maisara Caverns
    [2502] = { fly = false, ground = false }, -- Shadow Enclave
    [2503] = { fly = false, ground = false }, -- Twilight Crypts
    [2504] = { fly = false, ground = false }, -- Twilight Crypts
    [2505] = { fly = false, ground = false }, -- Gulf of Memory
    [2506] = { fly = false, ground = false }, -- Shadowguard Point
    [2507] = { fly = false, ground = false }, -- Torment's Rise
    [2509] = { fly = true, ground = true }, -- Vaults of Atal'Utek
    [2510] = { fly = false, ground = true }, -- The Grudge Pit
    [2511] = { fly = false, ground = false }, -- Magisters' Terrace
    [2512] = { fly = true, ground = true }, -- The Coiled Isle
    [2513] = { fly = false, ground = true }, -- Den of Nalorakk
    [2514] = { fly = false, ground = false }, -- Den of Nalorakk
    [2515] = { fly = false, ground = false }, -- Magister's Terrace
    [2516] = { fly = false, ground = false }, -- Magister's Terrace
    [2517] = { fly = false, ground = false }, -- Magister's Terrace
    [2518] = { fly = false, ground = false }, -- Magister's Terrace
    [2519] = { fly = false, ground = false }, -- Magister's Terrace
    [2520] = { fly = false, ground = false }, -- Magister's Terrace
    [2522] = { fly = false, ground = false }, -- Abundant Grotto
    [2523] = { fly = false, ground = false }, -- Abundant Grotto
    [2525] = { fly = false, ground = false }, -- The Darkway
    [2526] = { fly = false, ground = false }, -- Lair of Predaxas
    [2527] = { fly = false, ground = false }, -- Lair of Predaxas
    [2528] = { fly = false, ground = false }, -- Sunkiller Sanctum
    [2529] = { fly = false, ground = true }, -- The Voidspire
    [2530] = { fly = false, ground = false }, -- The Voidspire
    [2531] = { fly = true, ground = true }, -- The Dreamrift
    [2532] = { fly = false, ground = false }, -- The Dreamrift
    [2533] = { fly = false, ground = true }, -- March on Quel'Danas
    [2534] = { fly = false, ground = false }, -- March on Quel'Danas
    [2535] = { fly = false, ground = false }, -- Atal'Aman
    [2536] = { fly = true, ground = true }, -- Atal'Aman
    [2537] = { fly = false, ground = false }, -- Quel'Thalas
    [2540] = { fly = false, ground = false }, -- Sunkiller Sanctum
    [2541] = { fly = false, ground = false }, -- Arcantina
    [2545] = { fly = false, ground = true }, -- Parhelion Plaza
    [2547] = { fly = false, ground = true }, -- Collegiate Calamity
    [2556] = { fly = false, ground = false }, -- Nexus Point Xenas
    [2557] = { fly = true, ground = true }, -- Derelict Legion Vessel
    [2558] = { fly = true, ground = true }, -- Derelict Legion Vessel
    [2561] = { fly = false, ground = false }, -- Quel'Thalas
    [2564] = { fly = false, ground = false }, -- Den of Nalorakk
    [2565] = { fly = false, ground = true }, -- Isle of Quel'Danas
    [2566] = { fly = false, ground = false }, -- Isle of Quel'Danas
    [2567] = { fly = true, ground = true }, -- Eversong Woods
    [2568] = { fly = true, ground = true }, -- Zul'Aman
    [2569] = { fly = true, ground = true }, -- Isle of Quel'Danas
    [2571] = { fly = false, ground = false }, -- Sunkiller Sanctum
    [2572] = { fly = false, ground = false }, -- Voidscar Arena
    [2573] = { fly = false, ground = false }, -- Voidscar Arena
    [2574] = { fly = false, ground = false }, -- Voidscar Arena
    [2575] = { fly = false, ground = false }, -- Gulf of Memory
    [2576] = { fly = false, ground = false }, -- The Den
    [2577] = { fly = false, ground = false }, -- Collegiate Calamity
    [2578] = { fly = false, ground = false }, -- Collegiate Calamity
    [2579] = { fly = false, ground = false }, -- Wartha'nan Crypts
    [2580] = { fly = false, ground = false }, -- Loaknit Den
    [2581] = { fly = false, ground = false }, -- Voidburrow
    [2582] = { fly = false, ground = false }, -- Voidburrow
    [2583] = { fly = false, ground = false }, -- Wit'Kalar Crypt
    [2584] = { fly = false, ground = false }, -- Revantusk Sedge
    [2585] = { fly = false, ground = false }, -- Zul'Aman
    [2588] = { fly = false, ground = false }, -- Altar of Fangs
    [2589] = { fly = false, ground = false }, -- Altar of Fangs
    [2590] = { fly = false, ground = false }, -- Altar of Fangs
    [2594] = { fly = false, ground = false }, -- Eversong Woods
    [2598] = { fly = false, ground = true }, -- Ritual Site
    [2599] = { fly = false, ground = true }, -- Val
    [2600] = { fly = false, ground = true }, -- Naigtal
    [2606] = { fly = false, ground = false }, -- The Venomous Abyss
    [2607] = { fly = false, ground = false }, -- The Venomous Abyss
    [2608] = { fly = false, ground = false }, -- The Venomous Abyss
    [2609] = { fly = false, ground = false }, -- The Venomous Abyss
    [2610] = { fly = false, ground = false }, -- The Venomous Abyss
    [2613] = { fly = false, ground = false }, -- The Underbelly
    [2617] = { fly = false, ground = false }, -- Void Acropolis
    [2618] = { fly = false, ground = false }, -- Void Acropolis
    [2619] = { fly = false, ground = false }, -- Void Acropolis
    [2620] = { fly = false, ground = false }, -- Forgotten Depths
    [2621] = { fly = false, ground = false }, -- Forgotten Depths
    [2622] = { fly = false, ground = true }, -- Val
    [2623] = { fly = false, ground = true }, -- Naigtal
    [2632] = { fly = false, ground = false }, -- The Tidebound Grotto
    [2633] = { fly = false, ground = true }, -- The Ring of Glory
    [2634] = { fly = false, ground = false }, -- Venomfall Deeps
    [2635] = { fly = false, ground = true }, -- Gnarldor Isle
    [2636] = { fly = false, ground = false }, -- Vault of Restless Bones
    [2637] = { fly = false, ground = false }, -- Ruuk'Jar's Clutch
    [2638] = { fly = false, ground = false }, -- Profaned Mausoleum
    [2639] = { fly = false, ground = false }, -- Crypt of the Denied
    [2640] = { fly = false, ground = false }, -- Infested Tomb
    [2641] = { fly = false, ground = false }, -- Crypt of the Lost Warrior
    [2642] = { fly = false, ground = false }, -- Tomb of the Lost Priest
    [2643] = { fly = false, ground = false }, -- Crypt of the Lost Mason
    [2644] = { fly = false, ground = false }, -- Crypt of the Disgraced
    [2645] = { fly = false, ground = false }, -- Kin's Rest
    [2646] = { fly = false, ground = false }, -- Vilaldoun
    [2649] = { fly = false, ground = false }, -- The Lycaneum
    [2668] = { fly = true, ground = true }, -- The Great Sea
}

Navigation.mountData = mountData

Navigation.defaultMountInfo = { fly = true, ground = true }
