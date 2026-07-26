---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerGroupEntryTemplate : Button
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedGroupMixin
---@field expandIcon Texture
---@field title FontString
---@field icon Texture
---@field line Texture
MapPinEnhancedTrackerGroupEntryMixin = {}
local Transfer = MapPinEnhanced:GetModule("Transfer")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L

local TITLE_LEFT_OFFSET = 43
local TITLE_LINE_GAP = 5
local RIGHT_PADDING = 5
local MIN_LINE_WIDTH = 20

function MapPinEnhancedTrackerGroupEntryMixin:IsFullyReached()
    return self.group and not self.group:IsHidden() and self.group:GetTotalPinCount() > 0 and
        self.group:GetPinCount() == 0
end

function MapPinEnhancedTrackerGroupEntryMixin:CanExpandGroup()
    return self.group and not self.group:IsHidden() and self.group:GetPinCount() > 0
end

function MapPinEnhancedTrackerGroupEntryMixin:UpdateExpandIcon()
    if not self:CanExpandGroup() then
        self.expandIcon:Hide()
        return
    end

    self.expandIcon:Show()
    if self.treeNode:IsCollapsed() then
        self.expandIcon:SetAtlas("common-icon-plus")
    else
        self.expandIcon:SetAtlas("common-icon-minus")
    end
end

function MapPinEnhancedTrackerGroupEntryMixin:SetIcon(texturePath)
    self.icon:SetTexture(texturePath)
end

function MapPinEnhancedTrackerGroupEntryMixin:UpdateTitleWidth()
    local availableWidth = self:GetWidth() - TITLE_LEFT_OFFSET - TITLE_LINE_GAP - RIGHT_PADDING - MIN_LINE_WIDTH
    if availableWidth <= 0 then return end

    self.title:SetWidth(math.min(self.title:GetStringWidth(), availableWidth))
end

function MapPinEnhancedTrackerGroupEntryMixin:Reset()
    self.expandIcon:Hide()
    self.title:SetText("")
    self.title:SetWidth(0)
end

---@param treeNode TreeNodeMixin
function MapPinEnhancedTrackerGroupEntryMixin:Init(treeNode)
    ---@class MapPinEnhancedGroupMixin
    local group = treeNode:GetData()
    self.group = group
    self.treeNode = treeNode
    self:UpdateTitle()
    self:SetIcon(group:GetIcon())
    self:UpdateExpandIcon()
end

function MapPinEnhancedTrackerGroupEntryMixin:UpdateTitle()
    local group = self.group
    if not group then return end

    local title = group:GetName()
    local totalPins = group:GetTotalPinCount()
    if group:IsHidden() then
        self.title:SetText(string.upper(string.format("%s (%d)", title, totalPins)))
        self:UpdateTitleWidth()
        return
    end

    local reachedPins = group:GetReachedPinCount()
    self.title:SetText(string.upper(string.format("%s (%d/%d)", title, reachedPins, totalPins)))
    self:UpdateTitleWidth()
end

function MapPinEnhancedTrackerGroupEntryMixin:ConfirmDeleteGroup()
    Dialogs:ShowConfirmDialog(L["Delete Group"],
        string.format(L["Delete group \"%s\" and all of its pins?"], self.group:GetName()), function()
            Groups:DeleteGroup(self.group)
        end)
end

function MapPinEnhancedTrackerGroupEntryMixin:ConfirmClearGroup()
    Dialogs:ShowConfirmDialog(L["Clear Group"], string.format(L["Clear all pins from \"%s\"?"], self.group:GetName()),
        function()
            self.group:ClearGroup()
        end)
end

function MapPinEnhancedTrackerGroupEntryMixin:CanRenameGroup()
    return not self.group:IsProtected() or self.group.groupType == "ungrouped"
end

function MapPinEnhancedTrackerGroupEntryMixin:AddDeleteOrClearMenuAction(menu)
    if self.group:IsProtected() then
        table.insert(menu, {
            type = "button",
            label = L["Clear Group"],
            onClick = function() self:ConfirmClearGroup() end,
        })
    else
        table.insert(menu, {
            type = "button",
            label = L["Delete Group"],
            onClick = function() self:ConfirmDeleteGroup() end,
        })
    end
end

function MapPinEnhancedTrackerGroupEntryMixin:AddRenameMenuHeader(menu)
    if not self:CanRenameGroup() then return end

    local group = self.group
    table.insert(menu, {
        type = "template",
        template = "MapPinEnhancedMenuTitleActionTemplate",
        data = {
            label = group:GetName(),
            icon = "edit",
            onClick = function()
                Dialogs:ShowRenameGroupDialog(group)
            end,
        },
    })
    table.insert(menu, {
        type = "divider",
    })
end

function MapPinEnhancedTrackerGroupEntryMixin:AddTrackingModeMenu(menu)
    local group = self.group
    if group:IsHidden() or group:IsProtected() then return end

    local entries = {}
    for _, option in ipairs(Groups.TRACKING_MODE_OPTIONS) do
        local mode = option.value
        local label = option.label
        table.insert(entries, {
            type = "radio",
            label = label,
            isSelected = function()
                return group:GetTrackingMode() == mode
            end,
            setSelected = function()
                group:SetTrackingMode(mode)
            end,
            data = mode,
        })
    end

    table.insert(menu, {
        type = "submenu",
        entry = {
            type = "button",
            label = L["Tracking Mode"],
        },
        entries = entries,
    })
end

function MapPinEnhancedTrackerGroupEntryMixin:BuildFullyReachedMenu()
    local menu = {}
    local group = self.group

    table.insert(menu, {
        type = "button",
        label = L["Show Reached Pins Again"],
        onClick = function() group:RestoreReachedPins() end,
    })

    if not group:IsProtected() then
        table.insert(menu, {
            type = "button",
            label = L["Hide Group"],
            onClick = function() group:HideGroup() end,
        })
    end

    table.insert(menu, {
        type = "divider",
    })

    self:AddDeleteOrClearMenuAction(menu)

    return menu
end

function MapPinEnhancedTrackerGroupEntryMixin:BuildMenu()
    local group = self.group
    local menu = {}

    if group:IsHidden() then
        self:AddRenameMenuHeader(menu)
        table.insert(menu, {
            type = "button",
            label = L["Show Group"],
            onClick = function() group:ShowGroup() end,
        })
        table.insert(menu, {
            type = "button",
            label = L["Delete Group"],
            onClick = function() self:ConfirmDeleteGroup() end,
        })
        return menu
    end

    if self:IsFullyReached() then
        return self:BuildFullyReachedMenu()
    end

    self:AddRenameMenuHeader(menu)
    self:AddTrackingModeMenu(menu)

    if group:GetReachedPinCount() > 0 then
        table.insert(menu, {
            type = "button",
            label = L["Show Reached Pins Again"],
            onClick = function() group:RestoreReachedPins() end,
        })
    end

    if not group:IsProtected() then
        table.insert(menu, {
            type = "button",
            label = L["Hide Group"],
            onClick = function() group:HideGroup() end,
        })
    end

    table.insert(menu, {
        type = "button",
        label = MapPinEnhanced.L["Export"],
        onClick = function() Transfer:ShowExportWindow(group) end,
    })


    self:AddDeleteOrClearMenuAction(menu)

    return menu
end

function MapPinEnhancedTrackerGroupEntryMixin:OnMouseDown(button)
    assert(self.treeNode, "TreeNode is not set for MapPinEnhancedTrackerGroupEntryMixin")
    if button == "LeftButton" then
        if self.group:IsHidden() then
            self.group:ShowGroup()
            return
        end
        if not self:CanExpandGroup() then return end
        self.treeNode:ToggleCollapsed()
        self:UpdateExpandIcon()
    elseif button == "RightButton" then
        MapPinEnhanced:GenerateMenu(self, self:BuildMenu())
    end
end
