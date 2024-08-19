---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")
local PinManager = MapPinEnhanced:GetModule("PinManager")

local CONSTANTS = MapPinEnhanced.CONSTANTS

local decimal_separator = CONSTANTS.DECIMAL_SEPARATOR
local inverse_decimal_separator = decimal_separator == "," and "." or ","
local DECIMAL_SEPARATOR_PATTERN = decimal_separator == "." and "%." or ","
local INVERSE_DECIMAL_SEPARATOR_PATTERN = inverse_decimal_separator == "." and "%." or ","

local SLASH_PREFIX_PATTERN_1 = "/[Mm][Pp][Hh]"
local SLASH_PREFIX_PATTERN_2 = "/[Mm][Pp][Ee]"
local SLASH_PREFIX_PATTERN_3 = "/[Ww][Aa][Yy]"

local HBDmapData = MapPinEnhanced.HBD.mapData
local trim = string.trim

---------------------------------------------------------------------------

---@type table<string, number|number[]>
local ZONE_NAME_TO_ID = {}
for mapID in pairs(HBDmapData) do
    local mapType = CONSTANTS.MAPID_MAPTYPE_OVERRIDE[mapID] or HBDmapData[mapID].mapType
    if mapType == Enum.UIMapType.Zone or
        mapType == Enum.UIMapType.Continent or
        mapType == Enum.UIMapType.Micro then
        local mapName = HBDmapData[mapID].name
        if CONSTANTS.MAPID_SUFFIXES[mapID] then
            mapName = mapName .. " " .. CONSTANTS.MAPID_SUFFIXES[mapID]
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


---parse a wayString into a coords, mapID and title
---@param wayString string
---@return string?, number?, number[]
function PinProvider:ParseWayStringToData(wayString)
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
        if tonumber(tokens[idx]) or string.find(tokens[idx], "%d" .. decimal_separator .. "%d") then
            break
        else
            table.insert(titleTokens, 1, tokens[idx])
            table.remove(tokens, idx)
        end
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
        -- replace all wrong decimal separators with the right one
        token = token:gsub(INVERSE_DECIMAL_SEPARATOR_PATTERN, DECIMAL_SEPARATOR_PATTERN)
        -- if element is not a number its the mapID/zoneName
        if not tonumber(token) then
            mapID = ConvertImportMapString(token)
        else
            table.insert(coords, tonumber(token))
        end
    end
    if not mapID or mapID == "" then
        mapID = C_Map.GetBestMapForUnit("player")
    end
    return title, mapID, coords
end

---deserialize a multiline wayString into pinData
---@param wayString string
---@return pinData[]
function PinProvider:DeserializeWayString(wayString)
    local data = {}
    for line in wayString:gmatch("[^\r\n]+") do
        local title, mapID, coords = self:ParseWayStringToData(line)
        if title and mapID and coords and coords[1] and coords[2] then
            table.insert(data, {
                title = title,
                mapID = mapID,
                x = coords[1] / 100,
                y = coords[2] / 100,
            })
        end
    end
    return data
end

function PinProvider:ImportSlashCommand(msg)
    local title, mapID, coords = self:ParseWayStringToData(msg)
    if mapID and coords then
        PinManager:AddPin({
            mapID = mapID,
            x = coords[1] / 100,
            y = coords[2] / 100,
            title = title or CONSTANTS.DEFAULT_PIN_NAME,
            setTracked = true,
        })
    end
end

---create pins from a multiline wayString
---@param wayString string
function PinProvider:ImportFromWayString(wayString)
    -- iterate over newlines
    for line in wayString:gmatch("[^\r\n]+") do
        local title, mapID, coords = self:ParseWayStringToData(line)
        if mapID and coords then
            PinManager:AddPin({
                mapID = mapID,
                x = coords[1] / 100,
                y = coords[2] / 100,
                title = title or CONSTANTS.DEFAULT_PIN_NAME,
            })
        end
    end
end

---create a wayString from pinData
---@param pinData pinData
---@return string
function PinProvider:SerializeWayString(pinData)
    local mapID = pinData.mapID or ""
    local title = pinData.title or ""
    local x = pinData.x * 100
    local y = pinData.y * 100
    return trim(string.format(CONSTANTS.WAY_COMMAND_PATTERN, "#" .. mapID, x, y, title))
end
