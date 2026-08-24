---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@alias SuperTrackingDiagnosticValue string|number|boolean|nil
---@alias SuperTrackingDiagnostics table<string, SuperTrackingDiagnosticValue>

---@class SuperTrackingProvider
---@field source string
---@field superTrackingType Enum.SuperTrackingType
---@field getTargetID fun(): string
---@field refresh fun()
---@field events WowEvent[]?

---@class SuperTrackingFallbackProvider
---@field source string
---@field getTargetID fun(): string
---@field refresh fun()
---@field events WowEvent[]?

local TARGET_RETRY_DELAYS = { 0.1, 0.25, 0.5, 1, 2 }

---@type table<Enum.SuperTrackingType, SuperTrackingProvider>
local providersByType = {}
---@type table<string, SuperTrackingProvider|SuperTrackingFallbackProvider>
local providersBySource = {}
---@type SuperTrackingFallbackProvider?
local fallbackProvider
---@type table<WowEvent, table<string, boolean>>
local sourceEventProviders = {}

---@class WaitingSuperTrackingTarget
---@field targetID string
---@field changeNumber integer
---@field attempts number
---@field timer FunctionContainer?

---@type table<string, WaitingSuperTrackingTarget>
local waitingTargets = {}

---@return SuperTrackingProvider|SuperTrackingFallbackProvider|nil
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

    ---@type string[]
    local values = {}
    for _, key in ipairs(keys) do
        table.insert(values, string.format("%s=%s", key, FormatDiagnosticValue(fields[key])))
    end
    return table.concat(values, ", ")
end

---@type table<string, boolean>
local reportedTargets = {}

---@param targetID string
---@param targetType string
---@param fields SuperTrackingDiagnostics
function Providers:ReportUnresolvedSuperTrackingTarget(targetID, targetType, fields)
    if reportedTargets[targetID] then return end
    reportedTargets[targetID] = true
    MapPinEnhanced:Print(string.format(
        L["Tracked %s could not be resolved as a location (%s). Please provide this information to the addon author."],
        targetType, FormatDiagnostics(fields)))
end

---@param targetID string
---@param fields SuperTrackingDiagnostics
function Providers:ReportUnsupportedSuperTrackingTarget(targetID, fields)
    if reportedTargets[targetID] then return end
    reportedTargets[targetID] = true
    MapPinEnhanced:Print(string.format(
        L["Unsupported super-tracking target (%s). Please provide this information to the addon author."],
        FormatDiagnostics(fields)))
end

---@param targetID string
function Providers:ClearSuperTrackingReport(targetID)
    reportedTargets[targetID] = nil
end

---@param source string
local function CancelTargetRetry(source)
    local waitingTarget = waitingTargets[source]
    if not waitingTarget then return end
    if waitingTarget.timer then waitingTarget.timer:Cancel() end
    waitingTargets[source] = nil
end

---@param source string
local function CancelOtherTargetRetries(source)
    ---@type string[]
    local sourcesToCancel = {}
    for waitingSource in pairs(waitingTargets) do
        if waitingSource ~= source then table.insert(sourcesToCancel, waitingSource) end
    end
    for _, waitingSource in ipairs(sourcesToCancel) do
        CancelTargetRetry(waitingSource)
    end
end

---@param activeSource string?
local function CancelInactiveTargetRetries(activeSource)
    ---@type string[]
    local sourcesToCancel = {}
    for waitingSource in pairs(waitingTargets) do
        if waitingSource ~= activeSource then table.insert(sourcesToCancel, waitingSource) end
    end
    for _, waitingSource in ipairs(sourcesToCancel) do
        CancelTargetRetry(waitingSource)
    end
end

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider|nil
local function ClearInactiveProviderTarget(provider)
    local owner, targetID, changeNumber = Wayfinders:GetActiveTargetState()
    if not owner or not providersBySource[owner] then return end
    if provider and provider.source == owner then return end
    CancelTargetRetry(owner)
    Wayfinders:ClearTarget(owner, targetID, changeNumber)
end

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider|nil
local function UpdateProviderTarget(provider)
    ClearInactiveProviderTarget(provider)
    CancelInactiveTargetRetries(provider and provider.source or nil)
    if provider then provider.refresh() end
end

local function RefreshActiveProvider()
    UpdateProviderTarget(GetActiveProvider())
end

---@param event WowEvent
local function OnSourceEvent(event)
    local provider = GetActiveProvider()
    if not provider then
        UpdateProviderTarget(nil)
        return
    end
    local eventProviders = sourceEventProviders[event]
    if eventProviders and eventProviders[provider.source] then UpdateProviderTarget(provider) end
end

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider
local function RegisterSourceEvents(provider)
    ---@type table<WowEvent, boolean>
    local seenEvents = {}
    for _, event in ipairs(provider.events or {}) do
        assert(type(event) == "string" and event ~= "",
            "Providers:RegisterSuperTrackingProvider: events must contain non-empty strings")
        assert(event ~= "SUPER_TRACKING_CHANGED" and event ~= "SUPER_TRACKING_PATH_UPDATED" and
            event ~= "PLAYER_LOGIN",
            "Providers:RegisterSuperTrackingProvider: common events are registered by the coordinator")
        assert(not seenEvents[event],
            "Providers:RegisterSuperTrackingProvider: provider contains a duplicate event")
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

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider
local function CheckProvider(provider)
    assert(type(provider) == "table", "Providers:RegisterSuperTrackingProvider: provider must be a table")
    assert(type(provider.source) == "string" and provider.source ~= "",
        "Providers:RegisterSuperTrackingProvider: source must be a non-empty string")
    assert(type(provider.getTargetID) == "function",
        "Providers:RegisterSuperTrackingProvider: getTargetID must be a function")
    assert(type(provider.refresh) == "function",
        "Providers:RegisterSuperTrackingProvider: refresh must be a function")
    assert(provider.events == nil or type(provider.events) == "table",
        "Providers:RegisterSuperTrackingProvider: events must be a table or nil")
    assert(not providersBySource[provider.source],
        "Providers:RegisterSuperTrackingProvider: source is already registered")
end

---@param source string
---@param targetID string
---@param targetType string
---@param fields SuperTrackingDiagnostics
function Providers:HandleUnresolvedSuperTrackingTarget(source, targetID, targetType, fields)
    local provider = providersBySource[source]
    assert(provider, "Providers:HandleUnresolvedSuperTrackingTarget: source is not registered")

    -- Keep valid data while Blizzard rebuilds the path for the same target. If the
    -- target itself changed, the old coordinates must not remain visible.
    local activeOwner, activeTargetID, activeChangeNumber = Wayfinders:GetActiveTargetState()
    if activeOwner == source and activeTargetID ~= targetID then
        Wayfinders:ClearTarget(source, activeTargetID, activeChangeNumber)
    end
    if reportedTargets[targetID] then return end

    local waitingTarget = waitingTargets[source]
    if waitingTarget and waitingTarget.targetID ~= targetID then
        CancelTargetRetry(source)
    end
    waitingTarget = waitingTargets[source]
    if not waitingTarget then
        local _, _, changeNumber = Wayfinders:GetActiveTargetState()
        waitingTarget = { targetID = targetID, changeNumber = changeNumber, attempts = 0 }
        waitingTargets[source] = waitingTarget
    end
    if waitingTarget.timer then return end

    local retryDelay = TARGET_RETRY_DELAYS[waitingTarget.attempts + 1]
    if not retryDelay then
        waitingTargets[source] = nil
        Wayfinders:ClearTarget(source, targetID, waitingTarget.changeNumber)
        self:ReportUnresolvedSuperTrackingTarget(targetID, targetType, fields)
        return
    end

    waitingTarget.attempts = waitingTarget.attempts + 1
    waitingTarget.timer = C_Timer.NewTimer(retryDelay, function()
        if waitingTargets[source] ~= waitingTarget then return end
        local activeProvider = GetActiveProvider()
        if not activeProvider or activeProvider ~= provider or activeProvider.getTargetID() ~= waitingTarget.targetID then
            waitingTargets[source] = nil
            return
        end
        local _, _, changeNumber = Wayfinders:GetActiveTargetState()
        if changeNumber ~= waitingTarget.changeNumber then
            waitingTargets[source] = nil
            return
        end
        waitingTarget.timer = nil
        provider.refresh()
    end)
end

---@param provider SuperTrackingProvider
function Providers:RegisterSuperTrackingProvider(provider)
    CheckProvider(provider)
    assert(type(provider.superTrackingType) == "number",
        "Providers:RegisterSuperTrackingProvider: superTrackingType must be a number")
    assert(not providersByType[provider.superTrackingType],
        "Providers:RegisterSuperTrackingProvider: superTrackingType is already registered")
    providersByType[provider.superTrackingType] = provider
    providersBySource[provider.source] = provider
    RegisterSourceEvents(provider)
end

---@param provider SuperTrackingFallbackProvider
function Providers:RegisterSuperTrackingFallback(provider)
    CheckProvider(provider)
    assert(not fallbackProvider, "Providers:RegisterSuperTrackingFallback: fallback is already registered")
    fallbackProvider = provider
    providersBySource[provider.source] = provider
    RegisterSourceEvents(provider)
end

---@param source string
function Providers:RefreshSuperTrackingProvider(source)
    local provider = GetActiveProvider()
    if provider and provider.source == source then UpdateProviderTarget(provider) end
end

---@param source string
---@param targetID string
---@param targetData WayfinderData
---@param removeTarget WayfinderTargetRemoval?
---@return integer changeNumber
function Providers:SetSuperTrackingWayfinderData(source, targetID, targetData, removeTarget)
    CancelTargetRetry(source)
    CancelOtherTargetRetries(source)
    self:ClearSuperTrackingReport(targetID)
    targetData.targetType = Wayfinders.TARGET_TYPE_BLIZZARD
    return Wayfinders:SetTarget(source, targetID, targetData, removeTarget)
end

---@param source string
---@param targetID string?
---@param changeNumber integer?
---@return boolean
function Providers:ClearSuperTrackingWayfinderData(source, targetID, changeNumber)
    CancelTargetRetry(source)
    return Wayfinders:ClearTarget(source, targetID, changeNumber)
end

function Providers:CancelSuperTrackingTargetRetries()
    ---@type string[]
    local sourcesToCancel = {}
    for source in pairs(waitingTargets) do
        table.insert(sourcesToCancel, source)
    end
    for _, source in ipairs(sourcesToCancel) do
        CancelTargetRetry(source)
    end
end

MapPinEnhanced:RegisterEvent("SUPER_TRACKING_CHANGED", RefreshActiveProvider)
MapPinEnhanced:RegisterEvent("SUPER_TRACKING_PATH_UPDATED", RefreshActiveProvider)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", RefreshActiveProvider)
