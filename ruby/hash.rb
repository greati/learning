=begin
Hashes are arrays indexed by any kind of object.
=end

# Declaring a hash giving the objects, attention to the special notation
h = {'dog' => 'canine', 'cat' => 'feline', 20 => 'Vitor'}
puts h.length
puts h['dog']
puts h[20]

# It's better to use symbols instead of Strings:

h = {:nickname => 'greati', :language => 'pt-br'}
puts h[:nickname]

# In this case (keys are not numbers!) we can use the following short syntax:

h = {nickname:'greati', language:'pt-br'}
puts h

