module ExFun where

import Prelude hiding ( exp )

-- Nat datatype --------------------------------

data Nat = Z | S Nat
     deriving (Eq, Show)

instance (Num Nat) where
    (+) = add
    (*) = mul
    abs = id
    fromInteger 0 = Z
    fromInteger n
      | n > 0     = S $ fromInteger (n-1)
      | otherwise = Z
    signum Z = Z
    signum n = S Z
    negate n = Z

instance (Ord Nat) where
    Z     <= m     = True
    (S n) <= Z     = False
    (S n) <= (S m) = n <= m

{- definitions of add, mul, exp: 

add n Z     = n
add n (S m) = S (add m n)

mul n Z     = Z
mul n (S m) = add (mul n m) n

exp n Z     = S Z
exp n (S m) = mul (exp n m) n

-}

------------------------------------------------

add = fun 0
mul = fun 1
exp = fun 2

fun :: Integral i => i -> (Nat -> Nat -> Nat)
fun 0 n Z = n
fun 0 n (S m) = S (fun 0 n m)
fun 1 n Z = Z
fun i n Z = S (fun (i-1) n Z)
fun i n (S m) = fun (i-1) (fun i n m) n

