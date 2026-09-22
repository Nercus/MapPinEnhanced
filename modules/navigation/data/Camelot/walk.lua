---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local WALK = {

  -- Zone: Badlands (map 1418)
  -- Badlands (map 1418 35.23,10.40) -> Badlands (map 1418 36.41,11.99) via walk
  {
    fromPointID = 200010,
    fromMap = 1418,
    fromX = 0.3523,
    fromY = 0.104,
    toPointID = 200011,
    toMap = 1418,
    toX = 0.3641,
    toY = 0.1199,
    type = "walk",
  },
  -- Badlands (map 1418 36.41,11.99) -> Badlands (map 1418 35.23,10.40) via walk
  {
    fromPointID = 200011,
    fromMap = 1418,
    fromX = 0.3641,
    fromY = 0.1199,
    toPointID = 200010,
    toMap = 1418,
    toX = 0.3523,
    toY = 0.104,
    type = "walk",
  },
  -- Badlands (map 1418 36.41,11.99) -> Badlands (map 1418 37.73,11.57) via walk
  {
    fromPointID = 200011,
    fromMap = 1418,
    fromX = 0.3641,
    fromY = 0.1199,
    toPointID = 200012,
    toMap = 1418,
    toX = 0.3773,
    toY = 0.1157,
    type = "walk",
  },
  -- Badlands (map 1418 37.73,11.57) -> Badlands (map 1418 36.41,11.99) via walk
  {
    fromPointID = 200012,
    fromMap = 1418,
    fromX = 0.3773,
    fromY = 0.1157,
    toPointID = 200011,
    toMap = 1418,
    toX = 0.3641,
    toY = 0.1199,
    type = "walk",
  },
  -- Badlands (map 1418 37.73,11.57) -> Badlands (map 1418 39.51,11.97) via walk
  {
    fromPointID = 200012,
    fromMap = 1418,
    fromX = 0.3773,
    fromY = 0.1157,
    toPointID = 200013,
    toMap = 1418,
    toX = 0.3951,
    toY = 0.1197,
    type = "walk",
  },
  -- Badlands (map 1418 39.51,11.97) -> Badlands (map 1418 37.73,11.57) via walk
  {
    fromPointID = 200013,
    fromMap = 1418,
    fromX = 0.3951,
    fromY = 0.1197,
    toPointID = 200012,
    toMap = 1418,
    toX = 0.3773,
    toY = 0.1157,
    type = "walk",
  },
  -- Badlands (map 1418 39.51,11.97) -> Badlands (map 1418 42.12,11.95) via walk
  {
    fromPointID = 200013,
    fromMap = 1418,
    fromX = 0.3951,
    fromY = 0.1197,
    toPointID = 200014,
    toMap = 1418,
    toX = 0.4212,
    toY = 0.1195,
    type = "walk",
  },
  -- Badlands (map 1418 42.12,11.95) -> Badlands (map 1418 39.51,11.97) via walk
  {
    fromPointID = 200014,
    fromMap = 1418,
    fromX = 0.4212,
    fromY = 0.1195,
    toPointID = 200013,
    toMap = 1418,
    toX = 0.3951,
    toY = 0.1197,
    type = "walk",
  },
  -- Badlands (map 1418 42.12,11.95) -> Badlands (map 1418 44.28,12.15) via walk
  {
    fromPointID = 200014,
    fromMap = 1418,
    fromX = 0.4212,
    fromY = 0.1195,
    toPointID = 200015,
    toMap = 1418,
    toX = 0.4428,
    toY = 0.1215,
    type = "walk",
  },
  -- Badlands (map 1418 44.28,12.15) -> Badlands (map 1418 42.12,11.95) via walk
  {
    fromPointID = 200015,
    fromMap = 1418,
    fromX = 0.4428,
    fromY = 0.1215,
    toPointID = 200014,
    toMap = 1418,
    toX = 0.4212,
    toY = 0.1195,
    type = "walk",
  },

  -- Zone: Eastern Plaguelands (map 1423)
  -- Eastern Plaguelands (map 1423 30.85,19.78) -> Eastern Plaguelands (map 1423 31.34,15.78) via walk
  {
    fromPointID = 200038,
    fromMap = 1423,
    fromX = 0.3085,
    fromY = 0.1978,
    toPointID = 200039,
    toMap = 1423,
    toX = 0.3134,
    toY = 0.1578,
    type = "walk",
  },
  -- Eastern Plaguelands (map 1423 31.34,15.78) -> Eastern Plaguelands (map 1423 30.85,19.78) via walk
  {
    fromPointID = 200039,
    fromMap = 1423,
    fromX = 0.3134,
    fromY = 0.1578,
    toPointID = 200038,
    toMap = 1423,
    toX = 0.3085,
    toY = 0.1978,
    type = "walk",
  },

  -- Zone: Silverpine Forest (map 1421)
  -- Silverpine Forest (map 1421 44.74,67.80) -> Silverpine Forest (map 1421 45.57,68.28) via walk
  {
    fromPointID = 200024,
    fromMap = 1421,
    fromX = 0.4474,
    fromY = 0.678,
    toPointID = 200026,
    toMap = 1421,
    toX = 0.4557,
    toY = 0.6828,
    type = "walk",
  },
  -- Silverpine Forest (map 1421 45.57,68.28) -> Silverpine Forest (map 1421 44.74,67.80) via walk
  {
    fromPointID = 200026,
    fromMap = 1421,
    fromX = 0.4557,
    fromY = 0.6828,
    toPointID = 200024,
    toMap = 1421,
    toX = 0.4474,
    toY = 0.678,
    type = "walk",
  },
  -- Silverpine Forest (map 1421 45.57,68.28) -> Silverpine Forest (map 1421 47.16,69.51) via walk
  {
    fromPointID = 200026,
    fromMap = 1421,
    fromX = 0.4557,
    fromY = 0.6828,
    toPointID = 200027,
    toMap = 1421,
    toX = 0.4716,
    toY = 0.6951,
    type = "walk",
  },
  -- Silverpine Forest (map 1421 47.16,69.51) -> Silverpine Forest (map 1421 45.57,68.28) via walk
  {
    fromPointID = 200027,
    fromMap = 1421,
    fromX = 0.4716,
    fromY = 0.6951,
    toPointID = 200026,
    toMap = 1421,
    toX = 0.4557,
    toY = 0.6828,
    type = "walk",
  },

  -- Zone: The Barrens (map 1413)
  -- The Barrens (map 1413 42.28,89.89) -> The Barrens (map 1413 43.71,90.11) via walk
  {
    fromPointID = 100009,
    fromMap = 1413,
    fromX = 0.4228,
    fromY = 0.8989,
    toPointID = 100010,
    toMap = 1413,
    toX = 0.4371,
    toY = 0.9011,
    type = "walk",
  },
  -- The Barrens (map 1413 43.71,90.11) -> The Barrens (map 1413 42.28,89.89) via walk
  {
    fromPointID = 100010,
    fromMap = 1413,
    fromX = 0.4371,
    fromY = 0.9011,
    toPointID = 100009,
    toMap = 1413,
    toX = 0.4228,
    toY = 0.8989,
    type = "walk",
  },
  -- The Barrens (map 1413 45.86,33.22) -> The Barrens (map 1413 46.23,34.89) via walk
  {
    fromPointID = 100012,
    fromMap = 1413,
    fromX = 0.4586,
    fromY = 0.3322,
    toPointID = 100014,
    toMap = 1413,
    toX = 0.4623,
    toY = 0.3489,
    type = "walk",
  },
  -- The Barrens (map 1413 45.86,33.22) -> The Barrens (map 1413 47.44,33.14) via walk
  {
    fromPointID = 100012,
    fromMap = 1413,
    fromX = 0.4586,
    fromY = 0.3322,
    toPointID = 100015,
    toMap = 1413,
    toX = 0.4744,
    toY = 0.3314,
    type = "walk",
  },
  -- The Barrens (map 1413 45.97,36.25) -> The Barrens (map 1413 46.23,34.89) via walk
  {
    fromPointID = 100013,
    fromMap = 1413,
    fromX = 0.4597,
    fromY = 0.3625,
    toPointID = 100014,
    toMap = 1413,
    toX = 0.4623,
    toY = 0.3489,
    type = "walk",
  },
  -- The Barrens (map 1413 46.23,34.89) -> The Barrens (map 1413 45.86,33.22) via walk
  {
    fromPointID = 100014,
    fromMap = 1413,
    fromX = 0.4623,
    fromY = 0.3489,
    toPointID = 100012,
    toMap = 1413,
    toX = 0.4586,
    toY = 0.3322,
    type = "walk",
  },
  -- The Barrens (map 1413 46.23,34.89) -> The Barrens (map 1413 45.97,36.25) via walk
  {
    fromPointID = 100014,
    fromMap = 1413,
    fromX = 0.4623,
    fromY = 0.3489,
    toPointID = 100013,
    toMap = 1413,
    toX = 0.4597,
    toY = 0.3625,
    type = "walk",
  },
  -- The Barrens (map 1413 47.44,33.14) -> The Barrens (map 1413 45.86,33.22) via walk
  {
    fromPointID = 100015,
    fromMap = 1413,
    fromX = 0.4744,
    fromY = 0.3314,
    toPointID = 100012,
    toMap = 1413,
    toX = 0.4586,
    toY = 0.3322,
    type = "walk",
  },
  -- The Barrens (map 1413 47.44,33.14) -> The Barrens (map 1413 47.72,34.93) via walk
  {
    fromPointID = 100015,
    fromMap = 1413,
    fromX = 0.4744,
    fromY = 0.3314,
    toPointID = 100016,
    toMap = 1413,
    toX = 0.4772,
    toY = 0.3493,
    type = "walk",
  },
  -- The Barrens (map 1413 47.72,34.93) -> The Barrens (map 1413 47.44,33.14) via walk
  {
    fromPointID = 100016,
    fromMap = 1413,
    fromX = 0.4772,
    fromY = 0.3493,
    toPointID = 100015,
    toMap = 1413,
    toX = 0.4744,
    toY = 0.3314,
    type = "walk",
  },
  -- The Barrens (map 1413 49.10,93.56) -> The Barrens (map 1413 49.73,92.72) via walk
  {
    fromPointID = 100018,
    fromMap = 1413,
    fromX = 0.491,
    fromY = 0.9356,
    toPointID = 100020,
    toMap = 1413,
    toX = 0.4973,
    toY = 0.9272,
    type = "walk",
  },
  -- The Barrens (map 1413 49.73,92.72) -> The Barrens (map 1413 49.10,93.56) via walk
  {
    fromPointID = 100020,
    fromMap = 1413,
    fromX = 0.4973,
    fromY = 0.9272,
    toPointID = 100018,
    toMap = 1413,
    toX = 0.491,
    toY = 0.9356,
    type = "walk",
  },
  -- The Barrens (map 1413 49.73,92.72) -> The Barrens (map 1413 50.25,92.83) via walk
  {
    fromPointID = 100020,
    fromMap = 1413,
    fromX = 0.4973,
    fromY = 0.9272,
    toPointID = 100021,
    toMap = 1413,
    toX = 0.5025,
    toY = 0.9283,
    type = "walk",
  },
  -- The Barrens (map 1413 50.25,92.83) -> The Barrens (map 1413 49.73,92.72) via walk
  {
    fromPointID = 100021,
    fromMap = 1413,
    fromX = 0.5025,
    fromY = 0.9283,
    toPointID = 100020,
    toMap = 1413,
    toX = 0.4973,
    toY = 0.9272,
    type = "walk",
  },
  -- The Barrens (map 1413 50.25,92.83) -> The Barrens (map 1413 50.86,92.86) via walk
  {
    fromPointID = 100021,
    fromMap = 1413,
    fromX = 0.5025,
    fromY = 0.9283,
    toPointID = 100022,
    toMap = 1413,
    toX = 0.5086,
    toY = 0.9286,
    type = "walk",
  },
  -- The Barrens (map 1413 50.86,92.86) -> The Barrens (map 1413 50.25,92.83) via walk
  {
    fromPointID = 100022,
    fromMap = 1413,
    fromX = 0.5086,
    fromY = 0.9286,
    toPointID = 100021,
    toMap = 1413,
    toX = 0.5025,
    toY = 0.9283,
    type = "walk",
  },

  -- Zone: Western Plaguelands (map 1422)
  -- Western Plaguelands (map 1422 42.12,11.95) -> Western Plaguelands (map 1422 68.50,72.58) via walk
  {
    fromPointID = 200031,
    fromMap = 1422,
    fromX = 0.4212,
    fromY = 0.1195,
    toPointID = 200034,
    toMap = 1422,
    toX = 0.685,
    toY = 0.7258,
    type = "walk",
  },
  -- Western Plaguelands (map 1422 42.12,11.95) -> Western Plaguelands (map 1422 69.72,73.36) via walk
  {
    fromPointID = 200031,
    fromMap = 1422,
    fromX = 0.4212,
    fromY = 0.1195,
    toPointID = 200035,
    toMap = 1422,
    toX = 0.6972,
    toY = 0.7336,
    type = "walk",
  },
  -- Western Plaguelands (map 1422 68.50,72.58) -> Western Plaguelands (map 1422 42.12,11.95) via walk
  {
    fromPointID = 200034,
    fromMap = 1422,
    fromX = 0.685,
    fromY = 0.7258,
    toPointID = 200031,
    toMap = 1422,
    toX = 0.4212,
    toY = 0.1195,
    type = "walk",
  },
  -- Western Plaguelands (map 1422 69.72,73.36) -> Western Plaguelands (map 1422 42.12,11.95) via walk
  {
    fromPointID = 200035,
    fromMap = 1422,
    fromX = 0.6972,
    fromY = 0.7336,
    toPointID = 200031,
    toMap = 1422,
    toX = 0.4212,
    toY = 0.1195,
    type = "walk",
  },
}

Navigation:RegisterPathData("walk", WALK)
