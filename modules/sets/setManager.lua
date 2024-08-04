---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")

local CB = MapPinEnhanced.CB
---@type table<UUID, SetObject>
SetManager.Sets = {}

local MAX_COUNT_SETS = 500
local CURRENT_SET_COUNT = 0

---@class reducedSet
---@field name string
---@field pins table<string, pinData>

---@param targetSetID? UUID if nil, all sets will be persisted
function SetManager:PersistSets(targetSetID)
    if targetSetID then
        local set = self.Sets[targetSetID]
        if not set then --set was deleted
            MapPinEnhanced:DeleteVar("Sets", targetSetID)
            return
        end
        local setTable = {
            name = set.name,
            pins = set:GetPins()
        }
        MapPinEnhanced:SaveVar("Sets", targetSetID, setTable)
        return
    end
    ---@type table<UUID, reducedSet>
    local reducedSets = {}
    for setID, set in pairs(self.Sets) do
        reducedSets[setID] = {
            name = set.name,
            pins = set:GetPins()
        }
    end
    MapPinEnhanced:SaveVar("Sets", reducedSets)
end

function SetManager:RestoreSets()
    local reducedSets = MapPinEnhanced:GetVar("Sets") --[[@as table<UUID, reducedSet> | nil]]
    if not reducedSets then
        return
    end
    for setID, setTable in pairs(reducedSets) do
        local set = SetManager:AddSet(setTable.name, setID, true)
        for _, pinData in pairs(setTable.pins) do
            set:AddPin(pinData, true)
        end
        self.Sets[set.setID] = set
    end
end

function SetManager:DeleteSet(setID)
    self.Sets[setID]:Delete()
    self.Sets[setID] = nil
    SetManager:PersistSets(setID)
    CB:Fire("UpdateSetList")
end

function SetManager:GetSets()
    return self.Sets
end

function SetManager:GetSetByID(setID)
    return self.Sets[setID]
end

function SetManager:GetSetByName(name)
    for _, set in pairs(self.Sets) do
        if set.name == name then
            return set
        end
    end
end

function SetManager:UpdateSetNameByID(setID, newName)
    self.Sets[setID].name = newName
    self.Sets[setID]:SetName(newName)
    SetManager:PersistSets(setID)
    CB:Fire("UpdateSetList")
end

---@param name string
---@param overrideSetID UUID? if nil, a new setID will be generated
---@param restore boolean?
---@return SetObject
function SetManager:AddSet(name, overrideSetID, restore)
    CURRENT_SET_COUNT = CURRENT_SET_COUNT + 1
    if CURRENT_SET_COUNT > MAX_COUNT_SETS then
        error("Too many sets")
    end
    local setID = overrideSetID or MapPinEnhanced:GenerateUUID("set")
    local set = SetFactory:CreateSet(name, setID)
    set.setID = setID
    self.Sets[setID] = set
    if not restore then
        SetManager:PersistSets(setID)
    end
    CB:Fire("UpdateSetList")
    return set
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    SetManager:RestoreSets()
end)
