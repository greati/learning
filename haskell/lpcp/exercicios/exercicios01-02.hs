import Data.Char

{- Exercício 1 -}

-----------------------
-- Versão imediata:
-----------------------

noZeroInPeriod :: Int -> Bool
noZeroInPeriod n = not (zeroInPeriod n)

zeroInPeriod :: Int -> Bool
zeroInPeriod 0 = isZeroDay 0
zeroInPeriod n = zeroInPeriod (n-1) || isZeroDay n

isZeroDay :: Int -> Bool
isZeroDay n
    | sales n == 0 = True
    | otherwise = False

sales :: Int -> Int
sales x
    | x == 0 = 12
    | x == 1 = 20
    | x == 2 = 18
    | x == 3 = 25
    | otherwise = 0

-------------------------
-- Versão mais elaborada:
-------------------------
noZeroInPeriod2 :: Int -> Bool
noZeroInPeriod2 0 = (sales 0) /= 0
noZeroInPeriod2 n = (noZeroInPeriod2 (n-1)) && ((sales n) /= 0)

{- Exercício 2 -}

funct x y z = not ((not (x > z)) && (y >= x))

{- Exercício 3 -}

maiuscula :: Char -> Char
maiuscula c
    | isLower c = chr (ord c + offset)
    | otherwise = c

offset = ord 'A' - ord 'a'

{- Exercício 4 -}

infix 8 &-

(&-) :: Int -> Int -> Int
x &- y = x - 2 * y

{- Exercício 5 -}
{- Retorna a dia mais recente, em caso de empate. -}

greaterSaleDay :: Int -> Int
greaterSaleDay 0 = 0
greaterSaleDay n = if (sales n >= sales k) then n else k
                   where k = greaterSaleDay (n-1)

{- Exercício 6 -}

howManyLess :: Int -> Int -> Int
howManyLess m 0 = if (sales 0 < m) then 1 else 0
howManyLess m d = howManyLess m (d - 1) + aux
                  where aux = if (sales d < m) then 1 else 0
                  
{- Exercício 7 -}

fib 0 = 0
fib n = y  
        where
          (x, y) = fibDupla(n)
          fibDupla 1 = (0,1)
          fibDupla n = (y,z) where (x,y) = fibDupla (n-1)
                                   z = x + y