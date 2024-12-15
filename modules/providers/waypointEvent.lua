---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class PinProvider
local PinProvider = MapPinEnhanced:GetModule("PinProvider")
local PinManager = MapPinEnhanced:GetModule("PinManager")

---@param uiMapPoint UiMapPoint
local function HandleSetUserWaypoint(uiMapPoint)
    if not uiMapPoint then return end
    local stack = debugstack(2) ---@type string
    if stack.find(stack, MapPinEnhanced.addonName) then return end -- ignore calls from this function
    local title, texture, usesAtlas = PinProvider:DetectMouseFocusPinInfo()
    local isSuperTrackingCorpse = C_SuperTrack.IsSuperTrackingCorpse()
    PinManager:AddPin({
        mapID = uiMapPoint.uiMapID,
        x = uiMapPoint.position.x,
        y = uiMapPoint.position.y,
        title = title,
        texture = texture,
        usesAtlas = usesAtlas,
        setTracked = not isSuperTrackingCorpse
    })
end

hooksecurefunc(C_Map, "SetUserWaypoint", HandleSetUserWaypoint)
