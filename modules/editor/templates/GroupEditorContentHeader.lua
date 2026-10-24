---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Transfer = MapPinEnhanced:GetModule("Transfer")
local L = MapPinEnhanced.L
local HIDDEN_GROUP_ICON_COLOR = CreateColor(0.65, 0.65, 0.65)
local MORE_ICON_PATH = MapPinEnhanced.basePath .. "\\assets\\icons\\IconEllipsis.png"

---@class MapPinEnhancedEditorInputField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedInputTemplate

---@class MapPinEnhancedEditorDropdownField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedDropdownTemplate

---@class MapPinEnhancedEditorToggleField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedToggleTemplate

---@class MapPinEnhancedEditorGroupIconButton : Button, MapPinEnhancedTooltipMixin
---@field iconTexture Texture

---@class MapPinEnhancedGroupEditorContentHeaderTemplate : Frame
---@field group MapPinEnhancedGroupMixin?
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field iconButton MapPinEnhancedEditorGroupIconButton
---@field nameField MapPinEnhancedEditorInputField
---@field trackingModeField MapPinEnhancedEditorDropdownField
---@field restorableField MapPinEnhancedEditorToggleField
---@field hideButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field exportButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedGroupEditorContentHeaderMixin = {}

function MapPinEnhancedGroupEditorContentHeaderMixin:Reset()
    self.nameField.child:ClearTextApply()
    self.trackingModeField.child:ClearMenuState()
    self.trackingModeField.child:SetSelectedValue(nil)
    self.trackingModeField.child:Disable()
    self.restorableField.child:SetScript("OnClick", nil)
    self.restorableField.child:SetValue(false, false, true)
    self.restorableField:Hide()
    self.group = nil
    self.editor = nil
    self.iconButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.deleteButton.tooltipInteractions = nil
    self.deleteButton:OnTooltipLeave()
    self.exportButton:SetScript("OnClick", nil)
    self.exportButton:Disable()
    self.hideButton:SetScript("OnClick", nil)
    self.hideButton:UnlockHighlight()
    self.hideButton:SetAlpha(1)
end

function MapPinEnhancedGroupEditorContentHeaderMixin:UpdateGroupVisibilityButton()
    local hidden = self.group and self.group:IsHidden()
    self.hideButton:SetIconTexture(hidden and "eyeslash" or "eye", hidden and HIDDEN_GROUP_ICON_COLOR or nil)
    if hidden then
        self.hideButton:UnlockHighlight()
    else
        self.hideButton:LockHighlight()
    end
end

function MapPinEnhancedGroupEditorContentHeaderMixin:ShowIconMenu()
    local group = assert(self.group)
    local groupID, lifetime = group:GetGroupID(), group.lifetimeChangeNumber
    local editor = assert(self.editor)
    local entries = {}
    for _, groupIcon in ipairs(Groups.GROUP_ICON_MENU_ICONS) do
        local icon = groupIcon
        table.insert(entries, {
            type = "template",
            template = "MapPinEnhancedMenuRadioCellTemplate",
            data = {
                owner = group,
                icon = icon,
                isSelected = function() return group:GetIcon() == icon.path end,
                onClick = function()
                    if not group:IsSameGroup(groupID, lifetime) then return end
                    group:SetIcon(icon.path)
                    if self.group == group then self.iconButton.iconTexture:SetTexture(icon.path) end
                    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
                    editor.groupEditorSidebar:Refresh()
                end,
            },
            initializer = function(_, _, menu)
                menu.minimumElementWidth = 36
                return 36, 36
            end,
        })
    end
    table.insert(entries, {
        type = "button",
        label = "",
        onClick = function()
            MapPinEnhanced:ShowIconPicker(group:GetIcon(), function(path)
                if not group:IsSameGroup(groupID, lifetime) then return end
                group:SetIcon(path)
                if self.group == group then self.iconButton.iconTexture:SetTexture(path) end
                MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
                editor.groupEditorSidebar:Refresh()
            end)
        end,
        initializer = function(button, _, menu)
            ---@type Texture
            local texture = button:AttachTexture()
            texture:SetSize(18, 18)
            texture:SetPoint("CENTER")
            texture:SetTexture(MORE_ICON_PATH)
            texture:SetVertexColor(1, 0.82, 0)
            button.fontString:Hide()
            menu.minimumElementWidth = 36
            return 36, 36
        end,
    })
    MapPinEnhanced:GenerateMenu(self.iconButton, entries, { gridModeColumns = 4 })
end

---@param group MapPinEnhancedGroupMixin
---@param editor MapPinEnhancedGroupEditorTemplate
---@param focusName boolean?
function MapPinEnhancedGroupEditorContentHeaderMixin:SetGroup(group, editor, focusName)
    local groupChanged = self.group ~= group
    if groupChanged then self:Reset() end
    self.group, self.editor = group, editor
    local protected = group:IsProtected()
    self.iconButton.iconTexture:SetTexture(group:GetIcon())
    self.iconButton:SetEnabled(not protected)
    self.iconButton.iconTexture:SetDesaturated(protected)
    local iconBrightness = protected and 0.5 or 1
    self.iconButton.iconTexture:SetVertexColor(iconBrightness, iconBrightness, iconBrightness)
    self.iconButton:SetScript("OnClick", function() self:ShowIconMenu() end)

    self.nameField.child:SetEnabled(not protected)
    self.nameField.child:SetTextApply(group:GetName(), function(value)
        if value == "" or protected then return nil end
        local existing = Groups:GetGroupByName(value)
        if existing and existing ~= group then return nil end
        if not group:SetName(value) then return nil end
        editor.groupEditorSidebar:Refresh()
        return group:GetName()
    end)

    local dropdown = self.trackingModeField.child
    dropdown.options = protected and {
        { label = MapPinEnhanced:Iconize("arrowleftright", L["Track by Distance"]), value = Groups.TRACKING_MODE_NEAREST },
    } or Groups.TRACKING_MODE_OPTIONS
    local entries = {}
    -- Apply editor choices immediately; a delayed callback must not edit a previous group.
    for _, option in ipairs(dropdown.options) do
        local mode = option.value
        table.insert(entries, {
            type = "radio",
            label = option.label,
            isSelected = function() return group:GetTrackingMode() == mode end,
            initializer = not protected and mode == Groups.TRACKING_MODE_NEAREST and function(_, description)
                MenuUtil.SetTitleAndTextTooltip(description, L["Track by Travel Time"],
                    L["Next Pin Travel Time Description"])
            end or nil,
            setSelected = function()
                if self.group == group and not protected then
                    group:SetTrackingMode(mode)
                    dropdown:SetSelectedValue(group:GetTrackingMode())
                end
            end,
        })
    end
    dropdown:SetupMenu(MapPinEnhanced:GetGeneratorFunction(entries))
    dropdown:SetSelectedValue(group:GetTrackingMode())
    dropdown:SetEnabled(not protected)

    self.restorableField:SetShown(not protected)
    -- GROUP_UPDATED refreshes the same header before the click animation finishes.
    if groupChanged or self.restorableField.child:GetChecked() ~= group:IsRestorable() then
        self.restorableField.child:SetValue(group:IsRestorable(), false, groupChanged)
    end
    self.restorableField.child:SetScript("OnClick", function()
        if self.group ~= group or protected then return end
        group:SetRestorable(not group:IsRestorable())
        -- Disabling retention may synchronously detach this header while pins restore.
        if self.group == group then
            self.restorableField.child:SetValue(group:IsRestorable(), false, false)
        end
    end)

    self.exportButton:SetEnabled(group:GetTotalPinCount() > 0)
    self.exportButton:SetScript("OnClick", function() Transfer:ShowExportWindow(group) end)

    self:UpdateGroupVisibilityButton()
    self.hideButton:SetEnabled(not protected)
    self.hideButton:SetScript("OnClick", function()
        if protected then return end
        if group:IsHidden() then group:ShowGroup() else group:HideGroup() end
        self:UpdateGroupVisibilityButton()
        editor.groupEditorSidebar:Refresh()
    end)

    self.deleteButton.tooltipInteractions = {
        { L["Left Click"],         protected and L["Clear Group"] or L["Delete Group"] },
        { L["Shift + Left Click"], protected and L["Clear without confirmation"] or L["Delete without confirmation"] },
    }
    local groupID, lifetime = group:GetGroupID(), group.lifetimeChangeNumber
    self.deleteButton:SetScript("OnClick", function()
        local function destroy()
            if not group:IsSameGroup(groupID, lifetime) then return end
            if protected then
                group:ClearGroup()
                editor:RequestRefresh()
            else
                Groups:DeleteGroup(group)
                if editor.selectedGroup == group then editor:SelectGroup(nil) end
            end
        end
        if IsShiftKeyDown() then
            destroy()
        elseif protected then
            MapPinEnhanced:ShowConfirmDialog(L["Clear Group"],
                string.format(L["Clear all pins from \"%s\"?"], group:GetName()), destroy)
        else
            MapPinEnhanced:ShowConfirmDialog(L["Delete Group"],
                string.format(L["Delete group \"%s\" and all of its pins?"], group:GetName()), destroy)
        end
    end)

    if focusName and not protected then
        C_Timer.After(0, function()
            if self.group == group then
                self.nameField.child:SetFocus()
                self.nameField.child:HighlightText()
            end
        end)
    end
end
