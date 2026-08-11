---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@type table<number, HereBeDragonMapData>
local HBDMapData = MapPinEnhanced.HBD.mapData
local L = MapPinEnhanced.L
local trim = string.trim

local decimal_separator = tonumber("0,5") and "," or "."
local inverse_decimal_separator = decimal_separator == "," and "." or ","
local DECIMAL_SEPARATOR_PATTERN = decimal_separator == "." and "%." or ","
local INVERSE_DECIMAL_SEPARATOR_PATTERN = inverse_decimal_separator == "." and "%." or ","

local SLASH_PREFIX_PATTERN_1 = "/[Mm][Pp][Hh]"
local SLASH_PREFIX_PATTERN_2 = "/[Mm][Aa][Pp][Pp][Ii][Nn]"
local SLASH_PREFIX_PATTERN_3 = "/[Ww][Aa][Yy]"

local WAY_COMMAND_PATTERN = "/way %s %.2f %.2f %s"
local MAPPIN_COMMAND_PATTERN = "/mappin %s %.6f %.6f"
local PREFIX = "!MPH!"
MapPinEnhanced.PREFIX = PREFIX


local MAPID_MAPTYPE_OVERRIDE = {
    [101] = Enum.UIMapType.World,  -- Outland
    [125] = Enum.UIMapType.Zone,   -- Dalaran
    [126] = Enum.UIMapType.Micro,
    [501] = Enum.UIMapType.Zone,   -- Dalaran
    [502] = Enum.UIMapType.Micro,
    [572] = Enum.UIMapType.World,  -- Draenor
    [582] = Enum.UIMapType.Zone,   -- Lunarfall
    [590] = Enum.UIMapType.Zone,   -- Frostwall
    [625] = Enum.UIMapType.Orphan, -- Dalaran
    [626] = Enum.UIMapType.Micro,  -- Dalaran
    [627] = Enum.UIMapType.Zone,
    [628] = Enum.UIMapType.Micro,
    [629] = Enum.UIMapType.Micro,
}

local MAPID_SUFFIXES = {
    [195] = "1",                                -- Kaja'mine
    [196] = "2",                                -- Kaja'mine
    [197] = "3",                                -- Kaja'mine
    [579] = "1",                                -- Lunarfall Excavation
    [580] = "2",                                -- Lunarfall Excavation
    [581] = "3",                                -- Lunarfall Excavation
    [585] = "1",                                -- Frostwall Minem
    [586] = "2",                                -- Frostwall Mine
    [587] = "3",                                -- Frostwall Mine
    ---@diagnostic disable-next-line: undefined-global
    [943] = FACTION_HORDE --[[@as string]],     -- Arathi Highlands Horde
    ---@diagnostic disable-next-line: undefined-global
    [1044] = FACTION_ALLIANCE --[[@as string]], -- Arathi Highlands Alliance
}



---@type table<string, number|number[]>
local ZONE_NAME_TO_ID = {}
for mapID in pairs(HBDMapData) do
    local mapType = MAPID_MAPTYPE_OVERRIDE[mapID] or HBDMapData[mapID].mapType
    if mapType == Enum.UIMapType.Zone or
        mapType == Enum.UIMapType.Continent or
        mapType == Enum.UIMapType.Micro then
        local mapName = HBDMapData[mapID].name
        if MAPID_SUFFIXES[mapID] then
            mapName = mapName .. " " .. MAPID_SUFFIXES[mapID]
        end
        if not mapName then
            mapName = "#" .. mapID
        end
        if ZONE_NAME_TO_ID[mapName] then
            if type(ZONE_NAME_TO_ID[mapName]) ~= "table" then
                -- convert to table
                ZONE_NAME_TO_ID[mapName] = { ZONE_NAME_TO_ID[mapName] } --[[@as table<number>]]
            end
            table.insert(ZONE_NAME_TO_ID[mapName] --[[@as table<number>]], mapID)
        else
            ZONE_NAME_TO_ID[mapName] = mapID
        end
    end
end

---get the mapID from a mapString
---@param mapString string
---@return number?
local function ConvertImportMapString(mapString)
    -- if first character is a # remove it and return to number
    if mapString:sub(1, 1) == "#" then
        return tonumber(mapString:sub(2))
    else
        local mapID = ZONE_NAME_TO_ID[mapString]
        if type(mapID) == "table" then
            return mapID[1]
        else
            return mapID
        end
    end
end

---@param token string
---@return number?
local function ParseNumberToken(token)
    token = token:gsub(INVERSE_DECIMAL_SEPARATOR_PATTERN, DECIMAL_SEPARATOR_PATTERN)
    return tonumber(token)
end

---parse Blizzard's /mappin format: mapID x y, with normalized 0..1 coordinates
---@param mapPinString string
---@return string?, number?, number[]?, boolean
local function ParseMapPinCommandToData(mapPinString)
    local hasMapPinPrefix = string.find(mapPinString, "^%s*" .. SLASH_PREFIX_PATTERN_2) ~= nil
    if not hasMapPinPrefix then
        return nil, nil, nil, false
    end

    mapPinString = mapPinString:gsub("^%s*" .. SLASH_PREFIX_PATTERN_2, "", 1)
    mapPinString = trim(mapPinString)

    local mapIDToken, xToken, yToken = string.match(mapPinString, "^(%S+)%s+(%S+)%s+(%S+)%s*$")
    if not mapIDToken or not xToken or not yToken then
        return nil, nil, nil, hasMapPinPrefix
    end

    local mapID = tonumber(mapIDToken)
    local x = ParseNumberToken(xToken)
    local y = ParseNumberToken(yToken)
    if not mapID or not x or not y then
        return nil, nil, nil, hasMapPinPrefix
    end
    if mapID ~= math.floor(mapID) or x < 0 or x > 1 or y < 0 or y > 1 then
        return nil, nil, nil, hasMapPinPrefix
    end

    return nil, mapID, { x * 100, y * 100 }, true
end


---parse a wayString into a coords, mapID and title
---@param wayString string
---@return string?, number?, number[]?
function MapPinEnhanced:ParseWayCommandToData(wayString)
    local title, mapID, coords, isMapPinCommand = ParseMapPinCommandToData(wayString)
    if mapID and coords then
        return title, mapID, coords
    end
    if isMapPinCommand then
        return nil, nil, nil
    end

    -- remove the slashString from the message
    wayString = wayString:gsub(SLASH_PREFIX_PATTERN_1, ""):gsub(SLASH_PREFIX_PATTERN_2, ""):gsub(SLASH_PREFIX_PATTERN_3,
        "")
    wayString = trim(wayString)
    -- split msg into tokens on whitespace
    ---@type string[]
    local tokens = {}
    for token in string.gmatch(wayString, "%S+") do
        -- check if the last character in a token is either a . or a , and if so remove it
        if string.find(token, "[%.%,]$") then
            token = token:sub(1, -2) --[[@as string remove last character]]
        end
        table.insert(tokens, token)
    end

    local titleTokens = {}
    -- iterate reverse over tokens to find the first number
    for idx = #tokens, 1, -1 do
        -- check if token is a number or a number with a decimal separator (check for different separators) else add the token to the title
        if (tonumber(tokens[idx]) or string.find(tokens[idx], "%d" .. decimal_separator .. "%d")) and #tokens <= 3 then
            break
        else
            table.insert(titleTokens, 1, tokens[idx])
            table.remove(tokens, idx)
        end
    end

    -- check if the first token is a map id or a zone name -> if it is not and the length is 3 then the last token in there is a number that belongs to the title
    local firstTokenIsMap = tonumber(tokens[1]) == nil
    if not firstTokenIsMap and #tokens == 3 then
        -- remove the last entry in tokens and add it to the front of titleTokens
        table.insert(titleTokens, 1, tokens[#tokens])
        table.remove(tokens, #tokens)
    end

    ---@type string?
    local title = table.concat(titleTokens, " ")
    if title == "" then
        title = nil
    end

    local tokenLength = #tokens
    -- if length is small than 3 try to split the last element on ","
    if tokenLength < 2 then
        local last = tokens[#tokens] or ""
        local split = { string.match(last, "(.-),(.+)") }
        if #split == 2 then
            table.remove(tokens, #tokens)
            table.insert(tokens, split[1])
            table.insert(tokens, split[2])
        end
    end

    ---@type number?
    local mapID
    local coords = {}
    for _, token in ipairs(tokens) do
        -- if element is not a number its the mapID/zoneName
        local numberValue = ParseNumberToken(token)
        if not numberValue then
            mapID = ConvertImportMapString(token)
        else
            table.insert(coords, numberValue)
        end
    end
    if not mapID or mapID == "" then
        mapID = C_Map.GetBestMapForUnit("player")
    end
    if not coords[1] or not coords[2] then
        coords = nil
    end
    return title, mapID, coords
end

---deserialize a multiline wayString into pinData
---@param wayLine string
---@return pinData[]
function MapPinEnhanced:DeserializeWayLine(wayLine)
    local data = {}
    local title, mapID, coords = self:ParseWayCommandToData(wayLine)
    if mapID and coords and coords[1] and coords[2] then
        table.insert(data, {
            title = title,
            mapID = mapID,
            x = coords[1] / 100,
            y = coords[2] / 100,
        })
    end
    return data
end

---create a wayString from pinData
---@param pinData pinData
---@param prefix "/way"|"/mph"|"/mappin"?
---@return string wayLine
function MapPinEnhanced:SerializeWayLine(pinData, prefix)
    local mapID = pinData.mapID or ""
    local title = pinData.title or ""
    if prefix == "/mappin" then
        return trim(string.format(MAPPIN_COMMAND_PATTERN, mapID, pinData.x, pinData.y))
    end

    local x = pinData.x * 100
    local y = pinData.y * 100
    local wayLine = trim(string.format(WAY_COMMAND_PATTERN, "#" .. mapID, x, y, title))
    local command = wayLine:gsub("^/way", prefix or "/way", 1)
    return command
end

---deserialize a table from a string received through import/export
---@param data string
---@return table | nil
function MapPinEnhanced:DeserializeData(data)
    local dataWithoutPrefix = string.sub(data, #PREFIX + 1)
    local decoded = C_EncodingUtil.DecodeBase64(dataWithoutPrefix)
    if not decoded then return end
    local decompressed = C_EncodingUtil.DecompressString(decoded)
    if not decompressed then return end
    local deserialized = C_EncodingUtil.DeserializeCBOR(decompressed)
    return deserialized
end

---serialize a table for import/export
---@param data table
---@return string
function MapPinEnhanced:SerializeData(data)
    local serialized = C_EncodingUtil.SerializeCBOR(data)
    local compressed = C_EncodingUtil.CompressString(serialized)
    local encoded = C_EncodingUtil.EncodeBase64(compressed)
    return PREFIX .. encoded
end

function MapPinEnhanced:IsSerializedData(str)
    return type(str) == "string" and str:sub(1, #PREFIX) == PREFIX
end

MapPinEnhanced.EXPORT_VERSION = 1
