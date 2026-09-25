---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Navigation = MapPinEnhanced:GetModule("Navigation")
local L = MapPinEnhanced.L

local PHASE_SWITCH_SECONDS = 10

---@class NavigationPhaseSwitchData
---@field fromMap number
---@field toMap number

local activeContext ---@type NavigationActivePathContext?
local activeReport ---@type NavigationPathReport?
local activePathReference ---@type integer?
local startingMapArtID ---@type number?

local function Presentation()
    return "ChromieTime-32x32", L["Navigation Method Phase Change"], L["Navigation Take Transport"]
end

---@param path NavigationStaticPath
---@return NavigationPhaseSwitchData? data
---@return string? failure
local function Dataprovider(path)
    if type(path.fromMap) ~= "number" then return nil, "missing phase-switch origin" end
    return { fromMap = path.fromMap, toMap = path.toMap }
end

---@return NavigationCalculatedPathCost
local function CostCalculator()
    return {
        expectedSeconds = PHASE_SWITCH_SECONDS,
        uncertaintySeconds = 0,
        comparisonSeconds = PHASE_SWITCH_SECONDS,
        explanation = { kind = "phase-switch", seconds = PHASE_SWITCH_SECONDS },
    }
end

---@param context NavigationActivePathContext
---@param report NavigationPathReport
local function Activator(context, report)
    activeContext = context
    activeReport = report
    if activePathReference == context.pathReference then return end
    activePathReference = context.pathReference
    local data = context.data ---@type NavigationPhaseSwitchData
    startingMapArtID = C_Map and C_Map.GetMapArtID and C_Map.GetMapArtID(data.fromMap) or nil
end

local function Deactivator()
    activeContext = nil
    activeReport = nil
    activePathReference = nil
    startingMapArtID = nil
end

local function OnGossipClosed()
    if activeContext and activeContext.phase == "ready" and activeReport then
        activeReport("attempted")
    end
end

local function CheckPhaseChange()
    local context = activeContext
    local report = activeReport
    if not context or not report or context.phase == "approach" then return end
    local data = context.data ---@type NavigationPhaseSwitchData
    local currentMapID = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player") or nil
    if data.fromMap ~= data.toMap and currentMapID == data.toMap then
        report("completed")
        return
    end
    local currentMapArtID = C_Map and C_Map.GetMapArtID and C_Map.GetMapArtID(data.fromMap) or nil
    if startingMapArtID and currentMapArtID and currentMapArtID ~= startingMapArtID then
        report("completed")
    end
end

MapPinEnhanced:RegisterEvent("GOSSIP_CLOSED", OnGossipClosed)
MapPinEnhanced:RegisterEventBucket({
    "LOADING_SCREEN_DISABLED",
    "PLAYER_ENTERING_WORLD",
    "QUEST_LOG_UPDATE",
    "ZONE_CHANGED",
    "ZONE_CHANGED_INDOORS",
    "ZONE_CHANGED_NEW_AREA",
}, CheckPhaseChange, 0.25)

Navigation:RegisterPathHandler("phaseswitch", Presentation, Dataprovider, CostCalculator,
    Activator, Deactivator)
