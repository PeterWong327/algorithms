require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    if (index < 0 || index >= @length)
      raise 'index out of bounds'
    else
      @store[(index + @start_idx) % @capacity]
    end
  end

  # O(1)
  def []=(index, val)
    if(index < 0 || index >= @length)
      raise 'index out of bounds'
    else
      @store[(index + @start_idx) % @capacity] = val
    end
  end

  # O(1)
  # remove last element
  def pop
    raise "index out of bounds" unless (@length > 0)

    last = @store[(@start_idx + @length - 1) % capacity]
    @store[(@start_idx + @length - 1) % capacity] = nil
    @length -= 1
    last
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity

    @store[(@start_idx + @length) % capacity] = val
    @length += 1
  end

  # O(1)
  #remove first index value
  def shift
    raise "index out of bounds" if (@length == 0)

    @length -= 1
    @start_idx = (@start_idx) % capacity
    first = @store[@start_idx]
    @store[@start_idx] = nil
    @start_idx += 1
    first

    # first = @store[start_idx]
    #
    # (1...@length).each do |i|
    #   @store[i - 1] = @store[i]
    # end
    # @length -= 1
    # first
  end

  # O(1) ammortized
  # add val to last index and then make that the start_index
  def unshift(val)
    resize! if @length == @capacity

    @length += 1
    @start_idx = (@start_idx - 1) % capacity
    @store[@start_idx-1] = val

    #
    # @length += 1
    # (@length-2).downto(0).each do |i|
    #   @store[i+1] = @store[i]
    # end
    # @store[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    capacity2 = @capacity * 2
    store2 = StaticArray.new(capacity2)
    @length.times { |i| store2[i] = @store[(@start_idx + i) % capacity]}
    @capacity = capacity2
    @start_idx = 0
    @store = store2
  end
end
