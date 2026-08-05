---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field cachedData WayfinderData? the last set wayfinder data, used to update wayfinders when they are enabled after data has already been set
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, data: WayfinderData | nil) sets the wayfinder pin for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
---@field SetTitle fun(self: MapPinEnhancedWayfinder, title: string) sets the wayfinder title, if the wayfinder supports it
---@field SetColor fun(self: MapPinEnhancedWayfinder, color: string) sets the wayfinder color, if the wayfinder supports it
---@field SetTexture fun(self: MapPinEnhancedWayfinder, texture: string, usesAtlas: boolean) sets the wayfinder texture, if the wayfinder supports it
---@field SetLock fun(self: MapPinEnhancedWayfinder, lock: boolean) sets the wayfinder lock, if the wayfinder supports it
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
---@field texture string|number? an optional texture to use for the pin this will override the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the color of the pin, if texture is set, this will be ignored -> the colors are predefined names in CONSTANTS.PIN_COLORS
---@field lock boolean? if true, the pin will be not be removed automatically when it has been reached

--- Set the wayfinder data for the currently tracked pin, this will update all active wayfinders with the new data
---@param data WayfinderData
function Wayfinders:SetWayfinderData(data)
    self.cachedData = data
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:Init(data)
    end
    if data.mapID and data.x and data.y then
        MapPinEnhanced:EnableContinuousDistanceCheck(data.mapID, data.x, data.y)
    end
end

---@param title string
function Wayfinders:OverrideWayfinderTitle(title)
    if not self.cachedData then return end
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:SetTitle(title)
    end
    self.cachedData.title = title
end

---@param color string
function Wayfinders:OverrideWayfinderColor(color)
    if not self.cachedData then return end
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:SetColor(color)
    end
    self.cachedData.color = color
    self.cachedData.texture = nil
    self.cachedData.usesAtlas = nil
end

---@param texture string
---@param usesAtlas boolean
function Wayfinders:OverrideWayfinderTexture(texture, usesAtlas)
    if not self.cachedData then return end
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:SetTexture(texture, usesAtlas)
    end
    self.cachedData.texture = texture
    self.cachedData.usesAtlas = usesAtlas
    self.cachedData.color = nil
end

function Wayfinders:OverrideWayfinderLock(lock)
    if not self.cachedData then return end
    for _, wayfinder in ipairs(self.activeWayfinders) do
        wayfinder:SetLock(lock)
    end
    self.cachedData.lock = lock
end

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
    MapPinEnhanced:DisableContinuousDistanceCheck()
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
    for _, activeWayfinder in ipairs(self.activeWayfinders) do
        if activeWayfinder == wayfinder then return end
    end
    wayfinder:Enable()
    self:RefreshWayfinder(wayfinder)
    table.insert(self.activeWayfinders, wayfinder)
end

---@param wayfinderType WayfinderType
function Wayfinders:DisableWayfinder(wayfinderType)
    local wayfinder = self:GetWayfinder(wayfinderType)
    if not wayfinder then
        error("Wayfinders type not registered: " .. tostring(wayfinderType))
    end
    for i, activeWayfinder in ipairs(self.activeWayfinders) do
        if activeWayfinder == wayfinder then
            wayfinder:Disable()
            table.remove(self.activeWayfinders, i)
            return
        end
    end
end
