---@meta


--- Linearly interpolates between two values.
---@param startValue number The starting value.
---@param endValue number The ending value.
---@param amount number The interpolation factor (typically between 0 and 1).
---@return number The interpolated value.
function Lerp(startValue, endValue, amount) end

--- Performs a delta-based linear interpolation between two values, factoring in time and a target frame rate. Interpolation uses 60 FPS as the target frame rate.
---@param startValue number The starting value.
---@param endValue number The ending value.
---@param amount number The interpolation factor per second.
---@param timeSec number The elapsed time in seconds.
---@return number The interpolated value adjusted for time and frame rate.
function DeltaLerp(startValue, endValue, amount, timeSec) end
