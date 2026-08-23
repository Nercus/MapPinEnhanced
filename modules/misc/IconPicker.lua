---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@alias MapPinEnhancedIconTexture string|number

---@class MapPinEnhancedIconPickerEntry
---@field path MapPinEnhancedIconTexture
---@field name string
---@field search string
---@field pathSearch string

local COLUMN_COUNT = 8
local CELL_SIZE = 42
local CELL_SPACING = 4
local ROW_HEIGHT = CELL_SIZE + CELL_SPACING
local SEARCH_DEBOUNCE_SECONDS = 0.15
local DOUBLE_CLICK_SECONDS = 0.35
local PRECACHE_CHUNK_SIZE = 100
local PRECACHE_REFRESH_INTERVAL = 5
---@type MapPinEnhancedIconPickerWindowTemplate?
local iconPickerWindow

---@class MapPinEnhancedIconPickerRowTemplate : Frame
---@field buttons MapPinEnhancedIconPickerButton[]
MapPinEnhancedIconPickerRowMixin = {}

---@class MapPinEnhancedIconPickerButton : Button
---@field icon Texture
---@field selected Texture
---@field iconData MapPinEnhancedIconPickerEntry?
---@field lastClickIcon MapPinEnhancedIconPickerEntry?
---@field lastClickTime number?

---@param button MapPinEnhancedIconPickerButton
local function SetTooltip(button)
    local icon = button.iconData
    if not icon then return end
    GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
    GameTooltip:AddLine(icon.name)
    if tostring(icon.path) ~= icon.name then
        GameTooltip:AddLine(tostring(icon.path), 0.65, 0.65, 0.65, true)
    end
    GameTooltip:Show()
end

function MapPinEnhancedIconPickerRowMixin:OnLoad()
    ---@type MapPinEnhancedIconPickerButton[]
    self.buttons = {}
    for column = 1, COLUMN_COUNT do
        ---@type MapPinEnhancedIconPickerButton
        local button = CreateFrame("Button", nil, self)
        button:SetSize(CELL_SIZE, CELL_SIZE)
        button:SetPoint("LEFT", (column - 1) * (CELL_SIZE + CELL_SPACING), 0)

        button.icon = button:CreateTexture(nil, "ARTWORK")
        button.icon:SetPoint("TOPLEFT", 2, -2)
        button.icon:SetPoint("BOTTOMRIGHT", -2, 2)

        button.selected = button:CreateTexture(nil, "OVERLAY")
        button.selected:SetAtlas("UI-HUD-ActionBar-IconFrame-Mouseover")
        button.selected:SetAllPoints()
        button.selected:Hide()

        button:SetHighlightAtlas("UI-HUD-ActionBar-IconFrame-Mouseover")
        button:SetScript("OnEnter", SetTooltip)
        button:SetScript("OnLeave", function() GameTooltip:Hide() end)
        button:SetScript("OnClick", function(clicked)
            ---@cast clicked MapPinEnhancedIconPickerButton
            if not clicked.iconData then return end
            local window = assert(iconPickerWindow, "Icon picker window is not loaded")
            window:Select(clicked.iconData)
            local now = GetTime()
            if clicked.lastClickIcon == clicked.iconData and
                now - (clicked.lastClickTime or 0) <= DOUBLE_CLICK_SECONDS then
                window:Confirm()
            end
            clicked.lastClickIcon = clicked.iconData
            clicked.lastClickTime = now
        end)
        self.buttons[column] = button
    end
end

---@param rowIndex number
function MapPinEnhancedIconPickerRowMixin:Init(rowIndex)
    local window = assert(iconPickerWindow, "Icon picker window is not loaded")
    local startIndex = (rowIndex - 1) * COLUMN_COUNT + 1
    for column, button in ipairs(self.buttons) do
        local icon = window.filteredIcons[startIndex + column - 1]
        button.iconData = icon
        button:SetShown(icon ~= nil)
        if icon then
            button.icon:SetTexture(icon.path)
            local selected = iconPickerWindow and iconPickerWindow.selected
            button.selected:SetShown(selected ~= nil and selected.path == icon.path)
        end
    end
end

function MapPinEnhancedIconPickerRowMixin:Reset()
    for _, button in ipairs(self.buttons) do
        button.iconData = nil
        button.lastClickIcon = nil
        button.lastClickTime = nil
        button:Hide()
    end
end

---@class MapPinEnhancedIconPickerWindowTemplate : MapPinEnhancedWindowTemplate
---@field search MapPinEnhancedInputTemplate
---@field preview Texture
---@field selectedName FontString
---@field resultCount FontString
---@field loadingSpinner Texture
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar
---@field cancelButton MapPinEnhancedButtonTemplate
---@field confirmButton MapPinEnhancedButtonTemplate
---@field dataProvider IndexRangeDataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field selected MapPinEnhancedIconPickerEntry?
---@field callback fun(path: string|number)?
---@field scheduleSearch fun()
---@field cancelSearch fun()
---@field flushSearch fun()
---@field icons MapPinEnhancedIconPickerEntry[]
---@field filteredIcons MapPinEnhancedIconPickerEntry[]
---@field lastQuery string?
---@field isPrecacheStarted boolean
---@field isPrecacheComplete boolean
MapPinEnhancedIconPickerWindowMixin = {}

function MapPinEnhancedIconPickerWindowMixin:StartPrecache()
    if self.isPrecacheStarted then return end
    self.isPrecacheStarted = true
    local iconFileNames = MapPinEnhanced.ICON_FILE_NAMES
    assert(type(iconFileNames) == "table",
        "MapPinEnhancedIconPickerWindowMixin:StartPrecache: icon file names are unavailable")
    ---@type number[]
    local iconFileIDs = {}
    for fileID in pairs(iconFileNames) do
        if type(fileID) == "number" then
            iconFileIDs[#iconFileIDs + 1] = fileID
        end
    end
    table.sort(iconFileIDs)

    ---@type fun()[]
    local tasks = {}
    for startIndex = 1, #iconFileIDs, PRECACHE_CHUNK_SIZE do
        local firstIndex = startIndex
        local lastIndex = math.min(startIndex + PRECACHE_CHUNK_SIZE - 1, #iconFileIDs)
        tasks[#tasks + 1] = function()
            for index = firstIndex, lastIndex do
                local fileID = iconFileIDs[index]
                local name = iconFileNames[fileID]
                self.icons[#self.icons + 1] = {
                    path = fileID,
                    name = name,
                    search = string.lower(name),
                    pathSearch = tostring(fileID),
                }
            end
        end
    end

    MapPinEnhanced:BatchExecution(tasks, function(progress)
        if self:IsShown() and progress % PRECACHE_REFRESH_INTERVAL == 0 then
            self:Refresh()
        end
    end, function()
        self.isPrecacheComplete = true
        self.lastQuery = nil
        self:Refresh()
    end, 1)
end

function MapPinEnhancedIconPickerWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    iconPickerWindow = self
    self.search:SetInlineIcon("search")
    self.search:SetPlaceholderText(L["Search"])
    self.cancelButton:SetLabel(L["Cancel"])
    self.confirmButton:SetLabel(L["Confirm"])
    self.icons = {}
    self.filteredIcons = self.icons
    self.isPrecacheStarted = false
    self.isPrecacheComplete = false

    self.dataProvider = CreateIndexRangeDataProvider(0)
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetElementExtent(ROW_HEIGHT)
    self.scrollView:SetElementInitializer("MapPinEnhancedIconPickerRowTemplate", function(row, rowIndex)
        ---@cast row MapPinEnhancedIconPickerRowTemplate
        ---@cast rowIndex number
        row:Init(rowIndex)
    end)
    self.scrollView:SetElementResetter(function(row)
        ---@cast row MapPinEnhancedIconPickerRowTemplate
        row:Reset()
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.scrollBar:SetHideIfUnscrollable(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.scheduleSearch, self.cancelSearch, self.flushSearch = MapPinEnhanced:DebounceChange(function()
        self:Refresh()
    end, SEARCH_DEBOUNCE_SECONDS)

    self.search:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        self.scheduleSearch()
    end)
    self.search:SetScript("OnEnterPressed", function(editBox)
        editBox:ClearFocus()
        self.flushSearch()
    end)
    self.search:SetScript("OnEscapePressed", function(editBox)
        self.cancelSearch()
        editBox:SetText("")
        editBox:ClearFocus()
        self:Refresh()
    end)
    self.cancelButton:SetScript("OnClick", function() self:Cancel() end)
    self.confirmButton:SetScript("OnClick", function() self:Confirm() end)
end

function MapPinEnhancedIconPickerWindowMixin:OnHide()
    MapPinEnhancedWindowMixin.OnHide(self)
    self.cancelSearch()
    self.callback = nil
end

function MapPinEnhancedIconPickerWindowMixin:Refresh()
    local query = string.lower(strtrim(self.search:GetText() or ""))
    local source = self.icons
    if self.isPrecacheComplete and self.lastQuery and self.lastQuery ~= "" and
        #query >= #self.lastQuery and string.sub(query, 1, #self.lastQuery) == self.lastQuery then
        source = self.filteredIcons
    end

    local filtered = self.icons
    if query ~= "" then
        filtered = {}
        for _, icon in ipairs(source) do
            if string.find(icon.search, query, 1, true) or string.find(icon.pathSearch, query, 1, true) then
                filtered[#filtered + 1] = icon
            end
        end
    end

    self.filteredIcons = filtered
    self.lastQuery = query
    self.dataProvider:SetSize(math.ceil(#filtered / COLUMN_COUNT))
    self.scrollBox:ReinitializeFrames()
    self.loadingSpinner:SetShown(not self.isPrecacheComplete)
    if self.isPrecacheComplete then
        self.resultCount:SetText(string.format(L["%d icons"], #filtered))
    else
        self.resultCount:SetText(string.format(L["%d icons (loading...)"], #filtered))
    end
end

---@param icon MapPinEnhancedIconPickerEntry
function MapPinEnhancedIconPickerWindowMixin:Select(icon)
    self.selected = icon
    self.preview:SetTexture(icon.path)
    self.preview:Show()
    self.selectedName:SetText(icon.name)
    self.confirmButton:SetEnabled(true)
    self.scrollBox:ForEachFrame(function(row)
        ---@cast row MapPinEnhancedIconPickerRowTemplate
        for _, button in ipairs(row.buttons) do
            button.selected:SetShown(button.iconData ~= nil and button.iconData.path == icon.path)
        end
    end)
end

function MapPinEnhancedIconPickerWindowMixin:Confirm()
    if not self.selected or not self.callback then return end
    local callback = assert(self.callback)
    local path = self.selected.path
    self:Hide()
    callback(path)
end

function MapPinEnhancedIconPickerWindowMixin:Cancel()
    self:Hide()
end

---@param currentIcon string|number?
---@param callback fun(path: string|number)
function MapPinEnhancedIconPickerWindowMixin:Open(currentIcon, callback)
    assert(type(callback) == "function", "Icon picker callback must be a function")
    self.callback = callback
    self.search:SetText("")
    self.selected = currentIcon and {
        path = currentIcon,
        name = tostring(currentIcon):match("([^\\/]+)$") or tostring(currentIcon),
        search = "",
        pathSearch = "",
    } or nil
    self.preview:SetTexture(currentIcon or nil)
    self.preview:SetShown(currentIcon ~= nil)
    self.selectedName:SetText(self.selected and self.selected.name or L["Select an icon"])
    self.confirmButton:SetEnabled(self.selected ~= nil)
    self:Refresh()
    self:Show()
    self:Raise()
    if not self.isPrecacheStarted then
        C_Timer.After(0, function() self:StartPrecache() end)
    end
end

---@param currentIcon string|number?
---@param callback fun(path: string|number)
function MapPinEnhanced:ShowIconPicker(currentIcon, callback)
    assert(iconPickerWindow, "Icon picker window is not loaded"):Open(currentIcon, callback)
end

MapPinEnhanced:RegisterEvent("PLAYER_LOGIN", function()
    C_Timer.After(0, function()
        if iconPickerWindow then iconPickerWindow:StartPrecache() end
    end)
end)
