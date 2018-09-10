require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    #check to see if key points to node in hash map
    if @map[key]
      #move node to end of list
      node = @map[key]
      @store.remove(key)
      # node.remove
      @map[node.key] = @store.append(node.key, node.val)
    else
      val = @prc.call(key)
      new_node = @store.append(key, val)
      @map[key] = new_node
      if count > @max
        eject!
      end
      val
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    @store.remove(@store.first.key)
    # @store.first.remove
    @map.delete(@store.first.key)
    nil
  end
end
