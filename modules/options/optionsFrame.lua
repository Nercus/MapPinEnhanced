---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionsFrame : Frame
MapPinEnhancedOptionsFrameMixin = {}

function MapPinEnhancedOptionsFrameMixin:OnLoad()
    ---@type SettingsCategoryMixin
    local category = Settings.RegisterCanvasLayoutCategory(self, MapPinEnhanced.name)
    ---@type number
    self.categoryID = category:GetID()
    Settings.RegisterAddOnCategory(category)
    self:Show()
end
