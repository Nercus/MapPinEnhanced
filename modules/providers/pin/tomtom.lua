---@diagnostic disable: no-unknown
---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class Providers
local Providers = MapPinEnhanced:GetModule("Providers")
local Groups = MapPinEnhanced:GetModule("Groups")

---@return MapPinEnhancedGroupMixin?
local function EnsureTomTomGroup()
    local group = Groups:GetGroupByName(L["TomTom Pins"])
    if group then return group end

    group = Groups:RegisterGroup({
        name = L["TomTom Pins"],
        source = MapPinEnhanced.name,
        icon = "Interface\\Icons\\INV_Misc_Map_01",
        order = GetTime()
    })
    return group
end

---@param mapID any
---@param x any
---@param y any
---@param info any
local function AddTomTomWaypoint(mapID, x, y, info)
    if not MapPinEnhanced:IsReadablePositiveInteger(mapID) or
        not MapPinEnhanced:IsCoordinate(x) or not MapPinEnhanced:IsCoordinate(y) then
        return
    end
    if not MapPinEnhanced:IsReadableTable(info) then info = {} end
    local title = info.title
    if MapPinEnhanced:IsSecretValue(title) or type(title) ~= "string" or title == "" then
        title = L["TomTom Waypoint"]
    end
    local texture = info.minimap_icon
    if MapPinEnhanced:IsSecretValue(texture) or
        not ((type(texture) == "string" and texture ~= "") or
            MapPinEnhanced:IsReadablePositiveInteger(texture)) then
        texture = "Interface\\Icons\\INV_Misc_Map_01"
    end

    -- Groups are deletable pooled objects; resolve ownership for every call.
    local group = EnsureTomTomGroup()
    if not group then return end
    group:AddPin({
        mapID = mapID,
        x = x,
        y = y,
        title = title,
        texture = texture,
        setTracked = true,
    })
end

local tomTomShim = {}

---@param mapID any
---@param x any
---@param y any
---@param info any
local function AddShimWaypoint(_, mapID, x, y, info)
    -- Saved shim references stop ingesting once another owner takes over.
    if TomTom ~= tomTomShim or C_AddOns.IsAddOnLoaded("TomTom") then return end
    AddTomTomWaypoint(mapID, x, y, info)
end

tomTomShim.AddWaypoint = AddShimWaypoint

---@type table<table, table<function, boolean>>
local hookedMethods = {}

-- Post-hooks leave TomTom's behavior and return values with its original owner.
local function HookTomTomAddWaypoint()
    if not C_AddOns.IsAddOnLoaded("TomTom") or not MapPinEnhanced:IsReadableTable(TomTom) then return end
    local method = TomTom.AddWaypoint
    if MapPinEnhanced:IsSecretValue(method) or type(method) ~= "function" or method == AddShimWaypoint then return end
    local methods = hookedMethods[TomTom]
    if not methods then
        methods = {}
        hookedMethods[TomTom] = methods
    end
    if methods[method] then return end
    hooksecurefunc(TomTom, "AddWaypoint", function(_, mapID, x, y, info)
        AddTomTomWaypoint(mapID, x, y, info)
    end)
    methods[method] = true
    methods[TomTom.AddWaypoint] = true
end

function Providers:CheckForTomTom()
    self.isTomTomLoaded = C_AddOns.IsAddOnLoaded("TomTom")
    MapPinEnhanced.isTomTomLoaded = self.isTomTomLoaded
    if not self.isTomTomLoaded then return end
    HookTomTomAddWaypoint()
    MapPinEnhanced:Print(L["TomTom Is Loaded! You may experience some unexpected behavior."])
end

MapPinEnhanced:RegisterEvent("ADDON_LOADED", function(addon)
    if addon == "TomTom" then
        MapPinEnhanced.isTomTomLoaded = true
        Providers.isTomTomLoaded = true
        HookTomTomAddWaypoint()
    end
end)


MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    Providers:CheckForTomTom()
    if not Providers.isTomTomLoaded and TomTom == nil then
        TomTom = tomTomShim
    end
end)
