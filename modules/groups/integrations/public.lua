---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

local function ValidateGroupInfo(groupInfo, apiName)
    if type(groupInfo) ~= "table" then
        error(apiName .. ": groupInfo must be a table")
    end
    if not Groups:IsValidGroupName(groupInfo.name) then
        error(apiName .. ": groupInfo.name must be a non-empty string")
    end
    if type(groupInfo.source) ~= "string" or groupInfo.source == "" then
        error(apiName .. ": groupInfo.source must be a non-empty string")
    end
    if groupInfo.source == MapPinEnhanced.name then
        error(apiName .. ": player-owned groups cannot be registered through the public API")
    end
    if type(groupInfo.groupID) ~= "string" or groupInfo.groupID == "" then
        error(apiName .. ": groupInfo.groupID must be a non-empty stable ID")
    end
    if not C_AddOns.IsAddOnLoaded(groupInfo.source) then
        error(apiName .. ": source addon is not loaded")
    end
    if groupInfo.groupType ~= nil or Groups:GetSystemGroupType(groupInfo.groupID) ~= nil then
        error(apiName .. ": system groups cannot be registered through the public API")
    end
    if groupInfo.restorable ~= nil and type(groupInfo.restorable) ~= "boolean" then
        error(apiName .. ": groupInfo.restorable must be a boolean")
    end
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedPublicGroupProxy
local function CreateGroupProxy(group)
    local groupID, source = group:GetGroupID(), group:GetSource()
    local lifetimeChangeNumber = group.lifetimeChangeNumber

    -- IDs can be registered again and pooled objects reused. A proxy belongs
    -- only to this lifetime; caller-supplied fields never select its group.
    ---@return MapPinEnhancedGroupMixin?
    local function GetGroup()
        if not group:IsSameGroup(groupID, lifetimeChangeNumber) or group:IsProtected() or
            group:GetSource() ~= source then
            return nil
        end
        return group
    end

    ---@param pinID UUID
    ---@return MapPinEnhancedGroupMixin?
    local function GetPinGroup(pinID)
        local current = GetGroup()
        if not current or type(pinID) ~= "string" then return nil end
        -- Owner operations may cancel batches even for missing pins. Check
        -- membership first, including hidden/cleared pins and pins moved away.
        if current:GetPinByID(pinID) or current:GetArchivedPinByID(pinID) then
            return current
        end
        return nil
    end

    ---@class MapPinEnhancedPublicGroupProxy
    local proxy = {}

    ---@param pinData pinData
    ---@return UUID? pinID
    function proxy:AddPin(pinData)
        local current = GetGroup()
        if not current then return nil end
        assert(type(pinData) == "table", "MapPinEnhancedPublicGroupProxy:AddPin: pinData must be a table")
        -- Hidden storage accepts retained IDs for restore; public additions
        -- must never introduce an identity belonging to another group.
        assert(rawget(pinData, "pinID") == nil, "MapPinEnhancedPublicGroupProxy:AddPin: pinID must not be supplied")
        local _, pinID = current:AddPin(pinData)
        return pinID
    end

    ---@param pinID UUID
    ---@return boolean deleted
    function proxy:DeletePin(pinID)
        local current = GetPinGroup(pinID)
        if not current then return false end
        return current:RemovePin(pinID)
    end

    ---@param pinID UUID
    ---@return boolean cleared
    function proxy:ClearPin(pinID)
        local current = GetPinGroup(pinID)
        if not current then return false end
        return current:ClearPin(pinID)
    end

    ---@param pinID UUID
    ---@return boolean restored
    function proxy:RestorePin(pinID)
        local current = GetPinGroup(pinID)
        if not current then return false end
        return current:RestorePin(pinID)
    end

    ---@return boolean accepted
    function proxy:DeleteAllPins()
        local current = GetGroup()
        if not current then return false end
        return current:ClearGroup()
    end

    ---@return boolean accepted
    function proxy:ClearAllPins()
        local current = GetGroup()
        if not current then return false end
        return current:ClearAllPins()
    end

    ---Restore cleared pins without starting tracking; hidden groups stay hidden.
    ---@return boolean accepted true means accepted, not necessarily completed
    function proxy:RestorePins()
        local current = GetGroup()
        if not current then return false end
        return current:RestorePins()
    end

    ---@return boolean? restorable
    function proxy:IsRestorable()
        local current = GetGroup()
        if not current then return nil end
        return current:IsRestorable()
    end

    ---@param restorable boolean
    ---@return boolean accepted disabling may restore cleared pins over multiple frames
    function proxy:SetRestorable(restorable)
        if type(restorable) ~= "boolean" then
            error("MapPinEnhancedPublicGroupProxy:SetRestorable: restorable must be a boolean")
        end
        local current = GetGroup()
        if not current then return false end
        return current:SetRestorable(restorable)
    end

    ---@return GroupTrackingMode? mode
    function proxy:GetTrackingMode()
        local current = GetGroup()
        if not current then return nil end
        return current:GetTrackingMode()
    end

    ---@param mode GroupTrackingMode
    ---@return boolean accepted
    function proxy:SetTrackingMode(mode)
        if not Groups:IsValidTrackingMode(mode) then
            error("MapPinEnhancedPublicGroupProxy:SetTrackingMode: invalid tracking mode")
        end
        local current = GetGroup()
        if not current then return false end
        return current:SetTrackingMode(mode)
    end

    return proxy
end

---@param groupInfo GroupInfo
---@return MapPinEnhancedPublicGroupProxy
MapPinEnhanced:RegisterGlobalAPI("RegisterGroup", function(groupInfo)
    ValidateGroupInfo(groupInfo, "MapPinEnhanced.RegisterGroup")

    local group, failureReason = Groups:RegisterGroup(groupInfo)
    if not group then
        error("MapPinEnhanced.RegisterGroup: " .. (failureReason or "failed to register group"))
    end

    local proxy = CreateGroupProxy(group)
    if group:IsHidden() then
        MapPinEnhanced:Print(string.format(L["%s added hidden group \"%s\"."], group:GetSource(), group:GetName()))
    end

    return proxy
end)
