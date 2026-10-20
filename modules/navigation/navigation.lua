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
---@field insideObjectiveArea boolean?
---@field objectiveDirectionDistance number?
---@field showDirectionInObjectiveArea boolean?
---@field objectiveAreaExitTimer FunctionContainer?
---@field directGuidance boolean? user abandoned routing for this destination

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
---@field traversal WayfinderData?
---@field portalEntranceSteps table<integer, NavigationPortalEntranceStep>?

---@class NavigationPortalEntranceStep
---@field approach NavigationPortalApproach
---@field shown boolean
---@field completed boolean

---@class NavigationPortalApproach
---@field mapID number
---@field x number
---@field y number
---@field exitX number
---@field exitY number
---@field instruction string

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
---@field lastCalculationTermination string?
---@field lastCalculationInputs NavigationPreparedData?
---@field lastCalculationOriginMapID number?
---@field transportationChangedDuringTravel boolean?
---@field lastCalculationExclusions string[]?
---@field routeMapFramePool FramePoolCollection<MapPinEnhancedNavigationMapPinTemplate>?
---@field routeSteps table<integer, NavigationStep>
---@field portalApproaches table<number, NavigationPortalApproach>?
local Navigation = MapPinEnhanced:GetModule("Navigation")

local DEVIATION_RECALCULATION_COOLDOWN = 15
local presentationChangeNumber = 0
local publicationNumber = 0

---@param pathType string
---@param fromMapID number?
---@param toMapID number
---@return boolean
local function IsCrossMapTransition(pathType, fromMapID, toMapID)
    return fromMapID ~= nil and fromMapID ~= toMapID and
        (pathType == "portal" or pathType == "localportal" or pathType == "gossip")
end

---@param pathType string
---@param fromMapID number?
---@param toMapID number
---@return boolean
local function RequiresDestinationMap(pathType, fromMapID, toMapID)
    return pathType == "floor" or pathType == "border" or pathType == "lift" or
        IsCrossMapTransition(pathType, fromMapID, toMapID)
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

---@param mapID number
---@param parentMapID number
---@return boolean
local function HasParentMap(mapID, parentMapID)
    local visited = {} ---@type table<number, boolean>
    while mapID > 0 and not visited[mapID] do
        if mapID == parentMapID then return true end
        visited[mapID] = true
        local info = C_Map.GetMapInfo(mapID)
        if not info then break end
        mapID = info.parentMapID
    end
    return false
end

---@param data WayfinderData
---@return WayfinderData
local function CopyRoutingData(data)
    local copy = CopyWayfinderData(data)
    local hbd = MapPinEnhanced.HBD
    if not hbd or type(copy.mapID) ~= "number" or
        type(copy.x) ~= "number" or type(copy.y) ~= "number" then
        return copy
    end
    -- Resolve the destination before preferring the player's map; otherwise a
    -- city pin placed on its surrounding zone gains an unnecessary exit leg.
    copy.mapID, copy.x, copy.y = MapPinEnhanced:ResolveZonePosition(copy.mapID, copy.x, copy.y)
    if copy.mapID ~= data.mapID then return copy end
    local _, _, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    if playerMapID == copy.mapID then return copy end
    local mapInfo = C_Map.GetMapInfo(copy.mapID)
    local playerMapInfo = playerMapID and C_Map.GetMapInfo(playerMapID)
    -- Cities can be siblings of their surrounding zone (Ironforge/Dun Morogh).
    -- Require the whole player map inside the source zone: overlapping zone
    -- rectangles alone cannot establish a walkable route across their border.
    local siblingZone = mapInfo and playerMapInfo and mapInfo.mapType == Enum.UIMapType.Zone and
        playerMapInfo.mapType == Enum.UIMapType.Zone and mapInfo.parentMapID > 0 and
        mapInfo.parentMapID == playerMapInfo.parentMapID
    if siblingZone then
        local minX, minY = hbd:TranslateZoneCoordinates(0, 0, playerMapID, copy.mapID)
        local maxX, maxY = hbd:TranslateZoneCoordinates(1, 1, playerMapID, copy.mapID)
        siblingZone = MapPinEnhanced:IsCoordinate(minX) and MapPinEnhanced:IsCoordinate(minY) and
            MapPinEnhanced:IsCoordinate(maxX) and MapPinEnhanced:IsCoordinate(maxY)
    end
    if playerMapID and (siblingZone or HasParentMap(playerMapID, copy.mapID) or
            HasParentMap(copy.mapID, playerMapID)) then
        local x, y = hbd:TranslateZoneCoordinates(copy.x, copy.y, copy.mapID, playerMapID)
        if type(x) == "number" and type(y) == "number" and
            x >= 0 and x <= 1 and y >= 0 and y <= 1 then
            copy.mapID, copy.x, copy.y = playerMapID, x, y
            return copy
        end
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
---@param pathIndex integer
---@return integer
local function GetDisplayedStepIndex(progression, pathIndex)
    if not progression.portalEntranceSteps then return pathIndex end
    local index = pathIndex
    for beforePath, entrance in pairs(progression.portalEntranceSteps) do
        if entrance.shown and beforePath <= pathIndex then index = index + 1 end
    end
    return index
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
    local hasZone = MapPinEnhanced:IsZoneMap(destination.routingData.mapID)
    if fallbackPhase ~= "calculating" then self:RestoreActionEquipment() end
    self:DeactivatePathHandler()
    self:ReleaseRouteLayers()
    local phase = fallbackPhase or "direct"
    presentationChangeNumber = presentationChangeNumber + 1
    self:ApplyStepPresentation(destination.routingData, hasZone and removeOnArrival and function()
        self:CompleteFinalDestination(destination)
    end or nil, {
        changeNumber = presentationChangeNumber,
        arrivalIdentity = string.format("%d:direct:%s", destination.changeNumber, tostring(removeOnArrival)),
        showDirection = hasZone and (destination.directGuidance or not self.routeNavigationEnabled or
            phase ~= "no-direction" and self:CanGuideDirectly()),
        showInstruction = self.routeNavigationEnabled == true,
        phase = phase,
        isFinalDestination = true,
        instruction = fallbackInstruction or destination.data.title or "",
    })
end

---@param owner string
---@param destinationID string
---@param changeNumber integer
function Navigation:UseDirectDestination(owner, destinationID, changeNumber)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return end
    self.activeDestination.directGuidance = true
    self:CancelActionTravel()
    self:CancelRouteCalculation(self.activeCalculation)
    self.progression = nil
    self:ApplyDirectDestination(true)
end

---@param destination NavigationDestination
function Navigation:CompleteFinalDestination(destination)
    if not IsCurrentDestination(destination) then return end
    if Wayfinders:GetNavigationTraversal(destination.routingData) then return end
    if destination.data.lock and destination.data.targetType ~= Wayfinders.TARGET_TYPE_PIN then return end
    local progression = self.progression
    if progression and progression.route.pathReferences[progression.pathIndex] then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then return end
    local data = destination.routingData
    local distance = self:GetComparableDistance(mapID, x, y, data.mapID, data.x, data.y)
    if not distance or distance > 50 then return end
    self:CancelRouteCalculation(self.activeCalculation)
    self:CancelPreparedData()
    local removeDestination = destination.removeDestination
    if not destination.data.lock then destination.removeDestination = nil end
    if removeDestination then
        removeDestination(destination.owner, destination.destinationID, destination.changeNumber)
    end
end

function Navigation:IsDirectOnlyRoute()
    return self.progression ~= nil and #self.progression.route.pathReferences == 0 and
        not self.activeCalculation and not self.pendingCalculationRestart
end

-- Automatic adapters share this gate. A displayed frozen Route is not itself
-- proof that dirty observations still permit executing its current operation.
function Navigation:IsCurrentPathReady()
    local progression = self.progression
    if not progression or progression.pathUnavailable or not self:ArePreparedInputsFresh() then return false end
    local reference = progression.route.pathReferences[progression.pathIndex]
    if not reference then return false end
    if reference > 0 then return self:GetFreshPathCost(reference) ~= nil end
    local prepared = self:GetPreparedData()
    local journey = progression.route.taxiJourneys[reference]
    return prepared ~= nil and journey ~= nil and
        (not journey.observed or progression.route.preparedData.taxiObservation == self:GetTaxiObservation()) and
        self:IsTaxiJourneyEligible(journey, prepared)
end

---@param destination NavigationDestination
---@param route NavigationRoute?
---@param failure string?
---@param checkpoint fun()
---@param currentRouteUnusable boolean?
function Navigation:ApplyCalculatedRoute(destination, route, failure, checkpoint, currentRouteUnusable)
    if not IsCurrentDestination(destination) or destination.directGuidance or not self.routeNavigationEnabled then return end
    local job = self.activeCalculation
    local previous = self.progression
    local prepared ---@type NavigationPreparedData|NavigationMovementData|nil
    if route and #route.pathReferences == 0 then
        prepared = { movement = self:GetMovementCapabilities(), movementOnly = true }
    elseif self:ArePreparedInputsFresh() then
        prepared = self:GetPreparedData()
    end
    if not IsCurrentDestination(destination) or destination.directGuidance or self.progression ~= previous then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    local position = { x = x, y = y, mapID = mapID }
    if previous and (not mapID or not x or not y) then return end
    local remaining ---@type number?
    if previous and not currentRouteUnusable then
        -- A cheap direct candidate cannot assume that a dirty transport Route
        -- is unusable. Its ordinary refresh owns that decision.
        if #previous.route.pathReferences > 0 and not self:ArePreparedInputsFresh() then return end
        local currentInputs = #previous.route.pathReferences > 0 and self:GetPreparedData() or prepared or
            { movement = self:GetMovementCapabilities(), movementOnly = true }
        remaining = self:GetRemainingRouteCost(previous, currentInputs, checkpoint, position)
        currentRouteUnusable = remaining == nil
    end
    if previous and remaining and route and #route.pathReferences == 0 then
        local reference = previous.route.pathReferences[previous.pathIndex]
        -- Entering the lift's map does not prove reaching its lower level. A
        -- straight-line candidate cannot replace this unfinished ordered crossing.
        if reference and previous.route.graph.pathTypes[reference] == "lift" then return end
    end
    if route and prepared then
        if mapID and x and y and (not HasRouteOrigin(route) or mapID ~= route.originMapID) then
            self:StartCalculation(currentRouteUnusable)
            return
        end
        if not self:ValidateRoute(route, prepared, checkpoint, position) then route = nil end
        -- Validation may yield. Freshness must hold after the last selected leg.
        if route and not prepared.movementOnly and
            (not self:ArePreparedInputsFresh() or self:GetPreparedData() ~= prepared) then
            route = nil
        end
    else
        route = nil
    end
    if not IsCurrentDestination(destination) or destination.directGuidance or self.progression ~= previous then return end
    if not route and job and job.preparedData and job.preparedData ~= self:GetPreparedData() and
        self:ArePreparedInputsFresh() and (not previous or currentRouteUnusable) then
        self:StartCalculation(true)
        return
    end
    self.lastCalculationInputs = self:GetPreparedData()
    self.lastCalculationOriginMapID = select(3, MapPinEnhanced:GetPlayerMapPosition())
    if not route then
        self.lastCalculationFailure = failure or "selected route unavailable"
        if job and failure == "no route" then
            local counts = {} ---@type table<string, integer>
            for _, reason in pairs(job.unavailablePathCosts) do
                counts[reason] = (counts[reason] or 0) + 1
                checkpoint()
            end
            local exclusions = {} ---@type string[]
            for reason, count in pairs(counts) do
                exclusions[#exclusions + 1] = string.format("%s (%d)", reason, count)
            end
            table.sort(exclusions)
            self.lastCalculationExclusions = exclusions
        end
        if not previous or currentRouteUnusable then
            self.progression = nil
            local direct = self:CanGuideDirectly()
            self:ApplyDirectDestination(direct, direct and L["Navigation Direct Guidance"] or
                L["Navigation No Direction"], direct and "direct" or "no-direction")
        end
        return
    end
    if remaining and remaining - route.comparisonSeconds < math.max(15, remaining * 0.1) then return end
    self.lastCalculationFailure = nil
    if job then
        route.calculationSeconds = GetTimePreciseSec() - job.startedAt
        route.calculationSlices = job.calculationSlices
    end
    publicationNumber = publicationNumber + 1
    route.calculationID = publicationNumber
    self:DeactivatePathHandler()
    self.progression = {
        route = route,
        pathIndex = 1,
        changeNumber = 1,
        phase = route.pathReferences[1] and not route.graph.pathFromPointIndexes[route.pathReferences[1]] and
            "ready" or "approach",
    }
    self:PublishStep(self.progression)
end

---@param currentRouteUnusable boolean?
function Navigation:StartCalculation(currentRouteUnusable)
    local destination = self.activeDestination
    if not destination or not self.routeNavigationEnabled then return end
    destination.routingData = CopyRoutingData(destination.data)
    if not MapPinEnhanced:IsZoneMap(destination.routingData.mapID) then
        self:CancelRouteCalculation(self.activeCalculation)
        self.progression = nil
        self.lastCalculationFailure = "destination zone unavailable"
        self.lastCalculationTermination = "destination zone unavailable"
        self.lastCalculationExclusions = nil
        self:ApplyDirectDestination(false, L["Navigation No Direction"], "no-direction")
        return
    end
    if destination.directGuidance then
        self:ApplyDirectDestination(true)
        return
    end
    if self:IsTaxiBookingPending() then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if self.progression and (not mapID or not x or not y) then return end
    self:CancelRouteCalculation(self.activeCalculation)
    self.lastCalculationFailure = nil
    self.lastCalculationExclusions = nil
    self.lastCalculationTermination = nil
    local direct = self:CreateDirectRoute(destination.destinationID, destination.changeNumber, destination.routingData)
    local shortcut = direct and direct.comparisonSeconds <= 60
    if shortcut then
        self:ApplyCalculatedRoute(destination, direct, nil, function() end, currentRouteUnusable)
        self:CancelPreparedData()
        self.lastCalculationTermination = "short direct journey"
        return
    elseif not self.progression then
        self:ApplyDirectDestination(false, L["Navigation Calculating"], "calculating")
    end
    if not IsCurrentDestination(destination) then return end
    self.activeCalculation = self:StartRouteCalculation(destination.destinationID, destination.changeNumber,
        destination.routingData, self.avoidedPaths,
        function(route, failure, checkpoint)
            self:ApplyCalculatedRoute(destination, route, failure, checkpoint, currentRouteUnusable)
        end, function()
            if IsCurrentDestination(destination) then self:StartCalculation(currentRouteUnusable) end
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
    self:CancelActionTravel()
    self:CancelRouteCalculation(self.activeCalculation)
    self:DeactivatePathHandler()
    self:RestoreActionEquipment()
    self.destinationChangeNumber = self.destinationChangeNumber + 1
    if active and active.objectiveAreaExitTimer then active.objectiveAreaExitTimer:Cancel() end
    self.activeDestination = {
        owner = owner,
        destinationID = destinationID,
        changeNumber = self.destinationChangeNumber,
        data = CopyWayfinderData(destinationData),
        routingData = CopyRoutingData(destinationData),
        removeDestination = removeDestination,
        directGuidance = active and active.owner == owner and active.destinationID == destinationID and
            active.directGuidance or nil,
    }
    self.avoidedPaths = {}
    self.transportationChangedDuringTravel = nil
    self.progression = nil
    if self.routeNavigationEnabled then
        self:StartCalculation(true)
    else
        self:ApplyDirectDestination(true)
    end
    MapPinEnhanced:FireCallback("NAVIGATION_DESTINATION_CHANGED")
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
---@param destinationID string
---@param changeNumber integer
---@param texture string|number
---@param usesAtlas boolean
function Navigation:UpdateDestinationIcon(owner, destinationID, changeNumber, texture, usesAtlas)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return end
    local destination = self.activeDestination
    if not destination or destination.data.texture == texture and destination.data.usesAtlas == usesAtlas then return end
    destination.data.texture, destination.data.usesAtlas = texture, usesAtlas
    destination.routingData.texture, destination.routingData.usesAtlas = texture, usesAtlas
    for _, step in pairs(self.routeSteps) do
        local entries = step.info and step.info.progressEntries
        local finalEntry = entries and entries[#entries]
        if finalEntry and finalEntry.destination then
            finalEntry.destination.texture, finalEntry.destination.usesAtlas = texture, usesAtlas
        end
        if step.target and step.info and step.info.isFinalDestination then
            step.target.texture, step.target.usesAtlas = texture, usesAtlas
        end
    end
    -- Objective artwork changes do not invalidate routes or rearm arrival.
    Wayfinders:UpdateDestinationIcon(texture, usesAtlas)
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

---@param destination NavigationDestination
---@param membershipChanged boolean?
local function RefreshObjectiveAreaPresentation(destination, membershipChanged)
    local inside = destination.insideObjectiveArea == true
    local showDirection = false
    if inside and destination.objectiveDirectionDistance then
        -- Native navigation can measure to a blob edge or temporary Step. This
        -- rule needs the original quest waypoint, even while its marker is hidden.
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        if MapPinEnhanced:IsReadableNumber(mapID) and MapPinEnhanced:IsCoordinate(x) and
            MapPinEnhanced:IsCoordinate(y) then
            local data = destination.data
            local distance = Navigation:GetComparableDistance(mapID, x, y, data.mapID, data.x, data.y)
            showDirection = MapPinEnhanced:IsReadableNumber(distance) and
                distance >= 0 and distance <= destination.objectiveDirectionDistance
        end
    end
    if not membershipChanged and (destination.showDirectionInObjectiveArea == true) == showDirection then return end
    destination.showDirectionInObjectiveArea = showDirection
    for _, step in pairs(Navigation.routeSteps) do
        if step.info then
            step.info.insideObjectiveArea = step.info.isFinalDestination == true and inside
            step.info.showDirectionInObjectiveArea = step.info.isFinalDestination == true and showDirection
        end
    end
    -- Presentation changes preserve routes, target identity and arrival state.
    Wayfinders:UpdateDestinationAreaState(inside, showDirection)
end

---@param owner string
---@param destinationID string
---@param changeNumber integer
---@param inside boolean
---@param exitGraceSeconds number? provider-owned grace for a readable area exit
---@param directionDistance number? provider-approved maximum distance for guidance inside the area
---@param exitDistance number? minimum displacement from the first readable exit position
function Navigation:UpdateDestinationAreaState(owner, destinationID, changeNumber, inside, exitGraceSeconds,
                                               directionDistance, exitDistance)
    if not self:IsDestinationActive(owner, destinationID, changeNumber) then return end
    local destination = self.activeDestination
    if not destination then return end
    if not inside and exitGraceSeconds and destination.insideObjectiveArea then
        -- Keep the first exit position across repeated outside samples. Re-entry,
        -- readiness changes and destination release cancel this pending exit.
        if not destination.objectiveAreaExitTimer then
            local exitX, exitY, exitMapID = MapPinEnhanced:GetPlayerMapPosition()
            local clearSince ---@type number?
            local function CheckExit()
                if not self:IsDestinationActive(owner, destinationID, changeNumber) then return end
                local farEnough = not exitDistance
                if exitDistance then
                    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
                    if MapPinEnhanced:IsReadableNumber(mapID) and MapPinEnhanced:IsCoordinate(x) and
                        MapPinEnhanced:IsCoordinate(y) then
                        -- If the boundary position was unavailable, start the buffer
                        -- at the first readable position instead of guessing distance.
                        if not MapPinEnhanced:IsReadableNumber(exitMapID) or
                            not MapPinEnhanced:IsCoordinate(exitX) or not MapPinEnhanced:IsCoordinate(exitY) then
                            exitX, exitY, exitMapID = x, y, mapID
                        end
                        local distance = self:GetComparableDistance(mapID, x, y, exitMapID, exitX, exitY)
                        farEnough = MapPinEnhanced:IsReadableNumber(distance) and distance >= exitDistance
                    end
                end
                if farEnough and not InCombatLockdown() then
                    clearSince = clearSince or GetTime()
                    if GetTime() - clearSince >= exitGraceSeconds then
                        destination.objectiveAreaExitTimer = nil
                        self:UpdateDestinationAreaState(owner, destinationID, changeNumber, false)
                        return
                    end
                else
                    clearSince = nil
                end
                destination.objectiveAreaExitTimer = C_Timer.NewTimer(0.25, CheckExit)
            end
            CheckExit()
        end
        return
    end
    if destination.objectiveAreaExitTimer then
        destination.objectiveAreaExitTimer:Cancel()
        destination.objectiveAreaExitTimer = nil
    end
    -- Re-entry cancels the exit; quest updates can change direction eligibility
    -- even when membership stays the same.
    local membershipChanged = (destination.insideObjectiveArea == true) ~= inside
    destination.insideObjectiveArea = inside
    destination.objectiveDirectionDistance = inside and directionDistance or nil
    RefreshObjectiveAreaPresentation(destination, membershipChanged)
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
    self:RestoreActionEquipment()
    local destination = self.activeDestination
    if destination and destination.objectiveAreaExitTimer then destination.objectiveAreaExitTimer:Cancel() end
    self:CancelRouteCalculation(self.activeCalculation)
    self:CancelActionTravel()
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
    MapPinEnhanced:FireCallback("NAVIGATION_DESTINATION_CHANGED")
    return true
end

---@param changeNumber integer?
---@return boolean
function Navigation:Recalculate(changeNumber)
    changeNumber = changeNumber or presentationChangeNumber
    if changeNumber ~= presentationChangeNumber or not self.activeDestination or not self.routeNavigationEnabled then
        return false
    end
    self:InvalidatePreparedData()
    self:StartCalculation()
    return true
end

function Navigation:RefreshDynamicDestinationRoute()
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
        local entrance = progression.portalEntranceSteps and progression.portalEntranceSteps[index]
        if entrance and entrance.shown and not entrance.completed then
            steps[#steps + 1] = MapPinEnhanced:CompactChatLabel(L[entrance.approach.instruction], 240)
        end
        local phase = index == progression.pathIndex and progression.phase or nil
        steps[#steps + 1] = MapPinEnhanced:CompactChatLabel(
            self:GetPathInstruction(progression.route, index, phase), 240)
    end
    local data = destination.data
    local info = C_Map.GetMapInfo(data.mapID)
    ---@type string?
    local mode = progression.route.finalCost.explanation and progression.route.finalCost.explanation.mode
    local isFlying = mode == "steady-flight" or mode == "skyriding"
    steps[#steps + 1] = MapPinEnhanced:CompactChatLabel(string.format(
        L[isFlying and "Navigation Fly To Destination" or "Navigation Travel To Destination"],
        GetDestinationTitle(destination)), 240)
    return steps, {
        mapID = data.mapID,
        x = data.x,
        y = data.y,
        header = string.format(L["Navigation Chat Header"],
            MapPinEnhanced:CompactChatLabel(GetDestinationTitle(destination), 64),
            MapPinEnhanced:CompactChatLabel(info and info.name or tostring(data.mapID), 80),
            MapPinEnhanced.displayName),
    }
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
        local entrance = progression.portalEntranceSteps and progression.portalEntranceSteps[index]
        if entrance and entrance.shown then
            local approach = entrance.approach
            local mapInfo = C_Map.GetMapInfo(approach.mapID)
            local r, g, b = Navigation:GetPathColor("localportal"):GetRGB()
            entries[#entries + 1] = {
                icon = Navigation:GetPathIcon("localportal"),
                r = r,
                g = g,
                b = b,
                title = string.format(L["Navigation Step Number"], #entries + 1,
                    Navigation:GetPathMethod("localportal")),
                instruction = L[approach.instruction],
                location = string.format("%s (%.1f, %.1f)", mapInfo and mapInfo.name or tostring(approach.mapID),
                    approach.x * 100, approach.y * 100),
            }
        end
        local reference = route.pathReferences[index]
        local point = reference and graph.pathToPointIndexes[reference]
        local mode = route.finalCost.explanation and route.finalCost.explanation.mode
        local pathType = reference and graph.pathTypes[reference] or
            ((mode == "steady-flight" or mode == "skyriding") and "fly" or "walk")
        local mapID = point and graph.pointMapIDs[point] or destination.routingData.mapID
        local x = point and graph.pointXs[point] or destination.routingData.x
        local y = point and graph.pointYs[point] or destination.routingData.y
        local mapInfo = C_Map.GetMapInfo(mapID)
        local color = Navigation:GetPathColor(pathType)
        local r, g, b = color:GetRGB()
        entries[#entries + 1] = {
            icon = reference and Navigation:GetPathIcon(pathType) or nil,
            destination = not reference and CopyWayfinderData(destination.data) or nil,
            r = r,
            g = g,
            b = b,
            title = string.format(L["Navigation Step Number"], #entries + 1, Navigation:GetPathMethod(pathType)),
            instruction = reference and Navigation:GetPathInstruction(route, index,
                    index == progression.pathIndex and progression.phase or nil) or
                string.format(L[pathType == "fly" and "Navigation Fly To Destination" or
                "Navigation Travel To Destination"], GetDestinationTitle(destination)),
            location = string.format("%s (%.1f, %.1f)", mapInfo and mapInfo.name or tostring(mapID), x * 100, y * 100),
        }
    end
    return entries
end

---@param progression NavigationProgression
function Navigation:PublishStep(progression)
    if not self:IsCurrentProgression(progression) then return end
    self:ReconcileActionEquipment()
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
            showInstruction = GetRouteStepCount(progression.route) > 1,
            phase = "approach",
            isFinalDestination = true,
            stepIndex = progression.pathIndex,
            stepCount = GetRouteStepCount(progression.route),
            instruction = string.format(L[instructionKey], GetDestinationTitle(destination)),
            status = progression.status,
        })
        return
    end

    local pathType = graph.pathTypes[pathReference]
    local fromPointIndex = graph.pathFromPointIndexes[pathReference]
    local toPointIndex = graph.pathToPointIndexes[pathReference]
    local targetPointIndex = toPointIndex
    local isSummonedSpell = pathType == "spell" and graph.pathHandlerData[pathReference] ~= nil
    ---@type WayfinderTargetArrival?
    local onArrival

    if not self:IsMovementPath(pathType) and progression.phase == "approach" and fromPointIndex then
        targetPointIndex = fromPointIndex
        onArrival = function()
            if not self:IsCurrentProgression(progression) then return end
            self:ApplyProgressionPhase(progression, "ready")
        end
    elseif pathType == "floor" or pathType == "border" or pathType == "lift" or self:IsMovementPath(pathType) or
        progression.phase == "in-transit" and pathType ~= "phaseswitch" and pathType ~= "flighttaxi" and
            not isSummonedSpell then
        onArrival = function()
            self:CompleteCurrentPath(progression)
        end
    elseif progression.phase ~= "in-transit" or pathType ~= "flighttaxi" then
        targetPointIndex = fromPointIndex or toPointIndex
    end

    local destination = self.activeDestination
    if not destination then return end
    local travelIcon = self:GetPathIcon(pathType)
    local desiredAction = progression.phase == "ready" and not progression.pathUnavailable and
        self:GetPathAction(pathType, graph.pathRequirements[pathReference]) or nil
    if desiredAction and not self:GetFreshPathCost(pathReference) then desiredAction = nil end
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
    local arrivalMapID = RequiresDestinationMap(pathType,
        fromPointIndex and graph.pointMapIDs[fromPointIndex], graph.pointMapIDs[toPointIndex]) and
        graph.pointMapIDs[targetPointIndex] or nil
    if pathType == "lift" and progression.phase == "approach" then
        local _, _, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
        -- The upper ruins already report Undercity. Still require the boarding
        -- position, but accept either authored map for this selected lift.
        if playerMapID == graph.pointMapIDs[toPointIndex] then arrivalMapID = playerMapID end
    end
    self:ApplyStepPresentation(targetData, onArrival, {
        changeNumber = presentationChangeNumber,
        arrivalIdentity = arrivalIdentity,
        -- Entrance proximity readies an interaction; its marker stays until use.
        showDirection = desiredAction == nil and
            (progression.phase == "approach" or progression.phase == "ready"),
        phase = progression.phase,
        arrivalMapID = (pathType == "floor" or pathType == "border" or pathType == "lift" or
            progression.phase == "in-transit") and arrivalMapID or nil,
        stepIndex = progression.pathIndex,
        stepCount = GetRouteStepCount(progression.route),
        instruction = self:GetPathInstruction(progression.route, progression.pathIndex, progression.phase),
        status = progression.status,
        desiredAction = desiredAction,
    })
    local identity = self:CaptureStepIdentity(progression)
    if identity and not progression.pathUnavailable then
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
---@param stepIndex integer
local function ApplyStepIndex(progression, stepIndex)
    -- A pending job priced the old Step and must not replace selected progress.
    Navigation:CancelRouteCalculation(Navigation.activeCalculation)
    Navigation.activeCalculation = nil
    Navigation:DeactivatePathHandler()
    progression.pathIndex = stepIndex
    progression.changeNumber = progression.changeNumber + 1
    progression.status = nil
    progression.attempted = nil
    progression.pathUnavailable = nil
    ResetDeviationState(progression)
    local graph = progression.route.graph
    local nextReference = progression.route.pathReferences[progression.pathIndex]
    if not graph then return end
    progression.phase = nextReference and graph.pathFromPointIndexes[nextReference] and "approach" or
        nextReference and "ready" or "approach"
    Navigation:PublishStep(progression)
end

---@param progression NavigationProgression
function Navigation:CompleteCurrentPath(progression)
    if not self:IsCurrentProgression(progression) then return end
    self:RestoreActionEquipment()
    if self.transportationChangedDuringTravel then
        self.transportationChangedDuringTravel = nil
        self:DeactivatePathHandler()
        self.progression = nil
        self:StartCalculation(true)
    else
        ApplyStepIndex(progression, progression.pathIndex + 1)
    end
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
    -- Summoning a spell menu and selecting an option do not prove teleportation.
    -- Its travel observer replans only after loading, or on bounded expiry.
    if pathType == "spell" and graph.pathHandlerData[pathReference] then return end
    -- Lifts visit the walk-on and walk-off points in order. The broad transition
    -- vicinity below cannot skip either point or complete at the lift shaft.
    if pathType == "lift" then return end
    local playerX, playerY, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    if not playerMapID or not playerX or not playerY then return end
    local destinationDistance = self:GetComparableDistance(playerMapID, playerX, playerY,
        graph.pointMapIDs[toPointIndex], graph.pointXs[toPointIndex], graph.pointYs[toPointIndex])
    if self:IsMovementPath(graph.pathTypes[pathReference]) then
        if destinationDistance == nil then self:StartCalculation(false) end
        return
    end
    if graph.pathTypes[pathReference] == "phaseswitch" or graph.pathTypes[pathReference] == "flighttaxi" then return end
    -- Floor and border endpoints advance through their arrival callbacks in order.
    -- Exit vicinity must not skip the entrance or hide exit guidance.
    if (pathType == "floor" or pathType == "border") and destinationDistance then return end
    if destinationDistance and destinationDistance <= 100 and
        (not RequiresDestinationMap(pathType, fromPointIndex and graph.pointMapIDs[fromPointIndex],
            graph.pointMapIDs[toPointIndex]) or playerMapID == graph.pointMapIDs[toPointIndex]) then
        -- A distinct destination map plus exit vicinity proves this transition.
        -- Spawn offsets must not require walking back to an exact authored exit.
        if IsCrossMapTransition(pathType, fromPointIndex and graph.pointMapIDs[fromPointIndex],
                graph.pointMapIDs[toPointIndex]) then
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

---@param progression NavigationProgression?
---@return NavigationPortalApproach? approach
---@return WayfinderData? target
local function GetPortalApproach(progression)
    if not progression or (progression.phase ~= "approach" and progression.phase ~= "ready") then return end
    local graph = progression.route.graph
    local reference = progression.route.pathReferences[progression.pathIndex]
    if not reference or graph.pathTypes[reference] ~= "portal" then return end
    local point = graph.pathFromPointIndexes[reference]
    if not point then return end
    local approach = Navigation.portalApproaches and Navigation.portalApproaches[graph.pointIDs[point]]
    if not approach or graph.pointMapIDs[point] ~= approach.mapID then return end
    return approach, { mapID = graph.pointMapIDs[point], x = graph.pointXs[point], y = graph.pointYs[point] }
end

---@param progression NavigationProgression
---@param approach NavigationPortalApproach
---@param target WayfinderData
---@return WayfinderData? entrance
local function GetPortalTraversal(progression, approach, target)
    local steps = progression.portalEntranceSteps
    local step = steps and steps[progression.pathIndex]
    if step and step.completed then return end
    local _, _, playerMapID = MapPinEnhanced:GetPlayerMapPosition()
    if playerMapID and playerMapID ~= approach.mapID then return end
    local entrance = { mapID = approach.mapID, x = approach.x, y = approach.y, title = L[approach.instruction] }
    -- On first publication the portal may still be selected. Afterwards the
    -- entrance itself owns native projection, including the exit after crossing.
    local native = Wayfinders:GetNavigationTraversal(entrance) or Wayfinders:GetNavigationTraversal(target)
    local inside = false
    if native and native.mapID == approach.mapID then
        local distance = Navigation:GetComparableDistance(native.mapID, native.x, native.y,
            approach.mapID, approach.exitX, approach.exitY)
        -- The exit hint proves which side of this same-map boundary contains
        -- the player. Its localized wording must never become portal guidance.
        inside = distance ~= nil and distance <= 5
    end
    if not steps then
        steps = {}
        progression.portalEntranceSteps = steps
    end
    if not step then
        step = { approach = approach, shown = not inside, completed = inside }
        steps[progression.pathIndex] = step
    end
    if inside then
        -- Completion belongs to this progression. Retargeting the portal can
        -- temporarily remove native traversal data and must not reinsert entry.
        step.completed = true
        return
    end
    -- Missing/delayed native data cannot prove entry. Proximity to the tower
    -- or the mountain above the room must never consume the entrance guidance.
    return entrance
end

-- Native paths can arrive after route publication and can change without a map
-- change (the Sanctum and the city both use Stormwind's map ID).
---@return boolean? changed
local function RefreshNativeTraversal()
    local progression = Navigation.progression
    local destination = Navigation.activeDestination
    if not progression or not destination or not Navigation:IsCurrentProgression(progression) then return end
    local previous = progression.traversal
    local approach, target = GetPortalApproach(progression)
    local traversal ---@type WayfinderData?
    if approach and target then
        traversal = GetPortalTraversal(progression, approach, target)
    elseif progression.phase == "approach" and not progression.route.pathReferences[progression.pathIndex] then
        traversal = Wayfinders:GetNavigationTraversal(destination.routingData)
    else
        return
    end
    if not previous and not traversal then return end
    if previous and traversal and previous.mapID == traversal.mapID and previous.x == traversal.x and
        previous.y == traversal.y and previous.title == traversal.title then
        return
    end
    progression.closestDistance, progression.movingAwayStartedAt = nil, nil
    Navigation:PublishStep(progression)
    return true
end

MapPinEnhanced:RegisterEventBucket({ "SUPER_TRACKING_PATH_UPDATED" }, RefreshNativeTraversal, 0.1)

---@return boolean
function Navigation:CanGuideDirectly()
    local destination = self.activeDestination
    if not destination then return false end
    if not MapPinEnhanced:IsZoneMap(destination.routingData.mapID) then return false end
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
    if self:ObserveActionTravelPosition() then return end
    if RefreshNativeTraversal() then return end
    if self.activeDestination and self.activeDestination.insideObjectiveArea then
        RefreshObjectiveAreaPresentation(self.activeDestination)
    end
    if RefreshRouteOrigin() then return end
    local progression = self.progression
    if not progression or not self:IsCurrentProgression(progression) then return end
    if progression.traversal then return end
    local reference = progression.route.pathReferences[progression.pathIndex]
    if reference and not self:IsMovementPath(progression.route.graph.pathTypes[reference]) then
        local changeNumber = progression.changeNumber
        -- Arrival at a stop, floor exit or border exit need not produce a zone event.
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
---@param result "attempted"|"completed"|"failed"
---@param detail string?
function Navigation:HandlePathHandlerReport(identity, result, detail)
    if not self:IsStepIdentityCurrent(identity) then return end
    local progression = self.progression
    if not progression then return end
    if result == "attempted" then
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
    if self.activeDestination.directGuidance then
        self:StartCalculation()
        return
    end
    -- Loading can invalidate the departure before its handler sees the exit.
    -- Observe arrival before revalidating operations that are already finished.
    self:CheckCurrentPathCompletion()
    self:RecheckFailedPaths("action")
    self:RecheckFailedPaths("taxi")
    -- Applied Legacy perks can change the best route even when the old one
    -- remains usable. Reuse the transportation-change deferral for a booked leg.
    if events and events.TRAIT_CONFIG_UPDATED and Constants and Constants.LegacyConsts then
        local progression = self.progression
        if progression and (progression.attempted or progression.phase == "in-transit" or
                self:IsTaxiBookingPending()) then
            self.transportationChangedDuringTravel = true
            return
        end
        self:StartCalculation(true)
        return
    end
    if self:IsDirectOnlyRoute() then
        local route = self.progression.route
        local current = self:CreateDirectRoute(self.activeDestination.destinationID,
            self.activeDestination.changeNumber, self.activeDestination.routingData)
        if not current or current.originMapID ~= route.originMapID or
            current.finalCost.explanation.mode ~= route.finalCost.explanation.mode or
            current.finalCost.explanation.speed ~= route.finalCost.explanation.speed then
            self:StartCalculation(true)
        end
        return
    end
    local prepared = self:EnsurePreparedData()
    if not prepared then return end
    local job = self.activeCalculation
    if job and job.preparedData and job.preparedData.movement ~= prepared.movement then
        self:StartCalculation(true)
        return
    end
    local progression = self.progression
    if progression and not progression.attempted and progression.phase ~= "in-transit" then
        local phaseState = self:GetTravelPhaseState()
        for index = progression.pathIndex, #progression.route.pathReferences do
            local reference = progression.route.pathReferences[index]
            local journey = progression.route.taxiJourneys[reference]
            if reference > 0 and not self:GetFreshPathCost(reference, phaseState) or
                journey and (not self:IsTaxiJourneyEligible(journey, prepared, phaseState) or
                    journey.observed and progression.route.preparedData.taxiObservation ~= self:GetTaxiObservation()) then
                progression.pathUnavailable = true
                self:DeactivatePathHandler()
                self:PublishStep(progression)
                self:StartCalculation(true)
                return
            end
            phaseState = self:AdvanceTravelPhase(progression.route.graph, reference, phaseState)
            if not phaseState then
                progression.pathUnavailable = true
                self:DeactivatePathHandler()
                self:PublishStep(progression)
                self:StartCalculation(true)
                return
            end
        end
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        if mapID and x and y and not self:GetRemainingRouteCost(progression, prepared, function() end,
                { x = x, y = y, mapID = mapID }) then
            progression.pathUnavailable = true
            self:DeactivatePathHandler()
            self:PublishStep(progression)
            self:StartCalculation(true)
            return
        end
        -- Restore a ready action/adapter after dirty authoritative inputs clear.
        progression.pathUnavailable = nil
        self:PublishStep(progression)
        self:TryAutomaticTaxiSelection()
    end
    if RefreshRouteOrigin() then return end
    local restart = self.pendingCalculationRestart
    if restart then
        restart()
    elseif not self.progression and not self.activeCalculation and
        (prepared ~= self.lastCalculationInputs or
            select(3, MapPinEnhanced:GetPlayerMapPosition()) ~= self.lastCalculationOriginMapID) then
        self:StartCalculation(true)
    end
end

function Navigation:SetupEligibilityRefresh()
    if self.unsubscribeEligibilityRefresh then return end
    -- flightTaxiMap refreshes taxi events immediately. Bucketing them here would
    -- cancel its fresh calculation and delay the restart again.
    self.unsubscribeEligibilityRefresh = MapPinEnhanced:RegisterEventBucket(ELIGIBILITY_EVENTS, function(events)
        self:RefreshEligibility(events)
    end, 0.1, function(event, unit)
        if event == "UNIT_AURA" then
            if MapPinEnhanced:IsSecretValue(unit) or unit ~= "player" then return false end
            if not self:NeedsAuraRefresh() then return false end
        end
        -- Mark inputs stale at intake, before a new job can beat the bucket timer.
        self:InvalidatePreparedData(event)
        local progression = self.progression
        if progression and not progression.attempted and progression.phase ~= "in-transit" and
            progression.route.pathReferences[progression.pathIndex] then
            self:PublishStep(progression)
        end
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
---@field progressEntry WayfinderProgressEntry?

Navigation.routeSteps = {}
---@return NavigationStep
local function CreateStep()
    return { index = 0, mapEntries = {} }
end

---@param step NavigationStep
local function ResetStep(_, step)
    wipe(step.mapEntries)
    step.info, step.target = nil, nil
    step.progressEntry = nil
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
    local progression = self.progression
    local approach, portalTarget = GetPortalApproach(progression)
    local traversal ---@type WayfinderData?
    if approach and portalTarget and not info.isFinalDestination then
        traversal = GetPortalTraversal(progression, approach, portalTarget)
        info.nativeTraversalTarget = traversal
    elseif progression and info.isFinalDestination and info.phase == "approach" then
        traversal = Wayfinders:GetNavigationTraversal(target)
    end
    if progression then
        progression.traversal = traversal
    end
    if traversal then
        -- Native traversal supplies boundaries absent from UI map IDs. Final
        -- movement retains its selection; an authored entrance selects itself.
        -- Neither advances from entrance proximity alone.
        target = CopyWayfinderData(target)
        target.mapID, target.x, target.y = traversal.mapID, traversal.x, traversal.y
        target.mapDistanceOnly = true
        target.lock = false
        if approach then target.texture = self:GetPathIcon("localportal") end
        onArrival = nil
        info.arrivalIdentity = info.arrivalIdentity .. ":traversal:" .. traversal.mapID .. ":" ..
            traversal.x .. ":" .. traversal.y
        info.instruction = traversal.title or info.instruction
        info.showInstruction = true
        info.isFinalDestination = false
        info.isTraversal = true
    end
    if progression and info.stepIndex then
        -- Entrance execution is independent of the transport Path index. Keep
        -- its numbered history when the portal and final movement become active.
        info.progressEntries = CopyRouteProgress(progression, progression.route.graph)
        info.stepCount = #info.progressEntries
        info.stepIndex = GetDisplayedStepIndex(progression, progression.pathIndex) -
            (approach and traversal and 1 or 0)
    end
    info.insideObjectiveArea = info.isFinalDestination == true and
        destination ~= nil and destination.insideObjectiveArea == true
    info.showDirectionInObjectiveArea = info.insideObjectiveArea == true and
        destination ~= nil and destination.showDirectionInObjectiveArea == true
    info.destinationTitle = destination and destination.data.title
    info.destinationMapID = destination and destination.data.mapID
    self:RefreshRouteLayers()
    for index, entry in ipairs(info.progressEntries or {}) do
        self:GetRouteStep(index).progressEntry = entry
    end
    local step = self:GetRouteStep(info.stepIndex or 1)
    step.target = CopyWayfinderData(target)
    step.info = info
    Wayfinders:ApplyPresentation(step.target, onArrival, step.info)
end

local layerRoute ---@type NavigationRoute?
local layerPathIndex ---@type integer?
local layerPhase ---@type string?
local layerDisplayedStepIndex ---@type integer?
local worldMapApproachTimer ---@type FunctionContainer?
local minimapApproachTimer ---@type FunctionContainer?
local surfaceApproaches = {} ---@type table<boolean, fun()>

function Navigation:GetRouteMapFramePool()
    if not self.routeMapFramePool then
        self.routeMapFramePool = CreateFramePoolCollection()
        self.routeMapFramePool:CreatePool("Frame", nil, "MapPinEnhancedNavigationMapPinTemplate")
    end
    return self.routeMapFramePool
end

---@param isWorldMap boolean? nil releases both surfaces
function Navigation:ReleaseRouteLayers(isWorldMap)
    if isWorldMap ~= false then surfaceApproaches[true] = nil end
    if isWorldMap ~= true then surfaceApproaches[false] = nil end
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
        layerDisplayedStepIndex = nil
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

-- One worker per surface covers all geometry, even a route without a player
-- approach. HBD still anchors/clips each frame; native UV scrolling is independent.
local function EnsureSurfaceGeometry(isWorldMap)
    if isWorldMap and worldMapApproachTimer or not isWorldMap and minimapApproachTimer then return end
    local function UpdateGeometry()
        if isWorldMap and not WorldMapFrame:IsShown() then return end
        local approach = surfaceApproaches[isWorldMap]
        if approach then approach() end
        local hasLines = false
        for _, step in pairs(Navigation.routeSteps) do
            for _, entry in ipairs(step.mapEntries) do
                if entry.isWorldMap == isWorldMap and entry.frame.lineEnd then
                    hasLines = true
                    entry.frame:RefreshLine()
                end
            end
        end
        if not hasLines then
            local current = isWorldMap and worldMapApproachTimer or minimapApproachTimer
            if current then current:Cancel() end
            if isWorldMap then worldMapApproachTimer = nil else minimapApproachTimer = nil end
            surfaceApproaches[isWorldMap] = nil
        end
    end
    --@debug@
    UpdateGeometry = MapPinEnhanced.profiler:WrapScope(isWorldMap and
        "Navigation.WorldMap.UpdateGeometry" or "Navigation.Minimap.UpdateGeometry", UpdateGeometry)
    --@end-debug@
    local timer = C_Timer.NewTicker(0.1, UpdateGeometry)
    if isWorldMap then worldMapApproachTimer = timer else minimapApproachTimer = timer end
end

---@param isWorldMap boolean
---@param startFrame MapPinEnhancedNavigationMapPinTemplate
---@param endFrame MapPinEnhancedNavigationMapPinTemplate
---@param toMapID number
---@param toX number
---@param toY number
local function FollowPlayerApproach(isWorldMap, startFrame, endFrame, toMapID, toX, toY)
    local previousMapID, previousX, previousY ---@type number?, number?, number?
    surfaceApproaches[isWorldMap] = function()
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
        -- The surface worker refreshes all lines after updating this approach.
    end
    EnsureSurfaceGeometry(isWorldMap)
end

---@param isWorldMap boolean
function Navigation:BuildRouteLayer(isWorldMap)
    if isWorldMap and not WorldMapFrame:IsShown() or not isWorldMap and not Minimap:IsVisible() then return end
    local progression = self.progression
    local graph = self.progression and self.progression.route.graph or self:GetGraph()
    local destination = self.activeDestination
    if not progression or not graph or not destination then return end
    EnsureSurfaceGeometry(isWorldMap)
    local route = progression.route
    local stepCount = GetRouteStepCount(route)
    local portalStepIndex = GetDisplayedStepIndex(progression, progression.pathIndex)
    local entranceStep = progression.portalEntranceSteps and progression.portalEntranceSteps[progression.pathIndex]
    local entrance = progression.traversal and entranceStep and not entranceStep.completed and entranceStep.approach
    local currentX, currentY, currentMapID = MapPinEnhanced:GetPlayerMapPosition()
    currentMapID = currentMapID or route.originMapID
    currentX = currentX or route.originX
    currentY = currentY or route.originY
    local firstPathReference = route.pathReferences[progression.pathIndex]
    local targetsPathEnd = firstPathReference and (self:IsMovementPath(graph.pathTypes[firstPathReference]) or
        (graph.pathTypes[firstPathReference] == "floor" or graph.pathTypes[firstPathReference] == "border" or
            graph.pathTypes[firstPathReference] == "lift") and
        progression.phase ~= "approach" or
        progression.phase == "in-transit" and graph.pathTypes[firstPathReference] ~= "phaseswitch")
    if firstPathReference then
        local firstFromPointIndex = graph.pathFromPointIndexes[firstPathReference]
        local firstToPointIndex = graph.pathToPointIndexes[firstPathReference]
        local firstPointIndex = targetsPathEnd and firstToPointIndex or firstFromPointIndex or firstToPointIndex
        if firstPointIndex and currentMapID and currentX and currentY then
            local approachStep = self:GetRouteStep(portalStepIndex - (entrance and 1 or 0))
            local approachMapID = entrance and entrance.mapID or graph.pointMapIDs[firstPointIndex]
            local approachX = entrance and entrance.x or graph.pointXs[firstPointIndex]
            local approachY = entrance and entrance.y or graph.pointYs[firstPointIndex]
            local startFrame, endFrame = AcquireRouteMapEndpoints(approachStep,
                isWorldMap, currentMapID, currentX, currentY,
                approachMapID, approachX, approachY)
            if startFrame and endFrame then
                startFrame:SetRouteLine(endFrame, true)
                FollowPlayerApproach(isWorldMap, startFrame, endFrame, approachMapID, approachX, approachY)
                endFrame:SetRoutePoint(entrance and "localportal" or graph.pathTypes[firstPathReference])
            end
            if entrance then
                local portalStart, portalEnd = AcquireRouteMapEndpoints(self:GetRouteStep(portalStepIndex),
                    isWorldMap, entrance.mapID, entrance.exitX, entrance.exitY,
                    graph.pointMapIDs[firstPointIndex], graph.pointXs[firstPointIndex], graph.pointYs[firstPointIndex])
                if portalStart and portalEnd then
                    portalStart:SetRouteLine(portalEnd, false)
                    portalEnd:SetRoutePoint(graph.pathTypes[firstPathReference])
                end
            end
        end
    end

    local firstDrawnPathIndex = progression.pathIndex + (targetsPathEnd and 1 or 0)
    for pathIndex = firstDrawnPathIndex, #route.pathReferences do
        local pathReference = route.pathReferences[pathIndex]
        local step = self:GetRouteStep(GetDisplayedStepIndex(progression, pathIndex))
        local fromPointIndex = graph.pathFromPointIndexes[pathReference]
        local toPointIndex = graph.pathToPointIndexes[pathReference]
        if pathIndex > progression.pathIndex and fromPointIndex then
            local previousReference = route.pathReferences[pathIndex - 1]
            local previousPointIndex = graph.pathToPointIndexes[previousReference]
            if previousPointIndex ~= fromPointIndex then
                local startFrame, endFrame = AcquireRouteMapEndpoints(step,
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
                local startFrame, endFrame = AcquireRouteMapEndpoints(step,
                    isWorldMap, graph.pointMapIDs[from], graph.pointXs[from], graph.pointYs[from],
                    graph.pointMapIDs[to], graph.pointXs[to], graph.pointYs[to])
                if startFrame and endFrame then
                    startFrame:SetRouteLine(endFrame, pathIndex == progression.pathIndex and not entrance)
                    -- The active floor or border shows only its current endpoint; keep
                    -- the exit as a line anchor until entrance arrival.
                    if legIndex == segments and
                        (pathIndex ~= progression.pathIndex or
                            graph.pathTypes[pathReference] ~= "floor" and graph.pathTypes[pathReference] ~= "border") then
                        endFrame:SetRoutePoint(graph.pathTypes[pathReference])
                    end
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
    local finalStep = self:GetRouteStep(GetDisplayedStepIndex(progression, stepCount))
    local finalStartFrame, finalEndFrame = AcquireRouteMapEndpoints(finalStep, isWorldMap,
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
    local entrance = progression and progression.portalEntranceSteps and
        progression.portalEntranceSteps[progression.pathIndex]
    local displayedStepIndex = progression and GetDisplayedStepIndex(progression, progression.pathIndex) -
        (progression.traversal and entrance and not entrance.completed and 1 or 0)
    if progression and layerRoute == progression.route and layerPathIndex == progression.pathIndex and
        layerPhase == progression.phase and layerDisplayedStepIndex == displayedStepIndex then
        return
    end
    self:ReleaseRouteLayers()
    if self.worldMapRouteEnabled then self:BuildRouteLayer(true) end
    if self.minimapRouteEnabled then self:BuildRouteLayer(false) end
    layerRoute = progression and progression.route
    layerPathIndex = progression and progression.pathIndex
    layerPhase = progression and progression.phase
    layerDisplayedStepIndex = displayedStepIndex
end

local function RefreshWorldMapRouteLayer()
    Navigation:ReleaseRouteLayers(true)
    if Navigation.worldMapRouteEnabled then Navigation:BuildRouteLayer(true) end
end

hooksecurefunc(WorldMapFrame, "OnMapChanged", RefreshWorldMapRouteLayer)
WorldMapFrame:HookScript("OnShow", RefreshWorldMapRouteLayer)
WorldMapFrame:HookScript("OnHide", function() Navigation:ReleaseRouteLayers(true) end)
Minimap:HookScript("OnHide", function() Navigation:ReleaseRouteLayers(false) end)
Minimap:HookScript("OnShow", function()
    Navigation:ReleaseRouteLayers(false)
    if Navigation.minimapRouteEnabled then Navigation:BuildRouteLayer(false) end
end)

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Navigation:SetupCalendarRequirements()
    Navigation:BuildGraph()
    MapPinEnhanced:CallRestricted(function()
        Navigation:SetupHearthstoneDestination()
        Navigation:SetupCampDestination()
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
    Navigation:CancelActionTravel()
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
    local progression = Navigation.progression
    if progression and (progression.attempted or progression.phase == "in-transit" or
            Navigation:IsTaxiBookingPending()) then
        Navigation.transportationChangedDuringTravel = true
        Navigation:PublishStep(progression)
        return
    end
    Navigation.transportationChangedDuringTravel = nil
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
