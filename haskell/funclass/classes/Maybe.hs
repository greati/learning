
import Prelude hiding (reverse, length)

{-
 - (a -> b -> a) -> a -> [a] -> a
 -
 - -}


foldr' :: (a->b->b) -> b -> [a] -> b
foldr' f v []       = v
foldr' f v (x:xs)   = x `f` (foldr' f v xs)


snoc :: a -> [a] -> [a]
snoc x ws = ws ++ [x]


sum ls = foldr (+) 0 ls
prod ls = foldr (*) 1 ls
or ls = foldr (||) False ls
and ls = foldr (&&) True ls
concat ls = foldr (++) [] ls
reverse ls = foldr (snoc) [] ls
length ls = foldr (\x y -> y + 1) 0 ls
