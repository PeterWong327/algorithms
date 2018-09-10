# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    # @store.max_Q = RingBuffer.new
    @store = RingBuffer.new
    @max = nil
  end

  def enqueue(val) #push method
    # self.store.push(val)
    # update_max_Q(val)

    if @store.length == 0
      @max = val
    else
      @max = val if val > @max
    end
    @store.push(val)

  end

  def dequeue #shift method
    # val = self.store.shift
    # self.max_Q
    #   # if element remove is the max, also remove max from maxQ
    # self.max_Q.shift if val = max_Q[0]

    #remove the first element
    val = @store.shift
    if val == @max
      #find new max
      (0...@store.length).each do |i|
        if @store[i] > @max
          @max = @store[i]
        end
      end
    end
  end

  def max
    @max
    # self.max_Q[0] if max_Q.length > 0
  end

  def length
    @store.length
  end

  def update_maxQ(val)
    while self.max_Q[0] && self.max_Q[self.max_Q.length - 1] < val
      self.max_Q.pop
    end
    self.max_Q.push(val)
  end

end
