---@class MapPinEnhanced
---@field modules table<string, Module>
local MapPinEnhanced = select(2, ...)

---@class Module
---@field name string


---@param name string
---@return Module
function MapPinEnhanced:CreateModule(name)
    local module = {
        name = name,
    } ---@type Module
    if (not self.modules) then
        self.modules = {}
    end
    self.modules[name] = module
    return module
end

---@param name string
---@return Module
function MapPinEnhanced:GetModule(name)
    return self.modules[name]
end

function MapPinEnhanced:GetModuleAsync(name, callback)
    local m = self.modules[name]
    if (m) then
        callback(m)
    else
        C_Timer.After(0.1, function()
            callback(self.modules[name])
        end)
    end
end
