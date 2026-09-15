---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local function PortalPresentation(destinationMapID)
    local instruction = L["Navigation Use Portal"]
    local mapInfo = destinationMapID and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(destinationMapID)
    if mapInfo and type(mapInfo.name) == "string" and mapInfo.name ~= "" then
        instruction = string.format(L["Navigation Use Portal To"], mapInfo.name)
    end
    return "MagePortalAlliance", L["Navigation Method Portal"], instruction
end

local function LocalPortalPresentation(destinationMapID)
    local _, method, instruction = PortalPresentation(destinationMapID)
    return "PortalBlue", method, instruction
end

local function BorderPresentation()
    return "poi-traveldirections-arrow2", L["Navigation Method Border"], L["Navigation Cross Border"]
end

local function FloorPresentation()
    return "poi-door", L["Navigation Method Floor Change"], L["Navigation Change Floor"]
end

-- Most generated portals omit a duration. Price the loading transition here
-- instead of allowing the generic fixed-duration guard to exclude the portal.
local DEFAULT_PORTAL_SECONDS = 5

---@param graph NavigationGraph
---@param _preparedData NavigationPreparedData
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
local function PortalCostCalculator(graph, _preparedData, pathReference)
    local duration = graph.pathDurations[pathReference]
    local estimated = duration == nil
    if estimated then
        duration = DEFAULT_PORTAL_SECONDS
    elseif type(duration) ~= "number" or duration < 0 or duration ~= duration or duration == math.huge then
        return nil, "invalid portal duration"
    end
    -- An authored zero describes an instant portal, not an unavailable Path.
    local seconds = math.max(duration, 1)
    return {
        expectedSeconds = seconds,
        uncertaintySeconds = 0,
        comparisonSeconds = seconds,
        explanation = { kind = "portal", seconds = seconds, estimated = estimated },
    }
end

Navigation:RegisterPathAdapter("portal", PortalPresentation, nil, PortalCostCalculator)
Navigation:RegisterPathAdapter("localportal", LocalPortalPresentation, nil, PortalCostCalculator)
Navigation:RegisterPathAdapter("border", BorderPresentation)
Navigation:RegisterPathAdapter("floor", FloorPresentation)
