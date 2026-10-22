---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Options = MapPinEnhanced:GetModule("Options")
local OPTION_KEY = "Pins.Integrations.TomTom"
-- Capture absence before Options persists its initial values during addon setup.
local needsInitialDefault = MapPinEnhanced:GetVar("options", OPTION_KEY) == nil
local integrationEnabled = false
local loggedIn = false

---@type table<TomTomUID, {groupID: UUID, pinID: UUID}>
local bindings = {}
---@type UUID?
local groupID
---@type TomTomUID?
local selected
local tomTomShim = {} ---@type TomTom

-- Keep IDs, never pooled objects: groups can be renamed, hidden, deleted or reused.
---@param uid any
---@return MapPinEnhancedGroupMixin?, UUID?
local function GetBoundGroup(uid)
    if not MapPinEnhanced:IsReadableTable(uid) then return end
    local binding = bindings[uid]
    local group = binding and Groups:GetGroupByID(binding.groupID)
    if group and (group:GetPinByID(binding.pinID) or group:GetArchivedPinByID(binding.pinID)) then
        return group, binding.pinID
    end
    bindings[uid] = nil
end

---@param uid any
---@return MapPinEnhancedPinMixin?
local function GetBoundPin(uid)
    local group, pinID = GetBoundGroup(uid)
    return group and group:GetPinByID(pinID)
end

---@return MapPinEnhancedGroupMixin?
local function EnsureTomTomGroup()
    local group = groupID and Groups:GetGroupByID(groupID) or Groups:GetGroupByName(L["TomTom Pins"])
    if not group then
        group = Groups:RegisterGroup({
            name = L["TomTom Pins"],
            source = MapPinEnhanced.name,
            icon = "Interface\\Icons\\INV_Misc_Map_01",
            order = GetTime(),
        })
    end
    groupID = group and group:GetGroupID()
    return group
end

---@param uid any
---@param existingOnly boolean?
---@return MapPinEnhancedPinMixin?
local function AddTomTomWaypoint(uid, existingOnly)
    if not MapPinEnhanced:IsReadableTable(uid) or MapPinEnhanced:IsSecretValue(uid.corpse) or uid.corpse then return end
    if not MapPinEnhanced:IsReadablePositiveInteger(uid[1]) or
        not MapPinEnhanced:IsCoordinate(uid[2]) or not MapPinEnhanced:IsCoordinate(uid[3]) then
        return
    end
    local boundGroup, boundPinID = GetBoundGroup(uid)
    if boundGroup then
        if not existingOnly and not boundGroup:GetPinByID(boundPinID) then boundGroup:RestorePin(boundPinID) end
        return boundGroup:GetPinByID(boundPinID)
    end
    local mapID, x, y = Pins:ResolvePinPosition(uid[1], uid[2], uid[3])
    if not mapID then return end
    local title = uid.title
    if MapPinEnhanced:IsSecretValue(title) or type(title) ~= "string" then title = "" end
    title = MapPinEnhanced:CompactChatLabel(title, 64)
    if title == "" then title = L["TomTom Waypoint"] end
    local texture = uid.minimap_icon
    if MapPinEnhanced:IsSecretValue(texture) or
        not ((type(texture) == "string" and texture ~= "") or MapPinEnhanced:IsReadablePositiveInteger(texture)) then
        texture = "Interface\\Icons\\INV_Misc_Map_01"
    end
    local group = groupID and Groups:GetGroupByID(groupID) or Groups:GetGroupByName(L["TomTom Pins"])
    if not group and not existingOnly then group = EnsureTomTomGroup() end
    if not group then return end
    groupID = group:GetGroupID()
    -- Native handles are session-local. Reattach matching saved pins after reload.
    for _, entry in ipairs(group:GetPinEntries()) do
        local data = entry.data
        if entry.state ~= "cleared" and data.mapID == mapID and data.x == x and data.y == y and data.title == title then
            local claimed = false
            for _, binding in pairs(bindings) do
                if binding.pinID == entry.pinID then
                    claimed = true
                    break
                end
            end
            if not claimed then
                bindings[uid] = { groupID = group:GetGroupID(), pinID = entry.pinID }
                return entry.pin
            end
        end
    end
    if existingOnly then return end
    local pin, pinID = group:AddPin({ mapID = mapID, x = x, y = y, title = title, texture = texture })
    if pinID then bindings[uid] = { groupID = group:GetGroupID(), pinID = pinID } end
    return pin
end

---@param uid any
local function UntrackWaypoint(uid)
    local pin = GetBoundPin(uid)
    if pin and pin:IsTracked() then pin:Untrack() end
end

---@param uid any
---@param nativeOwnsArrival boolean?
local function SelectWaypoint(uid, nativeOwnsArrival)
    local pin = AddTomTomWaypoint(uid)
    if not GetBoundGroup(uid) then return end
    if selected ~= uid then UntrackWaypoint(selected) end
    selected = uid
    -- Real TomTom's own arrival/removal decides completion, including custom guide callbacks.
    if pin and nativeOwnsArrival and not pin:IsLocked() then pin:SetLock(true) end
    if pin and not pin:IsTracked() then pin:Track() end
end

---@param uid any
local function RemoveWaypoint(uid)
    local group, pinID = GetBoundGroup(uid)
    if not group then return end
    -- Group removal normally advances tracking. External cancellation must not do so.
    UntrackWaypoint(uid)
    if not group:RemovePin(pinID) then return end
    bindings[uid] = nil
    if selected == uid then selected = nil end
end

local function ShimIsActive()
    return integrationEnabled and TomTom == tomTomShim and not C_AddOns.IsAddOnLoaded("TomTom")
end

function tomTomShim:IsValidWaypoint(uid)
    if not ShimIsActive() then return false end
    local group, pinID = GetBoundGroup(uid)
    if not group then return false end
    local archived = group:GetArchivedPinByID(pinID)
    return not archived or archived.state == "hidden"
end

function tomTomShim:WaypointExists(mapID, x, y, title)
    if not ShimIsActive() or not MapPinEnhanced:IsReadablePositiveInteger(mapID) or
        not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) or
        MapPinEnhanced:IsSecretValue(title) then
        return false
    end
    for uid in pairs(bindings) do
        if uid[1] == mapID and uid[2] == x and uid[3] == y and uid.title == title and self:IsValidWaypoint(uid) then
            return true
        end
    end
    return false
end

function tomTomShim:AddWaypoint(mapID, x, y, info)
    if not ShimIsActive() or not MapPinEnhanced:IsReadablePositiveInteger(mapID) or
        not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then
        return
    end
    if not MapPinEnhanced:IsReadableTable(info) then info = {} end
    local title = info.title
    if MapPinEnhanced:IsSecretValue(title) or type(title) ~= "string" then title = nil end
    for uid in pairs(bindings) do
        if uid[1] == mapID and uid[2] == x and uid[3] == y and uid.title == title and self:IsValidWaypoint(uid) then
            return uid
        end
    end
    local uid = { mapID, x, y, title = title, minimap_icon = info.minimap_icon }
    AddTomTomWaypoint(uid)
    if not GetBoundGroup(uid) then return end
    if not MapPinEnhanced:IsSecretValue(info.crazy) and info.crazy ~= false then SelectWaypoint(uid) end
    return uid
end

function tomTomShim:SetCrazyArrow(uid)
    if self:IsValidWaypoint(uid) then SelectWaypoint(uid) end
end

function tomTomShim:RemoveWaypoint(uid)
    if ShimIsActive() then RemoveWaypoint(uid) end
end

tomTomShim.ClearWaypoint = tomTomShim.RemoveWaypoint

function tomTomShim:ClearCrazyArrowPoint(remove)
    if not ShimIsActive() then return end
    if remove then
        RemoveWaypoint(selected)
    else
        UntrackWaypoint(selected)
        selected = nil
    end
end

function tomTomShim:IsCrazyArrowEmpty()
    local pin = ShimIsActive() and GetBoundPin(selected)
    return not pin or not pin:IsTracked()
end

function tomTomShim:ClearAllWaypoints()
    if not ShimIsActive() then return end
    for uid in pairs(bindings) do RemoveWaypoint(uid) end
end

function tomTomShim:GetDistanceToWaypoint(uid)
    if not self:IsValidWaypoint(uid) or not MapPinEnhanced:IsReadablePositiveInteger(uid[1]) or
        not MapPinEnhanced:IsCoordinate(uid[2]) or not MapPinEnhanced:IsCoordinate(uid[3]) then
        return
    end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    if not mapID or not x or not y then return end
    return MapPinEnhanced.HBD:GetZoneDistance(mapID, x, y, uid[1], uid[2], uid[3])
end

function tomTomShim:GetClosestWaypoint()
    if not ShimIsActive() then return end
    local closest, closestDistance
    for uid in pairs(bindings) do
        local distance = self:GetDistanceToWaypoint(uid)
        if distance and (not closestDistance or distance < closestDistance) then
            closest, closestDistance = uid, distance
        end
    end
    return closest
end

function tomTomShim:SetClosestWaypoint()
    local uid = self:GetClosestWaypoint()
    if uid then self:SetCrazyArrow(uid) end
    return uid
end

function tomTomShim:GetCurrentPlayerPosition()
    if not ShimIsActive() then return end
    local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
    return mapID, x, y
end

function tomTomShim:AddWaypointToCurrentZone(x, y, title)
    if not ShimIsActive() or not MapPinEnhanced:IsReadableNumber(x) or
        not MapPinEnhanced:IsReadableNumber(y) then
        return
    end
    local mapID = C_Map.GetBestMapForUnit("player")
    return self:AddWaypoint(mapID, x / 100, y / 100, { title = title })
end

---@type table<table, table<string, function>>
local hookedMethods = {}
---@type TomTomUID?
local nativeSelected

local function HookTomTom()
    local native = TomTom
    if not native or not C_AddOns.IsAddOnLoaded("TomTom") or
        not MapPinEnhanced:IsReadableTable(native) or native == tomTomShim then
        return
    end
    local methods = hookedMethods[native] or {}
    hookedMethods[native] = methods
    local function Hook(name, callback)
        local method = native[name]
        if MapPinEnhanced:IsSecretValue(method) or type(method) ~= "function" or methods[name] == method then return end
        hooksecurefunc(native, name, function(...)
            if integrationEnabled and TomTom == native then callback(...) end
        end)
        methods[name] = native[name]
    end
    -- Rebind saved pins on restoration without importing or selecting background waypoints.
    Hook("SetWaypoint", function(_, uid) AddTomTomWaypoint(uid, true) end)
    Hook("SetCrazyArrow", function(_, uid)
        -- TomTom rejects selection while its sticky corpse arrow is active.
        local profile = native.db and native.db.profile
        if nativeSelected and nativeSelected.corpse and profile and profile.arrow and profile.arrow.stickycorpse and
            type(native.IsCrazyArrowEmpty) == "function" and not native:IsCrazyArrowEmpty() then
            return
        end
        nativeSelected = MapPinEnhanced:IsReadableTable(uid) and uid or nil
        if nativeSelected and MapPinEnhanced:IsSecretValue(nativeSelected.corpse) then
            nativeSelected = nil
            return
        end
        if not nativeSelected or nativeSelected.corpse then
            UntrackWaypoint(selected)
            selected = nil
            return
        end
        SelectWaypoint(uid, true)
    end)
    Hook("RemoveWaypoint", function(_, uid) RemoveWaypoint(uid) end)
    -- Bulk reset/profile changes call ClearWaypoint directly, bypassing RemoveWaypoint.
    Hook("ClearWaypoint", function(_, uid) RemoveWaypoint(uid) end)
    Hook("ClearCrazyArrowPoint", function()
        -- Clearing may select the closest waypoint inside TomTom. Keep that nested selection.
        if type(native.IsCrazyArrowEmpty) == "function" and native:IsCrazyArrowEmpty() then
            UntrackWaypoint(selected)
            selected, nativeSelected = nil, nil
        end
    end)
end

local function CheckForTomTom()
    MapPinEnhanced.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    if MapPinEnhanced.isTomTomLoaded then HookTomTom() end
end

local function ApplyIntegrationOption(enabled)
    integrationEnabled = enabled == true
    if not integrationEnabled then
        UntrackWaypoint(selected)
        selected, nativeSelected = nil, nil
        -- Only withdraw our own global. Retained stand-in references are gated too.
        if TomTom == tomTomShim then TomTom = nil end
    elseif loggedIn and not C_AddOns.IsAddOnLoaded("TomTom") and TomTom == nil then
        TomTom = tomTomShim
    end
end

-- Session-long subscription; Options owns saving and restoring the preference.
Options:SubscribeToOptionChanges(OPTION_KEY, ApplyIntegrationOption)

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(addon)
    if addon == "TomTom" then
        -- Retained stand-in handles cannot affect the real addon's new targets.
        if integrationEnabled then
            for uid in pairs(bindings) do RemoveWaypoint(uid) end
        else
            bindings = {}
        end
        selected, nativeSelected = nil, nil
        CheckForTomTom()
    end
end)

-- Install before TomTom restores saved waypoints at PLAYER_LOGIN, in either load order.
MapPinEnhanced:OnLoad(CheckForTomTom)
MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    loggedIn = true
    CheckForTomTom()
    -- Both addons have loaded by login, regardless of their startup order.
    if needsInitialDefault then
        Options:SetOptionValue(OPTION_KEY, MapPinEnhanced.isTomTomLoaded)
        needsInitialDefault = false
    end
    ApplyIntegrationOption(Options:GetOptionValue(OPTION_KEY))
end)
