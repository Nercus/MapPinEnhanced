---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedFormElementTemplate : Frame
---@field label FontString
---@field description FontString
---@field searchHighlight Texture
---@field child Frame
---@field orientation "vertical" | "horizontal" | nil
---@field key string The unique key for the option, used for saving values. Is of the format "category.optionName", e.g. "general.showMinimapPin".
---@field hideLabel boolean If true, the label will be hidden and not take up space.
---@field hideDescription boolean If true, the description will be hidden and not take up space.
---@field GetValue fun(self): any A function that returns the current value of the option.
---@field SetValue fun(self, value): nil A function that sets the value of the option.
---@field IsValueEqual fun(self, value): boolean A function that checks whether the option already has the given value.
---@field NotifyChange fun(self, value): nil A function that notifies subscribers that the option value changed.
---@field OnChange fun(self, callback: fun(value): nil): fun() A function that allows subscribing to changes of the option's value. Returns an unsubscribe function.
---@field Setup fun(self, init: any): nil A function that is called when the option is registered. Can be used to perform any necessary setup, such as registering callbacks on the child frame.
---@field ScrollToOption fun(self): nil A function that scrolls the options panel to this option. Only necessary if the option is not guaranteed to be visible when changed, e.g. because it's in a collapsible section.
---@field callbacks function[] A list of callback functions that will be called when the option's value changes.
---@field padding number
---@field labelBottomSpacing number
---@field descriptionBottomSpacing number
---@field scrollPadding number
MapPinEnhancedFormElementMixin = {}

local Options = MapPinEnhanced:GetModule("Options")
local L = MapPinEnhanced.L

function MapPinEnhancedFormElementMixin:IsValueEqual(value)
    return self:GetValue() == value
end

function MapPinEnhancedFormElementMixin:NotifyChange(value)
    if not self.callbacks then return end
    for _, callback in ipairs(self.callbacks) do
        callback(value)
    end
end

---@param callback function
---@return function unsubscribe Call to remove this callback
function MapPinEnhancedFormElementMixin:OnChange(callback)
    if not self.callbacks then
        self.callbacks = {}
    end
    for _, existingCallback in ipairs(self.callbacks) do
        if existingCallback == callback then
            return function() end
        end
    end
    table.insert(self.callbacks, callback)
    return function()
        for i, cb in ipairs(self.callbacks) do
            if cb == callback then
                table.remove(self.callbacks, i)
                return
            end
        end
    end
end

function MapPinEnhancedFormElementMixin:GetLabelText()
    if not self.key then return nil end
    local labelKey = self.key .. "_LABEL"
    local labelText = L[labelKey]
    if labelText and labelText ~= labelKey then
        return labelText
    end
    return nil
end

function MapPinEnhancedFormElementMixin:GetDescriptionText()
    if not self.key then return nil end
    local descKey = self.key .. "_DESCRIPTION"
    local descText = L[descKey]
    if descText and descText ~= descKey then
        return descText
    end
    return nil
end

function MapPinEnhancedFormElementMixin:HasLabel()
    return self:GetLabelText() ~= nil and not self.hideLabel
end

function MapPinEnhancedFormElementMixin:HasDescription()
    return self:GetDescriptionText() ~= nil and not self.hideDescription
end

function MapPinEnhancedFormElementMixin:UpdateHeight()
    local hasLabel = self:HasLabel()
    local hasDescription = self:HasDescription()

    local labelHeight = hasLabel and (self.label:GetHeight() + self.labelBottomSpacing) or 0
    local descriptionHeight = hasDescription and (self.description:GetHeight() + self.descriptionBottomSpacing) or 0
    local childHeight = self.child:GetHeight()

    ---@type number
    local totalHeight
    if self.orientation == "vertical" then
        totalHeight = labelHeight + descriptionHeight + childHeight
    elseif self.orientation == "horizontal" then
        totalHeight = math.max(labelHeight + descriptionHeight, childHeight)
    end
    totalHeight = totalHeight + self.padding * 2

    self:SetHeight(totalHeight)
end

function MapPinEnhancedFormElementMixin:ScrollToOption()
    local Options = MapPinEnhanced:GetModule("Options")
    local scrollFrame = Options.frame and Options.frame.scrollFrame

    if not scrollFrame then return end

    local scrollChild = scrollFrame:GetScrollChild()
    if not scrollChild then return end

    local childTop = scrollChild:GetTop()
    local selfTop = self:GetTop()
    if not childTop or not selfTop then return end

    local target = childTop - selfTop - self.scrollPadding
    local maxScroll = scrollFrame:GetVerticalScrollRange() or 0

    if target < 0 then
        target = 0
    elseif target > maxScroll then
        target = maxScroll
    end

    scrollFrame:SetVerticalScroll(target)
    self.searchHighlight:Show()
end

function MapPinEnhancedFormElementMixin:SetLayout(orientation)
    assert(orientation == "vertical" or orientation == "horizontal", "Invalid orientation: " .. tostring(orientation))

    self.child:ClearAllPoints()
    if orientation == "vertical" then
        local hasLabel = self:HasLabel()
        local hasDescription = self:HasDescription()

        ---@type Region
        local anchor = self
        local anchorPoint = "TOPLEFT"
        local offsetY = 0
        if hasDescription then
            anchor = self.description
            anchorPoint = "BOTTOMLEFT"
            offsetY = -self.descriptionBottomSpacing
        elseif hasLabel then
            anchor = self.label
            anchorPoint = "BOTTOMLEFT"
            offsetY = -self.labelBottomSpacing
        end
        self.child:SetPoint("TOPLEFT", anchor, anchorPoint, 0, offsetY)
    elseif orientation == "horizontal" then
        self.child:SetPoint("TOPRIGHT", self, "TOPRIGHT")
    end
end

function MapPinEnhancedFormElementMixin:OnLoad()
    assert(self.child, "Form element must have a child frame")
    assert(self.key, "Form element must have an key")

    assert(self.GetValue, "Form element must have a GetValue method")
    assert(self.SetValue, "Form element must have a SetValue method")
    assert(self.OnChange, "Form element must have a OnChange method")
    assert(self.Setup, "Form element must have a Setup method")

    local showLabel = self:HasLabel()
    local showDescription = self:HasDescription()

    self.label:SetShown(showLabel)
    self.description:SetShown(showDescription)

    if showLabel then
        self.label:SetText(self:GetLabelText())
    end
    if showDescription then
        self.description:SetText(self:GetDescriptionText())
    end
    self.orientation = self.orientation or "horizontal"
    self:SetLayout(self.orientation)
    self:UpdateHeight()
    Options:RegisterOption(self.key, self)
end
