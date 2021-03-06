class SinglyLinkedList

  Node = Struct.new(:value, :next) # TODO: Research how Struct works

  # class Node
  #   attr_accessor :value, :next
  #
  #   def initialize value
  #     @value = value
  #     @next = nil
  #   end
  # end

  attr_accessor :head

  def initialize value=nil
    @head = Node.new value if value
  end

  def prepend value # AKA .unshift
    node = Node.new value
    node.next = @head
    @head = node
  end

  def remove # AKA .shift
    # point @head to @head.next
    @head = @head.next
  end

  def append value # AKA .push
    # TODO: fix this
    last.next = Node.new value
  end

  def last
    node = @head
    while node and node.next
      node = node.next # Traverse by one to the next node in the list.
    end
    node
  end

  def find needle
    # Returns the node with value of needle OR nil
    node = @head
    until node.value == needle or node.next.nil?
      node = node.next
    end
    if node.value == needle then node else nil end
    end

  def insert_after(node, new_node)
    needle = find node
    if needle
      # point new_node.next to needle.next
      detached_node = Node.new new_node
      detached_node.next = needle.next

      # point needle to new_node
      needle.next = detached_node
    end
  end

  def length # AKA .count, .size
    count = 0
    node = @head
    count += 1 unless node.nil?
    # if node then count += 1 end
    while node and node.next
      count += 1
      node = node.next
    end
    count
  end

  def reverse
    # create new SinglyLinkedList
    newSinglyLinkedList = SinglyLinkedList.new
    # traverse through list and prepend nodes to new SinglyLinkedList
    node = @head
    while node
      newSinglyLinkedList.prepend node.value
      node = node.next
    end
    newSinglyLinkedList
  end

  def reverse!
    @head = reverse.head
  end

  def each
    # traverse through list
    node = @head
    while node
      # perform action on node
      yield node.value if block_given?
      node = node.next
    end
  end

  # Also: .map, .inject, etc

  # Bonus: at_index => []
  def at_index index
    # p length, index
    unless index >= length
      current_index = 0
      node = @head
      until current_index == index
        p current_index, index
        node = node.next
        current_index += 1
      end
    end
    node.value unless node.nil?
  end

  def [] index
    # convert to syntactic sugar
    unless index >= length
      current_index = 0
      node = @head
      until current_index == index
        node = node.next
        current_index += 1
      end
    end
    # return value at_index
    node.value unless node.nil?
  end
end

bros = SinglyLinkedList.new 'groucho'
bros.append 'harpo'
bros.append 'chico'

require 'pry'
binding.pry
