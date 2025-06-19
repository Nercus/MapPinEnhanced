---@meta


---@class ColorPickerFrame : Frame
ColorPickerFrame = {}

---@return number, number, number
function ColorPickerFrame:GetColorRGB() end

---@return number
function ColorPickerFrame:GetColorAlpha() end

function ColorPickerFrame:SetupColorPickerAndShow(info) end
