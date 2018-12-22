{- 1. length :: [a] -> Int
 -    one argument, of List
 -    Int
 - 2. a. 5, b. 3, c. 2, d. 5
 - 3. The second one, since length returns an integer
 - 4. Use a length' :: [a] -> Double
 - 5. Bool. True.
 - 6. Bool. False.
 - 7. a. Not, b. Not. , c.Yes., d.Yes., e.Not.
 - -}

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == reverse xs

myAbs :: Integer -> Integer
myAbs x = if x >= 0 then x else -x

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f x y = ((snd x, snd y), (fst x, fst y))

x = (+)
f1 xs = w `x` 1
      where w = length xs

id x = x

k = \(x:xs)->x

m (a, b) = a

{- 1. c
 - 2. b
 - 3. a
 - 4. d
 -
 -
 - -}
