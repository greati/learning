=begin
When we have a block, which is not an object, and convert it to an object, it becomes
an object of class Proc.

This can be done by calling the method lambda of the class Object.
=end

prc = lambda{"hello"}

# examples
prc = lambda {puts 'Hello'}

# call method makes the block execute
prc.call

# examples
toast = lambda do 
	'Cheers'
end

puts toast.call

# It's possible to pass procs to methods
# and return procs from methods
def some_mtd some_proc
	puts 'Start of mtd'
	some_proc.call
	puts 'End of mtd'
end

say = lambda do 
	puts 'Hello'
end

some_mtd say

# Passing argument using lambda
a_Block = lambda {|x| "Hello #{x}"}
puts a_Block.class 'World!'

