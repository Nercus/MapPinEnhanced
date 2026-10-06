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
---@field travelDurationEstimated boolean?

---@class NavigationTaxiNodeState
---@field nodeID number
---@field x number?
---@field y number?
---@field known boolean?
---@field name string?

local taxiNodesByMap = {} ---@type table<number, NavigationTaxiNodeState[]|false>
local taxiNodesByIDByMap = {} ---@type table<number, table<number, NavigationTaxiNodeState>>
local dirtyTaxiMaps = {} ---@type table<number, boolean>
local taxiKnowledgeChangeNumber = 0
local taxiPricesDirty = true
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
local hasGeometryPrices = false

---@param context NavigationPathPresentationContext?
---@return string icon, string method, string instruction
local function Presentation(context)
    local key = context and context.phase == "in-transit" and "Navigation Traveling By Flight" or
        "Navigation Take Flight"
    local destination = context and context.destinationName
    local instruction = destination and string.format(L[key .. " To"], destination) or L[key]
    return "FlightMaster", L["Navigation Method Flight Taxi"], instruction
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
        assert(MapPinEnhanced:IsReadablePositiveInteger(id),
            "Navigation flight taxi requires positive integer source IDs")
        assert(MapPinEnhanced:IsReadablePositiveInteger(path.fromTaxiNodeID) and
            MapPinEnhanced:IsReadablePositiveInteger(path.toTaxiNodeID),
            "Navigation flight taxi source IDs require node endpoints")
        local pair = path.fromTaxiNodeID .. ":" .. path.toTaxiNodeID
        if sourcePairs[id] and sourcePairs[id] ~= pair then
            error("Navigation flight taxi source ID has conflicting endpoints: " .. id)
        end
        sourcePairs[id] = pair
        ids[#ids + 1] = id
    end
    table.sort(ids)
    for index = 2, #ids do
        assert(ids[index] ~= ids[index - 1], "Navigation flight taxi has duplicate source IDs")
    end
    return {
        taxiPathIDs = ids,
        travelDurationEstimated = path.travelDurationEstimated,
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
    if cached ~= nil and not dirtyTaxiMaps[mapID] then return cached or nil end
    dirtyTaxiMaps[mapID] = nil
    if not C_TaxiMap or not C_TaxiMap.GetTaxiNodesForMap then
        if cached ~= false then taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1 end
        taxiNodesByMap[mapID] = false
        taxiNodesByIDByMap[mapID] = nil
        return nil
    end

    local taxiNodes = {} ---@type NavigationTaxiNodeState[]
    local nodesByID = {} ---@type table<number, NavigationTaxiNodeState>
    local observedNodes = C_TaxiMap.GetTaxiNodesForMap(mapID)
    if MapPinEnhanced:IsSecretValue(observedNodes) or type(observedNodes) ~= "table" then
        if cached ~= false then taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1 end
        taxiNodesByMap[mapID] = false
        taxiNodesByIDByMap[mapID] = nil
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
                    name = not MapPinEnhanced:IsSecretValue(node.name) and type(node.name) == "string" and node.name or
                        nil,
                }
                table.insert(taxiNodes, record)
                -- Preserve the first matching record, as the former array lookup did.
                if not nodesByID[node.nodeID] then nodesByID[node.nodeID] = record end
            end
        end
    end
    -- Preserve complete observations, including order for equal-distance fallback,
    -- missing nodes, unknown discovery, identity, coordinates and display names.
    local equal = type(cached) == "table" and #cached == #taxiNodes
    if equal then
        ---@cast cached NavigationTaxiNodeState[]
        for index, node in ipairs(taxiNodes) do
            local previous = cached[index]
            if previous.nodeID ~= node.nodeID or previous.known ~= node.known or
                previous.x ~= node.x or previous.y ~= node.y or previous.name ~= node.name then
                equal = false
                break
            end
        end
    end
    if equal then return cached end
    taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1
    taxiNodesByIDByMap[mapID] = nodesByID
    taxiNodesByMap[mapID] = taxiNodes
    return taxiNodes
end

---@param nodeID number
---@return NavigationTaxiNodeState?
local function GetTaxiNodeByID(nodeID)
    local mapID = taxiMapByNodeID[nodeID]
    if mapID and GetTaxiNodes(mapID) then
        local node = taxiNodesByIDByMap[mapID][nodeID]
        if node then return node end
    end
    -- Older clients use saved flight-master observations for discovery. A city
    -- map omitting the node must not discard that positive character knowledge.
    if not mapReportsDiscovery then
        local learnedTaxiNodes = GetLearnedTaxiNodes()
        if learnedTaxiNodes and learnedTaxiNodes[nodeID] == true then
            return { nodeID = nodeID, known = true }
        end
    end
    return nil
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
    hasGeometryPrices = false
    for reference = 1, graph.pathCount do
        if graph.pathTypes[reference] == "flighttaxi" then
            local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
            local duration = graph.pathDurations[reference]
            if type(duration) ~= "number" or duration <= 0 or duration >= math.huge or duration ~= duration then
                hasGeometryPrices = true
            end
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

local pricedGraph ---@type NavigationGraph?
local authoredPrices = {} ---@type table<integer, NavigationCalculatedPathCost>

---@param graph NavigationGraph
---@param reference integer
---@return NavigationCalculatedPathCost
local function PriceLeg(graph, reference)
    if pricedGraph ~= graph then
        pricedGraph = graph
        authoredPrices = {}
    end
    if authoredPrices[reference] then return authoredPrices[reference] end
    local data = graph.pathHandlerData[reference] ---@type NavigationFlightTaxiData
    local duration = graph.pathDurations[reference]
    local hasDuration = type(duration) == "number" and duration > 0 and duration < math.huge
    local estimated = not hasDuration or data.travelDurationEstimated == true
    local seconds = duration or 0
    if not hasDuration then
        local distance = Navigation:GetComparableDistance(data.fromMap, data.fromX, data.fromY,
            data.toMap, data.toX, data.toY)
        seconds = distance and math.max(1, distance / TAXI_ESTIMATED_SPEED) or TAXI_FALLBACK_SECONDS
    end
    -- Pair timings have no variant/context evidence. Through-flight overhead
    -- has not been measured, so even authored leg sums retain uncertainty.
    local uncertainty = math.max(30, seconds * 0.25)
    local cost = {
        expectedSeconds = seconds,
        uncertaintySeconds = uncertainty,
        comparisonSeconds = seconds + uncertainty,
        explanation = {
            kind = "flight-taxi",
            timingScope = not hasDuration and "endpoint-estimate" or
                estimated and "path-geometry-estimate" or "authored-pair",
            estimated = estimated,
            sourceVerified = #data.taxiPathIDs > 0,
            taxiPathIDs = data.taxiPathIDs,
            fromTaxiNodeID = data.fromTaxiNodeID,
            toTaxiNodeID = data.toTaxiNodeID
        },
    }
    -- Missing-duration geometry stays fresh; authored prices depend only on graph.
    if hasDuration then authoredPrices[reference] = cost end
    return cost
end

---@alias NavigationTaxiLegMemo table<number, table<number, NavigationTaxiLeg|string>>

---@param graph NavigationGraph
---@param prepared NavigationPreparedData
---@param from number
---@param to number
---@param checkpoint fun()
---@return NavigationTaxiLeg?, string?
local function PriceDirectedLeg(graph, prepared, from, to, checkpoint)
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
    return {
        fromTaxiNodeID = from,
        toTaxiNodeID = to,
        sourceReferences = usable,
        taxiPathIDs = ids,
        cost = cost
    }
end

---@param graph NavigationGraph
---@param prepared NavigationPreparedData
---@param nodes number[]
---@param checkpoint fun()
---@param legMemo NavigationTaxiLegMemo
---@return NavigationTaxiJourney? journey
---@return string? failure
function Navigation:PriceTaxiJourney(graph, prepared, nodes, checkpoint, legMemo)
    local origin, destination = nodes[1], nodes[#nodes]
    local fromPoint, toPoint = pointsByNode[origin], pointsByNode[destination]
    if not fromPoint or not toPoint then return nil, "taxi destination or origin has no graph point" end
    local legs = {} ---@type NavigationTaxiLeg[]
    local seconds = 0 ---@type number
    local uncertainty = 0 ---@type number
    for index = 1, #nodes - 1 do
        checkpoint()
        local from, to = nodes[index], nodes[index + 1]
        local outgoing = legMemo[from]
        if not outgoing then
            outgoing = {}
            legMemo[from] = outgoing
        end
        local leg = outgoing[to]
        if not leg then
            local failure
            leg, failure = PriceDirectedLeg(graph, prepared, from, to, checkpoint)
            if not leg then
                outgoing[to] = failure
                return nil, failure
            end
            outgoing[to] = leg
        end
        if type(leg) == "string" then return nil, leg end
        legs[#legs + 1] = leg
        local cost = leg.cost
        seconds = seconds + cost.expectedSeconds
        uncertainty = uncertainty + cost.uncertaintySeconds
    end
    ---@cast seconds number
    ---@cast uncertainty number
    local identity = "taxi:" .. table.concat(nodes, ":")
    return {
        identity = identity,
        origin = origin,
        destination = destination,
        fromPointIndex = fromPoint,
        toPointIndex = toPoint,
        legs = legs,
        observed = true,
        cost = {
            expectedSeconds = seconds,
            uncertaintySeconds = uncertainty,
            comparisonSeconds = seconds + uncertainty,
            explanation = {
                kind = "flight-taxi",
                identity = identity,
                observed = true,
                nodes = nodes,
                legs = legs,
                timingScope = "sum-of-pair-estimates"
            }
        }
    }
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
    return {
        identity = "taxi-estimate:" .. table.concat(nodes, ":"),
        origin = nodes[1],
        destination = nodes[2],
        fromPointIndex = graph.pathFromPointIndexes[reference],
        toPointIndex = graph.pathToPointIndexes[reference],
        observed = false,
        cost = cost,
        destinationName = cost.explanation.destinationName,
        legs = { {
            fromTaxiNodeID = nodes[1],
            toTaxiNodeID = nodes[2],
            sourceReferences = { reference },
            taxiPathIDs = data.taxiPathIDs,
            cost = cost
        } }
    }
end

-- Dirty intake cancels unsafe work immediately; unchanged complete observations
-- retain immutable prices. Fresh single-Path checks never publish this cache.
local preparedTaxiChangeNumber = -1
local preparedTaxiGraph ---@type NavigationGraph?
local preparedTaxiCosts ---@type table<integer, NavigationCalculatedPathCost>?
local preparedTaxiFailures ---@type table<integer, string>?

---@param graph NavigationGraph
---@param checkpoint fun()
---@return table<integer, NavigationCalculatedPathCost>, table<integer, string>
function Navigation:GetPreparedTaxiCosts(graph, checkpoint)
    if taxiPricesDirty or preparedTaxiGraph ~= graph or preparedTaxiChangeNumber ~= taxiKnowledgeChangeNumber then
        for mapID in pairs(taxiNodesByMap) do
            GetTaxiNodes(mapID)
            checkpoint()
        end
        if preparedTaxiGraph == graph and preparedTaxiChangeNumber == taxiKnowledgeChangeNumber and
            not hasGeometryPrices then
            taxiPricesDirty = false
            return assert(preparedTaxiCosts, "Navigation:GetPreparedTaxiCosts: missing costs"),
                assert(preparedTaxiFailures, "Navigation:GetPreparedTaxiCosts: missing failures")
        end
        local costs, failures = self:PrepareTaxiCosts(graph, nil, checkpoint)
        preparedTaxiGraph = graph
        preparedTaxiChangeNumber = taxiKnowledgeChangeNumber
        taxiPricesDirty = false
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
            local origin = data.fromTaxiNodeID
            if not origin then
                local from = FindTaxiNode(data.fromMap, data.fromX, data.fromY)
                origin = from and from.nodeID
            end
            local to = FindTaxiNode(data.toMap, data.toX, data.toY, data.toTaxiNodeID)
            if not origin then
                failures[reference] = "origin taxi node ID is unavailable"
            elseif not to or to.known ~= true then
                failures[reference] = to and to.known == false and
                    "destination taxi node is undiscovered" or "destination taxi knowledge is unknown"
            else
                local base = PriceLeg(graph, reference)
                local previous = preparedTaxiGraph == graph and preparedTaxiCosts and preparedTaxiCosts[reference]
                if previous and previous.expectedSeconds == base.expectedSeconds and
                    previous.uncertaintySeconds == base.uncertaintySeconds and
                    previous.explanation.nodes[1] == origin and previous.explanation.nodes[2] == to.nodeID and
                    previous.explanation.destinationName == to.name then
                    costs[reference] = previous
                else
                    -- Never decorate the cached base record or an older Route's cost.
                    local explanation = {} ---@type table<string, any>
                    for key, value in pairs(base.explanation) do explanation[key] = value end
                    explanation.observed = false
                    explanation.nodes = { origin, to.nodeID }
                    explanation.destinationName = to.name
                    costs[reference] = {
                        expectedSeconds = base.expectedSeconds,
                        uncertaintySeconds = base.uncertaintySeconds,
                        comparisonSeconds = base.comparisonSeconds,
                        explanation = explanation
                    }
                end
            end
        end
    end
    if not onlyReference and preparedTaxiGraph == graph then
        ---@generic T
        ---@param values table<integer, T>
        ---@param previous table<integer, T>?
        ---@return table<integer, T>
        local function ReuseEqual(values, previous)
            if not previous then return values end
            for key, value in pairs(values) do
                if checkpoint then checkpoint() end
                if previous[key] ~= value then return values end
            end
            for key in pairs(previous) do
                if checkpoint then checkpoint() end
                if values[key] == nil then return values end
            end
            return previous
        end
        costs = ReuseEqual(costs, preparedTaxiCosts)
        failures = ReuseEqual(failures, preparedTaxiFailures)
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
    -- Destination discovery gates inferred paths and observed journey legs. Only the
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
    local changed = false
    for _, nodeID in ipairs(nodeIDs) do
        if MapPinEnhanced:IsReadablePositiveInteger(nodeID) and learnedTaxiNodes[nodeID] ~= true then
            changed = true
            learnedTaxiNodes[nodeID] = true
        end
    end
    if not changed then return end
    taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1
    saved[characterKey] = learnedTaxiNodes
    MapPinEnhanced:SetVar("learnedTaxiNodes", saved)
    self:ClearTaxiNodeKnowledge()
end

function Navigation:ClearTaxiNodeKnowledge()
    for mapID in pairs(taxiNodesByMap) do dirtyTaxiMaps[mapID] = true end
    taxiPricesDirty = true
    self:InvalidatePreparedData("TAXIMAP_OPENED")
end

Navigation:RegisterPathHandler("flighttaxi", Presentation, Dataprovider, CostCalculator,
    function(context, report) Navigation:ActivateTaxiJourney(context, report) end,
    function() Navigation:DeactivateTaxiJourney() end)
