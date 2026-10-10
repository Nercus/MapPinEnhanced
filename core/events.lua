---@diagnostic disable: incomplete-signature-doc
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type CallbackHandler-1.0
local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0");


---@class MapPinEnhancedEventHandler
---@field callback function
---@field active boolean

---@type table<WowEvent, MapPinEnhancedEventHandler[]>
local registeredEvents = {}

---@type function[] | nil
local onLoadCallbacks = {}

local addonWasLoaded = false
local function EventFrameHandler(self, event, ...)
    local functions = registeredEvents[event]
    if (functions) then
        -- Mutations replace the registry array; this dispatch retains its original order.
        -- Removals take effect immediately; additions start with the next (including nested) dispatch.
        for _, handler in ipairs(functions) do
            if handler.active then handler.callback(...) end
        end
    end
    if event == "ADDON_LOADED" then
        ---@type string | nil
        local addonName = ...
        if not addonName or addonName ~= MapPinEnhanced.name then return end
        if not onLoadCallbacks then return end
        for _, callback in ipairs(onLoadCallbacks) do
            callback()
        end
        addonWasLoaded = true
        onLoadCallbacks = nil
    end
end

local addonEventFrame = CreateFrame("Frame")
addonEventFrame:SetScript("OnEvent", EventFrameHandler)

---Register an event for a function to be called when the event is fired
---@param event WowEvent the event to register for
---@param func function the function to call when the event is fired
function MapPinEnhanced:RegisterEvent(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    ---@type MapPinEnhancedEventHandler[]
    local handlers = {}
    for _, handler in ipairs(registeredEvents[event] or {}) do
        handlers[#handlers + 1] = handler
    end
    handlers[#handlers + 1] = { callback = func, active = true }
    registeredEvents[event] = handlers
    addonEventFrame:RegisterEvent(event)
end

---@param events WowEvent[]
---@param callback fun(events: table<WowEvent, boolean>)
---@param throttleSeconds number?
---@param acceptEvent? fun(event: WowEvent, ...): boolean
---@return fun() unsubscribe
function MapPinEnhanced:RegisterEventBucket(events, callback, throttleSeconds, acceptEvent)
    assert(type(events) == "table", "MapPinEnhanced:RegisterEventBucket requires an event list")
    assert(type(callback) == "function", "MapPinEnhanced:RegisterEventBucket requires a callback")
    assert(throttleSeconds == nil or type(throttleSeconds) == "number" and throttleSeconds > 0,
        "MapPinEnhanced:RegisterEventBucket requires a positive throttleSeconds")

    assert(acceptEvent == nil or type(acceptEvent) == "function",
        "MapPinEnhanced:RegisterEventBucket requires an optional event predicate")

    ---@type WowEvent[]
    local ownedEvents = {}
    ---@type table<WowEvent, boolean>
    local seenEvents = {}
    for _, event in ipairs(events) do
        assert(type(event) == "string" and event ~= "",
            "MapPinEnhanced:RegisterEventBucket events must be non-empty strings")
        assert(not seenEvents[event], "MapPinEnhanced:RegisterEventBucket events must be unique")
        seenEvents[event] = true
        table.insert(ownedEvents, event)
    end
    assert(#ownedEvents > 0, "MapPinEnhanced:RegisterEventBucket requires at least one event")

    local isSubscribed = true
    local publicationNumber = 0
    ---@type { event: WowEvent, callback: function }[]
    local registrations = {}
    ---@type table<WowEvent, boolean>
    local pendingEvents = {}
    ---@type FunctionContainer?
    local publicationTimer

    local function Publish(expectedPublicationNumber)
        publicationTimer = nil
        if not isSubscribed or publicationNumber ~= expectedPublicationNumber then return end
        local publishedEvents = pendingEvents
        pendingEvents = {}
        callback(publishedEvents)
    end

    local function OnEvent(event, ...)
        if not isSubscribed or acceptEvent and not acceptEvent(event, ...) then return end
        pendingEvents[event] = true
        if publicationTimer then return end

        publicationNumber = publicationNumber + 1
        local expectedPublicationNumber = publicationNumber
        publicationTimer = C_Timer.NewTimer(throttleSeconds or 0, function()
            Publish(expectedPublicationNumber)
        end)
    end

    for _, event in ipairs(ownedEvents) do
        local eventName = event
        local eventCallback = function(...)
            OnEvent(eventName, ...)
        end
        table.insert(registrations, { event = eventName, callback = eventCallback })
        MapPinEnhanced:RegisterEvent(eventName, eventCallback)
    end

    return function()
        if not isSubscribed then return end
        isSubscribed = false
        publicationNumber = publicationNumber + 1
        pendingEvents = {}
        if publicationTimer then
            publicationTimer:Cancel()
            publicationTimer = nil
        end
        for _, registration in ipairs(registrations) do
            MapPinEnhanced:UnregisterEventForFunction(registration.event, registration.callback)
        end
    end
end

---Unregister an event for a given function
---@param event WowEvent the event to unregister for
---@param func function the function to unregister for
function MapPinEnhanced:UnregisterEventForFunction(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    local handlers = registeredEvents[event]
    if not handlers then return end
    ---@type MapPinEnhancedEventHandler[]
    local remaining = {}
    local removed = false
    for _, handler in ipairs(handlers) do
        if not removed and handler.callback == func then
            handler.active = false
            removed = true
        else
            remaining[#remaining + 1] = handler
        end
    end
    registeredEvents[event] = #remaining > 0 and remaining or nil
    if #remaining == 0 then addonEventFrame:UnregisterEvent(event) end
end

---Run a callback when Map Pin Enhanced is loaded
---@param callback fun()
function MapPinEnhanced:OnLoad(callback)
    -- If the addon is already loaded, call the callback immediately
    if addonWasLoaded then
        callback()
        return
    end
    if not onLoadCallbacks then
        onLoadCallbacks = {}
    end
    table.insert(onLoadCallbacks, callback)
end

---Unregister an event for the addon
---@param event WowEvent the event to unregister for
function MapPinEnhanced:UnregisterEvent(event)
    assert(event, "Event must be provided")
    for _, handler in ipairs(registeredEvents[event] or {}) do handler.active = false end
    registeredEvents[event] = nil
    addonEventFrame:UnregisterEvent(event)
end

---@enum (key) CallbackEvent
local CALLBACK_EVENTS = {
    PIN_UPDATED_TRACKING = { event = "PIN_UPDATED_TRACKING_%w+", pattern = true },
    PIN_UPDATED_DESCRIPTION = { event = "PIN_UPDATED_DESCRIPTION_%w+", pattern = true },
    PIN_UPDATED_TITLE = { event = "PIN_UPDATED_TITLE_%w+", pattern = true },
    PIN_UPDATED_ICON = { event = "PIN_UPDATED_ICON_%w+", pattern = true },
    PIN_UPDATED_COLOR = { event = "PIN_UPDATED_COLOR_%w+", pattern = true },
    PIN_UPDATED_LOCK = { event = "PIN_UPDATED_LOCK_%w+", pattern = true },
    PIN_ADDED = { event = "PIN_ADDED", pattern = false },
    PIN_REMOVED = { event = "PIN_REMOVED", pattern = false },
    PIN_REACHED = { event = "PIN_REACHED", pattern = false },
    PIN_TRACKING_CHANGED = { event = "PIN_TRACKING_CHANGED", pattern = false },
    NAVIGATION_DESTINATION_CHANGED = { event = "NAVIGATION_DESTINATION_CHANGED", pattern = false },
    GROUP_UPDATED = { event = "GROUP_UPDATED", pattern = false },
    GROUP_DELETED = { event = "GROUP_DELETED", pattern = false },
}

---@class CallbackTarget
---@field RegisterCallback fun(self: string, event: string, func: function, ...)
---@field UnregisterCallback fun(self: string, event: string)
---@field UnregisterAllCallbacks fun(self: string)
local callbackTarget = {}
---@class CallbackHandlerRegistryWithEvents : CallbackHandlerRegistry
---@field events table<string, table<CallbackTarget, function[]>>
---@field recurse number
---@field insertQueue table?
local callbackRegistry = CallbackHandler:New(callbackTarget, "RegisterCallback", "UnregisterCallback",
    "UnregisterAllCallbacks");

-- CallbackHandler must finish dispatch and queued registrations before keys disappear.
---@type table<string, boolean>
local unusedCallbacks = {}
local function ClearUnusedCallbacks()
    if callbackRegistry.recurse > 0 or callbackRegistry.insertQueue then return end
    for eventName in pairs(unusedCallbacks) do
        local callbacks = rawget(callbackRegistry.events, eventName)
        if callbacks and not next(callbacks) then
            callbackRegistry.events[eventName] = nil
        end
        unusedCallbacks[eventName] = nil
    end
end

local function IsValidCallbackEvent(event)
    if CALLBACK_EVENTS[event] then
        return true
    end
    for _, eventInfo in pairs(CALLBACK_EVENTS) do
        if eventInfo.pattern and event:match("^" .. eventInfo.event .. "$") then
            return true
        end
    end
    return false
end

---@param callbackEvent CallbackEvent
---@param key string|nil
---@return string
local function GetCallbackEventName(callbackEvent, key)
    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        return (string.gsub(eventInfo.event, "%%w%+", key))
    elseif eventInfo then
        return eventInfo.event
    end
    return callbackEvent
end

---@param callbackEvent CallbackEvent
---@param func function
---@param key string|nil
function MapPinEnhanced:RegisterCallback(callbackEvent, func, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    assert(type(func) == "function", "Function must be provided")

    local eventName = GetCallbackEventName(callbackEvent, key)
    callbackTarget.RegisterCallback(tostring(func), eventName, func)
end

---@param callbackEvent CallbackEvent
---@param func function
---@param key string|nil
function MapPinEnhanced:UnregisterCallback(callbackEvent, func, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    assert(type(func) == "function", "Function must be provided")

    local eventName = GetCallbackEventName(callbackEvent, key)
    callbackTarget.UnregisterCallback(tostring(func), eventName)
    unusedCallbacks[eventName] = true
    ClearUnusedCallbacks()
end

---@param key string
---@param callbacks table<CallbackEvent, function>
---@return fun() unsubscribe Call to unregister every callback in this set
function MapPinEnhanced:RegisterKeyedCallbacks(key, callbacks)
    assert(type(key) == "string", "MapPinEnhanced:RegisterKeyedCallbacks requires a string key")
    assert(type(callbacks) == "table", "MapPinEnhanced:RegisterKeyedCallbacks requires a callback table")

    ---@type { eventName: string, func: function }[]
    local registrations = {}
    for callbackEvent, func in pairs(callbacks) do
        -- Validate the complete set before changing the registry.
        assert(type(callbackEvent) == "string" and IsValidCallbackEvent(callbackEvent),
            "MapPinEnhanced:RegisterKeyedCallbacks: invalid callback event")
        assert(type(func) == "function", "MapPinEnhanced:RegisterKeyedCallbacks: callback must be a function")
        table.insert(registrations, {
            eventName = GetCallbackEventName(callbackEvent, key),
            func = func,
        })
    end

    for _, registration in ipairs(registrations) do
        callbackTarget.RegisterCallback(tostring(registration.func), registration.eventName, registration.func)
    end

    local isSubscribed = true
    return function()
        if not isSubscribed then return end
        isSubscribed = false
        for _, registration in ipairs(registrations) do
            callbackTarget.UnregisterCallback(tostring(registration.func), registration.eventName)
            unusedCallbacks[registration.eventName] = true
        end
        ClearUnusedCallbacks()
    end
end

---@param callbackEvent CallbackEvent
---@param key string|nil
function MapPinEnhanced:FireCallback(callbackEvent, key, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    local eventName = GetCallbackEventName(callbackEvent, key)
    callbackRegistry:Fire(eventName, ...)
    ClearUnusedCallbacks()
end

---Call a function with restricted access, ensuring it runs outside of combat.
---@param func function
---@param warning string|nil A warning message to display if the function is called while in combat
---@param ... unknown
function MapPinEnhanced:CallRestricted(func, warning, ...)
    local inCombat = InCombatLockdown()
    local args = { ... }
    if inCombat then
        if warning then
            self:Print(warning)
        end
        ---@type function
        local functionToRun
        functionToRun = function()
            self:UnregisterEventForFunction("PLAYER_REGEN_ENABLED", functionToRun)
            func(unpack(args))
        end
        self:RegisterEvent("PLAYER_REGEN_ENABLED", functionToRun)
    else
        func(...)
    end
end
