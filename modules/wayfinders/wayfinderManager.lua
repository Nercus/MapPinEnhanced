---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
---@field wayfinders table<string, MapPinEnhancedWayfinder> a table of registered wayfinders, with values injected in each wayfinder file
---@field activeWayfinders MapPinEnhancedWayfinder[] a list of currently active wayfind
---@field TARGET_TYPE_PIN WayfinderTargetType
---@field TARGET_TYPE_BLIZZARD WayfinderTargetType
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinder
---@field Init fun(self: MapPinEnhancedWayfinder, data: WayfinderData | nil) sets the wayfinder pin for the wayfinder
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

---@alias WayfinderTargetRemoval fun(owner: string, identity: string, revision: integer)

---@class ActiveWayfinderTarget
---@field owner string
---@field identity string
---@field revision integer
---@field data WayfinderData
---@field removeTarget WayfinderTargetRemoval?

---@class ActiveWayfinderTargetSnapshot
---@field owner string
---@field identity string
---@field revision integer
---@field data WayfinderData

---@type ActiveWayfinderTarget?
local activeTarget
local targetRevision = 0

---@param data WayfinderData
---@return WayfinderData
local function CopyWayfinderData(data)
    return {
        mapID = data.mapID,
        x = data.x,
        y = data.y,
        title = data.title,
        texture = data.texture,
        usesAtlas = data.usesAtlas,
        color = data.color,
        lock = data.lock,
        targetType = Wayfinders:NormalizeTargetType(data.targetType),
    }
end

---@param target ActiveWayfinderTarget?
local function ApplyActiveTarget(target)
    activeTarget = target
    Wayfinders:ResetArrivalDetection()

    local data = target and target.data or nil
    for _, wayfinder in ipairs(Wayfinders.activeWayfinders) do
        wayfinder:Init(data)
    end

    if data and data.mapID and data.x and data.y then
        MapPinEnhanced:EnableContinuousDistanceCheck(data.mapID, data.x, data.y)
    else
        MapPinEnhanced:DisableContinuousDistanceCheck()
    end
end

---@param targetType string?
---@return WayfinderTargetType
function Wayfinders:NormalizeTargetType(targetType)
    if targetType == self.TARGET_TYPE_BLIZZARD then
        return self.TARGET_TYPE_BLIZZARD
    end
    return self.TARGET_TYPE_PIN
end

---@param targetType string?
---@return PinStyleMode
function Wayfinders:GetTargetStyleMode(targetType)
    if self:NormalizeTargetType(targetType) == self.TARGET_TYPE_BLIZZARD then
        return Pins.STYLE_MODE_OUTLINE
    end
    return Pins.STYLE_MODE_PIN
end

--- Replace the active target without invoking the superseded target's removal operation.
---@param owner string
---@param identity string
---@param data WayfinderData
---@param removeTarget WayfinderTargetRemoval?
---@return integer revision
function Wayfinders:SetTarget(owner, identity, data, removeTarget)
    assert(type(owner) == "string" and owner ~= "", "Wayfinders:SetTarget: owner must be a non-empty string")
    assert(type(identity) == "string" and identity ~= "",
        "Wayfinders:SetTarget: identity must be a non-empty string")
    assert(type(data) == "table", "Wayfinders:SetTarget: data must be a table")
    assert(removeTarget == nil or type(removeTarget) == "function",
        "Wayfinders:SetTarget: removeTarget must be a function or nil")

    targetRevision = targetRevision + 1
    ApplyActiveTarget({
        owner = owner,
        identity = identity,
        revision = targetRevision,
        data = CopyWayfinderData(data),
        removeTarget = removeTarget,
    })
    return targetRevision
end

--- Update only the target version observed by the caller.
---@param owner string
---@param identity string
---@param revision integer
---@param data WayfinderData
---@return integer? revision
function Wayfinders:UpdateTarget(owner, identity, revision, data)
    assert(type(data) == "table", "Wayfinders:UpdateTarget: data must be a table")
    if not self:IsTargetActive(owner, identity, revision) then return nil end

    targetRevision = targetRevision + 1
    ApplyActiveTarget({
        owner = owner,
        identity = identity,
        revision = targetRevision,
        data = CopyWayfinderData(data),
        removeTarget = activeTarget and activeTarget.removeTarget or nil,
    })
    return targetRevision
end

---@param owner string
---@param identity string?
---@param revision integer?
---@return boolean
function Wayfinders:IsTargetActive(owner, identity, revision)
    if not activeTarget or activeTarget.owner ~= owner then return false end
    if identity and activeTarget.identity ~= identity then return false end
    if revision and activeTarget.revision ~= revision then return false end
    return true
end

---@return string? owner
---@return string? identity
---@return integer revision
function Wayfinders:GetActiveTargetIdentity()
    if not activeTarget then return nil, nil, targetRevision end
    return activeTarget.owner, activeTarget.identity, activeTarget.revision
end

---@return ActiveWayfinderTargetSnapshot?
function Wayfinders:GetActiveTargetSnapshot()
    if not activeTarget then return nil end
    return {
        owner = activeTarget.owner,
        identity = activeTarget.identity,
        revision = activeTarget.revision,
        data = CopyWayfinderData(activeTarget.data),
    }
end

---@param owner string
---@param identity string?
---@param revision integer?
---@return boolean
function Wayfinders:ClearTarget(owner, identity, revision)
    if not self:IsTargetActive(owner, identity, revision) then return false end
    targetRevision = targetRevision + 1
    ApplyActiveTarget(nil)
    return true
end

---@return boolean
function Wayfinders:CanRemoveActiveTargetOnArrival()
    return activeTarget ~= nil and not activeTarget.data.lock and activeTarget.removeTarget ~= nil
end

function Wayfinders:RemoveActiveTargetOnArrival()
    if not self:CanRemoveActiveTargetOnArrival() then return end

    local target = activeTarget
    if not target then return end
    local removeTarget = target.removeTarget
    target.removeTarget = nil
    self:ResetArrivalDetection()
    if removeTarget then
        removeTarget(target.owner, target.identity, target.revision)
    end
end

---@param wayfinder MapPinEnhancedWayfinder
function Wayfinders:RefreshWayfinder(wayfinder)
    if activeTarget then
        wayfinder:Init(activeTarget.data)
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
