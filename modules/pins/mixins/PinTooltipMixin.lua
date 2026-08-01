---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedPinMixin
MapPinEnhancedPinTooltipMixin = {}

local L = MapPinEnhanced.L

---@param tooltipInfo? PinTooltip
function MapPinEnhancedPinTooltipMixin:SetTooltip(tooltipInfo)
    self.pinData.tooltip = tooltipInfo
    self.worldmapPin:UpdateTooltip(tooltipInfo)
    self.minimapPin:UpdateTooltip(tooltipInfo)
    self:PersistPin()
end

---@param owner Frame
---@param anchor? string
function MapPinEnhancedPinTooltipMixin:ShowTooltip(owner, anchor)
    local pinData = self.pinData
    if not pinData then return end

    local tooltipInfo = pinData.tooltip or {}
    GameTooltip:SetOwner(owner, anchor or "ANCHOR_TOPLEFT", 20)
    GameTooltip:AddLine(tooltipInfo.title or pinData.title or L["Map Pin"], 1, 0.82, 0)

    local mapInfo = C_Map.GetMapInfo(pinData.mapID)
    local mapName = mapInfo and mapInfo.name or tostring(pinData.mapID)
    local coordinates = string.format("%.2f, %.2f", pinData.x * 100, pinData.y * 100)
    local group = self.group
    local groupName = group and group:GetName() or L["Ungrouped Pins"]
    local reached = group and group:GetReachedPinCount() or 0
    local total = group and group:GetTotalPinCount() or 1

    if tooltipInfo.text and tooltipInfo.text ~= "" then
        GameTooltip:AddLine(tooltipInfo.text, 0.85, 0.85, 0.85, true)
    end
    GameTooltip:AddLine(string.format("%s %s", mapName, coordinates), 1, 1, 1)
    GameTooltip:AddLine(" ")
    GameTooltip:AddLine(string.format("%s: %d/%d", groupName, reached, total), 0.65, 0.65, 0.65)
    GameTooltip:Show()
end
