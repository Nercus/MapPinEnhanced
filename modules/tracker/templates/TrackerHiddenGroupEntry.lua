---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")

---@class TrackerHiddenGroupData
---@field groupID UUID
---@field label string
---@field icon string|number

---@class MapPinEnhancedTrackerHiddenGroupEntryTemplate : Button
---@field label FontString
---@field icon Texture
MapPinEnhancedTrackerHiddenGroupEntryMixin = {}

---@param data TrackerHiddenGroupData
---@param menu MapPinEnhancedTrackerHiddenGroupsTemplate
function MapPinEnhancedTrackerHiddenGroupEntryMixin:Init(data, menu)
    self.label:SetText(data.label)
    self.icon:SetTexture(data.icon)
    self:SetScript("OnClick", function()
        -- Resolve durable identity again: domain objects may have been released while open.
        local group = Groups:GetGroupByID(data.groupID)
        menu:Close()
        if group and group:IsHidden() and not group:IsProtected() then
            group:ShowGroup()
        end
    end)
end

function MapPinEnhancedTrackerHiddenGroupEntryMixin:Reset()
    self:SetScript("OnClick", nil)
    self.label:SetText("")
    self.icon:SetTexture(nil)
end
