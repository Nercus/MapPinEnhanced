---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")

local HBD = MapPinEnhanced.HBD
local L = MapPinEnhanced.L
local abs = math.abs
local sqrt = math.sqrt

local EPSILON = 0.000001
local FULL_TWO_OPT_LIMIT = 150
local LIMITED_TWO_OPT_LIMIT = 500
local LIMITED_TWO_OPT_IMPROVEMENTS = 64

---@class MapPinEnhancedRouteInputEntry
---@field pinID UUID
---@field order number
---@field title string
---@field mapID number?
---@field x number?
---@field y number?
---@field state "active"|"reached"|"hidden"

---@class MapPinEnhancedRouteInput
---@field group MapPinEnhancedGroupMixin
---@field groupID UUID
---@field changeNumber number
---@field entries MapPinEnhancedRouteInputEntry[]

---@class MapPinEnhancedRouteNode
---@field pinID UUID
---@field x number
---@field y number
---@field originalIndex integer

---@param left MapPinEnhancedRouteNode
---@param right MapPinEnhancedRouteNode
---@return number
local function Distance(left, right)
    local dx, dy = left.x - right.x, left.y - right.y
    return sqrt(dx * dx + dy * dy)
end

---@param path MapPinEnhancedRouteNode[]
---@param first integer
---@param last integer
local function Reverse(path, first, last)
    while first < last do
        path[first], path[last] = path[last], path[first]
        first, last = first + 1, last - 1
    end
end

---@param nodes MapPinEnhancedRouteNode[]
---@return MapPinEnhancedRouteNode[]
local function BuildNearestNeighbourPath(nodes)
    if #nodes < 2 then return nodes end

    ---@type MapPinEnhancedRouteNode[]
    local path = { nodes[1] }
    ---@type table<integer, boolean>
    local used = { [1] = true }

    for pathIndex = 2, #nodes do
        local previous = path[pathIndex - 1]
        ---@type integer?
        local bestIndex
        ---@type number?
        local bestDistance
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

---@param path MapPinEnhancedRouteNode[]
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

---@param nodes MapPinEnhancedRouteNode[]
---@return MapPinEnhancedRouteNode[]
local function OrderNearbyPins(nodes)
    local path = BuildNearestNeighbourPath(nodes)
    if #path <= FULL_TWO_OPT_LIMIT then
        ImproveWithTwoOpt(path)
    elseif #path <= LIMITED_TWO_OPT_LIMIT then
        ImproveWithTwoOpt(path, LIMITED_TWO_OPT_IMPROVEMENTS)
    end
    return path
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedRouteInput
local function CopyRouteInputs(group)
    ---@type MapPinEnhancedRouteInputEntry[]
    local entries = {}
    for _, pinEntry in ipairs(group:GetPinEntries()) do
        local data = pinEntry.data
        entries[#entries + 1] = {
            pinID = pinEntry.pinID,
            order = pinEntry.order,
            title = data.title or "",
            mapID = data.mapID,
            x = data.x,
            y = data.y,
            state = pinEntry.state,
        }
    end
    table.sort(entries, function(left, right)
        if left.order ~= right.order then return left.order > right.order end
        if left.title ~= right.title then return left.title < right.title end
        return left.pinID < right.pinID
    end)

    return {
        group = group,
        groupID = assert(group:GetGroupID()),
        changeNumber = group:GetPinChangeNumber(),
        entries = entries,
    }
end

---@param entries MapPinEnhancedRouteInputEntry[]
---@return MapPinEnhancedRouteNode[][], MapPinEnhancedRouteInputEntry[]
local function BuildClusters(entries)
    ---@type MapPinEnhancedRouteNode[][]
    local clusters = {}
    ---@type table<number, MapPinEnhancedRouteNode[]>
    local clustersByInstance = {}
    ---@type MapPinEnhancedRouteInputEntry[]
    local unavailable = {}

    for index, entry in ipairs(entries) do
        ---@type number?, number?, number?
        local worldX, worldY, instance = nil, nil, nil
        if entry.mapID and entry.x and entry.y then
            worldX, worldY, instance = HBD:GetWorldCoordinatesFromZone(entry.x, entry.y, entry.mapID)
        end
        if worldX and worldY and instance then
            local cluster = clustersByInstance[instance]
            if not cluster then
                cluster = {}
                clustersByInstance[instance] = cluster
                clusters[#clusters + 1] = cluster
            end
            cluster[#cluster + 1] = {
                pinID = entry.pinID,
                x = worldX,
                y = worldY,
                originalIndex = index,
            }
        else
            unavailable[#unavailable + 1] = entry
        end
    end
    return clusters, unavailable
end

---@param groups Groups
---@param routeInput MapPinEnhancedRouteInput
---@return boolean
local function GroupStillMatchesRouteInput(groups, routeInput)
    local group = routeInput.group
    if group:GetGroupID() ~= routeInput.groupID or groups:GetGroupByID(routeInput.groupID) ~= group then
        return false
    end
    if group:GetPinChangeNumber() ~= routeInput.changeNumber then return false end
    if group:GetTotalPinCount() ~= #routeInput.entries then return false end

    -- Optimization yields between instance clusters. Only apply if every field
    -- that shaped the route still belongs to the same registered group state.
    ---@type table<UUID, MapPinEnhancedGroupPinEntry>
    local currentByID = {}
    for _, entry in ipairs(group:GetPinEntries()) do currentByID[entry.pinID] = entry end
    for _, inputEntry in ipairs(routeInput.entries) do
        local current = currentByID[inputEntry.pinID]
        local data = current and current.data or nil
        if not current or current.state ~= inputEntry.state or current.order ~= inputEntry.order or
            not data or data.mapID ~= inputEntry.mapID or data.x ~= inputEntry.x or
            data.y ~= inputEntry.y or (data.title or "") ~= inputEntry.title then
            return false
        end
    end
    return true
end

---@param group MapPinEnhancedGroupMixin
---@param pinIDs UUID[]
local function ApplyRouteOrder(group, pinIDs)
    assert(group:ReorderPins(pinIDs),
        "Groups:OrderGroupByDistance: route order does not contain every retained pin")
end

---@param group MapPinEnhancedGroupMixin
---@param onComplete fun()
---@param onError fun(message: string)?
function Groups:OrderGroupByDistance(group, onComplete, onError)
    assert(type(group) == "table" and group.classification == "group",
        "Groups:OrderGroupByDistance: group must be a MapPinEnhancedGroupMixin object")
    assert(type(onComplete) == "function", "Groups:OrderGroupByDistance: onComplete must be a function")
    assert(type(onError) == "function" or onError == nil,
        "Groups:OrderGroupByDistance: onError must be a function or nil")

    local routeInput = CopyRouteInputs(group)
    local clusters, unavailable = BuildClusters(routeInput.entries)
    ---@type UUID[]
    local orderedPinIDs = {}
    ---@type (fun(): boolean?)[]
    local tasks = {}
    for _, cluster in ipairs(clusters) do
        local currentCluster = cluster
        tasks[#tasks + 1] = function()
            for _, node in ipairs(OrderNearbyPins(currentCluster)) do
                orderedPinIDs[#orderedPinIDs + 1] = node.pinID
            end
        end
    end

    MapPinEnhanced:BatchExecution(tasks, nil, function()
        for _, entry in ipairs(unavailable) do
            orderedPinIDs[#orderedPinIDs + 1] = entry.pinID
        end
        if not GroupStillMatchesRouteInput(self, routeInput) then
            if onError then onError(L["Route optimization was canceled because the group changed."]) end
            return
        end
        ApplyRouteOrder(group, orderedPinIDs)
        onComplete()
    end, 1, onError)
end
