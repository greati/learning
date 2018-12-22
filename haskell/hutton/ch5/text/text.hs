module Text where

{- List comprehension: construct new sets from existing ones.
 -
 - The expression x <- [1..5] is called a generator.
 -
 - | is read 'such that'
 - <- is read 'is drawn from'
 -
 - Logical expressions in list comprehensions are called guards.
 -
 - The zip function pairs two lists element by element, until one
 - or both have exhausted.
 -
 -}

comp :: [Int]
comp = [x^2 | x <- [1..5]]

cartesian :: [a] -> [b] -> [(a,b)]
cartesian a b = [(x,y) | x <- a, y <- b]

length :: [a] -> Int
length xs = sum [1 | _ <- xs] {- here the generator is just a counter -}

factor :: Int -> [Int]
factor n = [x | x <- [1..n], n `mod` x == 0]

isPrime :: Int -> Bool
isPrime n = factor n == [1,n]

primes :: Int -> [Int]
primes n = [x | x <- [1..n], isPrime x]

find :: Eq a => a -> [(a,b)] -> [b]
find a t = [b | (k,b) <- t, k == a]
