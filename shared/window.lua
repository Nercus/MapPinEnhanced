---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedWindowHeader : Frame
---@field title FontString

---@class MapPinEnhancedWindowBackground : Frame
---@field bg Texture
---@field backgroundArt Texture
---@field backgroundMask Texture

---@class MapPinEnhancedWindowTemplate : Frame
---@field header MapPinEnhancedWindowHeader
---@field background MapPinEnhancedWindowBackground
---@field windowTitle string? set through keyvalues
---@field windowColor WindowColor? set through keyvalues
MapPinEnhancedWindowMixin = {}

---@param title string
function MapPinEnhancedWindowMixin:SetTitle(title)
    self.header.title:SetText(string.format("%s - %s", MapPinEnhanced.displayName, title))
end

---@enum (key) WindowColor
local WINDOW_COLORS = {
    ["yellow"] = CreateColor(0.4, 0.4, 0, 1),
    ["green"] = CreateColor(0, 0.4, 0, 1),
    ["blue"] = CreateColor(0, 0, 0.4, 1),
    ["purple"] = CreateColor(0.4, 0, 0.4, 1),
    ["red"] = CreateColor(0.4, 0, 0, 1),
}

---@param colorName WindowColor
function MapPinEnhancedWindowMixin:SetBackgroundGradientColor(colorName)
    assert(colorName, "MapPinEnhancedWindowMixin:SetBackgroundGradientColor: colorName is nil")
    assert(type(colorName) == "string",
        "MapPinEnhancedWindowMixin:SetBackgroundGradientColor: colorName must be a string")

    local color = WINDOW_COLORS[colorName]
    assert(color, "MapPinEnhancedWindowMixin:SetBackgroundGradientColor: unknown color: " .. colorName)

    local r, g, b = color:GetRGBA()
    self.background.backgroundArt:SetGradient("HORIZONTAL", CreateColor(r, g, b, 1), CreateColor(1, 1, 1, 1))
end

function MapPinEnhancedWindowMixin:OnLoad()
    local frameName = self:GetName()
    assert(frameName, "MapPinEnhancedWindowMixin:OnLoad: window must have a global name")

    MapPinEnhanced:RegisterDraggableFrame(self, frameName, self.header, function()
        return false
    end)
    table.insert(UISpecialFrames, frameName)

    if self.windowTitle then
        self:SetTitle(L[self.windowTitle] or self.windowTitle)
    end

    if self.windowColor then
        self:SetBackgroundGradientColor(self.windowColor)
    end
end

function MapPinEnhancedWindowMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function MapPinEnhancedWindowMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
end
