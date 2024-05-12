---@class Wayfinder
---@field modules table<string, Module>
local Wayfinder = select(2, ...)

---@class Module
---@field name string


---@param name string
---@return Module
function Wayfinder:CreateModule(name)
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
function Wayfinder:GetModule(name)
  return self.modules[name]
end
