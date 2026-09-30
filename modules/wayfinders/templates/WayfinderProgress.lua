---@class MapPinEnhancedWayfinderProgressPin : Frame
---@field pin Texture
---@field highlight Texture
---@field number FontString

---@class MapPinEnhancedWayfinderProgressTemplate : Frame
---@field pool FramePool<MapPinEnhancedWayfinderProgressPin>
---@field stepIndex integer?
---@field stepCount integer?
---@field columns integer?
MapPinEnhancedWayfinderProgressMixin = {}

local PIN_SIZE = 20
local SPACING = 8
local PADDING = 8

---@param pool FramePool<MapPinEnhancedWayfinderProgressPin>
---@param pin MapPinEnhancedWayfinderProgressPin
local function ResetPin(pool, pin)
    pin:Hide()
    pin:ClearAllPoints()
    pin.number:SetText("")
    pin.highlight:Hide()
    pin.pin:SetVertexColor(0.65, 0.65, 0.65)
end

function MapPinEnhancedWayfinderProgressMixin:OnLoad()
    self.pool = CreateFramePool("Frame", self, "MapPinEnhancedWayfinderProgressPinTemplate", ResetPin)
end

---@param step WayfinderStepData?
---@param width number
---@return number inset Space inside the panel occupied by the overlapping strip.
function MapPinEnhancedWayfinderProgressMixin:Apply(step, width)
    local index, count = step and step.stepIndex, step and step.stepCount
    if not index or not count or count <= 1 or index < 1 or index > count then
        self.stepIndex, self.stepCount, self.columns = nil, nil, nil
        self:Hide()
        self.pool:ReleaseAll()
        return 0
    end
    local columns = math.min(count, math.max(1, math.floor((width - 2 * PADDING + SPACING) /
        (PIN_SIZE + SPACING))))
    local changed = self.stepIndex ~= index or self.stepCount ~= count or self.columns ~= columns
    self.stepIndex, self.stepCount, self.columns = index, count, columns
    local rows = math.ceil(count / columns)
    self:SetSize(columns * (PIN_SIZE + SPACING) - SPACING + 2 * PADDING,
        rows * (PIN_SIZE + SPACING) - SPACING + 2 * PADDING)
    if not self:IsShown() then
        self:Show()
    elseif changed then
        self:Refresh()
    end
    return self:GetHeight() / 2
end

function MapPinEnhancedWayfinderProgressMixin:Refresh()
    self.pool:ReleaseAll()
    local index, count, columns = self.stepIndex, self.stepCount, self.columns
    if not self:IsVisible() or not index or not count or not columns then return end
    for number = 1, count do
        local pin = self.pool:Acquire()
        ---@cast pin MapPinEnhancedWayfinderProgressPin
        local row = math.floor((number - 1) / columns)
        local column = (number - 1) % columns
        local rowCount = math.min(columns, count - row * columns)
        pin:SetPoint("TOP", self, "TOP", (column - (rowCount - 1) / 2) * (PIN_SIZE + SPACING),
            -PADDING - row * (PIN_SIZE + SPACING))
        pin.number:SetText(tostring(number))
        if number < index then
            pin.pin:SetVertexColor(1, 0.82, 0)
        else
            pin.pin:SetVertexColor(0.65, 0.65, 0.65)
        end
        pin.highlight:SetShown(number == index)
        pin:Show()
    end
end

function MapPinEnhancedWayfinderProgressMixin:OnHide()
    -- Each display retains only copied counts; hidden frames return to its pool.
    self.pool:ReleaseAll()
end
