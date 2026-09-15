---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local GOSSIP = {

  -- Zone: Boralus (map 1161)
  -- Boralus (map 1161 67.95,26.69) -> Vol'dun (map 864 35.60,33.17) via gossip
  {
    fromPointID = 800076,
    fromMap = 1161,
    fromX = 0.6795,
    fromY = 0.2669,
    toPointID = 900056,
    toMap = 864,
    toX = 0.356,
    toY = 0.3317,
    type = "gossip",
    travelDuration = 30,
    gossip = {
      gossipOptionID = 48163,
      npcID = 135681,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51572,
        },
      },
    },
  },

  -- Zone: Nazmir (map 863)
  -- Nazmir (map 863 62.06,40.08) -> Boralus (map 1161 70.22,27.06) via gossip
  {
    fromPointID = 900049,
    fromMap = 863,
    fromX = 0.6206,
    fromY = 0.4008,
    toPointID = 800083,
    toMap = 1161,
    toX = 0.7022,
    toY = 0.2706,
    type = "gossip",
    travelDuration = 30,
    gossip = {
      gossipOptionID = 48827,
      npcID = 139620,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51571,
        },
      },
    },
  },

  -- Zone: Oribos (map 1670)
  -- Oribos (map 1670 38.88,70.00) -> Zereth Mortis (map 1970 33.27,69.43) via gossip
  {
    fromPointID = 1000169,
    fromMap = 1670,
    fromX = 0.3888,
    fromY = 0.7,
    toPointID = 1000323,
    toMap = 1970,
    toX = 0.3327,
    toY = 0.6943,
    type = "gossip",
    gossip = {
      gossipOptionID = 53550,
      npcID = 159478,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "not",
          children = {
            {
              operation = "check",
              kind = "questCompleted",
              value = 64957,
            },
          },
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 64944,
        },
      },
    },
  },

  -- Zone: Silithus (map 81)
  -- Silithus (map 81 78.93,21.97) -> Chamber of Heart (map 1021 50.22,35.92) via gossip
  {
    fromPointID = 100246,
    fromMap = 81,
    fromX = 0.7893,
    fromY = 0.2197,
    toPointID = 100459,
    toMap = 1021,
    toX = 0.5022,
    toY = 0.3592,
    type = "gossip",
    gossip = {
      gossipOptionID = 47635,
      npcID = 128607,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "phase",
          value = "BFA",
        },
        {
          operation = "check",
          kind = "phase",
          value = "Old Silithus",
        },
      },
    },
  },

  -- Zone: The Vindicaar (map 831)
  -- Krokuun (map 831 43.42,23.19) -> Arcatraz L (map 889 41.20,74.29) via gossip
  {
    fromPointID = 700288,
    fromMap = 831,
    fromX = 0.4342,
    fromY = 0.2319,
    toPointID = 300163,
    toMap = 889,
    toX = 0.412,
    toY = 0.7429,
    type = "gossip",
    gossip = {
      gossipOptionID = 46719,
      npcID = 121263,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "questActive",
          value = 47134,
        },
      },
    },
  },

  -- Zone: Tirisfal Glades (map 18)
  -- Tirisfal Glades (map 18 69.45,62.80) -> Hellfire Peninsula (map 100 89.16,49.56) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 300020,
    toMap = 100,
    toX = 0.8916,
    toY = 0.4956,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades (map 18 69.45,62.80) -> Silvermoon City (map 110 49.49,14.80) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200340,
    toMap = 110,
    toX = 0.4949,
    toY = 0.148,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades (map 18 69.45,62.80) -> Howling Fjord (map 117 79.00,28.92) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 400065,
    toMap = 117,
    toX = 0.79,
    toY = 0.2892,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades (map 18 69.45,62.80) -> Northern Stranglethorn (map 50 37.23,50.48) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200223,
    toMap = 50,
    toX = 0.3723,
    toY = 0.5048,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades (map 18 69.45,62.80) -> Orgrimmar (map 85 57.10,89.81) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 100278,
    toMap = 85,
    toX = 0.571,
    toY = 0.8981,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades (map 18 69.45,62.80) -> Undercity (map 90 89.16,49.56) via gossip
  {
    fromPointID = 200052,
    fromMap = 18,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200333,
    toMap = 90,
    toX = 0.8916,
    toY = 0.4956,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },

  -- Zone: Tirisfal Glades (map 2070)
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Hellfire Peninsula (map 100 89.16,49.56) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 300020,
    toMap = 100,
    toX = 0.8916,
    toY = 0.4956,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Silvermoon City (map 110 49.49,14.80) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200340,
    toMap = 110,
    toX = 0.4949,
    toY = 0.148,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Howling Fjord (map 117 79.00,28.92) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 400065,
    toMap = 117,
    toX = 0.79,
    toY = 0.2892,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Northern Stranglethorn (map 50 37.23,50.48) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200223,
    toMap = 50,
    toX = 0.3723,
    toY = 0.5048,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Orgrimmar (map 85 57.10,89.81) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 100278,
    toMap = 85,
    toX = 0.571,
    toY = 0.8981,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },
  -- Tirisfal Glades L (map 2070 69.45,62.80) -> Undercity (map 90 89.16,49.56) via gossip
  {
    fromPointID = 200639,
    fromMap = 2070,
    fromX = 0.6945,
    fromY = 0.628,
    toPointID = 200333,
    toMap = 90,
    toX = 0.8916,
    toY = 0.4956,
    type = "gossip",
    gossip = {
      gossipOptionID = 49018,
      npcID = 141488,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "phase",
          value = "UndercityOoze",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51443,
        },
      },
    },
  },

  -- Zone: Vol'dun (map 864)
  -- Vol'dun (map 864 34.91,33.76) -> Boralus (map 1161 70.22,27.06) via gossip
  {
    fromPointID = 900055,
    fromMap = 864,
    fromX = 0.3491,
    fromY = 0.3376,
    toPointID = 800083,
    toMap = 1161,
    toX = 0.7022,
    toY = 0.2706,
    type = "gossip",
    travelDuration = 30,
    gossip = {
      gossipOptionID = 48172,
      npcID = 135681,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51229,
        },
      },
    },
  },

  -- Zone: Zuldazar (map 862)
  -- Zuldazar (map 862 40.46,71.03) -> Boralus (map 1161 70.22,27.06) via gossip
  {
    fromPointID = 900006,
    fromMap = 862,
    fromX = 0.4046,
    fromY = 0.7103,
    toPointID = 800083,
    toMap = 1161,
    toX = 0.7022,
    toY = 0.2706,
    type = "gossip",
    travelDuration = 30,
    gossip = {
      gossipOptionID = 49161,
      npcID = 143334,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51418,
        },
      },
    },
  },
  -- Zuldazar (map 862 58.46,62.99) -> Tiragarde Sound (map 895 88.20,51.16) via gossip
  {
    fromPointID = 900024,
    fromMap = 862,
    fromX = 0.5846,
    fromY = 0.6299,
    toPointID = 800019,
    toMap = 895,
    toX = 0.882,
    toY = 0.5116,
    type = "gossip",
    travelDuration = 30,
    gossip = {
      gossipOptionID = 38346,
      npcID = 135690,
    },
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
        {
          operation = "check",
          kind = "questCompleted",
          value = 51800,
        },
      },
    },
  },
}

Navigation:RegisterPathData("gossip", GOSSIP)
