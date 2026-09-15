---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local ZEPPELIN = {

  -- Zone: Borean Tundra (map 114)
  -- Borean Tundra (map 114 41.38,53.61) -> Orgrimmar (map 85 44.75,62.30) via zeppelin
  {
    fromPointID = 400005,
    fromMap = 114,
    fromX = 0.4138,
    fromY = 0.5361,
    toPointID = 100259,
    toMap = 85,
    toX = 0.4475,
    toY = 0.623,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Durotar (map 1)
  -- Durotar (map 1 55.98,13.22) -> The Waking Shores (map 2022 81.65,27.96) via zeppelin
  {
    fromPointID = 100016,
    fromMap = 1,
    fromX = 0.5598,
    fromY = 0.1322,
    toPointID = 1100011,
    toMap = 2022,
    toX = 0.8165,
    toY = 0.2796,
    type = "zeppelin",
    travelDuration = 150,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Echo Isles (map 463)
  -- Echo Isles (map 463 70.93,38.23) -> Zuldazar (map 862 58.03,65.05) via zeppelin
  {
    fromPointID = 100446,
    fromMap = 463,
    fromX = 0.7093,
    fromY = 0.3823,
    toPointID = 900022,
    toMap = 862,
    toX = 0.5803,
    toY = 0.6505,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Northern Stranglethorn (map 50)
  -- Northern Stranglethorn (map 50 37.17,52.49) -> Orgrimmar (map 85 52.52,53.15) via zeppelin
  {
    fromPointID = 200222,
    fromMap = 50,
    fromX = 0.3717,
    fromY = 0.5249,
    toPointID = 100271,
    toMap = 85,
    toX = 0.5252,
    toY = 0.5315,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Orgrimmar (map 85)
  -- Orgrimmar (map 85 43.00,64.99) -> Thunder Bluff (map 88 15.28,25.70) via zeppelin
  {
    fromPointID = 100258,
    fromMap = 85,
    fromX = 0.43,
    fromY = 0.6499,
    toPointID = 100293,
    toMap = 88,
    toX = 0.1528,
    toY = 0.257,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },
  -- Orgrimmar (map 85 44.75,62.30) -> Borean Tundra (map 114 41.38,53.61) via zeppelin
  {
    fromPointID = 100259,
    fromMap = 85,
    fromX = 0.4475,
    fromY = 0.623,
    toPointID = 400005,
    toMap = 114,
    toX = 0.4138,
    toY = 0.5361,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },
  -- Orgrimmar (map 85 52.52,53.15) -> Northern Stranglethorn (map 50 37.17,52.49) via zeppelin
  {
    fromPointID = 100271,
    fromMap = 85,
    fromX = 0.5252,
    fromY = 0.5315,
    toPointID = 200222,
    toMap = 50,
    toX = 0.3717,
    toY = 0.5249,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: The Waking Shores (map 2022)
  -- The Waking Shores (map 2022 81.65,27.96) -> Durotar (map 1 55.98,13.22) via zeppelin
  {
    fromPointID = 1100011,
    fromMap = 2022,
    fromX = 0.8165,
    fromY = 0.2796,
    toPointID = 100016,
    toMap = 1,
    toX = 0.5598,
    toY = 0.1322,
    type = "zeppelin",
    travelDuration = 150,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Thunder Bluff (map 88)
  -- Thunder Bluff (map 88 15.28,25.70) -> Orgrimmar (map 85 43.00,64.99) via zeppelin
  {
    fromPointID = 100293,
    fromMap = 88,
    fromX = 0.1528,
    fromY = 0.257,
    toPointID = 100258,
    toMap = 85,
    toX = 0.43,
    toY = 0.6499,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },

  -- Zone: Zuldazar (map 862)
  -- Zuldazar (map 862 58.03,65.05) -> Echo Isles (map 463 70.93,38.23) via zeppelin
  {
    fromPointID = 900022,
    fromMap = 862,
    fromX = 0.5803,
    fromY = 0.6505,
    toPointID = 100446,
    toMap = 463,
    toX = 0.7093,
    toY = 0.3823,
    type = "zeppelin",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Horde",
        },
      },
    },
  },
}

Navigation:RegisterPathData("zeppelin", ZEPPELIN)
