# Sammy Lee
# Programming Assignment for Week2 in Algorithms

# NOTE: pivot on median (median between first, last, and middle element)

#
# This method counts the number of comparisons 
# in a partition. 
#
def partition(array, left_idx, right_idx)
  num_comp = right_idx - left_idx
  p = array[left_idx]   
  pivot_idx = left_idx
  
  # start your i, j indices to the right
  # i = index where everything to the left of it (excluding i)
  #  is less than the pivot; everything to the right is greater (including i)
  # j = current array index where you're comparing the array element to pivot
  i = left_idx + 1
  j = left_idx + 1

#  puts "left_idx: #{left_idx}, right index: #{right_idx}, #{array[j]} #{j}"
#  puts "pivot = #{p}"
  for j in (left_idx + 1..right_idx)
    if (array[j] < p)
      if (i != j)
        array[i], array[j] = array[j], array[i]
      end
      # worst case: when j == right_idx, i == right_idx + 1
      if (i < right_idx)
        i = i + 1
      end
    end
  end

  # After going through the array, we need to place the pivot
  # in the right place. 
  # if i == left_idx, then there are no elements less than pivot
  if (left_idx + 1 < i and i < right_idx) 
    array[pivot_idx], array[i-1] = array[i-1], array[pivot_idx]
    pivot_idx = i-1
  elsif (i == right_idx)
    if (array[pivot_idx] < array[i]) 
      array[pivot_idx], array[i-1] = array[i-1], array[pivot_idx]
      pivot_idx = i-1
    else
      array[pivot_idx], array[i] = array[i], array[pivot_idx]
      pivot_idx = i
    end
  end
  return array, num_comp, pivot_idx
end

def quickSort(array, start_idx, end_idx)
  num_comp  = 0
  num_comp1 = 0
  num_comp2 = 0
  local_array = array[start_idx..end_idx]

  # Determine the median
  mid_idx_offset = local_array.length % 2 == 1 ? local_array.length/2 : (local_array.length/2 - 1)
  sorted_arr = [array[start_idx], array[end_idx], array[start_idx + mid_idx_offset]].sort
  median = sorted_arr[1]

  # Put pivot (i.e. the median chosen above) to the front
  if (median == array[start_idx])
  elsif (median == array[end_idx])
    array[start_idx], array[end_idx] = array[end_idx], array[start_idx]
  elsif (median == array[start_idx + mid_idx_offset])
    array[start_idx], array[start_idx + mid_idx_offset] = 
      array[start_idx + mid_idx_offset], array[start_idx]
  end
  array_n, num_comp, pivot_idx = partition(array, start_idx, end_idx)

  # Terminate recursion if there's nothing to sort on left and right of pivot
  if (pivot_idx == start_idx and pivot_idx == end_idx)
    return array, num_comp + num_comp1 + num_comp2
  end

  # we have nothing to sort on the left if the start_idx 
  # is the same as the pivot index  
  if (start_idx != pivot_idx) 
    left_array = array_n[start_idx..pivot_idx - 1]
#    puts "Left array with pivot_idx: #{pivot_idx} start_idx: #{start_idx}"
#    puts left_array
    if (left_array.length > 1) 
      array_n, num_comp1 = quickSort(array_n, start_idx, pivot_idx - 1)
    end
  end 
  if (end_idx != pivot_idx)
    right_array = array_n[pivot_idx + 1..end_idx]
#    puts "Right array with pivot_idx: #{pivot_idx}"
#    puts right_array
    if (right_array.length > 1)
      array_n, num_comp2 = quickSort(array_n, pivot_idx + 1, end_idx)
    end
  end
  return array, num_comp + num_comp1 + num_comp2
end

#a = Array.new()
#a = [3, 2, 1, 4, 5]
#a = [1, 3, 2, 4, 5]
#a = [1, 2, 3, 4, 5]
#a = [5, 4, 3, 2, 1]
#a = [1, 3, 5, 2, 4]
#a = [5, 3, 1, 4, 2] 

#a = [1, 2, 3] #3 comparisons
#a = [1, 3, 2] #2 comparisons
#a = [2, 1, 3] #3 comparisons
#a = [2, 3, 1] #3 comparisons
#a = [3, 1 ,2] #2 comparisons
#a = [3, 2, 1] #3 comparisons

a = Array.new()
input = File.open("QuickSort.txt", 'r')
input.each_line { |s|
  s = s.chomp
  #Need Integer function to convert string to integer; or else 
  #it will compare character by character (i.e. 1<10<2<20)
  s = Integer(s) 
  a.push(s)
}
a, num = quickSort(a, 0, a.length-1)
print "Array\n"
puts a
puts "Num comp: #{num}"
