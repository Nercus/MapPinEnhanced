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
MapPinEnhancedWindowMixin = {}

---@param title string
function MapPinEnhancedWindowMixin:SetTitle(title)
    self.header.title:SetText(string.format("%s - %s", MapPinEnhanced.displayName, title))
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
end

function MapPinEnhancedWindowMixin:OnShow()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end

function MapPinEnhancedWindowMixin:OnHide()
    PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
end
