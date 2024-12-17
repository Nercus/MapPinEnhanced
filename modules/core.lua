---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@param name string
---@return table
function MapPinEnhanced:CreateModule(name)
    local m = {}
    if (not self.modules) then
        self.modules = {}
    end
    self.modules[name] = m
    return m
end

function MapPinEnhanced:GetModule(name)
    if (not self.modules or not self.modules[name]) then
        return self:CreateModule(name)
    end
    return self.modules[name]
end

--- TODO: CHANGE ALL FILE NAMES TO PASCAL CASE
