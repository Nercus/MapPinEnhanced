---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")


MapPinEnhanced:RegisterGlobalAPI("RegisterPinGroup", function(groupInfo)
    return Groups:RegisterPinGroup(groupInfo):GetProxy()
end)


MapPinEnhanced:RegisterGlobalAPI("GetGroupsBySource", function(source)
    local groups = {}
    ---@param group MapPinEnhancedPinGroupMixin
    for group in Groups:EnumerateGroups() do
        if group.source == source then
            table.insert(groups, group:GetProxy())
        end
    end
    return groups
end)
