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
    if not self.onLoadCallbacks then
        self.onLoadCallbacks = {}
    end
    table.insert(self.onLoadCallbacks, callback)
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
    PIN_ADDED = { event = "PIN_ADDED", pattern = false },
    PIN_REMOVED = { event = "PIN_REMOVED", pattern = false },
    GROUP_UPDATED = { event = "GROUP_UPDATED", pattern = false },
}

---@class CallbackTarget
---@field RegisterCallback fun(self: MapPinEnhanced, event: string, func: function, ...)
---@field UnregisterCallback fun(self: MapPinEnhanced, event: string)
---@field UnregisterAllCallbacks fun(self: MapPinEnhanced, event: string)
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
function MapPinEnhanced:RegisterCallback(callbackEvent, func, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    assert(func, "Function must be provided")


    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        local eventName = string.gsub(eventInfo.event, "%%w%+", key)
        callbackTarget.RegisterCallback(self, eventName, func)
    elseif eventInfo then
        callbackTarget.RegisterCallback(self, eventInfo.event, func)
    else
        callbackTarget.RegisterCallback(self, callbackEvent, func)
    end
end

---@param callbackEvent CallbackEvent
function MapPinEnhanced:UnregisterCallback(callbackEvent, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")

    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        callbackTarget.UnregisterCallback(self, string.gsub(eventInfo.event, "%%w%+", key))
    elseif eventInfo then
        callbackTarget.UnregisterCallback(self, eventInfo.event)
    else
        callbackTarget.UnregisterCallback(self, callbackEvent)
    end
end

---@param callbackEvent CallbackEvent
function MapPinEnhanced:FireCallback(callbackEvent, key, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        local eventName = string.gsub(eventInfo.event, "%%w%+", key)
        callbackRegistry:Fire(eventName, ...)
    elseif eventInfo then
        callbackRegistry:Fire(eventInfo.event, ...)
    else
        callbackRegistry:Fire(callbackEvent, ...)
    end
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
        self:RegisterEvent("PLAYER_REGEN_ENABLED", function()
            self:UnregisterEvent("PLAYER_REGEN_ENABLED")
            func(unpack(args))
        end)
    else
        func(...)
    end
end
