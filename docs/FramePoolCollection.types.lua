---@meta

---@class FramePoolCollection<A>: {CreatePool: fun(self: FramePoolCollection, frameType: FrameType, parent: Region | string | nil, frameTemplate: `A` | string, resetterFunc: fun()?, forbidden: boolean?): FramePool<A>}, {GetPool: fun(self: FramePoolCollection, frameType: A): FramePool<A>}, {Acquire: fun(self: FramePoolCollection, frameType: `A` | string): A}, {Release: fun(self: FramePoolCollection, obj: A): boolean}, {ReleaseAll: fun(self: FramePoolCollection)}, {EnumerateActive: fun(self: FramePoolCollection): (A, fun(self: FramePoolCollection): A)}, {GetNumActive: fun(self: FramePoolCollection): number}


---@return FramePoolCollection
function CreateFramePoolCollection() end
