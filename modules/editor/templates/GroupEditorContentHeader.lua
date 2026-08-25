---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local L = MapPinEnhanced.L
local MORE_ICON_PATH = MapPinEnhanced.basePath .. "\\assets\\icons\\IconMore_Yellow.png"

---@class MapPinEnhancedEditorInputField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedInputTemplate

---@class MapPinEnhancedEditorRadioGroupField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedRadioGroupTemplate

---@class MapPinEnhancedEditorGroupIconButton : MapPinEnhancedIconButtonTemplate

---@class MapPinEnhancedGroupEditorContentHeaderTemplate : Frame
---@field group MapPinEnhancedGroupMixin?
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field iconButton MapPinEnhancedEditorGroupIconButton
---@field nameField MapPinEnhancedEditorInputField
---@field trackingModeField MapPinEnhancedEditorRadioGroupField
---@field optimizeButton MapPinEnhancedButtonTemplate
---@field hideButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedGroupEditorContentHeaderMixin = {}

function MapPinEnhancedGroupEditorContentHeaderMixin:Reset()
    self.nameField.child:ClearTextApply()
    self.group = nil
    self.editor = nil
    self.iconButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.hideButton:SetScript("OnClick", nil)
    self.optimizeButton:SetScript("OnClick", nil)
    self.optimizeButton:Hide()
end

function MapPinEnhancedGroupEditorContentHeaderMixin:UpdateRouteOrderButton()
    local group = self.group
    self.optimizeButton:SetShown(group ~= nil and not group:IsProtected() and
        group:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and group:GetTotalPinCount() > 1)
end

function MapPinEnhancedGroupEditorContentHeaderMixin:OrderRouteByDistance()
    local group, editor = assert(self.group), assert(self.editor)
    MapPinEnhanced:ShowConfirmDialog(L["Optimize Route"],
        L
        ["Optimization reorders the pins so nearby destinations are visited together. This can reduce travel time and backtracking when you follow the group in order. The new order replaces your current pin order and cannot be undone."],
        function()
            if self.group ~= group then return end
            editor.groupEditorContent:SetLoading(true)
            Groups:OrderGroupByDistance(group, function()
                if self.group == group then
                    editor.groupEditorContent:SetGroup(group)
                end
                editor.groupEditorContent:SetLoading(false)
            end, function(message)
                editor.groupEditorContent:SetLoading(false)
                MapPinEnhanced:Print(message)
            end)
        end)
end

function MapPinEnhancedGroupEditorContentHeaderMixin:ShowIconMenu()
    local group = assert(self.group)
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
                    group:SetIcon(icon.path)
                    self.iconButton.iconTexture:SetTexture(icon.path)
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
                group:SetIcon(path)
                self.iconButton.iconTexture:SetTexture(path)
                MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
                editor.groupEditorSidebar:Refresh()
            end)
        end,
        initializer = function(button, _, menu)
            ---@type Texture
            local texture = button:AttachTexture()
            texture:SetSize(18, 6)
            texture:SetPoint("CENTER")
            texture:SetTexture(MORE_ICON_PATH)
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
    self:Reset()
    self.group, self.editor = group, editor
    local protected = group:IsProtected()
    self.iconButton.iconTexture:SetTexture(group:GetIcon())
    self.iconButton:SetEnabled(not protected)
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

    self.trackingModeField.child:Setup({
        options = Groups.TRACKING_MODE_OPTIONS,
        orientation = "horizontal",
        init = function() return group:GetTrackingMode() end,
        onChange = function(value)
            if not protected then
                group:SetTrackingMode(value)
                self:UpdateRouteOrderButton()
            end
        end,
    })
    for _, option in ipairs(Groups.TRACKING_MODE_OPTIONS) do
        self.trackingModeField.child:SetOptionDisabledState(option.value, protected)
    end
    self.optimizeButton:SetScript("OnClick", function() self:OrderRouteByDistance() end)
    self:UpdateRouteOrderButton()

    self.hideButton:SetEnabled(not protected)
    self.hideButton:SetScript("OnClick", function()
        if protected then return end
        if group:IsHidden() then group:ShowGroup() else group:HideGroup() end
        editor.groupEditorSidebar:Refresh()
    end)

    self.deleteButton:SetScript("OnClick", function()
        local function destroy()
            if protected then
                group:ClearGroup()
                editor:RequestRefresh()
            else
                Groups:DeleteGroup(group)
                editor:SelectGroup(nil)
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
