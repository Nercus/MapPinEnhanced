---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local DEFAULT_TRANSPORT_SECONDS = 240
local DEFAULT_TRAM_SECONDS = 300
local FALLBACK_UNCERTAINTY_FACTOR = 0.5

---@param pathType string
---@param icon string
---@param method string
local function RegisterTransport(pathType, icon, method)
    ---@param graph NavigationGraph
    ---@param _preparedData NavigationPreparedData
    ---@param pathReference integer
    ---@return NavigationCalculatedPathCost
    local function CostCalculator(graph, _preparedData, pathReference)
        local authoredDuration = graph.pathDurations[pathReference]
        local usesFallback = type(authoredDuration) ~= "number" or
            authoredDuration <= 0 or authoredDuration == math.huge
        local expectedSeconds = usesFallback and
            (pathType == "tram" and DEFAULT_TRAM_SECONDS or DEFAULT_TRANSPORT_SECONDS) or authoredDuration
        local uncertaintySeconds = usesFallback and expectedSeconds * FALLBACK_UNCERTAINTY_FACTOR or 0
        return {
            expectedSeconds = expectedSeconds,
            uncertaintySeconds = uncertaintySeconds,
            comparisonSeconds = expectedSeconds + uncertaintySeconds,
            explanation = {
                kind = "scheduled-transport",
                pathType = pathType,
                seconds = expectedSeconds,
                estimated = usesFallback,
            },
        }
    end

    Navigation:RegisterPathAdapter(pathType, function()
        return icon, method, L["Navigation Take Transport"]
    end, nil, CostCalculator)
end

RegisterTransport("boat", "FlightMasterFerry", L["Navigation Method Boat"])
RegisterTransport("ship", "DemonShip", L["Navigation Method Ship"])
RegisterTransport("zeppelin", "Vehicle-Air-Unoccupied", L["Navigation Method Zeppelin"])
RegisterTransport("tram", "Vehicle-Carriage", L["Navigation Method Tram"])
RegisterTransport("transport", "Vehicle-Ground-Unoccupied", L["Navigation Method Transport"])
