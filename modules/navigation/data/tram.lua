---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local TRAM = {

  -- Zone: Deeprun Tram (map 499)
  -- Deeprun Tram (map 499 42.53,11.53) -> Deeprun Tram (map 499 45.77,12.47) via tram
  {
    fromPointID = 200623,
    fromMap = 499,
    fromX = 0.4253,
    fromY = 0.1153,
    toPointID = 200624,
    toMap = 499,
    toX = 0.4577,
    toY = 0.1247,
    type = "tram",
    travelDuration = 30,
  },
  -- Deeprun Tram (map 499 45.77,12.47) -> Deeprun Tram (map 499 42.53,11.53) via tram
  {
    fromPointID = 200624,
    fromMap = 499,
    fromX = 0.4577,
    fromY = 0.1247,
    toPointID = 200623,
    toMap = 499,
    toX = 0.4253,
    toY = 0.1153,
    type = "tram",
    travelDuration = 30,
  },
}

Navigation:RegisterPathData("tram", TRAM)
