=begin
Ranges are Ruby objects that are mainly used
to represent sequences. A sequence is a Range
object containing reference to two Fixnum objects.
They can be built using ".." operator (inclusive
range) or "..." operator (high exclusive range).
=end

# A first example of a sequence
(1..10).to_a # [1,2,3,4,5,6,7,8,9,10]

# Methods of the Range
digits = -1..9
puts digits
puts digits.include?(5)
puts digits.min
puts digits.max
puts digits.reject {|i| i < 5}

# Ranges can be used for interval testing
puts (1..10) === 5 # true
puts ('a'..'c') === 'c' #true
