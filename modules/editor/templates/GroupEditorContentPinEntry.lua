---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Pins = MapPinEnhanced:GetModule("Pins")
local Editor = MapPinEnhanced:GetModule("Editor")
local L = MapPinEnhanced.L
local BACKGROUND_COLOR = CreateColor(1, 1, 1, 0.5)
local BACKGROUND_HOVER_COLOR = CreateColor(1, 1, 1, 0.75)
local BACKGROUND_END_COLOR = CreateColor(1, 1, 1, 0)

---@class MapPinEnhancedEditorAppliedAutocomplete : MapPinEnhancedAutocompleteTemplate
---@field appliedText string?
---@field appliedMapID number?

---@class MapPinEnhancedEditorAutocompleteField : MapPinEnhancedFormFieldTemplate
---@field child MapPinEnhancedEditorAppliedAutocomplete

---@class MapPinEnhancedEditorPositionInput : MapPinEnhancedInputTemplate
---@field appliedText string?
---@field validText string?

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
---@field background Texture
MapPinEnhancedGroupEditorContentPinEntryMixin = {}

---@class MapPinEnhancedEditorMapEntry
---@field mapID number
---@field name string
---@field search string

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

---@param input EditBox
function MapPinEnhancedGroupEditorContentPinEntryMixin:OnInputTabPressed(input)
    if not self.editor or not self.pinNode then return end
    self.editor.groupEditorContent:FocusNextPinInput(self, input)
end

---@param input MapPinEnhancedEditorPositionInput
---@param userInput boolean
function MapPinEnhancedGroupEditorContentPinEntryMixin:OnCoordinateTextChanged(input, userInput)
    local text = input:GetText() or ""
    -- Empty text and a decimal point are temporary drafts while replacing a value.
    if userInput and text ~= "" and text ~= "." and not Editor:ParsePercent(text) then
        local cursor = input:GetCursorPosition()
        input:SetText(input.validText or input.appliedText or "")
        input:SetCursorPosition(math.max(0, cursor - 1))
    else
        input.validText = text
    end
    input:UpdateClearButtonVisibility()
    input:UpdatePlaceholderVisibility()
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:OnEnter()
    self.background:SetGradient("HORIZONTAL", BACKGROUND_HOVER_COLOR, BACKGROUND_END_COLOR)
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:OnLeave()
    self.background:SetGradient("HORIZONTAL", BACKGROUND_COLOR, BACKGROUND_END_COLOR)
end

function MapPinEnhancedGroupEditorContentPinEntryMixin:Reset()
    self:OnLeave()
    self.nameField.child:ClearTextApply()
    self.mapField.child:Reset()
    self.mapField.child.appliedText = nil
    self.mapField.child.appliedMapID = nil
    self.mapField.child:SetScript("OnEditFocusLost", MapPinEnhancedAutocompleteMixin.OnEditFocusLost)
    self.mapField.child:SetScript("OnEscapePressed", MapPinEnhancedInputMixin.OnEscapePressed)
    self.mapField.child:ClearFocus()
    self.mapField.child.resultsFrame:Hide()
    for _, editBox in ipairs({ self.xField.child, self.yField.child }) do
        editBox.appliedText = nil
        editBox.validText = nil
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
    if GameTooltip:IsOwned(self.pinFrame) then GameTooltip:Hide() end
    self.pinFrame:SetScript("OnEnter", nil)
    self.pinFrame:SetScript("OnLeave", nil)
    self.pinFrame:SetScript("OnHide", MapPinEnhancedBasePinMixin.OnPinHide)
    self.pinFrame:SetScript("OnMouseDown", nil)
    self.deleteButton.tooltipInteractions = nil
    self.deleteButton:OnTooltipLeave()
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

function MapPinEnhancedGroupEditorContentPinEntryMixin:ShowStyleMenu()
    local node = assert(self.pinNode)
    local group, pinID = node.group, node.pinID
    local groupID, lifetime = group:GetGroupID(), group.lifetimeChangeNumber
    local data = Editor:GetPinData(node)
    local function IsCurrent()
        return group:IsSameGroup(groupID, lifetime) and
            (group:GetPinByID(pinID) ~= nil or group:GetArchivedPinByID(pinID) ~= nil)
    end
    -- The picker outlives recycled rows. Mutate the captured identity and only
    -- refresh this row if it is still presenting that same node.
    local menu = Pins:BuildPinStyleMenuEntries(node,
        function()
            if not IsCurrent() then return data end
            local pin = group:GetPinByID(pinID)
            local archived = not pin and group:GetArchivedPinByID(pinID)
            return pin and pin:GetPinData() or archived and archived.data or data
        end,
        function(color)
            if not IsCurrent() then return end
            group:SetPinColor(pinID, color)
            if self.pinNode == node then self:RefreshPreview() end
        end,
        function(icon, usesAtlas)
            if not IsCurrent() then return end
            group:SetPinIcon(pinID, icon, usesAtlas)
            if self.pinNode == node then self:RefreshPreview() end
        end)
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
        MapPinEnhanced:FormatPercent(x), MapPinEnhanced:FormatPercent(y)
    self.mapField.child:SetValue(mapID)
    return true
end

---@param pinNode MapPinEnhancedEditorPinNodeData
---@param editor MapPinEnhancedGroupEditorTemplate
function MapPinEnhancedGroupEditorContentPinEntryMixin:Init(pinNode, editor)
    self:Reset()
    self.pinNode, self.editor = pinNode, editor
    local pinData = Editor:GetPinData(pinNode)
    self:RefreshPreview()

    self.nameField.child:SetTextApply(pinData.title or L["Map Pin"], function(value)
        if value == "" then value = L["Map Pin"] end
        pinNode.group:SetPinTitle(pinNode.pinID, value)
        return value
    end)

    EnsureMapCache()
    self.mapField.child:Setup({
        options = mapOptions,
        init = function() return pinData.mapID end,
        onChange = function() self:ApplyPosition() end,
    })
    self.mapField.child.appliedText = GetMapDisplay(pinData.mapID)
    self.mapField.child.appliedMapID = pinData.mapID
    self.xField.child.appliedText, self.yField.child.appliedText =
        MapPinEnhanced:FormatPercent(pinData.x), MapPinEnhanced:FormatPercent(pinData.y)
    self.mapField.child:SetValue(pinData.mapID)
    self.xField.child:SetValue(self.xField.child.appliedText)
    self.yField.child:SetValue(self.yField.child.appliedText)

    local function applyPosition(editBox)
        self:ApplyPosition()
        for _, input in ipairs({ self.xField.child, self.yField.child }) do
            input:SetValue(input.appliedText or "")
        end
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
        editBox:SetScript("OnEditFocusLost", function(input)
            MapPinEnhancedInputMixin.OnEditFocusLost(input)
            applyPosition(input)
        end)
        editBox:SetScript("OnEscapePressed", restore)
    end
    self.mapField.child:SetScript("OnEditFocusLost", function(editBox)
        MapPinEnhancedAutocompleteMixin.OnEditFocusLost(editBox)
        -- A result click applies its own map; do not restore the draft before OnClick.
        if editBox.resultsFrame:IsShown() then return end
        applyPosition(editBox)
    end)
    self.mapField.child:SetScript("OnEscapePressed", restore)

    self.pinFrame:SetScript("OnEnter", function(frame)
        local data = Editor:GetPinData(pinNode)
        local showLockHint = MapPinEnhanced:GetModule("Options"):GetOptionValue("Pins.EnableLockedPins") ==
            true
        GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
        MapPinEnhanced:AddTooltipInteractions(GameTooltip, {
            { L["Left Click"],   L["Change pin appearance"] },
            { L["Middle Click"], showLockHint and (data.lock and L["Unlock Pin"] or L["Lock Pin"]) or nil },
        })
        if GameTooltip:NumLines() > 0 then GameTooltip:Show() end
    end)
    local function hidePreviewTooltip(frame)
        if GameTooltip:IsOwned(frame) then GameTooltip:Hide() end
    end
    self.pinFrame:SetScript("OnLeave", hidePreviewTooltip)
    self.pinFrame:SetScript("OnHide", function(frame)
        frame:OnPinHide()
        hidePreviewTooltip(frame)
    end)
    self.deleteButton.tooltipInteractions = {
        { L["Left Click"],         L["Delete Permanently"] },
        { L["Shift + Left Click"], L["Delete without confirmation"] },
    }
    self.pinFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then self:ShowStyleMenu() end
        if button == "MiddleButton" then
            local pinData = Editor:GetPinData(pinNode)
            if not pinData.lock and not MapPinEnhanced:GetModule("Options"):GetOptionValue("Pins.EnableLockedPins") then return end
            pinNode.group:SetPinLock(pinNode.pinID, not pinData.lock)
            self:RefreshPreview()
        end
    end)
    self.duplicateButton:SetScript("OnClick", function()
        if pinNode.group:DuplicatePin(pinNode.pinID) then editor:RequestRefresh() end
    end)
    local groupID, lifetime = pinNode.group:GetGroupID(), pinNode.group.lifetimeChangeNumber
    self.deleteButton:SetScript("OnClick", function()
        local function remove()
            if pinNode.group:IsSameGroup(groupID, lifetime) then pinNode.group:RemovePin(pinNode.pinID) end
        end
        if IsShiftKeyDown() then
            remove()
        else
            MapPinEnhanced:ShowConfirmDialog(L["Delete Permanently"],
                string.format(L["Delete pin \"%s\"?"], pinData.title or L["Map Pin"]), remove)
        end
    end)
    self.dragHandle:SetScript("OnEnter", function()
        self:OnEnter()
        if editor.draggedPinNode then
            SetCursorByMode(Enum.Cursormode.HoldingHandCursor)
        else
            SetCursorByMode(Enum.Cursormode.GrabbingHandCursor)
        end
    end)
    self.dragHandle:SetScript("OnLeave", function()
        self:OnLeave()
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

function MapPinEnhancedGroupEditorContentPinEntryMixin:EditDescription()
    if not self.pinNode then return end
    Editor:EditDescription(self.pinNode.group:GetGroupID(), self.pinNode.pinID)
end
