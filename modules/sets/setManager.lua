---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
---@class SetFactory : Module
local SetFactory = MapPinEnhanced:GetModule("SetFactory")
---@class SetManager : Module
local SetManager = MapPinEnhanced:GetModule("SetManager")

---@type table<string, SetObject>
SetManager.Sets = {}

local MAX_COUNT_SETS = 500

---@class reducedSet
---@field name string
---@field pins table<string, pinData>

function SetManager:PersistSets()
    ---@type table<number, reducedSet>
    local reducedSets = {}
    for _, set in pairs(self.Sets) do
        local setTable = {
            name = set.name,
            pins = set:GetPins()
        }
        table.insert(reducedSets, setTable)
    end
    MapPinEnhanced:SaveVar("Sets", reducedSets)
end

function SetManager:RestoreSets()
    local reducedSets = MapPinEnhanced:GetVar("Sets") --[[@as table<number, reducedSet> | nil]]
    if not reducedSets then
        return
    end
    for _, setTable in pairs(reducedSets) do
        local set = SetManager:AddSet(setTable.name)
        for _, pinData in pairs(setTable.pins) do
            set:AddPin(pinData)
        end
        self.Sets[set.setID] = set
    end
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

---@param name string
---@return SetObject
function SetManager:AddSet(name)
    if #self.Sets >= MAX_COUNT_SETS then
        error("Too many sets")
    end
    local setID = MapPinEnhanced:GenerateUUID("set")
    local set = SetFactory:CreateSet(name)
    set.setID = setID
    self.Sets[setID] = set
    SetManager:PersistSets()
    return set
end

MapPinEnhanced:RegisterEvent("PLAYER_ENTERING_WORLD", function()
    SetManager:RestoreSets()
end)
