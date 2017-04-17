# This class just dumbs down a regular Array to be staticly sized.
class StaticArray
  def initialize(length = 0)
    @store = Array.new(length)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]


  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  protected
  attr_accessor :store

  def check_index(index)
    raise "index out of bounds" if index >= @store.length
  end
end
