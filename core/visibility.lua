---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@alias VisibilityCallbackEvent
---| "PIN_ADDED"
---| "PIN_REMOVED"
---| "PIN_REACHED"
---| "PIN_TRACKING_CHANGED"
---| "GROUP_UPDATED"
---| "GROUP_DELETED"

---@class VisibilityRule
---@field isActive fun(): boolean
---@field events? WowEvent[]
---@field callbacks? VisibilityCallbackEvent[]
---@field delay? number
---@field poll? boolean

---@class VisibilityTarget
---@field optionKey string
---@field rules table<string, boolean>
---@field isManuallyEnabled fun(): boolean
---@field show fun()
---@field hide fun()
---@field ruleStartedAt table<string, number>
---@field isShown boolean?

---@class VisibilityTargetSettings
---@field optionKey string
---@field rules string[]
---@field isManuallyEnabled fun(): boolean
---@field show fun()
---@field hide fun()

---@type table<string, VisibilityRule>
local rules = {}
---@type table<string, VisibilityTarget>
local targets = {}
---@type table<WowEvent, boolean>
local registeredEvents = {}
---@type table<VisibilityCallbackEvent, boolean>
local registeredCallbacks = {}
local updateQueued = false

---@param targetID string
local function UpdateTargetVisibility(targetID)
    local target = targets[targetID]
    if not target then return end

    local shouldShow = target.isManuallyEnabled()
    if shouldShow then
        local Options = MapPinEnhanced:GetModule("Options")
        local selected = Options:GetOptionValue(target.optionKey) --[[@as MapPinEnhancedMultiselectValue]]
        local now = GetTime()
        for ruleID in pairs(target.rules) do
            local rule = rules[ruleID]
            assert(rule, "Visibility target references an unregistered rule: " .. ruleID)
            if selected[ruleID] and rule.isActive() then
                local startedAt = target.ruleStartedAt[ruleID]
                if not startedAt then
                    startedAt = now
                    target.ruleStartedAt[ruleID] = startedAt
                end
                if not rule.delay or now - startedAt >= rule.delay then
                    shouldShow = false
                    break
                end
            else
                target.ruleStartedAt[ruleID] = nil
            end
        end
    else
        wipe(target.ruleStartedAt)
    end

    if target.isShown == shouldShow then return end
    target.isShown = shouldShow
    if shouldShow then
        target.show()
    else
        target.hide()
    end
end

local function UpdateAllTargetVisibility()
    for targetID in pairs(targets) do
        UpdateTargetVisibility(targetID)
    end
end

local function QueueAllTargetVisibilityUpdates()
    if updateQueued then return end
    updateQueued = true
    C_Timer.After(0, function()
        updateQueued = false
        UpdateAllTargetVisibility()
    end)
end

---@param ruleID string
---@param rule VisibilityRule
function MapPinEnhanced:AddVisibilityRule(ruleID, rule)
    assert(type(ruleID) == "string" and ruleID ~= "", "Visibility rule ID is required")
    assert(not rules[ruleID], "Visibility rule already registered: " .. ruleID)
    assert(type(rule.isActive) == "function", "Visibility rule predicate is required")
    rules[ruleID] = rule

    for _, event in ipairs(rule.events or {}) do
        if not registeredEvents[event] then
            registeredEvents[event] = true
            self:RegisterEvent(event, UpdateAllTargetVisibility)
        end
    end
    for _, callback in ipairs(rule.callbacks or {}) do
        if not registeredCallbacks[callback] then
            registeredCallbacks[callback] = true
            self:RegisterCallback(callback, QueueAllTargetVisibilityUpdates)
        end
    end
end

---@param targetID string
---@param settings VisibilityTargetSettings
function MapPinEnhanced:RegisterVisibilityTarget(targetID, settings)
    assert(type(targetID) == "string" and targetID ~= "", "Visibility target ID is required")
    assert(not targets[targetID], "Visibility target already registered: " .. targetID)
    assert(type(settings.optionKey) == "string", "Visibility target option key is required")
    assert(type(settings.isManuallyEnabled) == "function", "Visibility target manual predicate is required")
    assert(type(settings.show) == "function" and type(settings.hide) == "function",
        "Visibility target show/hide adapters are required")

    ---@type table<string, boolean>
    local allowed = {}
    for _, ruleID in ipairs(settings.rules or {}) do
        assert(rules[ruleID], "Unknown visibility rule: " .. tostring(ruleID))
        allowed[ruleID] = true
    end

    targets[targetID] = {
        optionKey = settings.optionKey,
        rules = allowed,
        isManuallyEnabled = settings.isManuallyEnabled,
        show = settings.show,
        hide = settings.hide,
        ruleStartedAt = {},
    }

    local Options = self:GetModule("Options")
    Options:SubscribeToOptionChanges(settings.optionKey, function()
        UpdateTargetVisibility(targetID)
    end)
    QueueAllTargetVisibilityUpdates()
end

---@param targetID string
function MapPinEnhanced:UpdateVisibilityTarget(targetID)
    UpdateTargetVisibility(targetID)
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
MapPinEnhanced:AddVisibilityRule("dungeon", { isActive = IsInstanceType("party"), events = INSTANCE_EVENTS })
MapPinEnhanced:AddVisibilityRule("raid", { isActive = IsInstanceType("raid"), events = INSTANCE_EVENTS })
MapPinEnhanced:AddVisibilityRule("scenario",
    { isActive = IsInstanceType("scenario"), events = INSTANCE_EVENTS })
MapPinEnhanced:AddVisibilityRule("battleground", { isActive = IsInstanceType("pvp"), events = INSTANCE_EVENTS })
MapPinEnhanced:AddVisibilityRule("arena", { isActive = IsInstanceType("arena"), events = INSTANCE_EVENTS })

local function InitVisibility()
    C_Timer.NewTicker(0.25, function()
        for targetID, target in pairs(targets) do
            for ruleID in pairs(target.rules) do
                local rule = rules[ruleID]
                if rule and rule.poll then
                    UpdateTargetVisibility(targetID)
                    break
                end
            end
        end
    end)
end

MapPinEnhanced:OnLoad(InitVisibility)
