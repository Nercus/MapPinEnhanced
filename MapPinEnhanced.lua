---@class MapPinEnhanced
---@field globalAPI table
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.name = "MapPinEnhanced"
MapPinEnhanced.displayName = "Map Pin Enhanced"
MapPinEnhanced.me = UnitName("player")
MapPinEnhanced.realm = GetRealmName()
MapPinEnhanced.player = MapPinEnhanced.me .. "-" .. MapPinEnhanced.realm

MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- Note: Classic is not supported yet

MapPinEnhanced.HBD = LibStub:GetLibrary("HereBeDragons-2.0")
MapPinEnhanced.HBDP = LibStub:GetLibrary("HereBeDragons-Pins-2.0")
MapPinEnhanced.LDBIcon = LibStub:GetLibrary("LibDBIcon-1.0")
MapPinEnhanced.Chomp = LibStub:GetLibrary("Chomp")


MapPinEnhanced.basePath = "Interface\\AddOns\\MapPinEnhanced"
MapPinEnhanced.assetsPath = MapPinEnhanced.basePath .. "\\assets"
