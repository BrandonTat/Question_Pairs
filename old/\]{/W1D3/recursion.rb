require 'byebug'

def fibonacci(n)
  arr = [1, 1]
  return arr if n < 2

  arr = fibonacci(n - 1)
  arr << arr[-1] + arr[-2]
end

def fibonacci_it(n)
  arr = []
  n.times do
    if arr.length < 2
      arr << 1
    else
      arr << arr[-1] + arr[-2]
    end
  end
  arr
end

def combo_subsets(arr)
  #debugger
  return [] if arr[0] == []
  combos = arr.combination(arr.length - 1).to_a
  combos.each do |el|
    combos = combos | subsets(el)
  end
  combos << arr
end

def subsets(arr)
  #debugger
  return [] if arr[0] == []
  combos = arr.combination(arr.length - 1).to_a
  combos.each do |el|
    combos = combos | subsets(el)
  end
  combos << arr
end

def factorial(number)
  return 1 if number == 1
  number * factorial(number - 1)
end



def permutations(arr)
  return [arr] if arr.length == 1

  last = arr.pop
  arr.map.with_index do |el, i|
    [el].insert(i, last)
  end
  arr
end

def bsearch(array, target)
  if array.last == target
    return (array.length - 1)
  else
    return nil if array.length == 1
    bsearch(array[0..-2], target)
  end
end

def merge_sort(arr)
  half = arr.length/2
  left = arr[0...half]
  right = arr[half..-1]
  if arr.length <= 1
    return arr
  else
    merge_helper(merge_sort(left), merge_sort(right))
  end
end

def merge_helper(a,b)
  a_f = a.first
  b_f = b.first
  if a_f > b_f
    return a, b = [b, a]
  else
    return a, b = [a, b]
  end
end
