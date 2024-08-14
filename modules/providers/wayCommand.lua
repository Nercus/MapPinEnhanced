---@diagnostic disable: no-unknown, unused-local, redefined-local
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")

---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")

local CONSTANTS = MapPinEnhanced.CONSTANTS
local L = MapPinEnhanced.L

local decimal_separator = CONSTANTS.DECIMAL_SEPARATOR
local inverse_decimal_separator = decimal_separator == "," and "." or ","


local DECIMAL_SEPARATOR_PATTERN = decimal_separator == "." and "%." or ","
local INVERSE_DECIMAL_SEPARATOR_PATTERN = inverse_decimal_separator == "." and "%." or ","

local SLASH_PREFIX_PATTERN_1 = "/[Mm][Pp][Hh]"
local SLASH_PREFIX_PATTERN_2 = "/[Mm][Pp][Ee]"
local SLASH_PREFIX_PATTERN_3 = "/[Ww][Aa][Yy]"

local trim = string.trim

local HBDmapData = MapPinEnhanced.HBD.mapData --[[@as table<string, table>]]

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
                ZONE_NAME_TO_ID[mapName] = { ZONE_NAME_TO_ID[mapName] }
            end
            table.insert(ZONE_NAME_TO_ID[mapName], mapID)
        else
            ZONE_NAME_TO_ID[mapName] = mapID
        end
    end
end

---@param mapString string
---@return number?
local function ConvertImportMapString(mapString)
    -- if first character is a # remove it and return to number
    if mapString:sub(1, 1) == "#" then
        return tonumber(mapString:sub(2))
    else
        return ZONE_NAME_TO_ID[mapString]
    end
end


---@param wayString string
---@return string, number?, number[]
function PinProvider:ParseWayStringToData(wayString)
    -- remove the slashString from the message
    wayString = wayString:gsub(SLASH_PREFIX_PATTERN_1, ""):gsub(SLASH_PREFIX_PATTERN_2, ""):gsub(SLASH_PREFIX_PATTERN_3,
        "")
    wayString = trim(wayString)
    -- split msg into tokens on whitespace
    local tokens = {}
    for token in string.gmatch(wayString, "%S+") do
        -- check if the last character in a token is either a . or a , and if so remove it
        if string.find(token, "[%.%,]$") then
            token = token:sub(1, -2)
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
    local title = table.concat(titleTokens, " ")
    if title == "" then
        title = L[CONSTANTS.DEFAULT_PIN_NAME]
    end

    -- if length is small than 3 try to split the last element on ","
    if #tokens < 2 then
        local last = tokens[#tokens]
        local split = { string.match(last, "(.-),(.+)") }
        if #split == 2 then
            table.remove(tokens, #tokens)
            table.insert(tokens, split[1])
            table.insert(tokens, split[2])
        end
    end

    local mapID
    local coords = {}
    for idx, token in ipairs(tokens) do
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

---@class ParseWayStringData
---@field title string
---@field mapID number
---@field x number
---@field y number

---@param wayString string
---@return ParseWayStringData[]
function PinProvider:DeserializeWayString(wayString)
    local data = {}
    for line in wayString:gmatch("[^\r\n]+") do
        local title, mapID, coords = self:ParseWayStringToData(line)
        if title and mapID and coords then
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

---@param wayString string
function PinProvider:ImportFromWayString(wayString)
    -- iterate over newlines
    for line in wayString:gmatch("[^\r\n]+") do
        local title, mapID, coords = self:ParseWayStringToData(line)
        if title and mapID and coords then
            PinManager:AddPin({
                mapID = mapID,
                x = coords[1] / 100,
                y = coords[2] / 100,
                title = title or "Imported Waypoint",
            })
        end
    end
end
