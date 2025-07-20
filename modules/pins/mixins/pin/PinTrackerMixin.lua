---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinMixin
---@field trackerEntry MapPinEnhancedTrackerPinEntryTemplate
MapPinEnhancedTrackerPinMixin = {}

function MapPinEnhancedTrackerPinMixin:Reset()
    self:SetFrame(nil)
end

function MapPinEnhancedTrackerPinMixin:SetFrame(frame)
    self.trackerEntry = frame
end

function MapPinEnhancedTrackerPinMixin:GetFrame()
    return self.trackerEntry
end

function MapPinEnhancedTrackerPinMixin:SetPinColor(color)
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame.pinFrame:SetPinColor(color)
end

function MapPinEnhancedTrackerPinMixin:SetPinIcon(icon, usesAtlas)
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame.pinFrame:SetPinIcon(icon, usesAtlas)
end

---@param skipAnimation boolean?
function MapPinEnhancedTrackerPinMixin:SetTracked(skipAnimation)
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame.pinFrame:SetTracked(skipAnimation)
end

function MapPinEnhancedTrackerPinMixin:SetUntracked()
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame.pinFrame:SetUntracked()
end
