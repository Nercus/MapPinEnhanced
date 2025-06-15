---@meta

---@class FramePool<T>: {
---     EnumerateActive: fun(self: FramePool<T>):(T, fun(self: FramePool<T>):T),
---     Acquire: fun(self: FramePool<T>): T,
---     Release: fun(self: FramePool<T>, obj: T): boolean,
---     ReleaseAll: fun(self: FramePool<T>)}

---@generic T
---@param frameType string
---@param parent Region | string
---@param frameTemplate `T`
---@param resetterFunc fun()?
---@param forbidden boolean?
---@return FramePool<T>
function CreateFramePool(frameType, parent, frameTemplate, resetterFunc, forbidden) end
