---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class SavedVars
local SavedVars = MapPinEnhanced:GetModule("SavedVars")

local CONSTANTS = MapPinEnhanced.CONSTANTS
local DEFAULTS = CONSTANTS.DEFAULTS

-- The annotation could be changed if multiple function annotations in a definition file are support by luals -> there is currently a PR open for this: https://github.com/LuaLS/lua-language-server/pull/2822

---Retrieves the default value for a given set of keys.
function SavedVars:GetDefault(key1, key2)
    local arg = { key1, key2 }
    local currentTable = DEFAULTS
    for index, key in ipairs(arg) do
        if index == #arg then -- last key
            if currentTable[key] == nil then
                assert(false, "Key does not exist in DEFAULTS table: " .. table.concat(arg, ".", 1, #arg - 1))
            end
            return currentTable[key]
        end
        if currentTable[key] == nil then
            assert(false, "Key does not exist in DEFAULTS table: " .. table.concat(arg, ".", 1, #arg - 1))
        end
        currentTable = currentTable[key] --[[@as table]]
    end
end

---save a variable to the saved variables
function SavedVars:Save(key1, key2, key3, key4, key5)
    if not MapPinEnhancedDB then
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { key1, key2, key3, key4, key5 }
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
function SavedVars:Get(key1, key2, key3)
    if not MapPinEnhancedDB then
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { key1, key2, key3 }

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
function SavedVars:Delete(key1, key2, key3, key4)
    if not MapPinEnhancedDB then
        MapPinEnhancedDB = {}
    end

    -- move all arguments into a table
    local arg = { key1, key2, key3, key4 }
    local dbTable = MapPinEnhancedDB
    for index, key in ipairs(arg) do
        if index == #arg then
            dbTable[key] = nil ---@type nil
        end
        if not dbTable[key] then
            return
        end
        -- this annotation is not fully correct as we might already have traversed into a subtable
        dbTable = dbTable[key] --[[@as MapPinEnhancedDB]]
    end
end

function SavedVars:MigrateVar(prevKeys, newKeys)
    if not MapPinEnhancedDB then
        MapPinEnhancedDB = {}
    end
    local prevValue = self:Get(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys)
    if prevValue ~= nil then
        self:Save(type(newKeys) == "table" and unpack(newKeys) or newKeys, prevValue)
        self:Delete(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys)
    end
end
