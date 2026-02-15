---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field trackedPin MapPinEnhancedPinMixin the currently tracked pin, used to update wayfinders when the tracked pin changes
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")


---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, pin: MapPinEnhancedPinMixin | nil) sets the wayfinder pin for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
Wayfinders.activeWayfinders = {}

---@enum WayfinderType
local AVAILABLE_WAYFINDERS = {
    WAYFINDER_FLOATING = "WAYFINDER_FLOATING",
    WAYFINDER_ARROW = "WAYFINDER_ARROW",
}

---@param pin MapPinEnhancedPinMixin | nil
function Wayfinders:SetTrackedPin(pin)
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:Init(pin)
    end
    self.trackedPin = pin
end

function Wayfinders:UntrackTrackedPin()
    if not self.trackedPin then return end
    self.trackedPin:Untrack()
    self.trackedPin = nil
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:Init(nil)
    end
end

--- Set the wayfinder data for a specific wayfinder, used when enabling a wayfinder after pin data has already been set
---@param wayfinder MapPinEnhancedWayfinder
function Wayfinders:RefreshWayfinder(wayfinder)
    if not self.trackedPin then return end
    wayfinder:Init(self.trackedPin)
end

---@param wayfinderType WayfinderType
---@return MapPinEnhancedWayfinder
function Wayfinders:GetWayfinder(wayfinderType)
    local wayfinder = self.wayfinders and self.wayfinders[wayfinderType]
    assert(wayfinder.Enable and wayfinder.Disable and wayfinder.Init,
        "Wayfinders does not implement required methods")
    return wayfinder
end

---@param wayfinderType WayfinderType
function Wayfinders:EnableWayfinder(wayfinderType)
    local wayfinder = self:GetWayfinder(wayfinderType)
    if not wayfinder then
        error("Wayfinders type not registered: " .. tostring(wayfinderType))
    end
    wayfinder:Enable()
    table.insert(self.activeWayfinders, wayfinder)
end

---@param wayfinderType WayfinderType
function Wayfinders:DisableWayfinder(wayfinderType)
    local wayfinder = self:GetWayfinder(wayfinderType)
    if not wayfinder then
        error("Wayfinders type not registered: " .. tostring(wayfinderType))
    end
    wayfinder:Disable()
    for i, activeWayfinder in ipairs(self.activeWayfinders) do
        if activeWayfinder == wayfinder then
            table.remove(self.activeWayfinders, i)
            break
        end
    end
end
