---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData | nil
---@field frames {modern: MapPinEnhancedFloatingModernTemplate, simple: MapPinEnhancedFloatingSimpleTemplate}
---@field frameType WayfinderFloatingFrameType | nil
local MapPinEnhancedWayfinderFloating = {}

---@param frameType WayfinderFloatingFrameType
function MapPinEnhancedWayfinderFloating:SetFrameType(frameType)
    if self.frameType == frameType then return end
    self:GetFrame()
    self:ShowFrame()
end

---@enum (key) WayfinderFloatingFrameType
local templates = {
    modern = "MapPinEnhancedFloatingModernTemplate",
    simple = "MapPinEnhancedFloatingSimpleTemplate",
}

---@return MapPinEnhancedFloatingModernTemplate | MapPinEnhancedFloatingSimpleTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    ---@type WayfinderFloatingFrameType
    local currentType = Options:GetOptionValue("Wayfinder.Floating.Style")

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

function MapPinEnhancedWayfinderFloating:Reset()
    self.data = nil
    self:HideFrame()
end

---@param wayfinderData WayfinderData | nil
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end
    self.data = wayfinderData
    self:ShowFrame()
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
    OverrideSuperTrackedAlphaState(true)
    self.overrideActive = true
end

function MapPinEnhancedWayfinderFloating:Enable()
    self:SetOverride()
    self.unsubscribeFrameTypeOption = Options:SubscribeToOptionChanges("Wayfinder.Floating.Style", function(value)
        self:SetFrameType(value)
    end)
end

function MapPinEnhancedWayfinderFloating:Disable()
    local frame = self:GetFrame()
    if frame then
        frame:Hide()
    end
    OverrideSuperTrackedAlphaState(false)
    if self.unsubscribeFrameTypeOption then
        self.unsubscribeFrameTypeOption()
        self.unsubscribeFrameTypeOption = nil
    end
end

--- Inject into WayfinderManager
if not Wayfinders.wayfinders then
    Wayfinders.wayfinders = {}
end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating



Options:SubscribeToOptionChanges("Wayfinder.Floating.Enable", function(value)
    if value then
        Wayfinders:EnableWayfinder("WAYFINDER_FLOATING")
    else
        Wayfinders:DisableWayfinder("WAYFINDER_FLOATING")
    end
end)
