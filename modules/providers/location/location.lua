---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local flavor = MapPinEnhanced.isForever and "Forever" or "Standard"

---@class LocationRecord
---@field id string Durable, flavor-qualified source identity
---@field catalogID number?
---@field category string
---@field categories string[]?
---@field label string
---@field aliases string[]?
---@field description string?
---@field texture string|number?
---@field usesAtlas boolean?
---@field mapID number?
---@field x number?
---@field y number?
---@field areaPoiID number?
---@field areaPoiIDs number[]?
---@field faction string? Alliance, Horde, Neutral, or unknown
---@field class string? Explicit taught-class token
---@field profession string? Explicit taught-profession token
---@field skill string? Explicit taught-skill token, separate from class trainers
---@field eligible boolean? nil means availability is unknown
---@field source string

---@class LocationCatalogRecord
---@field id number
---@field types string[]
---@field name table<string, string>
---@field map number?
---@field x number?
---@field y number?
---@field areaPoiID number?
---@field areaPoiIDs number[]?
---@field faction string?
---@field class string?
---@field profession string?
---@field skill string?

---@type LocationCatalogRecord[][]
local catalogs = {}

---@param source LocationCatalogRecord
---@return string?
local function GetCatalogTexture(source)
    local kind = source.types[1]
    if kind == "city" or kind == "town" then return "Interface\\Icons\\INV_Misc_Map_01" end
    if kind == "dungeon" or kind == "raid" or kind == "delve" or kind == "great-vault" or kind == "lfr-npc" then
        return "Interface\\Icons\\INV_Misc_Key_10"
    end
end

---Reconstruct remote native map/art hints from source identity after reload.
---@param poiID number
---@param checkpoint fun()
---@return number?, string?
function Providers:FindCatalogAreaPOI(poiID, checkpoint)
    for _, catalog in ipairs(catalogs) do
        for _, source in ipairs(catalog) do
            if source.map and (source.areaPoiID == poiID or source.areaPoiIDs and tContains(source.areaPoiIDs, poiID)) and
                self:ReadLocationAreaPOI(source.map, poiID) then
                return source.map, GetCatalogTexture(source)
            end
            checkpoint()
        end
    end
end

---@param records LocationCatalogRecord[]
function Providers:RegisterLocationCatalog(records)
    -- Registration retains immutable literals only. Copying/indexing is sliced
    -- by the consumer, including the larger Forever service catalog.
    catalogs[#catalogs + 1] = records
end

---@return table<string, boolean>
function Providers:GetAvailableLocationTypes()
    local types = {} ---@type table<string, boolean>
    for _, catalog in ipairs(catalogs) do
        for _, source in ipairs(catalog) do
            for _, kind in ipairs(source.types) do
                types[kind] = true
                if kind:match("^vendor%-") then types.vendor = true end
                if kind == "class" or kind == "profession" then types.trainer = true end
            end
        end
    end
    return types
end

---Called inside the consumer's cancellable batch; providers never own UI work.
---@param checkpoint fun()
---@return number[]
function Providers:GetLocationMapIDs(checkpoint)
    local maps = {} ---@type number[]
    local seen = {} ---@type table<number, boolean>
    local pending = { 946, 947 }
    local playerMap = C_Map.GetBestMapForUnit("player")
    if playerMap then pending[#pending + 1] = playerMap end
    for _, catalog in ipairs(catalogs) do
        for _, record in ipairs(catalog) do
            if record.map then pending[#pending + 1] = record.map end
            checkpoint()
        end
    end
    local cursor = 1
    while cursor <= #pending do
        local mapID = pending[cursor]
        cursor = cursor + 1
        if not seen[mapID] then
            seen[mapID] = true
            if MapPinEnhanced:IsZoneMap(mapID) then maps[#maps + 1] = mapID end
            for _, child in ipairs(C_Map.GetMapChildrenInfo(mapID) or {}) do
                pending[#pending + 1] = child.mapID
                checkpoint()
            end
        end
        checkpoint()
    end
    table.sort(maps)
    return maps
end

---@param checkpoint fun()
---@return LocationRecord[]
function Providers:ReadLocations(checkpoint)
    local records = {} ---@type LocationRecord[]
    local seen = {} ---@type table<number, boolean>
    local locale = GetLocale()
    if locale == "enGB" then locale = "enUS" end
    for _, catalog in ipairs(catalogs) do
        for _, source in ipairs(catalog) do
            assert(not seen[source.id], "Providers:ReadLocations duplicate catalog ID: " .. source.id)
            seen[source.id] = true
            ---@type string[]
            local categories = CopyTable(source.types)
            local vendor, trainer = false, false
            for _, kind in ipairs(categories) do
                vendor = vendor or kind:match("^vendor%-") ~= nil
                trainer = trainer or kind == "class" or kind == "profession"
            end
            if vendor and not tContains(categories, "vendor") then categories[#categories + 1] = "vendor" end
            if trainer and not tContains(categories, "trainer") then categories[#categories + 1] = "trainer" end
            records[#records + 1] = {
                id = flavor .. ":catalog:" .. source.id,
                catalogID = source.id,
                source = "catalog",
                category = source.types[1],
                categories = categories,
                label = source.name[locale] or source.name.enUS,
                aliases = { source.name.enUS },
                mapID = source.map,
                x = source.x,
                y = source.y,
                texture = GetCatalogTexture(source),
                usesAtlas = false,
                faction = source.faction,
                class = source.class,
                profession = source.profession,
                skill = source.skill,
                areaPoiID = source.areaPoiID,
                areaPoiIDs = source.areaPoiIDs and CopyTable(source.areaPoiIDs),
                eligible = source.faction ~= nil and true or nil,
            }
            checkpoint()
        end
    end
    return records
end
