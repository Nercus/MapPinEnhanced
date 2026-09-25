---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local TAXI_ESTIMATED_SPEED = 25
local TAXI_FALLBACK_SECONDS = 240
local TAXI_POSITION_TOLERANCE = 0.005

---@class NavigationFlightTaxiData
---@field fromMap number
---@field fromX number
---@field fromY number
---@field toMap number
---@field toX number
---@field toY number
---@field fromTaxiNodeID number?
---@field toTaxiNodeID number?

---@class NavigationTaxiNodeState
---@field nodeID number
---@field x number
---@field y number
---@field known boolean?

local taxiNodesByMap = {} ---@type table<number, NavigationTaxiNodeState[]|false>
local activePathReference ---@type integer?
local activeReport ---@type NavigationPathReport?

local function Presentation()
    return "FlightMaster", L["Navigation Method Flight Taxi"], L["Navigation Take Transport"]
end

---@param path NavigationStaticPath
---@return NavigationFlightTaxiData? data
---@return string? failure
local function Dataprovider(path)
    if type(path.fromMap) ~= "number" or type(path.fromX) ~= "number" or type(path.fromY) ~= "number" then
        return nil, "missing taxi origin"
    end
    return {
        fromMap = path.fromMap,
        fromX = path.fromX,
        fromY = path.fromY,
        toMap = path.toMap,
        toX = path.toX,
        toY = path.toY,
        fromTaxiNodeID = path.fromTaxiNodeID,
        toTaxiNodeID = path.toTaxiNodeID,
    }
end

---@param mapID number
---@return NavigationTaxiNodeState[]?
local function GetTaxiNodes(mapID)
    local cached = taxiNodesByMap[mapID]
    if cached ~= nil then return cached or nil end
    if not C_TaxiMap or not C_TaxiMap.GetTaxiNodesForMap then
        taxiNodesByMap[mapID] = false
        return nil
    end

    local taxiNodes = {} ---@type NavigationTaxiNodeState[]
    for _, node in ipairs(C_TaxiMap.GetTaxiNodesForMap(mapID) or {}) do
        local position = node.position
        local x ---@type number?
        local y ---@type number?
        if position and position.GetXY then x, y = position:GetXY() end
        if type(node.nodeID) == "number" and type(x) == "number" and type(y) == "number" then
            local known ---@type boolean?
            if type(node.isUndiscovered) == "boolean" then known = not node.isUndiscovered end
            table.insert(taxiNodes, {
                nodeID = node.nodeID,
                x = x,
                y = y,
                known = known,
            })
        end
    end
    taxiNodesByMap[mapID] = taxiNodes
    return taxiNodes
end

---@param mapID number
---@param x number
---@param y number
---@param nodeID number?
---@return NavigationTaxiNodeState?
local function FindTaxiNode(mapID, x, y, nodeID)
    local taxiNodes = GetTaxiNodes(mapID)
    if not taxiNodes then return nil end
    local closestNode ---@type NavigationTaxiNodeState?
    local closestDistanceSquared = TAXI_POSITION_TOLERANCE * TAXI_POSITION_TOLERANCE
    for _, taxiNode in ipairs(taxiNodes) do
        if nodeID and taxiNode.nodeID == nodeID then return taxiNode end
        local deltaX = taxiNode.x - x
        local deltaY = taxiNode.y - y
        local distanceSquared = deltaX * deltaX + deltaY * deltaY
        if not nodeID and distanceSquared <= closestDistanceSquared then
            closestNode = taxiNode
            closestDistanceSquared = distanceSquared
        end
    end
    return closestNode
end

---@param graph NavigationGraph
---@param _preparedData NavigationPreparedData
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
local function CostCalculator(graph, _preparedData, pathReference)
    local data = graph.pathHandlerData[pathReference] ---@type NavigationFlightTaxiData
    local fromNode = FindTaxiNode(data.fromMap, data.fromX, data.fromY, data.fromTaxiNodeID)
    local toNode = FindTaxiNode(data.toMap, data.toX, data.toY, data.toTaxiNodeID)
    if fromNode and fromNode.known == false then return nil, "origin taxi node is undiscovered" end
    if toNode and toNode.known == false then return nil, "destination taxi node is undiscovered" end

    if not fromNode or fromNode.known ~= true then return nil, "origin taxi knowledge is unknown" end
    if not toNode or toNode.known ~= true then return nil, "destination taxi knowledge is unknown" end

    local authoredDuration = graph.pathDurations[pathReference]
    local estimated = type(authoredDuration) ~= "number" or
        authoredDuration <= 0 or authoredDuration == math.huge
    local expectedSeconds = authoredDuration ---@type number
    if estimated then
        local distance = Navigation:GetComparableDistance(data.fromMap, data.fromX, data.fromY,
            data.toMap, data.toX, data.toY)
        expectedSeconds = distance and math.max(1, distance / TAXI_ESTIMATED_SPEED) or TAXI_FALLBACK_SECONDS
    end
    local uncertaintySeconds = estimated and math.max(30, expectedSeconds * 0.25) or 0
    return {
        expectedSeconds = expectedSeconds,
        uncertaintySeconds = uncertaintySeconds,
        comparisonSeconds = expectedSeconds + uncertaintySeconds,
        explanation = {
            kind = "flight-taxi",
            seconds = expectedSeconds,
            estimated = estimated,
            unlock = "known",
            fromTaxiNodeID = fromNode.nodeID,
            toTaxiNodeID = toNode.nodeID,
        },
    }
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
local function Activator(context, report)
    activePathReference = context.pathReference
    activeReport = report
end

local function Deactivator()
    activePathReference = nil
    activeReport = nil
end

local function RefreshTaxiNodeKnowledge()
    taxiNodesByMap = {}
    Navigation:RecheckFailedPaths("taxi")
    local graph = Navigation:GetGraph()
    local preparedData = Navigation:GetPreparedData()
    if not activePathReference or not activeReport or not graph or not preparedData then return end
    local pathCost, failure = CostCalculator(graph, preparedData, activePathReference)
    if not pathCost then activeReport("failed", failure) end
end

MapPinEnhanced:RegisterEvent("TAXIMAP_OPENED", RefreshTaxiNodeKnowledge)
MapPinEnhanced:RegisterEvent("TAXI_NODE_STATUS_CHANGED", RefreshTaxiNodeKnowledge)

Navigation:RegisterPathHandler("flighttaxi", Presentation, Dataprovider, CostCalculator,
    Activator, Deactivator)
