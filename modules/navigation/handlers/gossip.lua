---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L
local travelOptions = {} ---@type table<number, table<number, number>> NPC -> option -> parent (0 for flat menus)

---@param gossip NavigationStaticGossip
---@return boolean
---@return string? failure
function Navigation:IsTravelGossipAvailable(gossip)
    -- Read the character's unlock before saved menu observations. Requiring a
    -- summon to discover an already learned destination consumes its cooldown;
    -- a newly completed unlock also supersedes an older missing-menu record.
    local unlocked ---@type boolean?
    if gossip.unlockQuestID and C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
        unlocked = C_QuestLog.IsQuestFlaggedCompleted(gossip.unlockQuestID)
        if not MapPinEnhanced:IsSecretValue(unlocked) and unlocked == true then return true end
    end
    local key = MapPinEnhanced:GetCharacterKey()
    local saved = MapPinEnhanced:GetVar("toyGossipOptions")
    ---@cast saved table<string, table<number, boolean>>?
    local options = key and type(saved) == "table" and saved[key]
    -- Missing character data is unobserved, not a recorded unavailable option.
    if type(options) == "table" then
        local known = options[gossip.gossipOptionID]
        if type(known) == "boolean" then
            return known, not known and "travel gossip observed unavailable" or nil
        end
    end
    if gossip.unlockQuestID and not MapPinEnhanced:IsSecretValue(unlocked) and unlocked == false then
        return false, "travel destination not unlocked or observed"
    end
    return not gossip.requiresObservation, gossip.requiresObservation and "travel gossip not yet observed" or nil
end

local function ObserveTravelOptions()
    local guid = UnitGUID("npc")
    if MapPinEnhanced:IsSecretValue(guid) or type(guid) ~= "string" then return end
    local npcID = select(6, strsplit("-", guid))
    local known = travelOptions[tonumber(npcID)]
    if not known then return end
    local key = MapPinEnhanced:GetCharacterKey()
    if not key then return end
    local observed = {} ---@type table<number, boolean>
    local options = C_GossipInfo.GetOptions()
    if not MapPinEnhanced:IsReadableTable(options) or #options == 0 then return end
    local branch ---@type number?
    for _, option in ipairs(options) do
        if not MapPinEnhanced:IsReadableTable(option) or
            not MapPinEnhanced:IsReadablePositiveInteger(option.gossipOptionID) or
            MapPinEnhanced:IsSecretValue(option.status) then
            return
        end
        local parent = known[option.gossipOptionID]
        if parent then
            if branch and branch ~= parent then return end
            branch = parent
            observed[option.gossipOptionID] = option.status == Enum.GossipOptionStatus.Available
        end
    end
    -- A category page says nothing about its unvisited destinations. A known
    -- leaf identifies only its own complete submenu. Preserve all other pages.
    if not branch then
        for _, parent in pairs(known) do
            if parent ~= 0 then return end
        end
        branch = 0
    end
    for id, parent in pairs(known) do
        if parent == branch and observed[id] == nil then observed[id] = false end
    end
    local saved = MapPinEnhanced:GetVar("toyGossipOptions")
    if type(saved) ~= "table" then saved = {} end
    ---@cast saved table<string, table<number, boolean>>
    saved[key] = type(saved[key]) == "table" and saved[key] or {}
    local changed = false
    for id, available in pairs(observed) do
        if saved[key][id] ~= available then changed = true end
        saved[key][id] = available
    end
    if changed then
        MapPinEnhanced:SetVar("toyGossipOptions", saved)
        Navigation:RefreshPreparedData()
    end
end

---@param context NavigationPathPresentationContext?
---@return string icon, string method, string instruction
local function GossipPresentation(context)
    local destination = context and context.destinationName
    return "ChatBallon", L["Navigation Method NPC Travel"],
        destination and string.format(L["Navigation Talk To NPC To"], destination) or L["Navigation Talk To NPC"]
end

---@param path NavigationStaticPath
---@return NavigationStaticGossip?
---@return string? failure
function Navigation:GetGossipPathData(path)
    local gossip = path.gossip ---@type NavigationStaticGossip?
    if type(gossip) ~= "table" or type(gossip.npcID) ~= "number" or
        type(gossip.gossipOptionID) ~= "number" then
        return nil, "missing gossip identity"
    end
    local npcID = gossip.npcID
    local gossipOptionID = gossip.gossipOptionID
    local parentOptionID = gossip.parentOptionID
    if parentOptionID and not MapPinEnhanced:IsReadablePositiveInteger(parentOptionID) then
        return nil, "invalid gossip category identity"
    end
    if gossip.unlockQuestID and not MapPinEnhanced:IsReadablePositiveInteger(gossip.unlockQuestID) then
        return nil, "invalid gossip unlock quest identity"
    end
    if path.type == "toy" or path.type == "spell" then
        travelOptions[npcID] = travelOptions[npcID] or {}
        travelOptions[npcID][gossipOptionID] = parentOptionID or 0
    end
    return {
        npcID = npcID,
        gossipOptionID = gossipOptionID,
        parentOptionID = parentOptionID,
        destinationNameKey = gossip.destinationNameKey,
        unlockQuestID = gossip.unlockQuestID,
        requiresObservation = gossip.requiresObservation
    }
end

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?
local selectedOptionID ---@type number?
local selectedOptions = {} ---@type table<number, boolean>
local gossipOpen = false
local selectionSuppressed = false
local selectionTimer ---@type FunctionContainer?
local selectionChangeNumber = 0

local function CancelSelection()
    selectionChangeNumber = selectionChangeNumber + 1
    if selectionTimer then selectionTimer:Cancel() end
    selectionTimer = nil
end

local function SelectTravelOption()
    local context, report = activeContext, activeReport
    if Options:GetOptionValue("Wayfinder.Navigation.AutomaticTravelSelection") ~= true or IsShiftKeyDown() then
        selectionSuppressed = true
    end
    local isSummoned = context and (context.pathType == "toy" or context.pathType == "spell")
    if not gossipOpen or not context or not report or
        (isSummoned and context.phase ~= "in-transit" or not isSummoned and context.phase == "in-transit") or
        selectionSuppressed or InCombatLockdown() then
        return
    end
    -- A summoned action is already on cooldown. Its retained interaction is
    -- validated by the exact live menu, rather than pre-summon eligibility.
    if not isSummoned and not Navigation:IsCurrentPathReady() then return end
    local guid = UnitGUID("npc")
    if MapPinEnhanced:IsSecretValue(guid) or type(guid) ~= "string" then return end
    local npcID = select(6, strsplit("-", guid))
    local data = context.data ---@type NavigationPhaseSwitchData
    if selectedOptionID and (not data.parentOptionID or selectedOptionID ~= data.parentOptionID) then return end
    if context.pathType == "phaseswitch" then
        local mapID = C_Map.GetBestMapForUnit("player")
        if MapPinEnhanced:IsSecretValue(mapID) or mapID ~= data.fromMap then return end
    end
    if tonumber(npcID) ~= data.npcID then return end
    local options = C_GossipInfo.GetOptions()
    if not MapPinEnhanced:IsReadableTable(options) then return end
    for _, option in ipairs(options) do
        if MapPinEnhanced:IsReadableTable(option) and
            MapPinEnhanced:IsReadablePositiveInteger(option.gossipOptionID) and
            not MapPinEnhanced:IsSecretValue(option.status) and
            (option.gossipOptionID == data.gossipOptionID or option.gossipOptionID == data.parentOptionID) and
            not selectedOptions[option.gossipOptionID] and option.status == Enum.GossipOptionStatus.Available then
            -- Set the guard before selection: it can synchronously close gossip.
            -- Selection is only an attempt; the destination still proves arrival.
            local optionID = option.gossipOptionID
            ---@cast optionID number
            selectedOptionID = optionID
            selectedOptions[optionID] = true
            Navigation:CancelRouteCalculation(Navigation.activeCalculation)
            C_GossipInfo.SelectOption(optionID)
            if optionID == data.gossipOptionID then report("attempted") end
            return
        end
    end
    if isSummoned and not Navigation:IsTravelGossipAvailable(data) then report("failed") end
end

local function ScheduleTravelSelection()
    if not gossipOpen then return end
    -- Shift bypass lasts for this opening, including delayed route/menu updates.
    if IsShiftKeyDown() or Options:GetOptionValue("Wayfinder.Navigation.AutomaticTravelSelection") ~= true then
        selectionSuppressed = true
    end
    if not activeContext or not activeReport or selectionSuppressed or selectionTimer then return end
    -- Finish native gossip dispatch and route publication before selection can
    -- synchronously close the interaction. Repeated updates share one callback.
    local changeNumber = selectionChangeNumber
    selectionTimer = C_Timer.NewTimer(0, function()
        if changeNumber ~= selectionChangeNumber then return end
        selectionTimer = nil
        SelectTravelOption()
    end)
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
function Navigation:ActivateGossipPath(context, report)
    activeContext, activeReport = context, report
    ScheduleTravelSelection()
end

function Navigation:DeactivateGossipPath()
    CancelSelection()
    activeContext, activeReport = nil, nil
    -- Selection belongs to the menu opening, not a republished route handler.
end

MapPinEnhanced:RegisterEvent("GOSSIP_SHOW", function()
    if not gossipOpen then
        selectedOptionID = nil
        wipe(selectedOptions)
        selectionSuppressed = false
    end
    gossipOpen = true
    ObserveTravelOptions()
    ScheduleTravelSelection()
end)
MapPinEnhanced:RegisterEvent("GOSSIP_OPTIONS_REFRESHED", function()
    if not gossipOpen then return end
    ObserveTravelOptions()
    ScheduleTravelSelection()
end)
MapPinEnhanced:RegisterEvent("GOSSIP_CLOSED", function()
    CancelSelection()
    gossipOpen = false
    selectedOptionID = nil
    wipe(selectedOptions)
    selectionSuppressed = false
end)
Options:SubscribeToOptionChanges("Wayfinder.Navigation.AutomaticTravelSelection", function(value)
    if value == true then return end
    if gossipOpen then selectionSuppressed = true end
    CancelSelection()
end)
MapPinEnhanced:RegisterEvent("PLAYER_REGEN_ENABLED", ScheduleTravelSelection)

---@return table
function Navigation:GetGossipSelectionState()
    return {
        open = gossipOpen,
        pending = selectionTimer ~= nil,
        suppressed = selectionSuppressed,
        selectedOptionID = selectedOptionID,
        pathReference = activeContext and activeContext.pathReference,
        phase = activeContext and activeContext.phase,
    }
end

Navigation:RegisterPathHandler("gossip", GossipPresentation,
    function(path) return Navigation:GetGossipPathData(path) end, nil,
    function(context, report) Navigation:ActivateGossipPath(context, report) end,
    function() Navigation:DeactivateGossipPath() end)

-- Phase interactions share exact gossip selection, but only the phase owner
-- can report completion. Proximity and closing the menu are never evidence.
---@class NavigationPhaseSwitchData : NavigationStaticGossip
---@field fromMap number
---@field toMap number

local function PhasePresentation(context)
    local _, _, instruction = GossipPresentation(context)
    return "ChromieTime-32x32", L["Navigation Method Phase Change"], instruction
end

---@param path NavigationStaticPath
---@return NavigationPhaseSwitchData? data
---@return string? failure
local function PhaseDataprovider(path)
    if type(path.fromMap) ~= "number" or path.fromMap == path.toMap then
        return nil, "phase switch requires distinct origin and destination maps"
    end
    local gossip, failure = Navigation:GetGossipPathData(path)
    if not gossip then return nil, failure end
    return {
        npcID = gossip.npcID,
        gossipOptionID = gossip.gossipOptionID,
        fromMap = path.fromMap,
        toMap = path.toMap
    }
end

---@return NavigationCalculatedPathCost
local function PhaseCostCalculator()
    return {
        expectedSeconds = 10,
        uncertaintySeconds = 0,
        comparisonSeconds = 10,
        explanation = { kind = "phase-switch", seconds = 10 },
    }
end

local function CheckPhaseChange()
    local context, report = activeContext, activeReport
    if not context or not report or context.pathType ~= "phaseswitch" or context.phase == "approach" then return end
    local data = context.data ---@type NavigationPhaseSwitchData
    local currentMapID = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil
    if MapPinEnhanced:IsSecretValue(currentMapID) then return end
    if currentMapID == data.toMap then report("completed") end
end

MapPinEnhanced:RegisterEventBucket({
    "LOADING_SCREEN_DISABLED",
    "PLAYER_ENTERING_WORLD",
    "QUEST_LOG_UPDATE",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA",
}, CheckPhaseChange, 1)

Navigation:RegisterPathHandler("phaseswitch", PhasePresentation, PhaseDataprovider, PhaseCostCalculator,
    function(context, report) Navigation:ActivateGossipPath(context, report) end,
    function() Navigation:DeactivateGossipPath() end)
