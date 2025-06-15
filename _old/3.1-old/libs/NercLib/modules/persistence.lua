---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib


---@param addon NercLibAddon
function NercLib:AddPersistenceModule(addon)
    ---@class SavedVars
    local SavedVars = addon:GetModule("SavedVars")
    local DEFAULTS = {}

    ---@type table?
    local DB = _G[addon.tableName]
    if not DB then
        DB = {}
        ---@type table
        _G[addon.tableName] = DB
    end

    ---Retrieves the default value for a given set of keys.
    ---@param ... string The keys to traverse to get the default value
    ---@return boolean | number | string | table
    function SavedVars:GetDefault(...)
        local arg = { ... }
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
        error("DEFAULT table is empty")
    end

    function SavedVars:SetDefaults(defaults)
        DEFAULTS = defaults
    end

    ---save a variable to the saved variables
    ---@param ... string | number | boolean | table The last element is the value to save and the rest are keys where the value should be saved
    function SavedVars:SetVar(...)
        -- move all arguments into a table
        local arg = { ... }
        local value = arg[#arg] -- last argument is the value

        -- remove the last argument from the tables
        arg[#arg] = nil
        -- iterate table and create sub-tables if needed and on last iteration set the value
        ---@type table
        local currentTable = _G[addon.tableName] -- start at the root
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
    ---@param ... string The keys to traverse to get the value
    ---@return boolean | number | string | table | nil
    function SavedVars:GetVar(...)
        -- move all arguments into a table
        local arg = { ... }

        ---@type table
        local dbTable = _G[addon.tableName]
        for index, key in ipairs(arg) do
            if index == #arg then
                return dbTable[key]
            end
            if not dbTable[key] then
                return nil
            end
            dbTable = dbTable[key] ---@type table
        end
        error("Error receiving value from saved variables")
    end

    ---delete a variable from the saved variables
    ---@param ... string The keys to traverse to delete the value
    function SavedVars:DeleteVar(...)
        -- move all arguments into a table
        local arg = { ... }
        local dbTable = _G[addon.tableName]
        for index, key in ipairs(arg) do
            if index == #arg then
                dbTable[key] = nil ---@type nil
            end
            if not dbTable[key] then
                return
            end
            -- this annotation is not fully correct as we might already have traversed into a sub-table
            dbTable = dbTable[key] ---@type table
        end
    end

    ---@param prevKeys string | table
    ---@param newKeys string | table
    function SavedVars:MigrateVar(prevKeys, newKeys)
        local prevValue = self:GetVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys --[[@as string]])
        if prevValue ~= nil then
            self:SetVar(type(newKeys) == "table" and unpack(newKeys) or newKeys, prevValue)
            self:DeleteVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys --[[@as string]])
        end
    end
end
