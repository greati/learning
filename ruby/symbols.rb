=begin
Symbols are prefixed with a colon (:), line :articles, :actions.
A particular symbol doesn't have to be initialized and will hold
the same value during all the execution. :<word> can be read as
"the thing named <word>", while <word> is the value of thing 
stored in <word>.

A symbol is the most basic Ruby object you can create. It's just
a name and an internal ID. Symbols always refer to the same object, so
they are more efficient than strings (which are always different objects).

If the content of the object is important, better to use strings.
Otherwise, if the identity is more important, use a symbol.

Symbols are actually names. Every entity in a ruby program (names of methods, names of instance variables, names of classes...) has a symbol associated. They are stored in a Symbol Table (call Symbol.all_symbols to see all).

Practical example: using symbols as hash keys.

(rubylearning.com)
=end

:this_is_a_new_symbol
puts Symbol.all_symbols
