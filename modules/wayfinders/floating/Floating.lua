---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData | nil
---@field frames {modern: MapPinEnhancedFloatingModernTemplate, simple: MapPinEnhancedFloatingSimpleTemplate}
---@field frameType WayfinderFloatingFrameType | nil
local MapPinEnhancedWayfinderFloating = {}

---@param frameType WayfinderFloatingFrameType
function MapPinEnhancedWayfinderFloating:SetFrameType(frameType)
    -- TODO: hook this up to an option
    if self.frameType == frameType then return end
    self:GetFrame()
    self:ShowFrame()
end

---@enum (key) WayfinderFloatingFrameType
local templates = {
    modern = "MapPinEnhancedFloatingModernTemplate",
    simple = "MapPinEnhancedFloatingSimpleTemplate",
}

local shouldReactToUserWaypointUpdate = false

---@return MapPinEnhancedFloatingModernTemplate | MapPinEnhancedFloatingSimpleTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    ---@type WayfinderFloatingFrameType
    local currentType = "modern" -- TODO: get the var here

    if self.frames and self.frames[currentType] then
        return self.frames[currentType]
    end
    local template = templates[currentType]
    if not template then
        error("Invalid frame type: " .. tostring(currentType))
    end
    local frame = CreateFrame("Frame", "MapPinEnhancedWayfinderFloatingFrame" .. currentType, nil, template)
    return frame
end

function MapPinEnhancedWayfinderFloating:ShowFrame()
    local frame = self:GetFrame()
    frame:Show()
end

function MapPinEnhancedWayfinderFloating:HideFrame()
    local frame = self:GetFrame()
    if frame then
        frame:Hide()
    end
end

---@param x number
---@param y number
---@param mapID number
function MapPinEnhancedWayfinderFloating:SetUserWaypoint(x, y, mapID)
    if not C_Map.CanSetUserWaypointOnMap(mapID) then
        local mapInfo = C_Map.GetMapInfo(mapID)
        MapPinEnhanced:Print("Cannot set waypoint on " .. mapInfo.name)
        return
    end

    local hasUserWaypoint = C_Map.HasUserWaypoint()
    if hasUserWaypoint then
        C_Map.ClearUserWaypoint()
    end

    if x < 0 then
        x = 0
    end
    if y < 0 then
        y = 0
    end

    local uiMapPoint = UiMapPoint.CreateFromCoordinates(mapID, x, y, 0)
    shouldReactToUserWaypointUpdate = true
    C_Map.SetUserWaypoint(uiMapPoint)
end

local function onUserwaypointUpdated()
    if not shouldReactToUserWaypointUpdate then return end
    shouldReactToUserWaypointUpdate = false
    local hasUserWaypoint = C_Map.HasUserWaypoint()
    if not hasUserWaypoint then return end
    C_Timer.After(0, function()
        if C_Map.HasUserWaypoint() == true then
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        end
    end)
end

function MapPinEnhancedWayfinderFloating:Reset()
    self.data = nil
    shouldReactToUserWaypointUpdate = false
    C_Map.ClearUserWaypoint()
    self:HideFrame()
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end
    self.data = wayfinderData
    if wayfinderData then
        local x, y, mapID = wayfinderData.x, wayfinderData.y, wayfinderData.mapID
        self:SetUserWaypoint(x, y, mapID)
        self:ShowFrame()
    else
        C_Map.ClearUserWaypoint()
        self:HideFrame()
    end
end

---Method to block the automatic removal of pins in the game
local function OverrideSuperTrackedReachedBehavior()
    ---@type function | nil
    local unregisterNavigationReachedEvent

    unregisterNavigationReachedEvent = function()
        if SuperTrackedFrame then
            SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
        end
        MapPinEnhanced:UnregisterEventForFunction("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end

    if SuperTrackedFrame then
        SuperTrackedFrame:UnregisterEvent("NAVIGATION_DESTINATION_REACHED")
    else
        MapPinEnhanced:RegisterEvent("NAVIGATION_FRAME_CREATED", unregisterNavigationReachedEvent)
    end
end


---Method to override the alpha state of the super tracked frame -> create unlimited distance
---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    if enable then
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 1)
        SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 1)
        return
    end
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, 0)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, 0)
end

function MapPinEnhancedWayfinderFloating:SetOverride()
    if self.overrideActive then return end
    OverrideSuperTrackedReachedBehavior()
    OverrideSuperTrackedAlphaState(true)
    self.overrideActive = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    self:SetOverride()
end

function MapPinEnhancedWayfinderFloating:Disable()
    shouldReactToUserWaypointUpdate = false
    local frame = self:GetFrame()
    if frame then
        frame:Hide()
    end
    C_Map.ClearUserWaypoint()
    OverrideSuperTrackedAlphaState(false)
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating

MapPinEnhanced:OnLoad(function()
    Wayfinders:EnableWayfinder("WAYFINDER_FLOATING")
end)

MapPinEnhanced:RegisterEvent("USER_WAYPOINT_UPDATED", onUserwaypointUpdated)
