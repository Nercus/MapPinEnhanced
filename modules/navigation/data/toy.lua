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
    itemID = 253629,
    cooldown = 90,
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
    itemID = 202046,
    cooldown = 60,
  },
}

Navigation:RegisterPathData("toy", TOY)
