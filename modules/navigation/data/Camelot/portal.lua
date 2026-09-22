---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local PORTAL = {

  -- Zone: Darnassus (map 1457)
  -- Darnassus (map 1457 30.06,41.44) -> Teldrassil (map 1438 55.91,89.64) via portal
  {
    fromPointID = 100100,
    fromMap = 1457,
    fromX = 0.3006,
    fromY = 0.4144,
    toPointID = 100026,
    toMap = 1438,
    toX = 0.5591,
    toY = 0.8964,
    type = "portal",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
      },
    },
    toRegion = "ruttheran",
  },

  -- Zone: Teldrassil (map 1438)
  -- Teldrassil (map 1438 55.91,89.64) -> Darnassus (map 1457 30.06,41.44) via portal
  {
    fromPointID = 100026,
    fromMap = 1438,
    fromX = 0.5591,
    fromY = 0.8964,
    toPointID = 100100,
    toMap = 1457,
    toX = 0.3006,
    toY = 0.4144,
    type = "portal",
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "faction",
          value = "Alliance",
        },
      },
    },
    fromRegion = "ruttheran",
  },
}

Navigation:RegisterPathData("portal", PORTAL)
