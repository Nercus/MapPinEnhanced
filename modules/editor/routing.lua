---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Editor
local Editor = MapPinEnhanced:GetModule("Editor")

local HBD = MapPinEnhanced.HBD
local abs = math.abs
local sqrt = math.sqrt

local EPSILON = 0.000001
local FULL_TWO_OPT_LIMIT = 150
local LIMITED_TWO_OPT_LIMIT = 500
local LIMITED_TWO_OPT_IMPROVEMENTS = 64

---@class MapPinEnhancedEditorRouteNode
---@field pinID UUID
---@field x number
---@field y number
---@field originalIndex integer

---@param left MapPinEnhancedEditorRouteNode
---@param right MapPinEnhancedEditorRouteNode
---@return number
local function Distance(left, right)
    local dx, dy = left.x - right.x, left.y - right.y
    return sqrt(dx * dx + dy * dy)
end

---@param path MapPinEnhancedEditorRouteNode[]
---@param first integer
---@param last integer
local function Reverse(path, first, last)
    while first < last do
        path[first], path[last] = path[last], path[first]
        first, last = first + 1, last - 1
    end
end

---@param nodes MapPinEnhancedEditorRouteNode[]
---@return MapPinEnhancedEditorRouteNode[]
local function BuildNearestNeighbourPath(nodes)
    if #nodes < 2 then return nodes end

    ---@type MapPinEnhancedEditorRouteNode[]
    local path = { nodes[1] }
    ---@type table<integer, boolean>
    local used = { [1] = true }

    for pathIndex = 2, #nodes do
        local previous = path[pathIndex - 1]
        local bestIndex, bestDistance
        for index = 2, #nodes do
            if not used[index] then
                local distance = Distance(previous, nodes[index])
                if not bestDistance or distance < bestDistance - EPSILON or
                    (abs(distance - bestDistance) <= EPSILON and
                        nodes[index].originalIndex < nodes[assert(bestIndex)].originalIndex) then
                    bestIndex, bestDistance = index, distance
                end
            end
        end
        bestIndex = assert(bestIndex)
        path[pathIndex] = nodes[bestIndex]
        used[bestIndex] = true
    end
    return path
end

---@param path MapPinEnhancedEditorRouteNode[]
---@param maxImprovements integer?
local function ImproveWithTwoOpt(path, maxImprovements)
    if #path < 4 or maxImprovements == 0 then return end

    local improvements = 0
    while not maxImprovements or improvements < maxImprovements do
        local improved = false
        for first = 2, #path - 1 do
            local before, oldFirst = path[first - 1], path[first]
            for last = first + 1, #path do
                local oldLast = path[last]
                local delta = Distance(before, oldLast) - Distance(before, oldFirst)
                if last < #path then
                    delta = delta + Distance(oldFirst, path[last + 1]) - Distance(oldLast, path[last + 1])
                end
                if delta < -EPSILON then
                    Reverse(path, first, last)
                    improvements = improvements + 1
                    improved = true
                    break
                end
            end
            if improved then break end
        end
        if not improved then return end
    end
end

---@param nodes MapPinEnhancedEditorRouteNode[]
---@return MapPinEnhancedEditorRouteNode[]
local function OptimizeCluster(nodes)
    local path = BuildNearestNeighbourPath(nodes)
    if #path <= FULL_TWO_OPT_LIMIT then
        ImproveWithTwoOpt(path)
    elseif #path <= LIMITED_TWO_OPT_LIMIT then
        ImproveWithTwoOpt(path, LIMITED_TWO_OPT_IMPROVEMENTS)
    end
    return path
end

---@param pinNodes MapPinEnhancedEditorPinNodeData[]
---@return MapPinEnhancedEditorRouteNode[][], MapPinEnhancedEditorPinNodeData[]
local function BuildClusters(pinNodes)
    ---@type MapPinEnhancedEditorRouteNode[][]
    local clusters = {}
    ---@type table<number, MapPinEnhancedEditorRouteNode[]>
    local clustersByInstance = {}
    ---@type MapPinEnhancedEditorPinNodeData[]
    local unavailable = {}

    for index, pinNode in ipairs(pinNodes) do
        local data = Editor:GetPinData(pinNode)
        ---@type number?, number?, number?
        local worldX, worldY, instance = nil, nil, nil
        if data and data.mapID and data.x and data.y then
            worldX, worldY, instance = HBD:GetWorldCoordinatesFromZone(data.x, data.y, data.mapID)
        end
        if worldX and worldY and instance then
            local cluster = clustersByInstance[instance]
            if not cluster then
                cluster = {}
                clustersByInstance[instance] = cluster
                clusters[#clusters + 1] = cluster
            end
            cluster[#cluster + 1] = {
                pinID = pinNode.pinID,
                x = worldX,
                y = worldY,
                originalIndex = index,
            }
        else
            unavailable[#unavailable + 1] = pinNode
        end
    end
    return clusters, unavailable
end

---@param pinNodes MapPinEnhancedEditorPinNodeData[] pins in current editor order
---@param onComplete fun(pinIDs: UUID[])
---@param onError fun(message: string)?
function Editor:OptimizePinOrder(pinNodes, onComplete, onError)
    assert(type(pinNodes) == "table", "Editor:OptimizePinOrder: pinNodes must be a table")
    assert(type(onComplete) == "function", "Editor:OptimizePinOrder: onComplete must be a function")

    local clusters, unavailable = BuildClusters(pinNodes)
    ---@type UUID[]
    local result = {}
    ---@type (fun(): boolean?)[]
    local tasks = {}
    for _, cluster in ipairs(clusters) do
        local currentCluster = cluster
        tasks[#tasks + 1] = function()
            for _, node in ipairs(OptimizeCluster(currentCluster)) do result[#result + 1] = node.pinID end
        end
    end

    MapPinEnhanced:BatchExecution(tasks, nil, function()
        for _, pinNode in ipairs(unavailable) do result[#result + 1] = pinNode.pinID end
        onComplete(result)
    end, 1, onError)
end
