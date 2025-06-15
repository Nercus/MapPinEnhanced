---@class NercLibPrivate : NercLib
local NercLib = _G.NercLib


---@enum (key) LogLevel
local LOGGING_LEVEL_COLOR = {
    DEBUG = CreateColor(0.7, 0.8, 0.9),
    INFO = CreateColor(0.2, 0.8, 0.2),
    WARN = CreateColor(1.0, 1.0, 0.0),
    ERROR = CreateColor(1.0, 0.0, 0.0),
}
local TIMESTAMP_COLOR = CreateColor(0.5, 0.5, 0.5)


---@class LogEntryFrame : Frame
---@field message FontString
---@field init boolean

---@class LogMessageInfo
---@field message string
---@field timestamp string
---@field level LogLevel

---@param addon NercLibAddon
function NercLib:AddLoggingModule(addon)
    ---@class Logging
    ---@field lines LogMessageInfo[]
    local Logging = addon:GetModule("Logging")
    Logging.lines = {}

    local Text = addon:GetModule("Text")
    local Utils = addon:GetModule("Utils")
    local SavedVars = addon:GetModule("SavedVars")
    local SlashCommand = addon:GetModule("SlashCommand")


    local function UpdateWindowData()
        if not Logging.loggingWindow then return end
        local loggingEnabled = SavedVars:GetVar("logging")
        if not loggingEnabled then return end
        local DP = Logging.loggingWindow.DataProvider
        local searchText = Logging.loggingWindow.searchFilter
        local enabledFilters = Logging.loggingWindow.enabledFilters
        local scrollBox = Logging.loggingWindow.scrollBox
        scrollBox:SetScrollPercentage(0)
        DP:Flush()
        if #Logging.lines == 0 then
            return
        end

        ---@type LogMessageInfo[]
        local filtered = {}
        -- filter by search and selected log levels
        for _, line in ipairs(Logging.lines) do
            if not searchText or string.find(line.message, searchText) then
                if enabledFilters[line.level] then
                    table.insert(filtered, line)
                end
            end
        end
        DP:InsertTable(filtered)
    end
    local debounceUpdateWindowData = Utils:DebounceChange(UpdateWindowData, 0.2)

    local function CreateLoggingWindow()
        local loggingWindow = CreateFrame("Frame", addon.name .. "LoggingWindow", UIParent, "DefaultPanelTemplate")
        tinsert(UISpecialFrames, loggingWindow:GetName());
        loggingWindow:SetSize(400, 200)
        loggingWindow:SetMovable(true)
        loggingWindow:EnableMouse(true)
        loggingWindow:RegisterForDrag("LeftButton")
        loggingWindow:SetResizable(true)
        loggingWindow:SetResizeBounds(200, 200, GetScreenWidth(), GetScreenHeight())
        loggingWindow:SetMovable(true)
        loggingWindow:SetScript("OnMouseDown", function(self)
            if not self.NineSlice.TopEdge:IsMouseOver() then
                return
            end
            self:StartMoving()
        end)
        loggingWindow:SetScript("OnMouseUp", loggingWindow.StopMovingOrSizing)
        loggingWindow:SetClampedToScreen(true)
        loggingWindow:SetFrameStrata("FULLSCREEN")
        loggingWindow:SetTitle(addon.name .. " Logging")
        loggingWindow:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 5, 5)
        loggingWindow:SetResizable(true)

        loggingWindow:SetScript("OnDragStart", function(self)
            if not self.NineSlice.TopEdge:IsMouseOver() then
                return
            end
            self:StartMoving()
        end)

        loggingWindow:SetScript("OnDragStop", function(self)
            self:StopMovingOrSizing()
        end)


        local Menu = addon:GetModule("Menu")
        local filterButton = CreateFrame("DropdownButton", nil, loggingWindow, "WowStyle1ArrowDropdownTemplate")
        filterButton:SetPoint("TOPRIGHT", loggingWindow, "TOPRIGHT", -5, -24)
        ---@type table<string, boolean>
        loggingWindow.enabledFilters = {}
        local MenuTemplate = {
            {
                type = "title",
                label = "Filter by log level"
            },
        }

        for level, _ in pairs(LOGGING_LEVEL_COLOR) do
            loggingWindow.enabledFilters[level] = true
            table.insert(MenuTemplate, {
                type = "checkbox",
                label = Text:WrapTextInColor(level, LOGGING_LEVEL_COLOR[level]),
                isSelected = function() return loggingWindow.enabledFilters[level] end,
                setSelected = function()
                    loggingWindow.enabledFilters[level] = not loggingWindow.enabledFilters[level]; debounceUpdateWindowData()
                end
            })
        end
        local GeneratorFunction = Menu:GetGeneratorFunction(MenuTemplate)
        filterButton:SetupMenu(GeneratorFunction);


        loggingWindow.searchFilter = ""
        local searchBox = CreateFrame("EditBox", nil, loggingWindow, "InputBoxInstructionsTemplate")
        searchBox:SetSize(1, 20)
        searchBox:SetAutoFocus(false)
        searchBox:SetPoint("TOPLEFT", loggingWindow, "TOPLEFT", 15, -25)
        searchBox:SetPoint("TOPRIGHT", filterButton, "TOPLEFT", -5, 0)
        searchBox:SetTextInsets(16, 5, 0, 0)
        searchBox.searchIcon = searchBox:CreateTexture(nil, "ARTWORK")
        searchBox.searchIcon:SetAtlas("common-search-magnifyingglass")
        searchBox.searchIcon:SetSize(10, 10)
        searchBox.searchIcon:SetPoint("LEFT", searchBox, "LEFT", 1, -1)

        local searchBoxClearButton = CreateFrame("Button", nil, searchBox)
        searchBoxClearButton:SetSize(10, 10)
        searchBoxClearButton:SetPoint("RIGHT", searchBox, "RIGHT", -3, 0)
        searchBoxClearButton:SetNormalAtlas("common-search-clearbutton")
        searchBoxClearButton:SetHighlightAtlas("common-roundhighlight")
        searchBoxClearButton:SetScript("OnClick", function()
            searchBox:SetText("")
            loggingWindow.searchFilter = ""
            debounceUpdateWindowData()
        end)
        searchBoxClearButton:Hide()
        ---@type string
        local lastText
        searchBox:SetScript("OnTextChanged", function(searchBoxFrame)
            ---@type string
            local searchBoxText = searchBoxFrame:GetText()
            if searchBoxText == "" then
                searchBoxClearButton:Hide()
            else
                searchBoxClearButton:Show()
            end
            if searchBoxText == lastText then return end
            lastText = searchBoxText
            loggingWindow.searchFilter = searchBoxText
            debounceUpdateWindowData()
        end)





        local resizeButton = CreateFrame("Button", nil, loggingWindow, "PanelResizeButtonTemplate")
        resizeButton:SetPoint("BOTTOMRIGHT", -3, 4)
        resizeButton:SetSize(12, 12)
        resizeButton:RegisterForDrag("LeftButton")
        resizeButton:Init(loggingWindow, 200, 200, GetScreenWidth(), GetScreenHeight())


        local scrollBox = CreateFrame("Frame", nil, loggingWindow, "WowScrollBoxList")
        scrollBox:SetPoint("TOPLEFT", searchBox, "BOTTOMLEFT", -5, -5)
        scrollBox:SetPoint("BOTTOMRIGHT", loggingWindow, "BOTTOMRIGHT", -5, 5)
        loggingWindow.scrollBox = scrollBox

        local scrollBar = CreateFrame("EventFrame", nil, loggingWindow, "MinimalScrollBar")
        scrollBar:SetPoint("TOPRIGHT", filterButton, "BOTTOMRIGHT", -7, -5)
        scrollBar:SetPoint("BOTTOMRIGHT", loggingWindow, "BOTTOMRIGHT", -5, 15)


        loggingWindow.DataProvider = CreateDataProvider()
        local scrollView = CreateScrollBoxListLinearView()
        loggingWindow.scrollView = scrollView
        scrollView:SetDataProvider(loggingWindow.DataProvider)

        ScrollUtil.InitScrollBoxListWithScrollBar(scrollBox, scrollBar, scrollView)

        ---@param frame LogEntryFrame
        ---@param messageInfo LogMessageInfo
        local function Initializer(frame, messageInfo)
            if not frame.init then
                frame:SetSize(1, 14)
                frame:SetPoint("LEFT", 0, 0)
                frame:SetPoint("RIGHT", 0, 0)
                frame.message = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
                frame.message:SetAllPoints()
                frame.message:SetJustifyH("LEFT")
                frame.message:SetWordWrap(false)
                frame.init = true
            end

            local color = LOGGING_LEVEL_COLOR[messageInfo.level]
            local logMessage = string.format("[%s] (%s) %s",
                Text:WrapTextInColor(messageInfo.timestamp, TIMESTAMP_COLOR),
                Text:WrapTextInColor(messageInfo.level, color),
                Text:WrapTextInColor(messageInfo.message, color)
            )
            frame.message:SetText(logMessage)
        end
        scrollView:SetElementExtent(14)
        scrollView:SetElementInitializer("Frame", Initializer)
        loggingWindow.DataProvider:InsertTable(Logging.lines)
        loggingWindow:Show()
        Logging.loggingWindow = loggingWindow
    end


    local function AddLogLine(messageInfo)
        table.insert(Logging.lines, messageInfo)
        if not Logging.loggingWindow then return end
        debounceUpdateWindowData()
    end

    local loggingWindowShown = false
    local function OpenLoggingWindow()
        if not Logging.loggingWindow then
            CreateLoggingWindow()
        end
        Logging.loggingWindow:Show()
        loggingWindowShown = true
    end

    local function CloseLoggingWindow()
        if Logging.loggingWindow then
            Logging.loggingWindow:Hide()
            loggingWindowShown = false
        end
    end

    function Logging:ToggleLoggingWindow()
        if loggingWindowShown then
            CloseLoggingWindow()
        else
            OpenLoggingWindow()
        end
    end

    local function UpdateSlashCommandAvailability()
        local loggingEnabled = SavedVars:GetVar("logging")
        if loggingEnabled then
            SlashCommand:AddSlashCommand("log", function() Logging:ToggleLoggingWindow() end, "Toggle logging window")
        else
            SlashCommand:RemoveSlashCommand("log")
        end
    end

    function Logging:EnableLogging()
        SavedVars:SetVar("logging", true)
        UpdateSlashCommandAvailability()
        OpenLoggingWindow()
    end

    function Logging:DisableLogging()
        SavedVars:SetVar("logging", false)
        UpdateSlashCommandAvailability()
        if Logging.loggingWindow then
            Logging.loggingWindow:Hide()
        end
    end

    ---@param message string
    ---@param level LogLevel?
    function Logging:Log(message, level)
        if not level or not LOGGING_LEVEL_COLOR[level] then
            level = "DEBUG"
        end
        AddLogLine({
            message = message,
            timestamp = date("%H:%M:%S"),
            level = level
        })
    end

    SlashCommand:AddSlashCommand("enableLogging", function() Logging:EnableLogging() end, "Enable logging")
    SlashCommand:AddSlashCommand("disableLogging", function() Logging:DisableLogging() end, "Disable logging")
    C_Timer.After(0.1, function() UpdateSlashCommandAvailability() end)
end
