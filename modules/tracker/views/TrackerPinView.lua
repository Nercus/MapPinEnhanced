---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")
local PinSections = MapPinEnhanced:GetModule("PinSections")

---@class MapPinEnhancedTrackerPinViewTemplate : ScrollFrame
---@field type "Pins"
MapPinEnhancedTrackerPinViewTemplate = {
    type = "Pins"
}


function MapPinEnhancedTrackerPinViewTemplate:IsActiveView()
    return Tracker:GetActiveView() == "Pins"
end

function MapPinEnhancedTrackerPinViewTemplate:UpdateAllPins()
    local sections = PinSections:GetAllSections()
    local addonSections = PinSections:GetSectionsBySource(MapPinEnhanced.addonName)
    -- create a non keyed table that is order that the section from MapPinEnhanced are always first, then the rest
    local orderedSections = addonSections
    for _, section in pairs(sections) do
        if section.source ~= MapPinEnhanced.addonName then
            table.insert(orderedSections, section)
        end
    end


    local lastFrame = nil

    for _, section in ipairs(orderedSections) do
        local sectionHeader = section:GetHeader()
        sectionHeader:SetParent(self.Child)
        if lastFrame then
            sectionHeader:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
            sectionHeader:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, 0)
        else
            sectionHeader:SetPoint("TOPLEFT", self.Child, "TOPLEFT", 0, 0)
            sectionHeader:SetPoint("TOPRIGHT", self.Child, "TOPRIGHT", 0, 0)
        end
        sectionHeader:Show()
        lastFrame = sectionHeader
        for _, pin in pairs(section:GetPins()) do
            local trackerEntry = pin.trackerPinEntry
            trackerEntry:SetParent(self.Child)
            trackerEntry:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, 0)
            trackerEntry:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, 0)
            trackerEntry:SetCollapsesLayout(true)
            trackerEntry:Show()
            lastFrame = trackerEntry
        end
    end
end

function MapPinEnhancedTrackerPinViewTemplate:Update()
    if not self:IsActiveView() then return end -- Only update if this is the active view
    Tracker:SetTitle("Pins")
    self:UpdateAllPins()
    self.Child:SetHeight(300)
    self.Child:Show()
    MapPinEnhanced:Debug(self)
end
