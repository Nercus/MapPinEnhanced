---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@alias VisibilityCallbackEvent
---| "PIN_ADDED"
---| "PIN_REMOVED"
---| "PIN_REACHED"
---| "PIN_TRACKING_CHANGED"
---| "GROUP_UPDATED"
---| "GROUP_DELETED"

---@class VisibilityCondition
---@field evaluate fun(): boolean
---@field events? WowEvent[]
---@field callbacks? VisibilityCallbackEvent[]
---@field delay? number
---@field poll? boolean

---@class VisibilityTarget
---@field optionKey string
---@field conditions table<string, boolean>
---@field isManuallyEnabled fun(): boolean
---@field show fun()
---@field hide fun()
---@field conditionStartedAt table<string, number>
---@field effectiveVisible boolean?

---@class VisibilityTargetConfig
---@field optionKey string
---@field conditions string[]
---@field isManuallyEnabled fun(): boolean
---@field show fun()
---@field hide fun()

---@type table<string, VisibilityCondition>
local conditions = {}
---@type table<string, VisibilityTarget>
local targets = {}
---@type table<WowEvent, boolean>
local registeredEvents = {}
---@type table<VisibilityCallbackEvent, boolean>
local registeredCallbacks = {}
local evaluationQueued = false

---@param targetID string
local function EvaluateTarget(targetID)
    local target = targets[targetID]
    if not target then return end

    local shouldShow = target.isManuallyEnabled()
    if shouldShow then
        local Options = MapPinEnhanced:GetModule("Options")
        local selected = Options:GetOptionValue(target.optionKey) --[[@as MapPinEnhancedMultiselectValue]]
        local now = GetTime()
        for conditionID in pairs(target.conditions) do
            local condition = conditions[conditionID]
            assert(condition, "Visibility target references an unregistered condition: " .. conditionID)
            if selected[conditionID] and condition.evaluate() then
                local startedAt = target.conditionStartedAt[conditionID]
                if not startedAt then
                    startedAt = now
                    target.conditionStartedAt[conditionID] = startedAt
                end
                if not condition.delay or now - startedAt >= condition.delay then
                    shouldShow = false
                    break
                end
            else
                target.conditionStartedAt[conditionID] = nil
            end
        end
    else
        wipe(target.conditionStartedAt)
    end

    if target.effectiveVisible == shouldShow then return end
    target.effectiveVisible = shouldShow
    if shouldShow then
        target.show()
    else
        target.hide()
    end
end

local function EvaluateAll()
    for targetID in pairs(targets) do
        EvaluateTarget(targetID)
    end
end

local function QueueEvaluateAll()
    if evaluationQueued then return end
    evaluationQueued = true
    C_Timer.After(0, function()
        evaluationQueued = false
        EvaluateAll()
    end)
end

---@param conditionID string
---@param condition VisibilityCondition
function MapPinEnhanced:RegisterVisibilityCondition(conditionID, condition)
    assert(type(conditionID) == "string" and conditionID ~= "", "Visibility condition ID is required")
    assert(not conditions[conditionID], "Visibility condition already registered: " .. conditionID)
    assert(type(condition.evaluate) == "function", "Visibility condition evaluator is required")
    conditions[conditionID] = condition

    for _, event in ipairs(condition.events or {}) do
        if not registeredEvents[event] then
            registeredEvents[event] = true
            self:RegisterEvent(event, EvaluateAll)
        end
    end
    for _, callback in ipairs(condition.callbacks or {}) do
        if not registeredCallbacks[callback] then
            registeredCallbacks[callback] = true
            self:RegisterCallback(callback, QueueEvaluateAll)
        end
    end
end

---@param targetID string
---@param config VisibilityTargetConfig
function MapPinEnhanced:RegisterVisibilityTarget(targetID, config)
    assert(type(targetID) == "string" and targetID ~= "", "Visibility target ID is required")
    assert(not targets[targetID], "Visibility target already registered: " .. targetID)
    assert(type(config.optionKey) == "string", "Visibility target option key is required")
    assert(type(config.isManuallyEnabled) == "function", "Visibility target manual predicate is required")
    assert(type(config.show) == "function" and type(config.hide) == "function",
        "Visibility target show/hide adapters are required")

    ---@type table<string, boolean>
    local allowed = {}
    for _, conditionID in ipairs(config.conditions or {}) do
        assert(conditions[conditionID], "Unknown visibility condition: " .. tostring(conditionID))
        allowed[conditionID] = true
    end

    targets[targetID] = {
        optionKey = config.optionKey,
        conditions = allowed,
        isManuallyEnabled = config.isManuallyEnabled,
        show = config.show,
        hide = config.hide,
        conditionStartedAt = {},
    }

    local Options = self:GetModule("Options")
    Options:SubscribeToOptionChanges(config.optionKey, function()
        EvaluateTarget(targetID)
    end)
    QueueEvaluateAll()
end

---@param targetID string
function MapPinEnhanced:EvaluateVisibilityTarget(targetID)
    EvaluateTarget(targetID)
end

---@param instanceType string
---@return fun(): boolean
local function IsInstanceType(instanceType)
    return function()
        local _, currentType = GetInstanceInfo()
        return currentType == instanceType
    end
end

local INSTANCE_EVENTS = { "PLAYER_ENTERING_WORLD", "ZONE_CHANGED_NEW_AREA" }
MapPinEnhanced:RegisterVisibilityCondition("dungeon", { evaluate = IsInstanceType("party"), events = INSTANCE_EVENTS })
MapPinEnhanced:RegisterVisibilityCondition("raid", { evaluate = IsInstanceType("raid"), events = INSTANCE_EVENTS })
MapPinEnhanced:RegisterVisibilityCondition("scenario",
    { evaluate = IsInstanceType("scenario"), events = INSTANCE_EVENTS })
MapPinEnhanced:RegisterVisibilityCondition("battleground", { evaluate = IsInstanceType("pvp"), events = INSTANCE_EVENTS })
MapPinEnhanced:RegisterVisibilityCondition("arena", { evaluate = IsInstanceType("arena"), events = INSTANCE_EVENTS })

local function InitVisibility()
    C_Timer.NewTicker(0.25, function()
        for targetID, target in pairs(targets) do
            for conditionID in pairs(target.conditions) do
                local condition = conditions[conditionID]
                if condition and condition.poll then
                    EvaluateTarget(targetID)
                    break
                end
            end
        end
    end)
end

MapPinEnhanced:OnLoad(InitVisibility)
