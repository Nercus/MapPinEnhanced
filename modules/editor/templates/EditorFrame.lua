---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local L = MapPinEnhanced.L

---@class Groups
local Groups = MapPinEnhanced:GetModule("Groups")
---@class Pins
local Pins = MapPinEnhanced:GetModule("Pins")
---@class Dialogs
local Dialogs = MapPinEnhanced:GetModule("Dialogs")

---@class MapPinEnhancedEditorScrollBox : Frame, ScrollBoxListMixin

---@class MapPinEnhancedEditorPinNodeData
---@field classification "editorPin"
---@field group MapPinEnhancedGroupMixin
---@field pin MapPinEnhancedPinMixin?
---@field pinID UUID
---@field archivedPin ArchivedPinData?
---@field archiveState "reached"|"hidden"|nil
---@field order number

---@class MapPinEnhancedEditorTemplate : MapPinEnhancedWindowTemplate
---@field scrollBox MapPinEnhancedEditorScrollBox
---@field scrollBar ScrollBarMixin
---@field scrollView ScrollBoxListTreeListViewMixin
---@field dataProvider TreeDataProviderMixin
---@field pendingListUpdate boolean?
---@field listUpdateElapsed number
---@field tocPanel MapPinEnhancedEditorTocPanel
---@field tocDataProvider TreeDataProviderMixin
---@field tocScrollView ScrollBoxListTreeListViewMixin
MapPinEnhancedEditorMixin = CreateFromMixins(MapPinEnhancedWindowMixin)

---@class MapPinEnhancedEditorTocPanel : Frame
---@field tocTitle FontString
---@field createGroupButton MapPinEnhancedIconButtonTemplate
---@field tocSearch MapPinEnhancedInputTemplate
---@field tocScrollBox Frame
---@field tocScrollBar ScrollBarMixin

---@class MapPinEnhancedEditorGroupEntryTemplate : Button
---@field editor MapPinEnhancedEditorTemplate
---@field treeNode TreeNodeMixin
---@field group MapPinEnhancedGroupMixin
---@field expandIcon Texture
---@field icon Texture
---@field groupLabel FontString
---@field hiddenStatus FontString
---@field pinCount FontString
---@field nameInput MapPinEnhancedInputTemplate
---@field iconInput MapPinEnhancedInputTemplate
---@field hiddenCheckbox MapPinEnhancedCheckboxWithLabelTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedEditorGroupEntryMixin = {}

---@class MapPinEnhancedEditorPinEntryTemplate : Button
---@field editor MapPinEnhancedEditorTemplate
---@field pinNode MapPinEnhancedEditorPinNodeData
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field dragIcon Texture
---@field dropLineBefore Texture
---@field dropLineAfter Texture
---@field nameInput MapPinEnhancedInputTemplate
---@field colorInput MapPinEnhancedInputTemplate
---@field iconInput MapPinEnhancedInputTemplate
---@field mapInput MapPinEnhancedInputTemplate
---@field xInput MapPinEnhancedInputTemplate
---@field yInput MapPinEnhancedInputTemplate
---@field atlasCheckbox MapPinEnhancedCheckboxWithLabelTemplate
---@field lockedCheckbox MapPinEnhancedCheckboxWithLabelTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
MapPinEnhancedEditorPinEntryMixin = {}

---@class MapPinEnhancedEditorTocEntryTemplate : Button
---@field editor MapPinEnhancedEditorTemplate
---@field tocNode MapPinEnhancedEditorTocNodeData
---@field icon Texture
---@field label FontString
---@field detail FontString
---@field glow Texture
---@field expandIcon Texture
---@field dropLineBefore Texture
---@field dropLineAfter Texture
MapPinEnhancedEditorTocEntryMixin = {}

---@class MapPinEnhancedEditorTocNodeData
---@field classification "toc"
---@field group MapPinEnhancedGroupMixin
---@field pinID UUID?
---@field targetType "group"|"pin"
---@field label string
---@field detail string
---@field searchString string

local DEFAULT_PIN_COLOR = Pins.DEFAULT_COLOR
local PIN_COLORS_BY_NAME = Pins.PIN_COLORS_BY_NAME
local PIN_ICONS = Pins.PIN_ICONS
local DEFAULT_GROUP_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"
local MENU_COLOR_BUTTON_PATTERN = "|T%s\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
local PIN_ICON_MENU_COLUMNS = 3
local PIN_ICON_MENU_ENTRY_SIZE = 36

local function FormatPercent(value)
    if not value then return "" end
    return string.format("%.2f", value * 100)
end

---@param value string|number|nil
---@return number?
local function ParsePercent(value)
    local numberValue = tonumber(value)
    if not numberValue then return nil end
    if numberValue > 1 then
        numberValue = numberValue / 100
    end
    if numberValue < 0 or numberValue > 1 then return nil end
    return numberValue
end

---@param value string|number|nil
---@return number?
local function ParseMapID(value)
    local mapID = tonumber(value)
    if not mapID then return nil end
    mapID = math.floor(mapID)
    if mapID <= 0 then return nil end
    return mapID
end

---@param colorName string|nil
---@return PinColor?
local function NormalizePinColor(colorName)
    if not colorName or colorName == "" then return nil end
    for knownColor in pairs(PIN_COLORS_BY_NAME) do
        if string.lower(knownColor) == string.lower(colorName) then
            return knownColor
        end
    end
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return SaveablePinData
local function GetPinData(pinNode)
    if pinNode.pin then
        return pinNode.pin:GetPinData()
    end
    return pinNode.archivedPin.data
end

---@param group MapPinEnhancedGroupMixin
---@param pinID UUID
---@param pinData SaveablePinData
---@param state "reached"|"hidden"|nil
---@param order number?
local function PersistArchivedPinData(group, pinID, pinData, state, order)
    group.pinArchive[pinID] = {
        state = state or "reached",
        data = pinData,
        order = order or GetTime(),
    }
    Groups:PersistGroup(group)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@param callback fun(pinData: SaveablePinData)
local function UpdateArchivedPinData(pinNode, callback)
    if pinNode.pin then return end
    local pinData = pinNode.archivedPin and pinNode.archivedPin.data
    if not pinData then return end
    callback(pinData)
    PersistArchivedPinData(pinNode.group, pinNode.pinID, pinData, pinNode.archiveState, pinNode.order)
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return MapPinEnhancedPinMixin?
local function ActivateReachedPinNode(pinNode)
    if pinNode.pin then return pinNode.pin end
    if pinNode.archiveState ~= "reached" then return nil end
    if pinNode.group:IsHidden() then return nil end
    if not pinNode.archivedPin or not pinNode.archivedPin.data then return nil end

    local group = pinNode.group
    local pinID = pinNode.pinID
    local pinData = CopyTable(pinNode.archivedPin.data)
    local order = pinNode.order or pinNode.archivedPin.order or GetTime()

    group.pinArchive[pinID] = nil
    group:SetPinOrder(pinID, order, true)
    local pin = group:AddPin(pinData, pinID, true, true)
    if not pin then return nil end

    pinNode.pin = pin
    pinNode.archivedPin = nil
    pinNode.archiveState = nil
    pinNode.order = order

    Groups:PersistGroup(group)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
    return pin
end

---@param pinData SaveablePinData
---@param title string
local function SetSaveablePinTitle(pinData, title)
    pinData.title = title
    if pinData.tooltip then
        pinData.tooltip.title = title
    end
end

---@param pinData SaveablePinData
---@param color PinColor
local function SetSaveablePinColor(pinData, color)
    pinData.color = color
    pinData.texture = nil
    pinData.usesAtlas = nil
end

---@param pinData SaveablePinData
---@param icon string
---@param usesAtlas boolean
local function SetSaveablePinIcon(pinData, icon, usesAtlas)
    pinData.texture = icon ~= "" and icon or nil
    pinData.usesAtlas = pinData.texture and usesAtlas or nil
    if pinData.texture then
        pinData.color = nil
    end
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return string
local function GetPinNodeTitle(pinNode)
    local pinData = GetPinData(pinNode)
    return pinData.title or L["Map Pin"]
end

---@param group MapPinEnhancedGroupMixin
---@return boolean
local function ShouldShowGroup(group)
    return group.systemType ~= "wayBack"
end

---@param groupnode1 TreeNodeMixin
---@param groupnode2 TreeNodeMixin
---@return boolean
local function GroupSortComparator(groupnode1, groupnode2)
    ---@type MapPinEnhancedGroupMixin, MapPinEnhancedGroupMixin
    local group1, group2 = groupnode1:GetData(), groupnode2:GetData()
    local order1 = group1.order or 0
    local order2 = group2.order or 0

    if order1 ~= order2 then
        return order1 > order2
    end
    return (group1.name or "") < (group2.name or "")
end

---@param pinNode1 TreeNodeMixin
---@param pinNode2 TreeNodeMixin
---@return boolean
local function PinSortComparator(pinNode1, pinNode2)
    ---@type MapPinEnhancedEditorPinNodeData, MapPinEnhancedEditorPinNodeData
    local pin1, pin2 = pinNode1:GetData(), pinNode2:GetData()
    local order1 = pin1.order or 0
    local order2 = pin2.order or 0

    if order1 ~= order2 then
        return order1 > order2
    end
    return GetPinNodeTitle(pin1) < GetPinNodeTitle(pin2)
end

function MapPinEnhancedEditorGroupEntryMixin:Reset()
    self.group = nil
    self.treeNode = nil
    self.editor = nil
    self.expandIcon:Hide()
    self.groupLabel:SetText("")
    self.hiddenStatus:SetText("")
    self.pinCount:SetText("")
    self.hiddenCheckbox:SetEnabled(true)
    self.deleteButton:SetEnabled(true)
end

function MapPinEnhancedEditorGroupEntryMixin:UpdateExpandIcon()
    if not self.treeNode or self.group:GetTotalPinCount() == 0 then
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

function MapPinEnhancedEditorGroupEntryMixin:UpdateHiddenStatus()
    if self.group:IsHidden() then
        self.hiddenStatus:SetText(L["Hidden"])
        self.hiddenStatus:Show()
        self.icon:SetDesaturated(true)
    else
        self.hiddenStatus:SetText("")
        self.hiddenStatus:Hide()
        self.icon:SetDesaturated(false)
    end
end

---@param treeNode TreeNodeMixin
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorGroupEntryMixin:Init(treeNode, editor)
    ---@type MapPinEnhancedGroupMixin
    local group = treeNode:GetData()
    self.group = group
    self.treeNode = treeNode
    self.editor = editor

    self.icon:SetTexture(group:GetIcon())
    self.groupLabel:SetText(L["Group"])
    self.pinCount:SetText(string.format(L["%d |4pin:pins;"], group:GetTotalPinCount()))
    self:UpdateHiddenStatus()
    self:UpdateExpandIcon()

    self.nameInput:SetInlineLabel(L["Name"])
    self.nameInput:SetValue(group:GetName())
    self.nameInput:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        local name = strtrim(self.nameInput:GetText() or "")
        if name == "" then return end
        group:SetName(name)
    end)

    self.iconInput:SetInlineLabel(L["Icon"])
    self.iconInput:SetValue(group:GetIcon() or "")
    self.iconInput:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        local icon = strtrim(self.iconInput:GetText() or "")
        if icon == "" then return end
        group:SetIcon(icon)
        self.icon:SetTexture(icon)
    end)

    self.hiddenCheckbox:SetLabel(L["Hidden"])
    self.hiddenCheckbox:SetChecked(group:IsHidden())
    self.hiddenCheckbox:SetEnabled(not group:IsProtected())
    self.hiddenCheckbox:SetScript("OnClick", function()
        if group:IsProtected() then
            self.hiddenCheckbox:SetChecked(false)
            return
        end

        if self.hiddenCheckbox:GetChecked() then
            group:HideGroup()
        else
            group:ShowGroup()
        end
    end)

    self.deleteButton:SetEnabled(not group:IsProtected())
    self.deleteButton:SetScript("OnClick", function()
        if group:IsProtected() then return end
        Dialogs:ShowConfirmDialog(L["Delete Group"],
            string.format(L["Delete group \"%s\" and all of its pins?"], group:GetName()), function()
                Groups:DeleteGroup(group)
            end)
    end)
end

function MapPinEnhancedEditorGroupEntryMixin:OnMouseDown(button)
    if button ~= "LeftButton" or not self.treeNode then return end
    if self.editor then
        self.editor.draggedPinNode = nil
    end
    if self.group:GetTotalPinCount() == 0 then return end
    self.treeNode:ToggleCollapsed()
    self:UpdateExpandIcon()
end

function MapPinEnhancedEditorGroupEntryMixin:OnMouseUp(button)
    if button ~= "LeftButton" or not self.editor then return end
    self.editor:DropDraggedPinOnGroup(self.group)
end

function MapPinEnhancedEditorGroupEntryMixin:OnReceiveDrag()
    if not self.editor then return end
    self.editor:DropDraggedPinOnGroup(self.group)
end

function MapPinEnhancedEditorPinEntryMixin:Reset()
    self.pinNode = nil
    self.editor = nil
    self.pinFrame:SetIconTexture(nil)
    self.deleteButton:SetScript("OnClick", nil)
    self.pinFrame:SetScript("OnMouseDown", nil)
    self:ClearDropPlaceholder()
end

---@param pinNode MapPinEnhancedEditorPinNodeData
function MapPinEnhancedEditorPinEntryMixin:RefreshPreview(pinNode)
    local pinData = GetPinData(pinNode)
    if pinData.texture then
        self.pinFrame:SetIconTexture(pinData.texture, pinData.usesAtlas)
    else
        self.pinFrame:SetColor(pinData.color or DEFAULT_PIN_COLOR)
    end
    self.pinFrame:SetTracked(true)
    self.pinFrame:SetLock(pinData.lock)
end

---@param color PinColor
function MapPinEnhancedEditorPinEntryMixin:SetPinColor(color)
    local pinNode = self.pinNode
    if not pinNode then return end

    local activePin = ActivateReachedPinNode(pinNode)
    if activePin then
        activePin:SetColor(color)
    else
        UpdateArchivedPinData(pinNode, function(archivedPinData)
            SetSaveablePinColor(archivedPinData, color)
        end)
    end

    self.colorInput:SetValue(color)
    self.iconInput:SetValue("")
    self:RefreshPreview(pinNode)
end

---@param icon string?
---@param usesAtlas boolean?
function MapPinEnhancedEditorPinEntryMixin:SetPinIcon(icon, usesAtlas)
    local pinNode = self.pinNode
    if not pinNode then return end

    local activePin = ActivateReachedPinNode(pinNode)
    if activePin then
        activePin:SetIcon(icon, usesAtlas)
    else
        UpdateArchivedPinData(pinNode, function(archivedPinData)
            SetSaveablePinIcon(archivedPinData, icon or "", usesAtlas and true or false)
        end)
    end

    self.iconInput:SetValue(icon or "")
    self.atlasCheckbox:SetChecked(usesAtlas and true or false)
    if icon then
        self.colorInput:SetValue("")
    end
    self:RefreshPreview(pinNode)
end

function MapPinEnhancedEditorPinEntryMixin:BuildPinStyleMenu()
    local pinNode = self.pinNode
    if not pinNode then return {} end

    local menu = {}
    table.insert(menu, {
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
                        local pinData = GetPinData(pinNode)
                        return pinData.color == colorName
                    end,
                    setSelected = function()
                        self:SetPinColor(colorName)
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
    })

    table.insert(menu, {
        type = "submenu",
        entries = function()
            local iconMenu = {}
            for _, icon in pairs(PIN_ICONS) do
                local iconData = icon
                table.insert(iconMenu, {
                    type = "template",
                    template = "MapPinEnhancedMenuRadioCellTemplate",
                    data = {
                        owner = pinNode,
                        icon = iconData,
                        isSelected = function()
                            local pinData = GetPinData(pinNode)
                            return pinData.texture == iconData.path
                        end,
                        onClick = function()
                            self:SetPinIcon(iconData.path, iconData.usesAtlas)
                        end,
                    },
                    initializer = function(_, _, dropdownMenu)
                        dropdownMenu.minimumElementWidth = PIN_ICON_MENU_ENTRY_SIZE
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
    })

    return menu
end

function MapPinEnhancedEditorPinEntryMixin:ShowPinStyleMenu()
    MapPinEnhanced:GenerateMenu(self.pinFrame, self:BuildPinStyleMenu())
end

---@param placement "before"|"after"|nil
function MapPinEnhancedEditorPinEntryMixin:SetDropPlaceholder(placement)
    self.dropLineBefore:SetShown(placement == "before")
    self.dropLineAfter:SetShown(placement == "after")
end

function MapPinEnhancedEditorPinEntryMixin:ClearDropPlaceholder()
    self.dropLineBefore:Hide()
    self.dropLineAfter:Hide()
end

---@param pinNode MapPinEnhancedEditorPinNodeData
function MapPinEnhancedEditorPinEntryMixin:UpdatePosition()
    local pinNode = self.pinNode
    if not pinNode then return end

    local pinData = GetPinData(pinNode)
    local mapID = ParseMapID(self.mapInput:GetText()) or pinData.mapID
    local x = ParsePercent(self.xInput:GetText()) or pinData.x
    local y = ParsePercent(self.yInput:GetText()) or pinData.y

    if not mapID or not x or not y then return end

    local activePin = ActivateReachedPinNode(pinNode)
    if activePin then
        activePin:SetPinPosition(mapID, x, y)
        return
    end

    UpdateArchivedPinData(pinNode, function(archivedPinData)
        archivedPinData.mapID = mapID
        archivedPinData.x = x
        archivedPinData.y = y
    end)
end

---@param treeNode TreeNodeMixin
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorPinEntryMixin:Init(treeNode, editor)
    ---@type MapPinEnhancedEditorPinNodeData
    local pinNode = treeNode:GetData()
    local pinData = GetPinData(pinNode)
    self.pinNode = pinNode
    self.editor = editor

    self:RefreshPreview(pinNode)

    self.nameInput:SetInlineLabel(L["Name"])
    self.nameInput:SetValue(pinData.title or L["Map Pin"])
    self.nameInput:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        local title = strtrim(self.nameInput:GetText() or "")
        if title == "" then
            title = L["Map Pin"]
        end

        local activePin = ActivateReachedPinNode(pinNode)
        if activePin then
            activePin:SetTitle(title)
        else
            UpdateArchivedPinData(pinNode, function(archivedPinData)
                SetSaveablePinTitle(archivedPinData, title)
            end)
        end
    end)

    self.colorInput:SetInlineLabel(L["Color"])
    self.colorInput:SetValue(pinData.color or "")
    self.colorInput:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        local color = NormalizePinColor(strtrim(self.colorInput:GetText() or ""))
        if not color then return end
        self:SetPinColor(color)
    end)

    self.iconInput:SetInlineLabel(L["Icon"])
    self.iconInput:SetValue(pinData.texture or "")
    self.iconInput:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        local icon = strtrim(self.iconInput:GetText() or "")
        local usesAtlas = self.atlasCheckbox:GetChecked() and true or false
        self:SetPinIcon(icon ~= "" and icon or nil, usesAtlas)
    end)

    self.mapInput:SetInlineLabel(L["Map"])
    self.mapInput:SetValue(tostring(pinData.mapID or ""))
    self.mapInput:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            self:UpdatePosition()
        end
    end)

    self.xInput:SetInlineLabel(L["X"])
    self.xInput:SetValue(FormatPercent(pinData.x))
    self.xInput:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            self:UpdatePosition()
        end
    end)

    self.yInput:SetInlineLabel(L["Y"])
    self.yInput:SetValue(FormatPercent(pinData.y))
    self.yInput:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            self:UpdatePosition()
        end
    end)

    self.atlasCheckbox:SetLabel(L["Atlas"])
    self.atlasCheckbox:SetChecked(pinData.usesAtlas and true or false)
    self.atlasCheckbox:SetScript("OnClick", function()
        local icon = strtrim(self.iconInput:GetText() or "")
        if icon == "" then return end
        local usesAtlas = self.atlasCheckbox:GetChecked() and true or false
        self:SetPinIcon(icon, usesAtlas)
    end)

    self.lockedCheckbox:SetLabel(L["Locked"])
    self.lockedCheckbox:SetChecked(pinData.lock and true or false)
    self.lockedCheckbox:SetScript("OnClick", function()
        local locked = self.lockedCheckbox:GetChecked() and true or false
        local activePin = ActivateReachedPinNode(pinNode)
        if activePin then
            activePin:SetLock(locked)
        else
            UpdateArchivedPinData(pinNode, function(archivedPinData)
                archivedPinData.lock = locked
            end)
        end
        self:RefreshPreview(pinNode)
    end)

    self.deleteButton:SetScript("OnClick", function()
        local title = pinData.title or L["Map Pin"]
        Dialogs:ShowConfirmDialog(L["Delete Pin"], string.format(L["Delete pin \"%s\"?"], title), function()
            pinNode.group:RemovePin(pinNode.pinID)
        end)
    end)

    self.pinFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" or button == "RightButton" then
            self:ShowPinStyleMenu()
        end
    end)
end

function MapPinEnhancedEditorPinEntryMixin:OnDragStart()
    if not self.editor or not self.pinNode then return end
    self.editor.draggedPinNode = self.pinNode
    self:SetAlpha(0.45)
    self:LockHighlight()
    self.editor:SetScript("OnUpdate", self.editor.OnUpdate)
end

function MapPinEnhancedEditorPinEntryMixin:OnDragStop()
    if not self.editor then return end
    self:SetAlpha(1)
    self:UnlockHighlight()
    self.editor:DropDraggedPinOnMouseOverRow()
end

function MapPinEnhancedEditorPinEntryMixin:OnMouseDown(button)
    if button ~= "LeftButton" or not self.editor or not self.pinNode then return end
    self.editor.draggedPinNode = self.pinNode
end

function MapPinEnhancedEditorPinEntryMixin:OnReceiveDrag()
    if not self.editor or not self.pinNode then return end
    self.editor:DropDraggedPinOnPin(self.pinNode, self:GetMouseDropPlacement())
end

---@return "before"|"after"
function MapPinEnhancedEditorPinEntryMixin:GetMouseDropPlacement()
    local _, mouseY = GetCursorPosition()
    local effectiveScale = self:GetEffectiveScale()
    mouseY = mouseY / effectiveScale
    local centerY = self:GetTop() - (self:GetHeight() / 2)
    if mouseY >= centerY then
        return "before"
    end
    return "after"
end

---@param factory fun(template: string, initFunc: fun(frame: any))
---@param node TreeNodeMixin
local function EditorElementFactory(factory, node)
    local data = node:GetData()

    if data.classification == "group" then
        factory("MapPinEnhancedEditorGroupEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedEditorGroupEntryTemplate
            frame:Init(node, node.dataProvider:GetParentFrame())
        end)
    elseif data.classification == "editorPin" then
        factory("MapPinEnhancedEditorPinEntryTemplate", function(frame)
            ---@cast frame MapPinEnhancedEditorPinEntryTemplate
            frame:Init(node, node.dataProvider:GetParentFrame())
        end)
    end
end

---@param frame MapPinEnhancedEditorGroupEntryTemplate | MapPinEnhancedEditorPinEntryTemplate
---@param node TreeNodeMixin
local function EditorElementResetter(frame, node)
    local data = node:GetData()
    if data.classification == "group" then
        ---@cast frame MapPinEnhancedEditorGroupEntryTemplate
        frame:Reset()
    elseif data.classification == "editorPin" then
        ---@cast frame MapPinEnhancedEditorPinEntryTemplate
        frame:Reset()
    end
end

---@param treeNode TreeNodeMixin
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorTocEntryMixin:Init(treeNode, editor)
    ---@type MapPinEnhancedEditorTocNodeData
    local data = treeNode:GetData()
    self.tocNode = data
    self.treeNode = treeNode
    self.editor = editor
    self.label:SetText(data.label)
    self.detail:SetText(data.detail or "")

    if data.targetType == "group" then
        self.icon:SetTexture(data.group:GetIcon())
        self.icon:SetDesaturated(data.group:IsHidden())
        self.expandIcon:Show()
        if treeNode:IsCollapsed() then
            self.expandIcon:SetAtlas("common-icon-plus")
        else
            self.expandIcon:SetAtlas("common-icon-minus")
        end
    else
        self.icon:SetAtlas("common-icon-forwardarrow")
        self.icon:SetDesaturated(false)
        self.expandIcon:Hide()
    end
end

function MapPinEnhancedEditorTocEntryMixin:Reset()
    self.tocNode = nil
    self.treeNode = nil
    self.editor = nil
    self.wasDragging = nil
    self.label:SetText("")
    self.detail:SetText("")
    self:SetAlpha(1)
    self.glow:Hide()
    self.expandIcon:Hide()
    self:ClearDropPlaceholder()
end

function MapPinEnhancedEditorTocEntryMixin:OnClick()
    if not self.editor or not self.tocNode then return end
    if self.wasDragging then
        self.wasDragging = nil
        return
    end
    if self.tocNode.targetType == "group" and self.treeNode then
        self.treeNode:ToggleCollapsed()
        self.editor:ScrollToTocNode(self.tocNode)
        return
    end
    self.editor:ScrollToTocNode(self.tocNode)
end

function MapPinEnhancedEditorTocEntryMixin:OnEnter()
    self.glow:Show()
end

function MapPinEnhancedEditorTocEntryMixin:OnLeave()
    self.glow:Hide()
end

---@param placement "before"|"after"|nil
function MapPinEnhancedEditorTocEntryMixin:SetDropPlaceholder(placement)
    self.dropLineBefore:SetShown(placement == "before")
    self.dropLineAfter:SetShown(placement == "after")
end

function MapPinEnhancedEditorTocEntryMixin:ClearDropPlaceholder()
    self.dropLineBefore:Hide()
    self.dropLineAfter:Hide()
end

---@return "before"|"after"
function MapPinEnhancedEditorTocEntryMixin:GetMouseDropPlacement()
    local _, mouseY = GetCursorPosition()
    local effectiveScale = self:GetEffectiveScale()
    mouseY = mouseY / effectiveScale
    local centerY = self:GetTop() - (self:GetHeight() / 2)
    if mouseY >= centerY then
        return "before"
    end
    return "after"
end

function MapPinEnhancedEditorTocEntryMixin:OnDragStart()
    if not self.editor or not self.tocNode or self.tocNode.targetType ~= "pin" then return end
    self.editor.draggedPinNode = self.editor:CreateEditorPinNodeFromTocNode(self.tocNode)
    if not self.editor.draggedPinNode then return end

    self.wasDragging = true
    self:SetAlpha(0.45)
    self:LockHighlight()
    self.editor:SetScript("OnUpdate", self.editor.OnUpdate)
end

function MapPinEnhancedEditorTocEntryMixin:OnDragStop()
    if not self.editor then return end
    self:SetAlpha(1)
    self:UnlockHighlight()
    self.editor:DropDraggedPinOnMouseOverRow()
end

function MapPinEnhancedEditorTocEntryMixin:OnReceiveDrag()
    if not self.editor or not self.tocNode then return end

    if self.tocNode.targetType == "group" then
        self.editor:DropDraggedPinOnGroup(self.tocNode.group)
        return
    end

    local targetPinNode = self.editor:CreateEditorPinNodeFromTocNode(self.tocNode)
    if not targetPinNode then return end
    self.editor:DropDraggedPinOnPin(targetPinNode, self:GetMouseDropPlacement())
end

function MapPinEnhancedEditorMixin:IsAnyEditBoxFocused()
    local focus = GetCurrentKeyBoardFocus and GetCurrentKeyBoardFocus()
    while focus do
        if focus == self then return true end
        focus = focus.GetParent and focus:GetParent()
    end
    return false
end

function MapPinEnhancedEditorMixin:RequestListUpdate()
    if not self:IsShown() then return end
    if self:IsAnyEditBoxFocused() then
        self.pendingListUpdate = true
        self:SetScript("OnUpdate", self.OnUpdate)
        return
    end
    self:UpdateList()
end

function MapPinEnhancedEditorMixin:ClearDropPlaceholders()
    self.scrollBox:ForEachFrame(function(frame)
        if frame.ClearDropPlaceholder then
            frame:ClearDropPlaceholder()
        end
    end)

    self.tocPanel.tocScrollBox:ForEachFrame(function(frame)
        if frame.ClearDropPlaceholder then
            frame:ClearDropPlaceholder()
        end
    end)
end

function MapPinEnhancedEditorMixin:ClearDraggedVisuals()
    self.scrollBox:ForEachFrame(function(frame)
        if frame.pinNode then
            frame:SetAlpha(1)
            frame:UnlockHighlight()
        end
    end)

    self.tocPanel.tocScrollBox:ForEachFrame(function(frame)
        if frame.tocNode and frame.tocNode.targetType == "pin" then
            frame:SetAlpha(1)
            frame:UnlockHighlight()
        end
    end)
end

function MapPinEnhancedEditorMixin:UpdateDropPlaceholder()
    local draggedPinNode = self.draggedPinNode
    if not draggedPinNode then
        self:ClearDropPlaceholders()
        return
    end

    local targetFrame
    local placement
    self.scrollBox:ForEachFrame(function(frame)
        if frame.SetDropPlaceholder then
            if not targetFrame and frame.pinNode and frame.pinNode.pinID ~= draggedPinNode.pinID and frame:IsMouseOver() then
                targetFrame = frame
                placement = frame:GetMouseDropPlacement()
            else
                frame:ClearDropPlaceholder()
            end
        end
    end)

    self.tocPanel.tocScrollBox:ForEachFrame(function(frame)
        if frame.SetDropPlaceholder then
            local isTargetPin = frame.tocNode and frame.tocNode.targetType == "pin" and
                frame.tocNode.pinID ~= draggedPinNode.pinID
            if not targetFrame and isTargetPin and frame:IsMouseOver() then
                targetFrame = frame
                placement = frame:GetMouseDropPlacement()
            else
                frame:ClearDropPlaceholder()
            end
        end
    end)

    if targetFrame then
        targetFrame:SetDropPlaceholder(placement)
    end
end

function MapPinEnhancedEditorMixin:OnUpdate(elapsed)
    if self.draggedPinNode then
        self:UpdateDropPlaceholder()
    else
        self:ClearDropPlaceholders()
    end

    if not self.pendingListUpdate then
        if not self.draggedPinNode then
            self:SetScript("OnUpdate", nil)
        end
        return
    end

    self.listUpdateElapsed = (self.listUpdateElapsed or 0) + elapsed
    if self.listUpdateElapsed < 0.25 then return end
    self.listUpdateElapsed = 0

    if self:IsAnyEditBoxFocused() then return end

    self.pendingListUpdate = nil
    self:UpdateList()
    if not self.draggedPinNode then
        self:SetScript("OnUpdate", nil)
    end
end

---@param group MapPinEnhancedGroupMixin
---@return TreeNodeMixin
function MapPinEnhancedEditorMixin:AddGroupNode(group)
    local groupElement = self.dataProvider:Insert(group) --[[@as TreeNodeMixin]]

    for _, pin in group:EnumeratePins() do
        ---@type MapPinEnhancedEditorPinNodeData
        local pinNode = {
            classification = "editorPin",
            group = group,
            pin = pin,
            pinID = pin.pinID,
            order = group:GetPinOrder(pin.pinID),
        }
        groupElement:Insert(pinNode)
    end

    for pinID, archivedPin in group:EnumerateArchivedPins() do
        ---@type MapPinEnhancedEditorPinNodeData
        local pinNode = {
            classification = "editorPin",
            group = group,
            pinID = pinID,
            archivedPin = archivedPin,
            archiveState = archivedPin.state,
            order = archivedPin.order or GetTime(),
        }
        groupElement:Insert(pinNode)
    end

    groupElement:SetSortComparator(PinSortComparator, false, false)
    return groupElement
end

function MapPinEnhancedEditorMixin:UpdateList()
    self.dataProvider:Flush()
    for group in Groups:EnumerateGroups() do
        if ShouldShowGroup(group) then
            self:AddGroupNode(group)
        end
    end
    self.dataProvider:SetSortComparator(GroupSortComparator, false, false)
    self:UpdateToc()
end

---@param group MapPinEnhancedGroupMixin
---@param pinData SaveablePinData
---@param pinID UUID
---@return MapPinEnhancedEditorTocNodeData
function MapPinEnhancedEditorMixin:CreatePinTocNode(group, pinData, pinID)
    local groupName = group:GetName()
    local title = pinData.title or L["Map Pin"]
    return {
        classification = "toc",
        group = group,
        pinID = pinID,
        targetType = "pin",
        label = title,
        detail = groupName,
        searchString = string.lower(title .. " " .. groupName),
    }
end

---@param tocNode MapPinEnhancedEditorTocNodeData
---@return MapPinEnhancedEditorPinNodeData?
function MapPinEnhancedEditorMixin:CreateEditorPinNodeFromTocNode(tocNode)
    if not tocNode or tocNode.targetType ~= "pin" or not tocNode.pinID then return nil end

    local group = tocNode.group
    local pin = group:GetPinByID(tocNode.pinID)
    if pin then
        return {
            classification = "editorPin",
            group = group,
            pin = pin,
            pinID = tocNode.pinID,
            order = group:GetPinOrder(tocNode.pinID),
        }
    end

    local archivedPin = group:GetArchivedPinByID(tocNode.pinID)
    if not archivedPin then return nil end

    return {
        classification = "editorPin",
        group = group,
        pinID = tocNode.pinID,
        archivedPin = archivedPin,
        archiveState = archivedPin.state,
        order = archivedPin.order or GetTime(),
    }
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorTocNodeData
function MapPinEnhancedEditorMixin:CreateGroupTocNode(group)
    local groupName = group:GetName()
    return {
        classification = "toc",
        group = group,
        targetType = "group",
        label = groupName,
        detail = group:IsHidden() and L["Hidden"] or string.format(L["%d |4pin:pins;"], group:GetTotalPinCount()),
        searchString = string.lower(groupName),
    }
end

function MapPinEnhancedEditorMixin:GetTocSearchText()
    local text = self.tocPanel.tocSearch:GetText()
    return text and string.lower(strtrim(text)) or ""
end

---@param tocNode MapPinEnhancedEditorTocNodeData
---@param searchText string
---@return boolean
function MapPinEnhancedEditorMixin:MatchesTocSearch(tocNode, searchText)
    if searchText == "" then return true end
    return string.find(tocNode.searchString, searchText, 1, true) ~= nil
end

function MapPinEnhancedEditorMixin:UpdateToc()
    if not self.tocDataProvider then return end

    local searchText = self:GetTocSearchText()
    self.tocDataProvider:Flush()

    for group in Groups:EnumerateGroups() do
        if ShouldShowGroup(group) then
            local groupNode = self:CreateGroupTocNode(group)
            local groupMatches = self:MatchesTocSearch(groupNode, searchText)
            local childNodes = {}

            for pinID, pin in group:EnumeratePins() do
                local tocNode = self:CreatePinTocNode(group, pin:GetPinData(), pinID)
                if groupMatches or self:MatchesTocSearch(tocNode, searchText) then
                    table.insert(childNodes, tocNode)
                end
            end

            for pinID, archivedPin in group:EnumerateArchivedPins() do
                local tocNode = self:CreatePinTocNode(group, archivedPin.data, pinID)
                if groupMatches or self:MatchesTocSearch(tocNode, searchText) then
                    table.insert(childNodes, tocNode)
                end
            end

            if groupMatches or #childNodes > 0 then
                local groupElement = self.tocDataProvider:Insert(groupNode)
                for _, childNode in ipairs(childNodes) do
                    groupElement:Insert(childNode)
                end
                if searchText ~= "" then
                    groupElement:SetCollapsed(false)
                end
            end
        end
    end
end

---@param tocNode MapPinEnhancedEditorTocNodeData
function MapPinEnhancedEditorMixin:ScrollToTocNode(tocNode)
    if tocNode.targetType == "pin" then
        local groupNode = self.dataProvider:FindElementDataByPredicate(function(node)
            local data = node:GetData()
            return data.classification == "group" and data:GetGroupID() == tocNode.group:GetGroupID()
        end, TreeDataProviderConstants.IncludeCollapsed)
        if groupNode then
            groupNode:SetCollapsed(false)
        end
    end

    self.scrollBox:ScrollToElementDataByPredicate(function(node)
        local data = node:GetData()
        if tocNode.targetType == "group" then
            return data.classification == "group" and data:GetGroupID() == tocNode.group:GetGroupID()
        end
        return data.classification == "editorPin" and data.pinID == tocNode.pinID
    end, TreeDataProviderConstants.IncludeCollapsed)
end

---@param group MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData[]
function MapPinEnhancedEditorMixin:GetSortedPinNodesForGroup(group)
    local pinNodes = {}

    for pinID, pin in group:EnumeratePins() do
        table.insert(pinNodes, {
            classification = "editorPin",
            group = group,
            pin = pin,
            pinID = pinID,
            order = group:GetPinOrder(pinID),
        })
    end

    for pinID, archivedPin in group:EnumerateArchivedPins() do
        table.insert(pinNodes, {
            classification = "editorPin",
            group = group,
            pinID = pinID,
            archivedPin = archivedPin,
            archiveState = archivedPin.state,
            order = archivedPin.order or GetTime(),
        })
    end

    table.sort(pinNodes, function(pinNode1, pinNode2)
        local order1 = pinNode1.order or 0
        local order2 = pinNode2.order or 0
        if order1 ~= order2 then
            return order1 > order2
        end
        return GetPinNodeTitle(pinNode1) < GetPinNodeTitle(pinNode2)
    end)

    return pinNodes
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@return SaveablePinData?
function MapPinEnhancedEditorMixin:GetSaveableDataForPinNode(pinNode)
    if pinNode.pin then
        return CopyTable(pinNode.pin:GetSaveableData())
    end
    if pinNode.archivedPin and pinNode.archivedPin.data then
        return CopyTable(pinNode.archivedPin.data)
    end
end

---@param sourceGroup MapPinEnhancedGroupMixin
---@param pinID UUID
---@param targetGroup MapPinEnhancedGroupMixin
---@return MapPinEnhancedEditorPinNodeData?
function MapPinEnhancedEditorMixin:MovePinToGroup(sourceGroup, pinID, targetGroup)
    local pin = sourceGroup:GetPinByID(pinID)
    local archivedPin = sourceGroup:GetArchivedPinByID(pinID)
    local pinData
    local order

    if pin then
        pinData = CopyTable(pin:GetSaveableData())
        order = sourceGroup:GetPinOrder(pinID)
    elseif archivedPin then
        pinData = CopyTable(archivedPin.data)
        order = archivedPin.order or GetTime()
    end

    if not pinData then return nil end

    sourceGroup:RemovePin(pinID, true, true)

    local newPin
    if targetGroup:IsHidden() then
        targetGroup:AddPin(pinData, pinID, true, true)
        targetGroup.pinOrder[pinID] = nil
    else
        targetGroup:SetPinOrder(pinID, order, true)
        newPin = targetGroup:AddPin(pinData, pinID, true, true)
    end

    local newArchivedPin = targetGroup:GetArchivedPinByID(pinID)
    if newArchivedPin then
        newArchivedPin.order = order
    end

    Groups:PersistGroup(sourceGroup)
    Groups:PersistGroup(targetGroup)

    return {
        classification = "editorPin",
        group = targetGroup,
        pin = newPin,
        pinID = pinID,
        archivedPin = newArchivedPin,
        archiveState = newArchivedPin and newArchivedPin.state or nil,
        order = order,
    }
end

---@param group MapPinEnhancedGroupMixin
---@param pinIDs UUID[]
function MapPinEnhancedEditorMixin:ApplyPinOrder(group, pinIDs)
    local count = #pinIDs
    for index, pinID in ipairs(pinIDs) do
        local order = count - index + 1
        local archivedPin = group:GetArchivedPinByID(pinID)
        if archivedPin then
            archivedPin.order = order
            group.pinOrder[pinID] = nil
        else
            group:SetPinOrder(pinID, order, true)
        end
    end
    Groups:PersistGroup(group)
end

---@param movedPinID UUID
---@param targetPinNode MapPinEnhancedEditorPinNodeData
---@param placement "before"|"after"
function MapPinEnhancedEditorMixin:ReorderPinInGroup(movedPinID, targetPinNode, placement)
    local group = targetPinNode.group
    local pinIDs = {}

    for _, pinNode in ipairs(self:GetSortedPinNodesForGroup(group)) do
        if pinNode.pinID ~= movedPinID then
            if pinNode.pinID == targetPinNode.pinID and placement == "before" then
                table.insert(pinIDs, movedPinID)
            end
            table.insert(pinIDs, pinNode.pinID)
            if pinNode.pinID == targetPinNode.pinID and placement == "after" then
                table.insert(pinIDs, movedPinID)
            end
        end
    end

    if #pinIDs == 0 then
        table.insert(pinIDs, movedPinID)
    end

    self:ApplyPinOrder(group, pinIDs)
end

---@param targetGroup MapPinEnhancedGroupMixin
function MapPinEnhancedEditorMixin:DropDraggedPinOnGroup(targetGroup)
    local draggedPinNode = self.draggedPinNode
    self.draggedPinNode = nil
    self:ClearDropPlaceholders()
    self:ClearDraggedVisuals()
    if not draggedPinNode or not targetGroup then return end

    if draggedPinNode.group ~= targetGroup then
        self:MovePinToGroup(draggedPinNode.group, draggedPinNode.pinID, targetGroup)
        MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetGroup)
    end

    self:UpdateList()
end

---@param targetPinNode MapPinEnhancedEditorPinNodeData
---@param placement "before"|"after"
function MapPinEnhancedEditorMixin:DropDraggedPinOnPin(targetPinNode, placement)
    local draggedPinNode = self.draggedPinNode
    self.draggedPinNode = nil
    self:ClearDropPlaceholders()
    self:ClearDraggedVisuals()
    if not draggedPinNode or not targetPinNode then return end
    if draggedPinNode.pinID == targetPinNode.pinID then return end

    local movedPinID = draggedPinNode.pinID
    if draggedPinNode.group ~= targetPinNode.group then
        local movedPinNode = self:MovePinToGroup(draggedPinNode.group, movedPinID, targetPinNode.group)
        if not movedPinNode then return end
    end

    self:ReorderPinInGroup(movedPinID, targetPinNode, placement)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, targetPinNode.group)
    self:UpdateList()
end

function MapPinEnhancedEditorMixin:DropDraggedPinOnMouseOverRow()
    local targetPinNode
    local placement
    local targetGroup

    self.scrollBox:ForEachFrame(function(frame)
        if targetPinNode or targetGroup then return end
        if frame.pinNode and frame.editor == self and frame:IsMouseOver() then
            targetPinNode = frame.pinNode
            placement = frame:GetMouseDropPlacement()
        elseif frame.group and frame.editor == self and frame:IsMouseOver() then
            targetGroup = frame.group
        end
    end)

    self.tocPanel.tocScrollBox:ForEachFrame(function(frame)
        if targetPinNode or targetGroup then return end
        if frame.tocNode and frame.editor == self and frame:IsMouseOver() then
            if frame.tocNode.targetType == "pin" then
                targetPinNode = self:CreateEditorPinNodeFromTocNode(frame.tocNode)
                placement = frame:GetMouseDropPlacement()
            elseif frame.tocNode.targetType == "group" then
                targetGroup = frame.tocNode.group
            end
        end
    end)

    if targetPinNode then
        self:DropDraggedPinOnPin(targetPinNode, placement)
        return
    end

    if targetGroup then
        self:DropDraggedPinOnGroup(targetGroup)
        return
    end

    self.draggedPinNode = nil
    self:ClearDropPlaceholders()
    self:ClearDraggedVisuals()
end

function MapPinEnhancedEditorMixin:GetAvailableNewGroupName()
    local index = 1
    local name = string.format(L["New Group %d"], index)
    while Groups:GetGroupByName(name) do
        index = index + 1
        name = string.format(L["New Group %d"], index)
    end
    return name
end

function MapPinEnhancedEditorMixin:CreateNewGroup()
    local group = Groups:RegisterGroup({
        name = self:GetAvailableNewGroupName(),
        source = MapPinEnhanced.name,
        icon = DEFAULT_GROUP_ICON,
        order = GetTime(),
    })
    if not group then return end
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, group)
    self:UpdateList()
    self:ScrollToTocNode(self:CreateGroupTocNode(group))
end

function MapPinEnhancedEditorMixin:SetupToc()
    local tocPanel = self.tocPanel
    tocPanel.tocTitle:SetText(L["Contents"])

    tocPanel.createGroupButton:SetIconTexture("plus")
    tocPanel.createGroupButton:SetScript("OnClick", function()
        self:CreateNewGroup()
    end)

    self.tocDataProvider = CreateTreeDataProvider()
    self.tocScrollView = CreateScrollBoxListTreeListView()
    self.tocScrollView:SetElementFactory(function(factory, node)
        factory("MapPinEnhancedEditorTocEntryTemplate", function(entry)
            ---@cast entry MapPinEnhancedEditorTocEntryTemplate
            entry:Init(node, self)
        end)
    end)
    self.tocScrollView:SetElementResetter(function(entry)
        ---@cast entry MapPinEnhancedEditorTocEntryTemplate
        entry:Reset()
    end)
    self.tocScrollView:SetDataProvider(self.tocDataProvider)

    tocPanel.tocScrollBar:SetHideIfUnscrollable(true)
    tocPanel.tocScrollBar:SetInterpolateScroll(true)
    tocPanel.tocScrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(tocPanel.tocScrollBox, tocPanel.tocScrollBar, self.tocScrollView)

    tocPanel.tocSearch:SetInlineIcon("search")
    tocPanel.tocSearch:SetPlaceholderText(L["Search"])
    tocPanel.tocSearch:SetScript("OnTextChanged", function(_, userInput)
        if userInput then
            self:UpdateToc()
            return
        end
    end)
end

function MapPinEnhancedEditorMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    self.scrollBar:SetHideIfUnscrollable(true)
    self.dataProvider = CreateTreeDataProvider()
    self.dataProvider.GetParentFrame = function()
        return self
    end

    self.scrollView = CreateScrollBoxListTreeListView()
    self.scrollView:SetElementFactory(EditorElementFactory)
    self.scrollView:SetElementResetter(EditorElementResetter)
    self.scrollView:SetDataProvider(self.dataProvider)

    self.scrollBar:SetInterpolateScroll(true)
    self.scrollBox:SetInterpolateScroll(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)
    self:SetupToc()

    MapPinEnhanced:RegisterCallback("PIN_ADDED", function()
        self:RequestListUpdate()
    end)
    MapPinEnhanced:RegisterCallback("PIN_REMOVED", function()
        self:RequestListUpdate()
    end)
    MapPinEnhanced:RegisterCallback("GROUP_UPDATED", function()
        self:RequestListUpdate()
    end)
    MapPinEnhanced:RegisterCallback("GROUP_DELETED", function()
        self:RequestListUpdate()
    end)
end

function MapPinEnhancedEditorMixin:ShowFrame()
    MapPinEnhanced:RestoreFrame(self)
    self:UpdateList()
    self:Show()
end

function MapPinEnhancedEditorMixin:HideFrame()
    self:Hide()
end
