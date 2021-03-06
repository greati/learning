module ExNat where

-- Do not alter this import!
import Prelude
    ( Show(..)
    , Eq(..)
    , Ord(..)
    , Num(..)
    , Integral
    , Bool(..)
    , not
    , (&&)
    , (||)
    , (++)
    , ($)
    , (.)
    , undefined
    , otherwise
    , error
    )

-- Define evenerything that is undefined,
-- without using standard Haskell functions.
-- (Hint: recursion is your friend!)

data Nat = Zero | Succ Nat

instance Show Nat where

    show Zero     = "0"
    show (Succ n) = "S" ++ show n

instance Eq Nat where

    Zero   == Zero    = True
    Zero   == Succ _  = False
    Succ _ == Zero    = False
    Succ m == Succ n  = m == n

instance Ord Nat where

    (<=) Zero _            = True
    (<=) _ Zero            = False
    (<=) (Succ x) (Succ y) = (<=) x y

    -- Ord does not require defining min and max.
    -- Howevener, you should define them without using (<=).
    -- Both are binary functions: max m n = ..., etc.

    min Zero x            = Zero
    min x Zero            = Zero
    min (Succ x) (Succ y) = Succ(min x y)

    max Zero x = x
    max x Zero = x
    max (Succ x) (Succ y) = Succ(max x y)

isZero :: Nat -> Bool
isZero Zero = True
isZero _    = False

pred :: Nat -> Nat
pred Zero     = Zero
pred (Succ x) = x

even :: Nat -> Bool
even Zero            = True
even (Succ Zero)     = False
even (Succ (Succ x)) = even x

odd :: Nat -> Bool
odd = not . even    -- point free or "pointless"

-- addition
(<+>) :: Nat -> Nat -> Nat
(<+>) Zero x = x
(<+>) (Succ x) y = x <+> Succ(y)

-- This is called the dotminus or monus operator
-- (also: proper subtraction, arithmetic subtraction, ...).
-- It behaves like subtraction, except that it returns 0
-- when subtraction returns a negative number.
(<->) :: Nat -> Nat -> Nat
(<->) Zero x = Zero
(<->) x Zero = x
(<->) (Succ x) (Succ y) = x <-> y

-- multiplication
(<*>) :: Nat -> Nat -> Nat
(<*>) Zero x         = Zero
(<*>) x Zero         = Zero
(<*>) (Succ(Zero)) x = x
(<*>) (Succ x) y     = y + (x <*> y) 

-- exponentiation
(<^>) :: Nat -> Nat -> Nat
(<^>) Zero x         = Zero
(<^>) x Zero         = Succ(Zero)
(<^>) x (Succ y)     = x <*> (x <^> y)

-- quotient
(</>) :: Nat -> Nat -> Nat
(</>) x Zero = undefined
(</>) Zero x = Zero
(</>) x y 
    | y <= x    = Succ(Zero) <+> ((x <-> y) </> y)
    | otherwise = error "Division by Zero is not defined."

-- remainder
(<%>) :: Nat -> Nat -> Nat
(<%>) x Zero = error "Division by Zero is not defined."
(<%>) Zero x = Zero
(<%>) x y 
    | y <= x    = (x <-> y) <%> y
    | otherwise = x 

-- divides
(<|>) :: Nat -> Nat -> Bool
(<|>) x y = (y <%> x) == Zero

divides = (<|>)

-- x `absDiff` y = |x - y|
-- (Careful: here this - is the real minus operator!)
absDiff :: Nat -> Nat -> Nat
absDiff x y 
    | x <= y    = y <-> x
    | otherwise = x <-> y

(|-|) = absDiff

factorial :: Nat -> Nat
factorial Zero     = Succ(Zero)
factorial (Succ x) = Succ x <*> factorial x  

(<!>) = factorial

-- signum of a number (-1, 0, or 1)
sg :: Nat -> Nat
sg Zero = Zero
sg _    = Succ(Zero)

-- lo b a is the floor of the logarithm base b of a
lo :: Nat -> Nat -> Nat
lo Zero _       = undefined
lo _ (Succ Zero) = Zero
lo x y
    | x <= y    = (Succ Zero) <+> lo x (y </> x) 
    | otherwise = Zero 

--
-- For the following functions we need Num(..).
-- Do NOT use the following functions in the definitions above!
--

toNat :: Integral a => a -> Nat
toNat x 
    | x == 0 = Zero
    | x > 0  = Succ(Zero) <+> toNat (x - 1)
    | otherwise = error "Not defined for negative numbers."

fromNat :: Integral a => Nat -> a
fromNat Zero = 0
fromNat (Succ x) = 1 + fromNat x


-- Obs: we can now easily make Nat an instance of Num.
instance Num Nat where

    (+) = (<+>)
    (*) = (<*>)
    (-) = (<->)
    abs n = n
    signum = sg
    fromInteger x
        | x < 0     = undefined
        | x == 0    = Zero
        | otherwise = toNat x

