---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


--- Check if a value is secret
---@param value any
---@return boolean
function MapPinEnhanced:IsSecretValue(value)
    if issecretvalue and issecretvalue(value) then
        return true
    end
    return false
end

---Check if a table is secret
---@param value table
---@return boolean
function MapPinEnhanced:IsSecretTable(value)
    if issecrettable and issecrettable(value) then
        return true
    end
    return false
end

local cachedCharacterKey ---@type string?

---@return string?
function MapPinEnhanced:GetCharacterKey()
    if cachedCharacterKey then return cachedCharacterKey end
    local name, surname = UnitName("player")
    if self:IsSecretValue(name) or type(name) ~= "string" or name == "" then return nil end
    local regionalNames = rawget(_G, "RegionalUniqueNamesEnabled") --[[@as (fun(): boolean)?]]
    if regionalNames and regionalNames() then
        -- Regional characters retain their surname and numeric game mode;
        -- realm names are not their durable identity.
        if self:IsSecretValue(surname) then return nil end
        if type(surname) == "string" and surname ~= "" then name = name .. " " .. surname end
        if not C_GameRules or not C_GameRules.GetGameRuleAsFloat then return nil end
        local mode = C_GameRules.GetGameRuleAsFloat(Enum.GameRule.GameMode)
        if self:IsSecretValue(mode) or type(mode) ~= "number" then return nil end
        cachedCharacterKey = "Forever:" .. name .. ":" .. mode
    else
        local realm = GetRealmName()
        if self:IsSecretValue(realm) or type(realm) ~= "string" or realm == "" then return nil end
        cachedCharacterKey = "Retail:" .. realm .. ":" .. name
    end
    return cachedCharacterKey
end
