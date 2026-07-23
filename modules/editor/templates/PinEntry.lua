---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L
local Pins = MapPinEnhanced:GetModule("Pins")

local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICONS = Pins.PIN_ICONS
local PIN_ICON_MENU_COLUMNS = 3
local PIN_ICON_MENU_ENTRY_SIZE = 36
local MENU_COLOR_BUTTON_PATTERN = "|T%s\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"

---@class MapPinEnhancedEditorPinEntryLockCheckboxTemplate : MapPinEnhancedCheckboxWithLabelTemplate
---@field NormalTexture Texture
---@field text FontString

---@class MapPinEnhancedEditorPinEntryTemplate : Frame
---@field editor MapPinEnhancedEditorTemplate?
---@field pinData pinData?
---@field dragHandle Button
---@field titleInput MapPinEnhancedInputTemplate
---@field duplicateButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field pinTexture MapPinEnhancedBasePinTemplate
---@field mapInput MapPinEnhancedAutocompleteTemplate
---@field xInput MapPinEnhancedInputTemplate
---@field yInput MapPinEnhancedInputTemplate
---@field tooltipInput MapPinEnhancedInputTemplate
---@field lockCheckbox MapPinEnhancedEditorPinEntryLockCheckboxTemplate
---@field dragHighlight Texture
---@field dropTargetHighlight Texture
MapPinEnhancedEditorPinEntryMixin = {}

---@param pinData pinData
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorPinEntryMixin:Init(pinData, editor)
    self.pinData = pinData
    self.editor = editor

    self:SetupFields()
    self:SetupActions()
    self:UpdatePinTexture()
end

function MapPinEnhancedEditorPinEntryMixin:SetupActions()
    self.dragHandle:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" and self.editor then
            self.editor:StartPinDrag(self)
        end
    end)
    self.dragHandle:SetScript("OnMouseUp", function(_, button)
        if button == "LeftButton" and self.editor then
            self.editor:FinishPinDrag()
        end
    end)
    self.dragHandle:SetScript("OnEnter", function()
        if self.editor and self.editor.draggedPinEntry then return end
        SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
    end)
    self.dragHandle:SetScript("OnLeave", function()
        if self.editor and self.editor.draggedPinEntry then return end
        ResetCursor()
    end)

    self.duplicateButton:SetScript("OnClick", function()
        if self.editor and self.pinData then
            self.editor:DuplicatePinData(self.pinData)
        end
    end)
    self.deleteButton:SetScript("OnClick", function()
        if self.editor and self.pinData then
            self.editor:DeletePinData(self.pinData)
        end
    end)
    self.pinTexture:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            self:ShowPinTextureMenu()
        end
    end)
end

function MapPinEnhancedEditorPinEntryMixin:Reset()
    self:SetDragging(false)
    self:SetDropTarget(false)
    self.pinData = nil
    self.editor = nil
    self.dragHandle:SetScript("OnMouseDown", nil)
    self.dragHandle:SetScript("OnMouseUp", nil)
    self.dragHandle:SetScript("OnEnter", nil)
    self.dragHandle:SetScript("OnLeave", nil)
    self:SetScript("OnUpdate", nil)
    self.duplicateButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.pinTexture:SetScript("OnMouseDown", nil)
end

---@param isDragging boolean
function MapPinEnhancedEditorPinEntryMixin:SetDragging(isDragging)
    self.dragHighlight:SetShown(isDragging)
    self:SetAlpha(isDragging and 0.3 or 1)
end

---@param isDropTarget boolean
function MapPinEnhancedEditorPinEntryMixin:SetDropTarget(isDropTarget)
    self.dropTargetHighlight:SetShown(isDropTarget)
end

function MapPinEnhancedEditorPinEntryMixin:UpdatePinTexture()
    if not self.pinData then return end

    if self.pinData.texture then
        self.pinTexture:SetIconTexture(self.pinData.texture, self.pinData.usesAtlas)
    else
        self.pinTexture:SetColor(self.pinData.color)
    end
    self.pinTexture:SetTracked(true)
    self.pinTexture:SetLock(self.pinData.lock)
end

function MapPinEnhancedEditorPinEntryMixin:ShowPinTextureMenu()
    if not self.pinData or not self.editor then return end

    MapPinEnhanced:GenerateMenu(self.pinTexture, {
        {
            type = "submenu",
            entries = function()
                local colorMenu = {}
                for colorName, colorData in pairs(PIN_COLORS_BY_NAME) do
                    local label = string.format(MENU_COLOR_BUTTON_PATTERN, MapPinEnhanced.basePath,
                        colorData:GetRGBAsBytes())
                    table.insert(colorMenu, {
                        type = "radio",
                        label = label,
                        style = "custom",
                        isSelected = function()
                            return not self.pinData.texture and (self.pinData.color or Pins.DEFAULT_COLOR) == colorName
                        end,
                        setSelected = function()
                            self.pinData.texture = nil
                            self.pinData.usesAtlas = nil
                            self.pinData.color = colorName
                            self:UpdatePinTexture()
                            self.editor:PersistSelectedCollection()
                        end,
                        data = colorName,
                    })
                end
                return colorMenu
            end,
            entry = {
                type = "button",
                label = L["Change Color"],
            },
        },
        {
            type = "submenu",
            entries = function()
                local iconMenu = {}
                for _, icon in pairs(PIN_ICONS) do
                    local iconData = icon
                    table.insert(iconMenu, {
                        type = "template",
                        template = "MapPinEnhancedMenuRadioCellTemplate",
                        data = {
                            owner = self,
                            icon = iconData,
                            isSelected = function()
                                return self.pinData.texture == iconData.path
                            end,
                            onClick = function()
                                self.pinData.texture = iconData.path
                                self.pinData.usesAtlas = iconData.usesAtlas
                                self:UpdatePinTexture()
                                self.editor:PersistSelectedCollection()
                            end,
                        },
                        initializer = function(_, _, menu)
                            menu.minimumElementWidth = PIN_ICON_MENU_ENTRY_SIZE
                            return PIN_ICON_MENU_ENTRY_SIZE, PIN_ICON_MENU_ENTRY_SIZE
                        end,
                    })
                end
                return iconMenu
            end,
            entry = {
                type = "button",
                label = L["Change Icon"],
            },
            options = {
                gridModeColumns = PIN_ICON_MENU_COLUMNS,
            },
        },
    })
end

function MapPinEnhancedEditorPinEntryMixin:OnEnter()
    if self.editor then
        self.editor:SetPinDropTarget(self)
    end
end

function MapPinEnhancedEditorPinEntryMixin:OnMouseUp(button)
    if button == "LeftButton" and self.editor and self.editor.draggedPinEntry then
        self.editor:FinishPinDrag()
    end
end
