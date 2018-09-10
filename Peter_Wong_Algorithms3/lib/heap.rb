class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = Array.new()
    @prc = prc ||= Proc.new { |x, y| x <=> y }
  end

  def count
    @store.length
  end

  def extract
    #swap first and last element
    @store[0], @store[-1] = @store[-1], @store[0]
    #save and remove last element (pop)
    extracted = @store.pop
    #heapify down
    self.class.heapify_down(@store, 0, &prc)
    # return extracted value
    extracted
  end

  def peek
    #first index of store
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, len = @store.length - 1, &prc)
  end

  public
  def self.child_indices(len, parent_index)
    left = (2 * parent_index) + 1
    right = (2 * parent_index) + 2
    [left, right].select { |idx| idx < len }
    # if right >= len
    #   return [left]
    # else
    #   return [left, right]
    # end
  end

  def self.parent_index(child_index)
    p_index = (child_index - 1) / 2

    if p_index < 0
      raise "root has no parent"
    else
      p_index
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    #children indices
    left_child_idx, right_child_idx = self.child_indices(len, parent_idx)

    # left_child = array[left_child_idx]
    # # right_child = array[right_child_idx[1]]
    parent = array[parent_idx]
    # create children array with only child indices that exist
    children = []
    children.push(array[left_child_idx]) if left_child_idx
    children.push(array[right_child_idx]) if right_child_idx != nil

    #return sorted array after check if all children are less than or equal to parent
    if children.all? { |child| prc.call(parent, child) < 0 }
      return array
    end

    child_swap_idx = 0
    if children.length == 1
      # only left child exists
      child_swap_idx = left_child_idx
    else
      # both children exists, find lesser of the 2
      if prc.call(children[0], children[1]) == -1
        child_swap_idx = left_child_idx
      else
        child_swap_idx = right_child_idx
      end
    end

    #swap parent with smaller child
    array[parent_idx], array[child_swap_idx] = array[child_swap_idx], parent
    # recursively call function with the new parent index
    heapify_down(array, child_swap_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    # return array if child_idx == 0
    if child_idx == 0
      return array
    end
    parent_idx = parent_index(child_idx)
    child = array[child_idx]
    parent = array[parent_idx]

    if prc.call(child, parent) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = parent, child
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
