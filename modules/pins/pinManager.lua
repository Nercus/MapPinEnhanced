---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
---@field trackedPin MapPinEnhancedPinMixin the currently tracked pin, used to update wayfinders when the tracked pin changes
local Pins = MapPinEnhanced:GetModule("Pins")

---@type table<UUID, MapPinEnhancedPinMixin>
local activePins = {}

---@param pin MapPinEnhancedPinMixin
---@param pinID UUID
function Pins:OverridePinID(pin, pinID)
    assert(type(pinID) == "string", "Pins:OverridePinID: pinID must be a string")
    assert(not activePins[pin.pinID] or not pin.group or pin.pinID == pinID,
        "Pins:OverridePinID: cannot change an active group pin ID")
    assert(not activePins[pinID] or activePins[pinID] == pin,
        "Pins:OverridePinID: duplicate active pin ID")
    if activePins[pin.pinID] == pin then activePins[pin.pinID] = nil end
    pin.pinID = pinID
    activePins[pinID] = pin
end

---@param pin MapPinEnhancedPinMixin
function Pins:RemoveActivePin(pin)
    if activePins[pin.pinID] == pin then activePins[pin.pinID] = nil end
end

local function CreatePin()
    -- Acquire frames only in the protected setup below, after identity is assigned.
    return CreateFromMixins(MapPinEnhancedPinMixin)
end

local function ResetPin(_, pin, isNew)
    if not pin then return end
    if isNew then return end
    pin:Reset()
end

---@type ObjectPool<MapPinEnhancedPinMixin>
local pinsPool = CreateObjectPool(CreatePin, ResetPin)
pinsPool.capacity = 1000 -- only allow 1000 pins at the same time

---@param value number
---@return number
function Pins:ConvertPercentCoordinate(value)
    assert(type(value) == "number", "Pins:ConvertPercentCoordinate: value must be a number")
    return value > 1 and value / 100 or value
end

---@param initPinData pinData
---@param overridePinID UUID?
---@param group MapPinEnhancedGroupMixin?
---@param groupWillPersist boolean? true while the group is still adding the pin
---@return MapPinEnhancedPinMixin?
function Pins:CreatePin(initPinData, overridePinID, group, groupWillPersist)
    local pin = pinsPool:Acquire()
    if not pin then return nil end
    local success, message = pcall(function()
        pin:OverridePinID(overridePinID or MapPinEnhanced:GenerateUUID("pin"))
        pin.group = group
        pin:SetPinData(initPinData, groupWillPersist)
    end)
    if not success or not pin.initialized then
        if pin.initialized then pin.suppressPersistence = true end
        pinsPool:Release(pin)
        if not success then error(message, 0) end
        return nil
    end
    return pin
end

function Pins:GetPinByID(pinID)
    return pinID and activePins[pinID] or nil
end

---@param pinOrID MapPinEnhancedPinMixin|UUID
function Pins:ReleasePin(pinOrID)
    local pin = type(pinOrID) == "table" and pinOrID or self:GetPinByID(pinOrID)
    if not pin then return end
    pinsPool:Release(pin)
end

---@param pin MapPinEnhancedPinMixin | nil
function Pins:SetTrackedPin(pin)
    self.trackedPin = pin
end

function Pins:GetTrackedPin()
    return self.trackedPin
end

function Pins:UntrackTrackedPin()
    if not self.trackedPin then return end
    self.trackedPin:Untrack()
    self.trackedPin = nil
end

local function OnSuperTrackingChanged()
    local isTrackingAnything = C_SuperTrack.IsSuperTrackingAnything()
    local isTrackingUserWaypoint = C_SuperTrack.IsSuperTrackingUserWaypoint()
    local isNotTrackingWaypoint = isTrackingAnything and not isTrackingUserWaypoint
    if isNotTrackingWaypoint then
        Pins:UntrackTrackedPin()
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", OnSuperTrackingChanged)

MapPinEnhanced:GetModule("Options"):SubscribeToOptionChanges("Pins.Appearance.ShowMinimapPins", function()
    for _, pin in pairs(activePins) do pin:UpdateMinimapVisibility() end
end)

-- Ordinary pin appearance belongs to the collection, never to pooled frame lifetimes.
local Options = MapPinEnhanced:GetModule("Options")

---@param pin MapPinEnhancedPinMixin
---@param changedKey string?
function Pins:ApplyPinAppearance(pin, changedKey)
    local worldmap, minimap = pin.worldmapPin, pin.minimapPin
    if not pin.initialized or not worldmap or not minimap then return end
    if not changedKey or changedKey == "Pins.Appearance.WorldMapScale" then
        local scale = Options:GetOptionValue("Pins.Appearance.WorldMapScale") --[[@as number]]
        worldmap:SetSize(25 * scale, 25 * scale)
    end
    if not changedKey or changedKey == "Pins.Appearance.MinimapScale" then
        local scale = Options:GetOptionValue("Pins.Appearance.MinimapScale") --[[@as number]]
        minimap:SetSize(22 * scale, 22 * scale)
    end
    if not changedKey or changedKey == "Pins.Miscellaneous.ScaleOnHover" then
        worldmap.hoverScaleEnabled = Options:GetOptionValue("Pins.Miscellaneous.ScaleOnHover") == true
        if worldmap.hoverScaleEnabled then
            worldmap:SetHoverScale(worldmap.hovered == true)
        else
            worldmap:ResetHoverScale()
        end
    end
    if not changedKey or changedKey == "Pins.Appearance.FadeUntracked" then
        worldmap:ApplyHoverStyle()
        minimap:ApplyHoverStyle()
    end
    if not changedKey or changedKey == "Pins.Appearance.AlwaysPingTracked" then
        worldmap:RefreshTrackingPulse()
    end
end

for _, key in ipairs({ "Pins.Appearance.WorldMapScale", "Pins.Appearance.MinimapScale",
    "Pins.Appearance.FadeUntracked", "Pins.Appearance.AlwaysPingTracked", "Pins.Miscellaneous.ScaleOnHover" }) do
    Options:SubscribeToOptionChanges(key, function()
        for _, pin in pairs(activePins) do Pins:ApplyPinAppearance(pin, key) end
    end)
end
