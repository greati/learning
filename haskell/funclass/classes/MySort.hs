module MySort
    ( sort
    , msort
    , isort
    , qsort
    ) where

import Prelude hiding ( sort )

sort :: Ord a => [a] -> [a]
sort = msort

msort :: Ord a => [a] -> [a]
msort []     = []
msort [x]    = [x]
msort xs = merge (msort ys) (msort zs)
    where (ys,zs) = halve xs

halve :: [a] -> ([a],[a])
halve xs = splitAt n xs
    where n = (length xs) `div` 2

halve' :: [a] -> ([a],[a])
halve' [] = ([],[])
halve' [x] = ([x],[])
halve' (x:xs) = (x : ys, last xs : zs)
    where (ys,zs) = halve' (init xs)

{- As-patterns: @ -}
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge xs'@(x:xs) ys'@(y:ys) 
    | x <= y = x : merge xs ys'
    | y < x = y : merge xs' ys

isort :: Ord a => [a] -> [a]
isort []     = []
isort (x:xs) = insert x (isort xs)

insert :: Ord a => a -> [a] -> [a]
insert w [] = [w]
insert w (x:xs) 
    | w <= x = w:x:xs
    | otherwise = x : insert w xs

qsort :: Ord a => [a] -> [a]
qsort []     = []
qsort (w:ws) = qsort left ++ [w] ++ qsort right
    where   left = [x | x <- ws, x <= w]
            right = [x | x <- ws, x > w]
          
prop_qsortLen xs = length xs == length(qsort xs)
