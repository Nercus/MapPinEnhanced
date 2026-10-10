---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Wayfinders = MapPinEnhanced:GetModule("Wayfinders")

local Providers = MapPinEnhanced:GetModule("Providers")
local SOURCE = "vignette"
local SUPER_TRACKING_TYPE = Enum.SuperTrackingType.Vignette

---@return string
local function GetVignetteTargetID()
    return string.format("vignette:%s", tostring(C_SuperTrack.GetSuperTrackedVignette()))
end

---@param vignetteGUID WOWGUID
---@param mapID number
---@return number? x
---@return number? y
local function GetVignettePositionForMap(vignetteGUID, mapID)
    local position = C_VignetteInfo.GetVignettePosition(vignetteGUID, mapID)
    if not position then return end
    return position.x, position.y
end

---@return WayfinderData?
---@return boolean? removable
---@return boolean? textAvailable
local function ReadVignette()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local vignetteInfo = vignetteGUID and C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(vignetteGUID and function(candidateMapID)
        return GetVignettePositionForMap(vignetteGUID, candidateMapID)
    end or nil)
    if not vignetteGUID or not vignetteInfo or x == nil or y == nil or mapID == nil then
        return
    end
    return {
        mapID = mapID,
        x = x,
        y = y,
        title = vignetteInfo.name,
        description = select(2, C_SuperTrack.GetSuperTrackedItemName()),
        texture = vignetteInfo.atlasName,
        usesAtlas = true,
    }
end

Wayfinders:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetVignetteTargetID,
    read = ReadVignette,
    events = { "VIGNETTES_UPDATED" },
})
