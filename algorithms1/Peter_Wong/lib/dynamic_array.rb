require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize(capacity = 8)
    @length = 0
    @capacity = capacity
    @store = StaticArray.new(capacity)
  end

  # O(1)
  def [](index)
    if (index < 0 || index >= @length)
      raise 'index out of bounds'
    else
      @store[index]
    end
  end

  # O(1)
  def []=(index, value)
    if(index < 0 || index >= @length)
      raise 'index out of bounds'
    else
      @store[index] = value
    end
  end

  # O(1)
  def pop
    raise "index out of bounds" unless (@length > 0)

    last = @store[@length - 1]
    @store[@length - 1] = nil
    @length -= 1
    last
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity

    #increase length of array first, then set val = to last element.
    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if (@length == 0)

    first = @store[0]
    (1...@length).each do |i|
      #slide everything to the left
      @store[i - 1] = @store[i]
    end
    @length -= 1
    first

  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    #slide everything to the right
    (@length-2).downto(0).each do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index < 0 || index >= length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    #dobule capacity
    #new store
    #place existing elements into new store
    capacity2 = @capacity * 2
    store2 = StaticArray.new(capacity2)
    @length.times { |i| store2[i] = @store[i] }
    @capacity = capacity2
    @store = store2
  end
end
