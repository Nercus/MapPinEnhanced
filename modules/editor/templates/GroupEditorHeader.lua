---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local L = MapPinEnhanced.L

---@type PinIcon[]
local GROUP_ICONS = {
    { path = "Interface\\Icons\\INV_Misc_Map_01",            usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_QuestionMark",      usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Note_01",           usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Book_09",           usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Compass_01",        usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Key_03",            usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Coin_01",           usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Bag_10",            usesAtlas = false },
    { path = "Interface\\Icons\\INV_Chest_Cloth_17",         usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_TreasureChest04b",  usesAtlas = false },
    { path = "Interface\\Icons\\INV_Misc_Flag_02",           usesAtlas = false },
    { path = "Interface\\Icons\\Ability_Hunter_Pathfinding", usesAtlas = false },
    { path = "Interface\\Icons\\Ability_Mount_RidingHorse",  usesAtlas = false },
    { path = "Interface\\Icons\\Ability_Spy",                usesAtlas = false },
    { path = "Interface\\Icons\\Spell_Fire_Fire",            usesAtlas = false },
    { path = "Interface\\Icons\\Spell_Frost_Frost",          usesAtlas = false },
    { path = "Interface\\Icons\\Spell_Nature_Earthquake",    usesAtlas = false },
    { path = "Interface\\Icons\\Spell_Holy_MagicalSentry",   usesAtlas = false },
    { path = "Interface\\Icons\\Trade_Engineering",          usesAtlas = false },
    { path = "Interface\\Icons\\Trade_Alchemy",              usesAtlas = false },
}

---@class MapPinEnhancedEditorCommittedInput : MapPinEnhancedInputTemplate
---@field committedValue string

---@class MapPinEnhancedEditorInputField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorCommittedInput

---@class MapPinEnhancedEditorRadioGroupField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedRadioGroupTemplate

---@class MapPinEnhancedEditorGroupIconButton : MapPinEnhancedIconButtonTemplate

---@class MapPinEnhancedEditorGroupEditorHeaderTemplate : Frame
---@field group MapPinEnhancedGroupMixin?
---@field editor MapPinEnhancedEditorTemplate?
---@field iconButton MapPinEnhancedEditorGroupIconButton
---@field pinCount FontString
---@field nameField MapPinEnhancedEditorInputField
---@field trackingModeField MapPinEnhancedEditorRadioGroupField
---@field optimizeButton MapPinEnhancedButtonTemplate
---@field hideButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedEditorGroupEditorHeaderMixin = {}

---@param editBox MapPinEnhancedEditorCommittedInput
---@param initialValue string
---@param commit fun(value: string): boolean?
local function SetupCommittedEditBox(editBox, initialValue, commit)
    editBox.committedValue = initialValue or ""
    editBox:SetValue(editBox.committedValue)
    local function apply()
        local value = strtrim(editBox:GetText() or "")
        if value == "" or commit(value) == false then
            editBox:SetValue(editBox.committedValue)
        else
            editBox.committedValue = value
            editBox:SetValue(value)
        end
        editBox:ClearFocus()
    end
    editBox:SetScript("OnEnterPressed", apply)
    editBox:SetScript("OnEditFocusLost", apply)
    editBox:SetScript("OnEscapePressed", function()
        editBox:SetValue(editBox.committedValue)
        editBox:ClearFocus()
    end)
end

function MapPinEnhancedEditorGroupEditorHeaderMixin:Reset()
    self.group = nil
    self.editor = nil
    self.nameField.child:SetScript("OnEnterPressed", nil)
    self.nameField.child:SetScript("OnEditFocusLost", nil)
    self.iconButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.hideButton:SetScript("OnClick", nil)
    self.optimizeButton:SetScript("OnClick", nil)
    self.optimizeButton:Hide()
end

function MapPinEnhancedEditorGroupEditorHeaderMixin:UpdateOptimizeButton()
    local group = self.group
    self.optimizeButton:SetShown(group ~= nil and not group:IsProtected() and
        group:GetTrackingMode() == Groups.TRACKING_MODE_ORDERED and group:GetTotalPinCount() > 1)
end

function MapPinEnhancedEditorGroupEditorHeaderMixin:OptimizeGroup()
    local group, editor = assert(self.group), assert(self.editor)
    Dialogs:ShowConfirmDialog(L["Optimize Route"],
        L["Optimizing will permanently reorder every pin in this group and cannot be undone."], function()
            if self.group ~= group then return end
            editor.groupEditor:SetLoading(true)
            Groups:OptimizeGroupRoute(group, function()
                if self.group == group then
                    editor.groupEditor:SetGroup(group)
                end
                editor.groupEditor:SetLoading(false)
            end, function(message)
                editor.groupEditor:SetLoading(false)
                MapPinEnhanced:Print(message)
            end)
        end)
end

function MapPinEnhancedEditorGroupEditorHeaderMixin:ShowIconMenu()
    local group = assert(self.group)
    local editor = assert(self.editor)
    local entries = {}
    for _, groupIcon in ipairs(GROUP_ICONS) do
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
                    editor.groupSidebar:Refresh()
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
        label = MapPinEnhanced:Iconize("plus", L["More..."]),
        onClick = function()
            MapPinEnhanced:ShowIconPicker(group:GetIcon(), function(path)
                group:SetIcon(path)
                self.iconButton.iconTexture:SetTexture(path)
                MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
                editor.groupSidebar:Refresh()
            end)
        end,
    })
    MapPinEnhanced:GenerateMenu(self.iconButton, entries, { gridModeColumns = 5 })
end

---@param group MapPinEnhancedGroupMixin
---@param editor MapPinEnhancedEditorTemplate
---@param focusName boolean?
function MapPinEnhancedEditorGroupEditorHeaderMixin:SetGroup(group, editor, focusName)
    self:Reset()
    self.group, self.editor = group, editor
    local protected = group:IsProtected()
    self.iconButton.iconTexture:SetTexture(group:GetIcon())
    self.iconButton:SetEnabled(not protected)
    self.iconButton:SetScript("OnClick", function() self:ShowIconMenu() end)
    self.pinCount:SetText(string.format(L["%d |4pin:pins;"], group:GetTotalPinCount()))

    self.nameField.child:SetEnabled(not protected)
    SetupCommittedEditBox(self.nameField.child, group:GetName(), function(value)
        if protected then return false end
        local existing = Groups:GetGroupByName(value)
        if existing and existing ~= group then return false end
        local result = group:SetName(value)
        editor.groupSidebar:Refresh()
        return result ~= false
    end)

    self.trackingModeField.child:Setup({
        options = Groups.TRACKING_MODE_OPTIONS,
        orientation = "horizontal",
        init = function() return group:GetTrackingMode() end,
        onChange = function(value)
            if not protected then
                group:SetTrackingMode(value)
                self:UpdateOptimizeButton()
            end
        end,
    })
    for _, option in ipairs(Groups.TRACKING_MODE_OPTIONS) do
        self.trackingModeField.child:SetOptionDisabledState(option.value, protected)
    end
    self.optimizeButton:SetScript("OnClick", function() self:OptimizeGroup() end)
    self:UpdateOptimizeButton()

    self.hideButton:SetEnabled(not protected)
    self.hideButton:SetScript("OnClick", function()
        if protected then return end
        if group:IsHidden() then group:ShowGroup() else group:HideGroup() end
        editor.groupSidebar:Refresh()
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
            Dialogs:ShowConfirmDialog(L["Clear Group"],
                string.format(L["Clear all pins from \"%s\"?"], group:GetName()), destroy)
        else
            Dialogs:ShowConfirmDialog(L["Delete Group"],
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
