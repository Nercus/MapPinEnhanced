---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@alias MapPinEnhancedDB table<string, table | number | string | boolean>


---save a variable to the saved variables
---@param ... string | number | boolean | table
function MapPinEnhanced:SaveVar(...)
    if not MapPinEnhancedDB then
        ---@type MapPinEnhancedDB
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { ... }
    local value = arg[#arg] -- last argument is the value

    -- remove the last argument from the tables
    arg[#arg] = nil
    -- iterate table and create subtables if needed and on last iteration set the value
    ---@type table
    local currentTable = MapPinEnhancedDB -- start at the root
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
function MapPinEnhanced:GetVar(...)
    if not MapPinEnhancedDB then
        ---@type MapPinEnhancedDB
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { ... }

    ---@type table
    local dbTable = MapPinEnhancedDB
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
function MapPinEnhanced:DeleteVar(...)
    if not MapPinEnhancedDB then
        ---@type MapPinEnhancedDB
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { ... }
    local dbTable = MapPinEnhancedDB
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

function MapPinEnhanced:MigrateVar(prevKeys, newKeys)
    if not MapPinEnhancedDB then
        ---@type MapPinEnhancedDB
        MapPinEnhancedDB = {}
    end
    local prevValue = self:GetVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys)
    if prevValue ~= nil then
        self:SaveVar(type(newKeys) == "table" and unpack(newKeys) or newKeys, prevValue)
        self:DeleteVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys)
    end
end
