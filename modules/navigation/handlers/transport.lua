---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local DEFAULT_TRANSPORT_SECONDS = 240
local DEFAULT_TRAM_SECONDS = 300
local DEFAULT_BOAT_SECONDS = 150
-- Authored travelDuration includes average waiting; compare expected totals only.

---@param pathType string
---@param icon string
---@param method string
local function RegisterTransport(pathType, icon, method)
    local defaultSeconds = pathType == "tram" and DEFAULT_TRAM_SECONDS or
        (pathType == "boat" or pathType == "ship") and DEFAULT_BOAT_SECONDS or DEFAULT_TRANSPORT_SECONDS
    ---@param graph NavigationGraph
    ---@param _preparedData NavigationPreparedData
    ---@param pathReference integer
    ---@return NavigationCalculatedPathCost
    local function CostCalculator(graph, _preparedData, pathReference)
        local authoredDuration = graph.pathDurations[pathReference]
        local usesFallback = type(authoredDuration) ~= "number" or
            authoredDuration <= 0 or authoredDuration == math.huge
        local expectedSeconds = usesFallback and defaultSeconds or authoredDuration
        return {
            expectedSeconds = expectedSeconds,
            uncertaintySeconds = 0,
            comparisonSeconds = expectedSeconds,
            explanation = {
                kind = "scheduled-transport",
                pathType = pathType,
                seconds = expectedSeconds,
                estimated = true,
            },
        }
    end

    Navigation:RegisterPathHandler(pathType, function()
        return icon, method, L["Navigation Take Transport"]
    end, nil, CostCalculator)
end

RegisterTransport("boat", "FlightMasterFerry", L["Navigation Method Boat"])
RegisterTransport("ship", "FlightMasterFerry", L["Navigation Method Ship"])
RegisterTransport("zeppelin", "Vehicle-Air-Unoccupied", L["Navigation Method Zeppelin"])
RegisterTransport("tram", "Vehicle-SilvershardMines-MineCart", L["Navigation Method Tram"])
RegisterTransport("transport", "Vehicle-Ground-Unoccupied", L["Navigation Method Transport"])
