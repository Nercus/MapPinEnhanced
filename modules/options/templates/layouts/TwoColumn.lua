---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionTwoColumnTemplate : Frame
---@field column1 Frame
---@field column2 Frame
---@field columnSpacing number
---@field rowSpacing number
---@field bottomPadding number
MapPinEnhancedOptionTwoColumnMixin = {}

function MapPinEnhancedOptionTwoColumnMixin:LayoutColumn(column)
    if not column then return 0 end

    ---@type Frame[]
    local children = { column:GetChildren() }
    if #children == 0 then return 0 end

    local totalHeight = 0
    for i, child in ipairs(children) do
        child:ClearAllPoints()
        child:SetWidth(column:GetWidth() - self.columnSpacing)
        if i == 1 then
            child:SetPoint("TOPLEFT", column, "TOPLEFT", 0, 0)
        else
            child:SetPoint("TOPLEFT", children[i - 1], "BOTTOMLEFT", 0, -self.rowSpacing)
        end

        totalHeight = totalHeight + child:GetHeight()
        if i < #children then
            ---@type number
            totalHeight = totalHeight + self.rowSpacing
        end
    end
    return totalHeight + self.bottomPadding
end

function MapPinEnhancedOptionTwoColumnMixin:UpdateLayout()
    assert(self.column1, "TwoColumnTemplate requires a 'column1' frame")
    assert(self.column2, "TwoColumnTemplate requires a 'column2' frame")

    local totalWidth = self:GetWidth()
    local columnWidth = (totalWidth - self.columnSpacing) / 2

    self.column1:ClearAllPoints()
    self.column1:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.column1:SetWidth(columnWidth)

    self.column2:ClearAllPoints()
    self.column2:SetPoint("TOPLEFT", self.column1, "TOPRIGHT", self.columnSpacing, 0)
    self.column2:SetWidth(columnWidth)

    local column1Height = self:LayoutColumn(self.column1)
    local column2Height = self:LayoutColumn(self.column2)

    self.column1:SetHeight(column1Height > 0 and column1Height or 1)
    self.column2:SetHeight(column2Height > 0 and column2Height or 1)

    local maxHeight = math.max(column1Height, column2Height)
    self:SetHeight(maxHeight > 0 and maxHeight or 1)
end

function MapPinEnhancedOptionTwoColumnMixin:OnShow()
    self:UpdateLayout()
end

function MapPinEnhancedOptionTwoColumnMixin:OnSizeChanged()
    self:UpdateLayout()
end
