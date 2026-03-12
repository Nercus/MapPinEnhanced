---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Collections = MapPinEnhanced:GetModule("Collections")

local L = MapPinEnhanced.L

function Providers:ImportNewCollection(dataString, collectionName)
    ---@type CollectionInfo | pinData[] | nil
    local data
    local dataType = "unknown"
    if MapPinEnhanced:IsSerializedData(dataString) then
        data = MapPinEnhanced:DeserializeData(dataString) --[[@as CollectionInfo]]
        dataType = "collection"
    else
        data = MapPinEnhanced:DeserializeWayLine(dataString) --[[@as pinData[] ]]
        dataType = "pins"
        -- TODO: this shouldn't even happen here. The way line import should not be in a collections provider
    end
    if not data then return end
    local collection = Collections:GetCollectionByName(collectionName)
    if collection then
        MapPinEnhanced:Notify(
            string.format(
                L
                ["A collection with the name '%s' already exists. Please choose a different name and or select to import into an existing collection."],
                collectionName), "ERROR")
        return
    end
    collection = Collections:CreateCollection(collectionName)
    -- TODO: import to collection here
end
