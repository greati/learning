module Trees where

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show, Eq)

t = Node (Node (Leaf 4) 2 (Leaf 5)) 1 (Leaf 8)

flatten :: Tree a -> [a]
flatten (Leaf x) = [x]
flatten (Node t1 x t2) = flatten t1 ++ [x] ++ flatten t2

tmap :: (a -> b) -> Tree a -> Tree b
tmap f (Leaf x) = Leaf (f x)
tmap f (Node t1 x t2) = Node (tmap f t1) (f x) (tmap f t2)
