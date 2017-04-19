class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      left.push(el) if el <= pivot
      right.push(el) if el > pivot
    end
    sorted_left = self.sort1(left)
    sorted_right = self.sort1(right)
    return sorted_left + [pivot] + sorted_right
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if array.length <= 1
    pivot_idx = self.partition(array, start, length, &prc)
    left = array[start...pivot_idx]
    right = array[(pivot_idx + 1)..length]
    sorted_left = self.sort2!(left, start, pivot_idx + 1)
    sorted_right = self.sort2!(right)
    p sorted_left
    p array[pivot_idx]
    p sorted_right
    p "-----"
    p sorted_left + [array[pivot_idx]] + sorted_right
    p "-----"
    return sorted_left + [array[pivot_idx]] + sorted_right

  end

  def self.partition(array, start, length, &prc)
    return array if array.length <= 1
    length = start + length
    pivot = array[start]
    verystart = start
    # border = start + 1
    prc = Proc.new {|el1, el2| el1 <=> el2 } unless block_given?
    current_idx = start + 1
    while current_idx < length
      comp = prc.call(pivot, array[current_idx])
      case comp
      when 1
        array[start + 1], array[current_idx] = array[current_idx], array[start + 1]
        start += 1
      when 0
        array[start + 1], array[current_idx] = array[current_idx], array[start + 1]
        start += 1
      end

      current_idx += 1
    end
    array[verystart], array[start] = array[start], array[verystart]
    start
  end
end
