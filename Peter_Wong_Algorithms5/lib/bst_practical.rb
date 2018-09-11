require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  array = in_order_traversal(tree_node, arr = [])
  # array[array.length - k]
  array[k - 1]

end

def in_order_traversal(tree_node, arr = [])
  return [] unless tree_node
  in_order_traversal(tree_node.right) + [tree_node] + in_order_traversal(tree_node.left)
end
