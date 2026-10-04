---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedTrackerTemplate
MapPinEnhancedTrackerListMixin = {}

---@class MapPinEnhancedTrackerPinNode : TreeNodeMixin
---@field ordinal number?

---@param first MapPinEnhancedGroupPinEntry
---@param second MapPinEnhancedGroupPinEntry
---@return boolean
local function IsEntryBefore(first, second)
    if first.order ~= second.order then return first.order > second.order end
    local firstTitle, secondTitle = first.data.title or first.pinID, second.data.title or second.pinID
    if firstTitle ~= secondTitle then return firstTitle < secondTitle end
    return first.pinID < second.pinID
end

---@param scrollToTrackedPin boolean?
---@return TreeDataProviderMixin, number, number
function MapPinEnhancedTrackerListMixin:UpdatePinList(scrollToTrackedPin)
    local provider = CreateTreeDataProvider()
    local reachedPins, totalPins = 0, 0
    local trackedPin = scrollToTrackedPin and Pins:GetTrackedPin() or nil
    for group in Groups:EnumerateGroups() do
        if not group.pinsUpdating and not group:IsHidden() then
            local active, reached, total = group:GetPinCounts()
            if total > 0 then
                local node = provider:Insert(group) --[[@as MapPinEnhancedTrackerGroupNode]]
                node.groupID = group:GetGroupID()
                node.activePins, node.reachedPins, node.totalPins = active, reached, total
                -- Retained archives occupy ordinals too. Sort once before publishing the tree.
                local entries = group:GetPinEntries()
                table.sort(entries, IsEntryBefore)
                local ordered = group:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED
                for ordinal, entry in ipairs(entries) do
                    if entry.pin then
                        local pinNode = node:Insert(entry.pin) --[[@as MapPinEnhancedTrackerPinNode]]
                        pinNode.ordinal = ordered and ordinal or nil
                    end
                end
                local collapsed = self.collapsedGroups[node.groupID] or false
                if trackedPin and trackedPin.group == group then collapsed = false end
                node:SetCollapsed(collapsed, false, TreeDataProviderConstants.SkipInvalidation)
                reachedPins, totalPins = reachedPins + reached, totalPins + total
            end
        end
    end
    provider:SetSortComparator(function(first, second)
        return Groups:IsGroupBefore(first:GetData(), second:GetData())
    end, false, false)
    return provider, reachedPins, totalPins
end
