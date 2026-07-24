---@diagnostic disable: incomplete-signature-doc
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@type CallbackHandler-1.0
local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0");


---@type table<WowEvent, function[]>
local registeredEvents = {}

---@type function[] | nil
local onLoadCallbacks = {}

local addonWasLoaded = false
local function EventFrameHandler(self, event, ...)
    local functions = registeredEvents[event]
    if (functions) then
        for _, func in ipairs(functions) do
            func(...)
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
    if not registeredEvents then
        registeredEvents = {}
    end
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end
    table.insert(registeredEvents[event], func)
    addonEventFrame:RegisterEvent(event)
end

---Unregister an event for a given function
---@param event WowEvent the event to unregister for
---@param func function the function to unregister for
function MapPinEnhanced:UnregisterEventForFunction(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    if not registeredEvents then
        registeredEvents = {}
    end
    if not registeredEvents[event] then
        registeredEvents[event] = {}
    end
    if registeredEvents[event] then
        for i, f in ipairs(registeredEvents[event]) do
            if f == func then
                table.remove(registeredEvents[event], i)
                break
            end
        end
    end
    if #registeredEvents[event] == 0 then
        registeredEvents[event] = nil
        addonEventFrame:UnregisterEvent(event)
    end
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
    if not registeredEvents then
        registeredEvents = {}
    end
    registeredEvents[event] = nil
    addonEventFrame:UnregisterEvent(event)
end

---@enum (key) CallbackEvent
local CALLBACK_EVENTS = {
    PIN_UPDATED_TRACKING = { event = "PIN_UPDATED_TRACKING_%w+", pattern = true },
    PIN_UPDATED_TITLE = { event = "PIN_UPDATED_TITLE_%w+", pattern = true },
    PIN_UPDATED_ICON = { event = "PIN_UPDATED_ICON_%w+", pattern = true },
    PIN_UPDATED_COLOR = { event = "PIN_UPDATED_COLOR_%w+", pattern = true },
    PIN_UPDATED_LOCK = { event = "PIN_UPDATED_LOCK_%w+", pattern = true },
    PIN_ADDED = { event = "PIN_ADDED", pattern = false },
    PIN_REMOVED = { event = "PIN_REMOVED", pattern = false },
    PIN_REACHED = { event = "PIN_REACHED", pattern = false },
    PIN_TRACKING_CHANGED = { event = "PIN_TRACKING_CHANGED", pattern = false },
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
local callbackRegistry = CallbackHandler:New(callbackTarget, "RegisterCallback", "UnregisterCallback",
    "UnregisterAllCallbacks");

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
end

---@param callbackEvent CallbackEvent
---@param key string|nil
function MapPinEnhanced:FireCallback(callbackEvent, key, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    local eventName = GetCallbackEventName(callbackEvent, key)
    callbackRegistry:Fire(eventName, ...)
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
            func(unpack(args))
            self:UnregisterEventForFunction("PLAYER_REGEN_ENABLED", functionToRun)
        end
        self:RegisterEvent("PLAYER_REGEN_ENABLED", functionToRun)
    else
        func(...)
    end
end
