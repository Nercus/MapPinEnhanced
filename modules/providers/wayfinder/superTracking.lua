---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
---@field superTrackingProviderTypes table<Enum.SuperTrackingType, string>
---@field activeSuperTrackingSource string?
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

Providers.superTrackingProviderTypes = {}

---@alias SuperTrackingDiagnosticValue string|number|boolean
---@alias SuperTrackingDiagnostics table<string, SuperTrackingDiagnosticValue>

---@type fun(uiMapID: number): number?, number?, string?
local GetNextWaypointForMap = C_Navigation.GetNextWaypointForMap

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
    self.activeSuperTrackingSource = source
    self:ClearSuperTrackingReport(identity)
    data.targetType = Wayfinders.TARGET_TYPE_BLIZZARD
    Wayfinders:SetWayfinderData(data, removeTarget)
end

---@param source string
function Providers:ClearSuperTrackingWayfinderData(source)
    if self.activeSuperTrackingSource ~= source then return end
    self.activeSuperTrackingSource = nil
    Wayfinders:ClearWayfinderData()
end

function Providers:ClearActiveSuperTrackingWayfinderData()
    if not self.activeSuperTrackingSource then return end
    self.activeSuperTrackingSource = nil
    Wayfinders:ClearWayfinderData()
end

function Providers:ReleaseActiveSuperTrackingSource()
    self.activeSuperTrackingSource = nil
end

---@return number? x
---@return number? y
---@return number? mapID
---@return string? waypointDescription
function Providers:GetSuperTrackingWaypoint()
    local mapID = C_Map.GetBestMapForUnit("player")
    if not mapID then return end
    local x, y, waypointDescription = GetNextWaypointForMap(mapID)
    if x == nil or y == nil then return end
    return x, y, mapID, waypointDescription
end
