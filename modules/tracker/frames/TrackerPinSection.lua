---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")
local Events = MapPinEnhanced:GetModule("Events")


---@class MapPinEnhancedTrackerPinSection : Button
---@field menuButton Button
---@field left Texture
---@field right Texture
---@field middle Texture
---@field icon Texture
---@field title FontString
MapPinEnhancedTrackerPinSectionMixin = {}


function MapPinEnhancedTrackerPinSectionMixin:UpdateSectionTitle()
    self.title:SetText(string.format("%s (%d/%d)", self.section.name, self.section.pinCount))
end

function MapPinEnhancedTrackerPinSectionMixin:UpdateSection()
    self.icon:SetTexture(self.section.icon)
    self:UpdateSectionTitle()
end

---@param section PinSection
function MapPinEnhancedTrackerPinSectionMixin:SetSection(section)
    self.section = section
    local eventName = Events:GetEventNameWithID("UpdateSection", section.name)
    self:UpdateSection()
    Events:RegisterEventCallback(self, eventName, self.UpdateSection)
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
        self:GetParent()
    end
end

function MapPinEnhancedTrackerPinSectionMixin:IsCollapsed()
    return self.collapsed
end

function MapPinEnhancedTrackerPinSectionMixin:OnClick()
    if self.collapsed then
        self.collapsed = false
        self:Expand()
    else
        self.collapsed = true
        self:Collapse()
    end
    ---@type MapPinEnhancedTrackerPinView we only update the pins if the view is active
    local activeView = Tracker:GetActiveView()
    if activeView.type == "Pins" then
        activeView:UpdateHeight()
    end
end
