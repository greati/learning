module ExRat
    ( rat
    , Rat
    , (//)
    , denominator
    , numerator
    ) where

data Rat = MkRat Integer Integer

instance Show Rat where
    show (MkRat x y) = show x ++ "/" ++ show y

instance Eq Rat where
    (==) x y = (numerator m == numerator n) && (denominator m == denominator n)
                where   m = simp x 
                        n = simp y

instance Num Rat where
    (+) (MkRat x1 y1) (MkRat x2 y2) = simp (rat (x1 * y2 + x2 * y1) (y1 * y2))
    (*) x y = rat (numerator x * numerator y) (denominator x * denominator y)
    negate x = rat (-(numerator x)) (denominator x)
    abs x = rat (abs (numerator x)) (abs (denominator x))
    signum (MkRat x y) 
        | x > 0 && y > 0 || x < 0 && y < 0 = rat 1 1
        | x == 0 = rat 0 1
        | otherwise = rat (-1) 1
    fromInteger x = rat x 1

instance Ord Rat where
    compare (MkRat x1 y1) (MkRat x2 y2) 
        | m > n  = GT
        | m < n  = LT
        | m == n = EQ
            where   m = (x1 * y2) 
                    n = (x2 * y1)

rat :: Integer -> Integer -> Rat
rat x y 
    | y == 0 = error "Denominator can't be zero."
    | y < 0 = MkRat (-x) (-y)
    | otherwise = MkRat x y

simp :: Rat -> Rat
simp (MkRat x y)
    | y /= 0 = MkRat (x `div` mdc) (y `div` mdc) 
    | otherwise = error "Denominator can't be zero."
    where mdc = maximum [k | k <- [1..(min x y)], x `mod` k == 0, y `mod` k == 0]

(//) :: Rat -> Rat -> Rat
(//) (MkRat x1 y1) (MkRat x2 y2) = MkRat (x1 * y2) (y1 * x2)

denominator :: Rat -> Integer
denominator (MkRat x y) = y

numerator :: Rat -> Integer
numerator (MkRat x y) = x

