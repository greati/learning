# Simply put, Arrays are lists of elements in order. They
# are acessed by indexes from 0 to size-1. 'size' and 'length'
# are methods that return the number of elements inside an
# Array. Negative indexes accesses starting from the end.
# If a index out of the bounds is given, it throws a nil,
# not an exception. Examples:


a = [] 		# empty array
puts a[0]	# throws nil

b = [1]		# array with 1 element
puts b[0]
puts b[1]
puts b.size, b.length

c = [1,2,[2,3,4],3,4]	# array with 5 elements, one of them is another array
puts c.size
puts c[2][0]		# getting the first element from array inside the array

# Arrays are dynamic! And look how an array can have objects of different types!
d = [1,2,3,4]
puts d.size
d[4] = 'Vitor'
puts d.size, d[4]
d[10] = 1.2
puts d[10]

# Class Array provides interesting methods:

e = [5,4,3] 

# sorting in-place (!); for a sort that returns the array sorted, use without the bang (!)
e.sort!
puts e

# first and last elements
puts e.first
puts e.last

# we can iterate over the elements simply using the each method
e.each do |l|
	puts 'Hello,' + l.to_s
end

# deleting in the middle and shifting the remainings
e.delete(4)

# When a method returns more than one value, the returned result is an
# array!
def k 
	return 1,2,3
end
puts k[1]

# Parallel assignment! :o
# We call lvalues the values at the left of the '=', and rvalues those at the right side. The interpreter
# starts at the rvalues, from left to right, putting the values in an array. Then the lvalues are inspected
# and if contains only one element, the array is assigned to it; otherwise, if ut contains a comma, 
# each value of the array will be assigned respectively to the elements of the lvalues.

a,b = 1,2
puts a,b # a==1 and b==2

a = 1,2,3,4,5 # a is an array now!
puts a

a, = 1,2,3 # a==1

# Environment variables: the ENV variable is the link between Ruby programs and
# system variables. It's a hash (key/value).

# Command-line arguments: the ARGV array stores the command-line arguments.

# The support for command-line options is given by getoptlong library.

# Finally, to wrap objects into an array, we can use the special Kernel module Array Array(obj).














