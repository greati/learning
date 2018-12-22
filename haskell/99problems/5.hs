module Five where

myReverse :: [a] -> [a]
myReverse [] = []
myReverse xs = (last xs) : (myReverse (init xs))

myReverse' :: [a] -> [a]
myReverse' [] = []
myReverse' (x:xs) = myReverse xs ++ [x]
