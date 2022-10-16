local core = LibStub("AceAddon-3.0"):GetAddon("MapPinEnhanced")
local HBD = LibStub("HereBeDragons-2.0")



local INF = math.huge
local cachedPaths = nil


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

-- TODO: add coroutine with onUpdate Handler

local function formatNavigationOnFrame(path, start, goal)
    local text = "Lets go\n"
    for index, node in ipairs(path) do
        local nodeInfo = C_Map.GetMapInfo(node.mapId)
        if node.type == "UnboundTeleport" then
            text = text ..
                "Teleport to " .. nodeInfo.name .. " (" .. node.mapId .. ", " .. node.x .. ", " .. node.y .. ")\n"
        elseif node.type == "Boat" then
            text = text .. "Take " .. node.type .. " (" .. node.mapId .. ", " .. node.x .. ", " .. node.y .. ")\n"
        elseif node.type == "LocalPortal" then
            text = text ..
                "Take Portal to" .. nodeInfo.name .. " (" .. node.mapId .. ", " .. node.x .. ", " .. node.y .. ")\n"
        end
    end
    print(text)
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

function core:navigateToPin(targetX, targetY, targetMapID)
    core.NavigationStepFrame:Show()
    core.NavigationStepFrame.spinner:Play()
    local sourceMapID = C_Map.GetBestMapForUnit("player")
    local sourceX, sourceY = C_Map.GetPlayerMapPosition(sourceMapID, "player"):GetXY()
    local _, _, worldZone = HBD:GetWorldCoordinatesFromZone(sourceX, sourceY, sourceMapID)
    local _, _, worldZone2 = HBD:GetWorldCoordinatesFromZone(targetX, targetY, targetMapID)
    if (not sourceMapID) then
        print("No source map ID")
        return
    end
    local data = {
        ["source"] = { x = sourceX, y = sourceY, mapId = sourceMapID, continent = worldZone, source = -1, target = -1,
            ["getInfo"] = C_Map.GetMapInfo(sourceMapID)
        },
        ["target"] = { x = targetX, y = targetY, mapId = targetMapID, continent = worldZone2, source = -1, target = -1,
            ["getInfo"] = C_Map.GetMapInfo(targetMapID)
        }
    }

    local navDataCopy = deepcopy(core.NavigationData)
    table.insert(navDataCopy, data.source)
    table.insert(navDataCopy, data.target)

    ViragDevTool:AddData(navDataCopy, "navDataCopy")

    local resPath = path(data.source, data.target, navDataCopy, false, is_valid_node)
    ViragDevTool:AddData(resPath, "resPath")
    core.NavigationStepFrame.spinner:Stop()
    core.NavigationStepFrame.spinnerTexture:Hide()
    formatNavigationOnFrame(resPath, data.source, data.target)
end
