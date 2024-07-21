---@meta

--- MapPinEnhanced specific CallbackHandler annotation

---@alias CallbackEvent 'UpdateSetList'


---@class MPHCallbackHandler
local CallbackHandler = {}

---Register a callback on the given object.
---@param event CallbackEvent
---@param method function
---@param arg any
function CallbackHandler:RegisterCallback(event, method, arg) end

---Unregister a callback on the given object.
---@param event CallbackEvent
function CallbackHandler:UnregisterCallback(event) end

---Unregister all callbacks on the given object.
function CallbackHandler:UnregisterAllCallbacks() end

---@class MPHCallbackHandlerRegistry
---@field OnUnused? fun(registry: CallbackHandlerRegistry, target: table, eventName: CallbackEvent) If defined, called when an event stops.
---@field OnUsed? fun(registry: CallbackHandlerRegistry, target: table, eventName: CallbackEvent) If defined, called when an event starts.
local MPHCallbackHandlerRegistry = {}

---fires the given event/message into the registry
---@param eventname CallbackEvent
---@param ... unknown passed to the functions listening to the event.
function MPHCallbackHandlerRegistry:Fire(eventname, ...) end
