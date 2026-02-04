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
