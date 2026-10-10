---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Navigation
local Navigation = MapPinEnhanced:GetModule("Navigation")
local Notifications = MapPinEnhanced:GetModule("Notifications")
local Options = MapPinEnhanced:GetModule("Options")

---@class NavigationEquipmentRestore
---@field originalGUID string? Absent when the slot was empty.
---@field originalLink string?
---@field travelGUID string|false False for an off-hand displaced by a travel weapon.
---@field mainHandTravelGUID string? Links a displaced off-hand to its navigation-owned main hand.
---@field originalMainHandGUID string|false|nil Protects manual main-hand changes after the first restore finishes.
---@field pathKey string
---@field due boolean?
---@field restoring boolean?
---@field failureNotified boolean?

---@class NavigationEquipmentSnapshot
---@field guid string?
---@field link string?

---@class NavigationEquipmentClick
---@field itemID number
---@field pathKey string
---@field slots table<integer, NavigationEquipmentSnapshot>
---@field requested boolean?

local pending = {} ---@type table<integer, NavigationEquipmentRestore>
local click ---@type NavigationEquipmentClick?
local equipping ---@type NavigationEquipmentClick?
local equipTimer ---@type FunctionContainer?
local restoreTimer ---@type FunctionContainer?
local characterKey ---@type string?
local inWorld = false
local applying = false
local enabled = false

local function Persist()
    if not characterKey then return end
    if next(pending) then
        MapPinEnhanced:SetVar("navigationEquipment", characterKey, pending)
    else
        MapPinEnhanced:DeleteVar("navigationEquipment", characterKey)
    end
end

-- False means a readable empty slot; nil means inventory data is unavailable.
---@param slot integer
---@return string|false|nil guid
local function ReadSlot(slot)
    local itemID = GetInventoryItemID("player", slot)
    if MapPinEnhanced:IsSecretValue(itemID) then return nil end
    if not itemID then return false end
    local guid = C_Item.GetItemGUID(ItemLocation:CreateFromEquipmentSlot(slot))
    if not MapPinEnhanced:IsSecretValue(guid) and type(guid) == "string" then return guid end
end

---@return string? key
---@return WayfinderDesiredAction? action
local function GetCurrentPath()
    local progression = Navigation.progression
    if not progression or progression.pathUnavailable then return nil end
    local graph = progression.route.graph
    local reference = progression.route.pathReferences[progression.pathIndex]
    if not reference then return nil end
    local action = Navigation:GetPathAction(graph.pathTypes[reference], graph.pathRequirements[reference])
    if not action or action.type ~= "item" then return nil end
    local point = graph.pathToPointIndexes[reference]
    return table.concat({ action.id, graph.pointMapIDs[point], graph.pointXs[point], graph.pointYs[point] }, ":"), action
end

local function ClearEquipObservation()
    if equipTimer then equipTimer:Cancel() end
    equipTimer = nil
    equipping = nil
end

-- The secure button owns the equip. Observe only calls made inside its click,
-- so down/up configuration and failed/no-op clicks cannot create a gear owner.
---@param action WayfinderDesiredAction?
function Navigation:BeginActionEquipmentClick(action)
    click = nil
    if not enabled or equipping or not inWorld or InCombatLockdown() or not characterKey or not action or
        action.type ~= "item" or not C_Item.GetItemGUID or not C_Item.GetItemLocation or
        not C_Item.IsEquippableItem(action.id) or C_Item.IsEquippedItem(action.id) then
        return
    end
    local pathKey, currentAction = GetCurrentPath()
    if not pathKey or not currentAction or currentAction.id ~= action.id or
        not self.progression or self.progression.phase ~= "ready" then
        return
    end
    local slots = {} ---@type table<integer, NavigationEquipmentSnapshot>
    for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
        local guid = ReadSlot(slot)
        if guid == nil then return end
        local link = guid and GetInventoryItemLink("player", slot) or nil
        if MapPinEnhanced:IsSecretValue(link) then return end
        slots[slot] = {
            guid = guid or nil,
            link = guid and (link or ("item:" .. tostring(GetInventoryItemID("player", slot)))) or nil,
        }
    end
    click = { itemID = action.id, pathKey = pathKey, slots = slots }
end

hooksecurefunc(C_Item, "EquipItemByName", function()
    if click then click.requested = true end
end)

local function ObserveEquipment()
    if not inWorld then return end
    local observation = equipping
    if observation then
        for slot, previous in pairs(observation.slots) do
            local guid = ReadSlot(slot)
            local itemID = GetInventoryItemID("player", slot)
            if guid and guid ~= previous.guid and not MapPinEnhanced:IsSecretValue(itemID) and
                itemID == observation.itemID and not IsInventoryItemLocked(slot) and
                (slot ~= INVSLOT_MAINHAND or not IsInventoryItemLocked(INVSLOT_OFFHAND)) then
                local record = pending[slot]
                -- A second navigation item can replace one whose restoration is
                -- still blocked. Retain the original gear, not the first travel item.
                if not record or record.travelGUID ~= previous.guid then
                    record = {
                        originalGUID = previous.guid,
                        originalLink = previous.link,
                        travelGUID = guid,
                        pathKey = observation.pathKey
                    }
                    pending[slot] = record
                end
                record.travelGUID = guid
                record.pathKey = observation.pathKey
                record.due = not enabled or GetCurrentPath() ~= observation.pathKey
                record.restoring = nil
                -- Catalogued travel staves can displace both weapon slots.
                local offHand = observation.slots[INVSLOT_OFFHAND]
                if slot == INVSLOT_MAINHAND and offHand.guid and ReadSlot(INVSLOT_OFFHAND) == false then
                    pending[INVSLOT_OFFHAND] = {
                        originalGUID = offHand.guid,
                        originalLink = offHand.link,
                        travelGUID = false,
                        mainHandTravelGUID = guid,
                        originalMainHandGUID = record.originalGUID or false,
                        pathKey = observation.pathKey,
                        due = record.due,
                    }
                end
                ClearEquipObservation()
                local link = GetInventoryItemLink("player", slot)
                Notifications:ShowNotification("NAVIGATION_ITEM_EQUIPPED",
                    not MapPinEnhanced:IsSecretValue(link) and link or ("item:" .. observation.itemID))
                break
            end
        end
    end
    -- A server-locked navigation swap can briefly differ from the old owned
    -- gear. Finish its snapshot before classifying replacements as manual.
    if equipping then return end
    for slot, record in pairs(pending) do
        local guid = ReadSlot(slot)
        local mainHandGUID = record.mainHandTravelGUID and ReadSlot(INVSLOT_MAINHAND)
        if record.mainHandTravelGUID and not pending[INVSLOT_MAINHAND] and mainHandGUID ~= nil and
            mainHandGUID ~= record.originalMainHandGUID then
            pending[slot] = nil
        elseif guid ~= nil and guid ~= record.travelGUID then
            if record.restoring and guid == (record.originalGUID or false) then
                Notifications:ShowNotification(record.originalGUID and "NAVIGATION_ITEM_RESTORED" or
                    "NAVIGATION_EMPTY_SLOT_RESTORED", record.originalLink)
            elseif slot == INVSLOT_MAINHAND then
                local offHand = pending[INVSLOT_OFFHAND]
                if offHand and offHand.mainHandTravelGUID == record.travelGUID then
                    pending[INVSLOT_OFFHAND] = nil
                end
            end
            -- Any other observed replacement belongs to the player.
            pending[slot] = nil
        end
    end
    if not next(pending) and restoreTimer then
        restoreTimer:Cancel()
        restoreTimer = nil
    end
    Persist()
end

function Navigation:EndActionEquipmentClick()
    local observation = click
    click = nil
    if not observation or not observation.requested then return end
    ClearEquipObservation()
    equipping = observation
    -- Bound unconfirmed server requests so an unrelated later manual equip
    -- cannot inherit a failed navigation click's snapshot.
    equipTimer = C_Timer.NewTimer(5, function()
        ObserveEquipment()
        ClearEquipObservation()
        ObserveEquipment()
    end)
    ObserveEquipment()
end

---@param record NavigationEquipmentRestore
local function NotifyFailure(record)
    if record.failureNotified then return end
    record.failureNotified = true
    Notifications:ShowNotification(record.originalGUID and "NAVIGATION_ITEM_RESTORE_FAILED" or
        "NAVIGATION_EMPTY_SLOT_RESTORE_FAILED", record.originalLink)
end

local function CheckRestoration()
    restoreTimer = nil
    if not inWorld then return end
    ObserveEquipment()
    for slot, record in pairs(pending) do
        if record.restoring then
            record.restoring = nil
            if ReadSlot(slot) == record.travelGUID and not IsInventoryItemLocked(slot) then NotifyFailure(record) end
        end
    end
    Persist()
end

---@param slot integer
---@param record NavigationEquipmentRestore
local function RestoreSlot(slot, record)
    if IsInventoryItemLocked(slot) then return end
    if record.mainHandTravelGUID and pending[INVSLOT_MAINHAND] then return end
    if record.originalGUID then
        local location = C_Item.GetItemLocation(record.originalGUID)
        if not location or not location:IsBagAndSlot() then
            NotifyFailure(record)
            return
        end
        local bag, bagSlot = location:GetBagAndSlot()
        -- Only carried gear is accessible; never pull from a bank or another slot.
        if bag < BACKPACK_CONTAINER or bag > NUM_TOTAL_EQUIPPED_BAG_SLOTS then
            NotifyFailure(record)
            return
        end
        local info = C_Container.GetContainerItemInfo(bag, bagSlot)
        if not info or info.isLocked then return end
        record.restoring = true
        C_Container.PickupContainerItem(bag, bagSlot)
        if CursorHasItem() then PickupInventoryItem(slot) end
    else
        local hasSpace = false
        for bag = BACKPACK_CONTAINER, NUM_TOTAL_EQUIPPED_BAG_SLOTS do
            local free, family = C_Container.GetContainerNumFreeSlots(bag)
            if free and free > 0 and family == 0 then
                hasSpace = true
                break
            end
        end
        if not hasSpace then
            NotifyFailure(record)
            return
        end
        record.restoring = true
        local action = EquipmentManager_UnequipItemInSlot(slot)
        if action then EquipmentManager_RunAction(action) end
    end
    -- We entered with an empty cursor; return a displaced or rejected item to
    -- its source slot without touching an item the player was already holding.
    ClearCursor()
    if not restoreTimer then restoreTimer = C_Timer.NewTimer(1, CheckRestoration) end
end

local function TryRestoration()
    if not inWorld or applying or not next(pending) and not equipping then return end
    ObserveEquipment()
    if InCombatLockdown() or GetCursorInfo() ~= nil or equipping then return end
    applying = true
    for slot, record in pairs(pending) do
        -- A loading screen can end an observation timer. Reconcile its result
        -- above before permitting another attempt after inventory returns.
        if not restoreTimer then record.restoring = nil end
        if record.due and not record.restoring and ReadSlot(slot) == record.travelGUID then
            RestoreSlot(slot, record)
        end
    end
    applying = false
    Persist()
end

-- Called on confirmed arrival or explicit abandonment, never mere handler
-- deactivation: publication and recalculation also deactivate action handlers.
function Navigation:RestoreActionEquipment()
    local changed = false
    for _, record in pairs(pending) do
        if not record.due then
            record.due = true
            changed = true
        end
    end
    if not changed then return end
    Persist()
    MapPinEnhanced:CallRestricted(TryRestoration)
end

function Navigation:ReconcileActionEquipment()
    if not next(pending) then return end
    local pathKey = GetCurrentPath()
    for _, record in pairs(pending) do
        if not record.due and record.pathKey ~= pathKey then
            self:RestoreActionEquipment()
            return
        end
    end
end

Options:SubscribeToOptionChanges("Wayfinder.Navigation.RestoreEquipment", function(value)
    enabled = value == true
    -- Disabling stops new snapshots; existing gear still belongs to this owner
    -- until restored or manually replaced, including an unconfirmed secure swap.
    if not enabled then Navigation:RestoreActionEquipment() end
end)

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    characterKey = MapPinEnhanced:GetCharacterKey()
    if not characterKey then return end
    local saved = MapPinEnhanced:GetVar("navigationEquipment", characterKey)
    if type(saved) == "table" then
        ---@cast saved table<any, any>
        for slot, record in pairs(saved) do
            if MapPinEnhanced:IsReadablePositiveInteger(slot) and slot >= INVSLOT_FIRST_EQUIPPED and
                slot <= INVSLOT_LAST_EQUIPPED and type(record) == "table" and
                (type(record.travelGUID) == "string" or record.travelGUID == false) and
                type(record.pathKey) == "string" and
                (record.originalGUID == nil or type(record.originalGUID) == "string" and
                    type(record.originalLink) == "string") then
                ---@cast record NavigationEquipmentRestore
                pending[slot] = record
                record.due = true
                record.restoring = nil
            end
        end
    end
end)

MapPinEnhanced:RegisterEvent("PLAYER_LEAVING_WORLD", function()
    inWorld = false
    if restoreTimer then restoreTimer:Cancel() end
    restoreTimer = nil
end)
MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function() inWorld = true end)
MapPinEnhanced:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", ObserveEquipment)
MapPinEnhanced:RegisterEventBucket({
    "PLAYER_ENTERING_WORLD", "BAG_UPDATE_DELAYED", "ITEM_UNLOCKED", "PLAYER_REGEN_ENABLED", "CURSOR_CHANGED",
}, TryRestoration)
