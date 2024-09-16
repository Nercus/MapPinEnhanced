---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")
local PinSections = MapPinEnhanced:GetModule("PinSections")
local SavedVars = MapPinEnhanced:GetModule("SavedVars")

---@class MapPinEnhancedTrackerPinView : ScrollFrameTemplate
---@field Child Frame
---@field type "Pins"
MapPinEnhancedTrackerPinViewTemplate = {
    type = "Pins",
}

local ENTRY_HEIGHT = 37
local ENTRY_GAP = 3

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
        sectionHeader:ClearAllPoints()
        if lastFrame then
            sectionHeader:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -ENTRY_GAP)
            sectionHeader:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, -ENTRY_GAP)
        else
            sectionHeader:SetPoint("TOPLEFT", self.Child, "TOPLEFT", 0, 0)
            sectionHeader:SetPoint("TOPRIGHT", self.Child, "TOPRIGHT", 0, 0)
        end
        sectionHeader:Show()
        lastFrame = sectionHeader
        for _, pin in pairs(section:GetPins()) do
            local trackerEntry = pin.trackerPinEntry
            trackerEntry:ClearAllPoints()
            trackerEntry:SetParent(self.Child)
            trackerEntry:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -ENTRY_GAP)
            trackerEntry:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, -ENTRY_GAP)
            trackerEntry:SetCollapsesLayout(true) -- This is needed to make the layout work
            trackerEntry:Show()
            lastFrame = trackerEntry
        end
    end
end

function MapPinEnhancedTrackerPinViewTemplate:GetViewHeight()
    local maxEntryCount = SavedVars:Get("tracker", "trackerHeight")
    if not maxEntryCount then
        maxEntryCount = SavedVars:GetDefault("tracker", "trackerHeight")
    end

    local entryCount = 0
    local sections = PinSections:GetAllSections()
    for _, section in pairs(sections) do
        entryCount = entryCount + 1 -- the header
        if not section.header:IsCollapsed() then
            ---@type number
            entryCount = entryCount + section:GetPinCount()
        end
        if entryCount >= maxEntryCount then
            break
        end
    end

    local height = entryCount * (ENTRY_HEIGHT + ENTRY_GAP) - ENTRY_GAP       -- - ENTRY_GAP to remove the last gap
    local maxHeight = maxEntryCount * (ENTRY_HEIGHT + ENTRY_GAP) - ENTRY_GAP -- - ENTRY_GAP to remove the last gap
    if height > maxHeight then
        height = maxHeight
    end
    height = Round(height)
    return height
end

function MapPinEnhancedTrackerPinViewTemplate:UpdateHeight()
    if not self:IsActiveView() then return end -- Only update if this is the active view
    self.Child:SetHeight(self:GetViewHeight())
    self.Child:Show()
    self.ScrollBar:Update()
end

function MapPinEnhancedTrackerPinViewTemplate:Update()
    if not self:IsActiveView() then return end -- Only update if this is the active view
    Tracker:SetTitle("Pins")
    self:UpdateAllPins()
    self:UpdateHeight()
end
