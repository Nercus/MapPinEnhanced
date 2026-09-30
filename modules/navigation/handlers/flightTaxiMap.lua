---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")

---@class NavigationTaxiObservation
---@field origin number?
---@field itineraries table<number, number[]>
---@field failures table<number, string>
---@field destinationsBySlot table<number, number>
---@field names table<number, string>
---@field learnedNodeIDs number[]

local observation ---@type NavigationTaxiObservation?
local interactionOpen = false
local activeData ---@type NavigationFlightTaxiData?
local activeJourney ---@type NavigationTaxiJourney?
local activeReport ---@type NavigationPathReport?
local rideStarted = false
local bookedDestination ---@type number?
local bookingPending = false
local closingObservation ---@type NavigationTaxiObservation?
local rideTimer ---@type FunctionContainer?
local automaticDestination ---@type NavigationDestination?

local function IsID(value)
    return not MapPinEnhanced:IsSecretValue(value) and type(value) == "number" and
        value > 0 and value < math.huge and value == math.floor(value)
end

---@return NavigationTaxiObservation?
function Navigation:GetTaxiObservation()
    return observation
end

---@return NavigationTaxiObservation
local function ReadObservation()
    -- FlightPathDataProvider passes destination slot, segment and source flag.
    local getNodeSlot = TaxiGetNodeSlot ---@type fun(destination: number, segment: number, source: boolean): number?
    local result = { itineraries = {}, failures = {}, destinationsBySlot = {}, names = {}, learnedNodeIDs = {} }
    ---@cast result NavigationTaxiObservation
    if not C_TaxiMap or not C_TaxiMap.GetAllTaxiNodes or not GetTaxiMapID or
        not GetNumRoutes or not TaxiGetNodeSlot or not Enum or not Enum.FlightPathState then
        return result
    end
    local mapID = GetTaxiMapID()
    if not IsID(mapID) then return result end
    local nodes = C_TaxiMap.GetAllTaxiNodes(mapID)
    if MapPinEnhanced:IsSecretValue(nodes) or type(nodes) ~= "table" then return result end
    local slots = {} ---@type table<number, number>
    for _, node in ipairs(nodes) do
        if not MapPinEnhanced:IsSecretValue(node) and type(node) == "table" and
            IsID(node.slotIndex) and IsID(node.nodeID) and not MapPinEnhanced:IsSecretValue(node.state) then
            slots[node.slotIndex] = node.nodeID
            if not MapPinEnhanced:IsSecretValue(node.isMapLayerTransition) and not node.isMapLayerTransition and
                (node.state == Enum.FlightPathState.Current or node.state == Enum.FlightPathState.Reachable) then
                result.learnedNodeIDs[#result.learnedNodeIDs + 1] = node.nodeID
            end
            if not MapPinEnhanced:IsSecretValue(node.name) and type(node.name) == "string" then
                result.names[node.nodeID] = node.name
            end
            if node.state == Enum.FlightPathState.Current then
                if result.origin and result.origin ~= node.nodeID then
                    result.origin = nil
                    return result
                end
                result.origin = node.nodeID
            end
        end
    end
    if not result.origin then return result end
    for _, node in ipairs(nodes) do
        if not MapPinEnhanced:IsSecretValue(node) and type(node) == "table" and
            IsID(node.nodeID) and IsID(node.slotIndex) and not MapPinEnhanced:IsSecretValue(node.state) then
            local id = node.nodeID
            if node.state == Enum.FlightPathState.Reachable then
                result.failures[id] = "incomplete taxi preview"
                if not MapPinEnhanced:IsSecretValue(node.isMapLayerTransition) and not node.isMapLayerTransition then
                    result.destinationsBySlot[node.slotIndex] = id
                    local count = GetNumRoutes(node.slotIndex)
                    if IsID(count) and count <= 1000 then
                        local itinerary = { result.origin }
                        local complete = true
                        for index = 1, count do
                            local fromSlot = getNodeSlot(node.slotIndex, index, true)
                            local toSlot = getNodeSlot(node.slotIndex, index, false)
                            local from = IsID(fromSlot) and slots[fromSlot]
                            local to = IsID(toSlot) and slots[toSlot]
                            if not from or not to or from ~= itinerary[#itinerary] or from == to then
                                complete = false
                                break
                            end
                            itinerary[#itinerary + 1] = to
                        end
                        if complete and itinerary[#itinerary] == id then
                            result.itineraries[id] = itinerary
                            result.failures[id] = nil
                        end
                    end
                end
            elseif node.state == Enum.FlightPathState.Unreachable then
                result.failures[id] = "taxi destination is unreachable"
            end
        end
    end
    return result
end

local function RefreshRoutes()
    Navigation:ClearTaxiNodeKnowledge()
    Navigation:RecheckFailedPaths("taxi")
    if Navigation.routeNavigationEnabled and Navigation.activeDestination then Navigation:EnsurePreparedData() end
    local progression = Navigation.progression
    local flying = UnitOnTaxi("player")
    if not MapPinEnhanced:IsSecretValue(flying) and flying then return end
    if bookingPending or progression and (progression.attempted or progression.phase == "in-transit") then return end
    if Navigation.activeDestination then Navigation:StartCalculation(true) end
end

local function Observe()
    if not rideStarted then bookingPending = false end
    closingObservation = nil
    local previousOrigin = interactionOpen and observation and observation.origin
    if not interactionOpen then
        local shiftDown = IsShiftKeyDown()
        automaticDestination = nil
        if Navigation.routeNavigationEnabled and not MapPinEnhanced:IsSecretValue(shiftDown) and
            shiftDown == false then
            automaticDestination = Navigation.activeDestination
        end
    end
    interactionOpen = true
    local fresh = ReadObservation()
    if fresh.origin then Navigation:RecordLearnedTaxiNodes(fresh.learnedNodeIDs) end
    fresh.origin = fresh.origin or previousOrigin
    observation = fresh
    RefreshRoutes()
end

local function Invalidate()
    automaticDestination = nil
    observation = nil
    Navigation:ClearTaxiNodeKnowledge()
end

local function TakeRequiredFlight()
    if not automaticDestination then return end
    if automaticDestination ~= Navigation.activeDestination or not Navigation.routeNavigationEnabled or
        not interactionOpen or InCombatLockdown() then
        automaticDestination = nil
        return
    end
    local progression = Navigation.progression
    local journey = activeJourney
    -- The ride ticker waits for publication of the route calculated from this
    -- open map. An older route must never select a slot from a new observation.
    if not TakeTaxiNode or bookingPending or Navigation.activeCalculation or not observation or
        not progression or progression.route.preparedData.taxiObservation ~= observation or
        not journey or not journey.observed or journey.origin ~= observation.origin or
        progression.route.taxiJourneys[progression.route.pathReferences[progression.pathIndex]] ~= journey then
        return
    end
    if not observation.itineraries[journey.destination] or observation.failures[journey.destination] then return end
    local destinationSlot ---@type number?
    for slot, nodeID in pairs(observation.destinationsBySlot) do
        if nodeID == journey.destination then
            if destinationSlot then return end
            destinationSlot = slot
        end
    end
    if not destinationSlot then return end
    -- Consume this opening before booking, which can synchronously close the
    -- map. A rejected booking stays manual until the next interaction.
    automaticDestination = nil
    TakeTaxiNode(destinationSlot)
end

function Navigation:IsTaxiBookingPending()
    return bookingPending
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
function Navigation:ActivateTaxiJourney(context, report)
    activeData = context.data
    activeJourney = context.taxiJourney
    activeReport = report
    if rideTimer then return end
    -- The subscription belongs to the selected operation, including loading
    -- transitions. Intermediate proximity never completes a booked flight.
    rideTimer = C_Timer.NewTicker(0.5, function()
        if not activeData or not activeReport then return end
        local flying = UnitOnTaxi("player")
        if MapPinEnhanced:IsSecretValue(flying) or type(flying) ~= "boolean" then return end
        if flying then
            if not rideStarted then
                rideStarted = true
                bookingPending = false
                activeReport("attempted")
            end
            return
        end
        if not rideStarted then
            -- A rejected booking leaves the interaction open. Do not leave
            -- calculation publication suspended after that ordinary failure.
            if interactionOpen then bookingPending = false end
            TakeRequiredFlight()
            return
        end
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        if not x or not y or not mapID then return end
        local distance = Navigation:GetComparableDistance(mapID, x, y,
            activeData.toMap, activeData.toX, activeData.toY)
        if not distance then return end
        rideStarted = false
        local destination = activeJourney and activeJourney.destination or activeData.toTaxiNodeID
        if distance <= 100 and (not bookedDestination or bookedDestination == destination) then
            activeReport("completed")
        else
            -- A different booking or early landing invalidates this operation,
            -- not an authored connection for every future flight master.
            Navigation:DeactivatePathHandler()
            Navigation:RefreshPreparedData()
            Navigation:StartCalculation(true)
        end
    end)
end

function Navigation:DeactivateTaxiJourney()
    if rideTimer then rideTimer:Cancel() end
    rideTimer = nil
    activeData = nil
    activeJourney = nil
    activeReport = nil
    bookedDestination = nil
    bookingPending = false
    rideStarted = false
end

-- Manual and automatic bookings share the same ride evidence and close race.
if TakeTaxiNode then
    hooksecurefunc("TakeTaxiNode", function(slot)
        automaticDestination = nil
        local evidence = observation or closingObservation
        if activeData and evidence and IsID(slot) then
            bookedDestination = evidence.destinationsBySlot[slot]
            bookingPending = bookedDestination ~= nil
            Navigation:CancelRouteCalculation(Navigation.activeCalculation)
            Navigation.activeCalculation = nil
        end
    end)
end
Options:SubscribeToOptionChanges("Wayfinder.Navigation.Enable", function(value)
    if value ~= true then automaticDestination = nil end
end)
MapPinEnhanced:RegisterEvent("TAXIMAP_OPENED", Observe)
MapPinEnhanced:RegisterEvent("TAXIMAP_CLOSED", function()
    interactionOpen = false
    closingObservation = observation
    local closed = closingObservation
    C_Timer.After(0, function()
        if closingObservation == closed then
            closingObservation = nil
            if not bookingPending and not rideStarted then RefreshRoutes() end
        end
    end)
    Invalidate()
    -- Do not discard a selected journey between booking and UnitOnTaxi becoming true.
    Navigation:RefreshPreparedData()
end)
MapPinEnhanced:RegisterEvent("TAXI_NODE_STATUS_CHANGED", function()
    if interactionOpen then Observe() else Invalidate() end
end)
for _, event in ipairs({ "PLAYER_ENTERING_WORLD", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA", "QUEST_LOG_UPDATE", "UPDATE_FACTION", "COVENANT_CHOSEN" }) do
    MapPinEnhanced:RegisterEvent(event, function()
        interactionOpen = false
        closingObservation = nil
        Invalidate()
    end)
end
