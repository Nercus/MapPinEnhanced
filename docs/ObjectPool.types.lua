---@meta

---@class ObjectPool<T>: {EnumerateActive: fun(self: ObjectPool<T>):(T, fun(self: ObjectPool<T>):T)},{ Acquire: fun(self: ObjectPool<T>): T},{Release: fun(self: ObjectPool<T>, obj: T): boolean},{ ReleaseAll: fun(self: ObjectPool<T>)},{ GetNumActive: fun(self: ObjectPool<T>): number}, {capacity: number}

---@generic T
---@param creationFunc fun(): T
---@param resetterFunc? fun(obj: T)
---@return ObjectPool<T>
function CreateObjectPool(creationFunc, resetterFunc) end
