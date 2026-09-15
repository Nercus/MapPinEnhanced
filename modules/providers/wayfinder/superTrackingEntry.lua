---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Groups = MapPinEnhanced:GetModule("Groups")

---@class SuperTrackingEntry
---@field description string?
---@field title string
---@field texture string|number?
---@field usesAtlas boolean?
---@field tracked boolean
---@field canToggle boolean
---@field changeNumber integer

---@class SuperTrackingEntryState : SuperTrackingEntry
---@field source string
---@field targetID string
---@field track (fun(): boolean)?
---@field untrack (fun())?
---@field pinData pinData

---@type SuperTrackingEntryState?
local entry
local changeNumber = 0
local changingSelection = false
---@type string?
local dismissedSource
---@type string?
local dismissedTargetID

local function PublishEntry()
    changeNumber = changeNumber + 1
    if entry then entry.changeNumber = changeNumber end
    MapPinEnhanced:FireCallback("SUPER_TRACKING_ENTRY_CHANGED")
end

---@param source string
---@param targetID string
---@param title string
---@param description string?
function Providers:UpdateSuperTrackingEntryText(source, targetID, title, description)
    if not entry or not entry.tracked or entry.source ~= source or entry.targetID ~= targetID then return end
    if entry.title == title and entry.description == description then return end
    entry.description = description
    entry.pinData.description = description
    entry.title = title
    entry.pinData.title = title
    PublishEntry()
end

---@return SuperTrackingEntry?
function Providers:GetSuperTrackingEntry()
    if not entry then return nil end
    return {
        title = entry.title, description = entry.description, texture = entry.texture, usesAtlas = entry.usesAtlas,
        tracked = entry.tracked, canToggle = entry.canToggle, changeNumber = entry.changeNumber,
    }
end

---@return boolean
function Providers:IsChangingSuperTrackingEntry()
    return changingSelection
end

---@param source string?
---@param targetID string?
---@param isUserWaypoint boolean
function Providers:UpdateSuperTrackingEntrySelection(source, targetID, isUserWaypoint)
    if source ~= dismissedSource or targetID ~= dismissedTargetID then
        dismissedSource, dismissedTargetID = nil, nil
    end
    if not entry then return end
    if source and entry.tracked and entry.source == source and entry.targetID == targetID then return end
    if not source and not isUserWaypoint and not entry.tracked then return end
    entry = nil
    PublishEntry()
end

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider
---@param targetID string
---@param data WayfinderData
function Providers:ApplySuperTrackingEntry(provider, targetID, data)
    if dismissedSource == provider.source and dismissedTargetID == targetID then return end
    if entry and entry.tracked and entry.source == provider.source and entry.targetID == targetID and
        entry.title == data.title and entry.description == data.description and entry.texture == data.texture and
        entry.usesAtlas == data.usesAtlas and entry.pinData.mapID == data.mapID and
        entry.pinData.x == data.x and entry.pinData.y == data.y then return end
    local track = provider.captureTracking and provider.captureTracking(data)
    entry = {
        source = provider.source, targetID = targetID,
        title = data.title or MapPinEnhanced.L["Target"], description = data.description, texture = data.texture, usesAtlas = data.usesAtlas,
        tracked = true, canToggle = track ~= nil and provider.untrack ~= nil,
        track = track, untrack = provider.untrack, changeNumber = changeNumber,
        pinData = {
            mapID = data.mapID, x = data.x, y = data.y,
            title = data.title or MapPinEnhanced.L["Target"], description = data.description,
            texture = data.texture or "Navigation-Tracked-Icon",
            usesAtlas = data.texture == nil or data.usesAtlas,
        },
    }
    PublishEntry()
end

---@param expectedChangeNumber integer
---@return SuperTrackingEntryState?
local function GetCommandEntry(expectedChangeNumber)
    if changingSelection then return nil end
    Providers:RefreshSuperTrackingSelection(true)
    if entry and entry.changeNumber == expectedChangeNumber then return entry end
end

---@param expectedChangeNumber integer
function Providers:RemoveSuperTrackingEntry(expectedChangeNumber)
    local selectedEntry = GetCommandEntry(expectedChangeNumber)
    if not selectedEntry then return end
    if selectedEntry.tracked and selectedEntry.canToggle then
        self:ToggleSuperTrackingEntry(expectedChangeNumber)
        -- An automatic replacement wins; only discard our own retained object.
        if entry ~= selectedEntry or selectedEntry.tracked then return end
    elseif selectedEntry.tracked then
        -- Sources without selection setters remain Blizzard-owned. Dismiss the
        -- row until a genuine source change, including across metadata refreshes.
        dismissedSource, dismissedTargetID = selectedEntry.source, selectedEntry.targetID
    end
    entry = nil
    PublishEntry()
end

---@param expectedChangeNumber integer
function Providers:ConvertSuperTrackingEntryToPin(expectedChangeNumber)
    local selectedEntry = GetCommandEntry(expectedChangeNumber)
    local group = Groups:GetUngroupedGroup()
    if not selectedEntry or not group then return end
    local data = CopyTable(selectedEntry.pinData)
    data.setTracked = false
    local pin = group:AddPin(data)
    if not pin then return end
    local wasTracked = selectedEntry.tracked
    self:RemoveSuperTrackingEntry(expectedChangeNumber)
    if wasTracked then pin:Track() end
end

---@param expectedChangeNumber integer
function Providers:ShareSuperTrackingEntry(expectedChangeNumber)
    local selectedEntry = GetCommandEntry(expectedChangeNumber)
    if not selectedEntry then return end
    local data = selectedEntry.pinData
    self:LinkToChat(data.x, data.y, data.mapID, data.title)
end

---@param source string
---@param targetID string?
function Providers:ClearSuperTrackingEntry(source, targetID)
    if not entry or not entry.tracked or entry.source ~= source then return end
    if targetID and entry.targetID ~= targetID then return end
    entry = nil
    PublishEntry()
end

---@param expectedChangeNumber integer
function Providers:ToggleSuperTrackingEntry(expectedChangeNumber)
    if changingSelection or not entry or not entry.canToggle or entry.changeNumber ~= expectedChangeNumber then return end
    -- Reconcile a selection that changed before its event reached the coordinator.
    -- An owned Step still represents this entry's original source.
    self:RefreshSuperTrackingSelection(true)
    if not entry or entry.changeNumber ~= expectedChangeNumber then return end
    local selectedEntry = entry
    local track, untrack = selectedEntry.track, selectedEntry.untrack
    if not track or not untrack then return end
    changingSelection = true
    self:CancelSuperTrackingTargetRetries()
    if selectedEntry.tracked then
        local owner, targetID, destinationChangeNumber = Navigation:GetActiveDestinationState()
        selectedEntry.tracked = false
        -- Retain before synchronous events. Clear the source while its temporary
        -- Step is still owned, then release the Step without restoring that source.
        untrack()
        self:ClearStepSuperTracking(false)
        if owner == selectedEntry.source and targetID == selectedEntry.targetID then
            Navigation:ClearDestination(owner, targetID, destinationChangeNumber)
        end
    else
        entry = nil
        track()
    end
    changingSelection = false
    PublishEntry()
    -- Any automatic selection caused by clearing wins over the retained row.
    self:RefreshSuperTrackingSelection()
end

-- Stop tracking through the original source, never through Step arrival.
---@return boolean
function Providers:CanClearNavigationTracking()
    local owner, targetID = Navigation:GetActiveDestinationState()
    local pin = MapPinEnhanced:GetModule("Pins"):GetTrackedPin()
    if owner == "addonPins" then return pin ~= nil and pin.pinID == targetID end
    return entry ~= nil and entry.tracked and entry.canToggle and
        entry.source == owner and entry.targetID == targetID
end

---@param expectedChangeNumber integer
function Providers:ClearNavigationTracking(expectedChangeNumber)
    local step = MapPinEnhanced:GetModule("Wayfinders"):GetStepSnapshot()
    if not step or step.changeNumber ~= expectedChangeNumber or not self:CanClearNavigationTracking() then return end
    local owner = Navigation:GetActiveDestinationState()
    if owner == "addonPins" then
        MapPinEnhanced:GetModule("Pins"):UntrackTrackedPin()
    elseif entry then
        self:ToggleSuperTrackingEntry(entry.changeNumber)
    end
end
