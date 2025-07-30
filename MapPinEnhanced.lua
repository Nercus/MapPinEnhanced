---@class MapPinEnhanced
---@field globalAPI table
local MapPinEnhanced = select(2, ...)

MapPinEnhanced.name = "MapPinEnhanced"
MapPinEnhanced.me = UnitName("player")
MapPinEnhanced.realm = GetRealmName()
MapPinEnhanced.player = MapPinEnhanced.me .. "-" .. MapPinEnhanced.realm

MapPinEnhanced.isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
MapPinEnhanced.isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC -- Note: Classic is not supported yet

MapPinEnhanced.HBD = LibStub:GetLibrary("HereBeDragons-2.0")
MapPinEnhanced.HBDP = LibStub:GetLibrary("HereBeDragons-Pins-2.0")
MapPinEnhanced.LDBIcon = LibStub:GetLibrary("LibDBIcon-1.0")
MapPinEnhanced.Chomp = LibStub:GetLibrary("Chomp")



---@type table<string, function>
local globalAPI = {}
---@type table
_G[MapPinEnhanced.name] = globalAPI
function MapPinEnhanced:RegisterGlobalAPI(name, func)
    assert(name, "MapPinEnhanced:RegisterGlobalAPI: name is nil")
    assert(type(name) == "string", "MapPinEnhanced:RegisterGlobalAPI: name must be a string")
    assert(func, "MapPinEnhanced:RegisterGlobalAPI: func is nil")
    assert(type(func) == "function", "MapPinEnhanced:RegisterGlobalAPI: func must be a function")

    if not globalAPI[name] then
        globalAPI[name] = func
    else
        error("MapPinEnhanced:RegisterGlobalAPI: API with name '" .. name .. "' already exists")
    end
end
