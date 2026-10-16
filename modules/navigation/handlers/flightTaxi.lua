---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local TAXI_ESTIMATED_SPEED = 25
local TAXI_FALLBACK_SECONDS = 240
local TAXI_POSITION_TOLERANCE = 0.005

-- Positive discoveries belong to this character and are learned only at a master.
local learnedTaxiNodes ---@type table<number, boolean>?
---@return table<number, boolean>?
local function GetLearnedTaxiNodes()
    if learnedTaxiNodes then return learnedTaxiNodes end
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return nil end
    local saved = MapPinEnhanced:GetVar("learnedTaxiNodes")
    local nodes = type(saved) == "table" and saved[characterKey] or nil
    learnedTaxiNodes = {}
    if type(nodes) == "table" then
        ---@cast nodes table<any, any>
        for nodeID, known in pairs(nodes) do
            if MapPinEnhanced:IsReadablePositiveInteger(nodeID) and known == true then
                learnedTaxiNodes[nodeID] = true
            end
        end
    end
    return learnedTaxiNodes
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
---@field name string?

local taxiNodesByMap = {} ---@type table<number, NavigationTaxiNodeState[]>
local taxiNodesByIDByMap = {} ---@type table<number, table<number, NavigationTaxiNodeState>>
local taxiKnowledgeChangeNumber = 0
local taxiMapByNodeID = {} ---@type table<number, number>
local taxiMapIDs = {} ---@type table<number, boolean>
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
    taxiMapIDs[path.fromMap], taxiMapIDs[path.toMap] = true, true
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

-- Strip native vectors and accept only plain, readable metadata for persistence.
---@param nodes table<any, any>
---@param native boolean
---@param checkpoint? fun()
---@return NavigationTaxiNodeState[]
local function CopyTaxiNodes(nodes, native, checkpoint)
    local result = {} ---@type NavigationTaxiNodeState[]
    for _, node in ipairs(nodes) do
        if checkpoint then checkpoint() end
        if MapPinEnhanced:IsReadableTable(node) and MapPinEnhanced:IsReadablePositiveInteger(node.nodeID) then
            ---@cast node { nodeID: number, position: Vector2DMixin?, x: number?, y: number?, name: string? }
            local x ---@type number?
            local y ---@type number?
            if native then
                local position = node.position
                if not MapPinEnhanced:IsSecretValue(position) and position and position.GetXY then
                    x, y = position:GetXY()
                end
            else
                x, y = node.x, node.y
            end
            if not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then x, y = nil, nil end
            result[#result + 1] = {
                nodeID = node.nodeID,
                x = x,
                y = y,
                name = not MapPinEnhanced:IsSecretValue(node.name) and type(node.name) == "string" and node.name or nil,
            }
        end
    end
    return result
end

---@param nodes NavigationTaxiNodeState[]
---@param checkpoint? fun()
---@return table<number, NavigationTaxiNodeState>
local function IndexTaxiNodes(nodes, checkpoint)
    local byID = {} ---@type table<number, NavigationTaxiNodeState>
    for _, node in ipairs(nodes) do
        if checkpoint then checkpoint() end
        if not byID[node.nodeID] then byID[node.nodeID] = node end
    end
    return byID
end

---@param mapID number
---@param checkpoint? fun()
---@return NavigationTaxiNodeState[]?
local function GetTaxiNodes(mapID, checkpoint)
    if taxiNodesByMap[mapID] then return taxiNodesByMap[mapID] end
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return nil end
    local saved = MapPinEnhanced:GetVar("taxiNodeMaps")
    local maps = type(saved) == "table" and saved[characterKey]
    local nodes = type(maps) == "table" and maps[mapID]
    local copy = type(nodes) == "table" and CopyTaxiNodes(nodes, false, checkpoint) or {}
    local byID = IndexTaxiNodes(copy, checkpoint)
    taxiNodesByMap[mapID], taxiNodesByIDByMap[mapID] = copy, byID
    return copy
end

---@param previous NavigationTaxiNodeState[]?
---@param nodes NavigationTaxiNodeState[]
---@param checkpoint fun()
---@return boolean
local function SameTaxiNodes(previous, nodes, checkpoint)
    if not previous or #previous ~= #nodes then return false end
    for index, node in ipairs(nodes) do
        checkpoint()
        local old = previous[index]
        if old.nodeID ~= node.nodeID or old.x ~= node.x or old.y ~= node.y or old.name ~= node.name then
            return false
        end
    end
    return true
end

---@param mapID number
---@return MapTaxiNodeInfo[]?
local function ReadTaxiNodeMap(mapID)
    return C_TaxiMap.GetTaxiNodesForMap(mapID)
end

--@debug@
ReadTaxiNodeMap = MapPinEnhanced.profiler:WrapScope("Navigation.TaxiNodeMaps.NativeQuery", ReadTaxiNodeMap)
--@end-debug@

-- The interaction owner retains cancellation. Staging may yield, publication may
-- not: readers keep the previous metadata until every queried map is processed.
---@param onComplete fun(changed: boolean)
---@return fun()? cancel
function Navigation:RefreshTaxiNodeMaps(onComplete)
    if not C_TaxiMap or not C_TaxiMap.GetTaxiNodesForMap then return nil end
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return nil end
    local cancelled = false
    local updates = {} ---@type table<number, NavigationTaxiNodeState[]>
    local indexes = {} ---@type table<number, table<number, NavigationTaxiNodeState>>
    local savedMaps = {} ---@type table<number, NavigationTaxiNodeState[]>
    local cancel = MapPinEnhanced:BatchExecution({ function()
        --@debug@
        MapPinEnhanced.profiler:SetWorkerScope("Navigation.TaxiNodeMapRefreshSlice")
        --@end-debug@
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(2)
        for mapID in pairs(taxiMapIDs) do
            checkpoint()
            if cancelled then return false end
            local previous = GetTaxiNodes(mapID, checkpoint)
            if cancelled then return false end
            local observed = ReadTaxiNodeMap(mapID)
            checkpoint()
            if MapPinEnhanced:IsReadableTable(observed) then
                local nodes = CopyTaxiNodes(observed, true, checkpoint)
                if #nodes > 0 and not SameTaxiNodes(previous, nodes, checkpoint) then
                    updates[mapID] = nodes
                    indexes[mapID] = IndexTaxiNodes(nodes, checkpoint)
                end
            end
        end
        if not next(updates) then return end
        -- Preserve maps outside the authored graph without mutating the saved
        -- table during yields; discoveries use their separate immediate save.
        local saved = MapPinEnhanced:GetVar("taxiNodeMaps")
        local maps = type(saved) == "table" and saved[characterKey] or nil
        if type(maps) == "table" then
            ---@cast maps table<number, NavigationTaxiNodeState[]>
            for mapID, nodes in pairs(maps) do
                savedMaps[mapID] = nodes
                checkpoint()
            end
        end
        for mapID, nodes in pairs(updates) do
            savedMaps[mapID] = nodes
            checkpoint()
        end
    end }, nil, function(status)
        if cancelled or status ~= "complete" then return end
        local changed = next(updates) ~= nil
        if changed then
            -- All per-node copying/indexing is finished. Only map-level reference
            -- swaps remain in this synchronous publication, followed by one save.
            for mapID, nodes in pairs(updates) do
                taxiNodesByMap[mapID], taxiNodesByIDByMap[mapID] = nodes, indexes[mapID]
            end
            local saved = MapPinEnhanced:GetVar("taxiNodeMaps")
            if type(saved) ~= "table" then saved = {} end
            ---@cast saved table<string, table<number, NavigationTaxiNodeState[]>>
            saved[characterKey] = savedMaps
            MapPinEnhanced:SetVar("taxiNodeMaps", saved)
            taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1
        end
        onComplete(changed)
    end)
    return function()
        cancelled = true
        cancel()
    end
end

---@param nodeID number
---@return NavigationTaxiNodeState?
local function GetTaxiNodeByID(nodeID)
    local mapID = taxiMapByNodeID[nodeID]
    if mapID and GetTaxiNodes(mapID) then
        local node = taxiNodesByIDByMap[mapID][nodeID]
        if node then return node end
    end
    -- Authored identity plus positive saved knowledge needs no live map record.
    return { nodeID = nodeID }
end

---@param nodeID number
---@return boolean? known
function Navigation:IsTaxiNodeKnown(nodeID)
    local learned = GetLearnedTaxiNodes()
    return learned and learned[nodeID] == true or nil
end

---@return boolean
function Navigation:HasTaxiNodeKnowledge()
    local learned = GetLearnedTaxiNodes()
    return learned ~= nil and next(learned) ~= nil
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

local pricedGraph ---@type NavigationGraph?
local pricedSpeedMultiplier ---@type number?
local authoredPrices = {} ---@type table<integer, NavigationCalculatedPathCost>

---@param graph NavigationGraph
---@param reference integer
---@param speedMultiplier number
---@return NavigationCalculatedPathCost
local function PriceLeg(graph, reference, speedMultiplier)
    if pricedGraph ~= graph or pricedSpeedMultiplier ~= speedMultiplier then
        pricedGraph = graph
        pricedSpeedMultiplier = speedMultiplier
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
    -- Frequent Flier raises speed by 20%, so duration is divided by 1.2.
    seconds = seconds / speedMultiplier
    -- Only estimated durations need a margin; authored timings compare as stored.
    local uncertainty = estimated and math.max(30, seconds * 0.25) or 0
    local cost = {
        expectedSeconds = seconds,
        uncertaintySeconds = uncertainty,
        comparisonSeconds = seconds + uncertainty,
        explanation = {
            kind = "flight-taxi",
            speedMultiplier = speedMultiplier,
            timingScope = not hasDuration and "endpoint-estimate" or
                estimated and "path-geometry-estimate" or "authored-pair",
            estimated = estimated,
            sourceVerified = #data.taxiPathIDs > 0,
            taxiPathIDs = data.taxiPathIDs,
            fromTaxiNodeID = data.fromTaxiNodeID,
            toTaxiNodeID = data.toTaxiNodeID
        },
    }
    -- Missing-duration geometry stays fresh; authored prices also depend on the perk.
    if hasDuration then authoredPrices[reference] = cost end
    return cost
end

-- A booked itinerary is live evidence of availability. Estimate its actual legs
-- without depending on route options or triggering a navigation calculation.
---@param nodes number[]?
---@return number?
function Navigation:GetBookedFlightDuration(nodes)
    local graph = self:GetGraph()
    if not graph or not nodes or #nodes < 2 then return nil end
    local speedMultiplier = self:IsLegacyTraitKnown(110300) and 1.2 or 1
    local seconds = 0 ---@type number
    for index = 1, #nodes - 1 do
        local references = connections[nodes[index]] and connections[nodes[index]][nodes[index + 1]]
        if not references then return nil end
        local longest = 0 ---@type number
        for _, reference in ipairs(references) do
            ---@type number
            longest = math.max(longest, PriceLeg(graph, reference, speedMultiplier).expectedSeconds)
        end
        ---@cast longest number
        if longest <= 0 then return nil end
        seconds = seconds + longest
    end
    ---@cast seconds number
    return seconds
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

-- Selected remote legs describe one intended ride. Keep their exact source
-- references and estimates until the departure master supplies a real preview.
---@param route NavigationRoute
---@param observedJourneys table<integer, NavigationTaxiJourney>
---@param checkpoint fun()
function Navigation:CombineRouteTaxiJourneys(route, observedJourneys, checkpoint)
    local graph = route.graph
    local nextReference = 0 ---@type integer
    for reference in pairs(route.taxiJourneys) do
        if reference < nextReference then nextReference = reference end
    end
    local index = 1
    while index < #route.pathReferences do
        checkpoint()
        local firstReference, secondReference = route.pathReferences[index], route.pathReferences[index + 1]
        local first, second = route.taxiJourneys[firstReference], route.taxiJourneys[secondReference]
        local combined ---@type NavigationTaxiJourney?
        if first and second and first.destination == second.origin and
            first.toPointIndex == second.fromPointIndex then
            if not first.observed and not second.observed then
                local legs = {} ---@type NavigationTaxiLeg[]
                local nodes = { first.origin }
                for _, journey in ipairs({ first, second }) do
                    for _, leg in ipairs(journey.legs) do
                        legs[#legs + 1] = leg
                        nodes[#nodes + 1] = leg.toTaxiNodeID
                        checkpoint()
                    end
                end
                local seconds = first.cost.expectedSeconds + second.cost.expectedSeconds
                local uncertainty = first.cost.uncertaintySeconds + second.cost.uncertaintySeconds
                combined = {
                    identity = "taxi-estimate:" .. table.concat(nodes, ":"),
                    origin = first.origin,
                    destination = second.destination,
                    fromPointIndex = first.fromPointIndex,
                    toPointIndex = second.toPointIndex,
                    destinationName = second.destinationName,
                    legs = legs,
                    observed = false,
                    cost = {
                        expectedSeconds = seconds,
                        uncertaintySeconds = uncertainty,
                        comparisonSeconds = seconds + uncertainty,
                        explanation = {
                            kind = "flight-taxi",
                            observed = false,
                            nodes = nodes,
                            legs = legs,
                            timingScope = "sum-of-pair-estimates"
                        }
                    }
                }
            else
                -- Never invent a through booking from two separate previews.
                for _, journey in pairs(observedJourneys) do
                    checkpoint()
                    if journey.origin == first.origin and journey.destination == second.destination then
                        combined = journey
                        break
                    end
                end
            end
        end
        if combined then
            nextReference = nextReference - 1
            local reference = nextReference
            for _, oldReference in ipairs({ firstReference, secondReference }) do
                route.taxiJourneys[oldReference] = nil
                if oldReference < 0 then
                    graph.pathTypes[oldReference] = nil
                    graph.pathFromPointIndexes[oldReference] = nil
                    graph.pathToPointIndexes[oldReference] = nil
                    graph.pathHandlerData[oldReference] = nil
                end
            end
            route.taxiJourneys[reference] = combined
            route.comparisonSeconds = route.comparisonSeconds - first.cost.comparisonSeconds -
                second.cost.comparisonSeconds + combined.cost.comparisonSeconds
            route.pathReferences[index] = reference
            route.pathCosts[index] = combined.cost
            table.remove(route.pathReferences, index + 1)
            table.remove(route.pathCosts, index + 1)
            graph.pathTypes[reference] = "flighttaxi"
            graph.pathFromPointIndexes[reference] = combined.fromPointIndex
            graph.pathToPointIndexes[reference] = combined.toPointIndex
            local from, to = combined.fromPointIndex, combined.toPointIndex
            graph.pathHandlerData[reference] = {
                fromMap = graph.pointMapIDs[from],
                fromX = graph.pointXs[from],
                fromY = graph.pointYs[from],
                toMap = graph.pointMapIDs[to],
                toX = graph.pointXs[to],
                toY = graph.pointYs[to],
                fromTaxiNodeID = combined.origin,
                toTaxiNodeID = combined.destination,
                taxiPathIDs = {}
            }
        else
            index = index + 1
        end
    end
end

---@param journey NavigationTaxiJourney
---@param prepared NavigationPreparedData
---@param checkpoint fun()
---@return NavigationTaxiJourney?
function Navigation:RefreshTaxiJourney(journey, prepared, checkpoint)
    if not self:IsTaxiJourneyEligible(journey, prepared) then return nil end
    local observation = self:GetTaxiObservation()
    if journey.observed then
        local nodes = observation and observation.itineraries[journey.destination]
        if not nodes then return nil end
        local fresh = self:PriceTaxiJourney(self:GetGraph(), prepared, nodes, checkpoint, {})
        if not fresh or fresh.identity ~= journey.identity then return nil end
        fresh.destinationName = journey.destinationName
        return fresh
    end
    -- Current-master evidence must replace the estimate before boarding.
    if observation and observation.origin == journey.origin then return nil end
    local fresh = CopyTable(journey) ---@type NavigationTaxiJourney
    local seconds, uncertainty = 0, 0
    for _, leg in ipairs(fresh.legs) do
        checkpoint()
        local cost = self:GetFreshPathCost(leg.sourceReferences[1])
        if not cost then return nil end
        leg.cost = cost
        seconds = seconds + cost.expectedSeconds
        uncertainty = uncertainty + cost.uncertaintySeconds
    end
    fresh.cost.expectedSeconds = seconds
    fresh.cost.uncertaintySeconds = uncertainty
    fresh.cost.comparisonSeconds = seconds + uncertainty
    fresh.cost.explanation.legs = fresh.legs
    return fresh
end

-- Only flight-master observations change discovery/metadata. Route eligibility
-- still refreshes independently; unchanged inputs retain immutable taxi prices.
local preparedTaxiChangeNumber = -1
local preparedTaxiSpeedMultiplier ---@type number?
local preparedTaxiGraph ---@type NavigationGraph?
local preparedTaxiCosts ---@type table<integer, NavigationCalculatedPathCost>?
local preparedTaxiFailures ---@type table<integer, string>?

---@param graph NavigationGraph
---@param checkpoint fun()
---@return table<integer, NavigationCalculatedPathCost>, table<integer, string>
function Navigation:GetPreparedTaxiCosts(graph, checkpoint)
    local speedMultiplier = self:IsLegacyTraitKnown(110300) and 1.2 or 1
    if preparedTaxiGraph ~= graph or preparedTaxiChangeNumber ~= taxiKnowledgeChangeNumber or
        preparedTaxiSpeedMultiplier ~= speedMultiplier then
        local costs, failures = self:PrepareTaxiCosts(graph, nil, checkpoint)
        preparedTaxiGraph = graph
        preparedTaxiChangeNumber = taxiKnowledgeChangeNumber
        preparedTaxiSpeedMultiplier = speedMultiplier
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
    local speedMultiplier = self:IsLegacyTraitKnown(110300) and 1.2 or 1
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
            elseif not to or self:IsTaxiNodeKnown(to.nodeID) ~= true then
                failures[reference] = "destination taxi knowledge is unknown"
            else
                local base = PriceLeg(graph, reference, speedMultiplier)
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
    local characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return end
    local saved = MapPinEnhanced:GetVar("learnedTaxiNodes")
    if type(saved) ~= "table" then saved = {} end
    ---@cast saved table<string, table<number, boolean>>
    local learned = GetLearnedTaxiNodes()
    if not learned then return end
    -- Persist positive character knowledge only. Missing/unreachable nodes at
    -- another master must not erase it; reachability and itineraries stay live.
    local changed = false
    for _, nodeID in ipairs(nodeIDs) do
        if MapPinEnhanced:IsReadablePositiveInteger(nodeID) and learned[nodeID] ~= true then
            changed = true
            learned[nodeID] = true
        end
    end
    if not changed then return end
    taxiKnowledgeChangeNumber = taxiKnowledgeChangeNumber + 1
    saved[characterKey] = learned
    MapPinEnhanced:SetVar("learnedTaxiNodes", saved)
end

Navigation:RegisterPathHandler("flighttaxi", Presentation, Dataprovider, CostCalculator,
    function(context, report) Navigation:ActivateTaxiJourney(context, report) end,
    function() Navigation:DeactivateTaxiJourney() end)
