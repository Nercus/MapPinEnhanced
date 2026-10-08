---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local reportWindow ---@type MapPinEnhancedNavigationReportTemplate?

-- Only selected plain data enters the dump. Format immediately so the copy
-- window cannot retain live route state or change while the player moves.
---@param value any
---@return string
local function FormatValue(value)
    if issecretvalue and issecretvalue(value) then return "<secret>" end
    if type(value) == "string" then return string.format("%q", value) end
    if type(value) ~= "table" then return tostring(value) end
    ---@cast value table<any, any>
    local entries = {} ---@type string[]
    for key, child in pairs(value) do
        entries[#entries + 1] = tostring(key) .. "=" .. FormatValue(child)
    end
    table.sort(entries)
    return "{" .. table.concat(entries, ", ") .. "}"
end

---@param graph NavigationGraph
---@param index integer?
---@return table?
local function GetPoint(graph, index)
    if not index then return nil end
    return {
        id = graph.pointIDs[index],
        mapID = graph.pointMapIDs[index],
        x = graph.pointXs[index],
        y = graph.pointYs[index]
    }
end

function Navigation:ShowDebugDump()
    local lines = { "Map Pin Enhanced navigation dump" }
    local function Add(label, value)
        lines[#lines + 1] = label .. ": " .. FormatValue(value)
    end
    local version, build, buildDate, interfaceVersion = GetBuildInfo()
    Add("Environment", {
        addon = C_AddOns.GetAddOnMetadata(MapPinEnhanced.name, "Version"),
        version = version,
        build = build,
        buildDate = buildDate,
        interfaceVersion = interfaceVersion,
        locale = GetLocale(),
        combat = InCombatLockdown(),
        faction = UnitFactionGroup("player")
    })
    local playerX, playerY, playerMapID = MapPinEnhanced.HBD:GetPlayerZonePosition()
    Add("Player", {
        mapID = playerMapID,
        x = playerX,
        y = playerY,
        mapArtID = playerMapID and C_Map.GetMapArtID(playerMapID)
    })
    local destination = Navigation.activeDestination
    Add("Destination", destination and {
        owner = destination.owner,
        id = destination.destinationID,
        changeNumber = destination.changeNumber,
        data = destination.data,
        routingData = destination.routingData
    })
    Add("Navigation enabled", Navigation.routeNavigationEnabled)
    Add("Step", Wayfinders:GetStepSnapshot())
    Add("Action display", Wayfinders:GetActionDebugText())
    Add("Calculation active", Navigation.activeCalculation ~= nil)
    Add("Calculation termination", Navigation.lastCalculationTermination)
    Add("Background search", Navigation.activeCalculation and Navigation.activeCalculation.background)
    local job = Navigation.activeCalculation
    local completedRoute = Navigation.progression and Navigation.progression.route
    Add("Calculation work", job and {
            elapsedSeconds = GetTimePreciseSec() - job.startedAt,
            slices = job.calculationSlices,
            movementCandidates = job.movementCandidates,
            queuedPoints = #job.heap
        } or
        completedRoute and {
            elapsedSeconds = completedRoute.calculationSeconds,
            slices = completedRoute.calculationSlices,
            movementCandidates = completedRoute.movementCandidates
        })
    Add("Last calculation failure", Navigation.lastCalculationFailure)
    Add("Last calculation exclusions", Navigation.lastCalculationExclusions)
    Add("Avoided paths", Navigation.avoidedPaths)
    Add("Movement now", Navigation:GetMovementCapabilities())

    local waypoint = C_Map.GetUserWaypoint()
    Add("Blizzard user waypoint", waypoint and {
        mapID = waypoint.uiMapID,
        x = waypoint.position.x,
        y = waypoint.position.y
    })
    Add("Blizzard tracking type", C_SuperTrack.GetHighestPrioritySuperTrackingType())
    if playerMapID then
        local x, y, description = MapPinEnhanced:GetModule("Providers"):GetNavigationWaypointForMap(playerMapID)
        Add("Blizzard next waypoint on player map", {
            mapID = playerMapID,
            x = x,
            y = y,
            description = description
        })
    end

    local graph = Navigation.progression and Navigation.progression.route.graph or Navigation:GetGraph()
    Add("Taxi observation", Navigation:GetTaxiObservation())
    local prepared = Navigation:GetPreparedData()
    local progression = Navigation.progression
    local route = progression and progression.route
    if progression then
        Add("Progression", {
            pathIndex = progression.pathIndex,
            phase = progression.phase,
            changeNumber = progression.changeNumber,
            status = progression.status,
            attempted = progression.attempted,
            pathUnavailable = progression.pathUnavailable
        })
    end
    if route then
        Add("Route", {
            signature = route.signature,
            comparisonSeconds = route.comparisonSeconds,
            calculationID = route.calculationID,
            pathReferences = route.pathReferences,
            taxiJourneys = route.taxiJourneys,
            taxiObservation = route.preparedData.taxiObservation,
            originMapID = route.originMapID,
            originX = route.originX,
            originY = route.originY,
            finalCost = route.finalCost,
            movement = route.preparedData.movement
        })
    end
    if graph then
        local hearthstoneDestination ---@type NavigationHearthstoneDestination?
        for _, reference in ipairs(graph.currentPlayerPathReferences) do
            if graph.pathTypes[reference] == "hearthstone" then
                local point = graph.pathToPointIndexes[reference]
                if graph.pointMapIDs[point] > 0 then
                    hearthstoneDestination = {
                        mapID = graph.pointMapIDs[point],
                        x = graph.pointXs[point],
                        y = graph.pointYs[point],
                        bindName = graph.hearthstoneBindName
                    }
                end
                break
            end
        end
        Add("Hearthstone destination", hearthstoneDestination)
        ---@param reference integer
        ---@param cost NavigationCalculatedPathCost?
        local function AddPath(reference, cost)
            local freshCost, failure = Navigation:GetFreshPathCost(reference)
            ---@type NavigationFlightTaxiData?
            local taxi = graph.pathTypes[reference] == "flighttaxi" and graph.pathHandlerData[reference] or nil
            Add("Path " .. reference, {
                type = graph.pathTypes[reference],
                from = GetPoint(graph, graph.pathFromPointIndexes[reference]),
                to = GetPoint(graph, graph.pathToPointIndexes[reference]),
                requirement = graph.pathRequirements[reference],
                preparedState = prepared and prepared.requirementStateByPath[reference],
                preparedExclusion = prepared and prepared.exclusionReasonByPath[reference],
                routeState = route and not route.preparedData.movementOnly and
                    route.preparedData.requirementStateByPath[reference],
                routeExclusion = route and not route.preparedData.movementOnly and
                    route.preparedData.exclusionReasonByPath[reference],
                routeCost = cost,
                freshCost = freshCost,
                freshFailure = failure,
                taxi = taxi and {
                    origin = taxi.fromTaxiNodeID,
                    destination = taxi.toTaxiNodeID,
                    destinationKnown = taxi.toTaxiNodeID and Navigation:IsTaxiNodeKnown(taxi.toTaxiNodeID),
                    preparedCost = prepared and prepared.taxiCosts[reference],
                    preparedFailure = prepared and prepared.taxiFailures[reference]
                } or nil
            })
        end
        lines[#lines + 1] = "Ordered route paths:"
        if route then
            for index, reference in ipairs(route.pathReferences) do
                Add("Route leg", index)
                AddPath(reference, route.pathCosts[index])
            end
        end
        -- Toys have no entrance on the player map; include rejected candidates too.
        lines[#lines + 1] = "Toy paths:"
        for reference = 1, graph.pathCount do
            if graph.pathTypes[reference] == "toy" then
                AddPath(reference)
            end
        end
        -- Include rejected local portals, which never appear in the winning route.
        lines[#lines + 1] = "Portals from player map:"
        for reference = 1, graph.pathCount do
            local pathType = graph.pathTypes[reference]
            local fromIndex = graph.pathFromPointIndexes[reference]
            if fromIndex and graph.pointMapIDs[fromIndex] == playerMapID and
                (pathType == "portal" or pathType == "localportal") then
                AddPath(reference)
            end
        end
        lines[#lines + 1] = "Taxi paths from player map:"
        for reference = 1, graph.pathCount do
            local fromIndex = graph.pathFromPointIndexes[reference]
            if graph.pathTypes[reference] == "flighttaxi" and fromIndex and
                graph.pointMapIDs[fromIndex] == playerMapID then
                AddPath(reference)
            end
        end
    end
    if not reportWindow then
        reportWindow = CreateFrame("Frame", "MapPinEnhancedNavigationReport", UIParent,
            "MapPinEnhancedNavigationReportTemplate") --[[@as MapPinEnhancedNavigationReportTemplate]]
    end
    reportWindow:OpenReport(table.concat(lines, "\n"))
end

MapPinEnhanced:AddSlashCommand("navdebug", function()
    Navigation:ShowDebugDump()
end, MapPinEnhanced.L["Navigation Debug Dump"], false)
