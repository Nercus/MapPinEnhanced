---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Wayfinders
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")
local Navigation = MapPinEnhanced:GetModule("Navigation")

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
local function UpdateEntryChangeNumber()
    changeNumber = changeNumber + 1
    if entry then entry.changeNumber = changeNumber end
end

---@param source string
---@param targetID string
---@param title string
---@param description string?
function Wayfinders:UpdateSuperTrackingEntryText(source, targetID, title, description)
    if not entry or not entry.tracked or entry.source ~= source or entry.targetID ~= targetID then return end
    if entry.title == title and entry.description == description then return end
    entry.description = description
    entry.pinData.description = description
    entry.title = title
    entry.pinData.title = title
    UpdateEntryChangeNumber()
end

---@param source string
---@param targetID string
---@param texture string|number
---@param usesAtlas boolean
function Wayfinders:UpdateSuperTrackingEntryIcon(source, targetID, texture, usesAtlas)
    if not entry or not entry.tracked or entry.source ~= source or entry.targetID ~= targetID then return end
    if entry.texture == texture and entry.usesAtlas == usesAtlas then return end
    entry.texture, entry.usesAtlas = texture, usesAtlas
    entry.pinData.texture, entry.pinData.usesAtlas = texture, usesAtlas
    UpdateEntryChangeNumber()
end

---@return boolean
function Wayfinders:IsChangingSuperTrackingEntry()
    return changingSelection
end

---@param source string?
---@param targetID string?
---@param isUserWaypoint boolean
function Wayfinders:UpdateSuperTrackingEntrySelection(source, targetID, isUserWaypoint)
    if not entry then return end
    if source and entry.tracked and entry.source == source and entry.targetID == targetID then return end
    if not source and not isUserWaypoint and not entry.tracked then return end
    entry = nil
    UpdateEntryChangeNumber()
end

---@param provider SuperTrackingProvider|SuperTrackingFallbackProvider
---@param targetID string
---@param data WayfinderData
function Wayfinders:ApplySuperTrackingEntry(provider, targetID, data)
    if entry and entry.tracked and entry.source == provider.source and entry.targetID == targetID and
        entry.title == data.title and entry.description == data.description and entry.texture == data.texture and
        entry.usesAtlas == data.usesAtlas and entry.pinData.mapID == data.mapID and
        entry.pinData.x == data.x and entry.pinData.y == data.y then
        return
    end
    local track, untrack = self:CaptureSourceTracking(provider.source, data)
    entry = {
        source = provider.source,
        targetID = targetID,
        title = data.title or MapPinEnhanced.L["Target"],
        description = data.description,
        texture = data.texture,
        usesAtlas = data.usesAtlas,
        tracked = true,
        canToggle = track ~= nil and untrack ~= nil,
        track = track,
        untrack = untrack,
        changeNumber = changeNumber,
        pinData = {
            mapID = data.mapID,
            x = data.x,
            y = data.y,
            title = data.title or MapPinEnhanced.L["Target"],
            description = data.description,
            texture = data.texture or "Navigation-Tracked-Icon",
            usesAtlas = data.texture == nil or data.usesAtlas,
        },
    }
    UpdateEntryChangeNumber()
end

---@param source string
---@param targetID string?
function Wayfinders:ClearSuperTrackingEntry(source, targetID)
    if not entry or not entry.tracked or entry.source ~= source then return end
    if targetID and entry.targetID ~= targetID then return end
    entry = nil
    UpdateEntryChangeNumber()
end

---@param expectedChangeNumber integer
function Wayfinders:ToggleSuperTrackingEntry(expectedChangeNumber)
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
    UpdateEntryChangeNumber()
    -- Reconcile any automatic selection caused by clearing the original source.
    self:RefreshSuperTrackingSelection()
end

-- Stop tracking through the original source, never through Step arrival.
---@return boolean
function Wayfinders:CanClearNavigationTracking()
    local owner, targetID = Navigation:GetActiveDestinationState()
    local pin = MapPinEnhanced:GetModule("Pins"):GetTrackedPin()
    if owner == "addonPins" then return pin ~= nil and pin.pinID == targetID end
    return entry ~= nil and entry.tracked and entry.canToggle and
        entry.source == owner and entry.targetID == targetID
end

---@param expectedChangeNumber integer
function Wayfinders:ClearNavigationTracking(expectedChangeNumber)
    local step = MapPinEnhanced:GetModule("Wayfinders"):GetStepSnapshot()
    if not step or step.changeNumber ~= expectedChangeNumber or not self:CanClearNavigationTracking() then return end
    local owner = Navigation:GetActiveDestinationState()
    if owner == "addonPins" then
        MapPinEnhanced:GetModule("Pins"):UntrackTrackedPin()
    elseif entry then
        self:ToggleSuperTrackingEntry(entry.changeNumber)
    end
end
