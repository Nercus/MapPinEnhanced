---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")


MapPinEnhanced:RegisterGlobalAPI("RegisterGroup", function(groupInfo)
    return Groups:RegisterGroup(groupInfo):GetProxy()
end)


MapPinEnhanced:RegisterGlobalAPI("GetGroupsBySource", function(source)
    local groups = {}
    ---@param group MapPinEnhancedGroupMixin
    for group in Groups:EnumerateGroups() do
        if group.source == source then
            table.insert(groups, group:GetProxy())
        end
    end
    return groups
end)
