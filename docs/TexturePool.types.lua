---@meta

---@class TexturePool<T>: {EnumerateActive: fun(self: TexturePool<T>):(T, fun(self: TexturePool<T>):T)},{Acquire: fun(self: TexturePool<T>): T},{Release: fun(self: TexturePool<T>, obj: T): boolean},{ReleaseAll: fun(self: TexturePool<T>)}

---@generic T
---@param parent Region | string
---@param layer DrawLayer
---@param subLayer number?
---@param template `T`
---@param resetFunc fun()?
---@return TexturePool<T>
function CreateTexturePool(parent, layer, subLayer, template, resetFunc) end
