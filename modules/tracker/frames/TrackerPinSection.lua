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
    MapPinEnhanced:Debug(section)
    self.section = section
    self.title:SetText(section.name)
    self.icon:SetTexture(section.icon)
end

function MapPinEnhancedTrackerPinSectionMixin:Expand()
    local pins = self.section:GetPins()
    for _, pin in pairs(pins) do
        local trackerEntry = pin.trackerPinEntry
        trackerEntry:Show()
    end
end

function MapPinEnhancedTrackerPinSectionMixin:Collapse()
    local pins = self.section:GetPins()
    for _, pin in pairs(pins) do
        local trackerEntry = pin.trackerPinEntry
        trackerEntry:Hide()
    end
end

function MapPinEnhancedTrackerPinSectionMixin:OnClick()
    if self.collapsed then
        self.collapsed = false
        self:Expand()
    else
        self.collapsed = true
        self:Collapse()
    end
end
