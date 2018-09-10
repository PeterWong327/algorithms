class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    self.prev.next = self.next if self.prev
    self.next.prev = self.prev if self.next
    self.next = nil
    self.prev = nil
    self
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    #create new node
    new_node = Node.new(key, val)
    #set next node of prev to the newly created
    @tail.prev.next = new_node
    #set prev node of new node to the tail's prev
    new_node.prev = @tail.prev
    #set next node to tail
    new_node.next = @tail
    #set prev node of tail to new node
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
        return node
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        if @head.next == node
          @head.next = node.next
        end
        if @tail.prev == node
          @tail.prev = node.prev
        end
        node.remove
        return node.val
      end
    end
    nil
  end

  def each
    current = @head.next
    until current == @tail
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
