---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Tracker = MapPinEnhanced:GetModule("Tracker")
local SavedVars = MapPinEnhanced:GetModule("SavedVars")

---@class MapPinEnhancedTrackerView : Frame
---@field viewName string name of the view (Key value in template)
---@field gap number? optional gap in entries(Key value in template)
---@field fixedEntryHeight number? optional fixed height for entries, if not set the height is calculated by the entries and the maxentrycount is ignored(Key value in template)
---@field parentKey string? key of the parent the entries should be anchored to, if not set the parent is the parent of the view(Key value in template)
MapPinEnhancedTrackerViewMixin = {}

---@class MapPinEnhancedTrackerScrollableView : MapPinEnhancedTrackerView, ScrollFrameTemplate


local DEFAULT_GAP = 5

---@return boolean
function MapPinEnhancedTrackerViewMixin:IsActiveView()
    local activeView = Tracker:GetActiveView()
    return activeView and activeView == self.viewName
end

---@param entries MapPinEnhancedTrackerPinSection[] | MapPinEnhancedTrackerSetEntry[]
function MapPinEnhancedTrackerViewMixin:SetEntries(entries)
    self.entries = entries
end

function MapPinEnhancedTrackerViewMixin:UpdateAll()
    local parent = self.parentKey and self[self.parentKey] or self
    local entries = self.entries
    if not entries then return end
    local gap = self.gap or DEFAULT_GAP
    local lastElement = nil
    for _, entry in ipairs(entries) do
        entry:ClearAllPoints()
        entry:SetParent(parent)
        if lastElement then
            entry:SetPoint("TOPLEFT", lastElement, "BOTTOMLEFT", 0, -gap)
            entry:SetPoint("TOPRIGHT", lastElement, "BOTTOMRIGHT", 0, -gap)
        else
            entry:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
            entry:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, 0)
        end
        entry:Show()
        entry:SetPrevious(lastElement)
        if lastElement then
            lastElement:SetNext(entry)
        end
        lastElement = entry
    end
end

---@param entry MapPinEnhancedTrackerPinSection | MapPinEnhancedTrackerSetEntry
function MapPinEnhancedTrackerViewMixin:Remove(entry)
    local parent = self.parentKey and self[self.parentKey] or self
    local gap = self.gap or DEFAULT_GAP
    local nextFrame = entry.next
    local previousFrame = entry.previous
    if nextFrame then
        nextFrame:SetPrevious(previousFrame)
        nextFrame:ClearAllPoints()
        if previousFrame then
            nextFrame:SetPoint("TOPLEFT", previousFrame, "BOTTOMLEFT", 0, -gap)
            nextFrame:SetPoint("TOPRIGHT", previousFrame, "BOTTOMRIGHT", 0, -gap)
        else
            nextFrame:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
            nextFrame:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, 0)
        end
    end
    if previousFrame then
        previousFrame:SetNext(nextFrame)
    end
    entry:Hide()
    self:UpdateHeight()
end

function MapPinEnhancedTrackerViewMixin:UpdateHeight()
    local maxEntryCount = SavedVars:Get("tracker", "trackerHeight")
    if not maxEntryCount then
        maxEntryCount = SavedVars:GetDefault("tracker", "trackerHeight")
    end
    if not self.fixedEntryHeight then
        maxEntryCount = 999 -- set a high number to ignore the max height
    end

    --- we calculate the maximum allowed height based on the maxEntryCount, for elements that have no fixed Entry height we use a very large height as they also dont have a scrollframe
    local maxHeight = maxEntryCount * (self.fixedEntryHeight or 999) - (self.gap or DEFAULT_GAP)

    local entries = self.entries
    local totalHeight = 0
    for _, entry in ipairs(entries) do
        local entryHeight = entry:GetHeight()
        if not entryHeight then
            entryHeight = 0
        end
        totalHeight = totalHeight + entryHeight
        if totalHeight >= maxHeight then
            totalHeight = maxHeight
            break
        end
    end
    totalHeight = Round(totalHeight)

    local parent = self.parentKey and self[self.parentKey] or self
    parent:SetHeight(totalHeight)


    -- update the scroll extent if we have a scrollframe
    ---@cast self MapPinEnhancedTrackerScrollableView
    if self.fixedEntryHeight and self.SetPanExtent then
        self:SetPanExtent(self.fixedEntryHeight + (self.gap or DEFAULT_GAP))
    end
end

function MapPinEnhancedTrackerViewMixin:Update()
    Tracker:SetTitle(self.viewName)
    self:UpdateAll()
end
