---@class MapPinEnhanced
---@field defaults table<string, any> a list of default values for the addon
---@field db table<string, any> the saved variables for the addon
local MapPinEnhanced = select(2, ...)

---Initializes the saved variables for the addon
function MapPinEnhanced:InitDB()
    if self.db then return end
    local addon = self.name
    self.defaults = self.defaults or {}
    self.db = _G[addon .. "DB"]
    if not self.db then
        self.db = {}
        ---@type table<string, any>
        _G[addon .. "DB"] = self.db
    end
end

---Retrieves the default value for a given set of keys.
---@param ... string The keys to traverse to get the default value
---@return boolean | number | string | table
function MapPinEnhanced:GetDefault(...)
    local arg = { ... }
    local currentTable = self.defaults
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

---Set the default value for a given set of keys.
---@param ... string | number | boolean | table The last element is the value to save and the rest are keys where the value should be saved
function MapPinEnhanced:SetDefault(...)
    -- move all arguments into a table
    local arg = { ... }
    local value = arg[#arg] -- last argument is the value

    -- remove the last argument from the tables
    arg[#arg] = nil
    -- iterate table and create sub-tables if needed and on last iteration set the value
    local currentTable = self.defaults -- start at the root
    for index, key in ipairs(arg) do
        if index == #arg then
            break
        end
        if not currentTable[key] then
            currentTable[key] = {}
        end
        ---@type table<string, boolean | number | string | table>
        currentTable = currentTable[key]
    end
    if type(currentTable) ~= "table" then
        return
    end
    -- arg[#arg] is the last key
    ---@type table<string, boolean | number | string | table>
    currentTable[arg[#arg]] = value
end

---Save a variable to the saved variables
---@param ... string | number | boolean | table The last element is the value to save and the rest are keys where the value should be saved
function MapPinEnhanced:SetVar(...)
    if not self.db then
        self:InitDB()
    end
    -- move all arguments into a table
    local arg = { ... }
    local value = arg[#arg] -- last argument is the value

    -- remove the last argument from the tables
    arg[#arg] = nil
    -- iterate table and create sub-tables if needed and on last iteration set the value

    local currentTable = self.db -- start at the root
    for index, key in ipairs(arg) do
        if index == #arg then
            break
        end
        if not currentTable[key] then
            currentTable[key] = {}
        end
        currentTable = currentTable[key]
    end
    if type(currentTable) ~= "table" then
        return
    end
    -- arg[#arg] is the last key
    currentTable[arg[#arg]] = value ---@type boolean | number | string | table
end

---Get a variable from the saved variables
---@param ... string The keys to traverse to get the value
---@return boolean | number | string | table | nil
function MapPinEnhanced:GetVar(...)
    if not self.db then
        self:InitDB()
    end
    -- move all arguments into a table
    local arg = { ... }


    local dbTable = self.db
    for index, key in ipairs(arg) do
        if index == #arg then
            return dbTable[key]
        end
        if not dbTable[key] then
            return nil
        end
        dbTable = dbTable[key]
    end
    error("Error receiving value from saved variables")
end

---Delete a variable from the saved variables
---@param ... string The keys to traverse to delete the value
function MapPinEnhanced:DeleteVar(...)
    if not self.db then
        self:InitDB()
    end
    -- move all arguments into a table
    local arg = { ... }
    local dbTable = self.db
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

---Migrate a variable from one set of keys to another
---@param prevKeys string | string[]
---@param newKeys string | string[]
function MapPinEnhanced:MigrateVar(prevKeys, newKeys)
    local prevValue = self:GetVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys --[[@as string]])
    if prevValue ~= nil then
        self:SetVar(type(newKeys) == "table" and unpack(newKeys) or newKeys, prevValue)
        self:DeleteVar(type(prevKeys) == "table" and unpack(prevKeys) or prevKeys --[[@as string]])
    end
end
