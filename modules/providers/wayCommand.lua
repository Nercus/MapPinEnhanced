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

local L = MapPinEnhanced.L

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
        -- check if the mapID is a number and is actually a mapID
        local mapID = tonumber(mapString:sub(2))
        if mapID and HBDmapData[mapID] then
            return mapID
        else
            MapPinEnhanced:Print("Invalid mapID: " .. mapString)
        end
    else
        local mapID = ZONE_NAME_TO_ID[mapString]
        if mapID then
            if type(mapID) == "table" then
                return mapID[1]
            else
                return mapID
            end
        end
        -- no mapID found let's iterate and do a partial match
        for mapName, id in pairs(ZONE_NAME_TO_ID) do
            if mapName:lower():find(mapString:lower()) then
                if (type(id) == "table") then
                    return id[1]
                else
                    return id
                end
            end
        end
    end
end


---parse a wayString into a coords, mapID and title
---@param wayString string
---@return string?, number?, number[]?
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
        if (type(tonumber(tokens[idx])) == "number" or string.find(tokens[idx], "%d" .. decimal_separator .. "%d")) then
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
    if tokenLength <= 2 then
        local last = tokens[#tokens] or ""
        local split = { string.match(last, "(.-),(.+)") }
        if #split == 2 then
            table.remove(tokens, #tokens)
            table.insert(tokens, split[1])
            table.insert(tokens, split[2])
        end
    end

    ---@type string[]
    local mapParts = {}
    local coords = {}
    for _, token in ipairs(tokens) do
        -- replace all wrong decimal separators with the right one
        token = token:gsub(INVERSE_DECIMAL_SEPARATOR_PATTERN, DECIMAL_SEPARATOR_PATTERN)
        -- if element is not a number its the mapID/zoneName
        if not tonumber(token) then
            mapParts[#mapParts + 1] = token
        else
            table.insert(coords, tonumber(token))
        end
    end

    local mapID = nil
    if #mapParts == 1 then
        mapID = ConvertImportMapString(mapParts[1])
    elseif #mapParts > 1 then
        -- join the mapParts to a string and try to convert it to a mapID
        mapID = ConvertImportMapString(table.concat(mapParts, " "))
    end

    if not mapID or mapID == "" then
        mapID = C_Map.GetBestMapForUnit("player")
    end

    if not coords[1] or not coords[2] or coords[1] > 100 or coords[2] > 100 then
        coords = nil
    end

    if not coords or not mapID then
        MapPinEnhanced:PrintList(
            L["Invalid way command format. Please use one of the following formats (without < and >):"], {
                L["/way <map name> <x> <y> <optional title>"],
                L["/way #<mapID> <x> <y> <optional title>"],
            }
        )
        return nil, nil, nil
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
        if mapID and coords and coords[1] and coords[2] then
            table.insert(data, {
                title = title or CONSTANTS.DEFAULT_PIN_NAME,
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
    if mapID and coords and coords[1] and coords[2] then
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
    local pinData = self:DeserializeWayString(wayString)
    for _, data in ipairs(pinData) do
        PinManager:AddPin(data)
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

--@do-not-package@
local Tests = MapPinEnhanced.Tests

Tests:Test("Import String: Simple", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50 50")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)


Tests:Test("Import String: Separator 1", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50, 50")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("Import String: Separator 2", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50. 50")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("Import String: Decimal", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50.0 50.0")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("Import String: Decimal with Separator", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50.0, 50.0")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("Import String: Map ID", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way #2369 50.12 50.34")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(2369)
    self:Expect(coords):ToBe({ 50.12, 50.34 })
end)

Tests:Test("Import String: Title", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50.0,50.0 ABC")
    self:Expect(title):ToBe("ABC")
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("(Import String: Map ID and Title)", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way #2369 50.12,50.12 ABC")
    self:Expect(title):ToBe("ABC")
    self:Expect(mapID):ToBe(2369)
    self:Expect(coords):ToBe({ 50.12, 50.12 })
end)

Tests:Test("Import String: Wrong Format", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 2369 50 12ABC")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(nil)
    self:Expect(coords):ToBe(nil)

    self:Expect(L["Invalid way command format. Please use one of the following formats (without < and >):"])
        :ToBeChatMessage()
    self:Expect(L["/way <map name> <x> <y> <optional title>"]):ToBeChatMessage()
    self:Expect(L["/way #<mapID> <x> <y> <optional title>"]):ToBeChatMessage()
end)

--@end-do-not-package@
