---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Route costs
---@class NavigationMountInfo
---@field fly boolean
---@field ground boolean

---@class Navigation
---@field mountData table<number, NavigationMountInfo>
---@field defaultMountInfo NavigationMountInfo

---@class NavigationMovementCapabilities
---@field groundSpeed number
---@field steadyFlightSpeed number
---@field skyridingSpeed number
---@field canFly boolean
---@field canSkyriding boolean
---@field activeFlightMode "steady"|"skyriding"|nil

local MOVEMENT_SPEEDS = {
    walking = 7,
    ground = 14,
    fastGround = 21,
    steadyFlight = 29,
    fastSteadyFlight = 35,
    skyriding = 50,
}

local function KnowsSpell(spellID)
    if IsPlayerSpell then return IsPlayerSpell(spellID) end
    if IsSpellKnown then return IsSpellKnown(spellID) end
    return false
end

---@return NavigationMovementCapabilities
function Navigation:GetMovementCapabilities()
    local groundSpeed = MOVEMENT_SPEEDS.walking
    if KnowsSpell(33388) then groundSpeed = MOVEMENT_SPEEDS.ground end
    if KnowsSpell(33391) then groundSpeed = MOVEMENT_SPEEDS.fastGround end

    local hasSteadyFlight = KnowsSpell(34090)
    local steadyFlightSpeed = groundSpeed
    if hasSteadyFlight then steadyFlightSpeed = MOVEMENT_SPEEDS.steadyFlight end
    if KnowsSpell(34091) then steadyFlightSpeed = MOVEMENT_SPEEDS.fastSteadyFlight end

    local canSkyriding = C_MountJournal and C_MountJournal.IsDragonridingUnlocked and
        C_MountJournal.IsDragonridingUnlocked() or false
    local currentAreaFlyable = IsFlyableArea and IsFlyableArea() or false
    local currentAreaSkyriding = IsAdvancedFlyableArea and IsAdvancedFlyableArea() or false
    ---@type "steady"|"skyriding"|nil
    local activeFlightMode
    if currentAreaFlyable and currentAreaSkyriding and canSkyriding then
        activeFlightMode = "skyriding"
    elseif currentAreaFlyable and hasSteadyFlight then
        activeFlightMode = "steady"
    end

    return {
        groundSpeed = groundSpeed,
        steadyFlightSpeed = steadyFlightSpeed,
        skyridingSpeed = canSkyriding and MOVEMENT_SPEEDS.skyriding or steadyFlightSpeed,
        canFly = hasSteadyFlight or canSkyriding,
        canSkyriding = canSkyriding,
        activeFlightMode = activeFlightMode,
    }
end

---@class NavigationCalculatedPathCost
---@field expectedSeconds number
---@field uncertaintySeconds number
---@field comparisonSeconds number
---@field explanation table<string, any>

---@param mapID1 number
---@param x1 number
---@param y1 number
---@param mapID2 number
---@param x2 number
---@param y2 number
---@return number?
function Navigation:GetComparableDistance(mapID1, x1, y1, mapID2, x2, y2)
    local hbd = MapPinEnhanced.HBD
    if not hbd then return nil end
    local worldX1, worldY1, instance1 = hbd:GetWorldCoordinatesFromZone(x1, y1, mapID1)
    local worldX2, worldY2, instance2 = hbd:GetWorldCoordinatesFromZone(x2, y2, mapID2)
    if not worldX1 or not worldY1 or not worldX2 or not worldY2 or instance1 ~= instance2 then return nil end
    local distance = hbd:GetZoneDistance(mapID1, x1, y1, mapID2, x2, y2)
    if type(distance) ~= "number" or distance < 0 then return nil end
    return distance
end

---@param movement NavigationMovementCapabilities
---@param travelMode "automatic"|"ground"|"flight"|"border"?
---@param fromMapID number
---@param toMapID number
---@return string? mode
---@return number? speed
local function GetMovementSpeed(movement, travelMode, fromMapID, toMapID)
    local fromMountInfo = Navigation.mountData[fromMapID] or Navigation.defaultMountInfo
    local toMountInfo = Navigation.mountData[toMapID] or Navigation.defaultMountInfo
    -- Future portal exits have their own restrictions; the player's current
    -- area's flight mode cannot describe movement throughout the route.
    if (travelMode == "automatic" or travelMode == "flight") and fromMountInfo.fly and toMountInfo.fly then
        if movement.canSkyriding then return "skyriding", movement.skyridingSpeed end
        if movement.canFly then return "steady-flight", movement.steadyFlightSpeed end
    end
    if travelMode == "flight" then return nil, nil end
    -- Ground travel cannot infer a pass through terrain between maps. The
    -- graph's authored border Paths own those crossings instead.
    if fromMapID ~= toMapID and travelMode ~= "border" then return nil, nil end
    if fromMountInfo.ground and toMountInfo.ground then return "ground", movement.groundSpeed end
    return "walking", MOVEMENT_SPEEDS.walking
end

---@param preparedData {movement: NavigationMovementCapabilities}
---@param mapID1 number
---@param x1 number
---@param y1 number
---@param mapID2 number
---@param x2 number
---@param y2 number
---@param travelMode "automatic"|"ground"|"flight"|"border"?
---@return NavigationCalculatedPathCost?
function Navigation:GetPlayerTravelCost(preparedData, mapID1, x1, y1, mapID2, x2, y2, travelMode)
    local distance = self:GetComparableDistance(mapID1, x1, y1, mapID2, x2, y2)
    if not distance then return nil end
    local mode, speed = GetMovementSpeed(preparedData.movement, travelMode, mapID1, mapID2)
    if not speed or speed <= 0 then return nil end
    local expectedSeconds = distance / speed
    return {
        expectedSeconds = expectedSeconds,
        uncertaintySeconds = 0,
        comparisonSeconds = expectedSeconds,
        explanation = { kind = "distance", distance = distance, mode = mode, speed = speed },
    }
end

---@param progression NavigationProgression
---@param preparedData NavigationPreparedData|NavigationMovementData
---@param checkpoint fun()
---@param position {mapID: number?, x: number?, y: number?}?
---@param useSelectedCosts boolean? Candidate costs already validated together.
---@return number?
function Navigation:GetRemainingRouteCost(progression, preparedData, checkpoint, position, useSelectedCosts)
    local graph = progression.route.graph
    local destination = self.activeDestination
    if not graph or not destination or not preparedData then return nil end
    local pathReference = progression.route.pathReferences[progression.pathIndex]
    if not pathReference then
        local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
        if position then playerX, playerY, playerMapID = position.x, position.y, position.mapID end
        if not playerMapID or not playerX or not playerY then return nil end
        local finalCost = self:GetPlayerTravelCost(preparedData, playerMapID, playerX, playerY,
            destination.routingData.mapID, destination.routingData.x, destination.routingData.y, "automatic")
        return finalCost and finalCost.comparisonSeconds or nil
    end
    local pathType = graph.pathTypes[pathReference]
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    local total = 0 ---@type number
    local remainingPathIndex = progression.pathIndex

    if progression.phase == "approach" then
        local isMovement = self:IsMovementPath(pathType)
        local targetPointIndex = isMovement and toPointIndex or fromPointIndex
        if not targetPointIndex then return nil end
        local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
        if position then playerX, playerY, playerMapID = position.x, position.y, position.mapID end
        if not playerMapID or not playerX or not playerY then return nil end
        local mode = self:GetPathApproachMode(pathType)
        local approachCost = self:GetPlayerTravelCost(preparedData, playerMapID, playerX, playerY,
            graph.pointMapIDs[targetPointIndex], graph.pointXs[targetPointIndex], graph.pointYs[targetPointIndex], mode)
        if not approachCost then return nil end
        ---@cast approachCost NavigationCalculatedPathCost
        total = total + approachCost.comparisonSeconds
        if isMovement then remainingPathIndex = remainingPathIndex + 1 end
    end

    for index = remainingPathIndex, #progression.route.pathCosts do
        local remainingPathCost = progression.route.pathCosts[index]
        if not useSelectedCosts and
            (index > progression.pathIndex or not progression.attempted and progression.phase ~= "in-transit") then
            local reference = progression.route.pathReferences[index]
            if reference < 0 then
                local journey = progression.route.taxiJourneys[reference]
                local observation = self:GetTaxiObservation()
                if not observation or observation ~= progression.route.preparedData.taxiObservation or
                    not observation.itineraries[journey.destination] or
                    preparedData.movementOnly or not self:IsTaxiJourneyEligible(journey, preparedData) then
                    return nil
                end
                ---@cast preparedData NavigationPreparedData
                local fresh = self:PriceTaxiJourney(self:GetGraph(), preparedData,
                    observation.itineraries[journey.destination], checkpoint, {})
                if not fresh or fresh.identity ~= journey.identity then return nil end
                remainingPathCost = fresh.cost
            else
                remainingPathCost = self:GetFreshPathCost(reference)
            end
        end
        if not remainingPathCost then return nil end
        total = total + remainingPathCost.comparisonSeconds
        checkpoint()
    end

    -- The current approach was sampled above. Later entrances still require
    -- movement from the preceding Path's exit, even without an authored walk.
    for index = progression.pathIndex + 1, #progression.route.pathReferences do
        checkpoint()
        local previousReference = progression.route.pathReferences[index - 1]
        local nextReference = progression.route.pathReferences[index]
        local exitIndex = graph.pathToPointIndexes[previousReference]
        local entranceIndex = graph.pathFromPointIndexes[nextReference]
        if entranceIndex then
            local connection = self:GetPlayerTravelCost(preparedData,
                graph.pointMapIDs[exitIndex], graph.pointXs[exitIndex], graph.pointYs[exitIndex],
                graph.pointMapIDs[entranceIndex], graph.pointXs[entranceIndex], graph.pointYs[entranceIndex],
                "automatic")
            if not connection then return nil end
            ---@cast connection NavigationCalculatedPathCost
            ---@cast total number
            total = total + connection.comparisonSeconds
        end
    end

    local finalPathReference = progression.route.pathReferences[#progression.route.pathReferences]
    local finalPointIndex = finalPathReference and graph.pathToPointIndexes[finalPathReference] or nil
    if not finalPointIndex then return total end
    local finalCost = self:GetPlayerTravelCost(preparedData,
        graph.pointMapIDs[finalPointIndex], graph.pointXs[finalPointIndex], graph.pointYs[finalPointIndex],
        destination.routingData.mapID, destination.routingData.x, destination.routingData.y, "automatic")
    if not finalCost then return nil end
    return total + finalCost.comparisonSeconds
end

-- Incremental route calculation
local MAX_OPERATIONS_PER_SLICE = 2500
local MAX_MILLISECONDS_PER_SLICE = 2
local FLIGHT_PRUNABLE_TYPES = {
    flighttaxi = true,
    tram = true,
    boat = true,
    ship = true,
    zeppelin = true,
    transport = true,
}

---@class NavigationRoute
---@field destinationID string
---@field destinationChangeNumber integer
---@field calculationID integer
---@field graph NavigationGraph
---@field taxiJourneys table<integer, NavigationTaxiJourney>
---@field pathReferences integer[]
---@field pathCosts NavigationCalculatedPathCost[]
---@field finalCost NavigationCalculatedPathCost
---@field comparisonSeconds number
---@field preparedData NavigationPreparedData|NavigationMovementData
---@field originMapID number?
---@field originX number?
---@field originY number?
---@field signature string
---@field calculationSeconds number
---@field calculationSlices integer
---@field movementCandidates integer

---@class NavigationWorldPoint
---@field mapID number
---@field x number
---@field y number
---@field instanceID number

---@class NavigationReverseSearch
---@field incomingPathsByPoint table<integer, integer[]>
---@field exitsByInstance table<number, integer[]>
---@field exitsByMap table<number, integer[]>

---@class NavigationCalculationJob
---@field baseGraph NavigationGraph
---@field graph NavigationGraph
---@field taxiJourneys table<integer, NavigationTaxiJourney>
---@field taxiOutgoing table<integer, integer[]>
---@field calculationID integer
---@field destinationID string
---@field destinationChangeNumber integer
---@field destinationData WayfinderData
---@field preparedData NavigationPreparedData
---@field avoidedPaths table<integer, boolean>
---@field heap NavigationHeapEntry[]
---@field bestCostBuckets table<integer, integer>
---@field bestUncertainties table<integer, number>
---@field bestPathCounts table<integer, integer>
---@field bestSignatures table<integer, string>
---@field destinationCostBucket integer?
---@field bestComplete NavigationHeapEntry?
---@field pathCostByReference table<integer, NavigationCalculatedPathCost>
---@field unavailablePathCosts table<integer, string>
---@field prunedPaths table<integer, boolean>
---@field originMapID number?
---@field originX number?
---@field originY number?
---@field cancelled boolean
---@field reverseSearch NavigationReverseSearch?
---@field movementEntry NavigationHeapEntry?
---@field movementPointIndexes integer[]?
---@field nextMovementPointIndex integer?
---@field destinationWorldPoint NavigationWorldPoint?
---@field worldPoints table<integer, NavigationWorldPoint>
---@field attemptedWorldPoints table<integer, boolean>
---@field entrancesByInstance table<number, integer[]>
---@field entrancesByInstanceX table<number, integer[]>
---@field entrancesByMap table<number, integer[]>
---@field entrancesByMapX table<number, integer[]>
---@field startedAt number
---@field calculationSlices integer
---@field movementCandidates integer
---@field background boolean?
---@field handlingLimit boolean?
---@field frameMilliseconds number?
---@field budgetFrame number?
---@field activeMilliseconds number
---@field onLimit fun()?
---@field wait fun()
---@field checkpoint fun()
---@field cancel fun()?
---@field restart fun()?
---@field onFinish async fun(route: NavigationRoute?, failure: string?, checkpoint: fun())

local calculationNumber = 0

---@class NavigationHeapEntry
---@field pointIndex integer
---@field cost number
---@field costBucket integer
---@field uncertainty number
---@field pathCount integer
---@field previousEntry NavigationHeapEntry?
---@field pathReference integer?
---@field finalCost NavigationCalculatedPathCost?
---@field firstPathReference integer?
---@field signature string

local function GetCostBucket(cost)
    return math.floor(cost + 0.5)
end

local function AddPathToSignature(signature, pathReference)
    return signature .. string.format("%08d,", pathReference)
end

---@param left NavigationHeapEntry
---@param right NavigationHeapEntry
---@return boolean
local function IsHeapEntryLess(left, right)
    if left.costBucket ~= right.costBucket then return left.costBucket < right.costBucket end
    if left.uncertainty ~= right.uncertainty then return left.uncertainty < right.uncertainty end
    if left.pathCount ~= right.pathCount then return left.pathCount < right.pathCount end
    if left.signature ~= right.signature then return left.signature < right.signature end
    return left.pointIndex < right.pointIndex
end

---@param heap NavigationHeapEntry[]
---@param entry NavigationHeapEntry
local function HeapPush(heap, entry)
    local index = #heap + 1
    heap[index] = entry
    while index > 1 do
        local parentIndex = math.floor(index / 2)
        if not IsHeapEntryLess(entry, heap[parentIndex]) then break end
        heap[index] = heap[parentIndex]
        index = parentIndex
    end
    heap[index] = entry
end

---@param heap NavigationHeapEntry[]
---@return NavigationHeapEntry?
local function HeapPop(heap)
    local root = heap[1]
    if not root then return nil end
    local last = table.remove(heap)
    if #heap == 0 then return root end
    local index = 1
    while true do
        local leftIndex = index * 2
        if leftIndex > #heap then break end
        local rightIndex = leftIndex + 1
        local childIndex = leftIndex
        if rightIndex <= #heap and IsHeapEntryLess(heap[rightIndex], heap[leftIndex]) then
            childIndex = rightIndex
        end
        if not IsHeapEntryLess(heap[childIndex], last) then break end
        heap[index] = heap[childIndex]
        index = childIndex
    end
    heap[index] = last
    return root
end

---@param job NavigationCalculationJob
---@param pointIndex integer
---@param cost number
---@param uncertainty number
---@param pathCount integer
---@param previousEntry NavigationHeapEntry?
---@param previousPathReference integer?
---@param signature string
---@param finalCost NavigationCalculatedPathCost?
---@param includePath boolean?
local function OfferPoint(job, pointIndex, cost, uncertainty, pathCount,
                          previousEntry, previousPathReference, signature, finalCost, includePath)
    local costBucket = GetCostBucket(cost)
    -- All remaining travel costs are nonnegative. Keep equal buckets for the
    -- existing uncertainty/Path-count/signature ties, but discard costlier prefixes.
    if job.destinationCostBucket and costBucket > job.destinationCostBucket then return end
    local bestCostBucket = job.bestCostBuckets[pointIndex]
    if bestCostBucket then
        if costBucket > bestCostBucket then return end
        if costBucket == bestCostBucket then
            local bestUncertainty = job.bestUncertainties[pointIndex]
            if uncertainty > bestUncertainty then return end
            if uncertainty == bestUncertainty and pathCount > job.bestPathCounts[pointIndex] then return end
        end
    end
    -- Build a Path signature only once the cheaper tuple comparisons admit it.
    -- Observed negative references retain their journey identity ordering.
    if includePath and previousPathReference then
        local journey = job.taxiJourneys[previousPathReference]
        if job.reverseSearch then
            signature = (journey and journey.identity .. "," or
                AddPathToSignature("", previousPathReference)) .. signature
        else
            signature = journey and signature .. journey.identity .. "," or
                AddPathToSignature(signature, previousPathReference)
        end
    end
    if costBucket == bestCostBucket and uncertainty == job.bestUncertainties[pointIndex] and
        pathCount == job.bestPathCounts[pointIndex] and signature >= job.bestSignatures[pointIndex] then
        return
    end
    job.bestCostBuckets[pointIndex] = costBucket
    job.bestUncertainties[pointIndex] = uncertainty
    job.bestPathCounts[pointIndex] = pathCount
    job.bestSignatures[pointIndex] = signature
    local accepted = {
        pointIndex = pointIndex,
        cost = cost,
        costBucket = costBucket,
        uncertainty = uncertainty,
        pathCount = pathCount,
        signature = signature,
        finalCost = finalCost,
        previousEntry = previousEntry,
        pathReference = previousPathReference,
    }
    HeapPush(job.heap, accepted)
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
---@return boolean
local function IsCurrentEntry(job, entry)
    return job.bestCostBuckets[entry.pointIndex] == entry.costBucket and
        job.bestUncertainties[entry.pointIndex] == entry.uncertainty and
        job.bestPathCounts[entry.pointIndex] == entry.pathCount and
        job.bestSignatures[entry.pointIndex] == entry.signature
end

-- Each overlay falls back directly to the base graph, never another job's
-- candidate overlay. Routes copy only their selected negative references.
---@param source NavigationGraph
---@return NavigationGraph
local function CreateGraphOverlay(source)
    local graph = setmetatable({}, { __index = source }) ---@type NavigationGraph
    graph.pathTypes = setmetatable({}, { __index = source.pathTypes })
    graph.pathFromPointIndexes = setmetatable({}, { __index = source.pathFromPointIndexes })
    graph.pathToPointIndexes = setmetatable({}, { __index = source.pathToPointIndexes })
    graph.pathHandlerData = setmetatable({}, { __index = source.pathHandlerData })
    return graph
end

---@param job NavigationCalculationJob
---@param destinationEntry NavigationHeapEntry
---@return NavigationRoute
local function BuildRoute(job, destinationEntry)
    ---@type integer[]
    local searchReferences = {}
    if destinationEntry.firstPathReference then
        searchReferences[1] = destinationEntry.firstPathReference
    end
    local label = destinationEntry.previousEntry
    while label do
        if label.pathReference then table.insert(searchReferences, label.pathReference) end
        label = label.previousEntry
        job.checkpoint()
    end

    local pathReferences = {}
    local pathCosts = {}
    local graph = CreateGraphOverlay(job.baseGraph)
    local journeys = {} ---@type table<integer, NavigationTaxiJourney>
    -- Forward search links point toward the player; fallback links already
    -- follow execution order from its escape action toward the destination.
    for index = 1, #searchReferences do
        local pathReference = searchReferences[job.reverseSearch and index or #searchReferences - index + 1]
        table.insert(pathReferences, pathReference)
        local pathCost = job.pathCostByReference[pathReference]
        ---@cast pathCost NavigationCalculatedPathCost
        table.insert(pathCosts, pathCost)
        if pathReference > 0 and job.graph.pathTypes[pathReference] == "flighttaxi" then
            journeys[pathReference] = Navigation:GetInferredTaxiJourney(job.graph, pathReference, pathCost)
        elseif pathReference < 0 then
            journeys[pathReference] = job.taxiJourneys[pathReference]
            graph.pathTypes[pathReference] = job.graph.pathTypes[pathReference]
            graph.pathFromPointIndexes[pathReference] = job.graph.pathFromPointIndexes[pathReference]
            graph.pathToPointIndexes[pathReference] = job.graph.pathToPointIndexes[pathReference]
            graph.pathHandlerData[pathReference] = job.graph.pathHandlerData[pathReference]
        end
        job.checkpoint()
    end
    return {
        graph = graph,
        taxiJourneys = journeys,
        destinationID = job.destinationID,
        destinationChangeNumber = job.destinationChangeNumber,
        calculationID = job.calculationID,
        pathReferences = pathReferences,
        pathCosts = pathCosts,
        finalCost = destinationEntry.finalCost,
        comparisonSeconds = destinationEntry.cost,
        preparedData = job.preparedData,
        originMapID = job.originMapID,
        originX = job.originX,
        originY = job.originY,
        signature = destinationEntry.signature,
        calculationSeconds = GetTimePreciseSec() - job.startedAt,
        calculationSlices = job.calculationSlices,
        movementCandidates = job.movementCandidates,
    }
end

---@param job NavigationCalculationJob
---@param pointIndex integer
---@return NavigationWorldPoint?
local function GetWorldPoint(job, pointIndex)
    if not job.attemptedWorldPoints[pointIndex] then
        job.attemptedWorldPoints[pointIndex] = true
        local graph = job.graph
        -- HBD normalizes instances here. Missing geometry is retried by the
        -- next job, without repeatedly converting this point in the current one.
        local x, y, instanceID = MapPinEnhanced.HBD:GetWorldCoordinatesFromZone(
            graph.pointXs[pointIndex], graph.pointYs[pointIndex], graph.pointMapIDs[pointIndex])
        if x and y and instanceID then
            job.worldPoints[pointIndex] = { x = x, y = y, instanceID = instanceID, mapID = graph.pointMapIDs[pointIndex] }
        end
    end
    return job.worldPoints[pointIndex]
end

---@param job NavigationCalculationJob
---@param reference integer
---@return boolean
local function IsRetainedPath(job, reference)
    if job.avoidedPaths[reference] or job.prunedPaths[reference] or job.unavailablePathCosts[reference] or
        job.preparedData.requirementStateByPath[reference] ~= "satisfied" then
        return false
    end
    if job.graph.pathTypes[reference] == "flighttaxi" and not job.pathCostByReference[reference] then
        -- This is a prepared-table lookup, not dominance pricing. Even ground
        -- jobs must exclude unknown destinations and replaced master departures
        -- before their points enter either movement index.
        local cost, failure = Navigation:GetPathCost(job.graph, job.preparedData, reference)
        if not cost then
            job.unavailablePathCosts[reference] = failure or "taxi cost unavailable"
            return false
        end
        job.pathCostByReference[reference] = cost
    end
    return true
end

---@param job NavigationCalculationJob
---@param fromPointIndex integer?
---@param toPointIndex integer
---@param cost NavigationCalculatedPathCost
---@return boolean
local function IsSlowerThanFlight(job, fromPointIndex, toPointIndex, cost)
    if not fromPointIndex or not (cost.comparisonSeconds >= 0 and cost.comparisonSeconds < math.huge) then
        return false
    end
    local graph = job.graph
    local _, speed = GetMovementSpeed(job.preparedData.movement, "flight",
        graph.pointMapIDs[fromPointIndex], graph.pointMapIDs[toPointIndex])
    if not speed or speed <= 0 then return false end
    local origin, target = GetWorldPoint(job, fromPointIndex), GetWorldPoint(job, toPointIndex)
    if not origin or not target or origin.instanceID ~= target.instanceID then return false end
    local distance = MapPinEnhanced.HBD:GetWorldDistance(origin.instanceID, origin.x, origin.y, target.x, target.y)
    -- With the same instance, endpoint permissions and flight speed, direct
    -- movement can bypass these detours by the triangle inequality. Keep a
    -- margin greater than the existing one-second comparison bucket.
    return type(distance) == "number" and distance >= 0 and distance / speed + 1 < cost.comparisonSeconds
end

---@param job NavigationCalculationJob
---@param pointIndex integer
---@return NavigationCalculatedPathCost?
local function GetFinalMovementCost(job, pointIndex)
    local origin, target = GetWorldPoint(job, pointIndex), job.destinationWorldPoint
    if not origin or not target or origin.instanceID ~= target.instanceID then return nil end
    local mode, speed = GetMovementSpeed(job.preparedData.movement, "automatic", origin.mapID, target.mapID)
    if not speed or speed <= 0 then return nil end
    local distance = MapPinEnhanced.HBD:GetWorldDistance(origin.instanceID, origin.x, origin.y, target.x, target.y)
    if type(distance) ~= "number" or distance < 0 then return nil end
    local seconds = distance / speed
    return {
        expectedSeconds = seconds,
        uncertaintySeconds = 0,
        comparisonSeconds = seconds,
        explanation = { kind = "distance", distance = distance, mode = mode, speed = speed }
    }
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
local function OfferComplete(job, entry)
    if not job.bestComplete or IsHeapEntryLess(entry, job.bestComplete) then
        job.bestComplete = entry
    end
    HeapPush(job.heap, entry)
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
local function OfferDestination(job, entry)
    local graph = job.graph
    if not graph or entry.pathCount == 0 then return end
    local finalCost = GetFinalMovementCost(job, entry.pointIndex)
    if not finalCost then return end
    local costBucket = GetCostBucket(entry.cost + finalCost.comparisonSeconds)
    if job.destinationCostBucket and costBucket > job.destinationCostBucket then return end
    job.destinationCostBucket = costBucket
    OfferComplete(job, {
        pointIndex = 0,
        cost = entry.cost + finalCost.comparisonSeconds,
        costBucket = costBucket,
        uncertainty = entry.uncertainty + finalCost.uncertaintySeconds,
        pathCount = entry.pathCount,
        previousEntry = entry,
        finalCost = finalCost,
        signature = entry.signature,
    })
end

---@param job NavigationCalculationJob
---@param origin NavigationWorldPoint
---@param cost number
---@return integer[]?
local function GetForwardMovementCandidates(job, origin, cost)
    local _, flightSpeed = GetMovementSpeed(job.preparedData.movement, "flight", origin.mapID, origin.mapID)
    local scope = flightSpeed and origin.instanceID or origin.mapID
    local lists = flightSpeed and job.entrancesByInstance or job.entrancesByMap
    local indexes = flightSpeed and job.entrancesByInstanceX or job.entrancesByMapX
    local candidates = lists[scope]
    if not candidates or not job.destinationCostBucket then return candidates end
    local _, speed = GetMovementSpeed(job.preparedData.movement, "automatic", origin.mapID, origin.mapID)
    if not speed or speed <= 0 then return nil end
    -- No endpoint can permit faster movement than the origin itself. A complete
    -- route bounds the search radius, including the entire equal-cost bucket.
    local radius = (job.destinationCostBucket + 0.5 - cost) * speed
    local sorted = indexes[scope]
    if not sorted then
        sorted = {}
        for index, pointIndex in ipairs(candidates) do
            sorted[index] = pointIndex
            job.checkpoint()
        end
        table.sort(sorted, function(left, right)
            return job.worldPoints[left].x < job.worldPoints[right].x
        end)
        indexes[scope] = sorted
        job.checkpoint()
    end
    local low, high = 1, #sorted + 1
    while low < high do
        local middle = math.floor((low + high) / 2)
        if job.worldPoints[sorted[middle]].x < origin.x - radius then
            low = middle + 1
        else
            high = middle
        end
    end
    local nearby = {} ---@type integer[]
    for index = low, #sorted do
        job.checkpoint()
        local pointIndex = sorted[index]
        local point = job.worldPoints[pointIndex]
        if point.x > origin.x + radius then break end
        if math.abs(point.y - origin.y) <= radius then nearby[#nearby + 1] = pointIndex end
    end
    -- Preserve the original dense-point offer order, including equal-cost ties.
    table.sort(nearby)
    return nearby
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
local function ExpandPoint(job, entry)
    local graph = job.graph
    if not graph then return end
    OfferDestination(job, entry)
    local firstOffset = graph.firstOutgoingPathByPointIndex[entry.pointIndex]
    local count = graph.outgoingPathCountByPointIndex[entry.pointIndex] or 0
    for offset = firstOffset, firstOffset + count - 1 do
        job.checkpoint()
        local pathReference = graph.outgoingPathReferences[offset]
        if IsRetainedPath(job, pathReference) then
            ---@type NavigationCalculatedPathCost?
            local pathCost = job.pathCostByReference[pathReference]
            if pathCost == nil then
                ---@type string?
                local failure
                pathCost, failure = Navigation:GetPathCost(graph, job.preparedData, pathReference)
                if pathCost then
                    job.pathCostByReference[pathReference] = pathCost
                else
                    job.unavailablePathCosts[pathReference] = failure or "path cost unavailable"
                end
            end
            if pathCost then
                OfferPoint(job, graph.pathToPointIndexes[pathReference],
                    entry.cost + pathCost.comparisonSeconds,
                    entry.uncertainty + pathCost.uncertaintySeconds,
                    entry.pathCount + 1, entry, pathReference,
                    entry.signature, nil, true)
            end
        end
    end
    for _, reference in ipairs(job.taxiOutgoing[entry.pointIndex] or {}) do
        job.checkpoint()
        local journey = job.taxiJourneys[reference]
        local cost = journey.cost
        OfferPoint(job, journey.toPointIndex, entry.cost + cost.comparisonSeconds,
            entry.uncertainty + cost.uncertaintySeconds, entry.pathCount + 1,
            entry, reference, entry.signature, nil, true)
    end
    -- Authored data describes transitions, not every walk between entrances.
    -- Offer connections from actual Path arrivals. Initial player approaches
    -- already cover entrances; arbitrary movement waypoints are not added.
    if entry.pathReference then
        local origin = job.worldPoints[entry.pointIndex]
        job.movementPointIndexes = origin and GetForwardMovementCandidates(job, origin, entry.cost)
        job.movementEntry = entry
        job.nextMovementPointIndex = 1
    end
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
---@param reverse NavigationReverseSearch
local function ExpandReversePoint(job, entry, reverse)
    local graph = job.graph
    -- Incoming links are searched backward but always priced and executed in
    -- their authored direction. This cannot invent a return trip for a portal.
    for _, reference in ipairs(reverse.incomingPathsByPoint[entry.pointIndex] or {}) do
        job.checkpoint()
        if not job.unavailablePathCosts[reference] then
            local cost = job.pathCostByReference[reference]
            if not cost then
                local failure
                cost, failure = Navigation:GetPathCost(graph, job.preparedData, reference)
                if cost then
                    job.pathCostByReference[reference] = cost
                else
                    job.unavailablePathCosts[reference] = failure or "path cost unavailable"
                end
            end
            if cost then
                local fromPointIndex = graph.pathFromPointIndexes[reference]
                local totalCost = entry.cost + cost.comparisonSeconds
                local uncertainty = entry.uncertainty + cost.uncertaintySeconds
                if fromPointIndex then
                    OfferPoint(job, fromPointIndex, totalCost, uncertainty, entry.pathCount + 1,
                        entry, reference, entry.signature, entry.finalCost, true)
                elseif Navigation:GetPathAction(graph.pathTypes[reference], graph.pathRequirements[reference]) then
                    -- Only a usable current-player action may close this
                    -- fallback. No player map coordinates or approach are needed.
                    OfferComplete(job, {
                        pointIndex = 0,
                        cost = totalCost,
                        costBucket = GetCostBucket(totalCost),
                        uncertainty = uncertainty,
                        pathCount = entry.pathCount + 1,
                        previousEntry = entry,
                        firstPathReference = reference,
                        finalCost = entry.finalCost,
                        signature = job.taxiJourneys[reference] and
                            job.taxiJourneys[reference].identity .. "," .. entry.signature or
                            AddPathToSignature("", reference) .. entry.signature,
                    })
                end
            end
        end
    end
    -- An entrance can follow movement from a preceding exit. Do not chain
    -- arbitrary movement waypoints or add a second approach from the player.
    if entry.pathReference then
        job.movementEntry = entry
        job.nextMovementPointIndex = 1
    end
end

---@param job NavigationCalculationJob
local function OfferNextMovementPoint(job)
    local entry = job.movementEntry
    local candidateIndex = job.nextMovementPointIndex
    if not entry or not candidateIndex then return end
    local origin = job.worldPoints[entry.pointIndex]
    local candidates = job.movementPointIndexes
    if job.reverseSearch and origin then
        -- In reverse, origin is the forward destination: both endpoints must fly.
        local _, speed = GetMovementSpeed(job.preparedData.movement, "flight", origin.mapID, origin.mapID)
        candidates = speed and job.reverseSearch.exitsByInstance[origin.instanceID] or
            job.reverseSearch.exitsByMap[origin.mapID]
    end
    local pointIndex = candidates and candidates[candidateIndex]
    if not origin or not pointIndex then
        job.movementEntry = nil
        job.movementPointIndexes = nil
        job.nextMovementPointIndex = nil
        return
    end
    job.nextMovementPointIndex = candidateIndex + 1
    job.movementCandidates = job.movementCandidates + 1
    if pointIndex == entry.pointIndex then return end
    local bestCostBucket = job.bestCostBuckets[pointIndex]
    if bestCostBucket and entry.costBucket > bestCostBucket then return end
    local target = job.worldPoints[pointIndex]
    local fromMapID = job.reverseSearch and target.mapID or origin.mapID
    local toMapID = job.reverseSearch and origin.mapID or target.mapID
    local _, speed = GetMovementSpeed(job.preparedData.movement, "automatic", fromMapID, toMapID)
    if not speed or speed <= 0 then return end
    if job.destinationCostBucket then
        -- The half-second margin includes every cost in the winning bucket.
        -- Reject distant entrances before computing distance or building heap entries.
        local remainingDistance = (job.destinationCostBucket + 0.5 - entry.cost) * speed
        if math.abs(origin.x - target.x) > remainingDistance or
            math.abs(origin.y - target.y) > remainingDistance then
            return
        end
    end
    local seconds = MapPinEnhanced:GetPointDistance(origin, target) / speed
    OfferPoint(job, pointIndex, entry.cost + seconds,
        entry.uncertainty, entry.pathCount, entry, nil, entry.signature, entry.finalCost)
end

---@async
---@param job NavigationCalculationJob
---@return NavigationHeapEntry?
local function AdvanceJob(job)
    while true do
        job.checkpoint()
        if job.movementEntry then
            OfferNextMovementPoint(job)
        else
            local entry = HeapPop(job.heap)
            if not entry then return nil end
            if entry.pointIndex == 0 then return entry end
            if IsCurrentEntry(job, entry) then
                if job.reverseSearch then
                    ExpandReversePoint(job, entry, job.reverseSearch)
                else
                    ExpandPoint(job, entry)
                end
            end
        end
    end
end

---@param job NavigationCalculationJob
local function SeedJob(job)
    local graph = job.graph
    if not graph then return end
    local playerX, playerY, playerMapID = job.originX, job.originY, job.originMapID

    if playerMapID and playerX and playerY then
        local destination = job.destinationData
        local directCost = Navigation:GetPlayerTravelCost(job.preparedData,
            playerMapID, playerX, playerY, destination.mapID, destination.x, destination.y, "automatic")
        if directCost then
            job.destinationCostBucket = GetCostBucket(directCost.comparisonSeconds)
            OfferComplete(job, {
                pointIndex = 0,
                cost = directCost.comparisonSeconds,
                costBucket = job.destinationCostBucket,
                uncertainty = directCost.uncertaintySeconds,
                pathCount = 0,
                finalCost = directCost,
                signature = "",
            })
        end

        local worldX, worldY, instanceID = MapPinEnhanced.HBD:GetWorldCoordinatesFromZone(playerX, playerY, playerMapID)
        local origin = worldX and worldY and instanceID and
            { x = worldX, y = worldY, instanceID = instanceID, mapID = playerMapID }
        local entrances = origin and GetForwardMovementCandidates(job, origin, 0)
        if worldX and worldY and entrances then
            for _, pointIndex in ipairs(entrances) do
                job.checkpoint()
                local target = job.worldPoints[pointIndex]
                local _, speed = GetMovementSpeed(job.preparedData.movement, "automatic", playerMapID, target.mapID)
                if speed and speed > 0 then
                    local seconds = MapPinEnhanced:GetPointDistance(origin, target) / speed
                    OfferPoint(job, pointIndex, seconds, 0, 0, nil, nil, "")
                end
            end
        end
    end

    -- Current-position actions do not need dungeon map coordinates. They are
    -- the escape route when the player's instance cannot attach to world travel.
    for _, pathReference in ipairs(graph.currentPlayerPathReferences) do
        job.checkpoint()
        if not job.avoidedPaths[pathReference] then
            local pathCost = Navigation:GetPathCost(graph, job.preparedData, pathReference)
            if pathCost then
                job.pathCostByReference[pathReference] = pathCost
                OfferPoint(job, graph.pathToPointIndexes[pathReference], pathCost.comparisonSeconds,
                    pathCost.uncertaintySeconds, 1, nil, pathReference,
                    "", nil, true)
            end
        end
    end
end

---@param job NavigationCalculationJob
---@param graph NavigationGraph
local function PrepareTransportCandidates(job, graph)
    if not job.preparedData.movement.canFly and not job.preparedData.movement.canSkyriding then return end
    for reference = 1, graph.pathCount do
        job.checkpoint()
        local from, to = graph.pathFromPointIndexes[reference], graph.pathToPointIndexes[reference]
        local _, speed ---@type string?, number?
        if from then
            _, speed = GetMovementSpeed(job.preparedData.movement, "flight",
                graph.pointMapIDs[from], graph.pointMapIDs[to])
        end
        if FLIGHT_PRUNABLE_TYPES[graph.pathTypes[reference]] and speed and IsRetainedPath(job, reference) then
            local cost, failure = Navigation:GetPathCost(graph, job.preparedData, reference)
            if cost then
                job.pathCostByReference[reference] = cost
                job.prunedPaths[reference] = IsSlowerThanFlight(job, graph.pathFromPointIndexes[reference],
                    graph.pathToPointIndexes[reference], cost) or nil
            else
                job.unavailablePathCosts[reference] = failure or "path cost unavailable"
            end
        end
    end
end

---@param job NavigationCalculationJob
---@param graph NavigationGraph
local function PrepareMovementPoints(job, graph)
    local destination = job.destinationData
    local x, y, instanceID = MapPinEnhanced.HBD:GetWorldCoordinatesFromZone(
        destination.x, destination.y, destination.mapID)
    if x and y and instanceID then
        job.destinationWorldPoint = { x = x, y = y, instanceID = instanceID, mapID = destination.mapID }
    end
    local seen = {} ---@type table<integer, boolean>
    for reference = 1, graph.pathCount do
        job.checkpoint()
        if IsRetainedPath(job, reference) then
            local from, to = graph.pathFromPointIndexes[reference], graph.pathToPointIndexes[reference]
            if from and GetWorldPoint(job, from) then seen[from] = true end
            -- Incoming-only junctions and player-origin action exits still need
            -- final movement and reverse fallback geometry.
            GetWorldPoint(job, to)
        end
    end
    -- Observed departures survive independently of their static source legs.
    for _, journey in pairs(job.taxiJourneys) do
        job.checkpoint()
        if GetWorldPoint(job, journey.fromPointIndex) then seen[journey.fromPointIndex] = true end
        GetWorldPoint(job, journey.toPointIndex)
    end
    -- Dense point order produces the same sorted entrances without a monolithic sort.
    for pointIndex = 1, #graph.pointIDs do
        if seen[pointIndex] then
            local point = job.worldPoints[pointIndex]
            local entrances = job.entrancesByInstance[point.instanceID] or {}
            job.entrancesByInstance[point.instanceID] = entrances
            entrances[#entrances + 1] = pointIndex
            local mapEntrances = job.entrancesByMap[point.mapID] or {}
            job.entrancesByMap[point.mapID] = mapEntrances
            mapEntrances[#mapEntrances + 1] = pointIndex
        end
        job.checkpoint()
    end
end

---@param job NavigationCalculationJob
local function SeedReverseFallback(job)
    -- Called only after the forward heap is exhausted. Keep its immutable
    -- inputs and cost observations, but no visited-point state may leak across.
    job.bestCostBuckets = {}
    job.bestUncertainties = {}
    job.bestPathCounts = {}
    job.bestSignatures = {}
    local reverse = { incomingPathsByPoint = {}, exitsByInstance = {}, exitsByMap = {} } ---@type NavigationReverseSearch
    job.reverseSearch = reverse
    local graph = job.graph
    local function AddIncomingPath(reference)
        local pointIndex = graph.pathToPointIndexes[reference]
        local incoming = reverse.incomingPathsByPoint[pointIndex] or {}
        reverse.incomingPathsByPoint[pointIndex] = incoming
        incoming[#incoming + 1] = reference
    end
    for reference = 1, graph.pathCount do
        job.checkpoint()
        if IsRetainedPath(job, reference) then
            AddIncomingPath(reference)
        end
    end
    -- These journeys were already priced and checked against avoided legs.
    for reference in pairs(job.taxiJourneys) do
        AddIncomingPath(reference)
        job.checkpoint()
    end
    for pointIndex = 1, #graph.pointIDs do
        job.checkpoint()
        if reverse.incomingPathsByPoint[pointIndex] then
            local point = job.worldPoints[pointIndex]
            if point then
                local exits = reverse.exitsByInstance[point.instanceID] or {}
                reverse.exitsByInstance[point.instanceID] = exits
                exits[#exits + 1] = pointIndex
                local mapExits = reverse.exitsByMap[point.mapID] or {}
                reverse.exitsByMap[point.mapID] = mapExits
                mapExits[#mapExits + 1] = pointIndex
            end
            local finalCost = GetFinalMovementCost(job, pointIndex)
            if finalCost then
                OfferPoint(job, pointIndex, finalCost.comparisonSeconds, finalCost.uncertaintySeconds,
                    0, nil, nil, "", finalCost)
            end
        end
    end
end

-- Negative operation references are calculation-local taxi journeys, never
-- authored path IDs. The overlay shares immutable point/source arrays while
-- providing endpoint/type views to existing presentation consumers.
---@param job NavigationCalculationJob
---@param source NavigationGraph
local function PrepareTaxiCandidates(job, source)
    local graph = CreateGraphOverlay(source)
    job.graph = graph
    local observation = job.preparedData.taxiObservation
    if not observation or not next(job.preparedData.taxiCosts) then return end
    local destinations = {} ---@type number[]
    for destination in pairs(observation.itineraries) do
        destinations[#destinations + 1] = destination
        job.checkpoint()
    end
    table.sort(destinations)
    local legs = {} ---@type NavigationTaxiLegMemo
    for index, destination in ipairs(destinations) do
        job.checkpoint()
        local journey, failure = Navigation:PriceTaxiJourney(source, job.preparedData,
            observation.itineraries[destination], job.checkpoint, legs)
        local reference = -index
        local avoided = false
        if journey then
            for _, leg in ipairs(journey.legs) do
                for _, sourceReference in ipairs(leg.sourceReferences) do
                    if job.avoidedPaths[sourceReference] then avoided = true end
                    job.checkpoint()
                end
            end
        end
        if journey and not avoided and IsSlowerThanFlight(job, journey.fromPointIndex, journey.toPointIndex,
                journey.cost) then
            job.prunedPaths[reference] = true
        elseif journey and not avoided then
            journey.destinationName = observation.names[destination]
            job.taxiJourneys[reference] = journey
            job.pathCostByReference[reference] = journey.cost
            local outgoing = job.taxiOutgoing[journey.fromPointIndex] or {}
            job.taxiOutgoing[journey.fromPointIndex] = outgoing
            outgoing[#outgoing + 1] = reference
            graph.pathTypes[reference] = "flighttaxi"
            graph.pathFromPointIndexes[reference] = journey.fromPointIndex
            graph.pathToPointIndexes[reference] = journey.toPointIndex
            local from, to = journey.fromPointIndex, journey.toPointIndex
            graph.pathHandlerData[reference] = {
                fromMap = graph.pointMapIDs[from],
                fromX = graph.pointXs[from],
                fromY = graph.pointYs[from],
                toMap = graph.pointMapIDs[to],
                toX = graph.pointXs[to],
                toY = graph.pointYs[to],
                fromTaxiNodeID = journey.origin,
                toTaxiNodeID = journey.destination,
                taxiPathIDs = {},
            }
        else
            job.unavailablePathCosts[reference] = failure or "taxi connection avoided"
        end
    end
end

-- Both workers charge only running time. Awaiting observations resets the clock
-- through wait(), so suspended frames never count as active CPU.
---@param job NavigationCalculationJob?
---@param preparation boolean?
---@return fun() checkpoint
---@return fun() wait
function Navigation:CreateNavigationCheckpoint(job, preparation)
    local last = debugprofilestop()
    local slice = last
    local operations = 0
    local function Charge()
        local now = debugprofilestop()
        local owner = job or self.activeCalculation
        if owner and not owner.cancelled then
            local frame = GetTime()
            if owner.budgetFrame ~= frame then
                owner.budgetFrame, owner.frameMilliseconds = frame, 0
            end
            owner.frameMilliseconds = (owner.frameMilliseconds or 0) + now - last
            owner.activeMilliseconds = owner.activeMilliseconds + now - last
        end
        last = now
        return owner, now
    end
    ---@async
    local function Wait()
        Charge()
        coroutine.yield()
        last = debugprofilestop()
        slice, operations = last, 0
        if job then job.calculationSlices = (job.calculationSlices or 0) + 1 end
    end
    ---@async
    local function Checkpoint()
        local owner, now = Charge()
        if owner and not owner.cancelled and not owner.handlingLimit then
            local elapsed = GetTimePreciseSec() - owner.startedAt
            local limit = not owner.background and (elapsed >= 0.1 or owner.activeMilliseconds >= 8)
            if not preparation and (limit or elapsed >= 30) and owner.onLimit then
                owner.onLimit()
                if owner.cancelled then coroutine.yield() end
            elseif preparation and (limit or elapsed >= 30) then
                Wait()
                return
            end
        end
        operations = operations + 1
        local budget = owner and owner.background and 0.25 or MAX_MILLISECONDS_PER_SLICE
        if operations >= MAX_OPERATIONS_PER_SLICE or now - slice >= budget or
            owner and owner.background and (owner.frameMilliseconds or 0) >= budget then
            Wait()
        end
        if job and job.cancelled then coroutine.yield() end
    end
    return Checkpoint, Wait
end

---@param destinationID string
---@param destinationChangeNumber integer
---@param data WayfinderData
---@return NavigationRoute?
function Navigation:CreateDirectRoute(destinationID, destinationChangeNumber, data)
    local graph = self:GetGraph()
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not graph or not mapID or not x or not y then return nil end
    local inputs = { movement = self:GetMovementCapabilities(), movementOnly = true }
    local cost = self:GetPlayerTravelCost(inputs, mapID, x, y, data.mapID, data.x, data.y, "automatic")
    if not cost or not MapPinEnhanced:IsReadableNumber(cost.comparisonSeconds) or
        not (cost.comparisonSeconds >= 0 and cost.comparisonSeconds < math.huge) then
        return nil
    end
    calculationNumber = calculationNumber + 1
    return {
        destinationID = destinationID,
        destinationChangeNumber = destinationChangeNumber,
        calculationID = calculationNumber,
        graph = graph,
        taxiJourneys = {},
        pathReferences = {},
        pathCosts = {},
        finalCost = cost,
        comparisonSeconds = cost.comparisonSeconds,
        preparedData = inputs,
        originMapID = mapID,
        originX = x,
        originY = y,
        signature = "",
        calculationSeconds = 0,
        calculationSlices = 0,
        movementCandidates = 0,
    }
end

---@param route NavigationRoute
---@param prepared NavigationPreparedData|NavigationMovementData
---@param checkpoint fun()
---@param position {mapID: number?, x: number?, y: number?}
---@return boolean
function Navigation:ValidateRoute(route, prepared, checkpoint, position)
    if #route.pathReferences > 0 and prepared.movementOnly then return false end
    for index, reference in ipairs(route.pathReferences) do
        checkpoint()
        local cost ---@type NavigationCalculatedPathCost?
        if reference < 0 then
            local journey = route.taxiJourneys[reference]
            local observation = self:GetTaxiObservation()
            if not observation or observation ~= route.preparedData.taxiObservation or
                observation ~= prepared.taxiObservation or not observation.itineraries[journey.destination] then
                return false
            end
            ---@cast prepared NavigationPreparedData
            local fresh = self:PriceTaxiJourney(self:GetGraph(), prepared,
                observation.itineraries[journey.destination], checkpoint, {})
            if not fresh or fresh.identity ~= journey.identity then return false end
            fresh.destinationName = journey.destinationName
            route.taxiJourneys[reference] = fresh
            cost = fresh.cost
        else
            cost = self:GetFreshPathCost(reference)
        end
        if not cost then return false end
        route.pathCosts[index] = cost
        if reference > 0 and route.graph.pathTypes[reference] == "flighttaxi" then
            route.taxiJourneys[reference] = self:GetInferredTaxiJourney(route.graph, reference, cost)
        end
    end
    ---@type NavigationProgression
    local progression = {
        route = route,
        pathIndex = 1,
        changeNumber = 1,
        phase = route.pathReferences[1] and not route.graph.pathFromPointIndexes[route.pathReferences[1]] and
            "ready" or "approach",
    }
    local total = self:GetRemainingRouteCost(progression, prepared, checkpoint, position, true)
    if not total then return false end
    route.comparisonSeconds = total
    route.preparedData = prepared
    local destination = self.activeDestination
    if not destination then return false end
    local graph = route.graph
    local lastReference = route.pathReferences[#route.pathReferences]
    local lastPoint = lastReference and graph.pathToPointIndexes[lastReference]
    local fromX, fromY, fromMap = position.x, position.y, position.mapID
    if lastPoint then
        fromX, fromY, fromMap = graph.pointXs[lastPoint], graph.pointYs[lastPoint], graph.pointMapIDs[lastPoint]
    end
    if not fromMap or not fromX or not fromY then
        if not lastPoint then return false end
    else
        local final = self:GetPlayerTravelCost(prepared, fromMap, fromX, fromY,
            destination.routingData.mapID, destination.routingData.x, destination.routingData.y, "automatic")
        if not final then return false end
        route.finalCost = final
    end
    route.originX, route.originY, route.originMapID = position.x, position.y, position.mapID
    return true
end

---@param destinationID string
---@param destinationChangeNumber integer
---@param destinationData WayfinderData
---@param avoidedPaths table<integer, NavigationPathFailure>
---@param onFinish async fun(route: NavigationRoute?, failure: string?, checkpoint: fun())
---@param onRestart fun()
---@param background boolean?
---@return NavigationCalculationJob?
function Navigation:StartRouteCalculation(destinationID, destinationChangeNumber, destinationData, avoidedPaths, onFinish,
                                          onRestart, background)
    local graph = self:GetGraph()
    calculationNumber = calculationNumber + 1
    local startedAt = GetTimePreciseSec()
    local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    local job = {
        graph = graph,
        baseGraph = graph,
        taxiJourneys = {},
        taxiOutgoing = {},
        calculationID = calculationNumber,
        destinationID = destinationID,
        destinationChangeNumber = destinationChangeNumber,
        destinationData = destinationData,
        avoidedPaths = {},
        heap = {},
        bestCostBuckets = {},
        bestUncertainties = {},
        bestPathCounts = {},
        bestSignatures = {},
        pathCostByReference = {},
        unavailablePathCosts = {},
        prunedPaths = {},
        originMapID = playerMapID,
        originX = playerX,
        originY = playerY,
        cancelled = false,
        worldPoints = {},
        attemptedWorldPoints = {},
        entrancesByInstance = {},
        entrancesByInstanceX = {},
        entrancesByMap = {},
        entrancesByMapX = {},
        startedAt = startedAt,
        background = background,
        activeMilliseconds = 0,
        calculationSlices = 0,
        movementCandidates = 0,
        onFinish = onFinish,
        restart = onRestart,
    }
    ---@cast job NavigationCalculationJob
    job.cancel = MapPinEnhanced:BatchExecution({
        ---@async
        function()
            job.calculationSlices = 1
            job.checkpoint, job.wait = self:CreateNavigationCheckpoint(job)
            ---@async
            job.onLimit = function()
                job.handlingLimit = true
                local expired = GetTimePreciseSec() - job.startedAt >= 30
                local reason = expired and "background lifetime" or "initial budget"
                self.lastCalculationTermination = reason
                local candidate = job.bestComplete and BuildRoute(job, job.bestComplete) or
                    self:CreateDirectRoute(destinationID, destinationChangeNumber, destinationData)
                -- An unfinished authoritative refresh cannot certify transport.
                if candidate and #candidate.pathReferences > 0 and not self:ArePreparedInputsFresh() then
                    candidate = self:CreateDirectRoute(destinationID, destinationChangeNumber, destinationData)
                end
                job.onFinish(candidate, reason, job.checkpoint)
                if job.cancelled then coroutine.yield() end
                if expired or not self.backgroundSearchEnabled then
                    self:CancelPreparedData()
                    self:CancelRouteCalculation(job)
                    -- A retained transport Route still consumes authoritative
                    -- observations. Finish that refresh without another search.
                    if self.progression and #self.progression.route.pathReferences > 0 and
                        not self:ArePreparedInputsFresh() then
                        self:EnsurePreparedData()
                    end
                    self:TryAutomaticTaxiSelection()
                    coroutine.yield()
                end
                job.background = true
                job.handlingLimit = nil
                self:TryAutomaticTaxiSelection()
                if job.cancelled then coroutine.yield() end
            end
            if not graph then
                job.onFinish(nil, "navigation data is not ready", job.checkpoint)
                return
            end
            local prepared, failure = self:AwaitPreparedData(job.checkpoint, job.wait)
            if not prepared then
                job.onFinish(nil, failure or "navigation data is not ready", job.checkpoint)
                return
            end
            job.preparedData = prepared
            job.checkpoint()
            for reference in pairs(avoidedPaths) do
                job.avoidedPaths[reference] = true
                job.checkpoint()
            end
            PrepareTransportCandidates(job, graph)
            PrepareTaxiCandidates(job, graph)
            PrepareMovementPoints(job, graph)
            SeedJob(job)
            local result = AdvanceJob(job)
            if not result then
                SeedReverseFallback(job)
                result = AdvanceJob(job)
            end
            self:AwaitPreparedData(job.checkpoint, job.wait)
            self.lastCalculationTermination = "complete"
            job.handlingLimit = true
            if result then
                job.onFinish(BuildRoute(job, result), nil, job.checkpoint)
            else
                job.onFinish(nil, "no route", job.checkpoint)
            end
            if not job.cancelled then job.checkpoint() end
        end,
    }, nil, function()
        local wasCurrent = self.activeCalculation == job
        self:CancelRouteCalculation(job)
        if wasCurrent then self:TryAutomaticTaxiSelection() end
    end, 1, function(message)
        local current = self.activeCalculation == job
        self:CancelRouteCalculation(job)
        if current and self.activeDestination then
            self:ApplyCalculatedRoute(self.activeDestination, nil, "calculation error", function() end)
        end
        geterrorhandler()(message)
    end)
    return job
end

---@param job NavigationCalculationJob?
function Navigation:CancelRouteCalculation(job)
    if not job or self.activeCalculation == job then self.pendingCalculationRestart = nil end
    if not job then
        self:CancelPreparedData()
        return
    end
    if job.cancelled then return end
    if self.activeCalculation == job then
        self.activeCalculation = nil
        self:CancelPreparedData()
    end
    if job.cancel then job.cancel() end
    -- Release candidate graphs, heaps, scratch arrays and callback captures even
    -- when another owner still holds this terminal job handle.
    wipe(job)
    job.cancelled = true
end
