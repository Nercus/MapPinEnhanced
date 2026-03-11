---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData | nil
---@field frame MapPinEnhancedFloatingSimpleTemplate | MapPinEnhancedFloatingModernTemplate
local MapPinEnhancedWayfinderFloating = {}

-- TODO: the distant diamond should scale based on distance
-- TODO: use the generic-frame-chamfered-12d-2o atlas to use as title background

---@param frameType WayfinderFloatingFrameType
function MapPinEnhancedWayfinderFloating:SetFrameType(frameType)
    -- TODO: save var here
    if self.frameType == frameType then return end
    self:GetFrame()
    self:ShowFrame()
end

---@enum (key) WayfinderFloatingFrameType
local templates = {
    modern = "MapPinEnhancedFloatingModernTemplate",
    simple = "MapPinEnhancedFloatingSimpleTemplate",
}

function MapPinEnhancedWayfinderFloating:GetFrame()
    ---@type WayfinderFloatingFrameType
    local currentType = "modern" -- TODO: get the var here

    if self.frame then
        if self.frameType == currentType then
            return self.frame
        else
            self.frame:ClearAllPoints()
            self.frame:SetParent(nil)
            self.frame = nil
        end
    end

    local template = templates[currentType] or templates.modern
    self.frame = CreateFrame("Frame", nil, UIParent, template)
    self.frameType = currentType

    return self.frame
end

function MapPinEnhancedWayfinderFloating:ShowFrame()
    local frame = self:GetFrame()
    frame:Show()
end

function MapPinEnhancedWayfinderFloating:HideFrame()
    if self.frame then
        self.frame:Hide()
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
    C_Map.SetUserWaypoint(uiMapPoint)
end

local function onUserwaypointUpdated()
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
    C_Map.ClearUserWaypoint()
    if self.frame then
        self.frame:ClearAllPoints()
        self.frame:SetParent(nil)
        self.frame = nil
        self.frameType = nil
    end
end

function MapPinEnhancedWayfinderFloating:OnDistanceUpdate(distance, timeToTarget)
    self.frame:OnDistanceUpdate(distance, timeToTarget)
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
    if self.overridesSet then return end
    OverrideSuperTrackedReachedBehavior()
    OverrideSuperTrackedAlphaState(true)
    self.overridesSet = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    self.distanceCallback = function(distance, timeToTarget)
        self:OnDistanceUpdate(distance, timeToTarget)
    end
    MapPinEnhanced:RegisterContinuousDistanceCallback(self.distanceCallback)
    self:SetOverride()
end

function MapPinEnhancedWayfinderFloating:Disable()
    if self.distanceCallback then
        MapPinEnhanced:UnregisterContinuousDistanceCallback(self.distanceCallback)
        self.distanceCallback = nil
    end
    if self.frame then
        self.frame:ClearAllPoints()
        self.frame:SetParent(nil)
        self.frame = nil
        self.frameType = nil
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
