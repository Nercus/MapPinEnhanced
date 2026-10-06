---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

---@param context NavigationPathPresentationContext?
---@return string icon, string method, string instruction
local function PortalPresentation(context)
    local instruction = L["Navigation Take Portal"]
    if context and context.destinationName then
        instruction = context.originName and
            string.format(L["Navigation Take Portal From To"], context.originName, context.destinationName) or
            string.format(L["Navigation Take Portal To"], context.destinationName)
    end
    return "MagePortalAlliance", L["Navigation Method Portal"], instruction
end

local function LocalPortalPresentation(context)
    local _, method, instruction = PortalPresentation(context)
    return "PortalBlue", method, instruction
end

---@param context NavigationPathPresentationContext?
---@return string icon, string method, string instruction
local function BorderPresentation(context)
    local destination = context and context.destinationName
    return "poi-traveldirections-arrow2", L["Navigation Method Border"],
        destination and string.format(L["Navigation Cross Border To"], destination) or L["Navigation Cross Border"]
end

---@param context NavigationPathPresentationContext?
---@return string icon, string method, string instruction
local function FloorPresentation(context)
    local destination = context and context.destinationName
    return "poi-door", L["Navigation Method Floor Change"],
        destination and string.format(L["Navigation Change Floor To"], destination) or L["Navigation Change Floor"]
end

-- Most generated portals omit a duration. Price the loading transition here
-- instead of allowing the generic fixed-duration guard to exclude the portal.
local DEFAULT_PORTAL_SECONDS = 5
local LOADING_SCREEN_PENALTY_SECONDS = 10

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
        comparisonSeconds = seconds + LOADING_SCREEN_PENALTY_SECONDS,
        explanation = {
            kind = "portal",
            seconds = seconds,
            estimated = estimated,
            penaltySeconds = LOADING_SCREEN_PENALTY_SECONDS
        },
    }
end

---@param graph NavigationGraph
---@param preparedData NavigationPreparedData
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
local function BorderCostCalculator(graph, preparedData, pathReference)
    local duration = graph.pathDurations[pathReference]
    if duration ~= nil then
        if type(duration) ~= "number" or duration <= 0 or duration ~= duration or duration == math.huge then
            return nil, "invalid border duration"
        end
        return {
            expectedSeconds = duration,
            uncertaintySeconds = 0,
            comparisonSeconds = duration,
            explanation = { kind = "fixed", seconds = duration },
        }
    end
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    if not fromPointIndex then return nil, "border crossing requires an origin" end
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    -- Authored crossings establish ground connectivity even across map IDs.
    return Navigation:GetPlayerTravelCost(preparedData,
        graph.pointMapIDs[fromPointIndex], graph.pointXs[fromPointIndex], graph.pointYs[fromPointIndex],
        graph.pointMapIDs[toPointIndex], graph.pointXs[toPointIndex], graph.pointYs[toPointIndex], "border")
end

---@param graph NavigationGraph
---@param _preparedData NavigationPreparedData
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
local function FloorCostCalculator(graph, _preparedData, pathReference)
    local duration = graph.pathDurations[pathReference]
    if type(duration) ~= "number" or duration < 0 or duration ~= duration or duration == math.huge then
        return nil, "invalid floor duration"
    end
    local seconds = math.max(duration, 1)
    return {
        expectedSeconds = seconds,
        uncertaintySeconds = 0,
        comparisonSeconds = seconds,
        explanation = { kind = "floor", seconds = seconds },
    }
end

Navigation:RegisterPathHandler("portal", PortalPresentation, nil, PortalCostCalculator)
Navigation:RegisterPathHandler("localportal", LocalPortalPresentation, nil, PortalCostCalculator)
Navigation:RegisterPathHandler("border", BorderPresentation, nil, BorderCostCalculator)
Navigation:RegisterPathHandler("floor", FloorPresentation, nil, FloorCostCalculator)
