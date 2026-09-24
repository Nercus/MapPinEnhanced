---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")
local Providers = MapPinEnhanced:GetModule("Providers")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData?
---@field frame MapPinEnhancedWayfinderFloatingTemplate?
---@field runtimeEnabled boolean?
---@field blizzardHiddenByOption boolean?
---@field unsubscribeBeamOption fun()?
---@field step WayfinderStepData?
local MapPinEnhancedWayfinderFloating = {}

---@return MapPinEnhancedWayfinderFloatingTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    if not self.frame then
        self.frame = CreateFrame("Frame", "MapPinEnhancedWayfinderFloating", nil,
            "MapPinEnhancedWayfinderFloatingTemplate")
        self.frame.content:SetShowBeam(Options:GetOptionValue("Wayfinder.Floating.ShowBeam") == true)
    end
    return self.frame
end

---@param title string
function MapPinEnhancedWayfinderFloating:SetTitle(title)
    self:SetDestinationText(title, self.data and self.data.description)
end

function MapPinEnhancedWayfinderFloating:RefreshTitle()
    local title = self.data and self.data.title
    local step = self.step
    if step and step.showInstruction ~= false and step.instruction and step.instruction ~= "" then
        title = step.instruction
    end
    self:GetFrame():SetDestinationText(title, self.data and self.data.description)
end

---@param color PinColor
function MapPinEnhancedWayfinderFloating:SetColor(color)
    self:GetFrame():SetColor(color)
end

---@param texture string|number
---@param usesAtlas boolean
function MapPinEnhancedWayfinderFloating:SetTexture(texture, usesAtlas)
    self:GetFrame():SetTexture(texture, usesAtlas)
end

---@param targetType WayfinderTargetType
function MapPinEnhancedWayfinderFloating:SetTargetType(targetType)
    local frame = self:GetFrame()
    local normalizedTargetType = Wayfinders:GetTargetTypeOrDefault(targetType)
    frame.pin:SetStyleMode(Wayfinders:GetTargetStyleMode(normalizedTargetType))
end

---@param lock boolean
function MapPinEnhancedWayfinderFloating:SetLock(lock)
    self:GetFrame().pin:SetLock(lock)
end

---@param step WayfinderStepData?
function MapPinEnhancedWayfinderFloating:SetStep(step)
    self.step = step
    local frame = self:GetFrame()
    self:RefreshTitle()
    local showDirection = step == nil or step.showDirection
    -- Reaching an entrance can hide direction while its Step still owns tracking.
    -- Keep the waypoint protected from native arrival clearing until the Step ends.
    if self.data and self.data.mapDistanceOnly then
        Providers:SetStepSuperTracking(self.data)
    else
        Providers:ClearStepSuperTracking()
    end
    frame:RefreshNavigationTarget()
    frame.content:SetShown(showDirection)
end

function MapPinEnhancedWayfinderFloating:Reset()
    Providers:ClearStepSuperTracking()
    self.data = nil
    self.step = nil
    if self.frame then
        self.frame:SetDestinationText(nil, nil)
        self.frame:Hide()
    end
end

---@param wayfinderData WayfinderData?
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end

    if not wayfinderData.mapDistanceOnly then Providers:ClearStepSuperTracking() end
    self.data = wayfinderData
    local frame = self:GetFrame()
    self:SetTargetType(wayfinderData.targetType)
    if wayfinderData.pinStyleMode then
        frame.pin:SetStyleMode(wayfinderData.pinStyleMode)
    end
    frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    if wayfinderData.texture then
        frame:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        frame:SetColor(wayfinderData.color)
    end
    self:RefreshTitle()
    frame.pin:SetLock(wayfinderData.lock)
    frame:Show()
end

---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    local alpha = enable and 1 or 0
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, alpha)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, alpha)
end

function MapPinEnhancedWayfinderFloating:RestoreBlizzardForFloating()
    if not self.blizzardHiddenByOption then return end
    SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:RegisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:RegisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:InitializeNavigationFrame()
    self.blizzardHiddenByOption = nil
end

function MapPinEnhancedWayfinderFloating:HideBlizzardForSession()
    if self.blizzardHiddenByOption then return end
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_CREATED")
    SuperTrackedFrame:UnregisterEvent("NAVIGATION_FRAME_DESTROYED")
    SuperTrackedFrame:UnregisterEvent("SUPER_TRACKING_CHANGED")
    SuperTrackedFrame:ShutdownNavigationFrame()
    SuperTrackedFrame:Hide()
    self.blizzardHiddenByOption = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    if self.runtimeEnabled then return end
    self.runtimeEnabled = true
    self:RestoreBlizzardForFloating()
    OverrideSuperTrackedAlphaState(true)
    self.unsubscribeBeamOption = Options:SubscribeToOptionChanges("Wayfinder.Floating.ShowBeam", function(value)
        if self.frame then self.frame.content:SetShowBeam(value == true) end
    end)
end

function MapPinEnhancedWayfinderFloating:Disable()
    if not self.runtimeEnabled then return end
    Providers:ClearStepSuperTracking()
    self.runtimeEnabled = nil
    if self.frame then
        self.frame:SetDestinationText(nil, nil)
        self.frame:Hide()
    end
    OverrideSuperTrackedAlphaState(false)
    if self.unsubscribeBeamOption then
        self.unsubscribeBeamOption()
        self.unsubscribeBeamOption = nil
    end
end

if not Wayfinders.wayfinders then Wayfinders.wayfinders = {} end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating

---@param title string
---@param description string?
function MapPinEnhancedWayfinderFloating:SetDestinationText(title, description)
    if self.data then
        self.data.title, self.data.description = title, description
    end
    self:RefreshTitle()
end
