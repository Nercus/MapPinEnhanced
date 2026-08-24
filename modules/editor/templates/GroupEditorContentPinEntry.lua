---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L

---@class MapPinEnhancedEditorAppliedAutocomplete : MapPinEnhancedAutocompleteTemplate
---@field appliedText string?
---@field appliedMapID number?

---@class MapPinEnhancedEditorAutocompleteField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorAppliedAutocomplete

---@class MapPinEnhancedEditorPositionInput : MapPinEnhancedInputTemplate
---@field appliedText string?

---@class MapPinEnhancedEditorPositionField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorPositionInput

---@class MapPinEnhancedGroupEditorContentPinEntryTemplate : Frame
---@field pinNode MapPinEnhancedEditorPinNodeData?
---@field editor MapPinEnhancedGroupEditorTemplate?
---@field dragHandle Button
---@field pinFrame MapPinEnhancedBasePinTemplate
---@field nameField MapPinEnhancedEditorInputField
---@field mapField MapPinEnhancedEditorAutocompleteField
---@field xField MapPinEnhancedEditorPositionField
---@field yField MapPinEnhancedEditorPositionField
---@field duplicateButton MapPinEnhancedIconButtonTemplate
---@field deleteButton MapPinEnhancedIconButtonTemplate
---@field dropLine Texture
MapPinEnhancedGroupEditorContentPinEntryMixin = {}

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
        local mapInfo = C_Map.GetMapInfo(mapID)
        if mapInfo and mapInfo.name and mapInfo.name ~= "" then
            local entry = { mapID = mapID, name = mapInfo.name, search = mapInfo.name .. " " .. mapID }
            mapCache[mapID] = entry
            table.insert(mapNames, entry)
            table.insert(mapOptions, {
                label = string.format("%s (%d)", mapInfo.name, mapID),
                description = tostring(mapID),
                searchString = mapInfo.name .. " " .. mapID,
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

function MapPinEnhancedGroupEditorContentPinEntryMixin:Reset()
    self.nameField.child:ClearTextApply()
    self.mapField.child.onChangeCallback = nil
    self.mapField.child.appliedText = nil
    self.mapField.child.appliedMapID = nil
    self.mapField.child:SetScript("OnEditFocusLost", MapPinEnhancedAutocompleteMixin.OnEditFocusLost)
    self.mapField.child:SetScript("OnEscapePressed", MapPinEnhancedInputMixin.OnEscapePressed)
    self.mapField.child:ClearFocus()
    self.mapField.child.resultsFrame:Hide()
    for _, editBox in ipairs({ self.xField.child, self.yField.child }) do
        editBox.appliedText = nil
        editBox:SetScript("OnEnterPressed", nil)
        editBox:SetScript("OnEditFocusLost", MapPinEnhancedInputMixin.OnEditFocusLost)
        editBox:SetScript("OnEscapePressed", MapPinEnhancedInputMixin.OnEscapePressed)
        editBox:ClearFocus()
    end
    self.pinNode, self.editor = nil, nil
    self.dragHandle:SetScript("OnDragStart", nil)
    self.dragHandle:SetScript("OnDragStop", nil)
    self.dragHandle:SetScript("OnEnter", nil)
    self.dragHandle:SetScript("OnLeave", nil)
    self.pinFrame:SetScript("OnMouseDown", nil)
    self.duplicateButton:SetScript("OnClick", nil)
    self.deleteButton:SetScript("OnClick", nil)
    self:ClearDropTarget()
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:RefreshPreview()
    local pinData = Editor:GetPinData(self.pinNode)
    if pinData.texture then
        self.pinFrame:SetIconTexture(pinData.texture, pinData.usesAtlas)
    else
        self.pinFrame:SetColor(pinData.color or Pins.DEFAULT_COLOR)
    end
    self.pinFrame:SetTracked(true)
    self.pinFrame:SetLock(pinData.lock)
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:SetColor(color)
    self.pinNode.group:SetPinColor(self.pinNode.pinID, color)
    self:RefreshPreview()
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:SetIcon(icon)
    self.pinNode.group:SetPinIcon(self.pinNode.pinID, icon.path, icon.usesAtlas)
    self:RefreshPreview()
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:ShowStyleMenu()
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
                        local pinData = Editor:GetPinData(self.pinNode)
                        local currentIcon = not pinData.usesAtlas and pinData.texture or nil
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

function MapPinEnhancedGroupEditorContentPinEntryMixin:ApplyPosition()
    local node = assert(self.pinNode)
    local selectedMap = self.mapField.child.value
    local mapText = self.mapField.child:GetText() or ""
    local mapID = selectedMap and selectedMap.label == mapText and selectedMap.value or FindExactMap(mapText)
    local x, y =
        Editor:ParsePercent(self.xField.child:GetText()), Editor:ParsePercent(self.yField.child:GetText())
    if not mapID then
        self.mapField.child:SetValue(assert(self.mapField.child.appliedMapID,
            "MapPinEnhancedGroupEditorContentPinEntryMixin:ApplyPosition: appliedMapID is nil"))
        return false
    end
    if not x or not y then return false end
    node.group:SetPinPosition(node.pinID, mapID, x, y)
    self.mapField.child.appliedText = GetMapDisplay(mapID)
    self.mapField.child.appliedMapID = mapID
    self.xField.child.appliedText, self.yField.child.appliedText =
        Editor:FormatPercent(x), Editor:FormatPercent(y)
    self.mapField.child:SetValue(mapID)
    return true
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@param editor MapPinEnhancedGroupEditorTemplate
function MapPinEnhancedGroupEditorContentPinEntryMixin:Init(pinNode, editor)
    self.pinNode, self.editor = pinNode, editor
    local pinData = Editor:GetPinData(pinNode)
    self:RefreshPreview()

    self.nameField.child:SetTextApply(pinData.title or L["Map Pin"], function(value)
        if value == "" then value = L["Map Pin"] end
        pinNode.group:SetPinTitle(pinNode.pinID, value)
        return value
    end)

    EnsureMapCache()
    self.mapField.child.onChangeCallback = nil
    self.mapField.child:Setup({
        options = mapOptions,
        init = function() return pinData.mapID end,
        onChange = function() self:ApplyPosition() end,
    })
    self.mapField.child.appliedText = GetMapDisplay(pinData.mapID)
    self.mapField.child.appliedMapID = pinData.mapID
    self.xField.child.appliedText, self.yField.child.appliedText =
        Editor:FormatPercent(pinData.x), Editor:FormatPercent(pinData.y)
    self.mapField.child:SetValue(pinData.mapID)
    self.xField.child:SetValue(self.xField.child.appliedText)
    self.yField.child:SetValue(self.yField.child.appliedText)

    local function applyPosition(editBox)
        self:ApplyPosition()
        editBox:ClearFocus()
    end
    local function restore(editBox)
        if editBox == self.mapField.child then
            editBox:SetValue(assert(editBox.appliedMapID,
                "MapPinEnhancedGroupEditorContentPinEntryMixin:Init: appliedMapID is nil"))
        else
            editBox:SetValue(assert(editBox.appliedText,
                "MapPinEnhancedGroupEditorContentPinEntryMixin:Init: appliedText is nil"))
        end
        editBox:ClearFocus()
    end
    for _, editBox in ipairs({ self.xField.child, self.yField.child }) do
        editBox:SetScript("OnEnterPressed", applyPosition)
        editBox:SetScript("OnEditFocusLost", applyPosition)
        editBox:SetScript("OnEscapePressed", restore)
    end
    self.mapField.child:SetScript("OnEditFocusLost", function(editBox)
        MapPinEnhancedAutocompleteMixin.OnEditFocusLost(editBox)
        applyPosition(editBox)
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
            MapPinEnhanced:ShowConfirmDialog(L["Delete Pin"],
                string.format(L["Delete pin \"%s\"?"], pinData.title or L["Map Pin"]), remove)
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
function MapPinEnhancedGroupEditorContentPinEntryMixin:SetDropTarget(placement)
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

function MapPinEnhancedGroupEditorContentPinEntryMixin:ClearDropTarget()
    self.dropLine:Hide()
end

---@return "before"|"after"
function MapPinEnhancedGroupEditorContentPinEntryMixin:GetDropPlacement()
    local _, cursorY = GetCursorPosition()
    cursorY = cursorY / self:GetEffectiveScale()
    return cursorY >= self:GetTop() - self:GetHeight() / 2 and "before" or "after"
end
