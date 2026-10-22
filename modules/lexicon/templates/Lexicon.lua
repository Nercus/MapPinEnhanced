---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)
local Lexicon = MapPinEnhanced:GetModule("Lexicon")
local L = MapPinEnhanced.L

---@class MapPinEnhancedLexiconResults : Frame
---@field message FontString
---@field scrollBox WowScrollBoxList
---@field scrollBar MinimalScrollBar
---@class MapPinEnhancedLexiconTemplate : Frame
---@field input MapPinEnhancedInputTemplate
---@field results MapPinEnhancedLexiconResults
---@field dataProvider DataProviderMixin
---@field selectedIndex number
MapPinEnhancedLexiconMixin = {}

function MapPinEnhancedLexiconMixin:OnLoad()
    self.input:SetPlaceholderText(L["Try a city, dungeon, or location name"])
    self.input:SetAltArrowKeyMode(false)
    self.dataProvider = CreateDataProvider()
    self.selectedIndex = 1
    local scrollView = CreateScrollBoxListLinearView()
    scrollView:SetElementInitializer("MapPinEnhancedLexiconRowTemplate", function(row, data)
        ---@cast row MapPinEnhancedLexiconRowTemplate
        ---@cast data LexiconResult
        row:ApplyResult(data)
        if self.dataProvider:Find(self.selectedIndex) == data then row:LockHighlight() else row:UnlockHighlight() end
    end)
    scrollView:SetElementResetter(function(row)
        ---@cast row MapPinEnhancedLexiconRowTemplate
        row:Reset()
    end)
    scrollView:SetDataProvider(self.dataProvider)
    ScrollUtil.InitScrollBoxListWithScrollBar(self.results.scrollBox, self.results.scrollBar, scrollView)
    self.results.scrollBar:SetHideIfUnscrollable(true)
end

---@param results LexiconResult[]
---@param message string?
function MapPinEnhancedLexiconMixin:ApplyResults(results, message)
    self.selectedIndex = 1
    self.dataProvider:Flush()
    self.dataProvider:InsertTable(results)
    self.results.message:SetText(message or "")
    local rowHeight = math.min(#results, Lexicon.MAX_VISIBLE_RESULTS) * Lexicon.ROW_HEIGHT
    local hasMessage = message ~= nil and message ~= ""
    self.results.message:SetShown(hasMessage)
    self.results.scrollBox:SetHeight(math.max(1, rowHeight))
    self.results.scrollBox:SetShown(#results > 0)
    -- Only the dropdown grows; the input's saved anchor never changes with results.
    self.results:SetHeight(16 + rowHeight + (hasMessage and 24 or 0))
    self.results:SetShown(#results > 0 or hasMessage)
    if #results > 0 then self:SelectIndex(1) end
end

---@param index number
function MapPinEnhancedLexiconMixin:SelectIndex(index)
    local count = self.dataProvider:GetSize()
    if count == 0 then return end
    self.selectedIndex = math.max(1, math.min(count, index))
    self.results.scrollBox:ScrollToElementDataIndex(self.selectedIndex, ScrollBoxConstants.AlignNearest, 0,
        ScrollBoxConstants.NoScrollInterpolation)
    self.results.scrollBox:ForEachFrame(function(row)
        ---@cast row MapPinEnhancedLexiconRowTemplate
        if row.result == self.dataProvider:Find(self.selectedIndex) then row:LockHighlight() else row:UnlockHighlight() end
    end)
end

---@param key string
function MapPinEnhancedLexiconMixin:OnInputKey(key)
    if key == "DOWN" then self:SelectIndex(self.selectedIndex + 1)
    elseif key == "UP" then self:SelectIndex(self.selectedIndex - 1) end
end

function MapPinEnhancedLexiconMixin:ActivateSelection()
    local result = self.dataProvider:Find(self.selectedIndex) --[[@as LexiconResult?]]
    if result then Lexicon:Activate(result) end
end

function MapPinEnhancedLexiconMixin:OnShow()
    MapPinEnhanced:RegisterDraggableFrame(self, "lexicon", self.input.inlineIcon)
    MapPinEnhanced:RestoreFrame(self)
    self:RegisterEvent("GLOBAL_MOUSE_DOWN")
end

function MapPinEnhancedLexiconMixin:OnEvent()
    for _, focus in ipairs(GetMouseFoci()) do
        while focus do
            if focus == self then return end
            focus = focus:GetParent()
        end
    end
    Lexicon:Hide()
end

function MapPinEnhancedLexiconMixin:OnHide()
    MapPinEnhanced:UnregisterDraggableFrame(self)
    self:UnregisterEvent("GLOBAL_MOUSE_DOWN")
    self.input:ClearFocus()
    Lexicon:ReleaseView()
    self.dataProvider:Flush()
    self.selectedIndex = 1
    self.results.message:SetText("")
    self.results:Hide()
end

function MapPinEnhancedLexiconMixin:Close()
    Lexicon:Hide()
end

function MapPinEnhancedLexiconMixin:OnInputChanged()
    if self:IsShown() then Lexicon:Search(self.input:GetText()) end
end
