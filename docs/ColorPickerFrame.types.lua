---@meta


---@class ColorPickerFrame : Frame
---@field swatchFunc? fun()
---@field opacityFunc? fun()
---@field cancelFunc? fun()
---@field extraInfo any
ColorPickerFrame = {}

---@return number, number, number
function ColorPickerFrame:GetColorRGB() end

---@return number
function ColorPickerFrame:GetColorAlpha() end

function ColorPickerFrame:SetupColorPickerAndShow(info) end

---@return any
function ColorPickerFrame:GetExtraInfo() end
