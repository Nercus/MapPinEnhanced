---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

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
