---@meta


---@class TreeNodeMixin
---@field nodes TreeNode[]
---@field dataProvider TreeDataProviderMixin
---@field parent TreeNode|nil
---@field data any
---@field sortComparator fun(a: TreeNode, b: TreeNode): boolean|nil
---@field collapsed boolean|nil
local TreeNodeMixin = {}

---@param dataProvider TreeDataProviderMixin
---@param parent TreeNode|nil
---@param data any
---@return TreeNode
local function CreateTreeNode(dataProvider, parent, data) end

---@param dataProvider TreeDataProviderMixin
---@param parent TreeNode|nil
---@param data any
function TreeNodeMixin:Init(dataProvider, parent, data) end

---@return TreeNode[]
function TreeNodeMixin:GetNodes() end

---@return integer
function TreeNodeMixin:GetDepth() end

---@return any
function TreeNodeMixin:GetData() end

---@return integer
function TreeNodeMixin:GetSize() end

---@return TreeNode|nil
function TreeNodeMixin:GetFirstNode() end

---@param node TreeNode
---@return TreeNode
function TreeNodeMixin:MoveNode(node) end

---@param node TreeNode
---@param referenceNode TreeNode
---@param offset integer
---@return TreeNode
function TreeNodeMixin:MoveNodeRelativeTo(node, referenceNode, offset) end

---@return TreeNode|nil
function TreeNodeMixin:GetParent() end

function TreeNodeMixin:Flush() end

---@param data any
---@return TreeNode
function TreeNodeMixin:Insert(data) end

---@param data any
---@param insertIndex integer
---@return TreeNode
function TreeNodeMixin:InsertNodeAtIndex(data, insertIndex) end

---@param node TreeNode
---@param insertIndex integer|nil
---@return TreeNode
function TreeNodeMixin:InsertNode(node, insertIndex) end

---@param node TreeNode
---@param skipInvalidation boolean|nil
---@return TreeNode|nil
function TreeNodeMixin:Remove(node, skipInvalidation) end

---@param sortComparator fun(a: TreeNode, b: TreeNode): boolean
---@param affectChildren boolean|nil
---@param skipSort boolean|nil
function TreeNodeMixin:SetSortComparator(sortComparator, affectChildren, skipSort) end

---@return boolean
function TreeNodeMixin:HasSortComparator() end

function TreeNodeMixin:Sort() end

function TreeNodeMixin:Invalidate() end

---@param collapsed boolean
---@param affectChildren boolean|nil
---@param skipInvalidate boolean|nil
function TreeNodeMixin:SetChildrenCollapsed(collapsed, affectChildren, skipInvalidate) end

---@param collapsed boolean
---@param affectChildren boolean|nil
---@param skipInvalidate boolean|nil
function TreeNodeMixin:SetCollapsed(collapsed, affectChildren, skipInvalidate) end

---@param affectChildren boolean|nil
---@param skipInvalidate boolean|nil
---@return boolean
function TreeNodeMixin:ToggleCollapsed(affectChildren, skipInvalidate) end

---@return boolean|nil
function TreeNodeMixin:IsCollapsed() end

---@alias TreeNode TreeNodeMixin



---@class SubTreeNodeMixin
---@field GetData fun(self: SubTreeNodeMixin): any
---@field GetElementData fun(self: SubTreeNodeMixin): any
---@field GetElementDataIndex fun(self: SubTreeNodeMixin): integer
---@field ElementDataMatches fun(self: SubTreeNodeMixin, elementData: any): boolean
---@field GetOrderIndex fun(self: SubTreeNodeMixin): integer
---@field SetOrderIndex fun(self: SubTreeNodeMixin, orderIndex: integer)
