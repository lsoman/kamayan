class LinkedList
  attr_reader :size

  def initialize
    @head = nil
    @size = 0
  end

  # Use this nested class for storing the values of the LinkedList. Each
  # LinkedList::Node contains the value at its index, and a link to the
  # LinkedList::Node at the next index (called the "child" here). If the child
  # is nil, that denotes the last element of the LinkedList.
  class Node
    attr_accessor :value, :child

    def initialize(value, child = nil)
      @value = value
      @child = child
    end 
  end

  # Define a method ">>" which takes a single argument. This method should
  # prepend the argument to the beginning of this LinkedList and increase the
  # size by 1. The return value must be self.

  def >>(value)
    #irb: require './linked_list.rb', value = LinkedList::Node.new("Hi")
    #@head = Node.new(first_value) if first_value
    new_value = Node.new(value)
    new_value.child = @head

    @head = new_value
    @size = @size+1
    return self
  end

  # Define a method "<<" which takes a single argument. This method should
  # append the argument to the end of this LinkedList and increase the size by
  # 1. The return value must be self.
  def <<(value)
    if @head == nil
      new_node = Node.new(value)
      @head = new_node
      @size = @size+1
    else
      end_node = @head
      while end_node.child != nil
        end_node = end_node.child
      end
      new_value = Node.new(value)
      end_node.child = new_value
      @size = @size+1
    end
    return self
  end

  # Define a "delete" method which takes a single index argument. This method
  # should delete the value at the provided index and return it. The size should
  # be 1 less than it was before this method was called. The index must be
  # within the bounds of the LinkedList, or an IndexError should be raised.

  def delete(index)
    check_bounds(index)
    if index == 0
      delete_node = @head
      @head = @head.child
      @size = @size-1
      return delete_node.value
    else
      parent_node = @head
      i = 1
      while i != index
        parent_node = parent_node.child
        i+=1
      end
      delete_node = parent_node.child
      parent_node.child = delete_node.child
      @size = @size-1
      return delete_node.value
    end
  end

  # Define a method "[]" which takes a single index argument. This method should
  # retrieve the value at the given index. The index must be within the bounds
  # of the LinkedList, or an IndexError should be raised.

  def [](index)
    node = get_node(index)
    return node.value
  end

  # Define a method "[]=" which takes 2 arguments. This method should set the
  # value at the index defined in the first argument such that
  # linked_list[index] will return the second argument.

  def []=(index, value)
    check_lower_bound(index)
    if index < size && size > 0
      node = get_node(index)
      node.value = value
    else
      if size > 0 
        parent_node = get_node(size-1)
      else
        parent_node = nil
      end      
      (size..index).each do |i|
        if i == index
          new_node = Node.new(value)
          if parent_node != nil 
            parent_node.child = new_node
          else 
            @head = new_node
          end
          @size = @size+1
        else
          new_node = Node.new(nil)
          if parent_node != nil 
            parent_node.child = new_node
          else 
            @head = new_node
          end
          @size= @size+1
          parent_node = new_node
        end
      end
    end
  end
  #
  # If the index is negative, an IndexError should be raised.
  #
  # If the index is bigger than the current size of the linked list, the links
  # should be adjusted to fit the new index.  All indexes between the former
  # last element and the new index should be initialized with nil.
  #
  # The size after this method is called depends on the index provided. An
  # existing index would not affect the size, but an index greater than the last
  # index will add the difference to the size.

  private

  def get_node(index)
    check_bounds(index)
    node = @head
    (0..@size).each do |i|
      if i == index
        return node
      else
        node = node.child
      end
    end
  end

  def check_bounds(index)
    check_lower_bound(index)
    check_upper_bound(index)
  end

  def check_lower_bound(index)
    raise IndexError, "Invalid index: #{index}" if index < 0
  end

  def check_upper_bound(index)
    raise IndexError, "Invalid index: #{index}" if index >= size
  end
end
