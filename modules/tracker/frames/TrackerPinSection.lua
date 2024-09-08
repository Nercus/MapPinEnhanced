---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinSectionMixin : Button
---@field left Texture
---@field right Texture
---@field middle Texture
---@field title FontString
---@field icon Texture
---@field menuButton Button
MapPinEnhancedTrackerPinSectionMixin = {}


---@param section PinSection
function MapPinEnhancedTrackerPinSectionMixin:SetSection(section)
    self.section = section
    self.title:SetText(section.name)
    self.icon:SetTexture(section.icon)
end
