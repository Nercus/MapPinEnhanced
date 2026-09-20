---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

---@class MapPinEnhancedTrackerHiddenGroupEntryTemplate : Button
---@field label FontString
---@field icon Texture

---@class TrackerHiddenGroupData
---@field groupID UUID
---@field label string
---@field icon string|number

---@class MapPinEnhancedTrackerHiddenGroupsTemplate : Frame
---@field title FontString
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar
---@field onOutsideClick function
---@field unsubscribe fun()?
MapPinEnhancedTrackerHiddenGroupsMixin = {}

function MapPinEnhancedTrackerHiddenGroupsMixin:OnLoad()
    local view = CreateScrollBoxListLinearView()
    view:SetElementExtent(26)
    view:SetElementInitializer("MapPinEnhancedTrackerHiddenGroupEntryTemplate", function(entry, data)
        ---@cast entry MapPinEnhancedTrackerHiddenGroupEntryTemplate
        ---@cast data TrackerHiddenGroupData
        entry.label:SetText(data.label)
        entry.icon:SetTexture(data.icon)
        entry:SetScript("OnClick", function()
            -- Resolve durable identity again: domain objects may have been released while open.
            local group = Groups:GetGroupByID(data.groupID)
            self:Hide()
            if group and group:IsHidden() and not group:IsProtected() then
                group:ShowGroup()
            end
        end)
    end)
    view:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedTrackerHiddenGroupEntryTemplate
        entry:SetScript("OnClick", nil)
        entry.label:SetText("")
        entry.icon:SetTexture(nil)
    end)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, view)
    self.scrollBar:SetHideIfUnscrollable(true)
    self.onOutsideClick = function()
        local header = self:GetParent()
        ---@cast header MapPinEnhancedTrackerHeaderTemplate
        if not self:IsMouseOver() and not header.hiddenGroupsButton:IsMouseOver() then
            self:Hide()
        end
    end
end

function MapPinEnhancedTrackerHiddenGroupsMixin:Refresh()
    ---@type MapPinEnhancedGroupMixin[]
    local groups = {}
    for group in Groups:EnumerateGroups() do
        if group:IsHidden() and not group:IsProtected() and group:GetTotalPinCount() > 0 then
            table.insert(groups, group)
        end
    end
    table.sort(groups, function(first, second) return Groups:IsGroupBefore(first, second) end)
    local dataProvider = CreateDataProvider()
    for _, group in ipairs(groups) do
        dataProvider:Insert({
            groupID = group:GetGroupID(),
            label = string.format("%s (%d)", group:GetName(), group:GetTotalPinCount()),
            icon = group:GetIcon(),
        })
    end
    self.title:SetText(#groups == 0 and L["No hidden groups"] or L["Show hidden group"])
    self:SetHeight(46 + math.min(#groups, 7) * 26)
    self.scrollBox:SetShown(#groups > 0)
    self.scrollBox:SetDataProvider(dataProvider)
end

function MapPinEnhancedTrackerHiddenGroupsMixin:OnShow()
    self:Refresh()
    MapPinEnhanced:RegisterEvent("GLOBAL_MOUSE_DOWN", self.onOutsideClick)
    self.unsubscribe = MapPinEnhanced:RegisterKeyedCallbacks("", {
        GROUP_UPDATED = function() self:Refresh() end,
        GROUP_DELETED = function() self:Refresh() end,
    })
end

function MapPinEnhancedTrackerHiddenGroupsMixin:OnHide()
    MapPinEnhanced:UnregisterEventForFunction("GLOBAL_MOUSE_DOWN", self.onOutsideClick)
    if self.unsubscribe then
        self.unsubscribe()
        self.unsubscribe = nil
    end
    self.scrollBox:SetDataProvider(CreateDataProvider())
end
