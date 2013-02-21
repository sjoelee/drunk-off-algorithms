# Sammy Lee
# Programming assignment for Week1 in Algorithms

class Array
  def mergesort_and_count_inversions 
    sorted_array, count_inv = divide(self)
    for i in sorted_array
      puts "#{i} "
    end
    puts ""
    puts "Number of inversions: %d" % count_inv
  end

  protected
  def merge_and_count_inversions (first_array,
                                  second_array)
    i = 0
    j = 0
    k = 0
    num_inv = 0
    combined_length = first_array.length + second_array.length
    combined = Array.new

#    print "First Array"
#    puts first_array[0]
#    print "SEcond array"
#    puts second_array[0]
#

    for k in (0..combined_length)
      if (first_array[i] < second_array[j]) 
        combined[k] = first_array[i]
        if i == (first_array.length - 1)
          k += 1
          combined[k, combined_length - 1] = second_array[j..second_array.length - 1]
          break
        end
        i += 1
      else
        combined[k] = second_array[j]
        num_inv = num_inv + first_array.length - i
        if j == (second_array.length - 1)
          k += 1
          combined[k, combined_length - 1] = first_array[i..first_array.length - 1]
          break
        end
        j += 1
      end
    end
    return combined, num_inv
  end

  def divide(input_array)
    num_inv0 = 0
    num_inv_subarr1 = 0
    num_inv_subarr2 = 0
    length = input_array.length

    first_subarray = input_array[0..input_array.length/2 - 1]
    second_subarray = input_array[(input_array.length/2)..length]
    # Recursion needs a terminal condition
    if (first_subarray.length > 1) 
      first_subarray, num_inv_subarr1 = divide(first_subarray)
    end
    if (second_subarray.length > 1) 
      second_subarray, num_inv_subarr2 = divide(second_subarray)
    end
    combined_array, num_inv0 = merge_and_count_inversions(first_subarray,
                                                          second_subarray)
    return combined_array, num_inv0 + num_inv_subarr1 + num_inv_subarr2
  end

end


a = Array.new()
#a = [99959, 9996, 99960, 99961, 99962, 99963, 99964, 99965, 99966, 99967, 99968, 99969, 99970]
#a = [1, 10, 100, 1000, 10000, 2, 20, 3, 2000, 200, 300, 30, 4, 400, 40]
#File.open("IntegerArray.txt").each do |line|
#  number = line.chomp
#  number = number.scan(/\b\d{1,6}\b/)
#  a.push(number)
#end
#
#for i in a
#  puts "#{i}"
#end
input = File.open("IntegerArray.txt", 'r')
input.each_line { |s|
  s = s.chomp
  #Need Integer function to convert string to integer; or else 
  #it will compare character by character (i.e. 1<10<2<20)
  s = Integer(s) 
  a.push(s)
}
input.close
a.mergesort_and_count_inversions

