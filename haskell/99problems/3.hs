module Three where

elementAt :: Int -> [a] -> a
elementAt i xs = xs !! (i - 1)

elementAt' :: Int -> [a] -> a
elementAt' 1 (x:xs) = x
elementAt' i (_:xs) = elementAt' (i-1) xs
