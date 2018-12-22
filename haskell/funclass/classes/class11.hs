module Class11 where

sumLastThree :: Num a => [a] -> a
sumLastThree = sum . take 3 . reverse

sumLast :: Num a => Int -> [a] -> a
sumLast k = sum . take k . reverse

