---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
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
---@field x number?
---@field y number?
---@field known boolean?

local taxiNodesByMap = {} ---@type table<number, NavigationTaxiNodeState[]|false>
local taxiMapByNodeID = {} ---@type table<number, number>
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
    if type(path.fromTaxiNodeID) == "number" then taxiMapByNodeID[path.fromTaxiNodeID] = path.fromMap end
    if type(path.toTaxiNodeID) == "number" then taxiMapByNodeID[path.toTaxiNodeID] = path.toMap end
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
        if type(node.nodeID) == "number" then
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

---@param nodeID number
---@return NavigationTaxiNodeState?
local function GetTaxiNodeByID(nodeID)
    local mapID = taxiMapByNodeID[nodeID]
    if not mapID then return nil end
    for _, node in ipairs(GetTaxiNodes(mapID) or {}) do
        if node.nodeID == nodeID then return node end
    end
    return nil
end

---@param nodeID number
---@return boolean? known
function Navigation:IsTaxiNodeKnown(nodeID)
    local node = GetTaxiNodeByID(nodeID)
    if node then return node.known end
    return nil
end

---@param mapID number
---@param x number
---@param y number
---@param nodeID number?
---@return NavigationTaxiNodeState?
local function FindTaxiNode(mapID, x, y, nodeID)
    if nodeID then return GetTaxiNodeByID(nodeID) end
    local taxiNodes = GetTaxiNodes(mapID)
    if not taxiNodes then return nil end
    local closestNode ---@type NavigationTaxiNodeState?
    local closestDistanceSquared = TAXI_POSITION_TOLERANCE * TAXI_POSITION_TOLERANCE
    for _, taxiNode in ipairs(taxiNodes) do
        if type(taxiNode.x) == "number" and type(taxiNode.y) == "number" then
            local deltaX = taxiNode.x - x
            local deltaY = taxiNode.y - y
            local distanceSquared = deltaX * deltaX + deltaY * deltaY
            if distanceSquared <= closestDistanceSquared then
                closestNode = taxiNode
                closestDistanceSquared = distanceSquared
            end
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

local function ClearTaxiNodeKnowledge()
    taxiNodesByMap = {}
end

local function RefreshTaxiNodeKnowledge()
    ClearTaxiNodeKnowledge()
    Navigation:RecheckFailedPaths("taxi")
    local graph = Navigation:GetGraph()
    local preparedData = Navigation:GetPreparedData()
    if not activePathReference or not activeReport or not graph or not preparedData then return end
    local pathCost, failure = CostCalculator(graph, preparedData, activePathReference)
    if not pathCost then activeReport("failed", failure) end
end

MapPinEnhanced:RegisterEvent("TAXIMAP_OPENED", RefreshTaxiNodeKnowledge)
MapPinEnhanced:RegisterEvent("TAXI_NODE_STATUS_CHANGED", RefreshTaxiNodeKnowledge)
-- Clear observations before the eligibility bucket prepares a new snapshot.
-- A zone transition during a ride is not evidence that the active taxi failed.
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", ClearTaxiNodeKnowledge)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED", ClearTaxiNodeKnowledge)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_INDOORS", ClearTaxiNodeKnowledge)
MapPinEnhanced:RegisterEvent("ZONE_CHANGED_NEW_AREA", ClearTaxiNodeKnowledge)

Navigation:RegisterPathHandler("flighttaxi", Presentation, Dataprovider, CostCalculator,
    Activator, Deactivator)
