---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.name = "MapPinEnhanced"

MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- Note: Classic is not supported yet

MapPinEnhanced.HBD = LibStub("HereBeDragons-2.0")
MapPinEnhanced.HBDP = LibStub("HereBeDragons-Pins-2.0")
MapPinEnhanced.LDBIcon = LibStub("LibDBIcon-1.0")
