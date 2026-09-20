---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Providers = MapPinEnhanced:GetModule("Providers")
local L = MapPinEnhanced.L
local SOURCE = "scenario"

---@return string
local function GetScenarioTargetID()
    local scenario = C_ScenarioInfo.GetScenarioInfo()
    local step = C_ScenarioInfo.GetScenarioStepInfo()
    return string.format("scenario:%s:%s", tostring(scenario and scenario.scenarioID),
        tostring(step and step.stepID or scenario and scenario.currentStage))
end

---@param mapID number
---@return ScenarioIconInfo[]
local function GetScenarioIcons(mapID)
    if not C_Scenario.IsInScenario() then return {} end
    if C_ScenarioInfo.GetScenarioIconInfo then
        return C_ScenarioInfo.GetScenarioIconInfo(mapID) or {}
    end
    -- Older Retail clients expose the same map records in C_Scenario.
    if C_Scenario.GetScenarioIconInfo then
        return C_Scenario.GetScenarioIconInfo(mapID) or {}
    end
    return {}
end

---@param mapID number
---@return number? x
---@return number? y
---@return string? description
local function GetScenarioWaypoint(mapID)
    local icons = GetScenarioIcons(mapID)
    -- Scenario icons have no tracked-target ID. Multiple icons cannot tell us
    -- which objective Blizzard selected, so leave that case to its waypoint API.
    if #icons ~= 1 then return end
    return icons[1].x, icons[1].y, icons[1].description
end

---@param text string?
---@return string?
local function NonEmpty(text)
    return Providers:PlainDescription(text)
end

---@param targetID string
---@param data WayfinderData
---@return string?, string?, boolean?
local function ReadScenarioText(targetID, data)
    if targetID ~= GetScenarioTargetID() then return end
    local scenario = C_ScenarioInfo.GetScenarioInfo()
    local step = C_ScenarioInfo.GetScenarioStepInfo()
    if not scenario or not step then return end
    local title = Providers:PlainDescription(step.title) or Providers:PlainDescription(scenario.name) or L["Scenario"]
    ---@type string?
    local description
    local matches = 0
    for _, icon in ipairs(GetScenarioIcons(data.mapID)) do
        if not issecretvalue(icon.x) and not issecretvalue(icon.y) and
            math.abs(icon.x - data.x) < 0.0001 and math.abs(icon.y - data.y) < 0.0001 then
            matches = matches + 1
            description = Providers:PlainDescription(icon.description, title)
        end
    end
    if matches ~= 1 then description = nil end
    if not description and not Providers:IsStepSuperTracking() then
        local _, _, _, waypoint = Providers:GetSuperTrackingWaypoint(GetScenarioWaypoint)
        description = Providers:PlainDescription(waypoint, title)
    end
    return title, description or Providers:PlainDescription(step.description, title), true
end

local function RefreshScenario()
    local scenario = C_ScenarioInfo.GetScenarioInfo()
    local step = C_ScenarioInfo.GetScenarioStepInfo()
    local targetID = GetScenarioTargetID()
    local x, y, mapID, waypointDescription = Providers:GetSuperTrackingWaypoint(GetScenarioWaypoint)
    if x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID)
        return
    end

    local title, description = ReadScenarioText(targetID, { mapID = mapID, x = x, y = y })
    title = title or NonEmpty(step and step.title) or NonEmpty(scenario and scenario.name) or L["Scenario"]
    local atlas = "Navigation-Tracked-Icon"
    for _, icon in ipairs(GetScenarioIcons(mapID)) do
        if not issecretvalue(icon.x) and not issecretvalue(icon.y) and
            math.abs(icon.x - x) < 0.0001 and math.abs(icon.y - y) < 0.0001 then
            atlas = NonEmpty(icon.atlas) or atlas
            break
        end
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = title,
        description = description,
        texture = atlas,
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = Enum.SuperTrackingType.Scenario,
    getTargetID = GetScenarioTargetID,
    refresh = RefreshScenario,
    readText = ReadScenarioText,
    events = { "SCENARIO_UPDATE", "SCENARIO_CRITERIA_UPDATE", "SCENARIO_POI_UPDATE",
        "SCENARIO_COMPLETED", "ZONE_CHANGED_NEW_AREA" },
})

-- Stage identity is independent of Blizzard's temporary UserWaypoint selection.
-- Replacing a stage is a destination change, not a text refresh for the old route.
MapPinEnhanced:RegisterEvent("SCENARIO_UPDATE", function()
    if Providers:IsChangingSuperTrackingEntry() then return end
    local Navigation = MapPinEnhanced:GetModule("Navigation")
    local scenario = C_ScenarioInfo.GetScenarioInfo()
    local step = C_ScenarioInfo.GetScenarioStepInfo()
    if not scenario or not step then return end
    local owner, targetID = Navigation:GetActiveDestinationState()
    if owner ~= SOURCE or not Providers:IsStepSuperTracking() or targetID == GetScenarioTargetID() then return end
    Providers:ClearStepSuperTracking()
    Providers:RefreshSuperTrackingProvider(SOURCE)
end)
