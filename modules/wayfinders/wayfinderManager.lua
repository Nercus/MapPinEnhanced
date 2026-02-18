---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field cachedData WayfinderData? the last set wayfinder data, used to update wayfinders when they are enabled after data has already been set
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Distance = MapPinEnhanced:GetModule("Distance")

---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, data: WayfinderData | nil) sets the wayfinder pin for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
Wayfinders.activeWayfinders = {}

---@enum WayfinderType
local AVAILABLE_WAYFINDERS = {
    WAYFINDER_FLOATING = "WAYFINDER_FLOATING",
    WAYFINDER_ARROW = "WAYFINDER_ARROW",
}

---@class WayfinderData
---@field mapID number UIMapID of the zone
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field title string? title of the pin
---@field texture string? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS

--- Set the wayfinder data for the currently tracked pin, this will update all active wayfinders with the new data
---@param data WayfinderData
function Wayfinders:SetWayfinderData(data)
    self.cachedData = data
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:Init(data)
    end
    if data.mapID and data.x and data.y then
        Distance:EnableDistanceCheck(data.mapID, data.x, data.y)
    end
end

--- Set the wayfinder data for a specific wayfinder, used when enabling a wayfinder after pin data has already been set
---@param wayfinder MapPinEnhancedWayfinder
function Wayfinders:RefreshWayfinder(wayfinder)
    if self.cachedData then
        wayfinder:Init(self.cachedData)
    else
        wayfinder:Init(nil)
    end
end

function Wayfinders:ClearWayfinderData()
    self.cachedData = nil
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:Init(nil)
    end
    Distance:DisableDistanceCheck()
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
