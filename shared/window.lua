---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@class MapPinEnhancedWindowTitleContainer : Frame
---@field TitleText FontString

---@class MapPinEnhancedWindowPortraitContainer : Frame
---@field portrait Texture

---@class MapPinEnhancedWindowTemplate : Frame
---@field TitleContainer MapPinEnhancedWindowTitleContainer
---@field PortraitContainer MapPinEnhancedWindowPortraitContainer
---@field CloseButton Button
---@field background Texture
---@field backgroundArt Texture
---@field backgroundMask MaskTexture
---@field windowTitle string? set through keyvalues
MapPinEnhancedWindowMixin = CreateFromMixins(PortraitFrameMixin)

---@param title string
function MapPinEnhancedWindowMixin:SetTitle(title)
    self.TitleContainer.TitleText:SetText(string.format("%s - %s", MapPinEnhanced.displayName, title))
end

function MapPinEnhancedWindowMixin:OnLoad()
    local frameName = self:GetName()
    assert(frameName, "MapPinEnhancedWindowMixin:OnLoad: window must have a global name")

    self.PortraitContainer.portrait:SetTexture(MapPinEnhanced.assetsPath .. "\\logo.png")
    self.PortraitContainer.portrait:SetTexCoord(0, 1, 0, 1)

    MapPinEnhanced:RegisterDraggableFrame(self, frameName, self.TitleContainer, function()
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
