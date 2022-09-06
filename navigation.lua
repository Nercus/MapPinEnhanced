local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Navigation")



-- local function UnpackXY(coord)
--     if type(coord) == "string" then
--         local xString, yString = coord:match("(%d+.%d+),(%d+%.%d+)")
--         if yString then
--             return tonumber(xString) / 100, tonumber(yString) / 100
--         end
--     end
--     if not tonumber(coord) then
--         return
--     end
--     local factor
--     if tonumber(coord) > 99999999 then
--         factor = 2 ^ 16
--     else
--         factor = 10000 -- Handy notes coord
--     end
--     local x, y = floor(coord / factor) / factor, (coord % factor) / factor
--     -- print("GetXY", "x", x, "y", y)
--     return x, y
-- end

-- local function getReqs(raw)
--     local returnData = false
--     if not raw then return end
--     local out = {}
--     if string.match(raw, "lvl") then
--         returnData = true
--         out["lvl"] = string.match(raw, "lvl:(%d*)")
--     end
--     if string.match(raw, "notlvl") then
--         returnData = true
--         out["notlvl"] = string.match(raw, "notlvl:(%d*)")
--     end
--     if string.match(raw, "passlvl") then
--         returnData = true
--         out["passlvl"] = string.match(raw, "passlvl:(%d*)")
--     end
--     if string.match(raw, "trank") then
--         returnData = true
--         out["trank"] = string.match(raw, "trank:(%d*)")
--     end
--     if string.match(raw, "qid:(%d*)") then
--         returnData = true
--         out["qid"] = string.match(raw, "qid:(%d*)")
--     end
--     if string.match(raw, "nqid") then
--         returnData = true
--         out["nqid"] = string.match(raw, "nqid:(%d*)")
--     end
--     if string.match(raw, "fac") then
--         returnData = true
--         out["fac"] = string.match(raw, "fac:(%a*)")
--     end
--     if string.match(raw, "rep") then
--         returnData = true
--         local repString = string.match(raw, "rep:(.*)")
--         local standing, fac = strmatch(repString, "^(%d+)%.(.*)$", 1)
--         if standing and fac then
--             out["rep"] = {
--                 ["standing"] = standing,
--                 ["fac"] = fac
--             }
--         end
--     end
--     if string.match(raw, "cls") then
--         returnData = true
--         out["cls"] = string.match(raw, "cls:(%a*)")
--     end
--     if string.match(raw, "rac") then
--         returnData = true
--         out["rac"] = string.match(raw, "rac:(%a*)")
--     end
--     if string.match(raw, "map") then
--         returnData = true
--         out["map"] = string.match(raw, "map:(%d*)")
--     end
--     if string.match(raw, "spell") then
--         returnData = true
--         out["spell"] = string.match(raw, "spell:(%d*)")
--     end
--     if returnData then
--         return out
--     end

-- end

--     -- transport data
--     for _, j in pairs(fullData.BoatData) do
--         for _, k in pairs(j) do
--             local row = {}
--             local fromMapId, fromFloor, fromLocString, toMapId, toFloor, toLocString, waitTime, type = strsplit(":", k)
--             row.fromMapId = tonumber(fromMapId)
--             row.fromFloor = tonumber(fromFloor)
--             row.fromX, row.fromY = UnpackXY(fromLocString)
--             row.toMapId = tonumber(toMapId)
--             row.toFloor = tonumber(toFloor)
--             row.toX, row.toY = UnpackXY(toLocString)
--             row.waitTime = tonumber(waitTime)
--             row.type = type
--             row.nodeType = "transport"

--             local reqs = getReqs(k)
--             if reqs then
--                 row.reqs = reqs
--             end
--             table.insert(newData, row)
--         end
--     end

--     -- instance portals
--     for i, j in pairs(fullData.InstancePortals) do
--         local row = {}
--         local fromMapId, fromFloor, fromLocString, toMapId, toFloor, toLocString = strsplit(":", j)
--         row.fromMapId = tonumber(fromMapId)
--         row.fromFloor = tonumber(fromFloor)
--         row.fromX, row.fromY = UnpackXY(fromLocString)
--         row.toMapId = tonumber(toMapId)
--         row.toFloor = tonumber(toFloor)
--         row.toX, row.toY = UnpackXY(toLocString)

--         local reqs = getReqs(j)
--         if reqs then
--             row.reqs = reqs
--         end

--         row.nodeType = "instance"
--         table.insert(newData, row)
--     end

--     for _, j in pairs(fullData.LocalPortalData) do
--         for _, k in pairs(j) do
--             local row = {}

--             local _, fromMapId, fromFloor, fromLocString, toMapId, toFloor, toLocString = strsplit(":", k)
--             row.fromMapId = tonumber(fromMapId)
--             row.fromFloor = tonumber(fromFloor)
--             row.fromX, row.fromY = UnpackXY(fromLocString)
--             row.toMapId = tonumber(toMapId)
--             row.toFloor = tonumber(toFloor)
--             row.toX, row.toY = UnpackXY(toLocString)

--             local reqs = getReqs(k)
--             if reqs then
--                 row.reqs = reqs
--             end
--             row.nodeType = "portals_local"
--             table.insert(newData, row)
--         end
--     end

--     for _, j in pairs(fullData.StaticPortalData) do
--         for _, k in pairs(j) do
--             local row = {}
--             local _, fromMapId, fromFloor, fromLocString, toMapId, toFloor, toLocString = strsplit(":", k)
--             row.fromMapId = tonumber(fromMapId)
--             row.fromFloor = tonumber(fromFloor)
--             row.fromX, row.fromY = UnpackXY(fromLocString)
--             row.toMapId = tonumber(toMapId)
--             row.toFloor = tonumber(toFloor)
--             row.toX, row.toY = UnpackXY(toLocString)

--             local reqs = getReqs(k)
--             if reqs then
--                 row.reqs = reqs
--             end
--             row.nodeType = "portals_static"
--             table.insert(newData, row)
--         end
--     end


--     -- unbound teleport data key is itemId and first value in string is spellId
--     for _, d in pairs(fullData.UnboundTeleportData) do
--         for itemId, data in pairs(d) do
--             local row = {}
--             local spellId, toMapId, toFloor, toLocString = strsplit(":", data)
--             row.spellId = tonumber(spellId)
--             row.toMapId = tonumber(toMapId)
--             row.toFloor = tonumber(toFloor)
--             row.toX, row.toY = UnpackXY(toLocString)

--             local reqs = getReqs(data)
--             if reqs then
--                 row.reqs = reqs
--             end
--             row.nodeType = "teleportto"

--             row.itemId = tonumber(itemId)

--             table.insert(newData, row)

--         end
--     end

--     local tableAsString = "{"
--     for i, j in pairs(newData) do
--         tableAsString = tableAsString .. "[" .. i .. "] = {"

--         for key, value in pairs(j) do
--             if type(value) == "table" then
--                 tableAsString = tableAsString .. "[\"" .. key .. "\"]" .. " = {"
--                 for k, v in pairs(value) do
--                     local v2
--                     if type(v) == "string" then
--                         v2 = "\"" .. v .. "\""
--                     else
--                         v2 = v
--                     end
--                     tableAsString = tableAsString .. "[\"" .. k .. "\"]" .. " = " .. v2 .. ", "
--                 end
--                 tableAsString = tableAsString .. "}, "
--             else
--                 local v2
--                 if type(value) == "string" then
--                     v2 = "\"" .. value .. "\""
--                 else
--                     v2 = value
--                 end
--                 tableAsString = tableAsString .. "[\"" .. key .. "\"]" .. " = " .. v2 .. ", "
--             end
--         end
--         tableAsString = tableAsString .. "}, "



--         local pin = CreateFrame("Button", nil)
--         pin:SetSize(30, 30)
--         pin.icon = pin:CreateTexture(nil, "BORDER")
--         pin.icon:SetAtlas("Waypoint-MapPin-Tracked", true)
--         pin.icon:SetSize(30, 30)
--         pin.icon:SetBlendMode("BLEND")
--         pin.icon:SetAllPoints(pin)
--         local function SetTooltip(title)
--             pin:SetScript("OnEnter", function(self)
--                 GameTooltip:SetOwner(self, "ANCHOR_RIGHT", -16, -4)
--                 GameTooltip_SetTitle(GameTooltip, title)

--                 GameTooltip:Show()
--             end)
--         end

--         local dataText = ""
--         for key, value in pairs(j) do
--             if value then
--                 if type(value) == "table" then
--                     for k, v in pairs(value) do
--                         dataText = dataText .. key .. "-" .. k .. ": " .. v .. "\n"
--                     end
--                 else
--                     dataText = dataText .. key .. ": " .. value .. "\n"
--             end
--         end
--     end
--     SetTooltip(dataText)

--     pin:SetScript("OnLeave", function()
--         GameTooltip:Hide()
--     end)
--     pin:Show()
--     if j.toMapId and j.toX and j.toY then
--         HBDP:AddWorldMapIconMap(core, pin, j.toMapId, j.toX, j.toY, 3)
--     else
--         core:debug(j, "Missing data")
--     end
-- end
-- tableAsString = tableAsString .. "}"

-- core:debug(fullData, "fullData")





function module:OnInitialize()
    core:debug(core.NavigationData)
end

function core:navigateToPin(targetX, targetY, targetMapID)
    local sourceX, sourceY = C_Map.GetPlayerMapPosition(sourceMapID, "player"):GetXY()
    local sourceMapID = C_Map.GetBestMapForUnit("player")
    -- local data = {["source"] = {targetX, targetY, targetMapID}, ["target"] = {sourceX, sourceY, sourceMapID}}

end
