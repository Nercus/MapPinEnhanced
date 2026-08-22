---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@alias SuperTrackingDiagnosticValue string|number|boolean|nil
---@alias SuperTrackingDiagnostics table<string, SuperTrackingDiagnosticValue>

---@class SuperTrackingProviderDescriptor
---@field source string
---@field superTrackingType Enum.SuperTrackingType
---@field getIdentity fun(): string
---@field refresh fun()
---@field events WowEvent[]?

---@class SuperTrackingFallbackDescriptor
---@field source string
---@field getIdentity fun(): string
---@field refresh fun()
---@field events WowEvent[]?

---@alias SuperTrackingDescriptor SuperTrackingProviderDescriptor|SuperTrackingFallbackDescriptor

local RESOLUTION_RETRY_DELAYS = { 0.1, 0.25, 0.5, 1, 2 }

---@type table<Enum.SuperTrackingType, SuperTrackingProviderDescriptor>
local providersByType = {}
---@type table<string, SuperTrackingDescriptor>
local providersBySource = {}
---@type SuperTrackingFallbackDescriptor?
local fallbackProvider
---@type table<WowEvent, table<string, boolean>>
local sourceEventProviders = {}

---@class PendingSuperTrackingResolution
---@field identity string
---@field revision integer
---@field attempts number
---@field timer FunctionContainer?

---@type table<string, PendingSuperTrackingResolution>
local pendingResolutions = {}

---@return SuperTrackingDescriptor?
local function GetActiveProvider()
    local superTrackingType = C_SuperTrack.GetHighestPrioritySuperTrackingType()
    if superTrackingType == nil or superTrackingType == Enum.SuperTrackingType.UserWaypoint then return nil end
    return providersByType[superTrackingType] or fallbackProvider
end

MapPinEnhanced:OnLoad(function()
    MapPinEnhanced:DeleteVar("superTrackingWayfinder")
end)

---@param value SuperTrackingDiagnosticValue
---@return string
local function FormatDiagnosticValue(value)
    return value == nil and "nil" or tostring(value)
end

---@param fields SuperTrackingDiagnostics
---@return string
local function FormatDiagnostics(fields)
    ---@type string[]
    local keys = {}
    for key in pairs(fields) do
        table.insert(keys, key)
    end
    table.sort(keys)

    local values = {}
    for _, key in ipairs(keys) do
        table.insert(values, string.format("%s=%s", key, FormatDiagnosticValue(fields[key])))
    end
    return table.concat(values, ", ")
end

---@type table<string, boolean>
local reportedTargets = {}

---@param identity string
---@param targetType string
---@param fields SuperTrackingDiagnostics
function Providers:ReportUnresolvedSuperTrackingTarget(identity, targetType, fields)
    if reportedTargets[identity] then return end
    reportedTargets[identity] = true
    MapPinEnhanced:Print(string.format(
        L["Tracked %s could not be resolved as a location (%s). Please provide this information to the addon author."],
        targetType, FormatDiagnostics(fields)))
end

---@param identity string
---@param fields SuperTrackingDiagnostics
function Providers:ReportUnsupportedSuperTrackingTarget(identity, fields)
    if reportedTargets[identity] then return end
    reportedTargets[identity] = true
    MapPinEnhanced:Print(string.format(
        L["Unsupported super-tracking target (%s). Please provide this information to the addon author."],
        FormatDiagnostics(fields)))
end

---@param identity string
function Providers:ClearSuperTrackingReport(identity)
    reportedTargets[identity] = nil
end

---@param source string
local function CancelPendingResolution(source)
    local pending = pendingResolutions[source]
    if not pending then return end
    if pending.timer then pending.timer:Cancel() end
    pendingResolutions[source] = nil
end

---@param source string
local function CancelOtherPendingResolutions(source)
    local pendingSources = {}
    for pendingSource in pairs(pendingResolutions) do
        if pendingSource ~= source then table.insert(pendingSources, pendingSource) end
    end
    ---@param pendingSource string
    for _, pendingSource in ipairs(pendingSources) do
        CancelPendingResolution(pendingSource)
    end
end

---@param activeSource string?
local function CancelInactivePendingResolutions(activeSource)
    local pendingSources = {}
    for pendingSource in pairs(pendingResolutions) do
        if pendingSource ~= activeSource then table.insert(pendingSources, pendingSource) end
    end
    for _, pendingSource in ipairs(pendingSources) do
        CancelPendingResolution(pendingSource)
    end
end

---@param provider SuperTrackingDescriptor?
local function ClearInactiveProviderTarget(provider)
    local owner, identity, revision = Wayfinders:GetActiveTargetIdentity()
    if not owner or not providersBySource[owner] then return end
    if provider and provider.source == owner then return end
    CancelPendingResolution(owner)
    Wayfinders:ClearTarget(owner, identity, revision)
end

---@param provider SuperTrackingDescriptor?
local function RefreshProvider(provider)
    ClearInactiveProviderTarget(provider)
    CancelInactivePendingResolutions(provider and provider.source or nil)
    if provider then provider.refresh() end
end

local function RefreshActiveProvider()
    RefreshProvider(GetActiveProvider())
end

---@param event WowEvent
local function OnSourceEvent(event)
    local provider = GetActiveProvider()
    if not provider then
        RefreshProvider(nil)
        return
    end
    local eventProviders = sourceEventProviders[event]
    if eventProviders and eventProviders[provider.source] then RefreshProvider(provider) end
end

---@param provider SuperTrackingDescriptor
local function RegisterSourceEvents(provider)
    local seenEvents = {}
    for _, event in ipairs(provider.events or {}) do
        assert(type(event) == "string" and event ~= "",
            "Providers:RegisterSuperTrackingProvider: events must contain non-empty strings")
        assert(event ~= "SUPER_TRACKING_CHANGED" and event ~= "SUPER_TRACKING_PATH_UPDATED" and
            event ~= "PLAYER_LOGIN",
            "Providers:RegisterSuperTrackingProvider: common events are registered by the coordinator")
        assert(not seenEvents[event],
            "Providers:RegisterSuperTrackingProvider: descriptor contains a duplicate event")
        seenEvents[event] = true

        local eventProviders = sourceEventProviders[event]
        if not eventProviders then
            eventProviders = {}
            sourceEventProviders[event] = eventProviders
            local sourceEvent = event
            MapPinEnhanced:RegisterEvent(sourceEvent, function() OnSourceEvent(sourceEvent) end)
        end
        eventProviders[provider.source] = true
    end
end

---@param provider SuperTrackingDescriptor
local function ValidateProvider(provider)
    assert(type(provider) == "table", "Providers:RegisterSuperTrackingProvider: descriptor must be a table")
    assert(type(provider.source) == "string" and provider.source ~= "",
        "Providers:RegisterSuperTrackingProvider: source must be a non-empty string")
    assert(type(provider.getIdentity) == "function",
        "Providers:RegisterSuperTrackingProvider: getIdentity must be a function")
    assert(type(provider.refresh) == "function",
        "Providers:RegisterSuperTrackingProvider: refresh must be a function")
    assert(provider.events == nil or type(provider.events) == "table",
        "Providers:RegisterSuperTrackingProvider: events must be a table or nil")
    assert(not providersBySource[provider.source],
        "Providers:RegisterSuperTrackingProvider: source is already registered")
end

---@param source string
---@param identity string
---@param targetType string
---@param fields SuperTrackingDiagnostics
function Providers:HandleUnresolvedSuperTrackingTarget(source, identity, targetType, fields)
    local provider = providersBySource[source]
    assert(provider, "Providers:HandleUnresolvedSuperTrackingTarget: source is not registered")

    -- Keep valid data while Blizzard rebuilds the path for the same target. If the
    -- target itself changed, the old coordinates must not remain visible.
    local activeOwner, activeIdentity, activeRevision = Wayfinders:GetActiveTargetIdentity()
    if activeOwner == source and activeIdentity ~= identity then
        Wayfinders:ClearTarget(source, activeIdentity, activeRevision)
    end
    if reportedTargets[identity] then return end

    local pending = pendingResolutions[source]
    if pending and pending.identity ~= identity then
        CancelPendingResolution(source)
    end
    pending = pendingResolutions[source]
    if not pending then
        local _, _, revision = Wayfinders:GetActiveTargetIdentity()
        pending = { identity = identity, revision = revision, attempts = 0 }
        pendingResolutions[source] = pending
    end
    if pending.timer then return end

    local retryDelay = RESOLUTION_RETRY_DELAYS[pending.attempts + 1]
    if not retryDelay then
        pendingResolutions[source] = nil
        Wayfinders:ClearTarget(source, identity, pending.revision)
        self:ReportUnresolvedSuperTrackingTarget(identity, targetType, fields)
        return
    end

    pending.attempts = pending.attempts + 1
    pending.timer = C_Timer.NewTimer(retryDelay, function()
        if pendingResolutions[source] ~= pending then return end
        local activeProvider = GetActiveProvider()
        if activeProvider ~= provider or activeProvider.getIdentity() ~= pending.identity then
            pendingResolutions[source] = nil
            return
        end
        local _, _, revision = Wayfinders:GetActiveTargetIdentity()
        if revision ~= pending.revision then
            pendingResolutions[source] = nil
            return
        end
        pending.timer = nil
        provider.refresh()
    end)
end

---@param provider SuperTrackingProviderDescriptor
function Providers:RegisterSuperTrackingProvider(provider)
    ValidateProvider(provider)
    assert(type(provider.superTrackingType) == "number",
        "Providers:RegisterSuperTrackingProvider: superTrackingType must be a number")
    assert(not providersByType[provider.superTrackingType],
        "Providers:RegisterSuperTrackingProvider: superTrackingType is already registered")
    providersByType[provider.superTrackingType] = provider
    providersBySource[provider.source] = provider
    RegisterSourceEvents(provider)
end

---@param provider SuperTrackingFallbackDescriptor
function Providers:RegisterSuperTrackingFallback(provider)
    ValidateProvider(provider)
    assert(not fallbackProvider, "Providers:RegisterSuperTrackingFallback: fallback is already registered")
    fallbackProvider = provider
    providersBySource[provider.source] = provider
    RegisterSourceEvents(provider)
end

---@param source string
function Providers:RefreshSuperTrackingProvider(source)
    local provider = GetActiveProvider()
    if provider and provider.source == source then RefreshProvider(provider) end
end

---@param source string
---@param identity string
---@param data WayfinderData
---@param removeTarget WayfinderTargetRemoval?
---@return integer revision
function Providers:SetSuperTrackingWayfinderData(source, identity, data, removeTarget)
    CancelPendingResolution(source)
    CancelOtherPendingResolutions(source)
    self:ClearSuperTrackingReport(identity)
    data.targetType = Wayfinders.TARGET_TYPE_BLIZZARD
    return Wayfinders:SetTarget(source, identity, data, removeTarget)
end

---@param source string
---@param identity string?
---@param revision integer?
---@return boolean
function Providers:ClearSuperTrackingWayfinderData(source, identity, revision)
    CancelPendingResolution(source)
    return Wayfinders:ClearTarget(source, identity, revision)
end

function Providers:CancelPendingSuperTrackingResolutions()
    local pendingSources = {}
    for source in pairs(pendingResolutions) do
        table.insert(pendingSources, source)
    end
    ---@param source string
    for _, source in ipairs(pendingSources) do
        CancelPendingResolution(source)
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshActiveProvider)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshActiveProvider)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshActiveProvider)
