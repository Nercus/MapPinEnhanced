---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class CategoryListScrollFrame : ScrollFrame
---@field Child Frame

---@class CategorySidebarHeader : Frame
---@field bg Texture
---@field headerText FontString



---@class MapPinEnhancedWindowOptionSidebarMixin : Frame
---@field switchViewButton MapPinEnhancedSquareButton
---@field body MapPinEnhancedWindowOptionBodyMixin
---@field categoryButtonPool FramePool<MapPinEnhancedWindowOptionSidebarEntryMixin>
---@field scrollFrame CategoryListScrollFrame
---@field header CategorySidebarHeader
MapPinEnhancedWindowOptionSidebarMixin = {}


local L = MapPinEnhanced.L

local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedWindowOptionSidebarMixin:UpdateCategoryList()
    local categories = Options:GetCategories()
    local lastCategoryButton = nil
    local activeButton = nil
    self.categoryButtonPool:ReleaseAll()
    for _, category in ipairs(categories) do
        local categoryButton = self.categoryButtonPool:Acquire()
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

function MapPinEnhancedWindowOptionSidebarMixin:OnShow()
    self:UpdateCategoryList()
end

function MapPinEnhancedWindowOptionSidebarMixin:OnLoad()
    self.categoryButtonPool = CreateFramePool("Button", nil, "MapPinEnhancedWindowOptionSidebarEntryTemplate")
    local EditorWindow = MapPinEnhanced:GetModule("EditorWindow")

    self.header:SetScript("OnMouseDown", function()
        EditorWindow.editorWindow:StartMoving()
        SetCursor("Interface/CURSOR/UI-Cursor-Move.crosshair")
    end)

    self.header:SetScript("OnMouseUp", function()
        EditorWindow.editorWindow:StopMovingOrSizing()
        SetCursor(nil)
    end)
    self.header.headerText:SetText(L["Options"])
    self.switchViewButton:SetText(L["Show Sets"])
    self.switchViewButton.tooltip = L["Show Options"]
end
