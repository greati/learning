{- Expressions are reduced to values. A value has a type.
 - A type groups values that share something in common.
 -
 - Data declarations are how datatypes are defined.
 -
 - The type constructor is the name of the type, and it is capitalized.
 -
 - Data constructors are the values that inhabit the type they are defined in.
 -
 -
 - -}

data Bool = False | True
--   (Type constructor) = (Data Constructor) (sum type) (Data Constructor)
-- The datatype  Bool is represented by the values False or True.
data Mood = Blah | Woot deriving Show

{- Typeclasses are a way of adding functionality to types that is
 - reusable across all the types that have instances of that
 - typeclass.
 -
 - -}

{- Tuples use product type:
 - :info (,)
 - data (,) a b = (,) a b
 -
 - It means a values is composed necessarily by providing another two values.
 - -}

{- Lists
 -
 - Differs from tuples:
 - 1 - type homogeneous
 - 2 - [] syntax
 - 3 - the size of the list can change
 -
 -
 - -}

{- Defining an alias for a type:
 - type Oi = String
 -
 - Polymorphism:
 - - parametric
 - - constrained
 -
 - -}
