---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Options = MapPinEnhanced:GetModule("Options")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@alias NavigationDestinationRemoval fun(owner: string, destinationID: string, changeNumber: integer)

---@class NavigationDestination
---@field owner string
---@field destinationID string
---@field changeNumber integer
---@field data WayfinderData
---@field routingData WayfinderData
---@field removeDestination NavigationDestinationRemoval?

---@class NavigationProgression
---@field route NavigationRoute
---@field pathIndex integer
---@field phase "approach"|"ready"|"in-transit"
---@field changeNumber integer
---@field closestDistance number?
---@field movingAwayStartedAt number?
---@field status string?
---@field attempted boolean?
---@field pathUnavailable boolean?
---@field lastDeviationCalculationAt number?

---@class NavigationRouteLayerEntry
---@field frame MapPinEnhancedNavigationMapPinTemplate
---@field isWorldMap boolean

---@class NavigationPathFailure
---@field kind "action"|"taxi"
---@field reason string

---@class Navigation
---@field destinationChangeNumber integer
---@field avoidedPaths table<integer, NavigationPathFailure>
---@field activeDestination NavigationDestination?
---@field activeCalculation NavigationCalculationJob?
---@field pendingCalculationRestart fun()?
---@field progression NavigationProgression?
---@field unsubscribeEligibilityRefresh fun()?
---@field lastCalculationFailure string?
---@field lastCalculationExclusions string[]?
---@field routeMapFramePool FramePoolCollection<MapPinEnhancedNavigationMapPinTemplate>?
---@field routeSteps table<integer, NavigationStep>
local Navigation = MapPinEnhanced:GetModule("Navigation")

local DEVIATION_RECALCULATION_COOLDOWN = 15
local presentationChangeNumber = 0

---@param pathType string
---@param fromMapID number?
---@param toMapID number
---@return boolean
local function RequiresDestinationMap(pathType, fromMapID, toMapID)
    return pathType == "floor" or
        (pathType == "portal" or pathType == "localportal" or pathType == "gossip") and fromMapID ~= toMapID
end

Navigation.destinationChangeNumber = Navigation.destinationChangeNumber or 0
Navigation.avoidedPaths = Navigation.avoidedPaths or {}

---@param data WayfinderData
---@return WayfinderData
local function CopyWayfinderData(data)
    return {
        mapID = data.mapID,
        x = data.x,
        y = data.y,
        title = data.title,
        description = data.description,
        texture = data.texture,
        usesAtlas = data.usesAtlas,
        color = data.color,
        lock = data.lock,
        targetType = data.targetType,
        mapDistanceOnly = data.mapDistanceOnly,
    }
end

---@param data WayfinderData
---@return WayfinderData
local function CopyRoutingData(data)
    local copy = CopyWayfinderData(data)
    local hbd = MapPinEnhanced.HBD
    if not hbd or not C_Map.GetMapInfoAtPosition or type(copy.mapID) ~= "number" or
        type(copy.x) ~= "number" or type(copy.y) ~= "number" then
        return copy
    end
    local mapInfo = C_Map.GetMapInfo(copy.mapID)
    while mapInfo and mapInfo.mapType <= Enum.UIMapType.Continent do
        local child = C_Map.GetMapInfoAtPosition(copy.mapID, copy.x, copy.y)
        if not child or child.mapID == copy.mapID or child.mapType <= mapInfo.mapType then break end
        local x, y = hbd:TranslateZoneCoordinates(copy.x, copy.y, copy.mapID, child.mapID)
        if type(x) ~= "number" or type(y) ~= "number" or
            not (x >= 0 and x <= 1 and y >= 0 and y <= 1) then
            break
        end
        copy.mapID, copy.x, copy.y = child.mapID, x, y
        mapInfo = child
    end
    return copy
end

---@param destination NavigationDestination
---@return boolean
local function IsCurrentDestination(destination)
    return Navigation.activeDestination == destination
end

---@param route NavigationRoute
---@return boolean
local function HasRouteOrigin(route)
    return route.originMapID ~= nil and route.originX ~= nil and route.originY ~= nil
end

---@return boolean started
local function RefreshRouteOrigin()
    local progression = Navigation.progression
    if not progression or progression.attempted or
        progression.phase == "in-transit" or Navigation.activeCalculation or Navigation.pendingCalculationRestart or
        not Navigation.routeNavigationEnabled then
        return false
    end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then return false end
    local route = progression.route
    if HasRouteOrigin(route) then
        local reference = route.pathReferences[progression.pathIndex]
        if progression.pathIndex ~= 1 or mapID == route.originMapID or not reference or
            route.graph.pathFromPointIndexes[reference] then
            return false
        end
    end
    -- Loading can temporarily report a parent map. An unstarted escape action
    -- must compete again once the actual zone and its nearby exits are known.
    Navigation:RefreshPreparedData()
    Navigation:StartCalculation(true)
    return true
end

---@param route NavigationRoute
---@return integer
local function GetRouteStepCount(route)
    return #route.pathReferences + 1
end

---@param progression NavigationProgression
---@return integer
local function GetProgressionPathReference(progression)
    return progression.route.pathReferences[progression.pathIndex] or 0
end

---@param destination NavigationDestination
---@return string
local function GetDestinationTitle(destination)
    local title = destination.data.title
    if type(title) == "string" and title ~= "" then return title end
    local mapInfo = C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(destination.data.mapID)
    return mapInfo and mapInfo.name or destination.destinationID
end

---@param removeOnArrival boolean
---@param fallbackInstruction string?
---@param fallbackPhase string?
function Navigation:ApplyDirectDestination(removeOnArrival, fallbackInstruction, fallbackPhase)
    local destination = self.activeDestination
    if not destination then return end
    self:DeactivatePathHandler()
    self:ReleaseRouteLayers()
    local phase = fallbackPhase or "direct"
    presentationChangeNumber = presentationChangeNumber + 1
    self:ApplyStepPresentation(destination.routingData, removeOnArrival and function()
        self:CompleteFinalDestination(destination)
    end or nil, {
        changeNumber = presentationChangeNumber,
        arrivalIdentity = string.format("%d:direct:%s", destination.changeNumber, tostring(removeOnArrival)),
        showDirection = not self.routeNavigationEnabled or phase ~= "no-direction" and self:CanGuideDirectly(),
        showInstruction = self.routeNavigationEnabled == true,
        phase = phase,
        instruction = fallbackInstruction or destination.data.title or "",
    })
end

---@param destination NavigationDestination
function Navigation:CompleteFinalDestination(destination)
    if not IsCurrentDestination(destination) or destination.data.lock then return end
    local progression = self.progression
    if progression and progression.route.pathReferences[progression.pathIndex] then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then return end
    local data = destination.routingData
    local distance = self:GetComparableDistance(mapID, x, y, data.mapID, data.x, data.y)
    if not distance or distance > 50 then return end
    local removeDestination = destination.removeDestination
    destination.removeDestination = nil
    if removeDestination then
        removeDestination(destination.owner, destination.destinationID, destination.changeNumber)
    end
end

---@param currentRouteUnusable boolean?
function Navigation:StartCalculation(currentRouteUnusable)
    local destination = self.activeDestination
    if not destination or not self.routeNavigationEnabled or self:IsTaxiBookingPending() then return end
    destination.routingData = CopyRoutingData(destination.data)
    self:CancelRouteCalculation(self.activeCalculation)
    self.lastCalculationFailure = nil
    self.lastCalculationExclusions = nil
    local previousProgression = self.progression
    if not previousProgression then
        self:ApplyDirectDestination(false, L["Navigation Calculating"], "calculating")
    end
    local expectedDestination = destination
    self.activeCalculation = self:StartRouteCalculation(destination.destinationID, destination.changeNumber,
        destination.routingData, self.avoidedPaths,
        ---@async
        function(route, failure, checkpoint)
            if not IsCurrentDestination(expectedDestination) then return end
            local prepared = self:AwaitPreparedData(checkpoint)
            local finishedCalculation = self.activeCalculation
            local currentRemainingCost ---@type number?
            if previousProgression and self:IsCurrentProgression(previousProgression) and
                not currentRouteUnusable and prepared then
                currentRemainingCost = self:GetRemainingRouteCost(previousProgression, prepared, checkpoint)
                currentRouteUnusable = currentRemainingCost == nil
            end
            if not route then
                -- Login data or failure recovery may change eligibility while
                -- this job uses its frozen snapshot. Retry if no usable Route remains.
                if (not previousProgression or currentRouteUnusable) and finishedCalculation and
                    finishedCalculation.preparedData ~= prepared then
                    self:StartCalculation(true)
                    return
                end
                self.lastCalculationFailure = failure or "route calculation failed"
                local reasonCounts = {} ---@type table<string, integer>
                if finishedCalculation then
                    for _, reason in pairs(finishedCalculation.unavailablePathCosts) do
                        reasonCounts[reason] = (reasonCounts[reason] or 0) + 1
                        checkpoint()
                    end
                end
                local exclusions = {}
                for reason, count in pairs(reasonCounts) do
                    table.insert(exclusions, string.format("%s (%d)", reason, count))
                end
                table.sort(exclusions)
                self.lastCalculationExclusions = exclusions
                if currentRouteUnusable or not previousProgression then
                    self.progression = nil
                    local canGuideDirectly = self:CanGuideDirectly()
                    self:ApplyDirectDestination(canGuideDirectly, canGuideDirectly and
                        L["Navigation Direct Guidance"] or L["Navigation No Direction"],
                        canGuideDirectly and "direct" or "no-direction")
                end
                return
            end
            if route.preparedData.taxiObservation ~= self:GetTaxiObservation() then
                self:StartCalculation(currentRouteUnusable)
                return
            end
            if prepared and route.preparedData ~= prepared then
                for _, reference in ipairs(route.pathReferences) do
                    checkpoint()
                    if reference > 0 and prepared.requirementStateByPath[reference] ~= "satisfied" then
                        self:StartCalculation(currentRouteUnusable)
                        return
                    end
                    local journey = route.taxiJourneys[reference]
                    if journey and not self:IsTaxiJourneyEligible(journey, prepared) then
                        self:StartCalculation(currentRouteUnusable)
                        return
                    end
                end
            end
            local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
            if mapID and x and y and (not HasRouteOrigin(route) or mapID ~= route.originMapID) then
                self:RefreshPreparedData()
                self:StartCalculation(currentRouteUnusable)
                return
            end
            -- Preserve the replacement threshold after the sliced remaining-cost check.
            if currentRemainingCost then
                local requiredSavings = math.max(15, currentRemainingCost * 0.1)
                if currentRemainingCost - route.comparisonSeconds < requiredSavings then return end
            end
            if finishedCalculation then
                route.calculationSeconds = GetTimePreciseSec() - finishedCalculation.startedAt
                route.calculationSlices = finishedCalculation.calculationSlices
            end
            self:DeactivatePathHandler()
            local graph = route.graph
            self.progression = {
                route = route,
                pathIndex = 1,
                phase = route.pathReferences[1] and graph and
                    graph.pathFromPointIndexes[route.pathReferences[1]] and "approach" or
                    route.pathReferences[1] and "ready" or "approach",
                changeNumber = 1,
            }
            self:PublishStep(self.progression)
        end, function()
            if IsCurrentDestination(expectedDestination) then self:StartCalculation(currentRouteUnusable) end
        end)
end

---@param owner string
---@param destinationID string
---@param destinationData WayfinderData
---@param removeDestination NavigationDestinationRemoval?
---@return integer changeNumber
function Navigation:SetDestination(owner, destinationID, destinationData, removeDestination)
    assert(type(owner) == "string" and owner ~= "", "Navigation:SetDestination: owner must be a non-empty string")
    assert(type(destinationID) == "string" and destinationID ~= "",
        "Navigation:SetDestination: destinationID must be a non-empty string")
    assert(type(destinationData) == "table", "Navigation:SetDestination: destinationData must be a table")
    assert(removeDestination == nil or type(removeDestination) == "function",
        "Navigation:SetDestination: removeDestination must be a function or nil")
    local active = self.activeDestination
    local old = active and active.data
    if active and old and active.owner == owner and active.destinationID == destinationID and
        old.mapID == destinationData.mapID and old.x == destinationData.x and old.y == destinationData.y and
        old.texture == destinationData.texture and old.usesAtlas == destinationData.usesAtlas and
        old.color == destinationData.color and old.lock == destinationData.lock and
        old.targetType == destinationData.targetType and
        old.mapDistanceOnly == destinationData.mapDistanceOnly then
        self:UpdateDestinationText(owner, destinationID, active.changeNumber,
            destinationData.title or "", destinationData.description)
        return active.changeNumber
    end
    self:CancelRouteCalculation(self.activeCalculation)
    self:DeactivatePathHandler()
    self.destinationChangeNumber = self.destinationChangeNumber + 1
    self.activeDestination = {
        owner = owner,
        destinationID = destinationID,
        changeNumber = self.destinationChangeNumber,
        data = CopyWayfinderData(destinationData),
        routingData = CopyRoutingData(destinationData),
        removeDestination = removeDestination,
    }
    self.avoidedPaths = {}
    self.progression = nil
    if self.routeNavigationEnabled then
        self:StartCalculation(true)
    else
        self:ApplyDirectDestination(true)
    end
    return self.destinationChangeNumber
end

---@param owner string
---@param destinationID string
---@param changeNumber integer
---@param destinationData WayfinderData
---@return integer?
function Navigation:UpdateDestination(owner, destinationID, changeNumber, destinationData)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return nil end
    local removeDestination = self.activeDestination and self.activeDestination.removeDestination or nil
    return self:SetDestination(owner, destinationID, destinationData, removeDestination)
end

---@param owner string
---@param destinationID string
---@param changeNumber integer
---@param title string
---@param description string?
function Navigation:UpdateDestinationText(owner, destinationID, changeNumber, title, description)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return end
    local destination = self.activeDestination
    if not destination or destination.data.title == title and destination.data.description == description then return end
    destination.data.title = title
    destination.data.description = description
    destination.routingData.title = title
    destination.routingData.description = description
    for _, step in pairs(self.routeSteps) do
        if step.info then step.info.destinationTitle = title end
        if step.target then
            step.target.title, step.target.description = title, description
        end
    end
    -- Only replace the display copy: jobs, progression, handlers, and consumed
    -- arrival callbacks remain owned by their existing lifecycle.
    Wayfinders:UpdateDestinationText(title, description)
end

---@param owner string
---@param destinationID string?
---@param changeNumber integer?
---@return boolean
function Navigation:IsDestinationActive(owner, destinationID, changeNumber)
    local destination = self.activeDestination
    if not destination or destination.owner ~= owner then return false end
    if destinationID and destination.destinationID ~= destinationID then return false end
    if changeNumber and destination.changeNumber ~= changeNumber then return false end
    return true
end

---@return string? owner
---@return string? destinationID
---@return integer changeNumber
function Navigation:GetActiveDestinationState()
    local destination = self.activeDestination
    if not destination then return nil, nil, self.destinationChangeNumber end
    return destination.owner, destination.destinationID, destination.changeNumber
end

---@param owner string
---@param destinationID string?
---@param changeNumber integer?
---@return boolean
function Navigation:ClearDestination(owner, destinationID, changeNumber)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return false end
    self:CancelRouteCalculation(self.activeCalculation)
    self:DeactivatePathHandler()
    self.activeCalculation = nil
    self.activeDestination = nil
    self:CancelPreparedData()
    self.progression = nil
    self.avoidedPaths = {}
    self.destinationChangeNumber = self.destinationChangeNumber + 1
    presentationChangeNumber = presentationChangeNumber + 1
    self:ReleaseRouteLayers()
    Wayfinders:ClearPresentation()
    return true
end

---@param changeNumber integer?
---@return boolean
function Navigation:Recalculate(changeNumber)
    changeNumber = changeNumber or presentationChangeNumber
    if changeNumber ~= presentationChangeNumber or not self.activeDestination or not self.routeNavigationEnabled then
        return false
    end
    self:RefreshPreparedData()
    self:StartCalculation()
    return true
end

function Navigation:RefreshHearthstoneRoute()
    self:CancelRouteCalculation(self.activeCalculation)
    self.activeCalculation = nil
    self:DeactivatePathHandler()
    self.progression = nil
    self:ReleaseRouteLayers()
    if self.activeDestination and self.routeNavigationEnabled then self:StartCalculation(true) end
end

---@param progression NavigationProgression
local function ResetDeviationState(progression)
    progression.closestDistance = nil
    progression.movingAwayStartedAt = nil
end

local CHAT_PATH_INSTRUCTIONS = {
    walk = "Navigation Chat Walk To",
    fly = "Navigation Chat Fly To",
    border = "Navigation Chat Travel To",
    floor = "Navigation Chat Change Floor To",
    gossip = "Navigation Chat Talk To NPC",
    phaseswitch = "Navigation Chat Change Phase To",
}

---@param pathType string
---@param location string
---@return string
local function GetChatInstruction(pathType, location)
    local key = CHAT_PATH_INSTRUCTIONS[pathType]
    if key then return string.format(L[key], location) end
    return string.format(L["Navigation Chat Use To"],
        MapPinEnhanced:CompactChatLabel(Navigation:GetPathMethod(pathType), 24), location)
end

---@param changeNumber integer
---@return string[]? steps
---@return {mapID: number, x: number, y: number, header: string}? destination
function Navigation:GetRouteChatSteps(changeNumber)
    local progression = self.progression
    local destination = self.activeDestination
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    if changeNumber ~= presentationChangeNumber or not progression or not destination or not graph then return nil end

    ---@type string[]
    local steps = {}
    for index = progression.pathIndex, #progression.route.pathReferences do
        local reference = progression.route.pathReferences[index]
        local mapID = graph.pointMapIDs[graph.pathToPointIndexes[reference]]
        local info = C_Map.GetMapInfo(mapID)
        local journey = progression.route.taxiJourneys[reference]
        steps[#steps + 1] = GetChatInstruction(graph.pathTypes[reference],
            MapPinEnhanced:CompactChatLabel(journey and journey.destinationName or info and info.name or tostring(mapID),
                80))
    end
    local data = destination.data
    local info = C_Map.GetMapInfo(data.mapID)
    ---@type string?
    local mode = progression.route.finalCost.explanation and progression.route.finalCost.explanation.mode
    local isFlying = mode == "steady-flight" or mode == "skyriding"
    steps[#steps + 1] = GetChatInstruction(isFlying and "fly" or "walk",
        MapPinEnhanced:CompactChatLabel(info and info.name or tostring(data.mapID), 80))
    return steps, {
        mapID = data.mapID,
        x = data.x,
        y = data.y,
        header = string.format(MapPinEnhanced.displayName .. L[" route To"],
            MapPinEnhanced:CompactChatLabel(GetDestinationTitle(destination), 64),
            MapPinEnhanced:CompactChatLabel(info and info.name or tostring(data.mapID), 80)),
    }
end

---@param progression NavigationProgression
---@param graph NavigationGraph
---@return string
local function GetCurrentPathInstruction(progression, graph)
    local pathIndex = progression.pathIndex
    local pathReference = progression.route.pathReferences[pathIndex]
    local pathType = graph.pathTypes[pathReference]
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    -- Portal wording names the action while progression still guides to its entrance.
    if pathType == "portal" or pathType == "localportal" then
        return Navigation:GetPathInstruction(pathType, graph.pointMapIDs[toPointIndex])
    end
    if progression.phase == "approach" and fromPointIndex and
        not Navigation:IsMovementPath(pathType) then
        return string.format(L["Navigation Approach Method"], Navigation:GetPathMethod(pathType))
    end
    if Navigation:IsMovementPath(pathType) then
        local nextPathReference = progression.route.pathReferences[pathIndex + 1]
        if nextPathReference then
            local nextPathType = graph.pathTypes[nextPathReference]
            if nextPathType == "portal" or nextPathType == "localportal" then
                local portalDestinationIndex = graph.pathToPointIndexes[nextPathReference]
                return Navigation:GetPathInstruction(nextPathType, graph.pointMapIDs[portalDestinationIndex])
            end
            return string.format(L["Navigation Continue To Method"],
                Navigation:GetPathMethod(nextPathType))
        end
        local mapInfo = toPointIndex and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(graph.pointMapIDs[toPointIndex])
        if mapInfo and type(mapInfo.name) == "string" and mapInfo.name ~= "" then
            return string.format(L["Navigation Approach"], mapInfo.name)
        end
    end
    local journey = progression.route.taxiJourneys[pathReference]
    if journey and journey.destinationName then
        return string.format(L["Navigation Take Flight To"], journey.destinationName)
    end
    return Navigation:GetPathInstruction(pathType, graph.pointMapIDs[toPointIndex])
end

---@param progression NavigationProgression
---@return boolean
function Navigation:IsCurrentProgression(progression)
    return self.progression == progression and self.activeDestination ~= nil and
        progression.route.destinationChangeNumber == self.activeDestination.changeNumber
end

---@class NavigationStepIdentity
---@field destinationID string
---@field destinationChangeNumber integer
---@field calculationID integer
---@field pathReference integer
---@field pathIndex integer
---@field progressionChangeNumber integer

---@param progression NavigationProgression?
---@return NavigationStepIdentity?
function Navigation:CaptureStepIdentity(progression)
    progression = progression or self.progression
    local destination = self.activeDestination
    if not progression or not destination or not self:IsCurrentProgression(progression) then return nil end
    local pathReference = GetProgressionPathReference(progression)
    return {
        destinationID = destination.destinationID,
        destinationChangeNumber = destination.changeNumber,
        calculationID = progression.route.calculationID,
        pathReference = pathReference,
        pathIndex = progression.pathIndex,
        progressionChangeNumber = progression.changeNumber,
    }
end

---@param identity NavigationStepIdentity?
---@return boolean
function Navigation:IsStepIdentityCurrent(identity)
    if not identity then return false end
    local progression = self.progression
    local destination = self.activeDestination
    return progression ~= nil and destination ~= nil and self:IsCurrentProgression(progression) and
        identity.destinationID == destination.destinationID and
        identity.destinationChangeNumber == destination.changeNumber and
        identity.calculationID == progression.route.calculationID and
        identity.pathReference == GetProgressionPathReference(progression) and
        identity.pathIndex == progression.pathIndex and
        identity.progressionChangeNumber == progression.changeNumber
end

---@param progression NavigationProgression
---@param graph NavigationGraph
---@return WayfinderProgressEntry[]
local function CopyRouteProgress(progression, graph)
    local entries = {} ---@type WayfinderProgressEntry[]
    local destination = Navigation.activeDestination
    if not destination then return entries end
    local route = progression.route
    for index = 1, GetRouteStepCount(route) do
        local reference = route.pathReferences[index]
        local point = reference and graph.pathToPointIndexes[reference]
        local mode = route.finalCost.explanation and route.finalCost.explanation.mode
        local pathType = reference and graph.pathTypes[reference] or
            ((mode == "steady-flight" or mode == "skyriding") and "fly" or "walk")
        local mapID = point and graph.pointMapIDs[point] or destination.routingData.mapID
        local x = point and graph.pointXs[point] or destination.routingData.x
        local y = point and graph.pointYs[point] or destination.routingData.y
        local mapInfo = C_Map.GetMapInfo(mapID)
        local color = Navigation.PATH_COLORS[pathType] or Navigation.DEFAULT_PATH_COLOR
        local r, g, b = color:GetRGB()
        local journey = reference and route.taxiJourneys[reference]
        entries[index] = {
            r = r,
            g = g,
            b = b,
            title = string.format(L["Navigation Step Number"], index, Navigation:GetPathMethod(pathType)),
            instruction = journey and journey.destinationName and
                string.format(L["Navigation Take Flight To"], journey.destinationName) or
                (reference and Navigation:GetPathInstruction(pathType, mapID) or
                    string.format(L[pathType == "fly" and "Navigation Fly To Destination" or
                    "Navigation Travel To Destination"], GetDestinationTitle(destination))),
            location = string.format("%s (%.1f, %.1f)", mapInfo and mapInfo.name or tostring(mapID), x * 100, y * 100),
        }
    end
    return entries
end

---@param progression NavigationProgression
function Navigation:PublishStep(progression)
    if not self:IsCurrentProgression(progression) then return end
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    if not graph then return end
    local pathReference = progression.route.pathReferences[progression.pathIndex]
    presentationChangeNumber = presentationChangeNumber + 1
    local arrivalIdentity = string.format("%d:%d:%s", progression.route.calculationID,
        progression.pathIndex, progression.phase)
    if not pathReference then
        local destination = self.activeDestination
        if not destination then return end
        self:DeactivatePathHandler()
        ---@type string?
        local mode = progression.route.finalCost.explanation and progression.route.finalCost.explanation.mode
        local isFlying = mode == "steady-flight" or mode == "skyriding"
        local instructionKey = isFlying and "Navigation Fly To Destination" or "Navigation Travel To Destination"
        self:ApplyStepPresentation(destination.routingData, function()
            self:CompleteFinalDestination(destination)
        end, {
            changeNumber = presentationChangeNumber,
            arrivalIdentity = arrivalIdentity,
            showDirection = true,
            showInstruction = not isFlying,
            phase = "approach",
            stepIndex = progression.pathIndex,
            stepCount = GetRouteStepCount(progression.route),
            progressEntries = CopyRouteProgress(progression, graph),
            instruction = string.format(L[instructionKey], GetDestinationTitle(destination)),
            status = progression.status,
        })
        return
    end

    local pathType = graph.pathTypes[pathReference]
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    local targetPointIndex = toPointIndex
    ---@type WayfinderTargetArrival?
    local onArrival

    if not self:IsMovementPath(pathType) and progression.phase == "approach" and fromPointIndex then
        targetPointIndex = fromPointIndex
        onArrival = function()
            if not self:IsCurrentProgression(progression) then return end
            self:ApplyProgressionPhase(progression, "ready")
        end
    elseif self:IsMovementPath(pathType) or
        progression.phase == "in-transit" and pathType ~= "phaseswitch" and pathType ~= "flighttaxi" then
        onArrival = function()
            self:CompleteCurrentPath(progression)
        end
    elseif pathType ~= "floor" and (progression.phase ~= "in-transit" or pathType ~= "flighttaxi") then
        targetPointIndex = fromPointIndex or toPointIndex
    end

    local destination = self.activeDestination
    if not destination then return end
    local travelIcon = self:GetPathIcon(pathType)
    local desiredAction = progression.phase == "ready" and not progression.pathUnavailable and
        self:GetPathAction(pathType, graph.pathRequirements[pathReference]) or nil
    local targetData = CopyWayfinderData(destination.data)
    targetData.mapID = graph.pointMapIDs[targetPointIndex]
    targetData.x = graph.pointXs[targetPointIndex]
    targetData.y = graph.pointYs[targetPointIndex]
    targetData.texture = travelIcon
    -- BasePin resolves this PIN_ICONS key and owns its custom artwork and style.
    targetData.usesAtlas = false
    -- Waiting Steps have no arrival callback; a destination lock is not Step state.
    targetData.lock = false
    targetData.mapDistanceOnly = true
    self:ApplyStepPresentation(targetData, onArrival, {
        changeNumber = presentationChangeNumber,
        arrivalIdentity = arrivalIdentity,
        -- Entrance proximity readies an interaction; its marker stays until use.
        showDirection = desiredAction == nil and
            (progression.phase == "approach" or progression.phase == "ready"),
        phase = progression.phase,
        arrivalMapID = progression.phase == "in-transit" and
            RequiresDestinationMap(pathType, fromPointIndex and graph.pointMapIDs[fromPointIndex],
                graph.pointMapIDs[toPointIndex]) and graph.pointMapIDs[toPointIndex] or nil,
        stepIndex = progression.pathIndex,
        stepCount = GetRouteStepCount(progression.route),
        progressEntries = CopyRouteProgress(progression, graph),
        instruction = GetCurrentPathInstruction(progression, graph),
        status = progression.status,
        desiredAction = desiredAction,
    })
    local identity = self:CaptureStepIdentity(progression)
    if identity then
        self:ActivatePathHandler({
            pathType = pathType,
            pathReference = pathReference,
            phase = progression.phase,
            requirement = graph.pathRequirements[pathReference],
            data = graph.pathHandlerData[pathReference],
            taxiJourney = progression.route.taxiJourneys[pathReference],
        }, function(result, detail)
            self:HandlePathHandlerReport(identity, result, detail)
        end)
    end
end

---@param progression NavigationProgression
function Navigation:CompleteCurrentPath(progression)
    if not self:IsCurrentProgression(progression) then return end
    -- A pending job priced the old Step and must not replace completed progress.
    self:CancelRouteCalculation(self.activeCalculation)
    self.activeCalculation = nil
    self:DeactivatePathHandler()
    progression.pathIndex = progression.pathIndex + 1
    progression.changeNumber = progression.changeNumber + 1
    progression.status = nil
    progression.attempted = nil
    progression.pathUnavailable = nil
    ResetDeviationState(progression)
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    local nextReference = progression.route.pathReferences[progression.pathIndex]
    if not graph then return end
    progression.phase = nextReference and graph.pathFromPointIndexes[nextReference] and "approach" or
        nextReference and "ready" or "approach"
    self:PublishStep(progression)
end

---@param progression NavigationProgression
---@param phase "approach"|"ready"|"in-transit"
---@param status string?
function Navigation:ApplyProgressionPhase(progression, phase, status)
    if not self:IsCurrentProgression(progression) then return end
    -- Arrival or a started action supersedes a calculation from its approach.
    self:CancelRouteCalculation(self.activeCalculation)
    self.activeCalculation = nil
    progression.phase = phase
    progression.status = status
    progression.changeNumber = progression.changeNumber + 1
    ResetDeviationState(progression)
    self:PublishStep(progression)
end

---@param identity NavigationStepIdentity?
function Navigation:CheckCurrentPathCompletion(identity)
    local progression = self.progression
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    if not progression or not graph or not self:IsCurrentProgression(progression) then return end
    if identity and not self:IsStepIdentityCurrent(identity) then return end
    local pathReference = progression.route.pathReferences[progression.pathIndex]
    if not pathReference then return end
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    local pathType = graph.pathTypes[pathReference]
    local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    if not playerMapID or not playerX or not playerY then return end
    local destinationDistance = self:GetComparableDistance(playerMapID, playerX, playerY,
        graph.pointMapIDs[toPointIndex], graph.pointXs[toPointIndex], graph.pointYs[toPointIndex])
    if self:IsMovementPath(graph.pathTypes[pathReference]) then
        if destinationDistance == nil then self:StartCalculation(false) end
        return
    end
    if graph.pathTypes[pathReference] == "phaseswitch" or graph.pathTypes[pathReference] == "flighttaxi" then return end
    if destinationDistance and destinationDistance <= 100 and
        (not RequiresDestinationMap(pathType, fromPointIndex and graph.pointMapIDs[fromPointIndex],
            graph.pointMapIDs[toPointIndex]) or playerMapID == graph.pointMapIDs[toPointIndex]) then
        if pathType == "floor" and fromPointIndex and
            graph.pointMapIDs[fromPointIndex] ~= graph.pointMapIDs[toPointIndex] then
            -- Floors can overlap in world XY. Destination-map exit proximity
            -- proves the crossing without a second pin-arrival pass.
            self:CompleteCurrentPath(progression)
            return
        end
        local requiresObservedAttempt = self:GetPathAction(pathType,
            graph.pathRequirements[pathReference]) ~= nil
        if not requiresObservedAttempt or progression.attempted then
            if progression.phase ~= "in-transit" then
                self:ApplyProgressionPhase(progression, "in-transit", L["Navigation Arrival Confirming"])
            end
        end
        return
    end

    if not fromPointIndex then return end
    local originDistance = self:GetComparableDistance(playerMapID, playerX, playerY,
        graph.pointMapIDs[fromPointIndex], graph.pointXs[fromPointIndex], graph.pointYs[fromPointIndex])
    if not originDistance and progression.phase ~= "approach" and
        not self.activeCalculation and not self.pendingCalculationRestart then
        self:StartCalculation(false)
    elseif progression.phase == "approach" and not originDistance and not destinationDistance and
        not self.activeCalculation and not self.pendingCalculationRestart then
        self:StartCalculation(false)
    end
end

---@return boolean
function Navigation:CanGuideDirectly()
    local destination = self.activeDestination
    if not destination then return false end
    if type(destination.routingData.mapID) ~= "number" or type(destination.routingData.x) ~= "number" or
        type(destination.routingData.y) ~= "number" then
        return false
    end
    local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    if not playerMapID or not playerX or not playerY then return false end
    local preparedData = { movement = self:GetMovementCapabilities() }
    return self:GetPlayerTravelCost(preparedData, playerMapID, playerX, playerY, destination.routingData.mapID,
        destination.routingData.x, destination.routingData.y, "automatic") ~= nil
end

---@param distance number
---@param _timeToTarget number
---@param _closingSpeed number
---@param _nextUpdateInterval number
---@param movementState DistanceMovementState
function Navigation:OnDistanceSample(distance, _timeToTarget, _closingSpeed, _nextUpdateInterval, movementState)
    if RefreshRouteOrigin() then return end
    local progression = self.progression
    if not progression or not self:IsCurrentProgression(progression) then return end
    local reference = progression.route.pathReferences[progression.pathIndex]
    if reference and not self:IsMovementPath(progression.route.graph.pathTypes[reference]) then
        local changeNumber = progression.changeNumber
        -- Arrival at a stop or a floor exit need not produce a zone event.
        self:CheckCurrentPathCompletion()
        if progression.changeNumber ~= changeNumber then return end
    end
    if progression.phase ~= "approach" then return end
    progression.closestDistance = math.min(progression.closestDistance or distance, distance)
    if movementState ~= "movingAway" then
        progression.movingAwayStartedAt = nil
        return
    end
    progression.movingAwayStartedAt = progression.movingAwayStartedAt or GetTime()
    if GetTime() - progression.movingAwayStartedAt < 3 then return end
    if distance - progression.closestDistance < 50 then return end
    local now = GetTime()
    if progression.lastDeviationCalculationAt and
        now - progression.lastDeviationCalculationAt < DEVIATION_RECALCULATION_COOLDOWN then
        return
    end
    progression.movingAwayStartedAt = nil
    progression.lastDeviationCalculationAt = now
    self:StartCalculation(false)
end

-- Handler results and eligibility events

---@param identity NavigationStepIdentity
---@param result "check-completion"|"attempted"|"completed"|"failed"
---@param detail string?
function Navigation:HandlePathHandlerReport(identity, result, detail)
    if not self:IsStepIdentityCurrent(identity) then return end
    local progression = self.progression
    if not progression then return end
    if result == "check-completion" then
        self:CheckCurrentPathCompletion(identity)
    elseif result == "attempted" then
        progression.attempted = true
        self:ApplyProgressionPhase(progression, "in-transit", detail or L["Navigation Action Started"])
    elseif result == "completed" then
        self:CompleteCurrentPath(progression)
    elseif result == "failed" then
        local graph = self.progression and self.progression.route.graph or self:GetGraph()
        local pathReference = progression.route.pathReferences[progression.pathIndex]
        local pathType = graph and pathReference and graph.pathTypes[pathReference]
        local kind = pathType == "flighttaxi" and "taxi" or
            (pathType == "spell" or pathType == "item" or pathType == "toy" or
                pathType == "hearthstone" or pathType == "unboundteleport") and "action" or nil
        local pathCost ---@type NavigationCalculatedPathCost?
        local failure ---@type string?
        if pathReference and kind then pathCost, failure = self:GetFreshPathCost(pathReference) end
        -- A failed cast alone can mean range or interruption. Only a fresh
        -- unavailable Path adds an exclusion; ordinary interruptions stay retryable.
        if pathReference and kind and not pathCost then
            self.avoidedPaths[pathReference] = { kind = kind, reason = failure or detail or "path unavailable" }
            progression.pathUnavailable = true
            progression.status = L["Navigation Finding Another Route"]
        else
            progression.status = detail or L["Navigation Action Failed"]
        end
        self:CancelRouteCalculation(self.activeCalculation)
        progression.changeNumber = progression.changeNumber + 1
        self:PublishStep(progression)
        if progression.pathUnavailable then self:StartCalculation(true) end
    end
end

---@param kind "action"|"taxi"
function Navigation:RecheckFailedPaths(kind)
    local recovered = false
    for pathReference, failure in pairs(self.avoidedPaths) do
        if failure.kind == kind and self:GetFreshPathCost(pathReference) then
            self.avoidedPaths[pathReference] = nil
            recovered = true
        end
    end
    if not recovered then return end
    -- Recovery invalidates pending work; usable Routes keep their presentation.
    -- An already queued restart waits for the complete preparation snapshot.
    self:InvalidatePreparedData()
    if self.activeDestination and self.routeNavigationEnabled and not self.progression and
        not self.activeCalculation and not self.pendingCalculationRestart then
        self:StartCalculation(true)
    end
end

local ELIGIBILITY_EVENTS = {
    "ACHIEVEMENT_EARNED",
    "AREA_POIS_UPDATED",
    "BAG_UPDATE_DELAYED",
    "CONTRIBUTION_CHANGED",
    "CONTRIBUTION_COLLECTOR_UPDATE",
    "CONTRIBUTION_COLLECTOR_UPDATE_SINGLE",
    "COVENANT_CHOSEN",
    "CRITERIA_UPDATE",
    "GARRISON_UPDATE",
    "LOADING_SCREEN_DISABLED",
    "MAP_EXPLORATION_UPDATED",
    "NEW_TOY_ADDED",
    "PLAYER_ENTERING_WORLD",
    "PLAYER_LEVEL_UP",
    "PLAYER_REGEN_DISABLED",
    "PLAYER_REGEN_ENABLED",
    "PLAYER_SPECIALIZATION_CHANGED",
    "PLAYER_TALENT_UPDATE",
    "QUEST_ACCEPTED",
    "QUEST_LOG_UPDATE",
    "QUEST_REMOVED",
    "QUEST_TURNED_IN",
    "SKILL_LINES_CHANGED",
    "SPELLS_CHANGED",
    "TAXIMAP_OPENED",
    "TAXI_NODE_STATUS_CHANGED",
    "TOYS_UPDATED",
    "TRAIT_CONFIG_UPDATED",
    "UNIT_AURA",
    "UPDATE_FACTION",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA",
}

---@param events? table<WowEvent, boolean>
function Navigation:RefreshEligibility(events)
    if not events then self:InvalidatePreparedData() end
    if not self.routeNavigationEnabled or not self.activeDestination then return end
    self:RecheckFailedPaths("action")
    self:RecheckFailedPaths("taxi")
    local prepared = self:EnsurePreparedData()
    if not prepared then return end
    local progression = self.progression
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    local reference = progression and progression.route.pathReferences[progression.pathIndex]
    if progression and not progression.pathUnavailable and not progression.attempted and
        progression.phase ~= "in-transit" and
        reference and graph and prepared and prepared.requirementStateByPath[reference] == "unsatisfied" and
        self:GetPathAction(graph.pathTypes[reference], graph.pathRequirements[reference]) then
        local identity = self:CaptureStepIdentity(progression)
        if identity then self:HandlePathHandlerReport(identity, "failed", "action requirements no longer satisfied") end
        return
    end
    if progression and not progression.attempted and progression.phase ~= "in-transit" and
        progression.route.preparedData.taxiObservation ~= self:GetTaxiObservation() then
        self:StartCalculation(true)
        return
    end
    if progression and prepared and not progression.attempted and progression.phase ~= "in-transit" then
        for index = progression.pathIndex, #progression.route.pathReferences do
            local journey = progression.route.taxiJourneys[progression.route.pathReferences[index]]
            if journey and not self:IsTaxiJourneyEligible(journey, prepared) then
                self:StartCalculation(true)
                return
            end
        end
    end
    if RefreshRouteOrigin() then return end
    local restart = self.pendingCalculationRestart
    if restart then
        restart()
    elseif self.activeDestination and not self.progression and not self.activeCalculation then
        self:StartCalculation(true)
    end
end

function Navigation:SetupEligibilityRefresh()
    if self.unsubscribeEligibilityRefresh then return end
    self.unsubscribeEligibilityRefresh = MapPinEnhanced:RegisterEventBucket(ELIGIBILITY_EVENTS, function(events)
        self:RefreshEligibility(events)
    end, 1, function(event, unit)
        if event == "UNIT_AURA" then
            if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" then return false end
            if not self:NeedsAuraRefresh() then return false end
        end
        -- Mark inputs stale at intake, before a new job can beat the bucket timer.
        self:InvalidatePreparedData()
        return true
    end)
end

-- Route map layers

local HBDP = MapPinEnhanced.HBDP
---@class NavigationStep
---@field index integer
---@field mapEntries NavigationRouteLayerEntry[]
---@field info WayfinderStepData?
---@field target WayfinderData?

Navigation.routeSteps = {}
---@return NavigationStep
local function CreateStep()
    return { index = 0, mapEntries = {} }
end

---@param step NavigationStep
local function ResetStep(_, step)
    wipe(step.mapEntries)
    step.info, step.target = nil, nil
    step.index = 0
end

---@type ObjectPool<NavigationStep>
local stepPool = CreateObjectPool(CreateStep, ResetStep)

---@param index integer
---@return NavigationStep
function Navigation:GetRouteStep(index)
    local step = self.routeSteps[index]
    if not step then
        step = stepPool:Acquire()
        step.index = index
        self.routeSteps[index] = step
    end
    return step
end

---@param target WayfinderData
---@param onArrival WayfinderTargetArrival?
---@param info WayfinderStepData
function Navigation:ApplyStepPresentation(target, onArrival, info)
    local destination = self.activeDestination
    info.destinationTitle = destination and destination.data.title
    info.destinationMapID = destination and destination.data.mapID
    self:RefreshRouteLayers()
    local step = self:GetRouteStep(info.stepIndex or 1)
    step.target = CopyWayfinderData(target)
    step.info = info
    Wayfinders:ApplyPresentation(step.target, onArrival, step.info)
end

local layerRoute ---@type NavigationRoute?
local layerPathIndex ---@type integer?
local layerPhase ---@type string?
local worldMapApproachTimer ---@type FunctionContainer?
local minimapApproachTimer ---@type FunctionContainer?

function Navigation:GetRouteMapFramePool()
    if not self.routeMapFramePool then
        self.routeMapFramePool = CreateFramePoolCollection()
        self.routeMapFramePool:CreatePool("Frame", nil, "MapPinEnhancedNavigationMapPinTemplate")
    end
    return self.routeMapFramePool
end

---@param isWorldMap boolean? nil releases both surfaces
function Navigation:ReleaseRouteLayers(isWorldMap)
    if isWorldMap ~= false and worldMapApproachTimer then
        worldMapApproachTimer:Cancel()
        worldMapApproachTimer = nil
    end
    if isWorldMap ~= true and minimapApproachTimer then
        minimapApproachTimer:Cancel()
        minimapApproachTimer = nil
    end
    if isWorldMap == nil then
        layerRoute = nil
        layerPathIndex = nil
        layerPhase = nil
    end
    local pool = self.routeMapFramePool
    for stepIndex, step in pairs(self.routeSteps) do
        for index = #step.mapEntries, 1, -1 do
            local entry = step.mapEntries[index]
            if isWorldMap == nil or entry.isWorldMap == isWorldMap then
                if entry.isWorldMap then
                    HBDP:RemoveWorldMapIcon(MapPinEnhanced, entry.frame)
                else
                    HBDP:RemoveMinimapIcon(MapPinEnhanced, entry.frame)
                end
                entry.frame:Reset()
                if pool then pool:Release(entry.frame) end
                table.remove(step.mapEntries, index)
            end
        end
        if isWorldMap == nil then
            stepPool:Release(step)
            self.routeSteps[stepIndex] = nil
        end
    end
end

---@param frame MapPinEnhancedNavigationMapPinTemplate
---@param isWorldMap boolean
---@param mapID number
---@param x number
---@param y number
---@param isMapEdge boolean?
---@return boolean?
local function RegisterRouteMapFrame(frame, isWorldMap, mapID, x, y, isMapEdge)
    frame.isMapEdge = isMapEdge
    -- HBD allocates a World Map wrapper on registration; remove the old one
    -- before moving an existing endpoint so bounded updates cannot retain it.
    if isWorldMap then HBDP:RemoveWorldMapIcon(MapPinEnhanced, frame) end
    if isWorldMap and isMapEdge then
        return HBDP:AddWorldMapIconMap(MapPinEnhanced, frame, mapID, x, y, nil,
            "PIN_FRAME_LEVEL_WAYPOINT_LOCATION")
    elseif isWorldMap then
        local worldX, worldY, instanceID = MapPinEnhanced.HBD:GetWorldCoordinatesFromZone(x, y, mapID)
        if worldX and worldY and instanceID then
            return HBDP:AddWorldMapIconWorld(MapPinEnhanced, frame, instanceID, worldX, worldY, 3,
                "PIN_FRAME_LEVEL_WAYPOINT_LOCATION")
        end
    else
        local added = HBDP:AddMinimapIconMap(MapPinEnhanced, frame, mapID, x, y, false, false)
        if not added then HBDP:RemoveMinimapIcon(MapPinEnhanced, frame) end
        return added
    end
end

---@param step NavigationStep
---@param isWorldMap boolean
---@param mapID number
---@param x number
---@param y number
---@param isMapEdge boolean?
---@return MapPinEnhancedNavigationMapPinTemplate?
function Navigation:AcquireRouteMapFrame(step, isWorldMap, mapID, x, y, isMapEdge)
    local frame = self:GetRouteMapFramePool():Acquire("MapPinEnhancedNavigationMapPinTemplate")
    if not RegisterRouteMapFrame(frame, isWorldMap, mapID, x, y, isMapEdge) then
        frame:Reset()
        self:GetRouteMapFramePool():Release(frame)
        return nil
    end
    frame.step = step
    table.insert(step.mapEntries, { frame = frame, isWorldMap = isWorldMap })
    return frame
end

---@param frame MapPinEnhancedNavigationMapPinTemplate?
local function ReleaseRouteMapFrame(frame)
    if not frame then return end
    local step = frame.step
    if not step then return end
    for index, entry in ipairs(step.mapEntries) do
        if entry.frame == frame then
            if entry.isWorldMap then
                HBDP:RemoveWorldMapIcon(MapPinEnhanced, frame)
            else
                HBDP:RemoveMinimapIcon(MapPinEnhanced, frame)
            end
            frame:Reset()
            Navigation:GetRouteMapFramePool():Release(frame)
            table.remove(step.mapEntries, index)
            return
        end
    end
end

---@param isWorldMap boolean
---@param fromMapID number
---@param fromX number
---@param fromY number
---@param toMapID number
---@param toX number
---@param toY number
---@return number, number, number, boolean, number, number, number, boolean
local function ProjectRouteMapEndpoints(isWorldMap, fromMapID, fromX, fromY, toMapID, toX, toY)
    local fromEdge, toEdge = false, false
    local visibleMapID = isWorldMap and WorldMapFrame:GetMapID()
    if visibleMapID then
        local HBD = MapPinEnhanced.HBD
        local startX, startY = HBD:TranslateZoneCoordinates(fromX, fromY, fromMapID, visibleMapID)
        local endX, endY = HBD:TranslateZoneCoordinates(toX, toY, toMapID, visibleMapID)
        if startX and startY and not endX then
            local edgeX, edgeY = MapPinEnhanced:ProjectPointToMapEdge(toMapID, toX, toY, visibleMapID, startX, startY)
            if edgeX and edgeY then
                toMapID, toX, toY, toEdge = visibleMapID, edgeX, edgeY, true
            end
        elseif endX and endY and not startX then
            local edgeX, edgeY = MapPinEnhanced:ProjectPointToMapEdge(fromMapID, fromX, fromY, visibleMapID, endX, endY)
            if edgeX and edgeY then
                fromMapID, fromX, fromY, fromEdge = visibleMapID, edgeX, edgeY, true
            end
        end
    end
    return fromMapID, fromX, fromY, fromEdge, toMapID, toX, toY, toEdge
end

---@param step NavigationStep
---@param isWorldMap boolean
---@param fromMapID number
---@param fromX number
---@param fromY number
---@param toMapID number
---@param toX number
---@param toY number
---@return MapPinEnhancedNavigationMapPinTemplate? startFrame
---@return MapPinEnhancedNavigationMapPinTemplate? endFrame
local function AcquireRouteMapEndpoints(step, isWorldMap, fromMapID, fromX, fromY, toMapID, toX, toY)
    local fromEdge, toEdge
    fromMapID, fromX, fromY, fromEdge, toMapID, toX, toY, toEdge =
        ProjectRouteMapEndpoints(isWorldMap, fromMapID, fromX, fromY, toMapID, toX, toY)
    local startFrame = Navigation:AcquireRouteMapFrame(step, isWorldMap, fromMapID, fromX, fromY, fromEdge)
    local endFrame = Navigation:AcquireRouteMapFrame(step, isWorldMap, toMapID, toX, toY, toEdge)
    if not startFrame or not endFrame then
        ReleaseRouteMapFrame(startFrame)
        ReleaseRouteMapFrame(endFrame)
        return nil, nil
    end
    return startFrame, endFrame
end

---@param isWorldMap boolean
---@param startFrame MapPinEnhancedNavigationMapPinTemplate
---@param endFrame MapPinEnhancedNavigationMapPinTemplate
---@param toMapID number
---@param toX number
---@param toY number
local function FollowPlayerApproach(isWorldMap, startFrame, endFrame, toMapID, toX, toY)
    local previousMapID, previousX, previousY ---@type number?, number?, number?
    local timer = C_Timer.NewTicker(0.05, function()
        if isWorldMap and not WorldMapFrame:IsShown() then return end
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        if not mapID or not x or not y then return end
        if mapID == previousMapID and x == previousX and y == previousY then return end
        previousMapID, previousX, previousY = mapID, x, y
        local fromMap, fromX, fromY, fromEdge, toMap, endX, endY, toEdge =
            ProjectRouteMapEndpoints(isWorldMap, mapID, x, y, toMapID, toX, toY)
        local startAdded = RegisterRouteMapFrame(startFrame, isWorldMap, fromMap, fromX, fromY, fromEdge)
        if not startAdded then startFrame:Hide() end
        -- The authored destination stays registered unless clipping moves it.
        local updateEnd = endFrame.isMapEdge or toEdge
        if updateEnd and not RegisterRouteMapFrame(endFrame, isWorldMap, toMap, endX, endY, toEdge) then
            endFrame:Hide()
        end
        if updateEnd and endFrame.routePathType then
            endFrame:SetRoutePoint(endFrame.routePathType)
        end
        startFrame:RefreshLine()
    end)
    if isWorldMap then worldMapApproachTimer = timer else minimapApproachTimer = timer end
end

---@param isWorldMap boolean
function Navigation:BuildRouteLayer(isWorldMap)
    local progression = self.progression
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    local destination = self.activeDestination
    if not progression or not graph or not destination then return end
    local route = progression.route
    local stepCount = GetRouteStepCount(route)
    local currentX, currentY, currentMapID = MapPinEnhanced:GetPlayerMapPosition()
    currentMapID = currentMapID or route.originMapID
    currentX = currentX or route.originX
    currentY = currentY or route.originY
    local firstPathReference = route.pathReferences[progression.pathIndex]
    local targetsPathEnd = firstPathReference and (self:IsMovementPath(graph.pathTypes[firstPathReference]) or
        progression.phase == "in-transit" and graph.pathTypes[firstPathReference] ~= "phaseswitch")
    if firstPathReference then
        local firstFromPointIndex = graph.pathFromPointIndexes[firstPathReference]
        local firstToPointIndex = graph.pathToPointIndexes[firstPathReference]
        local firstPointIndex = targetsPathEnd and firstToPointIndex or firstFromPointIndex or firstToPointIndex
        if firstPointIndex and currentMapID and currentX and currentY then
            local startFrame, endFrame = AcquireRouteMapEndpoints(self:GetRouteStep(progression.pathIndex),
                isWorldMap, currentMapID, currentX, currentY,
                graph.pointMapIDs[firstPointIndex],
                graph.pointXs[firstPointIndex], graph.pointYs[firstPointIndex])
            if startFrame and endFrame then
                startFrame:SetRouteLine(endFrame, true)
                FollowPlayerApproach(isWorldMap, startFrame, endFrame, graph.pointMapIDs[firstPointIndex],
                    graph.pointXs[firstPointIndex], graph.pointYs[firstPointIndex])
                endFrame:SetRoutePoint(graph.pathTypes[firstPathReference])
            end
        end
    end

    local firstDrawnPathIndex = progression.pathIndex + (targetsPathEnd and 1 or 0)
    for pathIndex = firstDrawnPathIndex, #route.pathReferences do
        local pathReference = route.pathReferences[pathIndex]
        local fromPointIndex = graph.pathFromPointIndexes[pathReference]
        local toPointIndex = graph.pathToPointIndexes[pathReference]
        if pathIndex > progression.pathIndex and fromPointIndex then
            local previousReference = route.pathReferences[pathIndex - 1]
            local previousPointIndex = graph.pathToPointIndexes[previousReference]
            if previousPointIndex ~= fromPointIndex then
                local startFrame, endFrame = AcquireRouteMapEndpoints(self:GetRouteStep(pathIndex),
                    isWorldMap, graph.pointMapIDs[previousPointIndex], graph.pointXs[previousPointIndex],
                    graph.pointYs[previousPointIndex], graph.pointMapIDs[fromPointIndex],
                    graph.pointXs[fromPointIndex], graph.pointYs[fromPointIndex])
                if startFrame and endFrame then
                    startFrame:SetRouteLine(endFrame, false)
                    endFrame:SetRoutePoint(graph.pathTypes[pathReference])
                end
            end
        end
        if fromPointIndex and toPointIndex then
            local journey = route.taxiJourneys[pathReference]
            local segments = journey and #journey.legs or 1
            for legIndex = 1, segments do
                local from, to = fromPointIndex, toPointIndex
                if journey then
                    local sourceReference = journey.legs[legIndex].sourceReferences[1]
                    from = graph.pathFromPointIndexes[sourceReference]
                    to = graph.pathToPointIndexes[sourceReference]
                end
                local startFrame, endFrame = AcquireRouteMapEndpoints(self:GetRouteStep(pathIndex),
                    isWorldMap, graph.pointMapIDs[from], graph.pointXs[from], graph.pointYs[from],
                    graph.pointMapIDs[to], graph.pointXs[to], graph.pointYs[to])
                if startFrame and endFrame then
                    startFrame:SetRouteLine(endFrame, pathIndex == progression.pathIndex)
                    if legIndex == segments then endFrame:SetRoutePoint(graph.pathTypes[pathReference]) end
                end
            end
        end
    end

    local finalStartMapID = currentMapID
    local finalStartX = currentX
    local finalStartY = currentY
    local finalPathReference = route.pathReferences[#route.pathReferences]
    local finalPointIndex = finalPathReference and graph.pathToPointIndexes[finalPathReference] or nil
    if finalPointIndex and progression.pathIndex < stepCount then
        finalStartMapID = graph.pointMapIDs[finalPointIndex]
        finalStartX = graph.pointXs[finalPointIndex]
        finalStartY = graph.pointYs[finalPointIndex]
    end
    if not finalStartMapID or not finalStartX or not finalStartY then return end
    local finalStartFrame, finalEndFrame = AcquireRouteMapEndpoints(self:GetRouteStep(stepCount), isWorldMap,
        finalStartMapID, finalStartX, finalStartY, destination.routingData.mapID, destination.routingData.x,
        destination.routingData.y)
    if finalStartFrame and finalEndFrame then
        finalStartFrame:SetRouteLine(finalEndFrame, progression.pathIndex == stepCount)
        -- The destination's owner supplies its pin. Route layers retain only
        -- the invisible line anchor, including on parent and continent maps.
        finalEndFrame:SetLineEndpoint()
        if progression.pathIndex == stepCount then
            FollowPlayerApproach(isWorldMap, finalStartFrame, finalEndFrame,
                destination.routingData.mapID, destination.routingData.x, destination.routingData.y)
        end
    end
end

function Navigation:RefreshRouteLayers()
    local progression = self.progression
    if progression and layerRoute == progression.route and layerPathIndex == progression.pathIndex and layerPhase == progression.phase then
        return
    end
    self:ReleaseRouteLayers()
    if self.worldMapRouteEnabled then self:BuildRouteLayer(true) end
    if self.minimapRouteEnabled then self:BuildRouteLayer(false) end
    layerRoute = progression and progression.route
    layerPathIndex = progression and progression.pathIndex
    layerPhase = progression and progression.phase
end

local function RefreshWorldMapRouteLayer()
    Navigation:ReleaseRouteLayers(true)
    if Navigation.worldMapRouteEnabled then Navigation:BuildRouteLayer(true) end
end

hooksecurefunc(WorldMapFrame, "OnMapChanged", RefreshWorldMapRouteLayer)
WorldMapFrame:HookScript("OnShow", RefreshWorldMapRouteLayer)

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Navigation:SetupCalendarRequirements()
    Navigation:BuildGraph()
    MapPinEnhanced:CallRestricted(function()
        Navigation:SetupHearthstoneDestination()
    end)
    Navigation:SetupPathHandlers()
    Navigation:SetupEligibilityRefresh()
    MapPinEnhanced:RegisterContinuousDistanceSampleCallback(function(...)
        Navigation:OnDistanceSample(...)
    end)
    if Navigation.activeDestination and Navigation.routeNavigationEnabled then
        Navigation:StartCalculation(true)
    end
end)

Options:SubscribeToOptionChanges("Wayfinder.Navigation.Enable", function(value)
    Navigation.routeNavigationEnabled = value == true
    if Navigation.routeNavigationEnabled then
        Navigation:StartCalculation()
    elseif Navigation.activeDestination then
        Navigation:CancelPreparedData()
        Navigation:CancelRouteCalculation(Navigation.activeCalculation)
        Navigation.activeCalculation = nil
        Navigation.progression = nil
        Navigation:ReleaseRouteLayers()
        Navigation:ApplyDirectDestination(true)
    end
end)

Options:SubscribeToOptionChanges("Wayfinder.Navigation.WorldMap", function(value)
    Navigation.worldMapRouteEnabled = value == true
    RefreshWorldMapRouteLayer()
end)

Options:SubscribeToOptionChanges("Wayfinder.Navigation.Minimap", function(value)
    Navigation.minimapRouteEnabled = value == true
    Navigation:ReleaseRouteLayers(false)
    if Navigation.minimapRouteEnabled then Navigation:BuildRouteLayer(false) end
end)

Options:SubscribeToOptionChanges("Wayfinder.Navigation.TransportationGroups", function(groups)
    Navigation:SetTransportationGroups(groups)
    -- A preference change invalidates the old Route, even if a replacement
    -- would not meet the usual cost-savings threshold. Keep the Destination
    -- and its failure records, but stop presenting or executing excluded Steps.
    Navigation:CancelRouteCalculation(Navigation.activeCalculation)
    Navigation.activeCalculation = nil
    Navigation:DeactivatePathHandler()
    Navigation.progression = nil
    Navigation:ReleaseRouteLayers()
    Navigation:StartCalculation(true)
end)

---@param owner string
---@param destinationID string
---@param changeNumber integer
---@return WayfinderData?
function Navigation:GetDestinationData(owner, destinationID, changeNumber)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return nil end
    return self.activeDestination and CopyWayfinderData(self.activeDestination.data)
end
