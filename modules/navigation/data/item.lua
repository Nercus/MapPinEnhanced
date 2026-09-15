---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")

local ITEM = {

  -- Zone: Blackrock Depths (map 243)
  -- current position -> Blackrock Depths (map 243 46.00,54.00) via item
  {
    toPointID = 200452,
    toMap = 243,
    toX = 0.46,
    toY = 0.54,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 37863,
        },
      },
    },
    itemID = 37863,
    cooldown = 3600,
  },

  -- Zone: Dalaran (map 125)
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 40585,
        },
      },
    },
    itemID = 40585,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 40586,
        },
      },
    },
    itemID = 40586,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 44934,
        },
      },
    },
    itemID = 44934,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 44935,
        },
      },
    },
    itemID = 44935,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 45688,
        },
      },
    },
    itemID = 45688,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 45689,
        },
      },
    },
    itemID = 45689,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 45690,
        },
      },
    },
    itemID = 45690,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 45691,
        },
      },
    },
    itemID = 45691,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 48954,
        },
      },
    },
    itemID = 48954,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 48955,
        },
      },
    },
    itemID = 48955,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 48956,
        },
      },
    },
    itemID = 48956,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 48957,
        },
      },
    },
    itemID = 48957,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 51557,
        },
      },
    },
    itemID = 51557,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 51558,
        },
      },
    },
    itemID = 51558,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 51559,
        },
      },
    },
    itemID = 51559,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 51560,
        },
      },
    },
    itemID = 51560,
    cooldown = 1800,
  },
  -- current position -> Dalaran (map 125 55.92,46.78) via item
  {
    toPointID = 400119,
    toMap = 125,
    toX = 0.5592,
    toY = 0.4678,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 52251,
        },
      },
    },
    itemID = 52251,
    cooldown = 3600,
  },

  -- Zone: Deadwind Pass (map 42)
  -- current position -> Deadwind Pass (map 42 55.00,78.00) via item
  {
    toPointID = 200195,
    toMap = 42,
    toX = 0.55,
    toY = 0.78,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 22631,
        },
      },
    },
    itemID = 22631,
    cooldown = 60,
  },

  -- Zone: Deepholm (map 207)
  -- current position -> Deepholm (map 207 48.70,53.60) via item
  {
    toPointID = 1300013,
    toMap = 207,
    toX = 0.487,
    toY = 0.536,
    type = "item",
    travelDuration = 90,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 58587,
        },
      },
    },
    itemID = 58587,
    cooldown = 1800,
  },

  -- Zone: Frostfire Ridge (map 525)
  -- current position -> Frostfire Ridge (map 525 42.68,69.58) via item
  {
    toPointID = 600007,
    toMap = 525,
    toX = 0.4268,
    toY = 0.6958,
    type = "item",
    travelDuration = 30,
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
          kind = "item",
          value = 128353,
        },
      },
    },
    itemID = 128353,
    cooldown = 14400,
  },

  -- Zone: Icecrown (map 118)
  -- current position -> Icecrown (map 118 69.38,22.64) via item
  {
    toPointID = 400074,
    toMap = 118,
    toX = 0.6938,
    toY = 0.2264,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 46874,
        },
      },
    },
    itemID = 46874,
    cooldown = 1800,
  },

  -- Zone: Orgrimmar (map 85)
  -- current position -> Orgrimmar (map 85 57.10,89.81) via item
  {
    toPointID = 100278,
    toMap = 85,
    toX = 0.571,
    toY = 0.8981,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63207,
        },
      },
    },
    itemID = 63207,
    cooldown = 14400,
  },
  -- current position -> Orgrimmar (map 85 57.10,89.81) via item
  {
    toPointID = 100278,
    toMap = 85,
    toX = 0.571,
    toY = 0.8981,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63353,
        },
      },
    },
    itemID = 63353,
    cooldown = 28800,
  },
  -- current position -> Orgrimmar (map 85 57.10,89.81) via item
  {
    toPointID = 100278,
    toMap = 85,
    toX = 0.571,
    toY = 0.8981,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 65274,
        },
      },
    },
    itemID = 65274,
    cooldown = 7200,
  },

  -- Zone: Shadowmoon Valley (map 104)
  -- current position -> Shadowmoon Valley (map 104 63.00,44.00) via item
  {
    toPointID = 300053,
    toMap = 104,
    toX = 0.63,
    toY = 0.44,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 32757,
        },
      },
    },
    itemID = 32757,
    cooldown = 900,
  },

  -- Zone: Shadowmoon Valley (map 539)
  -- current position -> Shadowmoon Valley D (map 539 27.94,11.16) via item
  {
    toPointID = 600061,
    toMap = 539,
    toX = 0.2794,
    toY = 0.1116,
    type = "item",
    travelDuration = 30,
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
          kind = "item",
          value = 128353,
        },
      },
    },
    itemID = 128353,
    cooldown = 14400,
  },

  -- Zone: Stormwind City (map 84)
  -- current position -> Stormwind City (map 84 46.35,90.23) via item
  {
    toPointID = 200292,
    toMap = 84,
    toX = 0.4635,
    toY = 0.9023,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63206,
        },
      },
    },
    itemID = 63206,
    cooldown = 14400,
  },
  -- current position -> Stormwind City (map 84 46.35,90.23) via item
  {
    toPointID = 200292,
    toMap = 84,
    toX = 0.4635,
    toY = 0.9023,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63352,
        },
      },
    },
    itemID = 63352,
    cooldown = 28800,
  },
  -- current position -> Stormwind City (map 84 46.35,90.23) via item
  {
    toPointID = 200292,
    toMap = 84,
    toX = 0.4635,
    toY = 0.9023,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 65360,
        },
      },
    },
    itemID = 65360,
    cooldown = 7200,
  },

  -- Zone: The Cape of Stranglethorn (map 210)
  -- current position -> The Cape of Stranglethorn (map 210 40.80,73.80) via item
  {
    toPointID = 200381,
    toMap = 210,
    toX = 0.408,
    toY = 0.738,
    type = "item",
    travelDuration = 120,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 50287,
        },
      },
    },
    itemID = 50287,
    cooldown = 86400,
  },

  -- Zone: Timeless Isle (map 554)
  -- current position -> Timeless Isle (map 554 21.32,39.52) via item
  {
    toPointID = 500257,
    toMap = 554,
    toX = 0.2132,
    toY = 0.3952,
    type = "item",
    travelDuration = 300,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 104110,
        },
      },
    },
    itemID = 104110,
    cooldown = 0,
  },
  -- current position -> Timeless Isle (map 554 23.28,70.83) via item
  {
    toPointID = 500260,
    toMap = 554,
    toX = 0.2328,
    toY = 0.7083,
    type = "item",
    travelDuration = 300,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 104113,
        },
      },
    },
    itemID = 104113,
    cooldown = 0,
  },

  -- Zone: Tol Barad Peninsula (map 245)
  -- current position -> Tol Barad Peninsula (map 245 73.70,60.90) via item
  {
    toPointID = 200472,
    toMap = 245,
    toX = 0.737,
    toY = 0.609,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63378,
        },
      },
    },
    itemID = 63378,
    cooldown = 14400,
  },
  -- current position -> Tol Barad Peninsula (map 245 55.80,80.10) via item
  {
    toPointID = 200467,
    toMap = 245,
    toX = 0.558,
    toY = 0.801,
    type = "item",
    travelDuration = 30,
    requirement = {
      operation = "all",
      children = {
        {
          operation = "check",
          kind = "item",
          value = 63379,
        },
      },
    },
    itemID = 63379,
    cooldown = 14400,
  },
}

Navigation:RegisterPathData("item", ITEM)
