---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTooltipMixin = {}

local L = MapPinEnhanced.L

---@param description string?
function MapPinEnhancedPinTooltipMixin:SetDescription(description)
    description = MapPinEnhanced:NormalizeText(description)
    if self.pinData.description == description then return end
    self.pinData.description = description
    self:PersistPin()
    for _, frame in ipairs({ self.worldmapPin, self.minimapPin }) do
        if GameTooltip:IsOwned(frame) then self:ShowTooltip(frame) end
    end
    if not self.groupIsAddingPin then
        MapPinEnhanced:FireCallback("PIN_UPDATED_DESCRIPTION", self.pinID, description)
    end
end

---@param owner Frame
---@param anchor? string
function MapPinEnhancedPinTooltipMixin:ShowTooltip(owner, anchor)
    local pinData = self.pinData
    if not pinData then return end

    GameTooltip:SetOwner(owner, anchor or "ANCHOR_TOPLEFT", 20)
    GameTooltip:AddLine(pinData.title or L["Map Pin"], 1, 0.82, 0, true)

    local mapInfo = C_Map.GetMapInfo(pinData.mapID)
    local mapName = mapInfo and mapInfo.name or tostring(pinData.mapID)
    local coordinates = string.format("%.2f, %.2f", pinData.x * 100, pinData.y * 100)
    local group = self.group
    local groupName = group and group:GetName() or L["Ungrouped Pins"]
    local reached = group and group:GetReachedPinCount() or 0
    local total = group and group:GetTotalPinCount() or 1

    MapPinEnhanced:AddDescriptionToTooltip(pinData.description)
    GameTooltip:AddLine(string.format("%s %s", mapName, coordinates), 1, 1, 1, true)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("%s: %d/%d", groupName, reached, total), 0.65, 0.65, 0.65, true)
    GameTooltip:Show()
end
