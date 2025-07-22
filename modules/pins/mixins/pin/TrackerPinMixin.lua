---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTrackerPinMixin
---@field trackerEntry MapPinEnhancedTrackerPinEntryTemplate
---@field treeNode SubTreeNodeMixin
---@field template string the template used for the tracker entry
MapPinEnhancedTrackerPinMixin = {
    template = "MapPinEnhancedTrackerPinEntryTemplate"
}

function MapPinEnhancedTrackerPinMixin:Reset()
    self:SetFrame(nil)
    self:SetTreeNode(nil)
end

function MapPinEnhancedTrackerPinMixin:SetFrame(frame)
    self.trackerEntry = frame
end

function MapPinEnhancedTrackerPinMixin:GetFrame()
    return self.trackerEntry
end

function MapPinEnhancedTrackerPinMixin:SetTreeNode(treeNode)
    self.treeNode = treeNode
end

function MapPinEnhancedTrackerPinMixin:GetTreeNode()
    return self.treeNode
end

function MapPinEnhancedTrackerPinMixin:SetPinColor(color)
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame.pinFrame:SetPinColor(color)
    local vertexColor = frame.pinFrame:GetColorValue()
    if vertexColor and vertexColor ~= 'Custom' then
        frame.overlayTexture:SetVertexColor(vertexColor.r, vertexColor.g, vertexColor.b)
    end
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
    frame:GetNormalTexture():SetDesaturated(false)
    frame.pinFrame:SetTracked(skipAnimation)
end

function MapPinEnhancedTrackerPinMixin:SetUntracked()
    local frame = self:GetFrame()
    if not frame then
        return
    end
    frame:GetNormalTexture():SetDesaturated(true)
    frame.pinFrame:SetUntracked()
end
