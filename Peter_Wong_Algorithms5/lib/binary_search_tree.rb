# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative 'bst_node'

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      insert_in_child(@root, value)
    end
  end

  def find(value, tree_node = @root)
    if tree_node == nil
      return nil
    end

    if value < tree_node.value
      return find(value, tree_node.left)
    elsif value > tree_node.value
      return find(value, tree_node.right)
    elsif value == tree_node.value
      return tree_node
    end
  end

  def delete(value)
    if @root.value == value
      @root = nil
      return
    end
    node = find(value, tree_node = @root)

    #traverse through children, check if child is equal to value, if equal
    # if value < @root.value



    #if no children, remove node
    if node.left.nil? && node.right.nil?
      # node.parent.left = nil
      node.parent.right = nil
    # if node has 1 child, promote child to take node's place
    elsif node.left.nil? && node.right != nil
      #if node's left child doesnt exist, promote right
      node.right.parent = node.parent
      node.parent.right = node.right
      #if node's right child doesnt exist, promote left
    elsif node.right.nil? && node.left != nil
      node.left.parent = node.parent
      node.parent.left = node.left
      # node = nil
      # node = node.left
    else
      #if node has 2 children, find max element in node's left subtree
      # call this child 'r'.
      r = maximum(node.left)

      #Replace node with 'r'
      node = r

      #If 'r' had a left child, promote this child to take r's place.
      if r.left
        r.left.parent = r.parent
        r.parent.left = r.left
      elsif r.right
        r.right.parent = r.parent
        r.parent.right = r.right
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    #return right child if right child doesnt have a right child
    return tree_node if tree_node.right == nil
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node == nil
    if tree_node.left
      left = depth(tree_node.left) + 1
    else
      left = 0
    end
    if tree_node.right
      right = depth(tree_node.right) + 1
    else
      right = 0
    end
    return left > right ? left : right

  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    left = tree_node.left
    right = tree_node.right
    return false if (depth(left) - depth(right)).abs > 1
    return is_balanced?(left) && is_balanced?(right)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return [] unless tree_node
    in_order_traversal(tree_node.left) + [tree_node.value] + in_order_traversal(tree_node.right)
  end

# in order iterative:
# 1. create empty stack
# 2. initialize current node as root
# 3. push current into stack, set current as current.left until current is null
# 4.

# arr = []
# #if tree_node left child is there
#   if tree_node.left != nil
#     #keep checking left until empty
#     until tree_node.left.nil?
#       tree_node = tree_node.left
#     end
#     #push the left most child into array
#       arr.push(tree_node)
#
#   end

def lowest_common_ancestor(tree_node, node1, node2) #recursive
  return tree_node if node1 == tree_node || node2 == tree_node
    if (tree_node < node1 && tree_node > node2) || (tree_node > node1 && tree_node < node2)
      return tree_node
      #go right
    elsif tree_node < node1 && tree_node < node2
      lowest_common_ancestor(tree_node.right, node1, node2)
    else
      #go left
      lowest_common_ancestor(tree_node.left, node1, node2)
    end
end

def lowest_common_ancestor(tree_node, node1, node2) #iterative
  while true
    return tree_node if node1 == tree_node || node2 == tree_node
    if (tree_node < node1 && tree_node > node2) || (tree_node > node1 && tree_node < node2)
      return tree_node
      #go right
    elsif tree_node < node1 && tree_node < node2
      tree_node = tree_node.right
    else
      #go left
      tree_node = tree_node.left
    end
  end
end

  #post order traversal (change order of left, right, and node value)
  # def in_order_traversal(tree_node = @root, arr = [])
  #   return [] unless tree_node
  #   in_order_traversal(tree_node.left) + in_order_traversal(tree_node.right) + [tree_node.value]
  # end


  private
  # optional helper methods go here:

  def insert_in_child(child, val) #
#if value is less than/= root value, insert into left tree
    if val <= child.value #
      #if left child already exist, recursively run this method
      # with left child until no left child, then create new node.
      if child.left != nil
        insert_in_child(child.left, val)
      else
        child.left = BSTNode.new(val)
        child.left.parent = child
        # return
      end
    end
#if value is greater than root value , insert into right tree
    if val > child.value
      #if right child already exist, recursively run this method
      # with right child until no right child, then create new node with value
      if child.right != nil
       insert_in_child(child.right, val)
      else
        child.right = BSTNode.new(val)
        child.right.parent = child
        # return
      end
    end
  end
end
