---@class MapPinEnhancedWayfinderProgressTemplate : Frame
---@field pool FramePool<MapPinEnhancedWayfinderProgressPin>
---@field stepIndex integer?
---@field stepCount integer?
---@field columns integer?
---@field entries WayfinderProgressEntry[]?
MapPinEnhancedWayfinderProgressMixin = {}

local PIN_SIZE = 12
local SPACING = 10
local HORIZONTAL_PADDING = 12
local VERTICAL_PADDING = 6

---@param pool FramePool<MapPinEnhancedWayfinderProgressPin>
---@param pin MapPinEnhancedWayfinderProgressPin
local function ResetPin(pool, pin)
    pin:Hide()
    pin:ClearAllPoints()
    pin:OnHide()
    pin:SetActive(false)
    pin.entry = nil
    pin.pin:SetVertexColor(1, 1, 1)
end

function MapPinEnhancedWayfinderProgressMixin:OnLoad()
    self.pool = CreateFramePool("Button", self, "MapPinEnhancedWayfinderProgressPinTemplate", ResetPin)
end

---@param step WayfinderStepData?
---@param width number
function MapPinEnhancedWayfinderProgressMixin:Apply(step, width)
    local index, count = step and step.stepIndex, step and step.stepCount
    if not step or not step.progressEntries or not index or not count or count <= 1 or index < 1 or index > count then
        self.stepIndex, self.stepCount, self.columns = nil, nil, nil
        self.entries = nil
        self:Hide()
        self.pool:ReleaseAll()
        return
    end
    local columns = math.min(count, math.max(1, math.floor((width - 2 * HORIZONTAL_PADDING + SPACING) /
        (PIN_SIZE + SPACING))))
    local changed = self.stepIndex ~= index or self.stepCount ~= count or self.columns ~= columns or
        self.entries ~= step.progressEntries
    self.entries = step.progressEntries
    self.stepIndex, self.stepCount, self.columns = index, count, columns
    local rows = math.ceil(count / columns)
    self:SetSize(columns * (PIN_SIZE + SPACING) - SPACING + 2 * HORIZONTAL_PADDING,
        rows * (PIN_SIZE + SPACING) - SPACING + 2 * VERTICAL_PADDING)
    if not self:IsShown() then
        self:Show()
    elseif changed then
        self:Refresh()
    end
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
            -VERTICAL_PADDING - row * (PIN_SIZE + SPACING))
        local entry = self.entries and self.entries[number]
        pin.entry = entry
        if entry then pin.pin:SetVertexColor(entry.r, entry.g, entry.b) end
        pin:SetActive(number == index)
        pin:Show()
    end
end

function MapPinEnhancedWayfinderProgressMixin:OnHide()
    -- Each display retains only copied presentation data; hidden frames return to its pool.
    self.pool:ReleaseAll()
end
