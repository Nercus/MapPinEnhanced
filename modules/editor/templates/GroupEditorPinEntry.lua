---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Groups = MapPinEnhanced:GetModule("Groups")
local Pins = MapPinEnhanced:GetModule("Pins")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local L = MapPinEnhanced.L
local Util = MapPinEnhancedEditorUtil

---@class MapPinEnhancedEditorCommittedAutocomplete : MapPinEnhancedAutocompleteTemplate
---@field committedValue string
---@field committedMapID number

---@class MapPinEnhancedEditorAutocompleteField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorCommittedAutocomplete

---@class MapPinEnhancedEditorGroupEditorPinEntryTemplate : Frame
---@field pinNode MapPinEnhancedEditorPinNodeData?
---@field editor MapPinEnhancedEditorTemplate?
---@field dragHandle Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field nameField MapPinEnhancedEditorInputField
---@field mapField MapPinEnhancedEditorAutocompleteField
---@field xField MapPinEnhancedEditorInputField
---@field yField MapPinEnhancedEditorInputField
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field dropLine Texture
MapPinEnhancedEditorGroupEditorPinEntryMixin = {}

local COLOR_PATTERN = "|T%s\\assets\\forms\\colorpicker\\body.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
local mapCache, mapNames, mapOptions

local function EnsureMapCache()
    if mapCache then return end
    mapCache, mapNames, mapOptions = {}, {}, {}
    -- UI map IDs are sparse. GetMapInfo is cheap and this runs once, lazily on first editor use.
    for mapID = 1, 5000 do
        local info = C_Map.GetMapInfo(mapID)
        if info and info.name and info.name ~= "" then
            local entry = { mapID = mapID, name = info.name, search = info.name .. " " .. mapID }
            mapCache[mapID] = entry
            table.insert(mapNames, entry)
            table.insert(mapOptions, {
                label = string.format("%s (%d)", info.name, mapID),
                description = tostring(mapID),
                searchString = info.name .. " " .. mapID,
                value = mapID,
            })
        end
    end
end

local function GetMapDisplay(mapID)
    EnsureMapCache()
    local entry = mapCache[mapID]
    return entry and string.format("%s (%d)", entry.name, mapID) or tostring(mapID or "")
end

local function FindExactMap(text)
    EnsureMapCache()
    local mapID = tonumber(text:match("^%s*(%d+)%s*$") or text:match("%((%d+)%)%s*$"))
    if mapID and mapCache[mapID] then return mapID end
    local lowered = string.lower(strtrim(text))
    local match
    for _, entry in ipairs(mapNames) do
        if string.lower(entry.name) == lowered then
            if match then return nil end
            match = entry.mapID
        end
    end
    return match
end

---@param node MapPinEnhancedEditorPinNodeData
---@param callback fun(pinData: SaveablePinData)
local function UpdateArchived(node, callback)
    if node.pin then return false end
    callback(node.archivedPin.data)
    Groups:PersistGroup(node.group)
    MapPinEnhanced:FireCallback("GROUP_UPDATED", nil, node.group)
    return true
end

---@param editBox MapPinEnhancedEditorCommittedInput
---@param initialValue string
---@param callback fun(value: string): boolean|string?
local function CommitTextBox(editBox, initialValue, callback)
    editBox.committedValue = initialValue or ""
    editBox:SetValue(editBox.committedValue)
    local function commit()
        local value = strtrim(editBox:GetText() or "")
        local result = callback(value)
        if result == false then
            value = editBox.committedValue
        elseif type(result) == "string" then
            value = result
        end
        editBox.committedValue = value
        editBox:SetValue(value)
        editBox:ClearFocus()
    end
    editBox:SetScript("OnEnterPressed", commit)
    editBox:SetScript("OnEditFocusLost", commit)
    editBox:SetScript("OnEscapePressed", function()
        editBox:SetValue(editBox.committedValue)
        editBox:ClearFocus()
    end)
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:Reset()
    self.pinNode, self.editor = nil, nil
    self.mapField.child.onChangeCallback = nil
    self.mapField.child.resultsFrame:Hide()
    self.dragHandle:SetScript("OnDragStart", nil)
    self.dragHandle:SetScript("OnDragStop", nil)
    self.dragHandle:SetScript("OnEnter", nil)
    self.dragHandle:SetScript("OnLeave", nil)
    self.pinFrame:SetScript("OnMouseDown", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self:ClearDropTarget()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:RefreshPreview()
    local data = Util.GetPinData(self.pinNode)
    if data.texture then
        self.pinFrame:SetIconTexture(data.texture, data.usesAtlas)
    else
        self.pinFrame:SetColor(data.color or Pins.DEFAULT_COLOR)
    end
    self.pinFrame:SetTracked(true)
    self.pinFrame:SetLock(data.lock)
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetColor(color)
    if self.pinNode.pin then
        self.pinNode.pin:SetColor(color)
    else
        UpdateArchived(self.pinNode, function(data)
            data.color, data.texture, data.usesAtlas = color, nil, nil
        end)
    end
    self:RefreshPreview()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetIcon(icon)
    if self.pinNode.pin then
        self.pinNode.pin:SetIcon(icon.path, icon.usesAtlas)
    else
        UpdateArchived(self.pinNode, function(data)
            data.texture, data.usesAtlas, data.color = icon.path, icon.usesAtlas, nil
        end)
    end
    self:RefreshPreview()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:ShowStyleMenu()
    local menu = {
        {
            type = "submenu",
            entry = { type = "button", label = L["Change Color"] },
            entries = function()
                local entries = {}
                for colorName, colorData in pairs(Pins.PIN_COLORS_BY_NAME) do
                    local color = colorName
                    table.insert(entries, {
                        type = "radio",
                        label = string.format(COLOR_PATTERN, MapPinEnhanced.basePath, colorData:GetRGBAsBytes()),
                        style = "custom",
                        isSelected = function() return Util.GetPinData(self.pinNode).color == color end,
                        setSelected = function() self:SetColor(color) end,
                    })
                end
                return entries
            end,
        },
        {
            type = "submenu",
            entry = { type = "button", label = L["Change Icon"] },
            options = { gridModeColumns = 3 },
            entries = function()
                local entries = {}
                for _, iconData in pairs(Pins.PIN_ICONS) do
                    local icon = iconData
                    table.insert(entries, {
                        type = "template",
                        template = "MapPinEnhancedMenuRadioCellTemplate",
                        data = {
                            owner = self.pinNode,
                            icon = icon,
                            isSelected = function() return Util.GetPinData(self.pinNode).texture == icon.path end,
                            onClick = function() self:SetIcon(icon) end,
                        },
                        initializer = function(_, _, dropdown)
                            dropdown.minimumElementWidth = 36
                            return 36, 36
                        end,
                    })
                end
                return entries
            end,
        },
    }
    MapPinEnhanced:GenerateMenu(self.pinFrame, menu)
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:CommitPosition()
    local node = assert(self.pinNode)
    local selectedMap = self.mapField.child.value
    local mapText = self.mapField.child:GetText() or ""
    local mapID = selectedMap and selectedMap.label == mapText and selectedMap.value or FindExactMap(mapText)
    local x, y = Util.ParsePercent(self.xField.child:GetText()), Util.ParsePercent(self.yField.child:GetText())
    if not mapID then
        self.mapField.child:SetValue(self.mapField.child.committedMapID)
        return false
    end
    if not x or not y then return false end
    if node.pin then
        node.pin:SetPinPosition(mapID, x, y)
    else
        UpdateArchived(node, function(pinData)
            pinData.mapID, pinData.x, pinData.y = mapID, x, y
        end)
    end
    self.mapField.child.committedValue = GetMapDisplay(mapID)
    self.mapField.child.committedMapID = mapID
    self.xField.child.committedValue, self.yField.child.committedValue = Util.FormatPercent(x), Util.FormatPercent(y)
    self.mapField.child:SetValue(mapID)
    return true
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorGroupEditorPinEntryMixin:Init(pinNode, editor)
    self.pinNode, self.editor = pinNode, editor
    local data = Util.GetPinData(pinNode)
    self:RefreshPreview()

    CommitTextBox(self.nameField.child, data.title or L["Map Pin"], function(value)
        if value == "" then value = L["Map Pin"] end
        if pinNode.pin then
            pinNode.pin:SetTitle(value)
        else
            UpdateArchived(pinNode, function(pinData)
                pinData.title = value
                if pinData.tooltip then pinData.tooltip.title = value end
            end)
        end
        return value
    end)

    EnsureMapCache()
    self.mapField.child.onChangeCallback = nil
    self.mapField.child:Setup({
        options = mapOptions,
        init = function() return data.mapID end,
        onChange = function() self:CommitPosition() end,
    })
    self.mapField.child.committedValue = GetMapDisplay(data.mapID)
    self.mapField.child.committedMapID = data.mapID
    self.xField.child.committedValue, self.yField.child.committedValue =
        Util.FormatPercent(data.x), Util.FormatPercent(data.y)
    self.mapField.child:SetValue(data.mapID)
    self.xField.child:SetValue(self.xField.child.committedValue)
    self.yField.child:SetValue(self.yField.child.committedValue)

    local function commitPosition(editBox)
        self:CommitPosition()
        editBox:ClearFocus()
    end
    local function restore(editBox)
        if editBox == self.mapField.child then
            editBox:SetValue(editBox.committedMapID)
        else
            editBox:SetValue(editBox.committedValue)
        end
        editBox:ClearFocus()
    end
    for _, editBox in ipairs({ self.xField.child, self.yField.child }) do
        editBox:SetScript("OnEnterPressed", commitPosition)
        editBox:SetScript("OnEditFocusLost", commitPosition)
        editBox:SetScript("OnEscapePressed", restore)
    end
    self.mapField.child:SetScript("OnEditFocusLost", function(editBox)
        MapPinEnhancedAutocompleteMixin.OnEditFocusLost(editBox)
        commitPosition(editBox)
    end)
    self.mapField.child:SetScript("OnEscapePressed", restore)

    self.pinFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then self:ShowStyleMenu() end
        if button == "MiddleButton" then
            if pinNode.pin then
                pinNode.pin:SetLock(locked)
            else
                UpdateArchived(pinNode, function(pinData)
                    pinData.lock = locked
                end)
            end
            self:RefreshPreview()
        end
    end)
    self.deleteButton:SetScript("OnClick", function()
        local function remove() Util.RemovePinCompletely(pinNode.group, pinNode.pinID) end
        if IsShiftKeyDown() then
            remove()
        else
            Dialogs:ShowConfirmDialog(L["Delete Pin"],
                string.format(L["Delete pin \"%s\"?"], data.title or L["Map Pin"]), remove)
        end
    end)
    self.dragHandle:SetScript("OnEnter", function()
        if editor.draggedPinNode then
            SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
        else
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        end
    end)
    self.dragHandle:SetScript("OnLeave", function()
        if editor.draggedPinNode then
            SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
        else
            ResetCursor()
        end
    end)
    self.dragHandle:SetScript("OnDragStart", function()
        editor:StartPinDrag(pinNode, self)
    end)
    self.dragHandle:SetScript("OnDragStop", function() editor:StopPinDrag() end)
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetDropTarget(placement)
    self.dropLine:ClearAllPoints()
    if placement == "before" then
        self.dropLine:SetPoint("TOPLEFT", 48, 0)
        self.dropLine:SetPoint("TOPRIGHT", -12, 0)
    else
        self.dropLine:SetPoint("BOTTOMLEFT", 48, 0)
        self.dropLine:SetPoint("BOTTOMRIGHT", -12, 0)
    end
    self.dropLine:Show()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:ClearDropTarget()
    self.dropLine:Hide()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:GetDropPlacement()
    local _, cursorY = GetCursorPosition()
    cursorY = cursorY / self:GetEffectiveScale()
    return cursorY >= self:GetTop() - self:GetHeight() / 2 and "before" or "after"
end
