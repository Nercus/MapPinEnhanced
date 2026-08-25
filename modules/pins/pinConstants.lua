---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
---@field STYLE_MODE_PIN PinStyleMode
---@field STYLE_MODE_OUTLINE PinStyleMode
local Pins = MapPinEnhanced:GetModule("Pins")


---@enum (key) PinColor
Pins.PIN_COLORS_BY_NAME = {
    ["Red"] = CreateColor(0.929, 0.239, 0.212, 1),
    ["Orange"] = CreateColor(0.953, 0.506, 0.157, 1),
    ["Pale"] = CreateColor(0.925, 0.678, 0.412, 1),
    ["Yellow"] = CreateColor(0.949, 0.788, 0.149, 1),
    ["Green"] = CreateColor(0.349, 0.780, 0.345, 1),
    ["LightBlue"] = CreateColor(0.286, 0.753, 0.925, 1),
    ["DarkBlue"] = CreateColor(0.349, 0.518, 1.000, 1),
    ["Purple"] = CreateColor(0.639, 0.388, 0.925, 1),
    ["Pink"] = CreateColor(0.925, 0.424, 0.737, 1),
}

---@type PinColor
Pins.DEFAULT_COLOR = "Yellow"

---@alias PinStyleMode "pin" | "outline"
Pins.STYLE_MODE_PIN = "pin"
Pins.STYLE_MODE_OUTLINE = "outline"

---@class PinIcon
---@field path string the path to the icon, if usesAtlas is true, this is the atlas name
---@field usesAtlas boolean if true, the path is an atlas, otherwise it is a file path
---@field offset {x: number, y: number}? optional offset for the icon, if not set, it will be
---@field scale number? optional scale for the icon, if not set, it will be 1
---@field color ColorMixin the color used by the configured outline presentation when tracked

---@type table<string|number, PinIcon> configured icons with rendering metadata; other icons use default geometry
Pins.PIN_ICONS = {
    ["WildBattlePet"] = {
        path = "WildBattlePet",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.58, 0.07)
    },
    ["ArchBlob"] = {
        path = "ArchBlob",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.10, 0.07, 0.07)
    },
    ["Banker"] = {
        path = "Banker",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.45, 0.24, 0.16)
    },
    ["Focus"] = {
        path = "Focus",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.53, 0.10)
    },
    ["BattleMaster"] = {
        path = "BattleMaster",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.56, 0.10)
    },
    ["Ammunition"] = {
        path = "Ammunition",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.43, 0.24)
    },
    ["Class"] = {
        path = "Class",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.77, 0.61)
    },
    ["Profession"] = {
        path = "Profession",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.66, 0.37, 0.11)
    },
    ["Target"] = {
        path = "Target",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.67, 0.26)
    },
    ["Food"] = {
        path = "Food",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.45, 0.13)
    },
    ["Reagents"] = {
        path = "Reagents",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.71, 0.14)
    },
    ["Innkeeper"] = {
        path = "Innkeeper",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.73, 0.86)
    },
    ["Auctioneer"] = {
        path = "Auctioneer",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.39, 0.00)
    },
    ["Repair"] = {
        path = "Repair",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.18, 0.16)
    },
    ["Mailbox"] = {
        path = "Mailbox",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.62, 0.53)
    },
    ["FlightMaster"] = {
        path = "FlightMaster",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.00, 0.00)
    },
    ["None"] = {
        path = "None",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.25, 0.22)
    },
    ["QuestBlob"] = {
        path = "QuestBlob",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.45, 0.97)
    },
    ["TrivialQuests"] = {
        path = "TrivialQuests",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.50, 0.07)
    },
    ["Poisons"] = {
        path = "Poisons",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.50, 0.76, 0.01)
    },
    ["PlayerFriend"] = {
        path = "PlayerFriend",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.75, 0.02)
    },
    ["QuestRepeatableTurnin"] = {
        path = "QuestRepeatableTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.54, 1.00)
    },
    ["MantidTowerDestroyed"] = {
        path = "MantidTowerDestroyed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.96, 0.29, 0.04)
    },
    ["PortalRed"] = {
        path = "PortalRed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.12, 0.07)
    },
    ["QuestTurnin"] = {
        path = "QuestTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.59, 0.01)
    },
    ["Object"] = {
        path = "Object",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.62, 0.17)
    },
    ["Gear"] = {
        path = "Gear",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.58, 0.00)
    },
    ["MonsterFriend"] = {
        path = "MonsterFriend",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.73, 0.03)
    },
    ["MonsterEnemy"] = {
        path = "MonsterEnemy",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.01, 0.04)
    },
    ["PortalPurple"] = {
        path = "PortalPurple",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.00, 0.75)
    },
    ["DungeonSkull"] = {
        path = "DungeonSkull",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.08, 0.10)
    },
    ["PlayerNeutral"] = {
        path = "PlayerNeutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.84, 0.63, 0.00)
    },
    ["MonsterNeutral"] = {
        path = "MonsterNeutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.62, 0.17)
    },
    ["PortalBlue"] = {
        path = "PortalBlue",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.04, 0.35, 0.82)
    },
    ["QuestLegendaryTurnin"] = {
        path = "QuestLegendaryTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.49, 0.00)
    },
    ["QuestDaily"] = {
        path = "QuestDaily",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.19, 0.59, 1.00)
    },
    ["PlayerControlled"] = {
        path = "PlayerControlled",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.55, 0.45, 0.97)
    },
    ["VignetteLoot"] = {
        path = "VignetteLoot",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.74, 0.75)
    },
    ["VignetteEvent"] = {
        path = "VignetteEvent",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.66, 0.13)
    },
    ["PlayerEnemy"] = {
        path = "PlayerEnemy",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.00, 0.03)
    },
    ["PartyMember"] = {
        path = "PartyMember",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.40, 0.96)
    },
    ["XMarksTheSpot"] = {
        path = "XMarksTheSpot",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.84, 0.07, 0.08)
    },
    ["QuestObjective"] = {
        path = "QuestObjective",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.58, 0.00)
    },
    ["QuestLegendary"] = {
        path = "QuestLegendary",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.49, 0.00)
    },
    ["ArtifactQuest"] = {
        path = "ArtifactQuest",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.40, 0.96)
    },
    ["QuestNormal"] = {
        path = "QuestNormal",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.98, 0.74, 0.03)
    },
    ["VignetteLootElite"] = {
        path = "VignetteLootElite",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.49, 0.31, 0.14)
    },
    ["FlightPath"] = {
        path = "FlightPath",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.47, 0.60, 0.32)
    },
    ["VignetteEventElite"] = {
        path = "VignetteEventElite",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.49, 0.19)
    },
    ["ChatBallon"] = {
        path = "ChatBallon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.58, 0.00)
    },
    ["MantidTower"] = {
        path = "MantidTower",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.96, 0.50, 0.18)
    },
    ["RaidMember"] = {
        path = "RaidMember",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.40, 0.96)
    },
    ["VignetteKill"] = {
        path = "VignetteKill",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.66, 0.13)
    },
    ["QuestBonusObjective"] = {
        path = "QuestBonusObjective",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.58, 0.09)
    },
    ["ArtifactQuestTurnin"] = {
        path = "ArtifactQuestTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.40, 0.96)
    },
    ["SmallQuestBang"] = {
        path = "SmallQuestBang",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.55, 0.12)
    },
    ["VignetteKillElite"] = {
        path = "VignetteKillElite",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.58, 0.11)
    },
    ["GreenCross"] = {
        path = "GreenCross",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.41, 0.68, 0.07)
    },
    ["PlayerDeadBlip"] = {
        path = "PlayerDeadBlip",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.88, 0.87, 0.85)
    },
    ["PlayerPartyBlip"] = {
        path = "PlayerPartyBlip",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.00, 0.00)
    },
    ["PlayerRaidBlip"] = {
        path = "PlayerRaidBlip",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.88, 0.90, 0.88)
    },
    ["Vehicle-Air-Alliance"] = {
        path = "Vehicle-Air-Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.20, 0.15)
    },
    ["Vehicle-Air-Horde"] = {
        path = "Vehicle-Air-Horde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.16, 0.13)
    },
    ["Vehicle-Air-Occupied"] = {
        path = "Vehicle-Air-Occupied",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.66, 0.55, 0.06)
    },
    ["Vehicle-Air-Unoccupied"] = {
        path = "Vehicle-Air-Unoccupied",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.86, 0.84)
    },
    ["Vehicle-AllianceCart"] = {
        path = "Vehicle-AllianceCart",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.58, 0.92)
    },
    ["Vehicle-Carriage"] = {
        path = "Vehicle-Carriage",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.74, 0.48)
    },
    ["Vehicle-Ground-Occupied"] = {
        path = "Vehicle-Ground-Occupied",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.60, 0.10)
    },
    ["Vehicle-Ground-Unoccupied"] = {
        path = "Vehicle-Ground-Unoccupied",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.89, 0.87)
    },
    ["Vehicle-GrummleConvoy"] = {
        path = "Vehicle-GrummleConvoy",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.43, 0.95)
    },
    ["Vehicle-HammerGold-1"] = {
        path = "Vehicle-HammerGold-1",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.36, 0.36, 0.35)
    },
    ["Vehicle-HammerGold-2"] = {
        path = "Vehicle-HammerGold-2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.48, 0.18)
    },
    ["Vehicle-HammerGold-3"] = {
        path = "Vehicle-HammerGold-3",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.52, 0.19)
    },
    ["Vehicle-HammerGold"] = {
        path = "Vehicle-HammerGold",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.56, 0.21)
    },
    ["Vehicle-HordeCart"] = {
        path = "Vehicle-HordeCart",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.52, 0.32, 0.12)
    },
    ["Vehicle-Mogu"] = {
        path = "Vehicle-Mogu",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.84, 0.77)
    },
    ["Vehicle-SilvershardMines-Arrow"] = {
        path = "Vehicle-SilvershardMines-Arrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.11, 0.09)
    },
    ["Vehicle-SilvershardMines-MineCart"] = {
        path = "Vehicle-SilvershardMines-MineCart",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.42, 0.41, 0.39)
    },
    ["Vehicle-SilvershardMines-MineCartBlue"] = {
        path = "Vehicle-SilvershardMines-MineCartBlue",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.19, 0.42, 1.00)
    },
    ["Vehicle-SilvershardMines-MineCartRed"] = {
        path = "Vehicle-SilvershardMines-MineCartRed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.02, 0.05)
    },
    ["Vehicle-TempleofKotmogu-CyanBall"] = {
        path = "Vehicle-TempleofKotmogu-CyanBall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.56, 0.97, 0.69)
    },
    ["Vehicle-TempleofKotmogu-GreenBall"] = {
        path = "Vehicle-TempleofKotmogu-GreenBall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.84, 0.83)
    },
    ["Vehicle-TempleofKotmogu-OrangeBall"] = {
        path = "Vehicle-TempleofKotmogu-OrangeBall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.75, 0.12)
    },
    ["Vehicle-TempleofKotmogu-PurpleBall"] = {
        path = "Vehicle-TempleofKotmogu-PurpleBall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.50, 0.94)
    },
    ["Vehicle-Trap-Gold"] = {
        path = "Vehicle-Trap-Gold",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.59, 0.20)
    },
    ["Vehicle-Trap-Grey"] = {
        path = "Vehicle-Trap-Grey",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.63, 0.61)
    },
    ["Vehicle-Trap-Red"] = {
        path = "Vehicle-Trap-Red",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.30, 0.25)
    },
    ["QuestSkull"] = {
        path = "QuestSkull",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.58, 0.00)
    },
    ["Focus-Tracker"] = {
        path = "Focus-Tracker",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.53, 0.10)
    },
    ["MagePortalAlliance"] = {
        path = "MagePortalAlliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.42, 0.46, 0.84)
    },
    ["MagePortalHorde"] = {
        path = "MagePortalHorde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.86, 0.37, 0.42)
    },
    ["QuestArtifact"] = {
        path = "QuestArtifact",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.62, 0.10)
    },
    ["QuestArtifactTurnin"] = {
        path = "QuestArtifactTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.56, 0.00)
    },
    ["Target-Tracker"] = {
        path = "Target-Tracker",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.67, 0.26)
    },
    ["WarlockPortalAlliance"] = {
        path = "WarlockPortalAlliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.23, 0.61, 0.87)
    },
    ["WarlockPortalHorde"] = {
        path = "WarlockPortalHorde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.99, 0.37, 0.35)
    },
    ["WildBattlePet-Tracker"] = {
        path = "WildBattlePet-Tracker",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.59, 0.40, 0.10)
    },
    ["WildBattlePetCapturable"] = {
        path = "WildBattlePetCapturable",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.56, 0.19)
    },
    ["CrossedFlags"] = {
        path = "CrossedFlags",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.25, 0.15)
    },
    ["CrossedFlagsWithTimer"] = {
        path = "CrossedFlagsWithTimer",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.21, 0.17)
    },
    ["MiniMap-DeadArrow"] = {
        path = "MiniMap-DeadArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.88, 0.27, 0.23)
    },
    ["MiniMap-PositionArrows"] = {
        path = "MiniMap-PositionArrows",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.00, 0.00)
    },
    ["MiniMap-QuestArrow"] = {
        path = "MiniMap-QuestArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.57, 0.26)
    },
    ["MiniMap-VignetteArrow"] = {
        path = "MiniMap-VignetteArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.58, 0.61, 0.83)
    },
    ["MinimapArrow"] = {
        path = "MinimapArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.61, 0.45, 0.00)
    },
    ["Rotating-MinimapArrow"] = {
        path = "Rotating-MinimapArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.23, 1.00)
    },
    ["Rotating-MinimapGroupArrow"] = {
        path = "Rotating-MinimapGroupArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.62, 0.17)
    },
    ["Rotating-MinimapGuideArrow"] = {
        path = "Rotating-MinimapGuideArrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.56, 0.00)
    },
    ["MiniMap-PositionArrowDown"] = {
        path = "MiniMap-PositionArrowDown",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.81, 0.80)
    },
    ["MiniMap-PositionArrowUp"] = {
        path = "MiniMap-PositionArrowUp",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.79, 0.77)
    },
    ["MovieRecordingIcon"] = {
        path = "MovieRecordingIcon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.98, 0.53, 0.24)
    },
    ["DemonInvasion1"] = {
        path = "DemonInvasion1",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.12, 0.68, 0.00)
    },
    ["DemonInvasion2"] = {
        path = "DemonInvasion2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.39, 0.61, 0.00)
    },
    ["DemonInvasion3"] = {
        path = "DemonInvasion3",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.39, 0.58, 0.08)
    },
    ["DemonInvasion4"] = {
        path = "DemonInvasion4",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.50, 0.57, 0.03)
    },
    ["DemonInvasion5"] = {
        path = "DemonInvasion5",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.80, 0.10)
    },
    ["poi-alliance"] = {
        path = "poi-alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.65, 0.00)
    },
    ["poi-horde"] = {
        path = "poi-horde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.14, 0.13)
    },
    ["poi-workorders"] = {
        path = "poi-workorders",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.51, 0.30)
    },
    ["poi-majorcity"] = {
        path = "poi-majorcity",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.35, 0.36, 0.35)
    },
    ["poi-town"] = {
        path = "poi-town",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.60, 0.51, 0.01)
    },
    ["map-icon-ignored-blueexclaimation"] = {
        path = "map-icon-ignored-blueexclaimation",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.12, 0.31, 0.53)
    },
    ["map-icon-ignored-bluequestion"] = {
        path = "map-icon-ignored-bluequestion",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.33, 0.51)
    },
    ["map-icon-deathknightclasshall"] = {
        path = "map-icon-deathknightclasshall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.57, 0.42, 0.59)
    },
    ["Dungeon"] = {
        path = "Dungeon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.41, 0.61, 0.57)
    },
    ["Raid"] = {
        path = "Raid",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.73, 0.20)
    },
    ["map-icon-SuramarDoor.tga"] = {
        path = "map-icon-SuramarDoor.tga",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.55, 0.26)
    },
    ["AncientMana"] = {
        path = "AncientMana",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.37, 0.52, 0.88)
    },
    ["LegionfallMapBanner"] = {
        path = "LegionfallMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.47, 0.11)
    },
    ["poi-transmogrifier"] = {
        path = "poi-transmogrifier",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.14, 0.95)
    },
    ["DemonShip"] = {
        path = "DemonShip",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.57, 0.66, 0.00)
    },
    ["DemonShip_East"] = {
        path = "DemonShip_East",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.57, 0.66, 0.00)
    },
    ["poi-graveyard-neutral"] = {
        path = "poi-graveyard-neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.25, 0.24)
    },
    ["poi-door-arrow-down"] = {
        path = "poi-door-arrow-down",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.60, 0.04)
    },
    ["poi-door-arrow-up"] = {
        path = "poi-door-arrow-up",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.60, 0.08)
    },
    ["poi-door"] = {
        path = "poi-door",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.52, 0.44)
    },
    ["TaxiNode_Alliance"] = {
        path = "TaxiNode_Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.36, 0.66, 1.00)
    },
    ["TaxiNode_Horde"] = {
        path = "TaxiNode_Horde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.39, 0.34)
    },
    ["TaxiNode_Neutral"] = {
        path = "TaxiNode_Neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.60, 0.16)
    },
    ["FlightMaster_Argus-TaxiNode_Neutral"] = {
        path = "FlightMaster_Argus-TaxiNode_Neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.46, 0.00)
    },
    ["poi-rift1"] = {
        path = "poi-rift1",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.53, 0.78, 0.12)
    },
    ["poi-rift2"] = {
        path = "poi-rift2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.66, 0.00)
    },
    ["FlightMasterArgus"] = {
        path = "FlightMasterArgus",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.58, 0.11)
    },
    ["poi-door-down"] = {
        path = "poi-door-down",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.66, 0.12)
    },
    ["poi-door-left"] = {
        path = "poi-door-left",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.61, 0.27)
    },
    ["poi-door-right"] = {
        path = "poi-door-right",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.66, 0.12)
    },
    ["poi-door-up"] = {
        path = "poi-door-up",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.91, 0.78, 0.05)
    },
    ["AzeriteReady"] = {
        path = "AzeriteReady",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.49, 0.99)
    },
    ["AzeriteSpawning"] = {
        path = "AzeriteSpawning",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.76, 0.75)
    },
    ["Warboard"] = {
        path = "Warboard",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.61, 0.44, 0.21)
    },
    ["Warfront-AllianceDot"] = {
        path = "Warfront-AllianceDot",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.00, 0.00)
    },
    ["Warfront-HordeDot"] = {
        path = "Warfront-HordeDot",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.00, 0.00)
    },
    ["Warfront-AllianceHero"] = {
        path = "Warfront-AllianceHero",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.42, 0.88, 0.99)
    },
    ["Warfront-HordeHero"] = {
        path = "Warfront-HordeHero",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.42, 0.42)
    },
    ["Warfronts-BaseMapIcons-Alliance-Armory-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Armory-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.34, 0.87)
    },
    ["Warfronts-BaseMapIcons-Alliance-Barracks-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Barracks-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.39, 0.89)
    },
    ["Warfronts-BaseMapIcons-Alliance-Heroes-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Heroes-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.34, 0.88)
    },
    ["Warfronts-BaseMapIcons-Alliance-MainHall-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-MainHall-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.33, 0.85)
    },
    ["Warfronts-BaseMapIcons-Alliance-Workshop-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Workshop-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.34, 0.88)
    },
    ["Warfronts-BaseMapIcons-Empty-Armory-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-Armory-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.56, 0.56, 0.55)
    },
    ["Warfronts-BaseMapIcons-Empty-Barracks-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-Barracks-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.02, 0.01, 0.01)
    },
    ["Warfronts-BaseMapIcons-Empty-Heroes-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-Heroes-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.47, 0.47, 0.45)
    },
    ["Warfronts-BaseMapIcons-Empty-MainHall-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-MainHall-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.49, 0.49, 0.47)
    },
    ["Warfronts-BaseMapIcons-Empty-Workshop-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-Workshop-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.37, 0.36, 0.35)
    },
    ["Warfronts-BaseMapIcons-Horde-Armory-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-Armory-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.05, 0.06)
    },
    ["Warfronts-BaseMapIcons-Horde-Barracks-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-Barracks-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.04, 0.06)
    },
    ["Warfronts-BaseMapIcons-Horde-Heroes-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-Heroes-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.37, 0.00)
    },
    ["Warfronts-BaseMapIcons-Horde-MainHall-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-MainHall-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.05, 0.07)
    },
    ["Warfronts-BaseMapIcons-Horde-Workshop-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-Workshop-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.07, 0.07)
    },
    ["Warfronts-FieldMapIcons-Alliance-Banner-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Alliance-Banner-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.19, 0.36, 0.88)
    },
    ["Warfronts-FieldMapIcons-Alliance-LumberMill-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Alliance-LumberMill-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.36, 0.89)
    },
    ["Warfronts-FieldMapIcons-Alliance-Mine-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Alliance-Mine-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.33, 0.83)
    },
    ["Warfronts-FieldMapIcons-Empty-Banner-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Empty-Banner-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.12, 0.11, 0.10)
    },
    ["Warfronts-FieldMapIcons-Empty-LumberMill-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Empty-LumberMill-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.57, 0.57, 0.55)
    },
    ["Warfronts-FieldMapIcons-Empty-Mine-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Empty-Mine-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.43, 0.41)
    },
    ["Warfronts-FieldMapIcons-Horde-Banner-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Horde-Banner-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.05, 0.07)
    },
    ["Warfronts-FieldMapIcons-Horde-LumberMill-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Horde-LumberMill-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.05, 0.07)
    },
    ["Warfronts-FieldMapIcons-Horde-Mine-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Horde-Mine-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.06, 0.07)
    },
    ["Warfronts-FieldMapIcons-Neutral-Banner-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Neutral-Banner-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.64, 0.04)
    },
    ["Warfronts-FieldMapIcons-Neutral-Mine-Minimap"] = {
        path = "Warfronts-FieldMapIcons-Neutral-Mine-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.62, 0.02)
    },
    ["Warfront-NeutralHero"] = {
        path = "Warfront-NeutralHero",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.61, 0.30)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionArmory-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionArmory-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.21, 0.39, 0.89)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionBarracks-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionBarracks-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.39, 0.89)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionHeroes-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionHeroes-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.43, 0.95)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionMainHall-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionMainHall-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.40, 0.86)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionWorkshop-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionWorkshop-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.41, 0.91)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionArmory-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionArmory-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.81, 0.05, 0.07)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionBarracks-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionBarracks-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.05, 0.07)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionHeroes-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionHeroes-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.06, 0.08)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionMainHall-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionMainHall-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.05, 0.07)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionWorkshop-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionWorkshop-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.00, 0.05)
    },
    ["Warfront-AllianceHero-Gold"] = {
        path = "Warfront-AllianceHero-Gold",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.33, 0.50, 0.91)
    },
    ["Warfront-AllianceHero-Silver"] = {
        path = "Warfront-AllianceHero-Silver",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.35, 0.51, 0.91)
    },
    ["Warfront-HordeHero-Gold"] = {
        path = "Warfront-HordeHero-Gold",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.25, 0.22)
    },
    ["Warfront-HordeHero-Silver"] = {
        path = "Warfront-HordeHero-Silver",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.25, 0.22)
    },
    ["Warfront-NeutralHero-Gold"] = {
        path = "Warfront-NeutralHero-Gold",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.59, 0.20)
    },
    ["Warfront-NeutralHero-Silver"] = {
        path = "Warfront-NeutralHero-Silver",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.59, 0.26)
    },
    ["Warfront-AllianceCommander-Muradin"] = {
        path = "Warfront-AllianceCommander-Muradin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.60, 0.34, 0.00)
    },
    ["Warfront-AllianceCommander-Trollbane"] = {
        path = "Warfront-AllianceCommander-Trollbane",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.45, 0.23)
    },
    ["Warfront-AllianceCommander-Turalyon"] = {
        path = "Warfront-AllianceCommander-Turalyon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.55, 0.35)
    },
    ["Warfront-AllianceWave1"] = {
        path = "Warfront-AllianceWave1",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.64, 0.22)
    },
    ["Warfront-AllianceWave2"] = {
        path = "Warfront-AllianceWave2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.51, 0.17)
    },
    ["Warfront-AllianceWave3"] = {
        path = "Warfront-AllianceWave3",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.21, 0.41, 1.00)
    },
    ["AllianceSymbol"] = {
        path = "AllianceSymbol",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.21, 0.41, 1.00)
    },
    ["HordeSymbol"] = {
        path = "HordeSymbol",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.00, 0.04)
    },
    ["Islands-AllianceBoat"] = {
        path = "Islands-AllianceBoat",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.11, 0.09, 0.07)
    },
    ["Islands-AzeriteBoss"] = {
        path = "Islands-AzeriteBoss",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 1.00, 0.43)
    },
    ["Islands-AzeriteChest"] = {
        path = "Islands-AzeriteChest",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.61, 0.79)
    },
    ["Islands-HordeBoat"] = {
        path = "Islands-HordeBoat",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.45, 0.02, 0.02)
    },
    ["Islands-MarkedArea"] = {
        path = "Islands-MarkedArea",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["Warfront-HordeWave1"] = {
        path = "Warfront-HordeWave1",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.00, 0.02)
    },
    ["Warfront-HordeWave2"] = {
        path = "Warfront-HordeWave2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.04, 0.06)
    },
    ["Warfront-HordeWave3"] = {
        path = "Warfront-HordeWave3",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.00, 0.00)
    },
    ["Warfronts-BaseMapIcons-Alliance-Tower-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Tower-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.31, 0.51, 1.00)
    },
    ["Warfronts-BaseMapIcons-Empty-Tower-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Empty-Tower-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.48, 0.47, 0.46)
    },
    ["Warfronts-BaseMapIcons-Horde-Tower-Minimap"] = {
        path = "Warfronts-BaseMapIcons-Horde-Tower-Minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.04, 0.06)
    },
    ["poi-bountyplayer-alliance"] = {
        path = "poi-bountyplayer-alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.45, 0.48, 1.00)
    },
    ["poi-bountyplayer-horde"] = {
        path = "poi-bountyplayer-horde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.16, 0.14)
    },
    ["Warfront-HordeCommander-Eitrigg"] = {
        path = "Warfront-HordeCommander-Eitrigg",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.46, 0.41, 0.17)
    },
    ["Warfront-HordeCommander-LadyLiadrin"] = {
        path = "Warfront-HordeCommander-LadyLiadrin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.47, 0.29)
    },
    ["Warfront-HordeCommander-Rokhan"] = {
        path = "Warfront-HordeCommander-Rokhan",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.99, 0.40, 0.47)
    },
    ["AllianceWarfrontMapBanner"] = {
        path = "AllianceWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.72, 0.56, 0.20)
    },
    ["HordeWarfrontMapBanner"] = {
        path = "HordeWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.60, 0.02)
    },
    ["Islands-QuestBang"] = {
        path = "Islands-QuestBang",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.62, 0.06)
    },
    ["Islands-QuestBangDisable"] = {
        path = "Islands-QuestBangDisable",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.57, 0.53, 0.45)
    },
    ["Islands-QuestDisable"] = {
        path = "Islands-QuestDisable",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.02, 0.02, 0.01)
    },
    ["Islands-QuestTurnin"] = {
        path = "Islands-QuestTurnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.60, 0.02)
    },
    ["Warfront-Alliance-SiegeEngine"] = {
        path = "Warfront-Alliance-SiegeEngine",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.07, 0.42, 0.78)
    },
    ["Warfront-Horde-Demolisher"] = {
        path = "Warfront-Horde-Demolisher",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["FlightMasterFerry"] = {
        path = "FlightMasterFerry",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.59, 0.33)
    },
    ["FlightMaster_Ferry-TaxiNode_Alliance"] = {
        path = "FlightMaster_Ferry-TaxiNode_Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.44, 0.60)
    },
    ["TaxiNode_Continent_Alliance"] = {
        path = "TaxiNode_Continent_Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.31, 0.42)
    },
    ["TaxiNode_Continent_Horde"] = {
        path = "TaxiNode_Continent_Horde",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.67, 0.43, 0.37)
    },
    ["TaxiNode_Continent_Neutral"] = {
        path = "TaxiNode_Continent_Neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.57, 0.31)
    },
    ["Map-MarkedDefeated"] = {
        path = "Map-MarkedDefeated",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["Warfronts-BaseMapIcons-Alliance-Armory-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Armory-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.13, 0.42, 0.89)
    },
    ["Warfronts-BaseMapIcons-Alliance-Barracks-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Barracks-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.15, 0.29, 0.72)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionArmory-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionArmory-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.40, 0.86)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionBarracks-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionBarracks-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.40, 0.88)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionHeroes-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionHeroes-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.26, 0.44, 0.91)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionMainHall-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionMainHall-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.36, 0.81)
    },
    ["Warfronts-BaseMapIcons-Alliance-ConstructionWorkshop-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-ConstructionWorkshop-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.36, 0.83)
    },
    ["Warfronts-BaseMapIcons-Alliance-Heroes-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Heroes-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.36, 0.89)
    },
    ["Warfronts-BaseMapIcons-Alliance-MainHall-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-MainHall-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.15, 0.31, 0.81)
    },
    ["Warfronts-BaseMapIcons-Alliance-Tower-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Tower-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.11, 0.55, 1.00)
    },
    ["Warfronts-BaseMapIcons-Alliance-Workshop-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Alliance-Workshop-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.35, 0.89)
    },
    ["Warfronts-BaseMapIcons-Empty-Armory-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-Armory-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.07, 0.08, 0.07)
    },
    ["Warfronts-BaseMapIcons-Empty-Barracks-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-Barracks-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.19, 0.18)
    },
    ["Warfronts-BaseMapIcons-Empty-Heroes-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-Heroes-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.50, 0.49)
    },
    ["Warfronts-BaseMapIcons-Empty-MainHall-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-MainHall-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.54, 0.53, 0.52)
    },
    ["Warfronts-BaseMapIcons-Empty-Tower-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-Tower-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.09, 0.08, 0.07)
    },
    ["Warfronts-BaseMapIcons-Empty-Workshop-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Empty-Workshop-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.53, 0.53, 0.51)
    },
    ["Warfronts-BaseMapIcons-Horde-Armory-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-Armory-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.09, 0.09)
    },
    ["Warfronts-BaseMapIcons-Horde-Barracks-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-Barracks-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionArmory-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionArmory-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.06, 0.08)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionBarracks-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionBarracks-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.00, 0.00)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionHeroes-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionHeroes-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.06, 0.08)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionMainHall-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionMainHall-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.11, 0.10)
    },
    ["Warfronts-BaseMapIcons-Horde-ConstructionWorkshop-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-ConstructionWorkshop-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.91, 0.00, 0.04)
    },
    ["Warfronts-BaseMapIcons-Horde-Heroes-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-Heroes-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.06, 0.08)
    },
    ["Warfronts-BaseMapIcons-Horde-MainHall-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-MainHall-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.04, 0.05)
    },
    ["Warfronts-BaseMapIcons-Horde-Tower-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-Tower-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["Warfronts-BaseMapIcons-Horde-Workshop-Minimap-small"] = {
        path = "Warfronts-BaseMapIcons-Horde-Workshop-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.93, 0.03, 0.07)
    },
    ["Warfronts-FieldMapIcons-Alliance-Banner-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Alliance-Banner-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.14, 0.31, 0.84)
    },
    ["Warfronts-FieldMapIcons-Alliance-LumberMill-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Alliance-LumberMill-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.10, 0.39, 0.89)
    },
    ["Warfronts-FieldMapIcons-Alliance-Mine-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Alliance-Mine-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.15, 0.30, 0.77)
    },
    ["Warfronts-FieldMapIcons-Empty-Banner-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Empty-Banner-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.06, 0.05)
    },
    ["Warfronts-FieldMapIcons-Empty-LumberMill-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Empty-LumberMill-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.25, 0.25, 0.24)
    },
    ["Warfronts-FieldMapIcons-Empty-Mine-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Empty-Mine-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.51, 0.50, 0.47)
    },
    ["Warfronts-FieldMapIcons-Horde-Banner-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Horde-Banner-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.05, 0.06)
    },
    ["Warfronts-FieldMapIcons-Horde-LumberMill-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Horde-LumberMill-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.05, 0.07)
    },
    ["Warfronts-FieldMapIcons-Horde-Mine-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Horde-Mine-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.05, 0.07)
    },
    ["Warfronts-FieldMapIcons-Neutral-Banner-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Neutral-Banner-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.55, 0.01)
    },
    ["Warfronts-FieldMapIcons-Neutral-Mine-Minimap-small"] = {
        path = "Warfronts-FieldMapIcons-Neutral-Mine-Minimap-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.62, 0.02)
    },
    ["poi-scrapper"] = {
        path = "poi-scrapper",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.58, 0.38)
    },
    ["poi-islands-table"] = {
        path = "poi-islands-table",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.41, 0.24)
    },
    ["AllianceAssaultsMapBanner"] = {
        path = "AllianceAssaultsMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.58, 0.23)
    },
    ["HordeAssaultsMapBanner"] = {
        path = "HordeAssaultsMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.84, 0.40, 0.06)
    },
    ["poi-traveldirections-arrow"] = {
        path = "poi-traveldirections-arrow",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.55, 0.01)
    },
    ["poi-traveldirections-arrow2"] = {
        path = "poi-traveldirections-arrow2",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.50, 0.42, 0.02)
    },
    ["mechagon-projects"] = {
        path = "mechagon-projects",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.67, 0.34)
    },
    ["MinimapTrident"] = {
        path = "MinimapTrident",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.66, 0.53, 0.20)
    },
    ["QuestDaily-MainMap"] = {
        path = "QuestDaily-MainMap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.51, 1.00)
    },
    ["QuestRepeatableTurnin-MainMap"] = {
        path = "QuestRepeatableTurnin-MainMap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.47, 1.00)
    },
    ["nazjatar-nagaevent"] = {
        path = "nazjatar-nagaevent",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.24, 0.70)
    },
    ["poi-nzothpylon"] = {
        path = "poi-nzothpylon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.97, 0.24, 0.20)
    },
    ["poi-nzothvision"] = {
        path = "poi-nzothvision",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.32, 0.09)
    },
    ["Quest-Campaign-Available"] = {
        path = "Quest-Campaign-Available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.58, 0.11)
    },
    ["Quest-Campaign-TurnIn"] = {
        path = "Quest-Campaign-TurnIn",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.96, 0.70, 0.00)
    },
    ["Waypoint-MapPin-Minimap-Tracked"] = {
        path = "Waypoint-MapPin-Minimap-Tracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.58, 0.05)
    },
    ["Waypoint-MapPin-Minimap-Untracked"] = {
        path = "Waypoint-MapPin-Minimap-Untracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.60, 0.05)
    },
    ["Quest-DailyCampaign-Available"] = {
        path = "Quest-DailyCampaign-Available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.13, 0.62, 0.98)
    },
    ["Quest-DailyCampaign-TurnIn"] = {
        path = "Quest-DailyCampaign-TurnIn",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.67, 0.98)
    },
    ["Embercourt-Guest-AlexandrosMograine"] = {
        path = "Embercourt-Guest-AlexandrosMograine",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.51, 0.52)
    },
    ["Embercourt-Guest-BaronessVashj"] = {
        path = "Embercourt-Guest-BaronessVashj",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.32, 0.40, 0.60)
    },
    ["Embercourt-Guest-Choofa"] = {
        path = "Embercourt-Guest-Choofa",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.44, 0.90)
    },
    ["Embercourt-Guest-Countess"] = {
        path = "Embercourt-Guest-Countess",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.13, 0.08, 0.07)
    },
    ["Embercourt-Guest-CryptkeeperKassir"] = {
        path = "Embercourt-Guest-CryptkeeperKassir",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.13, 0.13, 0.17)
    },
    ["Embercourt-Guest-DromanAliothe"] = {
        path = "Embercourt-Guest-DromanAliothe",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.98, 0.00)
    },
    ["Embercourt-Guest-GrandmasterVole"] = {
        path = "Embercourt-Guest-GrandmasterVole",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.04, 0.02, 0.02)
    },
    ["Embercourt-Guest-HuntCaptainKorayn"] = {
        path = "Embercourt-Guest-HuntCaptainKorayn",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.12, 0.08, 0.15)
    },
    ["Embercourt-Guest-Kleia"] = {
        path = "Embercourt-Guest-Kleia",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.62, 0.99)
    },
    ["Embercourt-Guest-LadyMoonberry"] = {
        path = "Embercourt-Guest-LadyMoonberry",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 1.00, 1.00)
    },
    ["Embercourt-Guest-Mikanikos"] = {
        path = "Embercourt-Guest-Mikanikos",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.54, 0.30)
    },
    ["Embercourt-Guest-PlagueDeviserMarileth"] = {
        path = "Embercourt-Guest-PlagueDeviserMarileth",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.04, 0.03)
    },
    ["Embercourt-Guest-PolemarchAdrestes"] = {
        path = "Embercourt-Guest-PolemarchAdrestes",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.15, 0.60, 0.78)
    },
    ["Embercourt-Guest-PrinceRenathal"] = {
        path = "Embercourt-Guest-PrinceRenathal",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.10, 0.08, 0.07)
    },
    ["Embercourt-Guest-Rendle"] = {
        path = "Embercourt-Guest-Rendle",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.56, 0.64, 0.02)
    },
    ["Embercourt-Guest-Sika"] = {
        path = "Embercourt-Guest-Sika",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.40, 0.53, 0.82)
    },
    ["Embercourt-Guest-Stonehead"] = {
        path = "Embercourt-Guest-Stonehead",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.04, 0.03)
    },
    ["poi-soulspiritghost"] = {
        path = "poi-soulspiritghost",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.67, 0.82, 0.91)
    },
    ["poi-torghast"] = {
        path = "poi-torghast",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.31, 0.36, 0.39)
    },
    ["WarMode-Broker-32x32"] = {
        path = "WarMode-Broker-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.76, 0.84)
    },
    ["ChromieTime-32x32"] = {
        path = "ChromieTime-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.50, 0.13)
    },
    ["TeleportationNetwork-32x32"] = {
        path = "TeleportationNetwork-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.59, 0.74)
    },
    ["Barbershop-32x32"] = {
        path = "Barbershop-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.24, 0.23)
    },
    ["TorghastDoor-32x32"] = {
        path = "TorghastDoor-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.07, 0.12)
    },
    ["TorghastDoor-ArrowDown-32x32"] = {
        path = "TorghastDoor-ArrowDown-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.02, 0.00, 0.21)
    },
    ["TorghastDoor-ArrowLeft-32x32"] = {
        path = "TorghastDoor-ArrowLeft-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.84, 0.72, 0.00)
    },
    ["TorghastDoor-ArrowRight-32x32"] = {
        path = "TorghastDoor-ArrowRight-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.73, 0.00)
    },
    ["TorghastDoor-ArrowUp-32x32"] = {
        path = "TorghastDoor-ArrowUp-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.86, 0.71, 0.06)
    },
    ["Embercourt-Guest-Cudgelface"] = {
        path = "Embercourt-Guest-Cudgelface",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.09, 0.06, 0.05)
    },
    ["Embercourt-Guest-Pelagos"] = {
        path = "Embercourt-Guest-Pelagos",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.43, 0.57)
    },
    ["animachannel-icon-kyrian-map"] = {
        path = "animachannel-icon-kyrian-map",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.64, 0.92)
    },
    ["animachannel-icon-necrolord-map"] = {
        path = "animachannel-icon-necrolord-map",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.28, 0.22)
    },
    ["animachannel-icon-nightfae-map"] = {
        path = "animachannel-icon-nightfae-map",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.25, 0.44, 0.83)
    },
    ["animachannel-icon-venthyr-map"] = {
        path = "animachannel-icon-venthyr-map",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.59, 0.16, 0.22)
    },
    ["flightmaster_bastion-taxinode_neutral"] = {
        path = "flightmaster_bastion-taxinode_neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.25, 0.49, 0.67)
    },
    ["TeleportationNetwork-Ardenweald-32x32"] = {
        path = "TeleportationNetwork-Ardenweald-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.46, 0.98)
    },
    ["TeleportationNetwork-Maldraxxus-32x32"] = {
        path = "TeleportationNetwork-Maldraxxus-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.60, 0.39)
    },
    ["TeleportationNetwork-Revendreth-32x32"] = {
        path = "TeleportationNetwork-Revendreth-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.90, 0.36, 0.42)
    },
    ["SanctumUpgrades-Kyrian-32x32"] = {
        path = "SanctumUpgrades-Kyrian-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.15, 0.47, 0.97)
    },
    ["SanctumUpgrades-Necrolord-32x32"] = {
        path = "SanctumUpgrades-Necrolord-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.60, 0.35)
    },
    ["SanctumUpgrades-NightFae-32x32"] = {
        path = "SanctumUpgrades-NightFae-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.24, 0.53, 1.00)
    },
    ["SanctumUpgrades-Venthyr-32x32"] = {
        path = "SanctumUpgrades-Venthyr-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.49, 0.00)
    },
    ["PathofAscension-32x32"] = {
        path = "PathofAscension-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.59, 0.41, 0.24)
    },
    ["poi-lighthouse-neutral"] = {
        path = "poi-lighthouse-neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.29, 0.28)
    },
    ["TeleportationNetwork-FlightPathMinimap"] = {
        path = "TeleportationNetwork-FlightPathMinimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.43, 0.59, 0.74)
    },
    ["BuildanAbomination-32x32"] = {
        path = "BuildanAbomination-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.49, 0.60, 0.19)
    },
    ["embercourt-32x32-zhcn"] = {
        path = "embercourt-32x32-zhcn",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.16, 0.27)
    },
    ["EmberCourt-32x32"] = {
        path = "EmberCourt-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.05, 0.07)
    },
    ["QueensConservatory-32x32"] = {
        path = "QueensConservatory-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.05, 0.64, 0.92)
    },
    ["Soulbind-32x32"] = {
        path = "Soulbind-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.09, 0.44, 0.66)
    },
    ["animadiversion-icon"] = {
        path = "animadiversion-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.64, 0.34, 0.22)
    },
    ["Adventures-32x32"] = {
        path = "Adventures-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.57, 0.81)
    },
    ["GreatVault-32x32"] = {
        path = "GreatVault-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.58, 0.20)
    },
    ["TimewalkingVendor-32x32"] = {
        path = "TimewalkingVendor-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.07, 0.61, 0.93)
    },
    ["UpgradeItem-32x32"] = {
        path = "UpgradeItem-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.14, 0.73)
    },
    ["KyrianAssaults-64x64"] = {
        path = "KyrianAssaults-64x64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.03, 0.58, 0.95)
    },
    ["KyrianAssaultsQuest-32x32"] = {
        path = "KyrianAssaultsQuest-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.67, 0.75)
    },
    ["NecrolordAssaults-64x64"] = {
        path = "NecrolordAssaults-64x64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.86, 0.69)
    },
    ["NecrolordAssaultsQuest-32x32"] = {
        path = "NecrolordAssaultsQuest-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.78, 0.65)
    },
    ["NightFaeAssaults-64x64"] = {
        path = "NightFaeAssaults-64x64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.33, 0.59, 0.89)
    },
    ["NightFaeAssaultsQuest-32x32"] = {
        path = "NightFaeAssaultsQuest-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.57, 0.94)
    },
    ["VenthyrAssaults-64x64"] = {
        path = "VenthyrAssaults-64x64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.91, 0.61, 0.09)
    },
    ["VenthyrAssaultsQuest-32x32"] = {
        path = "VenthyrAssaultsQuest-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.49, 0.06)
    },
    ["Tormentors-Boss"] = {
        path = "Tormentors-Boss",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.40, 0.06)
    },
    ["Tormentors-Event"] = {
        path = "Tormentors-Event",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.58, 0.33, 0.01)
    },
    ["FlightMaster_Progenitor-TaxiNode_Neutral"] = {
        path = "FlightMaster_Progenitor-TaxiNode_Neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.40, 0.18)
    },
    ["ProgenitorFlightMaster-32x32"] = {
        path = "ProgenitorFlightMaster-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.40, 0.13)
    },
    ["WarlockPortal-Yellow-32x32"] = {
        path = "WarlockPortal-Yellow-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.46, 0.05)
    },
    ["CreationCatalyst-32x32"] = {
        path = "CreationCatalyst-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.82, 0.53, 0.15)
    },
    ["FlightMaster_ProgenitorObelisk-TaxiNode_Neutral"] = {
        path = "FlightMaster_ProgenitorObelisk-TaxiNode_Neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.78, 0.50)
    },
    ["vignetteloot-locked"] = {
        path = "vignetteloot-locked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.52, 0.51, 0.50)
    },
    ["vignettelootelite-locked"] = {
        path = "vignettelootelite-locked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.09, 0.09, 0.10)
    },
    ["MajorFactions_MapIcons_Centaur64"] = {
        path = "MajorFactions_MapIcons_Centaur64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.52, 0.13)
    },
    ["MajorFactions_MapIcons_Expedition64"] = {
        path = "MajorFactions_MapIcons_Expedition64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.54, 0.05)
    },
    ["MajorFactions_MapIcons_Tuskarr64"] = {
        path = "MajorFactions_MapIcons_Tuskarr64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.32, 0.64, 0.87)
    },
    ["MajorFactions_MapIcons_Valdrakken64"] = {
        path = "MajorFactions_MapIcons_Valdrakken64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.59, 0.18)
    },
    ["Quest-Campaign-Available-Trivial"] = {
        path = "Quest-Campaign-Available-Trivial",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.36, 0.30, 0.05)
    },
    ["racing"] = {
        path = "racing",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.40, 0.09)
    },
    ["Professions-Crafting-Orders-Icon"] = {
        path = "Professions-Crafting-Orders-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.54, 0.22)
    },
    ["dragonriding-winds"] = {
        path = "dragonriding-winds",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.60, 0.71, 0.80)
    },
    ["flightmaster_ancientwaygate-taxinode_neutral"] = {
        path = "flightmaster_ancientwaygate-taxinode_neutral",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.36, 0.22, 0.51)
    },
    ["ElementalStorm-Boss-Air"] = {
        path = "ElementalStorm-Boss-Air",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.52, 0.57, 0.95)
    },
    ["ElementalStorm-Boss-Earth"] = {
        path = "ElementalStorm-Boss-Earth",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.50, 0.13)
    },
    ["ElementalStorm-Boss-Fire"] = {
        path = "ElementalStorm-Boss-Fire",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.98, 0.35, 0.00)
    },
    ["ElementalStorm-Boss-Water"] = {
        path = "ElementalStorm-Boss-Water",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.73, 0.87)
    },
    ["ElementalStorm-Lesser-Air"] = {
        path = "ElementalStorm-Lesser-Air",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.86, 0.66, 0.89)
    },
    ["ElementalStorm-Lesser-Earth"] = {
        path = "ElementalStorm-Lesser-Earth",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.97, 0.65, 0.05)
    },
    ["ElementalStorm-Lesser-Fire"] = {
        path = "ElementalStorm-Lesser-Fire",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.49, 0.01)
    },
    ["ElementalStorm-Lesser-Water"] = {
        path = "ElementalStorm-Lesser-Water",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.78, 1.00)
    },
    ["greatvault-dragonflight-32x32"] = {
        path = "greatvault-dragonflight-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.64, 0.04)
    },
    ["Professions_Tracking_Fish"] = {
        path = "Professions_Tracking_Fish",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.60, 0.14)
    },
    ["Professions_Tracking_Herb"] = {
        path = "Professions_Tracking_Herb",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.60, 0.17)
    },
    ["Professions_Tracking_Ore"] = {
        path = "Professions_Tracking_Ore",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.56, 0.10)
    },
    ["dragon-rostrum"] = {
        path = "dragon-rostrum",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.63, 0.00)
    },
    ["minimap-genericevent-hornicon"] = {
        path = "minimap-genericevent-hornicon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 0.61, 0.15)
    },
    ["Fishing-Hole"] = {
        path = "Fishing-Hole",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.58, 0.68, 0.90)
    },
    ["CaveUnderground-Down"] = {
        path = "CaveUnderground-Down",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.53, 0.15)
    },
    ["CaveUnderground-Up"] = {
        path = "CaveUnderground-Up",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.55, 0.17)
    },
    ["MajorFactions_MapIcons_Niffen64"] = {
        path = "MajorFactions_MapIcons_Niffen64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.89, 0.52, 0.28)
    },
    ["niffen-myrrit"] = {
        path = "niffen-myrrit",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 0.55, 0.22)
    },
    ["Fyrakk-Flying-Icon"] = {
        path = "Fyrakk-Flying-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.27, 0.20)
    },
    ["Fyrakk-Head-Icon"] = {
        path = "Fyrakk-Head-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.33, 0.24)
    },
    ["quest-legendary-available-trivial"] = {
        path = "quest-legendary-available-trivial",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.65, 0.52, 0.05)
    },
    ["quest-legendary-available"] = {
        path = "quest-legendary-available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.98, 0.48, 0.00)
    },
    ["quest-legendary-turnin"] = {
        path = "quest-legendary-turnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.45, 0.00)
    },
    ["minimap-genericevent-hornicon-small"] = {
        path = "minimap-genericevent-hornicon-small",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.81, 0.69, 0.00)
    },
    ["Fyrakk-Head-Icon-Grey"] = {
        path = "Fyrakk-Head-Icon-Grey",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.96, 0.33, 0.00)
    },
    ["quest-important-available-trivial"] = {
        path = "quest-important-available-trivial",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.53, 0.05, 0.60)
    },
    ["quest-important-available"] = {
        path = "quest-important-available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.02, 0.83)
    },
    ["quest-important-turnin"] = {
        path = "quest-important-turnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.94, 0.42, 0.98)
    },
    ["Ping_Map_Whole_Assist"] = {
        path = "Ping_Map_Whole_Assist",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.27, 0.60, 0.23)
    },
    ["Ping_Map_Whole_Attack"] = {
        path = "Ping_Map_Whole_Attack",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.95, 0.42, 0.07)
    },
    ["Ping_Map_Whole_NonThreat"] = {
        path = "Ping_Map_Whole_NonThreat",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.16, 0.55, 0.84)
    },
    ["Ping_Map_Whole_OnMyWay"] = {
        path = "Ping_Map_Whole_OnMyWay",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.21, 0.52, 0.87)
    },
    ["Ping_Map_Whole_Threat"] = {
        path = "Ping_Map_Whole_Threat",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.16, 0.14)
    },
    ["Ping_Map_Whole_Warning"] = {
        path = "Ping_Map_Whole_Warning",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.84, 0.25, 0.25)
    },
    ["dreamsurge_fire-portal-icon"] = {
        path = "dreamsurge_fire-portal-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.96, 0.32, 0.04)
    },
    ["dreamsurge_hub-icon"] = {
        path = "dreamsurge_hub-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.04, 0.68, 0.36)
    },
    ["SeedPlanting-Empty"] = {
        path = "SeedPlanting-Empty",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.27, 0.08)
    },
    ["SeedPlanting-Full"] = {
        path = "SeedPlanting-Full",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.72, 0.34)
    },
    ["quest-recurring-available"] = {
        path = "quest-recurring-available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.72, 0.94)
    },
    ["quest-recurring-trivial"] = {
        path = "quest-recurring-trivial",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.01, 0.51, 0.63)
    },
    ["quest-recurring-turnin"] = {
        path = "quest-recurring-turnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.60, 0.87)
    },
    ["quest-wrapper-available"] = {
        path = "quest-wrapper-available",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.17, 0.67, 0.98)
    },
    ["quest-wrapper-trivial"] = {
        path = "quest-wrapper-trivial",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.08, 0.43, 0.61)
    },
    ["quest-wrapper-turnin"] = {
        path = "quest-wrapper-turnin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.04, 0.58, 0.90)
    },
    ["MajorFactions_MapIcons_Dream64"] = {
        path = "MajorFactions_MapIcons_Dream64",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.18, 0.53, 0.98)
    },
    ["fruit-minimap-icon"] = {
        path = "fruit-minimap-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.36, 0.22)
    },
    ["TaxiNode_Undiscovered"] = {
        path = "TaxiNode_Undiscovered",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.67, 0.33)
    },
    ["Professions_Tracking_Herb_Special"] = {
        path = "Professions_Tracking_Herb_Special",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.98, 0.66, 0.11)
    },
    ["Professions_Tracking_Ore_Special"] = {
        path = "Professions_Tracking_Ore_Special",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.67, 0.50, 0.12)
    },
    ["Professions_Tracking_Fish_Special"] = {
        path = "Professions_Tracking_Fish_Special",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.60, 0.15)
    },
    ["timerunninghub"] = {
        path = "timerunninghub",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.66, 0.22)
    },
    ["loreobject-32x32"] = {
        path = "loreobject-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.50, 0.35, 0.13)
    },
    ["notoriety-32x32"] = {
        path = "notoriety-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.52, 0.32, 0.80)
    },
    ["keyflameoff-32x32"] = {
        path = "keyflameoff-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.54, 0.47, 0.32)
    },
    ["keyflameon-32x32"] = {
        path = "keyflameon-32x32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.52, 0.13)
    },
    ["delves-bountiful"] = {
        path = "delves-bountiful",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.99, 0.36, 0.09)
    },
    ["delves-regular"] = {
        path = "delves-regular",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.73, 0.29)
    },
    ["poi-hub"] = {
        path = "poi-hub",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.53, 0.28)
    },
    ["TaxiNode_Continent_Alliance_Timed"] = {
        path = "TaxiNode_Continent_Alliance_Timed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.48, 0.63, 0.75)
    },
    ["TaxiNode_Continent_Horde_Timed"] = {
        path = "TaxiNode_Continent_Horde_Timed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.97, 0.71, 0.67)
    },
    ["TaxiNode_Continent_Neutral_Timed"] = {
        path = "TaxiNode_Continent_Neutral_Timed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.60, 0.29)
    },
    ["echoes-icon"] = {
        path = "echoes-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.08, 0.72, 0.83)
    },
    ["VignetteKill-Pressed-SuperTracked"] = {
        path = "VignetteKill-Pressed-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.70, 0.05)
    },
    ["VignetteKill-Pressed"] = {
        path = "VignetteKill-Pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.67, 0.15)
    },
    ["VignetteKill-SuperTracked"] = {
        path = "VignetteKill-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.70, 0.08)
    },
    ["VignetteKillElite-Pressed-SuperTracked"] = {
        path = "VignetteKillElite-Pressed-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.61, 0.04)
    },
    ["VignetteKillElite-Pressed"] = {
        path = "VignetteKillElite-Pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.67, 0.65, 0.15)
    },
    ["VignetteKillElite-SuperTracked"] = {
        path = "VignetteKillElite-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.56, 0.02)
    },
    ["questbonusobjective-Pressed-SuperTracked"] = {
        path = "questbonusobjective-Pressed-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.59, 0.01)
    },
    ["questbonusobjective-Pressed"] = {
        path = "questbonusobjective-Pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.58, 0.11)
    },
    ["questbonusobjective-SuperTracked"] = {
        path = "questbonusobjective-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.66, 0.12)
    },
    ["minimap-genericevent-hornicon-pressed-supertracked"] = {
        path = "minimap-genericevent-hornicon-pressed-supertracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.55, 0.00)
    },
    ["minimap-genericevent-hornicon-pressed"] = {
        path = "minimap-genericevent-hornicon-pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.59, 0.58, 0.13)
    },
    ["minimap-genericevent-hornicon-supertracked"] = {
        path = "minimap-genericevent-hornicon-supertracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.59, 0.57, 0.09)
    },
    ["vignettekillboss-pressed-SuperTracked"] = {
        path = "vignettekillboss-pressed-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.52, 0.00)
    },
    ["vignettekillboss-Pressed"] = {
        path = "vignettekillboss-Pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.76, 0.29)
    },
    ["vignettekillboss-SuperTracked"] = {
        path = "vignettekillboss-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.58, 0.00)
    },
    ["vignettekillboss"] = {
        path = "vignettekillboss",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.68, 0.31)
    },
    ["VignetteEvent-Pressed-SuperTracked"] = {
        path = "VignetteEvent-Pressed-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.70, 0.05)
    },
    ["VignetteEvent-Pressed"] = {
        path = "VignetteEvent-Pressed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.69, 0.67, 0.15)
    },
    ["VignetteEvent-SuperTracked"] = {
        path = "VignetteEvent-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.70, 0.08)
    },
    ["renown-candle"] = {
        path = "renown-candle",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 0.55, 0.22)
    },
    ["renown-flame"] = {
        path = "renown-flame",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.44, 0.25)
    },
    ["renown-storm"] = {
        path = "renown-storm",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.64, 0.26)
    },
    ["renown-web"] = {
        path = "renown-web",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.16, 0.14)
    },
    ["StableMaster"] = {
        path = "StableMaster",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.70, 0.72)
    },
    ["ChromieMap"] = {
        path = "ChromieMap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.73, 0.46, 0.13)
    },
    ["SCRAP-activated"] = {
        path = "SCRAP-activated",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.76, 0.66, 0.22)
    },
    ["SCRAP-deactivated"] = {
        path = "SCRAP-deactivated",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 0.47, 0.05)
    },
    ["lorewalking-map-icon"] = {
        path = "lorewalking-map-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.12, 0.51, 0.28)
    },
    ["renown-nightfall"] = {
        path = "renown-nightfall",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.87, 0.65, 0.31)
    },
    ["renown-rocket"] = {
        path = "renown-rocket",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.23, 0.11)
    },
    ["renown-Karesh"] = {
        path = "renown-Karesh",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.45, 0.23)
    },
    ["homestone-minimap-icon"] = {
        path = "homestone-minimap-icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.80, 0.47, 0.11)
    },
    ["DungeonStoneCheckpoint"] = {
        path = "DungeonStoneCheckpoint",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.29, 0.75, 0.71)
    },
    ["DungeonStoneCheckpointDeactivated"] = {
        path = "DungeonStoneCheckpointDeactivated",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.38, 0.38, 0.36)
    },
    ["renown-manaforge"] = {
        path = "renown-manaforge",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.53, 0.14)
    },
    ["Lumber_Tracking"] = {
        path = "Lumber_Tracking",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.68, 0.51, 0.04)
    },
    ["poi-saltherilssoiree"] = {
        path = "poi-saltherilssoiree",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.79, 0.67, 1.00)
    },
    ["poi-abundance"] = {
        path = "poi-abundance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.20, 0.51, 0.38)
    },
    ["housing-map-plot-occupied-friend-minimap"] = {
        path = "housing-map-plot-occupied-friend-minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.23, 0.40, 0.59)
    },
    ["housing-map-plot-occupied-minimap"] = {
        path = "housing-map-plot-occupied-minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.83, 0.50, 0.13)
    },
    ["housing-map-plot-unoccupied-minimap"] = {
        path = "housing-map-plot-unoccupied-minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.44, 0.27)
    },
    ["map-icon_bullletinboard-default-minimap"] = {
        path = "map-icon_bullletinboard-default-minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.77, 0.68, 0.38)
    },
    ["map-icon_bullletinboard-highlight-minimap"] = {
        path = "map-icon_bullletinboard-highlight-minimap",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.53, 0.20)
    },
    ["poi-stormarionassault"] = {
        path = "poi-stormarionassault",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.66, 0.38, 0.89)
    },
    ["poi-legendsoftheharanir"] = {
        path = "poi-legendsoftheharanir",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.81, 0.51, 0.20)
    },
    ["poi-prey"] = {
        path = "poi-prey",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.92, 0.24, 0.20)
    },
    ["housing-map-deed"] = {
        path = "housing-map-deed",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.63, 0.51, 0.24)
    },
    ["Quartermaster"] = {
        path = "Quartermaster",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.74, 0.48, 0.15)
    },
    ["VenomousTides"] = {
        path = "VenomousTides",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.22, 0.62, 0.15)
    },
    ["housing-decor-vendor_32"] = {
        path = "housing-decor-vendor_32",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.56, 0.45, 0.10)
    },
    ["Professions_Tracking_Skin"] = {
        path = "Professions_Tracking_Skin",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.52, 0.00)
    },
    ["Professions_Tracking_Skin_Special"] = {
        path = "Professions_Tracking_Skin_Special",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.75, 0.60, 0.13)
    },
    ["Ritual-Sites-Map-Icon"] = {
        path = "Ritual-Sites-Map-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.50, 0.27, 0.68)
    },
    ["Prey-HauntedBrazier"] = {
        path = "Prey-HauntedBrazier",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.19, 0.52, 0.31)
    },
    ["Ritual-Sites-BannerBuff-Icon"] = {
        path = "Ritual-Sites-BannerBuff-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(1.00, 0.08, 0.10)
    },
    ["Ritual-Sites-EnemyBuff-Icon"] = {
        path = "Ritual-Sites-EnemyBuff-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.85, 0.46, 0.98)
    },
    ["Ritual-Sites-PlayerBuff-Icon"] = {
        path = "Ritual-Sites-PlayerBuff-Icon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.00, 0.65, 0.67)
    },
    ["housing-map-cart"] = {
        path = "housing-map-cart",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.62, 0.42, 0.22)
    },
    ["Ulatek-major"] = {
        path = "Ulatek-major",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.45, 0.55, 0.00)
    },
    ["Ulatek-minor"] = {
        path = "Ulatek-minor",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.71, 0.88, 0.68)
    },
    ["Lairs"] = {
        path = "Lairs",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.78, 0.59, 0.25)
    },
    ["minimap-playeractivity"] = {
        path = "minimap-playeractivity",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1,
        color = CreateColor(0.70, 0.60, 0.07)
    },
}

---@type PinIcon[]
Pins.PIN_ICON_MENU_ICONS = {
    Pins.PIN_ICONS["QuestNormal"],
    Pins.PIN_ICONS["Dungeon"],
    Pins.PIN_ICONS["AllianceWarfrontMapBanner"],
    Pins.PIN_ICONS["minimap-playeractivity"],
    Pins.PIN_ICONS["quest-recurring-available"],
    Pins.PIN_ICONS["Raid"],
    Pins.PIN_ICONS["HordeWarfrontMapBanner"],
    Pins.PIN_ICONS["TaxiNode_Undiscovered"],
    Pins.PIN_ICONS["delves-bountiful"],
    Pins.PIN_ICONS["DungeonSkull"],
    Pins.PIN_ICONS["TaxiNode_Continent_Alliance"],
    Pins.PIN_ICONS["poi-prey"],
    Pins.PIN_ICONS["VignetteLoot"],
    Pins.PIN_ICONS["BuildanAbomination-32x32"],
    Pins.PIN_ICONS["TaxiNode_Continent_Horde"],
}
