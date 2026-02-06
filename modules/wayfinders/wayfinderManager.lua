---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinder
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field cachedPinData pinData|nil the last set pin data, used to refresh wayfinders when they are enabled
local Wayfinder = MapPinEnhanced:GetModule("Wayfinder")

---@class MapPinEnhancedWayfinder
---@field SetWayfinderData fun(self: MapPinEnhancedWayfinder, pinData: pinData | nil) sets the wayfinder data for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
Wayfinder.activeWayfinders = {}

---@enum WayfinderType
local AVAILABLE_WAYFINDERS = {
    WAYFINDER_FLOATING = "WAYFINDER_FLOATING",
    WAYFINDER_ARROW = "WAYFINDER_ARROW",
}

---@param pinData pinData | nil
function Wayfinder:SetPinData(pinData)
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:SetWayfinderData(pinData)
    end
    self.cachedPinData = pinData
end

--- Set the wayfinder data for a specific wayfinder, used when enabling a wayfinder after pin data has already been set
---@param wayfinder MapPinEnhancedWayfinder
function Wayfinder:RefreshWayfinder(wayfinder)
    if not self.cachedPinData then return end
    wayfinder:SetWayfinderData(self.cachedPinData)
end

---@param wayfinderType WayfinderType
---@return MapPinEnhancedWayfinder
function Wayfinder:GetWayfinder(wayfinderType)
    local wayfinder = self.wayfinders and self.wayfinders[wayfinderType]
    assert(wayfinder.Enable and wayfinder.Disable and wayfinder.SetWayfinderData,
        "Wayfinder does not implement required methods")
    return wayfinder
end

---@param wayfinderType WayfinderType
function Wayfinder:EnableWayfinder(wayfinderType)
    local wayfinder = self:GetWayfinder(wayfinderType)
    if not wayfinder then
        error("Wayfinder type not registered: " .. tostring(wayfinderType))
    end
    wayfinder:Enable()
    table.insert(self.activeWayfinders, wayfinder)
end

---@param wayfinderType WayfinderType
function Wayfinder:DisableWayfinder(wayfinderType)
    local wayfinder = self:GetWayfinder(wayfinderType)
    if not wayfinder then
        error("Wayfinder type not registered: " .. tostring(wayfinderType))
    end
    wayfinder:Disable()
    for i, activeWayfinder in ipairs(self.activeWayfinders) do
        if activeWayfinder == wayfinder then
            table.remove(self.activeWayfinders, i)
            break
        end
    end
end
