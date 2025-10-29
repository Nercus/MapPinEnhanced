---@class MapPinEnhancedImageTemplate : Frame
---@field image Texture
---@field imagePath string
---@field sourceWidth number
---@field sourceHeight number
MapPinEnhancedImageMixin = {}


function MapPinEnhancedImageMixin:UpdateHeight()
    assert(self.sourceWidth and self.sourceHeight, "sourceWidth and sourceHeight must be set")
    local aspectRatio = self.sourceHeight / self.sourceWidth
    local currentWidth = self:GetWidth()
    local newHeight = Round(currentWidth * aspectRatio)
    self:SetHeight(newHeight)
    self.lastWidth = currentWidth
end

---@param imagePath string
---@param sourceWidth number
---@param sourceHeight number
function MapPinEnhancedImageMixin:SetImage(imagePath, sourceWidth, sourceHeight)
    self.imagePath = imagePath
    self.sourceWidth = sourceWidth or self.sourceWidth
    self.sourceHeight = sourceHeight or self.sourceHeight
    if not self.imagePath or self.imagePath == "" then
        self.image:Hide()
        return
    end
    -- when there is a slash or backslash in the path, it is a file path and we use SetTexture
    -- otherwise, it is a texture name and we use SetAtlas
    if self.imagePath:find("[/\\]") then
        self.image:SetTexture(self.imagePath)
    else
        self.image:SetAtlas(self.imagePath)
    end
    self.image:Show()
    self:UpdateHeight()
end

function MapPinEnhancedImageMixin:OnSizeChanged()
    local currentWidth = self:GetWidth()
    if not self.lastWidth or self.lastWidth ~= currentWidth then
        self:UpdateHeight()
    end
end

function MapPinEnhancedImageMixin:OnLoad()
    self:SetImage(self.imagePath, self.sourceWidth, self.sourceHeight)
end
