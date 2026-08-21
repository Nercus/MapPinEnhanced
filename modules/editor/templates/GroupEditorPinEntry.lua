---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")
local Dialogs = MapPinEnhanced:GetModule("Dialogs")
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L

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
---@field duplicateButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field dropLine Texture
MapPinEnhancedEditorGroupEditorPinEntryMixin = {}

---@class MapPinEnhancedEditorMapEntry
---@field mapID number
---@field name string
---@field search string

local COLOR_PATTERN = "|T%s\\assets\\shared\\ColorpickerBody.png:16:64:0:0:256:64:0:256:0:64:%d:%d:%d|t"
local mapCacheReady = false
---@type table<number, MapPinEnhancedEditorMapEntry>
local mapCache = {}
---@type MapPinEnhancedEditorMapEntry[]
local mapNames = {}
---@type AutocompleteOption[]
local mapOptions = {}

local function EnsureMapCache()
    if mapCacheReady then return end
    mapCacheReady = true
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
    ---@type number?
    local match
    for _, entry in ipairs(mapNames) do
        if string.lower(entry.name) == lowered then
            if match then return nil end
            match = entry.mapID
        end
    end
    return match
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
    self.duplicateButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self:ClearDropTarget()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:RefreshPreview()
    local data = Editor:GetPinData(self.pinNode)
    if data.texture then
        self.pinFrame:SetIconTexture(data.texture, data.usesAtlas)
    else
        self.pinFrame:SetColor(data.color or Pins.DEFAULT_COLOR)
    end
    self.pinFrame:SetTracked(true)
    self.pinFrame:SetLock(data.lock)
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetColor(color)
    self.pinNode.group:SetPinColor(self.pinNode.pinID, color)
    self:RefreshPreview()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetIcon(icon)
    self.pinNode.group:SetPinIcon(self.pinNode.pinID, icon.path, icon.usesAtlas)
    self:RefreshPreview()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:ShowStyleMenu()
    local menu = {
        {
            type = "submenu",
            entry = {
                type = "button",
                -- TODO: Replace the placeholder pin with a color icon.
                label = MapPinEnhanced:Iconize("pin", L["Change Color"]),
            },
            entries = function()
                local entries = {}
                for colorName, colorData in pairs(Pins.PIN_COLORS_BY_NAME) do
                    local color = colorName
                    table.insert(entries, {
                        type = "radio",
                        label = string.format(COLOR_PATTERN, MapPinEnhanced.basePath, colorData:GetRGBAsBytes()),
                        style = "custom",
                        isSelected = function() return Editor:GetPinData(self.pinNode).color == color end,
                        setSelected = function() self:SetColor(color) end,
                    })
                end
                return entries
            end,
        },
        {
            type = "submenu",
            entry = { type = "button", label = MapPinEnhanced:Iconize("edit", L["Change Icon"]) },
            options = { gridModeColumns = 3 },
            entries = function()
                local entries = {}
                for _, iconData in ipairs(Pins.PIN_ICON_MENU_ICONS) do
                    local icon = iconData
                    table.insert(entries, {
                        type = "template",
                        template = "MapPinEnhancedMenuRadioCellTemplate",
                        data = {
                            owner = self.pinNode,
                            icon = icon,
                            isSelected = function() return Editor:GetPinData(self.pinNode).texture == icon.path end,
                            onClick = function() self:SetIcon(icon) end,
                        },
                        initializer = function(_, _, dropdown)
                            dropdown.minimumElementWidth = 36
                            return 36, 36
                        end,
                    })
                end
                table.insert(entries, {
                    type = "button",
                    label = L["More..."],
                    onClick = function()
                        local data = Editor:GetPinData(self.pinNode)
                        local currentIcon = not data.usesAtlas and data.texture or nil
                        MapPinEnhanced:ShowIconPicker(currentIcon, function(path)
                            self:SetIcon({ path = path, usesAtlas = false })
                        end)
                    end,
                })
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
    local x, y =
        Editor:ParsePercent(self.xField.child:GetText()), Editor:ParsePercent(self.yField.child:GetText())
    if not mapID then
        self.mapField.child:SetValue(self.mapField.child.committedMapID)
        return false
    end
    if not x or not y then return false end
    node.group:SetPinPosition(node.pinID, mapID, x, y)
    self.mapField.child.committedValue = GetMapDisplay(mapID)
    self.mapField.child.committedMapID = mapID
    self.xField.child.committedValue, self.yField.child.committedValue =
        Editor:FormatPercent(x), Editor:FormatPercent(y)
    self.mapField.child:SetValue(mapID)
    return true
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@param editor MapPinEnhancedEditorTemplate
function MapPinEnhancedEditorGroupEditorPinEntryMixin:Init(pinNode, editor)
    self.pinNode, self.editor = pinNode, editor
    local data = Editor:GetPinData(pinNode)
    self:RefreshPreview()

    CommitTextBox(self.nameField.child, data.title or L["Map Pin"], function(value)
        if value == "" then value = L["Map Pin"] end
        pinNode.group:SetPinTitle(pinNode.pinID, value)
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
        Editor:FormatPercent(data.x), Editor:FormatPercent(data.y)
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
            local pinData = Editor:GetPinData(pinNode)
            pinNode.group:SetPinLock(pinNode.pinID, not pinData.lock)
            self:RefreshPreview()
        end
    end)
    self.duplicateButton:SetScript("OnClick", function()
        if Editor:DuplicatePin(pinNode) then editor:RequestRefresh() end
    end)
    self.deleteButton:SetScript("OnClick", function()
        local function remove() Editor:RemovePinCompletely(pinNode.group, pinNode.pinID) end
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

---@param placement "before"|"after"
function MapPinEnhancedEditorGroupEditorPinEntryMixin:SetDropTarget(placement)
    self.dropLine:ClearAllPoints()
    if placement == "before" then
        self.dropLine:SetPoint("TOPLEFT", 48, 2)
        self.dropLine:SetPoint("TOPRIGHT", -12, 2)
    else
        self.dropLine:SetPoint("BOTTOMLEFT", 48, -2)
        self.dropLine:SetPoint("BOTTOMRIGHT", -12, -2)
    end
    self.dropLine:Show()
end

function MapPinEnhancedEditorGroupEditorPinEntryMixin:ClearDropTarget()
    self.dropLine:Hide()
end

---@return "before"|"after"
function MapPinEnhancedEditorGroupEditorPinEntryMixin:GetDropPlacement()
    local _, cursorY = GetCursorPosition()
    cursorY = cursorY / self:GetEffectiveScale()
    return cursorY >= self:GetTop() - self:GetHeight() / 2 and "before" or "after"
end
