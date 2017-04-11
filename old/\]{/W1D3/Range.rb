def range_recursive(start, range_end)
  return [] if range_end < start
  return [start + 1] if start + 1 == range_end - 1
  [start + 1].concat(range_recursive(start + 1, range_end))
end

def range_it(start, end_range)
  array = []
  (end_range - start - 1).times do |i|
    array << (start + i + 1)
  end
  array
end

def sum_array(array)
  return array[0] if array.length <= 1
  array[0] + sum_array(array[1..-1])
end

def expo(base, exp)
  return 1 if exp == 0
  base * expo(base, exp - 1)
end

def expo_two(base, n)
  return 1 if n == 0
  if n.even?
    expo_two(base, n / 2) * expo_two(base, n / 2)
  else
    base * (expo_two(base, (n-1) / 2) * expo_two(base, (n-1) / 2))
  end
end

class Array

  def deep_dup
    arr = []
    self.each do |el|
      if el.is_a?(Array)
        arr << el.deep_dup
      else
        arr << el
      end
    end
    arr
  end

end
