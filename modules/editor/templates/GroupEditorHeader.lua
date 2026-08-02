---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local L = MapPinEnhanced.L

---@class MapPinEnhancedEditorCommittedInput : MapPinEnhancedInputTemplate
---@field committedValue string

---@class MapPinEnhancedEditorInputField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorCommittedInput

---@class MapPinEnhancedEditorDropdownField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedDropdownTemplate

---@class MapPinEnhancedEditorGroupEditorHeaderTemplate : Frame
---@field group MapPinEnhancedGroupMixin?
---@field editor MapPinEnhancedEditorTemplate?
---@field icon Texture
---@field pinCount FontString
---@field nameField MapPinEnhancedEditorInputField
---@field iconField MapPinEnhancedEditorInputField
---@field trackingModeField MapPinEnhancedEditorDropdownField
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
    self.iconField.child:SetScript("OnEnterPressed", nil)
    self.iconField.child:SetScript("OnEditFocusLost", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.hideButton:SetScript("OnClick", nil)
end

---@param group MapPinEnhancedGroupMixin
---@param editor MapPinEnhancedEditorTemplate
---@param focusName boolean?
function MapPinEnhancedEditorGroupEditorHeaderMixin:SetGroup(group, editor, focusName)
    self:Reset()
    self.group, self.editor = group, editor
    local protected = group:IsProtected()
    self.icon:SetTexture(group:GetIcon())
    self.pinCount:SetText(string.format(L["%d |4pin:pins;"], group:GetTotalPinCount()))

    self.nameField.child:SetEnabled(not protected)
    self.iconField.child:SetEnabled(not protected)
    SetupCommittedEditBox(self.nameField.child, group:GetName(), function(value)
        if protected then return false end
        local existing = Groups:GetGroupByName(value)
        if existing and existing ~= group then return false end
        local result = group:SetName(value)
        editor.groupSidebar:Refresh()
        return result ~= false
    end)
    SetupCommittedEditBox(self.iconField.child, group:GetIcon() or "", function(value)
        if protected then return false end
        group:SetIcon(value)
        self.icon:SetTexture(value)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
        editor.groupSidebar:Refresh()
        return true
    end)

    self.trackingModeField.child:SetEnabled(not protected)
    self.trackingModeField.child:Setup({
        options = Groups.TRACKING_MODE_OPTIONS,
        init = function() return group:GetTrackingMode() end,
        onChange = function(value)
            if not protected then group:SetTrackingMode(value) end
        end,
    })

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
