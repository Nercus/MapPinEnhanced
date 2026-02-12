---@class MapPinEnhanced
---@field registeredEvents table<WowEvent, function[]>
---@field onLoadCallbacks function[]
local MapPinEnhanced = select(2, ...)

---@type CallbackHandler-1.0
local CallbackHandler = LibStub:GetLibrary("CallbackHandler-1.0");


local addonWasLoaded = false
local function EventFrameHandler(self, event, ...)
    local funcs = MapPinEnhanced.registeredEvents[event]
    if (funcs) then
        for _, func in ipairs(funcs) do
            func(...)
        end
    end
    if event == "ADDON_LOADED" then
        ---@type string | nil
        local addonName = ...
        if not addonName or addonName ~= MapPinEnhanced.name then return end
        if not MapPinEnhanced.onLoadCallbacks then return end
        for _, callback in ipairs(MapPinEnhanced.onLoadCallbacks) do
            callback()
        end
        addonWasLoaded = true
        MapPinEnhanced.onLoadCallbacks = nil
    end
end


---Register an event for a function to be called when the event is fired
---@param event WowEvent the event to register for
---@param func function the function to call when the event is fired
function MapPinEnhanced:RegisterEvent(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    if not self.registeredEvents[event] then
        self.registeredEvents[event] = {}
    end
    table.insert(self.registeredEvents[event], func)
    if (not self.addonEventFrame) then
        self.addonEventFrame = CreateFrame("Frame")
        self.addonEventFrame:SetScript("OnEvent", EventFrameHandler)
    end
    self.addonEventFrame:RegisterEvent(event)
end

---Unregister an event for a given function
---@param event WowEvent the event to unregister for
---@param func function the function to unregister for
function MapPinEnhanced:UnregisterEventForFunction(event, func)
    assert(event, "Event must be provided")
    assert(func, "Function must be provided")
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    if not self.registeredEvents[event] then
        self.registeredEvents[event] = {}
    end
    if self.registeredEvents[event] then
        for i, f in ipairs(self.registeredEvents[event]) do
            if f == func then
                table.remove(self.registeredEvents[event], i)
                break
            end
        end
    end
    if #self.registeredEvents[event] == 0 then
        self.registeredEvents[event] = nil
        self.addonEventFrame:UnregisterEvent(event)
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
    if not self.registeredEvents then
        self.registeredEvents = {}
    end
    self.registeredEvents[event] = nil
    self.addonEventFrame:UnregisterEvent(event)
end

---@enum (key) CallbackEvent
local CALLBACK_EVENTS = {
    PIN_UPDATED = { event = "PIN_UPDATED_%w+", pattern = true },
    SET_UPDATED = { event = "SET_UPDATED_%w+", pattern = true },
    GROUP_UPDATED = { event = "GROUP_UPDATED_%w+", pattern = true },
}

---@class CallbackTarget
---@field RegisterCallback fun(self: CallbackTarget, event: string, func: function, ...)
---@field UnregisterCallback fun(self: CallbackTarget, event: string)
---@field UnregisterAllCallbacks fun(self: CallbackTarget, event: string)
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
---@param func function
---@param key string? if the event is a pattern, the key to replace in the pattern
function MapPinEnhanced:RegisterCallback(callbackEvent, func, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    assert(func, "Function must be provided")

    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        local eventName = string.gsub(eventInfo.event, "%%w%+", key)
        callbackTarget:RegisterCallback(eventName, func)
    elseif eventInfo then
        callbackTarget:RegisterCallback(eventInfo.event, func)
    else
        callbackTarget:RegisterCallback(callbackEvent, func)
    end
end

---@param callbackEvent CallbackEvent
---@param key string? if the event is a pattern, the key to replace in the pattern
function MapPinEnhanced:UnregisterCallback(callbackEvent, key)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")

    local eventInfo = CALLBACK_EVENTS[callbackEvent]
    if eventInfo and eventInfo.pattern and key then
        callbackTarget:UnregisterCallback(string.gsub(eventInfo.event, "%%w%+", key))
    elseif eventInfo then
        callbackTarget:UnregisterCallback(eventInfo.event)
    else
        callbackTarget:UnregisterCallback(callbackEvent)
    end
end

---@param callbackEvent CallbackEvent
---@param key string? if the event is a pattern, the key to replace in the pattern
---@param ... any
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
