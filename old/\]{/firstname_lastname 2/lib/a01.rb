class Array
  # Write a method that binary searches an array for a target and returns its
  # index if found. Assume a sorted array

  # NB: YOU MUST WRITE THIS RECURSIVELY (searching half of the array every time).
  # We will not give you points if you visit every element in the array every time
  # you search.

  # For example, given the array [1, 2, 3, 4], you should NOT be checking
  # 1 first, then 2, then 3, then 4.

  def binary_search(target)
    prc ||= Proc.new {|num1, num2| num1 <=> num2}
    return nil if empty?
    mid = length/2
    return mid if self[mid] == target
    if prc.call(self[mid], target) == -1
      drop(mid+1).binary_search(target).nil? ? nil : drop(mid+1).binary_search(target) + mid + 1
    else
      take(mid).binary_search(target)
    end
  end
end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    sum_zero = []
    (0...length).each do |i|
      (i+1...length).each do |j|
        sum_zero << [i, j] if self[i] + self[j] == target
      end
    end
    sum_zero
  end
end

# Write a method called 'sum_rec' that
# recursively calculates the sum of an array of values
def sum_rec(nums)
  return 0 if nums.empty?
  return nums[0] if nums.length == 1
  nums[0] + sum_rec(nums[1..-1])
end

class String
  # Write a method that finds all the unique substrings for a word

  def uniq_subs
    uniq_strings = []
    (0...length).each do |i|
      (i...length).each do |j|
        uniq_strings << self[i..j]
      end
    end
    uniq_strings.uniq
  end
end

def prime?(num)
  (2...num).each do |n|
    return false if num % n == 0
  end
  true
end

# Write a method that sums the first n prime numbers starting with 2.
def sum_n_primes(n)
  return 0 if n == 0
  prime_nums = []
  i=2
  until prime_nums.length == n
    prime_nums << i if prime?(i)
    i+=1
  end
  prime_nums.reduce(:+)
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    (0...length).each do |i|
      prc.call(self[i])
    end
    self
  end
end

class Array
  # Write a method that calls a block for each element of the array
  # and returns a new array made up of the results
  def my_map(&prc)
    new_arr = []
    my_each do |el|
      new_arr << prc.call(el)
    end
    new_arr

  end
end
