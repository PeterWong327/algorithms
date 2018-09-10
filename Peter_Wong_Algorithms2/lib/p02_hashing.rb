class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.inject(0) do |new_hash, (el, i)|
      (el.hash + i.hash) ^ new_hash
    # self.each_with_index do |num, i|
    #   (num.hash + i.hash).to_i
    end
  end
end

class String
  def hash
    sum = 0
    chars = self.chars
    chars.each_with_index do |char, i|
      sum += (char.ord.hash ^ i)
    end
    sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end
