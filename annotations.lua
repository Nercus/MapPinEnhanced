---@meta

---@class pinData
---@field mapID number
---@field x number
---@field y number
---@field title string?
---@field texture string?
---@field usesAtlas boolean?


---@class PinObject
---@field id string
---@field worldPin Frame
---@field minimapPin Frame
---@field pinData pinData



---@param frameType string
---@param parent string?
---@param frameTemplate string?
---@param resetterFunc fun()?
---@param forbidden boolean?
---@return FramePool
function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden) end

---@class FramePool
local FramePool = {}
---@return string
function FramePool:GetTemplate() end

---@return Frame
function FramePool:Acquire() end

---@param obj Frame
---@return boolean success
function FramePool:Release(obj) end
