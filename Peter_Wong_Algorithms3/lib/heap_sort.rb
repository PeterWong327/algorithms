require_relative "heap"

class Array
  def heap_sort!

    # # solution from TA
    # prc = Proc.new {|a, b| (a <=> b) * -1}
    # (1..self.length).each do |heap_size|
    #   BinaryMinHeap.heapify_up(self, heap_size - 1, heap_size, &prc)
    # end
    #
    # self.length.downto(1) do |heap_size|
    #   self[heap_size -1], self[0] = self[0], self[heap_size - 1]
    #   BinaryMinHeap.heapify_down(self, 0, heap_size -1, &prc)
    # end
    #
    # self


    #heapify input
    newArr = []
    heap = BinaryMinHeap.new

    self.each do |el|
      heap.push(el)
    end
    # heap = heapify_down(self, self[0], len = self.length, &prc)
    until newArr.length == self.length
      #extract element and add it to the new array
      newArr.push(heap.extract)
    end
    newArr.each_with_index do |el, i|
      self[i] = el
    end
  end
end
