---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

---@param pathType "walk"|"fly"
---@param mode "ground"|"flight"
---@param icon string
---@param method string
---@param instruction string
local function RegisterMovement(pathType, mode, icon, method, instruction)
    local function Presentation()
        return icon, method, instruction
    end

    ---@param graph NavigationGraph
    ---@param preparedData NavigationPreparedData
    ---@param pathReference integer
    ---@return NavigationCalculatedPathCost?
    ---@return string? failure
    local function CostCalculator(graph, preparedData, pathReference)
        local fromPointIndex = graph.pathFromPointIndexes[pathReference]
        if not fromPointIndex then return nil, "player travel requires an origin" end
        local toPointIndex = graph.pathToPointIndexes[pathReference]
        return Navigation:GetPlayerTravelCost(preparedData,
            graph.pointMapIDs[fromPointIndex], graph.pointXs[fromPointIndex], graph.pointYs[fromPointIndex],
            graph.pointMapIDs[toPointIndex], graph.pointXs[toPointIndex], graph.pointYs[toPointIndex], mode)
    end

    Navigation:RegisterPathAdapter(pathType, Presentation, nil, CostCalculator)
end

RegisterMovement("walk", "ground", "poi-traveldirections-arrow",
    L["Navigation Method Walking"], L["Navigation Walk"])
RegisterMovement("fly", "flight", "FlightPath", L["Navigation Method Flying"], L["Navigation Fly"])
