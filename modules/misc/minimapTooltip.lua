---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")
local Providers = MapPinEnhanced:GetModule("Providers")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local L = MapPinEnhanced.L

---@return string? title
---@return string? description
---@return pinData? pinData
---@return MapPinEnhancedPinMixin? pin
local function GetWaypointDetails()
    if C_SuperTrack.GetHighestPrioritySuperTrackingType() ~= Enum.SuperTrackingType.UserWaypoint then return end
    -- A temporary Step takes precedence over the original tracked pin. These
    -- optional readers enrich native tracking without requiring Wayfinders.
    if Providers.IsStepSuperTracking and Providers:IsStepSuperTracking() then
        local step = Wayfinders.GetStepSnapshot and Wayfinders:GetStepSnapshot()
        if step then
            local description = step.destinationTitle
            if step.status and step.status ~= "" then
                description = description and description .. "\n" .. step.status or step.status
            end
            return step.instruction, description
        end
        return
    end

    local pin = Pins:GetTrackedPin()
    local data = pin and pin.pinData
    local waypoint = C_Map.GetUserWaypoint()
    if not data or not waypoint or waypoint.uiMapID ~= data.mapID or
        math.abs(waypoint.position.x - data.x) > 0.0001 or
        math.abs(waypoint.position.y - data.y) > 0.0001 then
        return
    end
    return data.title or L["Map Pin"], data.description, data, pin
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.MinimapMouseover, function(tooltip)
    if tooltip ~= GameTooltip then return end
    local title, description, data, pin = GetWaypointDetails()
    if not title then return end
    title = MapPinEnhanced:EscapeMarkup(title)

    -- Minimap mouseover can include several nearby markers. Replace only the
    -- generic waypoint entry, preserving all native names and tooltip ownership.
    local replaced = false
    for index = 1, tooltip:NumLines() do
        local line = _G["GameTooltipTextLeft" .. index] ---@type FontString?
        local text = line and line:GetText()
        if line and not issecretvalue(text) and type(text) == "string" then
            local changed = false
            local replacement = text:gsub("[^\n]+", function(entry)
                if entry ~= MAP_PIN then return entry end
                changed = true
                return title
            end)
            if changed then
                line:SetText(replacement)
                replaced = true
            end
        end
    end
    if not replaced then return end

    MapPinEnhanced:AddDescriptionToTooltip(description)
    if data and pin then
        local mapInfo = C_Map.GetMapInfo(data.mapID)
        tooltip:AddLine(string.format("%s (%.2f, %.2f)", mapInfo and mapInfo.name or tostring(data.mapID),
            data.x * 100, data.y * 100), 1, 1, 1, true)
        local group = pin.group
        tooltip:AddLine(string.format("%s: %d/%d", group and group:GetName() or L["Ungrouped Pins"],
            group and group:GetReachedPinCount() or 0, group and group:GetTotalPinCount() or 1),
            0.65, 0.65, 0.65, true)
    end
end)
