---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Lexicon
local Lexicon = MapPinEnhanced:GetModule("Lexicon")
local L = MapPinEnhanced.L
local iconPath = MapPinEnhanced.assetsPath .. "\\pins\\icons\\"

Lexicon.ENABLE_OPTION = "General.Lexicon.Enable"
Lexicon.ROW_HEIGHT = 42
Lexicon.MAX_VISIBLE_RESULTS = 5

-- BasePin and saved pins select configured outline artwork by icon key.
Lexicon.PIN_ICON_KEYS = {} ---@type table<string, string|number>
for key, icon in pairs(MapPinEnhanced:GetModule("Pins").PIN_ICONS) do
    Lexicon.PIN_ICON_KEYS[icon.icon] = key
end

---@class LexiconCategory
---@field label string
---@field aliases string[]
---@field texture string
---@field service boolean?

---@class LexiconEntry
---@field record LocationRecord
---@field text string
---@field zone string
---@field category LexiconCategory
---@field specialty string?
---@field specialtyLabel string?

---@class LexiconResult
---@field id string
---@field entry LexiconEntry?
---@field category string?
---@field specialty string?
---@field label string
---@field subtitle string
---@field texture string
---@field distance number?
---@field rank number
---@field service boolean?
---@field changeNumber number

---@type table<string, LexiconCategory>
Lexicon.CATEGORIES = {
    poi = { label = L["Point of interest"], aliases = { "poi", "location", "point of interest" }, texture = iconPath .. "xmarksthespot.png" },
    city = { label = L["City"], aliases = { "city", "capital" }, texture = iconPath .. "poi-hub.png" },
    dungeon = { label = L["Dungeon"], aliases = { "dungeon", "instance" }, texture = iconPath .. "dungeon.png" },
    raid = { label = L["Raid"], aliases = { "raid" }, texture = iconPath .. "raid.png" },
    delve = { label = L["Delve"], aliases = { "delve" }, texture = iconPath .. "delves-regular.png" },
    ["great-vault"] = { label = L["Vault"], aliases = { "vault", "great vault" }, texture = iconPath .. "greatvault-32x32.png" },
    ["lfr-npc"] = { label = L["Raid Finder"], aliases = { "lfr", "raid finder" }, texture = iconPath .. "raid.png" },
    ["vendor-repair"] = { label = L["Repair"], aliases = { "repair", "repairs" }, texture = iconPath .. "repair.png", service = true },
    vendor = { label = L["Vendor"], aliases = { "vendor", "merchant", "shop" }, texture = iconPath .. "quartermaster.png", service = true },
    banker = { label = L["Bank"], aliases = { "bank", "banker" }, texture = iconPath .. "banker.png", service = true },
    innkeeper = { label = L["Inn"], aliases = { "inn", "innkeeper", "hearthstone" }, texture = iconPath .. "innkeeper.png", service = true },
    auctioneer = { label = L["Auction House"], aliases = { "auction", "ah", "auction house", "auctioneer" }, texture = iconPath .. "auctioneer.png", service = true },
    stable = { label = L["Stable Master"], aliases = { "stable", "stable master" }, texture = iconPath .. "stablemaster.png", service = true },
    trainer = { label = L["Trainer"], aliases = { "trainer", "training" }, texture = iconPath .. "profession.png", service = true },
}

Lexicon.CATEGORIES.town = { label = L["Town"], aliases = { "town", "village" }, texture = iconPath .. "poi-town.png" }
Lexicon.CATEGORIES.mailbox = { label = L["Mailbox"], aliases = { "mail", "mailbox" }, texture = iconPath .. "mailbox.png", service = true }
Lexicon.CATEGORIES.class = { label = L["Class Trainer"], aliases = { "class", "class trainer" }, texture = iconPath ..
"class.png", service = true }
Lexicon.CATEGORIES.profession = { label = L["Profession Trainer"], aliases = { "profession", "profession trainer" }, texture =
iconPath .. "profession.png", service = true }
Lexicon.CATEGORIES["vendor-ammo"] = { label = L["Ammunition Vendor"], aliases = { "ammo", "ammunition", "ammunition vendor" }, texture =
iconPath .. "ammunition.png", service = true }
Lexicon.CATEGORIES["vendor-armor"] = { label = L["Armor Vendor"], aliases = { "armor", "armour", "armor vendor" }, texture =
iconPath .. "quartermaster.png", service = true }
Lexicon.CATEGORIES["vendor-bags"] = { label = L["Bag Vendor"], aliases = { "bag", "bags", "bag vendor" }, texture =
iconPath .. "quartermaster.png", service = true }
Lexicon.CATEGORIES["vendor-fishing"] = { label = L["Fishing Vendor"], aliases = { "fishing supplies", "fishing vendor" }, texture =
iconPath .. "professions_tracking_fish.png", service = true }
Lexicon.CATEGORIES["vendor-food"] = { label = L["Food Vendor"], aliases = { "food", "drink", "food vendor" }, texture =
iconPath .. "food.png", service = true }
Lexicon.CATEGORIES["vendor-general"] = { label = L["General Goods Vendor"], aliases = { "general goods", "general goods vendor" }, texture =
iconPath .. "quartermaster.png", service = true }
Lexicon.CATEGORIES["vendor-poisons"] = { label = L["Poison Vendor"], aliases = { "poison", "poisons", "poison vendor" }, texture =
iconPath .. "poisons.png", service = true }
Lexicon.CATEGORIES["vendor-profsupplies"] = { label = L["Profession Supplies Vendor"], aliases = { "profession supplies", "profession supplies vendor" }, texture =
iconPath .. "profession.png", service = true }
Lexicon.CATEGORIES["vendor-reagents"] = { label = L["Reagent Vendor"], aliases = { "reagent", "reagents", "reagent vendor" }, texture =
iconPath .. "reagents.png", service = true }
Lexicon.CATEGORIES["vendor-trade"] = { label = L["Trade Goods Vendor"], aliases = { "trade goods", "trade goods vendor" }, texture =
iconPath .. "quartermaster.png", service = true }
Lexicon.CATEGORIES["vendor-weapons"] = { label = L["Weapon Vendor"], aliases = { "weapon", "weapons", "weapon vendor" }, texture =
iconPath .. "quartermaster.png", service = true }

---@type table<string, string>
Lexicon.SPECIALTIES = {
    ALCHEMY = L["Alchemy"],
    BLACKSMITHING = L["Blacksmithing"],
    COOKING = L["Cooking"],
    ENCHANTING = L["Enchanting"],
    ENGINEERING = L["Engineering"],
    FIRST_AID = L["First Aid"],
    FISHING = L["Fishing"],
    HERBALISM = L["Herbalism"],
    LEATHERWORKING = L["Leatherworking"],
    MINING = L["Mining"],
    SKINNING = L["Skinning"],
    TAILORING = L["Tailoring"],
    PET_TRAINING = L["Pet Training"],
    PORTALS = L["Portals"],
    RIDING = L["Riding"],
    WEAPON_SKILLS = L["Weapon Skills"],
}
for _, token in ipairs({ "DRUID", "HUNTER", "MAGE", "PALADIN", "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR" }) do
    Lexicon.SPECIALTIES[token] = LOCALIZED_CLASS_NAMES_MALE[token]
end
