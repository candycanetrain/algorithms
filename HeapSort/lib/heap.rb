class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
  end

  def extract
  end

  def peek
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, @store.length - 1)
    val
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    left_child = 2 * parent_index + 1
    right_child = 2 * parent_index + 2

    children.push(left_child) if left_child < len
    children.push(right_child) if right_child < len
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1)/2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = Proc.new {|el1, el2| el1 <=> el2 } unless block_given?
    p array

    while !self.child_indices(len, parent_idx).empty?
      if self.child_indices(len, parent_idx)[0]
        if prc.call(array[parent_idx], array[self.child_indices(len, parent_idx)[0]]) == 1
          left_child_index = self.child_indices(len, parent_idx)[0]
          array[parent_idx], array[left_child_index] = array[left_child_index], array[parent_idx]
          parent_idx = left_child_index
        end
        p array
      elsif self.child_indices(len, parent_idx)[1]
        if prc.call(array[parent_idx], array[self.child_indices(len, parent_idx)[1]]) == 1
          right_child_index = self.child_indices(len, parent_idx)[1]
          array[parent_idx], array[right_child_index] = array[right_child_index], array[parent_idx]
          parent_idx = right_child_index
        end
        p array
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc = Proc.new {|el1, el2| el1 <=> el2 } unless block_given?

    while child_idx > 0
      parent_idx = self.parent_index(child_idx)
      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
        child_idx = parent_idx
      end
    end
    array
  end
end
