---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---Save a variable to the saved variables
---@param ... string | number | boolean | table The last element is the value to save and the rest are keys where the value should be saved
---@return boolean? success
function MapPinEnhanced:SetVar(...)
    if not MapPinEnhancedDB then
        ---@type MapPinEnhancedDB
        MapPinEnhancedDB = {}
    end
    -- move all arguments into a table
    local arg = { ... }
    local value = arg[#arg] -- last argument is the value

    -- remove the last argument from the tables
    arg[#arg] = nil
    -- iterate table and create sub-tables if needed and on last iteration set the value

    local currentTable = MapPinEnhancedDB -- start at the root
    for index, key in ipairs(arg) do
        if index == #arg then
            break
        end
        if not currentTable[key] then
            currentTable[key] = {}
        end
        currentTable = currentTable[key] --[[@as any]]
    end
    if type(currentTable) ~= "table" then
        return
    end
    -- arg[#arg] is the last key
    currentTable[arg[#arg]] = value ---@type boolean | number | string | table
    return true
end

---Get a variable from the saved variables
---@param ... string The keys to traverse to get the value
---@return boolean | number | string | table | nil
function MapPinEnhanced:GetVar(...)
    if not MapPinEnhancedDB then
        MapPinEnhancedDB = {}
    end

    local arg = { ... }
    local dbTable = MapPinEnhancedDB

    for index, key in ipairs(arg) do
        if index == #arg then
            return dbTable[key]
        end
        if not dbTable[key] then
            return nil
        end
        dbTable = dbTable[key] --[[@as table]]
    end
    error("Error receiving value from saved variables")
end

---Delete a variable from the saved variables
---@param ... string The keys to traverse to delete the value
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
        -- this annotation is not fully correct as we might already have traversed into a sub-table
        ---@type table<string, boolean | number | string | table>
        dbTable = dbTable[key]
    end
end
