---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")
local SetManager = MapPinEnhanced:GetModule("SetManager")
local SavedVars = MapPinEnhanced:GetModule("SavedVars")

---@class MapPinEnhancedTrackerSetView : ScrollFrameTemplate
---@field Child Frame
---@field type "Sets"
MapPinEnhancedTrackerSetViewTemplate = {}

local ENTRY_HEIGHT = 37
local ENTRY_GAP = 3

function MapPinEnhancedTrackerSetViewTemplate:IsActiveView()
    return Tracker:GetActiveView() == "Sets"
end

function MapPinEnhancedTrackerSetViewTemplate:UpdateAllPins()
    local sets = SetManager:GetAlphabeticalSortedSets()
    local lastFrame = nil
    for _, set in ipairs(sets) do
        local setEntry = set.trackerSetEntry
        setEntry:SetParent(self.Child)
        setEntry:ClearAllPoints()
        if lastFrame then
            setEntry:SetPoint("TOPLEFT", lastFrame, "BOTTOMLEFT", 0, -ENTRY_GAP)
            setEntry:SetPoint("TOPRIGHT", lastFrame, "BOTTOMRIGHT", 0, -ENTRY_GAP)
        else
            setEntry:SetPoint("TOPLEFT", self.Child, "TOPLEFT", 0, 0)
            setEntry:SetPoint("TOPRIGHT", self.Child, "TOPRIGHT", 0, 0)
        end
        setEntry:Show()
        lastFrame = setEntry
    end
end

function MapPinEnhancedTrackerSetViewTemplate:GetViewHeight()
    local maxEntryCount = SavedVars:Get("tracker", "trackerHeight")
    if not maxEntryCount then
        maxEntryCount = SavedVars:GetDefault("tracker", "trackerHeight")
    end


    local entryCount = SetManager:GetSetCount()
    if maxEntryCount and entryCount >= maxEntryCount then
        entryCount = maxEntryCount
    end

    local height = entryCount * (ENTRY_HEIGHT + ENTRY_GAP) - ENTRY_GAP       -- - ENTRY_GAP to remove the last gap
    local maxHeight = maxEntryCount * (ENTRY_HEIGHT + ENTRY_GAP) - ENTRY_GAP -- - ENTRY_GAP to remove the last gap
    if height > maxHeight then
        height = maxHeight
    end
    height = Round(height)
    return height
end

function MapPinEnhancedTrackerSetViewTemplate:UpdateHeight()
    if not self:IsActiveView() then return end -- Only update if this is the active view
    self.Child:SetHeight(self:GetViewHeight())
    self.Child:Show()
    self.ScrollBar:Update()
end

function MapPinEnhancedTrackerSetViewTemplate:Update()
    if not self:IsActiveView() then return end -- Only update if this is the active view
    Tracker:SetTitle("Sets")
    self:UpdateAllPins()
    self:UpdateHeight()
end
