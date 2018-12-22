module Ch3 where

{-- Types
 -
 - Integer is different from Int: the former allows bigger numbers; the last is
 - more efficient and is bounded.
 -
 --}


addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

addTwo :: (Int, Int) -> Int
addTwo (x,y) = x + y

{- Type variables
 -
 - head :: [a] -> a
 -
 - Functions with type variables are polymorphic functions.
 - -}

{- Typeclasses
 -
 - Interface that defines some behaviour
 -
 - (==) :: (Eq a) => a -> a -> Bool
 -
 - Everything before => is called a class constraint.
 - Example: Eq, Ord, Show, Read, Enum, Bounded (minBound, maxBound), Num, Integral, Floating
 -
 - Type annotations allows explicitly saying what type a expression should be:
 - read "5" :: Double
 - 
 - fromIntegral takes an Integral and returns a more general number.
 - 
 --}
