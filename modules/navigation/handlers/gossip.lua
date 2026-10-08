---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L
local toyOptions = {} ---@type table<number, table<number, boolean>>
MapPinEnhanced:SetDefault("toyGossipOptions", {})

---@param gossip NavigationStaticGossip
---@return boolean
function Navigation:IsToyGossipAvailable(gossip)
    local key = MapPinEnhanced:GetCharacterKey()
    local saved = MapPinEnhanced:GetVar("toyGossipOptions")
    local options = key and type(saved) == "table" and saved[key]
    local known = type(options) == "table" and options[gossip.gossipOptionID]
    if type(known) == "boolean" then return known end
    return not gossip.requiresObservation
end

local function ObserveToyOptions()
    local guid = UnitGUID("npc")
    if MapPinEnhanced:IsSecretValue(guid) or type(guid) ~= "string" then return end
    local npcID = select(6, strsplit("-", guid))
    local known = toyOptions[tonumber(npcID)]
    if not known then return end
    local key = MapPinEnhanced:GetCharacterKey()
    if not key then return end
    local observed = {} ---@type table<number, boolean>
    for id in pairs(known) do observed[id] = false end
    local options = C_GossipInfo.GetOptions()
    if not MapPinEnhanced:IsReadableTable(options) or #options == 0 then return end
    for _, option in ipairs(options) do
        if not MapPinEnhanced:IsReadableTable(option) or
            MapPinEnhanced:IsSecretValue(option.gossipOptionID) or
            MapPinEnhanced:IsSecretValue(option.status) then return end
        if known[option.gossipOptionID] then
            observed[option.gossipOptionID] = option.status == Enum.GossipOptionStatus.Available
        end
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
    if path.type == "toy" then
        toyOptions[npcID] = toyOptions[npcID] or {}
        toyOptions[npcID][gossipOptionID] = true
    end
    return { npcID = npcID, gossipOptionID = gossipOptionID,
        requiresObservation = gossip.requiresObservation }
end

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?
local selectedOptionID ---@type number?
local gossipOpen = false

local function SelectTravelOption()
    local context, report = activeContext, activeReport
    if Options:GetOptionValue("Wayfinder.Navigation.AutomaticTravelSelection") ~= true then return end
    local isToy = context and context.pathType == "toy"
    if not gossipOpen or not context or not report or
        (isToy and context.phase ~= "in-transit" or not isToy and context.phase == "in-transit") or
        selectedOptionID or InCombatLockdown() or IsShiftKeyDown() then
        return
    end
    -- A summoned toy is already on cooldown. Its retained interaction is
    -- validated by the exact live menu, rather than pre-summon eligibility.
    if not isToy and not Navigation:IsCurrentPathReady() then return end
    local guid = UnitGUID("npc")
    if MapPinEnhanced:IsSecretValue(guid) or type(guid) ~= "string" then return end
    local npcID = select(6, strsplit("-", guid))
    local data = context.data ---@type NavigationPhaseSwitchData
    if context.pathType == "phaseswitch" then
        local mapID = C_Map.GetBestMapForUnit("player")
        if MapPinEnhanced:IsSecretValue(mapID) or mapID ~= data.fromMap then return end
    end
    if tonumber(npcID) ~= data.npcID then return end
    for _, option in ipairs(C_GossipInfo.GetOptions()) do
        if not MapPinEnhanced:IsSecretTable(option) and
            not MapPinEnhanced:IsSecretValue(option.gossipOptionID) and
            not MapPinEnhanced:IsSecretValue(option.status) and
            option.gossipOptionID == data.gossipOptionID and option.status == Enum.GossipOptionStatus.Available then
            -- Set the guard before selection: it can synchronously close gossip.
            -- Selection is only an attempt; the destination still proves arrival.
            selectedOptionID = data.gossipOptionID
            Navigation:CancelRouteCalculation(Navigation.activeCalculation)
            C_GossipInfo.SelectOption(data.gossipOptionID)
            report("attempted")
            return
        end
    end
    if isToy and not Navigation:IsToyGossipAvailable(data) then report("failed") end
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
function Navigation:ActivateGossipPath(context, report)
    activeContext, activeReport = context, report
    SelectTravelOption()
end

function Navigation:DeactivateGossipPath()
    activeContext, activeReport, selectedOptionID = nil, nil, nil
end

MapPinEnhanced:RegisterEvent("GOSSIP_SHOW", function()
    gossipOpen = true
    ObserveToyOptions()
    SelectTravelOption()
end)
MapPinEnhanced:RegisterEvent("GOSSIP_CLOSED", function()
    gossipOpen = false
    selectedOptionID = nil
end)

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
