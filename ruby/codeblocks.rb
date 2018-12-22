=begin
Code blocks are chunks of code inside brackets (one line)
or begin/end keywords that are passed as
parameter to a method invocation. Inside the method,
the word 'yield' makes the block execute. 
=end

# Here I define the method. Look how I do not have to
# indicate in the signature that it is going to call a code block.
def this_calls_a_block
	# Here I'm calling the block that is eventually
	# passed as parameter. This word is what makes the
	# block execute, it's the link between the method
	# and the block code. 
	yield
end

# Now I call the method
this_calls_a_block {puts 'Executing a block'}

# If I call this method without a block as argument, the interpreter will
# throw an error.

# I can, otherwise, check inside the method if a block is passed.
def this_calls_a_block_or_not
	if block_given?
		yield
	else
		puts 'No block.'
	end
end

# Calling...
this_calls_a_block_or_not
this_calls_a_block_or_not {puts 'Executing a block'}

# A block can define local variables and parameters which are block-scoped.
# In order to define these variables, the following sintax is used: |<comma-separated parameters>; <comma-separated local variables>|. For example:

def this_calls_block_with_parameter
	yield('Oi')
end

# When I call, I define the block and declare the parameter that an 'yield' will have to give,
# and all the local variables I'll need.
this_calls_block_with_parameter do |s;a,b|
	puts 's'
	a = s + ', tudo bem?'
	b = s + ', como vai?'
	puts a,b
end

# In short, a good example of a block passing is 'times'.
# Here, the method times from Integer class calls a yield inside a loop.
5.times do |x|
	puts x
end


