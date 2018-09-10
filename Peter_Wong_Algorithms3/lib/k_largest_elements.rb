require_relative 'heap'

def k_largest_elements(array, k)
  # result = BinaryMinHeap.new
  # #prefill this result with k items
  # k.times do
  #   result.push(array.pop)
  # end
  # until empty?
  #   result.push(array.pop)
  #   result.extract
  # end
  #   result.store
  # end

  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
    heap.extract if heap.count > k
  end
  heap.store
end
