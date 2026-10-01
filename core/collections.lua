---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@param value table<string, boolean>?
---@return table<string, boolean>
function MapPinEnhanced:CopySet(value)
    ---@type table<string, boolean>
    local result = {}
    if type(value) ~= "table" then return result end
    for key, selected in pairs(value) do
        if selected then result[key] = true end
    end
    return result
end

---@param left table<string, boolean>?
---@param right table<string, boolean>?
---@return boolean
function MapPinEnhanced:SetsEqual(left, right)
    left, right = self:CopySet(left), self:CopySet(right)
    for key in pairs(left) do
        if not right[key] then return false end
    end
    for key in pairs(right) do
        if not left[key] then return false end
    end
    return true
end
