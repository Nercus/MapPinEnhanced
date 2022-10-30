local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local module = core:NewModule("Navigation", "AceEvent-3.0", "AceTimer-3.0")
local HBD = LibStub("HereBeDragons-2.0")
local HBDP = LibStub("HereBeDragons-Pins-2.0")

local INF = math.huge
local cachedPaths = nil
local UiMapPoint = _G.UiMapPoint

local function dist(m1, x1, y1, m2, x2, y2)
    local distance, _, _ = HBD:GetZoneDistance(m1, x1, y1, m2, x2, y2)
    if not distance then return 999999 end
    return distance
end

local function heuristic_cost_estimate(nodeA, nodeB)
    if nodeA.source and nodeB.target then
        if nodeA.source == nodeB.target then
            return 0
        end
    elseif nodeB.target then
        if nodeB.target < 0 then
            return 0
        end
    end
    return dist(nodeA.mapId, nodeA.x, nodeA.y, nodeB.mapId, nodeB.x, nodeB.y)
end

local function is_valid_node(node, neighbor)
    if neighbor.reqs then
        if neighbor.reqs.spell then
            local isReady = GetSpellCooldown(neighbor.reqs.spell) == 0
            return isReady
        end
    end
    if node.continent == neighbor.continent then
        return true
    elseif neighbor.mapId == node.mapId then
        return true
    elseif node.source and node.source == neighbor.target and node.source > 0 then
        return true
    else
        return false
    end
end

local function lowest_f_score(set, f_score)
    local lowest, bestNode = INF, nil
    for _, node in ipairs(set) do
        local score = f_score[node]
        if score < lowest then
            lowest, bestNode = score, node
        end
    end
    return bestNode
end

local function neighbor_nodes(theNode, nodes)
    local neighbors = {}
    for _, node in ipairs(nodes) do
        if theNode ~= node and is_valid_node(theNode, node) then
            table.insert(neighbors, node)
        end
    end
    return neighbors
end

local function not_in(set, theNode)

    for _, node in ipairs(set) do
        if node == theNode then return false end
    end
    return true
end

local function remove_node(set, theNode)

    for i, node in ipairs(set) do
        if node == theNode then
            set[i] = set[#set]
            set[#set] = nil
            break
        end
    end
end

local function unwind_path(flat_path, map, current_node)
    if map[current_node] then
        table.insert(flat_path, 1, map[current_node])
        return unwind_path(flat_path, map, map[current_node])
    else
        return flat_path
    end
end

local function a_star(start, goal, nodes, valid_node_func)

    local closedset = {}
    local openset = { start }
    local came_from = {}

    if valid_node_func then is_valid_node = valid_node_func end

    local g_score, f_score = {}, {}
    g_score[start] = 0
    f_score[start] = g_score[start] + heuristic_cost_estimate(start, goal)

    while #openset > 0 do

        local current = lowest_f_score(openset, f_score)


        if current == goal then
            local path = unwind_path({}, came_from, goal)
            table.insert(path, goal)
            return path
        end

        remove_node(openset, current)
        table.insert(closedset, current)


        local neighbors = neighbor_nodes(current, nodes)

        for _, neighbor in ipairs(neighbors) do
            if not_in(closedset, neighbor) then

                local tentative_g_score = g_score[current] + heuristic_cost_estimate(current, neighbor)

                if not_in(openset, neighbor) or tentative_g_score < g_score[neighbor] then
                    came_from[neighbor] = current
                    g_score[neighbor] = tentative_g_score
                    f_score[neighbor] = g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)
                    if not_in(openset, neighbor) then
                        table.insert(openset, neighbor)
                    end
                end
            end
        end
        coroutine.yield();
    end
    return nil -- no valid path
end

local function path(start, goal, nodes, ignore_cache, valid_node_func)

    if not cachedPaths then cachedPaths = {} end
    if not cachedPaths[start] then
        cachedPaths[start] = {}
    elseif cachedPaths[start][goal] and not ignore_cache then
        return cachedPaths[start][goal]
    end

    local resPath = a_star(start, goal, nodes, valid_node_func)
    if not cachedPaths[start][goal] and not ignore_cache then
        cachedPaths[start][goal] = resPath
    end

    return resPath
end

local function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function module:OnInitialize()
    local navPin = CreateFrame("Frame", nil, nil)
    navPin:SetSize(15, 15)
    navPin:SetFrameStrata("HIGH")
    navPin:SetFrameLevel(100)
    navPin.texture = navPin:CreateTexture(nil, "OVERLAY")
    navPin.texture:SetAllPoints()
    navPin.texture:SetAtlas("hud-microbutton-communities-icon-notification")
    navPin:Hide()
    self.navPin = navPin
end

local function drawNavigationStep(target)
    core.blockWAYPOINTevent = true
    if C_Map.CanSetUserWaypointOnMap(target.mapId) then
        C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(target.mapId, target.x, target.y, 0))
        C_SuperTrack.SetSuperTrackedUserWaypoint(true)
    else
        local worldX, worldY, worldM = HBD:GetWorldCoordinatesFromZone(target.x, target.y, target.mapId)
        local worldV = CreateVector2D(worldX, worldY)
        local m = C_Map.GetMapPosFromWorldPos(worldM, worldV)
        local translateX, translateY = HBD:TranslateZoneCoordinates(target.x, target.y, target.mapId, m)
        if m and translateX and translateY then
            print(m, translateX, translateY)
            C_Map.SetUserWaypoint(UiMapPoint.CreateFromCoordinates(m, translateX, translateY, 0))
            C_SuperTrack.SetSuperTrackedUserWaypoint(true)
        end
    end
    core.blockWAYPOINTevent = false




    -- TODO: set mouseover
    --module.navPin:SetScript("OnEnter")
    if module and module.navPin then
        HBDP:AddWorldMapIconMap(module, module.navPin, target.mapId, target.x, target.y, 3)
    end
    local mapInfo = C_Map.GetMapInfo(target.mapId)
    if target.reqs and target.reqs.spell then
        core.MPHFrame.NavigationStepFrame:SetAction(target.reqs.spell,
            "Use " .. GetSpellInfo(target.reqs.spell) .. " to get to " .. mapInfo.name)
    else
        core.MPHFrame.NavigationStepFrame:SetText(string.format("Travel to %s (%1.f, %1.f)", mapInfo.name, target.x * 100
            , target.y * 100))
    end



end

local function handleNextNavStep(path, index, distance, goal)
    print("handleNextNavStep", index, distance, goal)
    -- TODO: check if point is linked to the next one
    if distance < 10 then
        if index > #path then
            module.distanceTimer = nil
            return
        end
        if path[index] then
            drawNavigationStep(path[index])
        else
            core.RemoveTrackedPin()
        end
    end
end

local function setNavigationPath(path, goal)
    if not path then return end
    print("setNavigationPath")
    local navigateIndex = 2 -- skip start
    drawNavigationStep(path[navigateIndex])
    if not module.distanceTimer then
        module.distanceTimer = module:ScheduleRepeatingTimer("DistanceTimer", 0.1, function(distance)
            if (distance > 0 and distance <= 10) then
                handleNextNavStep(path, navigateIndex, distance, goal)
                navigateIndex = navigateIndex + 1
            end
        end)
    elseif module.distanceTimer.cancelled then
        module.distanceTimer = module:ScheduleRepeatingTimer("DistanceTimer", 0.1, function(distance)
            if (distance > 0 and distance <= 10) then
                handleNextNavStep(path, navigateIndex, distance, goal)
                navigateIndex = navigateIndex + 1
            end
        end)
    end
end

function core:navigateToPin(targetX, targetY, targetMapID)
    core.MPHFrame.NavigationStepFrame:Show()
    core.MPHFrame.NavigationStepFrame:StartSpinner()
    local sourceMapID = C_Map.GetBestMapForUnit("player")
    local sourceX, sourceY = C_Map.GetPlayerMapPosition(sourceMapID, "player"):GetXY()
    local _, _, worldZone = HBD:GetWorldCoordinatesFromZone(sourceX, sourceY, sourceMapID)
    local _, _, worldZone2 = HBD:GetWorldCoordinatesFromZone(targetX, targetY, targetMapID)
    if (not sourceMapID) then
        print("No source map ID")
        return
    end
    local data = {
        ["source"] = { x = sourceX, y = sourceY, mapId = sourceMapID, continent = worldZone, source = -1, target = -1

        },
        ["target"] = { x = targetX, y = targetY, mapId = targetMapID, continent = worldZone2, source = -1, target = -1
        }
    }

    local navDataCopy = deepcopy(core.NavigationData)
    table.insert(navDataCopy, data.source)
    table.insert(navDataCopy, data.target)


    local co = coroutine.create(function()
        local path = path(data.source, data.target, navDataCopy, false, is_valid_node)
        if path then
            setNavigationPath(path, data.target)
        else
            print("No path found")
        end
        core.MPHFrame.NavigationStepFrame:StopSpinner()
    end)
    local function step()
        if coroutine.status(co) == "dead" then
            return
        end
        local status, err = coroutine.resume(co)
        if not status then
            print(err)
        end
        C_Timer.After(0.005, step)
    end

    step()
end

function module:DistanceTimer(cb)
    local hasBlizzWaypoint = C_Map.HasUserWaypoint()
    if hasBlizzWaypoint then
        local distance = C_Navigation.GetDistance()
        print(module, distance)
        if distance == 0 then
            cb(-1)
            self.distanceTimer.delay = 1
        else
            cb(distance)
            self.distanceTimer.delay = (0.015 * distance ^ (0.7)) -- calc new update delay based on distance
        end
    else
        self:CancelAllTimers()
    end
end
