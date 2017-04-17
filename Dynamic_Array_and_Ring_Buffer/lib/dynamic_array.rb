require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new
    @length = 0
    @capacity = 8
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

  # O(1)
  def pop
    check_index(0)
    @store[length - 1] = nil
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    if @length == capacity
      resize!
    end
    @store[length] = val
    @length += 1

  end

  # O(n): has to shift over all the elements.
  def shift
    check_index(0)
    first = @store[0]
    (@length - 1).times do |idx|
      @store[idx] = @store[idx + 1]
    end
    @store[@length] = nil
    @length -= 1
    first
    # @start_idx = (@start_idx - 1) % capacity
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    # @start_idx = (@start_idx - 1) % capacity
    # @store[@start_idx] = val
    if @length == capacity
      resize!
    end
    @length.downto(1) do |idx|
      @store[idx] = @store[idx - 1]
    end

    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length || index < 0
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_array = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_array[i] = @store[i]
      i += 1
    end
    @array = new_array
  end
end
