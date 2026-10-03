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
---@field taxiPathIDs integer[]?
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
---@field children NavigationRequirement[]

---@alias NavigationRequirement NavigationRequirementCheck|NavigationRequirementGroup|NavigationRequirementNot

---@class NavigationPathData
---@field pathType string
---@field paths NavigationStaticPath[]

local registeredPathData = {} ---@type NavigationPathData[]
local navigationGraph ---@type NavigationGraph?
local preparedNavigationData ---@type NavigationPreparedData?
local preparedDataDirty = true
local preparationChangeNumber = 0
local cancelPreparation ---@type fun()?
local preparationFailure ---@type string?
local hearthstonePathReferences = {} ---@type integer[]
local hasBuffRequirements = false

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
    hearthstone = "personalTeleports",
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
---@field pathHandlerData table<integer, any>
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
---@field taxiObservation NavigationTaxiObservation?
---@field taxiCosts table<integer, NavigationCalculatedPathCost>
---@field taxiFailures table<integer, string>

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
---@return any handlerData
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

---@param requirement NavigationRequirement?
---@return boolean
local function HasBuffRequirement(requirement)
    if type(requirement) ~= "table" then return false end
    if requirement.operation == "check" then return requirement.kind == "buff" end
    if type(requirement.children) == "table" then
        for _, child in ipairs(requirement.children) do
            if HasBuffRequirement(child) then return true end
        end
    end
    return false
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
        pathHandlerData = {},
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
            local handlerData, failure = PrepareStaticPath(path)
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
                graph.pathHandlerData[pathReference] = handlerData
                if fromPointIndex then
                    graph.outgoingPathCountByPointIndex[fromPointIndex] =
                        (graph.outgoingPathCountByPointIndex[fromPointIndex] or 0) + 1
                end
            end
        end
    end

    -- Reserve one stable runtime endpoint after the generated graph. Its
    -- coordinates are replaced on binding without rebuilding authored Paths.
    local hearthstonePointIndex = #graph.pointIDs + 1
    graph.pointIDs[hearthstonePointIndex] = -1
    graph.pointMapIDs[hearthstonePointIndex] = 0
    graph.pointXs[hearthstonePointIndex] = 0
    graph.pointYs[hearthstonePointIndex] = 0
    local items = {} ---@type number[]
    for itemID in pairs(self.hearthstoneItems) do table.insert(items, itemID) end
    table.sort(items)
    for _, itemID in ipairs(items) do
        local reference = graph.pathCount + 1
        graph.pathCount = reference
        graph.pathToPointIndexes[reference] = hearthstonePointIndex
        graph.pathTypes[reference] = "hearthstone"
        graph.pathRequirements[reference] = {
            operation = "check", kind = itemID == 6948 and "item" or "toy", value = itemID,
        }
        graph.excludedPaths[reference] = "hearthstone destination unknown"
        table.insert(graph.currentPlayerPathReferences, reference)
        table.insert(hearthstonePathReferences, reference)
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

    self:IndexTaxiConnections(graph)
    hasBuffRequirements = false
    for _, requirement in pairs(graph.pathRequirements) do
        if HasBuffRequirement(requirement) then
            hasBuffRequirements = true
            break
        end
    end
    navigationGraph = graph
    preparedNavigationData = nil
    registeredPathData = {}
    self:RefreshPreparedData()
end

---@param destination NavigationHearthstoneDestination?
function Navigation:UpdateHearthstonePath(destination)
    local graph = navigationGraph
    local reference = hearthstonePathReferences[1]
    if not graph or not reference then return end
    local point = graph.pathToPointIndexes[reference]
    -- Existing Routes and jobs own immutable geometry. Share the static arrays,
    -- copying only the arrays whose hearth endpoint changes.
    local replacement = CopyTable(graph, true) ---@type NavigationGraph
    replacement.pointMapIDs = CopyTable(graph.pointMapIDs)
    replacement.pointXs = CopyTable(graph.pointXs)
    replacement.pointYs = CopyTable(graph.pointYs)
    replacement.excludedPaths = CopyTable(graph.excludedPaths)
    replacement.pointMapIDs[point] = destination and destination.mapID or 0
    replacement.pointXs[point] = destination and destination.x or 0
    replacement.pointYs[point] = destination and destination.y or 0
    for _, hearthReference in ipairs(hearthstonePathReferences) do
        replacement.excludedPaths[hearthReference] = not destination and "hearthstone destination unknown" or nil
        self.avoidedPaths[hearthReference] = nil
    end
    navigationGraph = replacement
    self:RefreshPreparedData()
    self:RefreshHearthstoneRoute()
end

-- Character requirement preparation
---@alias NavigationRequirementState "satisfied"|"unsatisfied"|"unknown"

local SATISFIED = "satisfied"
local UNSATISFIED = "unsatisfied"
local UNKNOWN = "unknown"

---@param result boolean?
---@return NavigationRequirementState
local function StateFromBoolean(result)
    if MapPinEnhanced:IsSecretValue(result) or type(result) ~= "boolean" then return UNKNOWN end
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
    if key == "taxiNodeKnown" then
        if type(value) ~= "number" then return UNKNOWN end
        return StateFromBoolean(Navigation:IsTaxiNodeKnown(value))
    elseif key == "event" then
        if type(value) ~= "string" then return UNKNOWN end
        return StateFromBoolean(Navigation:IsCalendarEventActive(value))
    elseif key == "mapPOIPresent" then
        if type(value) ~= "table" or type(value.mapID) ~= "number" or type(value.poiID) ~= "number" or
            not C_AreaPoiInfo or not C_AreaPoiInfo.GetAreaPOIForMap then return UNKNOWN end
        local poiIDs = C_AreaPoiInfo.GetAreaPOIForMap(value.mapID)
        if not MapPinEnhanced:IsReadableTable(poiIDs) then return UNKNOWN end
        local sawUnknown = false
        for _, poiID in ipairs(poiIDs) do
            if MapPinEnhanced:IsSecretValue(poiID) or type(poiID) ~= "number" then
                sawUnknown = true
            elseif poiID == value.poiID then
                return SATISFIED
            end
        end
        return sawUnknown and UNKNOWN or UNSATISFIED
    elseif key == "mapOverlayTexture" then
        if type(value) ~= "table" or type(value.mapID) ~= "number" or type(value.textureID) ~= "number" or
            not C_MapExplorationInfo or not C_MapExplorationInfo.GetExploredMapTextures then return UNKNOWN end
        local textures = C_MapExplorationInfo.GetExploredMapTextures(value.mapID)
        if not MapPinEnhanced:IsReadableTable(textures) or not MapPinEnhanced:IsReadableTable(textures[1]) or
            not MapPinEnhanced:IsReadableTable(textures[1].fileDataIDs) then return UNKNOWN end
        -- The source invasion selector observes the first overlay's first texture.
        local textureID = textures[1].fileDataIDs[1]
        if MapPinEnhanced:IsSecretValue(textureID) or type(textureID) ~= "number" then return UNKNOWN end
        return StateFromBoolean(textureID == value.textureID)
    elseif key == "contributionStateMin" then
        if type(value) ~= "table" or type(value.collectorID) ~= "number" or type(value.state) ~= "number" or
            not C_ContributionCollector or not C_ContributionCollector.GetState then return UNKNOWN end
        local state = C_ContributionCollector.GetState(value.collectorID)
        if MapPinEnhanced:IsSecretValue(state) or type(state) ~= "number" or
            state == Enum.ContributionState.None then return UNKNOWN end
        return StateFromBoolean(state >= value.state)
    elseif key == "garrison" then
        if type(value) ~= "table" or type(value.type) ~= "number" or type(value.level) ~= "number" or
            not C_Garrison or not C_Garrison.GetGarrisonInfo then return UNKNOWN end
        local level = C_Garrison.GetGarrisonInfo(value.type)
        if MapPinEnhanced:IsSecretValue(level) or type(level) ~= "number" then return UNKNOWN end
        return StateFromBoolean(level == value.level)
    elseif key == "legionUnlocked" then
        if type(value) ~= "boolean" then return UNKNOWN end
        local level = UnitLevel("player")
        local levelKnown = not MapPinEnhanced:IsSecretValue(level) and type(level) == "number" and level > 0
        if levelKnown and level >= 50 then return StateFromBoolean(value) end
        local completed = C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted and
            C_QuestLog.IsQuestFlaggedCompleted(44663)
        if MapPinEnhanced:IsSecretValue(completed) then return UNKNOWN end
        if completed == true then return StateFromBoolean(value) end
        if completed == false and levelKnown then return StateFromBoolean(not value) end
        return UNKNOWN
    elseif key == "faction" then
        local faction = UnitFactionGroup("player")
        if MapPinEnhanced:IsSecretValue(faction) or type(faction) ~= "string" then return UNKNOWN end
        return StateFromBoolean(ValueMatches(faction, value))
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
        if type(value) == "table" then
            if not MapPinEnhanced:IsReadableTable(value) or type(value.id) ~= "number" or
                type(value.criteria) ~= "number" or value.id <= 0 or value.id % 1 ~= 0 or
                value.criteria <= 0 or value.criteria % 1 ~= 0 or not GetAchievementCriteriaInfo then return UNKNOWN end
            -- Authored criteria are indexes, as in the source's achieved(id, index).
            -- Unavailable criteria can throw; keep that observation unknown without aborting preparation.
            local success, _, _, completed = pcall(GetAchievementCriteriaInfo, value.id, value.criteria)
            if not success then return UNKNOWN end
            return StateFromBoolean(completed)
        end
        if type(value) ~= "number" or value <= 0 or value % 1 ~= 0 or not GetAchievementInfo then return UNKNOWN end
        local completed = select(4, GetAchievementInfo(value))
        return StateFromBoolean(completed)
    elseif key == "mapArtID" then
        if type(value) ~= "table" or type(value[1]) ~= "number" or type(value[2]) ~= "number" or
            not C_Map or not C_Map.GetMapArtID then
            return UNKNOWN
        end
        local artID = C_Map.GetMapArtID(value[1])
        if MapPinEnhanced:IsSecretValue(artID) or type(artID) ~= "number" then return UNKNOWN end
        return StateFromBoolean(artID == value[2])
    elseif key == "currentMap" then
        if not C_Map or not C_Map.GetBestMapForUnit then return UNKNOWN end
        local mapID = C_Map.GetBestMapForUnit("player")
        if MapPinEnhanced:IsSecretValue(mapID) or type(mapID) ~= "number" then return UNKNOWN end
        return StateFromBoolean(ValueMatches(mapID, value))
    elseif key == "buff" then
        if type(value) ~= "number" or value <= 0 or value % 1 ~= 0 or
            not C_UnitAuras or not C_UnitAuras.GetPlayerAuraBySpellID or
            not C_Secrets or not C_Secrets.ShouldSpellAuraBeSecret then return UNKNOWN end
        -- Restricted lookups can return nil too; that is not proof of absence.
        local restricted = C_Secrets.ShouldSpellAuraBeSecret(value)
        if MapPinEnhanced:IsSecretValue(restricted) or restricted ~= false then return UNKNOWN end
        local aura = C_UnitAuras.GetPlayerAuraBySpellID(value)
        if MapPinEnhanced:IsSecretValue(aura) then return UNKNOWN end
        if aura == nil then return UNSATISFIED end
        if not MapPinEnhanced:IsReadableTable(aura) then return UNKNOWN end
        return SATISFIED
    elseif key == "covenant" then
        if type(value) ~= "number" or value < 1 or value > 4 or value % 1 ~= 0 or
            not C_Covenants or not C_Covenants.GetActiveCovenantID then return UNKNOWN end
        local covenantID = C_Covenants.GetActiveCovenantID()
        if MapPinEnhanced:IsSecretValue(covenantID) or type(covenantID) ~= "number" then return UNKNOWN end
        return StateFromBoolean(covenantID == value)
    elseif key == "chromieTime" then
        if type(value) ~= "number" then return UNKNOWN end
        if not C_ChromieTime or not C_ChromieTime.GetChromieTimeExpansionOption then return UNKNOWN end
        local option = C_ChromieTime.GetChromieTimeExpansionOption(value)
        return StateFromBoolean(option and option.alreadyOn)
    end
    return UNKNOWN
end

-- Typed, length-prefixed keys include every parameter of structured checks,
-- such as achievement criteria, map/texture pairs and garrison type/level.
---@param value any
---@return string?
local function GetObservationScalarKey(value)
    if MapPinEnhanced:IsSecretValue(value) then return nil end
    local kind = type(value)
    if kind == "string" then return "s" .. #value .. ":" .. value end
    if kind == "number" and MapPinEnhanced:IsReadableNumber(value) then return "n" .. string.format("%.17g", value) end
    if kind == "boolean" then return value and "true" or "false" end
    if value == nil then return "nil" end
    return nil
end

---@param value any
---@return string?
local function GetObservationKey(value)
    local scalar = GetObservationScalarKey(value)
    if scalar then return scalar end
    if not MapPinEnhanced:IsReadableTable(value) then return nil end
    local fields = {} ---@type string[]
    ---@cast value table<any, any>
    for key, item in pairs(value) do
        local fieldKey, fieldValue = GetObservationScalarKey(key), GetObservationScalarKey(item)
        -- Nested/malformed values bypass reuse and retain the evaluator's result.
        if not fieldKey or not fieldValue then return nil end
        fields[#fields + 1] = #fieldKey .. ":" .. fieldKey .. #fieldValue .. ":" .. fieldValue
    end
    table.sort(fields)
    return "table:" .. table.concat(fields)
end

---@alias NavigationRequirementObservations table<string, table<string, NavigationRequirementState>>

---@param kind string
---@param value any
---@param observations NavigationRequirementObservations?
---@return NavigationRequirementState
local function ObserveRequirement(kind, value, observations)
    if MapPinEnhanced:IsSecretValue(value) then return UNKNOWN end
    if kind == "spellKnown" then kind = "spell" end
    if kind == "toyKnown" then kind = "toy" end
    if kind == "event" and type(value) == "string" then value = string.upper(value) end
    local key = observations and GetObservationKey(value)
    local states = observations and observations[kind]
    if key and states and states[key] then return states[key] end
    local state = EvaluateDirectCheck(kind, value)
    if key and observations then
        states = states or {}
        states[key] = state
        observations[kind] = states
    end
    return state
end

---@param requirement NavigationRequirement?
---@param observations NavigationRequirementObservations?
---@return NavigationRequirementState state
---@return string? failure
function Navigation:EvaluateRequirement(requirement, observations)
    if requirement == nil then return SATISFIED end
    if type(requirement) ~= "table" then return UNKNOWN, "invalid requirement" end

    local toyItemID = GetQualifiedToyItemID(requirement)
    if toyItemID then
        local state = ObserveRequirement("toy", toyItemID, observations)
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
            local state, failure = self:EvaluateRequirement(child, observations)
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
        local children = requirement.children
        if type(children) ~= "table" or #children ~= 1 then return UNKNOWN, "invalid negation requirement" end
        local state, failure = self:EvaluateRequirement(children[1], observations)
        if state == UNKNOWN then return UNKNOWN, failure or "requirement unavailable" end
        return state == SATISFIED and UNSATISFIED or SATISFIED
    elseif operation ~= "check" or type(requirement.kind) ~= "string" then
        return UNKNOWN, "invalid requirement shape"
    end

    local state = ObserveRequirement(requirement.kind, requirement.value, observations)
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
            if found and found ~= childValue then return nil end
            found = childValue
        end
    end
    return found
end

-- Invalidations retain no event payloads. Published tables belong to snapshots and
-- must never be refilled while a Route or calculation still references them.
function Navigation:InvalidatePreparedData()
    preparedDataDirty = true
    preparationChangeNumber = preparationChangeNumber + 1
    preparationFailure = nil
    self:CancelPreparedData()
    local job = self.activeCalculation
    if job then
        local restart = job.restart
        self:CancelRouteCalculation(job)
        -- Intake rejects stale work immediately. The existing bucket, or an
        -- explicit preparation request, resumes it once fresh data is complete.
        self.pendingCalculationRestart = restart
    end
end

function Navigation:CancelPreparedData()
    if cancelPreparation then cancelPreparation() end
    cancelPreparation = nil
end

function Navigation:RefreshPreparedData()
    self:InvalidatePreparedData()
    if self.routeNavigationEnabled and self.activeDestination then
        self:EnsurePreparedData()
    end
end

---@param first NavigationMovementCapabilities
---@param second NavigationMovementCapabilities
---@return boolean
local function SameMovementCapabilities(first, second)
    return first.groundSpeed == second.groundSpeed and
        first.steadyFlightSpeed == second.steadyFlightSpeed and
        first.skyridingSpeed == second.skyridingSpeed and
        first.canFly == second.canFly and first.canSkyriding == second.canSkyriding and
        first.activeFlightMode == second.activeFlightMode
end

---Aura traffic cannot change requirements when the graph contains no buff checks.
---Movement availability can still change. While dirty, a suspended worker may
---have observed different movement than the last published snapshot.
---@return boolean
function Navigation:NeedsAuraRefresh()
    if hasBuffRequirements or preparedDataDirty or not preparedNavigationData then return true end
    return not SameMovementCapabilities(self:GetMovementCapabilities(), preparedNavigationData.movement)
end

-- Synchronous readers only schedule preparation. The private candidate is
-- published atomically; cancelled workers never resume into a newer generation.
---@return NavigationPreparedData?
---@return string? failure
function Navigation:EnsurePreparedData()
    if not navigationGraph then return nil, "navigation data is not ready" end
    if not preparedDataDirty then return preparedNavigationData end
    if self.routeNavigationEnabled and self.activeDestination and not cancelPreparation and not preparationFailure then
        local graph, changeNumber = navigationGraph, preparationChangeNumber
        cancelPreparation = MapPinEnhanced:BatchExecution({ function()
            local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(2)
            -- The memo belongs only to this pass; published snapshots retain no observations.
            local observations = {} ---@type NavigationRequirementObservations
            local previous = preparedNavigationData
            ---@generic T
            ---@param values table<integer, T>
            ---@return table<integer, T>
            local function CopyValues(values)
                local copy = {} ---@type table<integer, any>
                for key, value in pairs(values) do
                    copy[key] = value
                    checkpoint()
                end
                return copy
            end
            local states = previous and previous.requirementStateByPath or {}
            local reasons = previous and previous.exclusionReasonByPath or {}
            for pathReference = 1, graph.pathCount do
                checkpoint()
                local staticFailure = graph.excludedPaths[pathReference]
                local state, reason ---@type NavigationRequirementState, string?
                if IsTransportationDisabled(graph.pathTypes[pathReference]) then
                    state, reason = UNSATISFIED, "transportation group disabled"
                elseif staticFailure then
                    state, reason = UNKNOWN, staticFailure
                else
                    local failure
                    state, failure = self:EvaluateRequirement(graph.pathRequirements[pathReference], observations)
                    if state ~= SATISFIED then reason = failure or state end
                end
                if states[pathReference] ~= state then
                    if previous and states == previous.requirementStateByPath then
                        states = CopyValues(states)
                    end
                    states[pathReference] = state
                end
                if reasons[pathReference] ~= reason then
                    if previous and reasons == previous.exclusionReasonByPath then
                        reasons = CopyValues(reasons)
                    end
                    reasons[pathReference] = reason
                end
            end
            local movement = self:GetMovementCapabilities()
            if previous and SameMovementCapabilities(movement, previous.movement) then
                movement = previous.movement
            end
            local costs, failures = self:GetPreparedTaxiCosts(graph, checkpoint)
            local observation = self:GetTaxiObservation()
            if graph ~= navigationGraph or changeNumber ~= preparationChangeNumber then return end
            if not previous or states ~= previous.requirementStateByPath or reasons ~= previous.exclusionReasonByPath or
                movement ~= previous.movement or costs ~= previous.taxiCosts or failures ~= previous.taxiFailures or
                observation ~= previous.taxiObservation then
                preparedNavigationData = {
                    requirementStateByPath = states,
                    exclusionReasonByPath = reasons,
                    movement = movement,
                    taxiObservation = observation,
                    taxiCosts = costs,
                    taxiFailures = failures,
                }
            end
            preparedDataDirty = false
        end }, nil, function()
            cancelPreparation = nil
            self:RefreshEligibility({})
        end, 1, function(message)
            cancelPreparation = nil
            preparationFailure = message
            local restart = self.pendingCalculationRestart
            if restart then restart() end
            geterrorhandler()(message)
        end)
    end
    return nil, preparationFailure
end

---@async
---@param checkpoint fun()
---@return NavigationPreparedData?
---@return string? failure
function Navigation:AwaitPreparedData(checkpoint)
    local prepared, failure = self:EnsurePreparedData()
    while not prepared and cancelPreparation do
        coroutine.yield()
        checkpoint()
        prepared, failure = self:EnsurePreparedData()
    end
    return prepared, failure
end

-- Failure recovery reads a new requirement observation without mutating any
-- prepared snapshot held by a running calculation or retained Route.
---@param pathReference integer
---@return NavigationCalculatedPathCost?
---@return string? failure
function Navigation:GetFreshPathCost(pathReference)
    if pathReference < 0 then return nil, "taxi journey requires current interaction" end
    local graph = navigationGraph
    if not graph then return nil, "navigation data is not ready" end
    if IsTransportationDisabled(graph.pathTypes[pathReference]) then
        return nil, "transportation group disabled"
    end
    if graph.excludedPaths[pathReference] then return nil, graph.excludedPaths[pathReference] end
    local state, failure = self:EvaluateRequirement(graph.pathRequirements[pathReference])
    if state ~= SATISFIED then return nil, failure or state end
    local fresh = {
        requirementStateByPath = { [pathReference] = state },
        exclusionReasonByPath = {},
        movement = self:GetMovementCapabilities(),
        taxiObservation = self:GetTaxiObservation(),
        taxiCosts = {},
        taxiFailures = {},
    }
    if graph.pathTypes[pathReference] == "flighttaxi" then
        fresh.taxiCosts, fresh.taxiFailures = self:PrepareTaxiCosts(graph, pathReference)
    end
    return self:GetPathCost(graph, fresh, pathReference)
end
