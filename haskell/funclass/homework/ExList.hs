module ExList where

import Prelude
    ( Char , String , Int , Integer , Double , Float , Bool(..)
    , Num(..) , Integral(..) , Enum(..) , Ord(..) , Eq(..)
    , not , (&&) , (||)
    , (.) , ($)
    , flip , curry , uncurry
    , otherwise , error , undefined
    )
import qualified Prelude   as P
import qualified Data.List as L
import qualified Data.Char as C


head :: [a] -> a
head []    = error "head of empty list"
head (x:_) = x

tail :: [a] -> [a]
tail []     = error "tail of empty list"
tail (_:xs) = xs

null :: [a] -> Bool
null [] = True
null _  = False

length :: Integral i => [a] -> i
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
reverse (x:xs) = reverse xs ++ [x]

(++) :: [a] -> [a] -> [a]
[]     ++ ys = ys
(x:xs) ++ ys = x : (xs ++ ys)
infixr 5 ++         -- mais eficiente do que à infixl!

-- (snoc is cons written backwards)
snoc :: a -> [a] -> [a]
snoc w []     = [w]
snoc w (x:xs) = x : snoc w xs

(<:) :: [a] -> a -> [a]
(<:) = flip snoc

-- different implementation of (++)
(+++) :: [a] -> [a] -> [a]
xs +++ []     = xs
xs +++ [y]    = xs <: y
xs +++ (y:ys) = (xs +++ [y]) +++ ys

minimum :: Ord a => [a] -> a
minimum []  = error "minimum of empty list"
minimum [x] = x
minimum (x:xs)
  | x < m     = x
  | otherwise = m
  where m = minimum xs

maximum :: Ord a => [a] -> a
maximum []  = error "maximum of empty list"
maximum [x] = x
maximum (x:xs) =
    let m = maximum xs
     in if x > m then x else m

take :: Integral i => i -> [a] -> [a]
take _  []    = []
take 0  _     = []
take n (x:xs) = x : take (n - 1) xs

-- drop
drop :: Integral i => i -> [a] -> [a]
drop _ [] = []
drop n xs
    | n <= 0    = xs
    | otherwise = drop (n - 1) $ tail xs

-- takeWhile
takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile f [] = []
takeWhile f (x:xs)
    | f x == False  = []
    | otherwise     = x : takeWhile f xs 

-- dropWhile
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile f [] = []
dropWhile f (x:xs)
    | f x == False  = (x:xs)
    | otherwise     = dropWhile f xs

-- tails
tails :: [a] -> [[a]]
tails []        = [[]]
tails (x:xs)    = (x : y) : ys'
    where ys'@(y:ys) = tails xs

prop_tails xs = (L.tails xs) == (tails xs)

-- init
init :: [a] -> [a]
init [] = error "empty list"
init (x:[]) = []
init (x:xs) = x : init xs

-- inits
inits :: [a] -> [[a]]
inits [] = [[]]
inits (x:xs) = [] : map (x:) (inits xs)

prop_init xs = (L.inits xs) == (inits xs)

-- subsequences

subsequences' :: [a] -> [[a]]
subsequences' [] = [[]]
subsequences' (x:xs) = f x (subsequences' xs)
    where   f x [] = []
            f x (ys:yss) = ys : (x : ys) : (f x yss)

-- any
any :: (a -> Bool) -> [a] -> Bool
any _ []            = False
any f (x:xs) 
    | f x           = True
    | otherwise     = any f xs

-- all
all :: (a -> Bool) -> [a] -> Bool
all p = not . any (not . p)

all' :: (a -> Bool) -> [a] -> Bool
all' f []            = True
all' f (x:xs)        
    | f x == False  = False
    | otherwise     = all f xs

-- and
and :: [Bool] -> Bool
and = all (== True)

-- or
or :: [Bool] -> Bool
or = any (== True)

-- concat
concat :: [[a]] -> [a]
concat [] = []
concat (xs:xss) = xs ++ (concat xss) 

-- elem
elem :: Eq a => a -> [a] -> Bool
elem k = any (== k)

-- (!!)
(!!) :: [a] -> Int -> a
(!!) [] _ = error "out of range"
(!!) (x:_) 0 = x
(!!) (_:xs) i = (!!) xs (i-1)

-- filter
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter f (x:xs)
    | f x       = x : filter f xs
    | otherwise = filter f xs

-- map
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs

-- cycle
cycle :: [a] -> [a]
cycle [] = error "empty list"
cycle xs = xs ++ cycle xs

-- repeat
repeat :: a -> [a]
repeat x = x : repeat x

-- replicate
replicate :: Int -> a -> [a]
replicate 0 x = []
replicate i x = take i (repeat x)

-- isPrefixOf
isPrefixOf :: Eq a => [a] -> [a] -> Bool
isPrefixOf [] _ = True
isPrefixOf (_:xs) [] = False
isPrefixOf (x:xs) (y:ys) 
    | x == y    = isPrefixOf xs ys
    | otherwise = False

-- isInfixOf
isInfixOf :: Eq a => [a] -> [a] -> Bool
isInfixOf xs (y:ys) 
    | isPrefixOf xs (y:ys)  = True
    | otherwise             = isInfixOf xs ys

-- isSuffixOf
isSuffixOf :: Eq a => [a] -> [a] -> Bool
isSuffixOf xs ys = isPrefixOf (reverse xs) (reverse ys)

-- zip
zip :: [a] -> [a] -> [(a,a)]
zip [] _ = []
zip _ [] = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

-- zipWith
zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : zipWith f xs ys

-- intercalate
intercalate :: [a] -> [[a]] -> [a]
intercalate _ [] = []
intercalate xs (ys:yss) = ys ++ xs ++ intercalate xs yss

-- nub
nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) 
    | x `elem` nub xs   = nub xs
    | otherwise         = x : nub xs

-- splitAt
splitAt :: Integral i => i -> [a] -> ([a],[a])
splitAt 0 xs = ([], xs)
splitAt _ [] = ([],[])
splitAt i (x:xs) = (x:ys, zs)
    where (ys, zs) = splitAt (i-1) xs

-- break
break :: (a -> Bool) -> [a] -> ([a],[a])
break _ [] = ([],[])
break f (x:xs) 
    | not $ f x     = (x : ys, zs)
    | otherwise = ([],x:xs)
        where (ys, zs) = break f xs

-- split
split :: Eq a => (a -> Bool) -> [a] -> [[a]]
split p [] = []
split p [x] = if p x then [[]] else [[x]]
split p (x:xs)
    | p x = [] : yss'
    | otherwise = (x : ys) : yss
    where yss'@(ys:yss) = split p xs

-- lines
lines :: String -> [String]
lines = split (=='\n')

-- words
words :: String -> [String]
words = split (==' ')

-- unlines
unlines :: [String] -> String
unlines = (snoc '\n') . intercalate "\n"

-- unwords
unwords :: [String] -> String
unwords = intercalate " "

transpose'' :: [[a]] -> [[a]]
transpose'' [] = []
transpose'' ([] : xss) = transpose'' xss
transpose'' xss = [x | (x:_) <- xss] : transpose'' [xs | (_:xs) <- xss]

-- transpose
transpose :: Eq a => [[a]] -> [[a]]
transpose [] = []
transpose [[]] = []
transpose xss 
    | ys /= [] = ys : transpose yss
    | otherwise = transpose yss
    where (ys, yss) =  transpose' xss


transpose' :: [[a]] -> ([a],[[a]])
transpose' [] = ([],[])
transpose' ([]:xss) = (zs, zss)
    where (zs,zss) = transpose' xss
transpose' ((x:xs):xss) = (x:zs, xs:zss)
    where (zs,zss) = transpose' xss

prop_transpose :: Eq a => [[a]] -> Bool
prop_transpose xss = (transpose xss) == (L.transpose xss)


-- checks if the letters of a phrase form a palindrome (see below for examples)

palindrome' :: String -> Bool
palindrome' []       = True
palindrome' [x]      = True
palindrome' (x:y:[]) = x == y
palindrome' (x:xs)   = (x == head (reverse xs)) && (palindrome (init xs))

palindrome'' :: String -> Bool
palindrome'' xs = (xs == reverse xs)

clear :: String -> String
clear [] = []
clear (x:xs) 
    | C.isAlphaNum x = C.toLower x : clear xs
    | otherwise = clear xs

palindrome :: String -> Bool
palindrome = palindrome' . clear
{-

Examples of palindromes:

"Madam, I'm Adam"
"Step on no pets."
"Mr. Owl ate my metal worm."
"Was it a car or a cat I saw?"
"Doc, note I dissent.  A fast never prevents a fatness.  I diet on cod."

-}

insertAt :: Integral i => a -> i -> [a] -> [a]
insertAt y 0 xs = y : xs 
insertAt y i [] = [y] 
insertAt y i (x:xs) = x : (insertAt y (i-1) xs)

inserts :: a -> [a] -> [[a]]
inserts y xs = [insertAt y i xs | i <- [0..n]] 
        where n = length xs

permutations :: [a] -> [[a]]
permutations [] = []
permutations [x] = [[x]]
permutations (x:xs) = concat $ map (interleave x []) yss
    where yss = permutations xs

interleave :: a -> [a] -> [a] -> [[a]]
interleave x zs [] = [(snoc x zs)] 
interleave x zs (y:ys) = ((snoc x zs) ++ (y : ys)) : interleave x (snoc y zs) ys

--permutations' :: [a] -> [[a]]
--permutations' []  = []
--permutations' [x] = [[x]]
--permutations' (x:xs) = concat (map (insert x) (permutations' xs))
