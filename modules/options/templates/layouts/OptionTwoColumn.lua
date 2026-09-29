---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedOptionTwoColumnTemplate : Frame
---@field column1 Frame
---@field column2 Frame
---@field columnSpacing number
---@field rowSpacing number
---@field bottomPadding number
---@field configuredColumn1Width number?
---@field configuredColumn2Width number?
MapPinEnhancedOptionTwoColumnMixin = {}

---@param column Frame
---@return number | nil
local function GetConfiguredWidth(column)
    local width = column:GetWidth()
    return width > 0 and width or nil
end

function MapPinEnhancedOptionTwoColumnMixin:LayoutColumn(column)
    if not column then return 0 end

    ---@type Frame[]
    local children = { column:GetChildren() }
    if #children == 0 then return 0 end

    local totalHeight = 0
    for i, child in ipairs(children) do
        child:ClearAllPoints()
        child:SetWidth(column:GetWidth())
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

    local availableWidth = math.max(self:GetWidth() - self.columnSpacing, 0)
    local column1Width = self.configuredColumn1Width
    local column2Width = self.configuredColumn2Width

    if not column1Width and not column2Width then
        column1Width = availableWidth / 2
        column2Width = availableWidth / 2
    elseif not column1Width then
        column1Width = math.max(availableWidth - column2Width, 0)
    elseif not column2Width then
        column2Width = math.max(availableWidth - column1Width, 0)
    end

    self.column1:ClearAllPoints()
    self.column1:SetPoint("TOPLEFT", self, "TOPLEFT", 0, 0)
    self.column1:SetWidth(column1Width)

    self.column2:ClearAllPoints()
    self.column2:SetPoint("TOPLEFT", self.column1, "TOPRIGHT", self.columnSpacing, 0)
    self.column2:SetWidth(column2Width)

    local column1Height = self:LayoutColumn(self.column1)
    local column2Height = self:LayoutColumn(self.column2)

    self.column1:SetHeight(column1Height > 0 and column1Height or 1)
    self.column2:SetHeight(column2Height > 0 and column2Height or 1)

    local maxHeight = math.max(column1Height, column2Height)
    self:SetHeight(maxHeight > 0 and maxHeight or 1)
end

function MapPinEnhancedOptionTwoColumnMixin:OnLoad()
    assert(self.column1, "TwoColumnTemplate requires a 'column1' frame")
    assert(self.column2, "TwoColumnTemplate requires a 'column2' frame")

    self.configuredColumn1Width = GetConfiguredWidth(self.column1)
    self.configuredColumn2Width = GetConfiguredWidth(self.column2)
end

function MapPinEnhancedOptionTwoColumnMixin:OnShow()
    self:UpdateLayout()
end

function MapPinEnhancedOptionTwoColumnMixin:OnSizeChanged()
    self:UpdateLayout()
end
