---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData | nil
---@field frames table<WayfinderFloatingFrameType, MapPinEnhancedFloatingModernTemplate | MapPinEnhancedFloatingSimpleTemplate> | nil
---@field frameType WayfinderFloatingFrameType | nil
local MapPinEnhancedWayfinderFloating = {}

---@param frameType WayfinderFloatingFrameType
function MapPinEnhancedWayfinderFloating:SetFrameType(frameType)
    if self.frameType == frameType then return end

    local previousFrame = self.frameType and self.frames and self.frames[self.frameType]
    if previousFrame then
        previousFrame:Hide()
    end

    self.frameType = frameType
    if self.data then
        self:Init(self.data)
    end
end

---@enum (key) WayfinderFloatingFrameType
local floatingFrameTypes = {
    modern = {
        template = "MapPinEnhancedFloatingModernTemplate",
        name = "MapPinEnhancedWayfinderFloatingFrameModern",
    },
    simple = {
        template = "MapPinEnhancedFloatingSimpleTemplate",
        name = "MapPinEnhancedWayfinderFloatingFrameSimple",
    },
}

---@return MapPinEnhancedFloatingModernTemplate | MapPinEnhancedFloatingSimpleTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    ---@type WayfinderFloatingFrameType
    local currentType = Options:GetOptionValue("Wayfinder.Floating.Style")

    if self.frames and self.frames[currentType] then
        return self.frames[currentType]
    end
    local frameType = floatingFrameTypes[currentType]
    if not frameType then
        error("Invalid frame type: " .. tostring(currentType))
    end
    ---@type MapPinEnhancedFloatingModernTemplate | MapPinEnhancedFloatingSimpleTemplate
    local frame = CreateFrame("Frame", frameType.name, nil, frameType.template)
    self.frames = self.frames or {}
    self.frames[currentType] = frame
    return frame
end

---@param title string
function MapPinEnhancedWayfinderFloating:SetTitle(title)
    local frame = self:GetFrame()
    if frame.SetTitle then
        frame:SetTitle(title)
    end
end

---@param color PinColor
function MapPinEnhancedWayfinderFloating:SetColor(color)
    local frame = self:GetFrame()
    if frame.SetColor then
        frame:SetColor(color)
    end
end

---@param texture string|number
---@param usesAtlas boolean
function MapPinEnhancedWayfinderFloating:SetTexture(texture, usesAtlas)
    local frame = self:GetFrame()
    if frame.SetTexture then
        frame:SetTexture(texture, usesAtlas)
    end
end

---@param targetType WayfinderTargetType
function MapPinEnhancedWayfinderFloating:SetTargetType(targetType)
    local frame = self:GetFrame()
    if frame.pin then
        frame.pin:SetStyleMode(Wayfinders:GetTargetStyleMode(targetType))
    end
end

---@param lock boolean
function MapPinEnhancedWayfinderFloating:SetLock(lock)
    local frame = self:GetFrame()
    if frame.pin then
        frame.pin:SetLock(lock)
    end
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
    local frame = self:GetFrame()
    self:SetTargetType(wayfinderData.targetType)
    if frame.SetLocation then
        frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    end
    if wayfinderData.texture then
        self:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        self:SetColor(wayfinderData.color)
    end
    self:SetTitle(wayfinderData.title)
    self:SetLock(wayfinderData.lock)
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
