---@type string
local AddOnName = ...

---@class MapPinEnhanced : MPHCallbackHandler
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.version = C_AddOns.GetAddOnMetadata("MapPinEnhanced", "Version")
MapPinEnhanced.addonName = AddOnName

MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- Note: Classic is not supported yet

MapPinEnhanced.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")

MapPinEnhanced.HBD = LibStub("HereBeDragons-2.0")
MapPinEnhanced.HBDP = LibStub("HereBeDragons-Pins-2.0")
---@type MPHCallbackHandlerRegistry
MapPinEnhanced.CB = MapPinEnhanced.CB or LibStub("CallbackHandler-1.0"):New(MapPinEnhanced)
