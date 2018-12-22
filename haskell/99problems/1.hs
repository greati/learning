module One where

myLast :: [a] -> a
myLast [] = error "No elements in the list."
myLast xs = xs !! (length xs - 1)

myLast' :: [a] -> a
myLast' [] = error "No elements in the list."
myLast' [x] = x
myLast' (x:xs) = myLast' xs
