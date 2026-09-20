---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

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

local function RefreshVignette()
    local vignetteGUID = C_SuperTrack.GetSuperTrackedVignette()
    local targetID = GetVignetteTargetID()
    local vignetteInfo = vignetteGUID and C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    local x, y, mapID = Providers:GetSuperTrackingWaypoint(vignetteGUID and function(candidateMapID)
        return GetVignettePositionForMap(vignetteGUID, candidateMapID)
    end or nil)
    if not vignetteGUID or not vignetteInfo or x == nil or y == nil or mapID == nil then
        Providers:HandleUnresolvedSuperTrackingTarget(SOURCE, targetID)
        return
    end
    Providers:SetSuperTrackingWayfinderData(SOURCE, targetID, {
        mapID = mapID,
        x = x,
        y = y,
        title = vignetteInfo.name,
        description = select(2, C_SuperTrack.GetSuperTrackedItemName()),
        texture = vignetteInfo.atlasName,
        usesAtlas = true,
    })
end

Providers:RegisterSuperTrackingProvider({
    source = SOURCE,
    superTrackingType = SUPER_TRACKING_TYPE,
    getTargetID = GetVignetteTargetID,
    refresh = RefreshVignette,
    captureTracking = function()
        local guid = C_SuperTrack.GetSuperTrackedVignette()
        if not guid then return nil end
        return function()
            if not C_VignetteInfo.GetVignetteInfo(guid) then return false end
            C_SuperTrack.SetSuperTrackedVignette(guid)
            return true
        end
    end,
    -- Retail exposes no vignette-specific clear operation.
    untrack = function() C_SuperTrack.ClearAllSuperTracked() end,
    events = { "VIGNETTES_UPDATED" },
})
