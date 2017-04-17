require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @store = StaticArray.new
    @length = 0
    @capacity = 8
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    real_idx = (@start_idx + index) % capacity
    @store[real_idx]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    real_idx = (@start_idx + index) % capacity
    @store[real_idx] = val
  end

  # O(1)
  def pop
    check_index(0)
    real_end = (@start_idx + @length - 1) % capacity
    last = @store[real_end]
    @store[real_end] = nil
    @length -= 1
    last
  end

  # O(1) ammortized
  def push(val)
    if @length == @capacity
      resize!
    end
    real_end = (@start_idx + @length - 1) % capacity
    @store[real_end] = val
    @length += 1
  end

  # O(1)
  def shift
    check_index(0)
    first = @store[@start_idx]
    # (@length - 1).times do |idx|
    #   @store[idx] = @store[idx + 1]
    # end
    # @store[@length] = nil
    @store[@start_idx] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    first
  end

  # O(1) ammortized
  def unshift(val)
    if @length == @capacity
      resize!
    end
    # @length.downto(1) do |idx|
    #   @store[idx] = @store[idx - 1]
    # end
    @start_idx = (@start_idx - 1) % @capacity
    # if @start_idx == 0
    #   push(val)
    #   @start_idx = @length
    # else
      # @store[@start_idx - 1] = val
    #   @start_idx -= 1
    # end
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    if index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    i = 0
    while i < @length
      new_store[i] = @store[@start_idx]
      i += 1
    end
    @store = new_store

  end
end
