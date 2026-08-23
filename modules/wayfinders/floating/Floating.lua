---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Options = MapPinEnhanced:GetModule("Options")

---@alias FloatingStyle "basic"|"enhanced"

---@class MapPinEnhancedWayfinderFloating : MapPinEnhancedWayfinder
---@field data WayfinderData?
---@field frames table<FloatingStyle, MapPinEnhancedWayfinderFloatingEnhancedTemplate|MapPinEnhancedWayfinderFloatingBasicTemplate>?
---@field style FloatingStyle?
---@field runtimeEnabled boolean?
---@field unsubscribeStyleOption fun()?
local MapPinEnhancedWayfinderFloating = {}

local ENABLE_OPTION = "Wayfinder.Floating.Enable"
local STYLE_OPTION = "Wayfinder.Floating.Style"

local savedStyleToStyle = {
    modern = "enhanced",
    simple = "basic",
}

local styles = {
    basic = {
        template = "MapPinEnhancedWayfinderFloatingBasicTemplate",
        name = "MapPinEnhancedWayfinderFloatingBasic",
    },
    enhanced = {
        template = "MapPinEnhancedWayfinderFloatingEnhancedTemplate",
        name = "MapPinEnhancedWayfinderFloatingEnhanced",
    },
}

---@param savedStyle string
---@return FloatingStyle
local function GetStyle(savedStyle)
    local style = savedStyleToStyle[savedStyle]
    if style then return style end

    local defaultStyle = Options:GetDefaultValue(STYLE_OPTION)
    style = savedStyleToStyle[defaultStyle]
    assert(style, "Floating:GetStyle: default style is invalid")
    return style
end

---@return MapPinEnhancedWayfinderFloatingEnhancedTemplate|MapPinEnhancedWayfinderFloatingBasicTemplate
function MapPinEnhancedWayfinderFloating:GetFrame()
    local style = self.style or GetStyle(Options:GetOptionValue(STYLE_OPTION))
    self.style = style
    if self.frames and self.frames[style] then return self.frames[style] end

    local styleConfig = styles[style]
    assert(styleConfig, "Floating:GetFrame: invalid style " .. tostring(style))
    ---@type MapPinEnhancedWayfinderFloatingEnhancedTemplate|MapPinEnhancedWayfinderFloatingBasicTemplate
    local frame = CreateFrame("Frame", styleConfig.name, nil, styleConfig.template)
    self.frames = self.frames or {}
    self.frames[style] = frame
    return frame
end

---@param savedStyle string
function MapPinEnhancedWayfinderFloating:SetStyle(savedStyle)
    local style = GetStyle(savedStyle)
    if self.style == style then return end

    local previousFrame = self.style and self.frames and self.frames[self.style]
    if previousFrame then previousFrame:Hide() end
    self.style = style
    if self.runtimeEnabled and self.data then self:Init(self.data) end
end

---@param title string
function MapPinEnhancedWayfinderFloating:SetTitle(title)
    self:GetFrame():SetTitle(title)
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
    self:GetFrame().pin:SetStyleMode(Wayfinders:GetTargetStyleMode(targetType))
end

---@param lock boolean
function MapPinEnhancedWayfinderFloating:SetLock(lock)
    self:GetFrame().pin:SetLock(lock)
end

function MapPinEnhancedWayfinderFloating:Reset()
    self.data = nil
    if self.style and self.frames and self.frames[self.style] then
        self.frames[self.style]:Hide()
    end
end

---@param wayfinderData WayfinderData?
function MapPinEnhancedWayfinderFloating:Init(wayfinderData)
    if not wayfinderData then
        self:Reset()
        return
    end

    self.data = wayfinderData
    local frame = self:GetFrame()
    frame.pin:SetStyleMode(Wayfinders:GetTargetStyleMode(wayfinderData.targetType))
    frame:SetLocation(wayfinderData.mapID, wayfinderData.x, wayfinderData.y)
    if wayfinderData.texture then
        frame:SetTexture(wayfinderData.texture, wayfinderData.usesAtlas)
    else
        frame:SetColor(wayfinderData.color)
    end
    frame:SetTitle(wayfinderData.title)
    frame.pin:SetLock(wayfinderData.lock)
    frame:Show()
end

---@param enable boolean
local function OverrideSuperTrackedAlphaState(enable)
    local alpha = enable and 1 or 0
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Invalid, alpha)
    SuperTrackedFrameMixin:SetTargetAlphaForState(Enum.NavigationState.Occluded, alpha)
end

function MapPinEnhancedWayfinderFloating:Enable()
    if self.runtimeEnabled then return end
    self.runtimeEnabled = true
    OverrideSuperTrackedAlphaState(true)
    self.unsubscribeStyleOption = Options:SubscribeToOptionChanges(STYLE_OPTION, function(value)
        self:SetStyle(value)
    end)
end

function MapPinEnhancedWayfinderFloating:Disable()
    if not self.runtimeEnabled then return end
    self.runtimeEnabled = nil
    if self.style and self.frames and self.frames[self.style] then
        self.frames[self.style]:Hide()
    end
    OverrideSuperTrackedAlphaState(false)
    if self.unsubscribeStyleOption then
        self.unsubscribeStyleOption()
        self.unsubscribeStyleOption = nil
    end
end

if not Wayfinders.wayfinders then Wayfinders.wayfinders = {} end
Wayfinders.wayfinders["WAYFINDER_FLOATING"] = MapPinEnhancedWayfinderFloating

Options:SubscribeToOptionChanges(ENABLE_OPTION, function(value)
    if value then
        Wayfinders:EnableWayfinder("WAYFINDER_FLOATING")
    else
        Wayfinders:DisableWayfinder("WAYFINDER_FLOATING")
    end
end)
