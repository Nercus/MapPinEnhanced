---@class MapPinEnhanced
---@field modules table<string, Module>
local MapPinEnhanced = select(2, ...)



---@alias ModuleName "Blizz" | "Options" | "PinFactory" | "PinProvider"| "SetFactory" | "SetManager" |"PinManager"



---@class Module
---@field name ModuleName


---@param name ModuleName
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

---@generic T
---@param name `T`
---@return T
function MapPinEnhanced:GetModule(name)
    return self.modules[name]
end
