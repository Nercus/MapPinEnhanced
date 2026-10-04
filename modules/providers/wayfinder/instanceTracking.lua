---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Pins = MapPinEnhanced:GetModule("Pins")
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")
local clearingTracking = false
local baselineReady = false
local previousInstance ---@type string?
local instanceTypes = { party = true, raid = true, scenario = true, pvp = true, arena = true }

function Providers:IsClearingTracking()
    return clearingTracking
end

local function ClearTrackingOnEntry()
    -- Invalidate deferred addon selection before releasing Steps. Native clear is last.
    clearingTracking = true
    Providers:CancelAddonPinSelection()
    Providers:CancelSuperTrackingTargetRetries()
    Providers:ClearStepSuperTracking(false)
    Pins:UntrackTrackedPin()
    local owner, destinationID, changeNumber = Navigation:GetActiveDestinationState()
    if owner then Navigation:ClearDestination(owner, destinationID, changeNumber) end
    Providers:UpdateSuperTrackingEntrySelection(nil, nil, true)
    C_SuperTrack.ClearAllSuperTracked()
    clearingTracking = false
end

local function UpdateInstance(isInitialLogin, isReloadingUi)
    local _, instanceType, difficultyID, _, _, _, _, instanceID = GetInstanceInfo()
    if MapPinEnhanced:IsSecretValue(instanceType) or type(instanceType) ~= "string" then return end
    local identity ---@type string?
    if instanceTypes[instanceType] then
        if not MapPinEnhanced:IsReadablePositiveInteger(instanceID) then return end
        if not MapPinEnhanced:IsReadableNumber(difficultyID) then return end
        identity = instanceType .. ":" .. instanceID .. ":" .. difficultyID
    end
    local entered = baselineReady and identity and identity ~= previousInstance
    previousInstance = identity
    baselineReady = true
    if isInitialLogin or isReloadingUi then return end
    if entered and Options:GetOptionValue("Pins.Tracking.AutoUntrack") then ClearTrackingOnEntry() end
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", UpdateInstance)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_NEW_AREA", function() UpdateInstance(false, false) end)
