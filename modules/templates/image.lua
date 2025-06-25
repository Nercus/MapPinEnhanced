---@class MapPinEnhancedImageTemplate : Frame
---@field image Texture
MapPinEnhancedImageMixin = {}


---@param imagePath string
function MapPinEnhancedImageMixin:SetImage(imagePath)
    self.imagePath = imagePath
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
end

function MapPinEnhancedImageMixin:OnLoad()
    self:SetImage(self.imagePath)
end
