-- Template: file://./OptionEditorSidebar.xml

---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class CategoryListScrollFrame : ScrollFrame
---@field Child Frame

---@class CategorySidebarHeader : Frame
---@field bg Texture
---@field headerText FontString



---@class MapPinEnhancedOptionEditorViewSidebarMixin : Frame
---@field switchViewButton MapPinEnhancedSquareButton
---@field body MapPinEnhancedOptionEditorViewBodyMixin
---@field categoryButtonPool FramePool
---@field scrollFrame CategoryListScrollFrame
---@field header CategorySidebarHeader
MapPinEnhancedOptionEditorViewSidebarMixin = {}


local L = MapPinEnhanced.L

local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedOptionEditorViewSidebarMixin:UpdateCategoryList()
    local categories = Options:GetCategories()
    local lastCategoryButton = nil
    local activeButton = nil
    self.categoryButtonPool:ReleaseAll()
    for _, category in ipairs(categories) do
        local categoryButton = self.categoryButtonPool:Acquire() --[[@as MapPinEnhancedOptionEditorViewCategoryButtonMixin]]
        categoryButton:SetLabel(L[category])
        categoryButton:SetInactive()

        categoryButton:ClearAllPoints()
        if lastCategoryButton then
            categoryButton:SetPoint("TOPLEFT", lastCategoryButton, "BOTTOMLEFT", 0, -5)
            categoryButton:SetPoint("TOPRIGHT", lastCategoryButton, "BOTTOMRIGHT", 0, -5)
        else
            categoryButton:SetPoint("TOPLEFT", self.scrollFrame.Child, "TOPLEFT", 5, -5)
            categoryButton:SetPoint("TOPRIGHT", self.scrollFrame.Child, "TOPRIGHT", -5, -5)
            categoryButton:SetActive() -- set the first category to active
            activeButton = categoryButton
        end
        categoryButton:SetParent(self.scrollFrame.Child)
        categoryButton:SetScript("OnClick", function()
            self.body:SetActiveCategory(category)
        end)
        categoryButton:Show()
        categoryButton:SetScript("OnClick", function()
            self.body:SetActiveCategory(category)
            if activeButton then
                activeButton:SetInactive()
            end
            categoryButton:SetActive()
            activeButton = categoryButton
        end)
        lastCategoryButton = categoryButton
    end
end

function MapPinEnhancedOptionEditorViewSidebarMixin:OnShow()
    self:UpdateCategoryList()
end

function MapPinEnhancedOptionEditorViewSidebarMixin:OnLoad()
    self.categoryButtonPool = CreateFramePool("Button", nil, "MapPinEnhancedOptionEditorViewCategoryButtonTemplate")


    self.header:SetScript("OnMouseDown", function()
        MapPinEnhanced.editorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end)

    self.header:SetScript("OnMouseUp", function()
        MapPinEnhanced.editorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end)
    self.header.headerText:SetText(L["Options"])
    self.switchViewButton:SetText(L["Show Sets"])
    self.switchViewButton.tooltip = L["Show Options"]
end
