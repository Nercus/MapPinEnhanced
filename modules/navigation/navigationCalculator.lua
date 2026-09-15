---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

-- Route costs
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
---@field explanation table

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

---@param preparedData NavigationPreparedData
---@param mapID1 number
---@param x1 number
---@param y1 number
---@param mapID2 number
---@param x2 number
---@param y2 number
---@param travelMode "automatic"|"ground"|"flight"?
---@return NavigationCalculatedPathCost?
function Navigation:GetPlayerTravelCost(preparedData, mapID1, x1, y1, mapID2, x2, y2, travelMode)
    local distance = self:GetComparableDistance(mapID1, x1, y1, mapID2, x2, y2)
    if not distance then return nil end
    local movement = preparedData.movement
    local requestedMode = travelMode or "ground"
    local mode = "ground"
    local speed = movement.groundSpeed
    local flightMode = requestedMode == "flight" and
        (movement.canSkyriding and "skyriding" or movement.canFly and "steady" or nil) or
        requestedMode == "automatic" and movement.activeFlightMode or nil
    if flightMode == "skyriding" then
        mode = "skyriding"
        speed = movement.skyridingSpeed
    elseif flightMode == "steady" then
        mode = "steady-flight"
        speed = movement.steadyFlightSpeed
    end
    if speed <= 0 then return nil end
    local expectedSeconds = distance / speed
    return {
        expectedSeconds = expectedSeconds,
        uncertaintySeconds = 0,
        comparisonSeconds = expectedSeconds,
        explanation = { kind = "distance", distance = distance, mode = mode, speed = speed },
    }
end

---@param progression NavigationProgression
---@return number?
function Navigation:GetRemainingRouteCost(progression)
    local graph = self:GetGraph()
    local destination = self.activeDestination
    local preparedData = self:GetPreparedData()
    if not graph or not destination or not preparedData or not self:IsCurrentProgression(progression) then return nil end
    local pathReference = progression.route.pathReferences[progression.pathIndex]
    if not pathReference then
        local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
        if not playerMapID or not playerX or not playerY then return nil end
        local finalCost = self:GetPlayerTravelCost(preparedData, playerMapID, playerX, playerY,
            destination.data.mapID, destination.data.x, destination.data.y, "automatic")
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
        if not remainingPathCost then return nil end
        total = total + remainingPathCost.comparisonSeconds
    end

    local finalPathReference = progression.route.pathReferences[#progression.route.pathReferences]
    local finalPointIndex = finalPathReference and graph.pathToPointIndexes[finalPathReference] or nil
    if not finalPointIndex then return total end
    local finalCost = self:GetPlayerTravelCost(preparedData,
        graph.pointMapIDs[finalPointIndex], graph.pointXs[finalPointIndex], graph.pointYs[finalPointIndex],
        destination.data.mapID, destination.data.x, destination.data.y, "ground")
    if not finalCost then return nil end
    return total + finalCost.comparisonSeconds
end

-- Incremental route calculation
local MAX_EXPANSIONS_PER_SLICE = 250
local MAX_MILLISECONDS_PER_SLICE = 2

---@class NavigationRoute
---@field destinationID string
---@field destinationChangeNumber integer
---@field calculationID integer
---@field pathReferences integer[]
---@field pathCosts NavigationCalculatedPathCost[]
---@field finalCost NavigationCalculatedPathCost
---@field comparisonSeconds number
---@field preparedData NavigationPreparedData
---@field originMapID number?
---@field originX number?
---@field originY number?
---@field signature string

---@class NavigationCalculationJob
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
---@field previousPointIndexes table<integer, integer>
---@field previousPathReferences table<integer, integer>
---@field pathCostByReference table<integer, NavigationCalculatedPathCost>
---@field unavailablePathCosts table<integer, string>
---@field originMapID number?
---@field originX number?
---@field originY number?
---@field cancelled boolean
---@field onFinish fun(route: NavigationRoute?, failure: string?)

local calculationNumber = 0

---@class NavigationHeapEntry
---@field pointIndex integer
---@field cost number
---@field costBucket integer
---@field uncertainty number
---@field pathCount integer
---@field previousPointIndex integer?
---@field finalCost NavigationCalculatedPathCost?
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
---@param previousPointIndex integer?
---@param previousPathReference integer?
---@param signature string
local function OfferPoint(job, pointIndex, cost, uncertainty, pathCount,
                          previousPointIndex, previousPathReference, signature)
    local costBucket = GetCostBucket(cost)
    local bestCostBucket = job.bestCostBuckets[pointIndex]
    local isBetter = bestCostBucket == nil or costBucket < bestCostBucket or costBucket == bestCostBucket and
        (uncertainty < job.bestUncertainties[pointIndex] or uncertainty == job.bestUncertainties[pointIndex] and
            (pathCount < job.bestPathCounts[pointIndex] or pathCount == job.bestPathCounts[pointIndex] and
                signature < (job.bestSignatures[pointIndex] or "")))
    if not isBetter then return end
    job.bestCostBuckets[pointIndex] = costBucket
    job.bestUncertainties[pointIndex] = uncertainty
    job.bestPathCounts[pointIndex] = pathCount
    job.bestSignatures[pointIndex] = signature
    job.previousPointIndexes[pointIndex] = previousPointIndex
    job.previousPathReferences[pointIndex] = previousPathReference
    HeapPush(job.heap, {
        pointIndex = pointIndex,
        cost = cost,
        costBucket = costBucket,
        uncertainty = uncertainty,
        pathCount = pathCount,
        signature = signature,
    })
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

---@param job NavigationCalculationJob
---@param destinationEntry NavigationHeapEntry
---@return NavigationRoute
local function BuildRoute(job, destinationEntry)
    ---@type integer[]
    local reverseReferences = {}
    local pointIndex = destinationEntry.previousPointIndex
    while pointIndex do
        local pathReference = job.previousPathReferences[pointIndex]
        if pathReference then table.insert(reverseReferences, pathReference) end
        pointIndex = job.previousPointIndexes[pointIndex]
    end

    local pathReferences = {}
    local pathCosts = {}
    for index = #reverseReferences, 1, -1 do
        local pathReference = reverseReferences[index]
        table.insert(pathReferences, pathReference)
        local pathCost = job.pathCostByReference[pathReference]
        ---@cast pathCost NavigationCalculatedPathCost
        table.insert(pathCosts, pathCost)
    end
    return {
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
    }
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
local function OfferDestination(job, entry)
    local graph = Navigation:GetGraph()
    if not graph or entry.pathCount == 0 then return end
    local destination = job.destinationData
    local finalCost = Navigation:GetPlayerTravelCost(job.preparedData,
        graph.pointMapIDs[entry.pointIndex], graph.pointXs[entry.pointIndex], graph.pointYs[entry.pointIndex],
        destination.mapID, destination.x, destination.y, "automatic")
    if not finalCost then return end
    HeapPush(job.heap, {
        pointIndex = 0,
        cost = entry.cost + finalCost.comparisonSeconds,
        costBucket = GetCostBucket(entry.cost + finalCost.comparisonSeconds),
        uncertainty = entry.uncertainty + finalCost.uncertaintySeconds,
        pathCount = entry.pathCount,
        previousPointIndex = entry.pointIndex,
        finalCost = finalCost,
        signature = entry.signature,
    })
end

---@param job NavigationCalculationJob
---@param entry NavigationHeapEntry
local function ExpandPoint(job, entry)
    local graph = Navigation:GetGraph()
    if not graph then return end
    OfferDestination(job, entry)
    local firstOffset = graph.firstOutgoingPathByPointIndex[entry.pointIndex]
    local count = graph.outgoingPathCountByPointIndex[entry.pointIndex] or 0
    for offset = firstOffset, firstOffset + count - 1 do
        local pathReference = graph.outgoingPathReferences[offset]
        if not job.avoidedPaths[pathReference] and not job.unavailablePathCosts[pathReference] then
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
                    entry.pathCount + 1, entry.pointIndex, pathReference,
                    AddPathToSignature(entry.signature, pathReference))
            end
        end
    end
end

---@param job NavigationCalculationJob
local function AdvanceJob(job)
    if job.cancelled then return end
    local startedAt = debugprofilestop()
    local expansions = 0
    while expansions < MAX_EXPANSIONS_PER_SLICE and debugprofilestop() - startedAt < MAX_MILLISECONDS_PER_SLICE do
        if job.cancelled then return end
        local entry = HeapPop(job.heap)
        if not entry then
            job.onFinish(nil, "no route")
            return
        end
        if entry.pointIndex == 0 then
            job.onFinish(BuildRoute(job, entry))
            return
        end
        if IsCurrentEntry(job, entry) then
            ExpandPoint(job, entry)
            expansions = expansions + 1
        end
    end
    C_Timer.After(0, function()
        AdvanceJob(job)
    end)
end

---@param job NavigationCalculationJob
local function SeedJob(job)
    local graph = Navigation:GetGraph()
    if not graph then return end
    local playerX, playerY, playerMapID = job.originX, job.originY, job.originMapID

    if playerMapID and playerX and playerY then
        local destination = job.destinationData
        local directCost = Navigation:GetPlayerTravelCost(job.preparedData,
            playerMapID, playerX, playerY, destination.mapID, destination.x, destination.y, "automatic")
        if directCost then
            HeapPush(job.heap, {
                pointIndex = 0,
                cost = directCost.comparisonSeconds,
                costBucket = GetCostBucket(directCost.comparisonSeconds),
                uncertainty = directCost.uncertaintySeconds,
                pathCount = 0,
                finalCost = directCost,
                signature = "",
            })
        end

        for pointIndex = 1, #graph.pointIDs do
            local approachCost = Navigation:GetPlayerTravelCost(job.preparedData,
                playerMapID, playerX, playerY, graph.pointMapIDs[pointIndex],
                graph.pointXs[pointIndex], graph.pointYs[pointIndex], "automatic")
            if approachCost then
                OfferPoint(job, pointIndex, approachCost.comparisonSeconds,
                    approachCost.uncertaintySeconds, 0, nil, nil, "")
            end
        end
    end

    -- Current-position actions do not need dungeon map coordinates. They are
    -- the escape route when the player's instance cannot attach to world travel.
    for _, pathReference in ipairs(graph.currentPlayerPathReferences) do
        if not job.avoidedPaths[pathReference] then
            local pathCost = Navigation:GetPathCost(graph, job.preparedData, pathReference)
            if pathCost then
                job.pathCostByReference[pathReference] = pathCost
                OfferPoint(job, graph.pathToPointIndexes[pathReference], pathCost.comparisonSeconds,
                    pathCost.uncertaintySeconds, 1, nil, pathReference,
                    AddPathToSignature("", pathReference))
            end
        end
    end
end

---@param destinationID string
---@param destinationChangeNumber integer
---@param destinationData WayfinderData
---@param avoidedPaths table<integer, NavigationPathFailure>
---@param onFinish fun(route: NavigationRoute?, failure: string?)
---@return NavigationCalculationJob?
function Navigation:StartRouteCalculation(destinationID, destinationChangeNumber, destinationData, avoidedPaths, onFinish)
    local graph = self:GetGraph()
    local preparedData = self:GetPreparedData()
    if not graph or not preparedData then
        onFinish(nil, "navigation data is not ready")
        return nil
    end
    local excludedPaths = {} ---@type table<integer, boolean>
    for pathReference in pairs(avoidedPaths) do excludedPaths[pathReference] = true end
    calculationNumber = calculationNumber + 1
    local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    ---@type NavigationCalculationJob
    local job = {
        calculationID = calculationNumber,
        destinationID = destinationID,
        destinationChangeNumber = destinationChangeNumber,
        destinationData = destinationData,
        preparedData = preparedData,
        avoidedPaths = excludedPaths,
        heap = {},
        bestCostBuckets = {},
        bestUncertainties = {},
        bestPathCounts = {},
        bestSignatures = {},
        previousPointIndexes = {},
        previousPathReferences = {},
        pathCostByReference = {},
        unavailablePathCosts = {},
        originMapID = playerMapID,
        originX = playerX,
        originY = playerY,
        cancelled = false,
        onFinish = onFinish,
    }
    SeedJob(job)
    C_Timer.After(0, function()
        AdvanceJob(job)
    end)
    return job
end

---@param job NavigationCalculationJob?
function Navigation:CancelRouteCalculation(job)
    if job then job.cancelled = true end
end
