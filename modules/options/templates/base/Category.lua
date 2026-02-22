---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)


---@class MapPinEnhancedOptionCategoryBaseHeader : Button
---@field icon MapPinEnhancedIconMixin
---@field title FontString

---@class MapPinEnhancedOptionCategoryBaseTemplate : Frame
---@field header MapPinEnhancedOptionCategoryBaseHeader
MapPinEnhancedOptionCategoryBaseMixin = {}

function MapPinEnhancedOptionCategoryBaseMixin:Collapse()
    self.isCollapsed = true
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            child:Hide()
        end
    end
    self:SetHeight(self.header:GetHeight() + 8)
    self.header.icon:SetIconTexture("plus")
end

function MapPinEnhancedOptionCategoryBaseMixin:Expand()
    self.isCollapsed = false
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            child:Show()
        end
    end
    self:UpdateHeight()
    self.header.icon:SetIconTexture("minus")
end

function MapPinEnhancedOptionCategoryBaseMixin:UpdateHeight()
    local totalHeight = self.header:GetHeight()
    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            totalHeight = totalHeight + child:GetHeight() + 4
        end
    end
    self:SetHeight(totalHeight + 8)
end

function MapPinEnhancedOptionCategoryBaseMixin:LayoutChildren()
    local headerHeight = self.header:GetHeight()
    local offsetY = -headerHeight - 8

    for _, child in ipairs({ self:GetChildren() }) do
        if child ~= self.header then
            child:ClearAllPoints()
            child:SetPoint("TOPLEFT", self, "TOPLEFT", 8, offsetY)
            child:SetPoint("TOPRIGHT", self, "TOPRIGHT", -8, offsetY)
            offsetY = offsetY - child:GetHeight() - 4 -- 4px spacing
        end
    end
end

function MapPinEnhancedOptionCategoryBaseMixin:OnShow()
    self:LayoutChildren()
    self:UpdateHeight()
    self:Expand() -- default to expanded when shown
end

function MapPinEnhancedOptionCategoryBaseMixin:ToggleCollapse()
    if self.isCollapsed then
        self:Expand()
    else
        self:Collapse()
    end
end

function MapPinEnhancedOptionCategoryBaseMixin:OnLoad()
    self.header:SetScript("OnClick", function() self:ToggleCollapse() end)
end
