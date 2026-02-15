---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinStyleMixin = {}

---@param color PinColor?
function MapPinEnhancedPinStyleMixin:SetColor(color)
    self.worldmapPin:SetColor(color)
    self.minimapPin:SetColor(color)

    if self:IsTracked() then
        self.worldmapPin:SetTracked()
        self.minimapPin:SetTracked()
    else
        self.worldmapPin:SetUntracked()
        self.minimapPin:SetUntracked()
    end

    self.worldmapPin:SetIcon(nil, nil)
    self.minimapPin:SetIcon(nil, nil)

    self.pinData.color = color
    self.pinData.texture = nil
    self.pinData.usesAtlas = nil
    self:PersistPin()

    MapPinEnhanced:FireCallback("PIN_UPDATED_COLOR", self.pinID, color)
end

function MapPinEnhancedPinStyleMixin:HasColor(color)
    if not self.pinData.color then
        return false
    end

    return self.pinData.color == color
end

---@class PinIcon
---@field path string the path to the icon, if usesAtlas is true, this is the atlas name
---@field usesAtlas boolean if true, the path is an atlas, otherwise it is a file path
---@field offset {x: number, y: number}? optional offset for the icon, if not set, it will be
---@field scale number? optional scale for the icon, if not set, it will be 1

---@type PinIcon[] different icon that have some offsets and information about how to use them, icons outside this list can still be used but may look weird in some cases
Pins.PIN_ICONS = {
    ["delves-bountiful"] = {
        path = "delves-bountiful",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["delves-regular"] = {
        path = "delves-regular",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["Dungeon"] = {
        path = "Dungeon",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1.3
    },
    ["Raid"] = {
        path = "Raid",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1.3
    },
    ["VignetteKill-SuperTracked"] = {
        path = "VignetteKill-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["VignetteKill"] = {
        path = "VignetteKill",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["minimap-genericevent-hornicon-supertracked"] = {
        path = "minimap-genericevent-hornicon-supertracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["questbonusobjective-SuperTracked"] = {
        path = "questbonusobjective-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["vignettekillboss-SuperTracked"] = {
        path = "vignettekillboss-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["VignetteKillElite-SuperTracked"] = {
        path = "VignetteKillElite-SuperTracked",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["QuestNormal"] = {
        path = "QuestNormal",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["TaxiNode_Continent_Alliance"] = {
        path = "TaxiNode_Continent_Alliance",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["AllianceWarfrontMapBanner"] = {
        path = "AllianceWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
    ["HordeWarfrontMapBanner"] = {
        path = "HordeWarfrontMapBanner",
        usesAtlas = true,
        offset = { x = 0, y = 0 },
        scale = 1
    },
}


---@param icon PinIcon | string the icon to set, if usesAtlas is true, this is the atlas name, otherwise it is a file path
---@param usesAtlas boolean if true, the path is an atlas, otherwise it is a file path
---@param offset {x: number, y: number}? optional offset for the icon, if not set, it will be 0,0
---@param scale number? optional scale for the icon, if not set, it will be 1
function MapPinEnhancedPinStyleMixin:SetIcon(icon, usesAtlas, offset, scale)
    if Pins.PIN_ICONS[icon] then
        local pinConfig = Pins.PIN_ICONS[icon]
        usesAtlas = pinConfig.usesAtlas
        offset = pinConfig.offset
        scale = pinConfig.scale
    end

    if icon then
        self.pinData.texture = icon
        self.pinData.usesAtlas = usesAtlas
        self.pinData.color = nil
    else
        self.pinData.texture = nil
        self.pinData.usesAtlas = nil
        self.pinData.color = self.pinData.color
    end

    self.worldmapPin:SetIcon(icon, usesAtlas, offset, scale)
    self.minimapPin:SetIcon(icon, usesAtlas, offset, scale)
    MapPinEnhanced:FireCallback("PIN_UPDATED_ICON", self.pinID,
        { path = icon, usesAtlas = usesAtlas, offset = offset, scale = scale })
end
