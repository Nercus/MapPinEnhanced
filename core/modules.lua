---@class MapPinEnhanced
---@field modules table<string, table> a list of modules that have been registered
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.modules = MapPinEnhanced.modules or {}


---Get a specific module by name, if the module is not found, it will be created
---@generic T
---@param name `T`
---@return T
function MapPinEnhanced:GetModule(name)
    assert(self.modules, "Modules not initialized")
    assert(name, "Module name not provided")

    if (not self.modules or not self.modules[name]) then
        local m = {}
        if (not self.modules) then
            self.modules = {}
        end
        self.modules[name] = m
        return m
    end
    return self.modules[name]
end
