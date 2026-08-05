---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

local L = MapPinEnhanced.L

---@alias MapPinEnhancedIconTexture string|number

---@class MapPinEnhancedIconPickerEntry
---@field path MapPinEnhancedIconTexture
---@field name string
---@field search string

local COLUMN_COUNT = 8
local CELL_SIZE = 42
local CELL_SPACING = 4
local ROW_HEIGHT = CELL_SIZE + CELL_SPACING
local SEARCH_DEBOUNCE_SECONDS = 0.15
local DOUBLE_CLICK_SECONDS = 0.35
---@type MapPinEnhancedIconPickerWindowTemplate?
local iconPickerWindow

---@param path MapPinEnhancedIconTexture
---@return string
local function GetIconName(path)
    local value = tostring(path)
    local name = value:match("([^\\/]+)$") or value
    return name:gsub("%.[Bb][Ll][Pp]$", ""):gsub("%.[Tt][Gg][Aa]$", "")
end

---@class MapPinEnhancedIconPickerRowData
---@field icons MapPinEnhancedIconPickerEntry[]
---@field startIndex number

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

---@param data MapPinEnhancedIconPickerRowData
function MapPinEnhancedIconPickerRowMixin:Init(data)
    for column, button in ipairs(self.buttons) do
        local icon = data.icons[data.startIndex + column - 1]
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
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar
---@field cancelButton Button
---@field confirmButton Button
---@field dataProvider DataProviderMixin
---@field scrollView ScrollBoxListLinearViewMixin
---@field selected MapPinEnhancedIconPickerEntry?
---@field callback fun(path: string|number)?
---@field searchTimer FunctionContainer?
---@field icons MapPinEnhancedIconPickerEntry[]?
MapPinEnhancedIconPickerWindowMixin = {}

---@return MapPinEnhancedIconPickerEntry[]
function MapPinEnhancedIconPickerWindowMixin:GetIcons()
    if self.icons then return self.icons end

    ---@type IconDataProviderMixin
    local provider = CreateAndInitFromMixin(IconDataProviderMixin, IconDataProviderExtraType.Spellbook)
    ---@type MapPinEnhancedIconPickerEntry[]
    local icons = {}
    ---@type table<string, boolean>
    local seen = {}
    for index = 1, provider:GetNumIcons() do
        local path = provider:GetIconByIndex(index)
        if type(path) == "string" or type(path) == "number" then
            local key = tostring(path)
            if not seen[key] then
                seen[key] = true
                local name = GetIconName(path)
                icons[#icons + 1] = {
                    path = path,
                    name = name,
                    search = string.lower(name .. " " .. key),
                }
            end
        end
    end
    provider:Release()
    self.icons = icons
    return icons
end

function MapPinEnhancedIconPickerWindowMixin:OnLoad()
    MapPinEnhancedWindowMixin.OnLoad(self)
    iconPickerWindow = self
    self.search:SetInlineIcon("search")
    self.search:SetPlaceholderText(L["Search"])
    self.cancelButton:SetText(L["Cancel"])
    self.confirmButton:SetText(L["Confirm"])

    self.dataProvider = CreateDataProvider()
    self.scrollView = CreateScrollBoxListLinearView()
    self.scrollView:SetElementExtent(ROW_HEIGHT)
    self.scrollView:SetElementInitializer("MapPinEnhancedIconPickerRowTemplate", function(row, data)
        ---@cast row MapPinEnhancedIconPickerRowTemplate
        ---@cast data MapPinEnhancedIconPickerRowData
        row:Init(data)
    end)
    self.scrollView:SetElementResetter(function(row)
        ---@cast row MapPinEnhancedIconPickerRowTemplate
        row:Reset()
    end)
    self.scrollView:SetDataProvider(self.dataProvider)
    self.scrollBar:SetHideIfUnscrollable(true)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.scrollBox, self.scrollBar, self.scrollView)

    self.search:SetScript("OnTextChanged", function(_, userInput)
        if not userInput then return end
        if self.searchTimer then self.searchTimer:Cancel() end
        self.searchTimer = C_Timer.NewTimer(SEARCH_DEBOUNCE_SECONDS, function()
            self.searchTimer = nil
            self:Refresh()
        end)
    end)
    self.search:SetScript("OnEnterPressed", function(editBox)
        editBox:ClearFocus()
        if self.searchTimer then
            self.searchTimer:Cancel()
            self.searchTimer = nil
        end
        self:Refresh()
    end)
    self.search:SetScript("OnEscapePressed", function(editBox)
        editBox:SetText("")
        editBox:ClearFocus()
        self:Refresh()
    end)
    self.cancelButton:SetScript("OnClick", function() self:Cancel() end)
    self.confirmButton:SetScript("OnClick", function() self:Confirm() end)
end

function MapPinEnhancedIconPickerWindowMixin:OnHide()
    MapPinEnhancedWindowMixin.OnHide(self)
    if self.searchTimer then
        self.searchTimer:Cancel()
        self.searchTimer = nil
    end
    self.callback = nil
end

function MapPinEnhancedIconPickerWindowMixin:Refresh()
    local query = string.lower(strtrim(self.search:GetText() or ""))
    local source = self:GetIcons()
    local filtered = source
    if query ~= "" then
        filtered = {}
        for _, icon in ipairs(source) do
            if string.find(icon.search, query, 1, true) then
                filtered[#filtered + 1] = icon
            end
        end
    end

    self.dataProvider:Flush()
    for startIndex = 1, #filtered, COLUMN_COUNT do
        self.dataProvider:Insert({ icons = filtered, startIndex = startIndex })
    end
    self.resultCount:SetText(string.format(L["%d icons"], #filtered))
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
    } or nil
    self.preview:SetTexture(currentIcon or nil)
    self.preview:SetShown(currentIcon ~= nil)
    self.selectedName:SetText(self.selected and self.selected.name or L["Select an icon"])
    self.confirmButton:SetEnabled(self.selected ~= nil)
    self:Refresh()
    self:Show()
    self:Raise()
end

---@param currentIcon string|number?
---@param callback fun(path: string|number)
function MapPinEnhanced:ShowIconPicker(currentIcon, callback)
    assert(iconPickerWindow, "Icon picker window is not loaded"):Open(currentIcon, callback)
end
