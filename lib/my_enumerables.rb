# frozen_string_literal: true

# making custom enumerables
module Enumerable
  # Your code goes here
  def my_all?
    return to_enum(:my_all?) unless block_given?

    my_each { |elem| return false unless yield(elem) }
    true
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    new_list = []
    my_each { |val| new_list << yield(val) }
    new_list
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    my_each { |elem| return true if yield(elem) }
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each { |elem| count += 1 if yield(elem) }
    else
      count = length
    end
    count
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < length
      yield self[i], i
      i += 1
    end
    self
  end

  def my_inject(accumulator)
    i = 0
    accumulator += self[i]

    while i < length - 1
      accumulator = yield accumulator, self[i + 1]
      i += 1
    end
    accumulator
  end

  def my_none?
    return to_enum(:my_none?) unless block_given?

    my_each { |elem| return false if yield(elem) }
    true
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    new_list = []
    my_each { |elem| new_list << elem if yield(elem) }
    new_list
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < length
      yield self[i]
      i += 1
    end
    self
  end
end
