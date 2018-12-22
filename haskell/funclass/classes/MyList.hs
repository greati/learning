module MyList where

import Prelude
    ( Char , String , Int , Integer , Double , Float , Bool(..)
    , Num(..) , Integral(..) , Enum(..) , Ord(..) , Eq(..)
    , error , undefined
    )
import qualified Prelude as P
import qualified Data.List as L
import Data.Char

{-
data List a = Empty | Cons a (List a)
    deriving ( Show , Eq )

data [] a = [] | (:) a ([] a)

data [a]  = [] | a : [a]
-}

head :: [a] -> a
head []    = error "head of empty list"
head (x:_) = x

tail :: [a] -> [a]
tail []     = error "tail of empty list"
tail (_:xs) = xs

null :: [a] -> Bool
null [] = True
null _  = False

length :: Integral b => [a] -> b
length []     = 0
length (_:xs) = 1 + length xs

sum :: Num a => [a] -> a
sum []     = 0
sum (x:xs) = x + sum xs

product :: Num a => [a] -> a
product []     = 1
product (x:xs) = x * product xs

reverse :: [a] -> [a]
reverse []     = []
reverse (x:xs) = reverse xs P.++ [x]


-- (++)
(++) :: [a] -> [a] -> [a]
(++) [] ys      = ys
(++) (x:xs) ys  = x : (xs ++ ys)

append :: a -> [a] -> [a]
append w [] = [w]
append w (x:xs) = x : append w xs

-- inits
inits :: [a] -> [[a]]
inits xs = take (length xs) ++ inits

--[1,2,3]
--[ [], [1], [1,2], [1,2,3] ]

[1,2] ++ inits [1,2] 
[1,2] ++ [1] ++ []


-- tails

-- any
-- all
-- and
-- or
-- minimum
-- maximum
-- concat

-- sort

-- (!!)
-- filter
-- map
-- cycle
-- repeat
-- replicate

-- isPrefixOf
-- isInfixOf
-- isSuffixOf

-- splitAt

-- zip
-- zipWith
-- lines
-- words
-- unlines
-- unwords
-- iterate

-- safeHead
-- safeTail

-- -- }}}

