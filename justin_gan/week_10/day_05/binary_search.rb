# Binary Search
#
# In your choice of programming languages, implement a binary search function that returns the index of a given element within a sorted array. (You can assume/demand that the array is already sorted, otherwise binary search won't work.)
#
# Pseudocode can be found here: https://www.tutorialspoint.com/data_structures_algorithms/bubble_sort_algorithm.htm
#
# // Example:
# binarySearch([4, 5, 7, 12, 45], 12) // Returns 3
#
# Find an appropriate way of handling errors (for example, what is returned if the element you are searching for is not within the array)

def binarySearch( haystack, needle )
  search_index = haystack.length / 2
  value = haystack[search_index]
  indexes_searched = []
  until value == needle or indexes_searched.include? search_index
    indexes_searched << search_index
    @prev_value = value
    if value < needle
      search_index = (search_index + haystack.length) / 2
    else
      search_index /= search_index
    end
    value = haystack[search_index]
  end
  p indexes_searched
  search_index if value == needle
end

# p binarySearch([4, 5, 7, 12, 45], 12)
