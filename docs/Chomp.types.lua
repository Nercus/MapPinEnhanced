---@meta

---@class Chomp
local Chomp = {}

---@param prefix string
---@param text string
---@param kind? string
---@param target? string|number
---@param priority? "HIGH"|"MEDIUM"|"LOW"
---@param queue? string
---@param callback? fun(arg: any)
---@param callbackArg? any
function Chomp.SendAddonMessage(prefix, text, kind, target, priority, queue, callback, callbackArg) end

---@param prefix string
---@param text string
---@param kind? string
---@param target? string|number
---@param priority? "HIGH"|"MEDIUM"|"LOW"
---@param queue? string
---@param callback? fun(arg: any)
---@param callbackArg? any
function Chomp.SendAddonMessageLogged(prefix, text, kind, target, priority, queue, callback, callbackArg) end

---@param text string
---@param kind? string
---@param language? string|number
---@param target? string|number
---@param priority? "HIGH"|"MEDIUM"|"LOW"
---@param queue? string
---@param callback? fun(arg: any)
---@param callbackArg? any
function Chomp.SendChatMessage(text, kind, language, target, priority, queue, callback, callbackArg) end

---@param bnetIDGameAccount number
---@param prefix string
---@param text string
---@param priority? "HIGH"|"MEDIUM"|"LOW"
---@param queue? string
---@param callback? fun(arg: any)
---@param callbackArg? any
function Chomp.BNSendGameData(bnetIDGameAccount, prefix, text, priority, queue, callback, callbackArg) end

---@return boolean
function Chomp.IsSending() end

---@param prefix string
---@param callback fun(...)
---@param prefixSettings? table
function Chomp.RegisterAddonPrefix(prefix, callback, prefixSettings) end

---@param prefix string
---@return boolean
function Chomp.IsAddonPrefixRegistered(prefix) end

---@param prefix string
---@param data any
---@param kind string
---@param target? string|number
---@param messageOptions? table
---@return "BATTLENET"|"LOGGED"|"UNLOGGED"
function Chomp.SmartAddonMessage(prefix, data, kind, target, messageOptions) end

---@param prefix string
---@param guid string
---@return boolean
function Chomp.CheckReportGUID(prefix, guid) end

---@param prefix string
---@param guid string
---@param customMessage? string
---@return boolean, string
function Chomp.ReportGUID(prefix, guid, customMessage) end

---@param event string
---@param func fun(owner: any, ...)
---@param owner string|table|thread
function Chomp.RegisterCallback(event, func, owner) end

---@param event string
---@param owner string|table|thread
function Chomp.UnregisterCallback(event, owner) end

---@param owner string|table|thread
function Chomp.UnregisterAllCallbacks(owner) end

---@param callback fun(...)
---@return boolean
function Chomp.RegisterErrorCallback(callback) end

---@param callback fun(...)
---@return boolean
function Chomp.UnregisterErrorCallback(callback) end

---@param callback fun(...)
function Chomp.UnegisterErrorCallback(callback) end

---@return number, number
function Chomp.GetBPS() end

---@param bps number
---@param burst number
function Chomp.SetBPS(bps, burst) end

---@return string
function Chomp.GetVersion() end

return Chomp
