---@class MapPinEnhancedMapArtMixin : Texture
MapPinEnhancedMapArtMixin = {}

local IMAGE_ASPECT_RATIO = 1839 / 855
local FOCUS_X = 0.75
local FOCUS_Y = 0.5

function MapPinEnhancedMapArtMixin:UpdateCrop()
    local width, height = self:GetSize()
    if width <= 0 or height <= 0 then
        return
    end

    -- Fill the texture without distortion, keeping the center-right in view.
    local visibleWidth = math.min(1, width / height / IMAGE_ASPECT_RATIO)
    local visibleHeight = math.min(1, height / width * IMAGE_ASPECT_RATIO)
    local left = math.max(0, math.min(1 - visibleWidth, FOCUS_X - visibleWidth / 2))
    local top = math.max(0, math.min(1 - visibleHeight, FOCUS_Y - visibleHeight / 2))
    self:SetTexCoord(left, left + visibleWidth, top, top + visibleHeight)
end

function MapPinEnhancedMapArtMixin:OnLoad()
    -- Texture regions have no OnSizeChanged script. These anchored decorations
    -- stay with their parent for its lifetime; HookScript preserves owner handlers.
    local parent = self:GetParent()
    parent:HookScript("OnSizeChanged", function()
        self:UpdateCrop()
    end)
    self:UpdateCrop()
end
