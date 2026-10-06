---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Pins = MapPinEnhanced:GetModule("Pins")

---@class NavigationPathPresentationContext
---@field destinationName string?
---@field originName string? Only supplied when repeated portal destinations need disambiguation
---@field requirement NavigationRequirement?
---@field phase "approach"|"ready"|"in-transit"?

---@alias NavigationPathPresentation fun(context: NavigationPathPresentationContext?): icon: string, method: string, instruction: string
---@alias NavigationPathDataprovider fun(path: NavigationStaticPath): data: any, failure: string?
---@alias NavigationPathCostCalculator fun(graph: NavigationGraph, preparedData: NavigationPreparedData, pathReference: integer): cost: NavigationCalculatedPathCost?, failure: string?
---@alias NavigationPathActivator fun(context: NavigationActivePathContext, report: NavigationPathReport)
---@alias NavigationPathDeactivator fun()

---@class NavigationActivePathContext
---@field pathType string
---@field pathReference integer
---@field phase "approach"|"ready"|"in-transit"
---@field requirement NavigationRequirement?
---@field data any
---@field taxiJourney NavigationTaxiJourney?

---@alias NavigationPathReport fun(result: "check-completion"|"attempted"|"completed"|"failed", detail: string?)

---@type table<string, NavigationPathPresentation>
local presentations = {}
---@type table<string, NavigationPathDataprovider>
local dataproviders = {}
---@type table<string, NavigationPathCostCalculator>
local costCalculators = {}
---@type table<string, NavigationPathActivator>
local activators = {}
---@type table<string, NavigationPathDeactivator>
local deactivators = {}
local activePathType ---@type string?
local activePathReference ---@type integer?
local activeReport ---@type NavigationPathReport?
local unsubscribeProgressEvents ---@type function?

local PROGRESS_EVENTS = {
    "PLAYER_ENTERING_WORLD",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA",
    "LOADING_SCREEN_DISABLED",
}

---@param pathType string
---@param presentation NavigationPathPresentation
---@param dataprovider NavigationPathDataprovider?
---@param costCalculator NavigationPathCostCalculator?
---@param activator NavigationPathActivator?
---@param deactivator NavigationPathDeactivator?
function Navigation:RegisterPathHandler(pathType, presentation, dataprovider, costCalculator, activator, deactivator)
    assert(type(pathType) == "string" and pathType ~= "", "Navigation:RegisterPathHandler requires a Path type")
    assert(type(presentation) == "function", "Navigation:RegisterPathHandler requires a presentation function")
    assert(dataprovider == nil or type(dataprovider) == "function",
        "Navigation:RegisterPathHandler dataprovider must be a function or nil")
    assert(costCalculator == nil or type(costCalculator) == "function",
        "Navigation:RegisterPathHandler cost calculator must be a function or nil")
    assert(activator == nil or type(activator) == "function",
        "Navigation:RegisterPathHandler activator must be a function or nil")
    assert(deactivator == nil or type(deactivator) == "function",
        "Navigation:RegisterPathHandler deactivator must be a function or nil")
    assert(activator ~= nil or deactivator == nil,
        "Navigation:RegisterPathHandler deactivator requires an activator")
    assert(not presentations[pathType],
        "Navigation:RegisterPathHandler path type is already registered: " .. pathType)
    presentations[pathType] = presentation
    dataproviders[pathType] = dataprovider
    costCalculators[pathType] = costCalculator
    activators[pathType] = activator
    deactivators[pathType] = deactivator
end

---@param path NavigationStaticPath
---@return any data
---@return string? failure
function Navigation:GetPathData(path)
    if not presentations[path.type] then return nil, "unsupported path type" end
    local dataprovider = dataproviders[path.type]
    if dataprovider then return dataprovider(path) end
    return nil
end

---@param pathType string
---@param context NavigationPathPresentationContext?
---@return string icon
---@return string method
---@return string instruction
local function GetPresentation(pathType, context)
    local presentation = presentations[pathType]
    assert(presentation, "Navigation path type is not registered: " .. tostring(pathType))
    local icon, method, instruction = presentation(context)
    assert(Pins.PIN_ICONS[Pins:ResolveIcon(icon)], "Navigation handler PIN_ICONS entry is missing: " .. tostring(icon))
    assert(type(method) == "string" and method ~= "", "Navigation handler method is missing: " .. pathType)
    assert(type(instruction) == "string" and instruction ~= "",
        "Navigation handler instruction is missing: " .. pathType)
    return icon, method, instruction
end

---@param pathType string
---@return string icon
function Navigation:GetPathIcon(pathType)
    local icon = GetPresentation(pathType, nil)
    return icon
end

---@param pathType string
---@return ColorMixin
function Navigation:GetPathColor(pathType)
    local icon = self:GetPathIcon(pathType)
    return Pins.PIN_ICONS[Pins:ResolveIcon(icon)].color
end

---@param pathType string
---@return string
function Navigation:GetPathMethod(pathType)
    local presentation = presentations[pathType]
    if not presentation then return MapPinEnhanced.L["Navigation Method Travel"] end
    local _, method = GetPresentation(pathType, nil)
    return method
end

---@param mapID number?
---@return string?
local function GetMapName(mapID)
    local info = mapID and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(mapID)
    if MapPinEnhanced:IsReadableTable(info) and info then return MapPinEnhanced:NormalizeText(info.name) end
end

---@param route NavigationRoute
---@param pathIndex integer
---@param phase "approach"|"ready"|"in-transit"?
---@return string
function Navigation:GetPathInstruction(route, pathIndex, phase)
    local graph = route.graph
    local reference = route.pathReferences[pathIndex]
    local pathType = graph.pathTypes[reference]
    -- Movement immediately before an interaction describes that action on every
    -- surface. Its own endpoint and arrival rules are unaffected.
    if self:IsMovementPath(pathType) then
        local nextReference = route.pathReferences[pathIndex + 1]
        if nextReference and not self:IsMovementPath(graph.pathTypes[nextReference]) then
            return self:GetPathInstruction(route, pathIndex + 1, "approach")
        end
    end
    local destinationMapID = graph.pointMapIDs[graph.pathToPointIndexes[reference]]
    local journey = route.taxiJourneys[reference]
    local destinationName = journey and MapPinEnhanced:NormalizeText(journey.destinationName) or
        pathType == "hearthstone" and MapPinEnhanced:NormalizeText(graph.hearthstoneBindName) or nil
    local originName ---@type string?
    if pathType == "portal" or pathType == "localportal" then
        local origin = graph.pathFromPointIndexes[reference]
        local originMapID = origin and graph.pointMapIDs[origin]
        -- The normal instruction stays short. Origins distinguish repeated visits
        -- to the same destination through portals in different maps on this Route.
        for _, other in ipairs(route.pathReferences) do
            local otherType = graph.pathTypes[other]
            local otherOrigin = graph.pathFromPointIndexes[other]
            if (otherType == "portal" or otherType == "localportal") and otherOrigin and
                graph.pointMapIDs[graph.pathToPointIndexes[other]] == destinationMapID and
                graph.pointMapIDs[otherOrigin] ~= originMapID then
                originName = GetMapName(originMapID)
                break
            end
        end
    end
    local _, _, instruction = GetPresentation(pathType, {
        destinationName = destinationName or GetMapName(graph.pathDestinationNameMapIDs[reference]) or
            GetMapName(destinationMapID),
        originName = originName,
        requirement = graph.pathRequirements[reference],
        phase = phase,
    })
    return instruction
end

---@param pathType string
---@return boolean
function Navigation:IsMovementPath(pathType)
    return pathType == "walk" or pathType == "fly"
end

---@param pathType string
---@return "automatic"|"ground"|"flight"
function Navigation:GetPathApproachMode(pathType)
    if pathType == "walk" then return "ground" end
    if pathType == "fly" then return "flight" end
    return "automatic"
end

---@param graph NavigationGraph
---@param preparedData NavigationPreparedData
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
function Navigation:GetPathCost(graph, preparedData, pathReference)
    if preparedData.requirementStateByPath[pathReference] ~= "satisfied" then
        return nil, preparedData.exclusionReasonByPath[pathReference] or "requirement not satisfied"
    end
    local pathType = graph.pathTypes[pathReference]
    if not presentations[pathType] then return nil, "unsupported path type" end
    local costCalculator = costCalculators[pathType]
    if costCalculator then return costCalculator(graph, preparedData, pathReference) end

    local duration = graph.pathDurations[pathReference]
    if type(duration) ~= "number" or duration <= 0 or duration == math.huge then
        return nil, "missing or invalid duration"
    end
    return {
        expectedSeconds = duration,
        uncertaintySeconds = 0,
        comparisonSeconds = duration,
        explanation = { kind = "fixed", seconds = duration },
    }
end

function Navigation:SetupPathHandlers()
    if unsubscribeProgressEvents then return end
    unsubscribeProgressEvents = MapPinEnhanced:RegisterEventBucket(PROGRESS_EVENTS, function()
        if activeReport then activeReport("check-completion") end
    end)
end

function Navigation:DeactivatePathHandler()
    local pathType = activePathType
    activePathType = nil
    activePathReference = nil
    activeReport = nil
    local deactivator = pathType and deactivators[pathType] or nil
    if deactivator then deactivator() end
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
function Navigation:ActivatePathHandler(context, report)
    assert(presentations[context.pathType],
        "Navigation:ActivatePathHandler path type is not registered: " .. context.pathType)
    local activator = activators[context.pathType]
    if activePathType == context.pathType and activePathReference == context.pathReference then
        activeReport = report
        if activator then activator(context, report) end
        return
    end
    self:DeactivatePathHandler()
    activePathType = context.pathType
    activePathReference = context.pathReference
    activeReport = report
    if activator then activator(context, report) end
end
