#Try with ./console in the 
class ArrayList
  attr_reader :size

  def initialize
    @array = FixedArray.new(10)
    @size = 0
  end

  def [](index)
    check_bounds(index)
    @array[index]
  end

  # Define a method "<<" which takes a single argument. This method should
  # append the argument to the end of this ArrayList and increase the size by
  # 1. The return value must be self.

  def << (value)
    #expand_array if @size >= @array.size
    @array[@size] = value
    #@array = @array + [num]
    #puts @array
    #@array[]@size
    #@array.push(num)
    @size+=1
    self
  end

  # Define a method ">>" which takes a single argument. This method should
  # prepend the argument to the beginning of this ArrayList and increase the
  # size by 1. The return value must be self.

  def >> (value)
    #expand_array if @size >= @array.size
    #while @size < 10
      @array[0] = @array[1]
    #end
    @array[0] = value
    @size+=1
    self
  end

  # Define a "delete" method which takes a single index argument. This method
  # should delete the value at the provided index and return it. The size should
  # be 1 less than it was before this method was called. The index must be
  # within the bounds of the ArrayList, or an IndexError should be raised.

  def delete(index)
    #if @size >= index
      @array.delete_at(index)
      @size-=1
    #end
  end

  # Define a method "[]=" which takes 2 arguments. This method should set the
  # value at the index defined in the first argument such that array_list[index]
  # will return the second argument.
  #
  # If the index is negative, an IndexError should be raised.
  #
  # If the index is bigger than the current size of the @array, the @array
  # should be replaced with a bigger FixedArray to fit the new index. All
  # indexes between the former last element and the new index should be
  # initialized with nil. An additional buffer should be included in the new
  # FixedArray (in case the array is grown more), though this is not required.
  #
  # The size after this method is called depends on the index provided. An
  # existing index would not affect the size, but an index greater than the last
  # index will add the difference to the size.

  def []=(index, value)
    if index < 0
      raise "IndexError"
    end
    while index < 10
      @array[index] = value
      @size+=1
    end
    if index == 10
      @array = FixedArray.new(20)
      #FixedArray.new(20) { i @array|i| }
    end
  end


  private

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
