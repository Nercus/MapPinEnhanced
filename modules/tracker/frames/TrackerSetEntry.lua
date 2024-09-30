---@class MapPinEnhancedTrackerSetEntry : Button
---@field highlight Texture
---@field left Texture
---@field right Texture
---@field icon Texture
---@field title FontString
---@field tooltip string?
MapPinEnhancedTrackerSetEntry = {}

function MapPinEnhancedTrackerSetEntry:SetEntryIndex() end -- not used right now

function MapPinEnhancedTrackerSetEntry:SetTitle(title)
    self.title:SetText(title)
end

function MapPinEnhancedTrackerSetEntry:SetActive()
    self.highlight:Show()
    self.isActive = true
end

function MapPinEnhancedTrackerSetEntry:SetInactive()
    self.highlight:Hide()
    self.highlight:SetAlpha(1)
    self.isActive = false
end

function MapPinEnhancedTrackerSetEntry:ShowTooltip()
    if not self.tooltip then return end
    ---@type string
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    GameTooltip:SetText(self.tooltip)
    GameTooltip:Show()
end

function MapPinEnhancedTrackerSetEntry:OnEnter()
    self.highlight:Show()
    self:ShowTooltip()
end

function MapPinEnhancedTrackerSetEntry:OnLeave()
    GameTooltip:Hide()
    if self.isActive then return end
    self.highlight:Hide()
end
