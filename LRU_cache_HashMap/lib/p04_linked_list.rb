class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @sentinel = Link.new
    @sentinel.prev = @sentinel
    @sentinel.next = @sentinel
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel.next
  end

  def last
    @sentinel.prev
  end

  def empty?
    @sentinel.next == @sentinel
  end

  def get(key)
    current_link = @sentinel.next
    until current_link == @sentinel
      return current_link.val if current_link.key == key
      current_link = current_link.next
    end
    
    return nil
  end

  def include?(key)
    get(key) != nil
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    new_link.next = @sentinel
    last.next = new_link
    @sentinel.prev = new_link
  end

  def update(key, val)
    current_link = @sentinel.next
    until current_link == @sentinel
      if current_link.key == key
        current_link.val = val
        break
      end
      current_link = current_link.next
    end
    
  end

  def remove(key)
    current_link = first
    until current_link == @sentinel
      if current_link.key == key
        current_link.prev.next = current_link.next
        current_link.next.prev = current_link.prev
      end

      current_link = current_link.next
    end
    
  end

  def each(&blk)
    current_link = first
    until current_link == @sentinel
      blk.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
