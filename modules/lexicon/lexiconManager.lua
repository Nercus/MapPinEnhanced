---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Lexicon
local Lexicon = MapPinEnhanced:GetModule("Lexicon")
local Providers = MapPinEnhanced:GetModule("Providers")
local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L
local Groups = MapPinEnhanced:GetModule("Groups")
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

---@param record LocationRecord
---@param category string
---@return boolean
local function IsRoleCompatible(record, category)
    local _, class = UnitClass("player")
    return not record.class or record.class == class or
        (category ~= "class" and category ~= "trainer" and category ~= "profession")
end

---@param record LocationRecord
---@return boolean
local function IsCompatible(record)
    local faction = UnitFactionGroup("player")
    if (record.faction == "Alliance" or record.faction == "Horde") and record.faction ~= faction then return false end
    for _, category in ipairs(record.categories or { record.category }) do
        if IsRoleCompatible(record, category) then return true end
    end
    return false
end

---@param record LocationRecord
---@return LexiconCategory
local function GetCategory(record)
    for _, key in ipairs(record.categories or { record.category }) do
        if IsRoleCompatible(record, key) then return Lexicon.CATEGORIES[key] or Lexicon.CATEGORIES.poi end
    end
    return Lexicon.CATEGORIES.poi
end

---@param record LocationRecord
---@return boolean
local function HasPosition(record)
    return MapPinEnhanced:IsZoneMap(record.mapID) and MapPinEnhanced:IsCoordinate(record.x) and
        MapPinEnhanced:IsCoordinate(record.y)
end

---@param record LocationRecord
---@param x number?
---@param y number?
---@param mapID number?
---@return number?
local function GetDistance(record, x, y, mapID)
    if not HasPosition(record) or not mapID or not MapPinEnhanced:IsCoordinate(x) or
        not MapPinEnhanced:IsCoordinate(y) then
        return
    end
    -- HBD returns nil across world spaces or missing geometry; never turn it into zero.
    local distance = MapPinEnhanced.HBD:GetZoneDistance(mapID, x, y, record.mapID, record.x, record.y)
    if MapPinEnhanced:IsReadableNumber(distance) and distance >= 0 then return distance end
end

---@param record LocationRecord
---@param category string
---@return boolean
local function HasCategory(record, category)
    return IsRoleCompatible(record, category) and (record.category == category or
        record.categories ~= nil and tContains(record.categories, category))
end

---@param record LocationRecord
---@param category string
---@return boolean
local function IsNearestEligible(record, category)
    if not HasCategory(record, category) or not IsCompatible(record) or record.eligible ~= true or
        not HasPosition(record) or (record.faction ~= "Alliance" and record.faction ~= "Horde" and
            record.faction ~= "Neutral") then
        return false
    end
    if category == "class" then return record.class ~= nil and record.skill == nil end
    if category == "profession" then return record.profession ~= nil end
    return category ~= "trainer" or record.class ~= nil or record.profession ~= nil or record.skill ~= nil
end

---@param record LocationRecord
---@return boolean, string?
local function ApplyLocation(record)
    if not Lexicon:IsEnabled() or not IsCompatible(record) or record.eligible == false then
        return false, L["This location is not available to this character."]
    end
    local category = GetCategory(record)
    local texture, usesAtlas = record.texture or category.texture, record.texture and record.usesAtlas or false
    if record.mapID then
        for _, poiID in ipairs(record.areaPoiIDs or (record.areaPoiID and { record.areaPoiID } or {})) do
            if Wayfinders:TrackAreaPOI(poiID, record.mapID, texture, usesAtlas) then return true end
        end
    end
    if not HasPosition(record) then
        return false, L["This location is currently unavailable."]
    end
    local group = Groups:GetUngroupedGroup()
    local title = Providers:PlainDescription(record.label)
    if not group or not title or strlenutf8(title) > 64 then
        return false, L["Could not create a pin for this location."]
    end
    local pin = group:AddPin({
        mapID = record.mapID,
        x = record.x,
        y = record.y,
        title = title,
        texture = Lexicon.PIN_ICON_KEYS[category.texture] or category.texture,
        usesAtlas = false
    })
    if not pin then return false, L["Could not create a pin for this location."] end
    pin:Track()
    return true
end


local changeNumber = 0
local query = ""
local ready = false
---@type LexiconEntry[]
local entries = {}
---@type LexiconResult[]
local results = {}
---@type MapPinEnhancedLexiconTemplate?
local view
---@type fun()?, fun()?, fun()?
local cancelBuild, cancelSearch, unsubscribe
local scheduleSearch, cancelScheduledSearch

local function CancelSearch()
    changeNumber = changeNumber + 1
    if cancelScheduledSearch then cancelScheduledSearch() end
    if cancelSearch then cancelSearch() end
    cancelSearch = nil
    results = {}
end

local function Publish(message)
    if view and view:IsShown() then view:ApplyResults(results, message) end
end

---@param category LexiconCategory
---@param text string
---@return boolean
local function IsCategoryQuery(category, text)
    if text == category.label:lower() then return true end
    for _, alias in ipairs(category.aliases) do
        if text == alias then return true end
    end
    return false
end

---@param a LexiconResult
---@param b LexiconResult
---@return boolean
local function Before(a, b)
    if a.rank ~= b.rank then return a.rank < b.rank end
    -- Group service ties before comparing distances so mixed results keep a total ordering.
    if (a.service == true) ~= (b.service == true) then return a.service == true end
    if a.service and b.service then
        if (a.distance ~= nil) ~= (b.distance ~= nil) then return a.distance ~= nil end
        if a.distance and b.distance and a.distance ~= b.distance then return a.distance < b.distance end
        return a.id < b.id
    end
    if a.label ~= b.label then return a.label < b.label end
    return a.id < b.id
end

local function Search()
    if not ready or query == "" or not view or not view:IsShown() then return end
    if cancelScheduledSearch then cancelScheduledSearch() end
    if cancelSearch then cancelSearch() end
    local current, text = changeNumber, query:lower()
    local found = {} ---@type LexiconResult[]
    cancelSearch = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(2)
        local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
        local nearest = {} ---@type table<string, LexiconResult>
        local matchedCategories = {} ---@type string[]
        for key, category in pairs(Lexicon.CATEGORIES) do
            if IsCategoryQuery(category, text) then matchedCategories[#matchedCategories + 1] = key end
        end
        for _, entry in ipairs(entries) do
            local record, category = entry.record, entry.category
            if IsCompatible(record) then
                local specialty = entry.specialty
                local specialtyText = specialty and specialty:lower():gsub("_", " ")
                local specialtyLabel = entry.specialtyLabel and entry.specialtyLabel:lower()
                local specialtyMatch = specialty and (text == specialtyText or text == specialtyText .. " trainer" or
                    text == specialtyLabel or text == string.format(L["%s Trainer"], entry.specialtyLabel):lower())
                local distance = GetDistance(record, x, y, mapID)
                local categoryMatch = false
                local actions = {} ---@type string[]
                for _, key in ipairs(matchedCategories) do
                    if HasCategory(record, key) then
                        categoryMatch = true
                        if Lexicon.CATEGORIES[key].service then actions[#actions + 1] = key end
                    end
                end
                if specialtyMatch then actions[#actions + 1] = "trainer" end
                for _, key in ipairs(actions) do
                    local actionID = key .. ":" .. (specialtyMatch and specialty or "")
                    local action = nearest[actionID]
                    if not action then
                        action = {
                            id = "nearest:" .. actionID,
                            category = key,
                            specialty = specialtyMatch and specialty or nil,
                            label = string.format(L["Nearest %s"], specialtyMatch and
                                string.format(L["%s Trainer"], entry.specialtyLabel) or Lexicon.CATEGORIES[key].label),
                            subtitle = L["No suitable nearby location is available."],
                            texture = Lexicon.CATEGORIES[key].texture,
                            rank = 0,
                            changeNumber = current,
                            service = true
                        }
                        nearest[actionID] = action
                    end
                    if IsNearestEligible(record, key) and distance and
                        (not action.distance or distance < action.distance or
                            distance == action.distance and action.entry and record.id < action.entry.record.id) then
                        action.distance, action.entry = distance, entry
                        action.subtitle = record.label .. " — " .. entry.zone
                    end
                end
                local name = record.label:lower()
                local exact = text == name
                local nameContains = name:find(text, 1, true) ~= nil
                local nameFuzzy = MapPinEnhanced:FuzzyMatch(text, name, true)
                for _, alias in ipairs(record.aliases or {}) do
                    local aliasText = alias:lower()
                    exact = exact or text == aliasText
                    nameContains = nameContains or aliasText:find(text, 1, true) ~= nil
                    nameFuzzy = nameFuzzy or MapPinEnhanced:FuzzyMatch(text, aliasText, true)
                    checkpoint()
                end
                local rank = exact and 1 or nameContains and 2 or
                    (categoryMatch or specialtyMatch) and 3 or
                    entry.text:find(text, 1, true) and 4 or nameFuzzy and 5 or
                    MapPinEnhanced:FuzzyMatch(text, entry.text, true) and 6
                if rank then
                    local subtitle = (entry.specialtyLabel and string.format(L["%s Trainer"], entry.specialtyLabel) or
                        category.label) .. " — " .. entry.zone
                    if not HasPosition(record) then
                        subtitle = subtitle .. " — " .. L["Location unavailable"]
                    elseif record.eligible ~= true then
                        subtitle = subtitle .. " — " .. L["Availability unknown"]
                    end
                    found[#found + 1] = {
                        id = record.id,
                        entry = entry,
                        label = record.label,
                        subtitle = subtitle,
                        texture = category.texture,
                        distance = distance,
                        rank = rank,
                        service = category.service,
                        changeNumber = current
                    }
                end
            end
            checkpoint()
        end
        for _, result in pairs(nearest) do found[#found + 1] = result end
        table.sort(found, Before)
    end }, nil, function()
        if current ~= changeNumber then return end
        cancelSearch = nil
        results = found
        Publish(string.format(L["%d results"], #results))
    end, nil, function(message)
        if current == changeNumber then
            cancelSearch = nil
            Publish(L["Location search failed. Try again."])
        end
        geterrorhandler()(message)
    end)
end

---@param text string
function Lexicon:Search(text)
    CancelSearch()
    query = strtrim(text or "")
    Publish(query == "" and "" or ready and L["Searching locations..."] or L["Loading locations..."])
    if query ~= "" then scheduleSearch() end
end

local function BuildCatalog()
    CancelSearch()
    if cancelBuild then cancelBuild() end
    ready = false
    entries = {}
    Publish(query ~= "" and L["Loading locations..."] or "")
    local copied = {} ---@type LexiconEntry[]
    cancelBuild = MapPinEnhanced:BatchExecution({ function()
        local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(2)
        for _, record in ipairs(Providers:ReadLocations(checkpoint)) do
            record.label = Providers:PlainDescription(record.label) or L["Location"]
            local category = GetCategory(record)
            local map = record.mapID and C_Map.GetMapInfo(record.mapID)
            local zone = map and map.name or L["Unknown zone"]
            local specialty = IsRoleCompatible(record, "trainer") and (record.skill or record.class or record.profession) or
                nil
            local specialtyLabel = specialty and Lexicon.SPECIALTIES[specialty]
            local terms = { record.label, zone,
                specialty and specialty:gsub("_", " ") or "", specialtyLabel or "" }
            for _, key in ipairs(record.categories or { record.category }) do
                local kind = Lexicon.CATEGORIES[key] or Lexicon.CATEGORIES.poi
                if IsRoleCompatible(record, key) then
                    terms[#terms + 1] = kind.label
                    terms[#terms + 1] = table.concat(kind.aliases, " ")
                end
            end
            for _, alias in ipairs(record.aliases or {}) do terms[#terms + 1] = alias end
            copied[#copied + 1] = {
                record = record,
                category = category,
                zone = zone,
                specialty = specialty,
                specialtyLabel = specialtyLabel,
                text = table.concat(terms, " "):lower()
            }
            checkpoint()
        end
    end }, nil, function()
        cancelBuild = nil
        entries, ready = copied, true
        Search()
    end, nil, function(message)
        cancelBuild = nil
        Publish(L["Locations could not be loaded."])
        geterrorhandler()(message)
    end)
end

---@return boolean
function Lexicon:IsEnabled()
    return Options:GetOptionValue(self.ENABLE_OPTION) == true
end

---@param result LexiconResult
function Lexicon:Activate(result)
    if not self:IsEnabled() or not view or not view:IsShown() or result.changeNumber ~= changeNumber then return end
    local entry = result.entry
    if result.category then
        -- Nearest actions take a fresh position snapshot, with the same cancellable
        -- worker lifetime as search. Closing cannot publish or activate stale work.
        CancelSearch()
        local current = changeNumber
        Publish(L["Finding the nearest location..."])
        cancelSearch = MapPinEnhanced:BatchExecution({ function()
            local checkpoint = MapPinEnhanced:CreateBatchCheckpoint(2)
            local x, y, mapID = MapPinEnhanced:GetPlayerMapPosition()
            local bestDistance ---@type number?
            entry = nil
            for _, candidate in ipairs(entries) do
                local record = candidate.record
                if (not result.specialty or result.specialty == candidate.specialty) and
                    IsNearestEligible(record, result.category) then
                    local distance = GetDistance(record, x, y, mapID)
                    if distance and (not bestDistance or distance < bestDistance or
                            distance == bestDistance and entry and record.id < entry.record.id) then
                        entry, bestDistance = candidate, distance
                    end
                end
                checkpoint()
            end
        end }, nil, function()
            if current ~= changeNumber then return end
            cancelSearch = nil
            local success ---@type boolean?
            local message ---@type string?
            if entry then success, message = ApplyLocation(entry.record) end
            if success then Lexicon:Hide() else Publish(message or L["No suitable nearby location is available."]) end
        end, nil, function(message)
            if current == changeNumber then
                cancelSearch = nil
                Publish(L["Location search failed. Try again."])
            end
            geterrorhandler()(message)
        end)
        return
    end
    if not entry then return end
    local success, message = ApplyLocation(entry.record)
    if success then self:Hide() else Publish(message) end
end

function Lexicon:ReleaseView()
    CancelSearch()
    if cancelBuild then cancelBuild() end
    if unsubscribe then unsubscribe() end
    cancelBuild, unsubscribe = nil, nil
    entries, ready, query = {}, false, ""
end

function Lexicon:Hide()
    if view then view:Hide() end
    self:ReleaseView()
end

---@param text string?
function Lexicon:Show(text)
    if not self:IsEnabled() then
        MapPinEnhanced:Print(L["Location Lexicon is disabled."])
        return
    end
    self:Hide()
    if not view then
        view = CreateFrame("Frame", "MapPinEnhancedLexicon", UIParent, "MapPinEnhancedLexiconTemplate")
    end
    view:Show()
    view.input:SetText(text or "")
    view.input:SetFocus()
    self:Search(text or "")
    BuildCatalog()
    unsubscribe = MapPinEnhanced:RegisterEventBucket({ "PLAYER_ENTERING_WORLD", "NEUTRAL_FACTION_SELECT_RESULT" },
        BuildCatalog, 0.2)
end

scheduleSearch, cancelScheduledSearch = MapPinEnhanced:DebounceChange(Search, 0.2)
MapPinEnhanced:AddSlashCommand("find", function(_, ...) Lexicon:Show(table.concat({ ... }, " ")) end,
    L["Open the Location Lexicon."])
Options:SubscribeToOptionChanges(Lexicon.ENABLE_OPTION, function(enabled)
    if not enabled then Lexicon:Hide() end
end)
