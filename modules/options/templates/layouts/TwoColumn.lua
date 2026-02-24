---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionTwoColumnTemplate : Frame
---@field column1 Frame
---@field column2 Frame
MapPinEnhancedOptionTwoColumnMixin = {}

local COLUMN_SPACING = 10 -- Space between the two columns
local ROW_SPACING = 4     -- Space between rows in each column


function MapPinEnhancedOptionTwoColumnMixin:LayoutColumn(column)
    if not column then return 0 end

    ---@type Frame[]
    local children = { column:GetChildren() }
    if #children == 0 then return 0 end

    local totalHeight = 0
    for i, child in ipairs(children) do
        child:ClearAllPoints()
        child:SetWidth(column:GetWidth() - COLUMN_SPACING)
        if i == 1 then
            child:SetPoint("TOPLEFT", column, "TOPLEFT", 0, 0)
        else
            child:SetPoint("TOPLEFT", children[i - 1], "BOTTOMLEFT", 0, -ROW_SPACING)
        end

        totalHeight = totalHeight + child:GetHeight() + ROW_SPACING
    end
    return totalHeight + (ROW_SPACING * 3)
end

function MapPinEnhancedOptionTwoColumnMixin:UpdateLayout()
    assert(self.column1, "TwoColumnTemplate requires a 'column1' frame")
    assert(self.column2, "TwoColumnTemplate requires a 'column2' frame")

    local totalWidth = self:GetWidth()
    local columnWidth = (totalWidth - COLUMN_SPACING) / 2

    self.column1:ClearAllPoints()
    self.column1:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.column1:SetWidth(columnWidth)

    self.column2:ClearAllPoints()
    self.column2:SetPoint("TOPLEFT", self.column1, "TOPRIGHT", COLUMN_SPACING, 0)
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
