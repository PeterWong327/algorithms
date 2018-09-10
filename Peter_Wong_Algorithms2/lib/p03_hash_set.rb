require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    if @count == num_buckets
      resize!
    end
    num = key.hash
    @store[num % num_buckets] << key
    @count += 1

  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(key)
  end

  def remove(key)
    num = key.hash
    @count -= 1 if @store[num % num_buckets].delete(key)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = num_buckets * 2
    new_store = Array.new(@num_buckets) { Array.new }
    num_buckets.times do |bucket|
      new_store.insert(@store[bucket])
    end
    @store = new_store
  end
end
