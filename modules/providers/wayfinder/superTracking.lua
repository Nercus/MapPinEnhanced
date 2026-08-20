---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
---@field superTrackingProviderTypes table<Enum.SuperTrackingType, string>
---@field activeSuperTrackingSource string?
---@field activeSuperTrackingIdentity string?
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

Providers.superTrackingProviderTypes = {}

---@alias SuperTrackingDiagnosticValue string|number|boolean|nil
---@alias SuperTrackingDiagnostics table<string, SuperTrackingDiagnosticValue>
---@alias SuperTrackingWaypointResolver fun(mapID: number): number?, number?, string?

---@type SuperTrackingWaypointResolver
local GetNextWaypointForMap = C_SuperTrack.GetNextWaypointForMap

local RESOLUTION_RETRY_DELAYS = { 0.1, 0.25, 0.5, 1, 2 }

---@class PendingSuperTrackingResolution
---@field identity string
---@field attempts number
---@field timer FunctionContainer?

---@type table<string, PendingSuperTrackingResolution>
local pendingResolutions = {}

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

---@param source string
---@param identity string
---@param targetType string
---@param fields SuperTrackingDiagnostics
---@param refresh fun()
function Providers:HandleUnresolvedSuperTrackingTarget(source, identity, targetType, fields, refresh)
    assert(type(refresh) == "function",
        "Providers:HandleUnresolvedSuperTrackingTarget: refresh must be a function")

    -- Keep valid data while Blizzard rebuilds the path for the same target. If the
    -- target itself changed, the old coordinates must not remain visible.
    if self.activeSuperTrackingSource == source and self.activeSuperTrackingIdentity ~= identity then
        self.activeSuperTrackingSource = nil
        self.activeSuperTrackingIdentity = nil
        Wayfinders:ClearWayfinderData()
    end
    if reportedTargets[identity] then return end

    local pending = pendingResolutions[source]
    if pending and pending.identity ~= identity then
        CancelPendingResolution(source)
    end
    pending = pendingResolutions[source]
    if not pending then
        pending = { identity = identity, attempts = 0 }
        pendingResolutions[source] = pending
    end
    if pending.timer then return end

    local retryDelay = RESOLUTION_RETRY_DELAYS[pending.attempts + 1]
    if not retryDelay then
        pendingResolutions[source] = nil
        if self.activeSuperTrackingSource == source and self.activeSuperTrackingIdentity == identity then
            self.activeSuperTrackingSource = nil
            self.activeSuperTrackingIdentity = nil
            Wayfinders:ClearWayfinderData()
        end
        self:ReportUnresolvedSuperTrackingTarget(identity, targetType, fields)
        return
    end

    pending.attempts = pending.attempts + 1
    pending.timer = C_Timer.NewTimer(retryDelay, function()
        if pendingResolutions[source] ~= pending then return end
        pending.timer = nil
        refresh()
    end)
end

---@param source string
---@param superTrackingType Enum.SuperTrackingType
function Providers:RegisterSuperTrackingProvider(source, superTrackingType)
    assert(type(source) == "string", "Providers:RegisterSuperTrackingProvider: source must be a string")
    assert(type(superTrackingType) == "number",
        "Providers:RegisterSuperTrackingProvider: superTrackingType must be a number")
    assert(not self.superTrackingProviderTypes[superTrackingType],
        "Providers:RegisterSuperTrackingProvider: superTrackingType is already registered")
    self.superTrackingProviderTypes[superTrackingType] = source
end

---@param source string
---@param identity string
---@param data WayfinderData
---@param removeTarget fun()?
function Providers:SetSuperTrackingWayfinderData(source, identity, data, removeTarget)
    CancelPendingResolution(source)
    CancelOtherPendingResolutions(source)
    self.activeSuperTrackingSource = source
    self.activeSuperTrackingIdentity = identity
    self:ClearSuperTrackingReport(identity)
    data.targetType = Wayfinders.TARGET_TYPE_BLIZZARD
    Wayfinders:SetWayfinderData(data, removeTarget)
end

---@param source string
function Providers:ClearSuperTrackingWayfinderData(source)
    CancelPendingResolution(source)
    if self.activeSuperTrackingSource ~= source then return end
    self.activeSuperTrackingSource = nil
    self.activeSuperTrackingIdentity = nil
    Wayfinders:ClearWayfinderData()
end

function Providers:ClearActiveSuperTrackingWayfinderData()
    if not self.activeSuperTrackingSource then return end
    self.activeSuperTrackingSource = nil
    self.activeSuperTrackingIdentity = nil
    Wayfinders:ClearWayfinderData()
end

function Providers:ReleaseActiveSuperTrackingSource()
    self.activeSuperTrackingSource = nil
    self.activeSuperTrackingIdentity = nil
    local pendingSources = {}
    for source in pairs(pendingResolutions) do
        table.insert(pendingSources, source)
    end
    ---@param source string
    for _, source in ipairs(pendingSources) do
        CancelPendingResolution(source)
    end
end

---@param mapIDs number[]
---@param seenMapIDs table<number, boolean>
---@param mapID number?
local function AddMapID(mapIDs, seenMapIDs, mapID)
    if not mapID or seenMapIDs[mapID] then return end
    seenMapIDs[mapID] = true
    table.insert(mapIDs, mapID)
end

---@return number[] mapIDs
function Providers:GetSuperTrackingMapIDs()
    ---@type number[]
    local mapIDs = {}
    ---@type table<number, boolean>
    local seenMapIDs = {}
    ---@type number?
    local playerMapID = C_Map.GetBestMapForUnit("player")
    ---@type number?
    local visibleMapID
    if WorldMapFrame and WorldMapFrame.GetMapID then
        visibleMapID = WorldMapFrame:GetMapID()
    end

    -- Prefer the player's map so cross-map navigation points at the next route
    -- step. The visible world map is a useful fallback while tracking a clicked
    -- destination, matching Blizzard's waypoint UI behavior.
    AddMapID(mapIDs, seenMapIDs, playerMapID)
    AddMapID(mapIDs, seenMapIDs, visibleMapID)

    -- Some map types expose the route only on a parent/continent map.
    ---@type number[]
    local initialMapIDs = {}
    if playerMapID then table.insert(initialMapIDs, playerMapID) end
    if visibleMapID and visibleMapID ~= playerMapID then table.insert(initialMapIDs, visibleMapID) end
    for _, initialMapID in ipairs(initialMapIDs) do
        ---@type number
        local mapID = initialMapID
        for _ = 1, 4 do
            local mapInfo = C_Map.GetMapInfo(mapID)
            local parentMapID = mapInfo and mapInfo.parentMapID or nil
            if not parentMapID or parentMapID == 0 then break end
            mapID = parentMapID
            AddMapID(mapIDs, seenMapIDs, parentMapID)
        end
    end

    return mapIDs
end

---@param fallback? SuperTrackingWaypointResolver provider-specific resolver
---@return number? x
---@return number? y
---@return number? mapID
---@return string? waypointDescription
function Providers:GetSuperTrackingWaypoint(fallback)
    local mapIDs = self:GetSuperTrackingMapIDs()
    for _, mapID in ipairs(mapIDs) do
        local x, y, waypointDescription = GetNextWaypointForMap(mapID)
        if type(x) == "number" and type(y) == "number" then
            return x, y, mapID, waypointDescription
        end
    end

    if fallback then
        for _, mapID in ipairs(mapIDs) do
            local x, y, waypointDescription = fallback(mapID)
            if type(x) == "number" and type(y) == "number" then
                return x, y, mapID, waypointDescription
            end
        end
    end
end
