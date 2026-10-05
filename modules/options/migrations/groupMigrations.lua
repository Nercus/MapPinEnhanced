---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

---@param value any
---@return boolean
local function IsNumber(value)
    return type(value) == "number" and value == value and math.abs(value) < math.huge
end

---@param value table<string|number, any>
---@return (string|number)[]
local function SortedKeys(value)
    local keys = {} ---@type (string|number)[]
    for key in pairs(value) do
        if type(key) == "string" or type(key) == "number" then keys[#keys + 1] = key end
    end
    table.sort(keys, function(a, b)
        if type(a) == type(b) then return a < b end
        return type(a) < type(b)
    end)
    return keys
end

---@param raw any
---@return pinData?
local function CopyLegacyPin(raw)
    if type(raw) ~= "table" or not IsNumber(raw.mapID) or raw.mapID <= 0 or raw.mapID % 1 ~= 0 or
        not IsNumber(raw.x) or raw.x < 0 or raw.x > 1 or
        not IsNumber(raw.y) or raw.y < 0 or raw.y > 1 then
        return nil
    end
    ---@cast raw table<string, any>
    local options = type(raw.optionals) == "table" and raw.optionals or raw
    ---@type pinData
    local pin = { mapID = raw.mapID, x = raw.x, y = raw.y }
    for _, key in ipairs({ "title", "description", "color" }) do
        local value = raw[key]
        if value == nil then value = options[key] end
        if type(value) == "string" then pin[key] = value end
    end
    if type(options.texture) == "string" or IsNumber(options.texture) then pin.texture = options.texture end
    if type(raw.usesAtlas) == "boolean" then
        pin.usesAtlas = raw.usesAtlas
    elseif raw.optionals and type(pin.texture) == "string" then
        pin.usesAtlas = true -- AceDB-era string textures were atlas names.
    end
    if type(raw.lock) == "boolean" then
        pin.lock = raw.lock
    elseif type(options.persistent) == "boolean" then
        pin.lock = options.persistent
    end
    if type(raw.setTracked) == "boolean" then
        pin.setTracked = raw.setTracked
    elseif type(options.noTrack) == "boolean" then
        pin.setTracked = not options.noTrack
    end
    return pin
end

---Convert detached saved data before restoration acquires domain objects/frames.
---Keep source tables intact, including unsupported fields, for manual recovery.
function Groups:MigrateLegacyData()
    if MapPinEnhanced:GetVar("legacyGroupsMigrated") then return end
    local sets = MapPinEnhanced:GetVar("sets")
    local storedPins = MapPinEnhanced:GetVar("storedPins")
    local global = MapPinEnhanced:GetVar("global")
    local acePins = type(global) == "table" and global.savedPins or nil
    if sets == nil and storedPins == nil and acePins == nil then return end

    local savedGroups = MapPinEnhanced:GetVar("groups")
    if savedGroups ~= nil and type(savedGroups) ~= "table" then
        MapPinEnhanced:Print(L["Legacy migration could not update groups. Original saved data was kept."])
        return
    end
    ---@type table<UUID, SaveableGroupData>
    local groups = {}
    local names = {} ---@type table<string, boolean>
    local pinIDs = {} ---@type table<UUID, boolean>
    ---@cast savedGroups table<UUID, SaveableGroupData>?
    -- Reserve even absent-addon groups and archives; no live-owner lookup is
    -- sufficient here because restoration has not run yet.
    for groupID, group in pairs(savedGroups or {}) do
        groups[groupID] = group
        if type(group) == "table" then
            if type(group.name) == "string" then names[self:GetNameKey(group.name)] = true end
            for _, pin in pairs(type(group.pins) == "table" and group.pins or {}) do
                if type(pin) == "table" and type(pin.pinID) == "string" then pinIDs[pin.pinID] = true end
            end
            for pinID in pairs(type(group.pinArchive) == "table" and group.pinArchive or {}) do
                pinIDs[pinID] = true
            end
        end
    end
    names[self:GetNameKey(L["Ungrouped Pins"])], names[self:GetNameKey(L["My Way Back"])] = true, true
    local skipped, pinCount, groupCount = 0, 0, 0

    ---@param prefix string
    ---@param used table<string, any>
    ---@return UUID
    local function NewID(prefix, used)
        local id ---@type UUID
        repeat
            id = MapPinEnhanced:GenerateUUID(prefix)
        until not used[id]
        return id
    end

    ---@param name string
    ---@return string
    local function AvailableName(name)
        local base = self:CleanGroupName(name)
        local candidate, suffix = base, 2
        while names[self:GetNameKey(candidate)] do
            candidate = base .. " (" .. suffix .. ")"
            suffix = suffix + 1
        end
        names[self:GetNameKey(candidate)] = true
        return candidate
    end

    ---@param group SaveableGroupData
    ---@param input any
    ---@param preserveKeys boolean
    local function AddPins(group, input, preserveKeys)
        if input == nil then return end
        if type(input) ~= "table" then
            skipped = skipped + 1
            return
        end
        ---@cast input table<string|number, any>
        for _, key in ipairs(SortedKeys(input)) do
            local raw = input[key]
            local pin = CopyLegacyPin(raw)
            if pin then
                ---@cast pin SaveablePinData
                local pinID = preserveKeys and type(key) == "string" and key ~= "" and key or nil
                if not pinID and type(raw.pinID) == "string" and raw.pinID ~= "" then pinID = raw.pinID --[[@as string]] end
                if not pinID or pinIDs[pinID] then pinID = NewID("pin", pinIDs) end
                pinIDs[pinID], pin.pinID = true, pinID
                local order = IsNumber(raw.order) and raw.order or pinCount + 1
                if group.hidden then
                    pin.setTracked = nil
                    group.pinArchive[pinID] = { data = pin, order = order, state = "hidden" }
                else
                    group.pins[#group.pins + 1] = pin
                    group.pinOrder[pinID] = order
                end
                pinCount = pinCount + 1
            else
                skipped = skipped + 1
            end
        end
    end

    local ungroupedID = self.SYSTEM_GROUP_IDS.UNGROUPED
    if storedPins ~= nil or acePins ~= nil then
        local existing = groups[ungroupedID]
        if existing ~= nil and (type(existing) ~= "table" or existing.source ~= MapPinEnhanced.name or
                type(existing.pins) ~= "table" or type(existing.pinOrder) ~= "table" or type(existing.pinArchive) ~= "table") then
            MapPinEnhanced:Print(L["Legacy migration could not update groups. Original saved data was kept."])
            return
        end
        ---@type SaveableGroupData
        local group = existing and CopyTable(existing) or {
            groupID = ungroupedID,
            name = L["Ungrouped Pins"],
            source = MapPinEnhanced.name,
            groupType = "ungrouped",
            hidden = false,
            order = -1,
            pins = {},
            pinOrder = {},
            pinArchive = {},
        }
        -- An existing tracked selection wins when old and new saves coexist.
        local alreadyTracked = false
        for _, savedGroup in pairs(groups) do
            if type(savedGroup) == "table" and type(savedGroup.pins) == "table" then
                for _, pin in pairs(savedGroup.pins) do
                    if type(pin) == "table" and pin.setTracked then alreadyTracked = true end
                end
            end
        end
        local previousCount = #group.pins
        AddPins(group, storedPins, false)
        AddPins(group, acePins, false)
        for index = previousCount + 1, #group.pins do
            local pin = group.pins[index]
            if alreadyTracked then
                pin.setTracked = nil
            elseif pin.setTracked then
                alreadyTracked = true
            end
        end
        groups[ungroupedID] = group
    end

    if type(sets) == "table" then
        ---@cast sets table<string|number, any>
        for _, setID in ipairs(SortedKeys(sets)) do
            local set = sets[setID]
            if type(set) == "table" and self:IsValidGroupName(set.name) and type(set.pins) == "table" then
                local groupID = type(setID) == "string" and setID ~= "" and setID or NewID("group", groups)
                if groups[groupID] or self:GetSystemGroupType(groupID) then groupID = NewID("group", groups) end
                ---@type SaveableGroupData
                local group = {
                    groupID = groupID,
                    name = AvailableName(set.name),
                    source = MapPinEnhanced.name,
                    hidden = true,
                    order = 0,
                    pins = {},
                    pinOrder = {},
                    pinArchive = {},
                    trackingMode = self.TRACKING_MODE_NEAREST,
                }
                AddPins(group, set.pins, true)
                groups[groupID] = group
                groupCount = groupCount + 1
            else
                skipped = skipped + 1
            end
        end
    elseif sets ~= nil then
        skipped = skipped + 1
    end

    -- No yields between publishing the complete snapshot and marking completion.
    -- Subsequent deletes, reloads and option resets must not resurrect source data.
    MapPinEnhanced:SetVar("groups", groups)
    MapPinEnhanced:SetVar("legacyGroupsMigrated", true)
    MapPinEnhanced:Print(string.format(L["Migrated %d legacy pins and %d saved sets. Original saved data was kept."],
        pinCount, groupCount))
    if skipped > 0 then
        MapPinEnhanced:Print(string.format(L["%d legacy entries could not be migrated. Original saved data was kept."],
            skipped))
    end
end
