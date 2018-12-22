module CheckProps where

import Test.QuickCheck

prop01 :: (Num a, Eq a) => [a] -> [a] -> Bool
prop01 xs ys = (sum (xs ++ ys) == sum xs + sum ys)

prop02 xss yss = (concat (xss ++ yss) == concat xss ++ concat yss)

prop03 :: (Eq a) => (a -> Bool) -> [a] -> [a] -> Bool
prop03 p xs ys = (filter p (xs ++ ys) == (filter p xs ++ filter p ys))

prop04 f xs ys = map f (xs ++ ys) == map f xs ++ map f ys 

prop05 xs = sum (reverse xs) == sum xs 

prop06 xs = length (reverse xs) == length xs 

prop07 w xs ys = (w `elem` (xs ++ ys)) == (w `elem` xs || w `elem` ys)

prop08 ps = zip (fst (unzip ps)) (snd (unzip ps)) == ps 

prop09 n xs = take n xs ++ drop n xs == xs 

prop10 f xs = (head . (map f)) xs == (f . head) xs

prop11 xs = map id xs == id xs

prop12 g h xs = map (g . h) xs == (map g . map h) xs 
