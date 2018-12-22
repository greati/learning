module Folds where

import Prelude hiding ((++),map,unzip,last,init,map', inits)

snoc :: [a] -> a -> [a]
snoc [] x = [x]
snoc (x:xs) k = x : snoc xs k

(++) xs ys = foldr (:) ys xs
(+++) xs ys = foldl (snoc) xs ys

map :: (a -> b) -> [a] -> [b]
map f = foldr ((:).f) []

map' :: (a -> b) -> [a] -> [b]
map' f = foldl (flip $ (flip snoc).f) []

sumlength :: Num a => [a] -> (a,a)
sumlength = foldr (\x (s,l) -> (s + x, l + 1)) (0,0)

sumlength' :: Num a => [a] -> (a,a)
sumlength' = foldl (\(s,l) x -> (s + x, l + 1)) (0,0)

compose :: [a -> a] -> (a -> a)
compose = foldr (.) id

compose' :: [a -> a] -> (a -> a)
compose' = foldl (.) id

isort :: Ord a => [a] -> [a] 
isort = foldr insert []
    where   insert k [] = [k]
            insert k (x:xs) = if k <= x then (k:x:xs) else x:insert k xs

unzip :: [(a,b)] -> ([a],[b])
unzip = foldr f ([],[])
    where f (x,y) (xs,ys) = (x:xs, y:ys)

semo :: Integral i => [i] -> (i, Maybe i)
semo = foldr f (0, Nothing)
    where f x (e,o) = (e + de, o')
            where
                  de = if even x then x else 0
                  o' = if odd x then 
                        case o of
                            Nothing -> Just x
                            Just x' -> Just $ max x x'
                        else o

safeLast :: [a] -> Maybe a
safeLast [] = Nothing
safeLast xs = foldl (\r x -> Just x) (Just $ head xs) xs

safeMaximum :: Ord a => [a] -> Maybe a
safeMaximum [] = Nothing
safeMaximum xs = foldr f Nothing xs
    where f x r = case r of 
                    Nothing -> (Just x)
                    Just x' -> (Just $ max x x')

init :: [a] -> [a]
init xs = foldl f [] xs
    where 
        f :: [a] -> a -> [a]
        f xs' k = if length xs' + 1 == length xs then xs' else xs' ++ [k]
 

tail :: [a] -> [a]
tail xs = foldr f [] xs
    where 
        f :: a -> [a] -> [a]
        f k xs' = if length xs' + 1 == length xs then xs' else k:xs'
                    
inits :: [a] -> [[a]]
inits xs = foldr f [[]] xs
    where f x xs = [] : map (x:) xs
