---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local helperEnabled = true

---@param enabled boolean
function MapPinEnhanced:SetTooltipHelperEnabled(enabled)
    helperEnabled = enabled
end

---Feature owners supply available actions; this renderer owns only their presentation.
---@param tooltip GameTooltip
---@param interactions table<integer, table<integer, string|nil>>
function MapPinEnhanced:AddTooltipInteractions(tooltip, interactions)
    if not helperEnabled then return end
    local first = true
    for _, interaction in ipairs(interactions) do
        if interaction[2] then
            if first and tooltip:NumLines() > 0 then tooltip:AddLine(" ") end
            first = false
            tooltip:AddLine("|cffffd100" .. interaction[1] .. "|r  " .. interaction[2], 1, 1, 1, true)
        end
    end
end

---@class MapPinEnhancedTooltipMixin : Frame
---@field tooltip string?
---@field tooltipAnchor string?
---@field tooltipInitialized boolean?
---@field tooltipInteractions table<integer, table<integer, string|nil>>?
MapPinEnhancedTooltipMixin = {}

function MapPinEnhancedTooltipMixin:OnTooltipLoad()
    if self.tooltipInitialized or (not self.tooltip and not self.tooltipInteractions) then return end
    self.tooltipInitialized = true
    self:HookScript("OnEnter", self.OnTooltipEnter)
    self:HookScript("OnLeave", self.OnTooltipLeave)
    self:HookScript("OnHide", self.OnTooltipLeave)
end

function MapPinEnhancedTooltipMixin:OnTooltipEnter()
    GameTooltip:SetOwner(self, self.tooltipAnchor or "ANCHOR_RIGHT")
    if self.tooltip and self.tooltip ~= "" then
        GameTooltip:SetText(rawget(L, self.tooltip) or self.tooltip, 1, 1, 1, 1, true)
    end
    if self.tooltipInteractions then MapPinEnhanced:AddTooltipInteractions(GameTooltip, self.tooltipInteractions) end
    if GameTooltip:NumLines() > 0 then GameTooltip:Show() else GameTooltip:Hide() end
end

function MapPinEnhancedTooltipMixin:OnTooltipLeave()
    if GameTooltip:GetOwner() == self then GameTooltip:Hide() end
end

---@param tooltip string?
function MapPinEnhancedTooltipMixin:SetTooltip(tooltip)
    self.tooltip = tooltip
    if tooltip then
        self:OnTooltipLoad()
    elseif GameTooltip:GetOwner() == self then
        GameTooltip:Hide()
    end
end
