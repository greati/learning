module P1 where

sumMult35 :: Int -> Int
sumMult35 n = sum ([0,3..(n-1)]++[0,5..(n-1)]) - sum [0,15..(n-1)]
