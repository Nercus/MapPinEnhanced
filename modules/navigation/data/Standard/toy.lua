---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local TOY = {

    -- Zone: Arcantina (map 2541)
    -- current position -> Arcantina (map 2541 50.61,88.88) via toy
    {
        toPointID = 200830,
        toMap = 2541,
        toX = 0.5061,
        toY = 0.8888,
        type = "toy",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 253629,
                },
                {
                    operation = "check",
                    kind = "toy",
                    value = true,
                },
            },
        },
    },

    -- Zone: Dalaran (map 627)
    -- current position -> Dalaran (map 627 60.92,44.72) via Dalaran Hearthstone
    {
        toPointID = 1300087,
        toMap = 627,
        toX = 0.6092,
        toY = 0.4472,
        type = "toy",
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "toy",
                    value = 140192,
                },
                {
                    operation = "any",
                    children = {
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 44184,
                        },
                        {
                            operation = "check",
                            kind = "questCompleted",
                            value = 44663,
                        },
                    },
                },
            },
        },
    },

    -- Zone: Stormsong Valley (map 942)
    -- current position -> Stormsong Valley (map 942 40.28,36.53) via toy
    {
        toPointID = 800045,
        toMap = 942,
        toX = 0.4028,
        toY = 0.3653,
        type = "toy",
        travelDuration = 15,
        requirement = {
            operation = "all",
            children = {
                {
                    operation = "check",
                    kind = "item",
                    value = 202046,
                },
                {
                    operation = "check",
                    kind = "toy",
                    value = true,
                },
            },
        },
    },

    -- Gadgetzan
    {
        toPointID = 1400001,
        toMap = 71,
        toX = 0.5160,
        toY = 0.2800,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 18986 },
    },
    -- Everlook
    {
        toPointID = 1400002,
        toMap = 83,
        toX = 0.5900,
        toY = 0.5000,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 18984 },
    },
    -- Toshley’s Station
    {
        toPointID = 1400003,
        toMap = 105,
        toX = 0.6040,
        toY = 0.6510,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 30544 },
    },
    -- Area 52
    {
        toPointID = 1400004,
        toMap = 109,
        toX = 0.3200,
        toY = 0.6300,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 30542 },
    },
    -- Borean Tundra
    {
        toPointID = 1400005,
        toMap = 114,
        toX = 0.5178,
        toY = 0.4503,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 48933 },
        gossip = {
            npcID = 35646,
            gossipOptionID = 38054,
        },
    },
    -- Howling Fjord
    {
        toPointID = 1400006,
        toMap = 117,
        toX = 0.5853,
        toY = 0.4863,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 48933 },
        gossip = {
            npcID = 35646,
            gossipOptionID = 38055,
        },
    },
    -- Sholazar Basin
    {
        toPointID = 1400007,
        toMap = 119,
        toX = 0.4921,
        toY = 0.3962,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 48933 },
        gossip = {
            npcID = 35646,
            gossipOptionID = 38056,
        },
    },
    -- Icecrown
    {
        toPointID = 1400008,
        toMap = 118,
        toX = 0.6287,
        toY = 0.2692,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 48933 },
        gossip = {
            npcID = 35646,
            gossipOptionID = 38057,
        },
    },
    -- Storm Peaks
    {
        toPointID = 1400009,
        toMap = 120,
        toX = 0.4390,
        toY = 0.2580,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 48933 },
        gossip = {
            npcID = 35646,
            gossipOptionID = 38058,
        },
    },
    -- Oribos
    {
        toPointID = 1400010,
        toMap = 1670,
        toX = 0.5208,
        toY = 0.2613,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51934,
        },
    },
    -- Bastion
    {
        toPointID = 1400011,
        toMap = 1533,
        toX = 0.5185,
        toY = 0.8776,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51935,
        },
    },
    -- Maldraxxus
    {
        toPointID = 1400012,
        toMap = 1536,
        toX = 0.4244,
        toY = 0.4399,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51936,
        },
    },
    -- Ardenweald
    {
        toPointID = 1400013,
        toMap = 1565,
        toX = 0.5442,
        toY = 0.6032,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51937,
        },
    },
    -- Revendreth
    {
        toPointID = 1400014,
        toMap = 1525,
        toX = 0.3750,
        toY = 0.7655,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51938,
        },
    },
    -- The Maw
    {
        toPointID = 1400015,
        toMap = 1543,
        toX = 0.2245,
        toY = 0.2815,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51939,
            requiresObservation = true,
        },
    },
    -- Korthia
    {
        toPointID = 1400016,
        toMap = 1961,
        toX = 0.6240,
        toY = 0.2458,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51941,
            requiresObservation = true,
        },
    },
    -- Zereth Mortis
    {
        toPointID = 1400017,
        toMap = 1970,
        toX = 0.4552,
        toY = 0.5528,
        type = "toy",
        requirement = { operation = "check", kind = "toy", value = 172924 },
        gossip = {
            npcID = 169501,
            gossipOptionID = 51942,
            requiresObservation = true,
        },
    },
}

Navigation:RegisterPathData("toy", TOY)

-- Recognize manual use without fabricating fixed endpoints for random landings.
-- True means the toy summons an interaction before teleporting. All entries
-- remain toys; only the fixed destinations above participate in route search.
Navigation:RegisterTravelToys({
    [18986] = false,  -- Ultrasafe Transporter: Gadgetzan
    [18984] = false,  -- Dimensional Ripper - Everlook
    [30544] = false,  -- Ultrasafe Transporter: Toshley's Station
    [30542] = false,  -- Dimensional Ripper - Area 52
    [48933] = true,   -- Wormhole Generator: Northrend
    [87215] = false,  -- Wormhole Generator: Pandaria
    [112059] = true,  -- Wormhole Centrifuge: random within the chosen zone
    [151652] = false, -- Wormhole Generator: Argus
    [168807] = false, -- Wormhole Generator: Kul Tiras
    [168808] = false, -- Wormhole Generator: Zandalar
    [172924] = true,  -- Wormhole Generator: Shadowlands
    [198156] = true,  -- Wyrmhole Generator: Dragon Isles (random landings)
    [221966] = true,  -- Wormhole Generator: Khaz Algar (random landings)
    [248485] = true,  -- Wormhole Generator: Quel'Thalas (random landings)
})
