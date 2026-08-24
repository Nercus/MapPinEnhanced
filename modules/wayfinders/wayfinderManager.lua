---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field TARGET_TYPE_PIN WayfinderTargetType
---@field TARGET_TYPE_BLIZZARD WayfinderTargetType
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, targetData: WayfinderData | nil) sets the wayfinder pin for the wayfinder
---@field Enable fun(self: MapPinEnhancedWayfinder) enables the wayfinder
---@field Disable fun(self: MapPinEnhancedWayfinder) disables the wayfinder
---@field SetTitle fun(self: MapPinEnhancedWayfinder, title: string) sets the wayfinder title, if the wayfinder supports it
---@field SetColor fun(self: MapPinEnhancedWayfinder, color: string) sets the wayfinder color, if the wayfinder supports it
---@field SetTexture fun(self: MapPinEnhancedWayfinder, texture: string|number, usesAtlas: boolean) sets the wayfinder texture, if the wayfinder supports it
---@field SetTargetType fun(self: MapPinEnhancedWayfinder, targetType: WayfinderTargetType) sets the target style type
---@field SetLock fun(self: MapPinEnhancedWayfinder, lock: boolean) sets the wayfinder lock, if the wayfinder supports it
Wayfinders.activeWayfinders = {}

local Pins = MapPinEnhanced:GetModule("Pins")

---@alias WayfinderTargetType "pin" | "blizzard"
Wayfinders.TARGET_TYPE_PIN = "pin"
Wayfinders.TARGET_TYPE_BLIZZARD = "blizzard"

---@enum WayfinderType
local AVAILABLE_WAYFINDERS = {
    WAYFINDER_FLOATING = "WAYFINDER_FLOATING",
    WAYFINDER_ARROW = "WAYFINDER_ARROW",
}

---@class WayfinderData
---@field mapID number UIMapID of the zone
---@field x number x coordinate between 0 and 1
---@field y number y coordinate between 0 and 1
---@field title string? title of the target
---@field texture string|number? an optional texture to use for the target; this overrides the color
---@field usesAtlas boolean? if true, the texture is an atlas, otherwise it is a file path
---@field color string? the target color; ignored when texture is set
---@field lock boolean? if true, the target will not be removed automatically when reached
---@field targetType WayfinderTargetType? the target owner; missing or unknown values safely use the pin presentation

---@alias WayfinderTargetRemoval fun(owner: string, targetID: string, changeNumber: integer)

---@class ActiveWayfinderTarget
---@field owner string
---@field targetID string
---@field changeNumber integer
---@field targetData WayfinderData
---@field removeTarget WayfinderTargetRemoval?

---@class ActiveWayfinderTargetCopy
---@field owner string
---@field targetID string
---@field changeNumber integer
---@field targetData WayfinderData

---@type ActiveWayfinderTarget?
local activeTarget
local targetChangeNumber = 0

---@param targetData WayfinderData
---@return WayfinderData
local function CopyWayfinderData(targetData)
    return {
        mapID = targetData.mapID,
        x = targetData.x,
        y = targetData.y,
        title = targetData.title,
        texture = targetData.texture,
        usesAtlas = targetData.usesAtlas,
        color = targetData.color,
        lock = targetData.lock,
        targetType = Wayfinders:GetTargetTypeOrDefault(targetData.targetType),
    }
end

---@param target ActiveWayfinderTarget?
local function ApplyActiveTarget(target)
    activeTarget = target
    Wayfinders:ResetArrivalDetection()

    local targetData = target and target.targetData or nil
    for _, wayfinder in ipairs(Wayfinders.activeWayfinders) do
        wayfinder:Init(targetData)
    end

    if targetData and targetData.mapID and targetData.x and targetData.y then
        MapPinEnhanced:EnableContinuousDistanceCheck(targetData.mapID, targetData.x, targetData.y)
    else
        MapPinEnhanced:DisableContinuousDistanceCheck()
    end
end

---@param targetType string?
---@return WayfinderTargetType
function Wayfinders:GetTargetTypeOrDefault(targetType)
    if targetType == self.TARGET_TYPE_BLIZZARD then
        return self.TARGET_TYPE_BLIZZARD
    end
    return self.TARGET_TYPE_PIN
end

---@param targetType string?
---@return PinStyleMode
function Wayfinders:GetTargetStyleMode(targetType)
    if self:GetTargetTypeOrDefault(targetType) == self.TARGET_TYPE_BLIZZARD then
        return Pins.STYLE_MODE_OUTLINE
    end
    return Pins.STYLE_MODE_PIN
end

--- Replace the active target without invoking the superseded target's removal operation.
---@param owner string
---@param targetID string
---@param targetData WayfinderData
---@param removeTarget WayfinderTargetRemoval?
---@return integer changeNumber
function Wayfinders:SetTarget(owner, targetID, targetData, removeTarget)
    assert(type(owner) == "string" and owner ~= "", "Wayfinders:SetTarget: owner must be a non-empty string")
    assert(type(targetID) == "string" and targetID ~= "",
        "Wayfinders:SetTarget: targetID must be a non-empty string")
    assert(type(targetData) == "table", "Wayfinders:SetTarget: targetData must be a table")
    assert(removeTarget == nil or type(removeTarget) == "function",
        "Wayfinders:SetTarget: removeTarget must be a function or nil")

    targetChangeNumber = targetChangeNumber + 1
    ApplyActiveTarget({
        owner = owner,
        targetID = targetID,
        changeNumber = targetChangeNumber,
        targetData = CopyWayfinderData(targetData),
        removeTarget = removeTarget,
    })
    return targetChangeNumber
end

--- Update only the target version observed by the caller.
---@param owner string
---@param targetID string
---@param changeNumber integer
---@param targetData WayfinderData
---@return integer? changeNumber
function Wayfinders:UpdateTarget(owner, targetID, changeNumber, targetData)
    assert(type(targetData) == "table", "Wayfinders:UpdateTarget: targetData must be a table")
    if not self:IsTargetActive(owner, targetID, changeNumber) then return nil end

    targetChangeNumber = targetChangeNumber + 1
    ApplyActiveTarget({
        owner = owner,
        targetID = targetID,
        changeNumber = targetChangeNumber,
        targetData = CopyWayfinderData(targetData),
        removeTarget = activeTarget and activeTarget.removeTarget or nil,
    })
    return targetChangeNumber
end

---@param owner string
---@param targetID string?
---@param changeNumber integer?
---@return boolean
function Wayfinders:IsTargetActive(owner, targetID, changeNumber)
    if not activeTarget or activeTarget.owner ~= owner then return false end
    if targetID and activeTarget.targetID ~= targetID then return false end
    if changeNumber and activeTarget.changeNumber ~= changeNumber then return false end
    return true
end

---@return string? owner
---@return string? targetID
---@return integer changeNumber
function Wayfinders:GetActiveTargetState()
    if not activeTarget then return nil, nil, targetChangeNumber end
    return activeTarget.owner, activeTarget.targetID, activeTarget.changeNumber
end

---@return ActiveWayfinderTargetCopy?
function Wayfinders:GetActiveTargetSnapshot()
    if not activeTarget then return nil end
    return {
        owner = activeTarget.owner,
        targetID = activeTarget.targetID,
        changeNumber = activeTarget.changeNumber,
        targetData = CopyWayfinderData(activeTarget.targetData),
    }
end

---@param owner string
---@param targetID string?
---@param changeNumber integer?
---@return boolean
function Wayfinders:ClearTarget(owner, targetID, changeNumber)
    if not self:IsTargetActive(owner, targetID, changeNumber) then return false end
    targetChangeNumber = targetChangeNumber + 1
    ApplyActiveTarget(nil)
    return true
end

---@return boolean
function Wayfinders:CanRemoveActiveTargetOnArrival()
    return activeTarget ~= nil and not activeTarget.targetData.lock and activeTarget.removeTarget ~= nil
end

function Wayfinders:RemoveActiveTargetOnArrival()
    if not self:CanRemoveActiveTargetOnArrival() then return end

    local target = activeTarget
    if not target then return end
    local removeTarget = target.removeTarget
    target.removeTarget = nil
    self:ResetArrivalDetection()
    if removeTarget then
        removeTarget(target.owner, target.targetID, target.changeNumber)
    end
end

---@param wayfinder MapPinEnhancedWayfinder
function Wayfinders:RefreshWayfinder(wayfinder)
    if activeTarget then
        wayfinder:Init(activeTarget.targetData)
    else
        wayfinder:Init(nil)
    end
end

---@param wayfinderType WayfinderType
---@return MapPinEnhancedWayfinder
function Wayfinders:GetWayfinder(wayfinderType)
    local wayfinder = self.wayfinders and self.wayfinders[wayfinderType]
    assert(wayfinder.Enable and wayfinder.Disable and wayfinder.Init and wayfinder.SetTargetType,
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
