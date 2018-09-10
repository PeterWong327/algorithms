class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = array.select {|num| num < pivot }
    right = array.select { |num| num > pivot }
    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return array if (length - start) <= 1

    barrier = partition(array, start, length, &prc)

    #left
    sort2!(array, start, barrier, &prc)
    # right
    sort2!(array, barrier + 1, length, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }

    #set i to number after start to partition around start
    i = start + 1
    pivot = array[start]
    barrier = start
    # counter = 0

    #go through length of array from start + 1. 
    while i < (start + length)

      if array[i] && prc.call(pivot, array[i]) > 0
        #if pivot is greater than current num, swap w/ first num
        # after barrier. Move barrier to after swapped num.
        array[i], array[barrier + 1] = array[barrier + 1], array[i]
        barrier += 1

      end
      i += 1
    end
    #swap pivot with number left of barrier, return index of barrier
    array[start], array[barrier] = array[barrier], array[start]
    barrier
  end
end
