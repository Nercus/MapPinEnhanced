---@class MapPinEnhanced
local MapPinEnhanced = select(2, ...)

---@class MapPinEnhancedTextareaTemplate : ScrollFrame
---@field editbox EditBox
MapPinEnhancedTextareaMixin = {};


function MapPinEnhancedTextareaMixin:OnSizeChanged()
    local x, y = self:GetSize();
    self.editbox:SetSize(x - 5, y - 5);
end

function MapPinEnhancedTextareaMixin:OnMouseDown()
    self.editbox:SetFocus();
end

---@param callback fun(isChecked: boolean)
function MapPinEnhancedTextareaMixin:SetCallback(callback)
    assert(type(callback) == "function", "Callback must be a function.")
    self.onChangeCallback = MapPinEnhanced:DebounceChange(callback, 0.1)
end

---@class TextareaSetup
---@field onChange fun(text: string)
---@field init? fun(): string -- initial value can be nil if option has never been set before

---@param formData TextareaSetup
function MapPinEnhancedTextareaMixin:Setup(formData)
    assert(type(formData) == "table", "Form data must be a table.")
    assert(type(formData.onChange) == "function", "onChange callback must be a function.")


    if formData.init then
        assert(type(formData.init) == "function", "init must be a function")
        local initialValue = formData.init()
        if initialValue ~= nil then
            self.editbox:SetText(initialValue)
        else
            self.editbox:SetText("") -- default to empty if init returns nil
        end
    else
        self.editbox:SetText("") -- default to empty if no init function is provided
    end


    self.editbox:SetScript("OnTextChanged", function(_, userInput)
        if self.onChangeCallback and userInput then
            self.onChangeCallback(self.editbox:GetText())
        end
    end)
    self:SetCallback(formData.onChange)
end
