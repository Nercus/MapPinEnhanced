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
    local title = nil
    local mapID = nil
    local coords = nil

    -- remove the slashString from the message
    wayString = wayString:gsub(SLASH_PREFIX_PATTERN_1, ""):gsub(SLASH_PREFIX_PATTERN_2, ""):gsub(SLASH_PREFIX_PATTERN_3,
        "")
    wayString = trim(wayString)
    -- split msg into tokens on whitespace
    ---@type string[]
    local tokens = {}
    for token in string.gmatch(wayString, "%S+") do
        table.insert(tokens, token)
    end

    -- iterate until you we find the index of the first number
    local coordsIndex = 0
    for i = 1, #tokens do
        local token = tokens[i]
        if string.find(token, "[%.%,]$") then
            token = token:sub(1, -2) --[[@as string remove last character]]
            tokens[i] = token
        end
        if tonumber(token) then
            coordsIndex = i
            break
        else
            local split = { string.match(token, "(.-),(.+)") }
            if #split == 2 then
                table.remove(tokens, i)
                table.insert(tokens, i, split[1])
                table.insert(tokens, i + 1, split[2])
                coordsIndex = i
                break
            end
        end
    end


    if coordsIndex == 2 then -- mapID in form #<mapID> or <mapName>
        mapID = ConvertImportMapString(tokens[1])
        table.remove(tokens, 1)
    elseif coordsIndex > 2 then -- multi word map name
        -- combine all tokens before the coordsIndex to a single string
        local mapName = table.concat(tokens, " ", 1, coordsIndex - 1)
        mapID = ConvertImportMapString(mapName)
        for _ = 1, coordsIndex - 1 do
            table.remove(tokens, 1)
        end
    end
    if not mapID then
        mapID = C_Map.GetBestMapForUnit("player")
    end


    coords = { tonumber(tokens[1]), tonumber(tokens[2]) }
    table.remove(tokens, 1)
    table.remove(tokens, 1)
    if not coords[1] or not coords[2] or coords[1] > 100 or coords[2] > 100 then
        coords = nil
    end

    if #tokens > 0 then
        title = table.concat(tokens, " ")
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
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way #680 50.12 50.34")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(680)
    self:Expect(coords):ToBe({ 50.12, 50.34 })
end)

Tests:Test("Import String: Title", function(self)
    local currentMap = C_Map.GetBestMapForUnit("player")
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 50.0,50.0 ABC")
    self:Expect(title):ToBe("ABC")
    self:Expect(mapID):ToBe(currentMap)
    self:Expect(coords):ToBe({ 50, 50 })
end)

Tests:Test("Import String: Title with number", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way Blasted Lands 62.96 31.17 Ethos of War, Part 1")
    self:Expect(title):ToBe("Ethos of War, Part 1")
    self:Expect(mapID):ToBe(17)
    self:Expect(coords):ToBe({ 62.96, 31.17 })
end)

Tests:Test("Import String: Map ID and Title", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way #680 50.12,50.12 ABC")
    self:Expect(title):ToBe("ABC")
    self:Expect(mapID):ToBe(680)
    self:Expect(coords):ToBe({ 50.12, 50.12 })
end)

Tests:Test("Import String: Wrong Format", function(self)
    local title, mapID, coords = PinProvider:ParseWayStringToData("/way 680 50 12ABC")
    self:Expect(title):ToBe(nil)
    self:Expect(mapID):ToBe(nil)
    self:Expect(coords):ToBe(nil)

    self:Expect(L["Invalid way command format. Please use one of the following formats (without < and >):"])
        :ToBeChatMessage()
    self:Expect(L["/way <map name> <x> <y> <optional title>"]):ToBeChatMessage()
    self:Expect(L["/way #<mapID> <x> <y> <optional title>"]):ToBeChatMessage()
end)

--@end-do-not-package@
