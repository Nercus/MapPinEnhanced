---@class Wayfinder
local Wayfinder = select(2, ...)


---save a variable to the saved variables
---@param ... string | number | boolean | table
function Wayfinder:SaveVar(...)
  if not WayfinderDB then
    WayfinderDB = {}
  end

  -- move all arguments into a table
  local arg = { ... }


  local value = arg[#arg]

  -- remove the last argument from the tables
  arg[#arg] = nil
  -- iterate table and create subtables if needed and on last iteration set the value
  ---@type table
  local currentTable = WayfinderDB -- start at the root
  for index, key in ipairs(arg) do
    if index == #arg then
      break
    end
    if not currentTable[key] then
      currentTable[key] = {} ---@type table
    end
    currentTable = currentTable[key] ---@type table
  end
  if type(currentTable) ~= "table" then
    return
  end
  -- arg[#arg] is the last key
  currentTable[arg[#arg]] = value ---@type boolean | number | string | table
end

---get a variable from the saved variables
---@param ... string | number | boolean | table
---@return string | number | boolean | table | nil
function Wayfinder:GetVar(...)
  if not WayfinderDB then
    WayfinderDB = {}
  end

  -- move all arguments into a table
  local arg = { ... }

  ---@type table
  local dbTable = WayfinderDB
  for index, key in ipairs(arg) do
    if index == #arg then
      return dbTable[key]
    end
    if not dbTable[key] then
      return nil
    end
    dbTable = dbTable[key] ---@type table
  end
end

---delete a variable from the saved variables
---@param ... string | number | boolean | table | nil
function Wayfinder:DeleteVar(...)
  if not WayfinderDB then
    WayfinderDB = {}
  end

  -- move all arguments into a table
  local arg = { ... }
  local dbTable = WayfinderDB
  for index, key in ipairs(arg) do
    if index == #arg then
      dbTable[key] = nil ---@type nil
    end
    if not dbTable[key] then
      return
    end
    dbTable = dbTable[key] ---@type table
  end
end

function Wayfinder:MigrateVar(prevKeys, newKeys)
  if not WayfinderDB then
    WayfinderDB = {}
  end
  local prevValue = self:GetVar(unpack(prevKeys))
  if prevValue then
    self:SaveVar(unpack(newKeys), prevValue)
    self:DeleteVar(unpack(prevKeys))
  end
end
