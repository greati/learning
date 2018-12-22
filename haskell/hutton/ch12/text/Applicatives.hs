module Applicatives where

-- We want Functors to accept functions with more than one argument.

-- Using the idea of currying, a version of fmap with any desired number of arguments
-- can be constructed in terms of two basic functions:
-- pure :: a -> f a
-- (<*>) :: f (a->b) -> f a -> f b

-- In this way, for making g a function of n arguments, it is typically written:
-- pure g <*> x1 <*> x2 <*> ... <*> xn, where <*> is associative to the left.

-- The class of functors that support both pure and <*> are called applicative functions,
-- or applicatives for short.

-- For the Maybe type:
data MyMaybe a = MyNothing | MyJust a

instance Functor MyMaybe where
    fmap _ MyNothing = MyNothing
    fmap g (MyJust x) = MyJust (g x)

instance Applicative MyMaybe where
    pure = Just
    
    Nothing <*> _ = Nothing
    (Just g) <*> mx = Just (g mx)

-- This is a kind of exceptional programming in which we can apply pure functions
-- to arguments that may fail without the need to manage the propagation of failure
-- by hand.

{- The common theme between the examples of applicatives is that
 - they all concern programming with effects. The applicative style provides
 - a way to apply functions to arguments, with the key difference that
 - these arguments are no longer just plain values, but may also have effects:
 - fail, many ways to succeed or performing input/output actions.
 - 
 - In this way, applicative functors can also be viewed as abstracting the idea
 - of applying pure functions to effectful arguments, with the precise
 - form of effects that are permitted depending on the nature of the underlying
 - functor.
 -
 - Applicative functors are required to satisfy four equational rules:
 - pure id <*> x = x
 - pure (g x) = pure g <*> pure x
 - x <*> pure y = pure (\g -> g y) <*> x
 - x <*> (y <*> z) = (pure (.) <*> x <*> y) <*> z
 -
 - }
