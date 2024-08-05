-- Template: file://./OptionEditorSidebar.xml

---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class CategoryListScrollFrame : ScrollFrame
---@field Child Frame




---@class MapPinEnhancedOptionEditorViewSidebarMixin : Frame
---@field switchViewButton Button
---@field body MapPinEnhancedOptionEditorViewBodyMixin
---@field categoryButtonPool FramePool
---@field scrollFrame CategoryListScrollFrame
MapPinEnhancedOptionEditorViewSidebarMixin = {}



local Options = MapPinEnhanced:GetModule("Options")


function MapPinEnhancedOptionEditorViewSidebarMixin:UpdateCategoryList()
    local categories = Options:GetCategories()
    local lastCategoryButton = nil
    for i, category in ipairs(categories) do
        local categoryButton = self.categoryButtonPool:Acquire() --[[@as MapPinEnhancedOptionEditorViewCategoryButtonMixin]]
        categoryButton:SetLabel(category)
        categoryButton:SetInactive()

        if lastCategoryButton then
            categoryButton:SetPoint("TOPLEFT", lastCategoryButton, "BOTTOMLEFT", 0, -10)
            categoryButton:SetPoint("TOPRIGHT", lastCategoryButton, "BOTTOMRIGHT", 0, -10)
        else
            categoryButton:SetPoint("TOP", self.scrollFrame.Child)
            categoryButton:SetPoint("LEFT", self.scrollFrame.Child)
            categoryButton:SetPoint("RIGHT", self.scrollFrame.Child)
        end
        categoryButton:SetParent(self.scrollFrame.Child)

        categoryButton:SetScript("OnClick", function()
            self.body:SetActiveCategory(category)
        end)

        lastCategoryButton = categoryButton
    end
end

function MapPinEnhancedOptionEditorViewSidebarMixin:OnShow()
    self:UpdateCategoryList()
end

function MapPinEnhancedOptionEditorViewSidebarMixin:OnLoad()
    self.categoryButtonPool = CreateFramePool("Button", nil, "MapPinEnhancedOptionEditorViewCategoryButtonTemplate")
end
