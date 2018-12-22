=begin

Classes are first-class objects, each is an instance of class Class.

When a new class is defined, an object of type Class is created and assigned to a constant (with the name of the class, suppose Name.).

When Name.new is called to create a new object, the new class method in Class is run by default, which in turn invokes allocate to allocate memory for the object, before finally calling the new object's initialize method.

The constructing and initializing phases of an object are separate and both can be over-ridden.

The construction is done via new class method; the initialization, via initialize instance method.

Initialize is not a constructor!

(rubylearning.com)
=end

# Defining a class

class Dog

	def initialize(breed, name)
		# here comes the instance variables
		@breed = breed
		@name = name
	end

	def bark
		puts 'Ruff!'
	end

	def display
		puts 'I am of #{@breed} breed and my name is #{@name}'
	end
end

# Make an object
d = Dog.new('Labrador','Benzy');

# Every object in Ruby has an id associated

# It's sometimes important to check if the object has a method (if it
# responds to a message)
if d.respond_to?("talk")
	d.talk
else
	puts "Sorry, d doesn't understand it."
end

# Call methods (send messages to d)
d.bark
d.display

# Make d1 point to the same object as d
d1 = d
d1.display

# Make d points to nothing
d = nil
d.display

# If now
d1 = nil

# Then the Dog object is abandoned and can be collected by GC, which uses
# the mark-and-sweep approach (check if an object is in use, and mark to keep or not), then frees the memory of the not marked objects

# Objects are created on the heap

# Instead of creating a object directly with it's Class.new method, 
# it's possible to invoke some literal constructor for 
# some kind of objects

s1 = "Hi"
s2 = 'Hi'
a = [1,2,3]
h = {'oi' => 'hi'}
r = 1..2

# Class methods: the idea is to sent a message to the object that is the class, and not to one of the class's instances.

# Some notation that is not part of Ruby's syntax

# Dog#bark : it's the instance method bark inside Dog class
# Dog.color : it's the class method color, in the class Dog
# Dog::color : another way to refer to the class method color 

# There's a way to provide a message when a method is missing
class Dummy
	def method_missing(m, *args, &block)
		puts "No method called #{m} here..."
	end
end


