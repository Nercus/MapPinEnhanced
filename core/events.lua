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
    PIN_UPDATED = "PIN_UPDATED_%w+",
    SET_UPDATED = "SET_UPDATED_%w+",
    GROUP_UPDATED = "GROUP_UPDATED_%w+",
}

---@class CallbackTarget
---@field RegisterCallback fun(self: CallbackTarget, event: string, func: function, ...)
---@field UnregisterCallback fun(self: CallbackTarget, event: string)
---@field UnregisterAllCallbacks fun(self: CallbackTarget, event: string)
local callbackTarget = {}
---@class CallbackHandlerRegistry2 : CallbackHandlerRegistry
---@field events table<CallbackEvent, table<CallbackTarget, function[]>>
local callbackRegistry = CallbackHandler:New(callbackTarget, "RegisterCallback", "UnregisterCallback",
    "UnregisterAllCallbacks");


local function IsValidCallbackEvent(event)
    if CALLBACK_EVENTS[event] then
        return true
    end
    for _, pattern in pairs(CALLBACK_EVENTS) do
        if type(pattern) == "string" and event:match("^" .. pattern .. "$") then
            return true
        end
    end
    return false
end


---@param callbackEvent CallbackEvent
---@param func function
---@param ... any
function MapPinEnhanced:RegisterCallback(callbackEvent, func, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    assert(func, "Function must be provided")

    callbackTarget:RegisterCallback(callbackEvent, func, ...)
end

---@param callbackEvent CallbackEvent
function MapPinEnhanced:UnregisterCallback(callbackEvent)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")

    callbackTarget:UnregisterCallback(callbackEvent)
end

---@param callbackEvent CallbackEvent
---@param ... any
function MapPinEnhanced:FireCallback(callbackEvent, ...)
    assert(callbackEvent, "Callback event must be provided")
    assert(IsValidCallbackEvent(callbackEvent), "Callback event is not valid")
    callbackRegistry:Fire(callbackEvent, ...)
end

---Unregister all callbacks matching a pattern
---@param pattern string Lua pattern to match event names
function MapPinEnhanced:UnregisterCallbacksByPattern(pattern)
    assert(pattern, "Pattern must be provided")

    -- Access CallbackHandler's event registry
    if not callbackRegistry.events then return end

    for eventName, _ in pairs(callbackRegistry.events) do
        if string.match(pattern, eventName) then
            self:UnregisterCallback(eventName)
        end
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
