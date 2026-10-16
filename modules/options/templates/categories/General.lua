---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Options = MapPinEnhanced:GetModule("Options")

---@class MapPinEnhancedOptionCategoryGeneralTemplate : MapPinEnhancedOptionCategoryBaseTemplate
---@field customButton MapPinEnhancedFormElementTemplate
MapPinEnhancedOptionCategoryGeneralMixin = CreateFromMixins(MapPinEnhancedOptionCategoryBaseMixin)

function MapPinEnhancedOptionCategoryGeneralMixin:RefreshEnabledOptions()
    local enabled = Options:GetOptionValue(self.enableKey) == true
    self.customButton:SetEnabledState(enabled)
    self.customButton:SetShown(enabled)
    if not enabled then self.customButton.searchHighlight:Hide() end
    if Options.frame then Options.frame:UpdateLayout() end
end
