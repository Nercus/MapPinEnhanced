---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class Transfer
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

local STRING_FIELDS = { "title", "description", "color", "pinID" }
local BOOLEAN_FIELDS = { "usesAtlas", "lock" }

---@param pinData any
---@return boolean
local function IsValidPinData(pinData)
    if type(pinData) ~= "table" or type(pinData.mapID) ~= "number" or
        pinData.mapID <= 0 or pinData.mapID >= math.huge or pinData.mapID ~= math.floor(pinData.mapID) or
        type(pinData.x) ~= "number" or not (pinData.x >= 0 and pinData.x <= 1) or
        type(pinData.y) ~= "number" or not (pinData.y >= 0 and pinData.y <= 1) then
        return false
    end
    for _, key in ipairs(STRING_FIELDS) do
        if pinData[key] ~= nil and type(pinData[key]) ~= "string" then return false end
    end
    for _, key in ipairs(BOOLEAN_FIELDS) do
        if pinData[key] ~= nil and type(pinData[key]) ~= "boolean" then return false end
    end
    ---@type any
    local texture = pinData.texture
    return texture == nil or type(texture) == "string" or
        (type(texture) == "number" and texture > 0 and texture < math.huge)
end

---Runs inside the window's cancellable batch. Both inputs produce a private,
---portable preview; neither decoded input nor unknown nested fields are retained.
---@param input string|table
---@param checkpoint fun()
---@return SerializedExportGroup? group
---@return number invalidCount
---@return number mapCount
---@return string formatName
---@return string? errorMessage
function Transfer:ParseImport(input, checkpoint)
    local serialized = type(input) == "table" or MapPinEnhanced:IsSerializedData(input)
    local formatName = serialized and L["Serialized data"] or L["Way commands"]
    ---@type SerializedExportGroup
    local group = { pins = {}, pinOrder = {} }
    local invalidCount, mapCount = 0, 0
    ---@type table<number, boolean>
    local maps = {}
    ---@param data any
    local function AddPin(data)
        if IsValidPinData(data) then
            local copy = self:CopyPortablePin(data)
            group.pins[#group.pins + 1] = copy
            if not maps[copy.mapID] then
                maps[copy.mapID] = true
                mapCount = mapCount + 1
            end
        else
            invalidCount = invalidCount + 1
        end
    end

    if serialized then
        ---@type any
        local export = input
        if type(input) == "string" then
            local ok
            ok, export = pcall(MapPinEnhanced.DeserializeData, MapPinEnhanced, input)
            if not ok then export = nil end
        end
        if type(export) ~= "table" or export.version ~= MapPinEnhanced.EXPORT_VERSION or
            type(export.group) ~= "table" or type(export.group.pins) ~= "table" then
            return nil, 0, 0, formatName, L["Invalid or corrupted serialized data."]
        end
        ---@type table<string, any>
        local source = export.group
        group.name = type(source.name) == "string" and source.name or nil
        if type(source.icon) == "string" or
            (type(source.icon) == "number" and source.icon > 0 and source.icon < math.huge) then
            group.icon = source.icon
        end
        if source.trackingMode == Groups.TRACKING_MODE_ORDERED or
            source.trackingMode == Groups.TRACKING_MODE_NEAREST then
            group.trackingMode = source.trackingMode
        end
        ---@type any[]
        local sourcePins = source.pins
        for _, data in ipairs(sourcePins) do
            AddPin(data)
            checkpoint()
        end
        -- Only orders belonging to accepted pins are portable.
        if type(source.pinOrder) == "table" then
            for _, data in ipairs(group.pins) do
                local order = data.pinID and source.pinOrder[data.pinID]
                if type(order) == "number" and order > -math.huge and order < math.huge then
                    group.pinOrder[data.pinID] = order
                end
                checkpoint()
            end
        end
    else
        ---@cast input string
        for line in input:gmatch("[^\n]+") do
            local normalizedLine = line:match("^%s*(.-)%s*$") or ""
            if normalizedLine ~= "" then
                AddPin(MapPinEnhanced:DeserializeWayLine(normalizedLine)[1])
            end
            checkpoint()
        end
    end
    return group, invalidCount, mapCount, formatName
end
