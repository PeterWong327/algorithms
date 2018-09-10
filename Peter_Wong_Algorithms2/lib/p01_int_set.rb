class MaxIntSet
  def initialize(max)
    @store = Array.new(max)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = num
  end

  def remove(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num < @store.length
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] = num
  end

  def remove(num)
    @store[num % num_buckets] = []
  end

  def include?(num)
    @store[num % num_buckets] == num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    if @count == num_buckets
      resize!
    end
    @store[num % num_buckets] << num
    @count += 1

  end

  def remove(num)
    @count -= 1 if @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    # double num buckets
    # create new store with new num buckets
    # take every element from prev and insert it into new store
    @num_buckets = num_buckets * 2
    new_store = Array.new(@num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % @num_buckets] << num
        # new_store.insert(@store[bucket])
      end
    end
    @store = new_store
  end
end
