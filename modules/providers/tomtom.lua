---@diagnostic disable: no-unknown, unused-local, redefined-local
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider : Module
local PinProvider = MapPinEnhanced:GetModule("PinProvider")

---@class PinManager : Module
local PinManager = MapPinEnhanced:GetModule("PinManager")




-- TODO: add a wrapper to parse tomtom pin info
-- TODO: add fake tomtom function and namespace for compatibility with other addons

local TEST_STRINGS = {
    "/way #114 33,5 58,3 Ceremonial Spear",
    "/way Nazmir 51 59 1st clue",
    "/way 26.6, 53.9 on top of Fangli Hoot's head",
    "/way 9.97 56.5 on the bottom of a bookshelf in the Little Scales Daycare",
    "/way 39.8,64.4 ontop of a barrel to the right of the Jewelcrafting crafting station",
    "/way 29,2 62,7 near the Skinning banner in the Artisan's Market",
    "/way 44,2  58,4 above the entrance arch of the Auction House",
    "/way 38, 49 on the ground to the right of the Blacksmith building, behind an Obsidian Guardian",
    "/way 55,43 at the entrance of the Seat of the Aspects - After the stairs, by the first bonfire to the left",
    "/way 46. 32 by a waterfall near the Inn",
    "/way 47, 32.1 under the bridge near the Inn",
    "/way 47.5, 32 in the cellar of the Inn",
}

local decimal_separator = tonumber("0.5") == 0 and "," or "."
local inverse_decimal_separator = decimal_separator == "," and "." or ","
local slashString1 = "/way"
local slashString2 = "/mph"

local function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function ConvertImportMapString(mapString)
    -- if first character is a # remove it and return to number
    if mapString:sub(1, 1) == "#" then
        return tonumber(mapString:sub(2))
    end
    -- TODO: check localized map names
    return 1
end


local function parseMsg(msg)
    -- remove the slashString from the message
    msg = msg:gsub(slashString1, ""):gsub(slashString2, "")
    msg = trim(msg)
    -- split msg into tokens on whitespace
    local tokens = {}
    for token in string.gmatch(msg, "%S+") do
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
        token = token:gsub(inverse_decimal_separator, decimal_separator)
        -- if element is not a number its the mapID/zoneName
        if not tonumber(token) then
            mapID = ConvertImportMapString(token)
        else
            table.insert(coords, token)
        end
    end

    return title, mapID, coords
end

for _, msg in ipairs(TEST_STRINGS) do
    print(msg)
    parseMsg(msg)
    print("---------------------")
end


-- local HBDmapData = MapPinEnhanced.HBD.mapData --[[@as table<string, table>]]
-- MapPinEnhanced:Debug(HBDmapData)
-- for i, j in ipairs(HBDmapData) do
--     print(i)
-- end


-- local overrides = {
--     [101] = { mapType = Enum.UIMapType.World },  -- Outland
--     [125] = { mapType = Enum.UIMapType.Zone },   -- Dalaran
--     [126] = { mapType = Enum.UIMapType.Micro },
--     [195] = { suffix = "1" },                    -- Kaja'mine
--     [196] = { suffix = "2" },                    -- Kaja'mine
--     [197] = { suffix = "3" },                    -- Kaja'mine
--     [501] = { mapType = Enum.UIMapType.Zone },   -- Dalaran
--     [502] = { mapType = Enum.UIMapType.Micro },
--     [572] = { mapType = Enum.UIMapType.World },  -- Draenor
--     [579] = { suffix = "1" },                    -- Lunarfall Excavation
--     [580] = { suffix = "2" },                    -- Lunarfall Excavation
--     [581] = { suffix = "3" },                    -- Lunarfall Excavation
--     [582] = { mapType = Enum.UIMapType.Zone },   -- Lunarfall
--     [585] = { suffix = "1" },                    -- Frostwall Minem
--     [586] = { suffix = "2" },                    -- Frostwall Mine
--     [587] = { suffix = "3" },                    -- Frostwall Mine
--     [590] = { mapType = Enum.UIMapType.Zone },   -- Frostwall
--     [625] = { mapType = Enum.UIMapType.Orphan }, -- Dalaran
--     [626] = { mapType = Enum.UIMapType.Micro },  -- Dalaran
--     [627] = { mapType = Enum.UIMapType.Zone },
--     [628] = { mapType = Enum.UIMapType.Micro },
--     [629] = { mapType = Enum.UIMapType.Micro },
--     [943] = { suffix = FACTION_HORDE }, -- Arathi Highlands
--     [1044] = { suffix = FACTION_ALLIANCE },
-- }

-- local CZWFromMapID = {}
-- local function GetCZWFromMapID(m)
--     local zone, continent, world, map
--     local mapInfo = nil

--     if not m then
--         return nil, nil, nil;
--     end

--     -- Return the cached CZW
--     if CZWFromMapID[m] then
--         return unpack(CZWFromMapID[m])
--     end

--     map = m -- Save the original map
--     repeat
--         mapInfo = C_Map.GetMapInfo(m)
--         if not mapInfo then
--             -- No more parents, return what we have
--             CZWFromMapID[map] = { continent, zone, world }
--             return continent, zone, world
--         end
--         local mapType = (overrides[m] and overrides[m].mapType) or mapInfo.mapType
--         if mapType == Enum.UIMapType.Zone then
--             -- Its a zone map
--             zone = m
--         elseif mapType == Enum.UIMapType.Continent then
--             continent = m
--         elseif (mapType == Enum.UIMapType.World) or (mapType == Enum.UIMapType.Cosmic) then
--             world = m
--             continent = continent or m -- Hack for one continent worlds
--         end
--         m = mapInfo.parentMapID
--     until (m == 0)
--     CZWFromMapID[map] = { continent, zone, world }
--     return continent, zone, world
-- end


-- MapPinEnhanced.mapDataID = {}
-- local mapDataID = MapPinEnhanced.mapDataID


-- for id in pairs(HBDmapData) do
--     local c, z, w = GetCZWFromMapID(id)
--     local mapType = (overrides[id] and overrides[id].mapType) or HBDmapData[id].mapType
--     if (mapType == Enum.UIMapType.Zone) or (mapType == Enum.UIMapType.Continent) or
--         (mapType == Enum.UIMapType.Micro) then
--         local name = HBDmapData[id].name
--         if (overrides[id] and overrides[id].suffix) then
--             name = name .. " " .. overrides[id].suffix
--         end
--         if w then
--             if name and mapDataID[name] then
--                 if type(mapDataID[name]) ~= "table" then
--                     -- convert to table
--                     mapDataID[name] = { mapDataID[name] }
--                 end
--                 table.insert(mapDataID[name], id)
--             else
--                 mapDataID[name] = id
--             end
--         end

--         mapDataID["#" .. id] = id
--     end
-- end

-- local newEntries = {}
-- for name, mapID in pairs(mapDataID) do
--     if type(mapID) == "table" then
--         mapDataID[name] = nil
--         for _, mapId in pairs(mapID) do
--             local parent = HBDmapData[mapId].parent
--             local parentName = (parent and (parent > 0) and HBDmapData[parent].name)
--             if parentName then
--                 -- We rely on the implicit acending order of mapID's so the lowest one wins
--                 if not newEntries[name .. ":" .. parentName] then
--                     newEntries[name .. ":" .. parentName] = mapId
--                 else
--                     newEntries[name .. ":" .. tostring(mapId)] = mapId
--                 end
--             end
--         end
--     end
-- end
-- for name, mapID in pairs(newEntries) do
--     mapDataID[name] = mapID
-- end
-- wipe(newEntries)
-- collectgarbage("collect")


-- local wrongseparator = "(%d)" .. (tonumber("1.1") and "," or ".") .. "(%d)"
-- local rightseparator = "%1" .. (tonumber("1.1") and "." or ",") .. "%2"


-- function MapPinEnhanced:ParseImport(importstring)
--     if not importstring then return end
--     -- if self.GetNumPins() > 0 then
--     --     self.RemoveAllPins()
--     -- end
--     local msg
--     for s in importstring:gmatch("[^\r\n]+") do
--         if string.match(s:lower(), "/way ") or string.match(s:lower(), "/mph ") or string.match(s:lower(), "/pin ") then
--             msg = string.gsub(s, "/%a%a%a", "")
--         else
--             print("Formating error! Use |cffeda55f/mph|r [x] [y] <title>")
--         end
--         local x, y, mapID, title = self:ParseInput(msg)
--         --MapPinEnhanced:AddWaypoint(x, y, mapID, { title = title })
--     end
-- end

-- function MapPinEnhanced:ParseInput(msg)
--     if not msg then
--         return
--     end
--     local sx
--     local sy
--     local smapid
--     local stitle
--     local matches = {}
--     msg = msg:gsub("(%d)[%.,] (%d)", "%1 %2"):gsub(wrongseparator, rightseparator)
--     local tokens = {}
--     for token in msg:gmatch("%S+") do
--         table.insert(tokens, token)
--     end

--     if tokens[1] and not tonumber(tokens[1]) then
--         local zoneEnd
--         for idx = 1, #tokens do
--             local token = tokens[idx]
--             if tonumber(token) then
--                 zoneEnd = idx - 1
--                 break
--             end
--         end

--         if not zoneEnd then
--             return
--         end

--         local zone = table.concat(tokens, " ", 1, zoneEnd)
--         local x, y, title = select(zoneEnd + 1, unpack(tokens))

--         if title then title = table.concat(tokens, " ", zoneEnd + 3) end
--         local lzone = zone:lower():gsub("[%s]", "")
--         for name, mapId in pairs(mapDataID) do
--             local lname = name:lower():gsub("[%s]", "")
--             if lname == lzone then
--                 -- We have an exact match
--                 matches = { name }
--                 break
--             elseif lname:match(lzone) then
--                 table.insert(matches, name)
--             end
--         end

--         if #matches > 1 and #matches < 7 then
--             local msg = string.format("Found multiple matches for zone '%s'.  Did you mean: %s", zone,
--                 table.concat(matches, ", "))
--             return
--         elseif #matches == 0 then
--             local msg = string.format("Could not find any matches for zone %s.", zone)
--             return
--         end

--         -- There was only one match, so proceed
--         local zoneName = matches[1]
--         smapid = mapDataID[zoneName]

--         x = x and tonumber(x)
--         y = y and tonumber(y)

--         if not x or not y then
--             return
--         end

--         sx, sy = tonumber(x) / 100, tonumber(y) / 100


--         stitle = table.concat(tokens, " ", zoneEnd + 3)
--         if sx and sy and smapid then
--             return sx, sy, smapid, stitle
--         end
--     elseif tokens[1] and tonumber(tokens[1]) then
--         -- A vanilla set command
--         local x, y, title = unpack(tokens)
--         if not x or not tonumber(x) then
--             return
--         elseif not y or not tonumber(y) then
--             return
--         end
--         if title then
--             title = table.concat(tokens, " ", 3)
--         end
--         x = tonumber(x)
--         y = tonumber(y)

--         smapid = MapPinEnhanced.HBD:GetPlayerZone()
--         sx, sy = unpack(tokens)
--         if sx and sy and smapid then
--             sx, sy = tonumber(sx) / 100, tonumber(sy) / 100
--             stitle = table.concat(tokens, " ", 3)
--             if sx and sy and smapid then
--                 return sx, sy, smapid, stitle
--             end
--         else
--             print("Formating error! Use |cffeda55f/mph|r [x] [y] <title>")
--         end
--     else
--         print("Formating error! Use |cffeda55f/mph|r [x] [y] <title>")
--     end
-- end
