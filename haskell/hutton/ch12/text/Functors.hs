module Functors where

import Prelude

-- Notice the common construction of these two functions:

inc :: [Int] -> [Int]
inc [] = []
inc (n:ns) = n + 1 : inc ns

sqr :: [Int] -> [Int]
sqr [] = []
sqr (n:ns) = n^2 : sqr ns

-- The map function could do both jobs

-- inc = map (+1)
-- sqr = map (^2)


-- The idea of mapping a function over each element of a data structure isn't specific 
-- to the type os lists, but can be abstracted further to a wide range of parameterized types.
-- The class of types that support such a mapping function are called functors.
-- The class Functor demands the implementation of the fmap function, with takes a function
-- a -> b, a value of type f a, and returns a value of type f b, where f is a 
-- parameterized type.

-- For example, consider the type Maybe a. It can be transformed into a functor by:
data MyMaybe a = MyNothing | MyJust a

instance Functor MyMaybe where
    fmap _ MyNothing = MyNothing
    fmap g (MyJust x) = MyJust (g x)

-- Also, for data structures:
data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Show)

instance Functor Tree where
    fmap g (Leaf x) = Leaf (g x)
    fmap g (Node l r) = Node (fmap g l) (fmap g r)

-- Advantages: fmap can be used to process the elements of any structure that is functorial; 
-- we can define generic functions that can be used with any functor.
-- The fmap must obey to two equational laws:
-- fmap id = id
-- fmap (g . h) = fmap g . fmap h
-- The instances of Functor for a given parameterized type are uniquely determined: 
-- if it is possible to make a given parameterized type into a functor, there is only
-- one way to achieve this.
