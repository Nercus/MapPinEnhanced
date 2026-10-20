---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Destination unlock flags: InteractiveWormholes data/molemachine.lua.
-- The three default cities need only the racial spell; other destinations
-- accept their native unlock flag or a positive character menu observation.
---@type NavigationStaticPath[]
local MOLE_MACHINE = {
    -- Ironforge
    {
        toPointID = 1400100,
        toMap = 27,
        toX = 0.6129,
        toY = 0.3718,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49331,
            parentOptionID = 49322,
        },
    },
    -- Stormwind
    {
        toPointID = 1400101,
        toMap = 84,
        toX = 0.6333,
        toY = 0.3734,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49332,
            parentOptionID = 49322,
        },
    },
    -- Nethergarde Keep (Blasted Lands)
    {
        toPointID = 1400102,
        toMap = 17,
        toX = 0.6197,
        toY = 0.1280,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49333,
            parentOptionID = 49322,
            requiresObservation = true,
            unlockQuestID = 53594,
        },
    },
    -- Aerie Peak (The Hinterlands)
    {
        toPointID = 1400103,
        toMap = 26,
        toX = 0.1353,
        toY = 0.4680,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49334,
            parentOptionID = 49322,
            requiresObservation = true,
            unlockQuestID = 53585,
        },
    },
    -- The Masonary (Black Rock Mountains)
    {
        toPointID = 1400104,
        toMap = 35,
        toX = 0.3330,
        toY = 0.2480,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49335,
            parentOptionID = 49322,
            requiresObservation = true,
            unlockQuestID = 53587,
        },
    },
    -- Shadowforge City
    {
        toPointID = 200630,
        toMap = 1186,
        toX = 0.6144,
        toY = 0.2435,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49336,
            parentOptionID = 49322,
        },
    },
    -- Fire Plume Ridge (Un'Goro Crater)
    {
        toPointID = 1400106,
        toMap = 78,
        toX = 0.5288,
        toY = 0.5576,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49337,
            parentOptionID = 49323,
            requiresObservation = true,
            unlockQuestID = 53591,
        },
    },
    -- Throne of Flame (Mount Hyjal)
    {
        toPointID = 1400107,
        toMap = 198,
        toX = 0.5718,
        toY = 0.7711,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49338,
            parentOptionID = 49323,
            requiresObservation = true,
            unlockQuestID = 53601,
        },
    },
    -- The Great Divide (Southern Barrens)
    {
        toPointID = 1400108,
        toMap = 199,
        toX = 0.3911,
        toY = 0.0930,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49339,
            parentOptionID = 49323,
            requiresObservation = true,
            unlockQuestID = 53600,
        },
    },
    -- Honor Hold (Hellfire Peninsula)
    {
        toPointID = 1400109,
        toMap = 100,
        toX = 0.5309,
        toY = 0.6487,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49340,
            parentOptionID = 49324,
            requiresObservation = true,
            unlockQuestID = 53592,
        },
    },
    -- Fel Pits (Shadowmoon Valley)
    {
        toPointID = 1400110,
        toMap = 104,
        toX = 0.5077,
        toY = 0.3530,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49341,
            parentOptionID = 49324,
            requiresObservation = true,
            unlockQuestID = 53599,
        },
    },
    -- Skald (Blade's Edge Mountains)
    {
        toPointID = 1400111,
        toMap = 105,
        toX = 0.7242,
        toY = 0.1764,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49342,
            parentOptionID = 49324,
            requiresObservation = true,
            unlockQuestID = 53597,
        },
    },
    -- Argent Tournament Grounds (Icecrown)
    {
        toPointID = 1400112,
        toMap = 118,
        toX = 0.7697,
        toY = 0.1866,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49343,
            parentOptionID = 49325,
            requiresObservation = true,
            unlockQuestID = 53586,
        },
    },
    -- Ruby Dragonshrine (Dragonblight)
    {
        toPointID = 1400113,
        toMap = 115,
        toX = 0.4535,
        toY = 0.4992,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49344,
            parentOptionID = 49325,
            requiresObservation = true,
            unlockQuestID = 53596,
        },
    },
    -- One Keg (Kun-Lai Summit)
    {
        toPointID = 1400114,
        toMap = 379,
        toX = 0.5768,
        toY = 0.6281,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49345,
            parentOptionID = 49326,
            requiresObservation = true,
            unlockQuestID = 53595,
        },
    },
    -- Stormstout Brewery (Valley of the Four Winds)
    {
        toPointID = 1400115,
        toMap = 376,
        toX = 0.3151,
        toY = 0.7359,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49346,
            parentOptionID = 49326,
            requiresObservation = true,
            unlockQuestID = 53598,
        },
    },
    -- Blackrock Foundry Overlook (Gorgrond)
    {
        toPointID = 1400116,
        toMap = 543,
        toX = 0.4669,
        toY = 0.3876,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49347,
            parentOptionID = 49327,
            requiresObservation = true,
            unlockQuestID = 53588,
        },
    },
    -- Elemental Plateau (Nagrand)
    {
        toPointID = 1400117,
        toMap = 550,
        toX = 0.6575,
        toY = 0.0825,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49348,
            parentOptionID = 49327,
            requiresObservation = true,
            unlockQuestID = 53590,
        },
    },
    -- Neltharion's Vault (Highmountain)
    {
        toPointID = 1400118,
        toMap = 650,
        toX = 0.4466,
        toY = 0.7290,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49349,
            parentOptionID = 49328,
            requiresObservation = true,
            unlockQuestID = 53593,
        },
    },
    -- Broken Shore
    {
        toPointID = 1400119,
        toMap = 646,
        toX = 0.7169,
        toY = 0.4799,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 49350,
            parentOptionID = 49328,
            requiresObservation = true,
            unlockQuestID = 53589,
        },
    },
    -- Zalamar Invasion (Nazmir)
    {
        toPointID = 1400120,
        toMap = 863,
        toX = 0.3434,
        toY = 0.4515,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125454,
            parentOptionID = 49330,
            requiresObservation = true,
            unlockQuestID = 80099,
        },
    },
    -- Xibala Incursion (Zuldazar)
    {
        toPointID = 1400121,
        toMap = 862,
        toX = 0.3824,
        toY = 0.7238,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125453,
            parentOptionID = 49330,
            requiresObservation = true,
            unlockQuestID = 80100,
        },
    },
    -- Wailing Tideways (Tiragarde Sound)
    {
        toPointID = 1400122,
        toMap = 895,
        toX = 0.8822,
        toY = 0.7153,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125456,
            parentOptionID = 49329,
            requiresObservation = true,
            unlockQuestID = 80101,
        },
    },
    -- Tidebreak Summit (Stormsong Valley)
    {
        toPointID = 1400123,
        toMap = 942,
        toX = 0.6421,
        toY = 0.2944,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125455,
            parentOptionID = 49329,
            requiresObservation = true,
            unlockQuestID = 80102,
        },
    },
    -- Valley of a Thousand Legs (Maldraxxus)
    {
        toPointID = 1400124,
        toMap = 1536,
        toX = 0.5349,
        toY = 0.5979,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125460,
            parentOptionID = 125452,
            requiresObservation = true,
            unlockQuestID = 80103,
        },
    },
    -- Scorched Crypt (Revendreth)
    {
        toPointID = 1400125,
        toMap = 1525,
        toX = 0.1993,
        toY = 0.3878,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125459,
            parentOptionID = 125452,
            requiresObservation = true,
            unlockQuestID = 80104,
        },
    },
    -- The Eternal Forge (Bastion)
    {
        toPointID = 1400126,
        toMap = 1533,
        toX = 0.5175,
        toY = 0.1314,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125458,
            parentOptionID = 125452,
            requiresObservation = true,
            unlockQuestID = 80105,
        },
    },
    -- Soryn's Meadow (Ardenweald)
    {
        toPointID = 1400127,
        toMap = 1565,
        toX = 0.6647,
        toY = 0.5055,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125457,
            parentOptionID = 125452,
            requiresObservation = true,
            unlockQuestID = 80106,
        },
    },
    -- The Slagmire (The Waking Shores)
    {
        toPointID = 1400128,
        toMap = 2022,
        toX = 0.3236,
        toY = 0.5490,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125463,
            parentOptionID = 125451,
            requiresObservation = true,
            unlockQuestID = 80107,
        },
    },
    -- Vakthros Summit (The Azure Span)
    {
        toPointID = 1400129,
        toMap = 2024,
        toX = 0.8009,
        toY = 0.3896,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125462,
            parentOptionID = 125451,
            requiresObservation = true,
            unlockQuestID = 80108,
        },
    },
    -- Obsidian Rest (Zaralek Caverns)
    {
        toPointID = 1400130,
        toMap = 2133,
        toX = 0.5273,
        toY = 0.2767,
        type = "spell",
        requirement = { operation = "check", kind = "spellKnown", value = 265225 },
        gossip = {
            npcID = 143925,
            gossipOptionID = 125461,
            parentOptionID = 125451,
            requiresObservation = true,
            unlockQuestID = 80109,
        },
    },
}

Navigation:RegisterPathData("spell", MOLE_MACHINE)
Navigation:RegisterTravelSpells({ [265225] = true })
