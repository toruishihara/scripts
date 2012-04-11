#!/usr/bin/ruby

# pick up 4 highest number in in_array, then return as out_array
def get_highest4(in_array)
  # keep 4 highest in this array
  out_array = Array.new(4)
  in_array.each { |i|
   # most of case, skip to next number immediately
   if (i < out_array[3].to_i ) then
     next
   end
   
   for j in 0..3
     if ( i > out_array[j].to_i ) then
       # shift in out_array
       k = 3
       while k > j
         out_array[k] = out_array[k-1] 
         k = k-1
       end
      
      # keep Nth highest in out_array 
	  out_array[j] = i
	  break
     end
   end
  }
  return out_array
end

# test array
ints = [72,1,44,7,98,4,1,4,5,6,88,9,99]
highs = get_highest4(ints)
p highs
