---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local TAXI_ESTIMATED_SPEED = 25
local TAXI_FALLBACK_SECONDS = 240
local TAXI_POSITION_TOLERANCE = 0.005

-- The 1.60 client returns false undiscovered flags even for unlearned nodes.
-- Only mainline's 11.0+ discovery contract can establish knowledge from maps.
local _, _, _, interfaceVersion = GetBuildInfo()
local mapReportsDiscovery = type(interfaceVersion) == "number" and interfaceVersion >= 110000

---@return table<number, boolean>?
local function GetLearnedTaxiNodes()
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return nil end
    local saved = MapPinEnhanced:GetVar("learnedTaxiNodes")
    local nodes = type(saved) == "table" and saved[characterKey] or nil
    return type(nodes) == "table" and nodes or nil
end

---@class NavigationFlightTaxiData
---@field fromMap number
---@field fromX number
---@field fromY number
---@field toMap number
---@field toX number
---@field toY number
---@field fromTaxiNodeID number?
---@field toTaxiNodeID number?
---@field taxiPathIDs integer[]

---@class NavigationTaxiNodeState
---@field nodeID number
---@field x number?
---@field y number?
---@field known boolean?
---@field name string?

local taxiNodesByMap = {} ---@type table<number, NavigationTaxiNodeState[]|false>
local taxiNodesByIDByMap = {} ---@type table<number, table<number, NavigationTaxiNodeState>>
local taxiMapByNodeID = {} ---@type table<number, number>
---@class NavigationTaxiLeg
---@field fromTaxiNodeID number
---@field toTaxiNodeID number
---@field sourceReferences integer[]
---@field taxiPathIDs integer[]
---@field cost NavigationCalculatedPathCost

---@class NavigationTaxiJourney
---@field identity string
---@field origin number
---@field destination number
---@field destinationName string?
---@field fromPointIndex integer
---@field toPointIndex integer
---@field legs NavigationTaxiLeg[]
---@field observed boolean
---@field cost NavigationCalculatedPathCost

local connections = {} ---@type table<number, table<number, integer[]>>
local sourcePairs = {} ---@type table<integer, string>
local pointsByNode = {} ---@type table<number, integer>

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
    local ids = {} ---@type integer[]
    for _, id in ipairs(path.taxiPathIDs or {}) do
        assert(MapPinEnhanced:IsReadablePositiveInteger(id), "Navigation flight taxi requires positive integer source IDs")
        assert(MapPinEnhanced:IsReadablePositiveInteger(path.fromTaxiNodeID) and
            MapPinEnhanced:IsReadablePositiveInteger(path.toTaxiNodeID),
            "Navigation flight taxi source IDs require node endpoints")
        local pair = path.fromTaxiNodeID .. ":" .. path.toTaxiNodeID
        assert(not sourcePairs[id] or sourcePairs[id] == pair,
            "Navigation flight taxi source ID has conflicting endpoints: " .. id)
        sourcePairs[id] = pair
        ids[#ids + 1] = id
    end
    table.sort(ids)
    for index = 2, #ids do
        assert(ids[index] ~= ids[index - 1], "Navigation flight taxi has duplicate source IDs")
    end
    return {
        taxiPathIDs = ids,
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
    local nodesByID = {} ---@type table<number, NavigationTaxiNodeState>
    local observedNodes = C_TaxiMap.GetTaxiNodesForMap(mapID)
    if MapPinEnhanced:IsSecretValue(observedNodes) or type(observedNodes) ~= "table" then
        taxiNodesByMap[mapID] = false
        return nil
    end
    local learnedTaxiNodes = not mapReportsDiscovery and GetLearnedTaxiNodes() or nil
    for _, node in ipairs(observedNodes) do
        if not MapPinEnhanced:IsSecretValue(node) and type(node) == "table" then
            local position = node.position
            local x ---@type number?
            local y ---@type number?
            if not MapPinEnhanced:IsSecretValue(position) and position and position.GetXY then
                x, y = position:GetXY()
                if MapPinEnhanced:IsSecretValue(x) or MapPinEnhanced:IsSecretValue(y) then x, y = nil, nil end
            end
            if MapPinEnhanced:IsReadablePositiveInteger(node.nodeID) then
                local known = learnedTaxiNodes and learnedTaxiNodes[node.nodeID] == true or nil ---@type boolean?
                if mapReportsDiscovery then
                    known = nil
                    if not MapPinEnhanced:IsSecretValue(node.isUndiscovered) and
                        type(node.isUndiscovered) == "boolean" then
                        known = not node.isUndiscovered
                    end
                end
                local record = {
                    nodeID = node.nodeID,
                    x = x,
                    y = y,
                    known = known,
                    name = not MapPinEnhanced:IsSecretValue(node.name) and type(node.name) == "string" and node.name or nil,
                }
                table.insert(taxiNodes, record)
                -- Preserve the first matching record, as the former array lookup did.
                if not nodesByID[node.nodeID] then nodesByID[node.nodeID] = record end
            end
        end
    end
    taxiNodesByIDByMap[mapID] = nodesByID
    taxiNodesByMap[mapID] = taxiNodes
    return taxiNodes
end

---@param nodeID number
---@return NavigationTaxiNodeState?
local function GetTaxiNodeByID(nodeID)
    local mapID = taxiMapByNodeID[nodeID]
    if not mapID then return nil end
    if not GetTaxiNodes(mapID) then return nil end
    return taxiNodesByIDByMap[mapID][nodeID]
end

---@param nodeID number
---@return boolean? known
function Navigation:IsTaxiNodeKnown(nodeID)
    if not mapReportsDiscovery then
        local learnedTaxiNodes = GetLearnedTaxiNodes()
        return learnedTaxiNodes and learnedTaxiNodes[nodeID] == true or nil
    end
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

-- Connection indexes refer only to the immutable authored graph. A source ID
-- identifies a variant; its numerical order never selects a timing variant.
---@param graph NavigationGraph
function Navigation:IndexTaxiConnections(graph)
    connections = {}
    pointsByNode = {}
    for reference = 1, graph.pathCount do
        if graph.pathTypes[reference] == "flighttaxi" then
            local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
            local origin, destination = data.fromTaxiNodeID, data.toTaxiNodeID
            if origin and destination then
                connections[origin] = connections[origin] or {}
                local pair = connections[origin][destination] or {}
                connections[origin][destination] = pair
                pair[#pair + 1] = reference
                pointsByNode[origin] = graph.pathFromPointIndexes[reference]
                pointsByNode[destination] = graph.pathToPointIndexes[reference]
            end
        end
    end
end

---@param graph NavigationGraph
---@param reference integer
---@return NavigationCalculatedPathCost
local function PriceLeg(graph, reference)
    local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
    local duration = graph.pathDurations[reference]
    local estimated = type(duration) ~= "number" or duration <= 0 or duration == math.huge
    local seconds = duration or 0
    if estimated then
        local distance = Navigation:GetComparableDistance(data.fromMap, data.fromX, data.fromY,
            data.toMap, data.toX, data.toY)
        seconds = distance and math.max(1, distance / TAXI_ESTIMATED_SPEED) or TAXI_FALLBACK_SECONDS
    end
    -- Pair timings have no variant/context evidence. Through-flight overhead
    -- has not been measured, so even authored leg sums retain uncertainty.
    local uncertainty = math.max(30, seconds * 0.25)
    return {
        expectedSeconds = seconds, uncertaintySeconds = uncertainty,
        comparisonSeconds = seconds + uncertainty,
        explanation = { kind = "flight-taxi", timingScope = estimated and "endpoint-estimate" or "authored-pair",
            estimated = estimated, sourceVerified = #data.taxiPathIDs > 0,
            taxiPathIDs = data.taxiPathIDs, fromTaxiNodeID = data.fromTaxiNodeID,
            toTaxiNodeID = data.toTaxiNodeID },
    }
end

---@param graph NavigationGraph
---@param prepared NavigationPreparedData
---@param nodes number[]
---@param checkpoint fun()
---@return NavigationTaxiJourney? journey
---@return string? failure
function Navigation:PriceTaxiJourney(graph, prepared, nodes, checkpoint)
    local origin, destination = nodes[1], nodes[#nodes]
    local fromPoint, toPoint = pointsByNode[origin], pointsByNode[destination]
    if not fromPoint or not toPoint then return nil, "taxi destination or origin has no graph point" end
    local legs = {} ---@type NavigationTaxiLeg[]
    local seconds = 0 ---@type number
    local uncertainty = 0 ---@type number
    for index = 1, #nodes - 1 do
        checkpoint()
        local from, to = nodes[index], nodes[index + 1]
        local references = connections[from] and connections[from][to]
        if not references then return nil, "unmapped taxi leg " .. from .. ":" .. to end
        local ids = {} ---@type integer[]
        local usable = {} ---@type integer[]
        local cost ---@type NavigationCalculatedPathCost?
        local seen = {} ---@type table<integer, boolean>
        for _, reference in ipairs(references) do
            checkpoint()
            local candidate = prepared.taxiCosts[reference]
            if candidate and prepared.requirementStateByPath[reference] == "satisfied" then
                local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
                if #data.taxiPathIDs > 0 then
                    usable[#usable + 1] = reference
                    for _, id in ipairs(data.taxiPathIDs) do
                        assert(sourcePairs[id] == from .. ":" .. to,
                            "Navigation:PriceTaxiJourney source ID does not match its directed leg")
                        if not seen[id] then ids[#ids + 1] = id end
                        seen[id] = true
                    end
                    -- Conflicting pair estimates cannot resolve source variants.
                    if not cost or candidate.comparisonSeconds > cost.comparisonSeconds then cost = candidate end
                end
            end
        end
        if not cost then return nil, "taxi leg has no eligible source connection " .. from .. ":" .. to end
        table.sort(ids)
        legs[#legs + 1] = { fromTaxiNodeID = from, toTaxiNodeID = to,
            sourceReferences = usable, taxiPathIDs = ids, cost = cost }
        seconds = seconds + cost.expectedSeconds
        uncertainty = uncertainty + cost.uncertaintySeconds
    end
    ---@cast seconds number
    ---@cast uncertainty number
    local identity = "taxi:" .. table.concat(nodes, ":")
    return { identity = identity, origin = origin, destination = destination,
        fromPointIndex = fromPoint, toPointIndex = toPoint, legs = legs, observed = true,
        cost = { expectedSeconds = seconds, uncertaintySeconds = uncertainty,
            comparisonSeconds = seconds + uncertainty,
            explanation = { kind = "flight-taxi", identity = identity, observed = true,
                nodes = nodes, legs = legs, timingScope = "sum-of-pair-estimates" } } }
end

---@param journey NavigationTaxiJourney
---@param prepared NavigationPreparedData
---@return boolean
function Navigation:IsTaxiJourneyEligible(journey, prepared)
    for _, leg in ipairs(journey.legs) do
        for _, reference in ipairs(leg.sourceReferences) do
            if not prepared.taxiCosts[reference] or prepared.requirementStateByPath[reference] ~= "satisfied" then
                return false
            end
        end
    end
    return true
end

---@param graph NavigationGraph
---@param reference integer
---@param cost NavigationCalculatedPathCost
---@return NavigationTaxiJourney
function Navigation:GetInferredTaxiJourney(graph, reference, cost)
    local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
    local nodes = cost.explanation.nodes ---@type number[]
    return { identity = "taxi-estimate:" .. table.concat(nodes, ":"), origin = nodes[1], destination = nodes[2],
        fromPointIndex = graph.pathFromPointIndexes[reference], toPointIndex = graph.pathToPointIndexes[reference],
        observed = false, cost = cost, destinationName = cost.explanation.destinationName,
        legs = { { fromTaxiNodeID = nodes[1], toTaxiNodeID = nodes[2], sourceReferences = { reference },
            taxiPathIDs = data.taxiPathIDs, cost = cost } } }
end

-- Shared cost tables are immutable. A knowledge invalidation replaces the next
-- snapshot; fresh single-Path checks never replace this session-owned cache.
local taxiKnowledgeChangeNumber = 0
local preparedTaxiChangeNumber = -1
local preparedTaxiGraph ---@type NavigationGraph?
local preparedTaxiCosts ---@type table<integer, NavigationCalculatedPathCost>?
local preparedTaxiFailures ---@type table<integer, string>?

---@param graph NavigationGraph
---@param checkpoint fun()
---@return table<integer, NavigationCalculatedPathCost>, table<integer, string>
function Navigation:GetPreparedTaxiCosts(graph, checkpoint)
    if preparedTaxiGraph ~= graph or preparedTaxiChangeNumber ~= taxiKnowledgeChangeNumber then
        local changeNumber = taxiKnowledgeChangeNumber
        local costs, failures = self:PrepareTaxiCosts(graph, nil, checkpoint)
        preparedTaxiGraph = graph
        preparedTaxiChangeNumber = changeNumber
        preparedTaxiCosts, preparedTaxiFailures = costs, failures
    end
    return assert(preparedTaxiCosts, "Navigation:GetPreparedTaxiCosts: missing costs"),
        assert(preparedTaxiFailures, "Navigation:GetPreparedTaxiCosts: missing failures")
end

---@param graph NavigationGraph
---@param onlyReference integer?
---@param checkpoint? fun()
---@return table<integer, NavigationCalculatedPathCost>, table<integer, string>
function Navigation:PrepareTaxiCosts(graph, onlyReference, checkpoint)
    local costs = {} ---@type table<integer, NavigationCalculatedPathCost>
    local failures = {} ---@type table<integer, string>
    for reference = onlyReference or 1, onlyReference or graph.pathCount do
        if checkpoint then checkpoint() end
        if graph.pathTypes[reference] == "flighttaxi" then
            local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
            local from = FindTaxiNode(data.fromMap, data.fromX, data.fromY, data.fromTaxiNodeID)
            local to = FindTaxiNode(data.toMap, data.toX, data.toY, data.toTaxiNodeID)
            if not from or from.known ~= true then
                failures[reference] = from and from.known == false and
                    "origin taxi node is undiscovered" or "origin taxi knowledge is unknown"
            elseif not to or to.known ~= true then
                failures[reference] = to and to.known == false and
                    "destination taxi node is undiscovered" or "destination taxi knowledge is unknown"
            else
                costs[reference] = PriceLeg(graph, reference)
                costs[reference].explanation.observed = false
                costs[reference].explanation.nodes = { from.nodeID, to.nodeID }
                costs[reference].explanation.destinationName = to.name
            end
        end
    end
    return costs, failures
end

---@param _graph NavigationGraph
---@param prepared NavigationPreparedData
---@param reference integer
---@return NavigationCalculatedPathCost?
---@return string?
local function CostCalculator(_graph, prepared, reference)
    local cost = prepared.taxiCosts[reference]
    -- Discovery gates both inferred paths and observed journey legs. Only the
    -- static candidate is suppressed when a current-master itinerary replaces it.
    if cost and prepared.taxiObservation and
        prepared.taxiObservation.origin == cost.explanation.nodes[1] then
        return nil, "current-master taxi requires observed journey"
    end
    return cost, prepared.taxiFailures[reference]
end

---@param nodeIDs number[]
function Navigation:RecordLearnedTaxiNodes(nodeIDs)
    if mapReportsDiscovery then return end
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return end
    local saved = MapPinEnhanced:GetVar("learnedTaxiNodes")
    if type(saved) ~= "table" then saved = {} end
    ---@cast saved table<string, table<number, boolean>>
    local learnedTaxiNodes = GetLearnedTaxiNodes() or {}
    -- Persist positive character knowledge only. Missing/unreachable nodes at
    -- another master must not erase it; reachability and itineraries stay live.
    for _, nodeID in ipairs(nodeIDs) do
        if MapPinEnhanced:IsReadablePositiveInteger(nodeID) then
            learnedTaxiNodes[nodeID] = true
        end
    end
    saved[characterKey] = learnedTaxiNodes
    MapPinEnhanced:SetVar("learnedTaxiNodes", saved)
    self:ClearTaxiNodeKnowledge()
end

function Navigation:ClearTaxiNodeKnowledge()
    taxiNodesByMap = {}
    taxiNodesByIDByMap = {}
    taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1
    self:InvalidatePreparedData()
end

Navigation:RegisterPathHandler("flighttaxi", Presentation, Dataprovider, CostCalculator,
    function(context, report) Navigation:ActivateTaxiJourney(context, report) end,
    function() Navigation:DeactivateTaxiJourney() end)
