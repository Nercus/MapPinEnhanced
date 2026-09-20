---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")

---@class NavigationStaticPath
---@field fromPointID number?
---@field fromMap number?
---@field fromX number?
---@field fromY number?
---@field toPointID number
---@field toMap number
---@field toX number
---@field toY number
---@field type string
---@field travelDuration number?
---@field fromTaxiNodeID number?
---@field toTaxiNodeID number?
---@field requirement NavigationRequirement?
---@field gossip NavigationStaticGossip?

---@class NavigationStaticGossip
---@field npcID number
---@field gossipOptionID number

---@class NavigationRequirementCheck
---@field operation "check"
---@field kind string
---@field value any

---@class NavigationRequirementGroup
---@field operation "all"|"any"
---@field children NavigationRequirement[]

---@class NavigationRequirementNot
---@field operation "not"
---@field child NavigationRequirement

---@alias NavigationRequirement NavigationRequirementCheck|NavigationRequirementGroup|NavigationRequirementNot

---@class NavigationPathData
---@field pathType string
---@field paths NavigationStaticPath[]

local registeredPathData = {} ---@type NavigationPathData[]
local navigationGraph ---@type NavigationGraph?
local preparedNavigationData ---@type NavigationPreparedData?

-- Ordinary movement stays available for approaching and leaving transport stops.
local TRANSPORTATION_GROUP_BY_PATH_TYPE = {
    portal = "portals",
    localportal = "portals",
    flighttaxi = "flightPaths",
    ship = "scheduledTransport",
    boat = "scheduledTransport",
    zeppelin = "scheduledTransport",
    tram = "scheduledTransport",
    transport = "scheduledTransport",
    gossip = "npcTravel",
    phaseswitch = "phaseChanges",
    spell = "personalTeleports",
    item = "personalTeleports",
    toy = "personalTeleports",
    dhearth = "personalTeleports",
    unboundteleport = "personalTeleports",
    dungeonteleport = "dungeonTeleports",
}
local disabledTransportationGroups = { dungeonTeleports = true } ---@type table<string, boolean>

---@param pathType string
---@return boolean
local function IsTransportationDisabled(pathType)
    local group = TRANSPORTATION_GROUP_BY_PATH_TYPE[pathType]
    return group ~= nil and disabledTransportationGroups[group] == true
end

---@param groups table<string, boolean>
function Navigation:SetTransportationGroups(groups)
    -- Store our own boolean set; Options and prepared Route snapshots never
    -- share mutable preference state with Navigation.
    local disabled = {} ---@type table<string, boolean>
    for _, group in pairs(TRANSPORTATION_GROUP_BY_PATH_TYPE) do
        disabled[group] = groups[group] ~= true
    end
    disabledTransportationGroups = disabled
    self:RefreshPreparedData()
end

---@return NavigationGraph?
function Navigation:GetGraph()
    return navigationGraph
end

---@return NavigationPreparedData?
function Navigation:GetPreparedData()
    return preparedNavigationData
end

---@class NavigationGraph
---@field pointIDs number[]
---@field pointMapIDs number[]
---@field pointXs number[]
---@field pointYs number[]
---@field pathFromPointIndexes table<integer, integer>
---@field pathToPointIndexes integer[]
---@field pathTypes string[]
---@field pathDurations table<integer, number>
---@field pathRequirements table<integer, table>
---@field pathAdapterData table<integer, any>
---@field currentPlayerPathReferences integer[]
---@field outgoingPathReferences integer[]
---@field firstOutgoingPathByPointIndex integer[]
---@field outgoingPathCountByPointIndex integer[]
---@field excludedPaths table<integer, string>
---@field pathCount integer

---@class NavigationPreparedData
---@field requirementStateByPath table<integer, NavigationRequirementState>
---@field exclusionReasonByPath table<integer, string>
---@field movement NavigationMovementCapabilities

---@param pathType string
---@param paths NavigationStaticPath[]
function Navigation:RegisterPathData(pathType, paths)
    assert(type(pathType) == "string" and pathType ~= "",
        "Navigation:RegisterPathData requires a Path type")
    assert(type(paths) == "table", "Navigation:RegisterPathData requires a Path table")
    table.insert(registeredPathData, { pathType = pathType, paths = paths })
end

---@param graph NavigationGraph
---@param pointIndexByID table<number, integer>
---@param pointID number
---@param mapID number?
---@param x number?
---@param y number?
---@return integer
local function GetOrAddPoint(graph, pointIndexByID, pointID, mapID, x, y)
    local pointIndex = pointIndexByID[pointID]
    if pointIndex then
        if (graph.pointMapIDs[pointIndex] == nil or graph.pointXs[pointIndex] == nil or
                graph.pointYs[pointIndex] == nil) and type(mapID) == "number" and
            type(x) == "number" and type(y) == "number" then
            graph.pointMapIDs[pointIndex] = mapID
            graph.pointXs[pointIndex] = x
            graph.pointYs[pointIndex] = y
        end
        return pointIndex
    end

    pointIndex = #graph.pointIDs + 1
    pointIndexByID[pointID] = pointIndex
    graph.pointIDs[pointIndex] = pointID
    graph.pointMapIDs[pointIndex] = mapID
    graph.pointXs[pointIndex] = x
    graph.pointYs[pointIndex] = y
    return pointIndex
end

---@param path NavigationStaticPath
---@return any adapterData
---@return string? failure
local function PrepareStaticPath(path)
    if type(path.toPointID) ~= "number" or type(path.toMap) ~= "number" or
        type(path.toX) ~= "number" or type(path.toY) ~= "number" then
        return nil, "missing destination"
    end
    if path.toX < 0 or path.toX > 1 or path.toY < 0 or path.toY > 1 then
        return nil, "invalid destination coordinates"
    end
    if path.fromPointID ~= nil and (type(path.fromMap) ~= "number" or
            type(path.fromX) ~= "number" or type(path.fromY) ~= "number") then
        return nil, "missing origin"
    end
    if path.fromPointID ~= nil and
        (path.fromX < 0 or path.fromX > 1 or path.fromY < 0 or path.fromY > 1) then
        return nil, "invalid origin coordinates"
    end
    return Navigation:GetPathData(path)
end

function Navigation:BuildGraph()
    -- Authored IDs are resolved once; runtime routing uses dense point indexes.
    local pointIndexByID = {} ---@type table<number, integer>
    ---@type NavigationGraph
    local graph = {
        pointIDs = {},
        pointMapIDs = {},
        pointXs = {},
        pointYs = {},
        pathFromPointIndexes = {},
        pathToPointIndexes = {},
        pathTypes = {},
        pathDurations = {},
        pathRequirements = {},
        pathAdapterData = {},
        currentPlayerPathReferences = {},
        outgoingPathReferences = {},
        firstOutgoingPathByPointIndex = {},
        outgoingPathCountByPointIndex = {},
        excludedPaths = {},
        pathCount = 0,
    }

    for _, pathData in ipairs(registeredPathData) do
        for _, path in ipairs(pathData.paths) do
            assert(path.type == pathData.pathType,
                "Navigation:RegisterPathData Path type does not match its registered table: " ..
                tostring(pathData.pathType))
            local pathReference = graph.pathCount + 1
            graph.pathCount = pathReference
            ---@type integer?
            local toPointIndex
            if type(path.toPointID) == "number" then
                toPointIndex = GetOrAddPoint(graph, pointIndexByID, path.toPointID, path.toMap, path.toX, path.toY)
            end
            ---@type integer?
            local fromPointIndex
            if type(path.fromPointID) == "number" then
                fromPointIndex = GetOrAddPoint(graph, pointIndexByID, path.fromPointID, path.fromMap, path.fromX,
                    path.fromY)
            end
            local adapterData, failure = PrepareStaticPath(path)
            if failure then
                graph.excludedPaths[pathReference] = failure
            else
                ---@cast toPointIndex integer
                if fromPointIndex then
                    graph.pathFromPointIndexes[pathReference] = fromPointIndex
                else
                    table.insert(graph.currentPlayerPathReferences, pathReference)
                end
                graph.pathToPointIndexes[pathReference] = toPointIndex
                graph.pathTypes[pathReference] = path.type
                graph.pathDurations[pathReference] = path.travelDuration
                graph.pathRequirements[pathReference] = path.requirement
                graph.pathAdapterData[pathReference] = adapterData
                if fromPointIndex then
                    graph.outgoingPathCountByPointIndex[fromPointIndex] =
                        (graph.outgoingPathCountByPointIndex[fromPointIndex] or 0) + 1
                end
            end
        end
    end

    local nextOffset = 1
    local nextPathOffsetByPointIndex = {} ---@type integer[]
    for pointIndex = 1, #graph.pointIDs do
        graph.firstOutgoingPathByPointIndex[pointIndex] = nextOffset
        nextPathOffsetByPointIndex[pointIndex] = nextOffset
        nextOffset = nextOffset + (graph.outgoingPathCountByPointIndex[pointIndex] or 0)
    end
    for pathReference = 1, graph.pathCount do
        local fromPointIndex = graph.pathFromPointIndexes[pathReference]
        if fromPointIndex then
            local offset = nextPathOffsetByPointIndex[fromPointIndex]
            graph.outgoingPathReferences[offset] = pathReference
            nextPathOffsetByPointIndex[fromPointIndex] = offset + 1
        end
    end

    navigationGraph = graph
    registeredPathData = {}
    self:RefreshPreparedData()
end

-- Character requirement preparation
---@alias NavigationRequirementState "satisfied"|"unsatisfied"|"unknown"

local SATISFIED = "satisfied"
local UNSATISFIED = "unsatisfied"
local UNKNOWN = "unknown"

---@param result boolean?
---@return NavigationRequirementState
local function StateFromBoolean(result)
    if result == nil then return UNKNOWN end
    return result and SATISFIED or UNSATISFIED
end

---@param itemID any
---@return NavigationRequirementState
local function EvaluateToyOwnership(itemID)
    if type(itemID) ~= "number" or not PlayerHasToy then return UNKNOWN end
    return StateFromBoolean(PlayerHasToy(itemID))
end

-- Generated toy Paths pair tagged item and toy checks under one all operation.
---@param requirement NavigationRequirement
---@return number?
local function GetQualifiedToyItemID(requirement)
    if requirement.operation ~= "all" or type(requirement.children) ~= "table" or
        #requirement.children ~= 2 then
        return nil
    end
    ---@type number?
    local itemID
    local hasToyQualifier = false
    for _, child in ipairs(requirement.children) do
        if type(child) ~= "table" then return nil end
        if child.operation == "check" and child.kind == "item" and
            type(child.value) == "number" and not itemID then
            itemID = child.value
        elseif child.operation == "check" and child.kind == "toy" and
            child.value == true and not hasToyQualifier then
            hasToyQualifier = true
        else
            return nil
        end
    end
    return hasToyQualifier and itemID or nil
end

---@param value any
---@param expected any
---@return boolean
local function ValueMatches(value, expected)
    if type(expected) ~= "table" then return value == expected end
    ---@cast expected any[]
    for _, accepted in ipairs(expected) do
        if value == accepted then return true end
    end
    return false
end

---@param key string
---@param value any
---@return NavigationRequirementState
local function EvaluateDirectCheck(key, value)
    if key == "faction" then
        return StateFromBoolean(ValueMatches(UnitFactionGroup("player"), value))
    elseif key == "class" then
        local class = select(2, UnitClass("player"))
        return StateFromBoolean(ValueMatches(class, value))
    elseif key == "race" then
        local race = select(2, UnitRace("player"))
        return StateFromBoolean(ValueMatches(race, value))
    elseif key == "level" then
        if type(value) ~= "number" then return UNKNOWN end
        return StateFromBoolean(UnitLevel("player") == value)
    elseif key == "minLevel" then
        if type(value) ~= "number" then return UNKNOWN end
        return StateFromBoolean(UnitLevel("player") >= value)
    elseif key == "minLevelExclusive" then
        if type(value) ~= "number" then return UNKNOWN end
        return StateFromBoolean(UnitLevel("player") > value)
    elseif key == "maxLevelExclusive" then
        if type(value) ~= "number" then return UNKNOWN end
        return StateFromBoolean(UnitLevel("player") < value)
    elseif key == "questCompleted" then
        if type(value) ~= "number" then return UNKNOWN end
        if not C_QuestLog or not C_QuestLog.IsQuestFlaggedCompleted then return UNKNOWN end
        return StateFromBoolean(C_QuestLog.IsQuestFlaggedCompleted(value))
    elseif key == "questActive" then
        if type(value) ~= "number" then return UNKNOWN end
        if not C_QuestLog or not C_QuestLog.IsOnQuest then return UNKNOWN end
        return StateFromBoolean(C_QuestLog.IsOnQuest(value))
    elseif key == "questActiveOrComplete" then
        if type(value) ~= "number" then return UNKNOWN end
        if not C_QuestLog or not C_QuestLog.IsQuestFlaggedCompleted or not C_QuestLog.IsOnQuest then return UNKNOWN end
        return StateFromBoolean(C_QuestLog.IsQuestFlaggedCompleted(value) or C_QuestLog.IsOnQuest(value))
    elseif key == "spell" or key == "spellKnown" then
        if type(value) ~= "number" then return UNKNOWN end
        if IsPlayerSpell then return StateFromBoolean(IsPlayerSpell(value)) end
        if IsSpellKnown then return StateFromBoolean(IsSpellKnown(value)) end
        return UNKNOWN
    elseif key == "item" then
        if type(value) ~= "number" then return UNKNOWN end
        if C_Item and C_Item.GetItemCount then return StateFromBoolean(C_Item.GetItemCount(value) > 0) end
        if GetItemCount then return StateFromBoolean(GetItemCount(value) > 0) end
        return UNKNOWN
    elseif key == "toy" or key == "toyKnown" then
        return EvaluateToyOwnership(value)
    elseif key == "achievement" then
        if type(value) ~= "number" then return UNKNOWN end
        if not GetAchievementInfo then return UNKNOWN end
        local completed = select(4, GetAchievementInfo(value))
        return StateFromBoolean(completed)
    elseif key == "mapArtID" then
        if type(value) ~= "table" or type(value[1]) ~= "number" or type(value[2]) ~= "number" or
            not C_Map or not C_Map.GetMapArtID then
            return UNKNOWN
        end
        return StateFromBoolean(C_Map.GetMapArtID(value[1]) == value[2])
    elseif key == "currentMap" then
        if not C_Map or not C_Map.GetBestMapForUnit then return UNKNOWN end
        local mapID = C_Map.GetBestMapForUnit("player")
        if not mapID then return UNKNOWN end
        return StateFromBoolean(ValueMatches(mapID, value))
    elseif key == "buff" then
        if type(value) ~= "number" or not AuraUtil or not AuraUtil.FindAuraBySpellID then return UNKNOWN end
        return StateFromBoolean(AuraUtil.FindAuraBySpellID(value, "player") ~= nil)
    elseif key == "covenant" then
        if not C_Covenants or not C_Covenants.GetActiveCovenantID then return UNKNOWN end
        return StateFromBoolean(ValueMatches(C_Covenants.GetActiveCovenantID(), value))
    elseif key == "chromieTime" then
        if type(value) ~= "number" then return UNKNOWN end
        if not C_ChromieTime or not C_ChromieTime.GetChromieTimeExpansionOption then return UNKNOWN end
        local option = C_ChromieTime.GetChromieTimeExpansionOption(value)
        return StateFromBoolean(option and option.alreadyOn)
    end
    return UNKNOWN
end

---@param requirement NavigationRequirement?
---@return NavigationRequirementState state
---@return string? failure
function Navigation:EvaluateRequirement(requirement)
    if requirement == nil then return SATISFIED end
    if type(requirement) ~= "table" then return UNKNOWN, "invalid requirement" end

    local toyItemID = GetQualifiedToyItemID(requirement)
    if toyItemID then
        local state = EvaluateToyOwnership(toyItemID)
        if state == UNKNOWN then return state, "toy ownership unavailable" end
        return state
    end

    local operation = requirement.operation
    if operation == "all" or operation == "any" then
        local children = requirement.children
        if type(children) ~= "table" or #children == 0 then return UNKNOWN, "empty requirement group" end
        local sawUnknown = false
        local unknownFailure ---@type string?
        for _, child in ipairs(children) do
            local state, failure = self:EvaluateRequirement(child)
            if operation == "all" and state == UNSATISFIED then return UNSATISFIED end
            if operation == "any" and state == SATISFIED then return SATISFIED end
            if state == UNKNOWN then
                sawUnknown = true
                unknownFailure = unknownFailure or failure
            end
        end
        if sawUnknown then return UNKNOWN, unknownFailure or "requirement unavailable" end
        return operation == "all" and SATISFIED or UNSATISFIED
    elseif operation == "not" then
        local state, failure = self:EvaluateRequirement(requirement.child)
        if state == UNKNOWN then return UNKNOWN, failure or "requirement unavailable" end
        return state == SATISFIED and UNSATISFIED or SATISFIED
    elseif operation ~= "check" or type(requirement.kind) ~= "string" then
        return UNKNOWN, "invalid requirement shape"
    end

    local state = EvaluateDirectCheck(requirement.kind, requirement.value)
    if state == UNKNOWN then
        return state, "unsupported or unavailable requirement: " .. requirement.kind
    end
    return state
end

---@param requirement NavigationRequirement?
---@param resourceKey string
---@return number?
function Navigation:GetRequirementResource(requirement, resourceKey)
    if type(requirement) ~= "table" then return nil end
    if resourceKey == "toy" then
        local toyItemID = GetQualifiedToyItemID(requirement)
        if toyItemID then return toyItemID end
    end

    if requirement.operation == "check" then
        local matchesResource = requirement.kind == resourceKey or
            resourceKey == "toy" and requirement.kind == "toyKnown" or
            resourceKey == "spell" and requirement.kind == "spellKnown"
        return matchesResource and type(requirement.value) == "number" and requirement.value or nil
    end
    if requirement.operation ~= "all" and requirement.operation ~= "any" or
        type(requirement.children) ~= "table" then
        return nil
    end

    ---@type number?
    local found
    for _, child in ipairs(requirement.children) do
        local childValue = self:GetRequirementResource(child, resourceKey)
        if childValue then
            if found then return nil end
            found = childValue
        end
    end
    return found
end

function Navigation:RefreshPreparedData()
    local graph = navigationGraph
    if not graph then return end
    ---@type NavigationPreparedData
    local preparedData = {
        requirementStateByPath = {},
        exclusionReasonByPath = {},
        movement = Navigation:GetMovementCapabilities(),
    }
    for pathReference = 1, graph.pathCount do
        local staticFailure = graph.excludedPaths[pathReference]
        if IsTransportationDisabled(graph.pathTypes[pathReference]) then
            preparedData.requirementStateByPath[pathReference] = UNSATISFIED
            preparedData.exclusionReasonByPath[pathReference] = "transportation group disabled"
        elseif staticFailure then
            preparedData.requirementStateByPath[pathReference] = UNKNOWN
            preparedData.exclusionReasonByPath[pathReference] = staticFailure
        else
            local state, failure = self:EvaluateRequirement(graph.pathRequirements[pathReference])
            preparedData.requirementStateByPath[pathReference] = state
            if state ~= SATISFIED then
                preparedData.exclusionReasonByPath[pathReference] = failure or state
            end
        end
    end
    preparedNavigationData = preparedData
end

-- Failure recovery reads a new requirement observation without mutating any
-- prepared snapshot held by a running calculation or retained Route.
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
function Navigation:GetFreshPathCost(pathReference)
    local graph = navigationGraph
    if not graph then return nil, "navigation data is not ready" end
    if IsTransportationDisabled(graph.pathTypes[pathReference]) then
        return nil, "transportation group disabled"
    end
    if graph.excludedPaths[pathReference] then return nil, graph.excludedPaths[pathReference] end
    local state, failure = self:EvaluateRequirement(graph.pathRequirements[pathReference])
    if state ~= SATISFIED then return nil, failure or state end
    return self:GetPathCost(graph, {
        requirementStateByPath = { [pathReference] = state },
        exclusionReasonByPath = {},
        movement = self:GetMovementCapabilities(),
    }, pathReference)
end
