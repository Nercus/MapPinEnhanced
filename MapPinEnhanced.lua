---@type string
local AddOnName = ...

---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.version = C_AddOns.GetAddOnMetadata("MapPinEnhanced", "Version")
MapPinEnhanced.addonName = AddOnName
MapPinEnhanced.isWrath = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC
MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC
MapPinEnhanced.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")


local HereBeDragons = LibStub("HereBeDragons-2.0")
local HereBeDragonsPins = LibStub("HereBeDragons-Pins-2.0")

MapPinEnhanced.HBD = HereBeDragons
MapPinEnhanced.HBDP = HereBeDragonsPins
---@type CallbackHandlerRegistry
MapPinEnhanced.callbacks = MapPinEnhanced.callbacks or LibStub("CallbackHandler-1.0"):New(MapPinEnhanced)
