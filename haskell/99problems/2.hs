module Two where

myButLast :: [a] -> a
myButLast [] = error "Empty list."
myButLast [x] = error "Too few elements."
myButLast (x:_:[]) = x
myButLast (_:xs) = myButLast xs

myButLast' [x,_] = x
myButLast' (x:xs) = myButLast' xs
