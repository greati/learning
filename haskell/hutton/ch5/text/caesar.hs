module Caesar where

import Data.Char (chr, ord, isLower)

let2Int :: Char -> Int
let2Int c = ord c - ord 'a'

int2Let :: Int -> Char
int2Let n = chr(ord 'a' + n)

shift :: Char -> Int -> Char
shift c n | isLower c = int2Let ((let2Int c + n) `mod` 26)
          | otherwise = c

encode :: [Char] -> Int -> [Char]
encode s n = [shift s' n | s' <- s]
