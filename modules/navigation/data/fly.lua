---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local FLY = {

  -- Zone: Dun Morogh (map 27)
  -- Dun Morogh (map 27 2.00,28.00) -> Kelp'thar Forest (map 201 71.00,63.00) via fly
  {
    fromPointID = 200119,
    fromMap = 27,
    fromX = 0.02,
    fromY = 0.28,
    toPointID = 200361,
    toMap = 201,
    toX = 0.71,
    toY = 0.63,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 890,
        },
      },
    },
  },
  -- Dun Morogh (map 27 35.08,2.95) -> Ruins of Gilneas (map 217 72.77,99.94) via fly
  {
    fromPointID = 200120,
    fromMap = 27,
    fromX = 0.3508,
    fromY = 0.0295,
    toPointID = 200390,
    toMap = 217,
    toX = 0.7277,
    toY = 0.9994,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 890,
        },
      },
    },
  },

  -- Zone: Eastern Kingdoms (map 13)
  -- Eastern Kingdoms (map 13 40.34,69.07) -> Shimmering Expanse (map 205 70.00,74.00) via fly
  {
    fromPointID = 200001,
    fromMap = 13,
    fromX = 0.4034,
    fromY = 0.6907,
    toPointID = 200377,
    toMap = 205,
    toX = 0.7,
    toY = 0.74,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 5180,
        },
      },
    },
  },

  -- Zone: Kelp'thar Forest (map 201)
  -- Kelp'thar Forest (map 201 71.00,63.00) -> Dun Morogh (map 27 2.00,28.00) via fly
  {
    fromPointID = 200361,
    fromMap = 201,
    fromX = 0.71,
    fromY = 0.63,
    toPointID = 200119,
    toMap = 27,
    toX = 0.02,
    toY = 0.28,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 890,
        },
      },
    },
  },

  -- Zone: Ruins of Gilneas (map 217)
  -- Ruins of Gilneas (map 217 72.77,99.94) -> Dun Morogh (map 27 35.08,2.95) via fly
  {
    fromPointID = 200390,
    fromMap = 217,
    fromX = 0.7277,
    fromY = 0.9994,
    toPointID = 200120,
    toMap = 27,
    toX = 0.3508,
    toY = 0.0295,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 890,
        },
      },
    },
  },

  -- Zone: Shimmering Expanse (map 205)
  -- Shimmering Expanse (map 205 70.00,74.00) -> Eastern Kingdoms (map 13 40.34,69.07) via fly
  {
    fromPointID = 200377,
    fromMap = 205,
    fromX = 0.7,
    fromY = 0.74,
    toPointID = 200001,
    toMap = 13,
    toX = 0.4034,
    toY = 0.6907,
    type = "fly",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "achievement",
          value = 5180,
        },
      },
    },
  },

  -- Zone: Tirisfal Glades (map 18)
  -- Tirisfal Glades (map 18 51.10,71.60) -> Undercity (map 90 15.20,33.30) via fly
  {
    fromPointID = 200042,
    fromMap = 18,
    fromX = 0.511,
    fromY = 0.716,
    toPointID = 200327,
    toMap = 90,
    toX = 0.152,
    toY = 0.333,
    type = "fly",
  },

  -- Zone: Undercity (map 90)
  -- Undercity (map 90 15.20,33.30) -> Tirisfal Glades (map 18 51.10,71.60) via fly
  {
    fromPointID = 200327,
    fromMap = 90,
    fromX = 0.152,
    fromY = 0.333,
    toPointID = 200042,
    toMap = 18,
    toX = 0.511,
    toY = 0.716,
    type = "fly",
  },
  -- Undercity (map 90 43.40,24.00) -> Undercity (map 90 49.60,29.50) via fly
  {
    fromPointID = 200328,
    fromMap = 90,
    fromX = 0.434,
    fromY = 0.24,
    toPointID = 200329,
    toMap = 90,
    toX = 0.496,
    toY = 0.295,
    type = "fly",
  },
  -- Undercity (map 90 49.60,29.50) -> Undercity (map 90 43.40,24.00) via fly
  {
    fromPointID = 200329,
    fromMap = 90,
    fromX = 0.496,
    fromY = 0.295,
    toPointID = 200328,
    toMap = 90,
    toX = 0.434,
    toY = 0.24,
    type = "fly",
  },
}

Navigation:RegisterPathData("fly", FLY)
